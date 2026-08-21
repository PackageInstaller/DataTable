return {
	Play116051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "A00"

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
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.A00

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
					if iter_4_0 ~= "A00" then
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

			local var_4_28 = 2
			local var_4_29 = 0.733333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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
			local var_4_35 = 0.4

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

				local var_4_37 = arg_1_1:GetWordFromCfg(116051001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 16
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
	Play116051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116051002
		arg_9_1.duration_ = 7.37

		local var_9_0 = {
			zh = 7.366,
			ja = 2.5
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
				arg_9_0:Play116051003(arg_9_1)
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

			local var_12_14 = 0

			if var_12_14 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_12_16 = arg_9_1.actors_["1029ui_story"]
			local var_12_17 = 0

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1029ui_story == nil then
				arg_9_1.var_.characterEffect1029ui_story = var_12_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_18 = 0.2

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_18 and not isNil(var_12_16) then
				local var_12_19 = (arg_9_1.time_ - var_12_17) / var_12_18

				if arg_9_1.var_.characterEffect1029ui_story and not isNil(var_12_16) then
					arg_9_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_17 + var_12_18 and arg_9_1.time_ < var_12_17 + var_12_18 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1029ui_story then
				arg_9_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_12_20 = 0
			local var_12_21 = 0.65

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[319].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(116051002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051002", "story_v_out_116051.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_116051", "116051002", "story_v_out_116051.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_116051", "116051002", "story_v_out_116051.awb")

						arg_9_1:RecordAudio("116051002", var_12_29)
						arg_9_1:RecordAudio("116051002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_116051", "116051002", "story_v_out_116051.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_116051", "116051002", "story_v_out_116051.awb")
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
				actorName = "1029ui_story",
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
	Play116051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116051003
		arg_13_1.duration_ = 10.7

		local var_13_0 = {
			zh = 7.966,
			ja = 10.7
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
				arg_13_0:Play116051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_16_1 = 0
			local var_16_2 = 0.9

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_3 = arg_13_1:FormatText(StoryNameCfg[319].name)

				arg_13_1.leftNameTxt_.text = var_16_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(116051003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 36
				local var_16_7 = utf8.len(var_16_5)
				local var_16_8 = var_16_6 <= 0 and var_16_2 or var_16_2 * (var_16_7 / var_16_6)

				if var_16_8 > 0 and var_16_2 < var_16_8 then
					arg_13_1.talkMaxDuration = var_16_8

					if var_16_8 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051003", "story_v_out_116051.awb") ~= 0 then
					local var_16_9 = manager.audio:GetVoiceLength("story_v_out_116051", "116051003", "story_v_out_116051.awb") / 1000

					if var_16_9 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_1
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_116051", "116051003", "story_v_out_116051.awb")

						arg_13_1:RecordAudio("116051003", var_16_10)
						arg_13_1:RecordAudio("116051003", var_16_10)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_116051", "116051003", "story_v_out_116051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_116051", "116051003", "story_v_out_116051.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_11 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_11 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_11

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_11 and arg_13_1.time_ < var_16_1 + var_16_11 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play116051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116051004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play116051005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1029ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1029ui_story == nil then
				arg_17_1.var_.characterEffect1029ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1029ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1029ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1029ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1029ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.425

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(116051004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 17
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
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play116051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116051005
		arg_21_1.duration_ = 6.5

		local var_21_0 = {
			zh = 2.666,
			ja = 6.5
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play116051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_24_1 = arg_21_1.actors_["1029ui_story"]
			local var_24_2 = 0

			if var_24_2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1029ui_story == nil then
				arg_21_1.var_.characterEffect1029ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.2

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_3 and not isNil(var_24_1) then
				local var_24_4 = (arg_21_1.time_ - var_24_2) / var_24_3

				if arg_21_1.var_.characterEffect1029ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_2 + var_24_3 and arg_21_1.time_ < var_24_2 + var_24_3 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1029ui_story then
				arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_24_6 = 0
			local var_24_7 = 0.25

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[319].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:GetWordFromCfg(116051005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051005", "story_v_out_116051.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_116051", "116051005", "story_v_out_116051.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_out_116051", "116051005", "story_v_out_116051.awb")

						arg_21_1:RecordAudio("116051005", var_24_15)
						arg_21_1:RecordAudio("116051005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_116051", "116051005", "story_v_out_116051.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_116051", "116051005", "story_v_out_116051.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_16 and arg_21_1.time_ < var_24_6 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play116051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116051006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1029ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1029ui_story == nil then
				arg_25_1.var_.characterEffect1029ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1029ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1029ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.2

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(116051006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 8
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play116051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116051007
		arg_29_1.duration_ = 3.27

		local var_29_0 = {
			zh = 3.266,
			ja = 2.166
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
				arg_29_0:Play116051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_32_1 = arg_29_1.actors_["1029ui_story"]
			local var_32_2 = 0

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1029ui_story == nil then
				arg_29_1.var_.characterEffect1029ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.2

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_3 and not isNil(var_32_1) then
				local var_32_4 = (arg_29_1.time_ - var_32_2) / var_32_3

				if arg_29_1.var_.characterEffect1029ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_2 + var_32_3 and arg_29_1.time_ < var_32_2 + var_32_3 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1029ui_story then
				arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_32_5 = 0
			local var_32_6 = 0.15

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_7 = arg_29_1:FormatText(StoryNameCfg[319].name)

				arg_29_1.leftNameTxt_.text = var_32_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(116051007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 6
				local var_32_11 = utf8.len(var_32_9)
				local var_32_12 = var_32_10 <= 0 and var_32_6 or var_32_6 * (var_32_11 / var_32_10)

				if var_32_12 > 0 and var_32_6 < var_32_12 then
					arg_29_1.talkMaxDuration = var_32_12

					if var_32_12 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051007", "story_v_out_116051.awb") ~= 0 then
					local var_32_13 = manager.audio:GetVoiceLength("story_v_out_116051", "116051007", "story_v_out_116051.awb") / 1000

					if var_32_13 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_5
					end

					if var_32_8.prefab_name ~= "" and arg_29_1.actors_[var_32_8.prefab_name] ~= nil then
						local var_32_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_8.prefab_name].transform, "story_v_out_116051", "116051007", "story_v_out_116051.awb")

						arg_29_1:RecordAudio("116051007", var_32_14)
						arg_29_1:RecordAudio("116051007", var_32_14)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_116051", "116051007", "story_v_out_116051.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_116051", "116051007", "story_v_out_116051.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_15 = math.max(var_32_6, arg_29_1.talkMaxDuration)

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_15 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_5) / var_32_15

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_5 + var_32_15 and arg_29_1.time_ < var_32_5 + var_32_15 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play116051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116051008
		arg_33_1.duration_ = 8.77

		local var_33_0 = {
			zh = 6.566,
			ja = 8.766
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
				arg_33_0:Play116051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_36_1 = arg_33_1.actors_["1029ui_story"]
			local var_36_2 = 0

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1029ui_story == nil then
				arg_33_1.var_.characterEffect1029ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.2

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_3 and not isNil(var_36_1) then
				local var_36_4 = (arg_33_1.time_ - var_36_2) / var_36_3

				if arg_33_1.var_.characterEffect1029ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_2 + var_36_3 and arg_33_1.time_ < var_36_2 + var_36_3 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1029ui_story then
				arg_33_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_36_5 = 0
			local var_36_6 = 0.675

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

				local var_36_8 = arg_33_1:GetWordFromCfg(116051008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051008", "story_v_out_116051.awb") ~= 0 then
					local var_36_13 = manager.audio:GetVoiceLength("story_v_out_116051", "116051008", "story_v_out_116051.awb") / 1000

					if var_36_13 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_5
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_116051", "116051008", "story_v_out_116051.awb")

						arg_33_1:RecordAudio("116051008", var_36_14)
						arg_33_1:RecordAudio("116051008", var_36_14)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_116051", "116051008", "story_v_out_116051.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_116051", "116051008", "story_v_out_116051.awb")
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
	Play116051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116051009
		arg_37_1.duration_ = 0.2

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"

			SetActive(arg_37_1.choicesGo_, true)

			for iter_38_0, iter_38_1 in ipairs(arg_37_1.choices_) do
				local var_38_0 = iter_38_0 <= 2

				SetActive(iter_38_1.go, var_38_0)
			end

			arg_37_1.choices_[1].txt.text = arg_37_1:FormatText(StoryChoiceCfg[238].name)
			arg_37_1.choices_[2].txt.text = arg_37_1:FormatText(StoryChoiceCfg[239].name)
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play116051010(arg_37_1)
			end

			if arg_39_0 == 2 then
				arg_37_0:Play116051010(arg_37_1)
			end

			arg_37_1:RecordChoiceLog(116051009, 238, 239)
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1029ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1029ui_story == nil then
				arg_37_1.var_.characterEffect1029ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1029ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1029ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1029ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1029ui_story.fillRatio = var_40_5
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play116051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116051010
		arg_41_1.duration_ = 9.33

		local var_41_0 = {
			zh = 9.333,
			ja = 7.066
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
				arg_41_0:Play116051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = "1029ui_story"

			if arg_41_1.actors_[var_44_0] == nil then
				local var_44_1 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_44_1) then
					local var_44_2 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_41_1.stage_.transform)

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

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_44_6 = arg_41_1.actors_["1029ui_story"]
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1029ui_story == nil then
				arg_41_1.var_.characterEffect1029ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.2

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 and not isNil(var_44_6) then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8

				if arg_41_1.var_.characterEffect1029ui_story and not isNil(var_44_6) then
					arg_41_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1029ui_story then
				arg_41_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_44_10 = 0
			local var_44_11 = 1.05

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_12 = arg_41_1:FormatText(StoryNameCfg[319].name)

				arg_41_1.leftNameTxt_.text = var_44_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_13 = arg_41_1:GetWordFromCfg(116051010)
				local var_44_14 = arg_41_1:FormatText(var_44_13.content)

				arg_41_1.text_.text = var_44_14

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_15 = 42
				local var_44_16 = utf8.len(var_44_14)
				local var_44_17 = var_44_15 <= 0 and var_44_11 or var_44_11 * (var_44_16 / var_44_15)

				if var_44_17 > 0 and var_44_11 < var_44_17 then
					arg_41_1.talkMaxDuration = var_44_17

					if var_44_17 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_10
					end
				end

				arg_41_1.text_.text = var_44_14
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051010", "story_v_out_116051.awb") ~= 0 then
					local var_44_18 = manager.audio:GetVoiceLength("story_v_out_116051", "116051010", "story_v_out_116051.awb") / 1000

					if var_44_18 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_10
					end

					if var_44_13.prefab_name ~= "" and arg_41_1.actors_[var_44_13.prefab_name] ~= nil then
						local var_44_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_13.prefab_name].transform, "story_v_out_116051", "116051010", "story_v_out_116051.awb")

						arg_41_1:RecordAudio("116051010", var_44_19)
						arg_41_1:RecordAudio("116051010", var_44_19)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_116051", "116051010", "story_v_out_116051.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_116051", "116051010", "story_v_out_116051.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_20 = math.max(var_44_11, arg_41_1.talkMaxDuration)

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_20 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_10) / var_44_20

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_10 + var_44_20 and arg_41_1.time_ < var_44_10 + var_44_20 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play116051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116051011
		arg_45_1.duration_ = 7.73

		local var_45_0 = {
			zh = 7.5,
			ja = 7.733
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
				arg_45_0:Play116051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_48_1 = 0
			local var_48_2 = 0.9

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_3 = arg_45_1:FormatText(StoryNameCfg[319].name)

				arg_45_1.leftNameTxt_.text = var_48_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(116051011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 36
				local var_48_7 = utf8.len(var_48_5)
				local var_48_8 = var_48_6 <= 0 and var_48_2 or var_48_2 * (var_48_7 / var_48_6)

				if var_48_8 > 0 and var_48_2 < var_48_8 then
					arg_45_1.talkMaxDuration = var_48_8

					if var_48_8 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051011", "story_v_out_116051.awb") ~= 0 then
					local var_48_9 = manager.audio:GetVoiceLength("story_v_out_116051", "116051011", "story_v_out_116051.awb") / 1000

					if var_48_9 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_1
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_116051", "116051011", "story_v_out_116051.awb")

						arg_45_1:RecordAudio("116051011", var_48_10)
						arg_45_1:RecordAudio("116051011", var_48_10)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_116051", "116051011", "story_v_out_116051.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_116051", "116051011", "story_v_out_116051.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_11 and arg_45_1.time_ < var_48_1 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play116051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116051012
		arg_49_1.duration_ = 7.9

		local var_49_0 = {
			zh = 5.2,
			ja = 7.9
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
				arg_49_0:Play116051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_52_1 = 0
			local var_52_2 = 0.6

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_3 = arg_49_1:FormatText(StoryNameCfg[319].name)

				arg_49_1.leftNameTxt_.text = var_52_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(116051012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 24
				local var_52_7 = utf8.len(var_52_5)
				local var_52_8 = var_52_6 <= 0 and var_52_2 or var_52_2 * (var_52_7 / var_52_6)

				if var_52_8 > 0 and var_52_2 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051012", "story_v_out_116051.awb") ~= 0 then
					local var_52_9 = manager.audio:GetVoiceLength("story_v_out_116051", "116051012", "story_v_out_116051.awb") / 1000

					if var_52_9 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_1
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_116051", "116051012", "story_v_out_116051.awb")

						arg_49_1:RecordAudio("116051012", var_52_10)
						arg_49_1:RecordAudio("116051012", var_52_10)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_116051", "116051012", "story_v_out_116051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_116051", "116051012", "story_v_out_116051.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_11 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_11 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_11

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_11 and arg_49_1.time_ < var_52_1 + var_52_11 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play116051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116051013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play116051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1029ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1029ui_story == nil then
				arg_53_1.var_.characterEffect1029ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1029ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1029ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1029ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1029ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.575

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(116051013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 23
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
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play116051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116051014
		arg_57_1.duration_ = 5.5

		local var_57_0 = {
			zh = 5.5,
			ja = 4.833
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
				arg_57_0:Play116051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_60_1 = arg_57_1.actors_["1029ui_story"]
			local var_60_2 = 0

			if var_60_2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1029ui_story == nil then
				arg_57_1.var_.characterEffect1029ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.2

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_3 and not isNil(var_60_1) then
				local var_60_4 = (arg_57_1.time_ - var_60_2) / var_60_3

				if arg_57_1.var_.characterEffect1029ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_2 + var_60_3 and arg_57_1.time_ < var_60_2 + var_60_3 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1029ui_story then
				arg_57_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_60_5 = 0
			local var_60_6 = 0.6

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_7 = arg_57_1:FormatText(StoryNameCfg[319].name)

				arg_57_1.leftNameTxt_.text = var_60_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(116051014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 24
				local var_60_11 = utf8.len(var_60_9)
				local var_60_12 = var_60_10 <= 0 and var_60_6 or var_60_6 * (var_60_11 / var_60_10)

				if var_60_12 > 0 and var_60_6 < var_60_12 then
					arg_57_1.talkMaxDuration = var_60_12

					if var_60_12 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051014", "story_v_out_116051.awb") ~= 0 then
					local var_60_13 = manager.audio:GetVoiceLength("story_v_out_116051", "116051014", "story_v_out_116051.awb") / 1000

					if var_60_13 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_5
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_116051", "116051014", "story_v_out_116051.awb")

						arg_57_1:RecordAudio("116051014", var_60_14)
						arg_57_1:RecordAudio("116051014", var_60_14)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_116051", "116051014", "story_v_out_116051.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_116051", "116051014", "story_v_out_116051.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_15 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_15 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_15

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_15 and arg_57_1.time_ < var_60_5 + var_60_15 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play116051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116051015
		arg_61_1.duration_ = 6.77

		local var_61_0 = {
			zh = 6.666,
			ja = 6.766
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

			SetActive(arg_61_1.choicesGo_, true)

			for iter_62_0, iter_62_1 in ipairs(arg_61_1.choices_) do
				local var_62_0 = iter_62_0 <= 1

				SetActive(iter_62_1.go, var_62_0)
			end

			arg_61_1.choices_[1].txt.text = arg_61_1:FormatText(StoryChoiceCfg[240].name)
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play116051017(arg_61_1)
			end

			arg_61_1:RecordChoiceLog(116051015, 240)
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_64_1 = 0
			local var_64_2 = 0.6

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_3 = arg_61_1:FormatText(StoryNameCfg[319].name)

				arg_61_1.leftNameTxt_.text = var_64_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(116051015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 24
				local var_64_7 = utf8.len(var_64_5)
				local var_64_8 = var_64_6 <= 0 and var_64_2 or var_64_2 * (var_64_7 / var_64_6)

				if var_64_8 > 0 and var_64_2 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8

					if var_64_8 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051015", "story_v_out_116051.awb") ~= 0 then
					local var_64_9 = manager.audio:GetVoiceLength("story_v_out_116051", "116051015", "story_v_out_116051.awb") / 1000

					if var_64_9 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_1
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_116051", "116051015", "story_v_out_116051.awb")

						arg_61_1:RecordAudio("116051015", var_64_10)
						arg_61_1:RecordAudio("116051015", var_64_10)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_116051", "116051015", "story_v_out_116051.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_116051", "116051015", "story_v_out_116051.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_11 and arg_61_1.time_ < var_64_1 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play116051017 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116051017
		arg_65_1.duration_ = 13.17

		local var_65_0 = {
			zh = 13.166,
			ja = 8.666
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
				arg_65_0:Play116051018(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_68_1 = arg_65_1.actors_["1029ui_story"]
			local var_68_2 = 0

			if var_68_2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1029ui_story == nil then
				arg_65_1.var_.characterEffect1029ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.2

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_3 and not isNil(var_68_1) then
				local var_68_4 = (arg_65_1.time_ - var_68_2) / var_68_3

				if arg_65_1.var_.characterEffect1029ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_2 + var_68_3 and arg_65_1.time_ < var_68_2 + var_68_3 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1029ui_story then
				arg_65_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action447")
			end

			local var_68_6 = 0
			local var_68_7 = 1.425

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[319].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_9 = arg_65_1:GetWordFromCfg(116051017)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 57
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

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051017", "story_v_out_116051.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_116051", "116051017", "story_v_out_116051.awb") / 1000

					if var_68_14 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_6
					end

					if var_68_9.prefab_name ~= "" and arg_65_1.actors_[var_68_9.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_9.prefab_name].transform, "story_v_out_116051", "116051017", "story_v_out_116051.awb")

						arg_65_1:RecordAudio("116051017", var_68_15)
						arg_65_1:RecordAudio("116051017", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_116051", "116051017", "story_v_out_116051.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_116051", "116051017", "story_v_out_116051.awb")
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
	Play116051018 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116051018
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play116051019(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1029ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1029ui_story == nil then
				arg_69_1.var_.characterEffect1029ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1029ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1029ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1029ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1029ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.175

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(116051018)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 7
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
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play116051019 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 116051019
		arg_73_1.duration_ = 15.87

		local var_73_0 = {
			zh = 10.766,
			ja = 15.866
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
				arg_73_0:Play116051020(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_76_1 = arg_73_1.actors_["1029ui_story"]
			local var_76_2 = 0

			if var_76_2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1029ui_story == nil then
				arg_73_1.var_.characterEffect1029ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.2

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_3 and not isNil(var_76_1) then
				local var_76_4 = (arg_73_1.time_ - var_76_2) / var_76_3

				if arg_73_1.var_.characterEffect1029ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_2 + var_76_3 and arg_73_1.time_ < var_76_2 + var_76_3 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1029ui_story then
				arg_73_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action7_2")
			end

			local var_76_6 = 0
			local var_76_7 = 1.125

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[319].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_9 = arg_73_1:GetWordFromCfg(116051019)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051019", "story_v_out_116051.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_116051", "116051019", "story_v_out_116051.awb") / 1000

					if var_76_14 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_6
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_out_116051", "116051019", "story_v_out_116051.awb")

						arg_73_1:RecordAudio("116051019", var_76_15)
						arg_73_1:RecordAudio("116051019", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_116051", "116051019", "story_v_out_116051.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_116051", "116051019", "story_v_out_116051.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_16 and arg_73_1.time_ < var_76_6 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play116051020 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 116051020
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play116051021(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1029ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1029ui_story == nil then
				arg_77_1.var_.characterEffect1029ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1029ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1029ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1029ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1029ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 0.275

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_8 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_9 = arg_77_1:GetWordFromCfg(116051020)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 11
				local var_80_12 = utf8.len(var_80_10)
				local var_80_13 = var_80_11 <= 0 and var_80_7 or var_80_7 * (var_80_12 / var_80_11)

				if var_80_13 > 0 and var_80_7 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_14 and arg_77_1.time_ < var_80_6 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play116051021 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 116051021
		arg_81_1.duration_ = 3.87

		local var_81_0 = {
			zh = 1.999999999999,
			ja = 3.866
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
				arg_81_0:Play116051022(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1029ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1029ui_story == nil then
				arg_81_1.var_.characterEffect1029ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1029ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1029ui_story then
				arg_81_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_84_5 = 0
			local var_84_6 = 0.2

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_7 = arg_81_1:FormatText(StoryNameCfg[319].name)

				arg_81_1.leftNameTxt_.text = var_84_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(116051021)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 8
				local var_84_11 = utf8.len(var_84_9)
				local var_84_12 = var_84_10 <= 0 and var_84_6 or var_84_6 * (var_84_11 / var_84_10)

				if var_84_12 > 0 and var_84_6 < var_84_12 then
					arg_81_1.talkMaxDuration = var_84_12

					if var_84_12 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051021", "story_v_out_116051.awb") ~= 0 then
					local var_84_13 = manager.audio:GetVoiceLength("story_v_out_116051", "116051021", "story_v_out_116051.awb") / 1000

					if var_84_13 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_5
					end

					if var_84_8.prefab_name ~= "" and arg_81_1.actors_[var_84_8.prefab_name] ~= nil then
						local var_84_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_8.prefab_name].transform, "story_v_out_116051", "116051021", "story_v_out_116051.awb")

						arg_81_1:RecordAudio("116051021", var_84_14)
						arg_81_1:RecordAudio("116051021", var_84_14)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_116051", "116051021", "story_v_out_116051.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_116051", "116051021", "story_v_out_116051.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_15 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_15 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_15

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_15 and arg_81_1.time_ < var_84_5 + var_84_15 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play116051022 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 116051022
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play116051023(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1029ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1029ui_story == nil then
				arg_85_1.var_.characterEffect1029ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1029ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1029ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1029ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1029ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.325

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(116051022)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 13
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play116051023 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116051023
		arg_89_1.duration_ = 4.33

		local var_89_0 = {
			zh = 4.333,
			ja = 3.266
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
				arg_89_0:Play116051024(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1029ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1029ui_story == nil then
				arg_89_1.var_.characterEffect1029ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1029ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1029ui_story then
				arg_89_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_92_4 = 0

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_92_5 = 0
			local var_92_6 = 0.325

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_7 = arg_89_1:FormatText(StoryNameCfg[319].name)

				arg_89_1.leftNameTxt_.text = var_92_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(116051023)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 13
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_6 or var_92_6 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_6 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051023", "story_v_out_116051.awb") ~= 0 then
					local var_92_13 = manager.audio:GetVoiceLength("story_v_out_116051", "116051023", "story_v_out_116051.awb") / 1000

					if var_92_13 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_5
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_out_116051", "116051023", "story_v_out_116051.awb")

						arg_89_1:RecordAudio("116051023", var_92_14)
						arg_89_1:RecordAudio("116051023", var_92_14)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_116051", "116051023", "story_v_out_116051.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_116051", "116051023", "story_v_out_116051.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_15 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_15 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_15

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_15 and arg_89_1.time_ < var_92_5 + var_92_15 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play116051024 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 116051024
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play116051025(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1029ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1029ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, 100, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1029ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, 100, 0)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = 0
			local var_96_10 = 0.75

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_11 = arg_93_1:GetWordFromCfg(116051024)
				local var_96_12 = arg_93_1:FormatText(var_96_11.content)

				arg_93_1.text_.text = var_96_12

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 30
				local var_96_14 = utf8.len(var_96_12)
				local var_96_15 = var_96_13 <= 0 and var_96_10 or var_96_10 * (var_96_14 / var_96_13)

				if var_96_15 > 0 and var_96_10 < var_96_15 then
					arg_93_1.talkMaxDuration = var_96_15

					if var_96_15 + var_96_9 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_15 + var_96_9
					end
				end

				arg_93_1.text_.text = var_96_12
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_10, arg_93_1.talkMaxDuration)

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_9) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_9 + var_96_16 and arg_93_1.time_ < var_96_9 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play116051025 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 116051025
		arg_97_1.duration_ = 9

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play116051026(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_1 = 2

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_1 then
				local var_100_2 = (arg_97_1.time_ - var_100_0) / var_100_1
				local var_100_3 = Color.New(0, 0, 0)

				var_100_3.a = Mathf.Lerp(0, 1, var_100_2)
				arg_97_1.mask_.color = var_100_3
			end

			if arg_97_1.time_ >= var_100_0 + var_100_1 and arg_97_1.time_ < var_100_0 + var_100_1 + arg_100_0 then
				local var_100_4 = Color.New(0, 0, 0)

				var_100_4.a = 1
				arg_97_1.mask_.color = var_100_4
			end

			local var_100_5 = 2

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_6 = 2

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_6 then
				local var_100_7 = (arg_97_1.time_ - var_100_5) / var_100_6
				local var_100_8 = Color.New(0, 0, 0)

				var_100_8.a = Mathf.Lerp(1, 0, var_100_7)
				arg_97_1.mask_.color = var_100_8
			end

			if arg_97_1.time_ >= var_100_5 + var_100_6 and arg_97_1.time_ < var_100_5 + var_100_6 + arg_100_0 then
				local var_100_9 = Color.New(0, 0, 0)
				local var_100_10 = 0

				arg_97_1.mask_.enabled = false
				var_100_9.a = var_100_10
				arg_97_1.mask_.color = var_100_9
			end

			local var_100_11 = "ST18a"

			if arg_97_1.bgs_[var_100_11] == nil then
				local var_100_12 = Object.Instantiate(arg_97_1.paintGo_)

				var_100_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_100_11)
				var_100_12.name = var_100_11
				var_100_12.transform.parent = arg_97_1.stage_.transform
				var_100_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.bgs_[var_100_11] = var_100_12
			end

			local var_100_13 = 2

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				local var_100_14 = manager.ui.mainCamera.transform.localPosition
				local var_100_15 = Vector3.New(0, 0, 10) + Vector3.New(var_100_14.x, var_100_14.y, 0)
				local var_100_16 = arg_97_1.bgs_.ST18a

				var_100_16.transform.localPosition = var_100_15
				var_100_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_100_17 = var_100_16:GetComponent("SpriteRenderer")

				if var_100_17 and var_100_17.sprite then
					local var_100_18 = (var_100_16.transform.localPosition - var_100_14).z
					local var_100_19 = manager.ui.mainCameraCom_
					local var_100_20 = 2 * var_100_18 * Mathf.Tan(var_100_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_100_21 = var_100_20 * var_100_19.aspect
					local var_100_22 = var_100_17.sprite.bounds.size.x
					local var_100_23 = var_100_17.sprite.bounds.size.y
					local var_100_24 = var_100_21 / var_100_22
					local var_100_25 = var_100_20 / var_100_23
					local var_100_26 = var_100_25 < var_100_24 and var_100_24 or var_100_25

					var_100_16.transform.localScale = Vector3.New(var_100_26, var_100_26, 0)
				end

				for iter_100_0, iter_100_1 in pairs(arg_97_1.bgs_) do
					if iter_100_0 ~= "ST18a" then
						iter_100_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_100_27 = 0
			local var_100_28 = 1

			if var_100_27 < arg_97_1.time_ and arg_97_1.time_ <= var_100_27 + arg_100_0 then
				local var_100_29 = "play"
				local var_100_30 = "music"

				arg_97_1:AudioAction(var_100_29, var_100_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_100_31 = ""
				local var_100_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_100_32 ~= "" then
					if arg_97_1.bgmTxt_.text ~= var_100_32 and arg_97_1.bgmTxt_.text ~= "" then
						if arg_97_1.bgmTxt2_.text ~= "" then
							arg_97_1.bgmTxt_.text = arg_97_1.bgmTxt2_.text
						end

						arg_97_1.bgmTxt2_.text = var_100_32

						arg_97_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_97_1.bgmTxt_.text = var_100_32
						arg_97_1.bgmTxt2_.text = var_100_32
					end

					if arg_97_1.bgmTimer then
						arg_97_1.bgmTimer:Stop()

						arg_97_1.bgmTimer = nil
					end

					if arg_97_1.settingData.show_music_name == 1 then
						arg_97_1.musicController:SetSelectedState("show")
						arg_97_1.musicAnimator_:Play("open", 0, 0)

						if arg_97_1.settingData.music_time ~= 0 then
							arg_97_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_97_1.settingData.music_time), function()
								if arg_97_1 == nil or isNil(arg_97_1.bgmTxt_) then
									return
								end

								arg_97_1.musicController:SetSelectedState("hide")
								arg_97_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_100_33 = 2
			local var_100_34 = 1.5

			if var_100_33 < arg_97_1.time_ and arg_97_1.time_ <= var_100_33 + arg_100_0 then
				local var_100_35 = "play"
				local var_100_36 = "music"

				arg_97_1:AudioAction(var_100_35, var_100_36, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_100_37 = ""

				if var_100_37 ~= "" then
					if arg_97_1.bgmTxt_.text ~= var_100_37 and arg_97_1.bgmTxt_.text ~= "" then
						if arg_97_1.bgmTxt2_.text ~= "" then
							arg_97_1.bgmTxt_.text = arg_97_1.bgmTxt2_.text
						end

						arg_97_1.bgmTxt2_.text = var_100_37

						arg_97_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_97_1.bgmTxt_.text = var_100_37
						arg_97_1.bgmTxt2_.text = var_100_37
					end

					if arg_97_1.bgmTimer then
						arg_97_1.bgmTimer:Stop()

						arg_97_1.bgmTimer = nil
					end

					if arg_97_1.settingData.show_music_name == 1 then
						arg_97_1.musicController:SetSelectedState("show")
						arg_97_1.musicAnimator_:Play("open", 0, 0)

						if arg_97_1.settingData.music_time ~= 0 then
							arg_97_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_97_1.settingData.music_time), function()
								if arg_97_1 == nil or isNil(arg_97_1.bgmTxt_) then
									return
								end

								arg_97_1.musicController:SetSelectedState("hide")
								arg_97_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_100_38 = 2.2
			local var_100_39 = 1.5

			if var_100_38 < arg_97_1.time_ and arg_97_1.time_ <= var_100_38 + arg_100_0 then
				local var_100_40 = "play"
				local var_100_41 = "music"

				arg_97_1:AudioAction(var_100_40, var_100_41, "bgm_activity_1_6_story_story", "dialog", "bgm_activity_1_6_story_story.awb")

				local var_100_42 = ""
				local var_100_43 = MusicRecordCfg[95].musicName

				if var_100_43 ~= "" then
					if arg_97_1.bgmTxt_.text ~= var_100_43 and arg_97_1.bgmTxt_.text ~= "" then
						if arg_97_1.bgmTxt2_.text ~= "" then
							arg_97_1.bgmTxt_.text = arg_97_1.bgmTxt2_.text
						end

						arg_97_1.bgmTxt2_.text = var_100_43

						arg_97_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_97_1.bgmTxt_.text = var_100_43
						arg_97_1.bgmTxt2_.text = var_100_43
					end

					if arg_97_1.bgmTimer then
						arg_97_1.bgmTimer:Stop()

						arg_97_1.bgmTimer = nil
					end

					if arg_97_1.settingData.show_music_name == 1 then
						arg_97_1.musicController:SetSelectedState("show")
						arg_97_1.musicAnimator_:Play("open", 0, 0)

						if arg_97_1.settingData.music_time ~= 0 then
							arg_97_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_97_1.settingData.music_time), function()
								if arg_97_1 == nil or isNil(arg_97_1.bgmTxt_) then
									return
								end

								arg_97_1.musicController:SetSelectedState("hide")
								arg_97_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_44 = 4
			local var_100_45 = 0.45

			if var_100_44 < arg_97_1.time_ and arg_97_1.time_ <= var_100_44 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_46 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_46:setOnUpdate(LuaHelper.FloatAction(function(arg_104_0)
					arg_97_1.dialogCg_.alpha = arg_104_0
				end))
				var_100_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_47 = arg_97_1:GetWordFromCfg(116051025)
				local var_100_48 = arg_97_1:FormatText(var_100_47.content)

				arg_97_1.text_.text = var_100_48

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_49 = 18
				local var_100_50 = utf8.len(var_100_48)
				local var_100_51 = var_100_49 <= 0 and var_100_45 or var_100_45 * (var_100_50 / var_100_49)

				if var_100_51 > 0 and var_100_45 < var_100_51 then
					arg_97_1.talkMaxDuration = var_100_51
					var_100_44 = var_100_44 + 0.3

					if var_100_51 + var_100_44 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_51 + var_100_44
					end
				end

				arg_97_1.text_.text = var_100_48
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_52 = var_100_44 + 0.3
			local var_100_53 = math.max(var_100_45, arg_97_1.talkMaxDuration)

			if var_100_52 <= arg_97_1.time_ and arg_97_1.time_ < var_100_52 + var_100_53 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_52) / var_100_53

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_52 + var_100_53 and arg_97_1.time_ < var_100_52 + var_100_53 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play116051026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 116051026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play116051027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.25

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[7].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(116051026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 10
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_8 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_8 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_8

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_8 and arg_106_1.time_ < var_109_0 + var_109_8 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play116051027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 116051027
		arg_110_1.duration_ = 7.13

		local var_110_0 = {
			zh = 4.233,
			ja = 7.133
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
				arg_110_0:Play116051028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.375

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[328].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(116051027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 23
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051027", "story_v_out_116051.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_116051", "116051027", "story_v_out_116051.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_116051", "116051027", "story_v_out_116051.awb")

						arg_110_1:RecordAudio("116051027", var_113_9)
						arg_110_1:RecordAudio("116051027", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_116051", "116051027", "story_v_out_116051.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_116051", "116051027", "story_v_out_116051.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play116051028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 116051028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play116051029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.15

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_2 = arg_114_1:GetWordFromCfg(116051028)
				local var_117_3 = arg_114_1:FormatText(var_117_2.content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 6
				local var_117_5 = utf8.len(var_117_3)
				local var_117_6 = var_117_4 <= 0 and var_117_1 or var_117_1 * (var_117_5 / var_117_4)

				if var_117_6 > 0 and var_117_1 < var_117_6 then
					arg_114_1.talkMaxDuration = var_117_6

					if var_117_6 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_7 and arg_114_1.time_ < var_117_0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play116051029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 116051029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play116051030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 1.375

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

				local var_121_2 = arg_118_1:GetWordFromCfg(116051029)
				local var_121_3 = arg_118_1:FormatText(var_121_2.content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 55
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
	Play116051030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116051030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play116051031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.525

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(116051030)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 21
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_8 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_8 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_8

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_8 and arg_122_1.time_ < var_125_0 + var_125_8 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play116051031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 116051031
		arg_126_1.duration_ = 12.5

		local var_126_0 = {
			zh = 6.833,
			ja = 12.5
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
				arg_126_0:Play116051032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = "10025ui_story"

			if arg_126_1.actors_[var_129_0] == nil then
				local var_129_1 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_129_1) then
					local var_129_2 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_126_1.stage_.transform)

					var_129_2.name = var_129_0
					var_129_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_126_1.actors_[var_129_0] = var_129_2

					local var_129_3 = var_129_2:GetComponentInChildren(typeof(CharacterEffect))

					var_129_3.enabled = true

					local var_129_4 = GameObjectTools.GetOrAddComponent(var_129_2, typeof(DynamicBoneHelper))

					if var_129_4 then
						var_129_4:EnableDynamicBone(false)
					end

					arg_126_1:ShowWeapon(var_129_3.transform, false)

					arg_126_1.var_[var_129_0 .. "Animator"] = var_129_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_126_1.var_[var_129_0 .. "Animator"].applyRootMotion = true
					arg_126_1.var_[var_129_0 .. "LipSync"] = var_129_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_129_5 = arg_126_1.actors_["10025ui_story"].transform
			local var_129_6 = 0

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.var_.moveOldPos10025ui_story = var_129_5.localPosition
			end

			local var_129_7 = 0.001

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_7 then
				local var_129_8 = (arg_126_1.time_ - var_129_6) / var_129_7
				local var_129_9 = Vector3.New(0, -1.1, -5.9)

				var_129_5.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10025ui_story, var_129_9, var_129_8)

				local var_129_10 = manager.ui.mainCamera.transform.position - var_129_5.position

				var_129_5.forward = Vector3.New(var_129_10.x, var_129_10.y, var_129_10.z)

				local var_129_11 = var_129_5.localEulerAngles

				var_129_11.z = 0
				var_129_11.x = 0
				var_129_5.localEulerAngles = var_129_11
			end

			if arg_126_1.time_ >= var_129_6 + var_129_7 and arg_126_1.time_ < var_129_6 + var_129_7 + arg_129_0 then
				var_129_5.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_129_12 = manager.ui.mainCamera.transform.position - var_129_5.position

				var_129_5.forward = Vector3.New(var_129_12.x, var_129_12.y, var_129_12.z)

				local var_129_13 = var_129_5.localEulerAngles

				var_129_13.z = 0
				var_129_13.x = 0
				var_129_5.localEulerAngles = var_129_13
			end

			local var_129_14 = 0

			if var_129_14 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 then
				arg_126_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_129_15 = 0

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_129_16 = arg_126_1.actors_["10025ui_story"]
			local var_129_17 = 0

			if var_129_17 < arg_126_1.time_ and arg_126_1.time_ <= var_129_17 + arg_129_0 and not isNil(var_129_16) and arg_126_1.var_.characterEffect10025ui_story == nil then
				arg_126_1.var_.characterEffect10025ui_story = var_129_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_18 = 0.2

			if var_129_17 <= arg_126_1.time_ and arg_126_1.time_ < var_129_17 + var_129_18 and not isNil(var_129_16) then
				local var_129_19 = (arg_126_1.time_ - var_129_17) / var_129_18

				if arg_126_1.var_.characterEffect10025ui_story and not isNil(var_129_16) then
					arg_126_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_17 + var_129_18 and arg_126_1.time_ < var_129_17 + var_129_18 + arg_129_0 and not isNil(var_129_16) and arg_126_1.var_.characterEffect10025ui_story then
				arg_126_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_129_20 = 0
			local var_129_21 = 0.425

			if var_129_20 < arg_126_1.time_ and arg_126_1.time_ <= var_129_20 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_22 = arg_126_1:FormatText(StoryNameCfg[328].name)

				arg_126_1.leftNameTxt_.text = var_129_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_23 = arg_126_1:GetWordFromCfg(116051031)
				local var_129_24 = arg_126_1:FormatText(var_129_23.content)

				arg_126_1.text_.text = var_129_24

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_25 = 17
				local var_129_26 = utf8.len(var_129_24)
				local var_129_27 = var_129_25 <= 0 and var_129_21 or var_129_21 * (var_129_26 / var_129_25)

				if var_129_27 > 0 and var_129_21 < var_129_27 then
					arg_126_1.talkMaxDuration = var_129_27

					if var_129_27 + var_129_20 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_27 + var_129_20
					end
				end

				arg_126_1.text_.text = var_129_24
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051031", "story_v_out_116051.awb") ~= 0 then
					local var_129_28 = manager.audio:GetVoiceLength("story_v_out_116051", "116051031", "story_v_out_116051.awb") / 1000

					if var_129_28 + var_129_20 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_28 + var_129_20
					end

					if var_129_23.prefab_name ~= "" and arg_126_1.actors_[var_129_23.prefab_name] ~= nil then
						local var_129_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_23.prefab_name].transform, "story_v_out_116051", "116051031", "story_v_out_116051.awb")

						arg_126_1:RecordAudio("116051031", var_129_29)
						arg_126_1:RecordAudio("116051031", var_129_29)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_116051", "116051031", "story_v_out_116051.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_116051", "116051031", "story_v_out_116051.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_30 = math.max(var_129_21, arg_126_1.talkMaxDuration)

			if var_129_20 <= arg_126_1.time_ and arg_126_1.time_ < var_129_20 + var_129_30 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_20) / var_129_30

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_20 + var_129_30 and arg_126_1.time_ < var_129_20 + var_129_30 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play116051032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 116051032
		arg_130_1.duration_ = 0.2

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"

			SetActive(arg_130_1.choicesGo_, true)

			for iter_131_0, iter_131_1 in ipairs(arg_130_1.choices_) do
				local var_131_0 = iter_131_0 <= 1

				SetActive(iter_131_1.go, var_131_0)
			end

			arg_130_1.choices_[1].txt.text = arg_130_1:FormatText(StoryChoiceCfg[241].name)
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play116051033(arg_130_1)
			end

			arg_130_1:RecordChoiceLog(116051032, 241)
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10025ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10025ui_story == nil then
				arg_130_1.var_.characterEffect10025ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.2

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect10025ui_story and not isNil(var_133_0) then
					local var_133_4 = Mathf.Lerp(0, 0.5, var_133_3)

					arg_130_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_130_1.var_.characterEffect10025ui_story.fillRatio = var_133_4
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10025ui_story then
				local var_133_5 = 0.5

				arg_130_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_130_1.var_.characterEffect10025ui_story.fillRatio = var_133_5
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play116051033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 116051033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play116051034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["10025ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos10025ui_story = var_137_0.localPosition
			end

			local var_137_2 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2
				local var_137_4 = Vector3.New(0, 100, 0)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10025ui_story, var_137_4, var_137_3)

				local var_137_5 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_5.x, var_137_5.y, var_137_5.z)

				local var_137_6 = var_137_0.localEulerAngles

				var_137_6.z = 0
				var_137_6.x = 0
				var_137_0.localEulerAngles = var_137_6
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(0, 100, 0)

				local var_137_7 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_7.x, var_137_7.y, var_137_7.z)

				local var_137_8 = var_137_0.localEulerAngles

				var_137_8.z = 0
				var_137_8.x = 0
				var_137_0.localEulerAngles = var_137_8
			end

			local var_137_9 = manager.ui.mainCamera.transform
			local var_137_10 = 0

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1.var_.shakeOldPos = var_137_9.localPosition
			end

			local var_137_11 = 0.6

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_11 then
				local var_137_12 = (arg_134_1.time_ - var_137_10) / 0.066
				local var_137_13, var_137_14 = math.modf(var_137_12)

				var_137_9.localPosition = Vector3.New(var_137_14 * 0.13, var_137_14 * 0.13, var_137_14 * 0.13) + arg_134_1.var_.shakeOldPos
			end

			if arg_134_1.time_ >= var_137_10 + var_137_11 and arg_134_1.time_ < var_137_10 + var_137_11 + arg_137_0 then
				var_137_9.localPosition = arg_134_1.var_.shakeOldPos
			end

			local var_137_15 = 0

			if var_137_15 < arg_134_1.time_ and arg_134_1.time_ <= var_137_15 + arg_137_0 then
				arg_134_1.allBtn_.enabled = false
			end

			local var_137_16 = 0.6

			if arg_134_1.time_ >= var_137_15 + var_137_16 and arg_134_1.time_ < var_137_15 + var_137_16 + arg_137_0 then
				arg_134_1.allBtn_.enabled = true
			end

			local var_137_17 = 0
			local var_137_18 = 0.75

			if var_137_17 < arg_134_1.time_ and arg_134_1.time_ <= var_137_17 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_19 = arg_134_1:GetWordFromCfg(116051033)
				local var_137_20 = arg_134_1:FormatText(var_137_19.content)

				arg_134_1.text_.text = var_137_20

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_21 = 30
				local var_137_22 = utf8.len(var_137_20)
				local var_137_23 = var_137_21 <= 0 and var_137_18 or var_137_18 * (var_137_22 / var_137_21)

				if var_137_23 > 0 and var_137_18 < var_137_23 then
					arg_134_1.talkMaxDuration = var_137_23

					if var_137_23 + var_137_17 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_23 + var_137_17
					end
				end

				arg_134_1.text_.text = var_137_20
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_24 = math.max(var_137_18, arg_134_1.talkMaxDuration)

			if var_137_17 <= arg_134_1.time_ and arg_134_1.time_ < var_137_17 + var_137_24 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_17) / var_137_24

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_17 + var_137_24 and arg_134_1.time_ < var_137_17 + var_137_24 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play116051034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 116051034
		arg_138_1.duration_ = 1.43

		local var_138_0 = {
			zh = 1.433,
			ja = 1.3
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
				arg_138_0:Play116051035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 0.15

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[328].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(116051034)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051034", "story_v_out_116051.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_out_116051", "116051034", "story_v_out_116051.awb") / 1000

					if var_141_8 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_0
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_116051", "116051034", "story_v_out_116051.awb")

						arg_138_1:RecordAudio("116051034", var_141_9)
						arg_138_1:RecordAudio("116051034", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_116051", "116051034", "story_v_out_116051.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_116051", "116051034", "story_v_out_116051.awb")
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
	Play116051035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 116051035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play116051036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 1.075

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_2 = arg_142_1:GetWordFromCfg(116051035)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 43
				local var_145_5 = utf8.len(var_145_3)
				local var_145_6 = var_145_4 <= 0 and var_145_1 or var_145_1 * (var_145_5 / var_145_4)

				if var_145_6 > 0 and var_145_1 < var_145_6 then
					arg_142_1.talkMaxDuration = var_145_6

					if var_145_6 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_7 and arg_142_1.time_ < var_145_0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play116051036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 116051036
		arg_146_1.duration_ = 5.43

		local var_146_0 = {
			zh = 2.7,
			ja = 5.433
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
				arg_146_0:Play116051037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["10025ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos10025ui_story = var_149_0.localPosition
			end

			local var_149_2 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2
				local var_149_4 = Vector3.New(0, -1.1, -5.9)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10025ui_story, var_149_4, var_149_3)

				local var_149_5 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_5.x, var_149_5.y, var_149_5.z)

				local var_149_6 = var_149_0.localEulerAngles

				var_149_6.z = 0
				var_149_6.x = 0
				var_149_0.localEulerAngles = var_149_6
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_149_7 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_7.x, var_149_7.y, var_149_7.z)

				local var_149_8 = var_149_0.localEulerAngles

				var_149_8.z = 0
				var_149_8.x = 0
				var_149_0.localEulerAngles = var_149_8
			end

			local var_149_9 = 0

			if var_149_9 < arg_146_1.time_ and arg_146_1.time_ <= var_149_9 + arg_149_0 then
				arg_146_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_149_10 = arg_146_1.actors_["10025ui_story"]
			local var_149_11 = 0

			if var_149_11 < arg_146_1.time_ and arg_146_1.time_ <= var_149_11 + arg_149_0 and not isNil(var_149_10) and arg_146_1.var_.characterEffect10025ui_story == nil then
				arg_146_1.var_.characterEffect10025ui_story = var_149_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_12 = 0.2

			if var_149_11 <= arg_146_1.time_ and arg_146_1.time_ < var_149_11 + var_149_12 and not isNil(var_149_10) then
				local var_149_13 = (arg_146_1.time_ - var_149_11) / var_149_12

				if arg_146_1.var_.characterEffect10025ui_story and not isNil(var_149_10) then
					arg_146_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_11 + var_149_12 and arg_146_1.time_ < var_149_11 + var_149_12 + arg_149_0 and not isNil(var_149_10) and arg_146_1.var_.characterEffect10025ui_story then
				arg_146_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_149_14 = 0

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_149_15 = 0
			local var_149_16 = 0.225

			if var_149_15 < arg_146_1.time_ and arg_146_1.time_ <= var_149_15 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_17 = arg_146_1:FormatText(StoryNameCfg[328].name)

				arg_146_1.leftNameTxt_.text = var_149_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_18 = arg_146_1:GetWordFromCfg(116051036)
				local var_149_19 = arg_146_1:FormatText(var_149_18.content)

				arg_146_1.text_.text = var_149_19

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_20 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051036", "story_v_out_116051.awb") ~= 0 then
					local var_149_23 = manager.audio:GetVoiceLength("story_v_out_116051", "116051036", "story_v_out_116051.awb") / 1000

					if var_149_23 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_23 + var_149_15
					end

					if var_149_18.prefab_name ~= "" and arg_146_1.actors_[var_149_18.prefab_name] ~= nil then
						local var_149_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_18.prefab_name].transform, "story_v_out_116051", "116051036", "story_v_out_116051.awb")

						arg_146_1:RecordAudio("116051036", var_149_24)
						arg_146_1:RecordAudio("116051036", var_149_24)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_116051", "116051036", "story_v_out_116051.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_116051", "116051036", "story_v_out_116051.awb")
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
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play116051037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 116051037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play116051038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10025ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect10025ui_story == nil then
				arg_150_1.var_.characterEffect10025ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.2

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect10025ui_story and not isNil(var_153_0) then
					local var_153_4 = Mathf.Lerp(0, 0.5, var_153_3)

					arg_150_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_150_1.var_.characterEffect10025ui_story.fillRatio = var_153_4
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect10025ui_story then
				local var_153_5 = 0.5

				arg_150_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_150_1.var_.characterEffect10025ui_story.fillRatio = var_153_5
			end

			local var_153_6 = 0
			local var_153_7 = 0.625

			if var_153_6 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_8 = arg_150_1:FormatText(StoryNameCfg[7].name)

				arg_150_1.leftNameTxt_.text = var_153_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_9 = arg_150_1:GetWordFromCfg(116051037)
				local var_153_10 = arg_150_1:FormatText(var_153_9.content)

				arg_150_1.text_.text = var_153_10

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_11 = 25
				local var_153_12 = utf8.len(var_153_10)
				local var_153_13 = var_153_11 <= 0 and var_153_7 or var_153_7 * (var_153_12 / var_153_11)

				if var_153_13 > 0 and var_153_7 < var_153_13 then
					arg_150_1.talkMaxDuration = var_153_13

					if var_153_13 + var_153_6 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_13 + var_153_6
					end
				end

				arg_150_1.text_.text = var_153_10
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_14 = math.max(var_153_7, arg_150_1.talkMaxDuration)

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_14 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_6) / var_153_14

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_6 + var_153_14 and arg_150_1.time_ < var_153_6 + var_153_14 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play116051038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 116051038
		arg_154_1.duration_ = 2.97

		local var_154_0 = {
			zh = 2.6,
			ja = 2.966
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
				arg_154_0:Play116051039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_157_2 = arg_154_1.actors_["10025ui_story"]
			local var_157_3 = 0

			if var_157_3 < arg_154_1.time_ and arg_154_1.time_ <= var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect10025ui_story == nil then
				arg_154_1.var_.characterEffect10025ui_story = var_157_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_4 = 0.2

			if var_157_3 <= arg_154_1.time_ and arg_154_1.time_ < var_157_3 + var_157_4 and not isNil(var_157_2) then
				local var_157_5 = (arg_154_1.time_ - var_157_3) / var_157_4

				if arg_154_1.var_.characterEffect10025ui_story and not isNil(var_157_2) then
					arg_154_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_3 + var_157_4 and arg_154_1.time_ < var_157_3 + var_157_4 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect10025ui_story then
				arg_154_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_157_6 = 0
			local var_157_7 = 0.175

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_8 = arg_154_1:FormatText(StoryNameCfg[328].name)

				arg_154_1.leftNameTxt_.text = var_157_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_9 = arg_154_1:GetWordFromCfg(116051038)
				local var_157_10 = arg_154_1:FormatText(var_157_9.content)

				arg_154_1.text_.text = var_157_10

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_11 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051038", "story_v_out_116051.awb") ~= 0 then
					local var_157_14 = manager.audio:GetVoiceLength("story_v_out_116051", "116051038", "story_v_out_116051.awb") / 1000

					if var_157_14 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_14 + var_157_6
					end

					if var_157_9.prefab_name ~= "" and arg_154_1.actors_[var_157_9.prefab_name] ~= nil then
						local var_157_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_9.prefab_name].transform, "story_v_out_116051", "116051038", "story_v_out_116051.awb")

						arg_154_1:RecordAudio("116051038", var_157_15)
						arg_154_1:RecordAudio("116051038", var_157_15)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_116051", "116051038", "story_v_out_116051.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_116051", "116051038", "story_v_out_116051.awb")
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
	Play116051039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 116051039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play116051040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["10025ui_story"].transform
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.var_.moveOldPos10025ui_story = var_161_0.localPosition
			end

			local var_161_2 = 0.001

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2
				local var_161_4 = Vector3.New(0, 100, 0)

				var_161_0.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10025ui_story, var_161_4, var_161_3)

				local var_161_5 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_5.x, var_161_5.y, var_161_5.z)

				local var_161_6 = var_161_0.localEulerAngles

				var_161_6.z = 0
				var_161_6.x = 0
				var_161_0.localEulerAngles = var_161_6
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 then
				var_161_0.localPosition = Vector3.New(0, 100, 0)

				local var_161_7 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_7.x, var_161_7.y, var_161_7.z)

				local var_161_8 = var_161_0.localEulerAngles

				var_161_8.z = 0
				var_161_8.x = 0
				var_161_0.localEulerAngles = var_161_8
			end

			local var_161_9 = 0
			local var_161_10 = 0.75

			if var_161_9 < arg_158_1.time_ and arg_158_1.time_ <= var_161_9 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_11 = arg_158_1:GetWordFromCfg(116051039)
				local var_161_12 = arg_158_1:FormatText(var_161_11.content)

				arg_158_1.text_.text = var_161_12

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_13 = 30
				local var_161_14 = utf8.len(var_161_12)
				local var_161_15 = var_161_13 <= 0 and var_161_10 or var_161_10 * (var_161_14 / var_161_13)

				if var_161_15 > 0 and var_161_10 < var_161_15 then
					arg_158_1.talkMaxDuration = var_161_15

					if var_161_15 + var_161_9 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_15 + var_161_9
					end
				end

				arg_158_1.text_.text = var_161_12
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_10, arg_158_1.talkMaxDuration)

			if var_161_9 <= arg_158_1.time_ and arg_158_1.time_ < var_161_9 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_9) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_9 + var_161_16 and arg_158_1.time_ < var_161_9 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play116051040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 116051040
		arg_162_1.duration_ = 10.53

		local var_162_0 = {
			zh = 10.533,
			ja = 9.933
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
				arg_162_0:Play116051041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["10025ui_story"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos10025ui_story = var_165_0.localPosition
			end

			local var_165_2 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2
				local var_165_4 = Vector3.New(0, -1.1, -5.9)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10025ui_story, var_165_4, var_165_3)

				local var_165_5 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_5.x, var_165_5.y, var_165_5.z)

				local var_165_6 = var_165_0.localEulerAngles

				var_165_6.z = 0
				var_165_6.x = 0
				var_165_0.localEulerAngles = var_165_6
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_165_7 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_7.x, var_165_7.y, var_165_7.z)

				local var_165_8 = var_165_0.localEulerAngles

				var_165_8.z = 0
				var_165_8.x = 0
				var_165_0.localEulerAngles = var_165_8
			end

			local var_165_9 = 0

			if var_165_9 < arg_162_1.time_ and arg_162_1.time_ <= var_165_9 + arg_165_0 then
				arg_162_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_165_10 = arg_162_1.actors_["10025ui_story"]
			local var_165_11 = 0

			if var_165_11 < arg_162_1.time_ and arg_162_1.time_ <= var_165_11 + arg_165_0 and not isNil(var_165_10) and arg_162_1.var_.characterEffect10025ui_story == nil then
				arg_162_1.var_.characterEffect10025ui_story = var_165_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_12 = 0.2

			if var_165_11 <= arg_162_1.time_ and arg_162_1.time_ < var_165_11 + var_165_12 and not isNil(var_165_10) then
				local var_165_13 = (arg_162_1.time_ - var_165_11) / var_165_12

				if arg_162_1.var_.characterEffect10025ui_story and not isNil(var_165_10) then
					arg_162_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_11 + var_165_12 and arg_162_1.time_ < var_165_11 + var_165_12 + arg_165_0 and not isNil(var_165_10) and arg_162_1.var_.characterEffect10025ui_story then
				arg_162_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_165_14 = 0

			if var_165_14 < arg_162_1.time_ and arg_162_1.time_ <= var_165_14 + arg_165_0 then
				arg_162_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_165_15 = 0
			local var_165_16 = 0.775

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_17 = arg_162_1:FormatText(StoryNameCfg[328].name)

				arg_162_1.leftNameTxt_.text = var_165_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_18 = arg_162_1:GetWordFromCfg(116051040)
				local var_165_19 = arg_162_1:FormatText(var_165_18.content)

				arg_162_1.text_.text = var_165_19

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_20 = 31
				local var_165_21 = utf8.len(var_165_19)
				local var_165_22 = var_165_20 <= 0 and var_165_16 or var_165_16 * (var_165_21 / var_165_20)

				if var_165_22 > 0 and var_165_16 < var_165_22 then
					arg_162_1.talkMaxDuration = var_165_22

					if var_165_22 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_22 + var_165_15
					end
				end

				arg_162_1.text_.text = var_165_19
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051040", "story_v_out_116051.awb") ~= 0 then
					local var_165_23 = manager.audio:GetVoiceLength("story_v_out_116051", "116051040", "story_v_out_116051.awb") / 1000

					if var_165_23 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_23 + var_165_15
					end

					if var_165_18.prefab_name ~= "" and arg_162_1.actors_[var_165_18.prefab_name] ~= nil then
						local var_165_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_18.prefab_name].transform, "story_v_out_116051", "116051040", "story_v_out_116051.awb")

						arg_162_1:RecordAudio("116051040", var_165_24)
						arg_162_1:RecordAudio("116051040", var_165_24)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_116051", "116051040", "story_v_out_116051.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_116051", "116051040", "story_v_out_116051.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_25 = math.max(var_165_16, arg_162_1.talkMaxDuration)

			if var_165_15 <= arg_162_1.time_ and arg_162_1.time_ < var_165_15 + var_165_25 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_15) / var_165_25

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_15 + var_165_25 and arg_162_1.time_ < var_165_15 + var_165_25 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play116051041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 116051041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play116051042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10025ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect10025ui_story == nil then
				arg_166_1.var_.characterEffect10025ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect10025ui_story and not isNil(var_169_0) then
					local var_169_4 = Mathf.Lerp(0, 0.5, var_169_3)

					arg_166_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_166_1.var_.characterEffect10025ui_story.fillRatio = var_169_4
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect10025ui_story then
				local var_169_5 = 0.5

				arg_166_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_166_1.var_.characterEffect10025ui_story.fillRatio = var_169_5
			end

			local var_169_6 = 0
			local var_169_7 = 1.25

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_8 = arg_166_1:GetWordFromCfg(116051041)
				local var_169_9 = arg_166_1:FormatText(var_169_8.content)

				arg_166_1.text_.text = var_169_9

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_10 = 50
				local var_169_11 = utf8.len(var_169_9)
				local var_169_12 = var_169_10 <= 0 and var_169_7 or var_169_7 * (var_169_11 / var_169_10)

				if var_169_12 > 0 and var_169_7 < var_169_12 then
					arg_166_1.talkMaxDuration = var_169_12

					if var_169_12 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_12 + var_169_6
					end
				end

				arg_166_1.text_.text = var_169_9
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_13 = math.max(var_169_7, arg_166_1.talkMaxDuration)

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_13 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_6) / var_169_13

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_6 + var_169_13 and arg_166_1.time_ < var_169_6 + var_169_13 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play116051042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 116051042
		arg_170_1.duration_ = 9.53

		local var_170_0 = {
			zh = 4.366,
			ja = 9.533
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play116051043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10025ui_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect10025ui_story == nil then
				arg_170_1.var_.characterEffect10025ui_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect10025ui_story and not isNil(var_173_0) then
					arg_170_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect10025ui_story then
				arg_170_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_173_4 = 0

			if var_173_4 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_173_5 = 0
			local var_173_6 = 0.3

			if var_173_5 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_7 = arg_170_1:FormatText(StoryNameCfg[328].name)

				arg_170_1.leftNameTxt_.text = var_173_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_8 = arg_170_1:GetWordFromCfg(116051042)
				local var_173_9 = arg_170_1:FormatText(var_173_8.content)

				arg_170_1.text_.text = var_173_9

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_10 = 12
				local var_173_11 = utf8.len(var_173_9)
				local var_173_12 = var_173_10 <= 0 and var_173_6 or var_173_6 * (var_173_11 / var_173_10)

				if var_173_12 > 0 and var_173_6 < var_173_12 then
					arg_170_1.talkMaxDuration = var_173_12

					if var_173_12 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_12 + var_173_5
					end
				end

				arg_170_1.text_.text = var_173_9
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051042", "story_v_out_116051.awb") ~= 0 then
					local var_173_13 = manager.audio:GetVoiceLength("story_v_out_116051", "116051042", "story_v_out_116051.awb") / 1000

					if var_173_13 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_5
					end

					if var_173_8.prefab_name ~= "" and arg_170_1.actors_[var_173_8.prefab_name] ~= nil then
						local var_173_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_8.prefab_name].transform, "story_v_out_116051", "116051042", "story_v_out_116051.awb")

						arg_170_1:RecordAudio("116051042", var_173_14)
						arg_170_1:RecordAudio("116051042", var_173_14)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_116051", "116051042", "story_v_out_116051.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_116051", "116051042", "story_v_out_116051.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_15 = math.max(var_173_6, arg_170_1.talkMaxDuration)

			if var_173_5 <= arg_170_1.time_ and arg_170_1.time_ < var_173_5 + var_173_15 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_5) / var_173_15

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_5 + var_173_15 and arg_170_1.time_ < var_173_5 + var_173_15 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play116051043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 116051043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play116051044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10025ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect10025ui_story == nil then
				arg_174_1.var_.characterEffect10025ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect10025ui_story and not isNil(var_177_0) then
					local var_177_4 = Mathf.Lerp(0, 0.5, var_177_3)

					arg_174_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10025ui_story.fillRatio = var_177_4
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect10025ui_story then
				local var_177_5 = 0.5

				arg_174_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10025ui_story.fillRatio = var_177_5
			end

			local var_177_6 = 0
			local var_177_7 = 0.3

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_8 = arg_174_1:FormatText(StoryNameCfg[7].name)

				arg_174_1.leftNameTxt_.text = var_177_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_9 = arg_174_1:GetWordFromCfg(116051043)
				local var_177_10 = arg_174_1:FormatText(var_177_9.content)

				arg_174_1.text_.text = var_177_10

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_11 = 12
				local var_177_12 = utf8.len(var_177_10)
				local var_177_13 = var_177_11 <= 0 and var_177_7 or var_177_7 * (var_177_12 / var_177_11)

				if var_177_13 > 0 and var_177_7 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_6
					end
				end

				arg_174_1.text_.text = var_177_10
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_14 = math.max(var_177_7, arg_174_1.talkMaxDuration)

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_14 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_6) / var_177_14

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_6 + var_177_14 and arg_174_1.time_ < var_177_6 + var_177_14 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play116051044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 116051044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play116051045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.925

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_2 = arg_178_1:GetWordFromCfg(116051044)
				local var_181_3 = arg_178_1:FormatText(var_181_2.content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 37
				local var_181_5 = utf8.len(var_181_3)
				local var_181_6 = var_181_4 <= 0 and var_181_1 or var_181_1 * (var_181_5 / var_181_4)

				if var_181_6 > 0 and var_181_1 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_7 and arg_178_1.time_ < var_181_0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play116051045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 116051045
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play116051046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.175

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[7].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_3 = arg_182_1:GetWordFromCfg(116051045)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 7
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_8 and arg_182_1.time_ < var_185_0 + var_185_8 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play116051046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 116051046
		arg_186_1.duration_ = 4.9

		local var_186_0 = {
			zh = 4.9,
			ja = 1.999999999999
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play116051047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10025ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect10025ui_story == nil then
				arg_186_1.var_.characterEffect10025ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect10025ui_story and not isNil(var_189_0) then
					arg_186_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect10025ui_story then
				arg_186_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_189_4 = 0

			if var_189_4 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_189_5 = 0

			if var_189_5 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			local var_189_6 = 0
			local var_189_7 = 0.25

			if var_189_6 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_8 = arg_186_1:FormatText(StoryNameCfg[328].name)

				arg_186_1.leftNameTxt_.text = var_189_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_9 = arg_186_1:GetWordFromCfg(116051046)
				local var_189_10 = arg_186_1:FormatText(var_189_9.content)

				arg_186_1.text_.text = var_189_10

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_11 = 10
				local var_189_12 = utf8.len(var_189_10)
				local var_189_13 = var_189_11 <= 0 and var_189_7 or var_189_7 * (var_189_12 / var_189_11)

				if var_189_13 > 0 and var_189_7 < var_189_13 then
					arg_186_1.talkMaxDuration = var_189_13

					if var_189_13 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_6
					end
				end

				arg_186_1.text_.text = var_189_10
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051046", "story_v_out_116051.awb") ~= 0 then
					local var_189_14 = manager.audio:GetVoiceLength("story_v_out_116051", "116051046", "story_v_out_116051.awb") / 1000

					if var_189_14 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_14 + var_189_6
					end

					if var_189_9.prefab_name ~= "" and arg_186_1.actors_[var_189_9.prefab_name] ~= nil then
						local var_189_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_9.prefab_name].transform, "story_v_out_116051", "116051046", "story_v_out_116051.awb")

						arg_186_1:RecordAudio("116051046", var_189_15)
						arg_186_1:RecordAudio("116051046", var_189_15)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_116051", "116051046", "story_v_out_116051.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_116051", "116051046", "story_v_out_116051.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_7, arg_186_1.talkMaxDuration)

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_6) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_6 + var_189_16 and arg_186_1.time_ < var_189_6 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play116051047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 116051047
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play116051048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["10025ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect10025ui_story == nil then
				arg_190_1.var_.characterEffect10025ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect10025ui_story and not isNil(var_193_0) then
					local var_193_4 = Mathf.Lerp(0, 0.5, var_193_3)

					arg_190_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10025ui_story.fillRatio = var_193_4
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect10025ui_story then
				local var_193_5 = 0.5

				arg_190_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10025ui_story.fillRatio = var_193_5
			end

			local var_193_6 = 0
			local var_193_7 = 0.05

			if var_193_6 < arg_190_1.time_ and arg_190_1.time_ <= var_193_6 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_8 = arg_190_1:FormatText(StoryNameCfg[7].name)

				arg_190_1.leftNameTxt_.text = var_193_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_9 = arg_190_1:GetWordFromCfg(116051047)
				local var_193_10 = arg_190_1:FormatText(var_193_9.content)

				arg_190_1.text_.text = var_193_10

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_11 = 2
				local var_193_12 = utf8.len(var_193_10)
				local var_193_13 = var_193_11 <= 0 and var_193_7 or var_193_7 * (var_193_12 / var_193_11)

				if var_193_13 > 0 and var_193_7 < var_193_13 then
					arg_190_1.talkMaxDuration = var_193_13

					if var_193_13 + var_193_6 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_13 + var_193_6
					end
				end

				arg_190_1.text_.text = var_193_10
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_14 = math.max(var_193_7, arg_190_1.talkMaxDuration)

			if var_193_6 <= arg_190_1.time_ and arg_190_1.time_ < var_193_6 + var_193_14 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_6) / var_193_14

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_6 + var_193_14 and arg_190_1.time_ < var_193_6 + var_193_14 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play116051048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 116051048
		arg_194_1.duration_ = 7.27

		local var_194_0 = {
			zh = 7.266,
			ja = 4.7
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play116051049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["10025ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect10025ui_story == nil then
				arg_194_1.var_.characterEffect10025ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.2

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect10025ui_story and not isNil(var_197_0) then
					arg_194_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect10025ui_story then
				arg_194_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_197_4 = 0

			if var_197_4 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_197_5 = 0

			if var_197_5 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_197_6 = 0
			local var_197_7 = 0.4

			if var_197_6 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_8 = arg_194_1:FormatText(StoryNameCfg[328].name)

				arg_194_1.leftNameTxt_.text = var_197_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_9 = arg_194_1:GetWordFromCfg(116051048)
				local var_197_10 = arg_194_1:FormatText(var_197_9.content)

				arg_194_1.text_.text = var_197_10

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_11 = 16
				local var_197_12 = utf8.len(var_197_10)
				local var_197_13 = var_197_11 <= 0 and var_197_7 or var_197_7 * (var_197_12 / var_197_11)

				if var_197_13 > 0 and var_197_7 < var_197_13 then
					arg_194_1.talkMaxDuration = var_197_13

					if var_197_13 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_6
					end
				end

				arg_194_1.text_.text = var_197_10
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116051", "116051048", "story_v_out_116051.awb") ~= 0 then
					local var_197_14 = manager.audio:GetVoiceLength("story_v_out_116051", "116051048", "story_v_out_116051.awb") / 1000

					if var_197_14 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_6
					end

					if var_197_9.prefab_name ~= "" and arg_194_1.actors_[var_197_9.prefab_name] ~= nil then
						local var_197_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_9.prefab_name].transform, "story_v_out_116051", "116051048", "story_v_out_116051.awb")

						arg_194_1:RecordAudio("116051048", var_197_15)
						arg_194_1:RecordAudio("116051048", var_197_15)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_116051", "116051048", "story_v_out_116051.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_116051", "116051048", "story_v_out_116051.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_16 = math.max(var_197_7, arg_194_1.talkMaxDuration)

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_16 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_6) / var_197_16

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_6 + var_197_16 and arg_194_1.time_ < var_197_6 + var_197_16 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play116051049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 116051049
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play116051050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["10025ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos10025ui_story = var_201_0.localPosition
			end

			local var_201_2 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2
				local var_201_4 = Vector3.New(0, 100, 0)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10025ui_story, var_201_4, var_201_3)

				local var_201_5 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_5.x, var_201_5.y, var_201_5.z)

				local var_201_6 = var_201_0.localEulerAngles

				var_201_6.z = 0
				var_201_6.x = 0
				var_201_0.localEulerAngles = var_201_6
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0, 100, 0)

				local var_201_7 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_7.x, var_201_7.y, var_201_7.z)

				local var_201_8 = var_201_0.localEulerAngles

				var_201_8.z = 0
				var_201_8.x = 0
				var_201_0.localEulerAngles = var_201_8
			end

			local var_201_9 = 0
			local var_201_10 = 0.8

			if var_201_9 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_11 = arg_198_1:GetWordFromCfg(116051049)
				local var_201_12 = arg_198_1:FormatText(var_201_11.content)

				arg_198_1.text_.text = var_201_12

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_13 = 32
				local var_201_14 = utf8.len(var_201_12)
				local var_201_15 = var_201_13 <= 0 and var_201_10 or var_201_10 * (var_201_14 / var_201_13)

				if var_201_15 > 0 and var_201_10 < var_201_15 then
					arg_198_1.talkMaxDuration = var_201_15

					if var_201_15 + var_201_9 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_15 + var_201_9
					end
				end

				arg_198_1.text_.text = var_201_12
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_10, arg_198_1.talkMaxDuration)

			if var_201_9 <= arg_198_1.time_ and arg_198_1.time_ < var_201_9 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_9) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_9 + var_201_16 and arg_198_1.time_ < var_201_9 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play116051050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 116051050
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
			arg_202_1.auto_ = false
		end

		function arg_202_1.playNext_(arg_204_0)
			arg_202_1.onStoryFinished_()
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = manager.ui.mainCamera.transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.shakeOldPos = var_205_0.localPosition
			end

			local var_205_2 = 0.6

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / 0.066
				local var_205_4, var_205_5 = math.modf(var_205_3)

				var_205_0.localPosition = Vector3.New(var_205_5 * 0.13, var_205_5 * 0.13, var_205_5 * 0.13) + arg_202_1.var_.shakeOldPos
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 then
				var_205_0.localPosition = arg_202_1.var_.shakeOldPos
			end

			local var_205_6 = 0

			if var_205_6 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.allBtn_.enabled = false
			end

			local var_205_7 = 0.6

			if arg_202_1.time_ >= var_205_6 + var_205_7 and arg_202_1.time_ < var_205_6 + var_205_7 + arg_205_0 then
				arg_202_1.allBtn_.enabled = true
			end

			local var_205_8 = 0
			local var_205_9 = 0.125

			if var_205_8 < arg_202_1.time_ and arg_202_1.time_ <= var_205_8 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_10 = arg_202_1:FormatText(StoryNameCfg[7].name)

				arg_202_1.leftNameTxt_.text = var_205_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_11 = arg_202_1:GetWordFromCfg(116051050)
				local var_205_12 = arg_202_1:FormatText(var_205_11.content)

				arg_202_1.text_.text = var_205_12

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_13 = 5
				local var_205_14 = utf8.len(var_205_12)
				local var_205_15 = var_205_13 <= 0 and var_205_9 or var_205_9 * (var_205_14 / var_205_13)

				if var_205_15 > 0 and var_205_9 < var_205_15 then
					arg_202_1.talkMaxDuration = var_205_15

					if var_205_15 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_15 + var_205_8
					end
				end

				arg_202_1.text_.text = var_205_12
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_16 = math.max(var_205_9, arg_202_1.talkMaxDuration)

			if var_205_8 <= arg_202_1.time_ and arg_202_1.time_ < var_205_8 + var_205_16 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_8) / var_205_16

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_8 + var_205_16 and arg_202_1.time_ < var_205_8 + var_205_16 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/ST18a"
	},
	voices = {
		"story_v_out_116051.awb"
	}
}
