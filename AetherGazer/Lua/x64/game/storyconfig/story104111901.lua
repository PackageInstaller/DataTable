return {
	Play411191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411191001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I07"

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
				local var_4_5 = arg_1_1.bgs_.I07

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
					if iter_4_0 ~= "I07" then
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
			local var_4_23 = 0.3

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

			local var_4_28 = 0.433333333333333
			local var_4_29 = 0.3

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock")

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
			local var_4_35 = 1

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

				local var_4_37 = arg_1_1:GetWordFromCfg(411191001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 40
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
	Play411191002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411191002
		arg_9_1.duration_ = 2.17

		local var_9_0 = {
			zh = 2.166,
			ja = 2.1
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
				arg_9_0:Play411191003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "4010ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["4010ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos4010ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -1.59, -5.2)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos4010ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["4010ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect4010ui_story == nil then
				arg_9_1.var_.characterEffect4010ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect4010ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect4010ui_story then
				arg_9_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.15

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[42].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(411191002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191002", "story_v_out_411191.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_411191", "411191002", "story_v_out_411191.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_411191", "411191002", "story_v_out_411191.awb")

						arg_9_1:RecordAudio("411191002", var_12_29)
						arg_9_1:RecordAudio("411191002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_411191", "411191002", "story_v_out_411191.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_411191", "411191002", "story_v_out_411191.awb")
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
				actorName = "4010ui_story",
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
	Play411191003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411191003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play411191004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["4010ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos4010ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos4010ui_story, var_16_4, var_16_3)

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

			local var_16_9 = arg_13_1.actors_["4010ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect4010ui_story == nil then
				arg_13_1.var_.characterEffect4010ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect4010ui_story and not isNil(var_16_9) then
					local var_16_13 = Mathf.Lerp(0, 0.5, var_16_12)

					arg_13_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_13_1.var_.characterEffect4010ui_story.fillRatio = var_16_13
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect4010ui_story then
				local var_16_14 = 0.5

				arg_13_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_13_1.var_.characterEffect4010ui_story.fillRatio = var_16_14
			end

			local var_16_15 = 0
			local var_16_16 = 0.525

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

				local var_16_17 = arg_13_1:GetWordFromCfg(411191003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 21
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
				actorName = "4010ui_story",
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
	Play411191004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411191004
		arg_17_1.duration_ = 8.4

		local var_17_0 = {
			zh = 5.133,
			ja = 8.4
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
				arg_17_0:Play411191005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.775

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[718].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(411191004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 31
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191004", "story_v_out_411191.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_411191", "411191004", "story_v_out_411191.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_411191", "411191004", "story_v_out_411191.awb")

						arg_17_1:RecordAudio("411191004", var_20_9)
						arg_17_1:RecordAudio("411191004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_411191", "411191004", "story_v_out_411191.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_411191", "411191004", "story_v_out_411191.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play411191005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411191005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play411191006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.475

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(411191005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 60
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play411191006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411191006
		arg_25_1.duration_ = 2.97

		local var_25_0 = {
			zh = 2.333,
			ja = 2.966
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
				arg_25_0:Play411191007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.275

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[718].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(411191006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 11
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191006", "story_v_out_411191.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_411191", "411191006", "story_v_out_411191.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_411191", "411191006", "story_v_out_411191.awb")

						arg_25_1:RecordAudio("411191006", var_28_9)
						arg_25_1:RecordAudio("411191006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_411191", "411191006", "story_v_out_411191.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_411191", "411191006", "story_v_out_411191.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play411191007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411191007
		arg_29_1.duration_ = 3.37

		local var_29_0 = {
			zh = 0.999999999999,
			ja = 3.366
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play411191008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["4010ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos4010ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, -1.59, -5.2)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos4010ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["4010ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect4010ui_story == nil then
				arg_29_1.var_.characterEffect4010ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect4010ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect4010ui_story then
				arg_29_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_32_13 = 0
			local var_32_14 = 0.075

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_15 = arg_29_1:FormatText(StoryNameCfg[42].name)

				arg_29_1.leftNameTxt_.text = var_32_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_16 = arg_29_1:GetWordFromCfg(411191007)
				local var_32_17 = arg_29_1:FormatText(var_32_16.content)

				arg_29_1.text_.text = var_32_17

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_18 = 3
				local var_32_19 = utf8.len(var_32_17)
				local var_32_20 = var_32_18 <= 0 and var_32_14 or var_32_14 * (var_32_19 / var_32_18)

				if var_32_20 > 0 and var_32_14 < var_32_20 then
					arg_29_1.talkMaxDuration = var_32_20

					if var_32_20 + var_32_13 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_13
					end
				end

				arg_29_1.text_.text = var_32_17
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191007", "story_v_out_411191.awb") ~= 0 then
					local var_32_21 = manager.audio:GetVoiceLength("story_v_out_411191", "411191007", "story_v_out_411191.awb") / 1000

					if var_32_21 + var_32_13 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_21 + var_32_13
					end

					if var_32_16.prefab_name ~= "" and arg_29_1.actors_[var_32_16.prefab_name] ~= nil then
						local var_32_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_16.prefab_name].transform, "story_v_out_411191", "411191007", "story_v_out_411191.awb")

						arg_29_1:RecordAudio("411191007", var_32_22)
						arg_29_1:RecordAudio("411191007", var_32_22)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_411191", "411191007", "story_v_out_411191.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_411191", "411191007", "story_v_out_411191.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_23 = math.max(var_32_14, arg_29_1.talkMaxDuration)

			if var_32_13 <= arg_29_1.time_ and arg_29_1.time_ < var_32_13 + var_32_23 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_13) / var_32_23

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_13 + var_32_23 and arg_29_1.time_ < var_32_13 + var_32_23 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play411191008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411191008
		arg_33_1.duration_ = 1.07

		local var_33_0 = {
			zh = 1.066,
			ja = 0.999999999999
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
				arg_33_0:Play411191009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["4010ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect4010ui_story == nil then
				arg_33_1.var_.characterEffect4010ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect4010ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_33_1.var_.characterEffect4010ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect4010ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_33_1.var_.characterEffect4010ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.05

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[718].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(411191008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 2
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191008", "story_v_out_411191.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_411191", "411191008", "story_v_out_411191.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_411191", "411191008", "story_v_out_411191.awb")

						arg_33_1:RecordAudio("411191008", var_36_15)
						arg_33_1:RecordAudio("411191008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_411191", "411191008", "story_v_out_411191.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_411191", "411191008", "story_v_out_411191.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play411191009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411191009
		arg_37_1.duration_ = 5.47

		local var_37_0 = {
			zh = 4.533,
			ja = 5.466
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
				arg_37_0:Play411191010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["4010ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos4010ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -1.59, -5.2)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos4010ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["4010ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect4010ui_story == nil then
				arg_37_1.var_.characterEffect4010ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect4010ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect4010ui_story then
				arg_37_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_40_13 = 0
			local var_40_14 = 0.475

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_15 = arg_37_1:FormatText(StoryNameCfg[42].name)

				arg_37_1.leftNameTxt_.text = var_40_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_16 = arg_37_1:GetWordFromCfg(411191009)
				local var_40_17 = arg_37_1:FormatText(var_40_16.content)

				arg_37_1.text_.text = var_40_17

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_18 = 19
				local var_40_19 = utf8.len(var_40_17)
				local var_40_20 = var_40_18 <= 0 and var_40_14 or var_40_14 * (var_40_19 / var_40_18)

				if var_40_20 > 0 and var_40_14 < var_40_20 then
					arg_37_1.talkMaxDuration = var_40_20

					if var_40_20 + var_40_13 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_13
					end
				end

				arg_37_1.text_.text = var_40_17
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191009", "story_v_out_411191.awb") ~= 0 then
					local var_40_21 = manager.audio:GetVoiceLength("story_v_out_411191", "411191009", "story_v_out_411191.awb") / 1000

					if var_40_21 + var_40_13 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_21 + var_40_13
					end

					if var_40_16.prefab_name ~= "" and arg_37_1.actors_[var_40_16.prefab_name] ~= nil then
						local var_40_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_16.prefab_name].transform, "story_v_out_411191", "411191009", "story_v_out_411191.awb")

						arg_37_1:RecordAudio("411191009", var_40_22)
						arg_37_1:RecordAudio("411191009", var_40_22)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_411191", "411191009", "story_v_out_411191.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_411191", "411191009", "story_v_out_411191.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_23 = math.max(var_40_14, arg_37_1.talkMaxDuration)

			if var_40_13 <= arg_37_1.time_ and arg_37_1.time_ < var_40_13 + var_40_23 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_13) / var_40_23

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_13 + var_40_23 and arg_37_1.time_ < var_40_13 + var_40_23 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play411191010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411191010
		arg_41_1.duration_ = 6.67

		local var_41_0 = {
			zh = 6.666,
			ja = 2.9
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play411191011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = "1095ui_story"

			if arg_41_1.actors_[var_44_0] == nil then
				local var_44_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_44_1) then
					local var_44_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_41_1.stage_.transform)

					var_44_2.name = var_44_0
					var_44_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_41_1.actors_[var_44_0] = var_44_2

					local var_44_3 = var_44_2:GetComponentInChildren(typeof(CharacterEffect))

					var_44_3.enabled = true

					local var_44_4 = GameObjectTools.GetOrAddComponent(var_44_2, typeof(DynamicBoneHelper))

					if var_44_4 then
						var_44_4:EnableDynamicBone(false)
					end

					arg_41_1:ShowWeapon(var_44_3.transform, false)

					arg_41_1.var_[var_44_0 .. "Animator"] = var_44_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_41_1.var_[var_44_0 .. "Animator"].applyRootMotion = true
					arg_41_1.var_[var_44_0 .. "LipSync"] = var_44_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_44_5 = arg_41_1.actors_["1095ui_story"].transform
			local var_44_6 = 0

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.var_.moveOldPos1095ui_story = var_44_5.localPosition
			end

			local var_44_7 = 0.001

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_7 then
				local var_44_8 = (arg_41_1.time_ - var_44_6) / var_44_7
				local var_44_9 = Vector3.New(0, -0.98, -6.1)

				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1095ui_story, var_44_9, var_44_8)

				local var_44_10 = manager.ui.mainCamera.transform.position - var_44_5.position

				var_44_5.forward = Vector3.New(var_44_10.x, var_44_10.y, var_44_10.z)

				local var_44_11 = var_44_5.localEulerAngles

				var_44_11.z = 0
				var_44_11.x = 0
				var_44_5.localEulerAngles = var_44_11
			end

			if arg_41_1.time_ >= var_44_6 + var_44_7 and arg_41_1.time_ < var_44_6 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_44_12 = manager.ui.mainCamera.transform.position - var_44_5.position

				var_44_5.forward = Vector3.New(var_44_12.x, var_44_12.y, var_44_12.z)

				local var_44_13 = var_44_5.localEulerAngles

				var_44_13.z = 0
				var_44_13.x = 0
				var_44_5.localEulerAngles = var_44_13
			end

			local var_44_14 = arg_41_1.actors_["1095ui_story"]
			local var_44_15 = 0

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 and not isNil(var_44_14) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = var_44_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_16 = 0.200000002980232

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_16 and not isNil(var_44_14) then
				local var_44_17 = (arg_41_1.time_ - var_44_15) / var_44_16

				if arg_41_1.var_.characterEffect1095ui_story and not isNil(var_44_14) then
					arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_15 + var_44_16 and arg_41_1.time_ < var_44_15 + var_44_16 + arg_44_0 and not isNil(var_44_14) and arg_41_1.var_.characterEffect1095ui_story then
				arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_44_18 = 0

			if var_44_18 < arg_41_1.time_ and arg_41_1.time_ <= var_44_18 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_44_19 = 0

			if var_44_19 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_20 = arg_41_1.actors_["4010ui_story"].transform
			local var_44_21 = 0

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1.var_.moveOldPos4010ui_story = var_44_20.localPosition
			end

			local var_44_22 = 0.001

			if var_44_21 <= arg_41_1.time_ and arg_41_1.time_ < var_44_21 + var_44_22 then
				local var_44_23 = (arg_41_1.time_ - var_44_21) / var_44_22
				local var_44_24 = Vector3.New(0, 100, 0)

				var_44_20.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos4010ui_story, var_44_24, var_44_23)

				local var_44_25 = manager.ui.mainCamera.transform.position - var_44_20.position

				var_44_20.forward = Vector3.New(var_44_25.x, var_44_25.y, var_44_25.z)

				local var_44_26 = var_44_20.localEulerAngles

				var_44_26.z = 0
				var_44_26.x = 0
				var_44_20.localEulerAngles = var_44_26
			end

			if arg_41_1.time_ >= var_44_21 + var_44_22 and arg_41_1.time_ < var_44_21 + var_44_22 + arg_44_0 then
				var_44_20.localPosition = Vector3.New(0, 100, 0)

				local var_44_27 = manager.ui.mainCamera.transform.position - var_44_20.position

				var_44_20.forward = Vector3.New(var_44_27.x, var_44_27.y, var_44_27.z)

				local var_44_28 = var_44_20.localEulerAngles

				var_44_28.z = 0
				var_44_28.x = 0
				var_44_20.localEulerAngles = var_44_28
			end

			local var_44_29 = arg_41_1.actors_["4010ui_story"]
			local var_44_30 = 0

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 and not isNil(var_44_29) and arg_41_1.var_.characterEffect4010ui_story == nil then
				arg_41_1.var_.characterEffect4010ui_story = var_44_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_31 = 0.200000002980232

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_31 and not isNil(var_44_29) then
				local var_44_32 = (arg_41_1.time_ - var_44_30) / var_44_31

				if arg_41_1.var_.characterEffect4010ui_story and not isNil(var_44_29) then
					local var_44_33 = Mathf.Lerp(0, 0.5, var_44_32)

					arg_41_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_41_1.var_.characterEffect4010ui_story.fillRatio = var_44_33
				end
			end

			if arg_41_1.time_ >= var_44_30 + var_44_31 and arg_41_1.time_ < var_44_30 + var_44_31 + arg_44_0 and not isNil(var_44_29) and arg_41_1.var_.characterEffect4010ui_story then
				local var_44_34 = 0.5

				arg_41_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_41_1.var_.characterEffect4010ui_story.fillRatio = var_44_34
			end

			local var_44_35 = 0
			local var_44_36 = 0.875

			if var_44_35 < arg_41_1.time_ and arg_41_1.time_ <= var_44_35 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_37 = arg_41_1:FormatText(StoryNameCfg[471].name)

				arg_41_1.leftNameTxt_.text = var_44_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_38 = arg_41_1:GetWordFromCfg(411191010)
				local var_44_39 = arg_41_1:FormatText(var_44_38.content)

				arg_41_1.text_.text = var_44_39

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_40 = 35
				local var_44_41 = utf8.len(var_44_39)
				local var_44_42 = var_44_40 <= 0 and var_44_36 or var_44_36 * (var_44_41 / var_44_40)

				if var_44_42 > 0 and var_44_36 < var_44_42 then
					arg_41_1.talkMaxDuration = var_44_42

					if var_44_42 + var_44_35 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_42 + var_44_35
					end
				end

				arg_41_1.text_.text = var_44_39
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191010", "story_v_out_411191.awb") ~= 0 then
					local var_44_43 = manager.audio:GetVoiceLength("story_v_out_411191", "411191010", "story_v_out_411191.awb") / 1000

					if var_44_43 + var_44_35 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_43 + var_44_35
					end

					if var_44_38.prefab_name ~= "" and arg_41_1.actors_[var_44_38.prefab_name] ~= nil then
						local var_44_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_38.prefab_name].transform, "story_v_out_411191", "411191010", "story_v_out_411191.awb")

						arg_41_1:RecordAudio("411191010", var_44_44)
						arg_41_1:RecordAudio("411191010", var_44_44)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_411191", "411191010", "story_v_out_411191.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_411191", "411191010", "story_v_out_411191.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_45 = math.max(var_44_36, arg_41_1.talkMaxDuration)

			if var_44_35 <= arg_41_1.time_ and arg_41_1.time_ < var_44_35 + var_44_45 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_35) / var_44_45

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_35 + var_44_45 and arg_41_1.time_ < var_44_35 + var_44_45 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play411191011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 411191011
		arg_45_1.duration_ = 3.53

		local var_45_0 = {
			zh = 3.533,
			ja = 2.633
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
				arg_45_0:Play411191012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.45

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[471].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(411191011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 18
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191011", "story_v_out_411191.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_411191", "411191011", "story_v_out_411191.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_411191", "411191011", "story_v_out_411191.awb")

						arg_45_1:RecordAudio("411191011", var_48_9)
						arg_45_1:RecordAudio("411191011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_411191", "411191011", "story_v_out_411191.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_411191", "411191011", "story_v_out_411191.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play411191012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 411191012
		arg_49_1.duration_ = 5

		local var_49_0 = {
			zh = 2.733,
			ja = 5
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
				arg_49_0:Play411191013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["4010ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos4010ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, -1.59, -5.2)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos4010ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["4010ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect4010ui_story == nil then
				arg_49_1.var_.characterEffect4010ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect4010ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect4010ui_story then
				arg_49_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_15 = arg_49_1.actors_["1095ui_story"].transform
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.var_.moveOldPos1095ui_story = var_52_15.localPosition
			end

			local var_52_17 = 0.001

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17
				local var_52_19 = Vector3.New(0, 100, 0)

				var_52_15.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1095ui_story, var_52_19, var_52_18)

				local var_52_20 = manager.ui.mainCamera.transform.position - var_52_15.position

				var_52_15.forward = Vector3.New(var_52_20.x, var_52_20.y, var_52_20.z)

				local var_52_21 = var_52_15.localEulerAngles

				var_52_21.z = 0
				var_52_21.x = 0
				var_52_15.localEulerAngles = var_52_21
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 then
				var_52_15.localPosition = Vector3.New(0, 100, 0)

				local var_52_22 = manager.ui.mainCamera.transform.position - var_52_15.position

				var_52_15.forward = Vector3.New(var_52_22.x, var_52_22.y, var_52_22.z)

				local var_52_23 = var_52_15.localEulerAngles

				var_52_23.z = 0
				var_52_23.x = 0
				var_52_15.localEulerAngles = var_52_23
			end

			local var_52_24 = arg_49_1.actors_["1095ui_story"]
			local var_52_25 = 0

			if var_52_25 < arg_49_1.time_ and arg_49_1.time_ <= var_52_25 + arg_52_0 and not isNil(var_52_24) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = var_52_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_26 = 0.200000002980232

			if var_52_25 <= arg_49_1.time_ and arg_49_1.time_ < var_52_25 + var_52_26 and not isNil(var_52_24) then
				local var_52_27 = (arg_49_1.time_ - var_52_25) / var_52_26

				if arg_49_1.var_.characterEffect1095ui_story and not isNil(var_52_24) then
					local var_52_28 = Mathf.Lerp(0, 0.5, var_52_27)

					arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1095ui_story.fillRatio = var_52_28
				end
			end

			if arg_49_1.time_ >= var_52_25 + var_52_26 and arg_49_1.time_ < var_52_25 + var_52_26 + arg_52_0 and not isNil(var_52_24) and arg_49_1.var_.characterEffect1095ui_story then
				local var_52_29 = 0.5

				arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1095ui_story.fillRatio = var_52_29
			end

			local var_52_30 = 0
			local var_52_31 = 0.275

			if var_52_30 < arg_49_1.time_ and arg_49_1.time_ <= var_52_30 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_32 = arg_49_1:FormatText(StoryNameCfg[42].name)

				arg_49_1.leftNameTxt_.text = var_52_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_33 = arg_49_1:GetWordFromCfg(411191012)
				local var_52_34 = arg_49_1:FormatText(var_52_33.content)

				arg_49_1.text_.text = var_52_34

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_35 = 11
				local var_52_36 = utf8.len(var_52_34)
				local var_52_37 = var_52_35 <= 0 and var_52_31 or var_52_31 * (var_52_36 / var_52_35)

				if var_52_37 > 0 and var_52_31 < var_52_37 then
					arg_49_1.talkMaxDuration = var_52_37

					if var_52_37 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_37 + var_52_30
					end
				end

				arg_49_1.text_.text = var_52_34
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191012", "story_v_out_411191.awb") ~= 0 then
					local var_52_38 = manager.audio:GetVoiceLength("story_v_out_411191", "411191012", "story_v_out_411191.awb") / 1000

					if var_52_38 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_38 + var_52_30
					end

					if var_52_33.prefab_name ~= "" and arg_49_1.actors_[var_52_33.prefab_name] ~= nil then
						local var_52_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_33.prefab_name].transform, "story_v_out_411191", "411191012", "story_v_out_411191.awb")

						arg_49_1:RecordAudio("411191012", var_52_39)
						arg_49_1:RecordAudio("411191012", var_52_39)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_411191", "411191012", "story_v_out_411191.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_411191", "411191012", "story_v_out_411191.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_40 = math.max(var_52_31, arg_49_1.talkMaxDuration)

			if var_52_30 <= arg_49_1.time_ and arg_49_1.time_ < var_52_30 + var_52_40 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_30) / var_52_40

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_30 + var_52_40 and arg_49_1.time_ < var_52_30 + var_52_40 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play411191013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 411191013
		arg_53_1.duration_ = 3.23

		local var_53_0 = {
			zh = 3.233,
			ja = 2.2
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play411191014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["4010ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect4010ui_story == nil then
				arg_53_1.var_.characterEffect4010ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect4010ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_53_1.var_.characterEffect4010ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect4010ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_53_1.var_.characterEffect4010ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.3

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[718].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(411191013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 12
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191013", "story_v_out_411191.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_411191", "411191013", "story_v_out_411191.awb") / 1000

					if var_56_14 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_6
					end

					if var_56_9.prefab_name ~= "" and arg_53_1.actors_[var_56_9.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_9.prefab_name].transform, "story_v_out_411191", "411191013", "story_v_out_411191.awb")

						arg_53_1:RecordAudio("411191013", var_56_15)
						arg_53_1:RecordAudio("411191013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_411191", "411191013", "story_v_out_411191.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_411191", "411191013", "story_v_out_411191.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_16 and arg_53_1.time_ < var_56_6 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play411191014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 411191014
		arg_57_1.duration_ = 4.2

		local var_57_0 = {
			zh = 2.333,
			ja = 4.2
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play411191015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["4010ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos4010ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(-0.7, -1.59, -5.2)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos4010ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["4010ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect4010ui_story == nil then
				arg_57_1.var_.characterEffect4010ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect4010ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect4010ui_story then
				arg_57_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_2")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_60_15 = arg_57_1.actors_["1095ui_story"]
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 and not isNil(var_60_15) and arg_57_1.var_.characterEffect1095ui_story == nil then
				arg_57_1.var_.characterEffect1095ui_story = var_60_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_17 = 0.200000002980232

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_17 and not isNil(var_60_15) then
				local var_60_18 = (arg_57_1.time_ - var_60_16) / var_60_17

				if arg_57_1.var_.characterEffect1095ui_story and not isNil(var_60_15) then
					local var_60_19 = Mathf.Lerp(0, 0.5, var_60_18)

					arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1095ui_story.fillRatio = var_60_19
				end
			end

			if arg_57_1.time_ >= var_60_16 + var_60_17 and arg_57_1.time_ < var_60_16 + var_60_17 + arg_60_0 and not isNil(var_60_15) and arg_57_1.var_.characterEffect1095ui_story then
				local var_60_20 = 0.5

				arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1095ui_story.fillRatio = var_60_20
			end

			local var_60_21 = 0
			local var_60_22 = 0.175

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_23 = arg_57_1:FormatText(StoryNameCfg[42].name)

				arg_57_1.leftNameTxt_.text = var_60_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_24 = arg_57_1:GetWordFromCfg(411191014)
				local var_60_25 = arg_57_1:FormatText(var_60_24.content)

				arg_57_1.text_.text = var_60_25

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_26 = 7
				local var_60_27 = utf8.len(var_60_25)
				local var_60_28 = var_60_26 <= 0 and var_60_22 or var_60_22 * (var_60_27 / var_60_26)

				if var_60_28 > 0 and var_60_22 < var_60_28 then
					arg_57_1.talkMaxDuration = var_60_28

					if var_60_28 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_28 + var_60_21
					end
				end

				arg_57_1.text_.text = var_60_25
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191014", "story_v_out_411191.awb") ~= 0 then
					local var_60_29 = manager.audio:GetVoiceLength("story_v_out_411191", "411191014", "story_v_out_411191.awb") / 1000

					if var_60_29 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_29 + var_60_21
					end

					if var_60_24.prefab_name ~= "" and arg_57_1.actors_[var_60_24.prefab_name] ~= nil then
						local var_60_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_24.prefab_name].transform, "story_v_out_411191", "411191014", "story_v_out_411191.awb")

						arg_57_1:RecordAudio("411191014", var_60_30)
						arg_57_1:RecordAudio("411191014", var_60_30)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_411191", "411191014", "story_v_out_411191.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_411191", "411191014", "story_v_out_411191.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_31 = math.max(var_60_22, arg_57_1.talkMaxDuration)

			if var_60_21 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_31 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_21) / var_60_31

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_21 + var_60_31 and arg_57_1.time_ < var_60_21 + var_60_31 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play411191015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 411191015
		arg_61_1.duration_ = 8.5

		local var_61_0 = {
			zh = 6.9,
			ja = 8.5
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play411191016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.8

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[42].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(411191015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191015", "story_v_out_411191.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_411191", "411191015", "story_v_out_411191.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_411191", "411191015", "story_v_out_411191.awb")

						arg_61_1:RecordAudio("411191015", var_64_9)
						arg_61_1:RecordAudio("411191015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_411191", "411191015", "story_v_out_411191.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_411191", "411191015", "story_v_out_411191.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play411191016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 411191016
		arg_65_1.duration_ = 2.4

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 2.40000000298023
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
				arg_65_0:Play411191017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["4010ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect4010ui_story == nil then
				arg_65_1.var_.characterEffect4010ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect4010ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_65_1.var_.characterEffect4010ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect4010ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_65_1.var_.characterEffect4010ui_story.fillRatio = var_68_5
			end

			local var_68_6 = arg_65_1.actors_["1095ui_story"]
			local var_68_7 = 0

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.200000002980232

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 and not isNil(var_68_6) then
				local var_68_9 = (arg_65_1.time_ - var_68_7) / var_68_8

				if arg_65_1.var_.characterEffect1095ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1095ui_story then
				arg_65_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_68_11 = arg_65_1.actors_["1095ui_story"].transform
			local var_68_12 = 0

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.var_.moveOldPos1095ui_story = var_68_11.localPosition
			end

			local var_68_13 = 0.001

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 then
				local var_68_14 = (arg_65_1.time_ - var_68_12) / var_68_13
				local var_68_15 = Vector3.New(0.7, -0.98, -6.1)

				var_68_11.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1095ui_story, var_68_15, var_68_14)

				local var_68_16 = manager.ui.mainCamera.transform.position - var_68_11.position

				var_68_11.forward = Vector3.New(var_68_16.x, var_68_16.y, var_68_16.z)

				local var_68_17 = var_68_11.localEulerAngles

				var_68_17.z = 0
				var_68_17.x = 0
				var_68_11.localEulerAngles = var_68_17
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 then
				var_68_11.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_68_18 = manager.ui.mainCamera.transform.position - var_68_11.position

				var_68_11.forward = Vector3.New(var_68_18.x, var_68_18.y, var_68_18.z)

				local var_68_19 = var_68_11.localEulerAngles

				var_68_19.z = 0
				var_68_19.x = 0
				var_68_11.localEulerAngles = var_68_19
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_20 = 0.200000002980232
			local var_68_21 = 0.125

			if var_68_20 < arg_65_1.time_ and arg_65_1.time_ <= var_68_20 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_22 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_22:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_23 = arg_65_1:FormatText(StoryNameCfg[471].name)

				arg_65_1.leftNameTxt_.text = var_68_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_24 = arg_65_1:GetWordFromCfg(411191016)
				local var_68_25 = arg_65_1:FormatText(var_68_24.content)

				arg_65_1.text_.text = var_68_25

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_26 = 5
				local var_68_27 = utf8.len(var_68_25)
				local var_68_28 = var_68_26 <= 0 and var_68_21 or var_68_21 * (var_68_27 / var_68_26)

				if var_68_28 > 0 and var_68_21 < var_68_28 then
					arg_65_1.talkMaxDuration = var_68_28
					var_68_20 = var_68_20 + 0.3

					if var_68_28 + var_68_20 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_28 + var_68_20
					end
				end

				arg_65_1.text_.text = var_68_25
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191016", "story_v_out_411191.awb") ~= 0 then
					local var_68_29 = manager.audio:GetVoiceLength("story_v_out_411191", "411191016", "story_v_out_411191.awb") / 1000

					if var_68_29 + var_68_20 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_29 + var_68_20
					end

					if var_68_24.prefab_name ~= "" and arg_65_1.actors_[var_68_24.prefab_name] ~= nil then
						local var_68_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_24.prefab_name].transform, "story_v_out_411191", "411191016", "story_v_out_411191.awb")

						arg_65_1:RecordAudio("411191016", var_68_30)
						arg_65_1:RecordAudio("411191016", var_68_30)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_411191", "411191016", "story_v_out_411191.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_411191", "411191016", "story_v_out_411191.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_31 = var_68_20 + 0.3
			local var_68_32 = math.max(var_68_21, arg_65_1.talkMaxDuration)

			if var_68_31 <= arg_65_1.time_ and arg_65_1.time_ < var_68_31 + var_68_32 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_31) / var_68_32

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_31 + var_68_32 and arg_65_1.time_ < var_68_31 + var_68_32 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play411191017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 411191017
		arg_71_1.duration_ = 5.2

		local var_71_0 = {
			zh = 3.666,
			ja = 5.2
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
				arg_71_0:Play411191018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["4010ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect4010ui_story == nil then
				arg_71_1.var_.characterEffect4010ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect4010ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect4010ui_story then
				arg_71_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_74_4 = arg_71_1.actors_["1095ui_story"]
			local var_74_5 = 0

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1095ui_story == nil then
				arg_71_1.var_.characterEffect1095ui_story = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_6 = 0.200000002980232

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_6 and not isNil(var_74_4) then
				local var_74_7 = (arg_71_1.time_ - var_74_5) / var_74_6

				if arg_71_1.var_.characterEffect1095ui_story and not isNil(var_74_4) then
					local var_74_8 = Mathf.Lerp(0, 0.5, var_74_7)

					arg_71_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1095ui_story.fillRatio = var_74_8
				end
			end

			if arg_71_1.time_ >= var_74_5 + var_74_6 and arg_71_1.time_ < var_74_5 + var_74_6 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1095ui_story then
				local var_74_9 = 0.5

				arg_71_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1095ui_story.fillRatio = var_74_9
			end

			local var_74_10 = 0
			local var_74_11 = 0.4

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_12 = arg_71_1:FormatText(StoryNameCfg[42].name)

				arg_71_1.leftNameTxt_.text = var_74_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_13 = arg_71_1:GetWordFromCfg(411191017)
				local var_74_14 = arg_71_1:FormatText(var_74_13.content)

				arg_71_1.text_.text = var_74_14

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_15 = 16
				local var_74_16 = utf8.len(var_74_14)
				local var_74_17 = var_74_15 <= 0 and var_74_11 or var_74_11 * (var_74_16 / var_74_15)

				if var_74_17 > 0 and var_74_11 < var_74_17 then
					arg_71_1.talkMaxDuration = var_74_17

					if var_74_17 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_17 + var_74_10
					end
				end

				arg_71_1.text_.text = var_74_14
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191017", "story_v_out_411191.awb") ~= 0 then
					local var_74_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191017", "story_v_out_411191.awb") / 1000

					if var_74_18 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_18 + var_74_10
					end

					if var_74_13.prefab_name ~= "" and arg_71_1.actors_[var_74_13.prefab_name] ~= nil then
						local var_74_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_13.prefab_name].transform, "story_v_out_411191", "411191017", "story_v_out_411191.awb")

						arg_71_1:RecordAudio("411191017", var_74_19)
						arg_71_1:RecordAudio("411191017", var_74_19)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_411191", "411191017", "story_v_out_411191.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_411191", "411191017", "story_v_out_411191.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_20 = math.max(var_74_11, arg_71_1.talkMaxDuration)

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_20 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_10) / var_74_20

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_10 + var_74_20 and arg_71_1.time_ < var_74_10 + var_74_20 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play411191018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 411191018
		arg_75_1.duration_ = 10.17

		local var_75_0 = {
			zh = 10.166,
			ja = 9.066
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play411191019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["4010ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect4010ui_story == nil then
				arg_75_1.var_.characterEffect4010ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect4010ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_75_1.var_.characterEffect4010ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect4010ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_75_1.var_.characterEffect4010ui_story.fillRatio = var_78_5
			end

			local var_78_6 = arg_75_1.actors_["1095ui_story"]
			local var_78_7 = 0

			if var_78_7 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect1095ui_story == nil then
				arg_75_1.var_.characterEffect1095ui_story = var_78_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_8 = 0.200000002980232

			if var_78_7 <= arg_75_1.time_ and arg_75_1.time_ < var_78_7 + var_78_8 and not isNil(var_78_6) then
				local var_78_9 = (arg_75_1.time_ - var_78_7) / var_78_8

				if arg_75_1.var_.characterEffect1095ui_story and not isNil(var_78_6) then
					arg_75_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_7 + var_78_8 and arg_75_1.time_ < var_78_7 + var_78_8 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect1095ui_story then
				arg_75_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_78_10 = 0
			local var_78_11 = 1.05

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_12 = arg_75_1:FormatText(StoryNameCfg[471].name)

				arg_75_1.leftNameTxt_.text = var_78_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_13 = arg_75_1:GetWordFromCfg(411191018)
				local var_78_14 = arg_75_1:FormatText(var_78_13.content)

				arg_75_1.text_.text = var_78_14

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_15 = 42
				local var_78_16 = utf8.len(var_78_14)
				local var_78_17 = var_78_15 <= 0 and var_78_11 or var_78_11 * (var_78_16 / var_78_15)

				if var_78_17 > 0 and var_78_11 < var_78_17 then
					arg_75_1.talkMaxDuration = var_78_17

					if var_78_17 + var_78_10 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_17 + var_78_10
					end
				end

				arg_75_1.text_.text = var_78_14
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191018", "story_v_out_411191.awb") ~= 0 then
					local var_78_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191018", "story_v_out_411191.awb") / 1000

					if var_78_18 + var_78_10 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_18 + var_78_10
					end

					if var_78_13.prefab_name ~= "" and arg_75_1.actors_[var_78_13.prefab_name] ~= nil then
						local var_78_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_13.prefab_name].transform, "story_v_out_411191", "411191018", "story_v_out_411191.awb")

						arg_75_1:RecordAudio("411191018", var_78_19)
						arg_75_1:RecordAudio("411191018", var_78_19)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_411191", "411191018", "story_v_out_411191.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_411191", "411191018", "story_v_out_411191.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_20 = math.max(var_78_11, arg_75_1.talkMaxDuration)

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_20 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_10) / var_78_20

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_10 + var_78_20 and arg_75_1.time_ < var_78_10 + var_78_20 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play411191019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 411191019
		arg_79_1.duration_ = 3.03

		local var_79_0 = {
			zh = 3.033,
			ja = 1.533
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
				arg_79_0:Play411191020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["4010ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect4010ui_story == nil then
				arg_79_1.var_.characterEffect4010ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect4010ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect4010ui_story then
				arg_79_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_82_4 = arg_79_1.actors_["1095ui_story"]
			local var_82_5 = 0

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect1095ui_story == nil then
				arg_79_1.var_.characterEffect1095ui_story = var_82_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_6 = 0.200000002980232

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_6 and not isNil(var_82_4) then
				local var_82_7 = (arg_79_1.time_ - var_82_5) / var_82_6

				if arg_79_1.var_.characterEffect1095ui_story and not isNil(var_82_4) then
					local var_82_8 = Mathf.Lerp(0, 0.5, var_82_7)

					arg_79_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1095ui_story.fillRatio = var_82_8
				end
			end

			if arg_79_1.time_ >= var_82_5 + var_82_6 and arg_79_1.time_ < var_82_5 + var_82_6 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect1095ui_story then
				local var_82_9 = 0.5

				arg_79_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1095ui_story.fillRatio = var_82_9
			end

			local var_82_10 = 0
			local var_82_11 = 0.175

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_12 = arg_79_1:FormatText(StoryNameCfg[42].name)

				arg_79_1.leftNameTxt_.text = var_82_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_13 = arg_79_1:GetWordFromCfg(411191019)
				local var_82_14 = arg_79_1:FormatText(var_82_13.content)

				arg_79_1.text_.text = var_82_14

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_15 = 7
				local var_82_16 = utf8.len(var_82_14)
				local var_82_17 = var_82_15 <= 0 and var_82_11 or var_82_11 * (var_82_16 / var_82_15)

				if var_82_17 > 0 and var_82_11 < var_82_17 then
					arg_79_1.talkMaxDuration = var_82_17

					if var_82_17 + var_82_10 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_17 + var_82_10
					end
				end

				arg_79_1.text_.text = var_82_14
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191019", "story_v_out_411191.awb") ~= 0 then
					local var_82_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191019", "story_v_out_411191.awb") / 1000

					if var_82_18 + var_82_10 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_18 + var_82_10
					end

					if var_82_13.prefab_name ~= "" and arg_79_1.actors_[var_82_13.prefab_name] ~= nil then
						local var_82_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_13.prefab_name].transform, "story_v_out_411191", "411191019", "story_v_out_411191.awb")

						arg_79_1:RecordAudio("411191019", var_82_19)
						arg_79_1:RecordAudio("411191019", var_82_19)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_411191", "411191019", "story_v_out_411191.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_411191", "411191019", "story_v_out_411191.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_20 = math.max(var_82_11, arg_79_1.talkMaxDuration)

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_20 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_10) / var_82_20

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_10 + var_82_20 and arg_79_1.time_ < var_82_10 + var_82_20 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play411191020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 411191020
		arg_83_1.duration_ = 4.67

		local var_83_0 = {
			zh = 4.666,
			ja = 4.5
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
				arg_83_0:Play411191021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.65

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[42].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:GetWordFromCfg(411191020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 26
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191020", "story_v_out_411191.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_411191", "411191020", "story_v_out_411191.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_411191", "411191020", "story_v_out_411191.awb")

						arg_83_1:RecordAudio("411191020", var_86_9)
						arg_83_1:RecordAudio("411191020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_411191", "411191020", "story_v_out_411191.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_411191", "411191020", "story_v_out_411191.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play411191021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 411191021
		arg_87_1.duration_ = 5.7

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play411191022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["4010ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect4010ui_story == nil then
				arg_87_1.var_.characterEffect4010ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect4010ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_87_1.var_.characterEffect4010ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect4010ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_87_1.var_.characterEffect4010ui_story.fillRatio = var_90_5
			end

			local var_90_6 = arg_87_1.actors_["1095ui_story"]
			local var_90_7 = 0

			if var_90_7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1095ui_story == nil then
				arg_87_1.var_.characterEffect1095ui_story = var_90_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_8 = 0.200000002980232

			if var_90_7 <= arg_87_1.time_ and arg_87_1.time_ < var_90_7 + var_90_8 and not isNil(var_90_6) then
				local var_90_9 = (arg_87_1.time_ - var_90_7) / var_90_8

				if arg_87_1.var_.characterEffect1095ui_story and not isNil(var_90_6) then
					arg_87_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_7 + var_90_8 and arg_87_1.time_ < var_90_7 + var_90_8 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1095ui_story then
				arg_87_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_90_11 = 0
			local var_90_12 = 0.625

			if var_90_11 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_13 = arg_87_1:FormatText(StoryNameCfg[471].name)

				arg_87_1.leftNameTxt_.text = var_90_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_14 = arg_87_1:GetWordFromCfg(411191021)
				local var_90_15 = arg_87_1:FormatText(var_90_14.content)

				arg_87_1.text_.text = var_90_15

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_16 = 25
				local var_90_17 = utf8.len(var_90_15)
				local var_90_18 = var_90_16 <= 0 and var_90_12 or var_90_12 * (var_90_17 / var_90_16)

				if var_90_18 > 0 and var_90_12 < var_90_18 then
					arg_87_1.talkMaxDuration = var_90_18

					if var_90_18 + var_90_11 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_18 + var_90_11
					end
				end

				arg_87_1.text_.text = var_90_15
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191021", "story_v_out_411191.awb") ~= 0 then
					local var_90_19 = manager.audio:GetVoiceLength("story_v_out_411191", "411191021", "story_v_out_411191.awb") / 1000

					if var_90_19 + var_90_11 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_19 + var_90_11
					end

					if var_90_14.prefab_name ~= "" and arg_87_1.actors_[var_90_14.prefab_name] ~= nil then
						local var_90_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_14.prefab_name].transform, "story_v_out_411191", "411191021", "story_v_out_411191.awb")

						arg_87_1:RecordAudio("411191021", var_90_20)
						arg_87_1:RecordAudio("411191021", var_90_20)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_411191", "411191021", "story_v_out_411191.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_411191", "411191021", "story_v_out_411191.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_21 = math.max(var_90_12, arg_87_1.talkMaxDuration)

			if var_90_11 <= arg_87_1.time_ and arg_87_1.time_ < var_90_11 + var_90_21 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_11) / var_90_21

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_11 + var_90_21 and arg_87_1.time_ < var_90_11 + var_90_21 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play411191022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 411191022
		arg_91_1.duration_ = 4.1

		local var_91_0 = {
			zh = 2.5,
			ja = 4.1
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
				arg_91_0:Play411191023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["4010ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect4010ui_story == nil then
				arg_91_1.var_.characterEffect4010ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect4010ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect4010ui_story then
				arg_91_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_94_4 = arg_91_1.actors_["1095ui_story"]
			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect1095ui_story == nil then
				arg_91_1.var_.characterEffect1095ui_story = var_94_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_6 = 0.200000002980232

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_6 and not isNil(var_94_4) then
				local var_94_7 = (arg_91_1.time_ - var_94_5) / var_94_6

				if arg_91_1.var_.characterEffect1095ui_story and not isNil(var_94_4) then
					local var_94_8 = Mathf.Lerp(0, 0.5, var_94_7)

					arg_91_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1095ui_story.fillRatio = var_94_8
				end
			end

			if arg_91_1.time_ >= var_94_5 + var_94_6 and arg_91_1.time_ < var_94_5 + var_94_6 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect1095ui_story then
				local var_94_9 = 0.5

				arg_91_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1095ui_story.fillRatio = var_94_9
			end

			local var_94_10 = 0
			local var_94_11 = 0.225

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_12 = arg_91_1:FormatText(StoryNameCfg[42].name)

				arg_91_1.leftNameTxt_.text = var_94_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_13 = arg_91_1:GetWordFromCfg(411191022)
				local var_94_14 = arg_91_1:FormatText(var_94_13.content)

				arg_91_1.text_.text = var_94_14

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_15 = 9
				local var_94_16 = utf8.len(var_94_14)
				local var_94_17 = var_94_15 <= 0 and var_94_11 or var_94_11 * (var_94_16 / var_94_15)

				if var_94_17 > 0 and var_94_11 < var_94_17 then
					arg_91_1.talkMaxDuration = var_94_17

					if var_94_17 + var_94_10 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_17 + var_94_10
					end
				end

				arg_91_1.text_.text = var_94_14
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191022", "story_v_out_411191.awb") ~= 0 then
					local var_94_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191022", "story_v_out_411191.awb") / 1000

					if var_94_18 + var_94_10 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_18 + var_94_10
					end

					if var_94_13.prefab_name ~= "" and arg_91_1.actors_[var_94_13.prefab_name] ~= nil then
						local var_94_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_13.prefab_name].transform, "story_v_out_411191", "411191022", "story_v_out_411191.awb")

						arg_91_1:RecordAudio("411191022", var_94_19)
						arg_91_1:RecordAudio("411191022", var_94_19)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_411191", "411191022", "story_v_out_411191.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_411191", "411191022", "story_v_out_411191.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_20 = math.max(var_94_11, arg_91_1.talkMaxDuration)

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_20 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_10) / var_94_20

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_10 + var_94_20 and arg_91_1.time_ < var_94_10 + var_94_20 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play411191023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 411191023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play411191024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["4010ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos4010ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, 100, 0)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos4010ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, 100, 0)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["4010ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect4010ui_story == nil then
				arg_95_1.var_.characterEffect4010ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect4010ui_story and not isNil(var_98_9) then
					local var_98_13 = Mathf.Lerp(0, 0.5, var_98_12)

					arg_95_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_95_1.var_.characterEffect4010ui_story.fillRatio = var_98_13
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect4010ui_story then
				local var_98_14 = 0.5

				arg_95_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_95_1.var_.characterEffect4010ui_story.fillRatio = var_98_14
			end

			local var_98_15 = arg_95_1.actors_["1095ui_story"].transform
			local var_98_16 = 0

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1.var_.moveOldPos1095ui_story = var_98_15.localPosition
			end

			local var_98_17 = 0.001

			if var_98_16 <= arg_95_1.time_ and arg_95_1.time_ < var_98_16 + var_98_17 then
				local var_98_18 = (arg_95_1.time_ - var_98_16) / var_98_17
				local var_98_19 = Vector3.New(0, 100, 0)

				var_98_15.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1095ui_story, var_98_19, var_98_18)

				local var_98_20 = manager.ui.mainCamera.transform.position - var_98_15.position

				var_98_15.forward = Vector3.New(var_98_20.x, var_98_20.y, var_98_20.z)

				local var_98_21 = var_98_15.localEulerAngles

				var_98_21.z = 0
				var_98_21.x = 0
				var_98_15.localEulerAngles = var_98_21
			end

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 then
				var_98_15.localPosition = Vector3.New(0, 100, 0)

				local var_98_22 = manager.ui.mainCamera.transform.position - var_98_15.position

				var_98_15.forward = Vector3.New(var_98_22.x, var_98_22.y, var_98_22.z)

				local var_98_23 = var_98_15.localEulerAngles

				var_98_23.z = 0
				var_98_23.x = 0
				var_98_15.localEulerAngles = var_98_23
			end

			local var_98_24 = arg_95_1.actors_["1095ui_story"]
			local var_98_25 = 0

			if var_98_25 < arg_95_1.time_ and arg_95_1.time_ <= var_98_25 + arg_98_0 and not isNil(var_98_24) and arg_95_1.var_.characterEffect1095ui_story == nil then
				arg_95_1.var_.characterEffect1095ui_story = var_98_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_26 = 0.200000002980232

			if var_98_25 <= arg_95_1.time_ and arg_95_1.time_ < var_98_25 + var_98_26 and not isNil(var_98_24) then
				local var_98_27 = (arg_95_1.time_ - var_98_25) / var_98_26

				if arg_95_1.var_.characterEffect1095ui_story and not isNil(var_98_24) then
					local var_98_28 = Mathf.Lerp(0, 0.5, var_98_27)

					arg_95_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1095ui_story.fillRatio = var_98_28
				end
			end

			if arg_95_1.time_ >= var_98_25 + var_98_26 and arg_95_1.time_ < var_98_25 + var_98_26 + arg_98_0 and not isNil(var_98_24) and arg_95_1.var_.characterEffect1095ui_story then
				local var_98_29 = 0.5

				arg_95_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1095ui_story.fillRatio = var_98_29
			end

			local var_98_30 = 0
			local var_98_31 = 0.9

			if var_98_30 < arg_95_1.time_ and arg_95_1.time_ <= var_98_30 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_32 = arg_95_1:GetWordFromCfg(411191023)
				local var_98_33 = arg_95_1:FormatText(var_98_32.content)

				arg_95_1.text_.text = var_98_33

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_34 = 36
				local var_98_35 = utf8.len(var_98_33)
				local var_98_36 = var_98_34 <= 0 and var_98_31 or var_98_31 * (var_98_35 / var_98_34)

				if var_98_36 > 0 and var_98_31 < var_98_36 then
					arg_95_1.talkMaxDuration = var_98_36

					if var_98_36 + var_98_30 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_36 + var_98_30
					end
				end

				arg_95_1.text_.text = var_98_33
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_37 = math.max(var_98_31, arg_95_1.talkMaxDuration)

			if var_98_30 <= arg_95_1.time_ and arg_95_1.time_ < var_98_30 + var_98_37 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_30) / var_98_37

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_30 + var_98_37 and arg_95_1.time_ < var_98_30 + var_98_37 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play411191024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 411191024
		arg_99_1.duration_ = 2

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play411191025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1095ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1095ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, -0.98, -6.1)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1095ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = arg_99_1.actors_["1095ui_story"]
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1095ui_story == nil then
				arg_99_1.var_.characterEffect1095ui_story = var_102_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_11 = 0.200000002980232

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 and not isNil(var_102_9) then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11

				if arg_99_1.var_.characterEffect1095ui_story and not isNil(var_102_9) then
					arg_99_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1095ui_story then
				arg_99_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_102_13 = 0

			if var_102_13 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_14 = 0
			local var_102_15 = 0.1

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_16 = arg_99_1:FormatText(StoryNameCfg[471].name)

				arg_99_1.leftNameTxt_.text = var_102_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_17 = arg_99_1:GetWordFromCfg(411191024)
				local var_102_18 = arg_99_1:FormatText(var_102_17.content)

				arg_99_1.text_.text = var_102_18

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_19 = 4
				local var_102_20 = utf8.len(var_102_18)
				local var_102_21 = var_102_19 <= 0 and var_102_15 or var_102_15 * (var_102_20 / var_102_19)

				if var_102_21 > 0 and var_102_15 < var_102_21 then
					arg_99_1.talkMaxDuration = var_102_21

					if var_102_21 + var_102_14 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_21 + var_102_14
					end
				end

				arg_99_1.text_.text = var_102_18
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191024", "story_v_out_411191.awb") ~= 0 then
					local var_102_22 = manager.audio:GetVoiceLength("story_v_out_411191", "411191024", "story_v_out_411191.awb") / 1000

					if var_102_22 + var_102_14 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_22 + var_102_14
					end

					if var_102_17.prefab_name ~= "" and arg_99_1.actors_[var_102_17.prefab_name] ~= nil then
						local var_102_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_17.prefab_name].transform, "story_v_out_411191", "411191024", "story_v_out_411191.awb")

						arg_99_1:RecordAudio("411191024", var_102_23)
						arg_99_1:RecordAudio("411191024", var_102_23)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_411191", "411191024", "story_v_out_411191.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_411191", "411191024", "story_v_out_411191.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_24 = math.max(var_102_15, arg_99_1.talkMaxDuration)

			if var_102_14 <= arg_99_1.time_ and arg_99_1.time_ < var_102_14 + var_102_24 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_14) / var_102_24

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_14 + var_102_24 and arg_99_1.time_ < var_102_14 + var_102_24 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play411191025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 411191025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play411191026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1095ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1095ui_story == nil then
				arg_103_1.var_.characterEffect1095ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1095ui_story and not isNil(var_106_0) then
					local var_106_4 = Mathf.Lerp(0, 0.5, var_106_3)

					arg_103_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1095ui_story.fillRatio = var_106_4
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1095ui_story then
				local var_106_5 = 0.5

				arg_103_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1095ui_story.fillRatio = var_106_5
			end

			local var_106_6 = 0
			local var_106_7 = 0.675

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_8 = arg_103_1:GetWordFromCfg(411191025)
				local var_106_9 = arg_103_1:FormatText(var_106_8.content)

				arg_103_1.text_.text = var_106_9

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 27
				local var_106_11 = utf8.len(var_106_9)
				local var_106_12 = var_106_10 <= 0 and var_106_7 or var_106_7 * (var_106_11 / var_106_10)

				if var_106_12 > 0 and var_106_7 < var_106_12 then
					arg_103_1.talkMaxDuration = var_106_12

					if var_106_12 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_12 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_9
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_13 and arg_103_1.time_ < var_106_6 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play411191026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 411191026
		arg_107_1.duration_ = 2

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play411191027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["4010ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos4010ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(0, -1.59, -5.2)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos4010ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["4010ui_story"]
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect4010ui_story == nil then
				arg_107_1.var_.characterEffect4010ui_story = var_110_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_11 = 0.200000002980232

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 and not isNil(var_110_9) then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11

				if arg_107_1.var_.characterEffect4010ui_story and not isNil(var_110_9) then
					arg_107_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect4010ui_story then
				arg_107_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_110_13 = 0

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			local var_110_14 = 0

			if var_110_14 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_110_15 = arg_107_1.actors_["1095ui_story"].transform
			local var_110_16 = 0

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				arg_107_1.var_.moveOldPos1095ui_story = var_110_15.localPosition
			end

			local var_110_17 = 0.001

			if var_110_16 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_17 then
				local var_110_18 = (arg_107_1.time_ - var_110_16) / var_110_17
				local var_110_19 = Vector3.New(0, 100, 0)

				var_110_15.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1095ui_story, var_110_19, var_110_18)

				local var_110_20 = manager.ui.mainCamera.transform.position - var_110_15.position

				var_110_15.forward = Vector3.New(var_110_20.x, var_110_20.y, var_110_20.z)

				local var_110_21 = var_110_15.localEulerAngles

				var_110_21.z = 0
				var_110_21.x = 0
				var_110_15.localEulerAngles = var_110_21
			end

			if arg_107_1.time_ >= var_110_16 + var_110_17 and arg_107_1.time_ < var_110_16 + var_110_17 + arg_110_0 then
				var_110_15.localPosition = Vector3.New(0, 100, 0)

				local var_110_22 = manager.ui.mainCamera.transform.position - var_110_15.position

				var_110_15.forward = Vector3.New(var_110_22.x, var_110_22.y, var_110_22.z)

				local var_110_23 = var_110_15.localEulerAngles

				var_110_23.z = 0
				var_110_23.x = 0
				var_110_15.localEulerAngles = var_110_23
			end

			local var_110_24 = arg_107_1.actors_["1095ui_story"]
			local var_110_25 = 0

			if var_110_25 < arg_107_1.time_ and arg_107_1.time_ <= var_110_25 + arg_110_0 and not isNil(var_110_24) and arg_107_1.var_.characterEffect1095ui_story == nil then
				arg_107_1.var_.characterEffect1095ui_story = var_110_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_26 = 0.200000002980232

			if var_110_25 <= arg_107_1.time_ and arg_107_1.time_ < var_110_25 + var_110_26 and not isNil(var_110_24) then
				local var_110_27 = (arg_107_1.time_ - var_110_25) / var_110_26

				if arg_107_1.var_.characterEffect1095ui_story and not isNil(var_110_24) then
					local var_110_28 = Mathf.Lerp(0, 0.5, var_110_27)

					arg_107_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1095ui_story.fillRatio = var_110_28
				end
			end

			if arg_107_1.time_ >= var_110_25 + var_110_26 and arg_107_1.time_ < var_110_25 + var_110_26 + arg_110_0 and not isNil(var_110_24) and arg_107_1.var_.characterEffect1095ui_story then
				local var_110_29 = 0.5

				arg_107_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1095ui_story.fillRatio = var_110_29
			end

			local var_110_30 = 0
			local var_110_31 = 0.05

			if var_110_30 < arg_107_1.time_ and arg_107_1.time_ <= var_110_30 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_32 = arg_107_1:FormatText(StoryNameCfg[42].name)

				arg_107_1.leftNameTxt_.text = var_110_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_33 = arg_107_1:GetWordFromCfg(411191026)
				local var_110_34 = arg_107_1:FormatText(var_110_33.content)

				arg_107_1.text_.text = var_110_34

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_35 = 2
				local var_110_36 = utf8.len(var_110_34)
				local var_110_37 = var_110_35 <= 0 and var_110_31 or var_110_31 * (var_110_36 / var_110_35)

				if var_110_37 > 0 and var_110_31 < var_110_37 then
					arg_107_1.talkMaxDuration = var_110_37

					if var_110_37 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_37 + var_110_30
					end
				end

				arg_107_1.text_.text = var_110_34
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191026", "story_v_out_411191.awb") ~= 0 then
					local var_110_38 = manager.audio:GetVoiceLength("story_v_out_411191", "411191026", "story_v_out_411191.awb") / 1000

					if var_110_38 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_38 + var_110_30
					end

					if var_110_33.prefab_name ~= "" and arg_107_1.actors_[var_110_33.prefab_name] ~= nil then
						local var_110_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_33.prefab_name].transform, "story_v_out_411191", "411191026", "story_v_out_411191.awb")

						arg_107_1:RecordAudio("411191026", var_110_39)
						arg_107_1:RecordAudio("411191026", var_110_39)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_411191", "411191026", "story_v_out_411191.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_411191", "411191026", "story_v_out_411191.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_40 = math.max(var_110_31, arg_107_1.talkMaxDuration)

			if var_110_30 <= arg_107_1.time_ and arg_107_1.time_ < var_110_30 + var_110_40 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_30) / var_110_40

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_30 + var_110_40 and arg_107_1.time_ < var_110_30 + var_110_40 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play411191027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 411191027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play411191028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["4010ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect4010ui_story == nil then
				arg_111_1.var_.characterEffect4010ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect4010ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_111_1.var_.characterEffect4010ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect4010ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_111_1.var_.characterEffect4010ui_story.fillRatio = var_114_5
			end

			local var_114_6 = arg_111_1.actors_["4010ui_story"].transform
			local var_114_7 = 0

			if var_114_7 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 then
				arg_111_1.var_.moveOldPos4010ui_story = var_114_6.localPosition
			end

			local var_114_8 = 0.001

			if var_114_7 <= arg_111_1.time_ and arg_111_1.time_ < var_114_7 + var_114_8 then
				local var_114_9 = (arg_111_1.time_ - var_114_7) / var_114_8
				local var_114_10 = Vector3.New(0, 100, 0)

				var_114_6.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos4010ui_story, var_114_10, var_114_9)

				local var_114_11 = manager.ui.mainCamera.transform.position - var_114_6.position

				var_114_6.forward = Vector3.New(var_114_11.x, var_114_11.y, var_114_11.z)

				local var_114_12 = var_114_6.localEulerAngles

				var_114_12.z = 0
				var_114_12.x = 0
				var_114_6.localEulerAngles = var_114_12
			end

			if arg_111_1.time_ >= var_114_7 + var_114_8 and arg_111_1.time_ < var_114_7 + var_114_8 + arg_114_0 then
				var_114_6.localPosition = Vector3.New(0, 100, 0)

				local var_114_13 = manager.ui.mainCamera.transform.position - var_114_6.position

				var_114_6.forward = Vector3.New(var_114_13.x, var_114_13.y, var_114_13.z)

				local var_114_14 = var_114_6.localEulerAngles

				var_114_14.z = 0
				var_114_14.x = 0
				var_114_6.localEulerAngles = var_114_14
			end

			local var_114_15 = manager.ui.mainCamera.transform
			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.var_.shakeOldPos = var_114_15.localPosition
			end

			local var_114_17 = 0.6

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_17 then
				local var_114_18 = (arg_111_1.time_ - var_114_16) / 0.066
				local var_114_19, var_114_20 = math.modf(var_114_18)

				var_114_15.localPosition = Vector3.New(var_114_20 * 0.13, var_114_20 * 0.13, var_114_20 * 0.13) + arg_111_1.var_.shakeOldPos
			end

			if arg_111_1.time_ >= var_114_16 + var_114_17 and arg_111_1.time_ < var_114_16 + var_114_17 + arg_114_0 then
				var_114_15.localPosition = arg_111_1.var_.shakeOldPos
			end

			local var_114_21 = 0
			local var_114_22 = 0.95

			if var_114_21 < arg_111_1.time_ and arg_111_1.time_ <= var_114_21 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_23 = arg_111_1:GetWordFromCfg(411191027)
				local var_114_24 = arg_111_1:FormatText(var_114_23.content)

				arg_111_1.text_.text = var_114_24

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_25 = 38
				local var_114_26 = utf8.len(var_114_24)
				local var_114_27 = var_114_25 <= 0 and var_114_22 or var_114_22 * (var_114_26 / var_114_25)

				if var_114_27 > 0 and var_114_22 < var_114_27 then
					arg_111_1.talkMaxDuration = var_114_27

					if var_114_27 + var_114_21 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_27 + var_114_21
					end
				end

				arg_111_1.text_.text = var_114_24
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_28 = math.max(var_114_22, arg_111_1.talkMaxDuration)

			if var_114_21 <= arg_111_1.time_ and arg_111_1.time_ < var_114_21 + var_114_28 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_21) / var_114_28

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_21 + var_114_28 and arg_111_1.time_ < var_114_21 + var_114_28 + arg_114_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play411191028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 411191028
		arg_115_1.duration_ = 8.07

		local var_115_0 = {
			zh = 6.9,
			ja = 8.066
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
				arg_115_0:Play411191029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1095ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1095ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0.7, -0.98, -6.1)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1095ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["1095ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1095ui_story == nil then
				arg_115_1.var_.characterEffect1095ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 and not isNil(var_118_9) then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect1095ui_story and not isNil(var_118_9) then
					arg_115_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1095ui_story then
				arg_115_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_118_13 = 0

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_118_14 = 0

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_15 = 0
			local var_118_16 = 0.7

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_17 = arg_115_1:FormatText(StoryNameCfg[471].name)

				arg_115_1.leftNameTxt_.text = var_118_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_18 = arg_115_1:GetWordFromCfg(411191028)
				local var_118_19 = arg_115_1:FormatText(var_118_18.content)

				arg_115_1.text_.text = var_118_19

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_20 = 28
				local var_118_21 = utf8.len(var_118_19)
				local var_118_22 = var_118_20 <= 0 and var_118_16 or var_118_16 * (var_118_21 / var_118_20)

				if var_118_22 > 0 and var_118_16 < var_118_22 then
					arg_115_1.talkMaxDuration = var_118_22

					if var_118_22 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_15
					end
				end

				arg_115_1.text_.text = var_118_19
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191028", "story_v_out_411191.awb") ~= 0 then
					local var_118_23 = manager.audio:GetVoiceLength("story_v_out_411191", "411191028", "story_v_out_411191.awb") / 1000

					if var_118_23 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_23 + var_118_15
					end

					if var_118_18.prefab_name ~= "" and arg_115_1.actors_[var_118_18.prefab_name] ~= nil then
						local var_118_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_18.prefab_name].transform, "story_v_out_411191", "411191028", "story_v_out_411191.awb")

						arg_115_1:RecordAudio("411191028", var_118_24)
						arg_115_1:RecordAudio("411191028", var_118_24)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_411191", "411191028", "story_v_out_411191.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_411191", "411191028", "story_v_out_411191.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_25 = math.max(var_118_16, arg_115_1.talkMaxDuration)

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_25 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_15) / var_118_25

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_15 + var_118_25 and arg_115_1.time_ < var_118_15 + var_118_25 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play411191029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 411191029
		arg_119_1.duration_ = 4.37

		local var_119_0 = {
			zh = 2.96666666666667,
			ja = 4.36666666666667
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play411191030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["4010ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect4010ui_story == nil then
				arg_119_1.var_.characterEffect4010ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect4010ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect4010ui_story then
				arg_119_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_122_4 = arg_119_1.actors_["1095ui_story"]
			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1095ui_story == nil then
				arg_119_1.var_.characterEffect1095ui_story = var_122_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.200000002980232

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 and not isNil(var_122_4) then
				local var_122_7 = (arg_119_1.time_ - var_122_5) / var_122_6

				if arg_119_1.var_.characterEffect1095ui_story and not isNil(var_122_4) then
					local var_122_8 = Mathf.Lerp(0, 0.5, var_122_7)

					arg_119_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1095ui_story.fillRatio = var_122_8
				end
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1095ui_story then
				local var_122_9 = 0.5

				arg_119_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1095ui_story.fillRatio = var_122_9
			end

			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_2")
			end

			local var_122_11 = 0

			if var_122_11 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_122_12 = arg_119_1.actors_["4010ui_story"].transform
			local var_122_13 = 0

			if var_122_13 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1.var_.moveOldPos4010ui_story = var_122_12.localPosition
			end

			local var_122_14 = 0.001

			if var_122_13 <= arg_119_1.time_ and arg_119_1.time_ < var_122_13 + var_122_14 then
				local var_122_15 = (arg_119_1.time_ - var_122_13) / var_122_14
				local var_122_16 = Vector3.New(-0.7, -1.59, -5.2)

				var_122_12.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos4010ui_story, var_122_16, var_122_15)

				local var_122_17 = manager.ui.mainCamera.transform.position - var_122_12.position

				var_122_12.forward = Vector3.New(var_122_17.x, var_122_17.y, var_122_17.z)

				local var_122_18 = var_122_12.localEulerAngles

				var_122_18.z = 0
				var_122_18.x = 0
				var_122_12.localEulerAngles = var_122_18
			end

			if arg_119_1.time_ >= var_122_13 + var_122_14 and arg_119_1.time_ < var_122_13 + var_122_14 + arg_122_0 then
				var_122_12.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_122_19 = manager.ui.mainCamera.transform.position - var_122_12.position

				var_122_12.forward = Vector3.New(var_122_19.x, var_122_19.y, var_122_19.z)

				local var_122_20 = var_122_12.localEulerAngles

				var_122_20.z = 0
				var_122_20.x = 0
				var_122_12.localEulerAngles = var_122_20
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_21 = 0.466666666666667
			local var_122_22 = 0.25

			if var_122_21 < arg_119_1.time_ and arg_119_1.time_ <= var_122_21 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_23 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_23:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_24 = arg_119_1:FormatText(StoryNameCfg[42].name)

				arg_119_1.leftNameTxt_.text = var_122_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_25 = arg_119_1:GetWordFromCfg(411191029)
				local var_122_26 = arg_119_1:FormatText(var_122_25.content)

				arg_119_1.text_.text = var_122_26

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_27 = 10
				local var_122_28 = utf8.len(var_122_26)
				local var_122_29 = var_122_27 <= 0 and var_122_22 or var_122_22 * (var_122_28 / var_122_27)

				if var_122_29 > 0 and var_122_22 < var_122_29 then
					arg_119_1.talkMaxDuration = var_122_29
					var_122_21 = var_122_21 + 0.3

					if var_122_29 + var_122_21 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_29 + var_122_21
					end
				end

				arg_119_1.text_.text = var_122_26
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191029", "story_v_out_411191.awb") ~= 0 then
					local var_122_30 = manager.audio:GetVoiceLength("story_v_out_411191", "411191029", "story_v_out_411191.awb") / 1000

					if var_122_30 + var_122_21 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_30 + var_122_21
					end

					if var_122_25.prefab_name ~= "" and arg_119_1.actors_[var_122_25.prefab_name] ~= nil then
						local var_122_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_25.prefab_name].transform, "story_v_out_411191", "411191029", "story_v_out_411191.awb")

						arg_119_1:RecordAudio("411191029", var_122_31)
						arg_119_1:RecordAudio("411191029", var_122_31)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_411191", "411191029", "story_v_out_411191.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_411191", "411191029", "story_v_out_411191.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_32 = var_122_21 + 0.3
			local var_122_33 = math.max(var_122_22, arg_119_1.talkMaxDuration)

			if var_122_32 <= arg_119_1.time_ and arg_119_1.time_ < var_122_32 + var_122_33 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_32) / var_122_33

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_32 + var_122_33 and arg_119_1.time_ < var_122_32 + var_122_33 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play411191030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 411191030
		arg_125_1.duration_ = 8

		local var_125_0 = {
			zh = 8,
			ja = 4.9
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
				arg_125_0:Play411191031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["4010ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect4010ui_story == nil then
				arg_125_1.var_.characterEffect4010ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect4010ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_125_1.var_.characterEffect4010ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect4010ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_125_1.var_.characterEffect4010ui_story.fillRatio = var_128_5
			end

			local var_128_6 = arg_125_1.actors_["1095ui_story"]
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1095ui_story == nil then
				arg_125_1.var_.characterEffect1095ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_8 = 0.200000002980232

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 and not isNil(var_128_6) then
				local var_128_9 = (arg_125_1.time_ - var_128_7) / var_128_8

				if arg_125_1.var_.characterEffect1095ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1095ui_story then
				arg_125_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_128_10 = 0
			local var_128_11 = 0.9

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_12 = arg_125_1:FormatText(StoryNameCfg[471].name)

				arg_125_1.leftNameTxt_.text = var_128_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_13 = arg_125_1:GetWordFromCfg(411191030)
				local var_128_14 = arg_125_1:FormatText(var_128_13.content)

				arg_125_1.text_.text = var_128_14

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_15 = 36
				local var_128_16 = utf8.len(var_128_14)
				local var_128_17 = var_128_15 <= 0 and var_128_11 or var_128_11 * (var_128_16 / var_128_15)

				if var_128_17 > 0 and var_128_11 < var_128_17 then
					arg_125_1.talkMaxDuration = var_128_17

					if var_128_17 + var_128_10 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_17 + var_128_10
					end
				end

				arg_125_1.text_.text = var_128_14
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191030", "story_v_out_411191.awb") ~= 0 then
					local var_128_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191030", "story_v_out_411191.awb") / 1000

					if var_128_18 + var_128_10 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_18 + var_128_10
					end

					if var_128_13.prefab_name ~= "" and arg_125_1.actors_[var_128_13.prefab_name] ~= nil then
						local var_128_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_13.prefab_name].transform, "story_v_out_411191", "411191030", "story_v_out_411191.awb")

						arg_125_1:RecordAudio("411191030", var_128_19)
						arg_125_1:RecordAudio("411191030", var_128_19)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_411191", "411191030", "story_v_out_411191.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_411191", "411191030", "story_v_out_411191.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_20 = math.max(var_128_11, arg_125_1.talkMaxDuration)

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_20 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_10) / var_128_20

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_10 + var_128_20 and arg_125_1.time_ < var_128_10 + var_128_20 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play411191031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 411191031
		arg_129_1.duration_ = 2.2

		local var_129_0 = {
			zh = 1.466,
			ja = 2.2
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
				arg_129_0:Play411191032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["4010ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect4010ui_story == nil then
				arg_129_1.var_.characterEffect4010ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect4010ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect4010ui_story then
				arg_129_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_132_4 = arg_129_1.actors_["1095ui_story"]
			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect1095ui_story == nil then
				arg_129_1.var_.characterEffect1095ui_story = var_132_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_6 = 0.200000002980232

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_6 and not isNil(var_132_4) then
				local var_132_7 = (arg_129_1.time_ - var_132_5) / var_132_6

				if arg_129_1.var_.characterEffect1095ui_story and not isNil(var_132_4) then
					local var_132_8 = Mathf.Lerp(0, 0.5, var_132_7)

					arg_129_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1095ui_story.fillRatio = var_132_8
				end
			end

			if arg_129_1.time_ >= var_132_5 + var_132_6 and arg_129_1.time_ < var_132_5 + var_132_6 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect1095ui_story then
				local var_132_9 = 0.5

				arg_129_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1095ui_story.fillRatio = var_132_9
			end

			local var_132_10 = 0
			local var_132_11 = 0.125

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_12 = arg_129_1:FormatText(StoryNameCfg[42].name)

				arg_129_1.leftNameTxt_.text = var_132_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_13 = arg_129_1:GetWordFromCfg(411191031)
				local var_132_14 = arg_129_1:FormatText(var_132_13.content)

				arg_129_1.text_.text = var_132_14

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_15 = 5
				local var_132_16 = utf8.len(var_132_14)
				local var_132_17 = var_132_15 <= 0 and var_132_11 or var_132_11 * (var_132_16 / var_132_15)

				if var_132_17 > 0 and var_132_11 < var_132_17 then
					arg_129_1.talkMaxDuration = var_132_17

					if var_132_17 + var_132_10 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_17 + var_132_10
					end
				end

				arg_129_1.text_.text = var_132_14
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191031", "story_v_out_411191.awb") ~= 0 then
					local var_132_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191031", "story_v_out_411191.awb") / 1000

					if var_132_18 + var_132_10 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_18 + var_132_10
					end

					if var_132_13.prefab_name ~= "" and arg_129_1.actors_[var_132_13.prefab_name] ~= nil then
						local var_132_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_13.prefab_name].transform, "story_v_out_411191", "411191031", "story_v_out_411191.awb")

						arg_129_1:RecordAudio("411191031", var_132_19)
						arg_129_1:RecordAudio("411191031", var_132_19)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_411191", "411191031", "story_v_out_411191.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_411191", "411191031", "story_v_out_411191.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_20 = math.max(var_132_11, arg_129_1.talkMaxDuration)

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_20 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_10) / var_132_20

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_10 + var_132_20 and arg_129_1.time_ < var_132_10 + var_132_20 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play411191032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 411191032
		arg_133_1.duration_ = 10.7

		local var_133_0 = {
			zh = 9.9,
			ja = 10.7
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
				arg_133_0:Play411191033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["4010ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect4010ui_story == nil then
				arg_133_1.var_.characterEffect4010ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect4010ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_133_1.var_.characterEffect4010ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect4010ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_133_1.var_.characterEffect4010ui_story.fillRatio = var_136_5
			end

			local var_136_6 = arg_133_1.actors_["1095ui_story"]
			local var_136_7 = 0

			if var_136_7 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1095ui_story == nil then
				arg_133_1.var_.characterEffect1095ui_story = var_136_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_8 = 0.200000002980232

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_8 and not isNil(var_136_6) then
				local var_136_9 = (arg_133_1.time_ - var_136_7) / var_136_8

				if arg_133_1.var_.characterEffect1095ui_story and not isNil(var_136_6) then
					arg_133_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_7 + var_136_8 and arg_133_1.time_ < var_136_7 + var_136_8 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1095ui_story then
				arg_133_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_136_11 = 0
			local var_136_12 = 1.05

			if var_136_11 < arg_133_1.time_ and arg_133_1.time_ <= var_136_11 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_13 = arg_133_1:FormatText(StoryNameCfg[471].name)

				arg_133_1.leftNameTxt_.text = var_136_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_14 = arg_133_1:GetWordFromCfg(411191032)
				local var_136_15 = arg_133_1:FormatText(var_136_14.content)

				arg_133_1.text_.text = var_136_15

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_16 = 42
				local var_136_17 = utf8.len(var_136_15)
				local var_136_18 = var_136_16 <= 0 and var_136_12 or var_136_12 * (var_136_17 / var_136_16)

				if var_136_18 > 0 and var_136_12 < var_136_18 then
					arg_133_1.talkMaxDuration = var_136_18

					if var_136_18 + var_136_11 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_18 + var_136_11
					end
				end

				arg_133_1.text_.text = var_136_15
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191032", "story_v_out_411191.awb") ~= 0 then
					local var_136_19 = manager.audio:GetVoiceLength("story_v_out_411191", "411191032", "story_v_out_411191.awb") / 1000

					if var_136_19 + var_136_11 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_19 + var_136_11
					end

					if var_136_14.prefab_name ~= "" and arg_133_1.actors_[var_136_14.prefab_name] ~= nil then
						local var_136_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_14.prefab_name].transform, "story_v_out_411191", "411191032", "story_v_out_411191.awb")

						arg_133_1:RecordAudio("411191032", var_136_20)
						arg_133_1:RecordAudio("411191032", var_136_20)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_411191", "411191032", "story_v_out_411191.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_411191", "411191032", "story_v_out_411191.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_21 = math.max(var_136_12, arg_133_1.talkMaxDuration)

			if var_136_11 <= arg_133_1.time_ and arg_133_1.time_ < var_136_11 + var_136_21 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_11) / var_136_21

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_11 + var_136_21 and arg_133_1.time_ < var_136_11 + var_136_21 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play411191033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 411191033
		arg_137_1.duration_ = 11.37

		local var_137_0 = {
			zh = 7.2,
			ja = 11.366
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
				arg_137_0:Play411191034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.8

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[471].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(411191033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 32
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191033", "story_v_out_411191.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_411191", "411191033", "story_v_out_411191.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_411191", "411191033", "story_v_out_411191.awb")

						arg_137_1:RecordAudio("411191033", var_140_9)
						arg_137_1:RecordAudio("411191033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_411191", "411191033", "story_v_out_411191.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_411191", "411191033", "story_v_out_411191.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play411191034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 411191034
		arg_141_1.duration_ = 2.5

		local var_141_0 = {
			zh = 2.5,
			ja = 1.733
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
				arg_141_0:Play411191035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["4010ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect4010ui_story == nil then
				arg_141_1.var_.characterEffect4010ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect4010ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect4010ui_story then
				arg_141_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_144_4 = arg_141_1.actors_["1095ui_story"]
			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1095ui_story == nil then
				arg_141_1.var_.characterEffect1095ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_6 = 0.200000002980232

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_6 and not isNil(var_144_4) then
				local var_144_7 = (arg_141_1.time_ - var_144_5) / var_144_6

				if arg_141_1.var_.characterEffect1095ui_story and not isNil(var_144_4) then
					local var_144_8 = Mathf.Lerp(0, 0.5, var_144_7)

					arg_141_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1095ui_story.fillRatio = var_144_8
				end
			end

			if arg_141_1.time_ >= var_144_5 + var_144_6 and arg_141_1.time_ < var_144_5 + var_144_6 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1095ui_story then
				local var_144_9 = 0.5

				arg_141_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1095ui_story.fillRatio = var_144_9
			end

			local var_144_10 = 0
			local var_144_11 = 0.25

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_12 = arg_141_1:FormatText(StoryNameCfg[42].name)

				arg_141_1.leftNameTxt_.text = var_144_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_13 = arg_141_1:GetWordFromCfg(411191034)
				local var_144_14 = arg_141_1:FormatText(var_144_13.content)

				arg_141_1.text_.text = var_144_14

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_15 = 10
				local var_144_16 = utf8.len(var_144_14)
				local var_144_17 = var_144_15 <= 0 and var_144_11 or var_144_11 * (var_144_16 / var_144_15)

				if var_144_17 > 0 and var_144_11 < var_144_17 then
					arg_141_1.talkMaxDuration = var_144_17

					if var_144_17 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_10
					end
				end

				arg_141_1.text_.text = var_144_14
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191034", "story_v_out_411191.awb") ~= 0 then
					local var_144_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191034", "story_v_out_411191.awb") / 1000

					if var_144_18 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_18 + var_144_10
					end

					if var_144_13.prefab_name ~= "" and arg_141_1.actors_[var_144_13.prefab_name] ~= nil then
						local var_144_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_13.prefab_name].transform, "story_v_out_411191", "411191034", "story_v_out_411191.awb")

						arg_141_1:RecordAudio("411191034", var_144_19)
						arg_141_1:RecordAudio("411191034", var_144_19)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_411191", "411191034", "story_v_out_411191.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_411191", "411191034", "story_v_out_411191.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_20 = math.max(var_144_11, arg_141_1.talkMaxDuration)

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_20 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_10) / var_144_20

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_10 + var_144_20 and arg_141_1.time_ < var_144_10 + var_144_20 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play411191035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 411191035
		arg_145_1.duration_ = 6.57

		local var_145_0 = {
			zh = 3.133,
			ja = 6.566
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
				arg_145_0:Play411191036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["4010ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect4010ui_story == nil then
				arg_145_1.var_.characterEffect4010ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect4010ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_145_1.var_.characterEffect4010ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect4010ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_145_1.var_.characterEffect4010ui_story.fillRatio = var_148_5
			end

			local var_148_6 = arg_145_1.actors_["1095ui_story"]
			local var_148_7 = 0

			if var_148_7 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1095ui_story == nil then
				arg_145_1.var_.characterEffect1095ui_story = var_148_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_8 = 0.200000002980232

			if var_148_7 <= arg_145_1.time_ and arg_145_1.time_ < var_148_7 + var_148_8 and not isNil(var_148_6) then
				local var_148_9 = (arg_145_1.time_ - var_148_7) / var_148_8

				if arg_145_1.var_.characterEffect1095ui_story and not isNil(var_148_6) then
					arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_7 + var_148_8 and arg_145_1.time_ < var_148_7 + var_148_8 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1095ui_story then
				arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_148_10 = 0
			local var_148_11 = 0.4

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_12 = arg_145_1:FormatText(StoryNameCfg[471].name)

				arg_145_1.leftNameTxt_.text = var_148_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_13 = arg_145_1:GetWordFromCfg(411191035)
				local var_148_14 = arg_145_1:FormatText(var_148_13.content)

				arg_145_1.text_.text = var_148_14

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_15 = 16
				local var_148_16 = utf8.len(var_148_14)
				local var_148_17 = var_148_15 <= 0 and var_148_11 or var_148_11 * (var_148_16 / var_148_15)

				if var_148_17 > 0 and var_148_11 < var_148_17 then
					arg_145_1.talkMaxDuration = var_148_17

					if var_148_17 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_17 + var_148_10
					end
				end

				arg_145_1.text_.text = var_148_14
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191035", "story_v_out_411191.awb") ~= 0 then
					local var_148_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191035", "story_v_out_411191.awb") / 1000

					if var_148_18 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_18 + var_148_10
					end

					if var_148_13.prefab_name ~= "" and arg_145_1.actors_[var_148_13.prefab_name] ~= nil then
						local var_148_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_13.prefab_name].transform, "story_v_out_411191", "411191035", "story_v_out_411191.awb")

						arg_145_1:RecordAudio("411191035", var_148_19)
						arg_145_1:RecordAudio("411191035", var_148_19)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_411191", "411191035", "story_v_out_411191.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_411191", "411191035", "story_v_out_411191.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_20 = math.max(var_148_11, arg_145_1.talkMaxDuration)

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_20 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_10) / var_148_20

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_10 + var_148_20 and arg_145_1.time_ < var_148_10 + var_148_20 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play411191036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 411191036
		arg_149_1.duration_ = 7.83

		local var_149_0 = {
			zh = 7.833,
			ja = 7.7
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
				arg_149_0:Play411191037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["4010ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect4010ui_story == nil then
				arg_149_1.var_.characterEffect4010ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect4010ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect4010ui_story then
				arg_149_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["1095ui_story"]
			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1095ui_story == nil then
				arg_149_1.var_.characterEffect1095ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.200000002980232

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 and not isNil(var_152_4) then
				local var_152_7 = (arg_149_1.time_ - var_152_5) / var_152_6

				if arg_149_1.var_.characterEffect1095ui_story and not isNil(var_152_4) then
					local var_152_8 = Mathf.Lerp(0, 0.5, var_152_7)

					arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1095ui_story.fillRatio = var_152_8
				end
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1095ui_story then
				local var_152_9 = 0.5

				arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1095ui_story.fillRatio = var_152_9
			end

			local var_152_10 = 0
			local var_152_11 = 0.775

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_12 = arg_149_1:FormatText(StoryNameCfg[42].name)

				arg_149_1.leftNameTxt_.text = var_152_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_13 = arg_149_1:GetWordFromCfg(411191036)
				local var_152_14 = arg_149_1:FormatText(var_152_13.content)

				arg_149_1.text_.text = var_152_14

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_15 = 31
				local var_152_16 = utf8.len(var_152_14)
				local var_152_17 = var_152_15 <= 0 and var_152_11 or var_152_11 * (var_152_16 / var_152_15)

				if var_152_17 > 0 and var_152_11 < var_152_17 then
					arg_149_1.talkMaxDuration = var_152_17

					if var_152_17 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_17 + var_152_10
					end
				end

				arg_149_1.text_.text = var_152_14
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191036", "story_v_out_411191.awb") ~= 0 then
					local var_152_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191036", "story_v_out_411191.awb") / 1000

					if var_152_18 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_18 + var_152_10
					end

					if var_152_13.prefab_name ~= "" and arg_149_1.actors_[var_152_13.prefab_name] ~= nil then
						local var_152_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_13.prefab_name].transform, "story_v_out_411191", "411191036", "story_v_out_411191.awb")

						arg_149_1:RecordAudio("411191036", var_152_19)
						arg_149_1:RecordAudio("411191036", var_152_19)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_411191", "411191036", "story_v_out_411191.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_411191", "411191036", "story_v_out_411191.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_20 = math.max(var_152_11, arg_149_1.talkMaxDuration)

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_20 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_10) / var_152_20

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_10 + var_152_20 and arg_149_1.time_ < var_152_10 + var_152_20 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play411191037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 411191037
		arg_153_1.duration_ = 9.83

		local var_153_0 = {
			zh = 7.5,
			ja = 9.833
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
				arg_153_0:Play411191038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["4010ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect4010ui_story == nil then
				arg_153_1.var_.characterEffect4010ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect4010ui_story and not isNil(var_156_0) then
					local var_156_4 = Mathf.Lerp(0, 0.5, var_156_3)

					arg_153_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_153_1.var_.characterEffect4010ui_story.fillRatio = var_156_4
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect4010ui_story then
				local var_156_5 = 0.5

				arg_153_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_153_1.var_.characterEffect4010ui_story.fillRatio = var_156_5
			end

			local var_156_6 = arg_153_1.actors_["1095ui_story"]
			local var_156_7 = 0

			if var_156_7 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect1095ui_story == nil then
				arg_153_1.var_.characterEffect1095ui_story = var_156_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_8 = 0.200000002980232

			if var_156_7 <= arg_153_1.time_ and arg_153_1.time_ < var_156_7 + var_156_8 and not isNil(var_156_6) then
				local var_156_9 = (arg_153_1.time_ - var_156_7) / var_156_8

				if arg_153_1.var_.characterEffect1095ui_story and not isNil(var_156_6) then
					arg_153_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_7 + var_156_8 and arg_153_1.time_ < var_156_7 + var_156_8 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect1095ui_story then
				arg_153_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_156_10 = 0
			local var_156_11 = 0.775

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_12 = arg_153_1:FormatText(StoryNameCfg[471].name)

				arg_153_1.leftNameTxt_.text = var_156_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_13 = arg_153_1:GetWordFromCfg(411191037)
				local var_156_14 = arg_153_1:FormatText(var_156_13.content)

				arg_153_1.text_.text = var_156_14

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_15 = 31
				local var_156_16 = utf8.len(var_156_14)
				local var_156_17 = var_156_15 <= 0 and var_156_11 or var_156_11 * (var_156_16 / var_156_15)

				if var_156_17 > 0 and var_156_11 < var_156_17 then
					arg_153_1.talkMaxDuration = var_156_17

					if var_156_17 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_17 + var_156_10
					end
				end

				arg_153_1.text_.text = var_156_14
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191037", "story_v_out_411191.awb") ~= 0 then
					local var_156_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191037", "story_v_out_411191.awb") / 1000

					if var_156_18 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_10
					end

					if var_156_13.prefab_name ~= "" and arg_153_1.actors_[var_156_13.prefab_name] ~= nil then
						local var_156_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_13.prefab_name].transform, "story_v_out_411191", "411191037", "story_v_out_411191.awb")

						arg_153_1:RecordAudio("411191037", var_156_19)
						arg_153_1:RecordAudio("411191037", var_156_19)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_411191", "411191037", "story_v_out_411191.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_411191", "411191037", "story_v_out_411191.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_20 = math.max(var_156_11, arg_153_1.talkMaxDuration)

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_20 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_10) / var_156_20

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_10 + var_156_20 and arg_153_1.time_ < var_156_10 + var_156_20 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play411191038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 411191038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play411191039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_1")
			end

			local var_160_1 = arg_157_1.actors_["1095ui_story"]
			local var_160_2 = 0

			if var_160_2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1095ui_story == nil then
				arg_157_1.var_.characterEffect1095ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_3 = 0.200000002980232

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_3 and not isNil(var_160_1) then
				local var_160_4 = (arg_157_1.time_ - var_160_2) / var_160_3

				if arg_157_1.var_.characterEffect1095ui_story and not isNil(var_160_1) then
					local var_160_5 = Mathf.Lerp(0, 0.5, var_160_4)

					arg_157_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1095ui_story.fillRatio = var_160_5
				end
			end

			if arg_157_1.time_ >= var_160_2 + var_160_3 and arg_157_1.time_ < var_160_2 + var_160_3 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1095ui_story then
				local var_160_6 = 0.5

				arg_157_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1095ui_story.fillRatio = var_160_6
			end

			local var_160_7 = 0
			local var_160_8 = 0.4

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_9 = arg_157_1:GetWordFromCfg(411191038)
				local var_160_10 = arg_157_1:FormatText(var_160_9.content)

				arg_157_1.text_.text = var_160_10

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 16
				local var_160_12 = utf8.len(var_160_10)
				local var_160_13 = var_160_11 <= 0 and var_160_8 or var_160_8 * (var_160_12 / var_160_11)

				if var_160_13 > 0 and var_160_8 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_7 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_7
					end
				end

				arg_157_1.text_.text = var_160_10
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_14 = math.max(var_160_8, arg_157_1.talkMaxDuration)

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_14 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_7) / var_160_14

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_7 + var_160_14 and arg_157_1.time_ < var_160_7 + var_160_14 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play411191039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 411191039
		arg_161_1.duration_ = 5.5

		local var_161_0 = {
			zh = 5.2,
			ja = 5.5
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play411191040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1095ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1095ui_story == nil then
				arg_161_1.var_.characterEffect1095ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1095ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1095ui_story then
				arg_161_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_164_4 = 0
			local var_164_5 = 0.55

			if var_164_4 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_6 = arg_161_1:FormatText(StoryNameCfg[471].name)

				arg_161_1.leftNameTxt_.text = var_164_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_7 = arg_161_1:GetWordFromCfg(411191039)
				local var_164_8 = arg_161_1:FormatText(var_164_7.content)

				arg_161_1.text_.text = var_164_8

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 22
				local var_164_10 = utf8.len(var_164_8)
				local var_164_11 = var_164_9 <= 0 and var_164_5 or var_164_5 * (var_164_10 / var_164_9)

				if var_164_11 > 0 and var_164_5 < var_164_11 then
					arg_161_1.talkMaxDuration = var_164_11

					if var_164_11 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_8
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191039", "story_v_out_411191.awb") ~= 0 then
					local var_164_12 = manager.audio:GetVoiceLength("story_v_out_411191", "411191039", "story_v_out_411191.awb") / 1000

					if var_164_12 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_12 + var_164_4
					end

					if var_164_7.prefab_name ~= "" and arg_161_1.actors_[var_164_7.prefab_name] ~= nil then
						local var_164_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_7.prefab_name].transform, "story_v_out_411191", "411191039", "story_v_out_411191.awb")

						arg_161_1:RecordAudio("411191039", var_164_13)
						arg_161_1:RecordAudio("411191039", var_164_13)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_411191", "411191039", "story_v_out_411191.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_411191", "411191039", "story_v_out_411191.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_14 and arg_161_1.time_ < var_164_4 + var_164_14 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play411191040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 411191040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play411191041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1095ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1095ui_story == nil then
				arg_165_1.var_.characterEffect1095ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1095ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1095ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1095ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1095ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 0.775

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(411191040)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 31
				local var_168_11 = utf8.len(var_168_9)
				local var_168_12 = var_168_10 <= 0 and var_168_7 or var_168_7 * (var_168_11 / var_168_10)

				if var_168_12 > 0 and var_168_7 < var_168_12 then
					arg_165_1.talkMaxDuration = var_168_12

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_13 and arg_165_1.time_ < var_168_6 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play411191041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 411191041
		arg_169_1.duration_ = 4.37

		local var_169_0 = {
			zh = 1.999999999999,
			ja = 4.366
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
				arg_169_0:Play411191042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["4010ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect4010ui_story == nil then
				arg_169_1.var_.characterEffect4010ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect4010ui_story and not isNil(var_172_0) then
					arg_169_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect4010ui_story then
				arg_169_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_172_4 = 0

			if var_172_4 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			local var_172_5 = 0
			local var_172_6 = 0.1

			if var_172_5 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_7 = arg_169_1:FormatText(StoryNameCfg[42].name)

				arg_169_1.leftNameTxt_.text = var_172_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(411191041)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 4
				local var_172_11 = utf8.len(var_172_9)
				local var_172_12 = var_172_10 <= 0 and var_172_6 or var_172_6 * (var_172_11 / var_172_10)

				if var_172_12 > 0 and var_172_6 < var_172_12 then
					arg_169_1.talkMaxDuration = var_172_12

					if var_172_12 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191041", "story_v_out_411191.awb") ~= 0 then
					local var_172_13 = manager.audio:GetVoiceLength("story_v_out_411191", "411191041", "story_v_out_411191.awb") / 1000

					if var_172_13 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_5
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_411191", "411191041", "story_v_out_411191.awb")

						arg_169_1:RecordAudio("411191041", var_172_14)
						arg_169_1:RecordAudio("411191041", var_172_14)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_411191", "411191041", "story_v_out_411191.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_411191", "411191041", "story_v_out_411191.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_15 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_15 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_5) / var_172_15

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_5 + var_172_15 and arg_169_1.time_ < var_172_5 + var_172_15 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play411191042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 411191042
		arg_173_1.duration_ = 7.67

		local var_173_0 = {
			zh = 7.666,
			ja = 5.5
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play411191043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["4010ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect4010ui_story == nil then
				arg_173_1.var_.characterEffect4010ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect4010ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_173_1.var_.characterEffect4010ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect4010ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_173_1.var_.characterEffect4010ui_story.fillRatio = var_176_5
			end

			local var_176_6 = arg_173_1.actors_["1095ui_story"]
			local var_176_7 = 0

			if var_176_7 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1095ui_story == nil then
				arg_173_1.var_.characterEffect1095ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_8 = 0.200000002980232

			if var_176_7 <= arg_173_1.time_ and arg_173_1.time_ < var_176_7 + var_176_8 and not isNil(var_176_6) then
				local var_176_9 = (arg_173_1.time_ - var_176_7) / var_176_8

				if arg_173_1.var_.characterEffect1095ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_7 + var_176_8 and arg_173_1.time_ < var_176_7 + var_176_8 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1095ui_story then
				arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_176_10 = 0
			local var_176_11 = 0.75

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_12 = arg_173_1:FormatText(StoryNameCfg[471].name)

				arg_173_1.leftNameTxt_.text = var_176_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_13 = arg_173_1:GetWordFromCfg(411191042)
				local var_176_14 = arg_173_1:FormatText(var_176_13.content)

				arg_173_1.text_.text = var_176_14

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_15 = 30
				local var_176_16 = utf8.len(var_176_14)
				local var_176_17 = var_176_15 <= 0 and var_176_11 or var_176_11 * (var_176_16 / var_176_15)

				if var_176_17 > 0 and var_176_11 < var_176_17 then
					arg_173_1.talkMaxDuration = var_176_17

					if var_176_17 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_17 + var_176_10
					end
				end

				arg_173_1.text_.text = var_176_14
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191042", "story_v_out_411191.awb") ~= 0 then
					local var_176_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191042", "story_v_out_411191.awb") / 1000

					if var_176_18 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_18 + var_176_10
					end

					if var_176_13.prefab_name ~= "" and arg_173_1.actors_[var_176_13.prefab_name] ~= nil then
						local var_176_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_13.prefab_name].transform, "story_v_out_411191", "411191042", "story_v_out_411191.awb")

						arg_173_1:RecordAudio("411191042", var_176_19)
						arg_173_1:RecordAudio("411191042", var_176_19)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_411191", "411191042", "story_v_out_411191.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_411191", "411191042", "story_v_out_411191.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_20 = math.max(var_176_11, arg_173_1.talkMaxDuration)

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_20 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_10) / var_176_20

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_10 + var_176_20 and arg_173_1.time_ < var_176_10 + var_176_20 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play411191043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 411191043
		arg_177_1.duration_ = 8.5

		local var_177_0 = {
			zh = 6.533,
			ja = 8.5
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
				arg_177_0:Play411191044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["4010ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect4010ui_story == nil then
				arg_177_1.var_.characterEffect4010ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect4010ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect4010ui_story then
				arg_177_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["1095ui_story"]
			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1095ui_story == nil then
				arg_177_1.var_.characterEffect1095ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_6 = 0.200000002980232

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_6 and not isNil(var_180_4) then
				local var_180_7 = (arg_177_1.time_ - var_180_5) / var_180_6

				if arg_177_1.var_.characterEffect1095ui_story and not isNil(var_180_4) then
					local var_180_8 = Mathf.Lerp(0, 0.5, var_180_7)

					arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1095ui_story.fillRatio = var_180_8
				end
			end

			if arg_177_1.time_ >= var_180_5 + var_180_6 and arg_177_1.time_ < var_180_5 + var_180_6 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1095ui_story then
				local var_180_9 = 0.5

				arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1095ui_story.fillRatio = var_180_9
			end

			local var_180_10 = 0
			local var_180_11 = 0.775

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_12 = arg_177_1:FormatText(StoryNameCfg[42].name)

				arg_177_1.leftNameTxt_.text = var_180_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_13 = arg_177_1:GetWordFromCfg(411191043)
				local var_180_14 = arg_177_1:FormatText(var_180_13.content)

				arg_177_1.text_.text = var_180_14

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_15 = 31
				local var_180_16 = utf8.len(var_180_14)
				local var_180_17 = var_180_15 <= 0 and var_180_11 or var_180_11 * (var_180_16 / var_180_15)

				if var_180_17 > 0 and var_180_11 < var_180_17 then
					arg_177_1.talkMaxDuration = var_180_17

					if var_180_17 + var_180_10 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_17 + var_180_10
					end
				end

				arg_177_1.text_.text = var_180_14
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191043", "story_v_out_411191.awb") ~= 0 then
					local var_180_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191043", "story_v_out_411191.awb") / 1000

					if var_180_18 + var_180_10 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_18 + var_180_10
					end

					if var_180_13.prefab_name ~= "" and arg_177_1.actors_[var_180_13.prefab_name] ~= nil then
						local var_180_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_13.prefab_name].transform, "story_v_out_411191", "411191043", "story_v_out_411191.awb")

						arg_177_1:RecordAudio("411191043", var_180_19)
						arg_177_1:RecordAudio("411191043", var_180_19)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_411191", "411191043", "story_v_out_411191.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_411191", "411191043", "story_v_out_411191.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_20 = math.max(var_180_11, arg_177_1.talkMaxDuration)

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_20 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_10) / var_180_20

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_10 + var_180_20 and arg_177_1.time_ < var_180_10 + var_180_20 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play411191044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 411191044
		arg_181_1.duration_ = 2

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play411191045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["4010ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect4010ui_story == nil then
				arg_181_1.var_.characterEffect4010ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect4010ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_181_1.var_.characterEffect4010ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect4010ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_181_1.var_.characterEffect4010ui_story.fillRatio = var_184_5
			end

			local var_184_6 = arg_181_1.actors_["1095ui_story"]
			local var_184_7 = 0

			if var_184_7 < arg_181_1.time_ and arg_181_1.time_ <= var_184_7 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect1095ui_story == nil then
				arg_181_1.var_.characterEffect1095ui_story = var_184_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_8 = 0.200000002980232

			if var_184_7 <= arg_181_1.time_ and arg_181_1.time_ < var_184_7 + var_184_8 and not isNil(var_184_6) then
				local var_184_9 = (arg_181_1.time_ - var_184_7) / var_184_8

				if arg_181_1.var_.characterEffect1095ui_story and not isNil(var_184_6) then
					arg_181_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_7 + var_184_8 and arg_181_1.time_ < var_184_7 + var_184_8 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect1095ui_story then
				arg_181_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_184_11 = 0
			local var_184_12 = 0.15

			if var_184_11 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_13 = arg_181_1:FormatText(StoryNameCfg[471].name)

				arg_181_1.leftNameTxt_.text = var_184_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_14 = arg_181_1:GetWordFromCfg(411191044)
				local var_184_15 = arg_181_1:FormatText(var_184_14.content)

				arg_181_1.text_.text = var_184_15

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_16 = 6
				local var_184_17 = utf8.len(var_184_15)
				local var_184_18 = var_184_16 <= 0 and var_184_12 or var_184_12 * (var_184_17 / var_184_16)

				if var_184_18 > 0 and var_184_12 < var_184_18 then
					arg_181_1.talkMaxDuration = var_184_18

					if var_184_18 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_18 + var_184_11
					end
				end

				arg_181_1.text_.text = var_184_15
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191044", "story_v_out_411191.awb") ~= 0 then
					local var_184_19 = manager.audio:GetVoiceLength("story_v_out_411191", "411191044", "story_v_out_411191.awb") / 1000

					if var_184_19 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_19 + var_184_11
					end

					if var_184_14.prefab_name ~= "" and arg_181_1.actors_[var_184_14.prefab_name] ~= nil then
						local var_184_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_14.prefab_name].transform, "story_v_out_411191", "411191044", "story_v_out_411191.awb")

						arg_181_1:RecordAudio("411191044", var_184_20)
						arg_181_1:RecordAudio("411191044", var_184_20)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_411191", "411191044", "story_v_out_411191.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_411191", "411191044", "story_v_out_411191.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_21 = math.max(var_184_12, arg_181_1.talkMaxDuration)

			if var_184_11 <= arg_181_1.time_ and arg_181_1.time_ < var_184_11 + var_184_21 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_11) / var_184_21

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_11 + var_184_21 and arg_181_1.time_ < var_184_11 + var_184_21 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play411191045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 411191045
		arg_185_1.duration_ = 5.87

		local var_185_0 = {
			zh = 5.866,
			ja = 3.566
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
				arg_185_0:Play411191046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["4010ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect4010ui_story == nil then
				arg_185_1.var_.characterEffect4010ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect4010ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect4010ui_story then
				arg_185_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_188_4 = arg_185_1.actors_["1095ui_story"]
			local var_188_5 = 0

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 and not isNil(var_188_4) and arg_185_1.var_.characterEffect1095ui_story == nil then
				arg_185_1.var_.characterEffect1095ui_story = var_188_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_6 = 0.200000002980232

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_6 and not isNil(var_188_4) then
				local var_188_7 = (arg_185_1.time_ - var_188_5) / var_188_6

				if arg_185_1.var_.characterEffect1095ui_story and not isNil(var_188_4) then
					local var_188_8 = Mathf.Lerp(0, 0.5, var_188_7)

					arg_185_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1095ui_story.fillRatio = var_188_8
				end
			end

			if arg_185_1.time_ >= var_188_5 + var_188_6 and arg_185_1.time_ < var_188_5 + var_188_6 + arg_188_0 and not isNil(var_188_4) and arg_185_1.var_.characterEffect1095ui_story then
				local var_188_9 = 0.5

				arg_185_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1095ui_story.fillRatio = var_188_9
			end

			local var_188_10 = 0
			local var_188_11 = 0.675

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_12 = arg_185_1:FormatText(StoryNameCfg[42].name)

				arg_185_1.leftNameTxt_.text = var_188_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_13 = arg_185_1:GetWordFromCfg(411191045)
				local var_188_14 = arg_185_1:FormatText(var_188_13.content)

				arg_185_1.text_.text = var_188_14

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_15 = 27
				local var_188_16 = utf8.len(var_188_14)
				local var_188_17 = var_188_15 <= 0 and var_188_11 or var_188_11 * (var_188_16 / var_188_15)

				if var_188_17 > 0 and var_188_11 < var_188_17 then
					arg_185_1.talkMaxDuration = var_188_17

					if var_188_17 + var_188_10 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_17 + var_188_10
					end
				end

				arg_185_1.text_.text = var_188_14
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191045", "story_v_out_411191.awb") ~= 0 then
					local var_188_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191045", "story_v_out_411191.awb") / 1000

					if var_188_18 + var_188_10 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_18 + var_188_10
					end

					if var_188_13.prefab_name ~= "" and arg_185_1.actors_[var_188_13.prefab_name] ~= nil then
						local var_188_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_13.prefab_name].transform, "story_v_out_411191", "411191045", "story_v_out_411191.awb")

						arg_185_1:RecordAudio("411191045", var_188_19)
						arg_185_1:RecordAudio("411191045", var_188_19)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_411191", "411191045", "story_v_out_411191.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_411191", "411191045", "story_v_out_411191.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_20 = math.max(var_188_11, arg_185_1.talkMaxDuration)

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_20 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_10) / var_188_20

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_10 + var_188_20 and arg_185_1.time_ < var_188_10 + var_188_20 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play411191046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 411191046
		arg_189_1.duration_ = 2.4

		local var_189_0 = {
			zh = 1.433,
			ja = 2.4
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
				arg_189_0:Play411191047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["4010ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect4010ui_story == nil then
				arg_189_1.var_.characterEffect4010ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect4010ui_story and not isNil(var_192_0) then
					local var_192_4 = Mathf.Lerp(0, 0.5, var_192_3)

					arg_189_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_189_1.var_.characterEffect4010ui_story.fillRatio = var_192_4
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect4010ui_story then
				local var_192_5 = 0.5

				arg_189_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_189_1.var_.characterEffect4010ui_story.fillRatio = var_192_5
			end

			local var_192_6 = arg_189_1.actors_["1095ui_story"]
			local var_192_7 = 0

			if var_192_7 < arg_189_1.time_ and arg_189_1.time_ <= var_192_7 + arg_192_0 and not isNil(var_192_6) and arg_189_1.var_.characterEffect1095ui_story == nil then
				arg_189_1.var_.characterEffect1095ui_story = var_192_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_8 = 0.200000002980232

			if var_192_7 <= arg_189_1.time_ and arg_189_1.time_ < var_192_7 + var_192_8 and not isNil(var_192_6) then
				local var_192_9 = (arg_189_1.time_ - var_192_7) / var_192_8

				if arg_189_1.var_.characterEffect1095ui_story and not isNil(var_192_6) then
					arg_189_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_7 + var_192_8 and arg_189_1.time_ < var_192_7 + var_192_8 + arg_192_0 and not isNil(var_192_6) and arg_189_1.var_.characterEffect1095ui_story then
				arg_189_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_192_10 = 0
			local var_192_11 = 0.175

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_12 = arg_189_1:FormatText(StoryNameCfg[471].name)

				arg_189_1.leftNameTxt_.text = var_192_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_13 = arg_189_1:GetWordFromCfg(411191046)
				local var_192_14 = arg_189_1:FormatText(var_192_13.content)

				arg_189_1.text_.text = var_192_14

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_15 = 7
				local var_192_16 = utf8.len(var_192_14)
				local var_192_17 = var_192_15 <= 0 and var_192_11 or var_192_11 * (var_192_16 / var_192_15)

				if var_192_17 > 0 and var_192_11 < var_192_17 then
					arg_189_1.talkMaxDuration = var_192_17

					if var_192_17 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_17 + var_192_10
					end
				end

				arg_189_1.text_.text = var_192_14
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191046", "story_v_out_411191.awb") ~= 0 then
					local var_192_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191046", "story_v_out_411191.awb") / 1000

					if var_192_18 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_18 + var_192_10
					end

					if var_192_13.prefab_name ~= "" and arg_189_1.actors_[var_192_13.prefab_name] ~= nil then
						local var_192_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_13.prefab_name].transform, "story_v_out_411191", "411191046", "story_v_out_411191.awb")

						arg_189_1:RecordAudio("411191046", var_192_19)
						arg_189_1:RecordAudio("411191046", var_192_19)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_411191", "411191046", "story_v_out_411191.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_411191", "411191046", "story_v_out_411191.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_20 = math.max(var_192_11, arg_189_1.talkMaxDuration)

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_20 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_10) / var_192_20

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_10 + var_192_20 and arg_189_1.time_ < var_192_10 + var_192_20 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play411191047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 411191047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play411191048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["4010ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos4010ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, 100, 0)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos4010ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, 100, 0)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["4010ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect4010ui_story == nil then
				arg_193_1.var_.characterEffect4010ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect4010ui_story and not isNil(var_196_9) then
					local var_196_13 = Mathf.Lerp(0, 0.5, var_196_12)

					arg_193_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_193_1.var_.characterEffect4010ui_story.fillRatio = var_196_13
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect4010ui_story then
				local var_196_14 = 0.5

				arg_193_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_193_1.var_.characterEffect4010ui_story.fillRatio = var_196_14
			end

			local var_196_15 = arg_193_1.actors_["1095ui_story"].transform
			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.var_.moveOldPos1095ui_story = var_196_15.localPosition
			end

			local var_196_17 = 0.001

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17
				local var_196_19 = Vector3.New(0, 100, 0)

				var_196_15.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1095ui_story, var_196_19, var_196_18)

				local var_196_20 = manager.ui.mainCamera.transform.position - var_196_15.position

				var_196_15.forward = Vector3.New(var_196_20.x, var_196_20.y, var_196_20.z)

				local var_196_21 = var_196_15.localEulerAngles

				var_196_21.z = 0
				var_196_21.x = 0
				var_196_15.localEulerAngles = var_196_21
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 then
				var_196_15.localPosition = Vector3.New(0, 100, 0)

				local var_196_22 = manager.ui.mainCamera.transform.position - var_196_15.position

				var_196_15.forward = Vector3.New(var_196_22.x, var_196_22.y, var_196_22.z)

				local var_196_23 = var_196_15.localEulerAngles

				var_196_23.z = 0
				var_196_23.x = 0
				var_196_15.localEulerAngles = var_196_23
			end

			local var_196_24 = arg_193_1.actors_["1095ui_story"]
			local var_196_25 = 0

			if var_196_25 < arg_193_1.time_ and arg_193_1.time_ <= var_196_25 + arg_196_0 and not isNil(var_196_24) and arg_193_1.var_.characterEffect1095ui_story == nil then
				arg_193_1.var_.characterEffect1095ui_story = var_196_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_26 = 0.200000002980232

			if var_196_25 <= arg_193_1.time_ and arg_193_1.time_ < var_196_25 + var_196_26 and not isNil(var_196_24) then
				local var_196_27 = (arg_193_1.time_ - var_196_25) / var_196_26

				if arg_193_1.var_.characterEffect1095ui_story and not isNil(var_196_24) then
					local var_196_28 = Mathf.Lerp(0, 0.5, var_196_27)

					arg_193_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1095ui_story.fillRatio = var_196_28
				end
			end

			if arg_193_1.time_ >= var_196_25 + var_196_26 and arg_193_1.time_ < var_196_25 + var_196_26 + arg_196_0 and not isNil(var_196_24) and arg_193_1.var_.characterEffect1095ui_story then
				local var_196_29 = 0.5

				arg_193_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1095ui_story.fillRatio = var_196_29
			end

			local var_196_30 = 0
			local var_196_31 = 0.525

			if var_196_30 < arg_193_1.time_ and arg_193_1.time_ <= var_196_30 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_32 = arg_193_1:GetWordFromCfg(411191047)
				local var_196_33 = arg_193_1:FormatText(var_196_32.content)

				arg_193_1.text_.text = var_196_33

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_34 = 21
				local var_196_35 = utf8.len(var_196_33)
				local var_196_36 = var_196_34 <= 0 and var_196_31 or var_196_31 * (var_196_35 / var_196_34)

				if var_196_36 > 0 and var_196_31 < var_196_36 then
					arg_193_1.talkMaxDuration = var_196_36

					if var_196_36 + var_196_30 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_36 + var_196_30
					end
				end

				arg_193_1.text_.text = var_196_33
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_37 = math.max(var_196_31, arg_193_1.talkMaxDuration)

			if var_196_30 <= arg_193_1.time_ and arg_193_1.time_ < var_196_30 + var_196_37 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_30) / var_196_37

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_30 + var_196_37 and arg_193_1.time_ < var_196_30 + var_196_37 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play411191048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 411191048
		arg_197_1.duration_ = 4.87

		local var_197_0 = {
			zh = 4.766,
			ja = 4.866
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
				arg_197_0:Play411191049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["4010ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos4010ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, -1.59, -5.2)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos4010ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["4010ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect4010ui_story == nil then
				arg_197_1.var_.characterEffect4010ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect4010ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect4010ui_story then
				arg_197_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_200_15 = 0
			local var_200_16 = 0.325

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_17 = arg_197_1:FormatText(StoryNameCfg[42].name)

				arg_197_1.leftNameTxt_.text = var_200_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_18 = arg_197_1:GetWordFromCfg(411191048)
				local var_200_19 = arg_197_1:FormatText(var_200_18.content)

				arg_197_1.text_.text = var_200_19

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_20 = 13
				local var_200_21 = utf8.len(var_200_19)
				local var_200_22 = var_200_20 <= 0 and var_200_16 or var_200_16 * (var_200_21 / var_200_20)

				if var_200_22 > 0 and var_200_16 < var_200_22 then
					arg_197_1.talkMaxDuration = var_200_22

					if var_200_22 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_22 + var_200_15
					end
				end

				arg_197_1.text_.text = var_200_19
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191048", "story_v_out_411191.awb") ~= 0 then
					local var_200_23 = manager.audio:GetVoiceLength("story_v_out_411191", "411191048", "story_v_out_411191.awb") / 1000

					if var_200_23 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_15
					end

					if var_200_18.prefab_name ~= "" and arg_197_1.actors_[var_200_18.prefab_name] ~= nil then
						local var_200_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_18.prefab_name].transform, "story_v_out_411191", "411191048", "story_v_out_411191.awb")

						arg_197_1:RecordAudio("411191048", var_200_24)
						arg_197_1:RecordAudio("411191048", var_200_24)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_411191", "411191048", "story_v_out_411191.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_411191", "411191048", "story_v_out_411191.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_25 = math.max(var_200_16, arg_197_1.talkMaxDuration)

			if var_200_15 <= arg_197_1.time_ and arg_197_1.time_ < var_200_15 + var_200_25 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_15) / var_200_25

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_15 + var_200_25 and arg_197_1.time_ < var_200_15 + var_200_25 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play411191049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 411191049
		arg_201_1.duration_ = 1.53

		local var_201_0 = {
			zh = 1.533,
			ja = 1.366
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
				arg_201_0:Play411191050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.125

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[42].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(411191049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191049", "story_v_out_411191.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_411191", "411191049", "story_v_out_411191.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_411191", "411191049", "story_v_out_411191.awb")

						arg_201_1:RecordAudio("411191049", var_204_9)
						arg_201_1:RecordAudio("411191049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_411191", "411191049", "story_v_out_411191.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_411191", "411191049", "story_v_out_411191.awb")
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
	Play411191050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 411191050
		arg_205_1.duration_ = 9

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play411191051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 2

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				local var_208_1 = manager.ui.mainCamera.transform.localPosition
				local var_208_2 = Vector3.New(0, 0, 10) + Vector3.New(var_208_1.x, var_208_1.y, 0)
				local var_208_3 = arg_205_1.bgs_.I07

				var_208_3.transform.localPosition = var_208_2
				var_208_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_4 = var_208_3:GetComponent("SpriteRenderer")

				if var_208_4 and var_208_4.sprite then
					local var_208_5 = (var_208_3.transform.localPosition - var_208_1).z
					local var_208_6 = manager.ui.mainCameraCom_
					local var_208_7 = 2 * var_208_5 * Mathf.Tan(var_208_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_208_8 = var_208_7 * var_208_6.aspect
					local var_208_9 = var_208_4.sprite.bounds.size.x
					local var_208_10 = var_208_4.sprite.bounds.size.y
					local var_208_11 = var_208_8 / var_208_9
					local var_208_12 = var_208_7 / var_208_10
					local var_208_13 = var_208_12 < var_208_11 and var_208_11 or var_208_12

					var_208_3.transform.localScale = Vector3.New(var_208_13, var_208_13, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "I07" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_14 = 0

			if var_208_14 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_15 = 2

			if var_208_14 <= arg_205_1.time_ and arg_205_1.time_ < var_208_14 + var_208_15 then
				local var_208_16 = (arg_205_1.time_ - var_208_14) / var_208_15
				local var_208_17 = Color.New(0, 0, 0)

				var_208_17.a = Mathf.Lerp(0, 1, var_208_16)
				arg_205_1.mask_.color = var_208_17
			end

			if arg_205_1.time_ >= var_208_14 + var_208_15 and arg_205_1.time_ < var_208_14 + var_208_15 + arg_208_0 then
				local var_208_18 = Color.New(0, 0, 0)

				var_208_18.a = 1
				arg_205_1.mask_.color = var_208_18
			end

			local var_208_19 = 2

			if var_208_19 < arg_205_1.time_ and arg_205_1.time_ <= var_208_19 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_20 = 2

			if var_208_19 <= arg_205_1.time_ and arg_205_1.time_ < var_208_19 + var_208_20 then
				local var_208_21 = (arg_205_1.time_ - var_208_19) / var_208_20
				local var_208_22 = Color.New(0, 0, 0)

				var_208_22.a = Mathf.Lerp(1, 0, var_208_21)
				arg_205_1.mask_.color = var_208_22
			end

			if arg_205_1.time_ >= var_208_19 + var_208_20 and arg_205_1.time_ < var_208_19 + var_208_20 + arg_208_0 then
				local var_208_23 = Color.New(0, 0, 0)
				local var_208_24 = 0

				arg_205_1.mask_.enabled = false
				var_208_23.a = var_208_24
				arg_205_1.mask_.color = var_208_23
			end

			local var_208_25 = arg_205_1.actors_["4010ui_story"].transform
			local var_208_26 = 2

			if var_208_26 < arg_205_1.time_ and arg_205_1.time_ <= var_208_26 + arg_208_0 then
				arg_205_1.var_.moveOldPos4010ui_story = var_208_25.localPosition
			end

			local var_208_27 = 0.001

			if var_208_26 <= arg_205_1.time_ and arg_205_1.time_ < var_208_26 + var_208_27 then
				local var_208_28 = (arg_205_1.time_ - var_208_26) / var_208_27
				local var_208_29 = Vector3.New(0, 100, 0)

				var_208_25.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos4010ui_story, var_208_29, var_208_28)

				local var_208_30 = manager.ui.mainCamera.transform.position - var_208_25.position

				var_208_25.forward = Vector3.New(var_208_30.x, var_208_30.y, var_208_30.z)

				local var_208_31 = var_208_25.localEulerAngles

				var_208_31.z = 0
				var_208_31.x = 0
				var_208_25.localEulerAngles = var_208_31
			end

			if arg_205_1.time_ >= var_208_26 + var_208_27 and arg_205_1.time_ < var_208_26 + var_208_27 + arg_208_0 then
				var_208_25.localPosition = Vector3.New(0, 100, 0)

				local var_208_32 = manager.ui.mainCamera.transform.position - var_208_25.position

				var_208_25.forward = Vector3.New(var_208_32.x, var_208_32.y, var_208_32.z)

				local var_208_33 = var_208_25.localEulerAngles

				var_208_33.z = 0
				var_208_33.x = 0
				var_208_25.localEulerAngles = var_208_33
			end

			local var_208_34 = arg_205_1.actors_["4010ui_story"]
			local var_208_35 = 2

			if var_208_35 < arg_205_1.time_ and arg_205_1.time_ <= var_208_35 + arg_208_0 and not isNil(var_208_34) and arg_205_1.var_.characterEffect4010ui_story == nil then
				arg_205_1.var_.characterEffect4010ui_story = var_208_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_36 = 0.200000002980232

			if var_208_35 <= arg_205_1.time_ and arg_205_1.time_ < var_208_35 + var_208_36 and not isNil(var_208_34) then
				local var_208_37 = (arg_205_1.time_ - var_208_35) / var_208_36

				if arg_205_1.var_.characterEffect4010ui_story and not isNil(var_208_34) then
					local var_208_38 = Mathf.Lerp(0, 0.5, var_208_37)

					arg_205_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_205_1.var_.characterEffect4010ui_story.fillRatio = var_208_38
				end
			end

			if arg_205_1.time_ >= var_208_35 + var_208_36 and arg_205_1.time_ < var_208_35 + var_208_36 + arg_208_0 and not isNil(var_208_34) and arg_205_1.var_.characterEffect4010ui_story then
				local var_208_39 = 0.5

				arg_205_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_205_1.var_.characterEffect4010ui_story.fillRatio = var_208_39
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_40 = 4
			local var_208_41 = 0.775

			if var_208_40 < arg_205_1.time_ and arg_205_1.time_ <= var_208_40 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_42 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_42:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_43 = arg_205_1:GetWordFromCfg(411191050)
				local var_208_44 = arg_205_1:FormatText(var_208_43.content)

				arg_205_1.text_.text = var_208_44

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_45 = 31
				local var_208_46 = utf8.len(var_208_44)
				local var_208_47 = var_208_45 <= 0 and var_208_41 or var_208_41 * (var_208_46 / var_208_45)

				if var_208_47 > 0 and var_208_41 < var_208_47 then
					arg_205_1.talkMaxDuration = var_208_47
					var_208_40 = var_208_40 + 0.3

					if var_208_47 + var_208_40 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_47 + var_208_40
					end
				end

				arg_205_1.text_.text = var_208_44
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_48 = var_208_40 + 0.3
			local var_208_49 = math.max(var_208_41, arg_205_1.talkMaxDuration)

			if var_208_48 <= arg_205_1.time_ and arg_205_1.time_ < var_208_48 + var_208_49 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_48) / var_208_49

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_48 + var_208_49 and arg_205_1.time_ < var_208_48 + var_208_49 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play411191051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 411191051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play411191052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.175

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(411191051)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 7
				local var_214_5 = utf8.len(var_214_3)
				local var_214_6 = var_214_4 <= 0 and var_214_1 or var_214_1 * (var_214_5 / var_214_4)

				if var_214_6 > 0 and var_214_1 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_7 and arg_211_1.time_ < var_214_0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play411191052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 411191052
		arg_215_1.duration_ = 2.8

		local var_215_0 = {
			zh = 2.8,
			ja = 2.266
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
				arg_215_0:Play411191053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["4010ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos4010ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, -1.59, -5.2)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos4010ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["4010ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect4010ui_story == nil then
				arg_215_1.var_.characterEffect4010ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect4010ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect4010ui_story then
				arg_215_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_218_15 = 0
			local var_218_16 = 0.35

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[42].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(411191052)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 14
				local var_218_21 = utf8.len(var_218_19)
				local var_218_22 = var_218_20 <= 0 and var_218_16 or var_218_16 * (var_218_21 / var_218_20)

				if var_218_22 > 0 and var_218_16 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22

					if var_218_22 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191052", "story_v_out_411191.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_411191", "411191052", "story_v_out_411191.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_411191", "411191052", "story_v_out_411191.awb")

						arg_215_1:RecordAudio("411191052", var_218_24)
						arg_215_1:RecordAudio("411191052", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_411191", "411191052", "story_v_out_411191.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_411191", "411191052", "story_v_out_411191.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_25 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_25 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_25

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_25 and arg_215_1.time_ < var_218_15 + var_218_25 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play411191053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 411191053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play411191054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["4010ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos4010ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0, 100, 0)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos4010ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, 100, 0)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["4010ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect4010ui_story == nil then
				arg_219_1.var_.characterEffect4010ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 and not isNil(var_222_9) then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect4010ui_story and not isNil(var_222_9) then
					local var_222_13 = Mathf.Lerp(0, 0.5, var_222_12)

					arg_219_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_219_1.var_.characterEffect4010ui_story.fillRatio = var_222_13
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect4010ui_story then
				local var_222_14 = 0.5

				arg_219_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_219_1.var_.characterEffect4010ui_story.fillRatio = var_222_14
			end

			local var_222_15 = 0
			local var_222_16 = 1.05

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_17 = arg_219_1:GetWordFromCfg(411191053)
				local var_222_18 = arg_219_1:FormatText(var_222_17.content)

				arg_219_1.text_.text = var_222_18

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_19 = 42
				local var_222_20 = utf8.len(var_222_18)
				local var_222_21 = var_222_19 <= 0 and var_222_16 or var_222_16 * (var_222_20 / var_222_19)

				if var_222_21 > 0 and var_222_16 < var_222_21 then
					arg_219_1.talkMaxDuration = var_222_21

					if var_222_21 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_21 + var_222_15
					end
				end

				arg_219_1.text_.text = var_222_18
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_22 = math.max(var_222_16, arg_219_1.talkMaxDuration)

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_22 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_15) / var_222_22

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_15 + var_222_22 and arg_219_1.time_ < var_222_15 + var_222_22 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play411191054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 411191054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play411191055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.95

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_2 = arg_223_1:GetWordFromCfg(411191054)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 38
				local var_226_5 = utf8.len(var_226_3)
				local var_226_6 = var_226_4 <= 0 and var_226_1 or var_226_1 * (var_226_5 / var_226_4)

				if var_226_6 > 0 and var_226_1 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_7 and arg_223_1.time_ < var_226_0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play411191055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 411191055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play411191056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.5

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(411191055)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 20
				local var_230_5 = utf8.len(var_230_3)
				local var_230_6 = var_230_4 <= 0 and var_230_1 or var_230_1 * (var_230_5 / var_230_4)

				if var_230_6 > 0 and var_230_1 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_7 and arg_227_1.time_ < var_230_0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play411191056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 411191056
		arg_231_1.duration_ = 3.9

		local var_231_0 = {
			zh = 3.766,
			ja = 3.9
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
				arg_231_0:Play411191057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["4010ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos4010ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0, -1.59, -5.2)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos4010ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["4010ui_story"]
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect4010ui_story == nil then
				arg_231_1.var_.characterEffect4010ui_story = var_234_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_11 = 0.200000002980232

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_11 and not isNil(var_234_9) then
				local var_234_12 = (arg_231_1.time_ - var_234_10) / var_234_11

				if arg_231_1.var_.characterEffect4010ui_story and not isNil(var_234_9) then
					arg_231_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_10 + var_234_11 and arg_231_1.time_ < var_234_10 + var_234_11 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect4010ui_story then
				arg_231_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_234_13 = 0

			if var_234_13 < arg_231_1.time_ and arg_231_1.time_ <= var_234_13 + arg_234_0 then
				arg_231_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_2")
			end

			local var_234_14 = 0

			if var_234_14 < arg_231_1.time_ and arg_231_1.time_ <= var_234_14 + arg_234_0 then
				arg_231_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_15 = 0
			local var_234_16 = 0.375

			if var_234_15 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_17 = arg_231_1:FormatText(StoryNameCfg[42].name)

				arg_231_1.leftNameTxt_.text = var_234_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_18 = arg_231_1:GetWordFromCfg(411191056)
				local var_234_19 = arg_231_1:FormatText(var_234_18.content)

				arg_231_1.text_.text = var_234_19

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_20 = 15
				local var_234_21 = utf8.len(var_234_19)
				local var_234_22 = var_234_20 <= 0 and var_234_16 or var_234_16 * (var_234_21 / var_234_20)

				if var_234_22 > 0 and var_234_16 < var_234_22 then
					arg_231_1.talkMaxDuration = var_234_22

					if var_234_22 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_22 + var_234_15
					end
				end

				arg_231_1.text_.text = var_234_19
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191056", "story_v_out_411191.awb") ~= 0 then
					local var_234_23 = manager.audio:GetVoiceLength("story_v_out_411191", "411191056", "story_v_out_411191.awb") / 1000

					if var_234_23 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_23 + var_234_15
					end

					if var_234_18.prefab_name ~= "" and arg_231_1.actors_[var_234_18.prefab_name] ~= nil then
						local var_234_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_18.prefab_name].transform, "story_v_out_411191", "411191056", "story_v_out_411191.awb")

						arg_231_1:RecordAudio("411191056", var_234_24)
						arg_231_1:RecordAudio("411191056", var_234_24)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_411191", "411191056", "story_v_out_411191.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_411191", "411191056", "story_v_out_411191.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_25 = math.max(var_234_16, arg_231_1.talkMaxDuration)

			if var_234_15 <= arg_231_1.time_ and arg_231_1.time_ < var_234_15 + var_234_25 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_15) / var_234_25

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_15 + var_234_25 and arg_231_1.time_ < var_234_15 + var_234_25 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play411191057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 411191057
		arg_235_1.duration_ = 2.87

		local var_235_0 = {
			zh = 2.5,
			ja = 2.866
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
				arg_235_0:Play411191058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["4010ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos4010ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(0, 100, 0)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos4010ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0, 100, 0)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = arg_235_1.actors_["4010ui_story"]
			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect4010ui_story == nil then
				arg_235_1.var_.characterEffect4010ui_story = var_238_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_11 = 0.200000002980232

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_11 and not isNil(var_238_9) then
				local var_238_12 = (arg_235_1.time_ - var_238_10) / var_238_11

				if arg_235_1.var_.characterEffect4010ui_story and not isNil(var_238_9) then
					local var_238_13 = Mathf.Lerp(0, 0.5, var_238_12)

					arg_235_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_235_1.var_.characterEffect4010ui_story.fillRatio = var_238_13
				end
			end

			if arg_235_1.time_ >= var_238_10 + var_238_11 and arg_235_1.time_ < var_238_10 + var_238_11 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect4010ui_story then
				local var_238_14 = 0.5

				arg_235_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_235_1.var_.characterEffect4010ui_story.fillRatio = var_238_14
			end

			local var_238_15 = arg_235_1.actors_["1095ui_story"].transform
			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.var_.moveOldPos1095ui_story = var_238_15.localPosition
			end

			local var_238_17 = 0.001

			if var_238_16 <= arg_235_1.time_ and arg_235_1.time_ < var_238_16 + var_238_17 then
				local var_238_18 = (arg_235_1.time_ - var_238_16) / var_238_17
				local var_238_19 = Vector3.New(0, -0.98, -6.1)

				var_238_15.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1095ui_story, var_238_19, var_238_18)

				local var_238_20 = manager.ui.mainCamera.transform.position - var_238_15.position

				var_238_15.forward = Vector3.New(var_238_20.x, var_238_20.y, var_238_20.z)

				local var_238_21 = var_238_15.localEulerAngles

				var_238_21.z = 0
				var_238_21.x = 0
				var_238_15.localEulerAngles = var_238_21
			end

			if arg_235_1.time_ >= var_238_16 + var_238_17 and arg_235_1.time_ < var_238_16 + var_238_17 + arg_238_0 then
				var_238_15.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_238_22 = manager.ui.mainCamera.transform.position - var_238_15.position

				var_238_15.forward = Vector3.New(var_238_22.x, var_238_22.y, var_238_22.z)

				local var_238_23 = var_238_15.localEulerAngles

				var_238_23.z = 0
				var_238_23.x = 0
				var_238_15.localEulerAngles = var_238_23
			end

			local var_238_24 = arg_235_1.actors_["1095ui_story"]
			local var_238_25 = 0

			if var_238_25 < arg_235_1.time_ and arg_235_1.time_ <= var_238_25 + arg_238_0 and not isNil(var_238_24) and arg_235_1.var_.characterEffect1095ui_story == nil then
				arg_235_1.var_.characterEffect1095ui_story = var_238_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_26 = 0.200000002980232

			if var_238_25 <= arg_235_1.time_ and arg_235_1.time_ < var_238_25 + var_238_26 and not isNil(var_238_24) then
				local var_238_27 = (arg_235_1.time_ - var_238_25) / var_238_26

				if arg_235_1.var_.characterEffect1095ui_story and not isNil(var_238_24) then
					arg_235_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_25 + var_238_26 and arg_235_1.time_ < var_238_25 + var_238_26 + arg_238_0 and not isNil(var_238_24) and arg_235_1.var_.characterEffect1095ui_story then
				arg_235_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_238_28 = 0

			if var_238_28 < arg_235_1.time_ and arg_235_1.time_ <= var_238_28 + arg_238_0 then
				arg_235_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_238_29 = 0

			if var_238_29 < arg_235_1.time_ and arg_235_1.time_ <= var_238_29 + arg_238_0 then
				arg_235_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_30 = arg_235_1.actors_["1095ui_story"]
			local var_238_31 = 0

			if var_238_31 < arg_235_1.time_ and arg_235_1.time_ <= var_238_31 + arg_238_0 then
				if arg_235_1.var_.characterEffect1095ui_story == nil then
					arg_235_1.var_.characterEffect1095ui_story = var_238_30:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_238_32 = arg_235_1.var_.characterEffect1095ui_story

				var_238_32.imageEffect:turnOff()

				var_238_32.interferenceEffect.enabled = true
				var_238_32.interferenceEffect.noise = 0.01
				var_238_32.interferenceEffect.simTimeScale = 1
				var_238_32.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_238_33 = arg_235_1.actors_["1095ui_story"]
			local var_238_34 = 0
			local var_238_35 = 2

			if var_238_34 < arg_235_1.time_ and arg_235_1.time_ <= var_238_34 + arg_238_0 then
				if arg_235_1.var_.characterEffect1095ui_story == nil then
					arg_235_1.var_.characterEffect1095ui_story = var_238_33:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_235_1.var_.characterEffect1095ui_story.imageEffect:turnOn(false)
			end

			local var_238_36 = 0
			local var_238_37 = 0.25

			if var_238_36 < arg_235_1.time_ and arg_235_1.time_ <= var_238_36 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_38 = arg_235_1:FormatText(StoryNameCfg[471].name)

				arg_235_1.leftNameTxt_.text = var_238_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_39 = arg_235_1:GetWordFromCfg(411191057)
				local var_238_40 = arg_235_1:FormatText(var_238_39.content)

				arg_235_1.text_.text = var_238_40

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_41 = 10
				local var_238_42 = utf8.len(var_238_40)
				local var_238_43 = var_238_41 <= 0 and var_238_37 or var_238_37 * (var_238_42 / var_238_41)

				if var_238_43 > 0 and var_238_37 < var_238_43 then
					arg_235_1.talkMaxDuration = var_238_43

					if var_238_43 + var_238_36 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_43 + var_238_36
					end
				end

				arg_235_1.text_.text = var_238_40
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191057", "story_v_out_411191.awb") ~= 0 then
					local var_238_44 = manager.audio:GetVoiceLength("story_v_out_411191", "411191057", "story_v_out_411191.awb") / 1000

					if var_238_44 + var_238_36 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_44 + var_238_36
					end

					if var_238_39.prefab_name ~= "" and arg_235_1.actors_[var_238_39.prefab_name] ~= nil then
						local var_238_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_39.prefab_name].transform, "story_v_out_411191", "411191057", "story_v_out_411191.awb")

						arg_235_1:RecordAudio("411191057", var_238_45)
						arg_235_1:RecordAudio("411191057", var_238_45)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_411191", "411191057", "story_v_out_411191.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_411191", "411191057", "story_v_out_411191.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_46 = math.max(var_238_37, arg_235_1.talkMaxDuration)

			if var_238_36 <= arg_235_1.time_ and arg_235_1.time_ < var_238_36 + var_238_46 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_36) / var_238_46

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_36 + var_238_46 and arg_235_1.time_ < var_238_36 + var_238_46 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play411191058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 411191058
		arg_239_1.duration_ = 3.3

		local var_239_0 = {
			zh = 2.1,
			ja = 3.3
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play411191059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["4010ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos4010ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(-0.7, -1.59, -5.2)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos4010ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["4010ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect4010ui_story == nil then
				arg_239_1.var_.characterEffect4010ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect4010ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect4010ui_story then
				arg_239_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_242_13 = 0

			if var_242_13 < arg_239_1.time_ and arg_239_1.time_ <= var_242_13 + arg_242_0 then
				arg_239_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_242_14 = 0

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_15 = arg_239_1.actors_["1095ui_story"].transform
			local var_242_16 = 0

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 then
				arg_239_1.var_.moveOldPos1095ui_story = var_242_15.localPosition
			end

			local var_242_17 = 0.001

			if var_242_16 <= arg_239_1.time_ and arg_239_1.time_ < var_242_16 + var_242_17 then
				local var_242_18 = (arg_239_1.time_ - var_242_16) / var_242_17
				local var_242_19 = Vector3.New(0.7, -0.98, -6.1)

				var_242_15.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1095ui_story, var_242_19, var_242_18)

				local var_242_20 = manager.ui.mainCamera.transform.position - var_242_15.position

				var_242_15.forward = Vector3.New(var_242_20.x, var_242_20.y, var_242_20.z)

				local var_242_21 = var_242_15.localEulerAngles

				var_242_21.z = 0
				var_242_21.x = 0
				var_242_15.localEulerAngles = var_242_21
			end

			if arg_239_1.time_ >= var_242_16 + var_242_17 and arg_239_1.time_ < var_242_16 + var_242_17 + arg_242_0 then
				var_242_15.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_242_22 = manager.ui.mainCamera.transform.position - var_242_15.position

				var_242_15.forward = Vector3.New(var_242_22.x, var_242_22.y, var_242_22.z)

				local var_242_23 = var_242_15.localEulerAngles

				var_242_23.z = 0
				var_242_23.x = 0
				var_242_15.localEulerAngles = var_242_23
			end

			local var_242_24 = arg_239_1.actors_["1095ui_story"]
			local var_242_25 = 0

			if var_242_25 < arg_239_1.time_ and arg_239_1.time_ <= var_242_25 + arg_242_0 and not isNil(var_242_24) and arg_239_1.var_.characterEffect1095ui_story == nil then
				arg_239_1.var_.characterEffect1095ui_story = var_242_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_26 = 0.200000002980232

			if var_242_25 <= arg_239_1.time_ and arg_239_1.time_ < var_242_25 + var_242_26 and not isNil(var_242_24) then
				local var_242_27 = (arg_239_1.time_ - var_242_25) / var_242_26

				if arg_239_1.var_.characterEffect1095ui_story and not isNil(var_242_24) then
					local var_242_28 = Mathf.Lerp(0, 0.5, var_242_27)

					arg_239_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1095ui_story.fillRatio = var_242_28
				end
			end

			if arg_239_1.time_ >= var_242_25 + var_242_26 and arg_239_1.time_ < var_242_25 + var_242_26 + arg_242_0 and not isNil(var_242_24) and arg_239_1.var_.characterEffect1095ui_story then
				local var_242_29 = 0.5

				arg_239_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1095ui_story.fillRatio = var_242_29
			end

			local var_242_30 = 0
			local var_242_31 = 0.2

			if var_242_30 < arg_239_1.time_ and arg_239_1.time_ <= var_242_30 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_32 = arg_239_1:FormatText(StoryNameCfg[42].name)

				arg_239_1.leftNameTxt_.text = var_242_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_33 = arg_239_1:GetWordFromCfg(411191058)
				local var_242_34 = arg_239_1:FormatText(var_242_33.content)

				arg_239_1.text_.text = var_242_34

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_35 = 8
				local var_242_36 = utf8.len(var_242_34)
				local var_242_37 = var_242_35 <= 0 and var_242_31 or var_242_31 * (var_242_36 / var_242_35)

				if var_242_37 > 0 and var_242_31 < var_242_37 then
					arg_239_1.talkMaxDuration = var_242_37

					if var_242_37 + var_242_30 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_37 + var_242_30
					end
				end

				arg_239_1.text_.text = var_242_34
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191058", "story_v_out_411191.awb") ~= 0 then
					local var_242_38 = manager.audio:GetVoiceLength("story_v_out_411191", "411191058", "story_v_out_411191.awb") / 1000

					if var_242_38 + var_242_30 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_38 + var_242_30
					end

					if var_242_33.prefab_name ~= "" and arg_239_1.actors_[var_242_33.prefab_name] ~= nil then
						local var_242_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_33.prefab_name].transform, "story_v_out_411191", "411191058", "story_v_out_411191.awb")

						arg_239_1:RecordAudio("411191058", var_242_39)
						arg_239_1:RecordAudio("411191058", var_242_39)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_411191", "411191058", "story_v_out_411191.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_411191", "411191058", "story_v_out_411191.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_40 = math.max(var_242_31, arg_239_1.talkMaxDuration)

			if var_242_30 <= arg_239_1.time_ and arg_239_1.time_ < var_242_30 + var_242_40 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_30) / var_242_40

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_30 + var_242_40 and arg_239_1.time_ < var_242_30 + var_242_40 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411191059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 411191059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play411191060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["4010ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect4010ui_story == nil then
				arg_243_1.var_.characterEffect4010ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect4010ui_story and not isNil(var_246_0) then
					local var_246_4 = Mathf.Lerp(0, 0.5, var_246_3)

					arg_243_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_243_1.var_.characterEffect4010ui_story.fillRatio = var_246_4
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect4010ui_story then
				local var_246_5 = 0.5

				arg_243_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_243_1.var_.characterEffect4010ui_story.fillRatio = var_246_5
			end

			local var_246_6 = arg_243_1.actors_["1095ui_story"]
			local var_246_7 = 0

			if var_246_7 < arg_243_1.time_ and arg_243_1.time_ <= var_246_7 + arg_246_0 and not isNil(var_246_6) and arg_243_1.var_.characterEffect1095ui_story == nil then
				arg_243_1.var_.characterEffect1095ui_story = var_246_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_8 = 0.200000002980232

			if var_246_7 <= arg_243_1.time_ and arg_243_1.time_ < var_246_7 + var_246_8 and not isNil(var_246_6) then
				local var_246_9 = (arg_243_1.time_ - var_246_7) / var_246_8

				if arg_243_1.var_.characterEffect1095ui_story and not isNil(var_246_6) then
					local var_246_10 = Mathf.Lerp(0, 0.5, var_246_9)

					arg_243_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1095ui_story.fillRatio = var_246_10
				end
			end

			if arg_243_1.time_ >= var_246_7 + var_246_8 and arg_243_1.time_ < var_246_7 + var_246_8 + arg_246_0 and not isNil(var_246_6) and arg_243_1.var_.characterEffect1095ui_story then
				local var_246_11 = 0.5

				arg_243_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1095ui_story.fillRatio = var_246_11
			end

			local var_246_12 = 0
			local var_246_13 = 0.775

			if var_246_12 < arg_243_1.time_ and arg_243_1.time_ <= var_246_12 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_14 = arg_243_1:GetWordFromCfg(411191059)
				local var_246_15 = arg_243_1:FormatText(var_246_14.content)

				arg_243_1.text_.text = var_246_15

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_16 = 31
				local var_246_17 = utf8.len(var_246_15)
				local var_246_18 = var_246_16 <= 0 and var_246_13 or var_246_13 * (var_246_17 / var_246_16)

				if var_246_18 > 0 and var_246_13 < var_246_18 then
					arg_243_1.talkMaxDuration = var_246_18

					if var_246_18 + var_246_12 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_18 + var_246_12
					end
				end

				arg_243_1.text_.text = var_246_15
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_19 = math.max(var_246_13, arg_243_1.talkMaxDuration)

			if var_246_12 <= arg_243_1.time_ and arg_243_1.time_ < var_246_12 + var_246_19 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_12) / var_246_19

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_12 + var_246_19 and arg_243_1.time_ < var_246_12 + var_246_19 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play411191060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 411191060
		arg_247_1.duration_ = 3.57

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play411191061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["4010ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect4010ui_story == nil then
				arg_247_1.var_.characterEffect4010ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect4010ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect4010ui_story then
				arg_247_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_250_4 = 0
			local var_250_5 = 0.275

			if var_250_4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_6 = arg_247_1:FormatText(StoryNameCfg[42].name)

				arg_247_1.leftNameTxt_.text = var_250_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_7 = arg_247_1:GetWordFromCfg(411191060)
				local var_250_8 = arg_247_1:FormatText(var_250_7.content)

				arg_247_1.text_.text = var_250_8

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 11
				local var_250_10 = utf8.len(var_250_8)
				local var_250_11 = var_250_9 <= 0 and var_250_5 or var_250_5 * (var_250_10 / var_250_9)

				if var_250_11 > 0 and var_250_5 < var_250_11 then
					arg_247_1.talkMaxDuration = var_250_11

					if var_250_11 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_8
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191060", "story_v_out_411191.awb") ~= 0 then
					local var_250_12 = manager.audio:GetVoiceLength("story_v_out_411191", "411191060", "story_v_out_411191.awb") / 1000

					if var_250_12 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_12 + var_250_4
					end

					if var_250_7.prefab_name ~= "" and arg_247_1.actors_[var_250_7.prefab_name] ~= nil then
						local var_250_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_7.prefab_name].transform, "story_v_out_411191", "411191060", "story_v_out_411191.awb")

						arg_247_1:RecordAudio("411191060", var_250_13)
						arg_247_1:RecordAudio("411191060", var_250_13)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_411191", "411191060", "story_v_out_411191.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_411191", "411191060", "story_v_out_411191.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_14 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_14 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_14

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_14 and arg_247_1.time_ < var_250_4 + var_250_14 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play411191061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 411191061
		arg_251_1.duration_ = 5.03

		local var_251_0 = {
			zh = 4.366,
			ja = 5.033
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
				arg_251_0:Play411191062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1095ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1095ui_story == nil then
				arg_251_1.var_.characterEffect1095ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1095ui_story and not isNil(var_254_0) then
					arg_251_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1095ui_story then
				arg_251_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_254_4 = arg_251_1.actors_["4010ui_story"]
			local var_254_5 = 0

			if var_254_5 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect4010ui_story == nil then
				arg_251_1.var_.characterEffect4010ui_story = var_254_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_6 = 0.200000002980232

			if var_254_5 <= arg_251_1.time_ and arg_251_1.time_ < var_254_5 + var_254_6 and not isNil(var_254_4) then
				local var_254_7 = (arg_251_1.time_ - var_254_5) / var_254_6

				if arg_251_1.var_.characterEffect4010ui_story and not isNil(var_254_4) then
					local var_254_8 = Mathf.Lerp(0, 0.5, var_254_7)

					arg_251_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_251_1.var_.characterEffect4010ui_story.fillRatio = var_254_8
				end
			end

			if arg_251_1.time_ >= var_254_5 + var_254_6 and arg_251_1.time_ < var_254_5 + var_254_6 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect4010ui_story then
				local var_254_9 = 0.5

				arg_251_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_251_1.var_.characterEffect4010ui_story.fillRatio = var_254_9
			end

			local var_254_10 = 0
			local var_254_11 = 0.5

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_12 = arg_251_1:FormatText(StoryNameCfg[471].name)

				arg_251_1.leftNameTxt_.text = var_254_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_13 = arg_251_1:GetWordFromCfg(411191061)
				local var_254_14 = arg_251_1:FormatText(var_254_13.content)

				arg_251_1.text_.text = var_254_14

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_15 = 20
				local var_254_16 = utf8.len(var_254_14)
				local var_254_17 = var_254_15 <= 0 and var_254_11 or var_254_11 * (var_254_16 / var_254_15)

				if var_254_17 > 0 and var_254_11 < var_254_17 then
					arg_251_1.talkMaxDuration = var_254_17

					if var_254_17 + var_254_10 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_17 + var_254_10
					end
				end

				arg_251_1.text_.text = var_254_14
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191061", "story_v_out_411191.awb") ~= 0 then
					local var_254_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191061", "story_v_out_411191.awb") / 1000

					if var_254_18 + var_254_10 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_18 + var_254_10
					end

					if var_254_13.prefab_name ~= "" and arg_251_1.actors_[var_254_13.prefab_name] ~= nil then
						local var_254_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_13.prefab_name].transform, "story_v_out_411191", "411191061", "story_v_out_411191.awb")

						arg_251_1:RecordAudio("411191061", var_254_19)
						arg_251_1:RecordAudio("411191061", var_254_19)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_411191", "411191061", "story_v_out_411191.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_411191", "411191061", "story_v_out_411191.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_20 = math.max(var_254_11, arg_251_1.talkMaxDuration)

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_20 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_10) / var_254_20

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_10 + var_254_20 and arg_251_1.time_ < var_254_10 + var_254_20 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play411191062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 411191062
		arg_255_1.duration_ = 1.6

		local var_255_0 = {
			zh = 1.6,
			ja = 1.2
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play411191063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1095ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1095ui_story == nil then
				arg_255_1.var_.characterEffect1095ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect1095ui_story and not isNil(var_258_0) then
					local var_258_4 = Mathf.Lerp(0, 0.5, var_258_3)

					arg_255_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1095ui_story.fillRatio = var_258_4
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1095ui_story then
				local var_258_5 = 0.5

				arg_255_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1095ui_story.fillRatio = var_258_5
			end

			local var_258_6 = arg_255_1.actors_["4010ui_story"]
			local var_258_7 = 0

			if var_258_7 < arg_255_1.time_ and arg_255_1.time_ <= var_258_7 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect4010ui_story == nil then
				arg_255_1.var_.characterEffect4010ui_story = var_258_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_8 = 0.200000002980232

			if var_258_7 <= arg_255_1.time_ and arg_255_1.time_ < var_258_7 + var_258_8 and not isNil(var_258_6) then
				local var_258_9 = (arg_255_1.time_ - var_258_7) / var_258_8

				if arg_255_1.var_.characterEffect4010ui_story and not isNil(var_258_6) then
					arg_255_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_7 + var_258_8 and arg_255_1.time_ < var_258_7 + var_258_8 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect4010ui_story then
				arg_255_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_258_10 = 0
			local var_258_11 = 0.1

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_12 = arg_255_1:FormatText(StoryNameCfg[42].name)

				arg_255_1.leftNameTxt_.text = var_258_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_13 = arg_255_1:GetWordFromCfg(411191062)
				local var_258_14 = arg_255_1:FormatText(var_258_13.content)

				arg_255_1.text_.text = var_258_14

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_15 = 4
				local var_258_16 = utf8.len(var_258_14)
				local var_258_17 = var_258_15 <= 0 and var_258_11 or var_258_11 * (var_258_16 / var_258_15)

				if var_258_17 > 0 and var_258_11 < var_258_17 then
					arg_255_1.talkMaxDuration = var_258_17

					if var_258_17 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_17 + var_258_10
					end
				end

				arg_255_1.text_.text = var_258_14
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191062", "story_v_out_411191.awb") ~= 0 then
					local var_258_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191062", "story_v_out_411191.awb") / 1000

					if var_258_18 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_18 + var_258_10
					end

					if var_258_13.prefab_name ~= "" and arg_255_1.actors_[var_258_13.prefab_name] ~= nil then
						local var_258_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_13.prefab_name].transform, "story_v_out_411191", "411191062", "story_v_out_411191.awb")

						arg_255_1:RecordAudio("411191062", var_258_19)
						arg_255_1:RecordAudio("411191062", var_258_19)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_411191", "411191062", "story_v_out_411191.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_411191", "411191062", "story_v_out_411191.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_20 = math.max(var_258_11, arg_255_1.talkMaxDuration)

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_20 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_10) / var_258_20

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_10 + var_258_20 and arg_255_1.time_ < var_258_10 + var_258_20 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play411191063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 411191063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play411191064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["4010ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect4010ui_story == nil then
				arg_259_1.var_.characterEffect4010ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect4010ui_story and not isNil(var_262_0) then
					local var_262_4 = Mathf.Lerp(0, 0.5, var_262_3)

					arg_259_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_259_1.var_.characterEffect4010ui_story.fillRatio = var_262_4
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect4010ui_story then
				local var_262_5 = 0.5

				arg_259_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_259_1.var_.characterEffect4010ui_story.fillRatio = var_262_5
			end

			local var_262_6 = 0
			local var_262_7 = 1

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_8 = arg_259_1:GetWordFromCfg(411191063)
				local var_262_9 = arg_259_1:FormatText(var_262_8.content)

				arg_259_1.text_.text = var_262_9

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_10 = 40
				local var_262_11 = utf8.len(var_262_9)
				local var_262_12 = var_262_10 <= 0 and var_262_7 or var_262_7 * (var_262_11 / var_262_10)

				if var_262_12 > 0 and var_262_7 < var_262_12 then
					arg_259_1.talkMaxDuration = var_262_12

					if var_262_12 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_12 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_9
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_13 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_13 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_13

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_13 and arg_259_1.time_ < var_262_6 + var_262_13 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play411191064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 411191064
		arg_263_1.duration_ = 6.47

		local var_263_0 = {
			zh = 4.033,
			ja = 6.466
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play411191065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1095ui_story"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1095ui_story == nil then
				arg_263_1.var_.characterEffect1095ui_story = var_266_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.characterEffect1095ui_story and not isNil(var_266_0) then
					local var_266_4 = Mathf.Lerp(0, 0.5, var_266_3)

					arg_263_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1095ui_story.fillRatio = var_266_4
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1095ui_story then
				local var_266_5 = 0.5

				arg_263_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1095ui_story.fillRatio = var_266_5
			end

			local var_266_6 = arg_263_1.actors_["4010ui_story"]
			local var_266_7 = 0

			if var_266_7 < arg_263_1.time_ and arg_263_1.time_ <= var_266_7 + arg_266_0 and not isNil(var_266_6) and arg_263_1.var_.characterEffect4010ui_story == nil then
				arg_263_1.var_.characterEffect4010ui_story = var_266_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_8 = 0.200000002980232

			if var_266_7 <= arg_263_1.time_ and arg_263_1.time_ < var_266_7 + var_266_8 and not isNil(var_266_6) then
				local var_266_9 = (arg_263_1.time_ - var_266_7) / var_266_8

				if arg_263_1.var_.characterEffect4010ui_story and not isNil(var_266_6) then
					arg_263_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_7 + var_266_8 and arg_263_1.time_ < var_266_7 + var_266_8 + arg_266_0 and not isNil(var_266_6) and arg_263_1.var_.characterEffect4010ui_story then
				arg_263_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_266_10 = 0
			local var_266_11 = 0.45

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_12 = arg_263_1:FormatText(StoryNameCfg[42].name)

				arg_263_1.leftNameTxt_.text = var_266_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_13 = arg_263_1:GetWordFromCfg(411191064)
				local var_266_14 = arg_263_1:FormatText(var_266_13.content)

				arg_263_1.text_.text = var_266_14

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_15 = 18
				local var_266_16 = utf8.len(var_266_14)
				local var_266_17 = var_266_15 <= 0 and var_266_11 or var_266_11 * (var_266_16 / var_266_15)

				if var_266_17 > 0 and var_266_11 < var_266_17 then
					arg_263_1.talkMaxDuration = var_266_17

					if var_266_17 + var_266_10 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_17 + var_266_10
					end
				end

				arg_263_1.text_.text = var_266_14
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191064", "story_v_out_411191.awb") ~= 0 then
					local var_266_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191064", "story_v_out_411191.awb") / 1000

					if var_266_18 + var_266_10 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_18 + var_266_10
					end

					if var_266_13.prefab_name ~= "" and arg_263_1.actors_[var_266_13.prefab_name] ~= nil then
						local var_266_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_13.prefab_name].transform, "story_v_out_411191", "411191064", "story_v_out_411191.awb")

						arg_263_1:RecordAudio("411191064", var_266_19)
						arg_263_1:RecordAudio("411191064", var_266_19)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_411191", "411191064", "story_v_out_411191.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_411191", "411191064", "story_v_out_411191.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_20 = math.max(var_266_11, arg_263_1.talkMaxDuration)

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_20 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_10) / var_266_20

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_10 + var_266_20 and arg_263_1.time_ < var_266_10 + var_266_20 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play411191065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 411191065
		arg_267_1.duration_ = 4.47

		local var_267_0 = {
			zh = 4.466,
			ja = 4.133
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play411191066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1095ui_story"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1095ui_story == nil then
				arg_267_1.var_.characterEffect1095ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.characterEffect1095ui_story and not isNil(var_270_0) then
					arg_267_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1095ui_story then
				arg_267_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_270_4 = arg_267_1.actors_["4010ui_story"]
			local var_270_5 = 0

			if var_270_5 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect4010ui_story == nil then
				arg_267_1.var_.characterEffect4010ui_story = var_270_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_6 = 0.200000002980232

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_6 and not isNil(var_270_4) then
				local var_270_7 = (arg_267_1.time_ - var_270_5) / var_270_6

				if arg_267_1.var_.characterEffect4010ui_story and not isNil(var_270_4) then
					local var_270_8 = Mathf.Lerp(0, 0.5, var_270_7)

					arg_267_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_267_1.var_.characterEffect4010ui_story.fillRatio = var_270_8
				end
			end

			if arg_267_1.time_ >= var_270_5 + var_270_6 and arg_267_1.time_ < var_270_5 + var_270_6 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect4010ui_story then
				local var_270_9 = 0.5

				arg_267_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_267_1.var_.characterEffect4010ui_story.fillRatio = var_270_9
			end

			local var_270_10 = 0

			if var_270_10 < arg_267_1.time_ and arg_267_1.time_ <= var_270_10 + arg_270_0 then
				arg_267_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_270_11 = 0

			if var_270_11 < arg_267_1.time_ and arg_267_1.time_ <= var_270_11 + arg_270_0 then
				arg_267_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_270_12 = 0
			local var_270_13 = 0.475

			if var_270_12 < arg_267_1.time_ and arg_267_1.time_ <= var_270_12 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_14 = arg_267_1:FormatText(StoryNameCfg[471].name)

				arg_267_1.leftNameTxt_.text = var_270_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_15 = arg_267_1:GetWordFromCfg(411191065)
				local var_270_16 = arg_267_1:FormatText(var_270_15.content)

				arg_267_1.text_.text = var_270_16

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_17 = 19
				local var_270_18 = utf8.len(var_270_16)
				local var_270_19 = var_270_17 <= 0 and var_270_13 or var_270_13 * (var_270_18 / var_270_17)

				if var_270_19 > 0 and var_270_13 < var_270_19 then
					arg_267_1.talkMaxDuration = var_270_19

					if var_270_19 + var_270_12 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_19 + var_270_12
					end
				end

				arg_267_1.text_.text = var_270_16
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191065", "story_v_out_411191.awb") ~= 0 then
					local var_270_20 = manager.audio:GetVoiceLength("story_v_out_411191", "411191065", "story_v_out_411191.awb") / 1000

					if var_270_20 + var_270_12 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_20 + var_270_12
					end

					if var_270_15.prefab_name ~= "" and arg_267_1.actors_[var_270_15.prefab_name] ~= nil then
						local var_270_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_15.prefab_name].transform, "story_v_out_411191", "411191065", "story_v_out_411191.awb")

						arg_267_1:RecordAudio("411191065", var_270_21)
						arg_267_1:RecordAudio("411191065", var_270_21)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_411191", "411191065", "story_v_out_411191.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_411191", "411191065", "story_v_out_411191.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_22 = math.max(var_270_13, arg_267_1.talkMaxDuration)

			if var_270_12 <= arg_267_1.time_ and arg_267_1.time_ < var_270_12 + var_270_22 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_12) / var_270_22

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_12 + var_270_22 and arg_267_1.time_ < var_270_12 + var_270_22 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play411191066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 411191066
		arg_271_1.duration_ = 7.93

		local var_271_0 = {
			zh = 5.633,
			ja = 7.933
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
				arg_271_0:Play411191067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.625

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_2 = arg_271_1:FormatText(StoryNameCfg[471].name)

				arg_271_1.leftNameTxt_.text = var_274_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_3 = arg_271_1:GetWordFromCfg(411191066)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 25
				local var_274_6 = utf8.len(var_274_4)
				local var_274_7 = var_274_5 <= 0 and var_274_1 or var_274_1 * (var_274_6 / var_274_5)

				if var_274_7 > 0 and var_274_1 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191066", "story_v_out_411191.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_out_411191", "411191066", "story_v_out_411191.awb") / 1000

					if var_274_8 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_0
					end

					if var_274_3.prefab_name ~= "" and arg_271_1.actors_[var_274_3.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_3.prefab_name].transform, "story_v_out_411191", "411191066", "story_v_out_411191.awb")

						arg_271_1:RecordAudio("411191066", var_274_9)
						arg_271_1:RecordAudio("411191066", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_411191", "411191066", "story_v_out_411191.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_411191", "411191066", "story_v_out_411191.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_10 and arg_271_1.time_ < var_274_0 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play411191067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 411191067
		arg_275_1.duration_ = 2.2

		local var_275_0 = {
			zh = 2.133,
			ja = 2.2
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play411191068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1095ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1095ui_story == nil then
				arg_275_1.var_.characterEffect1095ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect1095ui_story and not isNil(var_278_0) then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1095ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1095ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1095ui_story.fillRatio = var_278_5
			end

			local var_278_6 = arg_275_1.actors_["4010ui_story"]
			local var_278_7 = 0

			if var_278_7 < arg_275_1.time_ and arg_275_1.time_ <= var_278_7 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect4010ui_story == nil then
				arg_275_1.var_.characterEffect4010ui_story = var_278_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_8 = 0.200000002980232

			if var_278_7 <= arg_275_1.time_ and arg_275_1.time_ < var_278_7 + var_278_8 and not isNil(var_278_6) then
				local var_278_9 = (arg_275_1.time_ - var_278_7) / var_278_8

				if arg_275_1.var_.characterEffect4010ui_story and not isNil(var_278_6) then
					arg_275_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_7 + var_278_8 and arg_275_1.time_ < var_278_7 + var_278_8 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect4010ui_story then
				arg_275_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_278_10 = 0
			local var_278_11 = 0.15

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_12 = arg_275_1:FormatText(StoryNameCfg[42].name)

				arg_275_1.leftNameTxt_.text = var_278_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_13 = arg_275_1:GetWordFromCfg(411191067)
				local var_278_14 = arg_275_1:FormatText(var_278_13.content)

				arg_275_1.text_.text = var_278_14

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_15 = 6
				local var_278_16 = utf8.len(var_278_14)
				local var_278_17 = var_278_15 <= 0 and var_278_11 or var_278_11 * (var_278_16 / var_278_15)

				if var_278_17 > 0 and var_278_11 < var_278_17 then
					arg_275_1.talkMaxDuration = var_278_17

					if var_278_17 + var_278_10 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_17 + var_278_10
					end
				end

				arg_275_1.text_.text = var_278_14
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191067", "story_v_out_411191.awb") ~= 0 then
					local var_278_18 = manager.audio:GetVoiceLength("story_v_out_411191", "411191067", "story_v_out_411191.awb") / 1000

					if var_278_18 + var_278_10 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_18 + var_278_10
					end

					if var_278_13.prefab_name ~= "" and arg_275_1.actors_[var_278_13.prefab_name] ~= nil then
						local var_278_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_13.prefab_name].transform, "story_v_out_411191", "411191067", "story_v_out_411191.awb")

						arg_275_1:RecordAudio("411191067", var_278_19)
						arg_275_1:RecordAudio("411191067", var_278_19)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_411191", "411191067", "story_v_out_411191.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_411191", "411191067", "story_v_out_411191.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_20 = math.max(var_278_11, arg_275_1.talkMaxDuration)

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_20 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_10) / var_278_20

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_10 + var_278_20 and arg_275_1.time_ < var_278_10 + var_278_20 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play411191068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 411191068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play411191069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["4010ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos4010ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, 100, 0)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos4010ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, 100, 0)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["4010ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect4010ui_story == nil then
				arg_279_1.var_.characterEffect4010ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.200000002980232

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect4010ui_story and not isNil(var_282_9) then
					local var_282_13 = Mathf.Lerp(0, 0.5, var_282_12)

					arg_279_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_279_1.var_.characterEffect4010ui_story.fillRatio = var_282_13
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect4010ui_story then
				local var_282_14 = 0.5

				arg_279_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_279_1.var_.characterEffect4010ui_story.fillRatio = var_282_14
			end

			local var_282_15 = arg_279_1.actors_["1095ui_story"].transform
			local var_282_16 = 0

			if var_282_16 < arg_279_1.time_ and arg_279_1.time_ <= var_282_16 + arg_282_0 then
				arg_279_1.var_.moveOldPos1095ui_story = var_282_15.localPosition
			end

			local var_282_17 = 0.001

			if var_282_16 <= arg_279_1.time_ and arg_279_1.time_ < var_282_16 + var_282_17 then
				local var_282_18 = (arg_279_1.time_ - var_282_16) / var_282_17
				local var_282_19 = Vector3.New(0, 100, 0)

				var_282_15.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1095ui_story, var_282_19, var_282_18)

				local var_282_20 = manager.ui.mainCamera.transform.position - var_282_15.position

				var_282_15.forward = Vector3.New(var_282_20.x, var_282_20.y, var_282_20.z)

				local var_282_21 = var_282_15.localEulerAngles

				var_282_21.z = 0
				var_282_21.x = 0
				var_282_15.localEulerAngles = var_282_21
			end

			if arg_279_1.time_ >= var_282_16 + var_282_17 and arg_279_1.time_ < var_282_16 + var_282_17 + arg_282_0 then
				var_282_15.localPosition = Vector3.New(0, 100, 0)

				local var_282_22 = manager.ui.mainCamera.transform.position - var_282_15.position

				var_282_15.forward = Vector3.New(var_282_22.x, var_282_22.y, var_282_22.z)

				local var_282_23 = var_282_15.localEulerAngles

				var_282_23.z = 0
				var_282_23.x = 0
				var_282_15.localEulerAngles = var_282_23
			end

			local var_282_24 = arg_279_1.actors_["1095ui_story"]
			local var_282_25 = 0

			if var_282_25 < arg_279_1.time_ and arg_279_1.time_ <= var_282_25 + arg_282_0 and not isNil(var_282_24) and arg_279_1.var_.characterEffect1095ui_story == nil then
				arg_279_1.var_.characterEffect1095ui_story = var_282_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_26 = 0.200000002980232

			if var_282_25 <= arg_279_1.time_ and arg_279_1.time_ < var_282_25 + var_282_26 and not isNil(var_282_24) then
				local var_282_27 = (arg_279_1.time_ - var_282_25) / var_282_26

				if arg_279_1.var_.characterEffect1095ui_story and not isNil(var_282_24) then
					local var_282_28 = Mathf.Lerp(0, 0.5, var_282_27)

					arg_279_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1095ui_story.fillRatio = var_282_28
				end
			end

			if arg_279_1.time_ >= var_282_25 + var_282_26 and arg_279_1.time_ < var_282_25 + var_282_26 + arg_282_0 and not isNil(var_282_24) and arg_279_1.var_.characterEffect1095ui_story then
				local var_282_29 = 0.5

				arg_279_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1095ui_story.fillRatio = var_282_29
			end

			local var_282_30 = 0
			local var_282_31 = 1.25

			if var_282_30 < arg_279_1.time_ and arg_279_1.time_ <= var_282_30 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_32 = arg_279_1:GetWordFromCfg(411191068)
				local var_282_33 = arg_279_1:FormatText(var_282_32.content)

				arg_279_1.text_.text = var_282_33

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_34 = 50
				local var_282_35 = utf8.len(var_282_33)
				local var_282_36 = var_282_34 <= 0 and var_282_31 or var_282_31 * (var_282_35 / var_282_34)

				if var_282_36 > 0 and var_282_31 < var_282_36 then
					arg_279_1.talkMaxDuration = var_282_36

					if var_282_36 + var_282_30 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_36 + var_282_30
					end
				end

				arg_279_1.text_.text = var_282_33
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_37 = math.max(var_282_31, arg_279_1.talkMaxDuration)

			if var_282_30 <= arg_279_1.time_ and arg_279_1.time_ < var_282_30 + var_282_37 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_30) / var_282_37

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_30 + var_282_37 and arg_279_1.time_ < var_282_30 + var_282_37 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411191069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 411191069
		arg_283_1.duration_ = 1.8

		local var_283_0 = {
			zh = 1.4,
			ja = 1.8
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
				arg_283_0:Play411191070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = "1024ui_story"

			if arg_283_1.actors_[var_286_0] == nil then
				local var_286_1 = Asset.Load("Char/" .. "1024ui_story")

				if not isNil(var_286_1) then
					local var_286_2 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_283_1.stage_.transform)

					var_286_2.name = var_286_0
					var_286_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_283_1.actors_[var_286_0] = var_286_2

					local var_286_3 = var_286_2:GetComponentInChildren(typeof(CharacterEffect))

					var_286_3.enabled = true

					local var_286_4 = GameObjectTools.GetOrAddComponent(var_286_2, typeof(DynamicBoneHelper))

					if var_286_4 then
						var_286_4:EnableDynamicBone(false)
					end

					arg_283_1:ShowWeapon(var_286_3.transform, false)

					arg_283_1.var_[var_286_0 .. "Animator"] = var_286_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_283_1.var_[var_286_0 .. "Animator"].applyRootMotion = true
					arg_283_1.var_[var_286_0 .. "LipSync"] = var_286_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_286_5 = arg_283_1.actors_["1024ui_story"].transform
			local var_286_6 = 0

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.var_.moveOldPos1024ui_story = var_286_5.localPosition
			end

			local var_286_7 = 0.001

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_7 then
				local var_286_8 = (arg_283_1.time_ - var_286_6) / var_286_7
				local var_286_9 = Vector3.New(0, -1, -6.05)

				var_286_5.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1024ui_story, var_286_9, var_286_8)

				local var_286_10 = manager.ui.mainCamera.transform.position - var_286_5.position

				var_286_5.forward = Vector3.New(var_286_10.x, var_286_10.y, var_286_10.z)

				local var_286_11 = var_286_5.localEulerAngles

				var_286_11.z = 0
				var_286_11.x = 0
				var_286_5.localEulerAngles = var_286_11
			end

			if arg_283_1.time_ >= var_286_6 + var_286_7 and arg_283_1.time_ < var_286_6 + var_286_7 + arg_286_0 then
				var_286_5.localPosition = Vector3.New(0, -1, -6.05)

				local var_286_12 = manager.ui.mainCamera.transform.position - var_286_5.position

				var_286_5.forward = Vector3.New(var_286_12.x, var_286_12.y, var_286_12.z)

				local var_286_13 = var_286_5.localEulerAngles

				var_286_13.z = 0
				var_286_13.x = 0
				var_286_5.localEulerAngles = var_286_13
			end

			local var_286_14 = arg_283_1.actors_["1024ui_story"]
			local var_286_15 = 0

			if var_286_15 < arg_283_1.time_ and arg_283_1.time_ <= var_286_15 + arg_286_0 and not isNil(var_286_14) and arg_283_1.var_.characterEffect1024ui_story == nil then
				arg_283_1.var_.characterEffect1024ui_story = var_286_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_16 = 0.200000002980232

			if var_286_15 <= arg_283_1.time_ and arg_283_1.time_ < var_286_15 + var_286_16 and not isNil(var_286_14) then
				local var_286_17 = (arg_283_1.time_ - var_286_15) / var_286_16

				if arg_283_1.var_.characterEffect1024ui_story and not isNil(var_286_14) then
					arg_283_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_15 + var_286_16 and arg_283_1.time_ < var_286_15 + var_286_16 + arg_286_0 and not isNil(var_286_14) and arg_283_1.var_.characterEffect1024ui_story then
				arg_283_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_286_18 = 0

			if var_286_18 < arg_283_1.time_ and arg_283_1.time_ <= var_286_18 + arg_286_0 then
				arg_283_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_286_19 = 0

			if var_286_19 < arg_283_1.time_ and arg_283_1.time_ <= var_286_19 + arg_286_0 then
				arg_283_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_286_20 = 0
			local var_286_21 = 0.225

			if var_286_20 < arg_283_1.time_ and arg_283_1.time_ <= var_286_20 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_22 = arg_283_1:FormatText(StoryNameCfg[265].name)

				arg_283_1.leftNameTxt_.text = var_286_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_23 = arg_283_1:GetWordFromCfg(411191069)
				local var_286_24 = arg_283_1:FormatText(var_286_23.content)

				arg_283_1.text_.text = var_286_24

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_25 = 9
				local var_286_26 = utf8.len(var_286_24)
				local var_286_27 = var_286_25 <= 0 and var_286_21 or var_286_21 * (var_286_26 / var_286_25)

				if var_286_27 > 0 and var_286_21 < var_286_27 then
					arg_283_1.talkMaxDuration = var_286_27

					if var_286_27 + var_286_20 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_27 + var_286_20
					end
				end

				arg_283_1.text_.text = var_286_24
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191069", "story_v_out_411191.awb") ~= 0 then
					local var_286_28 = manager.audio:GetVoiceLength("story_v_out_411191", "411191069", "story_v_out_411191.awb") / 1000

					if var_286_28 + var_286_20 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_28 + var_286_20
					end

					if var_286_23.prefab_name ~= "" and arg_283_1.actors_[var_286_23.prefab_name] ~= nil then
						local var_286_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_23.prefab_name].transform, "story_v_out_411191", "411191069", "story_v_out_411191.awb")

						arg_283_1:RecordAudio("411191069", var_286_29)
						arg_283_1:RecordAudio("411191069", var_286_29)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_411191", "411191069", "story_v_out_411191.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_411191", "411191069", "story_v_out_411191.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_30 = math.max(var_286_21, arg_283_1.talkMaxDuration)

			if var_286_20 <= arg_283_1.time_ and arg_283_1.time_ < var_286_20 + var_286_30 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_20) / var_286_30

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_20 + var_286_30 and arg_283_1.time_ < var_286_20 + var_286_30 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play411191070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 411191070
		arg_287_1.duration_ = 6.1

		local var_287_0 = {
			zh = 4.933,
			ja = 6.1
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
				arg_287_0:Play411191071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1024ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1024ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(0, 100, 0)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1024ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, 100, 0)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["1024ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1024ui_story == nil then
				arg_287_1.var_.characterEffect1024ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect1024ui_story and not isNil(var_290_9) then
					local var_290_13 = Mathf.Lerp(0, 0.5, var_290_12)

					arg_287_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1024ui_story.fillRatio = var_290_13
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1024ui_story then
				local var_290_14 = 0.5

				arg_287_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1024ui_story.fillRatio = var_290_14
			end

			local var_290_15 = arg_287_1.actors_["4010ui_story"].transform
			local var_290_16 = 0

			if var_290_16 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1.var_.moveOldPos4010ui_story = var_290_15.localPosition
			end

			local var_290_17 = 0.001

			if var_290_16 <= arg_287_1.time_ and arg_287_1.time_ < var_290_16 + var_290_17 then
				local var_290_18 = (arg_287_1.time_ - var_290_16) / var_290_17
				local var_290_19 = Vector3.New(0, -1.59, -5.2)

				var_290_15.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos4010ui_story, var_290_19, var_290_18)

				local var_290_20 = manager.ui.mainCamera.transform.position - var_290_15.position

				var_290_15.forward = Vector3.New(var_290_20.x, var_290_20.y, var_290_20.z)

				local var_290_21 = var_290_15.localEulerAngles

				var_290_21.z = 0
				var_290_21.x = 0
				var_290_15.localEulerAngles = var_290_21
			end

			if arg_287_1.time_ >= var_290_16 + var_290_17 and arg_287_1.time_ < var_290_16 + var_290_17 + arg_290_0 then
				var_290_15.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_290_22 = manager.ui.mainCamera.transform.position - var_290_15.position

				var_290_15.forward = Vector3.New(var_290_22.x, var_290_22.y, var_290_22.z)

				local var_290_23 = var_290_15.localEulerAngles

				var_290_23.z = 0
				var_290_23.x = 0
				var_290_15.localEulerAngles = var_290_23
			end

			local var_290_24 = arg_287_1.actors_["4010ui_story"]
			local var_290_25 = 0

			if var_290_25 < arg_287_1.time_ and arg_287_1.time_ <= var_290_25 + arg_290_0 and not isNil(var_290_24) and arg_287_1.var_.characterEffect4010ui_story == nil then
				arg_287_1.var_.characterEffect4010ui_story = var_290_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_26 = 0.200000002980232

			if var_290_25 <= arg_287_1.time_ and arg_287_1.time_ < var_290_25 + var_290_26 and not isNil(var_290_24) then
				local var_290_27 = (arg_287_1.time_ - var_290_25) / var_290_26

				if arg_287_1.var_.characterEffect4010ui_story and not isNil(var_290_24) then
					arg_287_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_25 + var_290_26 and arg_287_1.time_ < var_290_25 + var_290_26 + arg_290_0 and not isNil(var_290_24) and arg_287_1.var_.characterEffect4010ui_story then
				arg_287_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_290_28 = 0

			if var_290_28 < arg_287_1.time_ and arg_287_1.time_ <= var_290_28 + arg_290_0 then
				arg_287_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_290_29 = 0
			local var_290_30 = 0.425

			if var_290_29 < arg_287_1.time_ and arg_287_1.time_ <= var_290_29 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_31 = arg_287_1:FormatText(StoryNameCfg[42].name)

				arg_287_1.leftNameTxt_.text = var_290_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_32 = arg_287_1:GetWordFromCfg(411191070)
				local var_290_33 = arg_287_1:FormatText(var_290_32.content)

				arg_287_1.text_.text = var_290_33

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_34 = 17
				local var_290_35 = utf8.len(var_290_33)
				local var_290_36 = var_290_34 <= 0 and var_290_30 or var_290_30 * (var_290_35 / var_290_34)

				if var_290_36 > 0 and var_290_30 < var_290_36 then
					arg_287_1.talkMaxDuration = var_290_36

					if var_290_36 + var_290_29 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_36 + var_290_29
					end
				end

				arg_287_1.text_.text = var_290_33
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191070", "story_v_out_411191.awb") ~= 0 then
					local var_290_37 = manager.audio:GetVoiceLength("story_v_out_411191", "411191070", "story_v_out_411191.awb") / 1000

					if var_290_37 + var_290_29 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_37 + var_290_29
					end

					if var_290_32.prefab_name ~= "" and arg_287_1.actors_[var_290_32.prefab_name] ~= nil then
						local var_290_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_32.prefab_name].transform, "story_v_out_411191", "411191070", "story_v_out_411191.awb")

						arg_287_1:RecordAudio("411191070", var_290_38)
						arg_287_1:RecordAudio("411191070", var_290_38)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_411191", "411191070", "story_v_out_411191.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_411191", "411191070", "story_v_out_411191.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_39 = math.max(var_290_30, arg_287_1.talkMaxDuration)

			if var_290_29 <= arg_287_1.time_ and arg_287_1.time_ < var_290_29 + var_290_39 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_29) / var_290_39

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_29 + var_290_39 and arg_287_1.time_ < var_290_29 + var_290_39 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play411191071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 411191071
		arg_291_1.duration_ = 3.7

		local var_291_0 = {
			zh = 3.7,
			ja = 3.433
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
				arg_291_0:Play411191072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1024ui_story"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos1024ui_story = var_294_0.localPosition
			end

			local var_294_2 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2
				local var_294_4 = Vector3.New(-0.7, -1, -6.05)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1024ui_story, var_294_4, var_294_3)

				local var_294_5 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_5.x, var_294_5.y, var_294_5.z)

				local var_294_6 = var_294_0.localEulerAngles

				var_294_6.z = 0
				var_294_6.x = 0
				var_294_0.localEulerAngles = var_294_6
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_294_7 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_7.x, var_294_7.y, var_294_7.z)

				local var_294_8 = var_294_0.localEulerAngles

				var_294_8.z = 0
				var_294_8.x = 0
				var_294_0.localEulerAngles = var_294_8
			end

			local var_294_9 = arg_291_1.actors_["1024ui_story"]
			local var_294_10 = 0

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 and not isNil(var_294_9) and arg_291_1.var_.characterEffect1024ui_story == nil then
				arg_291_1.var_.characterEffect1024ui_story = var_294_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_11 = 0.200000002980232

			if var_294_10 <= arg_291_1.time_ and arg_291_1.time_ < var_294_10 + var_294_11 and not isNil(var_294_9) then
				local var_294_12 = (arg_291_1.time_ - var_294_10) / var_294_11

				if arg_291_1.var_.characterEffect1024ui_story and not isNil(var_294_9) then
					arg_291_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_10 + var_294_11 and arg_291_1.time_ < var_294_10 + var_294_11 + arg_294_0 and not isNil(var_294_9) and arg_291_1.var_.characterEffect1024ui_story then
				arg_291_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_294_13 = 0

			if var_294_13 < arg_291_1.time_ and arg_291_1.time_ <= var_294_13 + arg_294_0 then
				arg_291_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_294_14 = 0

			if var_294_14 < arg_291_1.time_ and arg_291_1.time_ <= var_294_14 + arg_294_0 then
				arg_291_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_294_15 = arg_291_1.actors_["4010ui_story"].transform
			local var_294_16 = 0

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 then
				arg_291_1.var_.moveOldPos4010ui_story = var_294_15.localPosition
			end

			local var_294_17 = 0.001

			if var_294_16 <= arg_291_1.time_ and arg_291_1.time_ < var_294_16 + var_294_17 then
				local var_294_18 = (arg_291_1.time_ - var_294_16) / var_294_17
				local var_294_19 = Vector3.New(0.7, -1.59, -5.2)

				var_294_15.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos4010ui_story, var_294_19, var_294_18)

				local var_294_20 = manager.ui.mainCamera.transform.position - var_294_15.position

				var_294_15.forward = Vector3.New(var_294_20.x, var_294_20.y, var_294_20.z)

				local var_294_21 = var_294_15.localEulerAngles

				var_294_21.z = 0
				var_294_21.x = 0
				var_294_15.localEulerAngles = var_294_21
			end

			if arg_291_1.time_ >= var_294_16 + var_294_17 and arg_291_1.time_ < var_294_16 + var_294_17 + arg_294_0 then
				var_294_15.localPosition = Vector3.New(0.7, -1.59, -5.2)

				local var_294_22 = manager.ui.mainCamera.transform.position - var_294_15.position

				var_294_15.forward = Vector3.New(var_294_22.x, var_294_22.y, var_294_22.z)

				local var_294_23 = var_294_15.localEulerAngles

				var_294_23.z = 0
				var_294_23.x = 0
				var_294_15.localEulerAngles = var_294_23
			end

			local var_294_24 = arg_291_1.actors_["4010ui_story"]
			local var_294_25 = 0

			if var_294_25 < arg_291_1.time_ and arg_291_1.time_ <= var_294_25 + arg_294_0 and not isNil(var_294_24) and arg_291_1.var_.characterEffect4010ui_story == nil then
				arg_291_1.var_.characterEffect4010ui_story = var_294_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_26 = 0.200000002980232

			if var_294_25 <= arg_291_1.time_ and arg_291_1.time_ < var_294_25 + var_294_26 and not isNil(var_294_24) then
				local var_294_27 = (arg_291_1.time_ - var_294_25) / var_294_26

				if arg_291_1.var_.characterEffect4010ui_story and not isNil(var_294_24) then
					local var_294_28 = Mathf.Lerp(0, 0.5, var_294_27)

					arg_291_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_291_1.var_.characterEffect4010ui_story.fillRatio = var_294_28
				end
			end

			if arg_291_1.time_ >= var_294_25 + var_294_26 and arg_291_1.time_ < var_294_25 + var_294_26 + arg_294_0 and not isNil(var_294_24) and arg_291_1.var_.characterEffect4010ui_story then
				local var_294_29 = 0.5

				arg_291_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_291_1.var_.characterEffect4010ui_story.fillRatio = var_294_29
			end

			local var_294_30 = 0
			local var_294_31 = 0.5

			if var_294_30 < arg_291_1.time_ and arg_291_1.time_ <= var_294_30 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_32 = arg_291_1:FormatText(StoryNameCfg[265].name)

				arg_291_1.leftNameTxt_.text = var_294_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_33 = arg_291_1:GetWordFromCfg(411191071)
				local var_294_34 = arg_291_1:FormatText(var_294_33.content)

				arg_291_1.text_.text = var_294_34

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_35 = 20
				local var_294_36 = utf8.len(var_294_34)
				local var_294_37 = var_294_35 <= 0 and var_294_31 or var_294_31 * (var_294_36 / var_294_35)

				if var_294_37 > 0 and var_294_31 < var_294_37 then
					arg_291_1.talkMaxDuration = var_294_37

					if var_294_37 + var_294_30 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_37 + var_294_30
					end
				end

				arg_291_1.text_.text = var_294_34
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191071", "story_v_out_411191.awb") ~= 0 then
					local var_294_38 = manager.audio:GetVoiceLength("story_v_out_411191", "411191071", "story_v_out_411191.awb") / 1000

					if var_294_38 + var_294_30 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_38 + var_294_30
					end

					if var_294_33.prefab_name ~= "" and arg_291_1.actors_[var_294_33.prefab_name] ~= nil then
						local var_294_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_33.prefab_name].transform, "story_v_out_411191", "411191071", "story_v_out_411191.awb")

						arg_291_1:RecordAudio("411191071", var_294_39)
						arg_291_1:RecordAudio("411191071", var_294_39)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_411191", "411191071", "story_v_out_411191.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_411191", "411191071", "story_v_out_411191.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_40 = math.max(var_294_31, arg_291_1.talkMaxDuration)

			if var_294_30 <= arg_291_1.time_ and arg_291_1.time_ < var_294_30 + var_294_40 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_30) / var_294_40

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_30 + var_294_40 and arg_291_1.time_ < var_294_30 + var_294_40 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play411191072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 411191072
		arg_295_1.duration_ = 2.7

		local var_295_0 = {
			zh = 1.766,
			ja = 2.7
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play411191073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.275

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[265].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:GetWordFromCfg(411191072)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 11
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191072", "story_v_out_411191.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_411191", "411191072", "story_v_out_411191.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_411191", "411191072", "story_v_out_411191.awb")

						arg_295_1:RecordAudio("411191072", var_298_9)
						arg_295_1:RecordAudio("411191072", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_411191", "411191072", "story_v_out_411191.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_411191", "411191072", "story_v_out_411191.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_10 and arg_295_1.time_ < var_298_0 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play411191073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 411191073
		arg_299_1.duration_ = 9.77

		local var_299_0 = {
			zh = 7.4,
			ja = 9.766
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play411191074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1024ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1024ui_story == nil then
				arg_299_1.var_.characterEffect1024ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1024ui_story and not isNil(var_302_0) then
					local var_302_4 = Mathf.Lerp(0, 0.5, var_302_3)

					arg_299_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1024ui_story.fillRatio = var_302_4
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1024ui_story then
				local var_302_5 = 0.5

				arg_299_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1024ui_story.fillRatio = var_302_5
			end

			local var_302_6 = arg_299_1.actors_["4010ui_story"]
			local var_302_7 = 0

			if var_302_7 < arg_299_1.time_ and arg_299_1.time_ <= var_302_7 + arg_302_0 and not isNil(var_302_6) and arg_299_1.var_.characterEffect4010ui_story == nil then
				arg_299_1.var_.characterEffect4010ui_story = var_302_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_8 = 0.200000002980232

			if var_302_7 <= arg_299_1.time_ and arg_299_1.time_ < var_302_7 + var_302_8 and not isNil(var_302_6) then
				local var_302_9 = (arg_299_1.time_ - var_302_7) / var_302_8

				if arg_299_1.var_.characterEffect4010ui_story and not isNil(var_302_6) then
					arg_299_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_7 + var_302_8 and arg_299_1.time_ < var_302_7 + var_302_8 + arg_302_0 and not isNil(var_302_6) and arg_299_1.var_.characterEffect4010ui_story then
				arg_299_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_302_10 = 0

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 then
				arg_299_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			local var_302_11 = 0

			if var_302_11 < arg_299_1.time_ and arg_299_1.time_ <= var_302_11 + arg_302_0 then
				arg_299_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_302_12 = 0
			local var_302_13 = 0.85

			if var_302_12 < arg_299_1.time_ and arg_299_1.time_ <= var_302_12 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_14 = arg_299_1:FormatText(StoryNameCfg[42].name)

				arg_299_1.leftNameTxt_.text = var_302_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_15 = arg_299_1:GetWordFromCfg(411191073)
				local var_302_16 = arg_299_1:FormatText(var_302_15.content)

				arg_299_1.text_.text = var_302_16

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_17 = 34
				local var_302_18 = utf8.len(var_302_16)
				local var_302_19 = var_302_17 <= 0 and var_302_13 or var_302_13 * (var_302_18 / var_302_17)

				if var_302_19 > 0 and var_302_13 < var_302_19 then
					arg_299_1.talkMaxDuration = var_302_19

					if var_302_19 + var_302_12 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_19 + var_302_12
					end
				end

				arg_299_1.text_.text = var_302_16
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191073", "story_v_out_411191.awb") ~= 0 then
					local var_302_20 = manager.audio:GetVoiceLength("story_v_out_411191", "411191073", "story_v_out_411191.awb") / 1000

					if var_302_20 + var_302_12 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_20 + var_302_12
					end

					if var_302_15.prefab_name ~= "" and arg_299_1.actors_[var_302_15.prefab_name] ~= nil then
						local var_302_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_15.prefab_name].transform, "story_v_out_411191", "411191073", "story_v_out_411191.awb")

						arg_299_1:RecordAudio("411191073", var_302_21)
						arg_299_1:RecordAudio("411191073", var_302_21)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_411191", "411191073", "story_v_out_411191.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_411191", "411191073", "story_v_out_411191.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_22 = math.max(var_302_13, arg_299_1.talkMaxDuration)

			if var_302_12 <= arg_299_1.time_ and arg_299_1.time_ < var_302_12 + var_302_22 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_12) / var_302_22

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_12 + var_302_22 and arg_299_1.time_ < var_302_12 + var_302_22 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play411191074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 411191074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play411191075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["4010ui_story"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos4010ui_story = var_306_0.localPosition
			end

			local var_306_2 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2
				local var_306_4 = Vector3.New(0, 100, 0)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos4010ui_story, var_306_4, var_306_3)

				local var_306_5 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_5.x, var_306_5.y, var_306_5.z)

				local var_306_6 = var_306_0.localEulerAngles

				var_306_6.z = 0
				var_306_6.x = 0
				var_306_0.localEulerAngles = var_306_6
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(0, 100, 0)

				local var_306_7 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_7.x, var_306_7.y, var_306_7.z)

				local var_306_8 = var_306_0.localEulerAngles

				var_306_8.z = 0
				var_306_8.x = 0
				var_306_0.localEulerAngles = var_306_8
			end

			local var_306_9 = arg_303_1.actors_["4010ui_story"]
			local var_306_10 = 0

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect4010ui_story == nil then
				arg_303_1.var_.characterEffect4010ui_story = var_306_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_11 = 0.200000002980232

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_11 and not isNil(var_306_9) then
				local var_306_12 = (arg_303_1.time_ - var_306_10) / var_306_11

				if arg_303_1.var_.characterEffect4010ui_story and not isNil(var_306_9) then
					local var_306_13 = Mathf.Lerp(0, 0.5, var_306_12)

					arg_303_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_303_1.var_.characterEffect4010ui_story.fillRatio = var_306_13
				end
			end

			if arg_303_1.time_ >= var_306_10 + var_306_11 and arg_303_1.time_ < var_306_10 + var_306_11 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect4010ui_story then
				local var_306_14 = 0.5

				arg_303_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_303_1.var_.characterEffect4010ui_story.fillRatio = var_306_14
			end

			local var_306_15 = arg_303_1.actors_["1024ui_story"].transform
			local var_306_16 = 0

			if var_306_16 < arg_303_1.time_ and arg_303_1.time_ <= var_306_16 + arg_306_0 then
				arg_303_1.var_.moveOldPos1024ui_story = var_306_15.localPosition
			end

			local var_306_17 = 0.001

			if var_306_16 <= arg_303_1.time_ and arg_303_1.time_ < var_306_16 + var_306_17 then
				local var_306_18 = (arg_303_1.time_ - var_306_16) / var_306_17
				local var_306_19 = Vector3.New(0, 100, 0)

				var_306_15.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1024ui_story, var_306_19, var_306_18)

				local var_306_20 = manager.ui.mainCamera.transform.position - var_306_15.position

				var_306_15.forward = Vector3.New(var_306_20.x, var_306_20.y, var_306_20.z)

				local var_306_21 = var_306_15.localEulerAngles

				var_306_21.z = 0
				var_306_21.x = 0
				var_306_15.localEulerAngles = var_306_21
			end

			if arg_303_1.time_ >= var_306_16 + var_306_17 and arg_303_1.time_ < var_306_16 + var_306_17 + arg_306_0 then
				var_306_15.localPosition = Vector3.New(0, 100, 0)

				local var_306_22 = manager.ui.mainCamera.transform.position - var_306_15.position

				var_306_15.forward = Vector3.New(var_306_22.x, var_306_22.y, var_306_22.z)

				local var_306_23 = var_306_15.localEulerAngles

				var_306_23.z = 0
				var_306_23.x = 0
				var_306_15.localEulerAngles = var_306_23
			end

			local var_306_24 = arg_303_1.actors_["1024ui_story"]
			local var_306_25 = 0

			if var_306_25 < arg_303_1.time_ and arg_303_1.time_ <= var_306_25 + arg_306_0 and not isNil(var_306_24) and arg_303_1.var_.characterEffect1024ui_story == nil then
				arg_303_1.var_.characterEffect1024ui_story = var_306_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_26 = 0.200000002980232

			if var_306_25 <= arg_303_1.time_ and arg_303_1.time_ < var_306_25 + var_306_26 and not isNil(var_306_24) then
				local var_306_27 = (arg_303_1.time_ - var_306_25) / var_306_26

				if arg_303_1.var_.characterEffect1024ui_story and not isNil(var_306_24) then
					local var_306_28 = Mathf.Lerp(0, 0.5, var_306_27)

					arg_303_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1024ui_story.fillRatio = var_306_28
				end
			end

			if arg_303_1.time_ >= var_306_25 + var_306_26 and arg_303_1.time_ < var_306_25 + var_306_26 + arg_306_0 and not isNil(var_306_24) and arg_303_1.var_.characterEffect1024ui_story then
				local var_306_29 = 0.5

				arg_303_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1024ui_story.fillRatio = var_306_29
			end

			local var_306_30 = 0
			local var_306_31 = 0.200000002980232

			if var_306_30 < arg_303_1.time_ and arg_303_1.time_ <= var_306_30 + arg_306_0 then
				local var_306_32 = "play"
				local var_306_33 = "music"

				arg_303_1:AudioAction(var_306_32, var_306_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_306_34 = ""
				local var_306_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_306_35 ~= "" then
					if arg_303_1.bgmTxt_.text ~= var_306_35 and arg_303_1.bgmTxt_.text ~= "" then
						if arg_303_1.bgmTxt2_.text ~= "" then
							arg_303_1.bgmTxt_.text = arg_303_1.bgmTxt2_.text
						end

						arg_303_1.bgmTxt2_.text = var_306_35

						arg_303_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_303_1.bgmTxt_.text = var_306_35
						arg_303_1.bgmTxt2_.text = var_306_35
					end

					if arg_303_1.bgmTimer then
						arg_303_1.bgmTimer:Stop()

						arg_303_1.bgmTimer = nil
					end

					if arg_303_1.settingData.show_music_name == 1 then
						arg_303_1.musicController:SetSelectedState("show")
						arg_303_1.musicAnimator_:Play("open", 0, 0)

						if arg_303_1.settingData.music_time ~= 0 then
							arg_303_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_303_1.settingData.music_time), function()
								if arg_303_1 == nil or isNil(arg_303_1.bgmTxt_) then
									return
								end

								arg_303_1.musicController:SetSelectedState("hide")
								arg_303_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_306_36 = 0.233333333333333
			local var_306_37 = 0.3

			if var_306_36 < arg_303_1.time_ and arg_303_1.time_ <= var_306_36 + arg_306_0 then
				local var_306_38 = "play"
				local var_306_39 = "music"

				arg_303_1:AudioAction(var_306_38, var_306_39, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_306_40 = ""
				local var_306_41 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_306_41 ~= "" then
					if arg_303_1.bgmTxt_.text ~= var_306_41 and arg_303_1.bgmTxt_.text ~= "" then
						if arg_303_1.bgmTxt2_.text ~= "" then
							arg_303_1.bgmTxt_.text = arg_303_1.bgmTxt2_.text
						end

						arg_303_1.bgmTxt2_.text = var_306_41

						arg_303_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_303_1.bgmTxt_.text = var_306_41
						arg_303_1.bgmTxt2_.text = var_306_41
					end

					if arg_303_1.bgmTimer then
						arg_303_1.bgmTimer:Stop()

						arg_303_1.bgmTimer = nil
					end

					if arg_303_1.settingData.show_music_name == 1 then
						arg_303_1.musicController:SetSelectedState("show")
						arg_303_1.musicAnimator_:Play("open", 0, 0)

						if arg_303_1.settingData.music_time ~= 0 then
							arg_303_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_303_1.settingData.music_time), function()
								if arg_303_1 == nil or isNil(arg_303_1.bgmTxt_) then
									return
								end

								arg_303_1.musicController:SetSelectedState("hide")
								arg_303_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_306_42 = 0
			local var_306_43 = 0.3

			if var_306_42 < arg_303_1.time_ and arg_303_1.time_ <= var_306_42 + arg_306_0 then
				local var_306_44 = "play"
				local var_306_45 = "effect"

				arg_303_1:AudioAction(var_306_44, var_306_45, "se_story_127", "se_story_127_hit", "")
			end

			local var_306_46 = 0.200000002980232

			if var_306_46 < arg_303_1.time_ and arg_303_1.time_ <= var_306_46 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = true

				arg_303_1:SetGaussion(false)
			end

			local var_306_47 = 0.3

			if var_306_46 <= arg_303_1.time_ and arg_303_1.time_ < var_306_46 + var_306_47 then
				local var_306_48 = (arg_303_1.time_ - var_306_46) / var_306_47
				local var_306_49 = Color.New(1, 1, 1)

				var_306_49.a = Mathf.Lerp(1, 0, var_306_48)
				arg_303_1.mask_.color = var_306_49
			end

			if arg_303_1.time_ >= var_306_46 + var_306_47 and arg_303_1.time_ < var_306_46 + var_306_47 + arg_306_0 then
				local var_306_50 = Color.New(1, 1, 1)
				local var_306_51 = 0

				arg_303_1.mask_.enabled = false
				var_306_50.a = var_306_51
				arg_303_1.mask_.color = var_306_50
			end

			local var_306_52 = 0.533333333333333

			if var_306_52 < arg_303_1.time_ and arg_303_1.time_ <= var_306_52 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = true

				arg_303_1:SetGaussion(false)
			end

			local var_306_53 = 0.3

			if var_306_52 <= arg_303_1.time_ and arg_303_1.time_ < var_306_52 + var_306_53 then
				local var_306_54 = (arg_303_1.time_ - var_306_52) / var_306_53
				local var_306_55 = Color.New(1, 1, 1)

				var_306_55.a = Mathf.Lerp(1, 0, var_306_54)
				arg_303_1.mask_.color = var_306_55
			end

			if arg_303_1.time_ >= var_306_52 + var_306_53 and arg_303_1.time_ < var_306_52 + var_306_53 + arg_306_0 then
				local var_306_56 = Color.New(1, 1, 1)
				local var_306_57 = 0

				arg_303_1.mask_.enabled = false
				var_306_56.a = var_306_57
				arg_303_1.mask_.color = var_306_56
			end

			local var_306_58 = manager.ui.mainCamera.transform
			local var_306_59 = 0.200000002980232

			if var_306_59 < arg_303_1.time_ and arg_303_1.time_ <= var_306_59 + arg_306_0 then
				arg_303_1.var_.shakeOldPos = var_306_58.localPosition
			end

			local var_306_60 = 0.633333330353101

			if var_306_59 <= arg_303_1.time_ and arg_303_1.time_ < var_306_59 + var_306_60 then
				local var_306_61 = (arg_303_1.time_ - var_306_59) / 0.066
				local var_306_62, var_306_63 = math.modf(var_306_61)

				var_306_58.localPosition = Vector3.New(var_306_63 * 0.13, var_306_63 * 0.13, var_306_63 * 0.13) + arg_303_1.var_.shakeOldPos
			end

			if arg_303_1.time_ >= var_306_59 + var_306_60 and arg_303_1.time_ < var_306_59 + var_306_60 + arg_306_0 then
				var_306_58.localPosition = arg_303_1.var_.shakeOldPos
			end

			local var_306_64 = 0
			local var_306_65 = 0.9

			if var_306_64 < arg_303_1.time_ and arg_303_1.time_ <= var_306_64 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_66 = arg_303_1:GetWordFromCfg(411191074)
				local var_306_67 = arg_303_1:FormatText(var_306_66.content)

				arg_303_1.text_.text = var_306_67

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_68 = 36
				local var_306_69 = utf8.len(var_306_67)
				local var_306_70 = var_306_68 <= 0 and var_306_65 or var_306_65 * (var_306_69 / var_306_68)

				if var_306_70 > 0 and var_306_65 < var_306_70 then
					arg_303_1.talkMaxDuration = var_306_70

					if var_306_70 + var_306_64 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_70 + var_306_64
					end
				end

				arg_303_1.text_.text = var_306_67
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_71 = math.max(var_306_65, arg_303_1.talkMaxDuration)

			if var_306_64 <= arg_303_1.time_ and arg_303_1.time_ < var_306_64 + var_306_71 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_64) / var_306_71

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_64 + var_306_71 and arg_303_1.time_ < var_306_64 + var_306_71 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play411191075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 411191075
		arg_309_1.duration_ = 2

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play411191076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1024ui_story"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos1024ui_story = var_312_0.localPosition
			end

			local var_312_2 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2
				local var_312_4 = Vector3.New(0, -1, -6.05)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1024ui_story, var_312_4, var_312_3)

				local var_312_5 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_5.x, var_312_5.y, var_312_5.z)

				local var_312_6 = var_312_0.localEulerAngles

				var_312_6.z = 0
				var_312_6.x = 0
				var_312_0.localEulerAngles = var_312_6
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_312_7 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_7.x, var_312_7.y, var_312_7.z)

				local var_312_8 = var_312_0.localEulerAngles

				var_312_8.z = 0
				var_312_8.x = 0
				var_312_0.localEulerAngles = var_312_8
			end

			local var_312_9 = arg_309_1.actors_["1024ui_story"]
			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1024ui_story == nil then
				arg_309_1.var_.characterEffect1024ui_story = var_312_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_11 = 0.200000002980232

			if var_312_10 <= arg_309_1.time_ and arg_309_1.time_ < var_312_10 + var_312_11 and not isNil(var_312_9) then
				local var_312_12 = (arg_309_1.time_ - var_312_10) / var_312_11

				if arg_309_1.var_.characterEffect1024ui_story and not isNil(var_312_9) then
					arg_309_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_10 + var_312_11 and arg_309_1.time_ < var_312_10 + var_312_11 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1024ui_story then
				arg_309_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_312_13 = 0

			if var_312_13 < arg_309_1.time_ and arg_309_1.time_ <= var_312_13 + arg_312_0 then
				arg_309_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action7_1")
			end

			local var_312_14 = 0

			if var_312_14 < arg_309_1.time_ and arg_309_1.time_ <= var_312_14 + arg_312_0 then
				arg_309_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_312_15 = 0
			local var_312_16 = 0.175

			if var_312_15 < arg_309_1.time_ and arg_309_1.time_ <= var_312_15 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_17 = arg_309_1:FormatText(StoryNameCfg[265].name)

				arg_309_1.leftNameTxt_.text = var_312_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_18 = arg_309_1:GetWordFromCfg(411191075)
				local var_312_19 = arg_309_1:FormatText(var_312_18.content)

				arg_309_1.text_.text = var_312_19

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_20 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191075", "story_v_out_411191.awb") ~= 0 then
					local var_312_23 = manager.audio:GetVoiceLength("story_v_out_411191", "411191075", "story_v_out_411191.awb") / 1000

					if var_312_23 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_23 + var_312_15
					end

					if var_312_18.prefab_name ~= "" and arg_309_1.actors_[var_312_18.prefab_name] ~= nil then
						local var_312_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_18.prefab_name].transform, "story_v_out_411191", "411191075", "story_v_out_411191.awb")

						arg_309_1:RecordAudio("411191075", var_312_24)
						arg_309_1:RecordAudio("411191075", var_312_24)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_411191", "411191075", "story_v_out_411191.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_411191", "411191075", "story_v_out_411191.awb")
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
				actorName = "1024ui_story",
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
	Play411191076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 411191076
		arg_313_1.duration_ = 2.13

		local var_313_0 = {
			zh = 1.999999999999,
			ja = 2.133
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
				arg_313_0:Play411191077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1024ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos1024ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0, 100, 0)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1024ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, 100, 0)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = arg_313_1.actors_["1024ui_story"]
			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1024ui_story == nil then
				arg_313_1.var_.characterEffect1024ui_story = var_316_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_11 = 0.200000002980232

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_11 and not isNil(var_316_9) then
				local var_316_12 = (arg_313_1.time_ - var_316_10) / var_316_11

				if arg_313_1.var_.characterEffect1024ui_story and not isNil(var_316_9) then
					local var_316_13 = Mathf.Lerp(0, 0.5, var_316_12)

					arg_313_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1024ui_story.fillRatio = var_316_13
				end
			end

			if arg_313_1.time_ >= var_316_10 + var_316_11 and arg_313_1.time_ < var_316_10 + var_316_11 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1024ui_story then
				local var_316_14 = 0.5

				arg_313_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1024ui_story.fillRatio = var_316_14
			end

			local var_316_15 = arg_313_1.actors_["4010ui_story"].transform
			local var_316_16 = 0

			if var_316_16 < arg_313_1.time_ and arg_313_1.time_ <= var_316_16 + arg_316_0 then
				arg_313_1.var_.moveOldPos4010ui_story = var_316_15.localPosition
			end

			local var_316_17 = 0.001

			if var_316_16 <= arg_313_1.time_ and arg_313_1.time_ < var_316_16 + var_316_17 then
				local var_316_18 = (arg_313_1.time_ - var_316_16) / var_316_17
				local var_316_19 = Vector3.New(0, -1.59, -5.2)

				var_316_15.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos4010ui_story, var_316_19, var_316_18)

				local var_316_20 = manager.ui.mainCamera.transform.position - var_316_15.position

				var_316_15.forward = Vector3.New(var_316_20.x, var_316_20.y, var_316_20.z)

				local var_316_21 = var_316_15.localEulerAngles

				var_316_21.z = 0
				var_316_21.x = 0
				var_316_15.localEulerAngles = var_316_21
			end

			if arg_313_1.time_ >= var_316_16 + var_316_17 and arg_313_1.time_ < var_316_16 + var_316_17 + arg_316_0 then
				var_316_15.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_316_22 = manager.ui.mainCamera.transform.position - var_316_15.position

				var_316_15.forward = Vector3.New(var_316_22.x, var_316_22.y, var_316_22.z)

				local var_316_23 = var_316_15.localEulerAngles

				var_316_23.z = 0
				var_316_23.x = 0
				var_316_15.localEulerAngles = var_316_23
			end

			local var_316_24 = arg_313_1.actors_["4010ui_story"]
			local var_316_25 = 0

			if var_316_25 < arg_313_1.time_ and arg_313_1.time_ <= var_316_25 + arg_316_0 and not isNil(var_316_24) and arg_313_1.var_.characterEffect4010ui_story == nil then
				arg_313_1.var_.characterEffect4010ui_story = var_316_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_26 = 0.200000002980232

			if var_316_25 <= arg_313_1.time_ and arg_313_1.time_ < var_316_25 + var_316_26 and not isNil(var_316_24) then
				local var_316_27 = (arg_313_1.time_ - var_316_25) / var_316_26

				if arg_313_1.var_.characterEffect4010ui_story and not isNil(var_316_24) then
					arg_313_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_25 + var_316_26 and arg_313_1.time_ < var_316_25 + var_316_26 + arg_316_0 and not isNil(var_316_24) and arg_313_1.var_.characterEffect4010ui_story then
				arg_313_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_316_28 = 0

			if var_316_28 < arg_313_1.time_ and arg_313_1.time_ <= var_316_28 + arg_316_0 then
				arg_313_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_2")
			end

			local var_316_29 = 0

			if var_316_29 < arg_313_1.time_ and arg_313_1.time_ <= var_316_29 + arg_316_0 then
				arg_313_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_316_30 = 0
			local var_316_31 = 0.225

			if var_316_30 < arg_313_1.time_ and arg_313_1.time_ <= var_316_30 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_32 = arg_313_1:FormatText(StoryNameCfg[42].name)

				arg_313_1.leftNameTxt_.text = var_316_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_33 = arg_313_1:GetWordFromCfg(411191076)
				local var_316_34 = arg_313_1:FormatText(var_316_33.content)

				arg_313_1.text_.text = var_316_34

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_35 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191076", "story_v_out_411191.awb") ~= 0 then
					local var_316_38 = manager.audio:GetVoiceLength("story_v_out_411191", "411191076", "story_v_out_411191.awb") / 1000

					if var_316_38 + var_316_30 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_38 + var_316_30
					end

					if var_316_33.prefab_name ~= "" and arg_313_1.actors_[var_316_33.prefab_name] ~= nil then
						local var_316_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_33.prefab_name].transform, "story_v_out_411191", "411191076", "story_v_out_411191.awb")

						arg_313_1:RecordAudio("411191076", var_316_39)
						arg_313_1:RecordAudio("411191076", var_316_39)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_411191", "411191076", "story_v_out_411191.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_411191", "411191076", "story_v_out_411191.awb")
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
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411191077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 411191077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play411191078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["4010ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect4010ui_story == nil then
				arg_317_1.var_.characterEffect4010ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect4010ui_story and not isNil(var_320_0) then
					local var_320_4 = Mathf.Lerp(0, 0.5, var_320_3)

					arg_317_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_317_1.var_.characterEffect4010ui_story.fillRatio = var_320_4
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect4010ui_story then
				local var_320_5 = 0.5

				arg_317_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_317_1.var_.characterEffect4010ui_story.fillRatio = var_320_5
			end

			local var_320_6 = arg_317_1.actors_["4010ui_story"].transform
			local var_320_7 = 0

			if var_320_7 < arg_317_1.time_ and arg_317_1.time_ <= var_320_7 + arg_320_0 then
				arg_317_1.var_.moveOldPos4010ui_story = var_320_6.localPosition
			end

			local var_320_8 = 0.001

			if var_320_7 <= arg_317_1.time_ and arg_317_1.time_ < var_320_7 + var_320_8 then
				local var_320_9 = (arg_317_1.time_ - var_320_7) / var_320_8
				local var_320_10 = Vector3.New(0, 100, 0)

				var_320_6.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos4010ui_story, var_320_10, var_320_9)

				local var_320_11 = manager.ui.mainCamera.transform.position - var_320_6.position

				var_320_6.forward = Vector3.New(var_320_11.x, var_320_11.y, var_320_11.z)

				local var_320_12 = var_320_6.localEulerAngles

				var_320_12.z = 0
				var_320_12.x = 0
				var_320_6.localEulerAngles = var_320_12
			end

			if arg_317_1.time_ >= var_320_7 + var_320_8 and arg_317_1.time_ < var_320_7 + var_320_8 + arg_320_0 then
				var_320_6.localPosition = Vector3.New(0, 100, 0)

				local var_320_13 = manager.ui.mainCamera.transform.position - var_320_6.position

				var_320_6.forward = Vector3.New(var_320_13.x, var_320_13.y, var_320_13.z)

				local var_320_14 = var_320_6.localEulerAngles

				var_320_14.z = 0
				var_320_14.x = 0
				var_320_6.localEulerAngles = var_320_14
			end

			local var_320_15 = 0
			local var_320_16 = 0.825

			if var_320_15 < arg_317_1.time_ and arg_317_1.time_ <= var_320_15 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_17 = arg_317_1:GetWordFromCfg(411191077)
				local var_320_18 = arg_317_1:FormatText(var_320_17.content)

				arg_317_1.text_.text = var_320_18

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_19 = 33
				local var_320_20 = utf8.len(var_320_18)
				local var_320_21 = var_320_19 <= 0 and var_320_16 or var_320_16 * (var_320_20 / var_320_19)

				if var_320_21 > 0 and var_320_16 < var_320_21 then
					arg_317_1.talkMaxDuration = var_320_21

					if var_320_21 + var_320_15 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_21 + var_320_15
					end
				end

				arg_317_1.text_.text = var_320_18
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_22 = math.max(var_320_16, arg_317_1.talkMaxDuration)

			if var_320_15 <= arg_317_1.time_ and arg_317_1.time_ < var_320_15 + var_320_22 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_15) / var_320_22

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_15 + var_320_22 and arg_317_1.time_ < var_320_15 + var_320_22 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411191078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 411191078
		arg_321_1.duration_ = 1.13

		local var_321_0 = {
			zh = 1.1,
			ja = 1.133
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play411191079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["4010ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos4010ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(0, 100, 0)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos4010ui_story, var_324_4, var_324_3)

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

			local var_324_9 = arg_321_1.actors_["4010ui_story"]
			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect4010ui_story == nil then
				arg_321_1.var_.characterEffect4010ui_story = var_324_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_11 = 0.200000002980232

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_11 and not isNil(var_324_9) then
				local var_324_12 = (arg_321_1.time_ - var_324_10) / var_324_11

				if arg_321_1.var_.characterEffect4010ui_story and not isNil(var_324_9) then
					local var_324_13 = Mathf.Lerp(0, 0.5, var_324_12)

					arg_321_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_321_1.var_.characterEffect4010ui_story.fillRatio = var_324_13
				end
			end

			if arg_321_1.time_ >= var_324_10 + var_324_11 and arg_321_1.time_ < var_324_10 + var_324_11 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect4010ui_story then
				local var_324_14 = 0.5

				arg_321_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_321_1.var_.characterEffect4010ui_story.fillRatio = var_324_14
			end

			local var_324_15 = 0
			local var_324_16 = 0.125

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_17 = arg_321_1:FormatText(StoryNameCfg[471].name)

				arg_321_1.leftNameTxt_.text = var_324_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_18 = arg_321_1:GetWordFromCfg(411191078)
				local var_324_19 = arg_321_1:FormatText(var_324_18.content)

				arg_321_1.text_.text = var_324_19

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_20 = 5
				local var_324_21 = utf8.len(var_324_19)
				local var_324_22 = var_324_20 <= 0 and var_324_16 or var_324_16 * (var_324_21 / var_324_20)

				if var_324_22 > 0 and var_324_16 < var_324_22 then
					arg_321_1.talkMaxDuration = var_324_22

					if var_324_22 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_22 + var_324_15
					end
				end

				arg_321_1.text_.text = var_324_19
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191078", "story_v_out_411191.awb") ~= 0 then
					local var_324_23 = manager.audio:GetVoiceLength("story_v_out_411191", "411191078", "story_v_out_411191.awb") / 1000

					if var_324_23 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_15
					end

					if var_324_18.prefab_name ~= "" and arg_321_1.actors_[var_324_18.prefab_name] ~= nil then
						local var_324_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_18.prefab_name].transform, "story_v_out_411191", "411191078", "story_v_out_411191.awb")

						arg_321_1:RecordAudio("411191078", var_324_24)
						arg_321_1:RecordAudio("411191078", var_324_24)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_411191", "411191078", "story_v_out_411191.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_411191", "411191078", "story_v_out_411191.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_25 = math.max(var_324_16, arg_321_1.talkMaxDuration)

			if var_324_15 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_25 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_15) / var_324_25

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_15 + var_324_25 and arg_321_1.time_ < var_324_15 + var_324_25 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411191079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 411191079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play411191080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1095ui_story"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1095ui_story = var_328_0.localPosition
			end

			local var_328_2 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(0, 100, 0)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1095ui_story, var_328_4, var_328_3)

				local var_328_5 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_5.x, var_328_5.y, var_328_5.z)

				local var_328_6 = var_328_0.localEulerAngles

				var_328_6.z = 0
				var_328_6.x = 0
				var_328_0.localEulerAngles = var_328_6
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, 100, 0)

				local var_328_7 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_7.x, var_328_7.y, var_328_7.z)

				local var_328_8 = var_328_0.localEulerAngles

				var_328_8.z = 0
				var_328_8.x = 0
				var_328_0.localEulerAngles = var_328_8
			end

			local var_328_9 = arg_325_1.actors_["1095ui_story"]
			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1095ui_story == nil then
				arg_325_1.var_.characterEffect1095ui_story = var_328_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_11 = 0.200000002980232

			if var_328_10 <= arg_325_1.time_ and arg_325_1.time_ < var_328_10 + var_328_11 and not isNil(var_328_9) then
				local var_328_12 = (arg_325_1.time_ - var_328_10) / var_328_11

				if arg_325_1.var_.characterEffect1095ui_story and not isNil(var_328_9) then
					local var_328_13 = Mathf.Lerp(0, 0.5, var_328_12)

					arg_325_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1095ui_story.fillRatio = var_328_13
				end
			end

			if arg_325_1.time_ >= var_328_10 + var_328_11 and arg_325_1.time_ < var_328_10 + var_328_11 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1095ui_story then
				local var_328_14 = 0.5

				arg_325_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1095ui_story.fillRatio = var_328_14
			end

			local var_328_15 = 0
			local var_328_16 = 1.175

			if var_328_15 < arg_325_1.time_ and arg_325_1.time_ <= var_328_15 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_17 = arg_325_1:GetWordFromCfg(411191079)
				local var_328_18 = arg_325_1:FormatText(var_328_17.content)

				arg_325_1.text_.text = var_328_18

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_19 = 47
				local var_328_20 = utf8.len(var_328_18)
				local var_328_21 = var_328_19 <= 0 and var_328_16 or var_328_16 * (var_328_20 / var_328_19)

				if var_328_21 > 0 and var_328_16 < var_328_21 then
					arg_325_1.talkMaxDuration = var_328_21

					if var_328_21 + var_328_15 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_21 + var_328_15
					end
				end

				arg_325_1.text_.text = var_328_18
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_22 = math.max(var_328_16, arg_325_1.talkMaxDuration)

			if var_328_15 <= arg_325_1.time_ and arg_325_1.time_ < var_328_15 + var_328_22 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_15) / var_328_22

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_15 + var_328_22 and arg_325_1.time_ < var_328_15 + var_328_22 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411191080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 411191080
		arg_329_1.duration_ = 2

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play411191081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1024ui_story"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos1024ui_story = var_332_0.localPosition
			end

			local var_332_2 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2
				local var_332_4 = Vector3.New(0, -1, -6.05)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1024ui_story, var_332_4, var_332_3)

				local var_332_5 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_5.x, var_332_5.y, var_332_5.z)

				local var_332_6 = var_332_0.localEulerAngles

				var_332_6.z = 0
				var_332_6.x = 0
				var_332_0.localEulerAngles = var_332_6
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_332_7 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_7.x, var_332_7.y, var_332_7.z)

				local var_332_8 = var_332_0.localEulerAngles

				var_332_8.z = 0
				var_332_8.x = 0
				var_332_0.localEulerAngles = var_332_8
			end

			local var_332_9 = arg_329_1.actors_["1024ui_story"]
			local var_332_10 = 0

			if var_332_10 < arg_329_1.time_ and arg_329_1.time_ <= var_332_10 + arg_332_0 and not isNil(var_332_9) and arg_329_1.var_.characterEffect1024ui_story == nil then
				arg_329_1.var_.characterEffect1024ui_story = var_332_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_11 = 0.200000002980232

			if var_332_10 <= arg_329_1.time_ and arg_329_1.time_ < var_332_10 + var_332_11 and not isNil(var_332_9) then
				local var_332_12 = (arg_329_1.time_ - var_332_10) / var_332_11

				if arg_329_1.var_.characterEffect1024ui_story and not isNil(var_332_9) then
					arg_329_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_10 + var_332_11 and arg_329_1.time_ < var_332_10 + var_332_11 + arg_332_0 and not isNil(var_332_9) and arg_329_1.var_.characterEffect1024ui_story then
				arg_329_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_332_13 = 0

			if var_332_13 < arg_329_1.time_ and arg_329_1.time_ <= var_332_13 + arg_332_0 then
				arg_329_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action7_2")
			end

			local var_332_14 = 0
			local var_332_15 = 0.075

			if var_332_14 < arg_329_1.time_ and arg_329_1.time_ <= var_332_14 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_16 = arg_329_1:FormatText(StoryNameCfg[265].name)

				arg_329_1.leftNameTxt_.text = var_332_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_17 = arg_329_1:GetWordFromCfg(411191080)
				local var_332_18 = arg_329_1:FormatText(var_332_17.content)

				arg_329_1.text_.text = var_332_18

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_19 = 3
				local var_332_20 = utf8.len(var_332_18)
				local var_332_21 = var_332_19 <= 0 and var_332_15 or var_332_15 * (var_332_20 / var_332_19)

				if var_332_21 > 0 and var_332_15 < var_332_21 then
					arg_329_1.talkMaxDuration = var_332_21

					if var_332_21 + var_332_14 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_21 + var_332_14
					end
				end

				arg_329_1.text_.text = var_332_18
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191080", "story_v_out_411191.awb") ~= 0 then
					local var_332_22 = manager.audio:GetVoiceLength("story_v_out_411191", "411191080", "story_v_out_411191.awb") / 1000

					if var_332_22 + var_332_14 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_22 + var_332_14
					end

					if var_332_17.prefab_name ~= "" and arg_329_1.actors_[var_332_17.prefab_name] ~= nil then
						local var_332_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_17.prefab_name].transform, "story_v_out_411191", "411191080", "story_v_out_411191.awb")

						arg_329_1:RecordAudio("411191080", var_332_23)
						arg_329_1:RecordAudio("411191080", var_332_23)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_411191", "411191080", "story_v_out_411191.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_411191", "411191080", "story_v_out_411191.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_24 = math.max(var_332_15, arg_329_1.talkMaxDuration)

			if var_332_14 <= arg_329_1.time_ and arg_329_1.time_ < var_332_14 + var_332_24 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_14) / var_332_24

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_14 + var_332_24 and arg_329_1.time_ < var_332_14 + var_332_24 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play411191081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 411191081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play411191082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1024ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1024ui_story == nil then
				arg_333_1.var_.characterEffect1024ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1024ui_story and not isNil(var_336_0) then
					local var_336_4 = Mathf.Lerp(0, 0.5, var_336_3)

					arg_333_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1024ui_story.fillRatio = var_336_4
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1024ui_story then
				local var_336_5 = 0.5

				arg_333_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1024ui_story.fillRatio = var_336_5
			end

			local var_336_6 = arg_333_1.actors_["1024ui_story"].transform
			local var_336_7 = 0

			if var_336_7 < arg_333_1.time_ and arg_333_1.time_ <= var_336_7 + arg_336_0 then
				arg_333_1.var_.moveOldPos1024ui_story = var_336_6.localPosition
			end

			local var_336_8 = 0.001

			if var_336_7 <= arg_333_1.time_ and arg_333_1.time_ < var_336_7 + var_336_8 then
				local var_336_9 = (arg_333_1.time_ - var_336_7) / var_336_8
				local var_336_10 = Vector3.New(0, 100, 0)

				var_336_6.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1024ui_story, var_336_10, var_336_9)

				local var_336_11 = manager.ui.mainCamera.transform.position - var_336_6.position

				var_336_6.forward = Vector3.New(var_336_11.x, var_336_11.y, var_336_11.z)

				local var_336_12 = var_336_6.localEulerAngles

				var_336_12.z = 0
				var_336_12.x = 0
				var_336_6.localEulerAngles = var_336_12
			end

			if arg_333_1.time_ >= var_336_7 + var_336_8 and arg_333_1.time_ < var_336_7 + var_336_8 + arg_336_0 then
				var_336_6.localPosition = Vector3.New(0, 100, 0)

				local var_336_13 = manager.ui.mainCamera.transform.position - var_336_6.position

				var_336_6.forward = Vector3.New(var_336_13.x, var_336_13.y, var_336_13.z)

				local var_336_14 = var_336_6.localEulerAngles

				var_336_14.z = 0
				var_336_14.x = 0
				var_336_6.localEulerAngles = var_336_14
			end

			local var_336_15 = 0
			local var_336_16 = 1.075

			if var_336_15 < arg_333_1.time_ and arg_333_1.time_ <= var_336_15 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_17 = arg_333_1:GetWordFromCfg(411191081)
				local var_336_18 = arg_333_1:FormatText(var_336_17.content)

				arg_333_1.text_.text = var_336_18

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_19 = 43
				local var_336_20 = utf8.len(var_336_18)
				local var_336_21 = var_336_19 <= 0 and var_336_16 or var_336_16 * (var_336_20 / var_336_19)

				if var_336_21 > 0 and var_336_16 < var_336_21 then
					arg_333_1.talkMaxDuration = var_336_21

					if var_336_21 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_21 + var_336_15
					end
				end

				arg_333_1.text_.text = var_336_18
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_22 = math.max(var_336_16, arg_333_1.talkMaxDuration)

			if var_336_15 <= arg_333_1.time_ and arg_333_1.time_ < var_336_15 + var_336_22 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_15) / var_336_22

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_15 + var_336_22 and arg_333_1.time_ < var_336_15 + var_336_22 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play411191082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 411191082
		arg_337_1.duration_ = 4.77

		local var_337_0 = {
			zh = 4.766,
			ja = 2
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
				arg_337_0:Play411191083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["4010ui_story"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos4010ui_story = var_340_0.localPosition
			end

			local var_340_2 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2
				local var_340_4 = Vector3.New(0, -1.59, -5.2)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos4010ui_story, var_340_4, var_340_3)

				local var_340_5 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_5.x, var_340_5.y, var_340_5.z)

				local var_340_6 = var_340_0.localEulerAngles

				var_340_6.z = 0
				var_340_6.x = 0
				var_340_0.localEulerAngles = var_340_6
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_340_7 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_7.x, var_340_7.y, var_340_7.z)

				local var_340_8 = var_340_0.localEulerAngles

				var_340_8.z = 0
				var_340_8.x = 0
				var_340_0.localEulerAngles = var_340_8
			end

			local var_340_9 = arg_337_1.actors_["4010ui_story"]
			local var_340_10 = 0

			if var_340_10 < arg_337_1.time_ and arg_337_1.time_ <= var_340_10 + arg_340_0 and not isNil(var_340_9) and arg_337_1.var_.characterEffect4010ui_story == nil then
				arg_337_1.var_.characterEffect4010ui_story = var_340_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_11 = 0.200000002980232

			if var_340_10 <= arg_337_1.time_ and arg_337_1.time_ < var_340_10 + var_340_11 and not isNil(var_340_9) then
				local var_340_12 = (arg_337_1.time_ - var_340_10) / var_340_11

				if arg_337_1.var_.characterEffect4010ui_story and not isNil(var_340_9) then
					arg_337_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_10 + var_340_11 and arg_337_1.time_ < var_340_10 + var_340_11 + arg_340_0 and not isNil(var_340_9) and arg_337_1.var_.characterEffect4010ui_story then
				arg_337_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_340_13 = 0

			if var_340_13 < arg_337_1.time_ and arg_337_1.time_ <= var_340_13 + arg_340_0 then
				arg_337_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_340_14 = 0

			if var_340_14 < arg_337_1.time_ and arg_337_1.time_ <= var_340_14 + arg_340_0 then
				arg_337_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_340_15 = 0
			local var_340_16 = 0.275

			if var_340_15 < arg_337_1.time_ and arg_337_1.time_ <= var_340_15 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_17 = arg_337_1:FormatText(StoryNameCfg[42].name)

				arg_337_1.leftNameTxt_.text = var_340_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_18 = arg_337_1:GetWordFromCfg(411191082)
				local var_340_19 = arg_337_1:FormatText(var_340_18.content)

				arg_337_1.text_.text = var_340_19

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_20 = 11
				local var_340_21 = utf8.len(var_340_19)
				local var_340_22 = var_340_20 <= 0 and var_340_16 or var_340_16 * (var_340_21 / var_340_20)

				if var_340_22 > 0 and var_340_16 < var_340_22 then
					arg_337_1.talkMaxDuration = var_340_22

					if var_340_22 + var_340_15 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_22 + var_340_15
					end
				end

				arg_337_1.text_.text = var_340_19
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191082", "story_v_out_411191.awb") ~= 0 then
					local var_340_23 = manager.audio:GetVoiceLength("story_v_out_411191", "411191082", "story_v_out_411191.awb") / 1000

					if var_340_23 + var_340_15 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_23 + var_340_15
					end

					if var_340_18.prefab_name ~= "" and arg_337_1.actors_[var_340_18.prefab_name] ~= nil then
						local var_340_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_18.prefab_name].transform, "story_v_out_411191", "411191082", "story_v_out_411191.awb")

						arg_337_1:RecordAudio("411191082", var_340_24)
						arg_337_1:RecordAudio("411191082", var_340_24)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_411191", "411191082", "story_v_out_411191.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_411191", "411191082", "story_v_out_411191.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_25 = math.max(var_340_16, arg_337_1.talkMaxDuration)

			if var_340_15 <= arg_337_1.time_ and arg_337_1.time_ < var_340_15 + var_340_25 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_15) / var_340_25

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_15 + var_340_25 and arg_337_1.time_ < var_340_15 + var_340_25 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play411191083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 411191083
		arg_341_1.duration_ = 1.1

		local var_341_0 = {
			zh = 1.1,
			ja = 0.999999999999
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
				arg_341_0:Play411191084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["4010ui_story"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos4010ui_story = var_344_0.localPosition
			end

			local var_344_2 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2
				local var_344_4 = Vector3.New(0, 100, 0)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos4010ui_story, var_344_4, var_344_3)

				local var_344_5 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_5.x, var_344_5.y, var_344_5.z)

				local var_344_6 = var_344_0.localEulerAngles

				var_344_6.z = 0
				var_344_6.x = 0
				var_344_0.localEulerAngles = var_344_6
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0, 100, 0)

				local var_344_7 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_7.x, var_344_7.y, var_344_7.z)

				local var_344_8 = var_344_0.localEulerAngles

				var_344_8.z = 0
				var_344_8.x = 0
				var_344_0.localEulerAngles = var_344_8
			end

			local var_344_9 = arg_341_1.actors_["4010ui_story"]
			local var_344_10 = 0

			if var_344_10 < arg_341_1.time_ and arg_341_1.time_ <= var_344_10 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect4010ui_story == nil then
				arg_341_1.var_.characterEffect4010ui_story = var_344_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_11 = 0.200000002980232

			if var_344_10 <= arg_341_1.time_ and arg_341_1.time_ < var_344_10 + var_344_11 and not isNil(var_344_9) then
				local var_344_12 = (arg_341_1.time_ - var_344_10) / var_344_11

				if arg_341_1.var_.characterEffect4010ui_story and not isNil(var_344_9) then
					local var_344_13 = Mathf.Lerp(0, 0.5, var_344_12)

					arg_341_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_341_1.var_.characterEffect4010ui_story.fillRatio = var_344_13
				end
			end

			if arg_341_1.time_ >= var_344_10 + var_344_11 and arg_341_1.time_ < var_344_10 + var_344_11 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect4010ui_story then
				local var_344_14 = 0.5

				arg_341_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_341_1.var_.characterEffect4010ui_story.fillRatio = var_344_14
			end

			local var_344_15 = arg_341_1.actors_["1024ui_story"].transform
			local var_344_16 = 0

			if var_344_16 < arg_341_1.time_ and arg_341_1.time_ <= var_344_16 + arg_344_0 then
				arg_341_1.var_.moveOldPos1024ui_story = var_344_15.localPosition
			end

			local var_344_17 = 0.001

			if var_344_16 <= arg_341_1.time_ and arg_341_1.time_ < var_344_16 + var_344_17 then
				local var_344_18 = (arg_341_1.time_ - var_344_16) / var_344_17
				local var_344_19 = Vector3.New(0, -1, -6.05)

				var_344_15.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1024ui_story, var_344_19, var_344_18)

				local var_344_20 = manager.ui.mainCamera.transform.position - var_344_15.position

				var_344_15.forward = Vector3.New(var_344_20.x, var_344_20.y, var_344_20.z)

				local var_344_21 = var_344_15.localEulerAngles

				var_344_21.z = 0
				var_344_21.x = 0
				var_344_15.localEulerAngles = var_344_21
			end

			if arg_341_1.time_ >= var_344_16 + var_344_17 and arg_341_1.time_ < var_344_16 + var_344_17 + arg_344_0 then
				var_344_15.localPosition = Vector3.New(0, -1, -6.05)

				local var_344_22 = manager.ui.mainCamera.transform.position - var_344_15.position

				var_344_15.forward = Vector3.New(var_344_22.x, var_344_22.y, var_344_22.z)

				local var_344_23 = var_344_15.localEulerAngles

				var_344_23.z = 0
				var_344_23.x = 0
				var_344_15.localEulerAngles = var_344_23
			end

			local var_344_24 = arg_341_1.actors_["1024ui_story"]
			local var_344_25 = 0

			if var_344_25 < arg_341_1.time_ and arg_341_1.time_ <= var_344_25 + arg_344_0 and not isNil(var_344_24) and arg_341_1.var_.characterEffect1024ui_story == nil then
				arg_341_1.var_.characterEffect1024ui_story = var_344_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_26 = 0.200000002980232

			if var_344_25 <= arg_341_1.time_ and arg_341_1.time_ < var_344_25 + var_344_26 and not isNil(var_344_24) then
				local var_344_27 = (arg_341_1.time_ - var_344_25) / var_344_26

				if arg_341_1.var_.characterEffect1024ui_story and not isNil(var_344_24) then
					arg_341_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_25 + var_344_26 and arg_341_1.time_ < var_344_25 + var_344_26 + arg_344_0 and not isNil(var_344_24) and arg_341_1.var_.characterEffect1024ui_story then
				arg_341_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_344_28 = 0

			if var_344_28 < arg_341_1.time_ and arg_341_1.time_ <= var_344_28 + arg_344_0 then
				arg_341_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_344_29 = 0

			if var_344_29 < arg_341_1.time_ and arg_341_1.time_ <= var_344_29 + arg_344_0 then
				arg_341_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_344_30 = 0
			local var_344_31 = 0.125

			if var_344_30 < arg_341_1.time_ and arg_341_1.time_ <= var_344_30 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_32 = arg_341_1:FormatText(StoryNameCfg[265].name)

				arg_341_1.leftNameTxt_.text = var_344_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_33 = arg_341_1:GetWordFromCfg(411191083)
				local var_344_34 = arg_341_1:FormatText(var_344_33.content)

				arg_341_1.text_.text = var_344_34

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_35 = 5
				local var_344_36 = utf8.len(var_344_34)
				local var_344_37 = var_344_35 <= 0 and var_344_31 or var_344_31 * (var_344_36 / var_344_35)

				if var_344_37 > 0 and var_344_31 < var_344_37 then
					arg_341_1.talkMaxDuration = var_344_37

					if var_344_37 + var_344_30 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_37 + var_344_30
					end
				end

				arg_341_1.text_.text = var_344_34
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191083", "story_v_out_411191.awb") ~= 0 then
					local var_344_38 = manager.audio:GetVoiceLength("story_v_out_411191", "411191083", "story_v_out_411191.awb") / 1000

					if var_344_38 + var_344_30 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_38 + var_344_30
					end

					if var_344_33.prefab_name ~= "" and arg_341_1.actors_[var_344_33.prefab_name] ~= nil then
						local var_344_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_33.prefab_name].transform, "story_v_out_411191", "411191083", "story_v_out_411191.awb")

						arg_341_1:RecordAudio("411191083", var_344_39)
						arg_341_1:RecordAudio("411191083", var_344_39)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_411191", "411191083", "story_v_out_411191.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_411191", "411191083", "story_v_out_411191.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_40 = math.max(var_344_31, arg_341_1.talkMaxDuration)

			if var_344_30 <= arg_341_1.time_ and arg_341_1.time_ < var_344_30 + var_344_40 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_30) / var_344_40

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_30 + var_344_40 and arg_341_1.time_ < var_344_30 + var_344_40 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play411191084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 411191084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play411191085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1024ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1024ui_story == nil then
				arg_345_1.var_.characterEffect1024ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1024ui_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1024ui_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1024ui_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1024ui_story.fillRatio = var_348_5
			end

			local var_348_6 = 0
			local var_348_7 = 0.3

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				local var_348_8 = "play"
				local var_348_9 = "effect"

				arg_345_1:AudioAction(var_348_8, var_348_9, "se_story_15", "se_story_15_gun05", "")
			end

			local var_348_10 = arg_345_1.actors_["1024ui_story"].transform
			local var_348_11 = 0

			if var_348_11 < arg_345_1.time_ and arg_345_1.time_ <= var_348_11 + arg_348_0 then
				arg_345_1.var_.moveOldPos1024ui_story = var_348_10.localPosition
			end

			local var_348_12 = 0.001

			if var_348_11 <= arg_345_1.time_ and arg_345_1.time_ < var_348_11 + var_348_12 then
				local var_348_13 = (arg_345_1.time_ - var_348_11) / var_348_12
				local var_348_14 = Vector3.New(0, 100, 0)

				var_348_10.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1024ui_story, var_348_14, var_348_13)

				local var_348_15 = manager.ui.mainCamera.transform.position - var_348_10.position

				var_348_10.forward = Vector3.New(var_348_15.x, var_348_15.y, var_348_15.z)

				local var_348_16 = var_348_10.localEulerAngles

				var_348_16.z = 0
				var_348_16.x = 0
				var_348_10.localEulerAngles = var_348_16
			end

			if arg_345_1.time_ >= var_348_11 + var_348_12 and arg_345_1.time_ < var_348_11 + var_348_12 + arg_348_0 then
				var_348_10.localPosition = Vector3.New(0, 100, 0)

				local var_348_17 = manager.ui.mainCamera.transform.position - var_348_10.position

				var_348_10.forward = Vector3.New(var_348_17.x, var_348_17.y, var_348_17.z)

				local var_348_18 = var_348_10.localEulerAngles

				var_348_18.z = 0
				var_348_18.x = 0
				var_348_10.localEulerAngles = var_348_18
			end

			local var_348_19 = manager.ui.mainCamera.transform
			local var_348_20 = 0

			if var_348_20 < arg_345_1.time_ and arg_345_1.time_ <= var_348_20 + arg_348_0 then
				arg_345_1.var_.shakeOldPos = var_348_19.localPosition
			end

			local var_348_21 = 0.2

			if var_348_20 <= arg_345_1.time_ and arg_345_1.time_ < var_348_20 + var_348_21 then
				local var_348_22 = (arg_345_1.time_ - var_348_20) / 0.066
				local var_348_23, var_348_24 = math.modf(var_348_22)

				var_348_19.localPosition = Vector3.New(var_348_24 * 0.13, var_348_24 * 0.13, var_348_24 * 0.13) + arg_345_1.var_.shakeOldPos
			end

			if arg_345_1.time_ >= var_348_20 + var_348_21 and arg_345_1.time_ < var_348_20 + var_348_21 + arg_348_0 then
				var_348_19.localPosition = arg_345_1.var_.shakeOldPos
			end

			local var_348_25 = manager.ui.mainCamera.transform
			local var_348_26 = 0.3

			if var_348_26 < arg_345_1.time_ and arg_345_1.time_ <= var_348_26 + arg_348_0 then
				arg_345_1.var_.shakeOldPos = var_348_25.localPosition
			end

			local var_348_27 = 0.1

			if var_348_26 <= arg_345_1.time_ and arg_345_1.time_ < var_348_26 + var_348_27 then
				local var_348_28 = (arg_345_1.time_ - var_348_26) / 0.066
				local var_348_29, var_348_30 = math.modf(var_348_28)

				var_348_25.localPosition = Vector3.New(var_348_30 * 0.13, var_348_30 * 0.13, var_348_30 * 0.13) + arg_345_1.var_.shakeOldPos
			end

			if arg_345_1.time_ >= var_348_26 + var_348_27 and arg_345_1.time_ < var_348_26 + var_348_27 + arg_348_0 then
				var_348_25.localPosition = arg_345_1.var_.shakeOldPos
			end

			local var_348_31 = manager.ui.mainCamera.transform
			local var_348_32 = 0.6

			if var_348_32 < arg_345_1.time_ and arg_345_1.time_ <= var_348_32 + arg_348_0 then
				arg_345_1.var_.shakeOldPos = var_348_31.localPosition
			end

			local var_348_33 = 0.2

			if var_348_32 <= arg_345_1.time_ and arg_345_1.time_ < var_348_32 + var_348_33 then
				local var_348_34 = (arg_345_1.time_ - var_348_32) / 0.066
				local var_348_35, var_348_36 = math.modf(var_348_34)

				var_348_31.localPosition = Vector3.New(var_348_36 * 0.13, var_348_36 * 0.13, var_348_36 * 0.13) + arg_345_1.var_.shakeOldPos
			end

			if arg_345_1.time_ >= var_348_32 + var_348_33 and arg_345_1.time_ < var_348_32 + var_348_33 + arg_348_0 then
				var_348_31.localPosition = arg_345_1.var_.shakeOldPos
			end

			local var_348_37 = 0

			if var_348_37 < arg_345_1.time_ and arg_345_1.time_ <= var_348_37 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			local var_348_38 = 0.8

			if arg_345_1.time_ >= var_348_37 + var_348_38 and arg_345_1.time_ < var_348_37 + var_348_38 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_39 = 0
			local var_348_40 = 1.3

			if var_348_39 < arg_345_1.time_ and arg_345_1.time_ <= var_348_39 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_41 = arg_345_1:GetWordFromCfg(411191084)
				local var_348_42 = arg_345_1:FormatText(var_348_41.content)

				arg_345_1.text_.text = var_348_42

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_43 = 52
				local var_348_44 = utf8.len(var_348_42)
				local var_348_45 = var_348_43 <= 0 and var_348_40 or var_348_40 * (var_348_44 / var_348_43)

				if var_348_45 > 0 and var_348_40 < var_348_45 then
					arg_345_1.talkMaxDuration = var_348_45

					if var_348_45 + var_348_39 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_45 + var_348_39
					end
				end

				arg_345_1.text_.text = var_348_42
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_46 = math.max(var_348_40, arg_345_1.talkMaxDuration)

			if var_348_39 <= arg_345_1.time_ and arg_345_1.time_ < var_348_39 + var_348_46 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_39) / var_348_46

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_39 + var_348_46 and arg_345_1.time_ < var_348_39 + var_348_46 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play411191085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 411191085
		arg_349_1.duration_ = 4.8

		local var_349_0 = {
			zh = 4.133,
			ja = 4.8
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play411191086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["4010ui_story"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos4010ui_story = var_352_0.localPosition
			end

			local var_352_2 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2
				local var_352_4 = Vector3.New(0, -1.59, -5.2)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos4010ui_story, var_352_4, var_352_3)

				local var_352_5 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_5.x, var_352_5.y, var_352_5.z)

				local var_352_6 = var_352_0.localEulerAngles

				var_352_6.z = 0
				var_352_6.x = 0
				var_352_0.localEulerAngles = var_352_6
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_352_7 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_7.x, var_352_7.y, var_352_7.z)

				local var_352_8 = var_352_0.localEulerAngles

				var_352_8.z = 0
				var_352_8.x = 0
				var_352_0.localEulerAngles = var_352_8
			end

			local var_352_9 = arg_349_1.actors_["4010ui_story"]
			local var_352_10 = 0

			if var_352_10 < arg_349_1.time_ and arg_349_1.time_ <= var_352_10 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect4010ui_story == nil then
				arg_349_1.var_.characterEffect4010ui_story = var_352_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_11 = 0.200000002980232

			if var_352_10 <= arg_349_1.time_ and arg_349_1.time_ < var_352_10 + var_352_11 and not isNil(var_352_9) then
				local var_352_12 = (arg_349_1.time_ - var_352_10) / var_352_11

				if arg_349_1.var_.characterEffect4010ui_story and not isNil(var_352_9) then
					arg_349_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_10 + var_352_11 and arg_349_1.time_ < var_352_10 + var_352_11 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect4010ui_story then
				arg_349_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_352_13 = 0

			if var_352_13 < arg_349_1.time_ and arg_349_1.time_ <= var_352_13 + arg_352_0 then
				arg_349_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_352_14 = 0

			if var_352_14 < arg_349_1.time_ and arg_349_1.time_ <= var_352_14 + arg_352_0 then
				arg_349_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_352_15 = 0
			local var_352_16 = 0.375

			if var_352_15 < arg_349_1.time_ and arg_349_1.time_ <= var_352_15 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_17 = arg_349_1:FormatText(StoryNameCfg[42].name)

				arg_349_1.leftNameTxt_.text = var_352_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_18 = arg_349_1:GetWordFromCfg(411191085)
				local var_352_19 = arg_349_1:FormatText(var_352_18.content)

				arg_349_1.text_.text = var_352_19

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_20 = 15
				local var_352_21 = utf8.len(var_352_19)
				local var_352_22 = var_352_20 <= 0 and var_352_16 or var_352_16 * (var_352_21 / var_352_20)

				if var_352_22 > 0 and var_352_16 < var_352_22 then
					arg_349_1.talkMaxDuration = var_352_22

					if var_352_22 + var_352_15 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_22 + var_352_15
					end
				end

				arg_349_1.text_.text = var_352_19
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191085", "story_v_out_411191.awb") ~= 0 then
					local var_352_23 = manager.audio:GetVoiceLength("story_v_out_411191", "411191085", "story_v_out_411191.awb") / 1000

					if var_352_23 + var_352_15 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_23 + var_352_15
					end

					if var_352_18.prefab_name ~= "" and arg_349_1.actors_[var_352_18.prefab_name] ~= nil then
						local var_352_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_18.prefab_name].transform, "story_v_out_411191", "411191085", "story_v_out_411191.awb")

						arg_349_1:RecordAudio("411191085", var_352_24)
						arg_349_1:RecordAudio("411191085", var_352_24)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_411191", "411191085", "story_v_out_411191.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_411191", "411191085", "story_v_out_411191.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_25 = math.max(var_352_16, arg_349_1.talkMaxDuration)

			if var_352_15 <= arg_349_1.time_ and arg_349_1.time_ < var_352_15 + var_352_25 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_15) / var_352_25

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_15 + var_352_25 and arg_349_1.time_ < var_352_15 + var_352_25 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play411191086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 411191086
		arg_353_1.duration_ = 3.03

		local var_353_0 = {
			zh = 1.333,
			ja = 3.033
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play411191087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["4010ui_story"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos4010ui_story = var_356_0.localPosition
			end

			local var_356_2 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2
				local var_356_4 = Vector3.New(0, 100, 0)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos4010ui_story, var_356_4, var_356_3)

				local var_356_5 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_5.x, var_356_5.y, var_356_5.z)

				local var_356_6 = var_356_0.localEulerAngles

				var_356_6.z = 0
				var_356_6.x = 0
				var_356_0.localEulerAngles = var_356_6
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(0, 100, 0)

				local var_356_7 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_7.x, var_356_7.y, var_356_7.z)

				local var_356_8 = var_356_0.localEulerAngles

				var_356_8.z = 0
				var_356_8.x = 0
				var_356_0.localEulerAngles = var_356_8
			end

			local var_356_9 = arg_353_1.actors_["4010ui_story"]
			local var_356_10 = 0

			if var_356_10 < arg_353_1.time_ and arg_353_1.time_ <= var_356_10 + arg_356_0 and not isNil(var_356_9) and arg_353_1.var_.characterEffect4010ui_story == nil then
				arg_353_1.var_.characterEffect4010ui_story = var_356_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_11 = 0.200000002980232

			if var_356_10 <= arg_353_1.time_ and arg_353_1.time_ < var_356_10 + var_356_11 and not isNil(var_356_9) then
				local var_356_12 = (arg_353_1.time_ - var_356_10) / var_356_11

				if arg_353_1.var_.characterEffect4010ui_story and not isNil(var_356_9) then
					local var_356_13 = Mathf.Lerp(0, 0.5, var_356_12)

					arg_353_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_353_1.var_.characterEffect4010ui_story.fillRatio = var_356_13
				end
			end

			if arg_353_1.time_ >= var_356_10 + var_356_11 and arg_353_1.time_ < var_356_10 + var_356_11 + arg_356_0 and not isNil(var_356_9) and arg_353_1.var_.characterEffect4010ui_story then
				local var_356_14 = 0.5

				arg_353_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_353_1.var_.characterEffect4010ui_story.fillRatio = var_356_14
			end

			local var_356_15 = arg_353_1.actors_["1024ui_story"].transform
			local var_356_16 = 0

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 then
				arg_353_1.var_.moveOldPos1024ui_story = var_356_15.localPosition
			end

			local var_356_17 = 0.001

			if var_356_16 <= arg_353_1.time_ and arg_353_1.time_ < var_356_16 + var_356_17 then
				local var_356_18 = (arg_353_1.time_ - var_356_16) / var_356_17
				local var_356_19 = Vector3.New(0, -1, -6.05)

				var_356_15.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1024ui_story, var_356_19, var_356_18)

				local var_356_20 = manager.ui.mainCamera.transform.position - var_356_15.position

				var_356_15.forward = Vector3.New(var_356_20.x, var_356_20.y, var_356_20.z)

				local var_356_21 = var_356_15.localEulerAngles

				var_356_21.z = 0
				var_356_21.x = 0
				var_356_15.localEulerAngles = var_356_21
			end

			if arg_353_1.time_ >= var_356_16 + var_356_17 and arg_353_1.time_ < var_356_16 + var_356_17 + arg_356_0 then
				var_356_15.localPosition = Vector3.New(0, -1, -6.05)

				local var_356_22 = manager.ui.mainCamera.transform.position - var_356_15.position

				var_356_15.forward = Vector3.New(var_356_22.x, var_356_22.y, var_356_22.z)

				local var_356_23 = var_356_15.localEulerAngles

				var_356_23.z = 0
				var_356_23.x = 0
				var_356_15.localEulerAngles = var_356_23
			end

			local var_356_24 = arg_353_1.actors_["1024ui_story"]
			local var_356_25 = 0

			if var_356_25 < arg_353_1.time_ and arg_353_1.time_ <= var_356_25 + arg_356_0 and not isNil(var_356_24) and arg_353_1.var_.characterEffect1024ui_story == nil then
				arg_353_1.var_.characterEffect1024ui_story = var_356_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_26 = 0.200000002980232

			if var_356_25 <= arg_353_1.time_ and arg_353_1.time_ < var_356_25 + var_356_26 and not isNil(var_356_24) then
				local var_356_27 = (arg_353_1.time_ - var_356_25) / var_356_26

				if arg_353_1.var_.characterEffect1024ui_story and not isNil(var_356_24) then
					arg_353_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= var_356_25 + var_356_26 and arg_353_1.time_ < var_356_25 + var_356_26 + arg_356_0 and not isNil(var_356_24) and arg_353_1.var_.characterEffect1024ui_story then
				arg_353_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_356_28 = 0

			if var_356_28 < arg_353_1.time_ and arg_353_1.time_ <= var_356_28 + arg_356_0 then
				arg_353_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_356_29 = 0

			if var_356_29 < arg_353_1.time_ and arg_353_1.time_ <= var_356_29 + arg_356_0 then
				arg_353_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_356_30 = 0
			local var_356_31 = 0.175

			if var_356_30 < arg_353_1.time_ and arg_353_1.time_ <= var_356_30 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_32 = arg_353_1:FormatText(StoryNameCfg[265].name)

				arg_353_1.leftNameTxt_.text = var_356_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_33 = arg_353_1:GetWordFromCfg(411191086)
				local var_356_34 = arg_353_1:FormatText(var_356_33.content)

				arg_353_1.text_.text = var_356_34

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_35 = 7
				local var_356_36 = utf8.len(var_356_34)
				local var_356_37 = var_356_35 <= 0 and var_356_31 or var_356_31 * (var_356_36 / var_356_35)

				if var_356_37 > 0 and var_356_31 < var_356_37 then
					arg_353_1.talkMaxDuration = var_356_37

					if var_356_37 + var_356_30 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_37 + var_356_30
					end
				end

				arg_353_1.text_.text = var_356_34
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191086", "story_v_out_411191.awb") ~= 0 then
					local var_356_38 = manager.audio:GetVoiceLength("story_v_out_411191", "411191086", "story_v_out_411191.awb") / 1000

					if var_356_38 + var_356_30 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_38 + var_356_30
					end

					if var_356_33.prefab_name ~= "" and arg_353_1.actors_[var_356_33.prefab_name] ~= nil then
						local var_356_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_33.prefab_name].transform, "story_v_out_411191", "411191086", "story_v_out_411191.awb")

						arg_353_1:RecordAudio("411191086", var_356_39)
						arg_353_1:RecordAudio("411191086", var_356_39)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_411191", "411191086", "story_v_out_411191.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_411191", "411191086", "story_v_out_411191.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_40 = math.max(var_356_31, arg_353_1.talkMaxDuration)

			if var_356_30 <= arg_353_1.time_ and arg_353_1.time_ < var_356_30 + var_356_40 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_30) / var_356_40

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_30 + var_356_40 and arg_353_1.time_ < var_356_30 + var_356_40 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play411191087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 411191087
		arg_357_1.duration_ = 1.73

		local var_357_0 = {
			zh = 1.733,
			ja = 0.999999999999
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play411191088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1024ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1024ui_story = var_360_0.localPosition
			end

			local var_360_2 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2
				local var_360_4 = Vector3.New(0, 100, 0)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1024ui_story, var_360_4, var_360_3)

				local var_360_5 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_5.x, var_360_5.y, var_360_5.z)

				local var_360_6 = var_360_0.localEulerAngles

				var_360_6.z = 0
				var_360_6.x = 0
				var_360_0.localEulerAngles = var_360_6
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, 100, 0)

				local var_360_7 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_7.x, var_360_7.y, var_360_7.z)

				local var_360_8 = var_360_0.localEulerAngles

				var_360_8.z = 0
				var_360_8.x = 0
				var_360_0.localEulerAngles = var_360_8
			end

			local var_360_9 = arg_357_1.actors_["1024ui_story"]
			local var_360_10 = 0

			if var_360_10 < arg_357_1.time_ and arg_357_1.time_ <= var_360_10 + arg_360_0 and not isNil(var_360_9) and arg_357_1.var_.characterEffect1024ui_story == nil then
				arg_357_1.var_.characterEffect1024ui_story = var_360_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_11 = 0.200000002980232

			if var_360_10 <= arg_357_1.time_ and arg_357_1.time_ < var_360_10 + var_360_11 and not isNil(var_360_9) then
				local var_360_12 = (arg_357_1.time_ - var_360_10) / var_360_11

				if arg_357_1.var_.characterEffect1024ui_story and not isNil(var_360_9) then
					local var_360_13 = Mathf.Lerp(0, 0.5, var_360_12)

					arg_357_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1024ui_story.fillRatio = var_360_13
				end
			end

			if arg_357_1.time_ >= var_360_10 + var_360_11 and arg_357_1.time_ < var_360_10 + var_360_11 + arg_360_0 and not isNil(var_360_9) and arg_357_1.var_.characterEffect1024ui_story then
				local var_360_14 = 0.5

				arg_357_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1024ui_story.fillRatio = var_360_14
			end

			local var_360_15 = arg_357_1.actors_["4010ui_story"].transform
			local var_360_16 = 0

			if var_360_16 < arg_357_1.time_ and arg_357_1.time_ <= var_360_16 + arg_360_0 then
				arg_357_1.var_.moveOldPos4010ui_story = var_360_15.localPosition
			end

			local var_360_17 = 0.001

			if var_360_16 <= arg_357_1.time_ and arg_357_1.time_ < var_360_16 + var_360_17 then
				local var_360_18 = (arg_357_1.time_ - var_360_16) / var_360_17
				local var_360_19 = Vector3.New(0, -1.59, -5.2)

				var_360_15.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos4010ui_story, var_360_19, var_360_18)

				local var_360_20 = manager.ui.mainCamera.transform.position - var_360_15.position

				var_360_15.forward = Vector3.New(var_360_20.x, var_360_20.y, var_360_20.z)

				local var_360_21 = var_360_15.localEulerAngles

				var_360_21.z = 0
				var_360_21.x = 0
				var_360_15.localEulerAngles = var_360_21
			end

			if arg_357_1.time_ >= var_360_16 + var_360_17 and arg_357_1.time_ < var_360_16 + var_360_17 + arg_360_0 then
				var_360_15.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_360_22 = manager.ui.mainCamera.transform.position - var_360_15.position

				var_360_15.forward = Vector3.New(var_360_22.x, var_360_22.y, var_360_22.z)

				local var_360_23 = var_360_15.localEulerAngles

				var_360_23.z = 0
				var_360_23.x = 0
				var_360_15.localEulerAngles = var_360_23
			end

			local var_360_24 = arg_357_1.actors_["4010ui_story"]
			local var_360_25 = 0

			if var_360_25 < arg_357_1.time_ and arg_357_1.time_ <= var_360_25 + arg_360_0 and not isNil(var_360_24) and arg_357_1.var_.characterEffect4010ui_story == nil then
				arg_357_1.var_.characterEffect4010ui_story = var_360_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_26 = 0.200000002980232

			if var_360_25 <= arg_357_1.time_ and arg_357_1.time_ < var_360_25 + var_360_26 and not isNil(var_360_24) then
				local var_360_27 = (arg_357_1.time_ - var_360_25) / var_360_26

				if arg_357_1.var_.characterEffect4010ui_story and not isNil(var_360_24) then
					arg_357_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_25 + var_360_26 and arg_357_1.time_ < var_360_25 + var_360_26 + arg_360_0 and not isNil(var_360_24) and arg_357_1.var_.characterEffect4010ui_story then
				arg_357_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_360_28 = 0

			if var_360_28 < arg_357_1.time_ and arg_357_1.time_ <= var_360_28 + arg_360_0 then
				arg_357_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_360_29 = 0

			if var_360_29 < arg_357_1.time_ and arg_357_1.time_ <= var_360_29 + arg_360_0 then
				arg_357_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_360_30 = 0
			local var_360_31 = 0.1

			if var_360_30 < arg_357_1.time_ and arg_357_1.time_ <= var_360_30 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_32 = arg_357_1:FormatText(StoryNameCfg[42].name)

				arg_357_1.leftNameTxt_.text = var_360_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_33 = arg_357_1:GetWordFromCfg(411191087)
				local var_360_34 = arg_357_1:FormatText(var_360_33.content)

				arg_357_1.text_.text = var_360_34

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_35 = 4
				local var_360_36 = utf8.len(var_360_34)
				local var_360_37 = var_360_35 <= 0 and var_360_31 or var_360_31 * (var_360_36 / var_360_35)

				if var_360_37 > 0 and var_360_31 < var_360_37 then
					arg_357_1.talkMaxDuration = var_360_37

					if var_360_37 + var_360_30 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_37 + var_360_30
					end
				end

				arg_357_1.text_.text = var_360_34
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191087", "story_v_out_411191.awb") ~= 0 then
					local var_360_38 = manager.audio:GetVoiceLength("story_v_out_411191", "411191087", "story_v_out_411191.awb") / 1000

					if var_360_38 + var_360_30 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_38 + var_360_30
					end

					if var_360_33.prefab_name ~= "" and arg_357_1.actors_[var_360_33.prefab_name] ~= nil then
						local var_360_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_33.prefab_name].transform, "story_v_out_411191", "411191087", "story_v_out_411191.awb")

						arg_357_1:RecordAudio("411191087", var_360_39)
						arg_357_1:RecordAudio("411191087", var_360_39)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_411191", "411191087", "story_v_out_411191.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_411191", "411191087", "story_v_out_411191.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_40 = math.max(var_360_31, arg_357_1.talkMaxDuration)

			if var_360_30 <= arg_357_1.time_ and arg_357_1.time_ < var_360_30 + var_360_40 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_30) / var_360_40

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_30 + var_360_40 and arg_357_1.time_ < var_360_30 + var_360_40 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play411191088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 411191088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play411191089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["4010ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect4010ui_story == nil then
				arg_361_1.var_.characterEffect4010ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect4010ui_story and not isNil(var_364_0) then
					local var_364_4 = Mathf.Lerp(0, 0.5, var_364_3)

					arg_361_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_361_1.var_.characterEffect4010ui_story.fillRatio = var_364_4
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect4010ui_story then
				local var_364_5 = 0.5

				arg_361_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_361_1.var_.characterEffect4010ui_story.fillRatio = var_364_5
			end

			local var_364_6 = arg_361_1.actors_["4010ui_story"].transform
			local var_364_7 = 0

			if var_364_7 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 then
				arg_361_1.var_.moveOldPos4010ui_story = var_364_6.localPosition
			end

			local var_364_8 = 0.001

			if var_364_7 <= arg_361_1.time_ and arg_361_1.time_ < var_364_7 + var_364_8 then
				local var_364_9 = (arg_361_1.time_ - var_364_7) / var_364_8
				local var_364_10 = Vector3.New(0, 100, 0)

				var_364_6.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos4010ui_story, var_364_10, var_364_9)

				local var_364_11 = manager.ui.mainCamera.transform.position - var_364_6.position

				var_364_6.forward = Vector3.New(var_364_11.x, var_364_11.y, var_364_11.z)

				local var_364_12 = var_364_6.localEulerAngles

				var_364_12.z = 0
				var_364_12.x = 0
				var_364_6.localEulerAngles = var_364_12
			end

			if arg_361_1.time_ >= var_364_7 + var_364_8 and arg_361_1.time_ < var_364_7 + var_364_8 + arg_364_0 then
				var_364_6.localPosition = Vector3.New(0, 100, 0)

				local var_364_13 = manager.ui.mainCamera.transform.position - var_364_6.position

				var_364_6.forward = Vector3.New(var_364_13.x, var_364_13.y, var_364_13.z)

				local var_364_14 = var_364_6.localEulerAngles

				var_364_14.z = 0
				var_364_14.x = 0
				var_364_6.localEulerAngles = var_364_14
			end

			local var_364_15 = 0

			if var_364_15 < arg_361_1.time_ and arg_361_1.time_ <= var_364_15 + arg_364_0 then
				arg_361_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action8_2")
			end

			local var_364_16 = 0
			local var_364_17 = 0.95

			if var_364_16 < arg_361_1.time_ and arg_361_1.time_ <= var_364_16 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_18 = arg_361_1:GetWordFromCfg(411191088)
				local var_364_19 = arg_361_1:FormatText(var_364_18.content)

				arg_361_1.text_.text = var_364_19

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_20 = 38
				local var_364_21 = utf8.len(var_364_19)
				local var_364_22 = var_364_20 <= 0 and var_364_17 or var_364_17 * (var_364_21 / var_364_20)

				if var_364_22 > 0 and var_364_17 < var_364_22 then
					arg_361_1.talkMaxDuration = var_364_22

					if var_364_22 + var_364_16 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_22 + var_364_16
					end
				end

				arg_361_1.text_.text = var_364_19
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_23 = math.max(var_364_17, arg_361_1.talkMaxDuration)

			if var_364_16 <= arg_361_1.time_ and arg_361_1.time_ < var_364_16 + var_364_23 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_16) / var_364_23

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_16 + var_364_23 and arg_361_1.time_ < var_364_16 + var_364_23 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play411191089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 411191089
		arg_365_1.duration_ = 3.4

		local var_365_0 = {
			zh = 3.4,
			ja = 1.999999999999
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play411191090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["4010ui_story"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect4010ui_story == nil then
				arg_365_1.var_.characterEffect4010ui_story = var_368_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.characterEffect4010ui_story and not isNil(var_368_0) then
					arg_365_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect4010ui_story then
				arg_365_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_368_4 = 0

			if var_368_4 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_368_5 = 0

			if var_368_5 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 then
				arg_365_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action8_2")
			end

			local var_368_6 = arg_365_1.actors_["4010ui_story"].transform
			local var_368_7 = 0

			if var_368_7 < arg_365_1.time_ and arg_365_1.time_ <= var_368_7 + arg_368_0 then
				arg_365_1.var_.moveOldPos4010ui_story = var_368_6.localPosition
			end

			local var_368_8 = 0.001

			if var_368_7 <= arg_365_1.time_ and arg_365_1.time_ < var_368_7 + var_368_8 then
				local var_368_9 = (arg_365_1.time_ - var_368_7) / var_368_8
				local var_368_10 = Vector3.New(0, -1.59, -5.2)

				var_368_6.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos4010ui_story, var_368_10, var_368_9)

				local var_368_11 = manager.ui.mainCamera.transform.position - var_368_6.position

				var_368_6.forward = Vector3.New(var_368_11.x, var_368_11.y, var_368_11.z)

				local var_368_12 = var_368_6.localEulerAngles

				var_368_12.z = 0
				var_368_12.x = 0
				var_368_6.localEulerAngles = var_368_12
			end

			if arg_365_1.time_ >= var_368_7 + var_368_8 and arg_365_1.time_ < var_368_7 + var_368_8 + arg_368_0 then
				var_368_6.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_368_13 = manager.ui.mainCamera.transform.position - var_368_6.position

				var_368_6.forward = Vector3.New(var_368_13.x, var_368_13.y, var_368_13.z)

				local var_368_14 = var_368_6.localEulerAngles

				var_368_14.z = 0
				var_368_14.x = 0
				var_368_6.localEulerAngles = var_368_14
			end

			local var_368_15 = 0

			if var_368_15 < arg_365_1.time_ and arg_365_1.time_ <= var_368_15 + arg_368_0 then
				arg_365_1.mask_.enabled = true
				arg_365_1.mask_.raycastTarget = false

				arg_365_1:SetGaussion(false)
			end

			local var_368_16 = 0.200000002980232

			if var_368_15 <= arg_365_1.time_ and arg_365_1.time_ < var_368_15 + var_368_16 then
				local var_368_17 = (arg_365_1.time_ - var_368_15) / var_368_16
				local var_368_18 = Color.New(1, 1, 1)

				var_368_18.a = Mathf.Lerp(1, 0, var_368_17)
				arg_365_1.mask_.color = var_368_18
			end

			if arg_365_1.time_ >= var_368_15 + var_368_16 and arg_365_1.time_ < var_368_15 + var_368_16 + arg_368_0 then
				local var_368_19 = Color.New(1, 1, 1)
				local var_368_20 = 0

				arg_365_1.mask_.enabled = false
				var_368_19.a = var_368_20
				arg_365_1.mask_.color = var_368_19
			end

			local var_368_21 = 0
			local var_368_22 = 0.075

			if var_368_21 < arg_365_1.time_ and arg_365_1.time_ <= var_368_21 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_23 = arg_365_1:FormatText(StoryNameCfg[42].name)

				arg_365_1.leftNameTxt_.text = var_368_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_24 = arg_365_1:GetWordFromCfg(411191089)
				local var_368_25 = arg_365_1:FormatText(var_368_24.content)

				arg_365_1.text_.text = var_368_25

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_26 = 3
				local var_368_27 = utf8.len(var_368_25)
				local var_368_28 = var_368_26 <= 0 and var_368_22 or var_368_22 * (var_368_27 / var_368_26)

				if var_368_28 > 0 and var_368_22 < var_368_28 then
					arg_365_1.talkMaxDuration = var_368_28

					if var_368_28 + var_368_21 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_28 + var_368_21
					end
				end

				arg_365_1.text_.text = var_368_25
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191089", "story_v_out_411191.awb") ~= 0 then
					local var_368_29 = manager.audio:GetVoiceLength("story_v_out_411191", "411191089", "story_v_out_411191.awb") / 1000

					if var_368_29 + var_368_21 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_29 + var_368_21
					end

					if var_368_24.prefab_name ~= "" and arg_365_1.actors_[var_368_24.prefab_name] ~= nil then
						local var_368_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_24.prefab_name].transform, "story_v_out_411191", "411191089", "story_v_out_411191.awb")

						arg_365_1:RecordAudio("411191089", var_368_30)
						arg_365_1:RecordAudio("411191089", var_368_30)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_411191", "411191089", "story_v_out_411191.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_411191", "411191089", "story_v_out_411191.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_31 = math.max(var_368_22, arg_365_1.talkMaxDuration)

			if var_368_21 <= arg_365_1.time_ and arg_365_1.time_ < var_368_21 + var_368_31 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_21) / var_368_31

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_21 + var_368_31 and arg_365_1.time_ < var_368_21 + var_368_31 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play411191090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 411191090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play411191091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["4010ui_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect4010ui_story == nil then
				arg_369_1.var_.characterEffect4010ui_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect4010ui_story and not isNil(var_372_0) then
					local var_372_4 = Mathf.Lerp(0, 0.5, var_372_3)

					arg_369_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_369_1.var_.characterEffect4010ui_story.fillRatio = var_372_4
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect4010ui_story then
				local var_372_5 = 0.5

				arg_369_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_369_1.var_.characterEffect4010ui_story.fillRatio = var_372_5
			end

			local var_372_6 = arg_369_1.actors_["4010ui_story"].transform
			local var_372_7 = 0

			if var_372_7 < arg_369_1.time_ and arg_369_1.time_ <= var_372_7 + arg_372_0 then
				arg_369_1.var_.moveOldPos4010ui_story = var_372_6.localPosition
			end

			local var_372_8 = 0.001

			if var_372_7 <= arg_369_1.time_ and arg_369_1.time_ < var_372_7 + var_372_8 then
				local var_372_9 = (arg_369_1.time_ - var_372_7) / var_372_8
				local var_372_10 = Vector3.New(0, 100, 0)

				var_372_6.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos4010ui_story, var_372_10, var_372_9)

				local var_372_11 = manager.ui.mainCamera.transform.position - var_372_6.position

				var_372_6.forward = Vector3.New(var_372_11.x, var_372_11.y, var_372_11.z)

				local var_372_12 = var_372_6.localEulerAngles

				var_372_12.z = 0
				var_372_12.x = 0
				var_372_6.localEulerAngles = var_372_12
			end

			if arg_369_1.time_ >= var_372_7 + var_372_8 and arg_369_1.time_ < var_372_7 + var_372_8 + arg_372_0 then
				var_372_6.localPosition = Vector3.New(0, 100, 0)

				local var_372_13 = manager.ui.mainCamera.transform.position - var_372_6.position

				var_372_6.forward = Vector3.New(var_372_13.x, var_372_13.y, var_372_13.z)

				local var_372_14 = var_372_6.localEulerAngles

				var_372_14.z = 0
				var_372_14.x = 0
				var_372_6.localEulerAngles = var_372_14
			end

			local var_372_15 = 0
			local var_372_16 = 0.925

			if var_372_15 < arg_369_1.time_ and arg_369_1.time_ <= var_372_15 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_17 = arg_369_1:GetWordFromCfg(411191090)
				local var_372_18 = arg_369_1:FormatText(var_372_17.content)

				arg_369_1.text_.text = var_372_18

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_19 = 37
				local var_372_20 = utf8.len(var_372_18)
				local var_372_21 = var_372_19 <= 0 and var_372_16 or var_372_16 * (var_372_20 / var_372_19)

				if var_372_21 > 0 and var_372_16 < var_372_21 then
					arg_369_1.talkMaxDuration = var_372_21

					if var_372_21 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_21 + var_372_15
					end
				end

				arg_369_1.text_.text = var_372_18
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_22 = math.max(var_372_16, arg_369_1.talkMaxDuration)

			if var_372_15 <= arg_369_1.time_ and arg_369_1.time_ < var_372_15 + var_372_22 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_15) / var_372_22

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_15 + var_372_22 and arg_369_1.time_ < var_372_15 + var_372_22 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play411191091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 411191091
		arg_373_1.duration_ = 2

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play411191092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["4010ui_story"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos4010ui_story = var_376_0.localPosition
			end

			local var_376_2 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2
				local var_376_4 = Vector3.New(0, 100, 0)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos4010ui_story, var_376_4, var_376_3)

				local var_376_5 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_5.x, var_376_5.y, var_376_5.z)

				local var_376_6 = var_376_0.localEulerAngles

				var_376_6.z = 0
				var_376_6.x = 0
				var_376_0.localEulerAngles = var_376_6
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(0, 100, 0)

				local var_376_7 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_7.x, var_376_7.y, var_376_7.z)

				local var_376_8 = var_376_0.localEulerAngles

				var_376_8.z = 0
				var_376_8.x = 0
				var_376_0.localEulerAngles = var_376_8
			end

			local var_376_9 = arg_373_1.actors_["4010ui_story"]
			local var_376_10 = 0

			if var_376_10 < arg_373_1.time_ and arg_373_1.time_ <= var_376_10 + arg_376_0 and not isNil(var_376_9) and arg_373_1.var_.characterEffect4010ui_story == nil then
				arg_373_1.var_.characterEffect4010ui_story = var_376_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_11 = 0.200000002980232

			if var_376_10 <= arg_373_1.time_ and arg_373_1.time_ < var_376_10 + var_376_11 and not isNil(var_376_9) then
				local var_376_12 = (arg_373_1.time_ - var_376_10) / var_376_11

				if arg_373_1.var_.characterEffect4010ui_story and not isNil(var_376_9) then
					local var_376_13 = Mathf.Lerp(0, 0.5, var_376_12)

					arg_373_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_373_1.var_.characterEffect4010ui_story.fillRatio = var_376_13
				end
			end

			if arg_373_1.time_ >= var_376_10 + var_376_11 and arg_373_1.time_ < var_376_10 + var_376_11 + arg_376_0 and not isNil(var_376_9) and arg_373_1.var_.characterEffect4010ui_story then
				local var_376_14 = 0.5

				arg_373_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_373_1.var_.characterEffect4010ui_story.fillRatio = var_376_14
			end

			local var_376_15 = arg_373_1.actors_["1024ui_story"].transform
			local var_376_16 = 0

			if var_376_16 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 then
				arg_373_1.var_.moveOldPos1024ui_story = var_376_15.localPosition
			end

			local var_376_17 = 0.001

			if var_376_16 <= arg_373_1.time_ and arg_373_1.time_ < var_376_16 + var_376_17 then
				local var_376_18 = (arg_373_1.time_ - var_376_16) / var_376_17
				local var_376_19 = Vector3.New(0, -1, -6.05)

				var_376_15.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1024ui_story, var_376_19, var_376_18)

				local var_376_20 = manager.ui.mainCamera.transform.position - var_376_15.position

				var_376_15.forward = Vector3.New(var_376_20.x, var_376_20.y, var_376_20.z)

				local var_376_21 = var_376_15.localEulerAngles

				var_376_21.z = 0
				var_376_21.x = 0
				var_376_15.localEulerAngles = var_376_21
			end

			if arg_373_1.time_ >= var_376_16 + var_376_17 and arg_373_1.time_ < var_376_16 + var_376_17 + arg_376_0 then
				var_376_15.localPosition = Vector3.New(0, -1, -6.05)

				local var_376_22 = manager.ui.mainCamera.transform.position - var_376_15.position

				var_376_15.forward = Vector3.New(var_376_22.x, var_376_22.y, var_376_22.z)

				local var_376_23 = var_376_15.localEulerAngles

				var_376_23.z = 0
				var_376_23.x = 0
				var_376_15.localEulerAngles = var_376_23
			end

			local var_376_24 = arg_373_1.actors_["1024ui_story"]
			local var_376_25 = 0

			if var_376_25 < arg_373_1.time_ and arg_373_1.time_ <= var_376_25 + arg_376_0 and not isNil(var_376_24) and arg_373_1.var_.characterEffect1024ui_story == nil then
				arg_373_1.var_.characterEffect1024ui_story = var_376_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_26 = 0.200000002980232

			if var_376_25 <= arg_373_1.time_ and arg_373_1.time_ < var_376_25 + var_376_26 and not isNil(var_376_24) then
				local var_376_27 = (arg_373_1.time_ - var_376_25) / var_376_26

				if arg_373_1.var_.characterEffect1024ui_story and not isNil(var_376_24) then
					arg_373_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= var_376_25 + var_376_26 and arg_373_1.time_ < var_376_25 + var_376_26 + arg_376_0 and not isNil(var_376_24) and arg_373_1.var_.characterEffect1024ui_story then
				arg_373_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_376_28 = 0

			if var_376_28 < arg_373_1.time_ and arg_373_1.time_ <= var_376_28 + arg_376_0 then
				arg_373_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_376_29 = 0

			if var_376_29 < arg_373_1.time_ and arg_373_1.time_ <= var_376_29 + arg_376_0 then
				arg_373_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_376_30 = 0
			local var_376_31 = 0.075

			if var_376_30 < arg_373_1.time_ and arg_373_1.time_ <= var_376_30 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_32 = arg_373_1:FormatText(StoryNameCfg[265].name)

				arg_373_1.leftNameTxt_.text = var_376_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_33 = arg_373_1:GetWordFromCfg(411191091)
				local var_376_34 = arg_373_1:FormatText(var_376_33.content)

				arg_373_1.text_.text = var_376_34

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_35 = 3
				local var_376_36 = utf8.len(var_376_34)
				local var_376_37 = var_376_35 <= 0 and var_376_31 or var_376_31 * (var_376_36 / var_376_35)

				if var_376_37 > 0 and var_376_31 < var_376_37 then
					arg_373_1.talkMaxDuration = var_376_37

					if var_376_37 + var_376_30 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_37 + var_376_30
					end
				end

				arg_373_1.text_.text = var_376_34
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191091", "story_v_out_411191.awb") ~= 0 then
					local var_376_38 = manager.audio:GetVoiceLength("story_v_out_411191", "411191091", "story_v_out_411191.awb") / 1000

					if var_376_38 + var_376_30 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_38 + var_376_30
					end

					if var_376_33.prefab_name ~= "" and arg_373_1.actors_[var_376_33.prefab_name] ~= nil then
						local var_376_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_33.prefab_name].transform, "story_v_out_411191", "411191091", "story_v_out_411191.awb")

						arg_373_1:RecordAudio("411191091", var_376_39)
						arg_373_1:RecordAudio("411191091", var_376_39)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_411191", "411191091", "story_v_out_411191.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_411191", "411191091", "story_v_out_411191.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_40 = math.max(var_376_31, arg_373_1.talkMaxDuration)

			if var_376_30 <= arg_373_1.time_ and arg_373_1.time_ < var_376_30 + var_376_40 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_30) / var_376_40

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_30 + var_376_40 and arg_373_1.time_ < var_376_30 + var_376_40 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play411191092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 411191092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play411191093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1024ui_story"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1024ui_story == nil then
				arg_377_1.var_.characterEffect1024ui_story = var_380_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.characterEffect1024ui_story and not isNil(var_380_0) then
					local var_380_4 = Mathf.Lerp(0, 0.5, var_380_3)

					arg_377_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1024ui_story.fillRatio = var_380_4
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1024ui_story then
				local var_380_5 = 0.5

				arg_377_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1024ui_story.fillRatio = var_380_5
			end

			local var_380_6 = 0
			local var_380_7 = 0.675

			if var_380_6 < arg_377_1.time_ and arg_377_1.time_ <= var_380_6 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_8 = arg_377_1:GetWordFromCfg(411191092)
				local var_380_9 = arg_377_1:FormatText(var_380_8.content)

				arg_377_1.text_.text = var_380_9

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_10 = 27
				local var_380_11 = utf8.len(var_380_9)
				local var_380_12 = var_380_10 <= 0 and var_380_7 or var_380_7 * (var_380_11 / var_380_10)

				if var_380_12 > 0 and var_380_7 < var_380_12 then
					arg_377_1.talkMaxDuration = var_380_12

					if var_380_12 + var_380_6 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_12 + var_380_6
					end
				end

				arg_377_1.text_.text = var_380_9
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_13 = math.max(var_380_7, arg_377_1.talkMaxDuration)

			if var_380_6 <= arg_377_1.time_ and arg_377_1.time_ < var_380_6 + var_380_13 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_6) / var_380_13

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_6 + var_380_13 and arg_377_1.time_ < var_380_6 + var_380_13 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play411191093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 411191093
		arg_381_1.duration_ = 1.3

		local var_381_0 = {
			zh = 0.999999999999,
			ja = 1.3
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play411191094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1024ui_story"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1024ui_story == nil then
				arg_381_1.var_.characterEffect1024ui_story = var_384_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.characterEffect1024ui_story and not isNil(var_384_0) then
					arg_381_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1024ui_story then
				arg_381_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_384_4 = 0
			local var_384_5 = 0.075

			if var_384_4 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_6 = arg_381_1:FormatText(StoryNameCfg[265].name)

				arg_381_1.leftNameTxt_.text = var_384_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_7 = arg_381_1:GetWordFromCfg(411191093)
				local var_384_8 = arg_381_1:FormatText(var_384_7.content)

				arg_381_1.text_.text = var_384_8

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_9 = 3
				local var_384_10 = utf8.len(var_384_8)
				local var_384_11 = var_384_9 <= 0 and var_384_5 or var_384_5 * (var_384_10 / var_384_9)

				if var_384_11 > 0 and var_384_5 < var_384_11 then
					arg_381_1.talkMaxDuration = var_384_11

					if var_384_11 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_11 + var_384_4
					end
				end

				arg_381_1.text_.text = var_384_8
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191093", "story_v_out_411191.awb") ~= 0 then
					local var_384_12 = manager.audio:GetVoiceLength("story_v_out_411191", "411191093", "story_v_out_411191.awb") / 1000

					if var_384_12 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_12 + var_384_4
					end

					if var_384_7.prefab_name ~= "" and arg_381_1.actors_[var_384_7.prefab_name] ~= nil then
						local var_384_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_7.prefab_name].transform, "story_v_out_411191", "411191093", "story_v_out_411191.awb")

						arg_381_1:RecordAudio("411191093", var_384_13)
						arg_381_1:RecordAudio("411191093", var_384_13)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_411191", "411191093", "story_v_out_411191.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_411191", "411191093", "story_v_out_411191.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_14 = math.max(var_384_5, arg_381_1.talkMaxDuration)

			if var_384_4 <= arg_381_1.time_ and arg_381_1.time_ < var_384_4 + var_384_14 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_4) / var_384_14

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_4 + var_384_14 and arg_381_1.time_ < var_384_4 + var_384_14 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play411191094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 411191094
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play411191095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1024ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1024ui_story == nil then
				arg_385_1.var_.characterEffect1024ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect1024ui_story and not isNil(var_388_0) then
					local var_388_4 = Mathf.Lerp(0, 0.5, var_388_3)

					arg_385_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1024ui_story.fillRatio = var_388_4
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1024ui_story then
				local var_388_5 = 0.5

				arg_385_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1024ui_story.fillRatio = var_388_5
			end

			local var_388_6 = 0
			local var_388_7 = 1.125

			if var_388_6 < arg_385_1.time_ and arg_385_1.time_ <= var_388_6 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_8 = arg_385_1:GetWordFromCfg(411191094)
				local var_388_9 = arg_385_1:FormatText(var_388_8.content)

				arg_385_1.text_.text = var_388_9

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_10 = 45
				local var_388_11 = utf8.len(var_388_9)
				local var_388_12 = var_388_10 <= 0 and var_388_7 or var_388_7 * (var_388_11 / var_388_10)

				if var_388_12 > 0 and var_388_7 < var_388_12 then
					arg_385_1.talkMaxDuration = var_388_12

					if var_388_12 + var_388_6 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_12 + var_388_6
					end
				end

				arg_385_1.text_.text = var_388_9
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_13 = math.max(var_388_7, arg_385_1.talkMaxDuration)

			if var_388_6 <= arg_385_1.time_ and arg_385_1.time_ < var_388_6 + var_388_13 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_6) / var_388_13

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_6 + var_388_13 and arg_385_1.time_ < var_388_6 + var_388_13 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play411191095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 411191095
		arg_389_1.duration_ = 5.73

		local var_389_0 = {
			zh = 5.4,
			ja = 5.733
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play411191096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["4010ui_story"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos4010ui_story = var_392_0.localPosition
			end

			local var_392_2 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2
				local var_392_4 = Vector3.New(0.7, -1.59, -5.2)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos4010ui_story, var_392_4, var_392_3)

				local var_392_5 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_5.x, var_392_5.y, var_392_5.z)

				local var_392_6 = var_392_0.localEulerAngles

				var_392_6.z = 0
				var_392_6.x = 0
				var_392_0.localEulerAngles = var_392_6
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(0.7, -1.59, -5.2)

				local var_392_7 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_7.x, var_392_7.y, var_392_7.z)

				local var_392_8 = var_392_0.localEulerAngles

				var_392_8.z = 0
				var_392_8.x = 0
				var_392_0.localEulerAngles = var_392_8
			end

			local var_392_9 = arg_389_1.actors_["4010ui_story"]
			local var_392_10 = 0

			if var_392_10 < arg_389_1.time_ and arg_389_1.time_ <= var_392_10 + arg_392_0 and not isNil(var_392_9) and arg_389_1.var_.characterEffect4010ui_story == nil then
				arg_389_1.var_.characterEffect4010ui_story = var_392_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_11 = 0.200000002980232

			if var_392_10 <= arg_389_1.time_ and arg_389_1.time_ < var_392_10 + var_392_11 and not isNil(var_392_9) then
				local var_392_12 = (arg_389_1.time_ - var_392_10) / var_392_11

				if arg_389_1.var_.characterEffect4010ui_story and not isNil(var_392_9) then
					arg_389_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= var_392_10 + var_392_11 and arg_389_1.time_ < var_392_10 + var_392_11 + arg_392_0 and not isNil(var_392_9) and arg_389_1.var_.characterEffect4010ui_story then
				arg_389_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_392_13 = arg_389_1.actors_["1024ui_story"].transform
			local var_392_14 = 0

			if var_392_14 < arg_389_1.time_ and arg_389_1.time_ <= var_392_14 + arg_392_0 then
				arg_389_1.var_.moveOldPos1024ui_story = var_392_13.localPosition
			end

			local var_392_15 = 0.001

			if var_392_14 <= arg_389_1.time_ and arg_389_1.time_ < var_392_14 + var_392_15 then
				local var_392_16 = (arg_389_1.time_ - var_392_14) / var_392_15
				local var_392_17 = Vector3.New(-0.7, -1, -6.05)

				var_392_13.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1024ui_story, var_392_17, var_392_16)

				local var_392_18 = manager.ui.mainCamera.transform.position - var_392_13.position

				var_392_13.forward = Vector3.New(var_392_18.x, var_392_18.y, var_392_18.z)

				local var_392_19 = var_392_13.localEulerAngles

				var_392_19.z = 0
				var_392_19.x = 0
				var_392_13.localEulerAngles = var_392_19
			end

			if arg_389_1.time_ >= var_392_14 + var_392_15 and arg_389_1.time_ < var_392_14 + var_392_15 + arg_392_0 then
				var_392_13.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_392_20 = manager.ui.mainCamera.transform.position - var_392_13.position

				var_392_13.forward = Vector3.New(var_392_20.x, var_392_20.y, var_392_20.z)

				local var_392_21 = var_392_13.localEulerAngles

				var_392_21.z = 0
				var_392_21.x = 0
				var_392_13.localEulerAngles = var_392_21
			end

			local var_392_22 = arg_389_1.actors_["1024ui_story"]
			local var_392_23 = 0

			if var_392_23 < arg_389_1.time_ and arg_389_1.time_ <= var_392_23 + arg_392_0 and not isNil(var_392_22) and arg_389_1.var_.characterEffect1024ui_story == nil then
				arg_389_1.var_.characterEffect1024ui_story = var_392_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_24 = 0.200000002980232

			if var_392_23 <= arg_389_1.time_ and arg_389_1.time_ < var_392_23 + var_392_24 and not isNil(var_392_22) then
				local var_392_25 = (arg_389_1.time_ - var_392_23) / var_392_24

				if arg_389_1.var_.characterEffect1024ui_story and not isNil(var_392_22) then
					local var_392_26 = Mathf.Lerp(0, 0.5, var_392_25)

					arg_389_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1024ui_story.fillRatio = var_392_26
				end
			end

			if arg_389_1.time_ >= var_392_23 + var_392_24 and arg_389_1.time_ < var_392_23 + var_392_24 + arg_392_0 and not isNil(var_392_22) and arg_389_1.var_.characterEffect1024ui_story then
				local var_392_27 = 0.5

				arg_389_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1024ui_story.fillRatio = var_392_27
			end

			local var_392_28 = 0

			if var_392_28 < arg_389_1.time_ and arg_389_1.time_ <= var_392_28 + arg_392_0 then
				arg_389_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action8_2")
			end

			local var_392_29 = 0

			if var_392_29 < arg_389_1.time_ and arg_389_1.time_ <= var_392_29 + arg_392_0 then
				arg_389_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_392_30 = 0
			local var_392_31 = 0.5

			if var_392_30 < arg_389_1.time_ and arg_389_1.time_ <= var_392_30 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_32 = arg_389_1:FormatText(StoryNameCfg[42].name)

				arg_389_1.leftNameTxt_.text = var_392_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_33 = arg_389_1:GetWordFromCfg(411191095)
				local var_392_34 = arg_389_1:FormatText(var_392_33.content)

				arg_389_1.text_.text = var_392_34

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_35 = 20
				local var_392_36 = utf8.len(var_392_34)
				local var_392_37 = var_392_35 <= 0 and var_392_31 or var_392_31 * (var_392_36 / var_392_35)

				if var_392_37 > 0 and var_392_31 < var_392_37 then
					arg_389_1.talkMaxDuration = var_392_37

					if var_392_37 + var_392_30 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_37 + var_392_30
					end
				end

				arg_389_1.text_.text = var_392_34
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191095", "story_v_out_411191.awb") ~= 0 then
					local var_392_38 = manager.audio:GetVoiceLength("story_v_out_411191", "411191095", "story_v_out_411191.awb") / 1000

					if var_392_38 + var_392_30 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_38 + var_392_30
					end

					if var_392_33.prefab_name ~= "" and arg_389_1.actors_[var_392_33.prefab_name] ~= nil then
						local var_392_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_33.prefab_name].transform, "story_v_out_411191", "411191095", "story_v_out_411191.awb")

						arg_389_1:RecordAudio("411191095", var_392_39)
						arg_389_1:RecordAudio("411191095", var_392_39)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_411191", "411191095", "story_v_out_411191.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_411191", "411191095", "story_v_out_411191.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_40 = math.max(var_392_31, arg_389_1.talkMaxDuration)

			if var_392_30 <= arg_389_1.time_ and arg_389_1.time_ < var_392_30 + var_392_40 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_30) / var_392_40

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_30 + var_392_40 and arg_389_1.time_ < var_392_30 + var_392_40 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play411191096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 411191096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play411191097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1024ui_story"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos1024ui_story = var_396_0.localPosition
			end

			local var_396_2 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2
				local var_396_4 = Vector3.New(0, 100, 0)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1024ui_story, var_396_4, var_396_3)

				local var_396_5 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_5.x, var_396_5.y, var_396_5.z)

				local var_396_6 = var_396_0.localEulerAngles

				var_396_6.z = 0
				var_396_6.x = 0
				var_396_0.localEulerAngles = var_396_6
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(0, 100, 0)

				local var_396_7 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_7.x, var_396_7.y, var_396_7.z)

				local var_396_8 = var_396_0.localEulerAngles

				var_396_8.z = 0
				var_396_8.x = 0
				var_396_0.localEulerAngles = var_396_8
			end

			local var_396_9 = arg_393_1.actors_["1024ui_story"]
			local var_396_10 = 0

			if var_396_10 < arg_393_1.time_ and arg_393_1.time_ <= var_396_10 + arg_396_0 and not isNil(var_396_9) and arg_393_1.var_.characterEffect1024ui_story == nil then
				arg_393_1.var_.characterEffect1024ui_story = var_396_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_11 = 0.200000002980232

			if var_396_10 <= arg_393_1.time_ and arg_393_1.time_ < var_396_10 + var_396_11 and not isNil(var_396_9) then
				local var_396_12 = (arg_393_1.time_ - var_396_10) / var_396_11

				if arg_393_1.var_.characterEffect1024ui_story and not isNil(var_396_9) then
					local var_396_13 = Mathf.Lerp(0, 0.5, var_396_12)

					arg_393_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1024ui_story.fillRatio = var_396_13
				end
			end

			if arg_393_1.time_ >= var_396_10 + var_396_11 and arg_393_1.time_ < var_396_10 + var_396_11 + arg_396_0 and not isNil(var_396_9) and arg_393_1.var_.characterEffect1024ui_story then
				local var_396_14 = 0.5

				arg_393_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1024ui_story.fillRatio = var_396_14
			end

			local var_396_15 = arg_393_1.actors_["4010ui_story"].transform
			local var_396_16 = 0

			if var_396_16 < arg_393_1.time_ and arg_393_1.time_ <= var_396_16 + arg_396_0 then
				arg_393_1.var_.moveOldPos4010ui_story = var_396_15.localPosition
			end

			local var_396_17 = 0.001

			if var_396_16 <= arg_393_1.time_ and arg_393_1.time_ < var_396_16 + var_396_17 then
				local var_396_18 = (arg_393_1.time_ - var_396_16) / var_396_17
				local var_396_19 = Vector3.New(0, 100, 0)

				var_396_15.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos4010ui_story, var_396_19, var_396_18)

				local var_396_20 = manager.ui.mainCamera.transform.position - var_396_15.position

				var_396_15.forward = Vector3.New(var_396_20.x, var_396_20.y, var_396_20.z)

				local var_396_21 = var_396_15.localEulerAngles

				var_396_21.z = 0
				var_396_21.x = 0
				var_396_15.localEulerAngles = var_396_21
			end

			if arg_393_1.time_ >= var_396_16 + var_396_17 and arg_393_1.time_ < var_396_16 + var_396_17 + arg_396_0 then
				var_396_15.localPosition = Vector3.New(0, 100, 0)

				local var_396_22 = manager.ui.mainCamera.transform.position - var_396_15.position

				var_396_15.forward = Vector3.New(var_396_22.x, var_396_22.y, var_396_22.z)

				local var_396_23 = var_396_15.localEulerAngles

				var_396_23.z = 0
				var_396_23.x = 0
				var_396_15.localEulerAngles = var_396_23
			end

			local var_396_24 = arg_393_1.actors_["4010ui_story"]
			local var_396_25 = 0

			if var_396_25 < arg_393_1.time_ and arg_393_1.time_ <= var_396_25 + arg_396_0 and not isNil(var_396_24) and arg_393_1.var_.characterEffect4010ui_story == nil then
				arg_393_1.var_.characterEffect4010ui_story = var_396_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_26 = 0.200000002980232

			if var_396_25 <= arg_393_1.time_ and arg_393_1.time_ < var_396_25 + var_396_26 and not isNil(var_396_24) then
				local var_396_27 = (arg_393_1.time_ - var_396_25) / var_396_26

				if arg_393_1.var_.characterEffect4010ui_story and not isNil(var_396_24) then
					local var_396_28 = Mathf.Lerp(0, 0.5, var_396_27)

					arg_393_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_393_1.var_.characterEffect4010ui_story.fillRatio = var_396_28
				end
			end

			if arg_393_1.time_ >= var_396_25 + var_396_26 and arg_393_1.time_ < var_396_25 + var_396_26 + arg_396_0 and not isNil(var_396_24) and arg_393_1.var_.characterEffect4010ui_story then
				local var_396_29 = 0.5

				arg_393_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_393_1.var_.characterEffect4010ui_story.fillRatio = var_396_29
			end

			local var_396_30 = 0
			local var_396_31 = 0.7

			if var_396_30 < arg_393_1.time_ and arg_393_1.time_ <= var_396_30 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_32 = arg_393_1:GetWordFromCfg(411191096)
				local var_396_33 = arg_393_1:FormatText(var_396_32.content)

				arg_393_1.text_.text = var_396_33

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_34 = 28
				local var_396_35 = utf8.len(var_396_33)
				local var_396_36 = var_396_34 <= 0 and var_396_31 or var_396_31 * (var_396_35 / var_396_34)

				if var_396_36 > 0 and var_396_31 < var_396_36 then
					arg_393_1.talkMaxDuration = var_396_36

					if var_396_36 + var_396_30 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_36 + var_396_30
					end
				end

				arg_393_1.text_.text = var_396_33
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_37 = math.max(var_396_31, arg_393_1.talkMaxDuration)

			if var_396_30 <= arg_393_1.time_ and arg_393_1.time_ < var_396_30 + var_396_37 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_30) / var_396_37

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_30 + var_396_37 and arg_393_1.time_ < var_396_30 + var_396_37 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play411191097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 411191097
		arg_397_1.duration_ = 3.37

		local var_397_0 = {
			zh = 3.366,
			ja = 2.8
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play411191098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1024ui_story"].transform
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.var_.moveOldPos1024ui_story = var_400_0.localPosition
			end

			local var_400_2 = 0.001

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2
				local var_400_4 = Vector3.New(0, -1, -6.05)

				var_400_0.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1024ui_story, var_400_4, var_400_3)

				local var_400_5 = manager.ui.mainCamera.transform.position - var_400_0.position

				var_400_0.forward = Vector3.New(var_400_5.x, var_400_5.y, var_400_5.z)

				local var_400_6 = var_400_0.localEulerAngles

				var_400_6.z = 0
				var_400_6.x = 0
				var_400_0.localEulerAngles = var_400_6
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 then
				var_400_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_400_7 = manager.ui.mainCamera.transform.position - var_400_0.position

				var_400_0.forward = Vector3.New(var_400_7.x, var_400_7.y, var_400_7.z)

				local var_400_8 = var_400_0.localEulerAngles

				var_400_8.z = 0
				var_400_8.x = 0
				var_400_0.localEulerAngles = var_400_8
			end

			local var_400_9 = arg_397_1.actors_["1024ui_story"]
			local var_400_10 = 0

			if var_400_10 < arg_397_1.time_ and arg_397_1.time_ <= var_400_10 + arg_400_0 and not isNil(var_400_9) and arg_397_1.var_.characterEffect1024ui_story == nil then
				arg_397_1.var_.characterEffect1024ui_story = var_400_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_11 = 0.200000002980232

			if var_400_10 <= arg_397_1.time_ and arg_397_1.time_ < var_400_10 + var_400_11 and not isNil(var_400_9) then
				local var_400_12 = (arg_397_1.time_ - var_400_10) / var_400_11

				if arg_397_1.var_.characterEffect1024ui_story and not isNil(var_400_9) then
					arg_397_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= var_400_10 + var_400_11 and arg_397_1.time_ < var_400_10 + var_400_11 + arg_400_0 and not isNil(var_400_9) and arg_397_1.var_.characterEffect1024ui_story then
				arg_397_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_400_13 = 0

			if var_400_13 < arg_397_1.time_ and arg_397_1.time_ <= var_400_13 + arg_400_0 then
				arg_397_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action4_1")
			end

			local var_400_14 = 0

			if var_400_14 < arg_397_1.time_ and arg_397_1.time_ <= var_400_14 + arg_400_0 then
				arg_397_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_400_15 = 0
			local var_400_16 = 0.45

			if var_400_15 < arg_397_1.time_ and arg_397_1.time_ <= var_400_15 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_17 = arg_397_1:FormatText(StoryNameCfg[265].name)

				arg_397_1.leftNameTxt_.text = var_400_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_18 = arg_397_1:GetWordFromCfg(411191097)
				local var_400_19 = arg_397_1:FormatText(var_400_18.content)

				arg_397_1.text_.text = var_400_19

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_20 = 18
				local var_400_21 = utf8.len(var_400_19)
				local var_400_22 = var_400_20 <= 0 and var_400_16 or var_400_16 * (var_400_21 / var_400_20)

				if var_400_22 > 0 and var_400_16 < var_400_22 then
					arg_397_1.talkMaxDuration = var_400_22

					if var_400_22 + var_400_15 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_22 + var_400_15
					end
				end

				arg_397_1.text_.text = var_400_19
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191097", "story_v_out_411191.awb") ~= 0 then
					local var_400_23 = manager.audio:GetVoiceLength("story_v_out_411191", "411191097", "story_v_out_411191.awb") / 1000

					if var_400_23 + var_400_15 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_23 + var_400_15
					end

					if var_400_18.prefab_name ~= "" and arg_397_1.actors_[var_400_18.prefab_name] ~= nil then
						local var_400_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_18.prefab_name].transform, "story_v_out_411191", "411191097", "story_v_out_411191.awb")

						arg_397_1:RecordAudio("411191097", var_400_24)
						arg_397_1:RecordAudio("411191097", var_400_24)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_411191", "411191097", "story_v_out_411191.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_411191", "411191097", "story_v_out_411191.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_25 = math.max(var_400_16, arg_397_1.talkMaxDuration)

			if var_400_15 <= arg_397_1.time_ and arg_397_1.time_ < var_400_15 + var_400_25 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_15) / var_400_25

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_15 + var_400_25 and arg_397_1.time_ < var_400_15 + var_400_25 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play411191098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 411191098
		arg_401_1.duration_ = 3

		local var_401_0 = {
			zh = 2.833,
			ja = 3
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play411191099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 0.325

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_2 = arg_401_1:FormatText(StoryNameCfg[265].name)

				arg_401_1.leftNameTxt_.text = var_404_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_3 = arg_401_1:GetWordFromCfg(411191098)
				local var_404_4 = arg_401_1:FormatText(var_404_3.content)

				arg_401_1.text_.text = var_404_4

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_5 = 13
				local var_404_6 = utf8.len(var_404_4)
				local var_404_7 = var_404_5 <= 0 and var_404_1 or var_404_1 * (var_404_6 / var_404_5)

				if var_404_7 > 0 and var_404_1 < var_404_7 then
					arg_401_1.talkMaxDuration = var_404_7

					if var_404_7 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_4
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191098", "story_v_out_411191.awb") ~= 0 then
					local var_404_8 = manager.audio:GetVoiceLength("story_v_out_411191", "411191098", "story_v_out_411191.awb") / 1000

					if var_404_8 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_0
					end

					if var_404_3.prefab_name ~= "" and arg_401_1.actors_[var_404_3.prefab_name] ~= nil then
						local var_404_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_3.prefab_name].transform, "story_v_out_411191", "411191098", "story_v_out_411191.awb")

						arg_401_1:RecordAudio("411191098", var_404_9)
						arg_401_1:RecordAudio("411191098", var_404_9)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_411191", "411191098", "story_v_out_411191.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_411191", "411191098", "story_v_out_411191.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_10 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_10 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_10

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_10 and arg_401_1.time_ < var_404_0 + var_404_10 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play411191099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 411191099
		arg_405_1.duration_ = 1

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play411191100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 0.1

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_2 = arg_405_1:FormatText(StoryNameCfg[265].name)

				arg_405_1.leftNameTxt_.text = var_408_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_3 = arg_405_1:GetWordFromCfg(411191099)
				local var_408_4 = arg_405_1:FormatText(var_408_3.content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 4
				local var_408_6 = utf8.len(var_408_4)
				local var_408_7 = var_408_5 <= 0 and var_408_1 or var_408_1 * (var_408_6 / var_408_5)

				if var_408_7 > 0 and var_408_1 < var_408_7 then
					arg_405_1.talkMaxDuration = var_408_7

					if var_408_7 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_7 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_4
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191099", "story_v_out_411191.awb") ~= 0 then
					local var_408_8 = manager.audio:GetVoiceLength("story_v_out_411191", "411191099", "story_v_out_411191.awb") / 1000

					if var_408_8 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_8 + var_408_0
					end

					if var_408_3.prefab_name ~= "" and arg_405_1.actors_[var_408_3.prefab_name] ~= nil then
						local var_408_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_3.prefab_name].transform, "story_v_out_411191", "411191099", "story_v_out_411191.awb")

						arg_405_1:RecordAudio("411191099", var_408_9)
						arg_405_1:RecordAudio("411191099", var_408_9)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_411191", "411191099", "story_v_out_411191.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_411191", "411191099", "story_v_out_411191.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_10 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_10 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_10

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_10 and arg_405_1.time_ < var_408_0 + var_408_10 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play411191100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 411191100
		arg_409_1.duration_ = 1.77

		local var_409_0 = {
			zh = 1.133,
			ja = 1.766
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play411191101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = "2079ui_story"

			if arg_409_1.actors_[var_412_0] == nil then
				local var_412_1 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_412_1) then
					local var_412_2 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_409_1.stage_.transform)

					var_412_2.name = var_412_0
					var_412_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_409_1.actors_[var_412_0] = var_412_2

					local var_412_3 = var_412_2:GetComponentInChildren(typeof(CharacterEffect))

					var_412_3.enabled = true

					local var_412_4 = GameObjectTools.GetOrAddComponent(var_412_2, typeof(DynamicBoneHelper))

					if var_412_4 then
						var_412_4:EnableDynamicBone(false)
					end

					arg_409_1:ShowWeapon(var_412_3.transform, false)

					arg_409_1.var_[var_412_0 .. "Animator"] = var_412_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_409_1.var_[var_412_0 .. "Animator"].applyRootMotion = true
					arg_409_1.var_[var_412_0 .. "LipSync"] = var_412_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_412_5 = arg_409_1.actors_["2079ui_story"].transform
			local var_412_6 = 0

			if var_412_6 < arg_409_1.time_ and arg_409_1.time_ <= var_412_6 + arg_412_0 then
				arg_409_1.var_.moveOldPos2079ui_story = var_412_5.localPosition
			end

			local var_412_7 = 0.001

			if var_412_6 <= arg_409_1.time_ and arg_409_1.time_ < var_412_6 + var_412_7 then
				local var_412_8 = (arg_409_1.time_ - var_412_6) / var_412_7
				local var_412_9 = Vector3.New(0, -1.28, -5.6)

				var_412_5.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos2079ui_story, var_412_9, var_412_8)

				local var_412_10 = manager.ui.mainCamera.transform.position - var_412_5.position

				var_412_5.forward = Vector3.New(var_412_10.x, var_412_10.y, var_412_10.z)

				local var_412_11 = var_412_5.localEulerAngles

				var_412_11.z = 0
				var_412_11.x = 0
				var_412_5.localEulerAngles = var_412_11
			end

			if arg_409_1.time_ >= var_412_6 + var_412_7 and arg_409_1.time_ < var_412_6 + var_412_7 + arg_412_0 then
				var_412_5.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_412_12 = manager.ui.mainCamera.transform.position - var_412_5.position

				var_412_5.forward = Vector3.New(var_412_12.x, var_412_12.y, var_412_12.z)

				local var_412_13 = var_412_5.localEulerAngles

				var_412_13.z = 0
				var_412_13.x = 0
				var_412_5.localEulerAngles = var_412_13
			end

			local var_412_14 = arg_409_1.actors_["2079ui_story"]
			local var_412_15 = 0

			if var_412_15 < arg_409_1.time_ and arg_409_1.time_ <= var_412_15 + arg_412_0 and not isNil(var_412_14) and arg_409_1.var_.characterEffect2079ui_story == nil then
				arg_409_1.var_.characterEffect2079ui_story = var_412_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_16 = 0.200000002980232

			if var_412_15 <= arg_409_1.time_ and arg_409_1.time_ < var_412_15 + var_412_16 and not isNil(var_412_14) then
				local var_412_17 = (arg_409_1.time_ - var_412_15) / var_412_16

				if arg_409_1.var_.characterEffect2079ui_story and not isNil(var_412_14) then
					arg_409_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_15 + var_412_16 and arg_409_1.time_ < var_412_15 + var_412_16 + arg_412_0 and not isNil(var_412_14) and arg_409_1.var_.characterEffect2079ui_story then
				arg_409_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_412_18 = 0

			if var_412_18 < arg_409_1.time_ and arg_409_1.time_ <= var_412_18 + arg_412_0 then
				arg_409_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_412_19 = 0

			if var_412_19 < arg_409_1.time_ and arg_409_1.time_ <= var_412_19 + arg_412_0 then
				arg_409_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_412_20 = arg_409_1.actors_["1024ui_story"].transform
			local var_412_21 = 0

			if var_412_21 < arg_409_1.time_ and arg_409_1.time_ <= var_412_21 + arg_412_0 then
				arg_409_1.var_.moveOldPos1024ui_story = var_412_20.localPosition
			end

			local var_412_22 = 0.001

			if var_412_21 <= arg_409_1.time_ and arg_409_1.time_ < var_412_21 + var_412_22 then
				local var_412_23 = (arg_409_1.time_ - var_412_21) / var_412_22
				local var_412_24 = Vector3.New(0, 100, 0)

				var_412_20.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1024ui_story, var_412_24, var_412_23)

				local var_412_25 = manager.ui.mainCamera.transform.position - var_412_20.position

				var_412_20.forward = Vector3.New(var_412_25.x, var_412_25.y, var_412_25.z)

				local var_412_26 = var_412_20.localEulerAngles

				var_412_26.z = 0
				var_412_26.x = 0
				var_412_20.localEulerAngles = var_412_26
			end

			if arg_409_1.time_ >= var_412_21 + var_412_22 and arg_409_1.time_ < var_412_21 + var_412_22 + arg_412_0 then
				var_412_20.localPosition = Vector3.New(0, 100, 0)

				local var_412_27 = manager.ui.mainCamera.transform.position - var_412_20.position

				var_412_20.forward = Vector3.New(var_412_27.x, var_412_27.y, var_412_27.z)

				local var_412_28 = var_412_20.localEulerAngles

				var_412_28.z = 0
				var_412_28.x = 0
				var_412_20.localEulerAngles = var_412_28
			end

			local var_412_29 = arg_409_1.actors_["1024ui_story"]
			local var_412_30 = 0

			if var_412_30 < arg_409_1.time_ and arg_409_1.time_ <= var_412_30 + arg_412_0 and not isNil(var_412_29) and arg_409_1.var_.characterEffect1024ui_story == nil then
				arg_409_1.var_.characterEffect1024ui_story = var_412_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_31 = 0.200000002980232

			if var_412_30 <= arg_409_1.time_ and arg_409_1.time_ < var_412_30 + var_412_31 and not isNil(var_412_29) then
				local var_412_32 = (arg_409_1.time_ - var_412_30) / var_412_31

				if arg_409_1.var_.characterEffect1024ui_story and not isNil(var_412_29) then
					local var_412_33 = Mathf.Lerp(0, 0.5, var_412_32)

					arg_409_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1024ui_story.fillRatio = var_412_33
				end
			end

			if arg_409_1.time_ >= var_412_30 + var_412_31 and arg_409_1.time_ < var_412_30 + var_412_31 + arg_412_0 and not isNil(var_412_29) and arg_409_1.var_.characterEffect1024ui_story then
				local var_412_34 = 0.5

				arg_409_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1024ui_story.fillRatio = var_412_34
			end

			local var_412_35 = 0
			local var_412_36 = 0.15

			if var_412_35 < arg_409_1.time_ and arg_409_1.time_ <= var_412_35 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_37 = arg_409_1:FormatText(StoryNameCfg[711].name)

				arg_409_1.leftNameTxt_.text = var_412_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_38 = arg_409_1:GetWordFromCfg(411191100)
				local var_412_39 = arg_409_1:FormatText(var_412_38.content)

				arg_409_1.text_.text = var_412_39

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_40 = 6
				local var_412_41 = utf8.len(var_412_39)
				local var_412_42 = var_412_40 <= 0 and var_412_36 or var_412_36 * (var_412_41 / var_412_40)

				if var_412_42 > 0 and var_412_36 < var_412_42 then
					arg_409_1.talkMaxDuration = var_412_42

					if var_412_42 + var_412_35 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_42 + var_412_35
					end
				end

				arg_409_1.text_.text = var_412_39
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191100", "story_v_out_411191.awb") ~= 0 then
					local var_412_43 = manager.audio:GetVoiceLength("story_v_out_411191", "411191100", "story_v_out_411191.awb") / 1000

					if var_412_43 + var_412_35 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_43 + var_412_35
					end

					if var_412_38.prefab_name ~= "" and arg_409_1.actors_[var_412_38.prefab_name] ~= nil then
						local var_412_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_38.prefab_name].transform, "story_v_out_411191", "411191100", "story_v_out_411191.awb")

						arg_409_1:RecordAudio("411191100", var_412_44)
						arg_409_1:RecordAudio("411191100", var_412_44)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_411191", "411191100", "story_v_out_411191.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_411191", "411191100", "story_v_out_411191.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_45 = math.max(var_412_36, arg_409_1.talkMaxDuration)

			if var_412_35 <= arg_409_1.time_ and arg_409_1.time_ < var_412_35 + var_412_45 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_35) / var_412_45

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_35 + var_412_45 and arg_409_1.time_ < var_412_35 + var_412_45 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play411191101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 411191101
		arg_413_1.duration_ = 3.27

		local var_413_0 = {
			zh = 2.5,
			ja = 3.266
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
			arg_413_1.auto_ = false
		end

		function arg_413_1.playNext_(arg_415_0)
			arg_413_1.onStoryFinished_()
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["2079ui_story"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos2079ui_story = var_416_0.localPosition
			end

			local var_416_2 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2
				local var_416_4 = Vector3.New(0, 100, 0)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos2079ui_story, var_416_4, var_416_3)

				local var_416_5 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_5.x, var_416_5.y, var_416_5.z)

				local var_416_6 = var_416_0.localEulerAngles

				var_416_6.z = 0
				var_416_6.x = 0
				var_416_0.localEulerAngles = var_416_6
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0, 100, 0)

				local var_416_7 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_7.x, var_416_7.y, var_416_7.z)

				local var_416_8 = var_416_0.localEulerAngles

				var_416_8.z = 0
				var_416_8.x = 0
				var_416_0.localEulerAngles = var_416_8
			end

			local var_416_9 = arg_413_1.actors_["2079ui_story"]
			local var_416_10 = 0

			if var_416_10 < arg_413_1.time_ and arg_413_1.time_ <= var_416_10 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect2079ui_story == nil then
				arg_413_1.var_.characterEffect2079ui_story = var_416_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_11 = 0.200000002980232

			if var_416_10 <= arg_413_1.time_ and arg_413_1.time_ < var_416_10 + var_416_11 and not isNil(var_416_9) then
				local var_416_12 = (arg_413_1.time_ - var_416_10) / var_416_11

				if arg_413_1.var_.characterEffect2079ui_story and not isNil(var_416_9) then
					local var_416_13 = Mathf.Lerp(0, 0.5, var_416_12)

					arg_413_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_413_1.var_.characterEffect2079ui_story.fillRatio = var_416_13
				end
			end

			if arg_413_1.time_ >= var_416_10 + var_416_11 and arg_413_1.time_ < var_416_10 + var_416_11 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect2079ui_story then
				local var_416_14 = 0.5

				arg_413_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_413_1.var_.characterEffect2079ui_story.fillRatio = var_416_14
			end

			local var_416_15 = arg_413_1.actors_["1024ui_story"].transform
			local var_416_16 = 0

			if var_416_16 < arg_413_1.time_ and arg_413_1.time_ <= var_416_16 + arg_416_0 then
				arg_413_1.var_.moveOldPos1024ui_story = var_416_15.localPosition
			end

			local var_416_17 = 0.001

			if var_416_16 <= arg_413_1.time_ and arg_413_1.time_ < var_416_16 + var_416_17 then
				local var_416_18 = (arg_413_1.time_ - var_416_16) / var_416_17
				local var_416_19 = Vector3.New(0, -1, -6.05)

				var_416_15.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1024ui_story, var_416_19, var_416_18)

				local var_416_20 = manager.ui.mainCamera.transform.position - var_416_15.position

				var_416_15.forward = Vector3.New(var_416_20.x, var_416_20.y, var_416_20.z)

				local var_416_21 = var_416_15.localEulerAngles

				var_416_21.z = 0
				var_416_21.x = 0
				var_416_15.localEulerAngles = var_416_21
			end

			if arg_413_1.time_ >= var_416_16 + var_416_17 and arg_413_1.time_ < var_416_16 + var_416_17 + arg_416_0 then
				var_416_15.localPosition = Vector3.New(0, -1, -6.05)

				local var_416_22 = manager.ui.mainCamera.transform.position - var_416_15.position

				var_416_15.forward = Vector3.New(var_416_22.x, var_416_22.y, var_416_22.z)

				local var_416_23 = var_416_15.localEulerAngles

				var_416_23.z = 0
				var_416_23.x = 0
				var_416_15.localEulerAngles = var_416_23
			end

			local var_416_24 = arg_413_1.actors_["1024ui_story"]
			local var_416_25 = 0

			if var_416_25 < arg_413_1.time_ and arg_413_1.time_ <= var_416_25 + arg_416_0 and not isNil(var_416_24) and arg_413_1.var_.characterEffect1024ui_story == nil then
				arg_413_1.var_.characterEffect1024ui_story = var_416_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_26 = 0.200000002980232

			if var_416_25 <= arg_413_1.time_ and arg_413_1.time_ < var_416_25 + var_416_26 and not isNil(var_416_24) then
				local var_416_27 = (arg_413_1.time_ - var_416_25) / var_416_26

				if arg_413_1.var_.characterEffect1024ui_story and not isNil(var_416_24) then
					arg_413_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_25 + var_416_26 and arg_413_1.time_ < var_416_25 + var_416_26 + arg_416_0 and not isNil(var_416_24) and arg_413_1.var_.characterEffect1024ui_story then
				arg_413_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_416_28 = 0

			if var_416_28 < arg_413_1.time_ and arg_413_1.time_ <= var_416_28 + arg_416_0 then
				arg_413_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action4_2")
			end

			local var_416_29 = 0

			if var_416_29 < arg_413_1.time_ and arg_413_1.time_ <= var_416_29 + arg_416_0 then
				arg_413_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_416_30 = 0
			local var_416_31 = 0.225

			if var_416_30 < arg_413_1.time_ and arg_413_1.time_ <= var_416_30 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_32 = arg_413_1:FormatText(StoryNameCfg[265].name)

				arg_413_1.leftNameTxt_.text = var_416_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_33 = arg_413_1:GetWordFromCfg(411191101)
				local var_416_34 = arg_413_1:FormatText(var_416_33.content)

				arg_413_1.text_.text = var_416_34

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_35 = 9
				local var_416_36 = utf8.len(var_416_34)
				local var_416_37 = var_416_35 <= 0 and var_416_31 or var_416_31 * (var_416_36 / var_416_35)

				if var_416_37 > 0 and var_416_31 < var_416_37 then
					arg_413_1.talkMaxDuration = var_416_37

					if var_416_37 + var_416_30 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_37 + var_416_30
					end
				end

				arg_413_1.text_.text = var_416_34
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411191", "411191101", "story_v_out_411191.awb") ~= 0 then
					local var_416_38 = manager.audio:GetVoiceLength("story_v_out_411191", "411191101", "story_v_out_411191.awb") / 1000

					if var_416_38 + var_416_30 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_38 + var_416_30
					end

					if var_416_33.prefab_name ~= "" and arg_413_1.actors_[var_416_33.prefab_name] ~= nil then
						local var_416_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_33.prefab_name].transform, "story_v_out_411191", "411191101", "story_v_out_411191.awb")

						arg_413_1:RecordAudio("411191101", var_416_39)
						arg_413_1:RecordAudio("411191101", var_416_39)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_411191", "411191101", "story_v_out_411191.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_411191", "411191101", "story_v_out_411191.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_40 = math.max(var_416_31, arg_413_1.talkMaxDuration)

			if var_416_30 <= arg_413_1.time_ and arg_413_1.time_ < var_416_30 + var_416_40 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_30) / var_416_40

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_30 + var_416_40 and arg_413_1.time_ < var_416_30 + var_416_40 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07"
	},
	voices = {
		"story_v_out_411191.awb"
	}
}
