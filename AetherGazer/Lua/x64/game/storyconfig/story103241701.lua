return {
	Play324171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324171001
		arg_1_1.duration_ = 6.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J15"

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
				local var_4_5 = arg_1_1.bgs_.J15

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
					if iter_4_0 ~= "J15" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_150", "se_story_150_amb_painting", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_32 = 1
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 1.4
			local var_4_39 = 1.025

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(324171001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 41
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324171002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324171002
		arg_8_1.duration_ = 2

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324171003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1053ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1053ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1053ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1053ui_story = var_11_5.localPosition

				local var_11_7 = GameObjectTools.GetOrAddComponent(var_11_5.gameObject, typeof(DynamicBoneHelper))

				if var_11_7 then
					var_11_7:EnableDynamicBone(false)
				end
			end

			local var_11_8 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_8 then
				local var_11_9 = (arg_8_1.time_ - var_11_6) / var_11_8
				local var_11_10 = Vector3.New(0, -1.08, -6)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1053ui_story, var_11_10, var_11_9)

				local var_11_11 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_11.x, var_11_11.y, var_11_11.z)

				local var_11_12 = var_11_5.localEulerAngles

				var_11_12.z = 0
				var_11_12.x = 0
				var_11_5.localEulerAngles = var_11_12
			end

			if arg_8_1.time_ >= var_11_6 + var_11_8 and arg_8_1.time_ < var_11_6 + var_11_8 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -1.08, -6)

				local var_11_13 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_13.x, var_11_13.y, var_11_13.z)

				local var_11_14 = var_11_5.localEulerAngles

				var_11_14.z = 0
				var_11_14.x = 0
				var_11_5.localEulerAngles = var_11_14

				local var_11_15 = GameObjectTools.GetOrAddComponent(var_11_5.gameObject, typeof(DynamicBoneHelper))

				if var_11_15 then
					var_11_15:EnableDynamicBone(true)
				end
			end

			local var_11_16 = arg_8_1.actors_["1053ui_story"]
			local var_11_17 = 0

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1053ui_story == nil then
				arg_8_1.var_.characterEffect1053ui_story = var_11_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_18 = 0.200000002980232

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_18 and not isNil(var_11_16) then
				local var_11_19 = (arg_8_1.time_ - var_11_17) / var_11_18

				if arg_8_1.var_.characterEffect1053ui_story and not isNil(var_11_16) then
					arg_8_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_17 + var_11_18 and arg_8_1.time_ < var_11_17 + var_11_18 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1053ui_story then
				arg_8_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_11_20 = 0

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_11_21 = 0

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_11_22 = 0
			local var_11_23 = 0.075

			if var_11_22 < arg_8_1.time_ and arg_8_1.time_ <= var_11_22 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_24 = arg_8_1:FormatText(StoryNameCfg[472].name)

				arg_8_1.leftNameTxt_.text = var_11_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_25 = arg_8_1:GetWordFromCfg(324171002)
				local var_11_26 = arg_8_1:FormatText(var_11_25.content)

				arg_8_1.text_.text = var_11_26

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_27 = 3
				local var_11_28 = utf8.len(var_11_26)
				local var_11_29 = var_11_27 <= 0 and var_11_23 or var_11_23 * (var_11_28 / var_11_27)

				if var_11_29 > 0 and var_11_23 < var_11_29 then
					arg_8_1.talkMaxDuration = var_11_29

					if var_11_29 + var_11_22 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_29 + var_11_22
					end
				end

				arg_8_1.text_.text = var_11_26
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171002", "story_v_out_324171.awb") ~= 0 then
					local var_11_30 = manager.audio:GetVoiceLength("story_v_out_324171", "324171002", "story_v_out_324171.awb") / 1000

					if var_11_30 + var_11_22 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_30 + var_11_22
					end

					if var_11_25.prefab_name ~= "" and arg_8_1.actors_[var_11_25.prefab_name] ~= nil then
						local var_11_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_25.prefab_name].transform, "story_v_out_324171", "324171002", "story_v_out_324171.awb")

						arg_8_1:RecordAudio("324171002", var_11_31)
						arg_8_1:RecordAudio("324171002", var_11_31)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324171", "324171002", "story_v_out_324171.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324171", "324171002", "story_v_out_324171.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_32 = math.max(var_11_23, arg_8_1.talkMaxDuration)

			if var_11_22 <= arg_8_1.time_ and arg_8_1.time_ < var_11_22 + var_11_32 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_22) / var_11_32

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_22 + var_11_32 and arg_8_1.time_ < var_11_22 + var_11_32 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play324171003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324171003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324171004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1053ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1053ui_story == nil then
				arg_12_1.var_.characterEffect1053ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1053ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1053ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1053ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1053ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.5

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

				local var_15_8 = arg_12_1:GetWordFromCfg(324171003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 20
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
	Play324171004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324171004
		arg_16_1.duration_ = 2

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324171005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1170ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1170ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1170ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1170ui_story = var_19_5.localPosition

				local var_19_7 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_7 then
					var_19_7:EnableDynamicBone(false)
				end
			end

			local var_19_8 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_6) / var_19_8
				local var_19_10 = Vector3.New(-0.68, -0.95, -6.08)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1170ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_5.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_5.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_6 + var_19_8 and arg_16_1.time_ < var_19_6 + var_19_8 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(-0.68, -0.95, -6.08)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_5.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_5.localEulerAngles = var_19_14

				local var_19_15 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_15 then
					var_19_15:EnableDynamicBone(true)
				end
			end

			local var_19_16 = arg_16_1.actors_["1053ui_story"].transform
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.var_.moveOldPos1053ui_story = var_19_16.localPosition

				local var_19_18 = GameObjectTools.GetOrAddComponent(var_19_16.gameObject, typeof(DynamicBoneHelper))

				if var_19_18 then
					var_19_18:EnableDynamicBone(false)
				end
			end

			local var_19_19 = 0.001

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_19 then
				local var_19_20 = (arg_16_1.time_ - var_19_17) / var_19_19
				local var_19_21 = Vector3.New(0.7, -1.08, -6)

				var_19_16.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1053ui_story, var_19_21, var_19_20)

				local var_19_22 = manager.ui.mainCamera.transform.position - var_19_16.position

				var_19_16.forward = Vector3.New(var_19_22.x, var_19_22.y, var_19_22.z)

				local var_19_23 = var_19_16.localEulerAngles

				var_19_23.z = 0
				var_19_23.x = 0
				var_19_16.localEulerAngles = var_19_23
			end

			if arg_16_1.time_ >= var_19_17 + var_19_19 and arg_16_1.time_ < var_19_17 + var_19_19 + arg_19_0 then
				var_19_16.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_19_24 = manager.ui.mainCamera.transform.position - var_19_16.position

				var_19_16.forward = Vector3.New(var_19_24.x, var_19_24.y, var_19_24.z)

				local var_19_25 = var_19_16.localEulerAngles

				var_19_25.z = 0
				var_19_25.x = 0
				var_19_16.localEulerAngles = var_19_25

				local var_19_26 = GameObjectTools.GetOrAddComponent(var_19_16.gameObject, typeof(DynamicBoneHelper))

				if var_19_26 then
					var_19_26:EnableDynamicBone(true)
				end
			end

			local var_19_27 = arg_16_1.actors_["1170ui_story"]
			local var_19_28 = 0

			if var_19_28 < arg_16_1.time_ and arg_16_1.time_ <= var_19_28 + arg_19_0 and not isNil(var_19_27) and arg_16_1.var_.characterEffect1170ui_story == nil then
				arg_16_1.var_.characterEffect1170ui_story = var_19_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_29 = 0.200000002980232

			if var_19_28 <= arg_16_1.time_ and arg_16_1.time_ < var_19_28 + var_19_29 and not isNil(var_19_27) then
				local var_19_30 = (arg_16_1.time_ - var_19_28) / var_19_29

				if arg_16_1.var_.characterEffect1170ui_story and not isNil(var_19_27) then
					arg_16_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_28 + var_19_29 and arg_16_1.time_ < var_19_28 + var_19_29 + arg_19_0 and not isNil(var_19_27) and arg_16_1.var_.characterEffect1170ui_story then
				arg_16_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_19_31 = 0

			if var_19_31 < arg_16_1.time_ and arg_16_1.time_ <= var_19_31 + arg_19_0 then
				arg_16_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action1_1")
			end

			local var_19_32 = 0

			if var_19_32 < arg_16_1.time_ and arg_16_1.time_ <= var_19_32 + arg_19_0 then
				arg_16_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_19_33 = 0
			local var_19_34 = 0.1

			if var_19_33 < arg_16_1.time_ and arg_16_1.time_ <= var_19_33 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_35 = arg_16_1:FormatText(StoryNameCfg[318].name)

				arg_16_1.leftNameTxt_.text = var_19_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_36 = arg_16_1:GetWordFromCfg(324171004)
				local var_19_37 = arg_16_1:FormatText(var_19_36.content)

				arg_16_1.text_.text = var_19_37

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_38 = 4
				local var_19_39 = utf8.len(var_19_37)
				local var_19_40 = var_19_38 <= 0 and var_19_34 or var_19_34 * (var_19_39 / var_19_38)

				if var_19_40 > 0 and var_19_34 < var_19_40 then
					arg_16_1.talkMaxDuration = var_19_40

					if var_19_40 + var_19_33 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_40 + var_19_33
					end
				end

				arg_16_1.text_.text = var_19_37
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171004", "story_v_out_324171.awb") ~= 0 then
					local var_19_41 = manager.audio:GetVoiceLength("story_v_out_324171", "324171004", "story_v_out_324171.awb") / 1000

					if var_19_41 + var_19_33 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_41 + var_19_33
					end

					if var_19_36.prefab_name ~= "" and arg_16_1.actors_[var_19_36.prefab_name] ~= nil then
						local var_19_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_36.prefab_name].transform, "story_v_out_324171", "324171004", "story_v_out_324171.awb")

						arg_16_1:RecordAudio("324171004", var_19_42)
						arg_16_1:RecordAudio("324171004", var_19_42)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324171", "324171004", "story_v_out_324171.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324171", "324171004", "story_v_out_324171.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_43 = math.max(var_19_34, arg_16_1.talkMaxDuration)

			if var_19_33 <= arg_16_1.time_ and arg_16_1.time_ < var_19_33 + var_19_43 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_33) / var_19_43

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_33 + var_19_43 and arg_16_1.time_ < var_19_33 + var_19_43 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play324171005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324171005
		arg_20_1.duration_ = 5.8

		local var_20_0 = {
			zh = 4.933,
			ja = 5.8
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
				arg_20_0:Play324171006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1053ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1053ui_story == nil then
				arg_20_1.var_.characterEffect1053ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1053ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1053ui_story then
				arg_20_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["1170ui_story"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1170ui_story == nil then
				arg_20_1.var_.characterEffect1170ui_story = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.200000002980232

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.characterEffect1170ui_story and not isNil(var_23_4) then
					local var_23_8 = Mathf.Lerp(0, 0.5, var_23_7)

					arg_20_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1170ui_story.fillRatio = var_23_8
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1170ui_story then
				local var_23_9 = 0.5

				arg_20_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1170ui_story.fillRatio = var_23_9
			end

			local var_23_10 = 0
			local var_23_11 = 0.425

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_12 = arg_20_1:FormatText(StoryNameCfg[472].name)

				arg_20_1.leftNameTxt_.text = var_23_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_13 = arg_20_1:GetWordFromCfg(324171005)
				local var_23_14 = arg_20_1:FormatText(var_23_13.content)

				arg_20_1.text_.text = var_23_14

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 17
				local var_23_16 = utf8.len(var_23_14)
				local var_23_17 = var_23_15 <= 0 and var_23_11 or var_23_11 * (var_23_16 / var_23_15)

				if var_23_17 > 0 and var_23_11 < var_23_17 then
					arg_20_1.talkMaxDuration = var_23_17

					if var_23_17 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_14
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171005", "story_v_out_324171.awb") ~= 0 then
					local var_23_18 = manager.audio:GetVoiceLength("story_v_out_324171", "324171005", "story_v_out_324171.awb") / 1000

					if var_23_18 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_10
					end

					if var_23_13.prefab_name ~= "" and arg_20_1.actors_[var_23_13.prefab_name] ~= nil then
						local var_23_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_13.prefab_name].transform, "story_v_out_324171", "324171005", "story_v_out_324171.awb")

						arg_20_1:RecordAudio("324171005", var_23_19)
						arg_20_1:RecordAudio("324171005", var_23_19)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324171", "324171005", "story_v_out_324171.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324171", "324171005", "story_v_out_324171.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_20 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_20 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_20

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_20 and arg_20_1.time_ < var_23_10 + var_23_20 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324171006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324171006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324171007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1053ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1053ui_story = var_27_0.localPosition

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end
			end

			local var_27_3 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_3 then
				local var_27_4 = (arg_24_1.time_ - var_27_1) / var_27_3
				local var_27_5 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1053ui_story, var_27_5, var_27_4)

				local var_27_6 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_6.x, var_27_6.y, var_27_6.z)

				local var_27_7 = var_27_0.localEulerAngles

				var_27_7.z = 0
				var_27_7.x = 0
				var_27_0.localEulerAngles = var_27_7
			end

			if arg_24_1.time_ >= var_27_1 + var_27_3 and arg_24_1.time_ < var_27_1 + var_27_3 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_8 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_8.x, var_27_8.y, var_27_8.z)

				local var_27_9 = var_27_0.localEulerAngles

				var_27_9.z = 0
				var_27_9.x = 0
				var_27_0.localEulerAngles = var_27_9

				local var_27_10 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_10 then
					var_27_10:EnableDynamicBone(true)
				end
			end

			local var_27_11 = arg_24_1.actors_["1170ui_story"].transform
			local var_27_12 = 0

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.var_.moveOldPos1170ui_story = var_27_11.localPosition

				local var_27_13 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_13 then
					var_27_13:EnableDynamicBone(false)
				end
			end

			local var_27_14 = 0.001

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_14 then
				local var_27_15 = (arg_24_1.time_ - var_27_12) / var_27_14
				local var_27_16 = Vector3.New(0, 100, 0)

				var_27_11.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1170ui_story, var_27_16, var_27_15)

				local var_27_17 = manager.ui.mainCamera.transform.position - var_27_11.position

				var_27_11.forward = Vector3.New(var_27_17.x, var_27_17.y, var_27_17.z)

				local var_27_18 = var_27_11.localEulerAngles

				var_27_18.z = 0
				var_27_18.x = 0
				var_27_11.localEulerAngles = var_27_18
			end

			if arg_24_1.time_ >= var_27_12 + var_27_14 and arg_24_1.time_ < var_27_12 + var_27_14 + arg_27_0 then
				var_27_11.localPosition = Vector3.New(0, 100, 0)

				local var_27_19 = manager.ui.mainCamera.transform.position - var_27_11.position

				var_27_11.forward = Vector3.New(var_27_19.x, var_27_19.y, var_27_19.z)

				local var_27_20 = var_27_11.localEulerAngles

				var_27_20.z = 0
				var_27_20.x = 0
				var_27_11.localEulerAngles = var_27_20

				local var_27_21 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_21 then
					var_27_21:EnableDynamicBone(true)
				end
			end

			local var_27_22 = arg_24_1.actors_["1053ui_story"]
			local var_27_23 = 0

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 and not isNil(var_27_22) and arg_24_1.var_.characterEffect1053ui_story == nil then
				arg_24_1.var_.characterEffect1053ui_story = var_27_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_24 = 0.200000002980232

			if var_27_23 <= arg_24_1.time_ and arg_24_1.time_ < var_27_23 + var_27_24 and not isNil(var_27_22) then
				local var_27_25 = (arg_24_1.time_ - var_27_23) / var_27_24

				if arg_24_1.var_.characterEffect1053ui_story and not isNil(var_27_22) then
					local var_27_26 = Mathf.Lerp(0, 0.5, var_27_25)

					arg_24_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1053ui_story.fillRatio = var_27_26
				end
			end

			if arg_24_1.time_ >= var_27_23 + var_27_24 and arg_24_1.time_ < var_27_23 + var_27_24 + arg_27_0 and not isNil(var_27_22) and arg_24_1.var_.characterEffect1053ui_story then
				local var_27_27 = 0.5

				arg_24_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1053ui_story.fillRatio = var_27_27
			end

			local var_27_28 = 0
			local var_27_29 = 1.05

			if var_27_28 < arg_24_1.time_ and arg_24_1.time_ <= var_27_28 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_30 = arg_24_1:GetWordFromCfg(324171006)
				local var_27_31 = arg_24_1:FormatText(var_27_30.content)

				arg_24_1.text_.text = var_27_31

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_32 = 42
				local var_27_33 = utf8.len(var_27_31)
				local var_27_34 = var_27_32 <= 0 and var_27_29 or var_27_29 * (var_27_33 / var_27_32)

				if var_27_34 > 0 and var_27_29 < var_27_34 then
					arg_24_1.talkMaxDuration = var_27_34

					if var_27_34 + var_27_28 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_34 + var_27_28
					end
				end

				arg_24_1.text_.text = var_27_31
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_35 = math.max(var_27_29, arg_24_1.talkMaxDuration)

			if var_27_28 <= arg_24_1.time_ and arg_24_1.time_ < var_27_28 + var_27_35 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_28) / var_27_35

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_28 + var_27_35 and arg_24_1.time_ < var_27_28 + var_27_35 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play324171007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324171007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324171008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1170ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1170ui_story = var_31_0.localPosition

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end
			end

			local var_31_3 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_3 then
				local var_31_4 = (arg_28_1.time_ - var_31_1) / var_31_3
				local var_31_5 = Vector3.New(-0.68, -0.95, -6.08)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1170ui_story, var_31_5, var_31_4)

				local var_31_6 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_6.x, var_31_6.y, var_31_6.z)

				local var_31_7 = var_31_0.localEulerAngles

				var_31_7.z = 0
				var_31_7.x = 0
				var_31_0.localEulerAngles = var_31_7
			end

			if arg_28_1.time_ >= var_31_1 + var_31_3 and arg_28_1.time_ < var_31_1 + var_31_3 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(-0.68, -0.95, -6.08)

				local var_31_8 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_8.x, var_31_8.y, var_31_8.z)

				local var_31_9 = var_31_0.localEulerAngles

				var_31_9.z = 0
				var_31_9.x = 0
				var_31_0.localEulerAngles = var_31_9

				local var_31_10 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_10 then
					var_31_10:EnableDynamicBone(true)
				end
			end

			local var_31_11 = arg_28_1.actors_["1170ui_story"]
			local var_31_12 = 0

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect1170ui_story == nil then
				arg_28_1.var_.characterEffect1170ui_story = var_31_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_13 = 0.200000002980232

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_13 and not isNil(var_31_11) then
				local var_31_14 = (arg_28_1.time_ - var_31_12) / var_31_13

				if arg_28_1.var_.characterEffect1170ui_story and not isNil(var_31_11) then
					arg_28_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_12 + var_31_13 and arg_28_1.time_ < var_31_12 + var_31_13 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect1170ui_story then
				arg_28_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_31_15 = 0

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_31_17 = 0
			local var_31_18 = 0.075

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_19 = arg_28_1:FormatText(StoryNameCfg[318].name)

				arg_28_1.leftNameTxt_.text = var_31_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_20 = arg_28_1:GetWordFromCfg(324171007)
				local var_31_21 = arg_28_1:FormatText(var_31_20.content)

				arg_28_1.text_.text = var_31_21

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_22 = 3
				local var_31_23 = utf8.len(var_31_21)
				local var_31_24 = var_31_22 <= 0 and var_31_18 or var_31_18 * (var_31_23 / var_31_22)

				if var_31_24 > 0 and var_31_18 < var_31_24 then
					arg_28_1.talkMaxDuration = var_31_24

					if var_31_24 + var_31_17 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_24 + var_31_17
					end
				end

				arg_28_1.text_.text = var_31_21
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171007", "story_v_out_324171.awb") ~= 0 then
					local var_31_25 = manager.audio:GetVoiceLength("story_v_out_324171", "324171007", "story_v_out_324171.awb") / 1000

					if var_31_25 + var_31_17 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_25 + var_31_17
					end

					if var_31_20.prefab_name ~= "" and arg_28_1.actors_[var_31_20.prefab_name] ~= nil then
						local var_31_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_20.prefab_name].transform, "story_v_out_324171", "324171007", "story_v_out_324171.awb")

						arg_28_1:RecordAudio("324171007", var_31_26)
						arg_28_1:RecordAudio("324171007", var_31_26)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324171", "324171007", "story_v_out_324171.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324171", "324171007", "story_v_out_324171.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_27 = math.max(var_31_18, arg_28_1.talkMaxDuration)

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_27 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_17) / var_31_27

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_17 + var_31_27 and arg_28_1.time_ < var_31_17 + var_31_27 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play324171008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324171008
		arg_32_1.duration_ = 7.53

		local var_32_0 = {
			zh = 3.833,
			ja = 7.533
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
				arg_32_0:Play324171009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1053ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1053ui_story = var_35_0.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_3 then
				local var_35_4 = (arg_32_1.time_ - var_35_1) / var_35_3
				local var_35_5 = Vector3.New(0.7, -1.08, -6)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1053ui_story, var_35_5, var_35_4)

				local var_35_6 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_6.x, var_35_6.y, var_35_6.z)

				local var_35_7 = var_35_0.localEulerAngles

				var_35_7.z = 0
				var_35_7.x = 0
				var_35_0.localEulerAngles = var_35_7
			end

			if arg_32_1.time_ >= var_35_1 + var_35_3 and arg_32_1.time_ < var_35_1 + var_35_3 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_35_8 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_8.x, var_35_8.y, var_35_8.z)

				local var_35_9 = var_35_0.localEulerAngles

				var_35_9.z = 0
				var_35_9.x = 0
				var_35_0.localEulerAngles = var_35_9

				local var_35_10 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_10 then
					var_35_10:EnableDynamicBone(true)
				end
			end

			local var_35_11 = arg_32_1.actors_["1053ui_story"]
			local var_35_12 = 0

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 and not isNil(var_35_11) and arg_32_1.var_.characterEffect1053ui_story == nil then
				arg_32_1.var_.characterEffect1053ui_story = var_35_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_13 = 0.200000002980232

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_13 and not isNil(var_35_11) then
				local var_35_14 = (arg_32_1.time_ - var_35_12) / var_35_13

				if arg_32_1.var_.characterEffect1053ui_story and not isNil(var_35_11) then
					arg_32_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_12 + var_35_13 and arg_32_1.time_ < var_35_12 + var_35_13 + arg_35_0 and not isNil(var_35_11) and arg_32_1.var_.characterEffect1053ui_story then
				arg_32_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_35_15 = arg_32_1.actors_["1170ui_story"]
			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 and not isNil(var_35_15) and arg_32_1.var_.characterEffect1170ui_story == nil then
				arg_32_1.var_.characterEffect1170ui_story = var_35_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_17 = 0.200000002980232

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_17 and not isNil(var_35_15) then
				local var_35_18 = (arg_32_1.time_ - var_35_16) / var_35_17

				if arg_32_1.var_.characterEffect1170ui_story and not isNil(var_35_15) then
					local var_35_19 = Mathf.Lerp(0, 0.5, var_35_18)

					arg_32_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1170ui_story.fillRatio = var_35_19
				end
			end

			if arg_32_1.time_ >= var_35_16 + var_35_17 and arg_32_1.time_ < var_35_16 + var_35_17 + arg_35_0 and not isNil(var_35_15) and arg_32_1.var_.characterEffect1170ui_story then
				local var_35_20 = 0.5

				arg_32_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1170ui_story.fillRatio = var_35_20
			end

			local var_35_21 = 0

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 then
				arg_32_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_1")
			end

			local var_35_22 = 0

			if var_35_22 < arg_32_1.time_ and arg_32_1.time_ <= var_35_22 + arg_35_0 then
				arg_32_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_35_23 = 0
			local var_35_24 = 0.475

			if var_35_23 < arg_32_1.time_ and arg_32_1.time_ <= var_35_23 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_25 = arg_32_1:FormatText(StoryNameCfg[472].name)

				arg_32_1.leftNameTxt_.text = var_35_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_26 = arg_32_1:GetWordFromCfg(324171008)
				local var_35_27 = arg_32_1:FormatText(var_35_26.content)

				arg_32_1.text_.text = var_35_27

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_28 = 19
				local var_35_29 = utf8.len(var_35_27)
				local var_35_30 = var_35_28 <= 0 and var_35_24 or var_35_24 * (var_35_29 / var_35_28)

				if var_35_30 > 0 and var_35_24 < var_35_30 then
					arg_32_1.talkMaxDuration = var_35_30

					if var_35_30 + var_35_23 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_30 + var_35_23
					end
				end

				arg_32_1.text_.text = var_35_27
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171008", "story_v_out_324171.awb") ~= 0 then
					local var_35_31 = manager.audio:GetVoiceLength("story_v_out_324171", "324171008", "story_v_out_324171.awb") / 1000

					if var_35_31 + var_35_23 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_31 + var_35_23
					end

					if var_35_26.prefab_name ~= "" and arg_32_1.actors_[var_35_26.prefab_name] ~= nil then
						local var_35_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_26.prefab_name].transform, "story_v_out_324171", "324171008", "story_v_out_324171.awb")

						arg_32_1:RecordAudio("324171008", var_35_32)
						arg_32_1:RecordAudio("324171008", var_35_32)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324171", "324171008", "story_v_out_324171.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324171", "324171008", "story_v_out_324171.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_33 = math.max(var_35_24, arg_32_1.talkMaxDuration)

			if var_35_23 <= arg_32_1.time_ and arg_32_1.time_ < var_35_23 + var_35_33 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_23) / var_35_33

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_23 + var_35_33 and arg_32_1.time_ < var_35_23 + var_35_33 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play324171009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324171009
		arg_36_1.duration_ = 7.13

		local var_36_0 = {
			zh = 7.133,
			ja = 6.9
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
				arg_36_0:Play324171010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1170ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1170ui_story == nil then
				arg_36_1.var_.characterEffect1170ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1170ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1170ui_story then
				arg_36_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1053ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1053ui_story == nil then
				arg_36_1.var_.characterEffect1053ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1053ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1053ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1053ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1053ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0
			local var_39_11 = 0.6

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_12 = arg_36_1:FormatText(StoryNameCfg[318].name)

				arg_36_1.leftNameTxt_.text = var_39_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_13 = arg_36_1:GetWordFromCfg(324171009)
				local var_39_14 = arg_36_1:FormatText(var_39_13.content)

				arg_36_1.text_.text = var_39_14

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171009", "story_v_out_324171.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_324171", "324171009", "story_v_out_324171.awb") / 1000

					if var_39_18 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_10
					end

					if var_39_13.prefab_name ~= "" and arg_36_1.actors_[var_39_13.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_13.prefab_name].transform, "story_v_out_324171", "324171009", "story_v_out_324171.awb")

						arg_36_1:RecordAudio("324171009", var_39_19)
						arg_36_1:RecordAudio("324171009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324171", "324171009", "story_v_out_324171.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324171", "324171009", "story_v_out_324171.awb")
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
	Play324171010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324171010
		arg_40_1.duration_ = 13.63

		local var_40_0 = {
			zh = 9.633,
			ja = 13.633
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
				arg_40_0:Play324171011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action432")
			end

			local var_43_1 = 0
			local var_43_2 = 0.975

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_3 = arg_40_1:FormatText(StoryNameCfg[318].name)

				arg_40_1.leftNameTxt_.text = var_43_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_4 = arg_40_1:GetWordFromCfg(324171010)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 39
				local var_43_7 = utf8.len(var_43_5)
				local var_43_8 = var_43_6 <= 0 and var_43_2 or var_43_2 * (var_43_7 / var_43_6)

				if var_43_8 > 0 and var_43_2 < var_43_8 then
					arg_40_1.talkMaxDuration = var_43_8

					if var_43_8 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171010", "story_v_out_324171.awb") ~= 0 then
					local var_43_9 = manager.audio:GetVoiceLength("story_v_out_324171", "324171010", "story_v_out_324171.awb") / 1000

					if var_43_9 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_1
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_out_324171", "324171010", "story_v_out_324171.awb")

						arg_40_1:RecordAudio("324171010", var_43_10)
						arg_40_1:RecordAudio("324171010", var_43_10)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324171", "324171010", "story_v_out_324171.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324171", "324171010", "story_v_out_324171.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_11 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_11 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_11

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_11 and arg_40_1.time_ < var_43_1 + var_43_11 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324171011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324171011
		arg_44_1.duration_ = 5.8

		local var_44_0 = {
			zh = 3.666,
			ja = 5.8
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
				arg_44_0:Play324171012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1053ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1053ui_story == nil then
				arg_44_1.var_.characterEffect1053ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1053ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1053ui_story then
				arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1170ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1170ui_story == nil then
				arg_44_1.var_.characterEffect1170ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.200000002980232

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1170ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1170ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1170ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1170ui_story.fillRatio = var_47_9
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action425")
			end

			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_47_12 = 0
			local var_47_13 = 0.35

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[472].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(324171011)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 14
				local var_47_18 = utf8.len(var_47_16)
				local var_47_19 = var_47_17 <= 0 and var_47_13 or var_47_13 * (var_47_18 / var_47_17)

				if var_47_19 > 0 and var_47_13 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171011", "story_v_out_324171.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_324171", "324171011", "story_v_out_324171.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_324171", "324171011", "story_v_out_324171.awb")

						arg_44_1:RecordAudio("324171011", var_47_21)
						arg_44_1:RecordAudio("324171011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324171", "324171011", "story_v_out_324171.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324171", "324171011", "story_v_out_324171.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_22 and arg_44_1.time_ < var_47_12 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324171012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324171012
		arg_48_1.duration_ = 5.77

		local var_48_0 = {
			zh = 4,
			ja = 5.766
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
				arg_48_0:Play324171013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1170ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1170ui_story == nil then
				arg_48_1.var_.characterEffect1170ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1170ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1170ui_story then
				arg_48_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1053ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1053ui_story == nil then
				arg_48_1.var_.characterEffect1053ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1053ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1053ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1053ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1053ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0
			local var_51_11 = 0.4

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_12 = arg_48_1:FormatText(StoryNameCfg[318].name)

				arg_48_1.leftNameTxt_.text = var_51_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_13 = arg_48_1:GetWordFromCfg(324171012)
				local var_51_14 = arg_48_1:FormatText(var_51_13.content)

				arg_48_1.text_.text = var_51_14

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 16
				local var_51_16 = utf8.len(var_51_14)
				local var_51_17 = var_51_15 <= 0 and var_51_11 or var_51_11 * (var_51_16 / var_51_15)

				if var_51_17 > 0 and var_51_11 < var_51_17 then
					arg_48_1.talkMaxDuration = var_51_17

					if var_51_17 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_14
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171012", "story_v_out_324171.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_324171", "324171012", "story_v_out_324171.awb") / 1000

					if var_51_18 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_10
					end

					if var_51_13.prefab_name ~= "" and arg_48_1.actors_[var_51_13.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_13.prefab_name].transform, "story_v_out_324171", "324171012", "story_v_out_324171.awb")

						arg_48_1:RecordAudio("324171012", var_51_19)
						arg_48_1:RecordAudio("324171012", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324171", "324171012", "story_v_out_324171.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324171", "324171012", "story_v_out_324171.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_20 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_20 and arg_48_1.time_ < var_51_10 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play324171013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324171013
		arg_52_1.duration_ = 9.9

		local var_52_0 = {
			zh = 6.633,
			ja = 9.9
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
				arg_52_0:Play324171014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action2_2")
			end

			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_55_2 = 0
			local var_55_3 = 0.775

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_4 = arg_52_1:FormatText(StoryNameCfg[318].name)

				arg_52_1.leftNameTxt_.text = var_55_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_5 = arg_52_1:GetWordFromCfg(324171013)
				local var_55_6 = arg_52_1:FormatText(var_55_5.content)

				arg_52_1.text_.text = var_55_6

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 31
				local var_55_8 = utf8.len(var_55_6)
				local var_55_9 = var_55_7 <= 0 and var_55_3 or var_55_3 * (var_55_8 / var_55_7)

				if var_55_9 > 0 and var_55_3 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_6
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171013", "story_v_out_324171.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_324171", "324171013", "story_v_out_324171.awb") / 1000

					if var_55_10 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_2
					end

					if var_55_5.prefab_name ~= "" and arg_52_1.actors_[var_55_5.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_5.prefab_name].transform, "story_v_out_324171", "324171013", "story_v_out_324171.awb")

						arg_52_1:RecordAudio("324171013", var_55_11)
						arg_52_1:RecordAudio("324171013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324171", "324171013", "story_v_out_324171.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324171", "324171013", "story_v_out_324171.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_12 and arg_52_1.time_ < var_55_2 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324171014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324171014
		arg_56_1.duration_ = 2.43

		local var_56_0 = {
			zh = 1.999999999999,
			ja = 2.433
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
				arg_56_0:Play324171015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1053ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1053ui_story == nil then
				arg_56_1.var_.characterEffect1053ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1053ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1053ui_story then
				arg_56_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["1170ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1170ui_story == nil then
				arg_56_1.var_.characterEffect1170ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.200000002980232

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect1170ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1170ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1170ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1170ui_story.fillRatio = var_59_9
			end

			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_59_12 = 0
			local var_59_13 = 0.075

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_14 = arg_56_1:FormatText(StoryNameCfg[472].name)

				arg_56_1.leftNameTxt_.text = var_59_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_15 = arg_56_1:GetWordFromCfg(324171014)
				local var_59_16 = arg_56_1:FormatText(var_59_15.content)

				arg_56_1.text_.text = var_59_16

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_17 = 3
				local var_59_18 = utf8.len(var_59_16)
				local var_59_19 = var_59_17 <= 0 and var_59_13 or var_59_13 * (var_59_18 / var_59_17)

				if var_59_19 > 0 and var_59_13 < var_59_19 then
					arg_56_1.talkMaxDuration = var_59_19

					if var_59_19 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_19 + var_59_12
					end
				end

				arg_56_1.text_.text = var_59_16
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171014", "story_v_out_324171.awb") ~= 0 then
					local var_59_20 = manager.audio:GetVoiceLength("story_v_out_324171", "324171014", "story_v_out_324171.awb") / 1000

					if var_59_20 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_20 + var_59_12
					end

					if var_59_15.prefab_name ~= "" and arg_56_1.actors_[var_59_15.prefab_name] ~= nil then
						local var_59_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_15.prefab_name].transform, "story_v_out_324171", "324171014", "story_v_out_324171.awb")

						arg_56_1:RecordAudio("324171014", var_59_21)
						arg_56_1:RecordAudio("324171014", var_59_21)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324171", "324171014", "story_v_out_324171.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324171", "324171014", "story_v_out_324171.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_22 = math.max(var_59_13, arg_56_1.talkMaxDuration)

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_22 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_12) / var_59_22

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_12 + var_59_22 and arg_56_1.time_ < var_59_12 + var_59_22 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324171015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324171015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play324171016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1053ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1053ui_story = var_63_0.localPosition

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end
			end

			local var_63_3 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_3 then
				local var_63_4 = (arg_60_1.time_ - var_63_1) / var_63_3
				local var_63_5 = Vector3.New(0, 100, 0)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1053ui_story, var_63_5, var_63_4)

				local var_63_6 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_6.x, var_63_6.y, var_63_6.z)

				local var_63_7 = var_63_0.localEulerAngles

				var_63_7.z = 0
				var_63_7.x = 0
				var_63_0.localEulerAngles = var_63_7
			end

			if arg_60_1.time_ >= var_63_1 + var_63_3 and arg_60_1.time_ < var_63_1 + var_63_3 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, 100, 0)

				local var_63_8 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_8.x, var_63_8.y, var_63_8.z)

				local var_63_9 = var_63_0.localEulerAngles

				var_63_9.z = 0
				var_63_9.x = 0
				var_63_0.localEulerAngles = var_63_9

				local var_63_10 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_10 then
					var_63_10:EnableDynamicBone(true)
				end
			end

			local var_63_11 = arg_60_1.actors_["1170ui_story"].transform
			local var_63_12 = 0

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.var_.moveOldPos1170ui_story = var_63_11.localPosition

				local var_63_13 = GameObjectTools.GetOrAddComponent(var_63_11.gameObject, typeof(DynamicBoneHelper))

				if var_63_13 then
					var_63_13:EnableDynamicBone(false)
				end
			end

			local var_63_14 = 0.001

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_14 then
				local var_63_15 = (arg_60_1.time_ - var_63_12) / var_63_14
				local var_63_16 = Vector3.New(0, 100, 0)

				var_63_11.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1170ui_story, var_63_16, var_63_15)

				local var_63_17 = manager.ui.mainCamera.transform.position - var_63_11.position

				var_63_11.forward = Vector3.New(var_63_17.x, var_63_17.y, var_63_17.z)

				local var_63_18 = var_63_11.localEulerAngles

				var_63_18.z = 0
				var_63_18.x = 0
				var_63_11.localEulerAngles = var_63_18
			end

			if arg_60_1.time_ >= var_63_12 + var_63_14 and arg_60_1.time_ < var_63_12 + var_63_14 + arg_63_0 then
				var_63_11.localPosition = Vector3.New(0, 100, 0)

				local var_63_19 = manager.ui.mainCamera.transform.position - var_63_11.position

				var_63_11.forward = Vector3.New(var_63_19.x, var_63_19.y, var_63_19.z)

				local var_63_20 = var_63_11.localEulerAngles

				var_63_20.z = 0
				var_63_20.x = 0
				var_63_11.localEulerAngles = var_63_20

				local var_63_21 = GameObjectTools.GetOrAddComponent(var_63_11.gameObject, typeof(DynamicBoneHelper))

				if var_63_21 then
					var_63_21:EnableDynamicBone(true)
				end
			end

			local var_63_22 = arg_60_1.actors_["1053ui_story"]
			local var_63_23 = 0

			if var_63_23 < arg_60_1.time_ and arg_60_1.time_ <= var_63_23 + arg_63_0 and not isNil(var_63_22) and arg_60_1.var_.characterEffect1053ui_story == nil then
				arg_60_1.var_.characterEffect1053ui_story = var_63_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_24 = 0.200000002980232

			if var_63_23 <= arg_60_1.time_ and arg_60_1.time_ < var_63_23 + var_63_24 and not isNil(var_63_22) then
				local var_63_25 = (arg_60_1.time_ - var_63_23) / var_63_24

				if arg_60_1.var_.characterEffect1053ui_story and not isNil(var_63_22) then
					local var_63_26 = Mathf.Lerp(0, 0.5, var_63_25)

					arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1053ui_story.fillRatio = var_63_26
				end
			end

			if arg_60_1.time_ >= var_63_23 + var_63_24 and arg_60_1.time_ < var_63_23 + var_63_24 + arg_63_0 and not isNil(var_63_22) and arg_60_1.var_.characterEffect1053ui_story then
				local var_63_27 = 0.5

				arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1053ui_story.fillRatio = var_63_27
			end

			local var_63_28 = 1
			local var_63_29 = 1

			if var_63_28 < arg_60_1.time_ and arg_60_1.time_ <= var_63_28 + arg_63_0 then
				local var_63_30 = "play"
				local var_63_31 = "effect"

				arg_60_1:AudioAction(var_63_30, var_63_31, "se_story_side_1034", "se_story_side_1034_clap", "")
			end

			local var_63_32 = 0
			local var_63_33 = 1.025

			if var_63_32 < arg_60_1.time_ and arg_60_1.time_ <= var_63_32 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_34 = arg_60_1:GetWordFromCfg(324171015)
				local var_63_35 = arg_60_1:FormatText(var_63_34.content)

				arg_60_1.text_.text = var_63_35

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_36 = 41
				local var_63_37 = utf8.len(var_63_35)
				local var_63_38 = var_63_36 <= 0 and var_63_33 or var_63_33 * (var_63_37 / var_63_36)

				if var_63_38 > 0 and var_63_33 < var_63_38 then
					arg_60_1.talkMaxDuration = var_63_38

					if var_63_38 + var_63_32 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_38 + var_63_32
					end
				end

				arg_60_1.text_.text = var_63_35
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_39 = math.max(var_63_33, arg_60_1.talkMaxDuration)

			if var_63_32 <= arg_60_1.time_ and arg_60_1.time_ < var_63_32 + var_63_39 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_32) / var_63_39

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_32 + var_63_39 and arg_60_1.time_ < var_63_32 + var_63_39 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play324171016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324171016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324171017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.6

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(324171016)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 24
				local var_67_5 = utf8.len(var_67_3)
				local var_67_6 = var_67_4 <= 0 and var_67_1 or var_67_1 * (var_67_5 / var_67_4)

				if var_67_6 > 0 and var_67_1 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_7 and arg_64_1.time_ < var_67_0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play324171017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324171017
		arg_68_1.duration_ = 11.4

		local var_68_0 = {
			zh = 8.033,
			ja = 11.4
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
				arg_68_0:Play324171018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1053ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1053ui_story = var_71_0.localPosition

				local var_71_2 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(false)
				end
			end

			local var_71_3 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_3 then
				local var_71_4 = (arg_68_1.time_ - var_71_1) / var_71_3
				local var_71_5 = Vector3.New(0, -1.08, -6)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1053ui_story, var_71_5, var_71_4)

				local var_71_6 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_6.x, var_71_6.y, var_71_6.z)

				local var_71_7 = var_71_0.localEulerAngles

				var_71_7.z = 0
				var_71_7.x = 0
				var_71_0.localEulerAngles = var_71_7
			end

			if arg_68_1.time_ >= var_71_1 + var_71_3 and arg_68_1.time_ < var_71_1 + var_71_3 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_71_8 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_8.x, var_71_8.y, var_71_8.z)

				local var_71_9 = var_71_0.localEulerAngles

				var_71_9.z = 0
				var_71_9.x = 0
				var_71_0.localEulerAngles = var_71_9

				local var_71_10 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_10 then
					var_71_10:EnableDynamicBone(true)
				end
			end

			local var_71_11 = arg_68_1.actors_["1053ui_story"]
			local var_71_12 = 0

			if var_71_12 < arg_68_1.time_ and arg_68_1.time_ <= var_71_12 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1053ui_story == nil then
				arg_68_1.var_.characterEffect1053ui_story = var_71_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_13 = 0.200000002980232

			if var_71_12 <= arg_68_1.time_ and arg_68_1.time_ < var_71_12 + var_71_13 and not isNil(var_71_11) then
				local var_71_14 = (arg_68_1.time_ - var_71_12) / var_71_13

				if arg_68_1.var_.characterEffect1053ui_story and not isNil(var_71_11) then
					arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_12 + var_71_13 and arg_68_1.time_ < var_71_12 + var_71_13 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1053ui_story then
				arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_71_15 = 0

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_71_17 = 0
			local var_71_18 = 0.725

			if var_71_17 < arg_68_1.time_ and arg_68_1.time_ <= var_71_17 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_19 = arg_68_1:FormatText(StoryNameCfg[472].name)

				arg_68_1.leftNameTxt_.text = var_71_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_20 = arg_68_1:GetWordFromCfg(324171017)
				local var_71_21 = arg_68_1:FormatText(var_71_20.content)

				arg_68_1.text_.text = var_71_21

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_22 = 29
				local var_71_23 = utf8.len(var_71_21)
				local var_71_24 = var_71_22 <= 0 and var_71_18 or var_71_18 * (var_71_23 / var_71_22)

				if var_71_24 > 0 and var_71_18 < var_71_24 then
					arg_68_1.talkMaxDuration = var_71_24

					if var_71_24 + var_71_17 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_24 + var_71_17
					end
				end

				arg_68_1.text_.text = var_71_21
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171017", "story_v_out_324171.awb") ~= 0 then
					local var_71_25 = manager.audio:GetVoiceLength("story_v_out_324171", "324171017", "story_v_out_324171.awb") / 1000

					if var_71_25 + var_71_17 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_25 + var_71_17
					end

					if var_71_20.prefab_name ~= "" and arg_68_1.actors_[var_71_20.prefab_name] ~= nil then
						local var_71_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_20.prefab_name].transform, "story_v_out_324171", "324171017", "story_v_out_324171.awb")

						arg_68_1:RecordAudio("324171017", var_71_26)
						arg_68_1:RecordAudio("324171017", var_71_26)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324171", "324171017", "story_v_out_324171.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324171", "324171017", "story_v_out_324171.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_27 = math.max(var_71_18, arg_68_1.talkMaxDuration)

			if var_71_17 <= arg_68_1.time_ and arg_68_1.time_ < var_71_17 + var_71_27 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_17) / var_71_27

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_17 + var_71_27 and arg_68_1.time_ < var_71_17 + var_71_27 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play324171018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324171018
		arg_72_1.duration_ = 12.67

		local var_72_0 = {
			zh = 12.666,
			ja = 10.666
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324171019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 1.075

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[472].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(324171018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 43
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171018", "story_v_out_324171.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171018", "story_v_out_324171.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_324171", "324171018", "story_v_out_324171.awb")

						arg_72_1:RecordAudio("324171018", var_75_9)
						arg_72_1:RecordAudio("324171018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_324171", "324171018", "story_v_out_324171.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_324171", "324171018", "story_v_out_324171.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play324171019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324171019
		arg_76_1.duration_ = 4.53

		local var_76_0 = {
			zh = 3.366,
			ja = 4.533
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
				arg_76_0:Play324171020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.325

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[472].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_3 = arg_76_1:GetWordFromCfg(324171019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 13
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171019", "story_v_out_324171.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171019", "story_v_out_324171.awb") / 1000

					if var_79_8 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_0
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_324171", "324171019", "story_v_out_324171.awb")

						arg_76_1:RecordAudio("324171019", var_79_9)
						arg_76_1:RecordAudio("324171019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_324171", "324171019", "story_v_out_324171.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_324171", "324171019", "story_v_out_324171.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_10 and arg_76_1.time_ < var_79_0 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play324171020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324171020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play324171021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1053ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1053ui_story = var_83_0.localPosition

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_0.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end
			end

			local var_83_3 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_3 then
				local var_83_4 = (arg_80_1.time_ - var_83_1) / var_83_3
				local var_83_5 = Vector3.New(0, 100, 0)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1053ui_story, var_83_5, var_83_4)

				local var_83_6 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_6.x, var_83_6.y, var_83_6.z)

				local var_83_7 = var_83_0.localEulerAngles

				var_83_7.z = 0
				var_83_7.x = 0
				var_83_0.localEulerAngles = var_83_7
			end

			if arg_80_1.time_ >= var_83_1 + var_83_3 and arg_80_1.time_ < var_83_1 + var_83_3 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, 100, 0)

				local var_83_8 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_8.x, var_83_8.y, var_83_8.z)

				local var_83_9 = var_83_0.localEulerAngles

				var_83_9.z = 0
				var_83_9.x = 0
				var_83_0.localEulerAngles = var_83_9

				local var_83_10 = GameObjectTools.GetOrAddComponent(var_83_0.gameObject, typeof(DynamicBoneHelper))

				if var_83_10 then
					var_83_10:EnableDynamicBone(true)
				end
			end

			local var_83_11 = arg_80_1.actors_["1053ui_story"]
			local var_83_12 = 0

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 and not isNil(var_83_11) and arg_80_1.var_.characterEffect1053ui_story == nil then
				arg_80_1.var_.characterEffect1053ui_story = var_83_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_13 = 0.200000002980232

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_13 and not isNil(var_83_11) then
				local var_83_14 = (arg_80_1.time_ - var_83_12) / var_83_13

				if arg_80_1.var_.characterEffect1053ui_story and not isNil(var_83_11) then
					local var_83_15 = Mathf.Lerp(0, 0.5, var_83_14)

					arg_80_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1053ui_story.fillRatio = var_83_15
				end
			end

			if arg_80_1.time_ >= var_83_12 + var_83_13 and arg_80_1.time_ < var_83_12 + var_83_13 + arg_83_0 and not isNil(var_83_11) and arg_80_1.var_.characterEffect1053ui_story then
				local var_83_16 = 0.5

				arg_80_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1053ui_story.fillRatio = var_83_16
			end

			local var_83_17 = 0
			local var_83_18 = 0.9

			if var_83_17 < arg_80_1.time_ and arg_80_1.time_ <= var_83_17 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_19 = arg_80_1:GetWordFromCfg(324171020)
				local var_83_20 = arg_80_1:FormatText(var_83_19.content)

				arg_80_1.text_.text = var_83_20

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_21 = 36
				local var_83_22 = utf8.len(var_83_20)
				local var_83_23 = var_83_21 <= 0 and var_83_18 or var_83_18 * (var_83_22 / var_83_21)

				if var_83_23 > 0 and var_83_18 < var_83_23 then
					arg_80_1.talkMaxDuration = var_83_23

					if var_83_23 + var_83_17 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_23 + var_83_17
					end
				end

				arg_80_1.text_.text = var_83_20
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_24 = math.max(var_83_18, arg_80_1.talkMaxDuration)

			if var_83_17 <= arg_80_1.time_ and arg_80_1.time_ < var_83_17 + var_83_24 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_17) / var_83_24

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_17 + var_83_24 and arg_80_1.time_ < var_83_17 + var_83_24 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play324171021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324171021
		arg_84_1.duration_ = 7.03

		local var_84_0 = {
			zh = 4.833,
			ja = 7.033
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
				arg_84_0:Play324171022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1053ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1053ui_story = var_87_0.localPosition

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end
			end

			local var_87_3 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_3 then
				local var_87_4 = (arg_84_1.time_ - var_87_1) / var_87_3
				local var_87_5 = Vector3.New(0, -1.08, -6)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1053ui_story, var_87_5, var_87_4)

				local var_87_6 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_6.x, var_87_6.y, var_87_6.z)

				local var_87_7 = var_87_0.localEulerAngles

				var_87_7.z = 0
				var_87_7.x = 0
				var_87_0.localEulerAngles = var_87_7
			end

			if arg_84_1.time_ >= var_87_1 + var_87_3 and arg_84_1.time_ < var_87_1 + var_87_3 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_87_8 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_8.x, var_87_8.y, var_87_8.z)

				local var_87_9 = var_87_0.localEulerAngles

				var_87_9.z = 0
				var_87_9.x = 0
				var_87_0.localEulerAngles = var_87_9

				local var_87_10 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_10 then
					var_87_10:EnableDynamicBone(true)
				end
			end

			local var_87_11 = arg_84_1.actors_["1053ui_story"]
			local var_87_12 = 0

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 and not isNil(var_87_11) and arg_84_1.var_.characterEffect1053ui_story == nil then
				arg_84_1.var_.characterEffect1053ui_story = var_87_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_13 = 0.200000002980232

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_13 and not isNil(var_87_11) then
				local var_87_14 = (arg_84_1.time_ - var_87_12) / var_87_13

				if arg_84_1.var_.characterEffect1053ui_story and not isNil(var_87_11) then
					arg_84_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_12 + var_87_13 and arg_84_1.time_ < var_87_12 + var_87_13 + arg_87_0 and not isNil(var_87_11) and arg_84_1.var_.characterEffect1053ui_story then
				arg_84_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_87_15 = 0

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action465")
			end

			local var_87_16 = 0

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 then
				arg_84_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_87_17 = 0
			local var_87_18 = 0.6

			if var_87_17 < arg_84_1.time_ and arg_84_1.time_ <= var_87_17 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_19 = arg_84_1:FormatText(StoryNameCfg[472].name)

				arg_84_1.leftNameTxt_.text = var_87_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_20 = arg_84_1:GetWordFromCfg(324171021)
				local var_87_21 = arg_84_1:FormatText(var_87_20.content)

				arg_84_1.text_.text = var_87_21

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_22 = 24
				local var_87_23 = utf8.len(var_87_21)
				local var_87_24 = var_87_22 <= 0 and var_87_18 or var_87_18 * (var_87_23 / var_87_22)

				if var_87_24 > 0 and var_87_18 < var_87_24 then
					arg_84_1.talkMaxDuration = var_87_24

					if var_87_24 + var_87_17 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_24 + var_87_17
					end
				end

				arg_84_1.text_.text = var_87_21
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171021", "story_v_out_324171.awb") ~= 0 then
					local var_87_25 = manager.audio:GetVoiceLength("story_v_out_324171", "324171021", "story_v_out_324171.awb") / 1000

					if var_87_25 + var_87_17 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_25 + var_87_17
					end

					if var_87_20.prefab_name ~= "" and arg_84_1.actors_[var_87_20.prefab_name] ~= nil then
						local var_87_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_20.prefab_name].transform, "story_v_out_324171", "324171021", "story_v_out_324171.awb")

						arg_84_1:RecordAudio("324171021", var_87_26)
						arg_84_1:RecordAudio("324171021", var_87_26)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324171", "324171021", "story_v_out_324171.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324171", "324171021", "story_v_out_324171.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_27 = math.max(var_87_18, arg_84_1.talkMaxDuration)

			if var_87_17 <= arg_84_1.time_ and arg_84_1.time_ < var_87_17 + var_87_27 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_17) / var_87_27

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_17 + var_87_27 and arg_84_1.time_ < var_87_17 + var_87_27 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play324171022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324171022
		arg_88_1.duration_ = 3.97

		local var_88_0 = {
			zh = 3,
			ja = 3.966
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play324171023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1170ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1170ui_story = var_91_0.localPosition

				local var_91_2 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(false)
				end
			end

			local var_91_3 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_3 then
				local var_91_4 = (arg_88_1.time_ - var_91_1) / var_91_3
				local var_91_5 = Vector3.New(-0.68, -0.95, -6.08)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1170ui_story, var_91_5, var_91_4)

				local var_91_6 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_6.x, var_91_6.y, var_91_6.z)

				local var_91_7 = var_91_0.localEulerAngles

				var_91_7.z = 0
				var_91_7.x = 0
				var_91_0.localEulerAngles = var_91_7
			end

			if arg_88_1.time_ >= var_91_1 + var_91_3 and arg_88_1.time_ < var_91_1 + var_91_3 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(-0.68, -0.95, -6.08)

				local var_91_8 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_8.x, var_91_8.y, var_91_8.z)

				local var_91_9 = var_91_0.localEulerAngles

				var_91_9.z = 0
				var_91_9.x = 0
				var_91_0.localEulerAngles = var_91_9

				local var_91_10 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_10 then
					var_91_10:EnableDynamicBone(true)
				end
			end

			local var_91_11 = arg_88_1.actors_["1053ui_story"].transform
			local var_91_12 = 0

			if var_91_12 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 then
				arg_88_1.var_.moveOldPos1053ui_story = var_91_11.localPosition

				local var_91_13 = GameObjectTools.GetOrAddComponent(var_91_11.gameObject, typeof(DynamicBoneHelper))

				if var_91_13 then
					var_91_13:EnableDynamicBone(false)
				end
			end

			local var_91_14 = 0.001

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_14 then
				local var_91_15 = (arg_88_1.time_ - var_91_12) / var_91_14
				local var_91_16 = Vector3.New(0.7, -1.08, -6)

				var_91_11.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1053ui_story, var_91_16, var_91_15)

				local var_91_17 = manager.ui.mainCamera.transform.position - var_91_11.position

				var_91_11.forward = Vector3.New(var_91_17.x, var_91_17.y, var_91_17.z)

				local var_91_18 = var_91_11.localEulerAngles

				var_91_18.z = 0
				var_91_18.x = 0
				var_91_11.localEulerAngles = var_91_18
			end

			if arg_88_1.time_ >= var_91_12 + var_91_14 and arg_88_1.time_ < var_91_12 + var_91_14 + arg_91_0 then
				var_91_11.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_91_19 = manager.ui.mainCamera.transform.position - var_91_11.position

				var_91_11.forward = Vector3.New(var_91_19.x, var_91_19.y, var_91_19.z)

				local var_91_20 = var_91_11.localEulerAngles

				var_91_20.z = 0
				var_91_20.x = 0
				var_91_11.localEulerAngles = var_91_20

				local var_91_21 = GameObjectTools.GetOrAddComponent(var_91_11.gameObject, typeof(DynamicBoneHelper))

				if var_91_21 then
					var_91_21:EnableDynamicBone(true)
				end
			end

			local var_91_22 = arg_88_1.actors_["1170ui_story"]
			local var_91_23 = 0

			if var_91_23 < arg_88_1.time_ and arg_88_1.time_ <= var_91_23 + arg_91_0 and not isNil(var_91_22) and arg_88_1.var_.characterEffect1170ui_story == nil then
				arg_88_1.var_.characterEffect1170ui_story = var_91_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_24 = 0.200000002980232

			if var_91_23 <= arg_88_1.time_ and arg_88_1.time_ < var_91_23 + var_91_24 and not isNil(var_91_22) then
				local var_91_25 = (arg_88_1.time_ - var_91_23) / var_91_24

				if arg_88_1.var_.characterEffect1170ui_story and not isNil(var_91_22) then
					arg_88_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_23 + var_91_24 and arg_88_1.time_ < var_91_23 + var_91_24 + arg_91_0 and not isNil(var_91_22) and arg_88_1.var_.characterEffect1170ui_story then
				arg_88_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_91_26 = arg_88_1.actors_["1053ui_story"]
			local var_91_27 = 0

			if var_91_27 < arg_88_1.time_ and arg_88_1.time_ <= var_91_27 + arg_91_0 and not isNil(var_91_26) and arg_88_1.var_.characterEffect1053ui_story == nil then
				arg_88_1.var_.characterEffect1053ui_story = var_91_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_28 = 0.200000002980232

			if var_91_27 <= arg_88_1.time_ and arg_88_1.time_ < var_91_27 + var_91_28 and not isNil(var_91_26) then
				local var_91_29 = (arg_88_1.time_ - var_91_27) / var_91_28

				if arg_88_1.var_.characterEffect1053ui_story and not isNil(var_91_26) then
					local var_91_30 = Mathf.Lerp(0, 0.5, var_91_29)

					arg_88_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1053ui_story.fillRatio = var_91_30
				end
			end

			if arg_88_1.time_ >= var_91_27 + var_91_28 and arg_88_1.time_ < var_91_27 + var_91_28 + arg_91_0 and not isNil(var_91_26) and arg_88_1.var_.characterEffect1053ui_story then
				local var_91_31 = 0.5

				arg_88_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1053ui_story.fillRatio = var_91_31
			end

			local var_91_32 = 0

			if var_91_32 < arg_88_1.time_ and arg_88_1.time_ <= var_91_32 + arg_91_0 then
				arg_88_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action6_1")
			end

			local var_91_33 = 0
			local var_91_34 = 0.2

			if var_91_33 < arg_88_1.time_ and arg_88_1.time_ <= var_91_33 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_35 = arg_88_1:FormatText(StoryNameCfg[318].name)

				arg_88_1.leftNameTxt_.text = var_91_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_36 = arg_88_1:GetWordFromCfg(324171022)
				local var_91_37 = arg_88_1:FormatText(var_91_36.content)

				arg_88_1.text_.text = var_91_37

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_38 = 8
				local var_91_39 = utf8.len(var_91_37)
				local var_91_40 = var_91_38 <= 0 and var_91_34 or var_91_34 * (var_91_39 / var_91_38)

				if var_91_40 > 0 and var_91_34 < var_91_40 then
					arg_88_1.talkMaxDuration = var_91_40

					if var_91_40 + var_91_33 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_40 + var_91_33
					end
				end

				arg_88_1.text_.text = var_91_37
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171022", "story_v_out_324171.awb") ~= 0 then
					local var_91_41 = manager.audio:GetVoiceLength("story_v_out_324171", "324171022", "story_v_out_324171.awb") / 1000

					if var_91_41 + var_91_33 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_41 + var_91_33
					end

					if var_91_36.prefab_name ~= "" and arg_88_1.actors_[var_91_36.prefab_name] ~= nil then
						local var_91_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_36.prefab_name].transform, "story_v_out_324171", "324171022", "story_v_out_324171.awb")

						arg_88_1:RecordAudio("324171022", var_91_42)
						arg_88_1:RecordAudio("324171022", var_91_42)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_324171", "324171022", "story_v_out_324171.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_324171", "324171022", "story_v_out_324171.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_43 = math.max(var_91_34, arg_88_1.talkMaxDuration)

			if var_91_33 <= arg_88_1.time_ and arg_88_1.time_ < var_91_33 + var_91_43 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_33) / var_91_43

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_33 + var_91_43 and arg_88_1.time_ < var_91_33 + var_91_43 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play324171023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324171023
		arg_92_1.duration_ = 9.23

		local var_92_0 = {
			zh = 6,
			ja = 9.233
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play324171024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1053ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1053ui_story = var_95_0.localPosition

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end
			end

			local var_95_3 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_3 then
				local var_95_4 = (arg_92_1.time_ - var_95_1) / var_95_3
				local var_95_5 = Vector3.New(0.7, -1.08, -6)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1053ui_story, var_95_5, var_95_4)

				local var_95_6 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_6.x, var_95_6.y, var_95_6.z)

				local var_95_7 = var_95_0.localEulerAngles

				var_95_7.z = 0
				var_95_7.x = 0
				var_95_0.localEulerAngles = var_95_7
			end

			if arg_92_1.time_ >= var_95_1 + var_95_3 and arg_92_1.time_ < var_95_1 + var_95_3 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_95_8 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_8.x, var_95_8.y, var_95_8.z)

				local var_95_9 = var_95_0.localEulerAngles

				var_95_9.z = 0
				var_95_9.x = 0
				var_95_0.localEulerAngles = var_95_9

				local var_95_10 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_10 then
					var_95_10:EnableDynamicBone(true)
				end
			end

			local var_95_11 = arg_92_1.actors_["1053ui_story"]
			local var_95_12 = 0

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect1053ui_story == nil then
				arg_92_1.var_.characterEffect1053ui_story = var_95_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_13 = 0.200000002980232

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_13 and not isNil(var_95_11) then
				local var_95_14 = (arg_92_1.time_ - var_95_12) / var_95_13

				if arg_92_1.var_.characterEffect1053ui_story and not isNil(var_95_11) then
					arg_92_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_12 + var_95_13 and arg_92_1.time_ < var_95_12 + var_95_13 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect1053ui_story then
				arg_92_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_95_15 = arg_92_1.actors_["1170ui_story"]
			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 and not isNil(var_95_15) and arg_92_1.var_.characterEffect1170ui_story == nil then
				arg_92_1.var_.characterEffect1170ui_story = var_95_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_17 = 0.200000002980232

			if var_95_16 <= arg_92_1.time_ and arg_92_1.time_ < var_95_16 + var_95_17 and not isNil(var_95_15) then
				local var_95_18 = (arg_92_1.time_ - var_95_16) / var_95_17

				if arg_92_1.var_.characterEffect1170ui_story and not isNil(var_95_15) then
					local var_95_19 = Mathf.Lerp(0, 0.5, var_95_18)

					arg_92_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1170ui_story.fillRatio = var_95_19
				end
			end

			if arg_92_1.time_ >= var_95_16 + var_95_17 and arg_92_1.time_ < var_95_16 + var_95_17 + arg_95_0 and not isNil(var_95_15) and arg_92_1.var_.characterEffect1170ui_story then
				local var_95_20 = 0.5

				arg_92_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1170ui_story.fillRatio = var_95_20
			end

			local var_95_21 = 0

			if var_95_21 < arg_92_1.time_ and arg_92_1.time_ <= var_95_21 + arg_95_0 then
				arg_92_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			local var_95_22 = 0

			if var_95_22 < arg_92_1.time_ and arg_92_1.time_ <= var_95_22 + arg_95_0 then
				arg_92_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_95_23 = 0
			local var_95_24 = 0.575

			if var_95_23 < arg_92_1.time_ and arg_92_1.time_ <= var_95_23 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_25 = arg_92_1:FormatText(StoryNameCfg[472].name)

				arg_92_1.leftNameTxt_.text = var_95_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_26 = arg_92_1:GetWordFromCfg(324171023)
				local var_95_27 = arg_92_1:FormatText(var_95_26.content)

				arg_92_1.text_.text = var_95_27

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_28 = 23
				local var_95_29 = utf8.len(var_95_27)
				local var_95_30 = var_95_28 <= 0 and var_95_24 or var_95_24 * (var_95_29 / var_95_28)

				if var_95_30 > 0 and var_95_24 < var_95_30 then
					arg_92_1.talkMaxDuration = var_95_30

					if var_95_30 + var_95_23 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_30 + var_95_23
					end
				end

				arg_92_1.text_.text = var_95_27
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171023", "story_v_out_324171.awb") ~= 0 then
					local var_95_31 = manager.audio:GetVoiceLength("story_v_out_324171", "324171023", "story_v_out_324171.awb") / 1000

					if var_95_31 + var_95_23 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_31 + var_95_23
					end

					if var_95_26.prefab_name ~= "" and arg_92_1.actors_[var_95_26.prefab_name] ~= nil then
						local var_95_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_26.prefab_name].transform, "story_v_out_324171", "324171023", "story_v_out_324171.awb")

						arg_92_1:RecordAudio("324171023", var_95_32)
						arg_92_1:RecordAudio("324171023", var_95_32)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_324171", "324171023", "story_v_out_324171.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_324171", "324171023", "story_v_out_324171.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_33 = math.max(var_95_24, arg_92_1.talkMaxDuration)

			if var_95_23 <= arg_92_1.time_ and arg_92_1.time_ < var_95_23 + var_95_33 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_23) / var_95_33

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_23 + var_95_33 and arg_92_1.time_ < var_95_23 + var_95_33 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play324171024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324171024
		arg_96_1.duration_ = 2.03

		local var_96_0 = {
			zh = 2.033,
			ja = 1.666
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
				arg_96_0:Play324171025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1170ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1170ui_story == nil then
				arg_96_1.var_.characterEffect1170ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1170ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1170ui_story then
				arg_96_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["1053ui_story"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1053ui_story == nil then
				arg_96_1.var_.characterEffect1053ui_story = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.200000002980232

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect1053ui_story and not isNil(var_99_4) then
					local var_99_8 = Mathf.Lerp(0, 0.5, var_99_7)

					arg_96_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1053ui_story.fillRatio = var_99_8
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1053ui_story then
				local var_99_9 = 0.5

				arg_96_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1053ui_story.fillRatio = var_99_9
			end

			local var_99_10 = 0
			local var_99_11 = 0.1

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_12 = arg_96_1:FormatText(StoryNameCfg[318].name)

				arg_96_1.leftNameTxt_.text = var_99_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_13 = arg_96_1:GetWordFromCfg(324171024)
				local var_99_14 = arg_96_1:FormatText(var_99_13.content)

				arg_96_1.text_.text = var_99_14

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_15 = 4
				local var_99_16 = utf8.len(var_99_14)
				local var_99_17 = var_99_15 <= 0 and var_99_11 or var_99_11 * (var_99_16 / var_99_15)

				if var_99_17 > 0 and var_99_11 < var_99_17 then
					arg_96_1.talkMaxDuration = var_99_17

					if var_99_17 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_17 + var_99_10
					end
				end

				arg_96_1.text_.text = var_99_14
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171024", "story_v_out_324171.awb") ~= 0 then
					local var_99_18 = manager.audio:GetVoiceLength("story_v_out_324171", "324171024", "story_v_out_324171.awb") / 1000

					if var_99_18 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_10
					end

					if var_99_13.prefab_name ~= "" and arg_96_1.actors_[var_99_13.prefab_name] ~= nil then
						local var_99_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_13.prefab_name].transform, "story_v_out_324171", "324171024", "story_v_out_324171.awb")

						arg_96_1:RecordAudio("324171024", var_99_19)
						arg_96_1:RecordAudio("324171024", var_99_19)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_324171", "324171024", "story_v_out_324171.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_324171", "324171024", "story_v_out_324171.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_20 = math.max(var_99_11, arg_96_1.talkMaxDuration)

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_20 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_10) / var_99_20

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_10 + var_99_20 and arg_96_1.time_ < var_99_10 + var_99_20 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play324171025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324171025
		arg_100_1.duration_ = 4.7

		local var_100_0 = {
			zh = 4.433,
			ja = 4.7
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play324171026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_103_2 = 0
			local var_103_3 = 0.3

			if var_103_2 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_4 = arg_100_1:FormatText(StoryNameCfg[318].name)

				arg_100_1.leftNameTxt_.text = var_103_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:GetWordFromCfg(324171025)
				local var_103_6 = arg_100_1:FormatText(var_103_5.content)

				arg_100_1.text_.text = var_103_6

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 12
				local var_103_8 = utf8.len(var_103_6)
				local var_103_9 = var_103_7 <= 0 and var_103_3 or var_103_3 * (var_103_8 / var_103_7)

				if var_103_9 > 0 and var_103_3 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_6
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171025", "story_v_out_324171.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_324171", "324171025", "story_v_out_324171.awb") / 1000

					if var_103_10 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_2
					end

					if var_103_5.prefab_name ~= "" and arg_100_1.actors_[var_103_5.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_5.prefab_name].transform, "story_v_out_324171", "324171025", "story_v_out_324171.awb")

						arg_100_1:RecordAudio("324171025", var_103_11)
						arg_100_1:RecordAudio("324171025", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_324171", "324171025", "story_v_out_324171.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_324171", "324171025", "story_v_out_324171.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_12 and arg_100_1.time_ < var_103_2 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play324171026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324171026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play324171027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1053ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1053ui_story = var_107_0.localPosition

				local var_107_2 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(false)
				end
			end

			local var_107_3 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_3 then
				local var_107_4 = (arg_104_1.time_ - var_107_1) / var_107_3
				local var_107_5 = Vector3.New(0, 100, 0)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1053ui_story, var_107_5, var_107_4)

				local var_107_6 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_6.x, var_107_6.y, var_107_6.z)

				local var_107_7 = var_107_0.localEulerAngles

				var_107_7.z = 0
				var_107_7.x = 0
				var_107_0.localEulerAngles = var_107_7
			end

			if arg_104_1.time_ >= var_107_1 + var_107_3 and arg_104_1.time_ < var_107_1 + var_107_3 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, 100, 0)

				local var_107_8 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_8.x, var_107_8.y, var_107_8.z)

				local var_107_9 = var_107_0.localEulerAngles

				var_107_9.z = 0
				var_107_9.x = 0
				var_107_0.localEulerAngles = var_107_9

				local var_107_10 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_10 then
					var_107_10:EnableDynamicBone(true)
				end
			end

			local var_107_11 = arg_104_1.actors_["1170ui_story"].transform
			local var_107_12 = 0

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 then
				arg_104_1.var_.moveOldPos1170ui_story = var_107_11.localPosition

				local var_107_13 = GameObjectTools.GetOrAddComponent(var_107_11.gameObject, typeof(DynamicBoneHelper))

				if var_107_13 then
					var_107_13:EnableDynamicBone(false)
				end
			end

			local var_107_14 = 0.001

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_14 then
				local var_107_15 = (arg_104_1.time_ - var_107_12) / var_107_14
				local var_107_16 = Vector3.New(0, 100, 0)

				var_107_11.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1170ui_story, var_107_16, var_107_15)

				local var_107_17 = manager.ui.mainCamera.transform.position - var_107_11.position

				var_107_11.forward = Vector3.New(var_107_17.x, var_107_17.y, var_107_17.z)

				local var_107_18 = var_107_11.localEulerAngles

				var_107_18.z = 0
				var_107_18.x = 0
				var_107_11.localEulerAngles = var_107_18
			end

			if arg_104_1.time_ >= var_107_12 + var_107_14 and arg_104_1.time_ < var_107_12 + var_107_14 + arg_107_0 then
				var_107_11.localPosition = Vector3.New(0, 100, 0)

				local var_107_19 = manager.ui.mainCamera.transform.position - var_107_11.position

				var_107_11.forward = Vector3.New(var_107_19.x, var_107_19.y, var_107_19.z)

				local var_107_20 = var_107_11.localEulerAngles

				var_107_20.z = 0
				var_107_20.x = 0
				var_107_11.localEulerAngles = var_107_20

				local var_107_21 = GameObjectTools.GetOrAddComponent(var_107_11.gameObject, typeof(DynamicBoneHelper))

				if var_107_21 then
					var_107_21:EnableDynamicBone(true)
				end
			end

			local var_107_22 = arg_104_1.actors_["1170ui_story"]
			local var_107_23 = 0

			if var_107_23 < arg_104_1.time_ and arg_104_1.time_ <= var_107_23 + arg_107_0 and not isNil(var_107_22) and arg_104_1.var_.characterEffect1170ui_story == nil then
				arg_104_1.var_.characterEffect1170ui_story = var_107_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_24 = 0.200000002980232

			if var_107_23 <= arg_104_1.time_ and arg_104_1.time_ < var_107_23 + var_107_24 and not isNil(var_107_22) then
				local var_107_25 = (arg_104_1.time_ - var_107_23) / var_107_24

				if arg_104_1.var_.characterEffect1170ui_story and not isNil(var_107_22) then
					local var_107_26 = Mathf.Lerp(0, 0.5, var_107_25)

					arg_104_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1170ui_story.fillRatio = var_107_26
				end
			end

			if arg_104_1.time_ >= var_107_23 + var_107_24 and arg_104_1.time_ < var_107_23 + var_107_24 + arg_107_0 and not isNil(var_107_22) and arg_104_1.var_.characterEffect1170ui_story then
				local var_107_27 = 0.5

				arg_104_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1170ui_story.fillRatio = var_107_27
			end

			local var_107_28 = 0
			local var_107_29 = 1.375

			if var_107_28 < arg_104_1.time_ and arg_104_1.time_ <= var_107_28 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_30 = arg_104_1:GetWordFromCfg(324171026)
				local var_107_31 = arg_104_1:FormatText(var_107_30.content)

				arg_104_1.text_.text = var_107_31

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_32 = 55
				local var_107_33 = utf8.len(var_107_31)
				local var_107_34 = var_107_32 <= 0 and var_107_29 or var_107_29 * (var_107_33 / var_107_32)

				if var_107_34 > 0 and var_107_29 < var_107_34 then
					arg_104_1.talkMaxDuration = var_107_34

					if var_107_34 + var_107_28 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_34 + var_107_28
					end
				end

				arg_104_1.text_.text = var_107_31
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_35 = math.max(var_107_29, arg_104_1.talkMaxDuration)

			if var_107_28 <= arg_104_1.time_ and arg_104_1.time_ < var_107_28 + var_107_35 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_28) / var_107_35

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_28 + var_107_35 and arg_104_1.time_ < var_107_28 + var_107_35 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play324171027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324171027
		arg_108_1.duration_ = 7.7

		local var_108_0 = {
			zh = 4.733,
			ja = 7.7
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
				arg_108_0:Play324171028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1053ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1053ui_story = var_111_0.localPosition

				local var_111_2 = GameObjectTools.GetOrAddComponent(var_111_0.gameObject, typeof(DynamicBoneHelper))

				if var_111_2 then
					var_111_2:EnableDynamicBone(false)
				end
			end

			local var_111_3 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_3 then
				local var_111_4 = (arg_108_1.time_ - var_111_1) / var_111_3
				local var_111_5 = Vector3.New(0.7, -1.08, -6)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1053ui_story, var_111_5, var_111_4)

				local var_111_6 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_6.x, var_111_6.y, var_111_6.z)

				local var_111_7 = var_111_0.localEulerAngles

				var_111_7.z = 0
				var_111_7.x = 0
				var_111_0.localEulerAngles = var_111_7
			end

			if arg_108_1.time_ >= var_111_1 + var_111_3 and arg_108_1.time_ < var_111_1 + var_111_3 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_111_8 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_8.x, var_111_8.y, var_111_8.z)

				local var_111_9 = var_111_0.localEulerAngles

				var_111_9.z = 0
				var_111_9.x = 0
				var_111_0.localEulerAngles = var_111_9

				local var_111_10 = GameObjectTools.GetOrAddComponent(var_111_0.gameObject, typeof(DynamicBoneHelper))

				if var_111_10 then
					var_111_10:EnableDynamicBone(true)
				end
			end

			local var_111_11 = arg_108_1.actors_["1053ui_story"]
			local var_111_12 = 0

			if var_111_12 < arg_108_1.time_ and arg_108_1.time_ <= var_111_12 + arg_111_0 and not isNil(var_111_11) and arg_108_1.var_.characterEffect1053ui_story == nil then
				arg_108_1.var_.characterEffect1053ui_story = var_111_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_13 = 0.200000002980232

			if var_111_12 <= arg_108_1.time_ and arg_108_1.time_ < var_111_12 + var_111_13 and not isNil(var_111_11) then
				local var_111_14 = (arg_108_1.time_ - var_111_12) / var_111_13

				if arg_108_1.var_.characterEffect1053ui_story and not isNil(var_111_11) then
					arg_108_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_12 + var_111_13 and arg_108_1.time_ < var_111_12 + var_111_13 + arg_111_0 and not isNil(var_111_11) and arg_108_1.var_.characterEffect1053ui_story then
				arg_108_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_111_15 = 0

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_111_16 = 0

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_111_17 = 0
			local var_111_18 = 0.375

			if var_111_17 < arg_108_1.time_ and arg_108_1.time_ <= var_111_17 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_19 = arg_108_1:FormatText(StoryNameCfg[472].name)

				arg_108_1.leftNameTxt_.text = var_111_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_20 = arg_108_1:GetWordFromCfg(324171027)
				local var_111_21 = arg_108_1:FormatText(var_111_20.content)

				arg_108_1.text_.text = var_111_21

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_22 = 15
				local var_111_23 = utf8.len(var_111_21)
				local var_111_24 = var_111_22 <= 0 and var_111_18 or var_111_18 * (var_111_23 / var_111_22)

				if var_111_24 > 0 and var_111_18 < var_111_24 then
					arg_108_1.talkMaxDuration = var_111_24

					if var_111_24 + var_111_17 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_24 + var_111_17
					end
				end

				arg_108_1.text_.text = var_111_21
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171027", "story_v_out_324171.awb") ~= 0 then
					local var_111_25 = manager.audio:GetVoiceLength("story_v_out_324171", "324171027", "story_v_out_324171.awb") / 1000

					if var_111_25 + var_111_17 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_25 + var_111_17
					end

					if var_111_20.prefab_name ~= "" and arg_108_1.actors_[var_111_20.prefab_name] ~= nil then
						local var_111_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_20.prefab_name].transform, "story_v_out_324171", "324171027", "story_v_out_324171.awb")

						arg_108_1:RecordAudio("324171027", var_111_26)
						arg_108_1:RecordAudio("324171027", var_111_26)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_324171", "324171027", "story_v_out_324171.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_324171", "324171027", "story_v_out_324171.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_27 = math.max(var_111_18, arg_108_1.talkMaxDuration)

			if var_111_17 <= arg_108_1.time_ and arg_108_1.time_ < var_111_17 + var_111_27 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_17) / var_111_27

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_17 + var_111_27 and arg_108_1.time_ < var_111_17 + var_111_27 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play324171028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324171028
		arg_112_1.duration_ = 4.33

		local var_112_0 = {
			zh = 2.633,
			ja = 4.333
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324171029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1170ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos1170ui_story = var_115_0.localPosition

				local var_115_2 = GameObjectTools.GetOrAddComponent(var_115_0.gameObject, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(false)
				end
			end

			local var_115_3 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_3 then
				local var_115_4 = (arg_112_1.time_ - var_115_1) / var_115_3
				local var_115_5 = Vector3.New(-0.68, -0.95, -6.08)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1170ui_story, var_115_5, var_115_4)

				local var_115_6 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_6.x, var_115_6.y, var_115_6.z)

				local var_115_7 = var_115_0.localEulerAngles

				var_115_7.z = 0
				var_115_7.x = 0
				var_115_0.localEulerAngles = var_115_7
			end

			if arg_112_1.time_ >= var_115_1 + var_115_3 and arg_112_1.time_ < var_115_1 + var_115_3 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(-0.68, -0.95, -6.08)

				local var_115_8 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_8.x, var_115_8.y, var_115_8.z)

				local var_115_9 = var_115_0.localEulerAngles

				var_115_9.z = 0
				var_115_9.x = 0
				var_115_0.localEulerAngles = var_115_9

				local var_115_10 = GameObjectTools.GetOrAddComponent(var_115_0.gameObject, typeof(DynamicBoneHelper))

				if var_115_10 then
					var_115_10:EnableDynamicBone(true)
				end
			end

			local var_115_11 = arg_112_1.actors_["1170ui_story"]
			local var_115_12 = 0

			if var_115_12 < arg_112_1.time_ and arg_112_1.time_ <= var_115_12 + arg_115_0 and not isNil(var_115_11) and arg_112_1.var_.characterEffect1170ui_story == nil then
				arg_112_1.var_.characterEffect1170ui_story = var_115_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_13 = 0.200000002980232

			if var_115_12 <= arg_112_1.time_ and arg_112_1.time_ < var_115_12 + var_115_13 and not isNil(var_115_11) then
				local var_115_14 = (arg_112_1.time_ - var_115_12) / var_115_13

				if arg_112_1.var_.characterEffect1170ui_story and not isNil(var_115_11) then
					arg_112_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_12 + var_115_13 and arg_112_1.time_ < var_115_12 + var_115_13 + arg_115_0 and not isNil(var_115_11) and arg_112_1.var_.characterEffect1170ui_story then
				arg_112_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_115_15 = arg_112_1.actors_["1053ui_story"]
			local var_115_16 = 0

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 and not isNil(var_115_15) and arg_112_1.var_.characterEffect1053ui_story == nil then
				arg_112_1.var_.characterEffect1053ui_story = var_115_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_17 = 0.200000002980232

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_17 and not isNil(var_115_15) then
				local var_115_18 = (arg_112_1.time_ - var_115_16) / var_115_17

				if arg_112_1.var_.characterEffect1053ui_story and not isNil(var_115_15) then
					local var_115_19 = Mathf.Lerp(0, 0.5, var_115_18)

					arg_112_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1053ui_story.fillRatio = var_115_19
				end
			end

			if arg_112_1.time_ >= var_115_16 + var_115_17 and arg_112_1.time_ < var_115_16 + var_115_17 + arg_115_0 and not isNil(var_115_15) and arg_112_1.var_.characterEffect1053ui_story then
				local var_115_20 = 0.5

				arg_112_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1053ui_story.fillRatio = var_115_20
			end

			local var_115_21 = 0

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 then
				arg_112_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_2")
			end

			local var_115_22 = 0

			if var_115_22 < arg_112_1.time_ and arg_112_1.time_ <= var_115_22 + arg_115_0 then
				arg_112_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_115_23 = 0
			local var_115_24 = 0.2

			if var_115_23 < arg_112_1.time_ and arg_112_1.time_ <= var_115_23 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_25 = arg_112_1:FormatText(StoryNameCfg[318].name)

				arg_112_1.leftNameTxt_.text = var_115_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_26 = arg_112_1:GetWordFromCfg(324171028)
				local var_115_27 = arg_112_1:FormatText(var_115_26.content)

				arg_112_1.text_.text = var_115_27

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_28 = 8
				local var_115_29 = utf8.len(var_115_27)
				local var_115_30 = var_115_28 <= 0 and var_115_24 or var_115_24 * (var_115_29 / var_115_28)

				if var_115_30 > 0 and var_115_24 < var_115_30 then
					arg_112_1.talkMaxDuration = var_115_30

					if var_115_30 + var_115_23 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_30 + var_115_23
					end
				end

				arg_112_1.text_.text = var_115_27
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171028", "story_v_out_324171.awb") ~= 0 then
					local var_115_31 = manager.audio:GetVoiceLength("story_v_out_324171", "324171028", "story_v_out_324171.awb") / 1000

					if var_115_31 + var_115_23 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_31 + var_115_23
					end

					if var_115_26.prefab_name ~= "" and arg_112_1.actors_[var_115_26.prefab_name] ~= nil then
						local var_115_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_26.prefab_name].transform, "story_v_out_324171", "324171028", "story_v_out_324171.awb")

						arg_112_1:RecordAudio("324171028", var_115_32)
						arg_112_1:RecordAudio("324171028", var_115_32)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_324171", "324171028", "story_v_out_324171.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_324171", "324171028", "story_v_out_324171.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_33 = math.max(var_115_24, arg_112_1.talkMaxDuration)

			if var_115_23 <= arg_112_1.time_ and arg_112_1.time_ < var_115_23 + var_115_33 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_23) / var_115_33

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_23 + var_115_33 and arg_112_1.time_ < var_115_23 + var_115_33 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play324171029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 324171029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play324171030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1170ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1170ui_story = var_119_0.localPosition

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end
			end

			local var_119_3 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_3 then
				local var_119_4 = (arg_116_1.time_ - var_119_1) / var_119_3
				local var_119_5 = Vector3.New(0, 100, 0)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1170ui_story, var_119_5, var_119_4)

				local var_119_6 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_6.x, var_119_6.y, var_119_6.z)

				local var_119_7 = var_119_0.localEulerAngles

				var_119_7.z = 0
				var_119_7.x = 0
				var_119_0.localEulerAngles = var_119_7
			end

			if arg_116_1.time_ >= var_119_1 + var_119_3 and arg_116_1.time_ < var_119_1 + var_119_3 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, 100, 0)

				local var_119_8 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_8.x, var_119_8.y, var_119_8.z)

				local var_119_9 = var_119_0.localEulerAngles

				var_119_9.z = 0
				var_119_9.x = 0
				var_119_0.localEulerAngles = var_119_9

				local var_119_10 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_10 then
					var_119_10:EnableDynamicBone(true)
				end
			end

			local var_119_11 = arg_116_1.actors_["1053ui_story"].transform
			local var_119_12 = 0

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.var_.moveOldPos1053ui_story = var_119_11.localPosition

				local var_119_13 = GameObjectTools.GetOrAddComponent(var_119_11.gameObject, typeof(DynamicBoneHelper))

				if var_119_13 then
					var_119_13:EnableDynamicBone(false)
				end
			end

			local var_119_14 = 0.001

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_14 then
				local var_119_15 = (arg_116_1.time_ - var_119_12) / var_119_14
				local var_119_16 = Vector3.New(0, 100, 0)

				var_119_11.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1053ui_story, var_119_16, var_119_15)

				local var_119_17 = manager.ui.mainCamera.transform.position - var_119_11.position

				var_119_11.forward = Vector3.New(var_119_17.x, var_119_17.y, var_119_17.z)

				local var_119_18 = var_119_11.localEulerAngles

				var_119_18.z = 0
				var_119_18.x = 0
				var_119_11.localEulerAngles = var_119_18
			end

			if arg_116_1.time_ >= var_119_12 + var_119_14 and arg_116_1.time_ < var_119_12 + var_119_14 + arg_119_0 then
				var_119_11.localPosition = Vector3.New(0, 100, 0)

				local var_119_19 = manager.ui.mainCamera.transform.position - var_119_11.position

				var_119_11.forward = Vector3.New(var_119_19.x, var_119_19.y, var_119_19.z)

				local var_119_20 = var_119_11.localEulerAngles

				var_119_20.z = 0
				var_119_20.x = 0
				var_119_11.localEulerAngles = var_119_20

				local var_119_21 = GameObjectTools.GetOrAddComponent(var_119_11.gameObject, typeof(DynamicBoneHelper))

				if var_119_21 then
					var_119_21:EnableDynamicBone(true)
				end
			end

			local var_119_22 = arg_116_1.actors_["1170ui_story"]
			local var_119_23 = 0

			if var_119_23 < arg_116_1.time_ and arg_116_1.time_ <= var_119_23 + arg_119_0 and not isNil(var_119_22) and arg_116_1.var_.characterEffect1170ui_story == nil then
				arg_116_1.var_.characterEffect1170ui_story = var_119_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_24 = 0.200000002980232

			if var_119_23 <= arg_116_1.time_ and arg_116_1.time_ < var_119_23 + var_119_24 and not isNil(var_119_22) then
				local var_119_25 = (arg_116_1.time_ - var_119_23) / var_119_24

				if arg_116_1.var_.characterEffect1170ui_story and not isNil(var_119_22) then
					local var_119_26 = Mathf.Lerp(0, 0.5, var_119_25)

					arg_116_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1170ui_story.fillRatio = var_119_26
				end
			end

			if arg_116_1.time_ >= var_119_23 + var_119_24 and arg_116_1.time_ < var_119_23 + var_119_24 + arg_119_0 and not isNil(var_119_22) and arg_116_1.var_.characterEffect1170ui_story then
				local var_119_27 = 0.5

				arg_116_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1170ui_story.fillRatio = var_119_27
			end

			local var_119_28 = 0
			local var_119_29 = 0.575

			if var_119_28 < arg_116_1.time_ and arg_116_1.time_ <= var_119_28 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_30 = arg_116_1:GetWordFromCfg(324171029)
				local var_119_31 = arg_116_1:FormatText(var_119_30.content)

				arg_116_1.text_.text = var_119_31

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_32 = 23
				local var_119_33 = utf8.len(var_119_31)
				local var_119_34 = var_119_32 <= 0 and var_119_29 or var_119_29 * (var_119_33 / var_119_32)

				if var_119_34 > 0 and var_119_29 < var_119_34 then
					arg_116_1.talkMaxDuration = var_119_34

					if var_119_34 + var_119_28 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_34 + var_119_28
					end
				end

				arg_116_1.text_.text = var_119_31
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_35 = math.max(var_119_29, arg_116_1.talkMaxDuration)

			if var_119_28 <= arg_116_1.time_ and arg_116_1.time_ < var_119_28 + var_119_35 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_28) / var_119_35

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_28 + var_119_35 and arg_116_1.time_ < var_119_28 + var_119_35 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play324171030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 324171030
		arg_120_1.duration_ = 6.2

		local var_120_0 = {
			zh = 4.6,
			ja = 6.2
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
				arg_120_0:Play324171031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1170ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1170ui_story = var_123_0.localPosition

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end
			end

			local var_123_3 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_3 then
				local var_123_4 = (arg_120_1.time_ - var_123_1) / var_123_3
				local var_123_5 = Vector3.New(-0.68, -0.95, -6.08)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1170ui_story, var_123_5, var_123_4)

				local var_123_6 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_6.x, var_123_6.y, var_123_6.z)

				local var_123_7 = var_123_0.localEulerAngles

				var_123_7.z = 0
				var_123_7.x = 0
				var_123_0.localEulerAngles = var_123_7
			end

			if arg_120_1.time_ >= var_123_1 + var_123_3 and arg_120_1.time_ < var_123_1 + var_123_3 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(-0.68, -0.95, -6.08)

				local var_123_8 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_8.x, var_123_8.y, var_123_8.z)

				local var_123_9 = var_123_0.localEulerAngles

				var_123_9.z = 0
				var_123_9.x = 0
				var_123_0.localEulerAngles = var_123_9

				local var_123_10 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_10 then
					var_123_10:EnableDynamicBone(true)
				end
			end

			local var_123_11 = arg_120_1.actors_["1170ui_story"]
			local var_123_12 = 0

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 and not isNil(var_123_11) and arg_120_1.var_.characterEffect1170ui_story == nil then
				arg_120_1.var_.characterEffect1170ui_story = var_123_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_13 = 0.200000002980232

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_13 and not isNil(var_123_11) then
				local var_123_14 = (arg_120_1.time_ - var_123_12) / var_123_13

				if arg_120_1.var_.characterEffect1170ui_story and not isNil(var_123_11) then
					arg_120_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_12 + var_123_13 and arg_120_1.time_ < var_123_12 + var_123_13 + arg_123_0 and not isNil(var_123_11) and arg_120_1.var_.characterEffect1170ui_story then
				arg_120_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_123_15 = 0

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action5_1")
			end

			local var_123_16 = 0

			if var_123_16 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 then
				arg_120_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_123_17 = 0
			local var_123_18 = 0.475

			if var_123_17 < arg_120_1.time_ and arg_120_1.time_ <= var_123_17 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_19 = arg_120_1:FormatText(StoryNameCfg[318].name)

				arg_120_1.leftNameTxt_.text = var_123_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_20 = arg_120_1:GetWordFromCfg(324171030)
				local var_123_21 = arg_120_1:FormatText(var_123_20.content)

				arg_120_1.text_.text = var_123_21

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_22 = 19
				local var_123_23 = utf8.len(var_123_21)
				local var_123_24 = var_123_22 <= 0 and var_123_18 or var_123_18 * (var_123_23 / var_123_22)

				if var_123_24 > 0 and var_123_18 < var_123_24 then
					arg_120_1.talkMaxDuration = var_123_24

					if var_123_24 + var_123_17 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_24 + var_123_17
					end
				end

				arg_120_1.text_.text = var_123_21
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171030", "story_v_out_324171.awb") ~= 0 then
					local var_123_25 = manager.audio:GetVoiceLength("story_v_out_324171", "324171030", "story_v_out_324171.awb") / 1000

					if var_123_25 + var_123_17 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_25 + var_123_17
					end

					if var_123_20.prefab_name ~= "" and arg_120_1.actors_[var_123_20.prefab_name] ~= nil then
						local var_123_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_20.prefab_name].transform, "story_v_out_324171", "324171030", "story_v_out_324171.awb")

						arg_120_1:RecordAudio("324171030", var_123_26)
						arg_120_1:RecordAudio("324171030", var_123_26)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_324171", "324171030", "story_v_out_324171.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_324171", "324171030", "story_v_out_324171.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_27 = math.max(var_123_18, arg_120_1.talkMaxDuration)

			if var_123_17 <= arg_120_1.time_ and arg_120_1.time_ < var_123_17 + var_123_27 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_17) / var_123_27

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_17 + var_123_27 and arg_120_1.time_ < var_123_17 + var_123_27 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play324171031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324171031
		arg_124_1.duration_ = 5.2

		local var_124_0 = {
			zh = 3.766,
			ja = 5.2
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play324171032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1053ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1053ui_story = var_127_0.localPosition

				local var_127_2 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(false)
				end
			end

			local var_127_3 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_3 then
				local var_127_4 = (arg_124_1.time_ - var_127_1) / var_127_3
				local var_127_5 = Vector3.New(0.7, -1.08, -6)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1053ui_story, var_127_5, var_127_4)

				local var_127_6 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_6.x, var_127_6.y, var_127_6.z)

				local var_127_7 = var_127_0.localEulerAngles

				var_127_7.z = 0
				var_127_7.x = 0
				var_127_0.localEulerAngles = var_127_7
			end

			if arg_124_1.time_ >= var_127_1 + var_127_3 and arg_124_1.time_ < var_127_1 + var_127_3 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_127_8 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_8.x, var_127_8.y, var_127_8.z)

				local var_127_9 = var_127_0.localEulerAngles

				var_127_9.z = 0
				var_127_9.x = 0
				var_127_0.localEulerAngles = var_127_9

				local var_127_10 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_10 then
					var_127_10:EnableDynamicBone(true)
				end
			end

			local var_127_11 = arg_124_1.actors_["1053ui_story"]
			local var_127_12 = 0

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect1053ui_story == nil then
				arg_124_1.var_.characterEffect1053ui_story = var_127_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_13 = 0.200000002980232

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_13 and not isNil(var_127_11) then
				local var_127_14 = (arg_124_1.time_ - var_127_12) / var_127_13

				if arg_124_1.var_.characterEffect1053ui_story and not isNil(var_127_11) then
					arg_124_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_12 + var_127_13 and arg_124_1.time_ < var_127_12 + var_127_13 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect1053ui_story then
				arg_124_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_127_15 = arg_124_1.actors_["1170ui_story"]
			local var_127_16 = 0

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 and not isNil(var_127_15) and arg_124_1.var_.characterEffect1170ui_story == nil then
				arg_124_1.var_.characterEffect1170ui_story = var_127_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_17 = 0.200000002980232

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_17 and not isNil(var_127_15) then
				local var_127_18 = (arg_124_1.time_ - var_127_16) / var_127_17

				if arg_124_1.var_.characterEffect1170ui_story and not isNil(var_127_15) then
					local var_127_19 = Mathf.Lerp(0, 0.5, var_127_18)

					arg_124_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1170ui_story.fillRatio = var_127_19
				end
			end

			if arg_124_1.time_ >= var_127_16 + var_127_17 and arg_124_1.time_ < var_127_16 + var_127_17 + arg_127_0 and not isNil(var_127_15) and arg_124_1.var_.characterEffect1170ui_story then
				local var_127_20 = 0.5

				arg_124_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1170ui_story.fillRatio = var_127_20
			end

			local var_127_21 = 0

			if var_127_21 < arg_124_1.time_ and arg_124_1.time_ <= var_127_21 + arg_127_0 then
				arg_124_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_127_22 = 0

			if var_127_22 < arg_124_1.time_ and arg_124_1.time_ <= var_127_22 + arg_127_0 then
				arg_124_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_127_23 = 0
			local var_127_24 = 0.375

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_25 = arg_124_1:FormatText(StoryNameCfg[472].name)

				arg_124_1.leftNameTxt_.text = var_127_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_26 = arg_124_1:GetWordFromCfg(324171031)
				local var_127_27 = arg_124_1:FormatText(var_127_26.content)

				arg_124_1.text_.text = var_127_27

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_28 = 15
				local var_127_29 = utf8.len(var_127_27)
				local var_127_30 = var_127_28 <= 0 and var_127_24 or var_127_24 * (var_127_29 / var_127_28)

				if var_127_30 > 0 and var_127_24 < var_127_30 then
					arg_124_1.talkMaxDuration = var_127_30

					if var_127_30 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_30 + var_127_23
					end
				end

				arg_124_1.text_.text = var_127_27
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171031", "story_v_out_324171.awb") ~= 0 then
					local var_127_31 = manager.audio:GetVoiceLength("story_v_out_324171", "324171031", "story_v_out_324171.awb") / 1000

					if var_127_31 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_31 + var_127_23
					end

					if var_127_26.prefab_name ~= "" and arg_124_1.actors_[var_127_26.prefab_name] ~= nil then
						local var_127_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_26.prefab_name].transform, "story_v_out_324171", "324171031", "story_v_out_324171.awb")

						arg_124_1:RecordAudio("324171031", var_127_32)
						arg_124_1:RecordAudio("324171031", var_127_32)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_324171", "324171031", "story_v_out_324171.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_324171", "324171031", "story_v_out_324171.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_33 = math.max(var_127_24, arg_124_1.talkMaxDuration)

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_33 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_23) / var_127_33

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_23 + var_127_33 and arg_124_1.time_ < var_127_23 + var_127_33 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play324171032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324171032
		arg_128_1.duration_ = 6.87

		local var_128_0 = {
			zh = 5.666,
			ja = 6.866
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
				arg_128_0:Play324171033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1170ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1170ui_story == nil then
				arg_128_1.var_.characterEffect1170ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1170ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1170ui_story then
				arg_128_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["1053ui_story"]
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1053ui_story == nil then
				arg_128_1.var_.characterEffect1053ui_story = var_131_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_6 = 0.200000002980232

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 and not isNil(var_131_4) then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6

				if arg_128_1.var_.characterEffect1053ui_story and not isNil(var_131_4) then
					local var_131_8 = Mathf.Lerp(0, 0.5, var_131_7)

					arg_128_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1053ui_story.fillRatio = var_131_8
				end
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1053ui_story then
				local var_131_9 = 0.5

				arg_128_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1053ui_story.fillRatio = var_131_9
			end

			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action5_2")
			end

			local var_131_11 = 0
			local var_131_12 = 0.45

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_13 = arg_128_1:FormatText(StoryNameCfg[318].name)

				arg_128_1.leftNameTxt_.text = var_131_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_14 = arg_128_1:GetWordFromCfg(324171032)
				local var_131_15 = arg_128_1:FormatText(var_131_14.content)

				arg_128_1.text_.text = var_131_15

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_16 = 18
				local var_131_17 = utf8.len(var_131_15)
				local var_131_18 = var_131_16 <= 0 and var_131_12 or var_131_12 * (var_131_17 / var_131_16)

				if var_131_18 > 0 and var_131_12 < var_131_18 then
					arg_128_1.talkMaxDuration = var_131_18

					if var_131_18 + var_131_11 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_18 + var_131_11
					end
				end

				arg_128_1.text_.text = var_131_15
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171032", "story_v_out_324171.awb") ~= 0 then
					local var_131_19 = manager.audio:GetVoiceLength("story_v_out_324171", "324171032", "story_v_out_324171.awb") / 1000

					if var_131_19 + var_131_11 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_19 + var_131_11
					end

					if var_131_14.prefab_name ~= "" and arg_128_1.actors_[var_131_14.prefab_name] ~= nil then
						local var_131_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_14.prefab_name].transform, "story_v_out_324171", "324171032", "story_v_out_324171.awb")

						arg_128_1:RecordAudio("324171032", var_131_20)
						arg_128_1:RecordAudio("324171032", var_131_20)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_324171", "324171032", "story_v_out_324171.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_324171", "324171032", "story_v_out_324171.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_21 = math.max(var_131_12, arg_128_1.talkMaxDuration)

			if var_131_11 <= arg_128_1.time_ and arg_128_1.time_ < var_131_11 + var_131_21 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_11) / var_131_21

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_11 + var_131_21 and arg_128_1.time_ < var_131_11 + var_131_21 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play324171033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324171033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324171034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1053ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1053ui_story = var_135_0.localPosition

				local var_135_2 = GameObjectTools.GetOrAddComponent(var_135_0.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(false)
				end
			end

			local var_135_3 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_3 then
				local var_135_4 = (arg_132_1.time_ - var_135_1) / var_135_3
				local var_135_5 = Vector3.New(0, 100, 0)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1053ui_story, var_135_5, var_135_4)

				local var_135_6 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_6.x, var_135_6.y, var_135_6.z)

				local var_135_7 = var_135_0.localEulerAngles

				var_135_7.z = 0
				var_135_7.x = 0
				var_135_0.localEulerAngles = var_135_7
			end

			if arg_132_1.time_ >= var_135_1 + var_135_3 and arg_132_1.time_ < var_135_1 + var_135_3 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, 100, 0)

				local var_135_8 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_8.x, var_135_8.y, var_135_8.z)

				local var_135_9 = var_135_0.localEulerAngles

				var_135_9.z = 0
				var_135_9.x = 0
				var_135_0.localEulerAngles = var_135_9

				local var_135_10 = GameObjectTools.GetOrAddComponent(var_135_0.gameObject, typeof(DynamicBoneHelper))

				if var_135_10 then
					var_135_10:EnableDynamicBone(true)
				end
			end

			local var_135_11 = arg_132_1.actors_["1170ui_story"].transform
			local var_135_12 = 0

			if var_135_12 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 then
				arg_132_1.var_.moveOldPos1170ui_story = var_135_11.localPosition

				local var_135_13 = GameObjectTools.GetOrAddComponent(var_135_11.gameObject, typeof(DynamicBoneHelper))

				if var_135_13 then
					var_135_13:EnableDynamicBone(false)
				end
			end

			local var_135_14 = 0.001

			if var_135_12 <= arg_132_1.time_ and arg_132_1.time_ < var_135_12 + var_135_14 then
				local var_135_15 = (arg_132_1.time_ - var_135_12) / var_135_14
				local var_135_16 = Vector3.New(0, 100, 0)

				var_135_11.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1170ui_story, var_135_16, var_135_15)

				local var_135_17 = manager.ui.mainCamera.transform.position - var_135_11.position

				var_135_11.forward = Vector3.New(var_135_17.x, var_135_17.y, var_135_17.z)

				local var_135_18 = var_135_11.localEulerAngles

				var_135_18.z = 0
				var_135_18.x = 0
				var_135_11.localEulerAngles = var_135_18
			end

			if arg_132_1.time_ >= var_135_12 + var_135_14 and arg_132_1.time_ < var_135_12 + var_135_14 + arg_135_0 then
				var_135_11.localPosition = Vector3.New(0, 100, 0)

				local var_135_19 = manager.ui.mainCamera.transform.position - var_135_11.position

				var_135_11.forward = Vector3.New(var_135_19.x, var_135_19.y, var_135_19.z)

				local var_135_20 = var_135_11.localEulerAngles

				var_135_20.z = 0
				var_135_20.x = 0
				var_135_11.localEulerAngles = var_135_20

				local var_135_21 = GameObjectTools.GetOrAddComponent(var_135_11.gameObject, typeof(DynamicBoneHelper))

				if var_135_21 then
					var_135_21:EnableDynamicBone(true)
				end
			end

			local var_135_22 = arg_132_1.actors_["1170ui_story"]
			local var_135_23 = 0

			if var_135_23 < arg_132_1.time_ and arg_132_1.time_ <= var_135_23 + arg_135_0 and not isNil(var_135_22) and arg_132_1.var_.characterEffect1170ui_story == nil then
				arg_132_1.var_.characterEffect1170ui_story = var_135_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_24 = 0.200000002980232

			if var_135_23 <= arg_132_1.time_ and arg_132_1.time_ < var_135_23 + var_135_24 and not isNil(var_135_22) then
				local var_135_25 = (arg_132_1.time_ - var_135_23) / var_135_24

				if arg_132_1.var_.characterEffect1170ui_story and not isNil(var_135_22) then
					local var_135_26 = Mathf.Lerp(0, 0.5, var_135_25)

					arg_132_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1170ui_story.fillRatio = var_135_26
				end
			end

			if arg_132_1.time_ >= var_135_23 + var_135_24 and arg_132_1.time_ < var_135_23 + var_135_24 + arg_135_0 and not isNil(var_135_22) and arg_132_1.var_.characterEffect1170ui_story then
				local var_135_27 = 0.5

				arg_132_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1170ui_story.fillRatio = var_135_27
			end

			local var_135_28 = 0
			local var_135_29 = 0.8

			if var_135_28 < arg_132_1.time_ and arg_132_1.time_ <= var_135_28 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_30 = arg_132_1:GetWordFromCfg(324171033)
				local var_135_31 = arg_132_1:FormatText(var_135_30.content)

				arg_132_1.text_.text = var_135_31

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_32 = 32
				local var_135_33 = utf8.len(var_135_31)
				local var_135_34 = var_135_32 <= 0 and var_135_29 or var_135_29 * (var_135_33 / var_135_32)

				if var_135_34 > 0 and var_135_29 < var_135_34 then
					arg_132_1.talkMaxDuration = var_135_34

					if var_135_34 + var_135_28 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_34 + var_135_28
					end
				end

				arg_132_1.text_.text = var_135_31
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_35 = math.max(var_135_29, arg_132_1.talkMaxDuration)

			if var_135_28 <= arg_132_1.time_ and arg_132_1.time_ < var_135_28 + var_135_35 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_28) / var_135_35

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_28 + var_135_35 and arg_132_1.time_ < var_135_28 + var_135_35 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play324171034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324171034
		arg_136_1.duration_ = 6.73

		local var_136_0 = {
			zh = 4.7,
			ja = 6.733
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
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play324171035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1053ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos1053ui_story = var_139_0.localPosition

				local var_139_2 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(false)
				end
			end

			local var_139_3 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_3 then
				local var_139_4 = (arg_136_1.time_ - var_139_1) / var_139_3
				local var_139_5 = Vector3.New(0.7, -1.08, -6)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1053ui_story, var_139_5, var_139_4)

				local var_139_6 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_6.x, var_139_6.y, var_139_6.z)

				local var_139_7 = var_139_0.localEulerAngles

				var_139_7.z = 0
				var_139_7.x = 0
				var_139_0.localEulerAngles = var_139_7
			end

			if arg_136_1.time_ >= var_139_1 + var_139_3 and arg_136_1.time_ < var_139_1 + var_139_3 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_139_8 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_8.x, var_139_8.y, var_139_8.z)

				local var_139_9 = var_139_0.localEulerAngles

				var_139_9.z = 0
				var_139_9.x = 0
				var_139_0.localEulerAngles = var_139_9

				local var_139_10 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_10 then
					var_139_10:EnableDynamicBone(true)
				end
			end

			local var_139_11 = arg_136_1.actors_["1053ui_story"]
			local var_139_12 = 0

			if var_139_12 < arg_136_1.time_ and arg_136_1.time_ <= var_139_12 + arg_139_0 and not isNil(var_139_11) and arg_136_1.var_.characterEffect1053ui_story == nil then
				arg_136_1.var_.characterEffect1053ui_story = var_139_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_13 = 0.200000002980232

			if var_139_12 <= arg_136_1.time_ and arg_136_1.time_ < var_139_12 + var_139_13 and not isNil(var_139_11) then
				local var_139_14 = (arg_136_1.time_ - var_139_12) / var_139_13

				if arg_136_1.var_.characterEffect1053ui_story and not isNil(var_139_11) then
					arg_136_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_12 + var_139_13 and arg_136_1.time_ < var_139_12 + var_139_13 + arg_139_0 and not isNil(var_139_11) and arg_136_1.var_.characterEffect1053ui_story then
				arg_136_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_139_15 = 0

			if var_139_15 < arg_136_1.time_ and arg_136_1.time_ <= var_139_15 + arg_139_0 then
				arg_136_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_1")
			end

			local var_139_16 = 0
			local var_139_17 = 0.4

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_18 = arg_136_1:FormatText(StoryNameCfg[472].name)

				arg_136_1.leftNameTxt_.text = var_139_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_19 = arg_136_1:GetWordFromCfg(324171034)
				local var_139_20 = arg_136_1:FormatText(var_139_19.content)

				arg_136_1.text_.text = var_139_20

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_21 = 16
				local var_139_22 = utf8.len(var_139_20)
				local var_139_23 = var_139_21 <= 0 and var_139_17 or var_139_17 * (var_139_22 / var_139_21)

				if var_139_23 > 0 and var_139_17 < var_139_23 then
					arg_136_1.talkMaxDuration = var_139_23

					if var_139_23 + var_139_16 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_23 + var_139_16
					end
				end

				arg_136_1.text_.text = var_139_20
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171034", "story_v_out_324171.awb") ~= 0 then
					local var_139_24 = manager.audio:GetVoiceLength("story_v_out_324171", "324171034", "story_v_out_324171.awb") / 1000

					if var_139_24 + var_139_16 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_24 + var_139_16
					end

					if var_139_19.prefab_name ~= "" and arg_136_1.actors_[var_139_19.prefab_name] ~= nil then
						local var_139_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_19.prefab_name].transform, "story_v_out_324171", "324171034", "story_v_out_324171.awb")

						arg_136_1:RecordAudio("324171034", var_139_25)
						arg_136_1:RecordAudio("324171034", var_139_25)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_324171", "324171034", "story_v_out_324171.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_324171", "324171034", "story_v_out_324171.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_26 = math.max(var_139_17, arg_136_1.talkMaxDuration)

			if var_139_16 <= arg_136_1.time_ and arg_136_1.time_ < var_139_16 + var_139_26 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_16) / var_139_26

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_16 + var_139_26 and arg_136_1.time_ < var_139_16 + var_139_26 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play324171035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324171035
		arg_140_1.duration_ = 4.53

		local var_140_0 = {
			zh = 2.7,
			ja = 4.533
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play324171036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1170ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1170ui_story = var_143_0.localPosition

				local var_143_2 = GameObjectTools.GetOrAddComponent(var_143_0.gameObject, typeof(DynamicBoneHelper))

				if var_143_2 then
					var_143_2:EnableDynamicBone(false)
				end
			end

			local var_143_3 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_3 then
				local var_143_4 = (arg_140_1.time_ - var_143_1) / var_143_3
				local var_143_5 = Vector3.New(-0.68, -0.95, -6.08)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1170ui_story, var_143_5, var_143_4)

				local var_143_6 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_6.x, var_143_6.y, var_143_6.z)

				local var_143_7 = var_143_0.localEulerAngles

				var_143_7.z = 0
				var_143_7.x = 0
				var_143_0.localEulerAngles = var_143_7
			end

			if arg_140_1.time_ >= var_143_1 + var_143_3 and arg_140_1.time_ < var_143_1 + var_143_3 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(-0.68, -0.95, -6.08)

				local var_143_8 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_8.x, var_143_8.y, var_143_8.z)

				local var_143_9 = var_143_0.localEulerAngles

				var_143_9.z = 0
				var_143_9.x = 0
				var_143_0.localEulerAngles = var_143_9

				local var_143_10 = GameObjectTools.GetOrAddComponent(var_143_0.gameObject, typeof(DynamicBoneHelper))

				if var_143_10 then
					var_143_10:EnableDynamicBone(true)
				end
			end

			local var_143_11 = arg_140_1.actors_["1170ui_story"]
			local var_143_12 = 0

			if var_143_12 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 and not isNil(var_143_11) and arg_140_1.var_.characterEffect1170ui_story == nil then
				arg_140_1.var_.characterEffect1170ui_story = var_143_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_13 = 0.200000002980232

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_13 and not isNil(var_143_11) then
				local var_143_14 = (arg_140_1.time_ - var_143_12) / var_143_13

				if arg_140_1.var_.characterEffect1170ui_story and not isNil(var_143_11) then
					arg_140_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_12 + var_143_13 and arg_140_1.time_ < var_143_12 + var_143_13 + arg_143_0 and not isNil(var_143_11) and arg_140_1.var_.characterEffect1170ui_story then
				arg_140_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_143_15 = arg_140_1.actors_["1053ui_story"]
			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 and not isNil(var_143_15) and arg_140_1.var_.characterEffect1053ui_story == nil then
				arg_140_1.var_.characterEffect1053ui_story = var_143_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_17 = 0.200000002980232

			if var_143_16 <= arg_140_1.time_ and arg_140_1.time_ < var_143_16 + var_143_17 and not isNil(var_143_15) then
				local var_143_18 = (arg_140_1.time_ - var_143_16) / var_143_17

				if arg_140_1.var_.characterEffect1053ui_story and not isNil(var_143_15) then
					local var_143_19 = Mathf.Lerp(0, 0.5, var_143_18)

					arg_140_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1053ui_story.fillRatio = var_143_19
				end
			end

			if arg_140_1.time_ >= var_143_16 + var_143_17 and arg_140_1.time_ < var_143_16 + var_143_17 + arg_143_0 and not isNil(var_143_15) and arg_140_1.var_.characterEffect1053ui_story then
				local var_143_20 = 0.5

				arg_140_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1053ui_story.fillRatio = var_143_20
			end

			local var_143_21 = 0

			if var_143_21 < arg_140_1.time_ and arg_140_1.time_ <= var_143_21 + arg_143_0 then
				arg_140_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action4_1")
			end

			local var_143_22 = 0

			if var_143_22 < arg_140_1.time_ and arg_140_1.time_ <= var_143_22 + arg_143_0 then
				arg_140_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_143_23 = 0
			local var_143_24 = 0.275

			if var_143_23 < arg_140_1.time_ and arg_140_1.time_ <= var_143_23 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_25 = arg_140_1:FormatText(StoryNameCfg[318].name)

				arg_140_1.leftNameTxt_.text = var_143_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_26 = arg_140_1:GetWordFromCfg(324171035)
				local var_143_27 = arg_140_1:FormatText(var_143_26.content)

				arg_140_1.text_.text = var_143_27

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_28 = 11
				local var_143_29 = utf8.len(var_143_27)
				local var_143_30 = var_143_28 <= 0 and var_143_24 or var_143_24 * (var_143_29 / var_143_28)

				if var_143_30 > 0 and var_143_24 < var_143_30 then
					arg_140_1.talkMaxDuration = var_143_30

					if var_143_30 + var_143_23 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_30 + var_143_23
					end
				end

				arg_140_1.text_.text = var_143_27
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171035", "story_v_out_324171.awb") ~= 0 then
					local var_143_31 = manager.audio:GetVoiceLength("story_v_out_324171", "324171035", "story_v_out_324171.awb") / 1000

					if var_143_31 + var_143_23 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_31 + var_143_23
					end

					if var_143_26.prefab_name ~= "" and arg_140_1.actors_[var_143_26.prefab_name] ~= nil then
						local var_143_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_26.prefab_name].transform, "story_v_out_324171", "324171035", "story_v_out_324171.awb")

						arg_140_1:RecordAudio("324171035", var_143_32)
						arg_140_1:RecordAudio("324171035", var_143_32)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_324171", "324171035", "story_v_out_324171.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_324171", "324171035", "story_v_out_324171.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_33 = math.max(var_143_24, arg_140_1.talkMaxDuration)

			if var_143_23 <= arg_140_1.time_ and arg_140_1.time_ < var_143_23 + var_143_33 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_23) / var_143_33

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_23 + var_143_33 and arg_140_1.time_ < var_143_23 + var_143_33 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play324171036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324171036
		arg_144_1.duration_ = 6.3

		local var_144_0 = {
			zh = 5.366,
			ja = 6.3
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play324171037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.6

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[318].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_3 = arg_144_1:GetWordFromCfg(324171036)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 24
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171036", "story_v_out_324171.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171036", "story_v_out_324171.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_324171", "324171036", "story_v_out_324171.awb")

						arg_144_1:RecordAudio("324171036", var_147_9)
						arg_144_1:RecordAudio("324171036", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_324171", "324171036", "story_v_out_324171.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_324171", "324171036", "story_v_out_324171.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_10 and arg_144_1.time_ < var_147_0 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play324171037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324171037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play324171038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1170ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1170ui_story = var_151_0.localPosition

				local var_151_2 = GameObjectTools.GetOrAddComponent(var_151_0.gameObject, typeof(DynamicBoneHelper))

				if var_151_2 then
					var_151_2:EnableDynamicBone(false)
				end
			end

			local var_151_3 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_3 then
				local var_151_4 = (arg_148_1.time_ - var_151_1) / var_151_3
				local var_151_5 = Vector3.New(0, 100, 0)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1170ui_story, var_151_5, var_151_4)

				local var_151_6 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_6.x, var_151_6.y, var_151_6.z)

				local var_151_7 = var_151_0.localEulerAngles

				var_151_7.z = 0
				var_151_7.x = 0
				var_151_0.localEulerAngles = var_151_7
			end

			if arg_148_1.time_ >= var_151_1 + var_151_3 and arg_148_1.time_ < var_151_1 + var_151_3 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, 100, 0)

				local var_151_8 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_8.x, var_151_8.y, var_151_8.z)

				local var_151_9 = var_151_0.localEulerAngles

				var_151_9.z = 0
				var_151_9.x = 0
				var_151_0.localEulerAngles = var_151_9

				local var_151_10 = GameObjectTools.GetOrAddComponent(var_151_0.gameObject, typeof(DynamicBoneHelper))

				if var_151_10 then
					var_151_10:EnableDynamicBone(true)
				end
			end

			local var_151_11 = arg_148_1.actors_["1053ui_story"].transform
			local var_151_12 = 0

			if var_151_12 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 then
				arg_148_1.var_.moveOldPos1053ui_story = var_151_11.localPosition

				local var_151_13 = GameObjectTools.GetOrAddComponent(var_151_11.gameObject, typeof(DynamicBoneHelper))

				if var_151_13 then
					var_151_13:EnableDynamicBone(false)
				end
			end

			local var_151_14 = 0.001

			if var_151_12 <= arg_148_1.time_ and arg_148_1.time_ < var_151_12 + var_151_14 then
				local var_151_15 = (arg_148_1.time_ - var_151_12) / var_151_14
				local var_151_16 = Vector3.New(0, 100, 0)

				var_151_11.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1053ui_story, var_151_16, var_151_15)

				local var_151_17 = manager.ui.mainCamera.transform.position - var_151_11.position

				var_151_11.forward = Vector3.New(var_151_17.x, var_151_17.y, var_151_17.z)

				local var_151_18 = var_151_11.localEulerAngles

				var_151_18.z = 0
				var_151_18.x = 0
				var_151_11.localEulerAngles = var_151_18
			end

			if arg_148_1.time_ >= var_151_12 + var_151_14 and arg_148_1.time_ < var_151_12 + var_151_14 + arg_151_0 then
				var_151_11.localPosition = Vector3.New(0, 100, 0)

				local var_151_19 = manager.ui.mainCamera.transform.position - var_151_11.position

				var_151_11.forward = Vector3.New(var_151_19.x, var_151_19.y, var_151_19.z)

				local var_151_20 = var_151_11.localEulerAngles

				var_151_20.z = 0
				var_151_20.x = 0
				var_151_11.localEulerAngles = var_151_20

				local var_151_21 = GameObjectTools.GetOrAddComponent(var_151_11.gameObject, typeof(DynamicBoneHelper))

				if var_151_21 then
					var_151_21:EnableDynamicBone(true)
				end
			end

			local var_151_22 = arg_148_1.actors_["1170ui_story"]
			local var_151_23 = 0

			if var_151_23 < arg_148_1.time_ and arg_148_1.time_ <= var_151_23 + arg_151_0 and not isNil(var_151_22) and arg_148_1.var_.characterEffect1170ui_story == nil then
				arg_148_1.var_.characterEffect1170ui_story = var_151_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_24 = 0.200000002980232

			if var_151_23 <= arg_148_1.time_ and arg_148_1.time_ < var_151_23 + var_151_24 and not isNil(var_151_22) then
				local var_151_25 = (arg_148_1.time_ - var_151_23) / var_151_24

				if arg_148_1.var_.characterEffect1170ui_story and not isNil(var_151_22) then
					local var_151_26 = Mathf.Lerp(0, 0.5, var_151_25)

					arg_148_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1170ui_story.fillRatio = var_151_26
				end
			end

			if arg_148_1.time_ >= var_151_23 + var_151_24 and arg_148_1.time_ < var_151_23 + var_151_24 + arg_151_0 and not isNil(var_151_22) and arg_148_1.var_.characterEffect1170ui_story then
				local var_151_27 = 0.5

				arg_148_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1170ui_story.fillRatio = var_151_27
			end

			local var_151_28 = 0
			local var_151_29 = 1.25

			if var_151_28 < arg_148_1.time_ and arg_148_1.time_ <= var_151_28 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_30 = arg_148_1:GetWordFromCfg(324171037)
				local var_151_31 = arg_148_1:FormatText(var_151_30.content)

				arg_148_1.text_.text = var_151_31

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_32 = 50
				local var_151_33 = utf8.len(var_151_31)
				local var_151_34 = var_151_32 <= 0 and var_151_29 or var_151_29 * (var_151_33 / var_151_32)

				if var_151_34 > 0 and var_151_29 < var_151_34 then
					arg_148_1.talkMaxDuration = var_151_34

					if var_151_34 + var_151_28 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_34 + var_151_28
					end
				end

				arg_148_1.text_.text = var_151_31
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_35 = math.max(var_151_29, arg_148_1.talkMaxDuration)

			if var_151_28 <= arg_148_1.time_ and arg_148_1.time_ < var_151_28 + var_151_35 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_28) / var_151_35

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_28 + var_151_35 and arg_148_1.time_ < var_151_28 + var_151_35 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play324171038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324171038
		arg_152_1.duration_ = 4.27

		local var_152_0 = {
			zh = 2.966,
			ja = 4.266
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play324171039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1053ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1053ui_story = var_155_0.localPosition

				local var_155_2 = GameObjectTools.GetOrAddComponent(var_155_0.gameObject, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(false)
				end
			end

			local var_155_3 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_3 then
				local var_155_4 = (arg_152_1.time_ - var_155_1) / var_155_3
				local var_155_5 = Vector3.New(0, -1.08, -6)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1053ui_story, var_155_5, var_155_4)

				local var_155_6 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_6.x, var_155_6.y, var_155_6.z)

				local var_155_7 = var_155_0.localEulerAngles

				var_155_7.z = 0
				var_155_7.x = 0
				var_155_0.localEulerAngles = var_155_7
			end

			if arg_152_1.time_ >= var_155_1 + var_155_3 and arg_152_1.time_ < var_155_1 + var_155_3 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_155_8 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_8.x, var_155_8.y, var_155_8.z)

				local var_155_9 = var_155_0.localEulerAngles

				var_155_9.z = 0
				var_155_9.x = 0
				var_155_0.localEulerAngles = var_155_9

				local var_155_10 = GameObjectTools.GetOrAddComponent(var_155_0.gameObject, typeof(DynamicBoneHelper))

				if var_155_10 then
					var_155_10:EnableDynamicBone(true)
				end
			end

			local var_155_11 = arg_152_1.actors_["1053ui_story"]
			local var_155_12 = 0

			if var_155_12 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 and not isNil(var_155_11) and arg_152_1.var_.characterEffect1053ui_story == nil then
				arg_152_1.var_.characterEffect1053ui_story = var_155_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_13 = 0.200000002980232

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_13 and not isNil(var_155_11) then
				local var_155_14 = (arg_152_1.time_ - var_155_12) / var_155_13

				if arg_152_1.var_.characterEffect1053ui_story and not isNil(var_155_11) then
					arg_152_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_12 + var_155_13 and arg_152_1.time_ < var_155_12 + var_155_13 + arg_155_0 and not isNil(var_155_11) and arg_152_1.var_.characterEffect1053ui_story then
				arg_152_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_155_15 = 0

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_2")
			end

			local var_155_16 = 0

			if var_155_16 < arg_152_1.time_ and arg_152_1.time_ <= var_155_16 + arg_155_0 then
				arg_152_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_155_17 = 0
			local var_155_18 = 0.275

			if var_155_17 < arg_152_1.time_ and arg_152_1.time_ <= var_155_17 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_19 = arg_152_1:FormatText(StoryNameCfg[472].name)

				arg_152_1.leftNameTxt_.text = var_155_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_20 = arg_152_1:GetWordFromCfg(324171038)
				local var_155_21 = arg_152_1:FormatText(var_155_20.content)

				arg_152_1.text_.text = var_155_21

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_22 = 11
				local var_155_23 = utf8.len(var_155_21)
				local var_155_24 = var_155_22 <= 0 and var_155_18 or var_155_18 * (var_155_23 / var_155_22)

				if var_155_24 > 0 and var_155_18 < var_155_24 then
					arg_152_1.talkMaxDuration = var_155_24

					if var_155_24 + var_155_17 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_24 + var_155_17
					end
				end

				arg_152_1.text_.text = var_155_21
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171038", "story_v_out_324171.awb") ~= 0 then
					local var_155_25 = manager.audio:GetVoiceLength("story_v_out_324171", "324171038", "story_v_out_324171.awb") / 1000

					if var_155_25 + var_155_17 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_25 + var_155_17
					end

					if var_155_20.prefab_name ~= "" and arg_152_1.actors_[var_155_20.prefab_name] ~= nil then
						local var_155_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_20.prefab_name].transform, "story_v_out_324171", "324171038", "story_v_out_324171.awb")

						arg_152_1:RecordAudio("324171038", var_155_26)
						arg_152_1:RecordAudio("324171038", var_155_26)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_324171", "324171038", "story_v_out_324171.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_324171", "324171038", "story_v_out_324171.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_27 = math.max(var_155_18, arg_152_1.talkMaxDuration)

			if var_155_17 <= arg_152_1.time_ and arg_152_1.time_ < var_155_17 + var_155_27 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_17) / var_155_27

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_17 + var_155_27 and arg_152_1.time_ < var_155_17 + var_155_27 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play324171039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324171039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324171040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1053ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1053ui_story = var_159_0.localPosition

				local var_159_2 = GameObjectTools.GetOrAddComponent(var_159_0.gameObject, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(false)
				end
			end

			local var_159_3 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_3 then
				local var_159_4 = (arg_156_1.time_ - var_159_1) / var_159_3
				local var_159_5 = Vector3.New(0, 100, 0)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1053ui_story, var_159_5, var_159_4)

				local var_159_6 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_6.x, var_159_6.y, var_159_6.z)

				local var_159_7 = var_159_0.localEulerAngles

				var_159_7.z = 0
				var_159_7.x = 0
				var_159_0.localEulerAngles = var_159_7
			end

			if arg_156_1.time_ >= var_159_1 + var_159_3 and arg_156_1.time_ < var_159_1 + var_159_3 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, 100, 0)

				local var_159_8 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_8.x, var_159_8.y, var_159_8.z)

				local var_159_9 = var_159_0.localEulerAngles

				var_159_9.z = 0
				var_159_9.x = 0
				var_159_0.localEulerAngles = var_159_9

				local var_159_10 = GameObjectTools.GetOrAddComponent(var_159_0.gameObject, typeof(DynamicBoneHelper))

				if var_159_10 then
					var_159_10:EnableDynamicBone(true)
				end
			end

			local var_159_11 = arg_156_1.actors_["1053ui_story"]
			local var_159_12 = 0

			if var_159_12 < arg_156_1.time_ and arg_156_1.time_ <= var_159_12 + arg_159_0 and not isNil(var_159_11) and arg_156_1.var_.characterEffect1053ui_story == nil then
				arg_156_1.var_.characterEffect1053ui_story = var_159_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_13 = 0.200000002980232

			if var_159_12 <= arg_156_1.time_ and arg_156_1.time_ < var_159_12 + var_159_13 and not isNil(var_159_11) then
				local var_159_14 = (arg_156_1.time_ - var_159_12) / var_159_13

				if arg_156_1.var_.characterEffect1053ui_story and not isNil(var_159_11) then
					local var_159_15 = Mathf.Lerp(0, 0.5, var_159_14)

					arg_156_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1053ui_story.fillRatio = var_159_15
				end
			end

			if arg_156_1.time_ >= var_159_12 + var_159_13 and arg_156_1.time_ < var_159_12 + var_159_13 + arg_159_0 and not isNil(var_159_11) and arg_156_1.var_.characterEffect1053ui_story then
				local var_159_16 = 0.5

				arg_156_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1053ui_story.fillRatio = var_159_16
			end

			local var_159_17 = 0
			local var_159_18 = 1.325

			if var_159_17 < arg_156_1.time_ and arg_156_1.time_ <= var_159_17 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_19 = arg_156_1:GetWordFromCfg(324171039)
				local var_159_20 = arg_156_1:FormatText(var_159_19.content)

				arg_156_1.text_.text = var_159_20

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_21 = 53
				local var_159_22 = utf8.len(var_159_20)
				local var_159_23 = var_159_21 <= 0 and var_159_18 or var_159_18 * (var_159_22 / var_159_21)

				if var_159_23 > 0 and var_159_18 < var_159_23 then
					arg_156_1.talkMaxDuration = var_159_23

					if var_159_23 + var_159_17 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_17
					end
				end

				arg_156_1.text_.text = var_159_20
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_24 = math.max(var_159_18, arg_156_1.talkMaxDuration)

			if var_159_17 <= arg_156_1.time_ and arg_156_1.time_ < var_159_17 + var_159_24 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_17) / var_159_24

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_17 + var_159_24 and arg_156_1.time_ < var_159_17 + var_159_24 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play324171040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324171040
		arg_160_1.duration_ = 6.7

		local var_160_0 = {
			zh = 6.6,
			ja = 6.7
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play324171041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1053ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos1053ui_story = var_163_0.localPosition

				local var_163_2 = GameObjectTools.GetOrAddComponent(var_163_0.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(false)
				end
			end

			local var_163_3 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_3 then
				local var_163_4 = (arg_160_1.time_ - var_163_1) / var_163_3
				local var_163_5 = Vector3.New(0, -1.08, -6)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1053ui_story, var_163_5, var_163_4)

				local var_163_6 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_6.x, var_163_6.y, var_163_6.z)

				local var_163_7 = var_163_0.localEulerAngles

				var_163_7.z = 0
				var_163_7.x = 0
				var_163_0.localEulerAngles = var_163_7
			end

			if arg_160_1.time_ >= var_163_1 + var_163_3 and arg_160_1.time_ < var_163_1 + var_163_3 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_163_8 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_8.x, var_163_8.y, var_163_8.z)

				local var_163_9 = var_163_0.localEulerAngles

				var_163_9.z = 0
				var_163_9.x = 0
				var_163_0.localEulerAngles = var_163_9

				local var_163_10 = GameObjectTools.GetOrAddComponent(var_163_0.gameObject, typeof(DynamicBoneHelper))

				if var_163_10 then
					var_163_10:EnableDynamicBone(true)
				end
			end

			local var_163_11 = arg_160_1.actors_["1053ui_story"]
			local var_163_12 = 0

			if var_163_12 < arg_160_1.time_ and arg_160_1.time_ <= var_163_12 + arg_163_0 and not isNil(var_163_11) and arg_160_1.var_.characterEffect1053ui_story == nil then
				arg_160_1.var_.characterEffect1053ui_story = var_163_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_13 = 0.200000002980232

			if var_163_12 <= arg_160_1.time_ and arg_160_1.time_ < var_163_12 + var_163_13 and not isNil(var_163_11) then
				local var_163_14 = (arg_160_1.time_ - var_163_12) / var_163_13

				if arg_160_1.var_.characterEffect1053ui_story and not isNil(var_163_11) then
					arg_160_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_12 + var_163_13 and arg_160_1.time_ < var_163_12 + var_163_13 + arg_163_0 and not isNil(var_163_11) and arg_160_1.var_.characterEffect1053ui_story then
				arg_160_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_163_15 = 0

			if var_163_15 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 then
				arg_160_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_163_16 = 0

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_163_17 = 0
			local var_163_18 = 0.45

			if var_163_17 < arg_160_1.time_ and arg_160_1.time_ <= var_163_17 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_19 = arg_160_1:FormatText(StoryNameCfg[472].name)

				arg_160_1.leftNameTxt_.text = var_163_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_20 = arg_160_1:GetWordFromCfg(324171040)
				local var_163_21 = arg_160_1:FormatText(var_163_20.content)

				arg_160_1.text_.text = var_163_21

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_22 = 18
				local var_163_23 = utf8.len(var_163_21)
				local var_163_24 = var_163_22 <= 0 and var_163_18 or var_163_18 * (var_163_23 / var_163_22)

				if var_163_24 > 0 and var_163_18 < var_163_24 then
					arg_160_1.talkMaxDuration = var_163_24

					if var_163_24 + var_163_17 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_24 + var_163_17
					end
				end

				arg_160_1.text_.text = var_163_21
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171040", "story_v_out_324171.awb") ~= 0 then
					local var_163_25 = manager.audio:GetVoiceLength("story_v_out_324171", "324171040", "story_v_out_324171.awb") / 1000

					if var_163_25 + var_163_17 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_25 + var_163_17
					end

					if var_163_20.prefab_name ~= "" and arg_160_1.actors_[var_163_20.prefab_name] ~= nil then
						local var_163_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_20.prefab_name].transform, "story_v_out_324171", "324171040", "story_v_out_324171.awb")

						arg_160_1:RecordAudio("324171040", var_163_26)
						arg_160_1:RecordAudio("324171040", var_163_26)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_324171", "324171040", "story_v_out_324171.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_324171", "324171040", "story_v_out_324171.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_27 = math.max(var_163_18, arg_160_1.talkMaxDuration)

			if var_163_17 <= arg_160_1.time_ and arg_160_1.time_ < var_163_17 + var_163_27 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_17) / var_163_27

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_17 + var_163_27 and arg_160_1.time_ < var_163_17 + var_163_27 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play324171041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324171041
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play324171042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1053ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1053ui_story = var_167_0.localPosition

				local var_167_2 = GameObjectTools.GetOrAddComponent(var_167_0.gameObject, typeof(DynamicBoneHelper))

				if var_167_2 then
					var_167_2:EnableDynamicBone(false)
				end
			end

			local var_167_3 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_3 then
				local var_167_4 = (arg_164_1.time_ - var_167_1) / var_167_3
				local var_167_5 = Vector3.New(0, 100, 0)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1053ui_story, var_167_5, var_167_4)

				local var_167_6 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_6.x, var_167_6.y, var_167_6.z)

				local var_167_7 = var_167_0.localEulerAngles

				var_167_7.z = 0
				var_167_7.x = 0
				var_167_0.localEulerAngles = var_167_7
			end

			if arg_164_1.time_ >= var_167_1 + var_167_3 and arg_164_1.time_ < var_167_1 + var_167_3 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0, 100, 0)

				local var_167_8 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_8.x, var_167_8.y, var_167_8.z)

				local var_167_9 = var_167_0.localEulerAngles

				var_167_9.z = 0
				var_167_9.x = 0
				var_167_0.localEulerAngles = var_167_9

				local var_167_10 = GameObjectTools.GetOrAddComponent(var_167_0.gameObject, typeof(DynamicBoneHelper))

				if var_167_10 then
					var_167_10:EnableDynamicBone(true)
				end
			end

			local var_167_11 = arg_164_1.actors_["1053ui_story"]
			local var_167_12 = 0

			if var_167_12 < arg_164_1.time_ and arg_164_1.time_ <= var_167_12 + arg_167_0 and not isNil(var_167_11) and arg_164_1.var_.characterEffect1053ui_story == nil then
				arg_164_1.var_.characterEffect1053ui_story = var_167_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_13 = 0.200000002980232

			if var_167_12 <= arg_164_1.time_ and arg_164_1.time_ < var_167_12 + var_167_13 and not isNil(var_167_11) then
				local var_167_14 = (arg_164_1.time_ - var_167_12) / var_167_13

				if arg_164_1.var_.characterEffect1053ui_story and not isNil(var_167_11) then
					local var_167_15 = Mathf.Lerp(0, 0.5, var_167_14)

					arg_164_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1053ui_story.fillRatio = var_167_15
				end
			end

			if arg_164_1.time_ >= var_167_12 + var_167_13 and arg_164_1.time_ < var_167_12 + var_167_13 + arg_167_0 and not isNil(var_167_11) and arg_164_1.var_.characterEffect1053ui_story then
				local var_167_16 = 0.5

				arg_164_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1053ui_story.fillRatio = var_167_16
			end

			local var_167_17 = 0
			local var_167_18 = 1.1

			if var_167_17 < arg_164_1.time_ and arg_164_1.time_ <= var_167_17 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_19 = arg_164_1:GetWordFromCfg(324171041)
				local var_167_20 = arg_164_1:FormatText(var_167_19.content)

				arg_164_1.text_.text = var_167_20

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_21 = 44
				local var_167_22 = utf8.len(var_167_20)
				local var_167_23 = var_167_21 <= 0 and var_167_18 or var_167_18 * (var_167_22 / var_167_21)

				if var_167_23 > 0 and var_167_18 < var_167_23 then
					arg_164_1.talkMaxDuration = var_167_23

					if var_167_23 + var_167_17 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_23 + var_167_17
					end
				end

				arg_164_1.text_.text = var_167_20
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_24 = math.max(var_167_18, arg_164_1.talkMaxDuration)

			if var_167_17 <= arg_164_1.time_ and arg_164_1.time_ < var_167_17 + var_167_24 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_17) / var_167_24

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_17 + var_167_24 and arg_164_1.time_ < var_167_17 + var_167_24 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play324171042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324171042
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play324171043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 1

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				local var_171_2 = "play"
				local var_171_3 = "effect"

				arg_168_1:AudioAction(var_171_2, var_171_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_171_4 = 0
			local var_171_5 = 1.5

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_6 = arg_168_1:GetWordFromCfg(324171042)
				local var_171_7 = arg_168_1:FormatText(var_171_6.content)

				arg_168_1.text_.text = var_171_7

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_8 = 60
				local var_171_9 = utf8.len(var_171_7)
				local var_171_10 = var_171_8 <= 0 and var_171_5 or var_171_5 * (var_171_9 / var_171_8)

				if var_171_10 > 0 and var_171_5 < var_171_10 then
					arg_168_1.talkMaxDuration = var_171_10

					if var_171_10 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_4
					end
				end

				arg_168_1.text_.text = var_171_7
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_11 = math.max(var_171_5, arg_168_1.talkMaxDuration)

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_11 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_4) / var_171_11

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_4 + var_171_11 and arg_168_1.time_ < var_171_4 + var_171_11 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play324171043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324171043
		arg_172_1.duration_ = 8.83

		local var_172_0 = {
			zh = 6.76633333631356,
			ja = 8.83333333631357
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324171044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = "J13g"

			if arg_172_1.bgs_[var_175_0] == nil then
				local var_175_1 = Object.Instantiate(arg_172_1.paintGo_)

				var_175_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_175_0)
				var_175_1.name = var_175_0
				var_175_1.transform.parent = arg_172_1.stage_.transform
				var_175_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_172_1.bgs_[var_175_0] = var_175_1
			end

			local var_175_2 = 2

			if var_175_2 < arg_172_1.time_ and arg_172_1.time_ <= var_175_2 + arg_175_0 then
				local var_175_3 = manager.ui.mainCamera.transform.localPosition
				local var_175_4 = Vector3.New(0, 0, 10) + Vector3.New(var_175_3.x, var_175_3.y, 0)
				local var_175_5 = arg_172_1.bgs_.J13g

				var_175_5.transform.localPosition = var_175_4
				var_175_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_175_6 = var_175_5:GetComponent("SpriteRenderer")

				if var_175_6 and var_175_6.sprite then
					local var_175_7 = (var_175_5.transform.localPosition - var_175_3).z
					local var_175_8 = manager.ui.mainCameraCom_
					local var_175_9 = 2 * var_175_7 * Mathf.Tan(var_175_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_175_10 = var_175_9 * var_175_8.aspect
					local var_175_11 = var_175_6.sprite.bounds.size.x
					local var_175_12 = var_175_6.sprite.bounds.size.y
					local var_175_13 = var_175_10 / var_175_11
					local var_175_14 = var_175_9 / var_175_12
					local var_175_15 = var_175_14 < var_175_13 and var_175_13 or var_175_14

					var_175_5.transform.localScale = Vector3.New(var_175_15, var_175_15, 0)
				end

				for iter_175_0, iter_175_1 in pairs(arg_172_1.bgs_) do
					if iter_175_0 ~= "J13g" then
						iter_175_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_175_16 = 0

			if var_175_16 < arg_172_1.time_ and arg_172_1.time_ <= var_175_16 + arg_175_0 then
				arg_172_1.allBtn_.enabled = false
			end

			local var_175_17 = 0.3

			if arg_172_1.time_ >= var_175_16 + var_175_17 and arg_172_1.time_ < var_175_16 + var_175_17 + arg_175_0 then
				arg_172_1.allBtn_.enabled = true
			end

			local var_175_18 = 0

			if var_175_18 < arg_172_1.time_ and arg_172_1.time_ <= var_175_18 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_19 = 2

			if var_175_18 <= arg_172_1.time_ and arg_172_1.time_ < var_175_18 + var_175_19 then
				local var_175_20 = (arg_172_1.time_ - var_175_18) / var_175_19
				local var_175_21 = Color.New(0, 0, 0)

				var_175_21.a = Mathf.Lerp(0, 1, var_175_20)
				arg_172_1.mask_.color = var_175_21
			end

			if arg_172_1.time_ >= var_175_18 + var_175_19 and arg_172_1.time_ < var_175_18 + var_175_19 + arg_175_0 then
				local var_175_22 = Color.New(0, 0, 0)

				var_175_22.a = 1
				arg_172_1.mask_.color = var_175_22
			end

			local var_175_23 = 2

			if var_175_23 < arg_172_1.time_ and arg_172_1.time_ <= var_175_23 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_24 = 2

			if var_175_23 <= arg_172_1.time_ and arg_172_1.time_ < var_175_23 + var_175_24 then
				local var_175_25 = (arg_172_1.time_ - var_175_23) / var_175_24
				local var_175_26 = Color.New(0, 0, 0)

				var_175_26.a = Mathf.Lerp(1, 0, var_175_25)
				arg_172_1.mask_.color = var_175_26
			end

			if arg_172_1.time_ >= var_175_23 + var_175_24 and arg_172_1.time_ < var_175_23 + var_175_24 + arg_175_0 then
				local var_175_27 = Color.New(0, 0, 0)
				local var_175_28 = 0

				arg_172_1.mask_.enabled = false
				var_175_27.a = var_175_28
				arg_172_1.mask_.color = var_175_27
			end

			local var_175_29 = arg_172_1.actors_["1170ui_story"].transform
			local var_175_30 = 3.53333333333333

			if var_175_30 < arg_172_1.time_ and arg_172_1.time_ <= var_175_30 + arg_175_0 then
				arg_172_1.var_.moveOldPos1170ui_story = var_175_29.localPosition

				local var_175_31 = GameObjectTools.GetOrAddComponent(var_175_29.gameObject, typeof(DynamicBoneHelper))

				if var_175_31 then
					var_175_31:EnableDynamicBone(false)
				end
			end

			local var_175_32 = 0.001

			if var_175_30 <= arg_172_1.time_ and arg_172_1.time_ < var_175_30 + var_175_32 then
				local var_175_33 = (arg_172_1.time_ - var_175_30) / var_175_32
				local var_175_34 = Vector3.New(0.03, -0.95, -6.08)

				var_175_29.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1170ui_story, var_175_34, var_175_33)

				local var_175_35 = manager.ui.mainCamera.transform.position - var_175_29.position

				var_175_29.forward = Vector3.New(var_175_35.x, var_175_35.y, var_175_35.z)

				local var_175_36 = var_175_29.localEulerAngles

				var_175_36.z = 0
				var_175_36.x = 0
				var_175_29.localEulerAngles = var_175_36
			end

			if arg_172_1.time_ >= var_175_30 + var_175_32 and arg_172_1.time_ < var_175_30 + var_175_32 + arg_175_0 then
				var_175_29.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_175_37 = manager.ui.mainCamera.transform.position - var_175_29.position

				var_175_29.forward = Vector3.New(var_175_37.x, var_175_37.y, var_175_37.z)

				local var_175_38 = var_175_29.localEulerAngles

				var_175_38.z = 0
				var_175_38.x = 0
				var_175_29.localEulerAngles = var_175_38

				local var_175_39 = GameObjectTools.GetOrAddComponent(var_175_29.gameObject, typeof(DynamicBoneHelper))

				if var_175_39 then
					var_175_39:EnableDynamicBone(true)
				end
			end

			local var_175_40 = arg_172_1.actors_["1170ui_story"]
			local var_175_41 = 3.53333333333333

			if var_175_41 < arg_172_1.time_ and arg_172_1.time_ <= var_175_41 + arg_175_0 and not isNil(var_175_40) and arg_172_1.var_.characterEffect1170ui_story == nil then
				arg_172_1.var_.characterEffect1170ui_story = var_175_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_42 = 0.200000002980232

			if var_175_41 <= arg_172_1.time_ and arg_172_1.time_ < var_175_41 + var_175_42 and not isNil(var_175_40) then
				local var_175_43 = (arg_172_1.time_ - var_175_41) / var_175_42

				if arg_172_1.var_.characterEffect1170ui_story and not isNil(var_175_40) then
					arg_172_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_41 + var_175_42 and arg_172_1.time_ < var_175_41 + var_175_42 + arg_175_0 and not isNil(var_175_40) and arg_172_1.var_.characterEffect1170ui_story then
				arg_172_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_175_44 = arg_172_1.actors_["1053ui_story"]
			local var_175_45 = 3.53333333333333

			if var_175_45 < arg_172_1.time_ and arg_172_1.time_ <= var_175_45 + arg_175_0 and not isNil(var_175_44) and arg_172_1.var_.characterEffect1053ui_story == nil then
				arg_172_1.var_.characterEffect1053ui_story = var_175_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_46 = 0.200000002980232

			if var_175_45 <= arg_172_1.time_ and arg_172_1.time_ < var_175_45 + var_175_46 and not isNil(var_175_44) then
				local var_175_47 = (arg_172_1.time_ - var_175_45) / var_175_46

				if arg_172_1.var_.characterEffect1053ui_story and not isNil(var_175_44) then
					local var_175_48 = Mathf.Lerp(0, 0.5, var_175_47)

					arg_172_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1053ui_story.fillRatio = var_175_48
				end
			end

			if arg_172_1.time_ >= var_175_45 + var_175_46 and arg_172_1.time_ < var_175_45 + var_175_46 + arg_175_0 and not isNil(var_175_44) and arg_172_1.var_.characterEffect1053ui_story then
				local var_175_49 = 0.5

				arg_172_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1053ui_story.fillRatio = var_175_49
			end

			local var_175_50 = 3.53333333333333

			if var_175_50 < arg_172_1.time_ and arg_172_1.time_ <= var_175_50 + arg_175_0 then
				arg_172_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action1_1")
			end

			local var_175_51 = 3.53333333333333

			if var_175_51 < arg_172_1.time_ and arg_172_1.time_ <= var_175_51 + arg_175_0 then
				arg_172_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_175_52 = 1.2
			local var_175_53 = 1

			if var_175_52 < arg_172_1.time_ and arg_172_1.time_ <= var_175_52 + arg_175_0 then
				local var_175_54 = "play"
				local var_175_55 = "effect"

				arg_172_1:AudioAction(var_175_54, var_175_55, "se_story_1311", "se_story_1311_wind", "")
			end

			local var_175_56 = 0.1
			local var_175_57 = 1

			if var_175_56 < arg_172_1.time_ and arg_172_1.time_ <= var_175_56 + arg_175_0 then
				local var_175_58 = "stop"
				local var_175_59 = "effect"

				arg_172_1:AudioAction(var_175_58, var_175_59, "se_story_150", "se_story_150_amb_painting", "")
			end

			local var_175_60 = 0
			local var_175_61 = 1

			if var_175_60 < arg_172_1.time_ and arg_172_1.time_ <= var_175_60 + arg_175_0 then
				local var_175_62 = "play"
				local var_175_63 = "music"

				arg_172_1:AudioAction(var_175_62, var_175_63, "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain.awb")

				local var_175_64 = ""
				local var_175_65 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain")

				if var_175_65 ~= "" then
					if arg_172_1.bgmTxt_.text ~= var_175_65 and arg_172_1.bgmTxt_.text ~= "" then
						if arg_172_1.bgmTxt2_.text ~= "" then
							arg_172_1.bgmTxt_.text = arg_172_1.bgmTxt2_.text
						end

						arg_172_1.bgmTxt2_.text = var_175_65

						arg_172_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_172_1.bgmTxt_.text = var_175_65
						arg_172_1.bgmTxt2_.text = var_175_65
					end

					if arg_172_1.bgmTimer then
						arg_172_1.bgmTimer:Stop()

						arg_172_1.bgmTimer = nil
					end

					if arg_172_1.settingData.show_music_name == 1 then
						arg_172_1.musicController:SetSelectedState("show")
						arg_172_1.musicAnimator_:Play("open", 0, 0)

						if arg_172_1.settingData.music_time ~= 0 then
							arg_172_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_172_1.settingData.music_time), function()
								if arg_172_1 == nil or isNil(arg_172_1.bgmTxt_) then
									return
								end

								arg_172_1.musicController:SetSelectedState("hide")
								arg_172_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_172_1.frameCnt_ <= 1 then
				arg_172_1.dialog_:SetActive(false)
			end

			local var_175_66 = 3.83333333631357
			local var_175_67 = 0.325

			if var_175_66 < arg_172_1.time_ and arg_172_1.time_ <= var_175_66 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				arg_172_1.dialog_:SetActive(true)

				arg_172_1.dialogCg_.alpha = 0

				local var_175_68 = LeanTween.value(arg_172_1.dialog_, 0, 1, 0.3)

				var_175_68:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_172_1.dialogCg_.alpha = arg_177_0
				end))
				var_175_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_172_1.dialog_)
					var_175_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_172_1.duration_ = arg_172_1.duration_ + 0.3

				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_69 = arg_172_1:FormatText(StoryNameCfg[318].name)

				arg_172_1.leftNameTxt_.text = var_175_69

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_70 = arg_172_1:GetWordFromCfg(324171043)
				local var_175_71 = arg_172_1:FormatText(var_175_70.content)

				arg_172_1.text_.text = var_175_71

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_72 = 13
				local var_175_73 = utf8.len(var_175_71)
				local var_175_74 = var_175_72 <= 0 and var_175_67 or var_175_67 * (var_175_73 / var_175_72)

				if var_175_74 > 0 and var_175_67 < var_175_74 then
					arg_172_1.talkMaxDuration = var_175_74
					var_175_66 = var_175_66 + 0.3

					if var_175_74 + var_175_66 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_74 + var_175_66
					end
				end

				arg_172_1.text_.text = var_175_71
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171043", "story_v_out_324171.awb") ~= 0 then
					local var_175_75 = manager.audio:GetVoiceLength("story_v_out_324171", "324171043", "story_v_out_324171.awb") / 1000

					if var_175_75 + var_175_66 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_75 + var_175_66
					end

					if var_175_70.prefab_name ~= "" and arg_172_1.actors_[var_175_70.prefab_name] ~= nil then
						local var_175_76 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_70.prefab_name].transform, "story_v_out_324171", "324171043", "story_v_out_324171.awb")

						arg_172_1:RecordAudio("324171043", var_175_76)
						arg_172_1:RecordAudio("324171043", var_175_76)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_324171", "324171043", "story_v_out_324171.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_324171", "324171043", "story_v_out_324171.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_77 = var_175_66 + 0.3
			local var_175_78 = math.max(var_175_67, arg_172_1.talkMaxDuration)

			if var_175_77 <= arg_172_1.time_ and arg_172_1.time_ < var_175_77 + var_175_78 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_77) / var_175_78

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_77 + var_175_78 and arg_172_1.time_ < var_175_77 + var_175_78 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play324171044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 324171044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play324171045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1170ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos1170ui_story = var_182_0.localPosition

				local var_182_2 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(false)
				end
			end

			local var_182_3 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_3 then
				local var_182_4 = (arg_179_1.time_ - var_182_1) / var_182_3
				local var_182_5 = Vector3.New(0, 100, 0)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1170ui_story, var_182_5, var_182_4)

				local var_182_6 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_6.x, var_182_6.y, var_182_6.z)

				local var_182_7 = var_182_0.localEulerAngles

				var_182_7.z = 0
				var_182_7.x = 0
				var_182_0.localEulerAngles = var_182_7
			end

			if arg_179_1.time_ >= var_182_1 + var_182_3 and arg_179_1.time_ < var_182_1 + var_182_3 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0, 100, 0)

				local var_182_8 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_8.x, var_182_8.y, var_182_8.z)

				local var_182_9 = var_182_0.localEulerAngles

				var_182_9.z = 0
				var_182_9.x = 0
				var_182_0.localEulerAngles = var_182_9

				local var_182_10 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_10 then
					var_182_10:EnableDynamicBone(true)
				end
			end

			local var_182_11 = arg_179_1.actors_["1170ui_story"]
			local var_182_12 = 0

			if var_182_12 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect1170ui_story == nil then
				arg_179_1.var_.characterEffect1170ui_story = var_182_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_13 = 0.200000002980232

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_13 and not isNil(var_182_11) then
				local var_182_14 = (arg_179_1.time_ - var_182_12) / var_182_13

				if arg_179_1.var_.characterEffect1170ui_story and not isNil(var_182_11) then
					local var_182_15 = Mathf.Lerp(0, 0.5, var_182_14)

					arg_179_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1170ui_story.fillRatio = var_182_15
				end
			end

			if arg_179_1.time_ >= var_182_12 + var_182_13 and arg_179_1.time_ < var_182_12 + var_182_13 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect1170ui_story then
				local var_182_16 = 0.5

				arg_179_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1170ui_story.fillRatio = var_182_16
			end

			local var_182_17 = 0
			local var_182_18 = 0.55

			if var_182_17 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_19 = arg_179_1:GetWordFromCfg(324171044)
				local var_182_20 = arg_179_1:FormatText(var_182_19.content)

				arg_179_1.text_.text = var_182_20

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_21 = 22
				local var_182_22 = utf8.len(var_182_20)
				local var_182_23 = var_182_21 <= 0 and var_182_18 or var_182_18 * (var_182_22 / var_182_21)

				if var_182_23 > 0 and var_182_18 < var_182_23 then
					arg_179_1.talkMaxDuration = var_182_23

					if var_182_23 + var_182_17 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_23 + var_182_17
					end
				end

				arg_179_1.text_.text = var_182_20
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_24 = math.max(var_182_18, arg_179_1.talkMaxDuration)

			if var_182_17 <= arg_179_1.time_ and arg_179_1.time_ < var_182_17 + var_182_24 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_17) / var_182_24

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_17 + var_182_24 and arg_179_1.time_ < var_182_17 + var_182_24 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play324171045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 324171045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play324171046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.1
			local var_186_1 = 1

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				local var_186_2 = "play"
				local var_186_3 = "effect"

				arg_183_1:AudioAction(var_186_2, var_186_3, "se_story_150", "se_story_150_sword08", "")
			end

			local var_186_4 = 0
			local var_186_5 = 1.15

			if var_186_4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(324171045)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_8 = 46
				local var_186_9 = utf8.len(var_186_7)
				local var_186_10 = var_186_8 <= 0 and var_186_5 or var_186_5 * (var_186_9 / var_186_8)

				if var_186_10 > 0 and var_186_5 < var_186_10 then
					arg_183_1.talkMaxDuration = var_186_10

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_11 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_11 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_11

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_11 and arg_183_1.time_ < var_186_4 + var_186_11 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play324171046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 324171046
		arg_187_1.duration_ = 5.5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play324171047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = manager.ui.mainCamera.transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				local var_190_2 = arg_187_1.var_.effect43434
				local var_190_3
				local var_190_4 = var_190_0

				if not var_190_2 then
					var_190_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu2"), var_190_4)
					var_190_2.name = "43434"
					arg_187_1.var_.effect43434 = var_190_2
				else
					var_190_2.transform:SetParent(var_190_4)
				end

				var_190_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_190_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_190_5 = manager.ui.mainCamera.transform
			local var_190_6 = 1.43333333333333

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				local var_190_7 = arg_187_1.var_.effect43434

				if var_190_7 then
					Object.Destroy(var_190_7)

					arg_187_1.var_.effect43434 = nil
				end
			end

			local var_190_8 = 0.5
			local var_190_9 = 1

			if var_190_8 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				local var_190_10 = "play"
				local var_190_11 = "effect"

				arg_187_1:AudioAction(var_190_10, var_190_11, "se_story_148", "se_story_148_whoosh03", "")
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_12 = 0.5
			local var_190_13 = 0.85

			if var_190_12 < arg_187_1.time_ and arg_187_1.time_ <= var_190_12 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_14 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_14:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_15 = arg_187_1:GetWordFromCfg(324171046)
				local var_190_16 = arg_187_1:FormatText(var_190_15.content)

				arg_187_1.text_.text = var_190_16

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_17 = 34
				local var_190_18 = utf8.len(var_190_16)
				local var_190_19 = var_190_17 <= 0 and var_190_13 or var_190_13 * (var_190_18 / var_190_17)

				if var_190_19 > 0 and var_190_13 < var_190_19 then
					arg_187_1.talkMaxDuration = var_190_19
					var_190_12 = var_190_12 + 0.3

					if var_190_19 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_19 + var_190_12
					end
				end

				arg_187_1.text_.text = var_190_16
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_20 = var_190_12 + 0.3
			local var_190_21 = math.max(var_190_13, arg_187_1.talkMaxDuration)

			if var_190_20 <= arg_187_1.time_ and arg_187_1.time_ < var_190_20 + var_190_21 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_20) / var_190_21

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_20 + var_190_21 and arg_187_1.time_ < var_190_20 + var_190_21 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play324171047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 324171047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play324171048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.875

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(324171047)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 35
				local var_196_5 = utf8.len(var_196_3)
				local var_196_6 = var_196_4 <= 0 and var_196_1 or var_196_1 * (var_196_5 / var_196_4)

				if var_196_6 > 0 and var_196_1 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_7 and arg_193_1.time_ < var_196_0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play324171048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 324171048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play324171049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.1
			local var_200_1 = 1

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				local var_200_2 = "play"
				local var_200_3 = "effect"

				arg_197_1:AudioAction(var_200_2, var_200_3, "se_story_148", "se_story_148_whoosh03", "")
			end

			local var_200_4 = 0
			local var_200_5 = 0.9

			if var_200_4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(324171048)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_8 = 36
				local var_200_9 = utf8.len(var_200_7)
				local var_200_10 = var_200_8 <= 0 and var_200_5 or var_200_5 * (var_200_9 / var_200_8)

				if var_200_10 > 0 and var_200_5 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_11 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_11 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_11

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_11 and arg_197_1.time_ < var_200_4 + var_200_11 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play324171049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 324171049
		arg_201_1.duration_ = 2

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play324171050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1053ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1053ui_story = var_204_0.localPosition

				local var_204_2 = GameObjectTools.GetOrAddComponent(var_204_0.gameObject, typeof(DynamicBoneHelper))

				if var_204_2 then
					var_204_2:EnableDynamicBone(false)
				end
			end

			local var_204_3 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_3 then
				local var_204_4 = (arg_201_1.time_ - var_204_1) / var_204_3
				local var_204_5 = Vector3.New(0, -1.08, -6)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1053ui_story, var_204_5, var_204_4)

				local var_204_6 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_6.x, var_204_6.y, var_204_6.z)

				local var_204_7 = var_204_0.localEulerAngles

				var_204_7.z = 0
				var_204_7.x = 0
				var_204_0.localEulerAngles = var_204_7
			end

			if arg_201_1.time_ >= var_204_1 + var_204_3 and arg_201_1.time_ < var_204_1 + var_204_3 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_204_8 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_8.x, var_204_8.y, var_204_8.z)

				local var_204_9 = var_204_0.localEulerAngles

				var_204_9.z = 0
				var_204_9.x = 0
				var_204_0.localEulerAngles = var_204_9

				local var_204_10 = GameObjectTools.GetOrAddComponent(var_204_0.gameObject, typeof(DynamicBoneHelper))

				if var_204_10 then
					var_204_10:EnableDynamicBone(true)
				end
			end

			local var_204_11 = arg_201_1.actors_["1053ui_story"]
			local var_204_12 = 0

			if var_204_12 < arg_201_1.time_ and arg_201_1.time_ <= var_204_12 + arg_204_0 and not isNil(var_204_11) and arg_201_1.var_.characterEffect1053ui_story == nil then
				arg_201_1.var_.characterEffect1053ui_story = var_204_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_13 = 0.200000002980232

			if var_204_12 <= arg_201_1.time_ and arg_201_1.time_ < var_204_12 + var_204_13 and not isNil(var_204_11) then
				local var_204_14 = (arg_201_1.time_ - var_204_12) / var_204_13

				if arg_201_1.var_.characterEffect1053ui_story and not isNil(var_204_11) then
					arg_201_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_12 + var_204_13 and arg_201_1.time_ < var_204_12 + var_204_13 + arg_204_0 and not isNil(var_204_11) and arg_201_1.var_.characterEffect1053ui_story then
				arg_201_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_204_15 = 0

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				arg_201_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_204_17 = 0
			local var_204_18 = 0.15

			if var_204_17 < arg_201_1.time_ and arg_201_1.time_ <= var_204_17 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_19 = arg_201_1:FormatText(StoryNameCfg[472].name)

				arg_201_1.leftNameTxt_.text = var_204_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_20 = arg_201_1:GetWordFromCfg(324171049)
				local var_204_21 = arg_201_1:FormatText(var_204_20.content)

				arg_201_1.text_.text = var_204_21

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_22 = 6
				local var_204_23 = utf8.len(var_204_21)
				local var_204_24 = var_204_22 <= 0 and var_204_18 or var_204_18 * (var_204_23 / var_204_22)

				if var_204_24 > 0 and var_204_18 < var_204_24 then
					arg_201_1.talkMaxDuration = var_204_24

					if var_204_24 + var_204_17 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_24 + var_204_17
					end
				end

				arg_201_1.text_.text = var_204_21
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171049", "story_v_out_324171.awb") ~= 0 then
					local var_204_25 = manager.audio:GetVoiceLength("story_v_out_324171", "324171049", "story_v_out_324171.awb") / 1000

					if var_204_25 + var_204_17 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_25 + var_204_17
					end

					if var_204_20.prefab_name ~= "" and arg_201_1.actors_[var_204_20.prefab_name] ~= nil then
						local var_204_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_20.prefab_name].transform, "story_v_out_324171", "324171049", "story_v_out_324171.awb")

						arg_201_1:RecordAudio("324171049", var_204_26)
						arg_201_1:RecordAudio("324171049", var_204_26)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_324171", "324171049", "story_v_out_324171.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_324171", "324171049", "story_v_out_324171.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_27 = math.max(var_204_18, arg_201_1.talkMaxDuration)

			if var_204_17 <= arg_201_1.time_ and arg_201_1.time_ < var_204_17 + var_204_27 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_17) / var_204_27

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_17 + var_204_27 and arg_201_1.time_ < var_204_17 + var_204_27 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play324171050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 324171050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play324171051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1053ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1053ui_story == nil then
				arg_205_1.var_.characterEffect1053ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect1053ui_story and not isNil(var_208_0) then
					local var_208_4 = Mathf.Lerp(0, 0.5, var_208_3)

					arg_205_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1053ui_story.fillRatio = var_208_4
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1053ui_story then
				local var_208_5 = 0.5

				arg_205_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1053ui_story.fillRatio = var_208_5
			end

			local var_208_6 = arg_205_1.actors_["1053ui_story"].transform
			local var_208_7 = 0

			if var_208_7 < arg_205_1.time_ and arg_205_1.time_ <= var_208_7 + arg_208_0 then
				arg_205_1.var_.moveOldPos1053ui_story = var_208_6.localPosition

				local var_208_8 = GameObjectTools.GetOrAddComponent(var_208_6.gameObject, typeof(DynamicBoneHelper))

				if var_208_8 then
					var_208_8:EnableDynamicBone(false)
				end
			end

			local var_208_9 = 0.001

			if var_208_7 <= arg_205_1.time_ and arg_205_1.time_ < var_208_7 + var_208_9 then
				local var_208_10 = (arg_205_1.time_ - var_208_7) / var_208_9
				local var_208_11 = Vector3.New(0, 100, 0)

				var_208_6.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1053ui_story, var_208_11, var_208_10)

				local var_208_12 = manager.ui.mainCamera.transform.position - var_208_6.position

				var_208_6.forward = Vector3.New(var_208_12.x, var_208_12.y, var_208_12.z)

				local var_208_13 = var_208_6.localEulerAngles

				var_208_13.z = 0
				var_208_13.x = 0
				var_208_6.localEulerAngles = var_208_13
			end

			if arg_205_1.time_ >= var_208_7 + var_208_9 and arg_205_1.time_ < var_208_7 + var_208_9 + arg_208_0 then
				var_208_6.localPosition = Vector3.New(0, 100, 0)

				local var_208_14 = manager.ui.mainCamera.transform.position - var_208_6.position

				var_208_6.forward = Vector3.New(var_208_14.x, var_208_14.y, var_208_14.z)

				local var_208_15 = var_208_6.localEulerAngles

				var_208_15.z = 0
				var_208_15.x = 0
				var_208_6.localEulerAngles = var_208_15

				local var_208_16 = GameObjectTools.GetOrAddComponent(var_208_6.gameObject, typeof(DynamicBoneHelper))

				if var_208_16 then
					var_208_16:EnableDynamicBone(true)
				end
			end

			local var_208_17 = 0
			local var_208_18 = 0.825

			if var_208_17 < arg_205_1.time_ and arg_205_1.time_ <= var_208_17 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_19 = arg_205_1:GetWordFromCfg(324171050)
				local var_208_20 = arg_205_1:FormatText(var_208_19.content)

				arg_205_1.text_.text = var_208_20

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_21 = 33
				local var_208_22 = utf8.len(var_208_20)
				local var_208_23 = var_208_21 <= 0 and var_208_18 or var_208_18 * (var_208_22 / var_208_21)

				if var_208_23 > 0 and var_208_18 < var_208_23 then
					arg_205_1.talkMaxDuration = var_208_23

					if var_208_23 + var_208_17 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_17
					end
				end

				arg_205_1.text_.text = var_208_20
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_24 = math.max(var_208_18, arg_205_1.talkMaxDuration)

			if var_208_17 <= arg_205_1.time_ and arg_205_1.time_ < var_208_17 + var_208_24 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_17) / var_208_24

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_17 + var_208_24 and arg_205_1.time_ < var_208_17 + var_208_24 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play324171051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 324171051
		arg_209_1.duration_ = 4.2

		local var_209_0 = {
			zh = 1.7,
			ja = 4.2
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play324171052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1053ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1053ui_story == nil then
				arg_209_1.var_.characterEffect1053ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1053ui_story and not isNil(var_212_0) then
					arg_209_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1053ui_story then
				arg_209_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_212_4 = 0
			local var_212_5 = 0.15

			if var_212_4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_6 = arg_209_1:FormatText(StoryNameCfg[472].name)

				arg_209_1.leftNameTxt_.text = var_212_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_7 = arg_209_1:GetWordFromCfg(324171051)
				local var_212_8 = arg_209_1:FormatText(var_212_7.content)

				arg_209_1.text_.text = var_212_8

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 6
				local var_212_10 = utf8.len(var_212_8)
				local var_212_11 = var_212_9 <= 0 and var_212_5 or var_212_5 * (var_212_10 / var_212_9)

				if var_212_11 > 0 and var_212_5 < var_212_11 then
					arg_209_1.talkMaxDuration = var_212_11

					if var_212_11 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_8
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171051", "story_v_out_324171.awb") ~= 0 then
					local var_212_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171051", "story_v_out_324171.awb") / 1000

					if var_212_12 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_4
					end

					if var_212_7.prefab_name ~= "" and arg_209_1.actors_[var_212_7.prefab_name] ~= nil then
						local var_212_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_7.prefab_name].transform, "story_v_out_324171", "324171051", "story_v_out_324171.awb")

						arg_209_1:RecordAudio("324171051", var_212_13)
						arg_209_1:RecordAudio("324171051", var_212_13)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_324171", "324171051", "story_v_out_324171.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_324171", "324171051", "story_v_out_324171.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_14 and arg_209_1.time_ < var_212_4 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play324171052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 324171052
		arg_213_1.duration_ = 6.85

		local var_213_0 = {
			zh = 6.01666666666667,
			ja = 6.84966666666667
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
				arg_213_0:Play324171053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = "ST2009"

			if arg_213_1.bgs_[var_216_0] == nil then
				local var_216_1 = Object.Instantiate(arg_213_1.paintGo_)

				var_216_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_216_0)
				var_216_1.name = var_216_0
				var_216_1.transform.parent = arg_213_1.stage_.transform
				var_216_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.bgs_[var_216_0] = var_216_1
			end

			local var_216_2 = 1.46666666666667

			if var_216_2 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				local var_216_3 = manager.ui.mainCamera.transform.localPosition
				local var_216_4 = Vector3.New(0, 0, 10) + Vector3.New(var_216_3.x, var_216_3.y, 0)
				local var_216_5 = arg_213_1.bgs_.ST2009

				var_216_5.transform.localPosition = var_216_4
				var_216_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_6 = var_216_5:GetComponent("SpriteRenderer")

				if var_216_6 and var_216_6.sprite then
					local var_216_7 = (var_216_5.transform.localPosition - var_216_3).z
					local var_216_8 = manager.ui.mainCameraCom_
					local var_216_9 = 2 * var_216_7 * Mathf.Tan(var_216_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_216_10 = var_216_9 * var_216_8.aspect
					local var_216_11 = var_216_6.sprite.bounds.size.x
					local var_216_12 = var_216_6.sprite.bounds.size.y
					local var_216_13 = var_216_10 / var_216_11
					local var_216_14 = var_216_9 / var_216_12
					local var_216_15 = var_216_14 < var_216_13 and var_216_13 or var_216_14

					var_216_5.transform.localScale = Vector3.New(var_216_15, var_216_15, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "ST2009" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_216_16 = 1.46666666666667

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1.allBtn_.enabled = false
			end

			local var_216_17 = 0.3

			if arg_213_1.time_ >= var_216_16 + var_216_17 and arg_213_1.time_ < var_216_16 + var_216_17 + arg_216_0 then
				arg_213_1.allBtn_.enabled = true
			end

			local var_216_18 = 0

			if var_216_18 < arg_213_1.time_ and arg_213_1.time_ <= var_216_18 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_19 = 1.46666666666667

			if var_216_18 <= arg_213_1.time_ and arg_213_1.time_ < var_216_18 + var_216_19 then
				local var_216_20 = (arg_213_1.time_ - var_216_18) / var_216_19
				local var_216_21 = Color.New(0, 0, 0)

				var_216_21.a = Mathf.Lerp(0, 1, var_216_20)
				arg_213_1.mask_.color = var_216_21
			end

			if arg_213_1.time_ >= var_216_18 + var_216_19 and arg_213_1.time_ < var_216_18 + var_216_19 + arg_216_0 then
				local var_216_22 = Color.New(0, 0, 0)

				var_216_22.a = 1
				arg_213_1.mask_.color = var_216_22
			end

			local var_216_23 = 1.46666666666667

			if var_216_23 < arg_213_1.time_ and arg_213_1.time_ <= var_216_23 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_24 = 2

			if var_216_23 <= arg_213_1.time_ and arg_213_1.time_ < var_216_23 + var_216_24 then
				local var_216_25 = (arg_213_1.time_ - var_216_23) / var_216_24
				local var_216_26 = Color.New(0, 0, 0)

				var_216_26.a = Mathf.Lerp(1, 0, var_216_25)
				arg_213_1.mask_.color = var_216_26
			end

			if arg_213_1.time_ >= var_216_23 + var_216_24 and arg_213_1.time_ < var_216_23 + var_216_24 + arg_216_0 then
				local var_216_27 = Color.New(0, 0, 0)
				local var_216_28 = 0

				arg_213_1.mask_.enabled = false
				var_216_27.a = var_216_28
				arg_213_1.mask_.color = var_216_27
			end

			local var_216_29 = arg_213_1.actors_["1053ui_story"].transform
			local var_216_30 = 1.46666666666667

			if var_216_30 < arg_213_1.time_ and arg_213_1.time_ <= var_216_30 + arg_216_0 then
				arg_213_1.var_.moveOldPos1053ui_story = var_216_29.localPosition

				local var_216_31 = GameObjectTools.GetOrAddComponent(var_216_29.gameObject, typeof(DynamicBoneHelper))

				if var_216_31 then
					var_216_31:EnableDynamicBone(false)
				end
			end

			local var_216_32 = 0.001

			if var_216_30 <= arg_213_1.time_ and arg_213_1.time_ < var_216_30 + var_216_32 then
				local var_216_33 = (arg_213_1.time_ - var_216_30) / var_216_32
				local var_216_34 = Vector3.New(0, 100, 0)

				var_216_29.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1053ui_story, var_216_34, var_216_33)

				local var_216_35 = manager.ui.mainCamera.transform.position - var_216_29.position

				var_216_29.forward = Vector3.New(var_216_35.x, var_216_35.y, var_216_35.z)

				local var_216_36 = var_216_29.localEulerAngles

				var_216_36.z = 0
				var_216_36.x = 0
				var_216_29.localEulerAngles = var_216_36
			end

			if arg_213_1.time_ >= var_216_30 + var_216_32 and arg_213_1.time_ < var_216_30 + var_216_32 + arg_216_0 then
				var_216_29.localPosition = Vector3.New(0, 100, 0)

				local var_216_37 = manager.ui.mainCamera.transform.position - var_216_29.position

				var_216_29.forward = Vector3.New(var_216_37.x, var_216_37.y, var_216_37.z)

				local var_216_38 = var_216_29.localEulerAngles

				var_216_38.z = 0
				var_216_38.x = 0
				var_216_29.localEulerAngles = var_216_38

				local var_216_39 = GameObjectTools.GetOrAddComponent(var_216_29.gameObject, typeof(DynamicBoneHelper))

				if var_216_39 then
					var_216_39:EnableDynamicBone(true)
				end
			end

			local var_216_40 = arg_213_1.actors_["1053ui_story"]
			local var_216_41 = 1.46666666666667

			if var_216_41 < arg_213_1.time_ and arg_213_1.time_ <= var_216_41 + arg_216_0 and not isNil(var_216_40) and arg_213_1.var_.characterEffect1053ui_story == nil then
				arg_213_1.var_.characterEffect1053ui_story = var_216_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_42 = 0.200000002980232

			if var_216_41 <= arg_213_1.time_ and arg_213_1.time_ < var_216_41 + var_216_42 and not isNil(var_216_40) then
				local var_216_43 = (arg_213_1.time_ - var_216_41) / var_216_42

				if arg_213_1.var_.characterEffect1053ui_story and not isNil(var_216_40) then
					local var_216_44 = Mathf.Lerp(0, 0.5, var_216_43)

					arg_213_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1053ui_story.fillRatio = var_216_44
				end
			end

			if arg_213_1.time_ >= var_216_41 + var_216_42 and arg_213_1.time_ < var_216_41 + var_216_42 + arg_216_0 and not isNil(var_216_40) and arg_213_1.var_.characterEffect1053ui_story then
				local var_216_45 = 0.5

				arg_213_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1053ui_story.fillRatio = var_216_45
			end

			local var_216_46 = manager.ui.mainCamera.transform
			local var_216_47 = 1.46666666666667

			if var_216_47 < arg_213_1.time_ and arg_213_1.time_ <= var_216_47 + arg_216_0 then
				local var_216_48 = arg_213_1.var_.effect43434

				if var_216_48 then
					Object.Destroy(var_216_48)

					arg_213_1.var_.effect43434 = nil
				end
			end

			local var_216_49 = 1.2
			local var_216_50 = 1

			if var_216_49 < arg_213_1.time_ and arg_213_1.time_ <= var_216_49 + arg_216_0 then
				local var_216_51 = "play"
				local var_216_52 = "effect"

				arg_213_1:AudioAction(var_216_51, var_216_52, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_216_53 = 0.1
			local var_216_54 = 1

			if var_216_53 < arg_213_1.time_ and arg_213_1.time_ <= var_216_53 + arg_216_0 then
				local var_216_55 = "stop"
				local var_216_56 = "effect"

				arg_213_1:AudioAction(var_216_55, var_216_56, "se_story_1311", "se_story_1311_wind", "")
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_57 = 3.21666666666667
			local var_216_58 = 0.25

			if var_216_57 < arg_213_1.time_ and arg_213_1.time_ <= var_216_57 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_59 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_59:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_60 = arg_213_1:FormatText(StoryNameCfg[1502].name)

				arg_213_1.leftNameTxt_.text = var_216_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_61 = arg_213_1:GetWordFromCfg(324171052)
				local var_216_62 = arg_213_1:FormatText(var_216_61.content)

				arg_213_1.text_.text = var_216_62

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_63 = 10
				local var_216_64 = utf8.len(var_216_62)
				local var_216_65 = var_216_63 <= 0 and var_216_58 or var_216_58 * (var_216_64 / var_216_63)

				if var_216_65 > 0 and var_216_58 < var_216_65 then
					arg_213_1.talkMaxDuration = var_216_65
					var_216_57 = var_216_57 + 0.3

					if var_216_65 + var_216_57 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_65 + var_216_57
					end
				end

				arg_213_1.text_.text = var_216_62
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171052", "story_v_out_324171.awb") ~= 0 then
					local var_216_66 = manager.audio:GetVoiceLength("story_v_out_324171", "324171052", "story_v_out_324171.awb") / 1000

					if var_216_66 + var_216_57 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_66 + var_216_57
					end

					if var_216_61.prefab_name ~= "" and arg_213_1.actors_[var_216_61.prefab_name] ~= nil then
						local var_216_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_61.prefab_name].transform, "story_v_out_324171", "324171052", "story_v_out_324171.awb")

						arg_213_1:RecordAudio("324171052", var_216_67)
						arg_213_1:RecordAudio("324171052", var_216_67)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_324171", "324171052", "story_v_out_324171.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_324171", "324171052", "story_v_out_324171.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_68 = var_216_57 + 0.3
			local var_216_69 = math.max(var_216_58, arg_213_1.talkMaxDuration)

			if var_216_68 <= arg_213_1.time_ and arg_213_1.time_ < var_216_68 + var_216_69 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_68) / var_216_69

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_68 + var_216_69 and arg_213_1.time_ < var_216_68 + var_216_69 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play324171053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 324171053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play324171054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 1.125

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(324171053)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 45
				local var_222_5 = utf8.len(var_222_3)
				local var_222_6 = var_222_4 <= 0 and var_222_1 or var_222_1 * (var_222_5 / var_222_4)

				if var_222_6 > 0 and var_222_1 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_7 and arg_219_1.time_ < var_222_0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play324171054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 324171054
		arg_223_1.duration_ = 2.83

		local var_223_0 = {
			zh = 1.933,
			ja = 2.833
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
				arg_223_0:Play324171055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.2

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[1497].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(324171054)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171054", "story_v_out_324171.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171054", "story_v_out_324171.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_324171", "324171054", "story_v_out_324171.awb")

						arg_223_1:RecordAudio("324171054", var_226_9)
						arg_223_1:RecordAudio("324171054", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_324171", "324171054", "story_v_out_324171.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_324171", "324171054", "story_v_out_324171.awb")
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
	Play324171055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 324171055
		arg_227_1.duration_ = 6.37

		local var_227_0 = {
			zh = 4.9,
			ja = 6.366
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play324171056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.55

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[1502].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(324171055)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 22
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171055", "story_v_out_324171.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171055", "story_v_out_324171.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_324171", "324171055", "story_v_out_324171.awb")

						arg_227_1:RecordAudio("324171055", var_230_9)
						arg_227_1:RecordAudio("324171055", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_324171", "324171055", "story_v_out_324171.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_324171", "324171055", "story_v_out_324171.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play324171056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 324171056
		arg_231_1.duration_ = 8.43

		local var_231_0 = {
			zh = 7.333,
			ja = 8.433
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
				arg_231_0:Play324171057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.75

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[1497].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(324171056)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 30
				local var_234_6 = utf8.len(var_234_4)
				local var_234_7 = var_234_5 <= 0 and var_234_1 or var_234_1 * (var_234_6 / var_234_5)

				if var_234_7 > 0 and var_234_1 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171056", "story_v_out_324171.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171056", "story_v_out_324171.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_324171", "324171056", "story_v_out_324171.awb")

						arg_231_1:RecordAudio("324171056", var_234_9)
						arg_231_1:RecordAudio("324171056", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_324171", "324171056", "story_v_out_324171.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_324171", "324171056", "story_v_out_324171.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_10 and arg_231_1.time_ < var_234_0 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play324171057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 324171057
		arg_235_1.duration_ = 7.3

		local var_235_0 = {
			zh = 6.233333333332,
			ja = 7.299333333332
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
				arg_235_0:Play324171058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = "MS2409"

			if arg_235_1.bgs_[var_238_0] == nil then
				local var_238_1 = Object.Instantiate(arg_235_1.paintGo_)

				var_238_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_238_0)
				var_238_1.name = var_238_0
				var_238_1.transform.parent = arg_235_1.stage_.transform
				var_238_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.bgs_[var_238_0] = var_238_1
			end

			local var_238_2 = 1.13333333333333

			if var_238_2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				local var_238_3 = manager.ui.mainCamera.transform.localPosition
				local var_238_4 = Vector3.New(0, 0, 10) + Vector3.New(var_238_3.x, var_238_3.y, 0)
				local var_238_5 = arg_235_1.bgs_.MS2409

				var_238_5.transform.localPosition = var_238_4
				var_238_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_6 = var_238_5:GetComponent("SpriteRenderer")

				if var_238_6 and var_238_6.sprite then
					local var_238_7 = (var_238_5.transform.localPosition - var_238_3).z
					local var_238_8 = manager.ui.mainCameraCom_
					local var_238_9 = 2 * var_238_7 * Mathf.Tan(var_238_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_238_10 = var_238_9 * var_238_8.aspect
					local var_238_11 = var_238_6.sprite.bounds.size.x
					local var_238_12 = var_238_6.sprite.bounds.size.y
					local var_238_13 = var_238_10 / var_238_11
					local var_238_14 = var_238_9 / var_238_12
					local var_238_15 = var_238_14 < var_238_13 and var_238_13 or var_238_14

					var_238_5.transform.localScale = Vector3.New(var_238_15, var_238_15, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "MS2409" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.allBtn_.enabled = false
			end

			local var_238_17 = 0.3

			if arg_235_1.time_ >= var_238_16 + var_238_17 and arg_235_1.time_ < var_238_16 + var_238_17 + arg_238_0 then
				arg_235_1.allBtn_.enabled = true
			end

			local var_238_18 = 0

			if var_238_18 < arg_235_1.time_ and arg_235_1.time_ <= var_238_18 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_19 = 1.13333333333333

			if var_238_18 <= arg_235_1.time_ and arg_235_1.time_ < var_238_18 + var_238_19 then
				local var_238_20 = (arg_235_1.time_ - var_238_18) / var_238_19
				local var_238_21 = Color.New(0, 0, 0)

				var_238_21.a = Mathf.Lerp(0, 1, var_238_20)
				arg_235_1.mask_.color = var_238_21
			end

			if arg_235_1.time_ >= var_238_18 + var_238_19 and arg_235_1.time_ < var_238_18 + var_238_19 + arg_238_0 then
				local var_238_22 = Color.New(0, 0, 0)

				var_238_22.a = 1
				arg_235_1.mask_.color = var_238_22
			end

			local var_238_23 = 1.13333333333333

			if var_238_23 < arg_235_1.time_ and arg_235_1.time_ <= var_238_23 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_24 = 1.5

			if var_238_23 <= arg_235_1.time_ and arg_235_1.time_ < var_238_23 + var_238_24 then
				local var_238_25 = (arg_235_1.time_ - var_238_23) / var_238_24
				local var_238_26 = Color.New(0, 0, 0)

				var_238_26.a = Mathf.Lerp(1, 0, var_238_25)
				arg_235_1.mask_.color = var_238_26
			end

			if arg_235_1.time_ >= var_238_23 + var_238_24 and arg_235_1.time_ < var_238_23 + var_238_24 + arg_238_0 then
				local var_238_27 = Color.New(0, 0, 0)
				local var_238_28 = 0

				arg_235_1.mask_.enabled = false
				var_238_27.a = var_238_28
				arg_235_1.mask_.color = var_238_27
			end

			local var_238_29 = arg_235_1.actors_["1170ui_story"]
			local var_238_30 = 0

			if var_238_30 < arg_235_1.time_ and arg_235_1.time_ <= var_238_30 + arg_238_0 and not isNil(var_238_29) and arg_235_1.var_.characterEffect1170ui_story == nil then
				arg_235_1.var_.characterEffect1170ui_story = var_238_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_31 = 0.200000002980232

			if var_238_30 <= arg_235_1.time_ and arg_235_1.time_ < var_238_30 + var_238_31 and not isNil(var_238_29) then
				local var_238_32 = (arg_235_1.time_ - var_238_30) / var_238_31

				if arg_235_1.var_.characterEffect1170ui_story and not isNil(var_238_29) then
					arg_235_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_30 + var_238_31 and arg_235_1.time_ < var_238_30 + var_238_31 + arg_238_0 and not isNil(var_238_29) and arg_235_1.var_.characterEffect1170ui_story then
				arg_235_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_238_33 = arg_235_1.bgs_.MS2409.transform
			local var_238_34 = 1.13333333333333

			if var_238_34 < arg_235_1.time_ and arg_235_1.time_ <= var_238_34 + arg_238_0 then
				arg_235_1.var_.moveOldPosMS2409 = var_238_33.localPosition
			end

			local var_238_35 = 1.7

			if var_238_34 <= arg_235_1.time_ and arg_235_1.time_ < var_238_34 + var_238_35 then
				local var_238_36 = (arg_235_1.time_ - var_238_34) / var_238_35
				local var_238_37 = Vector3.New(0, 1, 4)

				var_238_33.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPosMS2409, var_238_37, var_238_36)
			end

			if arg_235_1.time_ >= var_238_34 + var_238_35 and arg_235_1.time_ < var_238_34 + var_238_35 + arg_238_0 then
				var_238_33.localPosition = Vector3.New(0, 1, 4)
			end

			local var_238_38 = 1.86666666666667

			if var_238_38 < arg_235_1.time_ and arg_235_1.time_ <= var_238_38 + arg_238_0 then
				arg_235_1.allBtn_.enabled = false
			end

			local var_238_39 = 1.33333333333333

			if arg_235_1.time_ >= var_238_38 + var_238_39 and arg_235_1.time_ < var_238_38 + var_238_39 + arg_238_0 then
				arg_235_1.allBtn_.enabled = true
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_40 = 2.933333333332
			local var_238_41 = 0.4

			if var_238_40 < arg_235_1.time_ and arg_235_1.time_ <= var_238_40 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_42 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_42:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_235_1.dialogCg_.alpha = arg_239_0
				end))
				var_238_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_43 = arg_235_1:FormatText(StoryNameCfg[318].name)

				arg_235_1.leftNameTxt_.text = var_238_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_44 = arg_235_1:GetWordFromCfg(324171057)
				local var_238_45 = arg_235_1:FormatText(var_238_44.content)

				arg_235_1.text_.text = var_238_45

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_46 = 16
				local var_238_47 = utf8.len(var_238_45)
				local var_238_48 = var_238_46 <= 0 and var_238_41 or var_238_41 * (var_238_47 / var_238_46)

				if var_238_48 > 0 and var_238_41 < var_238_48 then
					arg_235_1.talkMaxDuration = var_238_48
					var_238_40 = var_238_40 + 0.3

					if var_238_48 + var_238_40 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_48 + var_238_40
					end
				end

				arg_235_1.text_.text = var_238_45
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171057", "story_v_out_324171.awb") ~= 0 then
					local var_238_49 = manager.audio:GetVoiceLength("story_v_out_324171", "324171057", "story_v_out_324171.awb") / 1000

					if var_238_49 + var_238_40 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_49 + var_238_40
					end

					if var_238_44.prefab_name ~= "" and arg_235_1.actors_[var_238_44.prefab_name] ~= nil then
						local var_238_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_44.prefab_name].transform, "story_v_out_324171", "324171057", "story_v_out_324171.awb")

						arg_235_1:RecordAudio("324171057", var_238_50)
						arg_235_1:RecordAudio("324171057", var_238_50)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_324171", "324171057", "story_v_out_324171.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_324171", "324171057", "story_v_out_324171.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_51 = var_238_40 + 0.3
			local var_238_52 = math.max(var_238_41, arg_235_1.talkMaxDuration)

			if var_238_51 <= arg_235_1.time_ and arg_235_1.time_ < var_238_51 + var_238_52 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_51) / var_238_52

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_51 + var_238_52 and arg_235_1.time_ < var_238_51 + var_238_52 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2409",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.7,
				startTime = 1.13333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 4),
					easeType = LeanTweenType.easeOutCirc
				}
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play324171058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 324171058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play324171059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1170ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1170ui_story == nil then
				arg_241_1.var_.characterEffect1170ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1170ui_story and not isNil(var_244_0) then
					local var_244_4 = Mathf.Lerp(0, 0.5, var_244_3)

					arg_241_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1170ui_story.fillRatio = var_244_4
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1170ui_story then
				local var_244_5 = 0.5

				arg_241_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1170ui_story.fillRatio = var_244_5
			end

			local var_244_6 = 0
			local var_244_7 = 1.575

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

				local var_244_8 = arg_241_1:GetWordFromCfg(324171058)
				local var_244_9 = arg_241_1:FormatText(var_244_8.content)

				arg_241_1.text_.text = var_244_9

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_10 = 63
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
	Play324171059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 324171059
		arg_245_1.duration_ = 2

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play324171060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1170ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1170ui_story == nil then
				arg_245_1.var_.characterEffect1170ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1170ui_story and not isNil(var_248_0) then
					arg_245_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1170ui_story then
				arg_245_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_248_4 = arg_245_1.actors_["1170ui_story"].transform
			local var_248_5 = 0

			if var_248_5 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1.var_.moveOldPos1170ui_story = var_248_4.localPosition

				local var_248_6 = GameObjectTools.GetOrAddComponent(var_248_4.gameObject, typeof(DynamicBoneHelper))

				if var_248_6 then
					var_248_6:EnableDynamicBone(false)
				end
			end

			local var_248_7 = 0.001

			if var_248_5 <= arg_245_1.time_ and arg_245_1.time_ < var_248_5 + var_248_7 then
				local var_248_8 = (arg_245_1.time_ - var_248_5) / var_248_7
				local var_248_9 = Vector3.New(0, 100, 0)

				var_248_4.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1170ui_story, var_248_9, var_248_8)

				local var_248_10 = manager.ui.mainCamera.transform.position - var_248_4.position

				var_248_4.forward = Vector3.New(var_248_10.x, var_248_10.y, var_248_10.z)

				local var_248_11 = var_248_4.localEulerAngles

				var_248_11.z = 0
				var_248_11.x = 0
				var_248_4.localEulerAngles = var_248_11
			end

			if arg_245_1.time_ >= var_248_5 + var_248_7 and arg_245_1.time_ < var_248_5 + var_248_7 + arg_248_0 then
				var_248_4.localPosition = Vector3.New(0, 100, 0)

				local var_248_12 = manager.ui.mainCamera.transform.position - var_248_4.position

				var_248_4.forward = Vector3.New(var_248_12.x, var_248_12.y, var_248_12.z)

				local var_248_13 = var_248_4.localEulerAngles

				var_248_13.z = 0
				var_248_13.x = 0
				var_248_4.localEulerAngles = var_248_13

				local var_248_14 = GameObjectTools.GetOrAddComponent(var_248_4.gameObject, typeof(DynamicBoneHelper))

				if var_248_14 then
					var_248_14:EnableDynamicBone(true)
				end
			end

			local var_248_15 = arg_245_1.actors_["1170ui_story"]
			local var_248_16 = 0

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.characterEffect1170ui_story == nil then
				arg_245_1.var_.characterEffect1170ui_story = var_248_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_17 = 0.200000002980232

			if var_248_16 <= arg_245_1.time_ and arg_245_1.time_ < var_248_16 + var_248_17 and not isNil(var_248_15) then
				local var_248_18 = (arg_245_1.time_ - var_248_16) / var_248_17

				if arg_245_1.var_.characterEffect1170ui_story and not isNil(var_248_15) then
					arg_245_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_16 + var_248_17 and arg_245_1.time_ < var_248_16 + var_248_17 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.characterEffect1170ui_story then
				arg_245_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_248_19 = 0

			if var_248_19 < arg_245_1.time_ and arg_245_1.time_ <= var_248_19 + arg_248_0 then
				arg_245_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action1_1")
			end

			local var_248_20 = 0

			if var_248_20 < arg_245_1.time_ and arg_245_1.time_ <= var_248_20 + arg_248_0 then
				arg_245_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_248_21 = 0
			local var_248_22 = 0.175

			if var_248_21 < arg_245_1.time_ and arg_245_1.time_ <= var_248_21 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_23 = arg_245_1:FormatText(StoryNameCfg[318].name)

				arg_245_1.leftNameTxt_.text = var_248_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_24 = arg_245_1:GetWordFromCfg(324171059)
				local var_248_25 = arg_245_1:FormatText(var_248_24.content)

				arg_245_1.text_.text = var_248_25

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_26 = 7
				local var_248_27 = utf8.len(var_248_25)
				local var_248_28 = var_248_26 <= 0 and var_248_22 or var_248_22 * (var_248_27 / var_248_26)

				if var_248_28 > 0 and var_248_22 < var_248_28 then
					arg_245_1.talkMaxDuration = var_248_28

					if var_248_28 + var_248_21 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_28 + var_248_21
					end
				end

				arg_245_1.text_.text = var_248_25
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171059", "story_v_out_324171.awb") ~= 0 then
					local var_248_29 = manager.audio:GetVoiceLength("story_v_out_324171", "324171059", "story_v_out_324171.awb") / 1000

					if var_248_29 + var_248_21 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_29 + var_248_21
					end

					if var_248_24.prefab_name ~= "" and arg_245_1.actors_[var_248_24.prefab_name] ~= nil then
						local var_248_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_24.prefab_name].transform, "story_v_out_324171", "324171059", "story_v_out_324171.awb")

						arg_245_1:RecordAudio("324171059", var_248_30)
						arg_245_1:RecordAudio("324171059", var_248_30)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_324171", "324171059", "story_v_out_324171.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_324171", "324171059", "story_v_out_324171.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_31 = math.max(var_248_22, arg_245_1.talkMaxDuration)

			if var_248_21 <= arg_245_1.time_ and arg_245_1.time_ < var_248_21 + var_248_31 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_21) / var_248_31

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_21 + var_248_31 and arg_245_1.time_ < var_248_21 + var_248_31 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play324171060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 324171060
		arg_249_1.duration_ = 7.83

		local var_249_0 = {
			zh = 5.266,
			ja = 7.833
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play324171061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1170ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1170ui_story == nil then
				arg_249_1.var_.characterEffect1170ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1170ui_story and not isNil(var_252_0) then
					local var_252_4 = Mathf.Lerp(0, 0.5, var_252_3)

					arg_249_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1170ui_story.fillRatio = var_252_4
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1170ui_story then
				local var_252_5 = 0.5

				arg_249_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1170ui_story.fillRatio = var_252_5
			end

			local var_252_6 = 0
			local var_252_7 = 0.675

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_8 = arg_249_1:FormatText(StoryNameCfg[1502].name)

				arg_249_1.leftNameTxt_.text = var_252_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_9 = arg_249_1:GetWordFromCfg(324171060)
				local var_252_10 = arg_249_1:FormatText(var_252_9.content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171060", "story_v_out_324171.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171060", "story_v_out_324171.awb") / 1000

					if var_252_14 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_6
					end

					if var_252_9.prefab_name ~= "" and arg_249_1.actors_[var_252_9.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_9.prefab_name].transform, "story_v_out_324171", "324171060", "story_v_out_324171.awb")

						arg_249_1:RecordAudio("324171060", var_252_15)
						arg_249_1:RecordAudio("324171060", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_324171", "324171060", "story_v_out_324171.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_324171", "324171060", "story_v_out_324171.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_16 and arg_249_1.time_ < var_252_6 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play324171061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 324171061
		arg_253_1.duration_ = 2.03

		local var_253_0 = {
			zh = 2.033,
			ja = 1.533
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
				arg_253_0:Play324171062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.2

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[1502].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(324171061)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 8
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171061", "story_v_out_324171.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171061", "story_v_out_324171.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_324171", "324171061", "story_v_out_324171.awb")

						arg_253_1:RecordAudio("324171061", var_256_9)
						arg_253_1:RecordAudio("324171061", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_324171", "324171061", "story_v_out_324171.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_324171", "324171061", "story_v_out_324171.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_10 and arg_253_1.time_ < var_256_0 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play324171062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 324171062
		arg_257_1.duration_ = 4.4

		local var_257_0 = {
			zh = 4.4,
			ja = 4.1
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play324171063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.425

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[1498].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(324171062)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 17
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171062", "story_v_out_324171.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171062", "story_v_out_324171.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_324171", "324171062", "story_v_out_324171.awb")

						arg_257_1:RecordAudio("324171062", var_260_9)
						arg_257_1:RecordAudio("324171062", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_324171", "324171062", "story_v_out_324171.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_324171", "324171062", "story_v_out_324171.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play324171063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 324171063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play324171064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.9

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				local var_264_2 = "play"
				local var_264_3 = "effect"

				arg_261_1:AudioAction(var_264_2, var_264_3, "se_story_150", "se_story_150_bamboo01", "")
			end

			local var_264_4 = 0
			local var_264_5 = 0.9

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(324171063)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_8 = 36
				local var_264_9 = utf8.len(var_264_7)
				local var_264_10 = var_264_8 <= 0 and var_264_5 or var_264_5 * (var_264_9 / var_264_8)

				if var_264_10 > 0 and var_264_5 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_11 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_11 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_11

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_11 and arg_261_1.time_ < var_264_4 + var_264_11 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play324171064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 324171064
		arg_265_1.duration_ = 5.27

		local var_265_0 = {
			zh = 4.733333333332,
			ja = 5.26633333631357
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play324171065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 1.5

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				local var_268_1 = manager.ui.mainCamera.transform.localPosition
				local var_268_2 = Vector3.New(0, 0, 10) + Vector3.New(var_268_1.x, var_268_1.y, 0)
				local var_268_3 = arg_265_1.bgs_.ST2009

				var_268_3.transform.localPosition = var_268_2
				var_268_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_4 = var_268_3:GetComponent("SpriteRenderer")

				if var_268_4 and var_268_4.sprite then
					local var_268_5 = (var_268_3.transform.localPosition - var_268_1).z
					local var_268_6 = manager.ui.mainCameraCom_
					local var_268_7 = 2 * var_268_5 * Mathf.Tan(var_268_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_268_8 = var_268_7 * var_268_6.aspect
					local var_268_9 = var_268_4.sprite.bounds.size.x
					local var_268_10 = var_268_4.sprite.bounds.size.y
					local var_268_11 = var_268_8 / var_268_9
					local var_268_12 = var_268_7 / var_268_10
					local var_268_13 = var_268_12 < var_268_11 and var_268_11 or var_268_12

					var_268_3.transform.localScale = Vector3.New(var_268_13, var_268_13, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "ST2009" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_14 = 0

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			local var_268_15 = 0.3

			if arg_265_1.time_ >= var_268_14 + var_268_15 and arg_265_1.time_ < var_268_14 + var_268_15 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_17 = 1.5

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17
				local var_268_19 = Color.New(0, 0, 0)

				var_268_19.a = Mathf.Lerp(0, 1, var_268_18)
				arg_265_1.mask_.color = var_268_19
			end

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 then
				local var_268_20 = Color.New(0, 0, 0)

				var_268_20.a = 1
				arg_265_1.mask_.color = var_268_20
			end

			local var_268_21 = 1.5

			if var_268_21 < arg_265_1.time_ and arg_265_1.time_ <= var_268_21 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_22 = 1.5

			if var_268_21 <= arg_265_1.time_ and arg_265_1.time_ < var_268_21 + var_268_22 then
				local var_268_23 = (arg_265_1.time_ - var_268_21) / var_268_22
				local var_268_24 = Color.New(0, 0, 0)

				var_268_24.a = Mathf.Lerp(1, 0, var_268_23)
				arg_265_1.mask_.color = var_268_24
			end

			if arg_265_1.time_ >= var_268_21 + var_268_22 and arg_265_1.time_ < var_268_21 + var_268_22 + arg_268_0 then
				local var_268_25 = Color.New(0, 0, 0)
				local var_268_26 = 0

				arg_265_1.mask_.enabled = false
				var_268_25.a = var_268_26
				arg_265_1.mask_.color = var_268_25
			end

			local var_268_27 = arg_265_1.actors_["1170ui_story"].transform
			local var_268_28 = 2.73333333333333

			if var_268_28 < arg_265_1.time_ and arg_265_1.time_ <= var_268_28 + arg_268_0 then
				arg_265_1.var_.moveOldPos1170ui_story = var_268_27.localPosition

				local var_268_29 = GameObjectTools.GetOrAddComponent(var_268_27.gameObject, typeof(DynamicBoneHelper))

				if var_268_29 then
					var_268_29:EnableDynamicBone(false)
				end
			end

			local var_268_30 = 0.001

			if var_268_28 <= arg_265_1.time_ and arg_265_1.time_ < var_268_28 + var_268_30 then
				local var_268_31 = (arg_265_1.time_ - var_268_28) / var_268_30
				local var_268_32 = Vector3.New(0.03, -0.95, -6.08)

				var_268_27.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1170ui_story, var_268_32, var_268_31)

				local var_268_33 = manager.ui.mainCamera.transform.position - var_268_27.position

				var_268_27.forward = Vector3.New(var_268_33.x, var_268_33.y, var_268_33.z)

				local var_268_34 = var_268_27.localEulerAngles

				var_268_34.z = 0
				var_268_34.x = 0
				var_268_27.localEulerAngles = var_268_34
			end

			if arg_265_1.time_ >= var_268_28 + var_268_30 and arg_265_1.time_ < var_268_28 + var_268_30 + arg_268_0 then
				var_268_27.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_268_35 = manager.ui.mainCamera.transform.position - var_268_27.position

				var_268_27.forward = Vector3.New(var_268_35.x, var_268_35.y, var_268_35.z)

				local var_268_36 = var_268_27.localEulerAngles

				var_268_36.z = 0
				var_268_36.x = 0
				var_268_27.localEulerAngles = var_268_36

				local var_268_37 = GameObjectTools.GetOrAddComponent(var_268_27.gameObject, typeof(DynamicBoneHelper))

				if var_268_37 then
					var_268_37:EnableDynamicBone(true)
				end
			end

			local var_268_38 = arg_265_1.actors_["1170ui_story"]
			local var_268_39 = 2.73333333333333

			if var_268_39 < arg_265_1.time_ and arg_265_1.time_ <= var_268_39 + arg_268_0 and not isNil(var_268_38) and arg_265_1.var_.characterEffect1170ui_story == nil then
				arg_265_1.var_.characterEffect1170ui_story = var_268_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_40 = 0.200000002980232

			if var_268_39 <= arg_265_1.time_ and arg_265_1.time_ < var_268_39 + var_268_40 and not isNil(var_268_38) then
				local var_268_41 = (arg_265_1.time_ - var_268_39) / var_268_40

				if arg_265_1.var_.characterEffect1170ui_story and not isNil(var_268_38) then
					arg_265_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_39 + var_268_40 and arg_265_1.time_ < var_268_39 + var_268_40 + arg_268_0 and not isNil(var_268_38) and arg_265_1.var_.characterEffect1170ui_story then
				arg_265_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_268_42 = 2.73333333333333

			if var_268_42 < arg_265_1.time_ and arg_265_1.time_ <= var_268_42 + arg_268_0 then
				arg_265_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			local var_268_43 = 2.73333333333333

			if var_268_43 < arg_265_1.time_ and arg_265_1.time_ <= var_268_43 + arg_268_0 then
				arg_265_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_268_44 = 0
			local var_268_45 = 1

			if var_268_44 < arg_265_1.time_ and arg_265_1.time_ <= var_268_44 + arg_268_0 then
				local var_268_46 = "play"
				local var_268_47 = "effect"

				arg_265_1:AudioAction(var_268_46, var_268_47, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_268_48 = 1
			local var_268_49 = 1

			if var_268_48 < arg_265_1.time_ and arg_265_1.time_ <= var_268_48 + arg_268_0 then
				local var_268_50 = "play"
				local var_268_51 = "music"

				arg_265_1:AudioAction(var_268_50, var_268_51, "bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun.awb")

				local var_268_52 = ""
				local var_268_53 = manager.audio:GetAudioName("bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun")

				if var_268_53 ~= "" then
					if arg_265_1.bgmTxt_.text ~= var_268_53 and arg_265_1.bgmTxt_.text ~= "" then
						if arg_265_1.bgmTxt2_.text ~= "" then
							arg_265_1.bgmTxt_.text = arg_265_1.bgmTxt2_.text
						end

						arg_265_1.bgmTxt2_.text = var_268_53

						arg_265_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_265_1.bgmTxt_.text = var_268_53
						arg_265_1.bgmTxt2_.text = var_268_53
					end

					if arg_265_1.bgmTimer then
						arg_265_1.bgmTimer:Stop()

						arg_265_1.bgmTimer = nil
					end

					if arg_265_1.settingData.show_music_name == 1 then
						arg_265_1.musicController:SetSelectedState("show")
						arg_265_1.musicAnimator_:Play("open", 0, 0)

						if arg_265_1.settingData.music_time ~= 0 then
							arg_265_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_265_1.settingData.music_time), function()
								if arg_265_1 == nil or isNil(arg_265_1.bgmTxt_) then
									return
								end

								arg_265_1.musicController:SetSelectedState("hide")
								arg_265_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_54 = 2.93333333631357
			local var_268_55 = 0.125

			if var_268_54 < arg_265_1.time_ and arg_265_1.time_ <= var_268_54 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_56 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_56:setOnUpdate(LuaHelper.FloatAction(function(arg_270_0)
					arg_265_1.dialogCg_.alpha = arg_270_0
				end))
				var_268_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_57 = arg_265_1:FormatText(StoryNameCfg[318].name)

				arg_265_1.leftNameTxt_.text = var_268_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_58 = arg_265_1:GetWordFromCfg(324171064)
				local var_268_59 = arg_265_1:FormatText(var_268_58.content)

				arg_265_1.text_.text = var_268_59

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_60 = 5
				local var_268_61 = utf8.len(var_268_59)
				local var_268_62 = var_268_60 <= 0 and var_268_55 or var_268_55 * (var_268_61 / var_268_60)

				if var_268_62 > 0 and var_268_55 < var_268_62 then
					arg_265_1.talkMaxDuration = var_268_62
					var_268_54 = var_268_54 + 0.3

					if var_268_62 + var_268_54 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_62 + var_268_54
					end
				end

				arg_265_1.text_.text = var_268_59
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171064", "story_v_out_324171.awb") ~= 0 then
					local var_268_63 = manager.audio:GetVoiceLength("story_v_out_324171", "324171064", "story_v_out_324171.awb") / 1000

					if var_268_63 + var_268_54 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_63 + var_268_54
					end

					if var_268_58.prefab_name ~= "" and arg_265_1.actors_[var_268_58.prefab_name] ~= nil then
						local var_268_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_58.prefab_name].transform, "story_v_out_324171", "324171064", "story_v_out_324171.awb")

						arg_265_1:RecordAudio("324171064", var_268_64)
						arg_265_1:RecordAudio("324171064", var_268_64)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_324171", "324171064", "story_v_out_324171.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_324171", "324171064", "story_v_out_324171.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_65 = var_268_54 + 0.3
			local var_268_66 = math.max(var_268_55, arg_265_1.talkMaxDuration)

			if var_268_65 <= arg_265_1.time_ and arg_265_1.time_ < var_268_65 + var_268_66 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_65) / var_268_66

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_65 + var_268_66 and arg_265_1.time_ < var_268_65 + var_268_66 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play324171065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 324171065
		arg_272_1.duration_ = 5.9

		local var_272_0 = {
			zh = 5.9,
			ja = 5.5
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play324171066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1170ui_story"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1170ui_story == nil then
				arg_272_1.var_.characterEffect1170ui_story = var_275_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 and not isNil(var_275_0) then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2

				if arg_272_1.var_.characterEffect1170ui_story and not isNil(var_275_0) then
					local var_275_4 = Mathf.Lerp(0, 0.5, var_275_3)

					arg_272_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_272_1.var_.characterEffect1170ui_story.fillRatio = var_275_4
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1170ui_story then
				local var_275_5 = 0.5

				arg_272_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_272_1.var_.characterEffect1170ui_story.fillRatio = var_275_5
			end

			local var_275_6 = 0
			local var_275_7 = 0.525

			if var_275_6 < arg_272_1.time_ and arg_272_1.time_ <= var_275_6 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_8 = arg_272_1:FormatText(StoryNameCfg[1498].name)

				arg_272_1.leftNameTxt_.text = var_275_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_9 = arg_272_1:GetWordFromCfg(324171065)
				local var_275_10 = arg_272_1:FormatText(var_275_9.content)

				arg_272_1.text_.text = var_275_10

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_11 = 21
				local var_275_12 = utf8.len(var_275_10)
				local var_275_13 = var_275_11 <= 0 and var_275_7 or var_275_7 * (var_275_12 / var_275_11)

				if var_275_13 > 0 and var_275_7 < var_275_13 then
					arg_272_1.talkMaxDuration = var_275_13

					if var_275_13 + var_275_6 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_13 + var_275_6
					end
				end

				arg_272_1.text_.text = var_275_10
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171065", "story_v_out_324171.awb") ~= 0 then
					local var_275_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171065", "story_v_out_324171.awb") / 1000

					if var_275_14 + var_275_6 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_14 + var_275_6
					end

					if var_275_9.prefab_name ~= "" and arg_272_1.actors_[var_275_9.prefab_name] ~= nil then
						local var_275_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_9.prefab_name].transform, "story_v_out_324171", "324171065", "story_v_out_324171.awb")

						arg_272_1:RecordAudio("324171065", var_275_15)
						arg_272_1:RecordAudio("324171065", var_275_15)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_324171", "324171065", "story_v_out_324171.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_324171", "324171065", "story_v_out_324171.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_16 = math.max(var_275_7, arg_272_1.talkMaxDuration)

			if var_275_6 <= arg_272_1.time_ and arg_272_1.time_ < var_275_6 + var_275_16 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_6) / var_275_16

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_6 + var_275_16 and arg_272_1.time_ < var_275_6 + var_275_16 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play324171066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 324171066
		arg_276_1.duration_ = 6.73

		local var_276_0 = {
			zh = 6.733,
			ja = 6.033
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play324171067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1170ui_story"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1170ui_story == nil then
				arg_276_1.var_.characterEffect1170ui_story = var_279_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.characterEffect1170ui_story and not isNil(var_279_0) then
					arg_276_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1170ui_story then
				arg_276_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_279_4 = 0

			if var_279_4 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_2")
			end

			local var_279_5 = 0
			local var_279_6 = 0.775

			if var_279_5 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_7 = arg_276_1:FormatText(StoryNameCfg[318].name)

				arg_276_1.leftNameTxt_.text = var_279_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_8 = arg_276_1:GetWordFromCfg(324171066)
				local var_279_9 = arg_276_1:FormatText(var_279_8.content)

				arg_276_1.text_.text = var_279_9

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_10 = 31
				local var_279_11 = utf8.len(var_279_9)
				local var_279_12 = var_279_10 <= 0 and var_279_6 or var_279_6 * (var_279_11 / var_279_10)

				if var_279_12 > 0 and var_279_6 < var_279_12 then
					arg_276_1.talkMaxDuration = var_279_12

					if var_279_12 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_12 + var_279_5
					end
				end

				arg_276_1.text_.text = var_279_9
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171066", "story_v_out_324171.awb") ~= 0 then
					local var_279_13 = manager.audio:GetVoiceLength("story_v_out_324171", "324171066", "story_v_out_324171.awb") / 1000

					if var_279_13 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_5
					end

					if var_279_8.prefab_name ~= "" and arg_276_1.actors_[var_279_8.prefab_name] ~= nil then
						local var_279_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_8.prefab_name].transform, "story_v_out_324171", "324171066", "story_v_out_324171.awb")

						arg_276_1:RecordAudio("324171066", var_279_14)
						arg_276_1:RecordAudio("324171066", var_279_14)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_324171", "324171066", "story_v_out_324171.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_324171", "324171066", "story_v_out_324171.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_15 = math.max(var_279_6, arg_276_1.talkMaxDuration)

			if var_279_5 <= arg_276_1.time_ and arg_276_1.time_ < var_279_5 + var_279_15 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_5) / var_279_15

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_5 + var_279_15 and arg_276_1.time_ < var_279_5 + var_279_15 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play324171067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 324171067
		arg_280_1.duration_ = 2.17

		local var_280_0 = {
			zh = 2.166,
			ja = 2.066
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play324171068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1170ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1170ui_story == nil then
				arg_280_1.var_.characterEffect1170ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect1170ui_story and not isNil(var_283_0) then
					local var_283_4 = Mathf.Lerp(0, 0.5, var_283_3)

					arg_280_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1170ui_story.fillRatio = var_283_4
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1170ui_story then
				local var_283_5 = 0.5

				arg_280_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1170ui_story.fillRatio = var_283_5
			end

			local var_283_6 = 0
			local var_283_7 = 0.075

			if var_283_6 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_8 = arg_280_1:FormatText(StoryNameCfg[1498].name)

				arg_280_1.leftNameTxt_.text = var_283_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_9 = arg_280_1:GetWordFromCfg(324171067)
				local var_283_10 = arg_280_1:FormatText(var_283_9.content)

				arg_280_1.text_.text = var_283_10

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 3
				local var_283_12 = utf8.len(var_283_10)
				local var_283_13 = var_283_11 <= 0 and var_283_7 or var_283_7 * (var_283_12 / var_283_11)

				if var_283_13 > 0 and var_283_7 < var_283_13 then
					arg_280_1.talkMaxDuration = var_283_13

					if var_283_13 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_10
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171067", "story_v_out_324171.awb") ~= 0 then
					local var_283_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171067", "story_v_out_324171.awb") / 1000

					if var_283_14 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_14 + var_283_6
					end

					if var_283_9.prefab_name ~= "" and arg_280_1.actors_[var_283_9.prefab_name] ~= nil then
						local var_283_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_9.prefab_name].transform, "story_v_out_324171", "324171067", "story_v_out_324171.awb")

						arg_280_1:RecordAudio("324171067", var_283_15)
						arg_280_1:RecordAudio("324171067", var_283_15)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_324171", "324171067", "story_v_out_324171.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_324171", "324171067", "story_v_out_324171.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_16 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_16 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_16

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_16 and arg_280_1.time_ < var_283_6 + var_283_16 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play324171068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 324171068
		arg_284_1.duration_ = 12.6

		local var_284_0 = {
			zh = 10.7,
			ja = 12.6
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play324171069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1170ui_story"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1170ui_story == nil then
				arg_284_1.var_.characterEffect1170ui_story = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect1170ui_story and not isNil(var_287_0) then
					arg_284_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1170ui_story then
				arg_284_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_287_4 = 0

			if var_287_4 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_1")
			end

			local var_287_5 = 0

			if var_287_5 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_287_6 = 0
			local var_287_7 = 1.175

			if var_287_6 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_8 = arg_284_1:FormatText(StoryNameCfg[318].name)

				arg_284_1.leftNameTxt_.text = var_287_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_9 = arg_284_1:GetWordFromCfg(324171068)
				local var_287_10 = arg_284_1:FormatText(var_287_9.content)

				arg_284_1.text_.text = var_287_10

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 47
				local var_287_12 = utf8.len(var_287_10)
				local var_287_13 = var_287_11 <= 0 and var_287_7 or var_287_7 * (var_287_12 / var_287_11)

				if var_287_13 > 0 and var_287_7 < var_287_13 then
					arg_284_1.talkMaxDuration = var_287_13

					if var_287_13 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_6
					end
				end

				arg_284_1.text_.text = var_287_10
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171068", "story_v_out_324171.awb") ~= 0 then
					local var_287_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171068", "story_v_out_324171.awb") / 1000

					if var_287_14 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_14 + var_287_6
					end

					if var_287_9.prefab_name ~= "" and arg_284_1.actors_[var_287_9.prefab_name] ~= nil then
						local var_287_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_9.prefab_name].transform, "story_v_out_324171", "324171068", "story_v_out_324171.awb")

						arg_284_1:RecordAudio("324171068", var_287_15)
						arg_284_1:RecordAudio("324171068", var_287_15)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_324171", "324171068", "story_v_out_324171.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_324171", "324171068", "story_v_out_324171.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_16 = math.max(var_287_7, arg_284_1.talkMaxDuration)

			if var_287_6 <= arg_284_1.time_ and arg_284_1.time_ < var_287_6 + var_287_16 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_6) / var_287_16

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_6 + var_287_16 and arg_284_1.time_ < var_287_6 + var_287_16 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play324171069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 324171069
		arg_288_1.duration_ = 10.4

		local var_288_0 = {
			zh = 7.633,
			ja = 10.4
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play324171070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1170ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1170ui_story == nil then
				arg_288_1.var_.characterEffect1170ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect1170ui_story and not isNil(var_291_0) then
					local var_291_4 = Mathf.Lerp(0, 0.5, var_291_3)

					arg_288_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1170ui_story.fillRatio = var_291_4
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1170ui_story then
				local var_291_5 = 0.5

				arg_288_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1170ui_story.fillRatio = var_291_5
			end

			local var_291_6 = 0
			local var_291_7 = 0.65

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_8 = arg_288_1:FormatText(StoryNameCfg[1498].name)

				arg_288_1.leftNameTxt_.text = var_291_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_9 = arg_288_1:GetWordFromCfg(324171069)
				local var_291_10 = arg_288_1:FormatText(var_291_9.content)

				arg_288_1.text_.text = var_291_10

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_11 = 26
				local var_291_12 = utf8.len(var_291_10)
				local var_291_13 = var_291_11 <= 0 and var_291_7 or var_291_7 * (var_291_12 / var_291_11)

				if var_291_13 > 0 and var_291_7 < var_291_13 then
					arg_288_1.talkMaxDuration = var_291_13

					if var_291_13 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_10
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171069", "story_v_out_324171.awb") ~= 0 then
					local var_291_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171069", "story_v_out_324171.awb") / 1000

					if var_291_14 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_14 + var_291_6
					end

					if var_291_9.prefab_name ~= "" and arg_288_1.actors_[var_291_9.prefab_name] ~= nil then
						local var_291_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_9.prefab_name].transform, "story_v_out_324171", "324171069", "story_v_out_324171.awb")

						arg_288_1:RecordAudio("324171069", var_291_15)
						arg_288_1:RecordAudio("324171069", var_291_15)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_324171", "324171069", "story_v_out_324171.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_324171", "324171069", "story_v_out_324171.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_16 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_16 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_16

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_16 and arg_288_1.time_ < var_291_6 + var_291_16 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play324171070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 324171070
		arg_292_1.duration_ = 7.73

		local var_292_0 = {
			zh = 6.3,
			ja = 7.733
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play324171071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1170ui_story"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1170ui_story == nil then
				arg_292_1.var_.characterEffect1170ui_story = var_295_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.characterEffect1170ui_story and not isNil(var_295_0) then
					arg_292_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1170ui_story then
				arg_292_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_295_4 = 0
			local var_295_5 = 0.65

			if var_295_4 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_6 = arg_292_1:FormatText(StoryNameCfg[318].name)

				arg_292_1.leftNameTxt_.text = var_295_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_7 = arg_292_1:GetWordFromCfg(324171070)
				local var_295_8 = arg_292_1:FormatText(var_295_7.content)

				arg_292_1.text_.text = var_295_8

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_9 = 26
				local var_295_10 = utf8.len(var_295_8)
				local var_295_11 = var_295_9 <= 0 and var_295_5 or var_295_5 * (var_295_10 / var_295_9)

				if var_295_11 > 0 and var_295_5 < var_295_11 then
					arg_292_1.talkMaxDuration = var_295_11

					if var_295_11 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_11 + var_295_4
					end
				end

				arg_292_1.text_.text = var_295_8
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171070", "story_v_out_324171.awb") ~= 0 then
					local var_295_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171070", "story_v_out_324171.awb") / 1000

					if var_295_12 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_12 + var_295_4
					end

					if var_295_7.prefab_name ~= "" and arg_292_1.actors_[var_295_7.prefab_name] ~= nil then
						local var_295_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_7.prefab_name].transform, "story_v_out_324171", "324171070", "story_v_out_324171.awb")

						arg_292_1:RecordAudio("324171070", var_295_13)
						arg_292_1:RecordAudio("324171070", var_295_13)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_324171", "324171070", "story_v_out_324171.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_324171", "324171070", "story_v_out_324171.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_14 = math.max(var_295_5, arg_292_1.talkMaxDuration)

			if var_295_4 <= arg_292_1.time_ and arg_292_1.time_ < var_295_4 + var_295_14 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_4) / var_295_14

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_4 + var_295_14 and arg_292_1.time_ < var_295_4 + var_295_14 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play324171071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 324171071
		arg_296_1.duration_ = 4.47

		local var_296_0 = {
			zh = 4.466,
			ja = 3.666
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play324171072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_2")
			end

			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_299_2 = 0
			local var_299_3 = 0.575

			if var_299_2 < arg_296_1.time_ and arg_296_1.time_ <= var_299_2 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_4 = arg_296_1:FormatText(StoryNameCfg[318].name)

				arg_296_1.leftNameTxt_.text = var_299_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_5 = arg_296_1:GetWordFromCfg(324171071)
				local var_299_6 = arg_296_1:FormatText(var_299_5.content)

				arg_296_1.text_.text = var_299_6

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_7 = 23
				local var_299_8 = utf8.len(var_299_6)
				local var_299_9 = var_299_7 <= 0 and var_299_3 or var_299_3 * (var_299_8 / var_299_7)

				if var_299_9 > 0 and var_299_3 < var_299_9 then
					arg_296_1.talkMaxDuration = var_299_9

					if var_299_9 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_2
					end
				end

				arg_296_1.text_.text = var_299_6
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171071", "story_v_out_324171.awb") ~= 0 then
					local var_299_10 = manager.audio:GetVoiceLength("story_v_out_324171", "324171071", "story_v_out_324171.awb") / 1000

					if var_299_10 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_2
					end

					if var_299_5.prefab_name ~= "" and arg_296_1.actors_[var_299_5.prefab_name] ~= nil then
						local var_299_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_5.prefab_name].transform, "story_v_out_324171", "324171071", "story_v_out_324171.awb")

						arg_296_1:RecordAudio("324171071", var_299_11)
						arg_296_1:RecordAudio("324171071", var_299_11)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_324171", "324171071", "story_v_out_324171.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_324171", "324171071", "story_v_out_324171.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_12 = math.max(var_299_3, arg_296_1.talkMaxDuration)

			if var_299_2 <= arg_296_1.time_ and arg_296_1.time_ < var_299_2 + var_299_12 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_2) / var_299_12

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_2 + var_299_12 and arg_296_1.time_ < var_299_2 + var_299_12 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play324171072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 324171072
		arg_300_1.duration_ = 6.93

		local var_300_0 = {
			zh = 4.666,
			ja = 6.933
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play324171073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 0.525

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_2 = arg_300_1:FormatText(StoryNameCfg[318].name)

				arg_300_1.leftNameTxt_.text = var_303_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_3 = arg_300_1:GetWordFromCfg(324171072)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 21
				local var_303_6 = utf8.len(var_303_4)
				local var_303_7 = var_303_5 <= 0 and var_303_1 or var_303_1 * (var_303_6 / var_303_5)

				if var_303_7 > 0 and var_303_1 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171072", "story_v_out_324171.awb") ~= 0 then
					local var_303_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171072", "story_v_out_324171.awb") / 1000

					if var_303_8 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_0
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_out_324171", "324171072", "story_v_out_324171.awb")

						arg_300_1:RecordAudio("324171072", var_303_9)
						arg_300_1:RecordAudio("324171072", var_303_9)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_324171", "324171072", "story_v_out_324171.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_324171", "324171072", "story_v_out_324171.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_10 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_10 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_10

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_10 and arg_300_1.time_ < var_303_0 + var_303_10 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play324171073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 324171073
		arg_304_1.duration_ = 2.3

		local var_304_0 = {
			zh = 1.9,
			ja = 2.3
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play324171074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1170ui_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1170ui_story == nil then
				arg_304_1.var_.characterEffect1170ui_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect1170ui_story and not isNil(var_307_0) then
					local var_307_4 = Mathf.Lerp(0, 0.5, var_307_3)

					arg_304_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1170ui_story.fillRatio = var_307_4
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1170ui_story then
				local var_307_5 = 0.5

				arg_304_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1170ui_story.fillRatio = var_307_5
			end

			local var_307_6 = 0
			local var_307_7 = 0.15

			if var_307_6 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_8 = arg_304_1:FormatText(StoryNameCfg[1498].name)

				arg_304_1.leftNameTxt_.text = var_307_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_9 = arg_304_1:GetWordFromCfg(324171073)
				local var_307_10 = arg_304_1:FormatText(var_307_9.content)

				arg_304_1.text_.text = var_307_10

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_11 = 6
				local var_307_12 = utf8.len(var_307_10)
				local var_307_13 = var_307_11 <= 0 and var_307_7 or var_307_7 * (var_307_12 / var_307_11)

				if var_307_13 > 0 and var_307_7 < var_307_13 then
					arg_304_1.talkMaxDuration = var_307_13

					if var_307_13 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_13 + var_307_6
					end
				end

				arg_304_1.text_.text = var_307_10
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171073", "story_v_out_324171.awb") ~= 0 then
					local var_307_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171073", "story_v_out_324171.awb") / 1000

					if var_307_14 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_14 + var_307_6
					end

					if var_307_9.prefab_name ~= "" and arg_304_1.actors_[var_307_9.prefab_name] ~= nil then
						local var_307_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_9.prefab_name].transform, "story_v_out_324171", "324171073", "story_v_out_324171.awb")

						arg_304_1:RecordAudio("324171073", var_307_15)
						arg_304_1:RecordAudio("324171073", var_307_15)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_324171", "324171073", "story_v_out_324171.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_324171", "324171073", "story_v_out_324171.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_16 = math.max(var_307_7, arg_304_1.talkMaxDuration)

			if var_307_6 <= arg_304_1.time_ and arg_304_1.time_ < var_307_6 + var_307_16 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_6) / var_307_16

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_6 + var_307_16 and arg_304_1.time_ < var_307_6 + var_307_16 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play324171074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 324171074
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play324171075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1170ui_story"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos1170ui_story = var_311_0.localPosition

				local var_311_2 = GameObjectTools.GetOrAddComponent(var_311_0.gameObject, typeof(DynamicBoneHelper))

				if var_311_2 then
					var_311_2:EnableDynamicBone(false)
				end
			end

			local var_311_3 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_3 then
				local var_311_4 = (arg_308_1.time_ - var_311_1) / var_311_3
				local var_311_5 = Vector3.New(0, 100, 0)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1170ui_story, var_311_5, var_311_4)

				local var_311_6 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_6.x, var_311_6.y, var_311_6.z)

				local var_311_7 = var_311_0.localEulerAngles

				var_311_7.z = 0
				var_311_7.x = 0
				var_311_0.localEulerAngles = var_311_7
			end

			if arg_308_1.time_ >= var_311_1 + var_311_3 and arg_308_1.time_ < var_311_1 + var_311_3 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(0, 100, 0)

				local var_311_8 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_8.x, var_311_8.y, var_311_8.z)

				local var_311_9 = var_311_0.localEulerAngles

				var_311_9.z = 0
				var_311_9.x = 0
				var_311_0.localEulerAngles = var_311_9

				local var_311_10 = GameObjectTools.GetOrAddComponent(var_311_0.gameObject, typeof(DynamicBoneHelper))

				if var_311_10 then
					var_311_10:EnableDynamicBone(true)
				end
			end

			local var_311_11 = 0
			local var_311_12 = 0.625

			if var_311_11 < arg_308_1.time_ and arg_308_1.time_ <= var_311_11 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_13 = arg_308_1:GetWordFromCfg(324171074)
				local var_311_14 = arg_308_1:FormatText(var_311_13.content)

				arg_308_1.text_.text = var_311_14

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_15 = 25
				local var_311_16 = utf8.len(var_311_14)
				local var_311_17 = var_311_15 <= 0 and var_311_12 or var_311_12 * (var_311_16 / var_311_15)

				if var_311_17 > 0 and var_311_12 < var_311_17 then
					arg_308_1.talkMaxDuration = var_311_17

					if var_311_17 + var_311_11 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_17 + var_311_11
					end
				end

				arg_308_1.text_.text = var_311_14
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_18 = math.max(var_311_12, arg_308_1.talkMaxDuration)

			if var_311_11 <= arg_308_1.time_ and arg_308_1.time_ < var_311_11 + var_311_18 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_11) / var_311_18

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_11 + var_311_18 and arg_308_1.time_ < var_311_11 + var_311_18 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play324171075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 324171075
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play324171076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 0.7

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_2 = arg_312_1:GetWordFromCfg(324171075)
				local var_315_3 = arg_312_1:FormatText(var_315_2.content)

				arg_312_1.text_.text = var_315_3

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 28
				local var_315_5 = utf8.len(var_315_3)
				local var_315_6 = var_315_4 <= 0 and var_315_1 or var_315_1 * (var_315_5 / var_315_4)

				if var_315_6 > 0 and var_315_1 < var_315_6 then
					arg_312_1.talkMaxDuration = var_315_6

					if var_315_6 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_6 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_3
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_7 and arg_312_1.time_ < var_315_0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play324171076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 324171076
		arg_316_1.duration_ = 3.8

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play324171077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.3

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[1495].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:GetWordFromCfg(324171076)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 12
				local var_319_6 = utf8.len(var_319_4)
				local var_319_7 = var_319_5 <= 0 and var_319_1 or var_319_1 * (var_319_6 / var_319_5)

				if var_319_7 > 0 and var_319_1 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171076", "story_v_out_324171.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171076", "story_v_out_324171.awb") / 1000

					if var_319_8 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_0
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_out_324171", "324171076", "story_v_out_324171.awb")

						arg_316_1:RecordAudio("324171076", var_319_9)
						arg_316_1:RecordAudio("324171076", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_324171", "324171076", "story_v_out_324171.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_324171", "324171076", "story_v_out_324171.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_10 and arg_316_1.time_ < var_319_0 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play324171077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 324171077
		arg_320_1.duration_ = 3.2

		local var_320_0 = {
			zh = 2.8,
			ja = 3.2
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play324171078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.3

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_2 = arg_320_1:FormatText(StoryNameCfg[1494].name)

				arg_320_1.leftNameTxt_.text = var_323_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_3 = arg_320_1:GetWordFromCfg(324171077)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 12
				local var_323_6 = utf8.len(var_323_4)
				local var_323_7 = var_323_5 <= 0 and var_323_1 or var_323_1 * (var_323_6 / var_323_5)

				if var_323_7 > 0 and var_323_1 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171077", "story_v_out_324171.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171077", "story_v_out_324171.awb") / 1000

					if var_323_8 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_0
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_324171", "324171077", "story_v_out_324171.awb")

						arg_320_1:RecordAudio("324171077", var_323_9)
						arg_320_1:RecordAudio("324171077", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_324171", "324171077", "story_v_out_324171.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_324171", "324171077", "story_v_out_324171.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_10 and arg_320_1.time_ < var_323_0 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play324171078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 324171078
		arg_324_1.duration_ = 3.83

		local var_324_0 = {
			zh = 3.266,
			ja = 3.833
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play324171079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.3

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_2 = arg_324_1:FormatText(StoryNameCfg[1496].name)

				arg_324_1.leftNameTxt_.text = var_327_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_3 = arg_324_1:GetWordFromCfg(324171078)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 12
				local var_327_6 = utf8.len(var_327_4)
				local var_327_7 = var_327_5 <= 0 and var_327_1 or var_327_1 * (var_327_6 / var_327_5)

				if var_327_7 > 0 and var_327_1 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171078", "story_v_out_324171.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171078", "story_v_out_324171.awb") / 1000

					if var_327_8 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_0
					end

					if var_327_3.prefab_name ~= "" and arg_324_1.actors_[var_327_3.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_3.prefab_name].transform, "story_v_out_324171", "324171078", "story_v_out_324171.awb")

						arg_324_1:RecordAudio("324171078", var_327_9)
						arg_324_1:RecordAudio("324171078", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_324171", "324171078", "story_v_out_324171.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_324171", "324171078", "story_v_out_324171.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_10 and arg_324_1.time_ < var_327_0 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play324171079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 324171079
		arg_328_1.duration_ = 3.7

		local var_328_0 = {
			zh = 2.966,
			ja = 3.7
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play324171080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1170ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1170ui_story == nil then
				arg_328_1.var_.characterEffect1170ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect1170ui_story and not isNil(var_331_0) then
					arg_328_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1170ui_story then
				arg_328_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_331_4 = 0
			local var_331_5 = 0.35

			if var_331_4 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_6 = arg_328_1:FormatText(StoryNameCfg[318].name)

				arg_328_1.leftNameTxt_.text = var_331_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1170")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_7 = arg_328_1:GetWordFromCfg(324171079)
				local var_331_8 = arg_328_1:FormatText(var_331_7.content)

				arg_328_1.text_.text = var_331_8

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_9 = 14
				local var_331_10 = utf8.len(var_331_8)
				local var_331_11 = var_331_9 <= 0 and var_331_5 or var_331_5 * (var_331_10 / var_331_9)

				if var_331_11 > 0 and var_331_5 < var_331_11 then
					arg_328_1.talkMaxDuration = var_331_11

					if var_331_11 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_11 + var_331_4
					end
				end

				arg_328_1.text_.text = var_331_8
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171079", "story_v_out_324171.awb") ~= 0 then
					local var_331_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171079", "story_v_out_324171.awb") / 1000

					if var_331_12 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_12 + var_331_4
					end

					if var_331_7.prefab_name ~= "" and arg_328_1.actors_[var_331_7.prefab_name] ~= nil then
						local var_331_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_7.prefab_name].transform, "story_v_out_324171", "324171079", "story_v_out_324171.awb")

						arg_328_1:RecordAudio("324171079", var_331_13)
						arg_328_1:RecordAudio("324171079", var_331_13)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_324171", "324171079", "story_v_out_324171.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_324171", "324171079", "story_v_out_324171.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_14 = math.max(var_331_5, arg_328_1.talkMaxDuration)

			if var_331_4 <= arg_328_1.time_ and arg_328_1.time_ < var_331_4 + var_331_14 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_4) / var_331_14

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_4 + var_331_14 and arg_328_1.time_ < var_331_4 + var_331_14 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play324171080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 324171080
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play324171081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1170ui_story"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1170ui_story == nil then
				arg_332_1.var_.characterEffect1170ui_story = var_335_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.characterEffect1170ui_story and not isNil(var_335_0) then
					local var_335_4 = Mathf.Lerp(0, 0.5, var_335_3)

					arg_332_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1170ui_story.fillRatio = var_335_4
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1170ui_story then
				local var_335_5 = 0.5

				arg_332_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1170ui_story.fillRatio = var_335_5
			end

			local var_335_6 = 0
			local var_335_7 = 0.8

			if var_335_6 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_8 = arg_332_1:GetWordFromCfg(324171080)
				local var_335_9 = arg_332_1:FormatText(var_335_8.content)

				arg_332_1.text_.text = var_335_9

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_10 = 32
				local var_335_11 = utf8.len(var_335_9)
				local var_335_12 = var_335_10 <= 0 and var_335_7 or var_335_7 * (var_335_11 / var_335_10)

				if var_335_12 > 0 and var_335_7 < var_335_12 then
					arg_332_1.talkMaxDuration = var_335_12

					if var_335_12 + var_335_6 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_12 + var_335_6
					end
				end

				arg_332_1.text_.text = var_335_9
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_13 = math.max(var_335_7, arg_332_1.talkMaxDuration)

			if var_335_6 <= arg_332_1.time_ and arg_332_1.time_ < var_335_6 + var_335_13 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_6) / var_335_13

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_6 + var_335_13 and arg_332_1.time_ < var_335_6 + var_335_13 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play324171081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 324171081
		arg_336_1.duration_ = 2.9

		local var_336_0 = {
			zh = 2.3,
			ja = 2.9
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play324171082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0
			local var_339_1 = 0.25

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_2 = arg_336_1:FormatText(StoryNameCfg[1494].name)

				arg_336_1.leftNameTxt_.text = var_339_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_3 = arg_336_1:GetWordFromCfg(324171081)
				local var_339_4 = arg_336_1:FormatText(var_339_3.content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 10
				local var_339_6 = utf8.len(var_339_4)
				local var_339_7 = var_339_5 <= 0 and var_339_1 or var_339_1 * (var_339_6 / var_339_5)

				if var_339_7 > 0 and var_339_1 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171081", "story_v_out_324171.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171081", "story_v_out_324171.awb") / 1000

					if var_339_8 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_0
					end

					if var_339_3.prefab_name ~= "" and arg_336_1.actors_[var_339_3.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_3.prefab_name].transform, "story_v_out_324171", "324171081", "story_v_out_324171.awb")

						arg_336_1:RecordAudio("324171081", var_339_9)
						arg_336_1:RecordAudio("324171081", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_324171", "324171081", "story_v_out_324171.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_324171", "324171081", "story_v_out_324171.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_10 and arg_336_1.time_ < var_339_0 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play324171082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 324171082
		arg_340_1.duration_ = 3.93

		local var_340_0 = {
			zh = 3.5,
			ja = 3.933
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play324171083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1170ui_story"].transform
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.var_.moveOldPos1170ui_story = var_343_0.localPosition

				local var_343_2 = GameObjectTools.GetOrAddComponent(var_343_0.gameObject, typeof(DynamicBoneHelper))

				if var_343_2 then
					var_343_2:EnableDynamicBone(false)
				end
			end

			local var_343_3 = 0.001

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_3 then
				local var_343_4 = (arg_340_1.time_ - var_343_1) / var_343_3
				local var_343_5 = Vector3.New(0.03, -0.95, -6.08)

				var_343_0.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1170ui_story, var_343_5, var_343_4)

				local var_343_6 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_6.x, var_343_6.y, var_343_6.z)

				local var_343_7 = var_343_0.localEulerAngles

				var_343_7.z = 0
				var_343_7.x = 0
				var_343_0.localEulerAngles = var_343_7
			end

			if arg_340_1.time_ >= var_343_1 + var_343_3 and arg_340_1.time_ < var_343_1 + var_343_3 + arg_343_0 then
				var_343_0.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_343_8 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_8.x, var_343_8.y, var_343_8.z)

				local var_343_9 = var_343_0.localEulerAngles

				var_343_9.z = 0
				var_343_9.x = 0
				var_343_0.localEulerAngles = var_343_9

				local var_343_10 = GameObjectTools.GetOrAddComponent(var_343_0.gameObject, typeof(DynamicBoneHelper))

				if var_343_10 then
					var_343_10:EnableDynamicBone(true)
				end
			end

			local var_343_11 = arg_340_1.actors_["1170ui_story"]
			local var_343_12 = 0

			if var_343_12 < arg_340_1.time_ and arg_340_1.time_ <= var_343_12 + arg_343_0 and not isNil(var_343_11) and arg_340_1.var_.characterEffect1170ui_story == nil then
				arg_340_1.var_.characterEffect1170ui_story = var_343_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_13 = 0.200000002980232

			if var_343_12 <= arg_340_1.time_ and arg_340_1.time_ < var_343_12 + var_343_13 and not isNil(var_343_11) then
				local var_343_14 = (arg_340_1.time_ - var_343_12) / var_343_13

				if arg_340_1.var_.characterEffect1170ui_story and not isNil(var_343_11) then
					arg_340_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= var_343_12 + var_343_13 and arg_340_1.time_ < var_343_12 + var_343_13 + arg_343_0 and not isNil(var_343_11) and arg_340_1.var_.characterEffect1170ui_story then
				arg_340_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_343_15 = 0

			if var_343_15 < arg_340_1.time_ and arg_340_1.time_ <= var_343_15 + arg_343_0 then
				arg_340_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action5_1")
			end

			local var_343_16 = 0

			if var_343_16 < arg_340_1.time_ and arg_340_1.time_ <= var_343_16 + arg_343_0 then
				arg_340_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_343_17 = 0
			local var_343_18 = 0.425

			if var_343_17 < arg_340_1.time_ and arg_340_1.time_ <= var_343_17 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_19 = arg_340_1:FormatText(StoryNameCfg[318].name)

				arg_340_1.leftNameTxt_.text = var_343_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_20 = arg_340_1:GetWordFromCfg(324171082)
				local var_343_21 = arg_340_1:FormatText(var_343_20.content)

				arg_340_1.text_.text = var_343_21

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_22 = 17
				local var_343_23 = utf8.len(var_343_21)
				local var_343_24 = var_343_22 <= 0 and var_343_18 or var_343_18 * (var_343_23 / var_343_22)

				if var_343_24 > 0 and var_343_18 < var_343_24 then
					arg_340_1.talkMaxDuration = var_343_24

					if var_343_24 + var_343_17 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_24 + var_343_17
					end
				end

				arg_340_1.text_.text = var_343_21
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171082", "story_v_out_324171.awb") ~= 0 then
					local var_343_25 = manager.audio:GetVoiceLength("story_v_out_324171", "324171082", "story_v_out_324171.awb") / 1000

					if var_343_25 + var_343_17 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_25 + var_343_17
					end

					if var_343_20.prefab_name ~= "" and arg_340_1.actors_[var_343_20.prefab_name] ~= nil then
						local var_343_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_20.prefab_name].transform, "story_v_out_324171", "324171082", "story_v_out_324171.awb")

						arg_340_1:RecordAudio("324171082", var_343_26)
						arg_340_1:RecordAudio("324171082", var_343_26)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_324171", "324171082", "story_v_out_324171.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_324171", "324171082", "story_v_out_324171.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_27 = math.max(var_343_18, arg_340_1.talkMaxDuration)

			if var_343_17 <= arg_340_1.time_ and arg_340_1.time_ < var_343_17 + var_343_27 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_17) / var_343_27

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_17 + var_343_27 and arg_340_1.time_ < var_343_17 + var_343_27 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play324171083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 324171083
		arg_344_1.duration_ = 5.27

		local var_344_0 = {
			zh = 2.733,
			ja = 5.266
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play324171084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1170ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1170ui_story == nil then
				arg_344_1.var_.characterEffect1170ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect1170ui_story and not isNil(var_347_0) then
					local var_347_4 = Mathf.Lerp(0, 0.5, var_347_3)

					arg_344_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1170ui_story.fillRatio = var_347_4
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1170ui_story then
				local var_347_5 = 0.5

				arg_344_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1170ui_story.fillRatio = var_347_5
			end

			local var_347_6 = 0
			local var_347_7 = 0.425

			if var_347_6 < arg_344_1.time_ and arg_344_1.time_ <= var_347_6 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_8 = arg_344_1:FormatText(StoryNameCfg[1494].name)

				arg_344_1.leftNameTxt_.text = var_347_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_9 = arg_344_1:GetWordFromCfg(324171083)
				local var_347_10 = arg_344_1:FormatText(var_347_9.content)

				arg_344_1.text_.text = var_347_10

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_11 = 17
				local var_347_12 = utf8.len(var_347_10)
				local var_347_13 = var_347_11 <= 0 and var_347_7 or var_347_7 * (var_347_12 / var_347_11)

				if var_347_13 > 0 and var_347_7 < var_347_13 then
					arg_344_1.talkMaxDuration = var_347_13

					if var_347_13 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_13 + var_347_6
					end
				end

				arg_344_1.text_.text = var_347_10
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171083", "story_v_out_324171.awb") ~= 0 then
					local var_347_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171083", "story_v_out_324171.awb") / 1000

					if var_347_14 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_14 + var_347_6
					end

					if var_347_9.prefab_name ~= "" and arg_344_1.actors_[var_347_9.prefab_name] ~= nil then
						local var_347_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_9.prefab_name].transform, "story_v_out_324171", "324171083", "story_v_out_324171.awb")

						arg_344_1:RecordAudio("324171083", var_347_15)
						arg_344_1:RecordAudio("324171083", var_347_15)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_324171", "324171083", "story_v_out_324171.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_324171", "324171083", "story_v_out_324171.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_16 = math.max(var_347_7, arg_344_1.talkMaxDuration)

			if var_347_6 <= arg_344_1.time_ and arg_344_1.time_ < var_347_6 + var_347_16 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_6) / var_347_16

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_6 + var_347_16 and arg_344_1.time_ < var_347_6 + var_347_16 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play324171084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 324171084
		arg_348_1.duration_ = 7.83

		local var_348_0 = {
			zh = 6.7,
			ja = 7.833
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play324171085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1170ui_story"]
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1170ui_story == nil then
				arg_348_1.var_.characterEffect1170ui_story = var_351_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.200000002980232

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 and not isNil(var_351_0) then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2

				if arg_348_1.var_.characterEffect1170ui_story and not isNil(var_351_0) then
					arg_348_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1170ui_story then
				arg_348_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_351_4 = 0
			local var_351_5 = 0.825

			if var_351_4 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_6 = arg_348_1:FormatText(StoryNameCfg[318].name)

				arg_348_1.leftNameTxt_.text = var_351_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_7 = arg_348_1:GetWordFromCfg(324171084)
				local var_351_8 = arg_348_1:FormatText(var_351_7.content)

				arg_348_1.text_.text = var_351_8

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_9 = 33
				local var_351_10 = utf8.len(var_351_8)
				local var_351_11 = var_351_9 <= 0 and var_351_5 or var_351_5 * (var_351_10 / var_351_9)

				if var_351_11 > 0 and var_351_5 < var_351_11 then
					arg_348_1.talkMaxDuration = var_351_11

					if var_351_11 + var_351_4 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_11 + var_351_4
					end
				end

				arg_348_1.text_.text = var_351_8
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171084", "story_v_out_324171.awb") ~= 0 then
					local var_351_12 = manager.audio:GetVoiceLength("story_v_out_324171", "324171084", "story_v_out_324171.awb") / 1000

					if var_351_12 + var_351_4 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_12 + var_351_4
					end

					if var_351_7.prefab_name ~= "" and arg_348_1.actors_[var_351_7.prefab_name] ~= nil then
						local var_351_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_7.prefab_name].transform, "story_v_out_324171", "324171084", "story_v_out_324171.awb")

						arg_348_1:RecordAudio("324171084", var_351_13)
						arg_348_1:RecordAudio("324171084", var_351_13)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_324171", "324171084", "story_v_out_324171.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_324171", "324171084", "story_v_out_324171.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_14 = math.max(var_351_5, arg_348_1.talkMaxDuration)

			if var_351_4 <= arg_348_1.time_ and arg_348_1.time_ < var_351_4 + var_351_14 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_4) / var_351_14

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_4 + var_351_14 and arg_348_1.time_ < var_351_4 + var_351_14 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play324171085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 324171085
		arg_352_1.duration_ = 7.93

		local var_352_0 = {
			zh = 7.933,
			ja = 7.8
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play324171086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1170ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1170ui_story == nil then
				arg_352_1.var_.characterEffect1170ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect1170ui_story and not isNil(var_355_0) then
					local var_355_4 = Mathf.Lerp(0, 0.5, var_355_3)

					arg_352_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1170ui_story.fillRatio = var_355_4
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1170ui_story then
				local var_355_5 = 0.5

				arg_352_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1170ui_story.fillRatio = var_355_5
			end

			local var_355_6 = 0
			local var_355_7 = 0.65

			if var_355_6 < arg_352_1.time_ and arg_352_1.time_ <= var_355_6 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_8 = arg_352_1:FormatText(StoryNameCfg[1495].name)

				arg_352_1.leftNameTxt_.text = var_355_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_9 = arg_352_1:GetWordFromCfg(324171085)
				local var_355_10 = arg_352_1:FormatText(var_355_9.content)

				arg_352_1.text_.text = var_355_10

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_11 = 26
				local var_355_12 = utf8.len(var_355_10)
				local var_355_13 = var_355_11 <= 0 and var_355_7 or var_355_7 * (var_355_12 / var_355_11)

				if var_355_13 > 0 and var_355_7 < var_355_13 then
					arg_352_1.talkMaxDuration = var_355_13

					if var_355_13 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_13 + var_355_6
					end
				end

				arg_352_1.text_.text = var_355_10
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171085", "story_v_out_324171.awb") ~= 0 then
					local var_355_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171085", "story_v_out_324171.awb") / 1000

					if var_355_14 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_14 + var_355_6
					end

					if var_355_9.prefab_name ~= "" and arg_352_1.actors_[var_355_9.prefab_name] ~= nil then
						local var_355_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_9.prefab_name].transform, "story_v_out_324171", "324171085", "story_v_out_324171.awb")

						arg_352_1:RecordAudio("324171085", var_355_15)
						arg_352_1:RecordAudio("324171085", var_355_15)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_324171", "324171085", "story_v_out_324171.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_324171", "324171085", "story_v_out_324171.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_16 = math.max(var_355_7, arg_352_1.talkMaxDuration)

			if var_355_6 <= arg_352_1.time_ and arg_352_1.time_ < var_355_6 + var_355_16 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_6) / var_355_16

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_6 + var_355_16 and arg_352_1.time_ < var_355_6 + var_355_16 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play324171086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 324171086
		arg_356_1.duration_ = 6.6

		local var_356_0 = {
			zh = 5.2,
			ja = 6.6
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play324171087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.45

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[1496].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_3 = arg_356_1:GetWordFromCfg(324171086)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 18
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171086", "story_v_out_324171.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171086", "story_v_out_324171.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_324171", "324171086", "story_v_out_324171.awb")

						arg_356_1:RecordAudio("324171086", var_359_9)
						arg_356_1:RecordAudio("324171086", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_324171", "324171086", "story_v_out_324171.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_324171", "324171086", "story_v_out_324171.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play324171087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 324171087
		arg_360_1.duration_ = 4.67

		local var_360_0 = {
			zh = 4.333,
			ja = 4.666
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play324171088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["1170ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1170ui_story == nil then
				arg_360_1.var_.characterEffect1170ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect1170ui_story and not isNil(var_363_0) then
					arg_360_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1170ui_story then
				arg_360_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_363_4 = 0

			if var_363_4 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action459")
			end

			local var_363_5 = 0

			if var_363_5 < arg_360_1.time_ and arg_360_1.time_ <= var_363_5 + arg_363_0 then
				arg_360_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_363_6 = 0
			local var_363_7 = 0.425

			if var_363_6 < arg_360_1.time_ and arg_360_1.time_ <= var_363_6 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_8 = arg_360_1:FormatText(StoryNameCfg[318].name)

				arg_360_1.leftNameTxt_.text = var_363_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_9 = arg_360_1:GetWordFromCfg(324171087)
				local var_363_10 = arg_360_1:FormatText(var_363_9.content)

				arg_360_1.text_.text = var_363_10

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_11 = 17
				local var_363_12 = utf8.len(var_363_10)
				local var_363_13 = var_363_11 <= 0 and var_363_7 or var_363_7 * (var_363_12 / var_363_11)

				if var_363_13 > 0 and var_363_7 < var_363_13 then
					arg_360_1.talkMaxDuration = var_363_13

					if var_363_13 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_13 + var_363_6
					end
				end

				arg_360_1.text_.text = var_363_10
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171087", "story_v_out_324171.awb") ~= 0 then
					local var_363_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171087", "story_v_out_324171.awb") / 1000

					if var_363_14 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_14 + var_363_6
					end

					if var_363_9.prefab_name ~= "" and arg_360_1.actors_[var_363_9.prefab_name] ~= nil then
						local var_363_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_9.prefab_name].transform, "story_v_out_324171", "324171087", "story_v_out_324171.awb")

						arg_360_1:RecordAudio("324171087", var_363_15)
						arg_360_1:RecordAudio("324171087", var_363_15)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_324171", "324171087", "story_v_out_324171.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_324171", "324171087", "story_v_out_324171.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_16 = math.max(var_363_7, arg_360_1.talkMaxDuration)

			if var_363_6 <= arg_360_1.time_ and arg_360_1.time_ < var_363_6 + var_363_16 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_6) / var_363_16

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_6 + var_363_16 and arg_360_1.time_ < var_363_6 + var_363_16 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play324171088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 324171088
		arg_364_1.duration_ = 4.03

		local var_364_0 = {
			zh = 3.6,
			ja = 4.033
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play324171089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["1170ui_story"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect1170ui_story == nil then
				arg_364_1.var_.characterEffect1170ui_story = var_367_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.200000002980232

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.characterEffect1170ui_story and not isNil(var_367_0) then
					local var_367_4 = Mathf.Lerp(0, 0.5, var_367_3)

					arg_364_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_364_1.var_.characterEffect1170ui_story.fillRatio = var_367_4
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect1170ui_story then
				local var_367_5 = 0.5

				arg_364_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_364_1.var_.characterEffect1170ui_story.fillRatio = var_367_5
			end

			local var_367_6 = 0
			local var_367_7 = 0.4

			if var_367_6 < arg_364_1.time_ and arg_364_1.time_ <= var_367_6 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_8 = arg_364_1:FormatText(StoryNameCfg[1494].name)

				arg_364_1.leftNameTxt_.text = var_367_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_9 = arg_364_1:GetWordFromCfg(324171088)
				local var_367_10 = arg_364_1:FormatText(var_367_9.content)

				arg_364_1.text_.text = var_367_10

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_11 = 16
				local var_367_12 = utf8.len(var_367_10)
				local var_367_13 = var_367_11 <= 0 and var_367_7 or var_367_7 * (var_367_12 / var_367_11)

				if var_367_13 > 0 and var_367_7 < var_367_13 then
					arg_364_1.talkMaxDuration = var_367_13

					if var_367_13 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_13 + var_367_6
					end
				end

				arg_364_1.text_.text = var_367_10
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171088", "story_v_out_324171.awb") ~= 0 then
					local var_367_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171088", "story_v_out_324171.awb") / 1000

					if var_367_14 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_14 + var_367_6
					end

					if var_367_9.prefab_name ~= "" and arg_364_1.actors_[var_367_9.prefab_name] ~= nil then
						local var_367_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_9.prefab_name].transform, "story_v_out_324171", "324171088", "story_v_out_324171.awb")

						arg_364_1:RecordAudio("324171088", var_367_15)
						arg_364_1:RecordAudio("324171088", var_367_15)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_324171", "324171088", "story_v_out_324171.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_324171", "324171088", "story_v_out_324171.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_16 = math.max(var_367_7, arg_364_1.talkMaxDuration)

			if var_367_6 <= arg_364_1.time_ and arg_364_1.time_ < var_367_6 + var_367_16 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_6) / var_367_16

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_6 + var_367_16 and arg_364_1.time_ < var_367_6 + var_367_16 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play324171089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 324171089
		arg_368_1.duration_ = 3.8

		local var_368_0 = {
			zh = 2.966,
			ja = 3.8
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play324171090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1170ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1170ui_story == nil then
				arg_368_1.var_.characterEffect1170ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect1170ui_story and not isNil(var_371_0) then
					arg_368_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1170ui_story then
				arg_368_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_371_4 = 0

			if var_371_4 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action9_2")
			end

			local var_371_5 = 0

			if var_371_5 < arg_368_1.time_ and arg_368_1.time_ <= var_371_5 + arg_371_0 then
				arg_368_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_371_6 = 0
			local var_371_7 = 0.3

			if var_371_6 < arg_368_1.time_ and arg_368_1.time_ <= var_371_6 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_8 = arg_368_1:FormatText(StoryNameCfg[318].name)

				arg_368_1.leftNameTxt_.text = var_371_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_9 = arg_368_1:GetWordFromCfg(324171089)
				local var_371_10 = arg_368_1:FormatText(var_371_9.content)

				arg_368_1.text_.text = var_371_10

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_11 = 12
				local var_371_12 = utf8.len(var_371_10)
				local var_371_13 = var_371_11 <= 0 and var_371_7 or var_371_7 * (var_371_12 / var_371_11)

				if var_371_13 > 0 and var_371_7 < var_371_13 then
					arg_368_1.talkMaxDuration = var_371_13

					if var_371_13 + var_371_6 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_13 + var_371_6
					end
				end

				arg_368_1.text_.text = var_371_10
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171089", "story_v_out_324171.awb") ~= 0 then
					local var_371_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171089", "story_v_out_324171.awb") / 1000

					if var_371_14 + var_371_6 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_14 + var_371_6
					end

					if var_371_9.prefab_name ~= "" and arg_368_1.actors_[var_371_9.prefab_name] ~= nil then
						local var_371_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_9.prefab_name].transform, "story_v_out_324171", "324171089", "story_v_out_324171.awb")

						arg_368_1:RecordAudio("324171089", var_371_15)
						arg_368_1:RecordAudio("324171089", var_371_15)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_324171", "324171089", "story_v_out_324171.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_324171", "324171089", "story_v_out_324171.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_16 = math.max(var_371_7, arg_368_1.talkMaxDuration)

			if var_371_6 <= arg_368_1.time_ and arg_368_1.time_ < var_371_6 + var_371_16 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_6) / var_371_16

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_6 + var_371_16 and arg_368_1.time_ < var_371_6 + var_371_16 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play324171090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 324171090
		arg_372_1.duration_ = 4.03

		local var_372_0 = {
			zh = 4.033,
			ja = 3
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play324171091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1170ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1170ui_story == nil then
				arg_372_1.var_.characterEffect1170ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect1170ui_story and not isNil(var_375_0) then
					local var_375_4 = Mathf.Lerp(0, 0.5, var_375_3)

					arg_372_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1170ui_story.fillRatio = var_375_4
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1170ui_story then
				local var_375_5 = 0.5

				arg_372_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1170ui_story.fillRatio = var_375_5
			end

			local var_375_6 = 0
			local var_375_7 = 0.35

			if var_375_6 < arg_372_1.time_ and arg_372_1.time_ <= var_375_6 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_8 = arg_372_1:FormatText(StoryNameCfg[1494].name)

				arg_372_1.leftNameTxt_.text = var_375_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_9 = arg_372_1:GetWordFromCfg(324171090)
				local var_375_10 = arg_372_1:FormatText(var_375_9.content)

				arg_372_1.text_.text = var_375_10

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_11 = 14
				local var_375_12 = utf8.len(var_375_10)
				local var_375_13 = var_375_11 <= 0 and var_375_7 or var_375_7 * (var_375_12 / var_375_11)

				if var_375_13 > 0 and var_375_7 < var_375_13 then
					arg_372_1.talkMaxDuration = var_375_13

					if var_375_13 + var_375_6 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_13 + var_375_6
					end
				end

				arg_372_1.text_.text = var_375_10
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171090", "story_v_out_324171.awb") ~= 0 then
					local var_375_14 = manager.audio:GetVoiceLength("story_v_out_324171", "324171090", "story_v_out_324171.awb") / 1000

					if var_375_14 + var_375_6 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_14 + var_375_6
					end

					if var_375_9.prefab_name ~= "" and arg_372_1.actors_[var_375_9.prefab_name] ~= nil then
						local var_375_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_9.prefab_name].transform, "story_v_out_324171", "324171090", "story_v_out_324171.awb")

						arg_372_1:RecordAudio("324171090", var_375_15)
						arg_372_1:RecordAudio("324171090", var_375_15)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_324171", "324171090", "story_v_out_324171.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_324171", "324171090", "story_v_out_324171.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_16 = math.max(var_375_7, arg_372_1.talkMaxDuration)

			if var_375_6 <= arg_372_1.time_ and arg_372_1.time_ < var_375_6 + var_375_16 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_6) / var_375_16

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_6 + var_375_16 and arg_372_1.time_ < var_375_6 + var_375_16 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play324171091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 324171091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play324171092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1170ui_story"].transform
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.var_.moveOldPos1170ui_story = var_379_0.localPosition

				local var_379_2 = GameObjectTools.GetOrAddComponent(var_379_0.gameObject, typeof(DynamicBoneHelper))

				if var_379_2 then
					var_379_2:EnableDynamicBone(false)
				end
			end

			local var_379_3 = 0.001

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_3 then
				local var_379_4 = (arg_376_1.time_ - var_379_1) / var_379_3
				local var_379_5 = Vector3.New(0, 100, 0)

				var_379_0.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1170ui_story, var_379_5, var_379_4)

				local var_379_6 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_6.x, var_379_6.y, var_379_6.z)

				local var_379_7 = var_379_0.localEulerAngles

				var_379_7.z = 0
				var_379_7.x = 0
				var_379_0.localEulerAngles = var_379_7
			end

			if arg_376_1.time_ >= var_379_1 + var_379_3 and arg_376_1.time_ < var_379_1 + var_379_3 + arg_379_0 then
				var_379_0.localPosition = Vector3.New(0, 100, 0)

				local var_379_8 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_8.x, var_379_8.y, var_379_8.z)

				local var_379_9 = var_379_0.localEulerAngles

				var_379_9.z = 0
				var_379_9.x = 0
				var_379_0.localEulerAngles = var_379_9

				local var_379_10 = GameObjectTools.GetOrAddComponent(var_379_0.gameObject, typeof(DynamicBoneHelper))

				if var_379_10 then
					var_379_10:EnableDynamicBone(true)
				end
			end

			local var_379_11 = 0
			local var_379_12 = 0.8

			if var_379_11 < arg_376_1.time_ and arg_376_1.time_ <= var_379_11 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_13 = arg_376_1:GetWordFromCfg(324171091)
				local var_379_14 = arg_376_1:FormatText(var_379_13.content)

				arg_376_1.text_.text = var_379_14

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_15 = 32
				local var_379_16 = utf8.len(var_379_14)
				local var_379_17 = var_379_15 <= 0 and var_379_12 or var_379_12 * (var_379_16 / var_379_15)

				if var_379_17 > 0 and var_379_12 < var_379_17 then
					arg_376_1.talkMaxDuration = var_379_17

					if var_379_17 + var_379_11 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_17 + var_379_11
					end
				end

				arg_376_1.text_.text = var_379_14
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_18 = math.max(var_379_12, arg_376_1.talkMaxDuration)

			if var_379_11 <= arg_376_1.time_ and arg_376_1.time_ < var_379_11 + var_379_18 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_11) / var_379_18

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_11 + var_379_18 and arg_376_1.time_ < var_379_11 + var_379_18 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play324171092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 324171092
		arg_380_1.duration_ = 4.63

		local var_380_0 = {
			zh = 3.4,
			ja = 4.633
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play324171093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.425

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_2 = arg_380_1:FormatText(StoryNameCfg[1494].name)

				arg_380_1.leftNameTxt_.text = var_383_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:GetWordFromCfg(324171092)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 17
				local var_383_6 = utf8.len(var_383_4)
				local var_383_7 = var_383_5 <= 0 and var_383_1 or var_383_1 * (var_383_6 / var_383_5)

				if var_383_7 > 0 and var_383_1 < var_383_7 then
					arg_380_1.talkMaxDuration = var_383_7

					if var_383_7 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171092", "story_v_out_324171.awb") ~= 0 then
					local var_383_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171092", "story_v_out_324171.awb") / 1000

					if var_383_8 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_0
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_out_324171", "324171092", "story_v_out_324171.awb")

						arg_380_1:RecordAudio("324171092", var_383_9)
						arg_380_1:RecordAudio("324171092", var_383_9)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_324171", "324171092", "story_v_out_324171.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_324171", "324171092", "story_v_out_324171.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_10 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_10 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_10

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_10 and arg_380_1.time_ < var_383_0 + var_383_10 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play324171093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 324171093
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play324171094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.2
			local var_387_1 = 1

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				local var_387_2 = "play"
				local var_387_3 = "effect"

				arg_384_1:AudioAction(var_387_2, var_387_3, "se_story_150", "se_story_150_bamboo02", "")
			end

			local var_387_4 = 0
			local var_387_5 = 1.2

			if var_387_4 < arg_384_1.time_ and arg_384_1.time_ <= var_387_4 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_6 = arg_384_1:GetWordFromCfg(324171093)
				local var_387_7 = arg_384_1:FormatText(var_387_6.content)

				arg_384_1.text_.text = var_387_7

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_8 = 48
				local var_387_9 = utf8.len(var_387_7)
				local var_387_10 = var_387_8 <= 0 and var_387_5 or var_387_5 * (var_387_9 / var_387_8)

				if var_387_10 > 0 and var_387_5 < var_387_10 then
					arg_384_1.talkMaxDuration = var_387_10

					if var_387_10 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_10 + var_387_4
					end
				end

				arg_384_1.text_.text = var_387_7
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_11 = math.max(var_387_5, arg_384_1.talkMaxDuration)

			if var_387_4 <= arg_384_1.time_ and arg_384_1.time_ < var_387_4 + var_387_11 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_4) / var_387_11

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_4 + var_387_11 and arg_384_1.time_ < var_387_4 + var_387_11 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play324171094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 324171094
		arg_388_1.duration_ = 2.27

		local var_388_0 = {
			zh = 2.266,
			ja = 1.466
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play324171095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0
			local var_391_1 = 0.125

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_2 = arg_388_1:FormatText(StoryNameCfg[1498].name)

				arg_388_1.leftNameTxt_.text = var_391_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_3 = arg_388_1:GetWordFromCfg(324171094)
				local var_391_4 = arg_388_1:FormatText(var_391_3.content)

				arg_388_1.text_.text = var_391_4

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_5 = 5
				local var_391_6 = utf8.len(var_391_4)
				local var_391_7 = var_391_5 <= 0 and var_391_1 or var_391_1 * (var_391_6 / var_391_5)

				if var_391_7 > 0 and var_391_1 < var_391_7 then
					arg_388_1.talkMaxDuration = var_391_7

					if var_391_7 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_7 + var_391_0
					end
				end

				arg_388_1.text_.text = var_391_4
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171094", "story_v_out_324171.awb") ~= 0 then
					local var_391_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171094", "story_v_out_324171.awb") / 1000

					if var_391_8 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_8 + var_391_0
					end

					if var_391_3.prefab_name ~= "" and arg_388_1.actors_[var_391_3.prefab_name] ~= nil then
						local var_391_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_3.prefab_name].transform, "story_v_out_324171", "324171094", "story_v_out_324171.awb")

						arg_388_1:RecordAudio("324171094", var_391_9)
						arg_388_1:RecordAudio("324171094", var_391_9)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_324171", "324171094", "story_v_out_324171.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_324171", "324171094", "story_v_out_324171.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_10 = math.max(var_391_1, arg_388_1.talkMaxDuration)

			if var_391_0 <= arg_388_1.time_ and arg_388_1.time_ < var_391_0 + var_391_10 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_0) / var_391_10

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_0 + var_391_10 and arg_388_1.time_ < var_391_0 + var_391_10 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play324171095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 324171095
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play324171096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 1.025

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, false)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_2 = arg_392_1:GetWordFromCfg(324171095)
				local var_395_3 = arg_392_1:FormatText(var_395_2.content)

				arg_392_1.text_.text = var_395_3

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_4 = 41
				local var_395_5 = utf8.len(var_395_3)
				local var_395_6 = var_395_4 <= 0 and var_395_1 or var_395_1 * (var_395_5 / var_395_4)

				if var_395_6 > 0 and var_395_1 < var_395_6 then
					arg_392_1.talkMaxDuration = var_395_6

					if var_395_6 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_6 + var_395_0
					end
				end

				arg_392_1.text_.text = var_395_3
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_7 = math.max(var_395_1, arg_392_1.talkMaxDuration)

			if var_395_0 <= arg_392_1.time_ and arg_392_1.time_ < var_395_0 + var_395_7 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_0) / var_395_7

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_0 + var_395_7 and arg_392_1.time_ < var_395_0 + var_395_7 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play324171096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 324171096
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play324171097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0
			local var_399_1 = 0.9

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_2 = arg_396_1:GetWordFromCfg(324171096)
				local var_399_3 = arg_396_1:FormatText(var_399_2.content)

				arg_396_1.text_.text = var_399_3

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_4 = 36
				local var_399_5 = utf8.len(var_399_3)
				local var_399_6 = var_399_4 <= 0 and var_399_1 or var_399_1 * (var_399_5 / var_399_4)

				if var_399_6 > 0 and var_399_1 < var_399_6 then
					arg_396_1.talkMaxDuration = var_399_6

					if var_399_6 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_6 + var_399_0
					end
				end

				arg_396_1.text_.text = var_399_3
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_7 = math.max(var_399_1, arg_396_1.talkMaxDuration)

			if var_399_0 <= arg_396_1.time_ and arg_396_1.time_ < var_399_0 + var_399_7 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_0) / var_399_7

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_0 + var_399_7 and arg_396_1.time_ < var_399_0 + var_399_7 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play324171097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 324171097
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play324171098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0.6
			local var_403_1 = 1

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				local var_403_2 = "play"
				local var_403_3 = "effect"

				arg_400_1:AudioAction(var_403_2, var_403_3, "se_story_150", "se_story_150_bamboo01", "")
			end

			local var_403_4 = 0
			local var_403_5 = 1.775

			if var_403_4 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_6 = arg_400_1:GetWordFromCfg(324171097)
				local var_403_7 = arg_400_1:FormatText(var_403_6.content)

				arg_400_1.text_.text = var_403_7

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_8 = 71
				local var_403_9 = utf8.len(var_403_7)
				local var_403_10 = var_403_8 <= 0 and var_403_5 or var_403_5 * (var_403_9 / var_403_8)

				if var_403_10 > 0 and var_403_5 < var_403_10 then
					arg_400_1.talkMaxDuration = var_403_10

					if var_403_10 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_10 + var_403_4
					end
				end

				arg_400_1.text_.text = var_403_7
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_11 = math.max(var_403_5, arg_400_1.talkMaxDuration)

			if var_403_4 <= arg_400_1.time_ and arg_400_1.time_ < var_403_4 + var_403_11 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_4) / var_403_11

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_4 + var_403_11 and arg_400_1.time_ < var_403_4 + var_403_11 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play324171098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 324171098
		arg_404_1.duration_ = 2.13

		local var_404_0 = {
			zh = 2.066,
			ja = 2.133
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
			arg_404_1.auto_ = false
		end

		function arg_404_1.playNext_(arg_406_0)
			arg_404_1.onStoryFinished_()
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 0.125

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_2 = arg_404_1:FormatText(StoryNameCfg[1498].name)

				arg_404_1.leftNameTxt_.text = var_407_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_3 = arg_404_1:GetWordFromCfg(324171098)
				local var_407_4 = arg_404_1:FormatText(var_407_3.content)

				arg_404_1.text_.text = var_407_4

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_5 = 5
				local var_407_6 = utf8.len(var_407_4)
				local var_407_7 = var_407_5 <= 0 and var_407_1 or var_407_1 * (var_407_6 / var_407_5)

				if var_407_7 > 0 and var_407_1 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_4
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324171", "324171098", "story_v_out_324171.awb") ~= 0 then
					local var_407_8 = manager.audio:GetVoiceLength("story_v_out_324171", "324171098", "story_v_out_324171.awb") / 1000

					if var_407_8 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_8 + var_407_0
					end

					if var_407_3.prefab_name ~= "" and arg_404_1.actors_[var_407_3.prefab_name] ~= nil then
						local var_407_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_3.prefab_name].transform, "story_v_out_324171", "324171098", "story_v_out_324171.awb")

						arg_404_1:RecordAudio("324171098", var_407_9)
						arg_404_1:RecordAudio("324171098", var_407_9)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_324171", "324171098", "story_v_out_324171.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_324171", "324171098", "story_v_out_324171.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_10 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_10 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_10

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_10 and arg_404_1.time_ < var_407_0 + var_407_10 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J15",
		"TextureConfig/Background/J13g",
		"TextureConfig/Background/ST2009"
	},
	voices = {
		"story_v_out_324171.awb"
	}
}
