return {
	Play114182001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114182001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114182002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F06"

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
				local var_4_5 = arg_1_1.bgs_.F06

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
					if iter_4_0 ~= "F06" then
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

			local var_4_22 = manager.ui.mainCamera.transform
			local var_4_23 = 1

			if var_4_23 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_22.localPosition
			end

			local var_4_24 = 1.5

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_23) / 0.066
				local var_4_26, var_4_27 = math.modf(var_4_25)

				var_4_22.localPosition = Vector3.New(var_4_27 * 0.13, var_4_27 * 0.13, var_4_27 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				var_4_22.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_28 = 2

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_29 = 0.5

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_30 = 0
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 2
			local var_4_37 = 1.76666666666667

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "music"

				arg_1_1:AudioAction(var_4_38, var_4_39, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_40 = ""
				local var_4_41 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if var_4_41 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_41 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_41

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_41
						arg_1_1.bgmTxt2_.text = var_4_41
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

			local var_4_42 = 2
			local var_4_43 = 1.35

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_44 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_44:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_45 = arg_1_1:GetWordFromCfg(114182001)
				local var_4_46 = arg_1_1:FormatText(var_4_45.content)

				arg_1_1.text_.text = var_4_46

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_47 = 54
				local var_4_48 = utf8.len(var_4_46)
				local var_4_49 = var_4_47 <= 0 and var_4_43 or var_4_43 * (var_4_48 / var_4_47)

				if var_4_49 > 0 and var_4_43 < var_4_49 then
					arg_1_1.talkMaxDuration = var_4_49
					var_4_42 = var_4_42 + 0.3

					if var_4_49 + var_4_42 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_49 + var_4_42
					end
				end

				arg_1_1.text_.text = var_4_46
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_50 = var_4_42 + 0.3
			local var_4_51 = math.max(var_4_43, arg_1_1.talkMaxDuration)

			if var_4_50 <= arg_1_1.time_ and arg_1_1.time_ < var_4_50 + var_4_51 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_50) / var_4_51

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_50 + var_4_51 and arg_1_1.time_ < var_4_50 + var_4_51 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play114182002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114182002
		arg_9_1.duration_ = 7.8

		local var_9_0 = {
			ja = 5.633,
			ko = 6.566,
			zh = 5.733,
			en = 7.8
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
				arg_9_0:Play114182003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1184ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1184ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1184ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -0.97, -6)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1184ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = 0

			if var_12_14 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_12_16 = arg_9_1.actors_["1184ui_story"]
			local var_12_17 = 0

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1184ui_story == nil then
				arg_9_1.var_.characterEffect1184ui_story = var_12_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_18 = 0.2

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_18 and not isNil(var_12_16) then
				local var_12_19 = (arg_9_1.time_ - var_12_17) / var_12_18

				if arg_9_1.var_.characterEffect1184ui_story and not isNil(var_12_16) then
					arg_9_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_17 + var_12_18 and arg_9_1.time_ < var_12_17 + var_12_18 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1184ui_story then
				arg_9_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_12_20 = 0
			local var_12_21 = 0.575

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[6].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(114182002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182002", "story_v_out_114182.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_114182", "114182002", "story_v_out_114182.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_114182", "114182002", "story_v_out_114182.awb")

						arg_9_1:RecordAudio("114182002", var_12_29)
						arg_9_1:RecordAudio("114182002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114182", "114182002", "story_v_out_114182.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114182", "114182002", "story_v_out_114182.awb")
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
				actorName = "1184ui_story",
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
	Play114182003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114182003
		arg_13_1.duration_ = 5.1

		local var_13_0 = {
			ja = 5.1,
			ko = 3.5,
			zh = 2.033,
			en = 2.633
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
				arg_13_0:Play114182004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1184ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1184ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1184ui_story, var_16_4, var_16_3)

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

			local var_16_9 = 0
			local var_16_10 = 0.2

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_11 = arg_13_1:FormatText(StoryNameCfg[208].name)

				arg_13_1.leftNameTxt_.text = var_16_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_12 = arg_13_1:GetWordFromCfg(114182003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_14 = 8
				local var_16_15 = utf8.len(var_16_13)
				local var_16_16 = var_16_14 <= 0 and var_16_10 or var_16_10 * (var_16_15 / var_16_14)

				if var_16_16 > 0 and var_16_10 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16

					if var_16_16 + var_16_9 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_9
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182003", "story_v_out_114182.awb") ~= 0 then
					local var_16_17 = manager.audio:GetVoiceLength("story_v_out_114182", "114182003", "story_v_out_114182.awb") / 1000

					if var_16_17 + var_16_9 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_9
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_114182", "114182003", "story_v_out_114182.awb")

						arg_13_1:RecordAudio("114182003", var_16_18)
						arg_13_1:RecordAudio("114182003", var_16_18)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114182", "114182003", "story_v_out_114182.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114182", "114182003", "story_v_out_114182.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_19 = math.max(var_16_10, arg_13_1.talkMaxDuration)

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_19 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_9) / var_16_19

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_9 + var_16_19 and arg_13_1.time_ < var_16_9 + var_16_19 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play114182004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114182004
		arg_17_1.duration_ = 2.67

		local var_17_0 = {
			ja = 2.066,
			ko = 2.666,
			zh = 2.3,
			en = 2.5
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
				arg_17_0:Play114182005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1184ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1184ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -0.97, -6)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1184ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4134")
			end

			local var_20_11 = arg_17_1.actors_["1184ui_story"]
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.characterEffect1184ui_story == nil then
				arg_17_1.var_.characterEffect1184ui_story = var_20_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_13 = 0.2

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_13 and not isNil(var_20_11) then
				local var_20_14 = (arg_17_1.time_ - var_20_12) / var_20_13

				if arg_17_1.var_.characterEffect1184ui_story and not isNil(var_20_11) then
					arg_17_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_12 + var_20_13 and arg_17_1.time_ < var_20_12 + var_20_13 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.characterEffect1184ui_story then
				arg_17_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_20_15 = 0
			local var_20_16 = 0.2

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(114182004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 8
				local var_20_21 = utf8.len(var_20_19)
				local var_20_22 = var_20_20 <= 0 and var_20_16 or var_20_16 * (var_20_21 / var_20_20)

				if var_20_22 > 0 and var_20_16 < var_20_22 then
					arg_17_1.talkMaxDuration = var_20_22

					if var_20_22 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_19
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182004", "story_v_out_114182.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_out_114182", "114182004", "story_v_out_114182.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_114182", "114182004", "story_v_out_114182.awb")

						arg_17_1:RecordAudio("114182004", var_20_24)
						arg_17_1:RecordAudio("114182004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114182", "114182004", "story_v_out_114182.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114182", "114182004", "story_v_out_114182.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_25 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_25 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_25

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_25 and arg_17_1.time_ < var_20_15 + var_20_25 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play114182005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114182005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play114182006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1184ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1184ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1184ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, 100, 0)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = 0
			local var_24_10 = 1.15

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_11 = arg_21_1:GetWordFromCfg(114182005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 46
				local var_24_14 = utf8.len(var_24_12)
				local var_24_15 = var_24_13 <= 0 and var_24_10 or var_24_10 * (var_24_14 / var_24_13)

				if var_24_15 > 0 and var_24_10 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_9 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_9
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_10, arg_21_1.talkMaxDuration)

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_9) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_9 + var_24_16 and arg_21_1.time_ < var_24_9 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play114182006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114182006
		arg_25_1.duration_ = 6.93

		local var_25_0 = {
			ja = 6.033,
			ko = 6.933,
			zh = 4,
			en = 5.466
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
				arg_25_0:Play114182007(arg_25_1)
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
				local var_28_9 = Vector3.New(-0.7, -1.11, -5.9)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1038ui_story, var_28_9, var_28_8)

				local var_28_10 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_10.x, var_28_10.y, var_28_10.z)

				local var_28_11 = var_28_5.localEulerAngles

				var_28_11.z = 0
				var_28_11.x = 0
				var_28_5.localEulerAngles = var_28_11
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(-0.7, -1.11, -5.9)

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
				arg_25_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
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
			local var_28_21 = 0.5

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

				local var_28_23 = arg_25_1:GetWordFromCfg(114182006)
				local var_28_24 = arg_25_1:FormatText(var_28_23.content)

				arg_25_1.text_.text = var_28_24

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_25 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182006", "story_v_out_114182.awb") ~= 0 then
					local var_28_28 = manager.audio:GetVoiceLength("story_v_out_114182", "114182006", "story_v_out_114182.awb") / 1000

					if var_28_28 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_20
					end

					if var_28_23.prefab_name ~= "" and arg_25_1.actors_[var_28_23.prefab_name] ~= nil then
						local var_28_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_23.prefab_name].transform, "story_v_out_114182", "114182006", "story_v_out_114182.awb")

						arg_25_1:RecordAudio("114182006", var_28_29)
						arg_25_1:RecordAudio("114182006", var_28_29)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114182", "114182006", "story_v_out_114182.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114182", "114182006", "story_v_out_114182.awb")
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
	Play114182007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114182007
		arg_29_1.duration_ = 4.27

		local var_29_0 = {
			ja = 4.266,
			ko = 3,
			zh = 3.5,
			en = 2.333
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
				arg_29_0:Play114182008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1038ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1038ui_story == nil then
				arg_29_1.var_.characterEffect1038ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1038ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1038ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1038ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1038ui_story.fillRatio = var_32_5
			end

			local var_32_6 = "1041ui_story"

			if arg_29_1.actors_[var_32_6] == nil then
				local var_32_7 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_32_7) then
					local var_32_8 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_29_1.stage_.transform)

					var_32_8.name = var_32_6
					var_32_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_6] = var_32_8

					local var_32_9 = var_32_8:GetComponentInChildren(typeof(CharacterEffect))

					var_32_9.enabled = true

					local var_32_10 = GameObjectTools.GetOrAddComponent(var_32_8, typeof(DynamicBoneHelper))

					if var_32_10 then
						var_32_10:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_9.transform, false)

					arg_29_1.var_[var_32_6 .. "Animator"] = var_32_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_6 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_6 .. "LipSync"] = var_32_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_11 = arg_29_1.actors_["1041ui_story"].transform
			local var_32_12 = 0

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.var_.moveOldPos1041ui_story = var_32_11.localPosition
			end

			local var_32_13 = 0.001

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_13 then
				local var_32_14 = (arg_29_1.time_ - var_32_12) / var_32_13
				local var_32_15 = Vector3.New(0.7, -1.11, -5.9)

				var_32_11.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1041ui_story, var_32_15, var_32_14)

				local var_32_16 = manager.ui.mainCamera.transform.position - var_32_11.position

				var_32_11.forward = Vector3.New(var_32_16.x, var_32_16.y, var_32_16.z)

				local var_32_17 = var_32_11.localEulerAngles

				var_32_17.z = 0
				var_32_17.x = 0
				var_32_11.localEulerAngles = var_32_17
			end

			if arg_29_1.time_ >= var_32_12 + var_32_13 and arg_29_1.time_ < var_32_12 + var_32_13 + arg_32_0 then
				var_32_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_32_18 = manager.ui.mainCamera.transform.position - var_32_11.position

				var_32_11.forward = Vector3.New(var_32_18.x, var_32_18.y, var_32_18.z)

				local var_32_19 = var_32_11.localEulerAngles

				var_32_19.z = 0
				var_32_19.x = 0
				var_32_11.localEulerAngles = var_32_19
			end

			local var_32_20 = 0

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action9_2")
			end

			local var_32_21 = arg_29_1.actors_["1041ui_story"]
			local var_32_22 = 0

			if var_32_22 < arg_29_1.time_ and arg_29_1.time_ <= var_32_22 + arg_32_0 and not isNil(var_32_21) and arg_29_1.var_.characterEffect1041ui_story == nil then
				arg_29_1.var_.characterEffect1041ui_story = var_32_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_23 = 0.2

			if var_32_22 <= arg_29_1.time_ and arg_29_1.time_ < var_32_22 + var_32_23 and not isNil(var_32_21) then
				local var_32_24 = (arg_29_1.time_ - var_32_22) / var_32_23

				if arg_29_1.var_.characterEffect1041ui_story and not isNil(var_32_21) then
					arg_29_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_22 + var_32_23 and arg_29_1.time_ < var_32_22 + var_32_23 + arg_32_0 and not isNil(var_32_21) and arg_29_1.var_.characterEffect1041ui_story then
				arg_29_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_32_25 = 0

			if var_32_25 < arg_29_1.time_ and arg_29_1.time_ <= var_32_25 + arg_32_0 then
				arg_29_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_32_26 = 0
			local var_32_27 = 0.2

			if var_32_26 < arg_29_1.time_ and arg_29_1.time_ <= var_32_26 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_28 = arg_29_1:FormatText(StoryNameCfg[208].name)

				arg_29_1.leftNameTxt_.text = var_32_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_29 = arg_29_1:GetWordFromCfg(114182007)
				local var_32_30 = arg_29_1:FormatText(var_32_29.content)

				arg_29_1.text_.text = var_32_30

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_31 = 8
				local var_32_32 = utf8.len(var_32_30)
				local var_32_33 = var_32_31 <= 0 and var_32_27 or var_32_27 * (var_32_32 / var_32_31)

				if var_32_33 > 0 and var_32_27 < var_32_33 then
					arg_29_1.talkMaxDuration = var_32_33

					if var_32_33 + var_32_26 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_33 + var_32_26
					end
				end

				arg_29_1.text_.text = var_32_30
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182007", "story_v_out_114182.awb") ~= 0 then
					local var_32_34 = manager.audio:GetVoiceLength("story_v_out_114182", "114182007", "story_v_out_114182.awb") / 1000

					if var_32_34 + var_32_26 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_34 + var_32_26
					end

					if var_32_29.prefab_name ~= "" and arg_29_1.actors_[var_32_29.prefab_name] ~= nil then
						local var_32_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_29.prefab_name].transform, "story_v_out_114182", "114182007", "story_v_out_114182.awb")

						arg_29_1:RecordAudio("114182007", var_32_35)
						arg_29_1:RecordAudio("114182007", var_32_35)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114182", "114182007", "story_v_out_114182.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114182", "114182007", "story_v_out_114182.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_36 = math.max(var_32_27, arg_29_1.talkMaxDuration)

			if var_32_26 <= arg_29_1.time_ and arg_29_1.time_ < var_32_26 + var_32_36 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_26) / var_32_36

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_26 + var_32_36 and arg_29_1.time_ < var_32_26 + var_32_36 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play114182008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114182008
		arg_33_1.duration_ = 4.1

		local var_33_0 = {
			ja = 3.4,
			ko = 2.266,
			zh = 3.6,
			en = 4.1
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
				arg_33_0:Play114182009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1038ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1038ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1038ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, 100, 0)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1041ui_story"].transform
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.var_.moveOldPos1041ui_story = var_36_9.localPosition
			end

			local var_36_11 = 0.001

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11
				local var_36_13 = Vector3.New(0, 100, 0)

				var_36_9.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1041ui_story, var_36_13, var_36_12)

				local var_36_14 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_14.x, var_36_14.y, var_36_14.z)

				local var_36_15 = var_36_9.localEulerAngles

				var_36_15.z = 0
				var_36_15.x = 0
				var_36_9.localEulerAngles = var_36_15
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 then
				var_36_9.localPosition = Vector3.New(0, 100, 0)

				local var_36_16 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_16.x, var_36_16.y, var_36_16.z)

				local var_36_17 = var_36_9.localEulerAngles

				var_36_17.z = 0
				var_36_17.x = 0
				var_36_9.localEulerAngles = var_36_17
			end

			local var_36_18 = 0
			local var_36_19 = 0.2

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_20 = arg_33_1:FormatText(StoryNameCfg[216].name)

				arg_33_1.leftNameTxt_.text = var_36_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_21 = arg_33_1:GetWordFromCfg(114182008)
				local var_36_22 = arg_33_1:FormatText(var_36_21.content)

				arg_33_1.text_.text = var_36_22

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_23 = 8
				local var_36_24 = utf8.len(var_36_22)
				local var_36_25 = var_36_23 <= 0 and var_36_19 or var_36_19 * (var_36_24 / var_36_23)

				if var_36_25 > 0 and var_36_19 < var_36_25 then
					arg_33_1.talkMaxDuration = var_36_25

					if var_36_25 + var_36_18 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_25 + var_36_18
					end
				end

				arg_33_1.text_.text = var_36_22
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182008", "story_v_out_114182.awb") ~= 0 then
					local var_36_26 = manager.audio:GetVoiceLength("story_v_out_114182", "114182008", "story_v_out_114182.awb") / 1000

					if var_36_26 + var_36_18 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_26 + var_36_18
					end

					if var_36_21.prefab_name ~= "" and arg_33_1.actors_[var_36_21.prefab_name] ~= nil then
						local var_36_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_21.prefab_name].transform, "story_v_out_114182", "114182008", "story_v_out_114182.awb")

						arg_33_1:RecordAudio("114182008", var_36_27)
						arg_33_1:RecordAudio("114182008", var_36_27)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114182", "114182008", "story_v_out_114182.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114182", "114182008", "story_v_out_114182.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_28 = math.max(var_36_19, arg_33_1.talkMaxDuration)

			if var_36_18 <= arg_33_1.time_ and arg_33_1.time_ < var_36_18 + var_36_28 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_18) / var_36_28

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_18 + var_36_28 and arg_33_1.time_ < var_36_18 + var_36_28 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play114182009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114182009
		arg_37_1.duration_ = 6.5

		local var_37_0 = {
			ja = 3.533,
			ko = 5.8,
			zh = 6.5,
			en = 5.933
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
				arg_37_0:Play114182010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.45

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[216].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(114182009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182009", "story_v_out_114182.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_114182", "114182009", "story_v_out_114182.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_114182", "114182009", "story_v_out_114182.awb")

						arg_37_1:RecordAudio("114182009", var_40_9)
						arg_37_1:RecordAudio("114182009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114182", "114182009", "story_v_out_114182.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114182", "114182009", "story_v_out_114182.awb")
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
	Play114182010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114182010
		arg_41_1.duration_ = 9.97

		local var_41_0 = {
			ja = 9.966,
			ko = 5.3,
			zh = 8.533,
			en = 9.7
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
				arg_41_0:Play114182011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.625

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[212].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(114182010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182010", "story_v_out_114182.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_114182", "114182010", "story_v_out_114182.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_114182", "114182010", "story_v_out_114182.awb")

						arg_41_1:RecordAudio("114182010", var_44_9)
						arg_41_1:RecordAudio("114182010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114182", "114182010", "story_v_out_114182.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114182", "114182010", "story_v_out_114182.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114182011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114182011
		arg_45_1.duration_ = 7.67

		local var_45_0 = {
			ja = 4.366,
			ko = 6.833,
			zh = 7.533,
			en = 7.666
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
				arg_45_0:Play114182012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.5

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[216].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(114182011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182011", "story_v_out_114182.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_114182", "114182011", "story_v_out_114182.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_114182", "114182011", "story_v_out_114182.awb")

						arg_45_1:RecordAudio("114182011", var_48_9)
						arg_45_1:RecordAudio("114182011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_114182", "114182011", "story_v_out_114182.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_114182", "114182011", "story_v_out_114182.awb")
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
	Play114182012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114182012
		arg_49_1.duration_ = 9.37

		local var_49_0 = {
			ja = 5.566,
			ko = 6.5,
			zh = 9.366,
			en = 9.266
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
				arg_49_0:Play114182013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.45

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[212].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(114182012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 18
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182012", "story_v_out_114182.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_114182", "114182012", "story_v_out_114182.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_114182", "114182012", "story_v_out_114182.awb")

						arg_49_1:RecordAudio("114182012", var_52_9)
						arg_49_1:RecordAudio("114182012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114182", "114182012", "story_v_out_114182.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114182", "114182012", "story_v_out_114182.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114182013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114182013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play114182014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.825

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(114182013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 33
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114182014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114182014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114182015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.9

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

				local var_60_2 = arg_57_1:GetWordFromCfg(114182014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 76
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
	Play114182015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114182015
		arg_61_1.duration_ = 3.17

		local var_61_0 = {
			ja = 3.166,
			ko = 1.999999999999,
			zh = 2.7,
			en = 2.133
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
				arg_61_0:Play114182016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1041ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1041ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(-0.7, -1.11, -5.9)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1041ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_64_10 = arg_61_1.actors_["1041ui_story"]
			local var_64_11 = 0

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 and not isNil(var_64_10) and arg_61_1.var_.characterEffect1041ui_story == nil then
				arg_61_1.var_.characterEffect1041ui_story = var_64_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_12 = 0.2

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_12 and not isNil(var_64_10) then
				local var_64_13 = (arg_61_1.time_ - var_64_11) / var_64_12

				if arg_61_1.var_.characterEffect1041ui_story and not isNil(var_64_10) then
					arg_61_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_11 + var_64_12 and arg_61_1.time_ < var_64_11 + var_64_12 + arg_64_0 and not isNil(var_64_10) and arg_61_1.var_.characterEffect1041ui_story then
				arg_61_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_64_15 = 0
			local var_64_16 = 0.1

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[208].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(114182015)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182015", "story_v_out_114182.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_out_114182", "114182015", "story_v_out_114182.awb") / 1000

					if var_64_23 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_15
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_out_114182", "114182015", "story_v_out_114182.awb")

						arg_61_1:RecordAudio("114182015", var_64_24)
						arg_61_1:RecordAudio("114182015", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114182", "114182015", "story_v_out_114182.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114182", "114182015", "story_v_out_114182.awb")
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
				actorName = "1041ui_story",
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
	Play114182016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114182016
		arg_65_1.duration_ = 11.6

		local var_65_0 = {
			ja = 8.6,
			ko = 9.066,
			zh = 9.066,
			en = 11.6
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
				arg_65_0:Play114182017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1041ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1041ui_story == nil then
				arg_65_1.var_.characterEffect1041ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1041ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1041ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1041ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1041ui_story.fillRatio = var_68_5
			end

			local var_68_6 = "10006ui_story"

			if arg_65_1.actors_[var_68_6] == nil then
				local var_68_7 = Asset.Load("Char/" .. "10006ui_story")

				if not isNil(var_68_7) then
					local var_68_8 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_65_1.stage_.transform)

					var_68_8.name = var_68_6
					var_68_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_65_1.actors_[var_68_6] = var_68_8

					local var_68_9 = var_68_8:GetComponentInChildren(typeof(CharacterEffect))

					var_68_9.enabled = true

					local var_68_10 = GameObjectTools.GetOrAddComponent(var_68_8, typeof(DynamicBoneHelper))

					if var_68_10 then
						var_68_10:EnableDynamicBone(false)
					end

					arg_65_1:ShowWeapon(var_68_9.transform, false)

					arg_65_1.var_[var_68_6 .. "Animator"] = var_68_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_65_1.var_[var_68_6 .. "Animator"].applyRootMotion = true
					arg_65_1.var_[var_68_6 .. "LipSync"] = var_68_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_68_11 = arg_65_1.actors_["10006ui_story"].transform
			local var_68_12 = 0

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.var_.moveOldPos10006ui_story = var_68_11.localPosition
			end

			local var_68_13 = 0.001

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 then
				local var_68_14 = (arg_65_1.time_ - var_68_12) / var_68_13
				local var_68_15 = Vector3.New(0.7, -0.98, -5.65)

				var_68_11.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10006ui_story, var_68_15, var_68_14)

				local var_68_16 = manager.ui.mainCamera.transform.position - var_68_11.position

				var_68_11.forward = Vector3.New(var_68_16.x, var_68_16.y, var_68_16.z)

				local var_68_17 = var_68_11.localEulerAngles

				var_68_17.z = 0
				var_68_17.x = 0
				var_68_11.localEulerAngles = var_68_17
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 then
				var_68_11.localPosition = Vector3.New(0.7, -0.98, -5.65)

				local var_68_18 = manager.ui.mainCamera.transform.position - var_68_11.position

				var_68_11.forward = Vector3.New(var_68_18.x, var_68_18.y, var_68_18.z)

				local var_68_19 = var_68_11.localEulerAngles

				var_68_19.z = 0
				var_68_19.x = 0
				var_68_11.localEulerAngles = var_68_19
			end

			local var_68_20 = 0

			if var_68_20 < arg_65_1.time_ and arg_65_1.time_ <= var_68_20 + arg_68_0 then
				arg_65_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			local var_68_21 = 0

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_68_22 = arg_65_1.actors_["10006ui_story"]
			local var_68_23 = 0

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 and not isNil(var_68_22) and arg_65_1.var_.characterEffect10006ui_story == nil then
				arg_65_1.var_.characterEffect10006ui_story = var_68_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_24 = 0.2

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_24 and not isNil(var_68_22) then
				local var_68_25 = (arg_65_1.time_ - var_68_23) / var_68_24

				if arg_65_1.var_.characterEffect10006ui_story and not isNil(var_68_22) then
					arg_65_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_23 + var_68_24 and arg_65_1.time_ < var_68_23 + var_68_24 + arg_68_0 and not isNil(var_68_22) and arg_65_1.var_.characterEffect10006ui_story then
				arg_65_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_68_26 = 0
			local var_68_27 = 0.75

			if var_68_26 < arg_65_1.time_ and arg_65_1.time_ <= var_68_26 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_28 = arg_65_1:FormatText(StoryNameCfg[212].name)

				arg_65_1.leftNameTxt_.text = var_68_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_29 = arg_65_1:GetWordFromCfg(114182016)
				local var_68_30 = arg_65_1:FormatText(var_68_29.content)

				arg_65_1.text_.text = var_68_30

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_31 = 30
				local var_68_32 = utf8.len(var_68_30)
				local var_68_33 = var_68_31 <= 0 and var_68_27 or var_68_27 * (var_68_32 / var_68_31)

				if var_68_33 > 0 and var_68_27 < var_68_33 then
					arg_65_1.talkMaxDuration = var_68_33

					if var_68_33 + var_68_26 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_33 + var_68_26
					end
				end

				arg_65_1.text_.text = var_68_30
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182016", "story_v_out_114182.awb") ~= 0 then
					local var_68_34 = manager.audio:GetVoiceLength("story_v_out_114182", "114182016", "story_v_out_114182.awb") / 1000

					if var_68_34 + var_68_26 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_34 + var_68_26
					end

					if var_68_29.prefab_name ~= "" and arg_65_1.actors_[var_68_29.prefab_name] ~= nil then
						local var_68_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_29.prefab_name].transform, "story_v_out_114182", "114182016", "story_v_out_114182.awb")

						arg_65_1:RecordAudio("114182016", var_68_35)
						arg_65_1:RecordAudio("114182016", var_68_35)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114182", "114182016", "story_v_out_114182.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114182", "114182016", "story_v_out_114182.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_36 = math.max(var_68_27, arg_65_1.talkMaxDuration)

			if var_68_26 <= arg_65_1.time_ and arg_65_1.time_ < var_68_26 + var_68_36 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_26) / var_68_36

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_26 + var_68_36 and arg_65_1.time_ < var_68_26 + var_68_36 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play114182017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114182017
		arg_69_1.duration_ = 6.7

		local var_69_0 = {
			ja = 4.933,
			ko = 4.3,
			zh = 6.7,
			en = 4.533
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
				arg_69_0:Play114182018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1041ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1041ui_story == nil then
				arg_69_1.var_.characterEffect1041ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1041ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1041ui_story then
				arg_69_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_72_4 = arg_69_1.actors_["10006ui_story"]
			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect10006ui_story == nil then
				arg_69_1.var_.characterEffect10006ui_story = var_72_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.2

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_6 and not isNil(var_72_4) then
				local var_72_7 = (arg_69_1.time_ - var_72_5) / var_72_6

				if arg_69_1.var_.characterEffect10006ui_story and not isNil(var_72_4) then
					local var_72_8 = Mathf.Lerp(0, 0.5, var_72_7)

					arg_69_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10006ui_story.fillRatio = var_72_8
				end
			end

			if arg_69_1.time_ >= var_72_5 + var_72_6 and arg_69_1.time_ < var_72_5 + var_72_6 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect10006ui_story then
				local var_72_9 = 0.5

				arg_69_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10006ui_story.fillRatio = var_72_9
			end

			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_72_11 = 0
			local var_72_12 = 0.55

			if var_72_11 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_13 = arg_69_1:FormatText(StoryNameCfg[208].name)

				arg_69_1.leftNameTxt_.text = var_72_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_14 = arg_69_1:GetWordFromCfg(114182017)
				local var_72_15 = arg_69_1:FormatText(var_72_14.content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 22
				local var_72_17 = utf8.len(var_72_15)
				local var_72_18 = var_72_16 <= 0 and var_72_12 or var_72_12 * (var_72_17 / var_72_16)

				if var_72_18 > 0 and var_72_12 < var_72_18 then
					arg_69_1.talkMaxDuration = var_72_18

					if var_72_18 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182017", "story_v_out_114182.awb") ~= 0 then
					local var_72_19 = manager.audio:GetVoiceLength("story_v_out_114182", "114182017", "story_v_out_114182.awb") / 1000

					if var_72_19 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_11
					end

					if var_72_14.prefab_name ~= "" and arg_69_1.actors_[var_72_14.prefab_name] ~= nil then
						local var_72_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_14.prefab_name].transform, "story_v_out_114182", "114182017", "story_v_out_114182.awb")

						arg_69_1:RecordAudio("114182017", var_72_20)
						arg_69_1:RecordAudio("114182017", var_72_20)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_114182", "114182017", "story_v_out_114182.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_114182", "114182017", "story_v_out_114182.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_21 = math.max(var_72_12, arg_69_1.talkMaxDuration)

			if var_72_11 <= arg_69_1.time_ and arg_69_1.time_ < var_72_11 + var_72_21 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_11) / var_72_21

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_11 + var_72_21 and arg_69_1.time_ < var_72_11 + var_72_21 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114182018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114182018
		arg_73_1.duration_ = 5.43

		local var_73_0 = {
			ja = 5.433,
			ko = 2.533,
			zh = 2.3,
			en = 3.4
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
				arg_73_0:Play114182019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1041ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1041ui_story == nil then
				arg_73_1.var_.characterEffect1041ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1041ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1041ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1041ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1041ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.25

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[94].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_5")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(114182018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182018", "story_v_out_114182.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_114182", "114182018", "story_v_out_114182.awb") / 1000

					if var_76_14 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_6
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_out_114182", "114182018", "story_v_out_114182.awb")

						arg_73_1:RecordAudio("114182018", var_76_15)
						arg_73_1:RecordAudio("114182018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114182", "114182018", "story_v_out_114182.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114182", "114182018", "story_v_out_114182.awb")
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
	Play114182019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114182019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play114182020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1041ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1041ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1041ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, 100, 0)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["10006ui_story"].transform
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.var_.moveOldPos10006ui_story = var_80_9.localPosition
			end

			local var_80_11 = 0.001

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11
				local var_80_13 = Vector3.New(0, 100, 0)

				var_80_9.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10006ui_story, var_80_13, var_80_12)

				local var_80_14 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_14.x, var_80_14.y, var_80_14.z)

				local var_80_15 = var_80_9.localEulerAngles

				var_80_15.z = 0
				var_80_15.x = 0
				var_80_9.localEulerAngles = var_80_15
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 then
				var_80_9.localPosition = Vector3.New(0, 100, 0)

				local var_80_16 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_16.x, var_80_16.y, var_80_16.z)

				local var_80_17 = var_80_9.localEulerAngles

				var_80_17.z = 0
				var_80_17.x = 0
				var_80_9.localEulerAngles = var_80_17
			end

			local var_80_18 = 0
			local var_80_19 = 0.725

			if var_80_18 < arg_77_1.time_ and arg_77_1.time_ <= var_80_18 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_20 = arg_77_1:GetWordFromCfg(114182019)
				local var_80_21 = arg_77_1:FormatText(var_80_20.content)

				arg_77_1.text_.text = var_80_21

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_22 = 29
				local var_80_23 = utf8.len(var_80_21)
				local var_80_24 = var_80_22 <= 0 and var_80_19 or var_80_19 * (var_80_23 / var_80_22)

				if var_80_24 > 0 and var_80_19 < var_80_24 then
					arg_77_1.talkMaxDuration = var_80_24

					if var_80_24 + var_80_18 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_24 + var_80_18
					end
				end

				arg_77_1.text_.text = var_80_21
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = math.max(var_80_19, arg_77_1.talkMaxDuration)

			if var_80_18 <= arg_77_1.time_ and arg_77_1.time_ < var_80_18 + var_80_25 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_18) / var_80_25

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_18 + var_80_25 and arg_77_1.time_ < var_80_18 + var_80_25 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play114182020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114182020
		arg_81_1.duration_ = 6.73

		local var_81_0 = {
			ja = 6.733,
			ko = 6.3,
			zh = 5.7,
			en = 6.166
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
				arg_81_0:Play114182021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1184ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1184ui_story = var_84_0.localPosition

				local var_84_2 = "1184ui_story"

				arg_81_1:ShowWeapon(arg_81_1.var_[var_84_2 .. "Animator"].transform, false)
			end

			local var_84_3 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_3 then
				local var_84_4 = (arg_81_1.time_ - var_84_1) / var_84_3
				local var_84_5 = Vector3.New(0, -0.97, -6)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1184ui_story, var_84_5, var_84_4)

				local var_84_6 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_6.x, var_84_6.y, var_84_6.z)

				local var_84_7 = var_84_0.localEulerAngles

				var_84_7.z = 0
				var_84_7.x = 0
				var_84_0.localEulerAngles = var_84_7
			end

			if arg_81_1.time_ >= var_84_1 + var_84_3 and arg_81_1.time_ < var_84_1 + var_84_3 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_84_8 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_8.x, var_84_8.y, var_84_8.z)

				local var_84_9 = var_84_0.localEulerAngles

				var_84_9.z = 0
				var_84_9.x = 0
				var_84_0.localEulerAngles = var_84_9
			end

			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_84_11 = 0

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_84_12 = arg_81_1.actors_["1184ui_story"]
			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 and not isNil(var_84_12) and arg_81_1.var_.characterEffect1184ui_story == nil then
				arg_81_1.var_.characterEffect1184ui_story = var_84_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_14 = 0.2

			if var_84_13 <= arg_81_1.time_ and arg_81_1.time_ < var_84_13 + var_84_14 and not isNil(var_84_12) then
				local var_84_15 = (arg_81_1.time_ - var_84_13) / var_84_14

				if arg_81_1.var_.characterEffect1184ui_story and not isNil(var_84_12) then
					arg_81_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_13 + var_84_14 and arg_81_1.time_ < var_84_13 + var_84_14 + arg_84_0 and not isNil(var_84_12) and arg_81_1.var_.characterEffect1184ui_story then
				arg_81_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_84_16 = 0
			local var_84_17 = 0.6

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_18 = arg_81_1:FormatText(StoryNameCfg[6].name)

				arg_81_1.leftNameTxt_.text = var_84_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_19 = arg_81_1:GetWordFromCfg(114182020)
				local var_84_20 = arg_81_1:FormatText(var_84_19.content)

				arg_81_1.text_.text = var_84_20

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_21 = 24
				local var_84_22 = utf8.len(var_84_20)
				local var_84_23 = var_84_21 <= 0 and var_84_17 or var_84_17 * (var_84_22 / var_84_21)

				if var_84_23 > 0 and var_84_17 < var_84_23 then
					arg_81_1.talkMaxDuration = var_84_23

					if var_84_23 + var_84_16 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_16
					end
				end

				arg_81_1.text_.text = var_84_20
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182020", "story_v_out_114182.awb") ~= 0 then
					local var_84_24 = manager.audio:GetVoiceLength("story_v_out_114182", "114182020", "story_v_out_114182.awb") / 1000

					if var_84_24 + var_84_16 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_24 + var_84_16
					end

					if var_84_19.prefab_name ~= "" and arg_81_1.actors_[var_84_19.prefab_name] ~= nil then
						local var_84_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_19.prefab_name].transform, "story_v_out_114182", "114182020", "story_v_out_114182.awb")

						arg_81_1:RecordAudio("114182020", var_84_25)
						arg_81_1:RecordAudio("114182020", var_84_25)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114182", "114182020", "story_v_out_114182.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114182", "114182020", "story_v_out_114182.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_26 = math.max(var_84_17, arg_81_1.talkMaxDuration)

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_26 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_16) / var_84_26

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_16 + var_84_26 and arg_81_1.time_ < var_84_16 + var_84_26 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play114182021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114182021
		arg_85_1.duration_ = 0.2

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"

			SetActive(arg_85_1.choicesGo_, true)

			for iter_86_0, iter_86_1 in ipairs(arg_85_1.choices_) do
				local var_86_0 = iter_86_0 <= 1

				SetActive(iter_86_1.go, var_86_0)
			end

			arg_85_1.choices_[1].txt.text = arg_85_1:FormatText(StoryChoiceCfg[146].name)
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114182022(arg_85_1)
			end

			arg_85_1:RecordChoiceLog(114182021, 146)
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1184ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1184ui_story == nil then
				arg_85_1.var_.characterEffect1184ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1184ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1184ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1184ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1184ui_story.fillRatio = var_88_5
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play114182022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114182022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play114182023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1184ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1184ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, 100, 0)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1184ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, 100, 0)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = 0
			local var_92_10 = 1.025

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_11 = arg_89_1:GetWordFromCfg(114182022)
				local var_92_12 = arg_89_1:FormatText(var_92_11.content)

				arg_89_1.text_.text = var_92_12

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 41
				local var_92_14 = utf8.len(var_92_12)
				local var_92_15 = var_92_13 <= 0 and var_92_10 or var_92_10 * (var_92_14 / var_92_13)

				if var_92_15 > 0 and var_92_10 < var_92_15 then
					arg_89_1.talkMaxDuration = var_92_15

					if var_92_15 + var_92_9 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_15 + var_92_9
					end
				end

				arg_89_1.text_.text = var_92_12
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_10, arg_89_1.talkMaxDuration)

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_9) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_9 + var_92_16 and arg_89_1.time_ < var_92_9 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play114182023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114182023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play114182024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.3

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[7].name)

				arg_93_1.leftNameTxt_.text = var_96_2

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

				local var_96_3 = arg_93_1:GetWordFromCfg(114182023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 12
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_8 and arg_93_1.time_ < var_96_0 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114182024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114182024
		arg_97_1.duration_ = 9

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play114182025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = "F04"

			if arg_97_1.bgs_[var_100_0] == nil then
				local var_100_1 = Object.Instantiate(arg_97_1.paintGo_)

				var_100_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_100_0)
				var_100_1.name = var_100_0
				var_100_1.transform.parent = arg_97_1.stage_.transform
				var_100_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.bgs_[var_100_0] = var_100_1
			end

			local var_100_2 = 2

			if var_100_2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				local var_100_3 = manager.ui.mainCamera.transform.localPosition
				local var_100_4 = Vector3.New(0, 0, 10) + Vector3.New(var_100_3.x, var_100_3.y, 0)
				local var_100_5 = arg_97_1.bgs_.F04

				var_100_5.transform.localPosition = var_100_4
				var_100_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_100_6 = var_100_5:GetComponent("SpriteRenderer")

				if var_100_6 and var_100_6.sprite then
					local var_100_7 = (var_100_5.transform.localPosition - var_100_3).z
					local var_100_8 = manager.ui.mainCameraCom_
					local var_100_9 = 2 * var_100_7 * Mathf.Tan(var_100_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_100_10 = var_100_9 * var_100_8.aspect
					local var_100_11 = var_100_6.sprite.bounds.size.x
					local var_100_12 = var_100_6.sprite.bounds.size.y
					local var_100_13 = var_100_10 / var_100_11
					local var_100_14 = var_100_9 / var_100_12
					local var_100_15 = var_100_14 < var_100_13 and var_100_13 or var_100_14

					var_100_5.transform.localScale = Vector3.New(var_100_15, var_100_15, 0)
				end

				for iter_100_0, iter_100_1 in pairs(arg_97_1.bgs_) do
					if iter_100_0 ~= "F04" then
						iter_100_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_17 = 2

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17
				local var_100_19 = Color.New(0, 0, 0)

				var_100_19.a = Mathf.Lerp(0, 1, var_100_18)
				arg_97_1.mask_.color = var_100_19
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 then
				local var_100_20 = Color.New(0, 0, 0)

				var_100_20.a = 1
				arg_97_1.mask_.color = var_100_20
			end

			local var_100_21 = 2

			if var_100_21 < arg_97_1.time_ and arg_97_1.time_ <= var_100_21 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_22 = 2

			if var_100_21 <= arg_97_1.time_ and arg_97_1.time_ < var_100_21 + var_100_22 then
				local var_100_23 = (arg_97_1.time_ - var_100_21) / var_100_22
				local var_100_24 = Color.New(0, 0, 0)

				var_100_24.a = Mathf.Lerp(1, 0, var_100_23)
				arg_97_1.mask_.color = var_100_24
			end

			if arg_97_1.time_ >= var_100_21 + var_100_22 and arg_97_1.time_ < var_100_21 + var_100_22 + arg_100_0 then
				local var_100_25 = Color.New(0, 0, 0)
				local var_100_26 = 0

				arg_97_1.mask_.enabled = false
				var_100_25.a = var_100_26
				arg_97_1.mask_.color = var_100_25
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_27 = 4
			local var_100_28 = 0.25

			if var_100_27 < arg_97_1.time_ and arg_97_1.time_ <= var_100_27 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_29 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_29:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_30 = arg_97_1:GetWordFromCfg(114182024)
				local var_100_31 = arg_97_1:FormatText(var_100_30.content)

				arg_97_1.text_.text = var_100_31

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_32 = 10
				local var_100_33 = utf8.len(var_100_31)
				local var_100_34 = var_100_32 <= 0 and var_100_28 or var_100_28 * (var_100_33 / var_100_32)

				if var_100_34 > 0 and var_100_28 < var_100_34 then
					arg_97_1.talkMaxDuration = var_100_34
					var_100_27 = var_100_27 + 0.3

					if var_100_34 + var_100_27 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_34 + var_100_27
					end
				end

				arg_97_1.text_.text = var_100_31
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_35 = var_100_27 + 0.3
			local var_100_36 = math.max(var_100_28, arg_97_1.talkMaxDuration)

			if var_100_35 <= arg_97_1.time_ and arg_97_1.time_ < var_100_35 + var_100_36 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_35) / var_100_36

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_35 + var_100_36 and arg_97_1.time_ < var_100_35 + var_100_36 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114182025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 114182025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play114182026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.625

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(114182025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 25
				local var_106_5 = utf8.len(var_106_3)
				local var_106_6 = var_106_4 <= 0 and var_106_1 or var_106_1 * (var_106_5 / var_106_4)

				if var_106_6 > 0 and var_106_1 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_7 and arg_103_1.time_ < var_106_0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play114182026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114182026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play114182027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.95

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(114182026)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 38
				local var_110_5 = utf8.len(var_110_3)
				local var_110_6 = var_110_4 <= 0 and var_110_1 or var_110_1 * (var_110_5 / var_110_4)

				if var_110_6 > 0 and var_110_1 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_7 and arg_107_1.time_ < var_110_0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114182027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114182027
		arg_111_1.duration_ = 3.23

		local var_111_0 = {
			ja = 2.3,
			ko = 3.1,
			zh = 3.2,
			en = 3.233
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
				arg_111_0:Play114182028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.375

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[206].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(114182027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182027", "story_v_out_114182.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_114182", "114182027", "story_v_out_114182.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_114182", "114182027", "story_v_out_114182.awb")

						arg_111_1:RecordAudio("114182027", var_114_9)
						arg_111_1:RecordAudio("114182027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_114182", "114182027", "story_v_out_114182.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_114182", "114182027", "story_v_out_114182.awb")
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
	Play114182028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114182028
		arg_115_1.duration_ = 2.37

		local var_115_0 = {
			ja = 2.366,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.266
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
				arg_115_0:Play114182029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = "1067ui_story"

			if arg_115_1.actors_[var_118_0] == nil then
				local var_118_1 = Asset.Load("Char/" .. "1067ui_story")

				if not isNil(var_118_1) then
					local var_118_2 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_115_1.stage_.transform)

					var_118_2.name = var_118_0
					var_118_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_115_1.actors_[var_118_0] = var_118_2

					local var_118_3 = var_118_2:GetComponentInChildren(typeof(CharacterEffect))

					var_118_3.enabled = true

					local var_118_4 = GameObjectTools.GetOrAddComponent(var_118_2, typeof(DynamicBoneHelper))

					if var_118_4 then
						var_118_4:EnableDynamicBone(false)
					end

					arg_115_1:ShowWeapon(var_118_3.transform, false)

					arg_115_1.var_[var_118_0 .. "Animator"] = var_118_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_115_1.var_[var_118_0 .. "Animator"].applyRootMotion = true
					arg_115_1.var_[var_118_0 .. "LipSync"] = var_118_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_118_5 = arg_115_1.actors_["1067ui_story"]
			local var_118_6 = 0

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect1067ui_story == nil then
				arg_115_1.var_.characterEffect1067ui_story = var_118_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_7 = 0.2

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_7 and not isNil(var_118_5) then
				local var_118_8 = (arg_115_1.time_ - var_118_6) / var_118_7

				if arg_115_1.var_.characterEffect1067ui_story and not isNil(var_118_5) then
					local var_118_9 = Mathf.Lerp(0, 0.5, var_118_8)

					arg_115_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1067ui_story.fillRatio = var_118_9
				end
			end

			if arg_115_1.time_ >= var_118_6 + var_118_7 and arg_115_1.time_ < var_118_6 + var_118_7 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect1067ui_story then
				local var_118_10 = 0.5

				arg_115_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1067ui_story.fillRatio = var_118_10
			end

			local var_118_11 = "1042ui_story"

			if arg_115_1.actors_[var_118_11] == nil then
				local var_118_12 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_118_12) then
					local var_118_13 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_115_1.stage_.transform)

					var_118_13.name = var_118_11
					var_118_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_115_1.actors_[var_118_11] = var_118_13

					local var_118_14 = var_118_13:GetComponentInChildren(typeof(CharacterEffect))

					var_118_14.enabled = true

					local var_118_15 = GameObjectTools.GetOrAddComponent(var_118_13, typeof(DynamicBoneHelper))

					if var_118_15 then
						var_118_15:EnableDynamicBone(false)
					end

					arg_115_1:ShowWeapon(var_118_14.transform, false)

					arg_115_1.var_[var_118_11 .. "Animator"] = var_118_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_115_1.var_[var_118_11 .. "Animator"].applyRootMotion = true
					arg_115_1.var_[var_118_11 .. "LipSync"] = var_118_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_118_16 = arg_115_1.actors_["1042ui_story"].transform
			local var_118_17 = 0

			if var_118_17 < arg_115_1.time_ and arg_115_1.time_ <= var_118_17 + arg_118_0 then
				arg_115_1.var_.moveOldPos1042ui_story = var_118_16.localPosition
			end

			local var_118_18 = 0.001

			if var_118_17 <= arg_115_1.time_ and arg_115_1.time_ < var_118_17 + var_118_18 then
				local var_118_19 = (arg_115_1.time_ - var_118_17) / var_118_18
				local var_118_20 = Vector3.New(-0.7, -1.06, -6.2)

				var_118_16.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1042ui_story, var_118_20, var_118_19)

				local var_118_21 = manager.ui.mainCamera.transform.position - var_118_16.position

				var_118_16.forward = Vector3.New(var_118_21.x, var_118_21.y, var_118_21.z)

				local var_118_22 = var_118_16.localEulerAngles

				var_118_22.z = 0
				var_118_22.x = 0
				var_118_16.localEulerAngles = var_118_22
			end

			if arg_115_1.time_ >= var_118_17 + var_118_18 and arg_115_1.time_ < var_118_17 + var_118_18 + arg_118_0 then
				var_118_16.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_118_23 = manager.ui.mainCamera.transform.position - var_118_16.position

				var_118_16.forward = Vector3.New(var_118_23.x, var_118_23.y, var_118_23.z)

				local var_118_24 = var_118_16.localEulerAngles

				var_118_24.z = 0
				var_118_24.x = 0
				var_118_16.localEulerAngles = var_118_24
			end

			local var_118_25 = 0

			if var_118_25 < arg_115_1.time_ and arg_115_1.time_ <= var_118_25 + arg_118_0 then
				arg_115_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_118_26 = 0

			if var_118_26 < arg_115_1.time_ and arg_115_1.time_ <= var_118_26 + arg_118_0 then
				arg_115_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_118_27 = arg_115_1.actors_["1042ui_story"]
			local var_118_28 = 0

			if var_118_28 < arg_115_1.time_ and arg_115_1.time_ <= var_118_28 + arg_118_0 and not isNil(var_118_27) and arg_115_1.var_.characterEffect1042ui_story == nil then
				arg_115_1.var_.characterEffect1042ui_story = var_118_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_29 = 0.2

			if var_118_28 <= arg_115_1.time_ and arg_115_1.time_ < var_118_28 + var_118_29 and not isNil(var_118_27) then
				local var_118_30 = (arg_115_1.time_ - var_118_28) / var_118_29

				if arg_115_1.var_.characterEffect1042ui_story and not isNil(var_118_27) then
					arg_115_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_28 + var_118_29 and arg_115_1.time_ < var_118_28 + var_118_29 + arg_118_0 and not isNil(var_118_27) and arg_115_1.var_.characterEffect1042ui_story then
				arg_115_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_118_31 = 0
			local var_118_32 = 0.075

			if var_118_31 < arg_115_1.time_ and arg_115_1.time_ <= var_118_31 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_33 = arg_115_1:FormatText(StoryNameCfg[205].name)

				arg_115_1.leftNameTxt_.text = var_118_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_34 = arg_115_1:GetWordFromCfg(114182028)
				local var_118_35 = arg_115_1:FormatText(var_118_34.content)

				arg_115_1.text_.text = var_118_35

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_36 = 3
				local var_118_37 = utf8.len(var_118_35)
				local var_118_38 = var_118_36 <= 0 and var_118_32 or var_118_32 * (var_118_37 / var_118_36)

				if var_118_38 > 0 and var_118_32 < var_118_38 then
					arg_115_1.talkMaxDuration = var_118_38

					if var_118_38 + var_118_31 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_38 + var_118_31
					end
				end

				arg_115_1.text_.text = var_118_35
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182028", "story_v_out_114182.awb") ~= 0 then
					local var_118_39 = manager.audio:GetVoiceLength("story_v_out_114182", "114182028", "story_v_out_114182.awb") / 1000

					if var_118_39 + var_118_31 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_39 + var_118_31
					end

					if var_118_34.prefab_name ~= "" and arg_115_1.actors_[var_118_34.prefab_name] ~= nil then
						local var_118_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_34.prefab_name].transform, "story_v_out_114182", "114182028", "story_v_out_114182.awb")

						arg_115_1:RecordAudio("114182028", var_118_40)
						arg_115_1:RecordAudio("114182028", var_118_40)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_114182", "114182028", "story_v_out_114182.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_114182", "114182028", "story_v_out_114182.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_41 = math.max(var_118_32, arg_115_1.talkMaxDuration)

			if var_118_31 <= arg_115_1.time_ and arg_115_1.time_ < var_118_31 + var_118_41 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_31) / var_118_41

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_31 + var_118_41 and arg_115_1.time_ < var_118_31 + var_118_41 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play114182029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114182029
		arg_119_1.duration_ = 6.1

		local var_119_0 = {
			ja = 6.1,
			ko = 2.8,
			zh = 4.666,
			en = 4
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
				arg_119_0:Play114182030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1067ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1067ui_story == nil then
				arg_119_1.var_.characterEffect1067ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.2

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1067ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1067ui_story then
				arg_119_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_122_4 = arg_119_1.actors_["1042ui_story"]
			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1042ui_story == nil then
				arg_119_1.var_.characterEffect1042ui_story = var_122_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.2

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 and not isNil(var_122_4) then
				local var_122_7 = (arg_119_1.time_ - var_122_5) / var_122_6

				if arg_119_1.var_.characterEffect1042ui_story and not isNil(var_122_4) then
					local var_122_8 = Mathf.Lerp(0, 0.5, var_122_7)

					arg_119_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1042ui_story.fillRatio = var_122_8
				end
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1042ui_story then
				local var_122_9 = 0.5

				arg_119_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1042ui_story.fillRatio = var_122_9
			end

			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_1")
			end

			local var_122_11 = 0

			if var_122_11 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_122_12 = arg_119_1.actors_["1067ui_story"].transform
			local var_122_13 = 0

			if var_122_13 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1.var_.moveOldPos1067ui_story = var_122_12.localPosition
			end

			local var_122_14 = 0.001

			if var_122_13 <= arg_119_1.time_ and arg_119_1.time_ < var_122_13 + var_122_14 then
				local var_122_15 = (arg_119_1.time_ - var_122_13) / var_122_14
				local var_122_16 = Vector3.New(0.7, -1.06, -6.2)

				var_122_12.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1067ui_story, var_122_16, var_122_15)

				local var_122_17 = manager.ui.mainCamera.transform.position - var_122_12.position

				var_122_12.forward = Vector3.New(var_122_17.x, var_122_17.y, var_122_17.z)

				local var_122_18 = var_122_12.localEulerAngles

				var_122_18.z = 0
				var_122_18.x = 0
				var_122_12.localEulerAngles = var_122_18
			end

			if arg_119_1.time_ >= var_122_13 + var_122_14 and arg_119_1.time_ < var_122_13 + var_122_14 + arg_122_0 then
				var_122_12.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_122_19 = manager.ui.mainCamera.transform.position - var_122_12.position

				var_122_12.forward = Vector3.New(var_122_19.x, var_122_19.y, var_122_19.z)

				local var_122_20 = var_122_12.localEulerAngles

				var_122_20.z = 0
				var_122_20.x = 0
				var_122_12.localEulerAngles = var_122_20
			end

			local var_122_21 = 0
			local var_122_22 = 0.35

			if var_122_21 < arg_119_1.time_ and arg_119_1.time_ <= var_122_21 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_23 = arg_119_1:FormatText(StoryNameCfg[206].name)

				arg_119_1.leftNameTxt_.text = var_122_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_24 = arg_119_1:GetWordFromCfg(114182029)
				local var_122_25 = arg_119_1:FormatText(var_122_24.content)

				arg_119_1.text_.text = var_122_25

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_26 = 14
				local var_122_27 = utf8.len(var_122_25)
				local var_122_28 = var_122_26 <= 0 and var_122_22 or var_122_22 * (var_122_27 / var_122_26)

				if var_122_28 > 0 and var_122_22 < var_122_28 then
					arg_119_1.talkMaxDuration = var_122_28

					if var_122_28 + var_122_21 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_28 + var_122_21
					end
				end

				arg_119_1.text_.text = var_122_25
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182029", "story_v_out_114182.awb") ~= 0 then
					local var_122_29 = manager.audio:GetVoiceLength("story_v_out_114182", "114182029", "story_v_out_114182.awb") / 1000

					if var_122_29 + var_122_21 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_29 + var_122_21
					end

					if var_122_24.prefab_name ~= "" and arg_119_1.actors_[var_122_24.prefab_name] ~= nil then
						local var_122_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_24.prefab_name].transform, "story_v_out_114182", "114182029", "story_v_out_114182.awb")

						arg_119_1:RecordAudio("114182029", var_122_30)
						arg_119_1:RecordAudio("114182029", var_122_30)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_114182", "114182029", "story_v_out_114182.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_114182", "114182029", "story_v_out_114182.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_31 = math.max(var_122_22, arg_119_1.talkMaxDuration)

			if var_122_21 <= arg_119_1.time_ and arg_119_1.time_ < var_122_21 + var_122_31 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_21) / var_122_31

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_21 + var_122_31 and arg_119_1.time_ < var_122_21 + var_122_31 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play114182030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114182030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play114182031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1067ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1067ui_story == nil then
				arg_123_1.var_.characterEffect1067ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1067ui_story and not isNil(var_126_0) then
					local var_126_4 = Mathf.Lerp(0, 0.5, var_126_3)

					arg_123_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1067ui_story.fillRatio = var_126_4
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1067ui_story then
				local var_126_5 = 0.5

				arg_123_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1067ui_story.fillRatio = var_126_5
			end

			local var_126_6 = 0

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_2")
			end

			local var_126_7 = 0
			local var_126_8 = 0.925

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_9 = arg_123_1:GetWordFromCfg(114182030)
				local var_126_10 = arg_123_1:FormatText(var_126_9.content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 37
				local var_126_12 = utf8.len(var_126_10)
				local var_126_13 = var_126_11 <= 0 and var_126_8 or var_126_8 * (var_126_12 / var_126_11)

				if var_126_13 > 0 and var_126_8 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_7
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_8, arg_123_1.talkMaxDuration)

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_7) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_7 + var_126_14 and arg_123_1.time_ < var_126_7 + var_126_14 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play114182031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114182031
		arg_127_1.duration_ = 2.47

		local var_127_0 = {
			ja = 2.466,
			ko = 2.133,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_127_0:Play114182032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_130_1 = arg_127_1.actors_["1067ui_story"]
			local var_130_2 = 0

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1067ui_story == nil then
				arg_127_1.var_.characterEffect1067ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_3 = 0.2

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_3 and not isNil(var_130_1) then
				local var_130_4 = (arg_127_1.time_ - var_130_2) / var_130_3

				if arg_127_1.var_.characterEffect1067ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_2 + var_130_3 and arg_127_1.time_ < var_130_2 + var_130_3 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1067ui_story then
				arg_127_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_130_5 = 0
			local var_130_6 = 0.2

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_7 = arg_127_1:FormatText(StoryNameCfg[206].name)

				arg_127_1.leftNameTxt_.text = var_130_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:GetWordFromCfg(114182031)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 8
				local var_130_11 = utf8.len(var_130_9)
				local var_130_12 = var_130_10 <= 0 and var_130_6 or var_130_6 * (var_130_11 / var_130_10)

				if var_130_12 > 0 and var_130_6 < var_130_12 then
					arg_127_1.talkMaxDuration = var_130_12

					if var_130_12 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182031", "story_v_out_114182.awb") ~= 0 then
					local var_130_13 = manager.audio:GetVoiceLength("story_v_out_114182", "114182031", "story_v_out_114182.awb") / 1000

					if var_130_13 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_5
					end

					if var_130_8.prefab_name ~= "" and arg_127_1.actors_[var_130_8.prefab_name] ~= nil then
						local var_130_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_8.prefab_name].transform, "story_v_out_114182", "114182031", "story_v_out_114182.awb")

						arg_127_1:RecordAudio("114182031", var_130_14)
						arg_127_1:RecordAudio("114182031", var_130_14)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_114182", "114182031", "story_v_out_114182.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_114182", "114182031", "story_v_out_114182.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_15 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_15 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_15

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_15 and arg_127_1.time_ < var_130_5 + var_130_15 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play114182032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114182032
		arg_131_1.duration_ = 2

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play114182033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1067ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1067ui_story == nil then
				arg_131_1.var_.characterEffect1067ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1067ui_story and not isNil(var_134_0) then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1067ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1067ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1067ui_story.fillRatio = var_134_5
			end

			local var_134_6 = 0

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_134_7 = arg_131_1.actors_["1042ui_story"]
			local var_134_8 = 0

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.characterEffect1042ui_story == nil then
				arg_131_1.var_.characterEffect1042ui_story = var_134_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_9 = 0.2

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_9 and not isNil(var_134_7) then
				local var_134_10 = (arg_131_1.time_ - var_134_8) / var_134_9

				if arg_131_1.var_.characterEffect1042ui_story and not isNil(var_134_7) then
					arg_131_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_8 + var_134_9 and arg_131_1.time_ < var_134_8 + var_134_9 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.characterEffect1042ui_story then
				arg_131_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_134_11 = 0
			local var_134_12 = 0.075

			if var_134_11 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_13 = arg_131_1:FormatText(StoryNameCfg[205].name)

				arg_131_1.leftNameTxt_.text = var_134_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_14 = arg_131_1:GetWordFromCfg(114182032)
				local var_134_15 = arg_131_1:FormatText(var_134_14.content)

				arg_131_1.text_.text = var_134_15

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_16 = 3
				local var_134_17 = utf8.len(var_134_15)
				local var_134_18 = var_134_16 <= 0 and var_134_12 or var_134_12 * (var_134_17 / var_134_16)

				if var_134_18 > 0 and var_134_12 < var_134_18 then
					arg_131_1.talkMaxDuration = var_134_18

					if var_134_18 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_18 + var_134_11
					end
				end

				arg_131_1.text_.text = var_134_15
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182032", "story_v_out_114182.awb") ~= 0 then
					local var_134_19 = manager.audio:GetVoiceLength("story_v_out_114182", "114182032", "story_v_out_114182.awb") / 1000

					if var_134_19 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_19 + var_134_11
					end

					if var_134_14.prefab_name ~= "" and arg_131_1.actors_[var_134_14.prefab_name] ~= nil then
						local var_134_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_14.prefab_name].transform, "story_v_out_114182", "114182032", "story_v_out_114182.awb")

						arg_131_1:RecordAudio("114182032", var_134_20)
						arg_131_1:RecordAudio("114182032", var_134_20)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_114182", "114182032", "story_v_out_114182.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_114182", "114182032", "story_v_out_114182.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_21 = math.max(var_134_12, arg_131_1.talkMaxDuration)

			if var_134_11 <= arg_131_1.time_ and arg_131_1.time_ < var_134_11 + var_134_21 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_11) / var_134_21

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_11 + var_134_21 and arg_131_1.time_ < var_134_11 + var_134_21 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play114182033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 114182033
		arg_135_1.duration_ = 9.97

		local var_135_0 = {
			ja = 5.1,
			ko = 9.966,
			zh = 7.7,
			en = 8.366
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
				arg_135_0:Play114182034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1067ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1067ui_story == nil then
				arg_135_1.var_.characterEffect1067ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1067ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1067ui_story then
				arg_135_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_138_4 = arg_135_1.actors_["1042ui_story"]
			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect1042ui_story == nil then
				arg_135_1.var_.characterEffect1042ui_story = var_138_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_6 = 0.2

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_6 and not isNil(var_138_4) then
				local var_138_7 = (arg_135_1.time_ - var_138_5) / var_138_6

				if arg_135_1.var_.characterEffect1042ui_story and not isNil(var_138_4) then
					local var_138_8 = Mathf.Lerp(0, 0.5, var_138_7)

					arg_135_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1042ui_story.fillRatio = var_138_8
				end
			end

			if arg_135_1.time_ >= var_138_5 + var_138_6 and arg_135_1.time_ < var_138_5 + var_138_6 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect1042ui_story then
				local var_138_9 = 0.5

				arg_135_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1042ui_story.fillRatio = var_138_9
			end

			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_138_11 = 0

			if var_138_11 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_138_12 = 0
			local var_138_13 = 1

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_14 = arg_135_1:FormatText(StoryNameCfg[206].name)

				arg_135_1.leftNameTxt_.text = var_138_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_15 = arg_135_1:GetWordFromCfg(114182033)
				local var_138_16 = arg_135_1:FormatText(var_138_15.content)

				arg_135_1.text_.text = var_138_16

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 40
				local var_138_18 = utf8.len(var_138_16)
				local var_138_19 = var_138_17 <= 0 and var_138_13 or var_138_13 * (var_138_18 / var_138_17)

				if var_138_19 > 0 and var_138_13 < var_138_19 then
					arg_135_1.talkMaxDuration = var_138_19

					if var_138_19 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_16
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182033", "story_v_out_114182.awb") ~= 0 then
					local var_138_20 = manager.audio:GetVoiceLength("story_v_out_114182", "114182033", "story_v_out_114182.awb") / 1000

					if var_138_20 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_12
					end

					if var_138_15.prefab_name ~= "" and arg_135_1.actors_[var_138_15.prefab_name] ~= nil then
						local var_138_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_15.prefab_name].transform, "story_v_out_114182", "114182033", "story_v_out_114182.awb")

						arg_135_1:RecordAudio("114182033", var_138_21)
						arg_135_1:RecordAudio("114182033", var_138_21)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_114182", "114182033", "story_v_out_114182.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_114182", "114182033", "story_v_out_114182.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_22 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_22 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_22

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_22 and arg_135_1.time_ < var_138_12 + var_138_22 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play114182034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114182034
		arg_139_1.duration_ = 4.5

		local var_139_0 = {
			ja = 3.5,
			ko = 4.5,
			zh = 3.466,
			en = 3.333
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
				arg_139_0:Play114182035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1067ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1067ui_story == nil then
				arg_139_1.var_.characterEffect1067ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1067ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1067ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1067ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1067ui_story.fillRatio = var_142_5
			end

			local var_142_6 = arg_139_1.actors_["1042ui_story"]
			local var_142_7 = 0

			if var_142_7 < arg_139_1.time_ and arg_139_1.time_ <= var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1042ui_story == nil then
				arg_139_1.var_.characterEffect1042ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_8 = 0.2

			if var_142_7 <= arg_139_1.time_ and arg_139_1.time_ < var_142_7 + var_142_8 and not isNil(var_142_6) then
				local var_142_9 = (arg_139_1.time_ - var_142_7) / var_142_8

				if arg_139_1.var_.characterEffect1042ui_story and not isNil(var_142_6) then
					arg_139_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_7 + var_142_8 and arg_139_1.time_ < var_142_7 + var_142_8 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1042ui_story then
				arg_139_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_142_11 = 0
			local var_142_12 = 0.375

			if var_142_11 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_13 = arg_139_1:FormatText(StoryNameCfg[205].name)

				arg_139_1.leftNameTxt_.text = var_142_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_14 = arg_139_1:GetWordFromCfg(114182034)
				local var_142_15 = arg_139_1:FormatText(var_142_14.content)

				arg_139_1.text_.text = var_142_15

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_16 = 15
				local var_142_17 = utf8.len(var_142_15)
				local var_142_18 = var_142_16 <= 0 and var_142_12 or var_142_12 * (var_142_17 / var_142_16)

				if var_142_18 > 0 and var_142_12 < var_142_18 then
					arg_139_1.talkMaxDuration = var_142_18

					if var_142_18 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_18 + var_142_11
					end
				end

				arg_139_1.text_.text = var_142_15
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182034", "story_v_out_114182.awb") ~= 0 then
					local var_142_19 = manager.audio:GetVoiceLength("story_v_out_114182", "114182034", "story_v_out_114182.awb") / 1000

					if var_142_19 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_19 + var_142_11
					end

					if var_142_14.prefab_name ~= "" and arg_139_1.actors_[var_142_14.prefab_name] ~= nil then
						local var_142_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_14.prefab_name].transform, "story_v_out_114182", "114182034", "story_v_out_114182.awb")

						arg_139_1:RecordAudio("114182034", var_142_20)
						arg_139_1:RecordAudio("114182034", var_142_20)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_114182", "114182034", "story_v_out_114182.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_114182", "114182034", "story_v_out_114182.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_21 = math.max(var_142_12, arg_139_1.talkMaxDuration)

			if var_142_11 <= arg_139_1.time_ and arg_139_1.time_ < var_142_11 + var_142_21 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_11) / var_142_21

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_11 + var_142_21 and arg_139_1.time_ < var_142_11 + var_142_21 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play114182035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114182035
		arg_143_1.duration_ = 6

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play114182036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1067ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1067ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(0, 100, 0)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1067ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, 100, 0)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = arg_143_1.actors_["1042ui_story"].transform
			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1.var_.moveOldPos1042ui_story = var_146_9.localPosition
			end

			local var_146_11 = 0.001

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_11 then
				local var_146_12 = (arg_143_1.time_ - var_146_10) / var_146_11
				local var_146_13 = Vector3.New(0, 100, 0)

				var_146_9.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1042ui_story, var_146_13, var_146_12)

				local var_146_14 = manager.ui.mainCamera.transform.position - var_146_9.position

				var_146_9.forward = Vector3.New(var_146_14.x, var_146_14.y, var_146_14.z)

				local var_146_15 = var_146_9.localEulerAngles

				var_146_15.z = 0
				var_146_15.x = 0
				var_146_9.localEulerAngles = var_146_15
			end

			if arg_143_1.time_ >= var_146_10 + var_146_11 and arg_143_1.time_ < var_146_10 + var_146_11 + arg_146_0 then
				var_146_9.localPosition = Vector3.New(0, 100, 0)

				local var_146_16 = manager.ui.mainCamera.transform.position - var_146_9.position

				var_146_9.forward = Vector3.New(var_146_16.x, var_146_16.y, var_146_16.z)

				local var_146_17 = var_146_9.localEulerAngles

				var_146_17.z = 0
				var_146_17.x = 0
				var_146_9.localEulerAngles = var_146_17
			end

			local var_146_18 = manager.ui.mainCamera.transform
			local var_146_19 = 0

			if var_146_19 < arg_143_1.time_ and arg_143_1.time_ <= var_146_19 + arg_146_0 then
				arg_143_1.var_.shakeOldPos = var_146_18.localPosition
			end

			local var_146_20 = 1

			if var_146_19 <= arg_143_1.time_ and arg_143_1.time_ < var_146_19 + var_146_20 then
				local var_146_21 = (arg_143_1.time_ - var_146_19) / 0.066
				local var_146_22, var_146_23 = math.modf(var_146_21)

				var_146_18.localPosition = Vector3.New(var_146_23 * 0.13, var_146_23 * 0.13, var_146_23 * 0.13) + arg_143_1.var_.shakeOldPos
			end

			if arg_143_1.time_ >= var_146_19 + var_146_20 and arg_143_1.time_ < var_146_19 + var_146_20 + arg_146_0 then
				var_146_18.localPosition = arg_143_1.var_.shakeOldPos
			end

			local var_146_24 = 0

			if var_146_24 < arg_143_1.time_ and arg_143_1.time_ <= var_146_24 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			local var_146_25 = 1

			if arg_143_1.time_ >= var_146_24 + var_146_25 and arg_143_1.time_ < var_146_24 + var_146_25 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			local var_146_26 = 1
			local var_146_27 = 1

			if var_146_26 < arg_143_1.time_ and arg_143_1.time_ <= var_146_26 + arg_146_0 then
				local var_146_28 = "play"
				local var_146_29 = "effect"

				arg_143_1:AudioAction(var_146_28, var_146_29, "se_story_11", "se_story_11_blast02", "")
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_30 = 1
			local var_146_31 = 0.075

			if var_146_30 < arg_143_1.time_ and arg_143_1.time_ <= var_146_30 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_32 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_32:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_33 = arg_143_1:GetWordFromCfg(114182035)
				local var_146_34 = arg_143_1:FormatText(var_146_33.content)

				arg_143_1.text_.text = var_146_34

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_35 = 3
				local var_146_36 = utf8.len(var_146_34)
				local var_146_37 = var_146_35 <= 0 and var_146_31 or var_146_31 * (var_146_36 / var_146_35)

				if var_146_37 > 0 and var_146_31 < var_146_37 then
					arg_143_1.talkMaxDuration = var_146_37
					var_146_30 = var_146_30 + 0.3

					if var_146_37 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_37 + var_146_30
					end
				end

				arg_143_1.text_.text = var_146_34
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_38 = var_146_30 + 0.3
			local var_146_39 = math.max(var_146_31, arg_143_1.talkMaxDuration)

			if var_146_38 <= arg_143_1.time_ and arg_143_1.time_ < var_146_38 + var_146_39 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_38) / var_146_39

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_38 + var_146_39 and arg_143_1.time_ < var_146_38 + var_146_39 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
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

		arg_143_1:InitPlayNodeList()
	end,
	Play114182036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 114182036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play114182037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 1.55

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(114182036)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 62
				local var_152_5 = utf8.len(var_152_3)
				local var_152_6 = var_152_4 <= 0 and var_152_1 or var_152_1 * (var_152_5 / var_152_4)

				if var_152_6 > 0 and var_152_1 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_7 and arg_149_1.time_ < var_152_0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play114182037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 114182037
		arg_153_1.duration_ = 3.8

		local var_153_0 = {
			ja = 2.8,
			ko = 2.733,
			zh = 3.8,
			en = 2.7
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
				arg_153_0:Play114182038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_156_2 = arg_153_1.actors_["1067ui_story"].transform
			local var_156_3 = 0

			if var_156_3 < arg_153_1.time_ and arg_153_1.time_ <= var_156_3 + arg_156_0 then
				arg_153_1.var_.moveOldPos1067ui_story = var_156_2.localPosition
			end

			local var_156_4 = 0.001

			if var_156_3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_3 + var_156_4 then
				local var_156_5 = (arg_153_1.time_ - var_156_3) / var_156_4
				local var_156_6 = Vector3.New(0, -1.06, -6.2)

				var_156_2.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1067ui_story, var_156_6, var_156_5)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_2.position

				var_156_2.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_2.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_2.localEulerAngles = var_156_8
			end

			if arg_153_1.time_ >= var_156_3 + var_156_4 and arg_153_1.time_ < var_156_3 + var_156_4 + arg_156_0 then
				var_156_2.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_156_9 = manager.ui.mainCamera.transform.position - var_156_2.position

				var_156_2.forward = Vector3.New(var_156_9.x, var_156_9.y, var_156_9.z)

				local var_156_10 = var_156_2.localEulerAngles

				var_156_10.z = 0
				var_156_10.x = 0
				var_156_2.localEulerAngles = var_156_10
			end

			local var_156_11 = arg_153_1.actors_["1067ui_story"]
			local var_156_12 = 0

			if var_156_12 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 and not isNil(var_156_11) and arg_153_1.var_.characterEffect1067ui_story == nil then
				arg_153_1.var_.characterEffect1067ui_story = var_156_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_13 = 0.2

			if var_156_12 <= arg_153_1.time_ and arg_153_1.time_ < var_156_12 + var_156_13 and not isNil(var_156_11) then
				local var_156_14 = (arg_153_1.time_ - var_156_12) / var_156_13

				if arg_153_1.var_.characterEffect1067ui_story and not isNil(var_156_11) then
					arg_153_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_12 + var_156_13 and arg_153_1.time_ < var_156_12 + var_156_13 + arg_156_0 and not isNil(var_156_11) and arg_153_1.var_.characterEffect1067ui_story then
				arg_153_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_156_15 = 0
			local var_156_16 = 0.25

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_17 = arg_153_1:FormatText(StoryNameCfg[206].name)

				arg_153_1.leftNameTxt_.text = var_156_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_18 = arg_153_1:GetWordFromCfg(114182037)
				local var_156_19 = arg_153_1:FormatText(var_156_18.content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_20 = 10
				local var_156_21 = utf8.len(var_156_19)
				local var_156_22 = var_156_20 <= 0 and var_156_16 or var_156_16 * (var_156_21 / var_156_20)

				if var_156_22 > 0 and var_156_16 < var_156_22 then
					arg_153_1.talkMaxDuration = var_156_22

					if var_156_22 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_22 + var_156_15
					end
				end

				arg_153_1.text_.text = var_156_19
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182037", "story_v_out_114182.awb") ~= 0 then
					local var_156_23 = manager.audio:GetVoiceLength("story_v_out_114182", "114182037", "story_v_out_114182.awb") / 1000

					if var_156_23 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_15
					end

					if var_156_18.prefab_name ~= "" and arg_153_1.actors_[var_156_18.prefab_name] ~= nil then
						local var_156_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_18.prefab_name].transform, "story_v_out_114182", "114182037", "story_v_out_114182.awb")

						arg_153_1:RecordAudio("114182037", var_156_24)
						arg_153_1:RecordAudio("114182037", var_156_24)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_114182", "114182037", "story_v_out_114182.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_114182", "114182037", "story_v_out_114182.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_25 = math.max(var_156_16, arg_153_1.talkMaxDuration)

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_25 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_25

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_25 and arg_153_1.time_ < var_156_15 + var_156_25 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
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
	Play114182038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 114182038
		arg_157_1.duration_ = 3.27

		local var_157_0 = {
			ja = 3.2,
			ko = 2.566,
			zh = 2.8,
			en = 3.266
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
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play114182039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1067ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1067ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0, 100, 0)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1067ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, 100, 0)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = 0
			local var_160_10 = 0.3

			if var_160_9 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_11 = arg_157_1:FormatText(StoryNameCfg[210].name)

				arg_157_1.leftNameTxt_.text = var_160_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_12 = arg_157_1:GetWordFromCfg(114182038)
				local var_160_13 = arg_157_1:FormatText(var_160_12.content)

				arg_157_1.text_.text = var_160_13

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_14 = 12
				local var_160_15 = utf8.len(var_160_13)
				local var_160_16 = var_160_14 <= 0 and var_160_10 or var_160_10 * (var_160_15 / var_160_14)

				if var_160_16 > 0 and var_160_10 < var_160_16 then
					arg_157_1.talkMaxDuration = var_160_16

					if var_160_16 + var_160_9 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_16 + var_160_9
					end
				end

				arg_157_1.text_.text = var_160_13
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182038", "story_v_out_114182.awb") ~= 0 then
					local var_160_17 = manager.audio:GetVoiceLength("story_v_out_114182", "114182038", "story_v_out_114182.awb") / 1000

					if var_160_17 + var_160_9 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_17 + var_160_9
					end

					if var_160_12.prefab_name ~= "" and arg_157_1.actors_[var_160_12.prefab_name] ~= nil then
						local var_160_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_12.prefab_name].transform, "story_v_out_114182", "114182038", "story_v_out_114182.awb")

						arg_157_1:RecordAudio("114182038", var_160_18)
						arg_157_1:RecordAudio("114182038", var_160_18)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_114182", "114182038", "story_v_out_114182.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_114182", "114182038", "story_v_out_114182.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_19 = math.max(var_160_10, arg_157_1.talkMaxDuration)

			if var_160_9 <= arg_157_1.time_ and arg_157_1.time_ < var_160_9 + var_160_19 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_9) / var_160_19

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_9 + var_160_19 and arg_157_1.time_ < var_160_9 + var_160_19 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
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
	Play114182039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 114182039
		arg_161_1.duration_ = 2.33

		local var_161_0 = {
			ja = 1.733,
			ko = 2.333,
			zh = 1.933,
			en = 2
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
				arg_161_0:Play114182040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.25

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[213].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(114182039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182039", "story_v_out_114182.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_114182", "114182039", "story_v_out_114182.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_114182", "114182039", "story_v_out_114182.awb")

						arg_161_1:RecordAudio("114182039", var_164_9)
						arg_161_1:RecordAudio("114182039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_114182", "114182039", "story_v_out_114182.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_114182", "114182039", "story_v_out_114182.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play114182040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114182040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play114182041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.9

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_2 = arg_165_1:GetWordFromCfg(114182040)
				local var_168_3 = arg_165_1:FormatText(var_168_2.content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 36
				local var_168_5 = utf8.len(var_168_3)
				local var_168_6 = var_168_4 <= 0 and var_168_1 or var_168_1 * (var_168_5 / var_168_4)

				if var_168_6 > 0 and var_168_1 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_7 and arg_165_1.time_ < var_168_0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play114182041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114182041
		arg_169_1.duration_ = 3

		local var_169_0 = {
			ja = 3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_169_0:Play114182042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_172_1 = arg_169_1.actors_["1067ui_story"].transform
			local var_172_2 = 0

			if var_172_2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.var_.moveOldPos1067ui_story = var_172_1.localPosition
			end

			local var_172_3 = 0.001

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_3 then
				local var_172_4 = (arg_169_1.time_ - var_172_2) / var_172_3
				local var_172_5 = Vector3.New(-0.7, -1.06, -6.2)

				var_172_1.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1067ui_story, var_172_5, var_172_4)

				local var_172_6 = manager.ui.mainCamera.transform.position - var_172_1.position

				var_172_1.forward = Vector3.New(var_172_6.x, var_172_6.y, var_172_6.z)

				local var_172_7 = var_172_1.localEulerAngles

				var_172_7.z = 0
				var_172_7.x = 0
				var_172_1.localEulerAngles = var_172_7
			end

			if arg_169_1.time_ >= var_172_2 + var_172_3 and arg_169_1.time_ < var_172_2 + var_172_3 + arg_172_0 then
				var_172_1.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_172_8 = manager.ui.mainCamera.transform.position - var_172_1.position

				var_172_1.forward = Vector3.New(var_172_8.x, var_172_8.y, var_172_8.z)

				local var_172_9 = var_172_1.localEulerAngles

				var_172_9.z = 0
				var_172_9.x = 0
				var_172_1.localEulerAngles = var_172_9
			end

			local var_172_10 = arg_169_1.actors_["1067ui_story"]
			local var_172_11 = 0

			if var_172_11 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 and not isNil(var_172_10) and arg_169_1.var_.characterEffect1067ui_story == nil then
				arg_169_1.var_.characterEffect1067ui_story = var_172_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_12 = 0.2

			if var_172_11 <= arg_169_1.time_ and arg_169_1.time_ < var_172_11 + var_172_12 and not isNil(var_172_10) then
				local var_172_13 = (arg_169_1.time_ - var_172_11) / var_172_12

				if arg_169_1.var_.characterEffect1067ui_story and not isNil(var_172_10) then
					arg_169_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_11 + var_172_12 and arg_169_1.time_ < var_172_11 + var_172_12 + arg_172_0 and not isNil(var_172_10) and arg_169_1.var_.characterEffect1067ui_story then
				arg_169_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_172_15 = 0
			local var_172_16 = 0.2

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_17 = arg_169_1:FormatText(StoryNameCfg[206].name)

				arg_169_1.leftNameTxt_.text = var_172_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_18 = arg_169_1:GetWordFromCfg(114182041)
				local var_172_19 = arg_169_1:FormatText(var_172_18.content)

				arg_169_1.text_.text = var_172_19

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_20 = 8
				local var_172_21 = utf8.len(var_172_19)
				local var_172_22 = var_172_20 <= 0 and var_172_16 or var_172_16 * (var_172_21 / var_172_20)

				if var_172_22 > 0 and var_172_16 < var_172_22 then
					arg_169_1.talkMaxDuration = var_172_22

					if var_172_22 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_22 + var_172_15
					end
				end

				arg_169_1.text_.text = var_172_19
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182041", "story_v_out_114182.awb") ~= 0 then
					local var_172_23 = manager.audio:GetVoiceLength("story_v_out_114182", "114182041", "story_v_out_114182.awb") / 1000

					if var_172_23 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_23 + var_172_15
					end

					if var_172_18.prefab_name ~= "" and arg_169_1.actors_[var_172_18.prefab_name] ~= nil then
						local var_172_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_18.prefab_name].transform, "story_v_out_114182", "114182041", "story_v_out_114182.awb")

						arg_169_1:RecordAudio("114182041", var_172_24)
						arg_169_1:RecordAudio("114182041", var_172_24)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114182", "114182041", "story_v_out_114182.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114182", "114182041", "story_v_out_114182.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_25 = math.max(var_172_16, arg_169_1.talkMaxDuration)

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_25 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_15) / var_172_25

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_15 + var_172_25 and arg_169_1.time_ < var_172_15 + var_172_25 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play114182042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114182042
		arg_173_1.duration_ = 6.33

		local var_173_0 = {
			ja = 6.333,
			ko = 4.6,
			zh = 3.3,
			en = 3.166
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
				arg_173_0:Play114182043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1067ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1067ui_story == nil then
				arg_173_1.var_.characterEffect1067ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1067ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1067ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1067ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1067ui_story.fillRatio = var_176_5
			end

			local var_176_6 = arg_173_1.actors_["1042ui_story"].transform
			local var_176_7 = 0

			if var_176_7 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 then
				arg_173_1.var_.moveOldPos1042ui_story = var_176_6.localPosition
			end

			local var_176_8 = 0.001

			if var_176_7 <= arg_173_1.time_ and arg_173_1.time_ < var_176_7 + var_176_8 then
				local var_176_9 = (arg_173_1.time_ - var_176_7) / var_176_8
				local var_176_10 = Vector3.New(0.7, -1.06, -6.2)

				var_176_6.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1042ui_story, var_176_10, var_176_9)

				local var_176_11 = manager.ui.mainCamera.transform.position - var_176_6.position

				var_176_6.forward = Vector3.New(var_176_11.x, var_176_11.y, var_176_11.z)

				local var_176_12 = var_176_6.localEulerAngles

				var_176_12.z = 0
				var_176_12.x = 0
				var_176_6.localEulerAngles = var_176_12
			end

			if arg_173_1.time_ >= var_176_7 + var_176_8 and arg_173_1.time_ < var_176_7 + var_176_8 + arg_176_0 then
				var_176_6.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_176_13 = manager.ui.mainCamera.transform.position - var_176_6.position

				var_176_6.forward = Vector3.New(var_176_13.x, var_176_13.y, var_176_13.z)

				local var_176_14 = var_176_6.localEulerAngles

				var_176_14.z = 0
				var_176_14.x = 0
				var_176_6.localEulerAngles = var_176_14
			end

			local var_176_15 = 0

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_176_16 = 0

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 then
				arg_173_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_176_17 = arg_173_1.actors_["1042ui_story"]
			local var_176_18 = 0

			if var_176_18 < arg_173_1.time_ and arg_173_1.time_ <= var_176_18 + arg_176_0 and not isNil(var_176_17) and arg_173_1.var_.characterEffect1042ui_story == nil then
				arg_173_1.var_.characterEffect1042ui_story = var_176_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_19 = 0.2

			if var_176_18 <= arg_173_1.time_ and arg_173_1.time_ < var_176_18 + var_176_19 and not isNil(var_176_17) then
				local var_176_20 = (arg_173_1.time_ - var_176_18) / var_176_19

				if arg_173_1.var_.characterEffect1042ui_story and not isNil(var_176_17) then
					arg_173_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_18 + var_176_19 and arg_173_1.time_ < var_176_18 + var_176_19 + arg_176_0 and not isNil(var_176_17) and arg_173_1.var_.characterEffect1042ui_story then
				arg_173_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_176_21 = 0
			local var_176_22 = 0.35

			if var_176_21 < arg_173_1.time_ and arg_173_1.time_ <= var_176_21 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_23 = arg_173_1:FormatText(StoryNameCfg[205].name)

				arg_173_1.leftNameTxt_.text = var_176_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_24 = arg_173_1:GetWordFromCfg(114182042)
				local var_176_25 = arg_173_1:FormatText(var_176_24.content)

				arg_173_1.text_.text = var_176_25

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_26 = 14
				local var_176_27 = utf8.len(var_176_25)
				local var_176_28 = var_176_26 <= 0 and var_176_22 or var_176_22 * (var_176_27 / var_176_26)

				if var_176_28 > 0 and var_176_22 < var_176_28 then
					arg_173_1.talkMaxDuration = var_176_28

					if var_176_28 + var_176_21 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_28 + var_176_21
					end
				end

				arg_173_1.text_.text = var_176_25
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182042", "story_v_out_114182.awb") ~= 0 then
					local var_176_29 = manager.audio:GetVoiceLength("story_v_out_114182", "114182042", "story_v_out_114182.awb") / 1000

					if var_176_29 + var_176_21 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_29 + var_176_21
					end

					if var_176_24.prefab_name ~= "" and arg_173_1.actors_[var_176_24.prefab_name] ~= nil then
						local var_176_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_24.prefab_name].transform, "story_v_out_114182", "114182042", "story_v_out_114182.awb")

						arg_173_1:RecordAudio("114182042", var_176_30)
						arg_173_1:RecordAudio("114182042", var_176_30)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_114182", "114182042", "story_v_out_114182.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_114182", "114182042", "story_v_out_114182.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_31 = math.max(var_176_22, arg_173_1.talkMaxDuration)

			if var_176_21 <= arg_173_1.time_ and arg_173_1.time_ < var_176_21 + var_176_31 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_21) / var_176_31

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_21 + var_176_31 and arg_173_1.time_ < var_176_21 + var_176_31 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
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

		arg_173_1:InitPlayNodeList()
	end,
	Play114182043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114182043
		arg_177_1.duration_ = 9

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play114182044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_1 = 2

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_1 then
				local var_180_2 = (arg_177_1.time_ - var_180_0) / var_180_1
				local var_180_3 = Color.New(0, 0, 0)

				var_180_3.a = Mathf.Lerp(0, 1, var_180_2)
				arg_177_1.mask_.color = var_180_3
			end

			if arg_177_1.time_ >= var_180_0 + var_180_1 and arg_177_1.time_ < var_180_0 + var_180_1 + arg_180_0 then
				local var_180_4 = Color.New(0, 0, 0)

				var_180_4.a = 1
				arg_177_1.mask_.color = var_180_4
			end

			local var_180_5 = 2

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_6 = 2

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_6 then
				local var_180_7 = (arg_177_1.time_ - var_180_5) / var_180_6
				local var_180_8 = Color.New(0, 0, 0)

				var_180_8.a = Mathf.Lerp(1, 0, var_180_7)
				arg_177_1.mask_.color = var_180_8
			end

			if arg_177_1.time_ >= var_180_5 + var_180_6 and arg_177_1.time_ < var_180_5 + var_180_6 + arg_180_0 then
				local var_180_9 = Color.New(0, 0, 0)
				local var_180_10 = 0

				arg_177_1.mask_.enabled = false
				var_180_9.a = var_180_10
				arg_177_1.mask_.color = var_180_9
			end

			local var_180_11 = arg_177_1.actors_["1042ui_story"].transform
			local var_180_12 = 1.966

			if var_180_12 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 then
				arg_177_1.var_.moveOldPos1042ui_story = var_180_11.localPosition
			end

			local var_180_13 = 0.001

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_13 then
				local var_180_14 = (arg_177_1.time_ - var_180_12) / var_180_13
				local var_180_15 = Vector3.New(0, 100, 0)

				var_180_11.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1042ui_story, var_180_15, var_180_14)

				local var_180_16 = manager.ui.mainCamera.transform.position - var_180_11.position

				var_180_11.forward = Vector3.New(var_180_16.x, var_180_16.y, var_180_16.z)

				local var_180_17 = var_180_11.localEulerAngles

				var_180_17.z = 0
				var_180_17.x = 0
				var_180_11.localEulerAngles = var_180_17
			end

			if arg_177_1.time_ >= var_180_12 + var_180_13 and arg_177_1.time_ < var_180_12 + var_180_13 + arg_180_0 then
				var_180_11.localPosition = Vector3.New(0, 100, 0)

				local var_180_18 = manager.ui.mainCamera.transform.position - var_180_11.position

				var_180_11.forward = Vector3.New(var_180_18.x, var_180_18.y, var_180_18.z)

				local var_180_19 = var_180_11.localEulerAngles

				var_180_19.z = 0
				var_180_19.x = 0
				var_180_11.localEulerAngles = var_180_19
			end

			local var_180_20 = arg_177_1.actors_["1067ui_story"].transform
			local var_180_21 = 1.966

			if var_180_21 < arg_177_1.time_ and arg_177_1.time_ <= var_180_21 + arg_180_0 then
				arg_177_1.var_.moveOldPos1067ui_story = var_180_20.localPosition
			end

			local var_180_22 = 0.001

			if var_180_21 <= arg_177_1.time_ and arg_177_1.time_ < var_180_21 + var_180_22 then
				local var_180_23 = (arg_177_1.time_ - var_180_21) / var_180_22
				local var_180_24 = Vector3.New(0, 100, 0)

				var_180_20.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1067ui_story, var_180_24, var_180_23)

				local var_180_25 = manager.ui.mainCamera.transform.position - var_180_20.position

				var_180_20.forward = Vector3.New(var_180_25.x, var_180_25.y, var_180_25.z)

				local var_180_26 = var_180_20.localEulerAngles

				var_180_26.z = 0
				var_180_26.x = 0
				var_180_20.localEulerAngles = var_180_26
			end

			if arg_177_1.time_ >= var_180_21 + var_180_22 and arg_177_1.time_ < var_180_21 + var_180_22 + arg_180_0 then
				var_180_20.localPosition = Vector3.New(0, 100, 0)

				local var_180_27 = manager.ui.mainCamera.transform.position - var_180_20.position

				var_180_20.forward = Vector3.New(var_180_27.x, var_180_27.y, var_180_27.z)

				local var_180_28 = var_180_20.localEulerAngles

				var_180_28.z = 0
				var_180_28.x = 0
				var_180_20.localEulerAngles = var_180_28
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_29 = 4
			local var_180_30 = 0.725

			if var_180_29 < arg_177_1.time_ and arg_177_1.time_ <= var_180_29 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_31 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_31:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_177_1.dialogCg_.alpha = arg_181_0
				end))
				var_180_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_32 = arg_177_1:GetWordFromCfg(114182043)
				local var_180_33 = arg_177_1:FormatText(var_180_32.content)

				arg_177_1.text_.text = var_180_33

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_34 = 29
				local var_180_35 = utf8.len(var_180_33)
				local var_180_36 = var_180_34 <= 0 and var_180_30 or var_180_30 * (var_180_35 / var_180_34)

				if var_180_36 > 0 and var_180_30 < var_180_36 then
					arg_177_1.talkMaxDuration = var_180_36
					var_180_29 = var_180_29 + 0.3

					if var_180_36 + var_180_29 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_36 + var_180_29
					end
				end

				arg_177_1.text_.text = var_180_33
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_37 = var_180_29 + 0.3
			local var_180_38 = math.max(var_180_30, arg_177_1.talkMaxDuration)

			if var_180_37 <= arg_177_1.time_ and arg_177_1.time_ < var_180_37 + var_180_38 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_37) / var_180_38

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_37 + var_180_38 and arg_177_1.time_ < var_180_37 + var_180_38 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play114182044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 114182044
		arg_183_1.duration_ = 2.83

		local var_183_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.833,
			en = 2.366
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
				arg_183_0:Play114182045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = "6046_story"

			if arg_183_1.actors_[var_186_0] == nil then
				local var_186_1 = Asset.Load("Char/" .. "6046_story")

				if not isNil(var_186_1) then
					local var_186_2 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_183_1.stage_.transform)

					var_186_2.name = var_186_0
					var_186_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_183_1.actors_[var_186_0] = var_186_2

					local var_186_3 = var_186_2:GetComponentInChildren(typeof(CharacterEffect))

					var_186_3.enabled = true

					local var_186_4 = GameObjectTools.GetOrAddComponent(var_186_2, typeof(DynamicBoneHelper))

					if var_186_4 then
						var_186_4:EnableDynamicBone(false)
					end

					arg_183_1:ShowWeapon(var_186_3.transform, false)

					arg_183_1.var_[var_186_0 .. "Animator"] = var_186_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_183_1.var_[var_186_0 .. "Animator"].applyRootMotion = true
					arg_183_1.var_[var_186_0 .. "LipSync"] = var_186_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_186_5 = arg_183_1.actors_["6046_story"].transform
			local var_186_6 = 0

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.var_.moveOldPos6046_story = var_186_5.localPosition

				local var_186_7 = GameObjectTools.GetOrAddComponent(var_186_5.gameObject, typeof(DynamicBoneHelper))

				if var_186_7 then
					var_186_7:EnableDynamicBone(false)
				end
			end

			local var_186_8 = 0.001

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_8 then
				local var_186_9 = (arg_183_1.time_ - var_186_6) / var_186_8
				local var_186_10 = Vector3.New(-0.7, -0.5, -6.3)

				var_186_5.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos6046_story, var_186_10, var_186_9)

				local var_186_11 = manager.ui.mainCamera.transform.position - var_186_5.position

				var_186_5.forward = Vector3.New(var_186_11.x, var_186_11.y, var_186_11.z)

				local var_186_12 = var_186_5.localEulerAngles

				var_186_12.z = 0
				var_186_12.x = 0
				var_186_5.localEulerAngles = var_186_12
			end

			if arg_183_1.time_ >= var_186_6 + var_186_8 and arg_183_1.time_ < var_186_6 + var_186_8 + arg_186_0 then
				var_186_5.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_186_13 = manager.ui.mainCamera.transform.position - var_186_5.position

				var_186_5.forward = Vector3.New(var_186_13.x, var_186_13.y, var_186_13.z)

				local var_186_14 = var_186_5.localEulerAngles

				var_186_14.z = 0
				var_186_14.x = 0
				var_186_5.localEulerAngles = var_186_14

				local var_186_15 = GameObjectTools.GetOrAddComponent(var_186_5.gameObject, typeof(DynamicBoneHelper))

				if var_186_15 then
					var_186_15:EnableDynamicBone(true)
				end
			end

			local var_186_16 = 0

			if var_186_16 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 then
				arg_183_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_186_17 = 0

			if var_186_17 < arg_183_1.time_ and arg_183_1.time_ <= var_186_17 + arg_186_0 then
				arg_183_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_186_18 = arg_183_1.actors_["6046_story"]
			local var_186_19 = 0

			if var_186_19 < arg_183_1.time_ and arg_183_1.time_ <= var_186_19 + arg_186_0 and not isNil(var_186_18) and arg_183_1.var_.characterEffect6046_story == nil then
				arg_183_1.var_.characterEffect6046_story = var_186_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_20 = 0.2

			if var_186_19 <= arg_183_1.time_ and arg_183_1.time_ < var_186_19 + var_186_20 and not isNil(var_186_18) then
				local var_186_21 = (arg_183_1.time_ - var_186_19) / var_186_20

				if arg_183_1.var_.characterEffect6046_story and not isNil(var_186_18) then
					arg_183_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_19 + var_186_20 and arg_183_1.time_ < var_186_19 + var_186_20 + arg_186_0 and not isNil(var_186_18) and arg_183_1.var_.characterEffect6046_story then
				arg_183_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_186_22 = "6045_story"

			if arg_183_1.actors_[var_186_22] == nil then
				local var_186_23 = Asset.Load("Char/" .. "6045_story")

				if not isNil(var_186_23) then
					local var_186_24 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_183_1.stage_.transform)

					var_186_24.name = var_186_22
					var_186_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_183_1.actors_[var_186_22] = var_186_24

					local var_186_25 = var_186_24:GetComponentInChildren(typeof(CharacterEffect))

					var_186_25.enabled = true

					local var_186_26 = GameObjectTools.GetOrAddComponent(var_186_24, typeof(DynamicBoneHelper))

					if var_186_26 then
						var_186_26:EnableDynamicBone(false)
					end

					arg_183_1:ShowWeapon(var_186_25.transform, false)

					arg_183_1.var_[var_186_22 .. "Animator"] = var_186_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_183_1.var_[var_186_22 .. "Animator"].applyRootMotion = true
					arg_183_1.var_[var_186_22 .. "LipSync"] = var_186_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_186_27 = arg_183_1.actors_["6045_story"].transform
			local var_186_28 = 0

			if var_186_28 < arg_183_1.time_ and arg_183_1.time_ <= var_186_28 + arg_186_0 then
				arg_183_1.var_.moveOldPos6045_story = var_186_27.localPosition

				local var_186_29 = GameObjectTools.GetOrAddComponent(var_186_27.gameObject, typeof(DynamicBoneHelper))

				if var_186_29 then
					var_186_29:EnableDynamicBone(false)
				end
			end

			local var_186_30 = 0.001

			if var_186_28 <= arg_183_1.time_ and arg_183_1.time_ < var_186_28 + var_186_30 then
				local var_186_31 = (arg_183_1.time_ - var_186_28) / var_186_30
				local var_186_32 = Vector3.New(0.7, -0.5, -6.3)

				var_186_27.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos6045_story, var_186_32, var_186_31)

				local var_186_33 = manager.ui.mainCamera.transform.position - var_186_27.position

				var_186_27.forward = Vector3.New(var_186_33.x, var_186_33.y, var_186_33.z)

				local var_186_34 = var_186_27.localEulerAngles

				var_186_34.z = 0
				var_186_34.x = 0
				var_186_27.localEulerAngles = var_186_34
			end

			if arg_183_1.time_ >= var_186_28 + var_186_30 and arg_183_1.time_ < var_186_28 + var_186_30 + arg_186_0 then
				var_186_27.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_186_35 = manager.ui.mainCamera.transform.position - var_186_27.position

				var_186_27.forward = Vector3.New(var_186_35.x, var_186_35.y, var_186_35.z)

				local var_186_36 = var_186_27.localEulerAngles

				var_186_36.z = 0
				var_186_36.x = 0
				var_186_27.localEulerAngles = var_186_36

				local var_186_37 = GameObjectTools.GetOrAddComponent(var_186_27.gameObject, typeof(DynamicBoneHelper))

				if var_186_37 then
					var_186_37:EnableDynamicBone(true)
				end
			end

			local var_186_38 = 0

			if var_186_38 < arg_183_1.time_ and arg_183_1.time_ <= var_186_38 + arg_186_0 then
				arg_183_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_186_39 = 0
			local var_186_40 = 0.175

			if var_186_39 < arg_183_1.time_ and arg_183_1.time_ <= var_186_39 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_41 = arg_183_1:FormatText(StoryNameCfg[214].name)

				arg_183_1.leftNameTxt_.text = var_186_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_42 = arg_183_1:GetWordFromCfg(114182044)
				local var_186_43 = arg_183_1:FormatText(var_186_42.content)

				arg_183_1.text_.text = var_186_43

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_44 = 7
				local var_186_45 = utf8.len(var_186_43)
				local var_186_46 = var_186_44 <= 0 and var_186_40 or var_186_40 * (var_186_45 / var_186_44)

				if var_186_46 > 0 and var_186_40 < var_186_46 then
					arg_183_1.talkMaxDuration = var_186_46

					if var_186_46 + var_186_39 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_46 + var_186_39
					end
				end

				arg_183_1.text_.text = var_186_43
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182044", "story_v_out_114182.awb") ~= 0 then
					local var_186_47 = manager.audio:GetVoiceLength("story_v_out_114182", "114182044", "story_v_out_114182.awb") / 1000

					if var_186_47 + var_186_39 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_47 + var_186_39
					end

					if var_186_42.prefab_name ~= "" and arg_183_1.actors_[var_186_42.prefab_name] ~= nil then
						local var_186_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_42.prefab_name].transform, "story_v_out_114182", "114182044", "story_v_out_114182.awb")

						arg_183_1:RecordAudio("114182044", var_186_48)
						arg_183_1:RecordAudio("114182044", var_186_48)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_114182", "114182044", "story_v_out_114182.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_114182", "114182044", "story_v_out_114182.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_49 = math.max(var_186_40, arg_183_1.talkMaxDuration)

			if var_186_39 <= arg_183_1.time_ and arg_183_1.time_ < var_186_39 + var_186_49 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_39) / var_186_49

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_39 + var_186_49 and arg_183_1.time_ < var_186_39 + var_186_49 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play114182045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 114182045
		arg_187_1.duration_ = 3.1

		local var_187_0 = {
			ja = 3.1,
			ko = 2.6,
			zh = 2.566,
			en = 2.733
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
				arg_187_0:Play114182046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["6046_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect6046_story == nil then
				arg_187_1.var_.characterEffect6046_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.2

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect6046_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect6046_story.fillFlat = true
					arg_187_1.var_.characterEffect6046_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect6046_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect6046_story.fillFlat = true
				arg_187_1.var_.characterEffect6046_story.fillRatio = var_190_5
			end

			local var_190_6 = arg_187_1.actors_["6045_story"]
			local var_190_7 = 0

			if var_190_7 < arg_187_1.time_ and arg_187_1.time_ <= var_190_7 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect6045_story == nil then
				arg_187_1.var_.characterEffect6045_story = var_190_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_8 = 0.2

			if var_190_7 <= arg_187_1.time_ and arg_187_1.time_ < var_190_7 + var_190_8 and not isNil(var_190_6) then
				local var_190_9 = (arg_187_1.time_ - var_190_7) / var_190_8

				if arg_187_1.var_.characterEffect6045_story and not isNil(var_190_6) then
					local var_190_10 = Mathf.Lerp(0, 0.5, var_190_9)

					arg_187_1.var_.characterEffect6045_story.fillFlat = true
					arg_187_1.var_.characterEffect6045_story.fillRatio = var_190_10
				end
			end

			if arg_187_1.time_ >= var_190_7 + var_190_8 and arg_187_1.time_ < var_190_7 + var_190_8 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect6045_story then
				local var_190_11 = 0.5

				arg_187_1.var_.characterEffect6045_story.fillFlat = true
				arg_187_1.var_.characterEffect6045_story.fillRatio = var_190_11
			end

			local var_190_12 = 0
			local var_190_13 = 0.275

			if var_190_12 < arg_187_1.time_ and arg_187_1.time_ <= var_190_12 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_14 = arg_187_1:FormatText(StoryNameCfg[94].name)

				arg_187_1.leftNameTxt_.text = var_190_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_15 = arg_187_1:GetWordFromCfg(114182045)
				local var_190_16 = arg_187_1:FormatText(var_190_15.content)

				arg_187_1.text_.text = var_190_16

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_17 = 11
				local var_190_18 = utf8.len(var_190_16)
				local var_190_19 = var_190_17 <= 0 and var_190_13 or var_190_13 * (var_190_18 / var_190_17)

				if var_190_19 > 0 and var_190_13 < var_190_19 then
					arg_187_1.talkMaxDuration = var_190_19

					if var_190_19 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_19 + var_190_12
					end
				end

				arg_187_1.text_.text = var_190_16
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182045", "story_v_out_114182.awb") ~= 0 then
					local var_190_20 = manager.audio:GetVoiceLength("story_v_out_114182", "114182045", "story_v_out_114182.awb") / 1000

					if var_190_20 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_20 + var_190_12
					end

					if var_190_15.prefab_name ~= "" and arg_187_1.actors_[var_190_15.prefab_name] ~= nil then
						local var_190_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_15.prefab_name].transform, "story_v_out_114182", "114182045", "story_v_out_114182.awb")

						arg_187_1:RecordAudio("114182045", var_190_21)
						arg_187_1:RecordAudio("114182045", var_190_21)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_114182", "114182045", "story_v_out_114182.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_114182", "114182045", "story_v_out_114182.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_22 = math.max(var_190_13, arg_187_1.talkMaxDuration)

			if var_190_12 <= arg_187_1.time_ and arg_187_1.time_ < var_190_12 + var_190_22 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_12) / var_190_22

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_12 + var_190_22 and arg_187_1.time_ < var_190_12 + var_190_22 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play114182046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 114182046
		arg_191_1.duration_ = 6.3

		local var_191_0 = {
			ja = 6.3,
			ko = 4.633,
			zh = 6.133,
			en = 5.9
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
				arg_191_0:Play114182047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["6045_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect6045_story == nil then
				arg_191_1.var_.characterEffect6045_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.2

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect6045_story and not isNil(var_194_0) then
					arg_191_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect6045_story then
				arg_191_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_194_4 = 0

			if var_194_4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_194_5 = 0
			local var_194_6 = 0.4

			if var_194_5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_7 = arg_191_1:FormatText(StoryNameCfg[215].name)

				arg_191_1.leftNameTxt_.text = var_194_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(114182046)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 16
				local var_194_11 = utf8.len(var_194_9)
				local var_194_12 = var_194_10 <= 0 and var_194_6 or var_194_6 * (var_194_11 / var_194_10)

				if var_194_12 > 0 and var_194_6 < var_194_12 then
					arg_191_1.talkMaxDuration = var_194_12

					if var_194_12 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182046", "story_v_out_114182.awb") ~= 0 then
					local var_194_13 = manager.audio:GetVoiceLength("story_v_out_114182", "114182046", "story_v_out_114182.awb") / 1000

					if var_194_13 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_5
					end

					if var_194_8.prefab_name ~= "" and arg_191_1.actors_[var_194_8.prefab_name] ~= nil then
						local var_194_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_8.prefab_name].transform, "story_v_out_114182", "114182046", "story_v_out_114182.awb")

						arg_191_1:RecordAudio("114182046", var_194_14)
						arg_191_1:RecordAudio("114182046", var_194_14)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_114182", "114182046", "story_v_out_114182.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_114182", "114182046", "story_v_out_114182.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_15 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_15 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_15

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_15 and arg_191_1.time_ < var_194_5 + var_194_15 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play114182047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 114182047
		arg_195_1.duration_ = 5.73

		local var_195_0 = {
			ja = 3.933,
			ko = 5.733,
			zh = 3.933,
			en = 4.3
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
				arg_195_0:Play114182048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["6045_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect6045_story == nil then
				arg_195_1.var_.characterEffect6045_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.2

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect6045_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect6045_story.fillFlat = true
					arg_195_1.var_.characterEffect6045_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect6045_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect6045_story.fillFlat = true
				arg_195_1.var_.characterEffect6045_story.fillRatio = var_198_5
			end

			local var_198_6 = 0
			local var_198_7 = 0.525

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_8 = arg_195_1:FormatText(StoryNameCfg[94].name)

				arg_195_1.leftNameTxt_.text = var_198_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_7")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_9 = arg_195_1:GetWordFromCfg(114182047)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182047", "story_v_out_114182.awb") ~= 0 then
					local var_198_14 = manager.audio:GetVoiceLength("story_v_out_114182", "114182047", "story_v_out_114182.awb") / 1000

					if var_198_14 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_14 + var_198_6
					end

					if var_198_9.prefab_name ~= "" and arg_195_1.actors_[var_198_9.prefab_name] ~= nil then
						local var_198_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_9.prefab_name].transform, "story_v_out_114182", "114182047", "story_v_out_114182.awb")

						arg_195_1:RecordAudio("114182047", var_198_15)
						arg_195_1:RecordAudio("114182047", var_198_15)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_114182", "114182047", "story_v_out_114182.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_114182", "114182047", "story_v_out_114182.awb")
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
	Play114182048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 114182048
		arg_199_1.duration_ = 8.67

		local var_199_0 = {
			ja = 8.666,
			ko = 4.4,
			zh = 6.166,
			en = 5.033
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
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play114182049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["6045_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos6045_story = var_202_0.localPosition

				local var_202_2 = GameObjectTools.GetOrAddComponent(var_202_0.gameObject, typeof(DynamicBoneHelper))

				if var_202_2 then
					var_202_2:EnableDynamicBone(false)
				end
			end

			local var_202_3 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_3 then
				local var_202_4 = (arg_199_1.time_ - var_202_1) / var_202_3
				local var_202_5 = Vector3.New(0, 100, 0)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos6045_story, var_202_5, var_202_4)

				local var_202_6 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_6.x, var_202_6.y, var_202_6.z)

				local var_202_7 = var_202_0.localEulerAngles

				var_202_7.z = 0
				var_202_7.x = 0
				var_202_0.localEulerAngles = var_202_7
			end

			if arg_199_1.time_ >= var_202_1 + var_202_3 and arg_199_1.time_ < var_202_1 + var_202_3 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, 100, 0)

				local var_202_8 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_8.x, var_202_8.y, var_202_8.z)

				local var_202_9 = var_202_0.localEulerAngles

				var_202_9.z = 0
				var_202_9.x = 0
				var_202_0.localEulerAngles = var_202_9

				local var_202_10 = GameObjectTools.GetOrAddComponent(var_202_0.gameObject, typeof(DynamicBoneHelper))

				if var_202_10 then
					var_202_10:EnableDynamicBone(true)
				end
			end

			local var_202_11 = arg_199_1.actors_["6046_story"].transform
			local var_202_12 = 0

			if var_202_12 < arg_199_1.time_ and arg_199_1.time_ <= var_202_12 + arg_202_0 then
				arg_199_1.var_.moveOldPos6046_story = var_202_11.localPosition

				local var_202_13 = GameObjectTools.GetOrAddComponent(var_202_11.gameObject, typeof(DynamicBoneHelper))

				if var_202_13 then
					var_202_13:EnableDynamicBone(false)
				end
			end

			local var_202_14 = 0.001

			if var_202_12 <= arg_199_1.time_ and arg_199_1.time_ < var_202_12 + var_202_14 then
				local var_202_15 = (arg_199_1.time_ - var_202_12) / var_202_14
				local var_202_16 = Vector3.New(0, 100, 0)

				var_202_11.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos6046_story, var_202_16, var_202_15)

				local var_202_17 = manager.ui.mainCamera.transform.position - var_202_11.position

				var_202_11.forward = Vector3.New(var_202_17.x, var_202_17.y, var_202_17.z)

				local var_202_18 = var_202_11.localEulerAngles

				var_202_18.z = 0
				var_202_18.x = 0
				var_202_11.localEulerAngles = var_202_18
			end

			if arg_199_1.time_ >= var_202_12 + var_202_14 and arg_199_1.time_ < var_202_12 + var_202_14 + arg_202_0 then
				var_202_11.localPosition = Vector3.New(0, 100, 0)

				local var_202_19 = manager.ui.mainCamera.transform.position - var_202_11.position

				var_202_11.forward = Vector3.New(var_202_19.x, var_202_19.y, var_202_19.z)

				local var_202_20 = var_202_11.localEulerAngles

				var_202_20.z = 0
				var_202_20.x = 0
				var_202_11.localEulerAngles = var_202_20

				local var_202_21 = GameObjectTools.GetOrAddComponent(var_202_11.gameObject, typeof(DynamicBoneHelper))

				if var_202_21 then
					var_202_21:EnableDynamicBone(true)
				end
			end

			local var_202_22 = 0
			local var_202_23 = 0.55

			if var_202_22 < arg_199_1.time_ and arg_199_1.time_ <= var_202_22 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_24 = arg_199_1:FormatText(StoryNameCfg[208].name)

				arg_199_1.leftNameTxt_.text = var_202_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_25 = arg_199_1:GetWordFromCfg(114182048)
				local var_202_26 = arg_199_1:FormatText(var_202_25.content)

				arg_199_1.text_.text = var_202_26

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_27 = 22
				local var_202_28 = utf8.len(var_202_26)
				local var_202_29 = var_202_27 <= 0 and var_202_23 or var_202_23 * (var_202_28 / var_202_27)

				if var_202_29 > 0 and var_202_23 < var_202_29 then
					arg_199_1.talkMaxDuration = var_202_29

					if var_202_29 + var_202_22 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_29 + var_202_22
					end
				end

				arg_199_1.text_.text = var_202_26
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182048", "story_v_out_114182.awb") ~= 0 then
					local var_202_30 = manager.audio:GetVoiceLength("story_v_out_114182", "114182048", "story_v_out_114182.awb") / 1000

					if var_202_30 + var_202_22 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_30 + var_202_22
					end

					if var_202_25.prefab_name ~= "" and arg_199_1.actors_[var_202_25.prefab_name] ~= nil then
						local var_202_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_25.prefab_name].transform, "story_v_out_114182", "114182048", "story_v_out_114182.awb")

						arg_199_1:RecordAudio("114182048", var_202_31)
						arg_199_1:RecordAudio("114182048", var_202_31)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_114182", "114182048", "story_v_out_114182.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_114182", "114182048", "story_v_out_114182.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_32 = math.max(var_202_23, arg_199_1.talkMaxDuration)

			if var_202_22 <= arg_199_1.time_ and arg_199_1.time_ < var_202_22 + var_202_32 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_22) / var_202_32

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_22 + var_202_32 and arg_199_1.time_ < var_202_22 + var_202_32 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play114182049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 114182049
		arg_203_1.duration_ = 8.07

		local var_203_0 = {
			ja = 8.066,
			ko = 5.1,
			zh = 3.9,
			en = 4.666
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play114182050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.45

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[212].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:GetWordFromCfg(114182049)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 18
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182049", "story_v_out_114182.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_114182", "114182049", "story_v_out_114182.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_114182", "114182049", "story_v_out_114182.awb")

						arg_203_1:RecordAudio("114182049", var_206_9)
						arg_203_1:RecordAudio("114182049", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_114182", "114182049", "story_v_out_114182.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_114182", "114182049", "story_v_out_114182.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play114182050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 114182050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play114182051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.95

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(114182050)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 38
				local var_210_5 = utf8.len(var_210_3)
				local var_210_6 = var_210_4 <= 0 and var_210_1 or var_210_1 * (var_210_5 / var_210_4)

				if var_210_6 > 0 and var_210_1 < var_210_6 then
					arg_207_1.talkMaxDuration = var_210_6

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_7 and arg_207_1.time_ < var_210_0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play114182051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 114182051
		arg_211_1.duration_ = 8.37

		local var_211_0 = {
			ja = 5.766,
			ko = 8.366,
			zh = 6.8,
			en = 8.266
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play114182052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1042ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1042ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, -1.06, -6.2)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1042ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = 0

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 then
				arg_211_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_214_11 = arg_211_1.actors_["1042ui_story"]
			local var_214_12 = 0

			if var_214_12 < arg_211_1.time_ and arg_211_1.time_ <= var_214_12 + arg_214_0 and not isNil(var_214_11) and arg_211_1.var_.characterEffect1042ui_story == nil then
				arg_211_1.var_.characterEffect1042ui_story = var_214_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_13 = 0.2

			if var_214_12 <= arg_211_1.time_ and arg_211_1.time_ < var_214_12 + var_214_13 and not isNil(var_214_11) then
				local var_214_14 = (arg_211_1.time_ - var_214_12) / var_214_13

				if arg_211_1.var_.characterEffect1042ui_story and not isNil(var_214_11) then
					arg_211_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_12 + var_214_13 and arg_211_1.time_ < var_214_12 + var_214_13 + arg_214_0 and not isNil(var_214_11) and arg_211_1.var_.characterEffect1042ui_story then
				arg_211_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_214_15 = 0
			local var_214_16 = 0.75

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_17 = arg_211_1:FormatText(StoryNameCfg[205].name)

				arg_211_1.leftNameTxt_.text = var_214_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_18 = arg_211_1:GetWordFromCfg(114182051)
				local var_214_19 = arg_211_1:FormatText(var_214_18.content)

				arg_211_1.text_.text = var_214_19

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_20 = 30
				local var_214_21 = utf8.len(var_214_19)
				local var_214_22 = var_214_20 <= 0 and var_214_16 or var_214_16 * (var_214_21 / var_214_20)

				if var_214_22 > 0 and var_214_16 < var_214_22 then
					arg_211_1.talkMaxDuration = var_214_22

					if var_214_22 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_22 + var_214_15
					end
				end

				arg_211_1.text_.text = var_214_19
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182051", "story_v_out_114182.awb") ~= 0 then
					local var_214_23 = manager.audio:GetVoiceLength("story_v_out_114182", "114182051", "story_v_out_114182.awb") / 1000

					if var_214_23 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_23 + var_214_15
					end

					if var_214_18.prefab_name ~= "" and arg_211_1.actors_[var_214_18.prefab_name] ~= nil then
						local var_214_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_18.prefab_name].transform, "story_v_out_114182", "114182051", "story_v_out_114182.awb")

						arg_211_1:RecordAudio("114182051", var_214_24)
						arg_211_1:RecordAudio("114182051", var_214_24)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_114182", "114182051", "story_v_out_114182.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_114182", "114182051", "story_v_out_114182.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_25 = math.max(var_214_16, arg_211_1.talkMaxDuration)

			if var_214_15 <= arg_211_1.time_ and arg_211_1.time_ < var_214_15 + var_214_25 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_15) / var_214_25

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_15 + var_214_25 and arg_211_1.time_ < var_214_15 + var_214_25 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play114182052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 114182052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play114182053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_1 = 2

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_1 then
				local var_218_2 = (arg_215_1.time_ - var_218_0) / var_218_1
				local var_218_3 = Color.New(0, 0, 0)

				var_218_3.a = Mathf.Lerp(0, 1, var_218_2)
				arg_215_1.mask_.color = var_218_3
			end

			if arg_215_1.time_ >= var_218_0 + var_218_1 and arg_215_1.time_ < var_218_0 + var_218_1 + arg_218_0 then
				local var_218_4 = Color.New(0, 0, 0)

				var_218_4.a = 1
				arg_215_1.mask_.color = var_218_4
			end

			local var_218_5 = 2

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_6 = 1.966

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_6 then
				local var_218_7 = (arg_215_1.time_ - var_218_5) / var_218_6
				local var_218_8 = Color.New(0, 0, 0)

				var_218_8.a = Mathf.Lerp(1, 0, var_218_7)
				arg_215_1.mask_.color = var_218_8
			end

			if arg_215_1.time_ >= var_218_5 + var_218_6 and arg_215_1.time_ < var_218_5 + var_218_6 + arg_218_0 then
				local var_218_9 = Color.New(0, 0, 0)
				local var_218_10 = 0

				arg_215_1.mask_.enabled = false
				var_218_9.a = var_218_10
				arg_215_1.mask_.color = var_218_9
			end

			local var_218_11 = arg_215_1.actors_["1042ui_story"].transform
			local var_218_12 = 1.966

			if var_218_12 < arg_215_1.time_ and arg_215_1.time_ <= var_218_12 + arg_218_0 then
				arg_215_1.var_.moveOldPos1042ui_story = var_218_11.localPosition
			end

			local var_218_13 = 0.001

			if var_218_12 <= arg_215_1.time_ and arg_215_1.time_ < var_218_12 + var_218_13 then
				local var_218_14 = (arg_215_1.time_ - var_218_12) / var_218_13
				local var_218_15 = Vector3.New(0, 100, 0)

				var_218_11.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1042ui_story, var_218_15, var_218_14)

				local var_218_16 = manager.ui.mainCamera.transform.position - var_218_11.position

				var_218_11.forward = Vector3.New(var_218_16.x, var_218_16.y, var_218_16.z)

				local var_218_17 = var_218_11.localEulerAngles

				var_218_17.z = 0
				var_218_17.x = 0
				var_218_11.localEulerAngles = var_218_17
			end

			if arg_215_1.time_ >= var_218_12 + var_218_13 and arg_215_1.time_ < var_218_12 + var_218_13 + arg_218_0 then
				var_218_11.localPosition = Vector3.New(0, 100, 0)

				local var_218_18 = manager.ui.mainCamera.transform.position - var_218_11.position

				var_218_11.forward = Vector3.New(var_218_18.x, var_218_18.y, var_218_18.z)

				local var_218_19 = var_218_11.localEulerAngles

				var_218_19.z = 0
				var_218_19.x = 0
				var_218_11.localEulerAngles = var_218_19
			end

			local var_218_20 = "STblack"

			if arg_215_1.bgs_[var_218_20] == nil then
				local var_218_21 = Object.Instantiate(arg_215_1.paintGo_)

				var_218_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_218_20)
				var_218_21.name = var_218_20
				var_218_21.transform.parent = arg_215_1.stage_.transform
				var_218_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.bgs_[var_218_20] = var_218_21
			end

			local var_218_22 = 2

			if var_218_22 < arg_215_1.time_ and arg_215_1.time_ <= var_218_22 + arg_218_0 then
				local var_218_23 = manager.ui.mainCamera.transform.localPosition
				local var_218_24 = Vector3.New(0, 0, 10) + Vector3.New(var_218_23.x, var_218_23.y, 0)
				local var_218_25 = arg_215_1.bgs_.STblack

				var_218_25.transform.localPosition = var_218_24
				var_218_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_26 = var_218_25:GetComponent("SpriteRenderer")

				if var_218_26 and var_218_26.sprite then
					local var_218_27 = (var_218_25.transform.localPosition - var_218_23).z
					local var_218_28 = manager.ui.mainCameraCom_
					local var_218_29 = 2 * var_218_27 * Mathf.Tan(var_218_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_218_30 = var_218_29 * var_218_28.aspect
					local var_218_31 = var_218_26.sprite.bounds.size.x
					local var_218_32 = var_218_26.sprite.bounds.size.y
					local var_218_33 = var_218_30 / var_218_31
					local var_218_34 = var_218_29 / var_218_32
					local var_218_35 = var_218_34 < var_218_33 and var_218_33 or var_218_34

					var_218_25.transform.localScale = Vector3.New(var_218_35, var_218_35, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "STblack" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_36 = 2

			if var_218_36 < arg_215_1.time_ and arg_215_1.time_ <= var_218_36 + arg_218_0 then
				arg_215_1.fswbg_:SetActive(true)
				arg_215_1.dialog_:SetActive(false)

				arg_215_1.fswtw_.percent = 0

				local var_218_37 = arg_215_1:GetWordFromCfg(114182052)
				local var_218_38 = arg_215_1:FormatText(var_218_37.content)

				arg_215_1.fswt_.text = var_218_38

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.fswt_)

				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_215_1.fswtw_:SetDirty()

				arg_215_1.typewritterCharCountI18N = 0

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_39 = 2.01666666666667

			if var_218_39 < arg_215_1.time_ and arg_215_1.time_ <= var_218_39 + arg_218_0 then
				arg_215_1.var_.oldValueTypewriter = arg_215_1.fswtw_.percent

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_40 = 21
			local var_218_41 = 1.4
			local var_218_42 = arg_215_1:GetWordFromCfg(114182052)
			local var_218_43 = arg_215_1:FormatText(var_218_42.content)
			local var_218_44, var_218_45 = arg_215_1:GetPercentByPara(var_218_43, 1)

			if var_218_39 < arg_215_1.time_ and arg_215_1.time_ <= var_218_39 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				local var_218_46 = var_218_40 <= 0 and var_218_41 or var_218_41 * ((var_218_45 - arg_215_1.typewritterCharCountI18N) / var_218_40)

				if var_218_46 > 0 and var_218_41 < var_218_46 then
					arg_215_1.talkMaxDuration = var_218_46

					if var_218_46 + var_218_39 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_46 + var_218_39
					end
				end
			end

			local var_218_47 = 1.4
			local var_218_48 = math.max(var_218_47, arg_215_1.talkMaxDuration)

			if var_218_39 <= arg_215_1.time_ and arg_215_1.time_ < var_218_39 + var_218_48 then
				local var_218_49 = (arg_215_1.time_ - var_218_39) / var_218_48

				arg_215_1.fswtw_.percent = Mathf.Lerp(arg_215_1.var_.oldValueTypewriter, var_218_44, var_218_49)
				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_215_1.fswtw_:SetDirty()
			end

			if arg_215_1.time_ >= var_218_39 + var_218_48 and arg_215_1.time_ < var_218_39 + var_218_48 + arg_218_0 then
				arg_215_1.fswtw_.percent = var_218_44

				arg_215_1.fswtw_:SetDirty()
				arg_215_1:ShowNextGo(true)

				arg_215_1.typewritterCharCountI18N = var_218_45
			end

			local var_218_50 = 2

			if var_218_50 < arg_215_1.time_ and arg_215_1.time_ <= var_218_50 + arg_218_0 then
				local var_218_51 = arg_215_1.fswbg_.transform:Find("textbox/adapt/content") or arg_215_1.fswbg_.transform:Find("textbox/content")
				local var_218_52 = arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_218_53 = var_218_51:GetComponent("Text")
				local var_218_54 = var_218_51:GetComponent("RectTransform")

				var_218_53.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_218_54.offsetMin = Vector2.New(0, 0)
				var_218_54.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play114182053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 114182053
		arg_219_1.duration_ = 16.67

		local var_219_0 = {
			ja = 16.6,
			ko = 16.666,
			zh = 15.3,
			en = 16.666
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
				arg_219_0:Play114182054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 3.8

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_222_1 = arg_219_1.actors_["1067ui_story"].transform
			local var_222_2 = 3.8

			if var_222_2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.var_.moveOldPos1067ui_story = var_222_1.localPosition
			end

			local var_222_3 = 0.001

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_3 then
				local var_222_4 = (arg_219_1.time_ - var_222_2) / var_222_3
				local var_222_5 = Vector3.New(-0.7, -1.06, -6.2)

				var_222_1.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1067ui_story, var_222_5, var_222_4)

				local var_222_6 = manager.ui.mainCamera.transform.position - var_222_1.position

				var_222_1.forward = Vector3.New(var_222_6.x, var_222_6.y, var_222_6.z)

				local var_222_7 = var_222_1.localEulerAngles

				var_222_7.z = 0
				var_222_7.x = 0
				var_222_1.localEulerAngles = var_222_7
			end

			if arg_219_1.time_ >= var_222_2 + var_222_3 and arg_219_1.time_ < var_222_2 + var_222_3 + arg_222_0 then
				var_222_1.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_222_8 = manager.ui.mainCamera.transform.position - var_222_1.position

				var_222_1.forward = Vector3.New(var_222_8.x, var_222_8.y, var_222_8.z)

				local var_222_9 = var_222_1.localEulerAngles

				var_222_9.z = 0
				var_222_9.x = 0
				var_222_1.localEulerAngles = var_222_9
			end

			local var_222_10 = arg_219_1.actors_["1067ui_story"]
			local var_222_11 = 3.8

			if var_222_11 < arg_219_1.time_ and arg_219_1.time_ <= var_222_11 + arg_222_0 and not isNil(var_222_10) and arg_219_1.var_.characterEffect1067ui_story == nil then
				arg_219_1.var_.characterEffect1067ui_story = var_222_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_12 = 0.2

			if var_222_11 <= arg_219_1.time_ and arg_219_1.time_ < var_222_11 + var_222_12 and not isNil(var_222_10) then
				local var_222_13 = (arg_219_1.time_ - var_222_11) / var_222_12

				if arg_219_1.var_.characterEffect1067ui_story and not isNil(var_222_10) then
					arg_219_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_11 + var_222_12 and arg_219_1.time_ < var_222_11 + var_222_12 + arg_222_0 and not isNil(var_222_10) and arg_219_1.var_.characterEffect1067ui_story then
				arg_219_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_222_14 = 3.8

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_222_15 = 0

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_16 = 2

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_16 then
				local var_222_17 = (arg_219_1.time_ - var_222_15) / var_222_16
				local var_222_18 = Color.New(0, 0, 0)

				var_222_18.a = Mathf.Lerp(0, 1, var_222_17)
				arg_219_1.mask_.color = var_222_18
			end

			if arg_219_1.time_ >= var_222_15 + var_222_16 and arg_219_1.time_ < var_222_15 + var_222_16 + arg_222_0 then
				local var_222_19 = Color.New(0, 0, 0)

				var_222_19.a = 1
				arg_219_1.mask_.color = var_222_19
			end

			local var_222_20 = 2

			if var_222_20 < arg_219_1.time_ and arg_219_1.time_ <= var_222_20 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_21 = 1.966

			if var_222_20 <= arg_219_1.time_ and arg_219_1.time_ < var_222_20 + var_222_21 then
				local var_222_22 = (arg_219_1.time_ - var_222_20) / var_222_21
				local var_222_23 = Color.New(0, 0, 0)

				var_222_23.a = Mathf.Lerp(1, 0, var_222_22)
				arg_219_1.mask_.color = var_222_23
			end

			if arg_219_1.time_ >= var_222_20 + var_222_21 and arg_219_1.time_ < var_222_20 + var_222_21 + arg_222_0 then
				local var_222_24 = Color.New(0, 0, 0)
				local var_222_25 = 0

				arg_219_1.mask_.enabled = false
				var_222_24.a = var_222_25
				arg_219_1.mask_.color = var_222_24
			end

			local var_222_26 = 2

			if var_222_26 < arg_219_1.time_ and arg_219_1.time_ <= var_222_26 + arg_222_0 then
				local var_222_27 = manager.ui.mainCamera.transform.localPosition
				local var_222_28 = Vector3.New(0, 0, 10) + Vector3.New(var_222_27.x, var_222_27.y, 0)
				local var_222_29 = arg_219_1.bgs_.F04

				var_222_29.transform.localPosition = var_222_28
				var_222_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_30 = var_222_29:GetComponent("SpriteRenderer")

				if var_222_30 and var_222_30.sprite then
					local var_222_31 = (var_222_29.transform.localPosition - var_222_27).z
					local var_222_32 = manager.ui.mainCameraCom_
					local var_222_33 = 2 * var_222_31 * Mathf.Tan(var_222_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_222_34 = var_222_33 * var_222_32.aspect
					local var_222_35 = var_222_30.sprite.bounds.size.x
					local var_222_36 = var_222_30.sprite.bounds.size.y
					local var_222_37 = var_222_34 / var_222_35
					local var_222_38 = var_222_33 / var_222_36
					local var_222_39 = var_222_38 < var_222_37 and var_222_37 or var_222_38

					var_222_29.transform.localScale = Vector3.New(var_222_39, var_222_39, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "F04" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_40 = 0

			if var_222_40 < arg_219_1.time_ and arg_219_1.time_ <= var_222_40 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(false)
				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_219_1:ShowNextGo(false)
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_41 = 4
			local var_222_42 = 1.275

			if var_222_41 < arg_219_1.time_ and arg_219_1.time_ <= var_222_41 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_43 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_43:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_44 = arg_219_1:FormatText(StoryNameCfg[206].name)

				arg_219_1.leftNameTxt_.text = var_222_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_45 = arg_219_1:GetWordFromCfg(114182053)
				local var_222_46 = arg_219_1:FormatText(var_222_45.content)

				arg_219_1.text_.text = var_222_46

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_47 = 51
				local var_222_48 = utf8.len(var_222_46)
				local var_222_49 = var_222_47 <= 0 and var_222_42 or var_222_42 * (var_222_48 / var_222_47)

				if var_222_49 > 0 and var_222_42 < var_222_49 then
					arg_219_1.talkMaxDuration = var_222_49
					var_222_41 = var_222_41 + 0.3

					if var_222_49 + var_222_41 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_49 + var_222_41
					end
				end

				arg_219_1.text_.text = var_222_46
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182053", "story_v_out_114182.awb") ~= 0 then
					local var_222_50 = manager.audio:GetVoiceLength("story_v_out_114182", "114182053", "story_v_out_114182.awb") / 1000

					if var_222_50 + var_222_41 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_50 + var_222_41
					end

					if var_222_45.prefab_name ~= "" and arg_219_1.actors_[var_222_45.prefab_name] ~= nil then
						local var_222_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_45.prefab_name].transform, "story_v_out_114182", "114182053", "story_v_out_114182.awb")

						arg_219_1:RecordAudio("114182053", var_222_51)
						arg_219_1:RecordAudio("114182053", var_222_51)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_114182", "114182053", "story_v_out_114182.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_114182", "114182053", "story_v_out_114182.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_52 = var_222_41 + 0.3
			local var_222_53 = math.max(var_222_42, arg_219_1.talkMaxDuration)

			if var_222_52 <= arg_219_1.time_ and arg_219_1.time_ < var_222_52 + var_222_53 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_52) / var_222_53

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_52 + var_222_53 and arg_219_1.time_ < var_222_52 + var_222_53 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play114182054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 114182054
		arg_225_1.duration_ = 9.93

		local var_225_0 = {
			ja = 8.7,
			ko = 9.933,
			zh = 7.866,
			en = 9.5
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play114182055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1184ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1184ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0.7, -0.97, -6)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1184ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = 0

			if var_228_9 < arg_225_1.time_ and arg_225_1.time_ <= var_228_9 + arg_228_0 then
				arg_225_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 then
				arg_225_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_228_11 = arg_225_1.actors_["1184ui_story"]
			local var_228_12 = 0

			if var_228_12 < arg_225_1.time_ and arg_225_1.time_ <= var_228_12 + arg_228_0 and not isNil(var_228_11) and arg_225_1.var_.characterEffect1184ui_story == nil then
				arg_225_1.var_.characterEffect1184ui_story = var_228_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_13 = 0.2

			if var_228_12 <= arg_225_1.time_ and arg_225_1.time_ < var_228_12 + var_228_13 and not isNil(var_228_11) then
				local var_228_14 = (arg_225_1.time_ - var_228_12) / var_228_13

				if arg_225_1.var_.characterEffect1184ui_story and not isNil(var_228_11) then
					arg_225_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_12 + var_228_13 and arg_225_1.time_ < var_228_12 + var_228_13 + arg_228_0 and not isNil(var_228_11) and arg_225_1.var_.characterEffect1184ui_story then
				arg_225_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_228_15 = arg_225_1.actors_["1067ui_story"]
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.characterEffect1067ui_story == nil then
				arg_225_1.var_.characterEffect1067ui_story = var_228_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_17 = 0.2

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 and not isNil(var_228_15) then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17

				if arg_225_1.var_.characterEffect1067ui_story and not isNil(var_228_15) then
					local var_228_19 = Mathf.Lerp(0, 0.5, var_228_18)

					arg_225_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1067ui_story.fillRatio = var_228_19
				end
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.characterEffect1067ui_story then
				local var_228_20 = 0.5

				arg_225_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1067ui_story.fillRatio = var_228_20
			end

			local var_228_21 = 0
			local var_228_22 = 0.9

			if var_228_21 < arg_225_1.time_ and arg_225_1.time_ <= var_228_21 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_23 = arg_225_1:FormatText(StoryNameCfg[6].name)

				arg_225_1.leftNameTxt_.text = var_228_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_24 = arg_225_1:GetWordFromCfg(114182054)
				local var_228_25 = arg_225_1:FormatText(var_228_24.content)

				arg_225_1.text_.text = var_228_25

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_26 = 36
				local var_228_27 = utf8.len(var_228_25)
				local var_228_28 = var_228_26 <= 0 and var_228_22 or var_228_22 * (var_228_27 / var_228_26)

				if var_228_28 > 0 and var_228_22 < var_228_28 then
					arg_225_1.talkMaxDuration = var_228_28

					if var_228_28 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_28 + var_228_21
					end
				end

				arg_225_1.text_.text = var_228_25
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182054", "story_v_out_114182.awb") ~= 0 then
					local var_228_29 = manager.audio:GetVoiceLength("story_v_out_114182", "114182054", "story_v_out_114182.awb") / 1000

					if var_228_29 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_29 + var_228_21
					end

					if var_228_24.prefab_name ~= "" and arg_225_1.actors_[var_228_24.prefab_name] ~= nil then
						local var_228_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_24.prefab_name].transform, "story_v_out_114182", "114182054", "story_v_out_114182.awb")

						arg_225_1:RecordAudio("114182054", var_228_30)
						arg_225_1:RecordAudio("114182054", var_228_30)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_114182", "114182054", "story_v_out_114182.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_114182", "114182054", "story_v_out_114182.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_31 = math.max(var_228_22, arg_225_1.talkMaxDuration)

			if var_228_21 <= arg_225_1.time_ and arg_225_1.time_ < var_228_21 + var_228_31 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_21) / var_228_31

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_21 + var_228_31 and arg_225_1.time_ < var_228_21 + var_228_31 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play114182055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 114182055
		arg_229_1.duration_ = 7.33

		local var_229_0 = {
			ja = 7.333,
			ko = 6.3,
			zh = 6.3,
			en = 5.966
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play114182056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_232_1 = arg_229_1.actors_["1067ui_story"]
			local var_232_2 = 0

			if var_232_2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1067ui_story == nil then
				arg_229_1.var_.characterEffect1067ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_3 = 0.2

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_3 and not isNil(var_232_1) then
				local var_232_4 = (arg_229_1.time_ - var_232_2) / var_232_3

				if arg_229_1.var_.characterEffect1067ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_2 + var_232_3 and arg_229_1.time_ < var_232_2 + var_232_3 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1067ui_story then
				arg_229_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_232_5 = 0

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_2")
			end

			local var_232_6 = arg_229_1.actors_["1184ui_story"]
			local var_232_7 = 0

			if var_232_7 < arg_229_1.time_ and arg_229_1.time_ <= var_232_7 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect1184ui_story == nil then
				arg_229_1.var_.characterEffect1184ui_story = var_232_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_8 = 0.2

			if var_232_7 <= arg_229_1.time_ and arg_229_1.time_ < var_232_7 + var_232_8 and not isNil(var_232_6) then
				local var_232_9 = (arg_229_1.time_ - var_232_7) / var_232_8

				if arg_229_1.var_.characterEffect1184ui_story and not isNil(var_232_6) then
					local var_232_10 = Mathf.Lerp(0, 0.5, var_232_9)

					arg_229_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1184ui_story.fillRatio = var_232_10
				end
			end

			if arg_229_1.time_ >= var_232_7 + var_232_8 and arg_229_1.time_ < var_232_7 + var_232_8 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect1184ui_story then
				local var_232_11 = 0.5

				arg_229_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1184ui_story.fillRatio = var_232_11
			end

			local var_232_12 = 0
			local var_232_13 = 0.65

			if var_232_12 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_14 = arg_229_1:FormatText(StoryNameCfg[206].name)

				arg_229_1.leftNameTxt_.text = var_232_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_15 = arg_229_1:GetWordFromCfg(114182055)
				local var_232_16 = arg_229_1:FormatText(var_232_15.content)

				arg_229_1.text_.text = var_232_16

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_17 = 26
				local var_232_18 = utf8.len(var_232_16)
				local var_232_19 = var_232_17 <= 0 and var_232_13 or var_232_13 * (var_232_18 / var_232_17)

				if var_232_19 > 0 and var_232_13 < var_232_19 then
					arg_229_1.talkMaxDuration = var_232_19

					if var_232_19 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_19 + var_232_12
					end
				end

				arg_229_1.text_.text = var_232_16
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182055", "story_v_out_114182.awb") ~= 0 then
					local var_232_20 = manager.audio:GetVoiceLength("story_v_out_114182", "114182055", "story_v_out_114182.awb") / 1000

					if var_232_20 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_20 + var_232_12
					end

					if var_232_15.prefab_name ~= "" and arg_229_1.actors_[var_232_15.prefab_name] ~= nil then
						local var_232_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_15.prefab_name].transform, "story_v_out_114182", "114182055", "story_v_out_114182.awb")

						arg_229_1:RecordAudio("114182055", var_232_21)
						arg_229_1:RecordAudio("114182055", var_232_21)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_114182", "114182055", "story_v_out_114182.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_114182", "114182055", "story_v_out_114182.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_22 = math.max(var_232_13, arg_229_1.talkMaxDuration)

			if var_232_12 <= arg_229_1.time_ and arg_229_1.time_ < var_232_12 + var_232_22 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_12) / var_232_22

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_12 + var_232_22 and arg_229_1.time_ < var_232_12 + var_232_22 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play114182056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 114182056
		arg_233_1.duration_ = 9.8

		local var_233_0 = {
			ja = 9.8,
			ko = 9.533,
			zh = 7.866,
			en = 6.666
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play114182057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1067ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1067ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(0, 100, 0)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1067ui_story, var_236_4, var_236_3)

				local var_236_5 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_5.x, var_236_5.y, var_236_5.z)

				local var_236_6 = var_236_0.localEulerAngles

				var_236_6.z = 0
				var_236_6.x = 0
				var_236_0.localEulerAngles = var_236_6
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, 100, 0)

				local var_236_7 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_7.x, var_236_7.y, var_236_7.z)

				local var_236_8 = var_236_0.localEulerAngles

				var_236_8.z = 0
				var_236_8.x = 0
				var_236_0.localEulerAngles = var_236_8
			end

			local var_236_9 = arg_233_1.actors_["1184ui_story"].transform
			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 then
				arg_233_1.var_.moveOldPos1184ui_story = var_236_9.localPosition
			end

			local var_236_11 = 0.001

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_11 then
				local var_236_12 = (arg_233_1.time_ - var_236_10) / var_236_11
				local var_236_13 = Vector3.New(0, 100, 0)

				var_236_9.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1184ui_story, var_236_13, var_236_12)

				local var_236_14 = manager.ui.mainCamera.transform.position - var_236_9.position

				var_236_9.forward = Vector3.New(var_236_14.x, var_236_14.y, var_236_14.z)

				local var_236_15 = var_236_9.localEulerAngles

				var_236_15.z = 0
				var_236_15.x = 0
				var_236_9.localEulerAngles = var_236_15
			end

			if arg_233_1.time_ >= var_236_10 + var_236_11 and arg_233_1.time_ < var_236_10 + var_236_11 + arg_236_0 then
				var_236_9.localPosition = Vector3.New(0, 100, 0)

				local var_236_16 = manager.ui.mainCamera.transform.position - var_236_9.position

				var_236_9.forward = Vector3.New(var_236_16.x, var_236_16.y, var_236_16.z)

				local var_236_17 = var_236_9.localEulerAngles

				var_236_17.z = 0
				var_236_17.x = 0
				var_236_9.localEulerAngles = var_236_17
			end

			local var_236_18 = arg_233_1.actors_["1042ui_story"].transform
			local var_236_19 = 0

			if var_236_19 < arg_233_1.time_ and arg_233_1.time_ <= var_236_19 + arg_236_0 then
				arg_233_1.var_.moveOldPos1042ui_story = var_236_18.localPosition
			end

			local var_236_20 = 0.001

			if var_236_19 <= arg_233_1.time_ and arg_233_1.time_ < var_236_19 + var_236_20 then
				local var_236_21 = (arg_233_1.time_ - var_236_19) / var_236_20
				local var_236_22 = Vector3.New(-0.7, -1.06, -6.2)

				var_236_18.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1042ui_story, var_236_22, var_236_21)

				local var_236_23 = manager.ui.mainCamera.transform.position - var_236_18.position

				var_236_18.forward = Vector3.New(var_236_23.x, var_236_23.y, var_236_23.z)

				local var_236_24 = var_236_18.localEulerAngles

				var_236_24.z = 0
				var_236_24.x = 0
				var_236_18.localEulerAngles = var_236_24
			end

			if arg_233_1.time_ >= var_236_19 + var_236_20 and arg_233_1.time_ < var_236_19 + var_236_20 + arg_236_0 then
				var_236_18.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_236_25 = manager.ui.mainCamera.transform.position - var_236_18.position

				var_236_18.forward = Vector3.New(var_236_25.x, var_236_25.y, var_236_25.z)

				local var_236_26 = var_236_18.localEulerAngles

				var_236_26.z = 0
				var_236_26.x = 0
				var_236_18.localEulerAngles = var_236_26
			end

			local var_236_27 = 0

			if var_236_27 < arg_233_1.time_ and arg_233_1.time_ <= var_236_27 + arg_236_0 then
				arg_233_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_236_28 = 0

			if var_236_28 < arg_233_1.time_ and arg_233_1.time_ <= var_236_28 + arg_236_0 then
				arg_233_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_236_29 = arg_233_1.actors_["1042ui_story"]
			local var_236_30 = 0

			if var_236_30 < arg_233_1.time_ and arg_233_1.time_ <= var_236_30 + arg_236_0 and not isNil(var_236_29) and arg_233_1.var_.characterEffect1042ui_story == nil then
				arg_233_1.var_.characterEffect1042ui_story = var_236_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_31 = 0.2

			if var_236_30 <= arg_233_1.time_ and arg_233_1.time_ < var_236_30 + var_236_31 and not isNil(var_236_29) then
				local var_236_32 = (arg_233_1.time_ - var_236_30) / var_236_31

				if arg_233_1.var_.characterEffect1042ui_story and not isNil(var_236_29) then
					arg_233_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_30 + var_236_31 and arg_233_1.time_ < var_236_30 + var_236_31 + arg_236_0 and not isNil(var_236_29) and arg_233_1.var_.characterEffect1042ui_story then
				arg_233_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_236_33 = 0
			local var_236_34 = 0.925

			if var_236_33 < arg_233_1.time_ and arg_233_1.time_ <= var_236_33 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_35 = arg_233_1:FormatText(StoryNameCfg[205].name)

				arg_233_1.leftNameTxt_.text = var_236_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_36 = arg_233_1:GetWordFromCfg(114182056)
				local var_236_37 = arg_233_1:FormatText(var_236_36.content)

				arg_233_1.text_.text = var_236_37

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_38 = 37
				local var_236_39 = utf8.len(var_236_37)
				local var_236_40 = var_236_38 <= 0 and var_236_34 or var_236_34 * (var_236_39 / var_236_38)

				if var_236_40 > 0 and var_236_34 < var_236_40 then
					arg_233_1.talkMaxDuration = var_236_40

					if var_236_40 + var_236_33 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_40 + var_236_33
					end
				end

				arg_233_1.text_.text = var_236_37
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182056", "story_v_out_114182.awb") ~= 0 then
					local var_236_41 = manager.audio:GetVoiceLength("story_v_out_114182", "114182056", "story_v_out_114182.awb") / 1000

					if var_236_41 + var_236_33 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_41 + var_236_33
					end

					if var_236_36.prefab_name ~= "" and arg_233_1.actors_[var_236_36.prefab_name] ~= nil then
						local var_236_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_36.prefab_name].transform, "story_v_out_114182", "114182056", "story_v_out_114182.awb")

						arg_233_1:RecordAudio("114182056", var_236_42)
						arg_233_1:RecordAudio("114182056", var_236_42)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_114182", "114182056", "story_v_out_114182.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_114182", "114182056", "story_v_out_114182.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_43 = math.max(var_236_34, arg_233_1.talkMaxDuration)

			if var_236_33 <= arg_233_1.time_ and arg_233_1.time_ < var_236_33 + var_236_43 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_33) / var_236_43

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_33 + var_236_43 and arg_233_1.time_ < var_236_33 + var_236_43 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
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

		arg_233_1:InitPlayNodeList()
	end,
	Play114182057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 114182057
		arg_237_1.duration_ = 10.3

		local var_237_0 = {
			ja = 10.3,
			ko = 6.2,
			zh = 6.3,
			en = 5.9
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
				arg_237_0:Play114182058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1041ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1041ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(0.7, -1.11, -5.9)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1041ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = 0

			if var_240_9 < arg_237_1.time_ and arg_237_1.time_ <= var_240_9 + arg_240_0 then
				arg_237_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_240_10 = arg_237_1.actors_["1041ui_story"]
			local var_240_11 = 0

			if var_240_11 < arg_237_1.time_ and arg_237_1.time_ <= var_240_11 + arg_240_0 and not isNil(var_240_10) and arg_237_1.var_.characterEffect1041ui_story == nil then
				arg_237_1.var_.characterEffect1041ui_story = var_240_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_12 = 0.2

			if var_240_11 <= arg_237_1.time_ and arg_237_1.time_ < var_240_11 + var_240_12 and not isNil(var_240_10) then
				local var_240_13 = (arg_237_1.time_ - var_240_11) / var_240_12

				if arg_237_1.var_.characterEffect1041ui_story and not isNil(var_240_10) then
					arg_237_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_11 + var_240_12 and arg_237_1.time_ < var_240_11 + var_240_12 + arg_240_0 and not isNil(var_240_10) and arg_237_1.var_.characterEffect1041ui_story then
				arg_237_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_240_14 = 0

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_240_15 = arg_237_1.actors_["1042ui_story"]
			local var_240_16 = 0

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.characterEffect1042ui_story == nil then
				arg_237_1.var_.characterEffect1042ui_story = var_240_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_17 = 0.2

			if var_240_16 <= arg_237_1.time_ and arg_237_1.time_ < var_240_16 + var_240_17 and not isNil(var_240_15) then
				local var_240_18 = (arg_237_1.time_ - var_240_16) / var_240_17

				if arg_237_1.var_.characterEffect1042ui_story and not isNil(var_240_15) then
					local var_240_19 = Mathf.Lerp(0, 0.5, var_240_18)

					arg_237_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1042ui_story.fillRatio = var_240_19
				end
			end

			if arg_237_1.time_ >= var_240_16 + var_240_17 and arg_237_1.time_ < var_240_16 + var_240_17 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.characterEffect1042ui_story then
				local var_240_20 = 0.5

				arg_237_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1042ui_story.fillRatio = var_240_20
			end

			local var_240_21 = 0
			local var_240_22 = 0.8

			if var_240_21 < arg_237_1.time_ and arg_237_1.time_ <= var_240_21 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_23 = arg_237_1:FormatText(StoryNameCfg[208].name)

				arg_237_1.leftNameTxt_.text = var_240_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_24 = arg_237_1:GetWordFromCfg(114182057)
				local var_240_25 = arg_237_1:FormatText(var_240_24.content)

				arg_237_1.text_.text = var_240_25

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_26 = 32
				local var_240_27 = utf8.len(var_240_25)
				local var_240_28 = var_240_26 <= 0 and var_240_22 or var_240_22 * (var_240_27 / var_240_26)

				if var_240_28 > 0 and var_240_22 < var_240_28 then
					arg_237_1.talkMaxDuration = var_240_28

					if var_240_28 + var_240_21 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_28 + var_240_21
					end
				end

				arg_237_1.text_.text = var_240_25
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182057", "story_v_out_114182.awb") ~= 0 then
					local var_240_29 = manager.audio:GetVoiceLength("story_v_out_114182", "114182057", "story_v_out_114182.awb") / 1000

					if var_240_29 + var_240_21 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_29 + var_240_21
					end

					if var_240_24.prefab_name ~= "" and arg_237_1.actors_[var_240_24.prefab_name] ~= nil then
						local var_240_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_24.prefab_name].transform, "story_v_out_114182", "114182057", "story_v_out_114182.awb")

						arg_237_1:RecordAudio("114182057", var_240_30)
						arg_237_1:RecordAudio("114182057", var_240_30)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_114182", "114182057", "story_v_out_114182.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_114182", "114182057", "story_v_out_114182.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_31 = math.max(var_240_22, arg_237_1.talkMaxDuration)

			if var_240_21 <= arg_237_1.time_ and arg_237_1.time_ < var_240_21 + var_240_31 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_21) / var_240_31

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_21 + var_240_31 and arg_237_1.time_ < var_240_21 + var_240_31 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play114182058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 114182058
		arg_241_1.duration_ = 4.1

		local var_241_0 = {
			ja = 4.1,
			ko = 2.733,
			zh = 3.6,
			en = 3.8
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play114182059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_244_1 = arg_241_1.actors_["1042ui_story"]
			local var_244_2 = 0

			if var_244_2 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1042ui_story == nil then
				arg_241_1.var_.characterEffect1042ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_3 = 0.2

			if var_244_2 <= arg_241_1.time_ and arg_241_1.time_ < var_244_2 + var_244_3 and not isNil(var_244_1) then
				local var_244_4 = (arg_241_1.time_ - var_244_2) / var_244_3

				if arg_241_1.var_.characterEffect1042ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_2 + var_244_3 and arg_241_1.time_ < var_244_2 + var_244_3 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1042ui_story then
				arg_241_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_244_6 = arg_241_1.actors_["1041ui_story"]
			local var_244_7 = 0

			if var_244_7 < arg_241_1.time_ and arg_241_1.time_ <= var_244_7 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect1041ui_story == nil then
				arg_241_1.var_.characterEffect1041ui_story = var_244_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_8 = 0.2

			if var_244_7 <= arg_241_1.time_ and arg_241_1.time_ < var_244_7 + var_244_8 and not isNil(var_244_6) then
				local var_244_9 = (arg_241_1.time_ - var_244_7) / var_244_8

				if arg_241_1.var_.characterEffect1041ui_story and not isNil(var_244_6) then
					local var_244_10 = Mathf.Lerp(0, 0.5, var_244_9)

					arg_241_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1041ui_story.fillRatio = var_244_10
				end
			end

			if arg_241_1.time_ >= var_244_7 + var_244_8 and arg_241_1.time_ < var_244_7 + var_244_8 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect1041ui_story then
				local var_244_11 = 0.5

				arg_241_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1041ui_story.fillRatio = var_244_11
			end

			local var_244_12 = 0
			local var_244_13 = 0.325

			if var_244_12 < arg_241_1.time_ and arg_241_1.time_ <= var_244_12 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_14 = arg_241_1:FormatText(StoryNameCfg[205].name)

				arg_241_1.leftNameTxt_.text = var_244_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_15 = arg_241_1:GetWordFromCfg(114182058)
				local var_244_16 = arg_241_1:FormatText(var_244_15.content)

				arg_241_1.text_.text = var_244_16

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_17 = 13
				local var_244_18 = utf8.len(var_244_16)
				local var_244_19 = var_244_17 <= 0 and var_244_13 or var_244_13 * (var_244_18 / var_244_17)

				if var_244_19 > 0 and var_244_13 < var_244_19 then
					arg_241_1.talkMaxDuration = var_244_19

					if var_244_19 + var_244_12 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_19 + var_244_12
					end
				end

				arg_241_1.text_.text = var_244_16
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182058", "story_v_out_114182.awb") ~= 0 then
					local var_244_20 = manager.audio:GetVoiceLength("story_v_out_114182", "114182058", "story_v_out_114182.awb") / 1000

					if var_244_20 + var_244_12 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_20 + var_244_12
					end

					if var_244_15.prefab_name ~= "" and arg_241_1.actors_[var_244_15.prefab_name] ~= nil then
						local var_244_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_15.prefab_name].transform, "story_v_out_114182", "114182058", "story_v_out_114182.awb")

						arg_241_1:RecordAudio("114182058", var_244_21)
						arg_241_1:RecordAudio("114182058", var_244_21)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_114182", "114182058", "story_v_out_114182.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_114182", "114182058", "story_v_out_114182.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_22 = math.max(var_244_13, arg_241_1.talkMaxDuration)

			if var_244_12 <= arg_241_1.time_ and arg_241_1.time_ < var_244_12 + var_244_22 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_12) / var_244_22

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_12 + var_244_22 and arg_241_1.time_ < var_244_12 + var_244_22 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play114182059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 114182059
		arg_245_1.duration_ = 22.83

		local var_245_0 = {
			ja = 18.6,
			ko = 15,
			zh = 15.366,
			en = 22.833
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
				arg_245_0:Play114182060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			local var_248_2 = 0
			local var_248_3 = 1.625

			if var_248_2 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_4 = arg_245_1:FormatText(StoryNameCfg[205].name)

				arg_245_1.leftNameTxt_.text = var_248_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_5 = arg_245_1:GetWordFromCfg(114182059)
				local var_248_6 = arg_245_1:FormatText(var_248_5.content)

				arg_245_1.text_.text = var_248_6

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 65
				local var_248_8 = utf8.len(var_248_6)
				local var_248_9 = var_248_7 <= 0 and var_248_3 or var_248_3 * (var_248_8 / var_248_7)

				if var_248_9 > 0 and var_248_3 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_6
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182059", "story_v_out_114182.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182059", "story_v_out_114182.awb") / 1000

					if var_248_10 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_2
					end

					if var_248_5.prefab_name ~= "" and arg_245_1.actors_[var_248_5.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_5.prefab_name].transform, "story_v_out_114182", "114182059", "story_v_out_114182.awb")

						arg_245_1:RecordAudio("114182059", var_248_11)
						arg_245_1:RecordAudio("114182059", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_114182", "114182059", "story_v_out_114182.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_114182", "114182059", "story_v_out_114182.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_12 and arg_245_1.time_ < var_248_2 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play114182060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 114182060
		arg_249_1.duration_ = 2.53

		local var_249_0 = {
			ja = 2.533,
			ko = 1.733,
			zh = 1.566,
			en = 1.833
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
				arg_249_0:Play114182061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1042ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1042ui_story == nil then
				arg_249_1.var_.characterEffect1042ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.2

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1042ui_story and not isNil(var_252_0) then
					local var_252_4 = Mathf.Lerp(0, 0.5, var_252_3)

					arg_249_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1042ui_story.fillRatio = var_252_4
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1042ui_story then
				local var_252_5 = 0.5

				arg_249_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1042ui_story.fillRatio = var_252_5
			end

			local var_252_6 = 0
			local var_252_7 = 0.125

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_8 = arg_249_1:FormatText(StoryNameCfg[206].name)

				arg_249_1.leftNameTxt_.text = var_252_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_9 = arg_249_1:GetWordFromCfg(114182060)
				local var_252_10 = arg_249_1:FormatText(var_252_9.content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182060", "story_v_out_114182.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_114182", "114182060", "story_v_out_114182.awb") / 1000

					if var_252_14 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_6
					end

					if var_252_9.prefab_name ~= "" and arg_249_1.actors_[var_252_9.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_9.prefab_name].transform, "story_v_out_114182", "114182060", "story_v_out_114182.awb")

						arg_249_1:RecordAudio("114182060", var_252_15)
						arg_249_1:RecordAudio("114182060", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_114182", "114182060", "story_v_out_114182.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_114182", "114182060", "story_v_out_114182.awb")
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
	Play114182061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 114182061
		arg_253_1.duration_ = 2

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play114182062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_256_2 = arg_253_1.actors_["1042ui_story"]
			local var_256_3 = 0

			if var_256_3 < arg_253_1.time_ and arg_253_1.time_ <= var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.characterEffect1042ui_story == nil then
				arg_253_1.var_.characterEffect1042ui_story = var_256_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_4 = 0.2

			if var_256_3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_3 + var_256_4 and not isNil(var_256_2) then
				local var_256_5 = (arg_253_1.time_ - var_256_3) / var_256_4

				if arg_253_1.var_.characterEffect1042ui_story and not isNil(var_256_2) then
					arg_253_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_3 + var_256_4 and arg_253_1.time_ < var_256_3 + var_256_4 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.characterEffect1042ui_story then
				arg_253_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_256_6 = 0
			local var_256_7 = 0.075

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[205].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_9 = arg_253_1:GetWordFromCfg(114182061)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182061", "story_v_out_114182.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_114182", "114182061", "story_v_out_114182.awb") / 1000

					if var_256_14 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_6
					end

					if var_256_9.prefab_name ~= "" and arg_253_1.actors_[var_256_9.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_9.prefab_name].transform, "story_v_out_114182", "114182061", "story_v_out_114182.awb")

						arg_253_1:RecordAudio("114182061", var_256_15)
						arg_253_1:RecordAudio("114182061", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_114182", "114182061", "story_v_out_114182.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_114182", "114182061", "story_v_out_114182.awb")
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
	Play114182062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 114182062
		arg_257_1.duration_ = 11.07

		local var_257_0 = {
			ja = 8.9,
			ko = 11.066,
			zh = 10.733,
			en = 9.8
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
				arg_257_0:Play114182063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1042ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1042ui_story = var_260_0.localPosition
			end

			local var_260_2 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2
				local var_260_4 = Vector3.New(0, 100, 0)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1042ui_story, var_260_4, var_260_3)

				local var_260_5 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_5.x, var_260_5.y, var_260_5.z)

				local var_260_6 = var_260_0.localEulerAngles

				var_260_6.z = 0
				var_260_6.x = 0
				var_260_0.localEulerAngles = var_260_6
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, 100, 0)

				local var_260_7 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_7.x, var_260_7.y, var_260_7.z)

				local var_260_8 = var_260_0.localEulerAngles

				var_260_8.z = 0
				var_260_8.x = 0
				var_260_0.localEulerAngles = var_260_8
			end

			local var_260_9 = arg_257_1.actors_["1041ui_story"].transform
			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1.var_.moveOldPos1041ui_story = var_260_9.localPosition
			end

			local var_260_11 = 0.001

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_11 then
				local var_260_12 = (arg_257_1.time_ - var_260_10) / var_260_11
				local var_260_13 = Vector3.New(0, 100, 0)

				var_260_9.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1041ui_story, var_260_13, var_260_12)

				local var_260_14 = manager.ui.mainCamera.transform.position - var_260_9.position

				var_260_9.forward = Vector3.New(var_260_14.x, var_260_14.y, var_260_14.z)

				local var_260_15 = var_260_9.localEulerAngles

				var_260_15.z = 0
				var_260_15.x = 0
				var_260_9.localEulerAngles = var_260_15
			end

			if arg_257_1.time_ >= var_260_10 + var_260_11 and arg_257_1.time_ < var_260_10 + var_260_11 + arg_260_0 then
				var_260_9.localPosition = Vector3.New(0, 100, 0)

				local var_260_16 = manager.ui.mainCamera.transform.position - var_260_9.position

				var_260_9.forward = Vector3.New(var_260_16.x, var_260_16.y, var_260_16.z)

				local var_260_17 = var_260_9.localEulerAngles

				var_260_17.z = 0
				var_260_17.x = 0
				var_260_9.localEulerAngles = var_260_17
			end

			local var_260_18 = arg_257_1.actors_["1067ui_story"]
			local var_260_19 = 0

			if var_260_19 < arg_257_1.time_ and arg_257_1.time_ <= var_260_19 + arg_260_0 and not isNil(var_260_18) and arg_257_1.var_.characterEffect1067ui_story == nil then
				arg_257_1.var_.characterEffect1067ui_story = var_260_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_20 = 0.2

			if var_260_19 <= arg_257_1.time_ and arg_257_1.time_ < var_260_19 + var_260_20 and not isNil(var_260_18) then
				local var_260_21 = (arg_257_1.time_ - var_260_19) / var_260_20

				if arg_257_1.var_.characterEffect1067ui_story and not isNil(var_260_18) then
					arg_257_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_19 + var_260_20 and arg_257_1.time_ < var_260_19 + var_260_20 + arg_260_0 and not isNil(var_260_18) and arg_257_1.var_.characterEffect1067ui_story then
				arg_257_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_260_22 = 0

			if var_260_22 < arg_257_1.time_ and arg_257_1.time_ <= var_260_22 + arg_260_0 then
				arg_257_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_260_23 = 0

			if var_260_23 < arg_257_1.time_ and arg_257_1.time_ <= var_260_23 + arg_260_0 then
				arg_257_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_260_24 = arg_257_1.actors_["1067ui_story"].transform
			local var_260_25 = 0

			if var_260_25 < arg_257_1.time_ and arg_257_1.time_ <= var_260_25 + arg_260_0 then
				arg_257_1.var_.moveOldPos1067ui_story = var_260_24.localPosition
			end

			local var_260_26 = 0.001

			if var_260_25 <= arg_257_1.time_ and arg_257_1.time_ < var_260_25 + var_260_26 then
				local var_260_27 = (arg_257_1.time_ - var_260_25) / var_260_26
				local var_260_28 = Vector3.New(-0.7, -1.06, -6.2)

				var_260_24.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1067ui_story, var_260_28, var_260_27)

				local var_260_29 = manager.ui.mainCamera.transform.position - var_260_24.position

				var_260_24.forward = Vector3.New(var_260_29.x, var_260_29.y, var_260_29.z)

				local var_260_30 = var_260_24.localEulerAngles

				var_260_30.z = 0
				var_260_30.x = 0
				var_260_24.localEulerAngles = var_260_30
			end

			if arg_257_1.time_ >= var_260_25 + var_260_26 and arg_257_1.time_ < var_260_25 + var_260_26 + arg_260_0 then
				var_260_24.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_260_31 = manager.ui.mainCamera.transform.position - var_260_24.position

				var_260_24.forward = Vector3.New(var_260_31.x, var_260_31.y, var_260_31.z)

				local var_260_32 = var_260_24.localEulerAngles

				var_260_32.z = 0
				var_260_32.x = 0
				var_260_24.localEulerAngles = var_260_32
			end

			local var_260_33 = 0
			local var_260_34 = 1.2

			if var_260_33 < arg_257_1.time_ and arg_257_1.time_ <= var_260_33 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_35 = arg_257_1:FormatText(StoryNameCfg[206].name)

				arg_257_1.leftNameTxt_.text = var_260_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_36 = arg_257_1:GetWordFromCfg(114182062)
				local var_260_37 = arg_257_1:FormatText(var_260_36.content)

				arg_257_1.text_.text = var_260_37

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_38 = 48
				local var_260_39 = utf8.len(var_260_37)
				local var_260_40 = var_260_38 <= 0 and var_260_34 or var_260_34 * (var_260_39 / var_260_38)

				if var_260_40 > 0 and var_260_34 < var_260_40 then
					arg_257_1.talkMaxDuration = var_260_40

					if var_260_40 + var_260_33 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_40 + var_260_33
					end
				end

				arg_257_1.text_.text = var_260_37
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182062", "story_v_out_114182.awb") ~= 0 then
					local var_260_41 = manager.audio:GetVoiceLength("story_v_out_114182", "114182062", "story_v_out_114182.awb") / 1000

					if var_260_41 + var_260_33 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_41 + var_260_33
					end

					if var_260_36.prefab_name ~= "" and arg_257_1.actors_[var_260_36.prefab_name] ~= nil then
						local var_260_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_36.prefab_name].transform, "story_v_out_114182", "114182062", "story_v_out_114182.awb")

						arg_257_1:RecordAudio("114182062", var_260_42)
						arg_257_1:RecordAudio("114182062", var_260_42)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_114182", "114182062", "story_v_out_114182.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_114182", "114182062", "story_v_out_114182.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_43 = math.max(var_260_34, arg_257_1.talkMaxDuration)

			if var_260_33 <= arg_257_1.time_ and arg_257_1.time_ < var_260_33 + var_260_43 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_33) / var_260_43

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_33 + var_260_43 and arg_257_1.time_ < var_260_33 + var_260_43 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play114182063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 114182063
		arg_261_1.duration_ = 11.13

		local var_261_0 = {
			ja = 11.133,
			ko = 6.033,
			zh = 5.966,
			en = 7.266
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play114182064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = "1068ui_story"

			if arg_261_1.actors_[var_264_0] == nil then
				local var_264_1 = Asset.Load("Char/" .. "1068ui_story")

				if not isNil(var_264_1) then
					local var_264_2 = Object.Instantiate(Asset.Load("Char/" .. "1068ui_story"), arg_261_1.stage_.transform)

					var_264_2.name = var_264_0
					var_264_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_261_1.actors_[var_264_0] = var_264_2

					local var_264_3 = var_264_2:GetComponentInChildren(typeof(CharacterEffect))

					var_264_3.enabled = true

					local var_264_4 = GameObjectTools.GetOrAddComponent(var_264_2, typeof(DynamicBoneHelper))

					if var_264_4 then
						var_264_4:EnableDynamicBone(false)
					end

					arg_261_1:ShowWeapon(var_264_3.transform, false)

					arg_261_1.var_[var_264_0 .. "Animator"] = var_264_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_261_1.var_[var_264_0 .. "Animator"].applyRootMotion = true
					arg_261_1.var_[var_264_0 .. "LipSync"] = var_264_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_264_5 = arg_261_1.actors_["1068ui_story"]
			local var_264_6 = 0

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect1068ui_story == nil then
				arg_261_1.var_.characterEffect1068ui_story = var_264_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_7 = 0.2

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_7 and not isNil(var_264_5) then
				local var_264_8 = (arg_261_1.time_ - var_264_6) / var_264_7

				if arg_261_1.var_.characterEffect1068ui_story and not isNil(var_264_5) then
					arg_261_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_6 + var_264_7 and arg_261_1.time_ < var_264_6 + var_264_7 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect1068ui_story then
				arg_261_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_264_9 = 0

			if var_264_9 < arg_261_1.time_ and arg_261_1.time_ <= var_264_9 + arg_264_0 then
				arg_261_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_264_11 = arg_261_1.actors_["1068ui_story"].transform
			local var_264_12 = 0

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.var_.moveOldPos1068ui_story = var_264_11.localPosition
			end

			local var_264_13 = 0.001

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_13 then
				local var_264_14 = (arg_261_1.time_ - var_264_12) / var_264_13
				local var_264_15 = Vector3.New(0.7, -0.95, -5.88)

				var_264_11.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1068ui_story, var_264_15, var_264_14)

				local var_264_16 = manager.ui.mainCamera.transform.position - var_264_11.position

				var_264_11.forward = Vector3.New(var_264_16.x, var_264_16.y, var_264_16.z)

				local var_264_17 = var_264_11.localEulerAngles

				var_264_17.z = 0
				var_264_17.x = 0
				var_264_11.localEulerAngles = var_264_17
			end

			if arg_261_1.time_ >= var_264_12 + var_264_13 and arg_261_1.time_ < var_264_12 + var_264_13 + arg_264_0 then
				var_264_11.localPosition = Vector3.New(0.7, -0.95, -5.88)

				local var_264_18 = manager.ui.mainCamera.transform.position - var_264_11.position

				var_264_11.forward = Vector3.New(var_264_18.x, var_264_18.y, var_264_18.z)

				local var_264_19 = var_264_11.localEulerAngles

				var_264_19.z = 0
				var_264_19.x = 0
				var_264_11.localEulerAngles = var_264_19
			end

			local var_264_20 = arg_261_1.actors_["1067ui_story"]
			local var_264_21 = 0

			if var_264_21 < arg_261_1.time_ and arg_261_1.time_ <= var_264_21 + arg_264_0 and not isNil(var_264_20) and arg_261_1.var_.characterEffect1067ui_story == nil then
				arg_261_1.var_.characterEffect1067ui_story = var_264_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_22 = 0.2

			if var_264_21 <= arg_261_1.time_ and arg_261_1.time_ < var_264_21 + var_264_22 and not isNil(var_264_20) then
				local var_264_23 = (arg_261_1.time_ - var_264_21) / var_264_22

				if arg_261_1.var_.characterEffect1067ui_story and not isNil(var_264_20) then
					local var_264_24 = Mathf.Lerp(0, 0.5, var_264_23)

					arg_261_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1067ui_story.fillRatio = var_264_24
				end
			end

			if arg_261_1.time_ >= var_264_21 + var_264_22 and arg_261_1.time_ < var_264_21 + var_264_22 + arg_264_0 and not isNil(var_264_20) and arg_261_1.var_.characterEffect1067ui_story then
				local var_264_25 = 0.5

				arg_261_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1067ui_story.fillRatio = var_264_25
			end

			local var_264_26 = 0
			local var_264_27 = 0.7

			if var_264_26 < arg_261_1.time_ and arg_261_1.time_ <= var_264_26 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_28 = arg_261_1:FormatText(StoryNameCfg[218].name)

				arg_261_1.leftNameTxt_.text = var_264_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_29 = arg_261_1:GetWordFromCfg(114182063)
				local var_264_30 = arg_261_1:FormatText(var_264_29.content)

				arg_261_1.text_.text = var_264_30

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_31 = 28
				local var_264_32 = utf8.len(var_264_30)
				local var_264_33 = var_264_31 <= 0 and var_264_27 or var_264_27 * (var_264_32 / var_264_31)

				if var_264_33 > 0 and var_264_27 < var_264_33 then
					arg_261_1.talkMaxDuration = var_264_33

					if var_264_33 + var_264_26 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_33 + var_264_26
					end
				end

				arg_261_1.text_.text = var_264_30
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182063", "story_v_out_114182.awb") ~= 0 then
					local var_264_34 = manager.audio:GetVoiceLength("story_v_out_114182", "114182063", "story_v_out_114182.awb") / 1000

					if var_264_34 + var_264_26 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_34 + var_264_26
					end

					if var_264_29.prefab_name ~= "" and arg_261_1.actors_[var_264_29.prefab_name] ~= nil then
						local var_264_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_29.prefab_name].transform, "story_v_out_114182", "114182063", "story_v_out_114182.awb")

						arg_261_1:RecordAudio("114182063", var_264_35)
						arg_261_1:RecordAudio("114182063", var_264_35)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_114182", "114182063", "story_v_out_114182.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_114182", "114182063", "story_v_out_114182.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_36 = math.max(var_264_27, arg_261_1.talkMaxDuration)

			if var_264_26 <= arg_261_1.time_ and arg_261_1.time_ < var_264_26 + var_264_36 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_26) / var_264_36

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_26 + var_264_36 and arg_261_1.time_ < var_264_26 + var_264_36 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play114182064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 114182064
		arg_265_1.duration_ = 6.8

		local var_265_0 = {
			ja = 4.833,
			ko = 6.8,
			zh = 5.166,
			en = 5.5
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
				arg_265_0:Play114182065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_1")
			end

			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_268_2 = arg_265_1.actors_["1067ui_story"]
			local var_268_3 = 0

			if var_268_3 < arg_265_1.time_ and arg_265_1.time_ <= var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1067ui_story == nil then
				arg_265_1.var_.characterEffect1067ui_story = var_268_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_4 = 0.2

			if var_268_3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_3 + var_268_4 and not isNil(var_268_2) then
				local var_268_5 = (arg_265_1.time_ - var_268_3) / var_268_4

				if arg_265_1.var_.characterEffect1067ui_story and not isNil(var_268_2) then
					arg_265_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_3 + var_268_4 and arg_265_1.time_ < var_268_3 + var_268_4 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1067ui_story then
				arg_265_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_268_6 = arg_265_1.actors_["1068ui_story"]
			local var_268_7 = 0

			if var_268_7 < arg_265_1.time_ and arg_265_1.time_ <= var_268_7 + arg_268_0 and not isNil(var_268_6) and arg_265_1.var_.characterEffect1068ui_story == nil then
				arg_265_1.var_.characterEffect1068ui_story = var_268_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_8 = 0.2

			if var_268_7 <= arg_265_1.time_ and arg_265_1.time_ < var_268_7 + var_268_8 and not isNil(var_268_6) then
				local var_268_9 = (arg_265_1.time_ - var_268_7) / var_268_8

				if arg_265_1.var_.characterEffect1068ui_story and not isNil(var_268_6) then
					local var_268_10 = Mathf.Lerp(0, 0.5, var_268_9)

					arg_265_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1068ui_story.fillRatio = var_268_10
				end
			end

			if arg_265_1.time_ >= var_268_7 + var_268_8 and arg_265_1.time_ < var_268_7 + var_268_8 + arg_268_0 and not isNil(var_268_6) and arg_265_1.var_.characterEffect1068ui_story then
				local var_268_11 = 0.5

				arg_265_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1068ui_story.fillRatio = var_268_11
			end

			local var_268_12 = 0
			local var_268_13 = 0.425

			if var_268_12 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_14 = arg_265_1:FormatText(StoryNameCfg[206].name)

				arg_265_1.leftNameTxt_.text = var_268_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_15 = arg_265_1:GetWordFromCfg(114182064)
				local var_268_16 = arg_265_1:FormatText(var_268_15.content)

				arg_265_1.text_.text = var_268_16

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_17 = 17
				local var_268_18 = utf8.len(var_268_16)
				local var_268_19 = var_268_17 <= 0 and var_268_13 or var_268_13 * (var_268_18 / var_268_17)

				if var_268_19 > 0 and var_268_13 < var_268_19 then
					arg_265_1.talkMaxDuration = var_268_19

					if var_268_19 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_19 + var_268_12
					end
				end

				arg_265_1.text_.text = var_268_16
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182064", "story_v_out_114182.awb") ~= 0 then
					local var_268_20 = manager.audio:GetVoiceLength("story_v_out_114182", "114182064", "story_v_out_114182.awb") / 1000

					if var_268_20 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_20 + var_268_12
					end

					if var_268_15.prefab_name ~= "" and arg_265_1.actors_[var_268_15.prefab_name] ~= nil then
						local var_268_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_15.prefab_name].transform, "story_v_out_114182", "114182064", "story_v_out_114182.awb")

						arg_265_1:RecordAudio("114182064", var_268_21)
						arg_265_1:RecordAudio("114182064", var_268_21)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_114182", "114182064", "story_v_out_114182.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_114182", "114182064", "story_v_out_114182.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_22 = math.max(var_268_13, arg_265_1.talkMaxDuration)

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_22 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_12) / var_268_22

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_12 + var_268_22 and arg_265_1.time_ < var_268_12 + var_268_22 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play114182065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 114182065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play114182066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1067ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1067ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, 100, 0)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1067ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, 100, 0)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1068ui_story"].transform
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 then
				arg_269_1.var_.moveOldPos1068ui_story = var_272_9.localPosition
			end

			local var_272_11 = 0.001

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11
				local var_272_13 = Vector3.New(0, 100, 0)

				var_272_9.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1068ui_story, var_272_13, var_272_12)

				local var_272_14 = manager.ui.mainCamera.transform.position - var_272_9.position

				var_272_9.forward = Vector3.New(var_272_14.x, var_272_14.y, var_272_14.z)

				local var_272_15 = var_272_9.localEulerAngles

				var_272_15.z = 0
				var_272_15.x = 0
				var_272_9.localEulerAngles = var_272_15
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 then
				var_272_9.localPosition = Vector3.New(0, 100, 0)

				local var_272_16 = manager.ui.mainCamera.transform.position - var_272_9.position

				var_272_9.forward = Vector3.New(var_272_16.x, var_272_16.y, var_272_16.z)

				local var_272_17 = var_272_9.localEulerAngles

				var_272_17.z = 0
				var_272_17.x = 0
				var_272_9.localEulerAngles = var_272_17
			end

			local var_272_18 = 0
			local var_272_19 = 0.9

			if var_272_18 < arg_269_1.time_ and arg_269_1.time_ <= var_272_18 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_20 = arg_269_1:GetWordFromCfg(114182065)
				local var_272_21 = arg_269_1:FormatText(var_272_20.content)

				arg_269_1.text_.text = var_272_21

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_22 = 36
				local var_272_23 = utf8.len(var_272_21)
				local var_272_24 = var_272_22 <= 0 and var_272_19 or var_272_19 * (var_272_23 / var_272_22)

				if var_272_24 > 0 and var_272_19 < var_272_24 then
					arg_269_1.talkMaxDuration = var_272_24

					if var_272_24 + var_272_18 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_24 + var_272_18
					end
				end

				arg_269_1.text_.text = var_272_21
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_25 = math.max(var_272_19, arg_269_1.talkMaxDuration)

			if var_272_18 <= arg_269_1.time_ and arg_269_1.time_ < var_272_18 + var_272_25 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_18) / var_272_25

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_18 + var_272_25 and arg_269_1.time_ < var_272_18 + var_272_25 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_269_1:InitPlayNodeList()
	end,
	Play114182066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 114182066
		arg_273_1.duration_ = 13.3

		local var_273_0 = {
			ja = 13.3,
			ko = 8.9,
			zh = 8.9,
			en = 9.866
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play114182067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1042ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1042ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1042ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = 0

			if var_276_9 < arg_273_1.time_ and arg_273_1.time_ <= var_276_9 + arg_276_0 then
				arg_273_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 then
				arg_273_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_276_11 = arg_273_1.actors_["1042ui_story"]
			local var_276_12 = 0

			if var_276_12 < arg_273_1.time_ and arg_273_1.time_ <= var_276_12 + arg_276_0 and not isNil(var_276_11) and arg_273_1.var_.characterEffect1042ui_story == nil then
				arg_273_1.var_.characterEffect1042ui_story = var_276_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_13 = 0.2

			if var_276_12 <= arg_273_1.time_ and arg_273_1.time_ < var_276_12 + var_276_13 and not isNil(var_276_11) then
				local var_276_14 = (arg_273_1.time_ - var_276_12) / var_276_13

				if arg_273_1.var_.characterEffect1042ui_story and not isNil(var_276_11) then
					arg_273_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_12 + var_276_13 and arg_273_1.time_ < var_276_12 + var_276_13 + arg_276_0 and not isNil(var_276_11) and arg_273_1.var_.characterEffect1042ui_story then
				arg_273_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_276_15 = 0
			local var_276_16 = 0.925

			if var_276_15 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_17 = arg_273_1:FormatText(StoryNameCfg[205].name)

				arg_273_1.leftNameTxt_.text = var_276_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_18 = arg_273_1:GetWordFromCfg(114182066)
				local var_276_19 = arg_273_1:FormatText(var_276_18.content)

				arg_273_1.text_.text = var_276_19

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_20 = 37
				local var_276_21 = utf8.len(var_276_19)
				local var_276_22 = var_276_20 <= 0 and var_276_16 or var_276_16 * (var_276_21 / var_276_20)

				if var_276_22 > 0 and var_276_16 < var_276_22 then
					arg_273_1.talkMaxDuration = var_276_22

					if var_276_22 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_22 + var_276_15
					end
				end

				arg_273_1.text_.text = var_276_19
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182066", "story_v_out_114182.awb") ~= 0 then
					local var_276_23 = manager.audio:GetVoiceLength("story_v_out_114182", "114182066", "story_v_out_114182.awb") / 1000

					if var_276_23 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_23 + var_276_15
					end

					if var_276_18.prefab_name ~= "" and arg_273_1.actors_[var_276_18.prefab_name] ~= nil then
						local var_276_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_18.prefab_name].transform, "story_v_out_114182", "114182066", "story_v_out_114182.awb")

						arg_273_1:RecordAudio("114182066", var_276_24)
						arg_273_1:RecordAudio("114182066", var_276_24)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_114182", "114182066", "story_v_out_114182.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_114182", "114182066", "story_v_out_114182.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_25 = math.max(var_276_16, arg_273_1.talkMaxDuration)

			if var_276_15 <= arg_273_1.time_ and arg_273_1.time_ < var_276_15 + var_276_25 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_15) / var_276_25

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_15 + var_276_25 and arg_273_1.time_ < var_276_15 + var_276_25 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play114182067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 114182067
		arg_277_1.duration_ = 6.77

		local var_277_0 = {
			ja = 6.766,
			ko = 4.233,
			zh = 4.933,
			en = 5.466
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play114182068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1041ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1041ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0.7, -1.11, -5.9)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1041ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = 0

			if var_280_9 < arg_277_1.time_ and arg_277_1.time_ <= var_280_9 + arg_280_0 then
				arg_277_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_280_10 = arg_277_1.actors_["1041ui_story"]
			local var_280_11 = 0

			if var_280_11 < arg_277_1.time_ and arg_277_1.time_ <= var_280_11 + arg_280_0 and not isNil(var_280_10) and arg_277_1.var_.characterEffect1041ui_story == nil then
				arg_277_1.var_.characterEffect1041ui_story = var_280_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_12 = 0.2

			if var_280_11 <= arg_277_1.time_ and arg_277_1.time_ < var_280_11 + var_280_12 and not isNil(var_280_10) then
				local var_280_13 = (arg_277_1.time_ - var_280_11) / var_280_12

				if arg_277_1.var_.characterEffect1041ui_story and not isNil(var_280_10) then
					arg_277_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_11 + var_280_12 and arg_277_1.time_ < var_280_11 + var_280_12 + arg_280_0 and not isNil(var_280_10) and arg_277_1.var_.characterEffect1041ui_story then
				arg_277_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_280_14 = 0

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_280_15 = arg_277_1.actors_["1042ui_story"]
			local var_280_16 = 0

			if var_280_16 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 and not isNil(var_280_15) and arg_277_1.var_.characterEffect1042ui_story == nil then
				arg_277_1.var_.characterEffect1042ui_story = var_280_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_17 = 0.2

			if var_280_16 <= arg_277_1.time_ and arg_277_1.time_ < var_280_16 + var_280_17 and not isNil(var_280_15) then
				local var_280_18 = (arg_277_1.time_ - var_280_16) / var_280_17

				if arg_277_1.var_.characterEffect1042ui_story and not isNil(var_280_15) then
					local var_280_19 = Mathf.Lerp(0, 0.5, var_280_18)

					arg_277_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1042ui_story.fillRatio = var_280_19
				end
			end

			if arg_277_1.time_ >= var_280_16 + var_280_17 and arg_277_1.time_ < var_280_16 + var_280_17 + arg_280_0 and not isNil(var_280_15) and arg_277_1.var_.characterEffect1042ui_story then
				local var_280_20 = 0.5

				arg_277_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1042ui_story.fillRatio = var_280_20
			end

			local var_280_21 = 0
			local var_280_22 = 0.55

			if var_280_21 < arg_277_1.time_ and arg_277_1.time_ <= var_280_21 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_23 = arg_277_1:FormatText(StoryNameCfg[208].name)

				arg_277_1.leftNameTxt_.text = var_280_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_24 = arg_277_1:GetWordFromCfg(114182067)
				local var_280_25 = arg_277_1:FormatText(var_280_24.content)

				arg_277_1.text_.text = var_280_25

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_26 = 22
				local var_280_27 = utf8.len(var_280_25)
				local var_280_28 = var_280_26 <= 0 and var_280_22 or var_280_22 * (var_280_27 / var_280_26)

				if var_280_28 > 0 and var_280_22 < var_280_28 then
					arg_277_1.talkMaxDuration = var_280_28

					if var_280_28 + var_280_21 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_28 + var_280_21
					end
				end

				arg_277_1.text_.text = var_280_25
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182067", "story_v_out_114182.awb") ~= 0 then
					local var_280_29 = manager.audio:GetVoiceLength("story_v_out_114182", "114182067", "story_v_out_114182.awb") / 1000

					if var_280_29 + var_280_21 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_29 + var_280_21
					end

					if var_280_24.prefab_name ~= "" and arg_277_1.actors_[var_280_24.prefab_name] ~= nil then
						local var_280_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_24.prefab_name].transform, "story_v_out_114182", "114182067", "story_v_out_114182.awb")

						arg_277_1:RecordAudio("114182067", var_280_30)
						arg_277_1:RecordAudio("114182067", var_280_30)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_114182", "114182067", "story_v_out_114182.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_114182", "114182067", "story_v_out_114182.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_31 = math.max(var_280_22, arg_277_1.talkMaxDuration)

			if var_280_21 <= arg_277_1.time_ and arg_277_1.time_ < var_280_21 + var_280_31 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_21) / var_280_31

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_21 + var_280_31 and arg_277_1.time_ < var_280_21 + var_280_31 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
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

		arg_277_1:InitPlayNodeList()
	end,
	Play114182068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 114182068
		arg_281_1.duration_ = 9.87

		local var_281_0 = {
			ja = 9.866,
			ko = 5.1,
			zh = 4.133,
			en = 7.5
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
				arg_281_0:Play114182069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_284_2 = arg_281_1.actors_["1042ui_story"]
			local var_284_3 = 0

			if var_284_3 < arg_281_1.time_ and arg_281_1.time_ <= var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1042ui_story == nil then
				arg_281_1.var_.characterEffect1042ui_story = var_284_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_4 = 0.2

			if var_284_3 <= arg_281_1.time_ and arg_281_1.time_ < var_284_3 + var_284_4 and not isNil(var_284_2) then
				local var_284_5 = (arg_281_1.time_ - var_284_3) / var_284_4

				if arg_281_1.var_.characterEffect1042ui_story and not isNil(var_284_2) then
					arg_281_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_3 + var_284_4 and arg_281_1.time_ < var_284_3 + var_284_4 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1042ui_story then
				arg_281_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_284_6 = arg_281_1.actors_["1041ui_story"]
			local var_284_7 = 0

			if var_284_7 < arg_281_1.time_ and arg_281_1.time_ <= var_284_7 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect1041ui_story == nil then
				arg_281_1.var_.characterEffect1041ui_story = var_284_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_8 = 0.2

			if var_284_7 <= arg_281_1.time_ and arg_281_1.time_ < var_284_7 + var_284_8 and not isNil(var_284_6) then
				local var_284_9 = (arg_281_1.time_ - var_284_7) / var_284_8

				if arg_281_1.var_.characterEffect1041ui_story and not isNil(var_284_6) then
					local var_284_10 = Mathf.Lerp(0, 0.5, var_284_9)

					arg_281_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1041ui_story.fillRatio = var_284_10
				end
			end

			if arg_281_1.time_ >= var_284_7 + var_284_8 and arg_281_1.time_ < var_284_7 + var_284_8 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect1041ui_story then
				local var_284_11 = 0.5

				arg_281_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1041ui_story.fillRatio = var_284_11
			end

			local var_284_12 = 0
			local var_284_13 = 0.55

			if var_284_12 < arg_281_1.time_ and arg_281_1.time_ <= var_284_12 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_14 = arg_281_1:FormatText(StoryNameCfg[205].name)

				arg_281_1.leftNameTxt_.text = var_284_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_15 = arg_281_1:GetWordFromCfg(114182068)
				local var_284_16 = arg_281_1:FormatText(var_284_15.content)

				arg_281_1.text_.text = var_284_16

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_17 = 22
				local var_284_18 = utf8.len(var_284_16)
				local var_284_19 = var_284_17 <= 0 and var_284_13 or var_284_13 * (var_284_18 / var_284_17)

				if var_284_19 > 0 and var_284_13 < var_284_19 then
					arg_281_1.talkMaxDuration = var_284_19

					if var_284_19 + var_284_12 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_19 + var_284_12
					end
				end

				arg_281_1.text_.text = var_284_16
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182068", "story_v_out_114182.awb") ~= 0 then
					local var_284_20 = manager.audio:GetVoiceLength("story_v_out_114182", "114182068", "story_v_out_114182.awb") / 1000

					if var_284_20 + var_284_12 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_20 + var_284_12
					end

					if var_284_15.prefab_name ~= "" and arg_281_1.actors_[var_284_15.prefab_name] ~= nil then
						local var_284_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_15.prefab_name].transform, "story_v_out_114182", "114182068", "story_v_out_114182.awb")

						arg_281_1:RecordAudio("114182068", var_284_21)
						arg_281_1:RecordAudio("114182068", var_284_21)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_114182", "114182068", "story_v_out_114182.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_114182", "114182068", "story_v_out_114182.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_22 = math.max(var_284_13, arg_281_1.talkMaxDuration)

			if var_284_12 <= arg_281_1.time_ and arg_281_1.time_ < var_284_12 + var_284_22 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_12) / var_284_22

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_12 + var_284_22 and arg_281_1.time_ < var_284_12 + var_284_22 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play114182069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 114182069
		arg_285_1.duration_ = 4.67

		local var_285_0 = {
			ja = 4.666,
			ko = 2.633,
			zh = 3.8,
			en = 3.233
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play114182070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10006ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos10006ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(0.7, -0.98, -5.65)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10006ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0.7, -0.98, -5.65)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = 0

			if var_288_9 < arg_285_1.time_ and arg_285_1.time_ <= var_288_9 + arg_288_0 then
				arg_285_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_288_11 = arg_285_1.actors_["10006ui_story"]
			local var_288_12 = 0

			if var_288_12 < arg_285_1.time_ and arg_285_1.time_ <= var_288_12 + arg_288_0 and not isNil(var_288_11) and arg_285_1.var_.characterEffect10006ui_story == nil then
				arg_285_1.var_.characterEffect10006ui_story = var_288_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_13 = 0.2

			if var_288_12 <= arg_285_1.time_ and arg_285_1.time_ < var_288_12 + var_288_13 and not isNil(var_288_11) then
				local var_288_14 = (arg_285_1.time_ - var_288_12) / var_288_13

				if arg_285_1.var_.characterEffect10006ui_story and not isNil(var_288_11) then
					arg_285_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_12 + var_288_13 and arg_285_1.time_ < var_288_12 + var_288_13 + arg_288_0 and not isNil(var_288_11) and arg_285_1.var_.characterEffect10006ui_story then
				arg_285_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_288_15 = arg_285_1.actors_["1041ui_story"].transform
			local var_288_16 = 0

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 then
				arg_285_1.var_.moveOldPos1041ui_story = var_288_15.localPosition
			end

			local var_288_17 = 0.001

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_17 then
				local var_288_18 = (arg_285_1.time_ - var_288_16) / var_288_17
				local var_288_19 = Vector3.New(0, 100, 0)

				var_288_15.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1041ui_story, var_288_19, var_288_18)

				local var_288_20 = manager.ui.mainCamera.transform.position - var_288_15.position

				var_288_15.forward = Vector3.New(var_288_20.x, var_288_20.y, var_288_20.z)

				local var_288_21 = var_288_15.localEulerAngles

				var_288_21.z = 0
				var_288_21.x = 0
				var_288_15.localEulerAngles = var_288_21
			end

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 then
				var_288_15.localPosition = Vector3.New(0, 100, 0)

				local var_288_22 = manager.ui.mainCamera.transform.position - var_288_15.position

				var_288_15.forward = Vector3.New(var_288_22.x, var_288_22.y, var_288_22.z)

				local var_288_23 = var_288_15.localEulerAngles

				var_288_23.z = 0
				var_288_23.x = 0
				var_288_15.localEulerAngles = var_288_23
			end

			local var_288_24 = arg_285_1.actors_["1042ui_story"]
			local var_288_25 = 0

			if var_288_25 < arg_285_1.time_ and arg_285_1.time_ <= var_288_25 + arg_288_0 and not isNil(var_288_24) and arg_285_1.var_.characterEffect1042ui_story == nil then
				arg_285_1.var_.characterEffect1042ui_story = var_288_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_26 = 0.2

			if var_288_25 <= arg_285_1.time_ and arg_285_1.time_ < var_288_25 + var_288_26 and not isNil(var_288_24) then
				local var_288_27 = (arg_285_1.time_ - var_288_25) / var_288_26

				if arg_285_1.var_.characterEffect1042ui_story and not isNil(var_288_24) then
					local var_288_28 = Mathf.Lerp(0, 0.5, var_288_27)

					arg_285_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1042ui_story.fillRatio = var_288_28
				end
			end

			if arg_285_1.time_ >= var_288_25 + var_288_26 and arg_285_1.time_ < var_288_25 + var_288_26 + arg_288_0 and not isNil(var_288_24) and arg_285_1.var_.characterEffect1042ui_story then
				local var_288_29 = 0.5

				arg_285_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1042ui_story.fillRatio = var_288_29
			end

			local var_288_30 = 0
			local var_288_31 = 0.225

			if var_288_30 < arg_285_1.time_ and arg_285_1.time_ <= var_288_30 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_32 = arg_285_1:FormatText(StoryNameCfg[212].name)

				arg_285_1.leftNameTxt_.text = var_288_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_33 = arg_285_1:GetWordFromCfg(114182069)
				local var_288_34 = arg_285_1:FormatText(var_288_33.content)

				arg_285_1.text_.text = var_288_34

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_35 = 9
				local var_288_36 = utf8.len(var_288_34)
				local var_288_37 = var_288_35 <= 0 and var_288_31 or var_288_31 * (var_288_36 / var_288_35)

				if var_288_37 > 0 and var_288_31 < var_288_37 then
					arg_285_1.talkMaxDuration = var_288_37

					if var_288_37 + var_288_30 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_37 + var_288_30
					end
				end

				arg_285_1.text_.text = var_288_34
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182069", "story_v_out_114182.awb") ~= 0 then
					local var_288_38 = manager.audio:GetVoiceLength("story_v_out_114182", "114182069", "story_v_out_114182.awb") / 1000

					if var_288_38 + var_288_30 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_38 + var_288_30
					end

					if var_288_33.prefab_name ~= "" and arg_285_1.actors_[var_288_33.prefab_name] ~= nil then
						local var_288_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_33.prefab_name].transform, "story_v_out_114182", "114182069", "story_v_out_114182.awb")

						arg_285_1:RecordAudio("114182069", var_288_39)
						arg_285_1:RecordAudio("114182069", var_288_39)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_114182", "114182069", "story_v_out_114182.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_114182", "114182069", "story_v_out_114182.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_40 = math.max(var_288_31, arg_285_1.talkMaxDuration)

			if var_288_30 <= arg_285_1.time_ and arg_285_1.time_ < var_288_30 + var_288_40 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_30) / var_288_40

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_30 + var_288_40 and arg_285_1.time_ < var_288_30 + var_288_40 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
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

		arg_285_1:InitPlayNodeList()
	end,
	Play114182070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 114182070
		arg_289_1.duration_ = 7.4

		local var_289_0 = {
			ja = 7.4,
			ko = 4.566,
			zh = 4.766,
			en = 3.733
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
				arg_289_0:Play114182071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1042ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1042ui_story == nil then
				arg_289_1.var_.characterEffect1042ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.2

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1042ui_story and not isNil(var_292_0) then
					arg_289_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1042ui_story then
				arg_289_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_292_4 = arg_289_1.actors_["10006ui_story"]
			local var_292_5 = 0

			if var_292_5 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect10006ui_story == nil then
				arg_289_1.var_.characterEffect10006ui_story = var_292_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_6 = 0.2

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_6 and not isNil(var_292_4) then
				local var_292_7 = (arg_289_1.time_ - var_292_5) / var_292_6

				if arg_289_1.var_.characterEffect10006ui_story and not isNil(var_292_4) then
					local var_292_8 = Mathf.Lerp(0, 0.5, var_292_7)

					arg_289_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_289_1.var_.characterEffect10006ui_story.fillRatio = var_292_8
				end
			end

			if arg_289_1.time_ >= var_292_5 + var_292_6 and arg_289_1.time_ < var_292_5 + var_292_6 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect10006ui_story then
				local var_292_9 = 0.5

				arg_289_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_289_1.var_.characterEffect10006ui_story.fillRatio = var_292_9
			end

			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_292_11 = 0
			local var_292_12 = 0.55

			if var_292_11 < arg_289_1.time_ and arg_289_1.time_ <= var_292_11 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_13 = arg_289_1:FormatText(StoryNameCfg[205].name)

				arg_289_1.leftNameTxt_.text = var_292_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_14 = arg_289_1:GetWordFromCfg(114182070)
				local var_292_15 = arg_289_1:FormatText(var_292_14.content)

				arg_289_1.text_.text = var_292_15

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_16 = 22
				local var_292_17 = utf8.len(var_292_15)
				local var_292_18 = var_292_16 <= 0 and var_292_12 or var_292_12 * (var_292_17 / var_292_16)

				if var_292_18 > 0 and var_292_12 < var_292_18 then
					arg_289_1.talkMaxDuration = var_292_18

					if var_292_18 + var_292_11 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_18 + var_292_11
					end
				end

				arg_289_1.text_.text = var_292_15
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182070", "story_v_out_114182.awb") ~= 0 then
					local var_292_19 = manager.audio:GetVoiceLength("story_v_out_114182", "114182070", "story_v_out_114182.awb") / 1000

					if var_292_19 + var_292_11 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_19 + var_292_11
					end

					if var_292_14.prefab_name ~= "" and arg_289_1.actors_[var_292_14.prefab_name] ~= nil then
						local var_292_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_14.prefab_name].transform, "story_v_out_114182", "114182070", "story_v_out_114182.awb")

						arg_289_1:RecordAudio("114182070", var_292_20)
						arg_289_1:RecordAudio("114182070", var_292_20)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_114182", "114182070", "story_v_out_114182.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_114182", "114182070", "story_v_out_114182.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_21 = math.max(var_292_12, arg_289_1.talkMaxDuration)

			if var_292_11 <= arg_289_1.time_ and arg_289_1.time_ < var_292_11 + var_292_21 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_11) / var_292_21

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_11 + var_292_21 and arg_289_1.time_ < var_292_11 + var_292_21 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play114182071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 114182071
		arg_293_1.duration_ = 4.47

		local var_293_0 = {
			ja = 1.999999999999,
			ko = 4.466,
			zh = 4.033,
			en = 3.666
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play114182072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_296_2 = arg_293_1.actors_["10006ui_story"]
			local var_296_3 = 0

			if var_296_3 < arg_293_1.time_ and arg_293_1.time_ <= var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect10006ui_story == nil then
				arg_293_1.var_.characterEffect10006ui_story = var_296_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_4 = 0.2

			if var_296_3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_3 + var_296_4 and not isNil(var_296_2) then
				local var_296_5 = (arg_293_1.time_ - var_296_3) / var_296_4

				if arg_293_1.var_.characterEffect10006ui_story and not isNil(var_296_2) then
					arg_293_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_3 + var_296_4 and arg_293_1.time_ < var_296_3 + var_296_4 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect10006ui_story then
				arg_293_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_296_6 = arg_293_1.actors_["1042ui_story"]
			local var_296_7 = 0

			if var_296_7 < arg_293_1.time_ and arg_293_1.time_ <= var_296_7 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect1042ui_story == nil then
				arg_293_1.var_.characterEffect1042ui_story = var_296_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_8 = 0.2

			if var_296_7 <= arg_293_1.time_ and arg_293_1.time_ < var_296_7 + var_296_8 and not isNil(var_296_6) then
				local var_296_9 = (arg_293_1.time_ - var_296_7) / var_296_8

				if arg_293_1.var_.characterEffect1042ui_story and not isNil(var_296_6) then
					local var_296_10 = Mathf.Lerp(0, 0.5, var_296_9)

					arg_293_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1042ui_story.fillRatio = var_296_10
				end
			end

			if arg_293_1.time_ >= var_296_7 + var_296_8 and arg_293_1.time_ < var_296_7 + var_296_8 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect1042ui_story then
				local var_296_11 = 0.5

				arg_293_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1042ui_story.fillRatio = var_296_11
			end

			local var_296_12 = 0
			local var_296_13 = 0.35

			if var_296_12 < arg_293_1.time_ and arg_293_1.time_ <= var_296_12 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_14 = arg_293_1:FormatText(StoryNameCfg[212].name)

				arg_293_1.leftNameTxt_.text = var_296_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_15 = arg_293_1:GetWordFromCfg(114182071)
				local var_296_16 = arg_293_1:FormatText(var_296_15.content)

				arg_293_1.text_.text = var_296_16

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_17 = 14
				local var_296_18 = utf8.len(var_296_16)
				local var_296_19 = var_296_17 <= 0 and var_296_13 or var_296_13 * (var_296_18 / var_296_17)

				if var_296_19 > 0 and var_296_13 < var_296_19 then
					arg_293_1.talkMaxDuration = var_296_19

					if var_296_19 + var_296_12 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_19 + var_296_12
					end
				end

				arg_293_1.text_.text = var_296_16
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182071", "story_v_out_114182.awb") ~= 0 then
					local var_296_20 = manager.audio:GetVoiceLength("story_v_out_114182", "114182071", "story_v_out_114182.awb") / 1000

					if var_296_20 + var_296_12 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_20 + var_296_12
					end

					if var_296_15.prefab_name ~= "" and arg_293_1.actors_[var_296_15.prefab_name] ~= nil then
						local var_296_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_15.prefab_name].transform, "story_v_out_114182", "114182071", "story_v_out_114182.awb")

						arg_293_1:RecordAudio("114182071", var_296_21)
						arg_293_1:RecordAudio("114182071", var_296_21)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_114182", "114182071", "story_v_out_114182.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_114182", "114182071", "story_v_out_114182.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_22 = math.max(var_296_13, arg_293_1.talkMaxDuration)

			if var_296_12 <= arg_293_1.time_ and arg_293_1.time_ < var_296_12 + var_296_22 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_12) / var_296_22

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_12 + var_296_22 and arg_293_1.time_ < var_296_12 + var_296_22 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play114182072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 114182072
		arg_297_1.duration_ = 18.57

		local var_297_0 = {
			ja = 18.566,
			ko = 13.5,
			zh = 14.033,
			en = 15.833
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
				arg_297_0:Play114182073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1042ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1042ui_story == nil then
				arg_297_1.var_.characterEffect1042ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.2

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1042ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1042ui_story then
				arg_297_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_300_4 = arg_297_1.actors_["10006ui_story"]
			local var_300_5 = 0

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect10006ui_story == nil then
				arg_297_1.var_.characterEffect10006ui_story = var_300_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_6 = 0.2

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_6 and not isNil(var_300_4) then
				local var_300_7 = (arg_297_1.time_ - var_300_5) / var_300_6

				if arg_297_1.var_.characterEffect10006ui_story and not isNil(var_300_4) then
					local var_300_8 = Mathf.Lerp(0, 0.5, var_300_7)

					arg_297_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_297_1.var_.characterEffect10006ui_story.fillRatio = var_300_8
				end
			end

			if arg_297_1.time_ >= var_300_5 + var_300_6 and arg_297_1.time_ < var_300_5 + var_300_6 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect10006ui_story then
				local var_300_9 = 0.5

				arg_297_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_297_1.var_.characterEffect10006ui_story.fillRatio = var_300_9
			end

			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_300_11 = 0

			if var_300_11 < arg_297_1.time_ and arg_297_1.time_ <= var_300_11 + arg_300_0 then
				arg_297_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_300_12 = 0
			local var_300_13 = 1.5

			if var_300_12 < arg_297_1.time_ and arg_297_1.time_ <= var_300_12 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_14 = arg_297_1:FormatText(StoryNameCfg[205].name)

				arg_297_1.leftNameTxt_.text = var_300_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_15 = arg_297_1:GetWordFromCfg(114182072)
				local var_300_16 = arg_297_1:FormatText(var_300_15.content)

				arg_297_1.text_.text = var_300_16

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_17 = 60
				local var_300_18 = utf8.len(var_300_16)
				local var_300_19 = var_300_17 <= 0 and var_300_13 or var_300_13 * (var_300_18 / var_300_17)

				if var_300_19 > 0 and var_300_13 < var_300_19 then
					arg_297_1.talkMaxDuration = var_300_19

					if var_300_19 + var_300_12 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_19 + var_300_12
					end
				end

				arg_297_1.text_.text = var_300_16
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182072", "story_v_out_114182.awb") ~= 0 then
					local var_300_20 = manager.audio:GetVoiceLength("story_v_out_114182", "114182072", "story_v_out_114182.awb") / 1000

					if var_300_20 + var_300_12 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_20 + var_300_12
					end

					if var_300_15.prefab_name ~= "" and arg_297_1.actors_[var_300_15.prefab_name] ~= nil then
						local var_300_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_15.prefab_name].transform, "story_v_out_114182", "114182072", "story_v_out_114182.awb")

						arg_297_1:RecordAudio("114182072", var_300_21)
						arg_297_1:RecordAudio("114182072", var_300_21)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_114182", "114182072", "story_v_out_114182.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_114182", "114182072", "story_v_out_114182.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_22 = math.max(var_300_13, arg_297_1.talkMaxDuration)

			if var_300_12 <= arg_297_1.time_ and arg_297_1.time_ < var_300_12 + var_300_22 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_12) / var_300_22

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_12 + var_300_22 and arg_297_1.time_ < var_300_12 + var_300_22 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play114182073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 114182073
		arg_301_1.duration_ = 7.4

		local var_301_0 = {
			ja = 6.666,
			ko = 4.833,
			zh = 5.333,
			en = 7.4
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
				arg_301_0:Play114182074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_304_1 = 0
			local var_304_2 = 0.6

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_3 = arg_301_1:FormatText(StoryNameCfg[205].name)

				arg_301_1.leftNameTxt_.text = var_304_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_4 = arg_301_1:GetWordFromCfg(114182073)
				local var_304_5 = arg_301_1:FormatText(var_304_4.content)

				arg_301_1.text_.text = var_304_5

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_6 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182073", "story_v_out_114182.awb") ~= 0 then
					local var_304_9 = manager.audio:GetVoiceLength("story_v_out_114182", "114182073", "story_v_out_114182.awb") / 1000

					if var_304_9 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_1
					end

					if var_304_4.prefab_name ~= "" and arg_301_1.actors_[var_304_4.prefab_name] ~= nil then
						local var_304_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_4.prefab_name].transform, "story_v_out_114182", "114182073", "story_v_out_114182.awb")

						arg_301_1:RecordAudio("114182073", var_304_10)
						arg_301_1:RecordAudio("114182073", var_304_10)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_114182", "114182073", "story_v_out_114182.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_114182", "114182073", "story_v_out_114182.awb")
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
	Play114182074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 114182074
		arg_305_1.duration_ = 2

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play114182075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_2")
			end

			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_308_2 = arg_305_1.actors_["10006ui_story"]
			local var_308_3 = 0

			if var_308_3 < arg_305_1.time_ and arg_305_1.time_ <= var_308_3 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.characterEffect10006ui_story == nil then
				arg_305_1.var_.characterEffect10006ui_story = var_308_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_4 = 0.2

			if var_308_3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_3 + var_308_4 and not isNil(var_308_2) then
				local var_308_5 = (arg_305_1.time_ - var_308_3) / var_308_4

				if arg_305_1.var_.characterEffect10006ui_story and not isNil(var_308_2) then
					arg_305_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_3 + var_308_4 and arg_305_1.time_ < var_308_3 + var_308_4 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.characterEffect10006ui_story then
				arg_305_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_308_6 = arg_305_1.actors_["1042ui_story"]
			local var_308_7 = 0

			if var_308_7 < arg_305_1.time_ and arg_305_1.time_ <= var_308_7 + arg_308_0 and not isNil(var_308_6) and arg_305_1.var_.characterEffect1042ui_story == nil then
				arg_305_1.var_.characterEffect1042ui_story = var_308_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_8 = 0.2

			if var_308_7 <= arg_305_1.time_ and arg_305_1.time_ < var_308_7 + var_308_8 and not isNil(var_308_6) then
				local var_308_9 = (arg_305_1.time_ - var_308_7) / var_308_8

				if arg_305_1.var_.characterEffect1042ui_story and not isNil(var_308_6) then
					local var_308_10 = Mathf.Lerp(0, 0.5, var_308_9)

					arg_305_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1042ui_story.fillRatio = var_308_10
				end
			end

			if arg_305_1.time_ >= var_308_7 + var_308_8 and arg_305_1.time_ < var_308_7 + var_308_8 + arg_308_0 and not isNil(var_308_6) and arg_305_1.var_.characterEffect1042ui_story then
				local var_308_11 = 0.5

				arg_305_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1042ui_story.fillRatio = var_308_11
			end

			local var_308_12 = 0
			local var_308_13 = 0.075

			if var_308_12 < arg_305_1.time_ and arg_305_1.time_ <= var_308_12 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_14 = arg_305_1:FormatText(StoryNameCfg[212].name)

				arg_305_1.leftNameTxt_.text = var_308_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_15 = arg_305_1:GetWordFromCfg(114182074)
				local var_308_16 = arg_305_1:FormatText(var_308_15.content)

				arg_305_1.text_.text = var_308_16

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_17 = 3
				local var_308_18 = utf8.len(var_308_16)
				local var_308_19 = var_308_17 <= 0 and var_308_13 or var_308_13 * (var_308_18 / var_308_17)

				if var_308_19 > 0 and var_308_13 < var_308_19 then
					arg_305_1.talkMaxDuration = var_308_19

					if var_308_19 + var_308_12 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_19 + var_308_12
					end
				end

				arg_305_1.text_.text = var_308_16
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182074", "story_v_out_114182.awb") ~= 0 then
					local var_308_20 = manager.audio:GetVoiceLength("story_v_out_114182", "114182074", "story_v_out_114182.awb") / 1000

					if var_308_20 + var_308_12 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_20 + var_308_12
					end

					if var_308_15.prefab_name ~= "" and arg_305_1.actors_[var_308_15.prefab_name] ~= nil then
						local var_308_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_15.prefab_name].transform, "story_v_out_114182", "114182074", "story_v_out_114182.awb")

						arg_305_1:RecordAudio("114182074", var_308_21)
						arg_305_1:RecordAudio("114182074", var_308_21)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_114182", "114182074", "story_v_out_114182.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_114182", "114182074", "story_v_out_114182.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_22 = math.max(var_308_13, arg_305_1.talkMaxDuration)

			if var_308_12 <= arg_305_1.time_ and arg_305_1.time_ < var_308_12 + var_308_22 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_12) / var_308_22

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_12 + var_308_22 and arg_305_1.time_ < var_308_12 + var_308_22 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play114182075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 114182075
		arg_309_1.duration_ = 8.37

		local var_309_0 = {
			ja = 7.4,
			ko = 6.8,
			zh = 7.066,
			en = 8.366
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
				arg_309_0:Play114182076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1042ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1042ui_story == nil then
				arg_309_1.var_.characterEffect1042ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.2

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1042ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1042ui_story then
				arg_309_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_312_4 = arg_309_1.actors_["10006ui_story"]
			local var_312_5 = 0

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 and not isNil(var_312_4) and arg_309_1.var_.characterEffect10006ui_story == nil then
				arg_309_1.var_.characterEffect10006ui_story = var_312_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_6 = 0.2

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_6 and not isNil(var_312_4) then
				local var_312_7 = (arg_309_1.time_ - var_312_5) / var_312_6

				if arg_309_1.var_.characterEffect10006ui_story and not isNil(var_312_4) then
					local var_312_8 = Mathf.Lerp(0, 0.5, var_312_7)

					arg_309_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_309_1.var_.characterEffect10006ui_story.fillRatio = var_312_8
				end
			end

			if arg_309_1.time_ >= var_312_5 + var_312_6 and arg_309_1.time_ < var_312_5 + var_312_6 + arg_312_0 and not isNil(var_312_4) and arg_309_1.var_.characterEffect10006ui_story then
				local var_312_9 = 0.5

				arg_309_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_309_1.var_.characterEffect10006ui_story.fillRatio = var_312_9
			end

			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 then
				arg_309_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_312_11 = 0

			if var_312_11 < arg_309_1.time_ and arg_309_1.time_ <= var_312_11 + arg_312_0 then
				arg_309_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_312_12 = 0
			local var_312_13 = 0.625

			if var_312_12 < arg_309_1.time_ and arg_309_1.time_ <= var_312_12 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_14 = arg_309_1:FormatText(StoryNameCfg[205].name)

				arg_309_1.leftNameTxt_.text = var_312_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_15 = arg_309_1:GetWordFromCfg(114182075)
				local var_312_16 = arg_309_1:FormatText(var_312_15.content)

				arg_309_1.text_.text = var_312_16

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_17 = 25
				local var_312_18 = utf8.len(var_312_16)
				local var_312_19 = var_312_17 <= 0 and var_312_13 or var_312_13 * (var_312_18 / var_312_17)

				if var_312_19 > 0 and var_312_13 < var_312_19 then
					arg_309_1.talkMaxDuration = var_312_19

					if var_312_19 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_19 + var_312_12
					end
				end

				arg_309_1.text_.text = var_312_16
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182075", "story_v_out_114182.awb") ~= 0 then
					local var_312_20 = manager.audio:GetVoiceLength("story_v_out_114182", "114182075", "story_v_out_114182.awb") / 1000

					if var_312_20 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_20 + var_312_12
					end

					if var_312_15.prefab_name ~= "" and arg_309_1.actors_[var_312_15.prefab_name] ~= nil then
						local var_312_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_15.prefab_name].transform, "story_v_out_114182", "114182075", "story_v_out_114182.awb")

						arg_309_1:RecordAudio("114182075", var_312_21)
						arg_309_1:RecordAudio("114182075", var_312_21)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_114182", "114182075", "story_v_out_114182.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_114182", "114182075", "story_v_out_114182.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_22 = math.max(var_312_13, arg_309_1.talkMaxDuration)

			if var_312_12 <= arg_309_1.time_ and arg_309_1.time_ < var_312_12 + var_312_22 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_12) / var_312_22

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_12 + var_312_22 and arg_309_1.time_ < var_312_12 + var_312_22 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play114182076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 114182076
		arg_313_1.duration_ = 2.37

		local var_313_0 = {
			ja = 2.366,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_313_0:Play114182077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_316_1 = arg_313_1.actors_["10006ui_story"]
			local var_316_2 = 0

			if var_316_2 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect10006ui_story == nil then
				arg_313_1.var_.characterEffect10006ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_3 = 0.2

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_3 and not isNil(var_316_1) then
				local var_316_4 = (arg_313_1.time_ - var_316_2) / var_316_3

				if arg_313_1.var_.characterEffect10006ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_2 + var_316_3 and arg_313_1.time_ < var_316_2 + var_316_3 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect10006ui_story then
				arg_313_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_316_5 = arg_313_1.actors_["1042ui_story"]
			local var_316_6 = 0

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1042ui_story == nil then
				arg_313_1.var_.characterEffect1042ui_story = var_316_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_7 = 0.2

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_7 and not isNil(var_316_5) then
				local var_316_8 = (arg_313_1.time_ - var_316_6) / var_316_7

				if arg_313_1.var_.characterEffect1042ui_story and not isNil(var_316_5) then
					local var_316_9 = Mathf.Lerp(0, 0.5, var_316_8)

					arg_313_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1042ui_story.fillRatio = var_316_9
				end
			end

			if arg_313_1.time_ >= var_316_6 + var_316_7 and arg_313_1.time_ < var_316_6 + var_316_7 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1042ui_story then
				local var_316_10 = 0.5

				arg_313_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1042ui_story.fillRatio = var_316_10
			end

			local var_316_11 = 0
			local var_316_12 = 0.1

			if var_316_11 < arg_313_1.time_ and arg_313_1.time_ <= var_316_11 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_13 = arg_313_1:FormatText(StoryNameCfg[212].name)

				arg_313_1.leftNameTxt_.text = var_316_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_14 = arg_313_1:GetWordFromCfg(114182076)
				local var_316_15 = arg_313_1:FormatText(var_316_14.content)

				arg_313_1.text_.text = var_316_15

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_16 = 4
				local var_316_17 = utf8.len(var_316_15)
				local var_316_18 = var_316_16 <= 0 and var_316_12 or var_316_12 * (var_316_17 / var_316_16)

				if var_316_18 > 0 and var_316_12 < var_316_18 then
					arg_313_1.talkMaxDuration = var_316_18

					if var_316_18 + var_316_11 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_18 + var_316_11
					end
				end

				arg_313_1.text_.text = var_316_15
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182076", "story_v_out_114182.awb") ~= 0 then
					local var_316_19 = manager.audio:GetVoiceLength("story_v_out_114182", "114182076", "story_v_out_114182.awb") / 1000

					if var_316_19 + var_316_11 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_19 + var_316_11
					end

					if var_316_14.prefab_name ~= "" and arg_313_1.actors_[var_316_14.prefab_name] ~= nil then
						local var_316_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_14.prefab_name].transform, "story_v_out_114182", "114182076", "story_v_out_114182.awb")

						arg_313_1:RecordAudio("114182076", var_316_20)
						arg_313_1:RecordAudio("114182076", var_316_20)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_114182", "114182076", "story_v_out_114182.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_114182", "114182076", "story_v_out_114182.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_21 = math.max(var_316_12, arg_313_1.talkMaxDuration)

			if var_316_11 <= arg_313_1.time_ and arg_313_1.time_ < var_316_11 + var_316_21 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_11) / var_316_21

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_11 + var_316_21 and arg_313_1.time_ < var_316_11 + var_316_21 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play114182077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 114182077
		arg_317_1.duration_ = 10.5

		local var_317_0 = {
			ja = 4.466,
			ko = 7.166,
			zh = 7.566,
			en = 10.5
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
				arg_317_0:Play114182078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["10006ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect10006ui_story == nil then
				arg_317_1.var_.characterEffect10006ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.2

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect10006ui_story and not isNil(var_320_0) then
					local var_320_4 = Mathf.Lerp(0, 0.5, var_320_3)

					arg_317_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_317_1.var_.characterEffect10006ui_story.fillRatio = var_320_4
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect10006ui_story then
				local var_320_5 = 0.5

				arg_317_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_317_1.var_.characterEffect10006ui_story.fillRatio = var_320_5
			end

			local var_320_6 = 0
			local var_320_7 = 0.8

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_8 = arg_317_1:FormatText(StoryNameCfg[6].name)

				arg_317_1.leftNameTxt_.text = var_320_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_9 = arg_317_1:GetWordFromCfg(114182077)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 32
				local var_320_12 = utf8.len(var_320_10)
				local var_320_13 = var_320_11 <= 0 and var_320_7 or var_320_7 * (var_320_12 / var_320_11)

				if var_320_13 > 0 and var_320_7 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182077", "story_v_out_114182.awb") ~= 0 then
					local var_320_14 = manager.audio:GetVoiceLength("story_v_out_114182", "114182077", "story_v_out_114182.awb") / 1000

					if var_320_14 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_14 + var_320_6
					end

					if var_320_9.prefab_name ~= "" and arg_317_1.actors_[var_320_9.prefab_name] ~= nil then
						local var_320_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_9.prefab_name].transform, "story_v_out_114182", "114182077", "story_v_out_114182.awb")

						arg_317_1:RecordAudio("114182077", var_320_15)
						arg_317_1:RecordAudio("114182077", var_320_15)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_114182", "114182077", "story_v_out_114182.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_114182", "114182077", "story_v_out_114182.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_16 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_16 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_16

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_16 and arg_317_1.time_ < var_320_6 + var_320_16 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play114182078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 114182078
		arg_321_1.duration_ = 10.47

		local var_321_0 = {
			ja = 9.566,
			ko = 9.8,
			zh = 10.466,
			en = 10.1
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
				arg_321_0:Play114182079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_324_1 = arg_321_1.actors_["10006ui_story"]
			local var_324_2 = 0

			if var_324_2 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect10006ui_story == nil then
				arg_321_1.var_.characterEffect10006ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_3 = 0.2

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_3 and not isNil(var_324_1) then
				local var_324_4 = (arg_321_1.time_ - var_324_2) / var_324_3

				if arg_321_1.var_.characterEffect10006ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_2 + var_324_3 and arg_321_1.time_ < var_324_2 + var_324_3 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect10006ui_story then
				arg_321_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_324_5 = 0
			local var_324_6 = 0.9

			if var_324_5 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_7 = arg_321_1:FormatText(StoryNameCfg[212].name)

				arg_321_1.leftNameTxt_.text = var_324_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_8 = arg_321_1:GetWordFromCfg(114182078)
				local var_324_9 = arg_321_1:FormatText(var_324_8.content)

				arg_321_1.text_.text = var_324_9

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 36
				local var_324_11 = utf8.len(var_324_9)
				local var_324_12 = var_324_10 <= 0 and var_324_6 or var_324_6 * (var_324_11 / var_324_10)

				if var_324_12 > 0 and var_324_6 < var_324_12 then
					arg_321_1.talkMaxDuration = var_324_12

					if var_324_12 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_12 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_9
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182078", "story_v_out_114182.awb") ~= 0 then
					local var_324_13 = manager.audio:GetVoiceLength("story_v_out_114182", "114182078", "story_v_out_114182.awb") / 1000

					if var_324_13 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_5
					end

					if var_324_8.prefab_name ~= "" and arg_321_1.actors_[var_324_8.prefab_name] ~= nil then
						local var_324_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_8.prefab_name].transform, "story_v_out_114182", "114182078", "story_v_out_114182.awb")

						arg_321_1:RecordAudio("114182078", var_324_14)
						arg_321_1:RecordAudio("114182078", var_324_14)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_114182", "114182078", "story_v_out_114182.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_114182", "114182078", "story_v_out_114182.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_15 = math.max(var_324_6, arg_321_1.talkMaxDuration)

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_15 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_5) / var_324_15

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_5 + var_324_15 and arg_321_1.time_ < var_324_5 + var_324_15 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play114182079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 114182079
		arg_325_1.duration_ = 10.07

		local var_325_0 = {
			ja = 10.066,
			ko = 5.833,
			zh = 5.366,
			en = 7.933
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
				arg_325_0:Play114182080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["10006ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect10006ui_story == nil then
				arg_325_1.var_.characterEffect10006ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.2

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect10006ui_story and not isNil(var_328_0) then
					local var_328_4 = Mathf.Lerp(0, 0.5, var_328_3)

					arg_325_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10006ui_story.fillRatio = var_328_4
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect10006ui_story then
				local var_328_5 = 0.5

				arg_325_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10006ui_story.fillRatio = var_328_5
			end

			local var_328_6 = arg_325_1.actors_["1042ui_story"]
			local var_328_7 = 0

			if var_328_7 < arg_325_1.time_ and arg_325_1.time_ <= var_328_7 + arg_328_0 and not isNil(var_328_6) and arg_325_1.var_.characterEffect1042ui_story == nil then
				arg_325_1.var_.characterEffect1042ui_story = var_328_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_8 = 0.2

			if var_328_7 <= arg_325_1.time_ and arg_325_1.time_ < var_328_7 + var_328_8 and not isNil(var_328_6) then
				local var_328_9 = (arg_325_1.time_ - var_328_7) / var_328_8

				if arg_325_1.var_.characterEffect1042ui_story and not isNil(var_328_6) then
					arg_325_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_7 + var_328_8 and arg_325_1.time_ < var_328_7 + var_328_8 + arg_328_0 and not isNil(var_328_6) and arg_325_1.var_.characterEffect1042ui_story then
				arg_325_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 then
				arg_325_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_328_11 = 0
			local var_328_12 = 0.525

			if var_328_11 < arg_325_1.time_ and arg_325_1.time_ <= var_328_11 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_13 = arg_325_1:FormatText(StoryNameCfg[205].name)

				arg_325_1.leftNameTxt_.text = var_328_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_14 = arg_325_1:GetWordFromCfg(114182079)
				local var_328_15 = arg_325_1:FormatText(var_328_14.content)

				arg_325_1.text_.text = var_328_15

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_16 = 21
				local var_328_17 = utf8.len(var_328_15)
				local var_328_18 = var_328_16 <= 0 and var_328_12 or var_328_12 * (var_328_17 / var_328_16)

				if var_328_18 > 0 and var_328_12 < var_328_18 then
					arg_325_1.talkMaxDuration = var_328_18

					if var_328_18 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_18 + var_328_11
					end
				end

				arg_325_1.text_.text = var_328_15
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182079", "story_v_out_114182.awb") ~= 0 then
					local var_328_19 = manager.audio:GetVoiceLength("story_v_out_114182", "114182079", "story_v_out_114182.awb") / 1000

					if var_328_19 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_19 + var_328_11
					end

					if var_328_14.prefab_name ~= "" and arg_325_1.actors_[var_328_14.prefab_name] ~= nil then
						local var_328_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_14.prefab_name].transform, "story_v_out_114182", "114182079", "story_v_out_114182.awb")

						arg_325_1:RecordAudio("114182079", var_328_20)
						arg_325_1:RecordAudio("114182079", var_328_20)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_114182", "114182079", "story_v_out_114182.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_114182", "114182079", "story_v_out_114182.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_21 = math.max(var_328_12, arg_325_1.talkMaxDuration)

			if var_328_11 <= arg_325_1.time_ and arg_325_1.time_ < var_328_11 + var_328_21 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_11) / var_328_21

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_11 + var_328_21 and arg_325_1.time_ < var_328_11 + var_328_21 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play114182080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 114182080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play114182081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1042ui_story"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos1042ui_story = var_332_0.localPosition
			end

			local var_332_2 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2
				local var_332_4 = Vector3.New(0, 100, 0)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1042ui_story, var_332_4, var_332_3)

				local var_332_5 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_5.x, var_332_5.y, var_332_5.z)

				local var_332_6 = var_332_0.localEulerAngles

				var_332_6.z = 0
				var_332_6.x = 0
				var_332_0.localEulerAngles = var_332_6
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(0, 100, 0)

				local var_332_7 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_7.x, var_332_7.y, var_332_7.z)

				local var_332_8 = var_332_0.localEulerAngles

				var_332_8.z = 0
				var_332_8.x = 0
				var_332_0.localEulerAngles = var_332_8
			end

			local var_332_9 = arg_329_1.actors_["10006ui_story"].transform
			local var_332_10 = 0

			if var_332_10 < arg_329_1.time_ and arg_329_1.time_ <= var_332_10 + arg_332_0 then
				arg_329_1.var_.moveOldPos10006ui_story = var_332_9.localPosition
			end

			local var_332_11 = 0.001

			if var_332_10 <= arg_329_1.time_ and arg_329_1.time_ < var_332_10 + var_332_11 then
				local var_332_12 = (arg_329_1.time_ - var_332_10) / var_332_11
				local var_332_13 = Vector3.New(0, 100, 0)

				var_332_9.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10006ui_story, var_332_13, var_332_12)

				local var_332_14 = manager.ui.mainCamera.transform.position - var_332_9.position

				var_332_9.forward = Vector3.New(var_332_14.x, var_332_14.y, var_332_14.z)

				local var_332_15 = var_332_9.localEulerAngles

				var_332_15.z = 0
				var_332_15.x = 0
				var_332_9.localEulerAngles = var_332_15
			end

			if arg_329_1.time_ >= var_332_10 + var_332_11 and arg_329_1.time_ < var_332_10 + var_332_11 + arg_332_0 then
				var_332_9.localPosition = Vector3.New(0, 100, 0)

				local var_332_16 = manager.ui.mainCamera.transform.position - var_332_9.position

				var_332_9.forward = Vector3.New(var_332_16.x, var_332_16.y, var_332_16.z)

				local var_332_17 = var_332_9.localEulerAngles

				var_332_17.z = 0
				var_332_17.x = 0
				var_332_9.localEulerAngles = var_332_17
			end

			local var_332_18 = 0
			local var_332_19 = 0.65

			if var_332_18 < arg_329_1.time_ and arg_329_1.time_ <= var_332_18 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_20 = arg_329_1:GetWordFromCfg(114182080)
				local var_332_21 = arg_329_1:FormatText(var_332_20.content)

				arg_329_1.text_.text = var_332_21

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_22 = 26
				local var_332_23 = utf8.len(var_332_21)
				local var_332_24 = var_332_22 <= 0 and var_332_19 or var_332_19 * (var_332_23 / var_332_22)

				if var_332_24 > 0 and var_332_19 < var_332_24 then
					arg_329_1.talkMaxDuration = var_332_24

					if var_332_24 + var_332_18 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_24 + var_332_18
					end
				end

				arg_329_1.text_.text = var_332_21
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_25 = math.max(var_332_19, arg_329_1.talkMaxDuration)

			if var_332_18 <= arg_329_1.time_ and arg_329_1.time_ < var_332_18 + var_332_25 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_18) / var_332_25

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_18 + var_332_25 and arg_329_1.time_ < var_332_18 + var_332_25 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play114182081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 114182081
		arg_333_1.duration_ = 11.4

		local var_333_0 = {
			ja = 11.4,
			ko = 7.666,
			zh = 5.7,
			en = 8.3
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
				arg_333_0:Play114182082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1042ui_story"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos1042ui_story = var_336_0.localPosition
			end

			local var_336_2 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2
				local var_336_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1042ui_story, var_336_4, var_336_3)

				local var_336_5 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_5.x, var_336_5.y, var_336_5.z)

				local var_336_6 = var_336_0.localEulerAngles

				var_336_6.z = 0
				var_336_6.x = 0
				var_336_0.localEulerAngles = var_336_6
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_336_7 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_7.x, var_336_7.y, var_336_7.z)

				local var_336_8 = var_336_0.localEulerAngles

				var_336_8.z = 0
				var_336_8.x = 0
				var_336_0.localEulerAngles = var_336_8
			end

			local var_336_9 = 0

			if var_336_9 < arg_333_1.time_ and arg_333_1.time_ <= var_336_9 + arg_336_0 then
				arg_333_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_336_10 = 0

			if var_336_10 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 then
				arg_333_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_336_11 = arg_333_1.actors_["1042ui_story"]
			local var_336_12 = 0

			if var_336_12 < arg_333_1.time_ and arg_333_1.time_ <= var_336_12 + arg_336_0 and not isNil(var_336_11) and arg_333_1.var_.characterEffect1042ui_story == nil then
				arg_333_1.var_.characterEffect1042ui_story = var_336_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_13 = 0.2

			if var_336_12 <= arg_333_1.time_ and arg_333_1.time_ < var_336_12 + var_336_13 and not isNil(var_336_11) then
				local var_336_14 = (arg_333_1.time_ - var_336_12) / var_336_13

				if arg_333_1.var_.characterEffect1042ui_story and not isNil(var_336_11) then
					arg_333_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_12 + var_336_13 and arg_333_1.time_ < var_336_12 + var_336_13 + arg_336_0 and not isNil(var_336_11) and arg_333_1.var_.characterEffect1042ui_story then
				arg_333_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_336_15 = 0
			local var_336_16 = 0.7

			if var_336_15 < arg_333_1.time_ and arg_333_1.time_ <= var_336_15 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_17 = arg_333_1:FormatText(StoryNameCfg[205].name)

				arg_333_1.leftNameTxt_.text = var_336_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_18 = arg_333_1:GetWordFromCfg(114182081)
				local var_336_19 = arg_333_1:FormatText(var_336_18.content)

				arg_333_1.text_.text = var_336_19

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_20 = 28
				local var_336_21 = utf8.len(var_336_19)
				local var_336_22 = var_336_20 <= 0 and var_336_16 or var_336_16 * (var_336_21 / var_336_20)

				if var_336_22 > 0 and var_336_16 < var_336_22 then
					arg_333_1.talkMaxDuration = var_336_22

					if var_336_22 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_22 + var_336_15
					end
				end

				arg_333_1.text_.text = var_336_19
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182081", "story_v_out_114182.awb") ~= 0 then
					local var_336_23 = manager.audio:GetVoiceLength("story_v_out_114182", "114182081", "story_v_out_114182.awb") / 1000

					if var_336_23 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_23 + var_336_15
					end

					if var_336_18.prefab_name ~= "" and arg_333_1.actors_[var_336_18.prefab_name] ~= nil then
						local var_336_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_18.prefab_name].transform, "story_v_out_114182", "114182081", "story_v_out_114182.awb")

						arg_333_1:RecordAudio("114182081", var_336_24)
						arg_333_1:RecordAudio("114182081", var_336_24)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_114182", "114182081", "story_v_out_114182.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_114182", "114182081", "story_v_out_114182.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_25 = math.max(var_336_16, arg_333_1.talkMaxDuration)

			if var_336_15 <= arg_333_1.time_ and arg_333_1.time_ < var_336_15 + var_336_25 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_15) / var_336_25

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_15 + var_336_25 and arg_333_1.time_ < var_336_15 + var_336_25 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play114182082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 114182082
		arg_337_1.duration_ = 3.13

		local var_337_0 = {
			ja = 2.9,
			ko = 2.3,
			zh = 2.766,
			en = 3.133
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
				arg_337_0:Play114182083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["10006ui_story"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos10006ui_story = var_340_0.localPosition
			end

			local var_340_2 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2
				local var_340_4 = Vector3.New(0.7, -0.98, -5.65)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10006ui_story, var_340_4, var_340_3)

				local var_340_5 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_5.x, var_340_5.y, var_340_5.z)

				local var_340_6 = var_340_0.localEulerAngles

				var_340_6.z = 0
				var_340_6.x = 0
				var_340_0.localEulerAngles = var_340_6
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(0.7, -0.98, -5.65)

				local var_340_7 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_7.x, var_340_7.y, var_340_7.z)

				local var_340_8 = var_340_0.localEulerAngles

				var_340_8.z = 0
				var_340_8.x = 0
				var_340_0.localEulerAngles = var_340_8
			end

			local var_340_9 = 0

			if var_340_9 < arg_337_1.time_ and arg_337_1.time_ <= var_340_9 + arg_340_0 then
				arg_337_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			local var_340_10 = 0

			if var_340_10 < arg_337_1.time_ and arg_337_1.time_ <= var_340_10 + arg_340_0 then
				arg_337_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_340_11 = arg_337_1.actors_["10006ui_story"]
			local var_340_12 = 0

			if var_340_12 < arg_337_1.time_ and arg_337_1.time_ <= var_340_12 + arg_340_0 and not isNil(var_340_11) and arg_337_1.var_.characterEffect10006ui_story == nil then
				arg_337_1.var_.characterEffect10006ui_story = var_340_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_13 = 0.2

			if var_340_12 <= arg_337_1.time_ and arg_337_1.time_ < var_340_12 + var_340_13 and not isNil(var_340_11) then
				local var_340_14 = (arg_337_1.time_ - var_340_12) / var_340_13

				if arg_337_1.var_.characterEffect10006ui_story and not isNil(var_340_11) then
					arg_337_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_12 + var_340_13 and arg_337_1.time_ < var_340_12 + var_340_13 + arg_340_0 and not isNil(var_340_11) and arg_337_1.var_.characterEffect10006ui_story then
				arg_337_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_340_15 = arg_337_1.actors_["1042ui_story"]
			local var_340_16 = 0

			if var_340_16 < arg_337_1.time_ and arg_337_1.time_ <= var_340_16 + arg_340_0 and not isNil(var_340_15) and arg_337_1.var_.characterEffect1042ui_story == nil then
				arg_337_1.var_.characterEffect1042ui_story = var_340_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_17 = 0.2

			if var_340_16 <= arg_337_1.time_ and arg_337_1.time_ < var_340_16 + var_340_17 and not isNil(var_340_15) then
				local var_340_18 = (arg_337_1.time_ - var_340_16) / var_340_17

				if arg_337_1.var_.characterEffect1042ui_story and not isNil(var_340_15) then
					local var_340_19 = Mathf.Lerp(0, 0.5, var_340_18)

					arg_337_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1042ui_story.fillRatio = var_340_19
				end
			end

			if arg_337_1.time_ >= var_340_16 + var_340_17 and arg_337_1.time_ < var_340_16 + var_340_17 + arg_340_0 and not isNil(var_340_15) and arg_337_1.var_.characterEffect1042ui_story then
				local var_340_20 = 0.5

				arg_337_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1042ui_story.fillRatio = var_340_20
			end

			local var_340_21 = 0
			local var_340_22 = 0.125

			if var_340_21 < arg_337_1.time_ and arg_337_1.time_ <= var_340_21 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_23 = arg_337_1:FormatText(StoryNameCfg[212].name)

				arg_337_1.leftNameTxt_.text = var_340_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_24 = arg_337_1:GetWordFromCfg(114182082)
				local var_340_25 = arg_337_1:FormatText(var_340_24.content)

				arg_337_1.text_.text = var_340_25

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_26 = 5
				local var_340_27 = utf8.len(var_340_25)
				local var_340_28 = var_340_26 <= 0 and var_340_22 or var_340_22 * (var_340_27 / var_340_26)

				if var_340_28 > 0 and var_340_22 < var_340_28 then
					arg_337_1.talkMaxDuration = var_340_28

					if var_340_28 + var_340_21 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_28 + var_340_21
					end
				end

				arg_337_1.text_.text = var_340_25
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182082", "story_v_out_114182.awb") ~= 0 then
					local var_340_29 = manager.audio:GetVoiceLength("story_v_out_114182", "114182082", "story_v_out_114182.awb") / 1000

					if var_340_29 + var_340_21 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_29 + var_340_21
					end

					if var_340_24.prefab_name ~= "" and arg_337_1.actors_[var_340_24.prefab_name] ~= nil then
						local var_340_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_24.prefab_name].transform, "story_v_out_114182", "114182082", "story_v_out_114182.awb")

						arg_337_1:RecordAudio("114182082", var_340_30)
						arg_337_1:RecordAudio("114182082", var_340_30)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_114182", "114182082", "story_v_out_114182.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_114182", "114182082", "story_v_out_114182.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_31 = math.max(var_340_22, arg_337_1.talkMaxDuration)

			if var_340_21 <= arg_337_1.time_ and arg_337_1.time_ < var_340_21 + var_340_31 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_21) / var_340_31

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_21 + var_340_31 and arg_337_1.time_ < var_340_21 + var_340_31 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play114182083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 114182083
		arg_341_1.duration_ = 7.27

		local var_341_0 = {
			ja = 7.266,
			ko = 4.6,
			zh = 3.9,
			en = 4.766
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
			arg_341_1.auto_ = false
		end

		function arg_341_1.playNext_(arg_343_0)
			arg_341_1.onStoryFinished_()
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["10006ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect10006ui_story == nil then
				arg_341_1.var_.characterEffect10006ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.2

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect10006ui_story and not isNil(var_344_0) then
					local var_344_4 = Mathf.Lerp(0, 0.5, var_344_3)

					arg_341_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_341_1.var_.characterEffect10006ui_story.fillRatio = var_344_4
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect10006ui_story then
				local var_344_5 = 0.5

				arg_341_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_341_1.var_.characterEffect10006ui_story.fillRatio = var_344_5
			end

			local var_344_6 = arg_341_1.actors_["1042ui_story"]
			local var_344_7 = 0

			if var_344_7 < arg_341_1.time_ and arg_341_1.time_ <= var_344_7 + arg_344_0 and not isNil(var_344_6) and arg_341_1.var_.characterEffect1042ui_story == nil then
				arg_341_1.var_.characterEffect1042ui_story = var_344_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_8 = 0.2

			if var_344_7 <= arg_341_1.time_ and arg_341_1.time_ < var_344_7 + var_344_8 and not isNil(var_344_6) then
				local var_344_9 = (arg_341_1.time_ - var_344_7) / var_344_8

				if arg_341_1.var_.characterEffect1042ui_story and not isNil(var_344_6) then
					arg_341_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_7 + var_344_8 and arg_341_1.time_ < var_344_7 + var_344_8 + arg_344_0 and not isNil(var_344_6) and arg_341_1.var_.characterEffect1042ui_story then
				arg_341_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_344_10 = 0

			if var_344_10 < arg_341_1.time_ and arg_341_1.time_ <= var_344_10 + arg_344_0 then
				arg_341_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_344_11 = 0
			local var_344_12 = 0.45

			if var_344_11 < arg_341_1.time_ and arg_341_1.time_ <= var_344_11 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_13 = arg_341_1:FormatText(StoryNameCfg[205].name)

				arg_341_1.leftNameTxt_.text = var_344_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_14 = arg_341_1:GetWordFromCfg(114182083)
				local var_344_15 = arg_341_1:FormatText(var_344_14.content)

				arg_341_1.text_.text = var_344_15

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_16 = 18
				local var_344_17 = utf8.len(var_344_15)
				local var_344_18 = var_344_16 <= 0 and var_344_12 or var_344_12 * (var_344_17 / var_344_16)

				if var_344_18 > 0 and var_344_12 < var_344_18 then
					arg_341_1.talkMaxDuration = var_344_18

					if var_344_18 + var_344_11 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_18 + var_344_11
					end
				end

				arg_341_1.text_.text = var_344_15
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182083", "story_v_out_114182.awb") ~= 0 then
					local var_344_19 = manager.audio:GetVoiceLength("story_v_out_114182", "114182083", "story_v_out_114182.awb") / 1000

					if var_344_19 + var_344_11 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_19 + var_344_11
					end

					if var_344_14.prefab_name ~= "" and arg_341_1.actors_[var_344_14.prefab_name] ~= nil then
						local var_344_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_14.prefab_name].transform, "story_v_out_114182", "114182083", "story_v_out_114182.awb")

						arg_341_1:RecordAudio("114182083", var_344_20)
						arg_341_1:RecordAudio("114182083", var_344_20)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_114182", "114182083", "story_v_out_114182.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_114182", "114182083", "story_v_out_114182.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_21 = math.max(var_344_12, arg_341_1.talkMaxDuration)

			if var_344_11 <= arg_341_1.time_ and arg_341_1.time_ < var_344_11 + var_344_21 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_11) / var_344_21

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_11 + var_344_21 and arg_341_1.time_ < var_344_11 + var_344_21 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F06",
		"TextureConfig/Background/F04",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_114182.awb"
	}
}
