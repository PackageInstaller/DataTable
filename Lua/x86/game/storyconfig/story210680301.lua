return {
	Play1106803001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106803001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1106803002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F03_2"

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
				local var_4_5 = arg_1_1.bgs_.F03_2

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
					if iter_4_0 ~= "F03_2" then
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
			local var_4_23 = 0.1

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

			local var_4_28 = 1.46666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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
			local var_4_35 = 1.2

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

				local var_4_37 = arg_1_1:GetWordFromCfg(1106803001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 48
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
	Play1106803002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1106803002
		arg_9_1.duration_ = 3.57

		local var_9_0 = {
			ja = 3.566,
			ko = 2.699999999999,
			zh = 2.699999999999
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
				arg_9_0:Play1106803003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1068ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1068ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1068ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1068ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1068ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -0.95, -5.88)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1068ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1068ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1068ui_story == nil then
				arg_9_1.var_.characterEffect1068ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.2

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1068ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1068ui_story then
				arg_9_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			local var_12_20 = 0
			local var_12_21 = 0.25

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[218].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(1106803002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 10
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803002", "story_v_side_new_1106803.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803002", "story_v_side_new_1106803.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_side_new_1106803", "1106803002", "story_v_side_new_1106803.awb")

						arg_9_1:RecordAudio("1106803002", var_12_29)
						arg_9_1:RecordAudio("1106803002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803002", "story_v_side_new_1106803.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803002", "story_v_side_new_1106803.awb")
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
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play1106803003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1106803003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1106803004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1068ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1068ui_story == nil then
				arg_13_1.var_.characterEffect1068ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1068ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1068ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1068ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1068ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.625

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

				local var_16_9 = arg_13_1:GetWordFromCfg(1106803003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 25
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
	Play1106803004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1106803004
		arg_17_1.duration_ = 5.63

		local var_17_0 = {
			ja = 5.633,
			ko = 5.466,
			zh = 5.466
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
				arg_17_0:Play1106803005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_20_1 = arg_17_1.actors_["1068ui_story"]
			local var_20_2 = 0

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1068ui_story == nil then
				arg_17_1.var_.characterEffect1068ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_3 = 0.2

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_3 and not isNil(var_20_1) then
				local var_20_4 = (arg_17_1.time_ - var_20_2) / var_20_3

				if arg_17_1.var_.characterEffect1068ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_2 + var_20_3 and arg_17_1.time_ < var_20_2 + var_20_3 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1068ui_story then
				arg_17_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_1")
			end

			local var_20_6 = 0
			local var_20_7 = 0.575

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[218].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_9 = arg_17_1:GetWordFromCfg(1106803004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 23
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803004", "story_v_side_new_1106803.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803004", "story_v_side_new_1106803.awb") / 1000

					if var_20_14 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_6
					end

					if var_20_9.prefab_name ~= "" and arg_17_1.actors_[var_20_9.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_9.prefab_name].transform, "story_v_side_new_1106803", "1106803004", "story_v_side_new_1106803.awb")

						arg_17_1:RecordAudio("1106803004", var_20_15)
						arg_17_1:RecordAudio("1106803004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803004", "story_v_side_new_1106803.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803004", "story_v_side_new_1106803.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_16 and arg_17_1.time_ < var_20_6 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1106803005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1106803005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1106803006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1068ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1068ui_story == nil then
				arg_21_1.var_.characterEffect1068ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1068ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1068ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1068ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1068ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.65

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

				local var_24_9 = arg_21_1:GetWordFromCfg(1106803005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 26
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
	Play1106803006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1106803006
		arg_25_1.duration_ = 17.67

		local var_25_0 = {
			ja = 17.666,
			ko = 8.466,
			zh = 8.466
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
				arg_25_0:Play1106803007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1068ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1068ui_story == nil then
				arg_25_1.var_.characterEffect1068ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1068ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1068ui_story then
				arg_25_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_2")
			end

			local var_28_6 = 0
			local var_28_7 = 1.075

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[218].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(1106803006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 43
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803006", "story_v_side_new_1106803.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803006", "story_v_side_new_1106803.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_side_new_1106803", "1106803006", "story_v_side_new_1106803.awb")

						arg_25_1:RecordAudio("1106803006", var_28_15)
						arg_25_1:RecordAudio("1106803006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803006", "story_v_side_new_1106803.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803006", "story_v_side_new_1106803.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_16 and arg_25_1.time_ < var_28_6 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1106803007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1106803007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1106803008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1068ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1068ui_story == nil then
				arg_29_1.var_.characterEffect1068ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1068ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1068ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1068ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1068ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.35

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

				local var_32_9 = arg_29_1:GetWordFromCfg(1106803007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 14
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
	Play1106803008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1106803008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1106803009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.65

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(1106803008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 26
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1106803009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1106803009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1106803010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.025

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(1106803009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 41
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
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1106803010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1106803010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1106803011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.325

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_2

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

				local var_44_3 = arg_41_1:GetWordFromCfg(1106803010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 13
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1106803011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1106803011
		arg_45_1.duration_ = 3.33

		local var_45_0 = {
			ja = 2.9,
			ko = 3.333,
			zh = 3.333
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
				arg_45_0:Play1106803012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_48_1 = arg_45_1.actors_["1068ui_story"]
			local var_48_2 = 0

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1068ui_story == nil then
				arg_45_1.var_.characterEffect1068ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_3 = 0.2

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_3 and not isNil(var_48_1) then
				local var_48_4 = (arg_45_1.time_ - var_48_2) / var_48_3

				if arg_45_1.var_.characterEffect1068ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_2 + var_48_3 and arg_45_1.time_ < var_48_2 + var_48_3 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1068ui_story then
				arg_45_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_48_5 = 0
			local var_48_6 = 0.225

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_7 = arg_45_1:FormatText(StoryNameCfg[218].name)

				arg_45_1.leftNameTxt_.text = var_48_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(1106803011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 9
				local var_48_11 = utf8.len(var_48_9)
				local var_48_12 = var_48_10 <= 0 and var_48_6 or var_48_6 * (var_48_11 / var_48_10)

				if var_48_12 > 0 and var_48_6 < var_48_12 then
					arg_45_1.talkMaxDuration = var_48_12

					if var_48_12 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803011", "story_v_side_new_1106803.awb") ~= 0 then
					local var_48_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803011", "story_v_side_new_1106803.awb") / 1000

					if var_48_13 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_5
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_side_new_1106803", "1106803011", "story_v_side_new_1106803.awb")

						arg_45_1:RecordAudio("1106803011", var_48_14)
						arg_45_1:RecordAudio("1106803011", var_48_14)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803011", "story_v_side_new_1106803.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803011", "story_v_side_new_1106803.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_15 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_15 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_15

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_15 and arg_45_1.time_ < var_48_5 + var_48_15 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1106803012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1106803012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1106803013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1068ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1068ui_story == nil then
				arg_49_1.var_.characterEffect1068ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1068ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1068ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1068ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1068ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 1.05

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(1106803012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 42
				local var_52_11 = utf8.len(var_52_9)
				local var_52_12 = var_52_10 <= 0 and var_52_7 or var_52_7 * (var_52_11 / var_52_10)

				if var_52_12 > 0 and var_52_7 < var_52_12 then
					arg_49_1.talkMaxDuration = var_52_12

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_13 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_13 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_13

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_13 and arg_49_1.time_ < var_52_6 + var_52_13 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1106803013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1106803013
		arg_53_1.duration_ = 2.53

		local var_53_0 = {
			ja = 2.533,
			ko = 1.166,
			zh = 1.166
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
				arg_53_0:Play1106803014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1068ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1068ui_story == nil then
				arg_53_1.var_.characterEffect1068ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1068ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1068ui_story then
				arg_53_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_56_4 = 0
			local var_56_5 = 0.15

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_6 = arg_53_1:FormatText(StoryNameCfg[414].name)

				arg_53_1.leftNameTxt_.text = var_56_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(1106803013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 6
				local var_56_10 = utf8.len(var_56_8)
				local var_56_11 = var_56_9 <= 0 and var_56_5 or var_56_5 * (var_56_10 / var_56_9)

				if var_56_11 > 0 and var_56_5 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803013", "story_v_side_new_1106803.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803013", "story_v_side_new_1106803.awb") / 1000

					if var_56_12 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_4
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_side_new_1106803", "1106803013", "story_v_side_new_1106803.awb")

						arg_53_1:RecordAudio("1106803013", var_56_13)
						arg_53_1:RecordAudio("1106803013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803013", "story_v_side_new_1106803.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803013", "story_v_side_new_1106803.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_14 and arg_53_1.time_ < var_56_4 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1106803014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1106803014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1106803015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1068ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1068ui_story == nil then
				arg_57_1.var_.characterEffect1068ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1068ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1068ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1068ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1068ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.65

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(1106803014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 26
				local var_60_11 = utf8.len(var_60_9)
				local var_60_12 = var_60_10 <= 0 and var_60_7 or var_60_7 * (var_60_11 / var_60_10)

				if var_60_12 > 0 and var_60_7 < var_60_12 then
					arg_57_1.talkMaxDuration = var_60_12

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_13 and arg_57_1.time_ < var_60_6 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1106803015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1106803015
		arg_61_1.duration_ = 5.83

		local var_61_0 = {
			ja = 5.833,
			ko = 2.633,
			zh = 2.633
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
				arg_61_0:Play1106803016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_64_1 = arg_61_1.actors_["1068ui_story"]
			local var_64_2 = 0

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1068ui_story == nil then
				arg_61_1.var_.characterEffect1068ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.2

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_3 and not isNil(var_64_1) then
				local var_64_4 = (arg_61_1.time_ - var_64_2) / var_64_3

				if arg_61_1.var_.characterEffect1068ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_2 + var_64_3 and arg_61_1.time_ < var_64_2 + var_64_3 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1068ui_story then
				arg_61_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action4_1")
			end

			local var_64_6 = 0
			local var_64_7 = 0.25

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[218].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_9 = arg_61_1:GetWordFromCfg(1106803015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 10
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803015", "story_v_side_new_1106803.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803015", "story_v_side_new_1106803.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_side_new_1106803", "1106803015", "story_v_side_new_1106803.awb")

						arg_61_1:RecordAudio("1106803015", var_64_15)
						arg_61_1:RecordAudio("1106803015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803015", "story_v_side_new_1106803.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803015", "story_v_side_new_1106803.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_16 and arg_61_1.time_ < var_64_6 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1106803016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1106803016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1106803017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1068ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1068ui_story == nil then
				arg_65_1.var_.characterEffect1068ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1068ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1068ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1068ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1068ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 0.75

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(1106803016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 30
				local var_68_11 = utf8.len(var_68_9)
				local var_68_12 = var_68_10 <= 0 and var_68_7 or var_68_7 * (var_68_11 / var_68_10)

				if var_68_12 > 0 and var_68_7 < var_68_12 then
					arg_65_1.talkMaxDuration = var_68_12

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_13 and arg_65_1.time_ < var_68_6 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1106803017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1106803017
		arg_69_1.duration_ = 9.7

		local var_69_0 = {
			ja = 8.3,
			ko = 9.7,
			zh = 9.7
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1106803018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1068ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1068ui_story == nil then
				arg_69_1.var_.characterEffect1068ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1068ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1068ui_story then
				arg_69_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action4_2")
			end

			local var_72_6 = 0
			local var_72_7 = 0.95

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[218].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_9 = arg_69_1:GetWordFromCfg(1106803017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 42
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803017", "story_v_side_new_1106803.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803017", "story_v_side_new_1106803.awb") / 1000

					if var_72_14 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_6
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_side_new_1106803", "1106803017", "story_v_side_new_1106803.awb")

						arg_69_1:RecordAudio("1106803017", var_72_15)
						arg_69_1:RecordAudio("1106803017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803017", "story_v_side_new_1106803.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803017", "story_v_side_new_1106803.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_16 and arg_69_1.time_ < var_72_6 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1106803018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1106803018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1106803019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1068ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1068ui_story == nil then
				arg_73_1.var_.characterEffect1068ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1068ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1068ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1068ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1068ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.8

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(1106803018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 32
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1106803019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1106803019
		arg_77_1.duration_ = 11.37

		local var_77_0 = {
			ja = 9.5,
			ko = 11.366,
			zh = 11.366
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1106803020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1068ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1068ui_story == nil then
				arg_77_1.var_.characterEffect1068ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1068ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1068ui_story then
				arg_77_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_80_4 = 0
			local var_80_5 = 1.25

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_6 = arg_77_1:FormatText(StoryNameCfg[218].name)

				arg_77_1.leftNameTxt_.text = var_80_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(1106803019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 60
				local var_80_10 = utf8.len(var_80_8)
				local var_80_11 = var_80_9 <= 0 and var_80_5 or var_80_5 * (var_80_10 / var_80_9)

				if var_80_11 > 0 and var_80_5 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803019", "story_v_side_new_1106803.awb") ~= 0 then
					local var_80_12 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803019", "story_v_side_new_1106803.awb") / 1000

					if var_80_12 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_4
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_side_new_1106803", "1106803019", "story_v_side_new_1106803.awb")

						arg_77_1:RecordAudio("1106803019", var_80_13)
						arg_77_1:RecordAudio("1106803019", var_80_13)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803019", "story_v_side_new_1106803.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803019", "story_v_side_new_1106803.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_14 and arg_77_1.time_ < var_80_4 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1106803020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1106803020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1106803021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1068ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1068ui_story == nil then
				arg_81_1.var_.characterEffect1068ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1068ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1068ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1068ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1068ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.925

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_9 = arg_81_1:GetWordFromCfg(1106803020)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 37
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1106803021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1106803021
		arg_85_1.duration_ = 10.63

		local var_85_0 = {
			ja = 10.633,
			ko = 8.133,
			zh = 8.133
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1106803022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1068ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1068ui_story == nil then
				arg_85_1.var_.characterEffect1068ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1068ui_story and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1068ui_story then
				arg_85_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 1.025

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_6 = arg_85_1:FormatText(StoryNameCfg[218].name)

				arg_85_1.leftNameTxt_.text = var_88_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(1106803021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 41
				local var_88_10 = utf8.len(var_88_8)
				local var_88_11 = var_88_9 <= 0 and var_88_5 or var_88_5 * (var_88_10 / var_88_9)

				if var_88_11 > 0 and var_88_5 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803021", "story_v_side_new_1106803.awb") ~= 0 then
					local var_88_12 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803021", "story_v_side_new_1106803.awb") / 1000

					if var_88_12 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_4
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_side_new_1106803", "1106803021", "story_v_side_new_1106803.awb")

						arg_85_1:RecordAudio("1106803021", var_88_13)
						arg_85_1:RecordAudio("1106803021", var_88_13)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803021", "story_v_side_new_1106803.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803021", "story_v_side_new_1106803.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_14 and arg_85_1.time_ < var_88_4 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1106803022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1106803022
		arg_89_1.duration_ = 7.17

		local var_89_0 = {
			ja = 4.733,
			ko = 7.166,
			zh = 7.166
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
				arg_89_0:Play1106803023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.55

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[218].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(1106803022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803022", "story_v_side_new_1106803.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803022", "story_v_side_new_1106803.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_side_new_1106803", "1106803022", "story_v_side_new_1106803.awb")

						arg_89_1:RecordAudio("1106803022", var_92_9)
						arg_89_1:RecordAudio("1106803022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803022", "story_v_side_new_1106803.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803022", "story_v_side_new_1106803.awb")
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
	Play1106803023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1106803023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1106803024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1068ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1068ui_story == nil then
				arg_93_1.var_.characterEffect1068ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1068ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1068ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1068ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1068ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 0.775

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[7].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_9 = arg_93_1:GetWordFromCfg(1106803023)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 31
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_14 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_14 and arg_93_1.time_ < var_96_6 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1106803024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1106803024
		arg_97_1.duration_ = 5.93

		local var_97_0 = {
			ja = 5.933,
			ko = 3.2,
			zh = 3.2
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1106803025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_100_1 = arg_97_1.actors_["1068ui_story"]
			local var_100_2 = 0

			if var_100_2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1068ui_story == nil then
				arg_97_1.var_.characterEffect1068ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_3 = 0.2

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_3 and not isNil(var_100_1) then
				local var_100_4 = (arg_97_1.time_ - var_100_2) / var_100_3

				if arg_97_1.var_.characterEffect1068ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_2 + var_100_3 and arg_97_1.time_ < var_100_2 + var_100_3 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1068ui_story then
				arg_97_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_1")
			end

			local var_100_6 = 0
			local var_100_7 = 0.525

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[218].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_9 = arg_97_1:GetWordFromCfg(1106803024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 17
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803024", "story_v_side_new_1106803.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803024", "story_v_side_new_1106803.awb") / 1000

					if var_100_14 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_6
					end

					if var_100_9.prefab_name ~= "" and arg_97_1.actors_[var_100_9.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_9.prefab_name].transform, "story_v_side_new_1106803", "1106803024", "story_v_side_new_1106803.awb")

						arg_97_1:RecordAudio("1106803024", var_100_15)
						arg_97_1:RecordAudio("1106803024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803024", "story_v_side_new_1106803.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803024", "story_v_side_new_1106803.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_16 and arg_97_1.time_ < var_100_6 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1106803025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1106803025
		arg_101_1.duration_ = 9

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1106803026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "ST27"

			if arg_101_1.bgs_[var_104_0] == nil then
				local var_104_1 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_104_0)
				var_104_1.name = var_104_0
				var_104_1.transform.parent = arg_101_1.stage_.transform
				var_104_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_[var_104_0] = var_104_1
			end

			local var_104_2 = 2

			if var_104_2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				local var_104_3 = manager.ui.mainCamera.transform.localPosition
				local var_104_4 = Vector3.New(0, 0, 10) + Vector3.New(var_104_3.x, var_104_3.y, 0)
				local var_104_5 = arg_101_1.bgs_.ST27

				var_104_5.transform.localPosition = var_104_4
				var_104_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_6 = var_104_5:GetComponent("SpriteRenderer")

				if var_104_6 and var_104_6.sprite then
					local var_104_7 = (var_104_5.transform.localPosition - var_104_3).z
					local var_104_8 = manager.ui.mainCameraCom_
					local var_104_9 = 2 * var_104_7 * Mathf.Tan(var_104_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_104_10 = var_104_9 * var_104_8.aspect
					local var_104_11 = var_104_6.sprite.bounds.size.x
					local var_104_12 = var_104_6.sprite.bounds.size.y
					local var_104_13 = var_104_10 / var_104_11
					local var_104_14 = var_104_9 / var_104_12
					local var_104_15 = var_104_14 < var_104_13 and var_104_13 or var_104_14

					var_104_5.transform.localScale = Vector3.New(var_104_15, var_104_15, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "ST27" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_17 = 2

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17
				local var_104_19 = Color.New(0, 0, 0)

				var_104_19.a = Mathf.Lerp(0, 1, var_104_18)
				arg_101_1.mask_.color = var_104_19
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 then
				local var_104_20 = Color.New(0, 0, 0)

				var_104_20.a = 1
				arg_101_1.mask_.color = var_104_20
			end

			local var_104_21 = 2

			if var_104_21 < arg_101_1.time_ and arg_101_1.time_ <= var_104_21 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_22 = 2

			if var_104_21 <= arg_101_1.time_ and arg_101_1.time_ < var_104_21 + var_104_22 then
				local var_104_23 = (arg_101_1.time_ - var_104_21) / var_104_22
				local var_104_24 = Color.New(0, 0, 0)

				var_104_24.a = Mathf.Lerp(1, 0, var_104_23)
				arg_101_1.mask_.color = var_104_24
			end

			if arg_101_1.time_ >= var_104_21 + var_104_22 and arg_101_1.time_ < var_104_21 + var_104_22 + arg_104_0 then
				local var_104_25 = Color.New(0, 0, 0)
				local var_104_26 = 0

				arg_101_1.mask_.enabled = false
				var_104_25.a = var_104_26
				arg_101_1.mask_.color = var_104_25
			end

			local var_104_27 = arg_101_1.actors_["1068ui_story"].transform
			local var_104_28 = 0

			if var_104_28 < arg_101_1.time_ and arg_101_1.time_ <= var_104_28 + arg_104_0 then
				arg_101_1.var_.moveOldPos1068ui_story = var_104_27.localPosition
			end

			local var_104_29 = 0.001

			if var_104_28 <= arg_101_1.time_ and arg_101_1.time_ < var_104_28 + var_104_29 then
				local var_104_30 = (arg_101_1.time_ - var_104_28) / var_104_29
				local var_104_31 = Vector3.New(0, 100, 0)

				var_104_27.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1068ui_story, var_104_31, var_104_30)

				local var_104_32 = manager.ui.mainCamera.transform.position - var_104_27.position

				var_104_27.forward = Vector3.New(var_104_32.x, var_104_32.y, var_104_32.z)

				local var_104_33 = var_104_27.localEulerAngles

				var_104_33.z = 0
				var_104_33.x = 0
				var_104_27.localEulerAngles = var_104_33
			end

			if arg_101_1.time_ >= var_104_28 + var_104_29 and arg_101_1.time_ < var_104_28 + var_104_29 + arg_104_0 then
				var_104_27.localPosition = Vector3.New(0, 100, 0)

				local var_104_34 = manager.ui.mainCamera.transform.position - var_104_27.position

				var_104_27.forward = Vector3.New(var_104_34.x, var_104_34.y, var_104_34.z)

				local var_104_35 = var_104_27.localEulerAngles

				var_104_35.z = 0
				var_104_35.x = 0
				var_104_27.localEulerAngles = var_104_35
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_36 = 4
			local var_104_37 = 0.925

			if var_104_36 < arg_101_1.time_ and arg_101_1.time_ <= var_104_36 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_38 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_38:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_39 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_40 = arg_101_1:GetWordFromCfg(1106803025)
				local var_104_41 = arg_101_1:FormatText(var_104_40.content)

				arg_101_1.text_.text = var_104_41

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_42 = 37
				local var_104_43 = utf8.len(var_104_41)
				local var_104_44 = var_104_42 <= 0 and var_104_37 or var_104_37 * (var_104_43 / var_104_42)

				if var_104_44 > 0 and var_104_37 < var_104_44 then
					arg_101_1.talkMaxDuration = var_104_44
					var_104_36 = var_104_36 + 0.3

					if var_104_44 + var_104_36 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_44 + var_104_36
					end
				end

				arg_101_1.text_.text = var_104_41
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_45 = var_104_36 + 0.3
			local var_104_46 = math.max(var_104_37, arg_101_1.talkMaxDuration)

			if var_104_45 <= arg_101_1.time_ and arg_101_1.time_ < var_104_45 + var_104_46 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_45) / var_104_46

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_45 + var_104_46 and arg_101_1.time_ < var_104_45 + var_104_46 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play1106803026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1106803026
		arg_107_1.duration_ = 4.43

		local var_107_0 = {
			ja = 3.8,
			ko = 4.433,
			zh = 4.433
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
				arg_107_0:Play1106803027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1068ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos1068ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(0, -0.95, -5.88)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1068ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 then
				arg_107_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			local var_110_11 = arg_107_1.actors_["1068ui_story"]
			local var_110_12 = 0

			if var_110_12 < arg_107_1.time_ and arg_107_1.time_ <= var_110_12 + arg_110_0 and not isNil(var_110_11) and arg_107_1.var_.characterEffect1068ui_story == nil then
				arg_107_1.var_.characterEffect1068ui_story = var_110_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_13 = 0.2

			if var_110_12 <= arg_107_1.time_ and arg_107_1.time_ < var_110_12 + var_110_13 and not isNil(var_110_11) then
				local var_110_14 = (arg_107_1.time_ - var_110_12) / var_110_13

				if arg_107_1.var_.characterEffect1068ui_story and not isNil(var_110_11) then
					arg_107_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_12 + var_110_13 and arg_107_1.time_ < var_110_12 + var_110_13 + arg_110_0 and not isNil(var_110_11) and arg_107_1.var_.characterEffect1068ui_story then
				arg_107_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_110_15 = 0
			local var_110_16 = 0.45

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_17 = arg_107_1:FormatText(StoryNameCfg[218].name)

				arg_107_1.leftNameTxt_.text = var_110_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_18 = arg_107_1:GetWordFromCfg(1106803026)
				local var_110_19 = arg_107_1:FormatText(var_110_18.content)

				arg_107_1.text_.text = var_110_19

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_20 = 18
				local var_110_21 = utf8.len(var_110_19)
				local var_110_22 = var_110_20 <= 0 and var_110_16 or var_110_16 * (var_110_21 / var_110_20)

				if var_110_22 > 0 and var_110_16 < var_110_22 then
					arg_107_1.talkMaxDuration = var_110_22

					if var_110_22 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_22 + var_110_15
					end
				end

				arg_107_1.text_.text = var_110_19
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803026", "story_v_side_new_1106803.awb") ~= 0 then
					local var_110_23 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803026", "story_v_side_new_1106803.awb") / 1000

					if var_110_23 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_23 + var_110_15
					end

					if var_110_18.prefab_name ~= "" and arg_107_1.actors_[var_110_18.prefab_name] ~= nil then
						local var_110_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_18.prefab_name].transform, "story_v_side_new_1106803", "1106803026", "story_v_side_new_1106803.awb")

						arg_107_1:RecordAudio("1106803026", var_110_24)
						arg_107_1:RecordAudio("1106803026", var_110_24)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803026", "story_v_side_new_1106803.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803026", "story_v_side_new_1106803.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_25 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_25 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_15) / var_110_25

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_15 + var_110_25 and arg_107_1.time_ < var_110_15 + var_110_25 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play1106803027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1106803027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1106803028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1068ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1068ui_story == nil then
				arg_111_1.var_.characterEffect1068ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1068ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1068ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1068ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1068ui_story.fillRatio = var_114_5
			end

			local var_114_6 = 0
			local var_114_7 = 0.3

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[7].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_9 = arg_111_1:GetWordFromCfg(1106803027)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 12
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_14 and arg_111_1.time_ < var_114_6 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1106803028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1106803028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1106803029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.6

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:GetWordFromCfg(1106803028)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 24
				local var_118_5 = utf8.len(var_118_3)
				local var_118_6 = var_118_4 <= 0 and var_118_1 or var_118_1 * (var_118_5 / var_118_4)

				if var_118_6 > 0 and var_118_1 < var_118_6 then
					arg_115_1.talkMaxDuration = var_118_6

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_7 and arg_115_1.time_ < var_118_0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1106803029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1106803029
		arg_119_1.duration_ = 10.6

		local var_119_0 = {
			ja = 10.6,
			ko = 7.3,
			zh = 7.3
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
				arg_119_0:Play1106803030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_1")
			end

			local var_122_1 = arg_119_1.actors_["1068ui_story"]
			local var_122_2 = 0

			if var_122_2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1068ui_story == nil then
				arg_119_1.var_.characterEffect1068ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_3 = 0.2

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_3 and not isNil(var_122_1) then
				local var_122_4 = (arg_119_1.time_ - var_122_2) / var_122_3

				if arg_119_1.var_.characterEffect1068ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_2 + var_122_3 and arg_119_1.time_ < var_122_2 + var_122_3 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1068ui_story then
				arg_119_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_122_6 = 0
			local var_122_7 = 0.975

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_8 = arg_119_1:FormatText(StoryNameCfg[218].name)

				arg_119_1.leftNameTxt_.text = var_122_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_9 = arg_119_1:GetWordFromCfg(1106803029)
				local var_122_10 = arg_119_1:FormatText(var_122_9.content)

				arg_119_1.text_.text = var_122_10

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 39
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803029", "story_v_side_new_1106803.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803029", "story_v_side_new_1106803.awb") / 1000

					if var_122_14 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_6
					end

					if var_122_9.prefab_name ~= "" and arg_119_1.actors_[var_122_9.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_9.prefab_name].transform, "story_v_side_new_1106803", "1106803029", "story_v_side_new_1106803.awb")

						arg_119_1:RecordAudio("1106803029", var_122_15)
						arg_119_1:RecordAudio("1106803029", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803029", "story_v_side_new_1106803.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803029", "story_v_side_new_1106803.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_16 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_16 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_16

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_16 and arg_119_1.time_ < var_122_6 + var_122_16 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1106803030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1106803030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1106803031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1068ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1068ui_story == nil then
				arg_123_1.var_.characterEffect1068ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1068ui_story and not isNil(var_126_0) then
					local var_126_4 = Mathf.Lerp(0, 0.5, var_126_3)

					arg_123_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1068ui_story.fillRatio = var_126_4
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1068ui_story then
				local var_126_5 = 0.5

				arg_123_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1068ui_story.fillRatio = var_126_5
			end

			local var_126_6 = 0
			local var_126_7 = 0.95

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_8 = arg_123_1:FormatText(StoryNameCfg[7].name)

				arg_123_1.leftNameTxt_.text = var_126_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_9 = arg_123_1:GetWordFromCfg(1106803030)
				local var_126_10 = arg_123_1:FormatText(var_126_9.content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 38
				local var_126_12 = utf8.len(var_126_10)
				local var_126_13 = var_126_11 <= 0 and var_126_7 or var_126_7 * (var_126_12 / var_126_11)

				if var_126_13 > 0 and var_126_7 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_14 and arg_123_1.time_ < var_126_6 + var_126_14 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1106803031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1106803031
		arg_127_1.duration_ = 5.93

		local var_127_0 = {
			ja = 5.933,
			ko = 4.133,
			zh = 4.133
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1106803032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_130_1 = arg_127_1.actors_["1068ui_story"]
			local var_130_2 = 0

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1068ui_story == nil then
				arg_127_1.var_.characterEffect1068ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_3 = 0.2

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_3 and not isNil(var_130_1) then
				local var_130_4 = (arg_127_1.time_ - var_130_2) / var_130_3

				if arg_127_1.var_.characterEffect1068ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_2 + var_130_3 and arg_127_1.time_ < var_130_2 + var_130_3 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1068ui_story then
				arg_127_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_2")
			end

			local var_130_6 = 0
			local var_130_7 = 0.275

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_8 = arg_127_1:FormatText(StoryNameCfg[218].name)

				arg_127_1.leftNameTxt_.text = var_130_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_9 = arg_127_1:GetWordFromCfg(1106803031)
				local var_130_10 = arg_127_1:FormatText(var_130_9.content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 11
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803031", "story_v_side_new_1106803.awb") ~= 0 then
					local var_130_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803031", "story_v_side_new_1106803.awb") / 1000

					if var_130_14 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_14 + var_130_6
					end

					if var_130_9.prefab_name ~= "" and arg_127_1.actors_[var_130_9.prefab_name] ~= nil then
						local var_130_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_9.prefab_name].transform, "story_v_side_new_1106803", "1106803031", "story_v_side_new_1106803.awb")

						arg_127_1:RecordAudio("1106803031", var_130_15)
						arg_127_1:RecordAudio("1106803031", var_130_15)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803031", "story_v_side_new_1106803.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803031", "story_v_side_new_1106803.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_16 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_16 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_16

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_16 and arg_127_1.time_ < var_130_6 + var_130_16 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1106803032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1106803032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1106803033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1068ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1068ui_story == nil then
				arg_131_1.var_.characterEffect1068ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1068ui_story and not isNil(var_134_0) then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1068ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1068ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1068ui_story.fillRatio = var_134_5
			end

			local var_134_6 = 0
			local var_134_7 = 1.475

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(1106803032)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 59
				local var_134_11 = utf8.len(var_134_9)
				local var_134_12 = var_134_10 <= 0 and var_134_7 or var_134_7 * (var_134_11 / var_134_10)

				if var_134_12 > 0 and var_134_7 < var_134_12 then
					arg_131_1.talkMaxDuration = var_134_12

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_13 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_13 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_13

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_13 and arg_131_1.time_ < var_134_6 + var_134_13 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1106803033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1106803033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1106803034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.225

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(1106803033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 9
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1106803034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1106803034
		arg_139_1.duration_ = 8

		local var_139_0 = {
			ja = 8,
			ko = 5.833,
			zh = 5.833
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1106803035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_142_1 = arg_139_1.actors_["1068ui_story"]
			local var_142_2 = 0

			if var_142_2 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1068ui_story == nil then
				arg_139_1.var_.characterEffect1068ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_3 = 0.2

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_3 and not isNil(var_142_1) then
				local var_142_4 = (arg_139_1.time_ - var_142_2) / var_142_3

				if arg_139_1.var_.characterEffect1068ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_2 + var_142_3 and arg_139_1.time_ < var_142_2 + var_142_3 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1068ui_story then
				arg_139_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_142_5 = 0
			local var_142_6 = 0.625

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_7 = arg_139_1:FormatText(StoryNameCfg[218].name)

				arg_139_1.leftNameTxt_.text = var_142_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_8 = arg_139_1:GetWordFromCfg(1106803034)
				local var_142_9 = arg_139_1:FormatText(var_142_8.content)

				arg_139_1.text_.text = var_142_9

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_10 = 25
				local var_142_11 = utf8.len(var_142_9)
				local var_142_12 = var_142_10 <= 0 and var_142_6 or var_142_6 * (var_142_11 / var_142_10)

				if var_142_12 > 0 and var_142_6 < var_142_12 then
					arg_139_1.talkMaxDuration = var_142_12

					if var_142_12 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_9
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803034", "story_v_side_new_1106803.awb") ~= 0 then
					local var_142_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803034", "story_v_side_new_1106803.awb") / 1000

					if var_142_13 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_5
					end

					if var_142_8.prefab_name ~= "" and arg_139_1.actors_[var_142_8.prefab_name] ~= nil then
						local var_142_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_8.prefab_name].transform, "story_v_side_new_1106803", "1106803034", "story_v_side_new_1106803.awb")

						arg_139_1:RecordAudio("1106803034", var_142_14)
						arg_139_1:RecordAudio("1106803034", var_142_14)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803034", "story_v_side_new_1106803.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803034", "story_v_side_new_1106803.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_15 = math.max(var_142_6, arg_139_1.talkMaxDuration)

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_15 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_5) / var_142_15

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_5 + var_142_15 and arg_139_1.time_ < var_142_5 + var_142_15 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1106803035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1106803035
		arg_143_1.duration_ = 7.2

		local var_143_0 = {
			ja = 7.2,
			ko = 6.6,
			zh = 6.6
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
				arg_143_0:Play1106803036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_146_1 = 0
			local var_146_2 = 0.7

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_3 = arg_143_1:FormatText(StoryNameCfg[218].name)

				arg_143_1.leftNameTxt_.text = var_146_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(1106803035)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 28
				local var_146_7 = utf8.len(var_146_5)
				local var_146_8 = var_146_6 <= 0 and var_146_2 or var_146_2 * (var_146_7 / var_146_6)

				if var_146_8 > 0 and var_146_2 < var_146_8 then
					arg_143_1.talkMaxDuration = var_146_8

					if var_146_8 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803035", "story_v_side_new_1106803.awb") ~= 0 then
					local var_146_9 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803035", "story_v_side_new_1106803.awb") / 1000

					if var_146_9 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_1
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_side_new_1106803", "1106803035", "story_v_side_new_1106803.awb")

						arg_143_1:RecordAudio("1106803035", var_146_10)
						arg_143_1:RecordAudio("1106803035", var_146_10)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803035", "story_v_side_new_1106803.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803035", "story_v_side_new_1106803.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_11 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_11 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_11

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_11 and arg_143_1.time_ < var_146_1 + var_146_11 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1106803036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1106803036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1106803037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1068ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1068ui_story == nil then
				arg_147_1.var_.characterEffect1068ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.2

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1068ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1068ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1068ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1068ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0
			local var_150_7 = 0.125

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_8 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_9 = arg_147_1:GetWordFromCfg(1106803036)
				local var_150_10 = arg_147_1:FormatText(var_150_9.content)

				arg_147_1.text_.text = var_150_10

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 5
				local var_150_12 = utf8.len(var_150_10)
				local var_150_13 = var_150_11 <= 0 and var_150_7 or var_150_7 * (var_150_12 / var_150_11)

				if var_150_13 > 0 and var_150_7 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_10
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_14 and arg_147_1.time_ < var_150_6 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1106803037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1106803037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1106803038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 1.65

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_2 = arg_151_1:GetWordFromCfg(1106803037)
				local var_154_3 = arg_151_1:FormatText(var_154_2.content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 66
				local var_154_5 = utf8.len(var_154_3)
				local var_154_6 = var_154_4 <= 0 and var_154_1 or var_154_1 * (var_154_5 / var_154_4)

				if var_154_6 > 0 and var_154_1 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_7 and arg_151_1.time_ < var_154_0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1106803038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1106803038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1106803039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.375

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:GetWordFromCfg(1106803038)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 33
				local var_158_5 = utf8.len(var_158_3)
				local var_158_6 = var_158_4 <= 0 and var_158_1 or var_158_1 * (var_158_5 / var_158_4)

				if var_158_6 > 0 and var_158_1 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_7 and arg_155_1.time_ < var_158_0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1106803039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1106803039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1106803040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.25

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(1106803039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 10
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
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1106803040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1106803040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1106803041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.775

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(1106803040)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 31
				local var_166_5 = utf8.len(var_166_3)
				local var_166_6 = var_166_4 <= 0 and var_166_1 or var_166_1 * (var_166_5 / var_166_4)

				if var_166_6 > 0 and var_166_1 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_7 and arg_163_1.time_ < var_166_0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1106803041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1106803041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1106803042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.225

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

				local var_170_3 = arg_167_1:GetWordFromCfg(1106803041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 9
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
	Play1106803042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1106803042
		arg_171_1.duration_ = 6.73

		local var_171_0 = {
			ja = 6.066,
			ko = 6.733,
			zh = 6.733
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
				arg_171_0:Play1106803043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_174_1 = arg_171_1.actors_["1068ui_story"]
			local var_174_2 = 0

			if var_174_2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1068ui_story == nil then
				arg_171_1.var_.characterEffect1068ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_3 = 0.2

			if var_174_2 <= arg_171_1.time_ and arg_171_1.time_ < var_174_2 + var_174_3 and not isNil(var_174_1) then
				local var_174_4 = (arg_171_1.time_ - var_174_2) / var_174_3

				if arg_171_1.var_.characterEffect1068ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_2 + var_174_3 and arg_171_1.time_ < var_174_2 + var_174_3 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1068ui_story then
				arg_171_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_174_5 = 0
			local var_174_6 = 0.75

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_7 = arg_171_1:FormatText(StoryNameCfg[218].name)

				arg_171_1.leftNameTxt_.text = var_174_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_8 = arg_171_1:GetWordFromCfg(1106803042)
				local var_174_9 = arg_171_1:FormatText(var_174_8.content)

				arg_171_1.text_.text = var_174_9

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 30
				local var_174_11 = utf8.len(var_174_9)
				local var_174_12 = var_174_10 <= 0 and var_174_6 or var_174_6 * (var_174_11 / var_174_10)

				if var_174_12 > 0 and var_174_6 < var_174_12 then
					arg_171_1.talkMaxDuration = var_174_12

					if var_174_12 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_12 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_9
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803042", "story_v_side_new_1106803.awb") ~= 0 then
					local var_174_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803042", "story_v_side_new_1106803.awb") / 1000

					if var_174_13 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_5
					end

					if var_174_8.prefab_name ~= "" and arg_171_1.actors_[var_174_8.prefab_name] ~= nil then
						local var_174_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_8.prefab_name].transform, "story_v_side_new_1106803", "1106803042", "story_v_side_new_1106803.awb")

						arg_171_1:RecordAudio("1106803042", var_174_14)
						arg_171_1:RecordAudio("1106803042", var_174_14)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803042", "story_v_side_new_1106803.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803042", "story_v_side_new_1106803.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_15 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_15 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_15

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_15 and arg_171_1.time_ < var_174_5 + var_174_15 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1106803043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1106803043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1106803044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1068ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1068ui_story == nil then
				arg_175_1.var_.characterEffect1068ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1068ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1068ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1068ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1068ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.525

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_8 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_9 = arg_175_1:GetWordFromCfg(1106803043)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 26
				local var_178_12 = utf8.len(var_178_10)
				local var_178_13 = var_178_11 <= 0 and var_178_7 or var_178_7 * (var_178_12 / var_178_11)

				if var_178_13 > 0 and var_178_7 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_10
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1106803044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1106803044
		arg_179_1.duration_ = 12.37

		local var_179_0 = {
			ja = 12.366,
			ko = 6.933,
			zh = 6.933
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
				arg_179_0:Play1106803045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_182_1 = arg_179_1.actors_["1068ui_story"]
			local var_182_2 = 0

			if var_182_2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1068ui_story == nil then
				arg_179_1.var_.characterEffect1068ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_3 = 0.2

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_3 and not isNil(var_182_1) then
				local var_182_4 = (arg_179_1.time_ - var_182_2) / var_182_3

				if arg_179_1.var_.characterEffect1068ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_2 + var_182_3 and arg_179_1.time_ < var_182_2 + var_182_3 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1068ui_story then
				arg_179_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action4_1")
			end

			local var_182_6 = 0
			local var_182_7 = 0.75

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_8 = arg_179_1:FormatText(StoryNameCfg[218].name)

				arg_179_1.leftNameTxt_.text = var_182_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_9 = arg_179_1:GetWordFromCfg(1106803044)
				local var_182_10 = arg_179_1:FormatText(var_182_9.content)

				arg_179_1.text_.text = var_182_10

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 30
				local var_182_12 = utf8.len(var_182_10)
				local var_182_13 = var_182_11 <= 0 and var_182_7 or var_182_7 * (var_182_12 / var_182_11)

				if var_182_13 > 0 and var_182_7 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_10
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803044", "story_v_side_new_1106803.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803044", "story_v_side_new_1106803.awb") / 1000

					if var_182_14 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_6
					end

					if var_182_9.prefab_name ~= "" and arg_179_1.actors_[var_182_9.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_9.prefab_name].transform, "story_v_side_new_1106803", "1106803044", "story_v_side_new_1106803.awb")

						arg_179_1:RecordAudio("1106803044", var_182_15)
						arg_179_1:RecordAudio("1106803044", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803044", "story_v_side_new_1106803.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803044", "story_v_side_new_1106803.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_16 and arg_179_1.time_ < var_182_6 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1106803045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1106803045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1106803046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1068ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1068ui_story == nil then
				arg_183_1.var_.characterEffect1068ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1068ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1068ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1068ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1068ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 0.525

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:GetWordFromCfg(1106803045)
				local var_186_9 = arg_183_1:FormatText(var_186_8.content)

				arg_183_1.text_.text = var_186_9

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_10 = 21
				local var_186_11 = utf8.len(var_186_9)
				local var_186_12 = var_186_10 <= 0 and var_186_7 or var_186_7 * (var_186_11 / var_186_10)

				if var_186_12 > 0 and var_186_7 < var_186_12 then
					arg_183_1.talkMaxDuration = var_186_12

					if var_186_12 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_9
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_13 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_13 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_13

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_13 and arg_183_1.time_ < var_186_6 + var_186_13 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1106803046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1106803046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1106803047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.3

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(1106803046)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 12
				local var_190_5 = utf8.len(var_190_3)
				local var_190_6 = var_190_4 <= 0 and var_190_1 or var_190_1 * (var_190_5 / var_190_4)

				if var_190_6 > 0 and var_190_1 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_7 and arg_187_1.time_ < var_190_0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1106803047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1106803047
		arg_191_1.duration_ = 9

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1106803048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = "ST22"

			if arg_191_1.bgs_[var_194_0] == nil then
				local var_194_1 = Object.Instantiate(arg_191_1.paintGo_)

				var_194_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_194_0)
				var_194_1.name = var_194_0
				var_194_1.transform.parent = arg_191_1.stage_.transform
				var_194_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_[var_194_0] = var_194_1
			end

			local var_194_2 = 2

			if var_194_2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				local var_194_3 = manager.ui.mainCamera.transform.localPosition
				local var_194_4 = Vector3.New(0, 0, 10) + Vector3.New(var_194_3.x, var_194_3.y, 0)
				local var_194_5 = arg_191_1.bgs_.ST22

				var_194_5.transform.localPosition = var_194_4
				var_194_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_6 = var_194_5:GetComponent("SpriteRenderer")

				if var_194_6 and var_194_6.sprite then
					local var_194_7 = (var_194_5.transform.localPosition - var_194_3).z
					local var_194_8 = manager.ui.mainCameraCom_
					local var_194_9 = 2 * var_194_7 * Mathf.Tan(var_194_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_194_10 = var_194_9 * var_194_8.aspect
					local var_194_11 = var_194_6.sprite.bounds.size.x
					local var_194_12 = var_194_6.sprite.bounds.size.y
					local var_194_13 = var_194_10 / var_194_11
					local var_194_14 = var_194_9 / var_194_12
					local var_194_15 = var_194_14 < var_194_13 and var_194_13 or var_194_14

					var_194_5.transform.localScale = Vector3.New(var_194_15, var_194_15, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "ST22" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_17 = 2

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_17 then
				local var_194_18 = (arg_191_1.time_ - var_194_16) / var_194_17
				local var_194_19 = Color.New(0, 0, 0)

				var_194_19.a = Mathf.Lerp(0, 1, var_194_18)
				arg_191_1.mask_.color = var_194_19
			end

			if arg_191_1.time_ >= var_194_16 + var_194_17 and arg_191_1.time_ < var_194_16 + var_194_17 + arg_194_0 then
				local var_194_20 = Color.New(0, 0, 0)

				var_194_20.a = 1
				arg_191_1.mask_.color = var_194_20
			end

			local var_194_21 = 2

			if var_194_21 < arg_191_1.time_ and arg_191_1.time_ <= var_194_21 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_22 = 2

			if var_194_21 <= arg_191_1.time_ and arg_191_1.time_ < var_194_21 + var_194_22 then
				local var_194_23 = (arg_191_1.time_ - var_194_21) / var_194_22
				local var_194_24 = Color.New(0, 0, 0)

				var_194_24.a = Mathf.Lerp(1, 0, var_194_23)
				arg_191_1.mask_.color = var_194_24
			end

			if arg_191_1.time_ >= var_194_21 + var_194_22 and arg_191_1.time_ < var_194_21 + var_194_22 + arg_194_0 then
				local var_194_25 = Color.New(0, 0, 0)
				local var_194_26 = 0

				arg_191_1.mask_.enabled = false
				var_194_25.a = var_194_26
				arg_191_1.mask_.color = var_194_25
			end

			local var_194_27 = arg_191_1.actors_["1068ui_story"].transform
			local var_194_28 = 1.966

			if var_194_28 < arg_191_1.time_ and arg_191_1.time_ <= var_194_28 + arg_194_0 then
				arg_191_1.var_.moveOldPos1068ui_story = var_194_27.localPosition
			end

			local var_194_29 = 0.001

			if var_194_28 <= arg_191_1.time_ and arg_191_1.time_ < var_194_28 + var_194_29 then
				local var_194_30 = (arg_191_1.time_ - var_194_28) / var_194_29
				local var_194_31 = Vector3.New(0, 100, 0)

				var_194_27.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1068ui_story, var_194_31, var_194_30)

				local var_194_32 = manager.ui.mainCamera.transform.position - var_194_27.position

				var_194_27.forward = Vector3.New(var_194_32.x, var_194_32.y, var_194_32.z)

				local var_194_33 = var_194_27.localEulerAngles

				var_194_33.z = 0
				var_194_33.x = 0
				var_194_27.localEulerAngles = var_194_33
			end

			if arg_191_1.time_ >= var_194_28 + var_194_29 and arg_191_1.time_ < var_194_28 + var_194_29 + arg_194_0 then
				var_194_27.localPosition = Vector3.New(0, 100, 0)

				local var_194_34 = manager.ui.mainCamera.transform.position - var_194_27.position

				var_194_27.forward = Vector3.New(var_194_34.x, var_194_34.y, var_194_34.z)

				local var_194_35 = var_194_27.localEulerAngles

				var_194_35.z = 0
				var_194_35.x = 0
				var_194_27.localEulerAngles = var_194_35
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_36 = 4
			local var_194_37 = 0.975

			if var_194_36 < arg_191_1.time_ and arg_191_1.time_ <= var_194_36 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_38 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_38:setOnUpdate(LuaHelper.FloatAction(function(arg_195_0)
					arg_191_1.dialogCg_.alpha = arg_195_0
				end))
				var_194_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_39 = arg_191_1:GetWordFromCfg(1106803047)
				local var_194_40 = arg_191_1:FormatText(var_194_39.content)

				arg_191_1.text_.text = var_194_40

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_41 = 36
				local var_194_42 = utf8.len(var_194_40)
				local var_194_43 = var_194_41 <= 0 and var_194_37 or var_194_37 * (var_194_42 / var_194_41)

				if var_194_43 > 0 and var_194_37 < var_194_43 then
					arg_191_1.talkMaxDuration = var_194_43
					var_194_36 = var_194_36 + 0.3

					if var_194_43 + var_194_36 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_43 + var_194_36
					end
				end

				arg_191_1.text_.text = var_194_40
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_44 = var_194_36 + 0.3
			local var_194_45 = math.max(var_194_37, arg_191_1.talkMaxDuration)

			if var_194_44 <= arg_191_1.time_ and arg_191_1.time_ < var_194_44 + var_194_45 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_44) / var_194_45

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_44 + var_194_45 and arg_191_1.time_ < var_194_44 + var_194_45 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play1106803048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1106803048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1106803049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 1.175

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(1106803048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 47
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
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_8 and arg_197_1.time_ < var_200_0 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1106803049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1106803049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1106803050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.875

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(1106803049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 35
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
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_8 and arg_201_1.time_ < var_204_0 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1106803050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1106803050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1106803051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 1.025

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

				local var_208_3 = arg_205_1:GetWordFromCfg(1106803050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 41
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
	Play1106803051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1106803051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1106803052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.575

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(1106803051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 23
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_8 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_8 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_8

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_8 and arg_209_1.time_ < var_212_0 + var_212_8 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1106803052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1106803052
		arg_213_1.duration_ = 5.07

		local var_213_0 = {
			ja = 5.066,
			ko = 4.333,
			zh = 4.333
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1106803053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1068ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1068ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(0, -0.95, -5.88)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1068ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 then
				arg_213_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				arg_213_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_216_11 = arg_213_1.actors_["1068ui_story"]
			local var_216_12 = 0

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 and not isNil(var_216_11) and arg_213_1.var_.characterEffect1068ui_story == nil then
				arg_213_1.var_.characterEffect1068ui_story = var_216_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_13 = 0.2

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_13 and not isNil(var_216_11) then
				local var_216_14 = (arg_213_1.time_ - var_216_12) / var_216_13

				if arg_213_1.var_.characterEffect1068ui_story and not isNil(var_216_11) then
					arg_213_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_12 + var_216_13 and arg_213_1.time_ < var_216_12 + var_216_13 + arg_216_0 and not isNil(var_216_11) and arg_213_1.var_.characterEffect1068ui_story then
				arg_213_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_216_15 = 0
			local var_216_16 = 0.575

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_17 = arg_213_1:FormatText(StoryNameCfg[218].name)

				arg_213_1.leftNameTxt_.text = var_216_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(1106803052)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 23
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_16 or var_216_16 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_16 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_15
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803052", "story_v_side_new_1106803.awb") ~= 0 then
					local var_216_23 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803052", "story_v_side_new_1106803.awb") / 1000

					if var_216_23 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_15
					end

					if var_216_18.prefab_name ~= "" and arg_213_1.actors_[var_216_18.prefab_name] ~= nil then
						local var_216_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_18.prefab_name].transform, "story_v_side_new_1106803", "1106803052", "story_v_side_new_1106803.awb")

						arg_213_1:RecordAudio("1106803052", var_216_24)
						arg_213_1:RecordAudio("1106803052", var_216_24)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803052", "story_v_side_new_1106803.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803052", "story_v_side_new_1106803.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_25 = math.max(var_216_16, arg_213_1.talkMaxDuration)

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_25 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_15) / var_216_25

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_15 + var_216_25 and arg_213_1.time_ < var_216_15 + var_216_25 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play1106803053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1106803053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1106803054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1068ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1068ui_story == nil then
				arg_217_1.var_.characterEffect1068ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1068ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1068ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1068ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1068ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 0.975

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_8 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_9 = arg_217_1:GetWordFromCfg(1106803053)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 39
				local var_220_12 = utf8.len(var_220_10)
				local var_220_13 = var_220_11 <= 0 and var_220_7 or var_220_7 * (var_220_12 / var_220_11)

				if var_220_13 > 0 and var_220_7 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_10
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1106803054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1106803054
		arg_221_1.duration_ = 4.9

		local var_221_0 = {
			ja = 4.9,
			ko = 4.6,
			zh = 4.6
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
				arg_221_0:Play1106803055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_224_1 = arg_221_1.actors_["1068ui_story"]
			local var_224_2 = 0

			if var_224_2 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1068ui_story == nil then
				arg_221_1.var_.characterEffect1068ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_3 = 0.2

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_3 and not isNil(var_224_1) then
				local var_224_4 = (arg_221_1.time_ - var_224_2) / var_224_3

				if arg_221_1.var_.characterEffect1068ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_2 + var_224_3 and arg_221_1.time_ < var_224_2 + var_224_3 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1068ui_story then
				arg_221_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_224_5 = 0
			local var_224_6 = 0.35

			if var_224_5 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_7 = arg_221_1:FormatText(StoryNameCfg[218].name)

				arg_221_1.leftNameTxt_.text = var_224_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_8 = arg_221_1:GetWordFromCfg(1106803054)
				local var_224_9 = arg_221_1:FormatText(var_224_8.content)

				arg_221_1.text_.text = var_224_9

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_10 = 14
				local var_224_11 = utf8.len(var_224_9)
				local var_224_12 = var_224_10 <= 0 and var_224_6 or var_224_6 * (var_224_11 / var_224_10)

				if var_224_12 > 0 and var_224_6 < var_224_12 then
					arg_221_1.talkMaxDuration = var_224_12

					if var_224_12 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_12 + var_224_5
					end
				end

				arg_221_1.text_.text = var_224_9
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803054", "story_v_side_new_1106803.awb") ~= 0 then
					local var_224_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803054", "story_v_side_new_1106803.awb") / 1000

					if var_224_13 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_5
					end

					if var_224_8.prefab_name ~= "" and arg_221_1.actors_[var_224_8.prefab_name] ~= nil then
						local var_224_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_8.prefab_name].transform, "story_v_side_new_1106803", "1106803054", "story_v_side_new_1106803.awb")

						arg_221_1:RecordAudio("1106803054", var_224_14)
						arg_221_1:RecordAudio("1106803054", var_224_14)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803054", "story_v_side_new_1106803.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803054", "story_v_side_new_1106803.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_15 = math.max(var_224_6, arg_221_1.talkMaxDuration)

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_15 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_5) / var_224_15

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_5 + var_224_15 and arg_221_1.time_ < var_224_5 + var_224_15 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1106803055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1106803055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1106803056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1068ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1068ui_story == nil then
				arg_225_1.var_.characterEffect1068ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1068ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1068ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1068ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1068ui_story.fillRatio = var_228_5
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

				local var_228_9 = arg_225_1:GetWordFromCfg(1106803055)
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
	Play1106803056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1106803056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1106803057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 1

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(1106803056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 40
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_8 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_8 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_8

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_8 and arg_229_1.time_ < var_232_0 + var_232_8 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1106803057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1106803057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1106803058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 1.1

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[7].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(1106803057)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 44
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_8 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_8 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_8

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_8 and arg_233_1.time_ < var_236_0 + var_236_8 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1106803058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1106803058
		arg_237_1.duration_ = 13

		local var_237_0 = {
			ja = 13,
			ko = 7.666,
			zh = 7.666
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
				arg_237_0:Play1106803059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_240_1 = arg_237_1.actors_["1068ui_story"]
			local var_240_2 = 0

			if var_240_2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1068ui_story == nil then
				arg_237_1.var_.characterEffect1068ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_3 = 0.2

			if var_240_2 <= arg_237_1.time_ and arg_237_1.time_ < var_240_2 + var_240_3 and not isNil(var_240_1) then
				local var_240_4 = (arg_237_1.time_ - var_240_2) / var_240_3

				if arg_237_1.var_.characterEffect1068ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_2 + var_240_3 and arg_237_1.time_ < var_240_2 + var_240_3 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1068ui_story then
				arg_237_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_240_5 = 0

			if var_240_5 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				arg_237_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action4_1")
			end

			local var_240_6 = 0
			local var_240_7 = 0.875

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_8 = arg_237_1:FormatText(StoryNameCfg[218].name)

				arg_237_1.leftNameTxt_.text = var_240_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_9 = arg_237_1:GetWordFromCfg(1106803058)
				local var_240_10 = arg_237_1:FormatText(var_240_9.content)

				arg_237_1.text_.text = var_240_10

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 35
				local var_240_12 = utf8.len(var_240_10)
				local var_240_13 = var_240_11 <= 0 and var_240_7 or var_240_7 * (var_240_12 / var_240_11)

				if var_240_13 > 0 and var_240_7 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_10
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803058", "story_v_side_new_1106803.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803058", "story_v_side_new_1106803.awb") / 1000

					if var_240_14 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_6
					end

					if var_240_9.prefab_name ~= "" and arg_237_1.actors_[var_240_9.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_9.prefab_name].transform, "story_v_side_new_1106803", "1106803058", "story_v_side_new_1106803.awb")

						arg_237_1:RecordAudio("1106803058", var_240_15)
						arg_237_1:RecordAudio("1106803058", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803058", "story_v_side_new_1106803.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803058", "story_v_side_new_1106803.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_16 and arg_237_1.time_ < var_240_6 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1106803059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1106803059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1106803060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1068ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1068ui_story == nil then
				arg_241_1.var_.characterEffect1068ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.2

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1068ui_story and not isNil(var_244_0) then
					local var_244_4 = Mathf.Lerp(0, 0.5, var_244_3)

					arg_241_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1068ui_story.fillRatio = var_244_4
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1068ui_story then
				local var_244_5 = 0.5

				arg_241_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1068ui_story.fillRatio = var_244_5
			end

			local var_244_6 = 0
			local var_244_7 = 1.4

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_8 = arg_241_1:FormatText(StoryNameCfg[7].name)

				arg_241_1.leftNameTxt_.text = var_244_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_9 = arg_241_1:GetWordFromCfg(1106803059)
				local var_244_10 = arg_241_1:FormatText(var_244_9.content)

				arg_241_1.text_.text = var_244_10

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 56
				local var_244_12 = utf8.len(var_244_10)
				local var_244_13 = var_244_11 <= 0 and var_244_7 or var_244_7 * (var_244_12 / var_244_11)

				if var_244_13 > 0 and var_244_7 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_10
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_14 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_14 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_14

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_14 and arg_241_1.time_ < var_244_6 + var_244_14 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1106803060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1106803060
		arg_245_1.duration_ = 11.4

		local var_245_0 = {
			ja = 10.3,
			ko = 11.4,
			zh = 11.4
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1106803061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1068ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1068ui_story == nil then
				arg_245_1.var_.characterEffect1068ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.2

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1068ui_story and not isNil(var_248_0) then
					arg_245_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1068ui_story then
				arg_245_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_248_4 = 0

			if var_248_4 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_248_5 = 0
			local var_248_6 = 1.35

			if var_248_5 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_7 = arg_245_1:FormatText(StoryNameCfg[218].name)

				arg_245_1.leftNameTxt_.text = var_248_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_8 = arg_245_1:GetWordFromCfg(1106803060)
				local var_248_9 = arg_245_1:FormatText(var_248_8.content)

				arg_245_1.text_.text = var_248_9

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_10 = 54
				local var_248_11 = utf8.len(var_248_9)
				local var_248_12 = var_248_10 <= 0 and var_248_6 or var_248_6 * (var_248_11 / var_248_10)

				if var_248_12 > 0 and var_248_6 < var_248_12 then
					arg_245_1.talkMaxDuration = var_248_12

					if var_248_12 + var_248_5 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_12 + var_248_5
					end
				end

				arg_245_1.text_.text = var_248_9
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803060", "story_v_side_new_1106803.awb") ~= 0 then
					local var_248_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803060", "story_v_side_new_1106803.awb") / 1000

					if var_248_13 + var_248_5 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_5
					end

					if var_248_8.prefab_name ~= "" and arg_245_1.actors_[var_248_8.prefab_name] ~= nil then
						local var_248_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_8.prefab_name].transform, "story_v_side_new_1106803", "1106803060", "story_v_side_new_1106803.awb")

						arg_245_1:RecordAudio("1106803060", var_248_14)
						arg_245_1:RecordAudio("1106803060", var_248_14)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803060", "story_v_side_new_1106803.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803060", "story_v_side_new_1106803.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_15 = math.max(var_248_6, arg_245_1.talkMaxDuration)

			if var_248_5 <= arg_245_1.time_ and arg_245_1.time_ < var_248_5 + var_248_15 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_5) / var_248_15

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_5 + var_248_15 and arg_245_1.time_ < var_248_5 + var_248_15 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1106803061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1106803061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1106803062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1068ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1068ui_story == nil then
				arg_249_1.var_.characterEffect1068ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.2

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1068ui_story and not isNil(var_252_0) then
					local var_252_4 = Mathf.Lerp(0, 0.5, var_252_3)

					arg_249_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1068ui_story.fillRatio = var_252_4
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1068ui_story then
				local var_252_5 = 0.5

				arg_249_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1068ui_story.fillRatio = var_252_5
			end

			local var_252_6 = 0
			local var_252_7 = 0.35

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_8 = arg_249_1:FormatText(StoryNameCfg[7].name)

				arg_249_1.leftNameTxt_.text = var_252_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_9 = arg_249_1:GetWordFromCfg(1106803061)
				local var_252_10 = arg_249_1:FormatText(var_252_9.content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 14
				local var_252_12 = utf8.len(var_252_10)
				local var_252_13 = var_252_11 <= 0 and var_252_7 or var_252_7 * (var_252_12 / var_252_11)

				if var_252_13 > 0 and var_252_7 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_10
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_14 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_14 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_14

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_14 and arg_249_1.time_ < var_252_6 + var_252_14 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1106803062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1106803062
		arg_253_1.duration_ = 8.47

		local var_253_0 = {
			ja = 7.033,
			ko = 8.466,
			zh = 8.466
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1106803063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1068ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1068ui_story == nil then
				arg_253_1.var_.characterEffect1068ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.2

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1068ui_story and not isNil(var_256_0) then
					arg_253_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1068ui_story then
				arg_253_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_256_4 = 0

			if var_256_4 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_256_5 = 0

			if var_256_5 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action4_2")
			end

			local var_256_6 = 0
			local var_256_7 = 0.95

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[218].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_9 = arg_253_1:GetWordFromCfg(1106803062)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 38
				local var_256_12 = utf8.len(var_256_10)
				local var_256_13 = var_256_11 <= 0 and var_256_7 or var_256_7 * (var_256_12 / var_256_11)

				if var_256_13 > 0 and var_256_7 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803062", "story_v_side_new_1106803.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803062", "story_v_side_new_1106803.awb") / 1000

					if var_256_14 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_6
					end

					if var_256_9.prefab_name ~= "" and arg_253_1.actors_[var_256_9.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_9.prefab_name].transform, "story_v_side_new_1106803", "1106803062", "story_v_side_new_1106803.awb")

						arg_253_1:RecordAudio("1106803062", var_256_15)
						arg_253_1:RecordAudio("1106803062", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803062", "story_v_side_new_1106803.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803062", "story_v_side_new_1106803.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_16 and arg_253_1.time_ < var_256_6 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1106803063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1106803063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1106803064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1068ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1068ui_story == nil then
				arg_257_1.var_.characterEffect1068ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1068ui_story and not isNil(var_260_0) then
					local var_260_4 = Mathf.Lerp(0, 0.5, var_260_3)

					arg_257_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1068ui_story.fillRatio = var_260_4
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1068ui_story then
				local var_260_5 = 0.5

				arg_257_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1068ui_story.fillRatio = var_260_5
			end

			local var_260_6 = 0
			local var_260_7 = 0.675

			if var_260_6 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_8 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_9 = arg_257_1:GetWordFromCfg(1106803063)
				local var_260_10 = arg_257_1:FormatText(var_260_9.content)

				arg_257_1.text_.text = var_260_10

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_11 = 27
				local var_260_12 = utf8.len(var_260_10)
				local var_260_13 = var_260_11 <= 0 and var_260_7 or var_260_7 * (var_260_12 / var_260_11)

				if var_260_13 > 0 and var_260_7 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_10
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_14 and arg_257_1.time_ < var_260_6 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1106803064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1106803064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1106803065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.8

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(1106803064)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 32
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_8 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_8

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_8 and arg_261_1.time_ < var_264_0 + var_264_8 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1106803065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1106803065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1106803066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.375

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(1106803065)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 15
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_8 and arg_265_1.time_ < var_268_0 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1106803066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1106803066
		arg_269_1.duration_ = 5.7

		local var_269_0 = {
			ja = 3.133,
			ko = 5.7,
			zh = 5.7
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1106803067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_272_1 = arg_269_1.actors_["1068ui_story"]
			local var_272_2 = 0

			if var_272_2 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1068ui_story == nil then
				arg_269_1.var_.characterEffect1068ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_3 = 0.2

			if var_272_2 <= arg_269_1.time_ and arg_269_1.time_ < var_272_2 + var_272_3 and not isNil(var_272_1) then
				local var_272_4 = (arg_269_1.time_ - var_272_2) / var_272_3

				if arg_269_1.var_.characterEffect1068ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_2 + var_272_3 and arg_269_1.time_ < var_272_2 + var_272_3 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1068ui_story then
				arg_269_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_272_5 = 0
			local var_272_6 = 0.75

			if var_272_5 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_7 = arg_269_1:FormatText(StoryNameCfg[218].name)

				arg_269_1.leftNameTxt_.text = var_272_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_8 = arg_269_1:GetWordFromCfg(1106803066)
				local var_272_9 = arg_269_1:FormatText(var_272_8.content)

				arg_269_1.text_.text = var_272_9

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 30
				local var_272_11 = utf8.len(var_272_9)
				local var_272_12 = var_272_10 <= 0 and var_272_6 or var_272_6 * (var_272_11 / var_272_10)

				if var_272_12 > 0 and var_272_6 < var_272_12 then
					arg_269_1.talkMaxDuration = var_272_12

					if var_272_12 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_12 + var_272_5
					end
				end

				arg_269_1.text_.text = var_272_9
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803066", "story_v_side_new_1106803.awb") ~= 0 then
					local var_272_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803066", "story_v_side_new_1106803.awb") / 1000

					if var_272_13 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_13 + var_272_5
					end

					if var_272_8.prefab_name ~= "" and arg_269_1.actors_[var_272_8.prefab_name] ~= nil then
						local var_272_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_8.prefab_name].transform, "story_v_side_new_1106803", "1106803066", "story_v_side_new_1106803.awb")

						arg_269_1:RecordAudio("1106803066", var_272_14)
						arg_269_1:RecordAudio("1106803066", var_272_14)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803066", "story_v_side_new_1106803.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803066", "story_v_side_new_1106803.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_15 = math.max(var_272_6, arg_269_1.talkMaxDuration)

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_15 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_5) / var_272_15

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_5 + var_272_15 and arg_269_1.time_ < var_272_5 + var_272_15 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1106803067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1106803067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1106803068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1068ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1068ui_story == nil then
				arg_273_1.var_.characterEffect1068ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.2

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1068ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1068ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1068ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1068ui_story.fillRatio = var_276_5
			end

			local var_276_6 = 0
			local var_276_7 = 0.425

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_8 = arg_273_1:FormatText(StoryNameCfg[7].name)

				arg_273_1.leftNameTxt_.text = var_276_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_9 = arg_273_1:GetWordFromCfg(1106803067)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 17
				local var_276_12 = utf8.len(var_276_10)
				local var_276_13 = var_276_11 <= 0 and var_276_7 or var_276_7 * (var_276_12 / var_276_11)

				if var_276_13 > 0 and var_276_7 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_10
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1106803068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1106803068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1106803069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.8

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[7].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(1106803068)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 32
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1106803069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1106803069
		arg_281_1.duration_ = 10.4

		local var_281_0 = {
			ja = 10.4,
			ko = 7.3,
			zh = 7.3
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1106803070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_284_1 = arg_281_1.actors_["1068ui_story"]
			local var_284_2 = 0

			if var_284_2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1068ui_story == nil then
				arg_281_1.var_.characterEffect1068ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_3 = 0.2

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_3 and not isNil(var_284_1) then
				local var_284_4 = (arg_281_1.time_ - var_284_2) / var_284_3

				if arg_281_1.var_.characterEffect1068ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_2 + var_284_3 and arg_281_1.time_ < var_284_2 + var_284_3 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1068ui_story then
				arg_281_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_284_5 = 0
			local var_284_6 = 0.875

			if var_284_5 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_7 = arg_281_1:FormatText(StoryNameCfg[218].name)

				arg_281_1.leftNameTxt_.text = var_284_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_8 = arg_281_1:GetWordFromCfg(1106803069)
				local var_284_9 = arg_281_1:FormatText(var_284_8.content)

				arg_281_1.text_.text = var_284_9

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 35
				local var_284_11 = utf8.len(var_284_9)
				local var_284_12 = var_284_10 <= 0 and var_284_6 or var_284_6 * (var_284_11 / var_284_10)

				if var_284_12 > 0 and var_284_6 < var_284_12 then
					arg_281_1.talkMaxDuration = var_284_12

					if var_284_12 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_12 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_9
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803069", "story_v_side_new_1106803.awb") ~= 0 then
					local var_284_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803069", "story_v_side_new_1106803.awb") / 1000

					if var_284_13 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_5
					end

					if var_284_8.prefab_name ~= "" and arg_281_1.actors_[var_284_8.prefab_name] ~= nil then
						local var_284_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_8.prefab_name].transform, "story_v_side_new_1106803", "1106803069", "story_v_side_new_1106803.awb")

						arg_281_1:RecordAudio("1106803069", var_284_14)
						arg_281_1:RecordAudio("1106803069", var_284_14)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803069", "story_v_side_new_1106803.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803069", "story_v_side_new_1106803.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_15 = math.max(var_284_6, arg_281_1.talkMaxDuration)

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_15 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_5) / var_284_15

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_5 + var_284_15 and arg_281_1.time_ < var_284_5 + var_284_15 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1106803070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1106803070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1106803071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1068ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1068ui_story == nil then
				arg_285_1.var_.characterEffect1068ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.2

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1068ui_story and not isNil(var_288_0) then
					local var_288_4 = Mathf.Lerp(0, 0.5, var_288_3)

					arg_285_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1068ui_story.fillRatio = var_288_4
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1068ui_story then
				local var_288_5 = 0.5

				arg_285_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1068ui_story.fillRatio = var_288_5
			end

			local var_288_6 = 0
			local var_288_7 = 0.3

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_8 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_9 = arg_285_1:GetWordFromCfg(1106803070)
				local var_288_10 = arg_285_1:FormatText(var_288_9.content)

				arg_285_1.text_.text = var_288_10

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 12
				local var_288_12 = utf8.len(var_288_10)
				local var_288_13 = var_288_11 <= 0 and var_288_7 or var_288_7 * (var_288_12 / var_288_11)

				if var_288_13 > 0 and var_288_7 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_10
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_14 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_14 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_14

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_14 and arg_285_1.time_ < var_288_6 + var_288_14 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1106803071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1106803071
		arg_289_1.duration_ = 5

		local var_289_0 = {
			ja = 5,
			ko = 4.266,
			zh = 4.266
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1106803072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_292_1 = arg_289_1.actors_["1068ui_story"]
			local var_292_2 = 0

			if var_292_2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1068ui_story == nil then
				arg_289_1.var_.characterEffect1068ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_3 = 0.2

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_3 and not isNil(var_292_1) then
				local var_292_4 = (arg_289_1.time_ - var_292_2) / var_292_3

				if arg_289_1.var_.characterEffect1068ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_2 + var_292_3 and arg_289_1.time_ < var_292_2 + var_292_3 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1068ui_story then
				arg_289_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_292_5 = 0
			local var_292_6 = 0.4

			if var_292_5 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_7 = arg_289_1:FormatText(StoryNameCfg[218].name)

				arg_289_1.leftNameTxt_.text = var_292_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_8 = arg_289_1:GetWordFromCfg(1106803071)
				local var_292_9 = arg_289_1:FormatText(var_292_8.content)

				arg_289_1.text_.text = var_292_9

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_10 = 16
				local var_292_11 = utf8.len(var_292_9)
				local var_292_12 = var_292_10 <= 0 and var_292_6 or var_292_6 * (var_292_11 / var_292_10)

				if var_292_12 > 0 and var_292_6 < var_292_12 then
					arg_289_1.talkMaxDuration = var_292_12

					if var_292_12 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_12 + var_292_5
					end
				end

				arg_289_1.text_.text = var_292_9
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803071", "story_v_side_new_1106803.awb") ~= 0 then
					local var_292_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803071", "story_v_side_new_1106803.awb") / 1000

					if var_292_13 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_5
					end

					if var_292_8.prefab_name ~= "" and arg_289_1.actors_[var_292_8.prefab_name] ~= nil then
						local var_292_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_8.prefab_name].transform, "story_v_side_new_1106803", "1106803071", "story_v_side_new_1106803.awb")

						arg_289_1:RecordAudio("1106803071", var_292_14)
						arg_289_1:RecordAudio("1106803071", var_292_14)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803071", "story_v_side_new_1106803.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803071", "story_v_side_new_1106803.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_15 = math.max(var_292_6, arg_289_1.talkMaxDuration)

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_15 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_5) / var_292_15

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_5 + var_292_15 and arg_289_1.time_ < var_292_5 + var_292_15 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1106803072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1106803072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1106803073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1068ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1068ui_story == nil then
				arg_293_1.var_.characterEffect1068ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.2

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1068ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1068ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1068ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1068ui_story.fillRatio = var_296_5
			end

			local var_296_6 = 0
			local var_296_7 = 0.875

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_8 = arg_293_1:FormatText(StoryNameCfg[7].name)

				arg_293_1.leftNameTxt_.text = var_296_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_9 = arg_293_1:GetWordFromCfg(1106803072)
				local var_296_10 = arg_293_1:FormatText(var_296_9.content)

				arg_293_1.text_.text = var_296_10

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 35
				local var_296_12 = utf8.len(var_296_10)
				local var_296_13 = var_296_11 <= 0 and var_296_7 or var_296_7 * (var_296_12 / var_296_11)

				if var_296_13 > 0 and var_296_7 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_10
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_14 and arg_293_1.time_ < var_296_6 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1106803073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1106803073
		arg_297_1.duration_ = 6.87

		local var_297_0 = {
			ja = 6.566,
			ko = 6.866,
			zh = 6.866
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1106803074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_300_1 = arg_297_1.actors_["1068ui_story"]
			local var_300_2 = 0

			if var_300_2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1068ui_story == nil then
				arg_297_1.var_.characterEffect1068ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_3 = 0.2

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_3 and not isNil(var_300_1) then
				local var_300_4 = (arg_297_1.time_ - var_300_2) / var_300_3

				if arg_297_1.var_.characterEffect1068ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_2 + var_300_3 and arg_297_1.time_ < var_300_2 + var_300_3 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1068ui_story then
				arg_297_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_300_5 = 0
			local var_300_6 = 0.8

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_7 = arg_297_1:FormatText(StoryNameCfg[218].name)

				arg_297_1.leftNameTxt_.text = var_300_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_8 = arg_297_1:GetWordFromCfg(1106803073)
				local var_300_9 = arg_297_1:FormatText(var_300_8.content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_10 = 33
				local var_300_11 = utf8.len(var_300_9)
				local var_300_12 = var_300_10 <= 0 and var_300_6 or var_300_6 * (var_300_11 / var_300_10)

				if var_300_12 > 0 and var_300_6 < var_300_12 then
					arg_297_1.talkMaxDuration = var_300_12

					if var_300_12 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_12 + var_300_5
					end
				end

				arg_297_1.text_.text = var_300_9
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803073", "story_v_side_new_1106803.awb") ~= 0 then
					local var_300_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803073", "story_v_side_new_1106803.awb") / 1000

					if var_300_13 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_5
					end

					if var_300_8.prefab_name ~= "" and arg_297_1.actors_[var_300_8.prefab_name] ~= nil then
						local var_300_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_8.prefab_name].transform, "story_v_side_new_1106803", "1106803073", "story_v_side_new_1106803.awb")

						arg_297_1:RecordAudio("1106803073", var_300_14)
						arg_297_1:RecordAudio("1106803073", var_300_14)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803073", "story_v_side_new_1106803.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803073", "story_v_side_new_1106803.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_15 = math.max(var_300_6, arg_297_1.talkMaxDuration)

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_15 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_5) / var_300_15

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_5 + var_300_15 and arg_297_1.time_ < var_300_5 + var_300_15 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1106803074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1106803074
		arg_301_1.duration_ = 5.83

		local var_301_0 = {
			ja = 4.9,
			ko = 5.833,
			zh = 5.833
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1106803075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_304_1 = 0
			local var_304_2 = 0.775

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_3 = arg_301_1:FormatText(StoryNameCfg[218].name)

				arg_301_1.leftNameTxt_.text = var_304_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_4 = arg_301_1:GetWordFromCfg(1106803074)
				local var_304_5 = arg_301_1:FormatText(var_304_4.content)

				arg_301_1.text_.text = var_304_5

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_6 = 31
				local var_304_7 = utf8.len(var_304_5)
				local var_304_8 = var_304_6 <= 0 and var_304_2 or var_304_2 * (var_304_7 / var_304_6)

				if var_304_8 > 0 and var_304_2 < var_304_8 then
					arg_301_1.talkMaxDuration = var_304_8

					if var_304_8 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_1
					end
				end

				arg_301_1.text_.text = var_304_5
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803074", "story_v_side_new_1106803.awb") ~= 0 then
					local var_304_9 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803074", "story_v_side_new_1106803.awb") / 1000

					if var_304_9 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_1
					end

					if var_304_4.prefab_name ~= "" and arg_301_1.actors_[var_304_4.prefab_name] ~= nil then
						local var_304_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_4.prefab_name].transform, "story_v_side_new_1106803", "1106803074", "story_v_side_new_1106803.awb")

						arg_301_1:RecordAudio("1106803074", var_304_10)
						arg_301_1:RecordAudio("1106803074", var_304_10)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803074", "story_v_side_new_1106803.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803074", "story_v_side_new_1106803.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_11 = math.max(var_304_2, arg_301_1.talkMaxDuration)

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_11 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_1) / var_304_11

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_1 + var_304_11 and arg_301_1.time_ < var_304_1 + var_304_11 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1106803075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1106803075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1106803076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1068ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1068ui_story == nil then
				arg_305_1.var_.characterEffect1068ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.2

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1068ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1068ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1068ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1068ui_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 0.175

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_9 = arg_305_1:GetWordFromCfg(1106803075)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 7
				local var_308_12 = utf8.len(var_308_10)
				local var_308_13 = var_308_11 <= 0 and var_308_7 or var_308_7 * (var_308_12 / var_308_11)

				if var_308_13 > 0 and var_308_7 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_10
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_14 and arg_305_1.time_ < var_308_6 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1106803076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1106803076
		arg_309_1.duration_ = 5.1

		local var_309_0 = {
			ja = 5.1,
			ko = 3.8,
			zh = 3.8
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
				arg_309_0:Play1106803077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1068ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1068ui_story == nil then
				arg_309_1.var_.characterEffect1068ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.2

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1068ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1068ui_story then
				arg_309_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_312_4 = 0
			local var_312_5 = 0.575

			if var_312_4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_6 = arg_309_1:FormatText(StoryNameCfg[218].name)

				arg_309_1.leftNameTxt_.text = var_312_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_7 = arg_309_1:GetWordFromCfg(1106803076)
				local var_312_8 = arg_309_1:FormatText(var_312_7.content)

				arg_309_1.text_.text = var_312_8

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 23
				local var_312_10 = utf8.len(var_312_8)
				local var_312_11 = var_312_9 <= 0 and var_312_5 or var_312_5 * (var_312_10 / var_312_9)

				if var_312_11 > 0 and var_312_5 < var_312_11 then
					arg_309_1.talkMaxDuration = var_312_11

					if var_312_11 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_11 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_8
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803076", "story_v_side_new_1106803.awb") ~= 0 then
					local var_312_12 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803076", "story_v_side_new_1106803.awb") / 1000

					if var_312_12 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_12 + var_312_4
					end

					if var_312_7.prefab_name ~= "" and arg_309_1.actors_[var_312_7.prefab_name] ~= nil then
						local var_312_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_7.prefab_name].transform, "story_v_side_new_1106803", "1106803076", "story_v_side_new_1106803.awb")

						arg_309_1:RecordAudio("1106803076", var_312_13)
						arg_309_1:RecordAudio("1106803076", var_312_13)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803076", "story_v_side_new_1106803.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803076", "story_v_side_new_1106803.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_14 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_14 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_14

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_14 and arg_309_1.time_ < var_312_4 + var_312_14 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1106803077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1106803077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1106803078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1068ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1068ui_story == nil then
				arg_313_1.var_.characterEffect1068ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.2

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1068ui_story and not isNil(var_316_0) then
					local var_316_4 = Mathf.Lerp(0, 0.5, var_316_3)

					arg_313_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1068ui_story.fillRatio = var_316_4
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1068ui_story then
				local var_316_5 = 0.5

				arg_313_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1068ui_story.fillRatio = var_316_5
			end

			local var_316_6 = 0
			local var_316_7 = 0.2

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_8 = arg_313_1:FormatText(StoryNameCfg[7].name)

				arg_313_1.leftNameTxt_.text = var_316_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_9 = arg_313_1:GetWordFromCfg(1106803077)
				local var_316_10 = arg_313_1:FormatText(var_316_9.content)

				arg_313_1.text_.text = var_316_10

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 8
				local var_316_12 = utf8.len(var_316_10)
				local var_316_13 = var_316_11 <= 0 and var_316_7 or var_316_7 * (var_316_12 / var_316_11)

				if var_316_13 > 0 and var_316_7 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_10
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_14 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_14 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_14

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_14 and arg_313_1.time_ < var_316_6 + var_316_14 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1106803078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1106803078
		arg_317_1.duration_ = 3.97

		local var_317_0 = {
			ja = 3.2,
			ko = 3.966,
			zh = 3.966
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
				arg_317_0:Play1106803079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_320_1 = arg_317_1.actors_["1068ui_story"]
			local var_320_2 = 0

			if var_320_2 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1068ui_story == nil then
				arg_317_1.var_.characterEffect1068ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_3 = 0.2

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_3 and not isNil(var_320_1) then
				local var_320_4 = (arg_317_1.time_ - var_320_2) / var_320_3

				if arg_317_1.var_.characterEffect1068ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_2 + var_320_3 and arg_317_1.time_ < var_320_2 + var_320_3 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1068ui_story then
				arg_317_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_320_5 = 0
			local var_320_6 = 0.525

			if var_320_5 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_7 = arg_317_1:FormatText(StoryNameCfg[218].name)

				arg_317_1.leftNameTxt_.text = var_320_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_8 = arg_317_1:GetWordFromCfg(1106803078)
				local var_320_9 = arg_317_1:FormatText(var_320_8.content)

				arg_317_1.text_.text = var_320_9

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_10 = 21
				local var_320_11 = utf8.len(var_320_9)
				local var_320_12 = var_320_10 <= 0 and var_320_6 or var_320_6 * (var_320_11 / var_320_10)

				if var_320_12 > 0 and var_320_6 < var_320_12 then
					arg_317_1.talkMaxDuration = var_320_12

					if var_320_12 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_12 + var_320_5
					end
				end

				arg_317_1.text_.text = var_320_9
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803078", "story_v_side_new_1106803.awb") ~= 0 then
					local var_320_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803078", "story_v_side_new_1106803.awb") / 1000

					if var_320_13 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_5
					end

					if var_320_8.prefab_name ~= "" and arg_317_1.actors_[var_320_8.prefab_name] ~= nil then
						local var_320_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_8.prefab_name].transform, "story_v_side_new_1106803", "1106803078", "story_v_side_new_1106803.awb")

						arg_317_1:RecordAudio("1106803078", var_320_14)
						arg_317_1:RecordAudio("1106803078", var_320_14)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803078", "story_v_side_new_1106803.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803078", "story_v_side_new_1106803.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_15 = math.max(var_320_6, arg_317_1.talkMaxDuration)

			if var_320_5 <= arg_317_1.time_ and arg_317_1.time_ < var_320_5 + var_320_15 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_5) / var_320_15

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_5 + var_320_15 and arg_317_1.time_ < var_320_5 + var_320_15 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1106803079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1106803079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1106803080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1068ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1068ui_story == nil then
				arg_321_1.var_.characterEffect1068ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.2

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect1068ui_story and not isNil(var_324_0) then
					local var_324_4 = Mathf.Lerp(0, 0.5, var_324_3)

					arg_321_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1068ui_story.fillRatio = var_324_4
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1068ui_story then
				local var_324_5 = 0.5

				arg_321_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1068ui_story.fillRatio = var_324_5
			end

			local var_324_6 = 0
			local var_324_7 = 0.375

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_8 = arg_321_1:FormatText(StoryNameCfg[7].name)

				arg_321_1.leftNameTxt_.text = var_324_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_9 = arg_321_1:GetWordFromCfg(1106803079)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 15
				local var_324_12 = utf8.len(var_324_10)
				local var_324_13 = var_324_11 <= 0 and var_324_7 or var_324_7 * (var_324_12 / var_324_11)

				if var_324_13 > 0 and var_324_7 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_10
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_14 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_14 and arg_321_1.time_ < var_324_6 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1106803080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1106803080
		arg_325_1.duration_ = 7.37

		local var_325_0 = {
			ja = 7.166,
			ko = 7.366,
			zh = 7.366
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
				arg_325_0:Play1106803081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_328_1 = arg_325_1.actors_["1068ui_story"]
			local var_328_2 = 0

			if var_328_2 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1068ui_story == nil then
				arg_325_1.var_.characterEffect1068ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_3 = 0.2

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_3 and not isNil(var_328_1) then
				local var_328_4 = (arg_325_1.time_ - var_328_2) / var_328_3

				if arg_325_1.var_.characterEffect1068ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_2 + var_328_3 and arg_325_1.time_ < var_328_2 + var_328_3 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1068ui_story then
				arg_325_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_328_5 = 0
			local var_328_6 = 0.775

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_7 = arg_325_1:FormatText(StoryNameCfg[218].name)

				arg_325_1.leftNameTxt_.text = var_328_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_8 = arg_325_1:GetWordFromCfg(1106803080)
				local var_328_9 = arg_325_1:FormatText(var_328_8.content)

				arg_325_1.text_.text = var_328_9

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_10 = 31
				local var_328_11 = utf8.len(var_328_9)
				local var_328_12 = var_328_10 <= 0 and var_328_6 or var_328_6 * (var_328_11 / var_328_10)

				if var_328_12 > 0 and var_328_6 < var_328_12 then
					arg_325_1.talkMaxDuration = var_328_12

					if var_328_12 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_12 + var_328_5
					end
				end

				arg_325_1.text_.text = var_328_9
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803080", "story_v_side_new_1106803.awb") ~= 0 then
					local var_328_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803080", "story_v_side_new_1106803.awb") / 1000

					if var_328_13 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_13 + var_328_5
					end

					if var_328_8.prefab_name ~= "" and arg_325_1.actors_[var_328_8.prefab_name] ~= nil then
						local var_328_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_8.prefab_name].transform, "story_v_side_new_1106803", "1106803080", "story_v_side_new_1106803.awb")

						arg_325_1:RecordAudio("1106803080", var_328_14)
						arg_325_1:RecordAudio("1106803080", var_328_14)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803080", "story_v_side_new_1106803.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803080", "story_v_side_new_1106803.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_15 = math.max(var_328_6, arg_325_1.talkMaxDuration)

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_15 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_5) / var_328_15

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_5 + var_328_15 and arg_325_1.time_ < var_328_5 + var_328_15 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1106803081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1106803081
		arg_329_1.duration_ = 8.07

		local var_329_0 = {
			ja = 7.466,
			ko = 8.066,
			zh = 8.066
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1106803082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 1.05

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[218].name)

				arg_329_1.leftNameTxt_.text = var_332_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_3 = arg_329_1:GetWordFromCfg(1106803081)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 42
				local var_332_6 = utf8.len(var_332_4)
				local var_332_7 = var_332_5 <= 0 and var_332_1 or var_332_1 * (var_332_6 / var_332_5)

				if var_332_7 > 0 and var_332_1 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803081", "story_v_side_new_1106803.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803081", "story_v_side_new_1106803.awb") / 1000

					if var_332_8 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_0
					end

					if var_332_3.prefab_name ~= "" and arg_329_1.actors_[var_332_3.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_3.prefab_name].transform, "story_v_side_new_1106803", "1106803081", "story_v_side_new_1106803.awb")

						arg_329_1:RecordAudio("1106803081", var_332_9)
						arg_329_1:RecordAudio("1106803081", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803081", "story_v_side_new_1106803.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803081", "story_v_side_new_1106803.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_10 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_10 and arg_329_1.time_ < var_332_0 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1106803082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1106803082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1106803083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1068ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1068ui_story == nil then
				arg_333_1.var_.characterEffect1068ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.2

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1068ui_story and not isNil(var_336_0) then
					local var_336_4 = Mathf.Lerp(0, 0.5, var_336_3)

					arg_333_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1068ui_story.fillRatio = var_336_4
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1068ui_story then
				local var_336_5 = 0.5

				arg_333_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1068ui_story.fillRatio = var_336_5
			end

			local var_336_6 = 0
			local var_336_7 = 1.025

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[7].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_9 = arg_333_1:GetWordFromCfg(1106803082)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 41
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
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_14 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_14 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_14

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_14 and arg_333_1.time_ < var_336_6 + var_336_14 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1106803083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1106803083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1106803084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.45

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(1106803083)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 18
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
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_8 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_8 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_8

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_8 and arg_337_1.time_ < var_340_0 + var_340_8 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1106803084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1106803084
		arg_341_1.duration_ = 8.53

		local var_341_0 = {
			ja = 8.533,
			ko = 7.433,
			zh = 7.433
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
				arg_341_0:Play1106803085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_344_1 = arg_341_1.actors_["1068ui_story"]
			local var_344_2 = 0

			if var_344_2 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1068ui_story == nil then
				arg_341_1.var_.characterEffect1068ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_3 = 0.2

			if var_344_2 <= arg_341_1.time_ and arg_341_1.time_ < var_344_2 + var_344_3 and not isNil(var_344_1) then
				local var_344_4 = (arg_341_1.time_ - var_344_2) / var_344_3

				if arg_341_1.var_.characterEffect1068ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_2 + var_344_3 and arg_341_1.time_ < var_344_2 + var_344_3 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1068ui_story then
				arg_341_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_344_5 = 0
			local var_344_6 = 0.825

			if var_344_5 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_7 = arg_341_1:FormatText(StoryNameCfg[218].name)

				arg_341_1.leftNameTxt_.text = var_344_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_8 = arg_341_1:GetWordFromCfg(1106803084)
				local var_344_9 = arg_341_1:FormatText(var_344_8.content)

				arg_341_1.text_.text = var_344_9

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_10 = 33
				local var_344_11 = utf8.len(var_344_9)
				local var_344_12 = var_344_10 <= 0 and var_344_6 or var_344_6 * (var_344_11 / var_344_10)

				if var_344_12 > 0 and var_344_6 < var_344_12 then
					arg_341_1.talkMaxDuration = var_344_12

					if var_344_12 + var_344_5 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_12 + var_344_5
					end
				end

				arg_341_1.text_.text = var_344_9
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803084", "story_v_side_new_1106803.awb") ~= 0 then
					local var_344_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803084", "story_v_side_new_1106803.awb") / 1000

					if var_344_13 + var_344_5 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_5
					end

					if var_344_8.prefab_name ~= "" and arg_341_1.actors_[var_344_8.prefab_name] ~= nil then
						local var_344_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_8.prefab_name].transform, "story_v_side_new_1106803", "1106803084", "story_v_side_new_1106803.awb")

						arg_341_1:RecordAudio("1106803084", var_344_14)
						arg_341_1:RecordAudio("1106803084", var_344_14)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803084", "story_v_side_new_1106803.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803084", "story_v_side_new_1106803.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_15 = math.max(var_344_6, arg_341_1.talkMaxDuration)

			if var_344_5 <= arg_341_1.time_ and arg_341_1.time_ < var_344_5 + var_344_15 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_5) / var_344_15

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_5 + var_344_15 and arg_341_1.time_ < var_344_5 + var_344_15 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1106803085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1106803085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1106803086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1068ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1068ui_story == nil then
				arg_345_1.var_.characterEffect1068ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.2

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1068ui_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1068ui_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1068ui_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1068ui_story.fillRatio = var_348_5
			end

			local var_348_6 = 0
			local var_348_7 = 0.225

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_8 = arg_345_1:FormatText(StoryNameCfg[7].name)

				arg_345_1.leftNameTxt_.text = var_348_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_9 = arg_345_1:GetWordFromCfg(1106803085)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 9
				local var_348_12 = utf8.len(var_348_10)
				local var_348_13 = var_348_11 <= 0 and var_348_7 or var_348_7 * (var_348_12 / var_348_11)

				if var_348_13 > 0 and var_348_7 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_14 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_14

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_14 and arg_345_1.time_ < var_348_6 + var_348_14 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1106803086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1106803086
		arg_349_1.duration_ = 5.17

		local var_349_0 = {
			ja = 5,
			ko = 5.166,
			zh = 5.166
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
				arg_349_0:Play1106803087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1068ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1068ui_story == nil then
				arg_349_1.var_.characterEffect1068ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.2

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1068ui_story and not isNil(var_352_0) then
					arg_349_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1068ui_story then
				arg_349_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_352_4 = 0

			if var_352_4 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_352_5 = 0
			local var_352_6 = 0.725

			if var_352_5 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_7 = arg_349_1:FormatText(StoryNameCfg[218].name)

				arg_349_1.leftNameTxt_.text = var_352_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_8 = arg_349_1:GetWordFromCfg(1106803086)
				local var_352_9 = arg_349_1:FormatText(var_352_8.content)

				arg_349_1.text_.text = var_352_9

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_10 = 29
				local var_352_11 = utf8.len(var_352_9)
				local var_352_12 = var_352_10 <= 0 and var_352_6 or var_352_6 * (var_352_11 / var_352_10)

				if var_352_12 > 0 and var_352_6 < var_352_12 then
					arg_349_1.talkMaxDuration = var_352_12

					if var_352_12 + var_352_5 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_12 + var_352_5
					end
				end

				arg_349_1.text_.text = var_352_9
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803086", "story_v_side_new_1106803.awb") ~= 0 then
					local var_352_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803086", "story_v_side_new_1106803.awb") / 1000

					if var_352_13 + var_352_5 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_5
					end

					if var_352_8.prefab_name ~= "" and arg_349_1.actors_[var_352_8.prefab_name] ~= nil then
						local var_352_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_8.prefab_name].transform, "story_v_side_new_1106803", "1106803086", "story_v_side_new_1106803.awb")

						arg_349_1:RecordAudio("1106803086", var_352_14)
						arg_349_1:RecordAudio("1106803086", var_352_14)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803086", "story_v_side_new_1106803.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803086", "story_v_side_new_1106803.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_15 = math.max(var_352_6, arg_349_1.talkMaxDuration)

			if var_352_5 <= arg_349_1.time_ and arg_349_1.time_ < var_352_5 + var_352_15 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_5) / var_352_15

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_5 + var_352_15 and arg_349_1.time_ < var_352_5 + var_352_15 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1106803087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1106803087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1106803088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1068ui_story"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1068ui_story == nil then
				arg_353_1.var_.characterEffect1068ui_story = var_356_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.2

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.characterEffect1068ui_story and not isNil(var_356_0) then
					local var_356_4 = Mathf.Lerp(0, 0.5, var_356_3)

					arg_353_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1068ui_story.fillRatio = var_356_4
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1068ui_story then
				local var_356_5 = 0.5

				arg_353_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1068ui_story.fillRatio = var_356_5
			end

			local var_356_6 = 0
			local var_356_7 = 1

			if var_356_6 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_8 = arg_353_1:GetWordFromCfg(1106803087)
				local var_356_9 = arg_353_1:FormatText(var_356_8.content)

				arg_353_1.text_.text = var_356_9

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_10 = 40
				local var_356_11 = utf8.len(var_356_9)
				local var_356_12 = var_356_10 <= 0 and var_356_7 or var_356_7 * (var_356_11 / var_356_10)

				if var_356_12 > 0 and var_356_7 < var_356_12 then
					arg_353_1.talkMaxDuration = var_356_12

					if var_356_12 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_12 + var_356_6
					end
				end

				arg_353_1.text_.text = var_356_9
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_13 = math.max(var_356_7, arg_353_1.talkMaxDuration)

			if var_356_6 <= arg_353_1.time_ and arg_353_1.time_ < var_356_6 + var_356_13 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_6) / var_356_13

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_6 + var_356_13 and arg_353_1.time_ < var_356_6 + var_356_13 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1106803088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1106803088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1106803089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 0.9

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_2 = arg_357_1:FormatText(StoryNameCfg[7].name)

				arg_357_1.leftNameTxt_.text = var_360_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_3 = arg_357_1:GetWordFromCfg(1106803088)
				local var_360_4 = arg_357_1:FormatText(var_360_3.content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 36
				local var_360_6 = utf8.len(var_360_4)
				local var_360_7 = var_360_5 <= 0 and var_360_1 or var_360_1 * (var_360_6 / var_360_5)

				if var_360_7 > 0 and var_360_1 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_8 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_8 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_8

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_8 and arg_357_1.time_ < var_360_0 + var_360_8 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play1106803089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1106803089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1106803090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.4

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[7].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(1106803089)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 16
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_8 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_8 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_8

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_8 and arg_361_1.time_ < var_364_0 + var_364_8 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1106803090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1106803090
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1106803091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.875

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[7].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(1106803090)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 35
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_8 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_8 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_8

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_8 and arg_365_1.time_ < var_368_0 + var_368_8 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1106803091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1106803091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1106803092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0
			local var_372_1 = 0.775

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_2 = arg_369_1:FormatText(StoryNameCfg[7].name)

				arg_369_1.leftNameTxt_.text = var_372_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:GetWordFromCfg(1106803091)
				local var_372_4 = arg_369_1:FormatText(var_372_3.content)

				arg_369_1.text_.text = var_372_4

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 31
				local var_372_6 = utf8.len(var_372_4)
				local var_372_7 = var_372_5 <= 0 and var_372_1 or var_372_1 * (var_372_6 / var_372_5)

				if var_372_7 > 0 and var_372_1 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_0
					end
				end

				arg_369_1.text_.text = var_372_4
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_8 = math.max(var_372_1, arg_369_1.talkMaxDuration)

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_8 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_0) / var_372_8

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_0 + var_372_8 and arg_369_1.time_ < var_372_0 + var_372_8 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1106803092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1106803092
		arg_373_1.duration_ = 9

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1106803093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_1 = 2

			if var_376_0 <= arg_373_1.time_ and arg_373_1.time_ < var_376_0 + var_376_1 then
				local var_376_2 = (arg_373_1.time_ - var_376_0) / var_376_1
				local var_376_3 = Color.New(0, 0, 0)

				var_376_3.a = Mathf.Lerp(0, 1, var_376_2)
				arg_373_1.mask_.color = var_376_3
			end

			if arg_373_1.time_ >= var_376_0 + var_376_1 and arg_373_1.time_ < var_376_0 + var_376_1 + arg_376_0 then
				local var_376_4 = Color.New(0, 0, 0)

				var_376_4.a = 1
				arg_373_1.mask_.color = var_376_4
			end

			local var_376_5 = 2

			if var_376_5 < arg_373_1.time_ and arg_373_1.time_ <= var_376_5 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_6 = 2

			if var_376_5 <= arg_373_1.time_ and arg_373_1.time_ < var_376_5 + var_376_6 then
				local var_376_7 = (arg_373_1.time_ - var_376_5) / var_376_6
				local var_376_8 = Color.New(0, 0, 0)

				var_376_8.a = Mathf.Lerp(1, 0, var_376_7)
				arg_373_1.mask_.color = var_376_8
			end

			if arg_373_1.time_ >= var_376_5 + var_376_6 and arg_373_1.time_ < var_376_5 + var_376_6 + arg_376_0 then
				local var_376_9 = Color.New(0, 0, 0)
				local var_376_10 = 0

				arg_373_1.mask_.enabled = false
				var_376_9.a = var_376_10
				arg_373_1.mask_.color = var_376_9
			end

			local var_376_11 = arg_373_1.actors_["1068ui_story"].transform
			local var_376_12 = 1.966

			if var_376_12 < arg_373_1.time_ and arg_373_1.time_ <= var_376_12 + arg_376_0 then
				arg_373_1.var_.moveOldPos1068ui_story = var_376_11.localPosition
			end

			local var_376_13 = 0.001

			if var_376_12 <= arg_373_1.time_ and arg_373_1.time_ < var_376_12 + var_376_13 then
				local var_376_14 = (arg_373_1.time_ - var_376_12) / var_376_13
				local var_376_15 = Vector3.New(0, 100, 0)

				var_376_11.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1068ui_story, var_376_15, var_376_14)

				local var_376_16 = manager.ui.mainCamera.transform.position - var_376_11.position

				var_376_11.forward = Vector3.New(var_376_16.x, var_376_16.y, var_376_16.z)

				local var_376_17 = var_376_11.localEulerAngles

				var_376_17.z = 0
				var_376_17.x = 0
				var_376_11.localEulerAngles = var_376_17
			end

			if arg_373_1.time_ >= var_376_12 + var_376_13 and arg_373_1.time_ < var_376_12 + var_376_13 + arg_376_0 then
				var_376_11.localPosition = Vector3.New(0, 100, 0)

				local var_376_18 = manager.ui.mainCamera.transform.position - var_376_11.position

				var_376_11.forward = Vector3.New(var_376_18.x, var_376_18.y, var_376_18.z)

				local var_376_19 = var_376_11.localEulerAngles

				var_376_19.z = 0
				var_376_19.x = 0
				var_376_11.localEulerAngles = var_376_19
			end

			if arg_373_1.frameCnt_ <= 1 then
				arg_373_1.dialog_:SetActive(false)
			end

			local var_376_20 = 4
			local var_376_21 = 1.075

			if var_376_20 < arg_373_1.time_ and arg_373_1.time_ <= var_376_20 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0

				arg_373_1.dialog_:SetActive(true)

				arg_373_1.dialogCg_.alpha = 0

				local var_376_22 = LeanTween.value(arg_373_1.dialog_, 0, 1, 0.3)

				var_376_22:setOnUpdate(LuaHelper.FloatAction(function(arg_377_0)
					arg_373_1.dialogCg_.alpha = arg_377_0
				end))
				var_376_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_373_1.dialog_)
					var_376_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_373_1.duration_ = arg_373_1.duration_ + 0.3

				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_23 = arg_373_1:GetWordFromCfg(1106803092)
				local var_376_24 = arg_373_1:FormatText(var_376_23.content)

				arg_373_1.text_.text = var_376_24

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_25 = 43
				local var_376_26 = utf8.len(var_376_24)
				local var_376_27 = var_376_25 <= 0 and var_376_21 or var_376_21 * (var_376_26 / var_376_25)

				if var_376_27 > 0 and var_376_21 < var_376_27 then
					arg_373_1.talkMaxDuration = var_376_27
					var_376_20 = var_376_20 + 0.3

					if var_376_27 + var_376_20 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_27 + var_376_20
					end
				end

				arg_373_1.text_.text = var_376_24
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_28 = var_376_20 + 0.3
			local var_376_29 = math.max(var_376_21, arg_373_1.talkMaxDuration)

			if var_376_28 <= arg_373_1.time_ and arg_373_1.time_ < var_376_28 + var_376_29 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_28) / var_376_29

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_28 + var_376_29 and arg_373_1.time_ < var_376_28 + var_376_29 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play1106803093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1106803093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1106803094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.85

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_2 = arg_379_1:FormatText(StoryNameCfg[7].name)

				arg_379_1.leftNameTxt_.text = var_382_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(1106803093)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 34
				local var_382_6 = utf8.len(var_382_4)
				local var_382_7 = var_382_5 <= 0 and var_382_1 or var_382_1 * (var_382_6 / var_382_5)

				if var_382_7 > 0 and var_382_1 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_8 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_8 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_8

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_8 and arg_379_1.time_ < var_382_0 + var_382_8 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1106803094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1106803094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1106803095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 0.775

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_2 = arg_383_1:FormatText(StoryNameCfg[7].name)

				arg_383_1.leftNameTxt_.text = var_386_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_3 = arg_383_1:GetWordFromCfg(1106803094)
				local var_386_4 = arg_383_1:FormatText(var_386_3.content)

				arg_383_1.text_.text = var_386_4

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 31
				local var_386_6 = utf8.len(var_386_4)
				local var_386_7 = var_386_5 <= 0 and var_386_1 or var_386_1 * (var_386_6 / var_386_5)

				if var_386_7 > 0 and var_386_1 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_4
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_8 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_8 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_8

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_8 and arg_383_1.time_ < var_386_0 + var_386_8 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1106803095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1106803095
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1106803096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 0.975

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[7].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:GetWordFromCfg(1106803095)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 39
				local var_390_6 = utf8.len(var_390_4)
				local var_390_7 = var_390_5 <= 0 and var_390_1 or var_390_1 * (var_390_6 / var_390_5)

				if var_390_7 > 0 and var_390_1 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_8 and arg_387_1.time_ < var_390_0 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1106803096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1106803096
		arg_391_1.duration_ = 6.2

		local var_391_0 = {
			ja = 6.2,
			ko = 4.5,
			zh = 4.5
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1106803097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1068ui_story"].transform
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos1068ui_story = var_394_0.localPosition
			end

			local var_394_2 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2
				local var_394_4 = Vector3.New(0, -0.95, -5.88)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1068ui_story, var_394_4, var_394_3)

				local var_394_5 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_5.x, var_394_5.y, var_394_5.z)

				local var_394_6 = var_394_0.localEulerAngles

				var_394_6.z = 0
				var_394_6.x = 0
				var_394_0.localEulerAngles = var_394_6
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 then
				var_394_0.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_394_7 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_7.x, var_394_7.y, var_394_7.z)

				local var_394_8 = var_394_0.localEulerAngles

				var_394_8.z = 0
				var_394_8.x = 0
				var_394_0.localEulerAngles = var_394_8
			end

			local var_394_9 = 0

			if var_394_9 < arg_391_1.time_ and arg_391_1.time_ <= var_394_9 + arg_394_0 then
				arg_391_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			local var_394_10 = 0

			if var_394_10 < arg_391_1.time_ and arg_391_1.time_ <= var_394_10 + arg_394_0 then
				arg_391_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_394_11 = arg_391_1.actors_["1068ui_story"]
			local var_394_12 = 0

			if var_394_12 < arg_391_1.time_ and arg_391_1.time_ <= var_394_12 + arg_394_0 and not isNil(var_394_11) and arg_391_1.var_.characterEffect1068ui_story == nil then
				arg_391_1.var_.characterEffect1068ui_story = var_394_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_13 = 0.2

			if var_394_12 <= arg_391_1.time_ and arg_391_1.time_ < var_394_12 + var_394_13 and not isNil(var_394_11) then
				local var_394_14 = (arg_391_1.time_ - var_394_12) / var_394_13

				if arg_391_1.var_.characterEffect1068ui_story and not isNil(var_394_11) then
					arg_391_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= var_394_12 + var_394_13 and arg_391_1.time_ < var_394_12 + var_394_13 + arg_394_0 and not isNil(var_394_11) and arg_391_1.var_.characterEffect1068ui_story then
				arg_391_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_394_15 = 0
			local var_394_16 = 0.575

			if var_394_15 < arg_391_1.time_ and arg_391_1.time_ <= var_394_15 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_17 = arg_391_1:FormatText(StoryNameCfg[218].name)

				arg_391_1.leftNameTxt_.text = var_394_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_18 = arg_391_1:GetWordFromCfg(1106803096)
				local var_394_19 = arg_391_1:FormatText(var_394_18.content)

				arg_391_1.text_.text = var_394_19

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_20 = 21
				local var_394_21 = utf8.len(var_394_19)
				local var_394_22 = var_394_20 <= 0 and var_394_16 or var_394_16 * (var_394_21 / var_394_20)

				if var_394_22 > 0 and var_394_16 < var_394_22 then
					arg_391_1.talkMaxDuration = var_394_22

					if var_394_22 + var_394_15 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_22 + var_394_15
					end
				end

				arg_391_1.text_.text = var_394_19
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803096", "story_v_side_new_1106803.awb") ~= 0 then
					local var_394_23 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803096", "story_v_side_new_1106803.awb") / 1000

					if var_394_23 + var_394_15 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_23 + var_394_15
					end

					if var_394_18.prefab_name ~= "" and arg_391_1.actors_[var_394_18.prefab_name] ~= nil then
						local var_394_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_18.prefab_name].transform, "story_v_side_new_1106803", "1106803096", "story_v_side_new_1106803.awb")

						arg_391_1:RecordAudio("1106803096", var_394_24)
						arg_391_1:RecordAudio("1106803096", var_394_24)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803096", "story_v_side_new_1106803.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803096", "story_v_side_new_1106803.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_25 = math.max(var_394_16, arg_391_1.talkMaxDuration)

			if var_394_15 <= arg_391_1.time_ and arg_391_1.time_ < var_394_15 + var_394_25 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_15) / var_394_25

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_15 + var_394_25 and arg_391_1.time_ < var_394_15 + var_394_25 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play1106803097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1106803097
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1106803098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1068ui_story"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1068ui_story == nil then
				arg_395_1.var_.characterEffect1068ui_story = var_398_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.2

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 and not isNil(var_398_0) then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.characterEffect1068ui_story and not isNil(var_398_0) then
					local var_398_4 = Mathf.Lerp(0, 0.5, var_398_3)

					arg_395_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1068ui_story.fillRatio = var_398_4
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1068ui_story then
				local var_398_5 = 0.5

				arg_395_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1068ui_story.fillRatio = var_398_5
			end

			local var_398_6 = 0
			local var_398_7 = 0.775

			if var_398_6 < arg_395_1.time_ and arg_395_1.time_ <= var_398_6 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_8 = arg_395_1:FormatText(StoryNameCfg[7].name)

				arg_395_1.leftNameTxt_.text = var_398_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_9 = arg_395_1:GetWordFromCfg(1106803097)
				local var_398_10 = arg_395_1:FormatText(var_398_9.content)

				arg_395_1.text_.text = var_398_10

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_11 = 31
				local var_398_12 = utf8.len(var_398_10)
				local var_398_13 = var_398_11 <= 0 and var_398_7 or var_398_7 * (var_398_12 / var_398_11)

				if var_398_13 > 0 and var_398_7 < var_398_13 then
					arg_395_1.talkMaxDuration = var_398_13

					if var_398_13 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_13 + var_398_6
					end
				end

				arg_395_1.text_.text = var_398_10
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_14 = math.max(var_398_7, arg_395_1.talkMaxDuration)

			if var_398_6 <= arg_395_1.time_ and arg_395_1.time_ < var_398_6 + var_398_14 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_6) / var_398_14

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_6 + var_398_14 and arg_395_1.time_ < var_398_6 + var_398_14 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1106803098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1106803098
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1106803099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0
			local var_402_1 = 0.625

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_2 = arg_399_1:FormatText(StoryNameCfg[7].name)

				arg_399_1.leftNameTxt_.text = var_402_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:GetWordFromCfg(1106803098)
				local var_402_4 = arg_399_1:FormatText(var_402_3.content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 25
				local var_402_6 = utf8.len(var_402_4)
				local var_402_7 = var_402_5 <= 0 and var_402_1 or var_402_1 * (var_402_6 / var_402_5)

				if var_402_7 > 0 and var_402_1 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_4
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_8 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_8 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_8

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_8 and arg_399_1.time_ < var_402_0 + var_402_8 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1106803099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1106803099
		arg_403_1.duration_ = 17.4

		local var_403_0 = {
			ja = 17.4,
			ko = 7.666,
			zh = 7.666
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1106803100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_1")
			end

			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_406_2 = arg_403_1.actors_["1068ui_story"]
			local var_406_3 = 0

			if var_406_3 < arg_403_1.time_ and arg_403_1.time_ <= var_406_3 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.characterEffect1068ui_story == nil then
				arg_403_1.var_.characterEffect1068ui_story = var_406_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_4 = 0.2

			if var_406_3 <= arg_403_1.time_ and arg_403_1.time_ < var_406_3 + var_406_4 and not isNil(var_406_2) then
				local var_406_5 = (arg_403_1.time_ - var_406_3) / var_406_4

				if arg_403_1.var_.characterEffect1068ui_story and not isNil(var_406_2) then
					arg_403_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_3 + var_406_4 and arg_403_1.time_ < var_406_3 + var_406_4 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.characterEffect1068ui_story then
				arg_403_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_406_6 = 0
			local var_406_7 = 1

			if var_406_6 < arg_403_1.time_ and arg_403_1.time_ <= var_406_6 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_8 = arg_403_1:FormatText(StoryNameCfg[218].name)

				arg_403_1.leftNameTxt_.text = var_406_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_9 = arg_403_1:GetWordFromCfg(1106803099)
				local var_406_10 = arg_403_1:FormatText(var_406_9.content)

				arg_403_1.text_.text = var_406_10

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_11 = 40
				local var_406_12 = utf8.len(var_406_10)
				local var_406_13 = var_406_11 <= 0 and var_406_7 or var_406_7 * (var_406_12 / var_406_11)

				if var_406_13 > 0 and var_406_7 < var_406_13 then
					arg_403_1.talkMaxDuration = var_406_13

					if var_406_13 + var_406_6 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_13 + var_406_6
					end
				end

				arg_403_1.text_.text = var_406_10
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803099", "story_v_side_new_1106803.awb") ~= 0 then
					local var_406_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803099", "story_v_side_new_1106803.awb") / 1000

					if var_406_14 + var_406_6 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_14 + var_406_6
					end

					if var_406_9.prefab_name ~= "" and arg_403_1.actors_[var_406_9.prefab_name] ~= nil then
						local var_406_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_9.prefab_name].transform, "story_v_side_new_1106803", "1106803099", "story_v_side_new_1106803.awb")

						arg_403_1:RecordAudio("1106803099", var_406_15)
						arg_403_1:RecordAudio("1106803099", var_406_15)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803099", "story_v_side_new_1106803.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803099", "story_v_side_new_1106803.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_16 = math.max(var_406_7, arg_403_1.talkMaxDuration)

			if var_406_6 <= arg_403_1.time_ and arg_403_1.time_ < var_406_6 + var_406_16 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_6) / var_406_16

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_6 + var_406_16 and arg_403_1.time_ < var_406_6 + var_406_16 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1106803100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1106803100
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1106803101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1068ui_story"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1068ui_story == nil then
				arg_407_1.var_.characterEffect1068ui_story = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.2

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.characterEffect1068ui_story and not isNil(var_410_0) then
					local var_410_4 = Mathf.Lerp(0, 0.5, var_410_3)

					arg_407_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1068ui_story.fillRatio = var_410_4
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1068ui_story then
				local var_410_5 = 0.5

				arg_407_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1068ui_story.fillRatio = var_410_5
			end

			local var_410_6 = 0
			local var_410_7 = 0.925

			if var_410_6 < arg_407_1.time_ and arg_407_1.time_ <= var_410_6 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_8 = arg_407_1:FormatText(StoryNameCfg[7].name)

				arg_407_1.leftNameTxt_.text = var_410_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_9 = arg_407_1:GetWordFromCfg(1106803100)
				local var_410_10 = arg_407_1:FormatText(var_410_9.content)

				arg_407_1.text_.text = var_410_10

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_11 = 37
				local var_410_12 = utf8.len(var_410_10)
				local var_410_13 = var_410_11 <= 0 and var_410_7 or var_410_7 * (var_410_12 / var_410_11)

				if var_410_13 > 0 and var_410_7 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_6
					end
				end

				arg_407_1.text_.text = var_410_10
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_14 = math.max(var_410_7, arg_407_1.talkMaxDuration)

			if var_410_6 <= arg_407_1.time_ and arg_407_1.time_ < var_410_6 + var_410_14 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_6) / var_410_14

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_6 + var_410_14 and arg_407_1.time_ < var_410_6 + var_410_14 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1106803101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1106803101
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1106803102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0
			local var_414_1 = 1.075

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_2 = arg_411_1:GetWordFromCfg(1106803101)
				local var_414_3 = arg_411_1:FormatText(var_414_2.content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_4 = 43
				local var_414_5 = utf8.len(var_414_3)
				local var_414_6 = var_414_4 <= 0 and var_414_1 or var_414_1 * (var_414_5 / var_414_4)

				if var_414_6 > 0 and var_414_1 < var_414_6 then
					arg_411_1.talkMaxDuration = var_414_6

					if var_414_6 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_6 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_7 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_7 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_7

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_7 and arg_411_1.time_ < var_414_0 + var_414_7 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1106803102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1106803102
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1106803103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0
			local var_418_1 = 0.425

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_2 = arg_415_1:FormatText(StoryNameCfg[7].name)

				arg_415_1.leftNameTxt_.text = var_418_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_3 = arg_415_1:GetWordFromCfg(1106803102)
				local var_418_4 = arg_415_1:FormatText(var_418_3.content)

				arg_415_1.text_.text = var_418_4

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 17
				local var_418_6 = utf8.len(var_418_4)
				local var_418_7 = var_418_5 <= 0 and var_418_1 or var_418_1 * (var_418_6 / var_418_5)

				if var_418_7 > 0 and var_418_1 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_4
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_8 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_8 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_8

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_8 and arg_415_1.time_ < var_418_0 + var_418_8 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1106803103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1106803103
		arg_419_1.duration_ = 2.7

		local var_419_0 = {
			ja = 2.7,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_419_0:Play1106803104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_2")
			end

			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_422_2 = arg_419_1.actors_["1068ui_story"]
			local var_422_3 = 0

			if var_422_3 < arg_419_1.time_ and arg_419_1.time_ <= var_422_3 + arg_422_0 and not isNil(var_422_2) and arg_419_1.var_.characterEffect1068ui_story == nil then
				arg_419_1.var_.characterEffect1068ui_story = var_422_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_4 = 0.2

			if var_422_3 <= arg_419_1.time_ and arg_419_1.time_ < var_422_3 + var_422_4 and not isNil(var_422_2) then
				local var_422_5 = (arg_419_1.time_ - var_422_3) / var_422_4

				if arg_419_1.var_.characterEffect1068ui_story and not isNil(var_422_2) then
					arg_419_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_3 + var_422_4 and arg_419_1.time_ < var_422_3 + var_422_4 + arg_422_0 and not isNil(var_422_2) and arg_419_1.var_.characterEffect1068ui_story then
				arg_419_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_422_6 = 0
			local var_422_7 = 0.2

			if var_422_6 < arg_419_1.time_ and arg_419_1.time_ <= var_422_6 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_8 = arg_419_1:FormatText(StoryNameCfg[218].name)

				arg_419_1.leftNameTxt_.text = var_422_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_9 = arg_419_1:GetWordFromCfg(1106803103)
				local var_422_10 = arg_419_1:FormatText(var_422_9.content)

				arg_419_1.text_.text = var_422_10

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_11 = 8
				local var_422_12 = utf8.len(var_422_10)
				local var_422_13 = var_422_11 <= 0 and var_422_7 or var_422_7 * (var_422_12 / var_422_11)

				if var_422_13 > 0 and var_422_7 < var_422_13 then
					arg_419_1.talkMaxDuration = var_422_13

					if var_422_13 + var_422_6 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_13 + var_422_6
					end
				end

				arg_419_1.text_.text = var_422_10
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803103", "story_v_side_new_1106803.awb") ~= 0 then
					local var_422_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803103", "story_v_side_new_1106803.awb") / 1000

					if var_422_14 + var_422_6 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_14 + var_422_6
					end

					if var_422_9.prefab_name ~= "" and arg_419_1.actors_[var_422_9.prefab_name] ~= nil then
						local var_422_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_9.prefab_name].transform, "story_v_side_new_1106803", "1106803103", "story_v_side_new_1106803.awb")

						arg_419_1:RecordAudio("1106803103", var_422_15)
						arg_419_1:RecordAudio("1106803103", var_422_15)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803103", "story_v_side_new_1106803.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803103", "story_v_side_new_1106803.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_16 = math.max(var_422_7, arg_419_1.talkMaxDuration)

			if var_422_6 <= arg_419_1.time_ and arg_419_1.time_ < var_422_6 + var_422_16 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_6) / var_422_16

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_6 + var_422_16 and arg_419_1.time_ < var_422_6 + var_422_16 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play1106803104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1106803104
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1106803105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1068ui_story"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1068ui_story == nil then
				arg_423_1.var_.characterEffect1068ui_story = var_426_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.2

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.characterEffect1068ui_story and not isNil(var_426_0) then
					local var_426_4 = Mathf.Lerp(0, 0.5, var_426_3)

					arg_423_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1068ui_story.fillRatio = var_426_4
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1068ui_story then
				local var_426_5 = 0.5

				arg_423_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1068ui_story.fillRatio = var_426_5
			end

			local var_426_6 = 0
			local var_426_7 = 0.575

			if var_426_6 < arg_423_1.time_ and arg_423_1.time_ <= var_426_6 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_8 = arg_423_1:FormatText(StoryNameCfg[7].name)

				arg_423_1.leftNameTxt_.text = var_426_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_9 = arg_423_1:GetWordFromCfg(1106803104)
				local var_426_10 = arg_423_1:FormatText(var_426_9.content)

				arg_423_1.text_.text = var_426_10

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_11 = 23
				local var_426_12 = utf8.len(var_426_10)
				local var_426_13 = var_426_11 <= 0 and var_426_7 or var_426_7 * (var_426_12 / var_426_11)

				if var_426_13 > 0 and var_426_7 < var_426_13 then
					arg_423_1.talkMaxDuration = var_426_13

					if var_426_13 + var_426_6 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_13 + var_426_6
					end
				end

				arg_423_1.text_.text = var_426_10
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_14 = math.max(var_426_7, arg_423_1.talkMaxDuration)

			if var_426_6 <= arg_423_1.time_ and arg_423_1.time_ < var_426_6 + var_426_14 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_6) / var_426_14

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_6 + var_426_14 and arg_423_1.time_ < var_426_6 + var_426_14 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1106803105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1106803105
		arg_427_1.duration_ = 4.1

		local var_427_0 = {
			ja = 4.1,
			ko = 2.333333333332,
			zh = 2.333333333332
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
				arg_427_0:Play1106803106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_430_1 = arg_427_1.actors_["1068ui_story"]
			local var_430_2 = 0

			if var_430_2 < arg_427_1.time_ and arg_427_1.time_ <= var_430_2 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1068ui_story == nil then
				arg_427_1.var_.characterEffect1068ui_story = var_430_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_3 = 0.2

			if var_430_2 <= arg_427_1.time_ and arg_427_1.time_ < var_430_2 + var_430_3 and not isNil(var_430_1) then
				local var_430_4 = (arg_427_1.time_ - var_430_2) / var_430_3

				if arg_427_1.var_.characterEffect1068ui_story and not isNil(var_430_1) then
					arg_427_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_2 + var_430_3 and arg_427_1.time_ < var_430_2 + var_430_3 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1068ui_story then
				arg_427_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_430_5 = 0
			local var_430_6 = 0.225

			if var_430_5 < arg_427_1.time_ and arg_427_1.time_ <= var_430_5 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_7 = arg_427_1:FormatText(StoryNameCfg[218].name)

				arg_427_1.leftNameTxt_.text = var_430_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_8 = arg_427_1:GetWordFromCfg(1106803105)
				local var_430_9 = arg_427_1:FormatText(var_430_8.content)

				arg_427_1.text_.text = var_430_9

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_10 = 9
				local var_430_11 = utf8.len(var_430_9)
				local var_430_12 = var_430_10 <= 0 and var_430_6 or var_430_6 * (var_430_11 / var_430_10)

				if var_430_12 > 0 and var_430_6 < var_430_12 then
					arg_427_1.talkMaxDuration = var_430_12

					if var_430_12 + var_430_5 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_12 + var_430_5
					end
				end

				arg_427_1.text_.text = var_430_9
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803105", "story_v_side_new_1106803.awb") ~= 0 then
					local var_430_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803105", "story_v_side_new_1106803.awb") / 1000

					if var_430_13 + var_430_5 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_13 + var_430_5
					end

					if var_430_8.prefab_name ~= "" and arg_427_1.actors_[var_430_8.prefab_name] ~= nil then
						local var_430_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_8.prefab_name].transform, "story_v_side_new_1106803", "1106803105", "story_v_side_new_1106803.awb")

						arg_427_1:RecordAudio("1106803105", var_430_14)
						arg_427_1:RecordAudio("1106803105", var_430_14)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803105", "story_v_side_new_1106803.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803105", "story_v_side_new_1106803.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_15 = math.max(var_430_6, arg_427_1.talkMaxDuration)

			if var_430_5 <= arg_427_1.time_ and arg_427_1.time_ < var_430_5 + var_430_15 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_5) / var_430_15

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_5 + var_430_15 and arg_427_1.time_ < var_430_5 + var_430_15 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1106803106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1106803106
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1106803107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1068ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1068ui_story == nil then
				arg_431_1.var_.characterEffect1068ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.2

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1068ui_story and not isNil(var_434_0) then
					local var_434_4 = Mathf.Lerp(0, 0.5, var_434_3)

					arg_431_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1068ui_story.fillRatio = var_434_4
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1068ui_story then
				local var_434_5 = 0.5

				arg_431_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1068ui_story.fillRatio = var_434_5
			end

			local var_434_6 = 0
			local var_434_7 = 0.425

			if var_434_6 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_8 = arg_431_1:FormatText(StoryNameCfg[7].name)

				arg_431_1.leftNameTxt_.text = var_434_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_9 = arg_431_1:GetWordFromCfg(1106803106)
				local var_434_10 = arg_431_1:FormatText(var_434_9.content)

				arg_431_1.text_.text = var_434_10

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 17
				local var_434_12 = utf8.len(var_434_10)
				local var_434_13 = var_434_11 <= 0 and var_434_7 or var_434_7 * (var_434_12 / var_434_11)

				if var_434_13 > 0 and var_434_7 < var_434_13 then
					arg_431_1.talkMaxDuration = var_434_13

					if var_434_13 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_13 + var_434_6
					end
				end

				arg_431_1.text_.text = var_434_10
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_14 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_14 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_14

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_14 and arg_431_1.time_ < var_434_6 + var_434_14 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1106803107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1106803107
		arg_435_1.duration_ = 9.63

		local var_435_0 = {
			ja = 9.633,
			ko = 5.1,
			zh = 5.1
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
				arg_435_0:Play1106803108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action4_1")
			end

			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_438_2 = arg_435_1.actors_["1068ui_story"]
			local var_438_3 = 0

			if var_438_3 < arg_435_1.time_ and arg_435_1.time_ <= var_438_3 + arg_438_0 and not isNil(var_438_2) and arg_435_1.var_.characterEffect1068ui_story == nil then
				arg_435_1.var_.characterEffect1068ui_story = var_438_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_4 = 0.2

			if var_438_3 <= arg_435_1.time_ and arg_435_1.time_ < var_438_3 + var_438_4 and not isNil(var_438_2) then
				local var_438_5 = (arg_435_1.time_ - var_438_3) / var_438_4

				if arg_435_1.var_.characterEffect1068ui_story and not isNil(var_438_2) then
					arg_435_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= var_438_3 + var_438_4 and arg_435_1.time_ < var_438_3 + var_438_4 + arg_438_0 and not isNil(var_438_2) and arg_435_1.var_.characterEffect1068ui_story then
				arg_435_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_438_6 = 0
			local var_438_7 = 0.725

			if var_438_6 < arg_435_1.time_ and arg_435_1.time_ <= var_438_6 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_8 = arg_435_1:FormatText(StoryNameCfg[218].name)

				arg_435_1.leftNameTxt_.text = var_438_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_9 = arg_435_1:GetWordFromCfg(1106803107)
				local var_438_10 = arg_435_1:FormatText(var_438_9.content)

				arg_435_1.text_.text = var_438_10

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_11 = 29
				local var_438_12 = utf8.len(var_438_10)
				local var_438_13 = var_438_11 <= 0 and var_438_7 or var_438_7 * (var_438_12 / var_438_11)

				if var_438_13 > 0 and var_438_7 < var_438_13 then
					arg_435_1.talkMaxDuration = var_438_13

					if var_438_13 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_13 + var_438_6
					end
				end

				arg_435_1.text_.text = var_438_10
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803107", "story_v_side_new_1106803.awb") ~= 0 then
					local var_438_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803107", "story_v_side_new_1106803.awb") / 1000

					if var_438_14 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_14 + var_438_6
					end

					if var_438_9.prefab_name ~= "" and arg_435_1.actors_[var_438_9.prefab_name] ~= nil then
						local var_438_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_9.prefab_name].transform, "story_v_side_new_1106803", "1106803107", "story_v_side_new_1106803.awb")

						arg_435_1:RecordAudio("1106803107", var_438_15)
						arg_435_1:RecordAudio("1106803107", var_438_15)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803107", "story_v_side_new_1106803.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803107", "story_v_side_new_1106803.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_16 = math.max(var_438_7, arg_435_1.talkMaxDuration)

			if var_438_6 <= arg_435_1.time_ and arg_435_1.time_ < var_438_6 + var_438_16 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_6) / var_438_16

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_6 + var_438_16 and arg_435_1.time_ < var_438_6 + var_438_16 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1106803108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1106803108
		arg_439_1.duration_ = 7.63

		local var_439_0 = {
			ja = 7.366,
			ko = 7.633,
			zh = 7.633
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
				arg_439_0:Play1106803109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.825

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[218].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_3 = arg_439_1:GetWordFromCfg(1106803108)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803108", "story_v_side_new_1106803.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803108", "story_v_side_new_1106803.awb") / 1000

					if var_442_8 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_0
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_side_new_1106803", "1106803108", "story_v_side_new_1106803.awb")

						arg_439_1:RecordAudio("1106803108", var_442_9)
						arg_439_1:RecordAudio("1106803108", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803108", "story_v_side_new_1106803.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803108", "story_v_side_new_1106803.awb")
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
	Play1106803109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1106803109
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1106803110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["1068ui_story"]
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.characterEffect1068ui_story == nil then
				arg_443_1.var_.characterEffect1068ui_story = var_446_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.2

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 and not isNil(var_446_0) then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2

				if arg_443_1.var_.characterEffect1068ui_story and not isNil(var_446_0) then
					local var_446_4 = Mathf.Lerp(0, 0.5, var_446_3)

					arg_443_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1068ui_story.fillRatio = var_446_4
				end
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.characterEffect1068ui_story then
				local var_446_5 = 0.5

				arg_443_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1068ui_story.fillRatio = var_446_5
			end

			local var_446_6 = 0
			local var_446_7 = 1.025

			if var_446_6 < arg_443_1.time_ and arg_443_1.time_ <= var_446_6 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_8 = arg_443_1:FormatText(StoryNameCfg[7].name)

				arg_443_1.leftNameTxt_.text = var_446_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_9 = arg_443_1:GetWordFromCfg(1106803109)
				local var_446_10 = arg_443_1:FormatText(var_446_9.content)

				arg_443_1.text_.text = var_446_10

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_11 = 41
				local var_446_12 = utf8.len(var_446_10)
				local var_446_13 = var_446_11 <= 0 and var_446_7 or var_446_7 * (var_446_12 / var_446_11)

				if var_446_13 > 0 and var_446_7 < var_446_13 then
					arg_443_1.talkMaxDuration = var_446_13

					if var_446_13 + var_446_6 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_13 + var_446_6
					end
				end

				arg_443_1.text_.text = var_446_10
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_14 = math.max(var_446_7, arg_443_1.talkMaxDuration)

			if var_446_6 <= arg_443_1.time_ and arg_443_1.time_ < var_446_6 + var_446_14 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_6) / var_446_14

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_6 + var_446_14 and arg_443_1.time_ < var_446_6 + var_446_14 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1106803110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1106803110
		arg_447_1.duration_ = 5.8

		local var_447_0 = {
			ja = 5.8,
			ko = 3.8,
			zh = 3.8
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1106803111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068actionlink/1068action442")
			end

			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_450_2 = arg_447_1.actors_["1068ui_story"]
			local var_450_3 = 0

			if var_450_3 < arg_447_1.time_ and arg_447_1.time_ <= var_450_3 + arg_450_0 and not isNil(var_450_2) and arg_447_1.var_.characterEffect1068ui_story == nil then
				arg_447_1.var_.characterEffect1068ui_story = var_450_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_4 = 0.2

			if var_450_3 <= arg_447_1.time_ and arg_447_1.time_ < var_450_3 + var_450_4 and not isNil(var_450_2) then
				local var_450_5 = (arg_447_1.time_ - var_450_3) / var_450_4

				if arg_447_1.var_.characterEffect1068ui_story and not isNil(var_450_2) then
					arg_447_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= var_450_3 + var_450_4 and arg_447_1.time_ < var_450_3 + var_450_4 + arg_450_0 and not isNil(var_450_2) and arg_447_1.var_.characterEffect1068ui_story then
				arg_447_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_450_6 = 0
			local var_450_7 = 0.325

			if var_450_6 < arg_447_1.time_ and arg_447_1.time_ <= var_450_6 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_8 = arg_447_1:FormatText(StoryNameCfg[218].name)

				arg_447_1.leftNameTxt_.text = var_450_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_9 = arg_447_1:GetWordFromCfg(1106803110)
				local var_450_10 = arg_447_1:FormatText(var_450_9.content)

				arg_447_1.text_.text = var_450_10

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_11 = 13
				local var_450_12 = utf8.len(var_450_10)
				local var_450_13 = var_450_11 <= 0 and var_450_7 or var_450_7 * (var_450_12 / var_450_11)

				if var_450_13 > 0 and var_450_7 < var_450_13 then
					arg_447_1.talkMaxDuration = var_450_13

					if var_450_13 + var_450_6 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_13 + var_450_6
					end
				end

				arg_447_1.text_.text = var_450_10
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803110", "story_v_side_new_1106803.awb") ~= 0 then
					local var_450_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803110", "story_v_side_new_1106803.awb") / 1000

					if var_450_14 + var_450_6 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_14 + var_450_6
					end

					if var_450_9.prefab_name ~= "" and arg_447_1.actors_[var_450_9.prefab_name] ~= nil then
						local var_450_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_9.prefab_name].transform, "story_v_side_new_1106803", "1106803110", "story_v_side_new_1106803.awb")

						arg_447_1:RecordAudio("1106803110", var_450_15)
						arg_447_1:RecordAudio("1106803110", var_450_15)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803110", "story_v_side_new_1106803.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803110", "story_v_side_new_1106803.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_16 = math.max(var_450_7, arg_447_1.talkMaxDuration)

			if var_450_6 <= arg_447_1.time_ and arg_447_1.time_ < var_450_6 + var_450_16 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_6) / var_450_16

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_6 + var_450_16 and arg_447_1.time_ < var_450_6 + var_450_16 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1106803111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1106803111
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1106803112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1068ui_story"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1068ui_story == nil then
				arg_451_1.var_.characterEffect1068ui_story = var_454_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.2

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 and not isNil(var_454_0) then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.characterEffect1068ui_story and not isNil(var_454_0) then
					local var_454_4 = Mathf.Lerp(0, 0.5, var_454_3)

					arg_451_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1068ui_story.fillRatio = var_454_4
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1068ui_story then
				local var_454_5 = 0.5

				arg_451_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1068ui_story.fillRatio = var_454_5
			end

			local var_454_6 = 0
			local var_454_7 = 1.25

			if var_454_6 < arg_451_1.time_ and arg_451_1.time_ <= var_454_6 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_8 = arg_451_1:FormatText(StoryNameCfg[7].name)

				arg_451_1.leftNameTxt_.text = var_454_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_9 = arg_451_1:GetWordFromCfg(1106803111)
				local var_454_10 = arg_451_1:FormatText(var_454_9.content)

				arg_451_1.text_.text = var_454_10

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_11 = 50
				local var_454_12 = utf8.len(var_454_10)
				local var_454_13 = var_454_11 <= 0 and var_454_7 or var_454_7 * (var_454_12 / var_454_11)

				if var_454_13 > 0 and var_454_7 < var_454_13 then
					arg_451_1.talkMaxDuration = var_454_13

					if var_454_13 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_13 + var_454_6
					end
				end

				arg_451_1.text_.text = var_454_10
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_14 = math.max(var_454_7, arg_451_1.talkMaxDuration)

			if var_454_6 <= arg_451_1.time_ and arg_451_1.time_ < var_454_6 + var_454_14 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_6) / var_454_14

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_6 + var_454_14 and arg_451_1.time_ < var_454_6 + var_454_14 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1106803112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1106803112
		arg_455_1.duration_ = 8.77

		local var_455_0 = {
			ja = 8.766,
			ko = 8.566,
			zh = 8.566
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1106803113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_2")
			end

			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_458_2 = arg_455_1.actors_["1068ui_story"]
			local var_458_3 = 0

			if var_458_3 < arg_455_1.time_ and arg_455_1.time_ <= var_458_3 + arg_458_0 and not isNil(var_458_2) and arg_455_1.var_.characterEffect1068ui_story == nil then
				arg_455_1.var_.characterEffect1068ui_story = var_458_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_4 = 0.2

			if var_458_3 <= arg_455_1.time_ and arg_455_1.time_ < var_458_3 + var_458_4 and not isNil(var_458_2) then
				local var_458_5 = (arg_455_1.time_ - var_458_3) / var_458_4

				if arg_455_1.var_.characterEffect1068ui_story and not isNil(var_458_2) then
					arg_455_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_455_1.time_ >= var_458_3 + var_458_4 and arg_455_1.time_ < var_458_3 + var_458_4 + arg_458_0 and not isNil(var_458_2) and arg_455_1.var_.characterEffect1068ui_story then
				arg_455_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_458_6 = 0
			local var_458_7 = 0.9

			if var_458_6 < arg_455_1.time_ and arg_455_1.time_ <= var_458_6 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_8 = arg_455_1:FormatText(StoryNameCfg[218].name)

				arg_455_1.leftNameTxt_.text = var_458_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_9 = arg_455_1:GetWordFromCfg(1106803112)
				local var_458_10 = arg_455_1:FormatText(var_458_9.content)

				arg_455_1.text_.text = var_458_10

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_11 = 36
				local var_458_12 = utf8.len(var_458_10)
				local var_458_13 = var_458_11 <= 0 and var_458_7 or var_458_7 * (var_458_12 / var_458_11)

				if var_458_13 > 0 and var_458_7 < var_458_13 then
					arg_455_1.talkMaxDuration = var_458_13

					if var_458_13 + var_458_6 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_13 + var_458_6
					end
				end

				arg_455_1.text_.text = var_458_10
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803112", "story_v_side_new_1106803.awb") ~= 0 then
					local var_458_14 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803112", "story_v_side_new_1106803.awb") / 1000

					if var_458_14 + var_458_6 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_14 + var_458_6
					end

					if var_458_9.prefab_name ~= "" and arg_455_1.actors_[var_458_9.prefab_name] ~= nil then
						local var_458_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_9.prefab_name].transform, "story_v_side_new_1106803", "1106803112", "story_v_side_new_1106803.awb")

						arg_455_1:RecordAudio("1106803112", var_458_15)
						arg_455_1:RecordAudio("1106803112", var_458_15)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803112", "story_v_side_new_1106803.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803112", "story_v_side_new_1106803.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_16 = math.max(var_458_7, arg_455_1.talkMaxDuration)

			if var_458_6 <= arg_455_1.time_ and arg_455_1.time_ < var_458_6 + var_458_16 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_6) / var_458_16

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_6 + var_458_16 and arg_455_1.time_ < var_458_6 + var_458_16 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play1106803113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1106803113
		arg_459_1.duration_ = 6.9

		local var_459_0 = {
			ja = 6.9,
			ko = 5,
			zh = 5
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
				arg_459_0:Play1106803114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 0.675

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_2 = arg_459_1:FormatText(StoryNameCfg[218].name)

				arg_459_1.leftNameTxt_.text = var_462_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_3 = arg_459_1:GetWordFromCfg(1106803113)
				local var_462_4 = arg_459_1:FormatText(var_462_3.content)

				arg_459_1.text_.text = var_462_4

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 27
				local var_462_6 = utf8.len(var_462_4)
				local var_462_7 = var_462_5 <= 0 and var_462_1 or var_462_1 * (var_462_6 / var_462_5)

				if var_462_7 > 0 and var_462_1 < var_462_7 then
					arg_459_1.talkMaxDuration = var_462_7

					if var_462_7 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_7 + var_462_0
					end
				end

				arg_459_1.text_.text = var_462_4
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803113", "story_v_side_new_1106803.awb") ~= 0 then
					local var_462_8 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803113", "story_v_side_new_1106803.awb") / 1000

					if var_462_8 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_8 + var_462_0
					end

					if var_462_3.prefab_name ~= "" and arg_459_1.actors_[var_462_3.prefab_name] ~= nil then
						local var_462_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_3.prefab_name].transform, "story_v_side_new_1106803", "1106803113", "story_v_side_new_1106803.awb")

						arg_459_1:RecordAudio("1106803113", var_462_9)
						arg_459_1:RecordAudio("1106803113", var_462_9)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803113", "story_v_side_new_1106803.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803113", "story_v_side_new_1106803.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_10 = math.max(var_462_1, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_10 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_0) / var_462_10

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_10 and arg_459_1.time_ < var_462_0 + var_462_10 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play1106803114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1106803114
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1106803115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["1068ui_story"]
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect1068ui_story == nil then
				arg_463_1.var_.characterEffect1068ui_story = var_466_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_2 = 0.2

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 and not isNil(var_466_0) then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2

				if arg_463_1.var_.characterEffect1068ui_story and not isNil(var_466_0) then
					local var_466_4 = Mathf.Lerp(0, 0.5, var_466_3)

					arg_463_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_463_1.var_.characterEffect1068ui_story.fillRatio = var_466_4
				end
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect1068ui_story then
				local var_466_5 = 0.5

				arg_463_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_463_1.var_.characterEffect1068ui_story.fillRatio = var_466_5
			end

			local var_466_6 = 0
			local var_466_7 = 0.65

			if var_466_6 < arg_463_1.time_ and arg_463_1.time_ <= var_466_6 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_8 = arg_463_1:FormatText(StoryNameCfg[7].name)

				arg_463_1.leftNameTxt_.text = var_466_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_9 = arg_463_1:GetWordFromCfg(1106803114)
				local var_466_10 = arg_463_1:FormatText(var_466_9.content)

				arg_463_1.text_.text = var_466_10

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_11 = 26
				local var_466_12 = utf8.len(var_466_10)
				local var_466_13 = var_466_11 <= 0 and var_466_7 or var_466_7 * (var_466_12 / var_466_11)

				if var_466_13 > 0 and var_466_7 < var_466_13 then
					arg_463_1.talkMaxDuration = var_466_13

					if var_466_13 + var_466_6 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_13 + var_466_6
					end
				end

				arg_463_1.text_.text = var_466_10
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_14 = math.max(var_466_7, arg_463_1.talkMaxDuration)

			if var_466_6 <= arg_463_1.time_ and arg_463_1.time_ < var_466_6 + var_466_14 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_6) / var_466_14

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_6 + var_466_14 and arg_463_1.time_ < var_466_6 + var_466_14 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1106803115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1106803115
		arg_467_1.duration_ = 4.67

		local var_467_0 = {
			ja = 3.566,
			ko = 4.666,
			zh = 4.666
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
			arg_467_1.auto_ = false
		end

		function arg_467_1.playNext_(arg_469_0)
			arg_467_1.onStoryFinished_()
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_470_1 = arg_467_1.actors_["1068ui_story"]
			local var_470_2 = 0

			if var_470_2 < arg_467_1.time_ and arg_467_1.time_ <= var_470_2 + arg_470_0 and not isNil(var_470_1) and arg_467_1.var_.characterEffect1068ui_story == nil then
				arg_467_1.var_.characterEffect1068ui_story = var_470_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_3 = 0.2

			if var_470_2 <= arg_467_1.time_ and arg_467_1.time_ < var_470_2 + var_470_3 and not isNil(var_470_1) then
				local var_470_4 = (arg_467_1.time_ - var_470_2) / var_470_3

				if arg_467_1.var_.characterEffect1068ui_story and not isNil(var_470_1) then
					arg_467_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= var_470_2 + var_470_3 and arg_467_1.time_ < var_470_2 + var_470_3 + arg_470_0 and not isNil(var_470_1) and arg_467_1.var_.characterEffect1068ui_story then
				arg_467_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_470_5 = 0
			local var_470_6 = 0.6

			if var_470_5 < arg_467_1.time_ and arg_467_1.time_ <= var_470_5 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_7 = arg_467_1:FormatText(StoryNameCfg[218].name)

				arg_467_1.leftNameTxt_.text = var_470_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_8 = arg_467_1:GetWordFromCfg(1106803115)
				local var_470_9 = arg_467_1:FormatText(var_470_8.content)

				arg_467_1.text_.text = var_470_9

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_10 = 24
				local var_470_11 = utf8.len(var_470_9)
				local var_470_12 = var_470_10 <= 0 and var_470_6 or var_470_6 * (var_470_11 / var_470_10)

				if var_470_12 > 0 and var_470_6 < var_470_12 then
					arg_467_1.talkMaxDuration = var_470_12

					if var_470_12 + var_470_5 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_12 + var_470_5
					end
				end

				arg_467_1.text_.text = var_470_9
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803115", "story_v_side_new_1106803.awb") ~= 0 then
					local var_470_13 = manager.audio:GetVoiceLength("story_v_side_new_1106803", "1106803115", "story_v_side_new_1106803.awb") / 1000

					if var_470_13 + var_470_5 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_13 + var_470_5
					end

					if var_470_8.prefab_name ~= "" and arg_467_1.actors_[var_470_8.prefab_name] ~= nil then
						local var_470_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_8.prefab_name].transform, "story_v_side_new_1106803", "1106803115", "story_v_side_new_1106803.awb")

						arg_467_1:RecordAudio("1106803115", var_470_14)
						arg_467_1:RecordAudio("1106803115", var_470_14)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_side_new_1106803", "1106803115", "story_v_side_new_1106803.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_side_new_1106803", "1106803115", "story_v_side_new_1106803.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_15 = math.max(var_470_6, arg_467_1.talkMaxDuration)

			if var_470_5 <= arg_467_1.time_ and arg_467_1.time_ < var_470_5 + var_470_15 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_5) / var_470_15

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_5 + var_470_15 and arg_467_1.time_ < var_470_5 + var_470_15 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F03_2",
		"TextureConfig/Background/ST27",
		"TextureConfig/Background/ST22"
	},
	voices = {
		"story_v_side_new_1106803.awb"
	}
}
