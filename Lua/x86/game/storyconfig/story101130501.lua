return {
	Play113051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play113051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST22"

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
				local var_4_5 = arg_1_1.bgs_.ST22

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
					if iter_4_0 ~= "ST22" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

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

			local var_4_28 = 2
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

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
			local var_4_35 = 0.65

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

				local var_4_37 = arg_1_1:GetWordFromCfg(113051001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 26
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
	Play113051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113051002
		arg_9_1.duration_ = 5.07

		local var_9_0 = {
			ja = 5.066,
			ko = 2.9,
			zh = 3.6,
			en = 4.433
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
				arg_9_0:Play113051003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1042ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1042ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1042ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(-0.7, -1.06, -6.2)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1042ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = 0

			if var_12_14 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_12_16 = arg_9_1.actors_["1042ui_story"]
			local var_12_17 = 0

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1042ui_story == nil then
				arg_9_1.var_.characterEffect1042ui_story = var_12_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_18 = 0.2

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_18 and not isNil(var_12_16) then
				local var_12_19 = (arg_9_1.time_ - var_12_17) / var_12_18

				if arg_9_1.var_.characterEffect1042ui_story and not isNil(var_12_16) then
					arg_9_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_17 + var_12_18 and arg_9_1.time_ < var_12_17 + var_12_18 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1042ui_story then
				arg_9_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_12_20 = 0
			local var_12_21 = 0.25

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[205].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(113051002)
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

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051002", "story_v_out_113051.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_113051", "113051002", "story_v_out_113051.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_113051", "113051002", "story_v_out_113051.awb")

						arg_9_1:RecordAudio("113051002", var_12_29)
						arg_9_1:RecordAudio("113051002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113051", "113051002", "story_v_out_113051.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113051", "113051002", "story_v_out_113051.awb")
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
				actorName = "1042ui_story",
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
	Play113051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113051003
		arg_13_1.duration_ = 7.23

		local var_13_0 = {
			ja = 7.233,
			ko = 4.8,
			zh = 5.3,
			en = 5.666
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play113051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1041ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = arg_13_1.actors_["1041ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1041ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0.7, -1.11, -5.9)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1041ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_16_16 = arg_13_1.actors_["1042ui_story"]
			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect1042ui_story == nil then
				arg_13_1.var_.characterEffect1042ui_story = var_16_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_18 = 0.2

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_18 and not isNil(var_16_16) then
				local var_16_19 = (arg_13_1.time_ - var_16_17) / var_16_18

				if arg_13_1.var_.characterEffect1042ui_story and not isNil(var_16_16) then
					local var_16_20 = Mathf.Lerp(0, 0.5, var_16_19)

					arg_13_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1042ui_story.fillRatio = var_16_20
				end
			end

			if arg_13_1.time_ >= var_16_17 + var_16_18 and arg_13_1.time_ < var_16_17 + var_16_18 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect1042ui_story then
				local var_16_21 = 0.5

				arg_13_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1042ui_story.fillRatio = var_16_21
			end

			local var_16_22 = arg_13_1.actors_["1041ui_story"]
			local var_16_23 = 0

			if var_16_23 < arg_13_1.time_ and arg_13_1.time_ <= var_16_23 + arg_16_0 and not isNil(var_16_22) and arg_13_1.var_.characterEffect1041ui_story == nil then
				arg_13_1.var_.characterEffect1041ui_story = var_16_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_24 = 0.2

			if var_16_23 <= arg_13_1.time_ and arg_13_1.time_ < var_16_23 + var_16_24 and not isNil(var_16_22) then
				local var_16_25 = (arg_13_1.time_ - var_16_23) / var_16_24

				if arg_13_1.var_.characterEffect1041ui_story and not isNil(var_16_22) then
					arg_13_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_23 + var_16_24 and arg_13_1.time_ < var_16_23 + var_16_24 + arg_16_0 and not isNil(var_16_22) and arg_13_1.var_.characterEffect1041ui_story then
				arg_13_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_16_26 = 0
			local var_16_27 = 0.7

			if var_16_26 < arg_13_1.time_ and arg_13_1.time_ <= var_16_26 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_28 = arg_13_1:FormatText(StoryNameCfg[208].name)

				arg_13_1.leftNameTxt_.text = var_16_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_29 = arg_13_1:GetWordFromCfg(113051003)
				local var_16_30 = arg_13_1:FormatText(var_16_29.content)

				arg_13_1.text_.text = var_16_30

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_31 = 27
				local var_16_32 = utf8.len(var_16_30)
				local var_16_33 = var_16_31 <= 0 and var_16_27 or var_16_27 * (var_16_32 / var_16_31)

				if var_16_33 > 0 and var_16_27 < var_16_33 then
					arg_13_1.talkMaxDuration = var_16_33

					if var_16_33 + var_16_26 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_33 + var_16_26
					end
				end

				arg_13_1.text_.text = var_16_30
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051003", "story_v_out_113051.awb") ~= 0 then
					local var_16_34 = manager.audio:GetVoiceLength("story_v_out_113051", "113051003", "story_v_out_113051.awb") / 1000

					if var_16_34 + var_16_26 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_34 + var_16_26
					end

					if var_16_29.prefab_name ~= "" and arg_13_1.actors_[var_16_29.prefab_name] ~= nil then
						local var_16_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_29.prefab_name].transform, "story_v_out_113051", "113051003", "story_v_out_113051.awb")

						arg_13_1:RecordAudio("113051003", var_16_35)
						arg_13_1:RecordAudio("113051003", var_16_35)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113051", "113051003", "story_v_out_113051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113051", "113051003", "story_v_out_113051.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_36 = math.max(var_16_27, arg_13_1.talkMaxDuration)

			if var_16_26 <= arg_13_1.time_ and arg_13_1.time_ < var_16_26 + var_16_36 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_26) / var_16_36

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_26 + var_16_36 and arg_13_1.time_ < var_16_26 + var_16_36 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play113051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113051004
		arg_17_1.duration_ = 8.07

		local var_17_0 = {
			ja = 8.066,
			ko = 7.9,
			zh = 8.033,
			en = 8.066
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
				arg_17_0:Play113051005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1041ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1041ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1041ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1042ui_story"].transform
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.var_.moveOldPos1042ui_story = var_20_9.localPosition
			end

			local var_20_11 = 0.001

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11
				local var_20_13 = Vector3.New(0, 100, 0)

				var_20_9.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1042ui_story, var_20_13, var_20_12)

				local var_20_14 = manager.ui.mainCamera.transform.position - var_20_9.position

				var_20_9.forward = Vector3.New(var_20_14.x, var_20_14.y, var_20_14.z)

				local var_20_15 = var_20_9.localEulerAngles

				var_20_15.z = 0
				var_20_15.x = 0
				var_20_9.localEulerAngles = var_20_15
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 then
				var_20_9.localPosition = Vector3.New(0, 100, 0)

				local var_20_16 = manager.ui.mainCamera.transform.position - var_20_9.position

				var_20_9.forward = Vector3.New(var_20_16.x, var_20_16.y, var_20_16.z)

				local var_20_17 = var_20_9.localEulerAngles

				var_20_17.z = 0
				var_20_17.x = 0
				var_20_9.localEulerAngles = var_20_17
			end

			local var_20_18 = "1084ui_story"

			if arg_17_1.actors_[var_20_18] == nil then
				local var_20_19 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_20_19) then
					local var_20_20 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_17_1.stage_.transform)

					var_20_20.name = var_20_18
					var_20_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_18] = var_20_20

					local var_20_21 = var_20_20:GetComponentInChildren(typeof(CharacterEffect))

					var_20_21.enabled = true

					local var_20_22 = GameObjectTools.GetOrAddComponent(var_20_20, typeof(DynamicBoneHelper))

					if var_20_22 then
						var_20_22:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_21.transform, false)

					arg_17_1.var_[var_20_18 .. "Animator"] = var_20_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_18 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_18 .. "LipSync"] = var_20_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_23 = arg_17_1.actors_["1084ui_story"].transform
			local var_20_24 = 0

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 then
				arg_17_1.var_.moveOldPos1084ui_story = var_20_23.localPosition
			end

			local var_20_25 = 0.001

			if var_20_24 <= arg_17_1.time_ and arg_17_1.time_ < var_20_24 + var_20_25 then
				local var_20_26 = (arg_17_1.time_ - var_20_24) / var_20_25
				local var_20_27 = Vector3.New(-0.7, -0.97, -6)

				var_20_23.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1084ui_story, var_20_27, var_20_26)

				local var_20_28 = manager.ui.mainCamera.transform.position - var_20_23.position

				var_20_23.forward = Vector3.New(var_20_28.x, var_20_28.y, var_20_28.z)

				local var_20_29 = var_20_23.localEulerAngles

				var_20_29.z = 0
				var_20_29.x = 0
				var_20_23.localEulerAngles = var_20_29
			end

			if arg_17_1.time_ >= var_20_24 + var_20_25 and arg_17_1.time_ < var_20_24 + var_20_25 + arg_20_0 then
				var_20_23.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_20_30 = manager.ui.mainCamera.transform.position - var_20_23.position

				var_20_23.forward = Vector3.New(var_20_30.x, var_20_30.y, var_20_30.z)

				local var_20_31 = var_20_23.localEulerAngles

				var_20_31.z = 0
				var_20_31.x = 0
				var_20_23.localEulerAngles = var_20_31
			end

			local var_20_32 = 0

			if var_20_32 < arg_17_1.time_ and arg_17_1.time_ <= var_20_32 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_20_33 = 0

			if var_20_33 < arg_17_1.time_ and arg_17_1.time_ <= var_20_33 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_20_34 = arg_17_1.actors_["1084ui_story"]
			local var_20_35 = 0

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 and not isNil(var_20_34) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_36 = 0.2

			if var_20_35 <= arg_17_1.time_ and arg_17_1.time_ < var_20_35 + var_20_36 and not isNil(var_20_34) then
				local var_20_37 = (arg_17_1.time_ - var_20_35) / var_20_36

				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_34) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_35 + var_20_36 and arg_17_1.time_ < var_20_35 + var_20_36 + arg_20_0 and not isNil(var_20_34) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_20_38 = 0
			local var_20_39 = 0.675

			if var_20_38 < arg_17_1.time_ and arg_17_1.time_ <= var_20_38 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_40 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_41 = arg_17_1:GetWordFromCfg(113051004)
				local var_20_42 = arg_17_1:FormatText(var_20_41.content)

				arg_17_1.text_.text = var_20_42

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_43 = 27
				local var_20_44 = utf8.len(var_20_42)
				local var_20_45 = var_20_43 <= 0 and var_20_39 or var_20_39 * (var_20_44 / var_20_43)

				if var_20_45 > 0 and var_20_39 < var_20_45 then
					arg_17_1.talkMaxDuration = var_20_45

					if var_20_45 + var_20_38 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_45 + var_20_38
					end
				end

				arg_17_1.text_.text = var_20_42
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051004", "story_v_out_113051.awb") ~= 0 then
					local var_20_46 = manager.audio:GetVoiceLength("story_v_out_113051", "113051004", "story_v_out_113051.awb") / 1000

					if var_20_46 + var_20_38 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_46 + var_20_38
					end

					if var_20_41.prefab_name ~= "" and arg_17_1.actors_[var_20_41.prefab_name] ~= nil then
						local var_20_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_41.prefab_name].transform, "story_v_out_113051", "113051004", "story_v_out_113051.awb")

						arg_17_1:RecordAudio("113051004", var_20_47)
						arg_17_1:RecordAudio("113051004", var_20_47)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113051", "113051004", "story_v_out_113051.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113051", "113051004", "story_v_out_113051.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_48 = math.max(var_20_39, arg_17_1.talkMaxDuration)

			if var_20_38 <= arg_17_1.time_ and arg_17_1.time_ < var_20_38 + var_20_48 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_38) / var_20_48

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_38 + var_20_48 and arg_17_1.time_ < var_20_38 + var_20_48 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play113051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113051005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play113051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1084ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1084ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1084ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.825

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

				local var_24_9 = arg_21_1:GetWordFromCfg(113051005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 33
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
	Play113051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113051006
		arg_25_1.duration_ = 3.27

		local var_25_0 = {
			ja = 3.266,
			ko = 2.5,
			zh = 2.2,
			en = 1.999999999999
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
				arg_25_0:Play113051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "1038ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["1038ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos1038ui_story = var_28_5.localPosition
			end

			local var_28_7 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7
				local var_28_9 = Vector3.New(0.7, -1.11, -5.9)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1038ui_story, var_28_9, var_28_8)

				local var_28_10 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_10.x, var_28_10.y, var_28_10.z)

				local var_28_11 = var_28_5.localEulerAngles

				var_28_11.z = 0
				var_28_11.x = 0
				var_28_5.localEulerAngles = var_28_11
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_28_12 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_12.x, var_28_12.y, var_28_12.z)

				local var_28_13 = var_28_5.localEulerAngles

				var_28_13.z = 0
				var_28_13.x = 0
				var_28_5.localEulerAngles = var_28_13
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_28_16 = arg_25_1.actors_["1038ui_story"]
			local var_28_17 = 0

			if var_28_17 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 and not isNil(var_28_16) and arg_25_1.var_.characterEffect1038ui_story == nil then
				arg_25_1.var_.characterEffect1038ui_story = var_28_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_18 = 0.2

			if var_28_17 <= arg_25_1.time_ and arg_25_1.time_ < var_28_17 + var_28_18 and not isNil(var_28_16) then
				local var_28_19 = (arg_25_1.time_ - var_28_17) / var_28_18

				if arg_25_1.var_.characterEffect1038ui_story and not isNil(var_28_16) then
					arg_25_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_17 + var_28_18 and arg_25_1.time_ < var_28_17 + var_28_18 + arg_28_0 and not isNil(var_28_16) and arg_25_1.var_.characterEffect1038ui_story then
				arg_25_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_28_20 = 0
			local var_28_21 = 0.2

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_22 = arg_25_1:FormatText(StoryNameCfg[94].name)

				arg_25_1.leftNameTxt_.text = var_28_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_23 = arg_25_1:GetWordFromCfg(113051006)
				local var_28_24 = arg_25_1:FormatText(var_28_23.content)

				arg_25_1.text_.text = var_28_24

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_25 = 8
				local var_28_26 = utf8.len(var_28_24)
				local var_28_27 = var_28_25 <= 0 and var_28_21 or var_28_21 * (var_28_26 / var_28_25)

				if var_28_27 > 0 and var_28_21 < var_28_27 then
					arg_25_1.talkMaxDuration = var_28_27

					if var_28_27 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_20
					end
				end

				arg_25_1.text_.text = var_28_24
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051006", "story_v_out_113051.awb") ~= 0 then
					local var_28_28 = manager.audio:GetVoiceLength("story_v_out_113051", "113051006", "story_v_out_113051.awb") / 1000

					if var_28_28 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_20
					end

					if var_28_23.prefab_name ~= "" and arg_25_1.actors_[var_28_23.prefab_name] ~= nil then
						local var_28_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_23.prefab_name].transform, "story_v_out_113051", "113051006", "story_v_out_113051.awb")

						arg_25_1:RecordAudio("113051006", var_28_29)
						arg_25_1:RecordAudio("113051006", var_28_29)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_113051", "113051006", "story_v_out_113051.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_113051", "113051006", "story_v_out_113051.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_30 = math.max(var_28_21, arg_25_1.talkMaxDuration)

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_30 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_20) / var_28_30

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_20 + var_28_30 and arg_25_1.time_ < var_28_20 + var_28_30 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play113051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113051007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play113051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1084ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1084ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, 100, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1084ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, 100, 0)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1038ui_story"].transform
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.var_.moveOldPos1038ui_story = var_32_9.localPosition
			end

			local var_32_11 = 0.001

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11
				local var_32_13 = Vector3.New(0, 100, 0)

				var_32_9.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1038ui_story, var_32_13, var_32_12)

				local var_32_14 = manager.ui.mainCamera.transform.position - var_32_9.position

				var_32_9.forward = Vector3.New(var_32_14.x, var_32_14.y, var_32_14.z)

				local var_32_15 = var_32_9.localEulerAngles

				var_32_15.z = 0
				var_32_15.x = 0
				var_32_9.localEulerAngles = var_32_15
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 then
				var_32_9.localPosition = Vector3.New(0, 100, 0)

				local var_32_16 = manager.ui.mainCamera.transform.position - var_32_9.position

				var_32_9.forward = Vector3.New(var_32_16.x, var_32_16.y, var_32_16.z)

				local var_32_17 = var_32_9.localEulerAngles

				var_32_17.z = 0
				var_32_17.x = 0
				var_32_9.localEulerAngles = var_32_17
			end

			local var_32_18 = 0
			local var_32_19 = 0.575

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_20 = arg_29_1:GetWordFromCfg(113051007)
				local var_32_21 = arg_29_1:FormatText(var_32_20.content)

				arg_29_1.text_.text = var_32_21

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_22 = 23
				local var_32_23 = utf8.len(var_32_21)
				local var_32_24 = var_32_22 <= 0 and var_32_19 or var_32_19 * (var_32_23 / var_32_22)

				if var_32_24 > 0 and var_32_19 < var_32_24 then
					arg_29_1.talkMaxDuration = var_32_24

					if var_32_24 + var_32_18 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_18
					end
				end

				arg_29_1.text_.text = var_32_21
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_25 = math.max(var_32_19, arg_29_1.talkMaxDuration)

			if var_32_18 <= arg_29_1.time_ and arg_29_1.time_ < var_32_18 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_18) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_18 + var_32_25 and arg_29_1.time_ < var_32_18 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play113051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113051008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play113051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action2_1")
			end

			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_36_2 = arg_33_1.actors_["1041ui_story"]
			local var_36_3 = 0

			if var_36_3 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1041ui_story == nil then
				arg_33_1.var_.characterEffect1041ui_story = var_36_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.2

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_4 and not isNil(var_36_2) then
				local var_36_5 = (arg_33_1.time_ - var_36_3) / var_36_4

				if arg_33_1.var_.characterEffect1041ui_story and not isNil(var_36_2) then
					arg_33_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_3 + var_36_4 and arg_33_1.time_ < var_36_3 + var_36_4 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1041ui_story then
				arg_33_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_36_6 = arg_33_1.actors_["1041ui_story"].transform
			local var_36_7 = 0

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.var_.moveOldPos1041ui_story = var_36_6.localPosition
			end

			local var_36_8 = 0.001

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_8 then
				local var_36_9 = (arg_33_1.time_ - var_36_7) / var_36_8
				local var_36_10 = Vector3.New(-0.7, -1.11, -5.9)

				var_36_6.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1041ui_story, var_36_10, var_36_9)

				local var_36_11 = manager.ui.mainCamera.transform.position - var_36_6.position

				var_36_6.forward = Vector3.New(var_36_11.x, var_36_11.y, var_36_11.z)

				local var_36_12 = var_36_6.localEulerAngles

				var_36_12.z = 0
				var_36_12.x = 0
				var_36_6.localEulerAngles = var_36_12
			end

			if arg_33_1.time_ >= var_36_7 + var_36_8 and arg_33_1.time_ < var_36_7 + var_36_8 + arg_36_0 then
				var_36_6.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_36_13 = manager.ui.mainCamera.transform.position - var_36_6.position

				var_36_6.forward = Vector3.New(var_36_13.x, var_36_13.y, var_36_13.z)

				local var_36_14 = var_36_6.localEulerAngles

				var_36_14.z = 0
				var_36_14.x = 0
				var_36_6.localEulerAngles = var_36_14
			end

			local var_36_15 = 0
			local var_36_16 = 0.125

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[208].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(113051008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 5
				local var_36_21 = utf8.len(var_36_19)
				local var_36_22 = var_36_20 <= 0 and var_36_16 or var_36_16 * (var_36_21 / var_36_20)

				if var_36_22 > 0 and var_36_16 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22

					if var_36_22 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051008", "story_v_out_113051.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_113051", "113051008", "story_v_out_113051.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_113051", "113051008", "story_v_out_113051.awb")

						arg_33_1:RecordAudio("113051008", var_36_24)
						arg_33_1:RecordAudio("113051008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_113051", "113051008", "story_v_out_113051.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_113051", "113051008", "story_v_out_113051.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_25 and arg_33_1.time_ < var_36_15 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play113051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 113051009
		arg_37_1.duration_ = 4.17

		local var_37_0 = {
			ja = 4.166,
			ko = 2.666,
			zh = 2.2,
			en = 2.633
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
				arg_37_0:Play113051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1038ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1038ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0.7, -1.11, -5.9)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1038ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_40_11 = arg_37_1.actors_["1038ui_story"]
			local var_40_12 = 0

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.characterEffect1038ui_story == nil then
				arg_37_1.var_.characterEffect1038ui_story = var_40_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_13 = 0.2

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_13 and not isNil(var_40_11) then
				local var_40_14 = (arg_37_1.time_ - var_40_12) / var_40_13

				if arg_37_1.var_.characterEffect1038ui_story and not isNil(var_40_11) then
					arg_37_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_12 + var_40_13 and arg_37_1.time_ < var_40_12 + var_40_13 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.characterEffect1038ui_story then
				arg_37_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_40_15 = arg_37_1.actors_["1041ui_story"]
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.characterEffect1041ui_story == nil then
				arg_37_1.var_.characterEffect1041ui_story = var_40_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_17 = 0.2

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 and not isNil(var_40_15) then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17

				if arg_37_1.var_.characterEffect1041ui_story and not isNil(var_40_15) then
					local var_40_19 = Mathf.Lerp(0, 0.5, var_40_18)

					arg_37_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1041ui_story.fillRatio = var_40_19
				end
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.characterEffect1041ui_story then
				local var_40_20 = 0.5

				arg_37_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1041ui_story.fillRatio = var_40_20
			end

			local var_40_21 = 0
			local var_40_22 = 0.175

			if var_40_21 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_23 = arg_37_1:FormatText(StoryNameCfg[94].name)

				arg_37_1.leftNameTxt_.text = var_40_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_24 = arg_37_1:GetWordFromCfg(113051009)
				local var_40_25 = arg_37_1:FormatText(var_40_24.content)

				arg_37_1.text_.text = var_40_25

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_26 = 7
				local var_40_27 = utf8.len(var_40_25)
				local var_40_28 = var_40_26 <= 0 and var_40_22 or var_40_22 * (var_40_27 / var_40_26)

				if var_40_28 > 0 and var_40_22 < var_40_28 then
					arg_37_1.talkMaxDuration = var_40_28

					if var_40_28 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_28 + var_40_21
					end
				end

				arg_37_1.text_.text = var_40_25
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051009", "story_v_out_113051.awb") ~= 0 then
					local var_40_29 = manager.audio:GetVoiceLength("story_v_out_113051", "113051009", "story_v_out_113051.awb") / 1000

					if var_40_29 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_29 + var_40_21
					end

					if var_40_24.prefab_name ~= "" and arg_37_1.actors_[var_40_24.prefab_name] ~= nil then
						local var_40_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_24.prefab_name].transform, "story_v_out_113051", "113051009", "story_v_out_113051.awb")

						arg_37_1:RecordAudio("113051009", var_40_30)
						arg_37_1:RecordAudio("113051009", var_40_30)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_113051", "113051009", "story_v_out_113051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_113051", "113051009", "story_v_out_113051.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_31 = math.max(var_40_22, arg_37_1.talkMaxDuration)

			if var_40_21 <= arg_37_1.time_ and arg_37_1.time_ < var_40_21 + var_40_31 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_21) / var_40_31

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_21 + var_40_31 and arg_37_1.time_ < var_40_21 + var_40_31 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play113051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 113051010
		arg_41_1.duration_ = 10.2

		local var_41_0 = {
			ja = 10.2,
			ko = 5.866,
			zh = 4.833,
			en = 5.033
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
				arg_41_0:Play113051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_44_2 = 0

			if var_44_2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_44_3 = 0
			local var_44_4 = 0.625

			if var_44_3 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_5 = arg_41_1:FormatText(StoryNameCfg[94].name)

				arg_41_1.leftNameTxt_.text = var_44_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(113051010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_8 = 25
				local var_44_9 = utf8.len(var_44_7)
				local var_44_10 = var_44_8 <= 0 and var_44_4 or var_44_4 * (var_44_9 / var_44_8)

				if var_44_10 > 0 and var_44_4 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_3
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051010", "story_v_out_113051.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_113051", "113051010", "story_v_out_113051.awb") / 1000

					if var_44_11 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_3
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_113051", "113051010", "story_v_out_113051.awb")

						arg_41_1:RecordAudio("113051010", var_44_12)
						arg_41_1:RecordAudio("113051010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_113051", "113051010", "story_v_out_113051.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_113051", "113051010", "story_v_out_113051.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_4, arg_41_1.talkMaxDuration)

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_3) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_3 + var_44_13 and arg_41_1.time_ < var_44_3 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play113051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 113051011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play113051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1038ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1038ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1038ui_story, var_48_4, var_48_3)

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

			local var_48_9 = arg_45_1.actors_["1041ui_story"].transform
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.var_.moveOldPos1041ui_story = var_48_9.localPosition
			end

			local var_48_11 = 0.001

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11
				local var_48_13 = Vector3.New(0, 100, 0)

				var_48_9.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1041ui_story, var_48_13, var_48_12)

				local var_48_14 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_14.x, var_48_14.y, var_48_14.z)

				local var_48_15 = var_48_9.localEulerAngles

				var_48_15.z = 0
				var_48_15.x = 0
				var_48_9.localEulerAngles = var_48_15
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 then
				var_48_9.localPosition = Vector3.New(0, 100, 0)

				local var_48_16 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_16.x, var_48_16.y, var_48_16.z)

				local var_48_17 = var_48_9.localEulerAngles

				var_48_17.z = 0
				var_48_17.x = 0
				var_48_9.localEulerAngles = var_48_17
			end

			local var_48_18 = 0
			local var_48_19 = 0.45

			if var_48_18 < arg_45_1.time_ and arg_45_1.time_ <= var_48_18 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_20 = arg_45_1:GetWordFromCfg(113051011)
				local var_48_21 = arg_45_1:FormatText(var_48_20.content)

				arg_45_1.text_.text = var_48_21

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_22 = 18
				local var_48_23 = utf8.len(var_48_21)
				local var_48_24 = var_48_22 <= 0 and var_48_19 or var_48_19 * (var_48_23 / var_48_22)

				if var_48_24 > 0 and var_48_19 < var_48_24 then
					arg_45_1.talkMaxDuration = var_48_24

					if var_48_24 + var_48_18 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_24 + var_48_18
					end
				end

				arg_45_1.text_.text = var_48_21
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_19, arg_45_1.talkMaxDuration)

			if var_48_18 <= arg_45_1.time_ and arg_45_1.time_ < var_48_18 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_18) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_18 + var_48_25 and arg_45_1.time_ < var_48_18 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play113051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 113051012
		arg_49_1.duration_ = 11.07

		local var_49_0 = {
			ja = 11.066,
			ko = 9.2,
			zh = 7.1,
			en = 8.3
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
				arg_49_0:Play113051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1042ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1042ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, -1.06, -6.2)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1042ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_52_11 = arg_49_1.actors_["1042ui_story"]
			local var_52_12 = 0

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 and not isNil(var_52_11) and arg_49_1.var_.characterEffect1042ui_story == nil then
				arg_49_1.var_.characterEffect1042ui_story = var_52_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_13 = 0.2

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_13 and not isNil(var_52_11) then
				local var_52_14 = (arg_49_1.time_ - var_52_12) / var_52_13

				if arg_49_1.var_.characterEffect1042ui_story and not isNil(var_52_11) then
					arg_49_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_12 + var_52_13 and arg_49_1.time_ < var_52_12 + var_52_13 + arg_52_0 and not isNil(var_52_11) and arg_49_1.var_.characterEffect1042ui_story then
				arg_49_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_52_15 = 0
			local var_52_16 = 0.9

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[205].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(113051012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 36
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051012", "story_v_out_113051.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_113051", "113051012", "story_v_out_113051.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_113051", "113051012", "story_v_out_113051.awb")

						arg_49_1:RecordAudio("113051012", var_52_24)
						arg_49_1:RecordAudio("113051012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_113051", "113051012", "story_v_out_113051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_113051", "113051012", "story_v_out_113051.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_25 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_25

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_25 and arg_49_1.time_ < var_52_15 + var_52_25 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play113051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 113051013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play113051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1042ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1042ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1042ui_story, var_56_4, var_56_3)

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

			local var_56_9 = 0
			local var_56_10 = 0.975

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_11 = arg_53_1:GetWordFromCfg(113051013)
				local var_56_12 = arg_53_1:FormatText(var_56_11.content)

				arg_53_1.text_.text = var_56_12

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 39
				local var_56_14 = utf8.len(var_56_12)
				local var_56_15 = var_56_13 <= 0 and var_56_10 or var_56_10 * (var_56_14 / var_56_13)

				if var_56_15 > 0 and var_56_10 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_9 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_9
					end
				end

				arg_53_1.text_.text = var_56_12
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_10, arg_53_1.talkMaxDuration)

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_9) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_9 + var_56_16 and arg_53_1.time_ < var_56_9 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play113051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 113051014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play113051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.225

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

				local var_60_2 = arg_57_1:GetWordFromCfg(113051014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 49
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
	Play113051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 113051015
		arg_61_1.duration_ = 4.93

		local var_61_0 = {
			ja = 4.933,
			ko = 4.033,
			zh = 3.7,
			en = 3.966
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
				arg_61_0:Play113051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1084ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1084ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(-0.7, -0.97, -6)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1084ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_64_11 = arg_61_1.actors_["1084ui_story"]
			local var_64_12 = 0

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.characterEffect1084ui_story == nil then
				arg_61_1.var_.characterEffect1084ui_story = var_64_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_13 = 0.2

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_13 and not isNil(var_64_11) then
				local var_64_14 = (arg_61_1.time_ - var_64_12) / var_64_13

				if arg_61_1.var_.characterEffect1084ui_story and not isNil(var_64_11) then
					arg_61_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_12 + var_64_13 and arg_61_1.time_ < var_64_12 + var_64_13 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.characterEffect1084ui_story then
				arg_61_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_64_15 = 0
			local var_64_16 = 0.325

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[6].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(113051015)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 13
				local var_64_21 = utf8.len(var_64_19)
				local var_64_22 = var_64_20 <= 0 and var_64_16 or var_64_16 * (var_64_21 / var_64_20)

				if var_64_22 > 0 and var_64_16 < var_64_22 then
					arg_61_1.talkMaxDuration = var_64_22

					if var_64_22 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_15
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051015", "story_v_out_113051.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_out_113051", "113051015", "story_v_out_113051.awb") / 1000

					if var_64_23 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_15
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_out_113051", "113051015", "story_v_out_113051.awb")

						arg_61_1:RecordAudio("113051015", var_64_24)
						arg_61_1:RecordAudio("113051015", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_113051", "113051015", "story_v_out_113051.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_113051", "113051015", "story_v_out_113051.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_16, arg_61_1.talkMaxDuration)

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_25 and arg_61_1.time_ < var_64_15 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play113051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 113051016
		arg_65_1.duration_ = 8.9

		local var_65_0 = {
			ja = 8.9,
			ko = 6.433,
			zh = 4.533,
			en = 6.433
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
				arg_65_0:Play113051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1084ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1084ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1084ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1084ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 0.4

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[216].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(113051016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 16
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051016", "story_v_out_113051.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_113051", "113051016", "story_v_out_113051.awb") / 1000

					if var_68_14 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_6
					end

					if var_68_9.prefab_name ~= "" and arg_65_1.actors_[var_68_9.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_9.prefab_name].transform, "story_v_out_113051", "113051016", "story_v_out_113051.awb")

						arg_65_1:RecordAudio("113051016", var_68_15)
						arg_65_1:RecordAudio("113051016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_113051", "113051016", "story_v_out_113051.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_113051", "113051016", "story_v_out_113051.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_16 and arg_65_1.time_ < var_68_6 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play113051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 113051017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play113051018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.475

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(113051017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 19
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play113051018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 113051018
		arg_73_1.duration_ = 7.9

		local var_73_0 = {
			ja = 7.9,
			ko = 7,
			zh = 6.766,
			en = 7.3
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play113051019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1042ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1042ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0.7, -1.06, -6.2)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1042ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_76_11 = arg_73_1.actors_["1042ui_story"]
			local var_76_12 = 0

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 and not isNil(var_76_11) and arg_73_1.var_.characterEffect1042ui_story == nil then
				arg_73_1.var_.characterEffect1042ui_story = var_76_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_13 = 0.2

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_13 and not isNil(var_76_11) then
				local var_76_14 = (arg_73_1.time_ - var_76_12) / var_76_13

				if arg_73_1.var_.characterEffect1042ui_story and not isNil(var_76_11) then
					arg_73_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_12 + var_76_13 and arg_73_1.time_ < var_76_12 + var_76_13 + arg_76_0 and not isNil(var_76_11) and arg_73_1.var_.characterEffect1042ui_story then
				arg_73_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_76_15 = 0
			local var_76_16 = 0.6

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[205].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(113051018)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 24
				local var_76_21 = utf8.len(var_76_19)
				local var_76_22 = var_76_20 <= 0 and var_76_16 or var_76_16 * (var_76_21 / var_76_20)

				if var_76_22 > 0 and var_76_16 < var_76_22 then
					arg_73_1.talkMaxDuration = var_76_22

					if var_76_22 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051018", "story_v_out_113051.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_113051", "113051018", "story_v_out_113051.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_113051", "113051018", "story_v_out_113051.awb")

						arg_73_1:RecordAudio("113051018", var_76_24)
						arg_73_1:RecordAudio("113051018", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_113051", "113051018", "story_v_out_113051.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_113051", "113051018", "story_v_out_113051.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_25 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_25 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_25

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_25 and arg_73_1.time_ < var_76_15 + var_76_25 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play113051019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 113051019
		arg_77_1.duration_ = 3.33

		local var_77_0 = {
			ja = 1.999999999999,
			ko = 3.3,
			zh = 3.333,
			en = 2.666
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
				arg_77_0:Play113051020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1042ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1042ui_story == nil then
				arg_77_1.var_.characterEffect1042ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1042ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1042ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1042ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1042ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4136")
			end

			local var_80_7 = 0

			if var_80_7 < arg_77_1.time_ and arg_77_1.time_ <= var_80_7 + arg_80_0 then
				arg_77_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_80_8 = arg_77_1.actors_["1084ui_story"]
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.characterEffect1084ui_story == nil then
				arg_77_1.var_.characterEffect1084ui_story = var_80_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_10 = 0.2

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 and not isNil(var_80_8) then
				local var_80_11 = (arg_77_1.time_ - var_80_9) / var_80_10

				if arg_77_1.var_.characterEffect1084ui_story and not isNil(var_80_8) then
					arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.characterEffect1084ui_story then
				arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_80_12 = 0
			local var_80_13 = 0.15

			if var_80_12 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_14 = arg_77_1:FormatText(StoryNameCfg[6].name)

				arg_77_1.leftNameTxt_.text = var_80_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_15 = arg_77_1:GetWordFromCfg(113051019)
				local var_80_16 = arg_77_1:FormatText(var_80_15.content)

				arg_77_1.text_.text = var_80_16

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_17 = 6
				local var_80_18 = utf8.len(var_80_16)
				local var_80_19 = var_80_17 <= 0 and var_80_13 or var_80_13 * (var_80_18 / var_80_17)

				if var_80_19 > 0 and var_80_13 < var_80_19 then
					arg_77_1.talkMaxDuration = var_80_19

					if var_80_19 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_19 + var_80_12
					end
				end

				arg_77_1.text_.text = var_80_16
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051019", "story_v_out_113051.awb") ~= 0 then
					local var_80_20 = manager.audio:GetVoiceLength("story_v_out_113051", "113051019", "story_v_out_113051.awb") / 1000

					if var_80_20 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_20 + var_80_12
					end

					if var_80_15.prefab_name ~= "" and arg_77_1.actors_[var_80_15.prefab_name] ~= nil then
						local var_80_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_15.prefab_name].transform, "story_v_out_113051", "113051019", "story_v_out_113051.awb")

						arg_77_1:RecordAudio("113051019", var_80_21)
						arg_77_1:RecordAudio("113051019", var_80_21)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_113051", "113051019", "story_v_out_113051.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_113051", "113051019", "story_v_out_113051.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_22 = math.max(var_80_13, arg_77_1.talkMaxDuration)

			if var_80_12 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_22 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_12) / var_80_22

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_12 + var_80_22 and arg_77_1.time_ < var_80_12 + var_80_22 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play113051020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 113051020
		arg_81_1.duration_ = 3.3

		local var_81_0 = {
			ja = 3.066,
			ko = 3.133,
			zh = 2.666,
			en = 3.3
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
				arg_81_0:Play113051021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1084ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1084ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1084ui_story.fillRatio = var_84_5
			end

			local var_84_6 = arg_81_1.actors_["1042ui_story"]
			local var_84_7 = 0

			if var_84_7 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1042ui_story == nil then
				arg_81_1.var_.characterEffect1042ui_story = var_84_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_8 = 0.2

			if var_84_7 <= arg_81_1.time_ and arg_81_1.time_ < var_84_7 + var_84_8 and not isNil(var_84_6) then
				local var_84_9 = (arg_81_1.time_ - var_84_7) / var_84_8

				if arg_81_1.var_.characterEffect1042ui_story and not isNil(var_84_6) then
					arg_81_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_7 + var_84_8 and arg_81_1.time_ < var_84_7 + var_84_8 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1042ui_story then
				arg_81_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_84_11 = 0

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_84_12 = 0

			if var_84_12 < arg_81_1.time_ and arg_81_1.time_ <= var_84_12 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_84_14 = 0
			local var_84_15 = 0.35

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_16 = arg_81_1:FormatText(StoryNameCfg[205].name)

				arg_81_1.leftNameTxt_.text = var_84_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_17 = arg_81_1:GetWordFromCfg(113051020)
				local var_84_18 = arg_81_1:FormatText(var_84_17.content)

				arg_81_1.text_.text = var_84_18

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_19 = 14
				local var_84_20 = utf8.len(var_84_18)
				local var_84_21 = var_84_19 <= 0 and var_84_15 or var_84_15 * (var_84_20 / var_84_19)

				if var_84_21 > 0 and var_84_15 < var_84_21 then
					arg_81_1.talkMaxDuration = var_84_21

					if var_84_21 + var_84_14 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_21 + var_84_14
					end
				end

				arg_81_1.text_.text = var_84_18
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051020", "story_v_out_113051.awb") ~= 0 then
					local var_84_22 = manager.audio:GetVoiceLength("story_v_out_113051", "113051020", "story_v_out_113051.awb") / 1000

					if var_84_22 + var_84_14 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_22 + var_84_14
					end

					if var_84_17.prefab_name ~= "" and arg_81_1.actors_[var_84_17.prefab_name] ~= nil then
						local var_84_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_17.prefab_name].transform, "story_v_out_113051", "113051020", "story_v_out_113051.awb")

						arg_81_1:RecordAudio("113051020", var_84_23)
						arg_81_1:RecordAudio("113051020", var_84_23)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_113051", "113051020", "story_v_out_113051.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_113051", "113051020", "story_v_out_113051.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_24 = math.max(var_84_15, arg_81_1.talkMaxDuration)

			if var_84_14 <= arg_81_1.time_ and arg_81_1.time_ < var_84_14 + var_84_24 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_14) / var_84_24

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_14 + var_84_24 and arg_81_1.time_ < var_84_14 + var_84_24 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play113051021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 113051021
		arg_85_1.duration_ = 9

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play113051022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1084ui_story"].transform
			local var_88_1 = 1.966

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1084ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, 100, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1084ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, 100, 0)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["1042ui_story"].transform
			local var_88_10 = 1.966

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.var_.moveOldPos1042ui_story = var_88_9.localPosition
			end

			local var_88_11 = 0.001

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11
				local var_88_13 = Vector3.New(0, 100, 0)

				var_88_9.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1042ui_story, var_88_13, var_88_12)

				local var_88_14 = manager.ui.mainCamera.transform.position - var_88_9.position

				var_88_9.forward = Vector3.New(var_88_14.x, var_88_14.y, var_88_14.z)

				local var_88_15 = var_88_9.localEulerAngles

				var_88_15.z = 0
				var_88_15.x = 0
				var_88_9.localEulerAngles = var_88_15
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 then
				var_88_9.localPosition = Vector3.New(0, 100, 0)

				local var_88_16 = manager.ui.mainCamera.transform.position - var_88_9.position

				var_88_9.forward = Vector3.New(var_88_16.x, var_88_16.y, var_88_16.z)

				local var_88_17 = var_88_9.localEulerAngles

				var_88_17.z = 0
				var_88_17.x = 0
				var_88_9.localEulerAngles = var_88_17
			end

			local var_88_18 = 0

			if var_88_18 < arg_85_1.time_ and arg_85_1.time_ <= var_88_18 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_19 = 2

			if var_88_18 <= arg_85_1.time_ and arg_85_1.time_ < var_88_18 + var_88_19 then
				local var_88_20 = (arg_85_1.time_ - var_88_18) / var_88_19
				local var_88_21 = Color.New(0, 0, 0)

				var_88_21.a = Mathf.Lerp(0, 1, var_88_20)
				arg_85_1.mask_.color = var_88_21
			end

			if arg_85_1.time_ >= var_88_18 + var_88_19 and arg_85_1.time_ < var_88_18 + var_88_19 + arg_88_0 then
				local var_88_22 = Color.New(0, 0, 0)

				var_88_22.a = 1
				arg_85_1.mask_.color = var_88_22
			end

			local var_88_23 = 2

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_24 = 2

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_24 then
				local var_88_25 = (arg_85_1.time_ - var_88_23) / var_88_24
				local var_88_26 = Color.New(0, 0, 0)

				var_88_26.a = Mathf.Lerp(1, 0, var_88_25)
				arg_85_1.mask_.color = var_88_26
			end

			if arg_85_1.time_ >= var_88_23 + var_88_24 and arg_85_1.time_ < var_88_23 + var_88_24 + arg_88_0 then
				local var_88_27 = Color.New(0, 0, 0)
				local var_88_28 = 0

				arg_85_1.mask_.enabled = false
				var_88_27.a = var_88_28
				arg_85_1.mask_.color = var_88_27
			end

			local var_88_29 = "F01a"

			if arg_85_1.bgs_[var_88_29] == nil then
				local var_88_30 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_30:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_88_29)
				var_88_30.name = var_88_29
				var_88_30.transform.parent = arg_85_1.stage_.transform
				var_88_30.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_[var_88_29] = var_88_30
			end

			local var_88_31 = 2

			if var_88_31 < arg_85_1.time_ and arg_85_1.time_ <= var_88_31 + arg_88_0 then
				local var_88_32 = manager.ui.mainCamera.transform.localPosition
				local var_88_33 = Vector3.New(0, 0, 10) + Vector3.New(var_88_32.x, var_88_32.y, 0)
				local var_88_34 = arg_85_1.bgs_.F01a

				var_88_34.transform.localPosition = var_88_33
				var_88_34.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_35 = var_88_34:GetComponent("SpriteRenderer")

				if var_88_35 and var_88_35.sprite then
					local var_88_36 = (var_88_34.transform.localPosition - var_88_32).z
					local var_88_37 = manager.ui.mainCameraCom_
					local var_88_38 = 2 * var_88_36 * Mathf.Tan(var_88_37.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_88_39 = var_88_38 * var_88_37.aspect
					local var_88_40 = var_88_35.sprite.bounds.size.x
					local var_88_41 = var_88_35.sprite.bounds.size.y
					local var_88_42 = var_88_39 / var_88_40
					local var_88_43 = var_88_38 / var_88_41
					local var_88_44 = var_88_43 < var_88_42 and var_88_42 or var_88_43

					var_88_34.transform.localScale = Vector3.New(var_88_44, var_88_44, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "F01a" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_45 = 0
			local var_88_46 = 1

			if var_88_45 < arg_85_1.time_ and arg_85_1.time_ <= var_88_45 + arg_88_0 then
				local var_88_47 = "play"
				local var_88_48 = "music"

				arg_85_1:AudioAction(var_88_47, var_88_48, "ui_battle", "ui_battle_stopbgm", "")

				local var_88_49 = ""
				local var_88_50 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_88_50 ~= "" then
					if arg_85_1.bgmTxt_.text ~= var_88_50 and arg_85_1.bgmTxt_.text ~= "" then
						if arg_85_1.bgmTxt2_.text ~= "" then
							arg_85_1.bgmTxt_.text = arg_85_1.bgmTxt2_.text
						end

						arg_85_1.bgmTxt2_.text = var_88_50

						arg_85_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_85_1.bgmTxt_.text = var_88_50
						arg_85_1.bgmTxt2_.text = var_88_50
					end

					if arg_85_1.bgmTimer then
						arg_85_1.bgmTimer:Stop()

						arg_85_1.bgmTimer = nil
					end

					if arg_85_1.settingData.show_music_name == 1 then
						arg_85_1.musicController:SetSelectedState("show")
						arg_85_1.musicAnimator_:Play("open", 0, 0)

						if arg_85_1.settingData.music_time ~= 0 then
							arg_85_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_85_1.settingData.music_time), function()
								if arg_85_1 == nil or isNil(arg_85_1.bgmTxt_) then
									return
								end

								arg_85_1.musicController:SetSelectedState("hide")
								arg_85_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_51 = 4
			local var_88_52 = 0.625

			if var_88_51 < arg_85_1.time_ and arg_85_1.time_ <= var_88_51 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_53 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_53:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_85_1.dialogCg_.alpha = arg_90_0
				end))
				var_88_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_54 = arg_85_1:GetWordFromCfg(113051021)
				local var_88_55 = arg_85_1:FormatText(var_88_54.content)

				arg_85_1.text_.text = var_88_55

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_56 = 25
				local var_88_57 = utf8.len(var_88_55)
				local var_88_58 = var_88_56 <= 0 and var_88_52 or var_88_52 * (var_88_57 / var_88_56)

				if var_88_58 > 0 and var_88_52 < var_88_58 then
					arg_85_1.talkMaxDuration = var_88_58
					var_88_51 = var_88_51 + 0.3

					if var_88_58 + var_88_51 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_58 + var_88_51
					end
				end

				arg_85_1.text_.text = var_88_55
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_59 = var_88_51 + 0.3
			local var_88_60 = math.max(var_88_52, arg_85_1.talkMaxDuration)

			if var_88_59 <= arg_85_1.time_ and arg_85_1.time_ < var_88_59 + var_88_60 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_59) / var_88_60

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_59 + var_88_60 and arg_85_1.time_ < var_88_59 + var_88_60 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play113051022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 113051022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play113051023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1.2

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_2 = arg_92_1:GetWordFromCfg(113051022)
				local var_95_3 = arg_92_1:FormatText(var_95_2.content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 48
				local var_95_5 = utf8.len(var_95_3)
				local var_95_6 = var_95_4 <= 0 and var_95_1 or var_95_1 * (var_95_5 / var_95_4)

				if var_95_6 > 0 and var_95_1 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_7 and arg_92_1.time_ < var_95_0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play113051023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 113051023
		arg_96_1.duration_ = 4.13

		local var_96_0 = {
			ja = 4.133,
			ko = 2.233,
			zh = 2.6,
			en = 2.633
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
				arg_96_0:Play113051024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 1

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				local var_99_2 = "play"
				local var_99_3 = "music"

				arg_96_1:AudioAction(var_99_2, var_99_3, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_99_4 = ""
				local var_99_5 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if var_99_5 ~= "" then
					if arg_96_1.bgmTxt_.text ~= var_99_5 and arg_96_1.bgmTxt_.text ~= "" then
						if arg_96_1.bgmTxt2_.text ~= "" then
							arg_96_1.bgmTxt_.text = arg_96_1.bgmTxt2_.text
						end

						arg_96_1.bgmTxt2_.text = var_99_5

						arg_96_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_96_1.bgmTxt_.text = var_99_5
						arg_96_1.bgmTxt2_.text = var_99_5
					end

					if arg_96_1.bgmTimer then
						arg_96_1.bgmTimer:Stop()

						arg_96_1.bgmTimer = nil
					end

					if arg_96_1.settingData.show_music_name == 1 then
						arg_96_1.musicController:SetSelectedState("show")
						arg_96_1.musicAnimator_:Play("open", 0, 0)

						if arg_96_1.settingData.music_time ~= 0 then
							arg_96_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_96_1.settingData.music_time), function()
								if arg_96_1 == nil or isNil(arg_96_1.bgmTxt_) then
									return
								end

								arg_96_1.musicController:SetSelectedState("hide")
								arg_96_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_99_6 = 0
			local var_99_7 = 0.275

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[213].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_9 = arg_96_1:GetWordFromCfg(113051023)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 11
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051023", "story_v_out_113051.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_out_113051", "113051023", "story_v_out_113051.awb") / 1000

					if var_99_14 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_6
					end

					if var_99_9.prefab_name ~= "" and arg_96_1.actors_[var_99_9.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_9.prefab_name].transform, "story_v_out_113051", "113051023", "story_v_out_113051.awb")

						arg_96_1:RecordAudio("113051023", var_99_15)
						arg_96_1:RecordAudio("113051023", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_113051", "113051023", "story_v_out_113051.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_113051", "113051023", "story_v_out_113051.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_16 and arg_96_1.time_ < var_99_6 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play113051024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 113051024
		arg_101_1.duration_ = 2

		local var_101_0 = {
			ja = 2,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_101_0:Play113051025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_104_2 = arg_101_1.actors_["1041ui_story"]
			local var_104_3 = 0

			if var_104_3 < arg_101_1.time_ and arg_101_1.time_ <= var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1041ui_story == nil then
				arg_101_1.var_.characterEffect1041ui_story = var_104_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_4 = 0.2

			if var_104_3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_3 + var_104_4 and not isNil(var_104_2) then
				local var_104_5 = (arg_101_1.time_ - var_104_3) / var_104_4

				if arg_101_1.var_.characterEffect1041ui_story and not isNil(var_104_2) then
					arg_101_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_3 + var_104_4 and arg_101_1.time_ < var_104_3 + var_104_4 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1041ui_story then
				arg_101_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_104_6 = arg_101_1.actors_["1041ui_story"].transform
			local var_104_7 = 0

			if var_104_7 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 then
				arg_101_1.var_.moveOldPos1041ui_story = var_104_6.localPosition
			end

			local var_104_8 = 0.001

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_8 then
				local var_104_9 = (arg_101_1.time_ - var_104_7) / var_104_8
				local var_104_10 = Vector3.New(0, -1.11, -5.9)

				var_104_6.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1041ui_story, var_104_10, var_104_9)

				local var_104_11 = manager.ui.mainCamera.transform.position - var_104_6.position

				var_104_6.forward = Vector3.New(var_104_11.x, var_104_11.y, var_104_11.z)

				local var_104_12 = var_104_6.localEulerAngles

				var_104_12.z = 0
				var_104_12.x = 0
				var_104_6.localEulerAngles = var_104_12
			end

			if arg_101_1.time_ >= var_104_7 + var_104_8 and arg_101_1.time_ < var_104_7 + var_104_8 + arg_104_0 then
				var_104_6.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_104_13 = manager.ui.mainCamera.transform.position - var_104_6.position

				var_104_6.forward = Vector3.New(var_104_13.x, var_104_13.y, var_104_13.z)

				local var_104_14 = var_104_6.localEulerAngles

				var_104_14.z = 0
				var_104_14.x = 0
				var_104_6.localEulerAngles = var_104_14
			end

			local var_104_15 = 0
			local var_104_16 = 0.2

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[208].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(113051024)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051024", "story_v_out_113051.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_out_113051", "113051024", "story_v_out_113051.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_out_113051", "113051024", "story_v_out_113051.awb")

						arg_101_1:RecordAudio("113051024", var_104_24)
						arg_101_1:RecordAudio("113051024", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_113051", "113051024", "story_v_out_113051.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_113051", "113051024", "story_v_out_113051.awb")
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
				actorName = "1041ui_story",
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
	Play113051025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 113051025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play113051026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1041ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1041ui_story == nil then
				arg_105_1.var_.characterEffect1041ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1041ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1041ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1041ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1041ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.8

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(113051025)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 32
				local var_108_11 = utf8.len(var_108_9)
				local var_108_12 = var_108_10 <= 0 and var_108_7 or var_108_7 * (var_108_11 / var_108_10)

				if var_108_12 > 0 and var_108_7 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_13 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_13

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_13 and arg_105_1.time_ < var_108_6 + var_108_13 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play113051026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 113051026
		arg_109_1.duration_ = 13.73

		local var_109_0 = {
			ja = 13.733,
			ko = 7.9,
			zh = 9.066,
			en = 12.066
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play113051027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_112_1 = arg_109_1.actors_["1041ui_story"]
			local var_112_2 = 0

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1041ui_story == nil then
				arg_109_1.var_.characterEffect1041ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_3 = 0.2

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_3 and not isNil(var_112_1) then
				local var_112_4 = (arg_109_1.time_ - var_112_2) / var_112_3

				if arg_109_1.var_.characterEffect1041ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_2 + var_112_3 and arg_109_1.time_ < var_112_2 + var_112_3 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1041ui_story then
				arg_109_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_112_5 = 0
			local var_112_6 = 1.025

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_7 = arg_109_1:FormatText(StoryNameCfg[208].name)

				arg_109_1.leftNameTxt_.text = var_112_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(113051026)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 41
				local var_112_11 = utf8.len(var_112_9)
				local var_112_12 = var_112_10 <= 0 and var_112_6 or var_112_6 * (var_112_11 / var_112_10)

				if var_112_12 > 0 and var_112_6 < var_112_12 then
					arg_109_1.talkMaxDuration = var_112_12

					if var_112_12 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051026", "story_v_out_113051.awb") ~= 0 then
					local var_112_13 = manager.audio:GetVoiceLength("story_v_out_113051", "113051026", "story_v_out_113051.awb") / 1000

					if var_112_13 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_5
					end

					if var_112_8.prefab_name ~= "" and arg_109_1.actors_[var_112_8.prefab_name] ~= nil then
						local var_112_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_8.prefab_name].transform, "story_v_out_113051", "113051026", "story_v_out_113051.awb")

						arg_109_1:RecordAudio("113051026", var_112_14)
						arg_109_1:RecordAudio("113051026", var_112_14)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_113051", "113051026", "story_v_out_113051.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_113051", "113051026", "story_v_out_113051.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_15 = math.max(var_112_6, arg_109_1.talkMaxDuration)

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_15 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_5) / var_112_15

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_5 + var_112_15 and arg_109_1.time_ < var_112_5 + var_112_15 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play113051027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 113051027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play113051028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1041ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1041ui_story == nil then
				arg_113_1.var_.characterEffect1041ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1041ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1041ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1041ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1041ui_story.fillRatio = var_116_5
			end

			local var_116_6 = 0
			local var_116_7 = 0.675

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(113051027)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 27
				local var_116_11 = utf8.len(var_116_9)
				local var_116_12 = var_116_10 <= 0 and var_116_7 or var_116_7 * (var_116_11 / var_116_10)

				if var_116_12 > 0 and var_116_7 < var_116_12 then
					arg_113_1.talkMaxDuration = var_116_12

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_13 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_13

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_13 and arg_113_1.time_ < var_116_6 + var_116_13 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play113051028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 113051028
		arg_117_1.duration_ = 5.37

		local var_117_0 = {
			ja = 5.133333333332,
			ko = 5.133333333332,
			zh = 5.133333333332,
			en = 5.366
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
				arg_117_0:Play113051029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1041ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1041ui_story = var_120_0.localPosition

				local var_120_2 = "1041ui_story"

				arg_117_1:ShowWeapon(arg_117_1.var_[var_120_2 .. "Animator"].transform, true)
			end

			local var_120_3 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_3 then
				local var_120_4 = (arg_117_1.time_ - var_120_1) / var_120_3
				local var_120_5 = Vector3.New(0, 100, 0)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1041ui_story, var_120_5, var_120_4)

				local var_120_6 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_6.x, var_120_6.y, var_120_6.z)

				local var_120_7 = var_120_0.localEulerAngles

				var_120_7.z = 0
				var_120_7.x = 0
				var_120_0.localEulerAngles = var_120_7
			end

			if arg_117_1.time_ >= var_120_1 + var_120_3 and arg_117_1.time_ < var_120_1 + var_120_3 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, 100, 0)

				local var_120_8 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_8.x, var_120_8.y, var_120_8.z)

				local var_120_9 = var_120_0.localEulerAngles

				var_120_9.z = 0
				var_120_9.x = 0
				var_120_0.localEulerAngles = var_120_9
			end

			local var_120_10 = manager.ui.mainCamera.transform
			local var_120_11 = 4

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				local var_120_12 = arg_117_1.var_.effectF03daoguang1
				local var_120_13
				local var_120_14 = var_120_10

				if not var_120_12 then
					var_120_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_120_14)
					var_120_12.name = "daoguang1"
					arg_117_1.var_.effectF03daoguang1 = var_120_12
				else
					var_120_12.transform:SetParent(var_120_14)
				end

				var_120_12.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_120_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_120_15 = manager.ui.mainCamera.transform
			local var_120_16 = 4.86666666666667

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				local var_120_17 = arg_117_1.var_.effectF03daoguang1

				if var_120_17 then
					Object.Destroy(var_120_17)

					arg_117_1.var_.effectF03daoguang1 = nil
				end
			end

			local var_120_18 = manager.ui.mainCamera.transform
			local var_120_19 = 4

			if var_120_19 < arg_117_1.time_ and arg_117_1.time_ <= var_120_19 + arg_120_0 then
				arg_117_1.var_.shakeOldPosF03 = var_120_18.localPosition
			end

			local var_120_20 = 0.6

			if var_120_19 <= arg_117_1.time_ and arg_117_1.time_ < var_120_19 + var_120_20 then
				local var_120_21 = (arg_117_1.time_ - var_120_19) / 0.066
				local var_120_22, var_120_23 = math.modf(var_120_21)

				var_120_18.localPosition = Vector3.New(var_120_23 * 0.13, var_120_23 * 0.13, var_120_23 * 0.13) + arg_117_1.var_.shakeOldPosF03
			end

			if arg_117_1.time_ >= var_120_19 + var_120_20 and arg_117_1.time_ < var_120_19 + var_120_20 + arg_120_0 then
				var_120_18.localPosition = arg_117_1.var_.shakeOldPosF03
			end

			local var_120_24 = 0

			if var_120_24 < arg_117_1.time_ and arg_117_1.time_ <= var_120_24 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			local var_120_25 = 2.36666666666667

			if arg_117_1.time_ >= var_120_24 + var_120_25 and arg_117_1.time_ < var_120_24 + var_120_25 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_26 = 3.6
			local var_120_27 = 1

			if var_120_26 < arg_117_1.time_ and arg_117_1.time_ <= var_120_26 + arg_120_0 then
				local var_120_28 = "play"
				local var_120_29 = "effect"

				arg_117_1:AudioAction(var_120_28, var_120_29, "se_story_10", "se_story_10_sword02", "")
			end

			local var_120_30 = 0
			local var_120_31 = 0.55

			if var_120_30 < arg_117_1.time_ and arg_117_1.time_ <= var_120_30 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_32 = arg_117_1:FormatText(StoryNameCfg[208].name)

				arg_117_1.leftNameTxt_.text = var_120_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_33 = arg_117_1:GetWordFromCfg(113051028)
				local var_120_34 = arg_117_1:FormatText(var_120_33.content)

				arg_117_1.text_.text = var_120_34

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_35 = 22
				local var_120_36 = utf8.len(var_120_34)
				local var_120_37 = var_120_35 <= 0 and var_120_31 or var_120_31 * (var_120_36 / var_120_35)

				if var_120_37 > 0 and var_120_31 < var_120_37 then
					arg_117_1.talkMaxDuration = var_120_37

					if var_120_37 + var_120_30 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_37 + var_120_30
					end
				end

				arg_117_1.text_.text = var_120_34
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051028", "story_v_out_113051.awb") ~= 0 then
					local var_120_38 = manager.audio:GetVoiceLength("story_v_out_113051", "113051028", "story_v_out_113051.awb") / 1000

					if var_120_38 + var_120_30 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_38 + var_120_30
					end

					if var_120_33.prefab_name ~= "" and arg_117_1.actors_[var_120_33.prefab_name] ~= nil then
						local var_120_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_33.prefab_name].transform, "story_v_out_113051", "113051028", "story_v_out_113051.awb")

						arg_117_1:RecordAudio("113051028", var_120_39)
						arg_117_1:RecordAudio("113051028", var_120_39)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_113051", "113051028", "story_v_out_113051.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_113051", "113051028", "story_v_out_113051.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_40 = math.max(var_120_31, arg_117_1.talkMaxDuration)

			if var_120_30 <= arg_117_1.time_ and arg_117_1.time_ < var_120_30 + var_120_40 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_30) / var_120_40

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_30 + var_120_40 and arg_117_1.time_ < var_120_30 + var_120_40 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play113051029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 113051029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play113051030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1041ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1041ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, 100, 0)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1041ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, 100, 0)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = 0
			local var_124_10 = 0.55

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_11 = arg_121_1:GetWordFromCfg(113051029)
				local var_124_12 = arg_121_1:FormatText(var_124_11.content)

				arg_121_1.text_.text = var_124_12

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 22
				local var_124_14 = utf8.len(var_124_12)
				local var_124_15 = var_124_13 <= 0 and var_124_10 or var_124_10 * (var_124_14 / var_124_13)

				if var_124_15 > 0 and var_124_10 < var_124_15 then
					arg_121_1.talkMaxDuration = var_124_15

					if var_124_15 + var_124_9 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_15 + var_124_9
					end
				end

				arg_121_1.text_.text = var_124_12
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_10, arg_121_1.talkMaxDuration)

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_9) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_9 + var_124_16 and arg_121_1.time_ < var_124_9 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play113051030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 113051030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play113051031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.8

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(113051030)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 32
				local var_128_5 = utf8.len(var_128_3)
				local var_128_6 = var_128_4 <= 0 and var_128_1 or var_128_1 * (var_128_5 / var_128_4)

				if var_128_6 > 0 and var_128_1 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_7 and arg_125_1.time_ < var_128_0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play113051031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 113051031
		arg_129_1.duration_ = 4.4

		local var_129_0 = {
			ja = 3.5,
			ko = 3.766,
			zh = 2.733,
			en = 4.4
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
				arg_129_0:Play113051032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1038ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1038ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(-0.7, -1.11, -5.9)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1038ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_132_11 = arg_129_1.actors_["1038ui_story"]
			local var_132_12 = 0

			if var_132_12 < arg_129_1.time_ and arg_129_1.time_ <= var_132_12 + arg_132_0 and not isNil(var_132_11) and arg_129_1.var_.characterEffect1038ui_story == nil then
				arg_129_1.var_.characterEffect1038ui_story = var_132_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_13 = 0.2

			if var_132_12 <= arg_129_1.time_ and arg_129_1.time_ < var_132_12 + var_132_13 and not isNil(var_132_11) then
				local var_132_14 = (arg_129_1.time_ - var_132_12) / var_132_13

				if arg_129_1.var_.characterEffect1038ui_story and not isNil(var_132_11) then
					arg_129_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_12 + var_132_13 and arg_129_1.time_ < var_132_12 + var_132_13 + arg_132_0 and not isNil(var_132_11) and arg_129_1.var_.characterEffect1038ui_story then
				arg_129_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_132_15 = 0
			local var_132_16 = 0.3

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_17 = arg_129_1:FormatText(StoryNameCfg[94].name)

				arg_129_1.leftNameTxt_.text = var_132_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_18 = arg_129_1:GetWordFromCfg(113051031)
				local var_132_19 = arg_129_1:FormatText(var_132_18.content)

				arg_129_1.text_.text = var_132_19

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_20 = 12
				local var_132_21 = utf8.len(var_132_19)
				local var_132_22 = var_132_20 <= 0 and var_132_16 or var_132_16 * (var_132_21 / var_132_20)

				if var_132_22 > 0 and var_132_16 < var_132_22 then
					arg_129_1.talkMaxDuration = var_132_22

					if var_132_22 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_22 + var_132_15
					end
				end

				arg_129_1.text_.text = var_132_19
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051031", "story_v_out_113051.awb") ~= 0 then
					local var_132_23 = manager.audio:GetVoiceLength("story_v_out_113051", "113051031", "story_v_out_113051.awb") / 1000

					if var_132_23 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_15
					end

					if var_132_18.prefab_name ~= "" and arg_129_1.actors_[var_132_18.prefab_name] ~= nil then
						local var_132_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_18.prefab_name].transform, "story_v_out_113051", "113051031", "story_v_out_113051.awb")

						arg_129_1:RecordAudio("113051031", var_132_24)
						arg_129_1:RecordAudio("113051031", var_132_24)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_113051", "113051031", "story_v_out_113051.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_113051", "113051031", "story_v_out_113051.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_25 = math.max(var_132_16, arg_129_1.talkMaxDuration)

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_25 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_15) / var_132_25

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_15 + var_132_25 and arg_129_1.time_ < var_132_15 + var_132_25 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play113051032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 113051032
		arg_133_1.duration_ = 2

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play113051033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1038ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1038ui_story == nil then
				arg_133_1.var_.characterEffect1038ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1038ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1038ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1038ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1038ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_1")
			end

			local var_136_7 = 0

			if var_136_7 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 then
				arg_133_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_136_8 = arg_133_1.actors_["1041ui_story"]
			local var_136_9 = 0

			if var_136_9 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.characterEffect1041ui_story == nil then
				arg_133_1.var_.characterEffect1041ui_story = var_136_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_10 = 0.2

			if var_136_9 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_10 and not isNil(var_136_8) then
				local var_136_11 = (arg_133_1.time_ - var_136_9) / var_136_10

				if arg_133_1.var_.characterEffect1041ui_story and not isNil(var_136_8) then
					arg_133_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_9 + var_136_10 and arg_133_1.time_ < var_136_9 + var_136_10 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.characterEffect1041ui_story then
				arg_133_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_136_12 = arg_133_1.actors_["1041ui_story"].transform
			local var_136_13 = 0

			if var_136_13 < arg_133_1.time_ and arg_133_1.time_ <= var_136_13 + arg_136_0 then
				arg_133_1.var_.moveOldPos1041ui_story = var_136_12.localPosition
			end

			local var_136_14 = 0.001

			if var_136_13 <= arg_133_1.time_ and arg_133_1.time_ < var_136_13 + var_136_14 then
				local var_136_15 = (arg_133_1.time_ - var_136_13) / var_136_14
				local var_136_16 = Vector3.New(0.7, -1.11, -5.9)

				var_136_12.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1041ui_story, var_136_16, var_136_15)

				local var_136_17 = manager.ui.mainCamera.transform.position - var_136_12.position

				var_136_12.forward = Vector3.New(var_136_17.x, var_136_17.y, var_136_17.z)

				local var_136_18 = var_136_12.localEulerAngles

				var_136_18.z = 0
				var_136_18.x = 0
				var_136_12.localEulerAngles = var_136_18
			end

			if arg_133_1.time_ >= var_136_13 + var_136_14 and arg_133_1.time_ < var_136_13 + var_136_14 + arg_136_0 then
				var_136_12.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_136_19 = manager.ui.mainCamera.transform.position - var_136_12.position

				var_136_12.forward = Vector3.New(var_136_19.x, var_136_19.y, var_136_19.z)

				local var_136_20 = var_136_12.localEulerAngles

				var_136_20.z = 0
				var_136_20.x = 0
				var_136_12.localEulerAngles = var_136_20
			end

			local var_136_21 = 0
			local var_136_22 = 0.1

			if var_136_21 < arg_133_1.time_ and arg_133_1.time_ <= var_136_21 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_23 = arg_133_1:FormatText(StoryNameCfg[208].name)

				arg_133_1.leftNameTxt_.text = var_136_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_24 = arg_133_1:GetWordFromCfg(113051032)
				local var_136_25 = arg_133_1:FormatText(var_136_24.content)

				arg_133_1.text_.text = var_136_25

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_26 = 4
				local var_136_27 = utf8.len(var_136_25)
				local var_136_28 = var_136_26 <= 0 and var_136_22 or var_136_22 * (var_136_27 / var_136_26)

				if var_136_28 > 0 and var_136_22 < var_136_28 then
					arg_133_1.talkMaxDuration = var_136_28

					if var_136_28 + var_136_21 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_28 + var_136_21
					end
				end

				arg_133_1.text_.text = var_136_25
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051032", "story_v_out_113051.awb") ~= 0 then
					local var_136_29 = manager.audio:GetVoiceLength("story_v_out_113051", "113051032", "story_v_out_113051.awb") / 1000

					if var_136_29 + var_136_21 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_29 + var_136_21
					end

					if var_136_24.prefab_name ~= "" and arg_133_1.actors_[var_136_24.prefab_name] ~= nil then
						local var_136_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_24.prefab_name].transform, "story_v_out_113051", "113051032", "story_v_out_113051.awb")

						arg_133_1:RecordAudio("113051032", var_136_30)
						arg_133_1:RecordAudio("113051032", var_136_30)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_113051", "113051032", "story_v_out_113051.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_113051", "113051032", "story_v_out_113051.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_31 = math.max(var_136_22, arg_133_1.talkMaxDuration)

			if var_136_21 <= arg_133_1.time_ and arg_133_1.time_ < var_136_21 + var_136_31 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_21) / var_136_31

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_21 + var_136_31 and arg_133_1.time_ < var_136_21 + var_136_31 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play113051033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 113051033
		arg_137_1.duration_ = 19.5

		local var_137_0 = {
			ja = 19.5,
			ko = 11.7,
			zh = 11.3,
			en = 13.833
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
				arg_137_0:Play113051034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1038ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1038ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1038ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, 100, 0)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["1041ui_story"].transform
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1.var_.moveOldPos1041ui_story = var_140_9.localPosition
			end

			local var_140_11 = 0.001

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11
				local var_140_13 = Vector3.New(0, 100, 0)

				var_140_9.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1041ui_story, var_140_13, var_140_12)

				local var_140_14 = manager.ui.mainCamera.transform.position - var_140_9.position

				var_140_9.forward = Vector3.New(var_140_14.x, var_140_14.y, var_140_14.z)

				local var_140_15 = var_140_9.localEulerAngles

				var_140_15.z = 0
				var_140_15.x = 0
				var_140_9.localEulerAngles = var_140_15
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 then
				var_140_9.localPosition = Vector3.New(0, 100, 0)

				local var_140_16 = manager.ui.mainCamera.transform.position - var_140_9.position

				var_140_9.forward = Vector3.New(var_140_16.x, var_140_16.y, var_140_16.z)

				local var_140_17 = var_140_9.localEulerAngles

				var_140_17.z = 0
				var_140_17.x = 0
				var_140_9.localEulerAngles = var_140_17
			end

			local var_140_18 = arg_137_1.actors_["1042ui_story"].transform
			local var_140_19 = 0

			if var_140_19 < arg_137_1.time_ and arg_137_1.time_ <= var_140_19 + arg_140_0 then
				arg_137_1.var_.moveOldPos1042ui_story = var_140_18.localPosition
			end

			local var_140_20 = 0.001

			if var_140_19 <= arg_137_1.time_ and arg_137_1.time_ < var_140_19 + var_140_20 then
				local var_140_21 = (arg_137_1.time_ - var_140_19) / var_140_20
				local var_140_22 = Vector3.New(0, -1.06, -6.2)

				var_140_18.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1042ui_story, var_140_22, var_140_21)

				local var_140_23 = manager.ui.mainCamera.transform.position - var_140_18.position

				var_140_18.forward = Vector3.New(var_140_23.x, var_140_23.y, var_140_23.z)

				local var_140_24 = var_140_18.localEulerAngles

				var_140_24.z = 0
				var_140_24.x = 0
				var_140_18.localEulerAngles = var_140_24
			end

			if arg_137_1.time_ >= var_140_19 + var_140_20 and arg_137_1.time_ < var_140_19 + var_140_20 + arg_140_0 then
				var_140_18.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_140_25 = manager.ui.mainCamera.transform.position - var_140_18.position

				var_140_18.forward = Vector3.New(var_140_25.x, var_140_25.y, var_140_25.z)

				local var_140_26 = var_140_18.localEulerAngles

				var_140_26.z = 0
				var_140_26.x = 0
				var_140_18.localEulerAngles = var_140_26
			end

			local var_140_27 = 0

			if var_140_27 < arg_137_1.time_ and arg_137_1.time_ <= var_140_27 + arg_140_0 then
				arg_137_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_140_28 = 0

			if var_140_28 < arg_137_1.time_ and arg_137_1.time_ <= var_140_28 + arg_140_0 then
				arg_137_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_140_29 = arg_137_1.actors_["1042ui_story"]
			local var_140_30 = 0

			if var_140_30 < arg_137_1.time_ and arg_137_1.time_ <= var_140_30 + arg_140_0 and not isNil(var_140_29) and arg_137_1.var_.characterEffect1042ui_story == nil then
				arg_137_1.var_.characterEffect1042ui_story = var_140_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_31 = 0.2

			if var_140_30 <= arg_137_1.time_ and arg_137_1.time_ < var_140_30 + var_140_31 and not isNil(var_140_29) then
				local var_140_32 = (arg_137_1.time_ - var_140_30) / var_140_31

				if arg_137_1.var_.characterEffect1042ui_story and not isNil(var_140_29) then
					arg_137_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_30 + var_140_31 and arg_137_1.time_ < var_140_30 + var_140_31 + arg_140_0 and not isNil(var_140_29) and arg_137_1.var_.characterEffect1042ui_story then
				arg_137_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_140_33 = 0
			local var_140_34 = 1.375

			if var_140_33 < arg_137_1.time_ and arg_137_1.time_ <= var_140_33 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_35 = arg_137_1:FormatText(StoryNameCfg[205].name)

				arg_137_1.leftNameTxt_.text = var_140_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_36 = arg_137_1:GetWordFromCfg(113051033)
				local var_140_37 = arg_137_1:FormatText(var_140_36.content)

				arg_137_1.text_.text = var_140_37

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_38 = 54
				local var_140_39 = utf8.len(var_140_37)
				local var_140_40 = var_140_38 <= 0 and var_140_34 or var_140_34 * (var_140_39 / var_140_38)

				if var_140_40 > 0 and var_140_34 < var_140_40 then
					arg_137_1.talkMaxDuration = var_140_40

					if var_140_40 + var_140_33 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_40 + var_140_33
					end
				end

				arg_137_1.text_.text = var_140_37
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051033", "story_v_out_113051.awb") ~= 0 then
					local var_140_41 = manager.audio:GetVoiceLength("story_v_out_113051", "113051033", "story_v_out_113051.awb") / 1000

					if var_140_41 + var_140_33 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_41 + var_140_33
					end

					if var_140_36.prefab_name ~= "" and arg_137_1.actors_[var_140_36.prefab_name] ~= nil then
						local var_140_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_36.prefab_name].transform, "story_v_out_113051", "113051033", "story_v_out_113051.awb")

						arg_137_1:RecordAudio("113051033", var_140_42)
						arg_137_1:RecordAudio("113051033", var_140_42)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113051", "113051033", "story_v_out_113051.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113051", "113051033", "story_v_out_113051.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_43 = math.max(var_140_34, arg_137_1.talkMaxDuration)

			if var_140_33 <= arg_137_1.time_ and arg_137_1.time_ < var_140_33 + var_140_43 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_33) / var_140_43

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_33 + var_140_43 and arg_137_1.time_ < var_140_33 + var_140_43 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play113051034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 113051034
		arg_141_1.duration_ = 6.83

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play113051035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1042ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1042ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, 100, 0)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1042ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, 100, 0)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_10 = 1.5

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_10 then
				local var_144_11 = (arg_141_1.time_ - var_144_9) / var_144_10
				local var_144_12 = Color.New(1, 1, 1)

				var_144_12.a = Mathf.Lerp(1, 0, var_144_11)
				arg_141_1.mask_.color = var_144_12
			end

			if arg_141_1.time_ >= var_144_9 + var_144_10 and arg_141_1.time_ < var_144_9 + var_144_10 + arg_144_0 then
				local var_144_13 = Color.New(1, 1, 1)
				local var_144_14 = 0

				arg_141_1.mask_.enabled = false
				var_144_13.a = var_144_14
				arg_141_1.mask_.color = var_144_13
			end

			local var_144_15 = 1.5

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_16 = 0.333333333333333

			if arg_141_1.time_ >= var_144_15 + var_144_16 and arg_141_1.time_ < var_144_15 + var_144_16 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_17 = 1.83333333333333
			local var_144_18 = 0.875

			if var_144_17 < arg_141_1.time_ and arg_141_1.time_ <= var_144_17 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_19 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_19:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_20 = arg_141_1:GetWordFromCfg(113051034)
				local var_144_21 = arg_141_1:FormatText(var_144_20.content)

				arg_141_1.text_.text = var_144_21

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_22 = 35
				local var_144_23 = utf8.len(var_144_21)
				local var_144_24 = var_144_22 <= 0 and var_144_18 or var_144_18 * (var_144_23 / var_144_22)

				if var_144_24 > 0 and var_144_18 < var_144_24 then
					arg_141_1.talkMaxDuration = var_144_24
					var_144_17 = var_144_17 + 0.3

					if var_144_24 + var_144_17 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_24 + var_144_17
					end
				end

				arg_141_1.text_.text = var_144_21
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = var_144_17 + 0.3
			local var_144_26 = math.max(var_144_18, arg_141_1.talkMaxDuration)

			if var_144_25 <= arg_141_1.time_ and arg_141_1.time_ < var_144_25 + var_144_26 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_25) / var_144_26

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_25 + var_144_26 and arg_141_1.time_ < var_144_25 + var_144_26 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play113051035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 113051035
		arg_147_1.duration_ = 5.8

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play113051036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = manager.ui.mainCamera.transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.shakeOldPos = var_150_0.localPosition
			end

			local var_150_2 = 0.6

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / 0.066
				local var_150_4, var_150_5 = math.modf(var_150_3)

				var_150_0.localPosition = Vector3.New(var_150_5 * 0.13, var_150_5 * 0.13, var_150_5 * 0.13) + arg_147_1.var_.shakeOldPos
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = arg_147_1.var_.shakeOldPos
			end

			local var_150_6 = 0

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			local var_150_7 = 0.8

			if arg_147_1.time_ >= var_150_6 + var_150_7 and arg_147_1.time_ < var_150_6 + var_150_7 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			local var_150_8 = 0
			local var_150_9 = 1

			if var_150_8 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				local var_150_10 = "play"
				local var_150_11 = "effect"

				arg_147_1:AudioAction(var_150_10, var_150_11, "se_story_10", "se_story_10_skill02", "")
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_12 = 0.8
			local var_150_13 = 0.85

			if var_150_12 < arg_147_1.time_ and arg_147_1.time_ <= var_150_12 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_14 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_14:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_15 = arg_147_1:GetWordFromCfg(113051035)
				local var_150_16 = arg_147_1:FormatText(var_150_15.content)

				arg_147_1.text_.text = var_150_16

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_17 = 34
				local var_150_18 = utf8.len(var_150_16)
				local var_150_19 = var_150_17 <= 0 and var_150_13 or var_150_13 * (var_150_18 / var_150_17)

				if var_150_19 > 0 and var_150_13 < var_150_19 then
					arg_147_1.talkMaxDuration = var_150_19
					var_150_12 = var_150_12 + 0.3

					if var_150_19 + var_150_12 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_19 + var_150_12
					end
				end

				arg_147_1.text_.text = var_150_16
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_20 = var_150_12 + 0.3
			local var_150_21 = math.max(var_150_13, arg_147_1.talkMaxDuration)

			if var_150_20 <= arg_147_1.time_ and arg_147_1.time_ < var_150_20 + var_150_21 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_20) / var_150_21

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_20 + var_150_21 and arg_147_1.time_ < var_150_20 + var_150_21 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play113051036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 113051036
		arg_153_1.duration_ = 2

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play113051037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1041ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1041ui_story = var_156_0.localPosition

				local var_156_2 = "1041ui_story"

				arg_153_1:ShowWeapon(arg_153_1.var_[var_156_2 .. "Animator"].transform, true)
			end

			local var_156_3 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_3 then
				local var_156_4 = (arg_153_1.time_ - var_156_1) / var_156_3
				local var_156_5 = Vector3.New(-0.7, -1.11, -5.9)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1041ui_story, var_156_5, var_156_4)

				local var_156_6 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_6.x, var_156_6.y, var_156_6.z)

				local var_156_7 = var_156_0.localEulerAngles

				var_156_7.z = 0
				var_156_7.x = 0
				var_156_0.localEulerAngles = var_156_7
			end

			if arg_153_1.time_ >= var_156_1 + var_156_3 and arg_153_1.time_ < var_156_1 + var_156_3 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_156_8 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_8.x, var_156_8.y, var_156_8.z)

				local var_156_9 = var_156_0.localEulerAngles

				var_156_9.z = 0
				var_156_9.x = 0
				var_156_0.localEulerAngles = var_156_9
			end

			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_156_11 = 0

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_156_12 = arg_153_1.actors_["1041ui_story"]
			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 and not isNil(var_156_12) and arg_153_1.var_.characterEffect1041ui_story == nil then
				arg_153_1.var_.characterEffect1041ui_story = var_156_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_14 = 0.2

			if var_156_13 <= arg_153_1.time_ and arg_153_1.time_ < var_156_13 + var_156_14 and not isNil(var_156_12) then
				local var_156_15 = (arg_153_1.time_ - var_156_13) / var_156_14

				if arg_153_1.var_.characterEffect1041ui_story and not isNil(var_156_12) then
					arg_153_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_13 + var_156_14 and arg_153_1.time_ < var_156_13 + var_156_14 + arg_156_0 and not isNil(var_156_12) and arg_153_1.var_.characterEffect1041ui_story then
				arg_153_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_156_16 = 0
			local var_156_17 = 0.1

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_18 = arg_153_1:FormatText(StoryNameCfg[208].name)

				arg_153_1.leftNameTxt_.text = var_156_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_19 = arg_153_1:GetWordFromCfg(113051036)
				local var_156_20 = arg_153_1:FormatText(var_156_19.content)

				arg_153_1.text_.text = var_156_20

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_21 = 4
				local var_156_22 = utf8.len(var_156_20)
				local var_156_23 = var_156_21 <= 0 and var_156_17 or var_156_17 * (var_156_22 / var_156_21)

				if var_156_23 > 0 and var_156_17 < var_156_23 then
					arg_153_1.talkMaxDuration = var_156_23

					if var_156_23 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_16
					end
				end

				arg_153_1.text_.text = var_156_20
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051036", "story_v_out_113051.awb") ~= 0 then
					local var_156_24 = manager.audio:GetVoiceLength("story_v_out_113051", "113051036", "story_v_out_113051.awb") / 1000

					if var_156_24 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_24 + var_156_16
					end

					if var_156_19.prefab_name ~= "" and arg_153_1.actors_[var_156_19.prefab_name] ~= nil then
						local var_156_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_19.prefab_name].transform, "story_v_out_113051", "113051036", "story_v_out_113051.awb")

						arg_153_1:RecordAudio("113051036", var_156_25)
						arg_153_1:RecordAudio("113051036", var_156_25)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_113051", "113051036", "story_v_out_113051.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_113051", "113051036", "story_v_out_113051.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_26 = math.max(var_156_17, arg_153_1.talkMaxDuration)

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_26 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_16) / var_156_26

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_16 + var_156_26 and arg_153_1.time_ < var_156_16 + var_156_26 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play113051037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 113051037
		arg_157_1.duration_ = 9.5

		local var_157_0 = {
			ja = 8.433,
			ko = 7.866,
			zh = 7,
			en = 9.5
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
			arg_157_1.auto_ = false
		end

		function arg_157_1.playNext_(arg_159_0)
			arg_157_1.onStoryFinished_()
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1041ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1041ui_story == nil then
				arg_157_1.var_.characterEffect1041ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1041ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1041ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1041ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1041ui_story.fillRatio = var_160_5
			end

			local var_160_6 = arg_157_1.actors_["1038ui_story"].transform
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 then
				arg_157_1.var_.moveOldPos1038ui_story = var_160_6.localPosition
			end

			local var_160_8 = 0.001

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8
				local var_160_10 = Vector3.New(0.7, -1.11, -5.9)

				var_160_6.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1038ui_story, var_160_10, var_160_9)

				local var_160_11 = manager.ui.mainCamera.transform.position - var_160_6.position

				var_160_6.forward = Vector3.New(var_160_11.x, var_160_11.y, var_160_11.z)

				local var_160_12 = var_160_6.localEulerAngles

				var_160_12.z = 0
				var_160_12.x = 0
				var_160_6.localEulerAngles = var_160_12
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 then
				var_160_6.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_160_13 = manager.ui.mainCamera.transform.position - var_160_6.position

				var_160_6.forward = Vector3.New(var_160_13.x, var_160_13.y, var_160_13.z)

				local var_160_14 = var_160_6.localEulerAngles

				var_160_14.z = 0
				var_160_14.x = 0
				var_160_6.localEulerAngles = var_160_14
			end

			local var_160_15 = 0

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_160_17 = arg_157_1.actors_["1038ui_story"]
			local var_160_18 = 0

			if var_160_18 < arg_157_1.time_ and arg_157_1.time_ <= var_160_18 + arg_160_0 and not isNil(var_160_17) and arg_157_1.var_.characterEffect1038ui_story == nil then
				arg_157_1.var_.characterEffect1038ui_story = var_160_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_19 = 0.2

			if var_160_18 <= arg_157_1.time_ and arg_157_1.time_ < var_160_18 + var_160_19 and not isNil(var_160_17) then
				local var_160_20 = (arg_157_1.time_ - var_160_18) / var_160_19

				if arg_157_1.var_.characterEffect1038ui_story and not isNil(var_160_17) then
					arg_157_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_18 + var_160_19 and arg_157_1.time_ < var_160_18 + var_160_19 + arg_160_0 and not isNil(var_160_17) and arg_157_1.var_.characterEffect1038ui_story then
				arg_157_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_160_21 = 0
			local var_160_22 = 0.85

			if var_160_21 < arg_157_1.time_ and arg_157_1.time_ <= var_160_21 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_23 = arg_157_1:FormatText(StoryNameCfg[94].name)

				arg_157_1.leftNameTxt_.text = var_160_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_24 = arg_157_1:GetWordFromCfg(113051037)
				local var_160_25 = arg_157_1:FormatText(var_160_24.content)

				arg_157_1.text_.text = var_160_25

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_26 = 34
				local var_160_27 = utf8.len(var_160_25)
				local var_160_28 = var_160_26 <= 0 and var_160_22 or var_160_22 * (var_160_27 / var_160_26)

				if var_160_28 > 0 and var_160_22 < var_160_28 then
					arg_157_1.talkMaxDuration = var_160_28

					if var_160_28 + var_160_21 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_28 + var_160_21
					end
				end

				arg_157_1.text_.text = var_160_25
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113051", "113051037", "story_v_out_113051.awb") ~= 0 then
					local var_160_29 = manager.audio:GetVoiceLength("story_v_out_113051", "113051037", "story_v_out_113051.awb") / 1000

					if var_160_29 + var_160_21 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_29 + var_160_21
					end

					if var_160_24.prefab_name ~= "" and arg_157_1.actors_[var_160_24.prefab_name] ~= nil then
						local var_160_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_24.prefab_name].transform, "story_v_out_113051", "113051037", "story_v_out_113051.awb")

						arg_157_1:RecordAudio("113051037", var_160_30)
						arg_157_1:RecordAudio("113051037", var_160_30)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_113051", "113051037", "story_v_out_113051.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_113051", "113051037", "story_v_out_113051.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_31 = math.max(var_160_22, arg_157_1.talkMaxDuration)

			if var_160_21 <= arg_157_1.time_ and arg_157_1.time_ < var_160_21 + var_160_31 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_21) / var_160_31

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_21 + var_160_31 and arg_157_1.time_ < var_160_21 + var_160_31 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/F01a"
	},
	voices = {
		"story_v_out_113051.awb"
	}
}
