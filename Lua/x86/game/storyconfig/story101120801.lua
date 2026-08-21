return {
	Play112081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112081001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112081002(arg_1_1)
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

				arg_1_1:AudioAction(var_4_28, var_4_29, "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense.awb")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_32 = 2
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_34 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_34:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:GetWordFromCfg(112081001)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 40
				local var_4_38 = utf8.len(var_4_36)
				local var_4_39 = var_4_37 <= 0 and var_4_33 or var_4_33 * (var_4_38 / var_4_37)

				if var_4_39 > 0 and var_4_33 < var_4_39 then
					arg_1_1.talkMaxDuration = var_4_39
					var_4_32 = var_4_32 + 0.3

					if var_4_39 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_32
					end
				end

				arg_1_1.text_.text = var_4_36
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_40 = var_4_32 + 0.3
			local var_4_41 = math.max(var_4_33, arg_1_1.talkMaxDuration)

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_40) / var_4_41

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 112081002
		arg_8_1.duration_ = 4.27

		local var_8_0 = {
			ja = 3,
			ko = 4.266,
			zh = 3.766,
			en = 2.433
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
				arg_8_0:Play112081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1039ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1039ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1039ui_story = var_11_5.localPosition
			end

			local var_11_7 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7
				local var_11_9 = Vector3.New(-0.7, -1.01, -5.9)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1039ui_story, var_11_9, var_11_8)

				local var_11_10 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_10.x, var_11_10.y, var_11_10.z)

				local var_11_11 = var_11_5.localEulerAngles

				var_11_11.z = 0
				var_11_11.x = 0
				var_11_5.localEulerAngles = var_11_11
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(-0.7, -1.01, -5.9)

				local var_11_12 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_12.x, var_11_12.y, var_11_12.z)

				local var_11_13 = var_11_5.localEulerAngles

				var_11_13.z = 0
				var_11_13.x = 0
				var_11_5.localEulerAngles = var_11_13
			end

			local var_11_14 = 0

			if var_11_14 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_11_16 = arg_8_1.actors_["1039ui_story"]
			local var_11_17 = 0

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1039ui_story == nil then
				arg_8_1.var_.characterEffect1039ui_story = var_11_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_18 = 0.2

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_18 and not isNil(var_11_16) then
				local var_11_19 = (arg_8_1.time_ - var_11_17) / var_11_18

				if arg_8_1.var_.characterEffect1039ui_story and not isNil(var_11_16) then
					arg_8_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_17 + var_11_18 and arg_8_1.time_ < var_11_17 + var_11_18 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1039ui_story then
				arg_8_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_11_20 = 0
			local var_11_21 = 0.4

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[9].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(112081002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081002", "story_v_out_112081.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_112081", "112081002", "story_v_out_112081.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_112081", "112081002", "story_v_out_112081.awb")

						arg_8_1:RecordAudio("112081002", var_11_29)
						arg_8_1:RecordAudio("112081002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_112081", "112081002", "story_v_out_112081.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_112081", "112081002", "story_v_out_112081.awb")
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
				actorName = "1039ui_story",
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
	Play112081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 112081003
		arg_12_1.duration_ = 11.9

		local var_12_0 = {
			ja = 11.9,
			ko = 11.6,
			zh = 9.8,
			en = 11.9
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
				arg_12_0:Play112081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1039ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1039ui_story == nil then
				arg_12_1.var_.characterEffect1039ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1039ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1039ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1039ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1039ui_story.fillRatio = var_15_5
			end

			local var_15_6 = "1081ui_story"

			if arg_12_1.actors_[var_15_6] == nil then
				local var_15_7 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_15_7) then
					local var_15_8 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_12_1.stage_.transform)

					var_15_8.name = var_15_6
					var_15_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_6] = var_15_8

					local var_15_9 = var_15_8:GetComponentInChildren(typeof(CharacterEffect))

					var_15_9.enabled = true

					local var_15_10 = GameObjectTools.GetOrAddComponent(var_15_8, typeof(DynamicBoneHelper))

					if var_15_10 then
						var_15_10:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_9.transform, false)

					arg_12_1.var_[var_15_6 .. "Animator"] = var_15_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_6 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_6 .. "LipSync"] = var_15_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_11 = arg_12_1.actors_["1081ui_story"].transform
			local var_15_12 = 0

			if var_15_12 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 then
				arg_12_1.var_.moveOldPos1081ui_story = var_15_11.localPosition
			end

			local var_15_13 = 0.001

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_13 then
				local var_15_14 = (arg_12_1.time_ - var_15_12) / var_15_13
				local var_15_15 = Vector3.New(0.7, -0.92, -5.8)

				var_15_11.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1081ui_story, var_15_15, var_15_14)

				local var_15_16 = manager.ui.mainCamera.transform.position - var_15_11.position

				var_15_11.forward = Vector3.New(var_15_16.x, var_15_16.y, var_15_16.z)

				local var_15_17 = var_15_11.localEulerAngles

				var_15_17.z = 0
				var_15_17.x = 0
				var_15_11.localEulerAngles = var_15_17
			end

			if arg_12_1.time_ >= var_15_12 + var_15_13 and arg_12_1.time_ < var_15_12 + var_15_13 + arg_15_0 then
				var_15_11.localPosition = Vector3.New(0.7, -0.92, -5.8)

				local var_15_18 = manager.ui.mainCamera.transform.position - var_15_11.position

				var_15_11.forward = Vector3.New(var_15_18.x, var_15_18.y, var_15_18.z)

				local var_15_19 = var_15_11.localEulerAngles

				var_15_19.z = 0
				var_15_19.x = 0
				var_15_11.localEulerAngles = var_15_19
			end

			local var_15_20 = 0

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			local var_15_21 = 0

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_15_22 = arg_12_1.actors_["1081ui_story"]
			local var_15_23 = 0

			if var_15_23 < arg_12_1.time_ and arg_12_1.time_ <= var_15_23 + arg_15_0 and not isNil(var_15_22) and arg_12_1.var_.characterEffect1081ui_story == nil then
				arg_12_1.var_.characterEffect1081ui_story = var_15_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_24 = 0.2

			if var_15_23 <= arg_12_1.time_ and arg_12_1.time_ < var_15_23 + var_15_24 and not isNil(var_15_22) then
				local var_15_25 = (arg_12_1.time_ - var_15_23) / var_15_24

				if arg_12_1.var_.characterEffect1081ui_story and not isNil(var_15_22) then
					arg_12_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_23 + var_15_24 and arg_12_1.time_ < var_15_23 + var_15_24 + arg_15_0 and not isNil(var_15_22) and arg_12_1.var_.characterEffect1081ui_story then
				arg_12_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_15_26 = 0
			local var_15_27 = 1.225

			if var_15_26 < arg_12_1.time_ and arg_12_1.time_ <= var_15_26 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_28 = arg_12_1:FormatText(StoryNameCfg[202].name)

				arg_12_1.leftNameTxt_.text = var_15_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_29 = arg_12_1:GetWordFromCfg(112081003)
				local var_15_30 = arg_12_1:FormatText(var_15_29.content)

				arg_12_1.text_.text = var_15_30

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_31 = 49
				local var_15_32 = utf8.len(var_15_30)
				local var_15_33 = var_15_31 <= 0 and var_15_27 or var_15_27 * (var_15_32 / var_15_31)

				if var_15_33 > 0 and var_15_27 < var_15_33 then
					arg_12_1.talkMaxDuration = var_15_33

					if var_15_33 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_33 + var_15_26
					end
				end

				arg_12_1.text_.text = var_15_30
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081003", "story_v_out_112081.awb") ~= 0 then
					local var_15_34 = manager.audio:GetVoiceLength("story_v_out_112081", "112081003", "story_v_out_112081.awb") / 1000

					if var_15_34 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_34 + var_15_26
					end

					if var_15_29.prefab_name ~= "" and arg_12_1.actors_[var_15_29.prefab_name] ~= nil then
						local var_15_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_29.prefab_name].transform, "story_v_out_112081", "112081003", "story_v_out_112081.awb")

						arg_12_1:RecordAudio("112081003", var_15_35)
						arg_12_1:RecordAudio("112081003", var_15_35)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_112081", "112081003", "story_v_out_112081.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_112081", "112081003", "story_v_out_112081.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_36 = math.max(var_15_27, arg_12_1.talkMaxDuration)

			if var_15_26 <= arg_12_1.time_ and arg_12_1.time_ < var_15_26 + var_15_36 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_26) / var_15_36

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_26 + var_15_36 and arg_12_1.time_ < var_15_26 + var_15_36 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play112081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 112081004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play112081005(arg_16_1)
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
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1081ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1081ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1081ui_story.fillRatio = var_19_5
			end

			local var_19_6 = 0
			local var_19_7 = 0.15

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_9 = arg_16_1:GetWordFromCfg(112081004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 6
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
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_14 and arg_16_1.time_ < var_19_6 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play112081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 112081005
		arg_20_1.duration_ = 11.3

		local var_20_0 = {
			ja = 11.3,
			ko = 10.3,
			zh = 8.4,
			en = 9.9
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
				arg_20_0:Play112081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_23_1 = arg_20_1.actors_["1081ui_story"]
			local var_23_2 = 0

			if var_23_2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 and not isNil(var_23_1) and arg_20_1.var_.characterEffect1081ui_story == nil then
				arg_20_1.var_.characterEffect1081ui_story = var_23_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.2

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_3 and not isNil(var_23_1) then
				local var_23_4 = (arg_20_1.time_ - var_23_2) / var_23_3

				if arg_20_1.var_.characterEffect1081ui_story and not isNil(var_23_1) then
					arg_20_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_2 + var_23_3 and arg_20_1.time_ < var_23_2 + var_23_3 + arg_23_0 and not isNil(var_23_1) and arg_20_1.var_.characterEffect1081ui_story then
				arg_20_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_23_5 = 0
			local var_23_6 = 0.975

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_7 = arg_20_1:FormatText(StoryNameCfg[202].name)

				arg_20_1.leftNameTxt_.text = var_23_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(112081005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_10 = 39
				local var_23_11 = utf8.len(var_23_9)
				local var_23_12 = var_23_10 <= 0 and var_23_6 or var_23_6 * (var_23_11 / var_23_10)

				if var_23_12 > 0 and var_23_6 < var_23_12 then
					arg_20_1.talkMaxDuration = var_23_12

					if var_23_12 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_5
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081005", "story_v_out_112081.awb") ~= 0 then
					local var_23_13 = manager.audio:GetVoiceLength("story_v_out_112081", "112081005", "story_v_out_112081.awb") / 1000

					if var_23_13 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_5
					end

					if var_23_8.prefab_name ~= "" and arg_20_1.actors_[var_23_8.prefab_name] ~= nil then
						local var_23_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_8.prefab_name].transform, "story_v_out_112081", "112081005", "story_v_out_112081.awb")

						arg_20_1:RecordAudio("112081005", var_23_14)
						arg_20_1:RecordAudio("112081005", var_23_14)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_112081", "112081005", "story_v_out_112081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_112081", "112081005", "story_v_out_112081.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_15 = math.max(var_23_6, arg_20_1.talkMaxDuration)

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_15 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_5) / var_23_15

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_5 + var_23_15 and arg_20_1.time_ < var_23_5 + var_23_15 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play112081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 112081006
		arg_24_1.duration_ = 4.17

		local var_24_0 = {
			ja = 4.166,
			ko = 3.666,
			zh = 3.4,
			en = 3.8
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
				arg_24_0:Play112081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1039ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1039ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1039ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = "1084ui_story"

			if arg_24_1.actors_[var_27_9] == nil then
				local var_27_10 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_27_10) then
					local var_27_11 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_24_1.stage_.transform)

					var_27_11.name = var_27_9
					var_27_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_9] = var_27_11

					local var_27_12 = var_27_11:GetComponentInChildren(typeof(CharacterEffect))

					var_27_12.enabled = true

					local var_27_13 = GameObjectTools.GetOrAddComponent(var_27_11, typeof(DynamicBoneHelper))

					if var_27_13 then
						var_27_13:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_12.transform, false)

					arg_24_1.var_[var_27_9 .. "Animator"] = var_27_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_9 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_9 .. "LipSync"] = var_27_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_14 = arg_24_1.actors_["1084ui_story"].transform
			local var_27_15 = 0

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_14.localPosition
			end

			local var_27_16 = 0.001

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_16 then
				local var_27_17 = (arg_24_1.time_ - var_27_15) / var_27_16
				local var_27_18 = Vector3.New(-0.7, -0.97, -6)

				var_27_14.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, var_27_18, var_27_17)

				local var_27_19 = manager.ui.mainCamera.transform.position - var_27_14.position

				var_27_14.forward = Vector3.New(var_27_19.x, var_27_19.y, var_27_19.z)

				local var_27_20 = var_27_14.localEulerAngles

				var_27_20.z = 0
				var_27_20.x = 0
				var_27_14.localEulerAngles = var_27_20
			end

			if arg_24_1.time_ >= var_27_15 + var_27_16 and arg_24_1.time_ < var_27_15 + var_27_16 + arg_27_0 then
				var_27_14.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_27_21 = manager.ui.mainCamera.transform.position - var_27_14.position

				var_27_14.forward = Vector3.New(var_27_21.x, var_27_21.y, var_27_21.z)

				local var_27_22 = var_27_14.localEulerAngles

				var_27_22.z = 0
				var_27_22.x = 0
				var_27_14.localEulerAngles = var_27_22
			end

			local var_27_23 = 0

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_27_24 = 0

			if var_27_24 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_27_25 = arg_24_1.actors_["1084ui_story"]
			local var_27_26 = 0

			if var_27_26 < arg_24_1.time_ and arg_24_1.time_ <= var_27_26 + arg_27_0 and not isNil(var_27_25) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_27 = 0.2

			if var_27_26 <= arg_24_1.time_ and arg_24_1.time_ < var_27_26 + var_27_27 and not isNil(var_27_25) then
				local var_27_28 = (arg_24_1.time_ - var_27_26) / var_27_27

				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_25) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_26 + var_27_27 and arg_24_1.time_ < var_27_26 + var_27_27 + arg_27_0 and not isNil(var_27_25) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_27_29 = 0
			local var_27_30 = 0.3

			if var_27_29 < arg_24_1.time_ and arg_24_1.time_ <= var_27_29 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_31 = arg_24_1:FormatText(StoryNameCfg[6].name)

				arg_24_1.leftNameTxt_.text = var_27_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_32 = arg_24_1:GetWordFromCfg(112081006)
				local var_27_33 = arg_24_1:FormatText(var_27_32.content)

				arg_24_1.text_.text = var_27_33

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_34 = 12
				local var_27_35 = utf8.len(var_27_33)
				local var_27_36 = var_27_34 <= 0 and var_27_30 or var_27_30 * (var_27_35 / var_27_34)

				if var_27_36 > 0 and var_27_30 < var_27_36 then
					arg_24_1.talkMaxDuration = var_27_36

					if var_27_36 + var_27_29 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_36 + var_27_29
					end
				end

				arg_24_1.text_.text = var_27_33
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081006", "story_v_out_112081.awb") ~= 0 then
					local var_27_37 = manager.audio:GetVoiceLength("story_v_out_112081", "112081006", "story_v_out_112081.awb") / 1000

					if var_27_37 + var_27_29 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_37 + var_27_29
					end

					if var_27_32.prefab_name ~= "" and arg_24_1.actors_[var_27_32.prefab_name] ~= nil then
						local var_27_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_32.prefab_name].transform, "story_v_out_112081", "112081006", "story_v_out_112081.awb")

						arg_24_1:RecordAudio("112081006", var_27_38)
						arg_24_1:RecordAudio("112081006", var_27_38)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_112081", "112081006", "story_v_out_112081.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_112081", "112081006", "story_v_out_112081.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_39 = math.max(var_27_30, arg_24_1.talkMaxDuration)

			if var_27_29 <= arg_24_1.time_ and arg_24_1.time_ < var_27_29 + var_27_39 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_29) / var_27_39

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_29 + var_27_39 and arg_24_1.time_ < var_27_29 + var_27_39 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
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

		arg_24_1:InitPlayNodeList()
	end,
	Play112081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 112081007
		arg_28_1.duration_ = 8.03

		local var_28_0 = {
			ja = 6.8,
			ko = 6.966,
			zh = 5.733,
			en = 8.033
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
				arg_28_0:Play112081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1084ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1084ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1084ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1084ui_story.fillRatio = var_31_5
			end

			local var_31_6 = arg_28_1.actors_["1081ui_story"]
			local var_31_7 = 0

			if var_31_7 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect1081ui_story == nil then
				arg_28_1.var_.characterEffect1081ui_story = var_31_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_8 = 0.2

			if var_31_7 <= arg_28_1.time_ and arg_28_1.time_ < var_31_7 + var_31_8 and not isNil(var_31_6) then
				local var_31_9 = (arg_28_1.time_ - var_31_7) / var_31_8

				if arg_28_1.var_.characterEffect1081ui_story and not isNil(var_31_6) then
					arg_28_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_7 + var_31_8 and arg_28_1.time_ < var_31_7 + var_31_8 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect1081ui_story then
				arg_28_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_31_11 = 0
			local var_31_12 = 0.825

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_13 = arg_28_1:FormatText(StoryNameCfg[202].name)

				arg_28_1.leftNameTxt_.text = var_31_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(112081007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_16 = 33
				local var_31_17 = utf8.len(var_31_15)
				local var_31_18 = var_31_16 <= 0 and var_31_12 or var_31_12 * (var_31_17 / var_31_16)

				if var_31_18 > 0 and var_31_12 < var_31_18 then
					arg_28_1.talkMaxDuration = var_31_18

					if var_31_18 + var_31_11 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_11
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081007", "story_v_out_112081.awb") ~= 0 then
					local var_31_19 = manager.audio:GetVoiceLength("story_v_out_112081", "112081007", "story_v_out_112081.awb") / 1000

					if var_31_19 + var_31_11 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_11
					end

					if var_31_14.prefab_name ~= "" and arg_28_1.actors_[var_31_14.prefab_name] ~= nil then
						local var_31_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_14.prefab_name].transform, "story_v_out_112081", "112081007", "story_v_out_112081.awb")

						arg_28_1:RecordAudio("112081007", var_31_20)
						arg_28_1:RecordAudio("112081007", var_31_20)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_112081", "112081007", "story_v_out_112081.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_112081", "112081007", "story_v_out_112081.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_21 = math.max(var_31_12, arg_28_1.talkMaxDuration)

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_21 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_11) / var_31_21

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_11 + var_31_21 and arg_28_1.time_ < var_31_11 + var_31_21 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play112081008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 112081008
		arg_32_1.duration_ = 7.1

		local var_32_0 = {
			ja = 4.9,
			ko = 5.633,
			zh = 5.133,
			en = 7.1
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
				arg_32_0:Play112081009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_35_1 = 0
			local var_35_2 = 0.6

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_3 = arg_32_1:FormatText(StoryNameCfg[202].name)

				arg_32_1.leftNameTxt_.text = var_35_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_4 = arg_32_1:GetWordFromCfg(112081008)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 24
				local var_35_7 = utf8.len(var_35_5)
				local var_35_8 = var_35_6 <= 0 and var_35_2 or var_35_2 * (var_35_7 / var_35_6)

				if var_35_8 > 0 and var_35_2 < var_35_8 then
					arg_32_1.talkMaxDuration = var_35_8

					if var_35_8 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081008", "story_v_out_112081.awb") ~= 0 then
					local var_35_9 = manager.audio:GetVoiceLength("story_v_out_112081", "112081008", "story_v_out_112081.awb") / 1000

					if var_35_9 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_1
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_out_112081", "112081008", "story_v_out_112081.awb")

						arg_32_1:RecordAudio("112081008", var_35_10)
						arg_32_1:RecordAudio("112081008", var_35_10)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_112081", "112081008", "story_v_out_112081.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_112081", "112081008", "story_v_out_112081.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_11 and arg_32_1.time_ < var_35_1 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play112081009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 112081009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play112081010(arg_36_1)
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

			local var_39_9 = arg_36_1.actors_["1084ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = var_39_9.localPosition
			end

			local var_39_11 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11
				local var_39_13 = Vector3.New(0, 100, 0)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, var_39_13, var_39_12)

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
			local var_39_19 = 0.675

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

				local var_39_20 = arg_36_1:GetWordFromCfg(112081009)
				local var_39_21 = arg_36_1:FormatText(var_39_20.content)

				arg_36_1.text_.text = var_39_21

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_22 = 27
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
				actorName = "1084ui_story",
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
	Play112081010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 112081010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play112081011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.775

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(112081010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 31
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play112081011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 112081011
		arg_44_1.duration_ = 9.27

		local var_44_0 = {
			ja = 9.266,
			ko = 8.333,
			zh = 6.533,
			en = 7
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
				arg_44_0:Play112081012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1081ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1081ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, -0.92, -5.8)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1081ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = 0

			if var_47_9 < arg_44_1.time_ and arg_44_1.time_ <= var_47_9 + arg_47_0 then
				arg_44_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_47_11 = arg_44_1.actors_["1081ui_story"]
			local var_47_12 = 0

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 and not isNil(var_47_11) and arg_44_1.var_.characterEffect1081ui_story == nil then
				arg_44_1.var_.characterEffect1081ui_story = var_47_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_13 = 0.2

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_13 and not isNil(var_47_11) then
				local var_47_14 = (arg_44_1.time_ - var_47_12) / var_47_13

				if arg_44_1.var_.characterEffect1081ui_story and not isNil(var_47_11) then
					arg_44_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_12 + var_47_13 and arg_44_1.time_ < var_47_12 + var_47_13 + arg_47_0 and not isNil(var_47_11) and arg_44_1.var_.characterEffect1081ui_story then
				arg_44_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_47_15 = 0
			local var_47_16 = 0.95

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[202].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_18 = arg_44_1:GetWordFromCfg(112081011)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 38
				local var_47_21 = utf8.len(var_47_19)
				local var_47_22 = var_47_20 <= 0 and var_47_16 or var_47_16 * (var_47_21 / var_47_20)

				if var_47_22 > 0 and var_47_16 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22

					if var_47_22 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_19
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081011", "story_v_out_112081.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_out_112081", "112081011", "story_v_out_112081.awb") / 1000

					if var_47_23 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_15
					end

					if var_47_18.prefab_name ~= "" and arg_44_1.actors_[var_47_18.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_18.prefab_name].transform, "story_v_out_112081", "112081011", "story_v_out_112081.awb")

						arg_44_1:RecordAudio("112081011", var_47_24)
						arg_44_1:RecordAudio("112081011", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_112081", "112081011", "story_v_out_112081.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_112081", "112081011", "story_v_out_112081.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_25 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_25 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_25

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_25 and arg_44_1.time_ < var_47_15 + var_47_25 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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

		arg_44_1:InitPlayNodeList()
	end,
	Play112081012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 112081012
		arg_48_1.duration_ = 3.77

		local var_48_0 = {
			ja = 3.766,
			ko = 3.5,
			zh = 2.166,
			en = 2.666
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
				arg_48_0:Play112081013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_1 = 0
			local var_51_2 = 0.325

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_3 = arg_48_1:FormatText(StoryNameCfg[202].name)

				arg_48_1.leftNameTxt_.text = var_51_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_4 = arg_48_1:GetWordFromCfg(112081012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_6 = 13
				local var_51_7 = utf8.len(var_51_5)
				local var_51_8 = var_51_6 <= 0 and var_51_2 or var_51_2 * (var_51_7 / var_51_6)

				if var_51_8 > 0 and var_51_2 < var_51_8 then
					arg_48_1.talkMaxDuration = var_51_8

					if var_51_8 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081012", "story_v_out_112081.awb") ~= 0 then
					local var_51_9 = manager.audio:GetVoiceLength("story_v_out_112081", "112081012", "story_v_out_112081.awb") / 1000

					if var_51_9 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_1
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_out_112081", "112081012", "story_v_out_112081.awb")

						arg_48_1:RecordAudio("112081012", var_51_10)
						arg_48_1:RecordAudio("112081012", var_51_10)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_112081", "112081012", "story_v_out_112081.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_112081", "112081012", "story_v_out_112081.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_11 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_11 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_11

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_11 and arg_48_1.time_ < var_51_1 + var_51_11 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play112081013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 112081013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play112081014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1081ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1081ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1081ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = 0
			local var_55_10 = 1.25

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_11 = arg_52_1:GetWordFromCfg(112081013)
				local var_55_12 = arg_52_1:FormatText(var_55_11.content)

				arg_52_1.text_.text = var_55_12

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 50
				local var_55_14 = utf8.len(var_55_12)
				local var_55_15 = var_55_13 <= 0 and var_55_10 or var_55_10 * (var_55_14 / var_55_13)

				if var_55_15 > 0 and var_55_10 < var_55_15 then
					arg_52_1.talkMaxDuration = var_55_15

					if var_55_15 + var_55_9 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_15 + var_55_9
					end
				end

				arg_52_1.text_.text = var_55_12
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_10, arg_52_1.talkMaxDuration)

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_9) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_9 + var_55_16 and arg_52_1.time_ < var_55_9 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play112081014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 112081014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play112081015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.125

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(112081014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 5
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_8 and arg_56_1.time_ < var_59_0 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play112081015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 112081015
		arg_60_1.duration_ = 10.33

		local var_60_0 = {
			ja = 8.3,
			ko = 10.266,
			zh = 10.333,
			en = 9.3
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play112081016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1081ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1081ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0, -0.92, -5.8)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1081ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 then
				arg_60_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_63_11 = arg_60_1.actors_["1081ui_story"]
			local var_63_12 = 0

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect1081ui_story == nil then
				arg_60_1.var_.characterEffect1081ui_story = var_63_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_13 = 0.2

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_13 and not isNil(var_63_11) then
				local var_63_14 = (arg_60_1.time_ - var_63_12) / var_63_13

				if arg_60_1.var_.characterEffect1081ui_story and not isNil(var_63_11) then
					arg_60_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_12 + var_63_13 and arg_60_1.time_ < var_63_12 + var_63_13 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect1081ui_story then
				arg_60_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_63_15 = 0
			local var_63_16 = 1.3

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[202].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_18 = arg_60_1:GetWordFromCfg(112081015)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 52
				local var_63_21 = utf8.len(var_63_19)
				local var_63_22 = var_63_20 <= 0 and var_63_16 or var_63_16 * (var_63_21 / var_63_20)

				if var_63_22 > 0 and var_63_16 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22

					if var_63_22 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081015", "story_v_out_112081.awb") ~= 0 then
					local var_63_23 = manager.audio:GetVoiceLength("story_v_out_112081", "112081015", "story_v_out_112081.awb") / 1000

					if var_63_23 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_15
					end

					if var_63_18.prefab_name ~= "" and arg_60_1.actors_[var_63_18.prefab_name] ~= nil then
						local var_63_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_18.prefab_name].transform, "story_v_out_112081", "112081015", "story_v_out_112081.awb")

						arg_60_1:RecordAudio("112081015", var_63_24)
						arg_60_1:RecordAudio("112081015", var_63_24)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_112081", "112081015", "story_v_out_112081.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_112081", "112081015", "story_v_out_112081.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_25 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_25 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_25

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_25 and arg_60_1.time_ < var_63_15 + var_63_25 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play112081016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 112081016
		arg_64_1.duration_ = 8.1

		local var_64_0 = {
			ja = 7.366,
			ko = 8.1,
			zh = 5.9,
			en = 7.733
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play112081017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_67_1 = 0
			local var_67_2 = 0.7

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_3 = arg_64_1:FormatText(StoryNameCfg[202].name)

				arg_64_1.leftNameTxt_.text = var_67_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_4 = arg_64_1:GetWordFromCfg(112081016)
				local var_67_5 = arg_64_1:FormatText(var_67_4.content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_6 = 28
				local var_67_7 = utf8.len(var_67_5)
				local var_67_8 = var_67_6 <= 0 and var_67_2 or var_67_2 * (var_67_7 / var_67_6)

				if var_67_8 > 0 and var_67_2 < var_67_8 then
					arg_64_1.talkMaxDuration = var_67_8

					if var_67_8 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081016", "story_v_out_112081.awb") ~= 0 then
					local var_67_9 = manager.audio:GetVoiceLength("story_v_out_112081", "112081016", "story_v_out_112081.awb") / 1000

					if var_67_9 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_1
					end

					if var_67_4.prefab_name ~= "" and arg_64_1.actors_[var_67_4.prefab_name] ~= nil then
						local var_67_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_4.prefab_name].transform, "story_v_out_112081", "112081016", "story_v_out_112081.awb")

						arg_64_1:RecordAudio("112081016", var_67_10)
						arg_64_1:RecordAudio("112081016", var_67_10)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_112081", "112081016", "story_v_out_112081.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_112081", "112081016", "story_v_out_112081.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_11 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_11 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_11

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_11 and arg_64_1.time_ < var_67_1 + var_67_11 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play112081017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 112081017
		arg_68_1.duration_ = 6.7

		local var_68_0 = {
			ja = 6.666,
			ko = 6.133,
			zh = 4.8,
			en = 6.7
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
				arg_68_0:Play112081018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_71_1 = 0
			local var_71_2 = 0.575

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_3 = arg_68_1:FormatText(StoryNameCfg[202].name)

				arg_68_1.leftNameTxt_.text = var_71_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(112081017)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_6 = 23
				local var_71_7 = utf8.len(var_71_5)
				local var_71_8 = var_71_6 <= 0 and var_71_2 or var_71_2 * (var_71_7 / var_71_6)

				if var_71_8 > 0 and var_71_2 < var_71_8 then
					arg_68_1.talkMaxDuration = var_71_8

					if var_71_8 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081017", "story_v_out_112081.awb") ~= 0 then
					local var_71_9 = manager.audio:GetVoiceLength("story_v_out_112081", "112081017", "story_v_out_112081.awb") / 1000

					if var_71_9 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_1
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_out_112081", "112081017", "story_v_out_112081.awb")

						arg_68_1:RecordAudio("112081017", var_71_10)
						arg_68_1:RecordAudio("112081017", var_71_10)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_112081", "112081017", "story_v_out_112081.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_112081", "112081017", "story_v_out_112081.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_11 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_11 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_11

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_11 and arg_68_1.time_ < var_71_1 + var_71_11 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play112081018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 112081018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play112081019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1081ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1081ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(0, 100, 0)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1081ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, 100, 0)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = 0
			local var_75_10 = 0.05

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_11 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_12 = arg_72_1:GetWordFromCfg(112081018)
				local var_75_13 = arg_72_1:FormatText(var_75_12.content)

				arg_72_1.text_.text = var_75_13

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_14 = 2
				local var_75_15 = utf8.len(var_75_13)
				local var_75_16 = var_75_14 <= 0 and var_75_10 or var_75_10 * (var_75_15 / var_75_14)

				if var_75_16 > 0 and var_75_10 < var_75_16 then
					arg_72_1.talkMaxDuration = var_75_16

					if var_75_16 + var_75_9 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_16 + var_75_9
					end
				end

				arg_72_1.text_.text = var_75_13
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_17 = math.max(var_75_10, arg_72_1.talkMaxDuration)

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_17 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_9) / var_75_17

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_9 + var_75_17 and arg_72_1.time_ < var_75_9 + var_75_17 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play112081019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 112081019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play112081020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.175

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(112081019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 7
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
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_8 and arg_76_1.time_ < var_79_0 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play112081020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 112081020
		arg_80_1.duration_ = 9

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play112081021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = "SA0103"

			if arg_80_1.bgs_[var_83_0] == nil then
				local var_83_1 = Object.Instantiate(arg_80_1.paintGo_)

				var_83_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_83_0)
				var_83_1.name = var_83_0
				var_83_1.transform.parent = arg_80_1.stage_.transform
				var_83_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.bgs_[var_83_0] = var_83_1
			end

			local var_83_2 = 2

			if var_83_2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				local var_83_3 = manager.ui.mainCamera.transform.localPosition
				local var_83_4 = Vector3.New(0, 0, 10) + Vector3.New(var_83_3.x, var_83_3.y, 0)
				local var_83_5 = arg_80_1.bgs_.SA0103

				var_83_5.transform.localPosition = var_83_4
				var_83_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_6 = var_83_5:GetComponent("SpriteRenderer")

				if var_83_6 and var_83_6.sprite then
					local var_83_7 = (var_83_5.transform.localPosition - var_83_3).z
					local var_83_8 = manager.ui.mainCameraCom_
					local var_83_9 = 2 * var_83_7 * Mathf.Tan(var_83_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_83_10 = var_83_9 * var_83_8.aspect
					local var_83_11 = var_83_6.sprite.bounds.size.x
					local var_83_12 = var_83_6.sprite.bounds.size.y
					local var_83_13 = var_83_10 / var_83_11
					local var_83_14 = var_83_9 / var_83_12
					local var_83_15 = var_83_14 < var_83_13 and var_83_13 or var_83_14

					var_83_5.transform.localScale = Vector3.New(var_83_15, var_83_15, 0)
				end

				for iter_83_0, iter_83_1 in pairs(arg_80_1.bgs_) do
					if iter_83_0 ~= "SA0103" then
						iter_83_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_16 = arg_80_1.bgs_.H01a
			local var_83_17 = 0

			if var_83_17 < arg_80_1.time_ and arg_80_1.time_ <= var_83_17 + arg_83_0 then
				local var_83_18 = var_83_16:GetComponent("SpriteRenderer")

				if var_83_18 then
					arg_80_1.var_.alphaOldValueH01a = var_83_18.color.a
					arg_80_1.var_.alphaMatValueH01a = var_83_18
				end

				arg_80_1.var_.alphaOldValueH01a = 1
			end

			local var_83_19 = 2

			if var_83_17 <= arg_80_1.time_ and arg_80_1.time_ < var_83_17 + var_83_19 then
				local var_83_20 = (arg_80_1.time_ - var_83_17) / var_83_19
				local var_83_21 = Mathf.Lerp(arg_80_1.var_.alphaOldValueH01a, 0, var_83_20)

				if arg_80_1.var_.alphaMatValueH01a then
					local var_83_22 = arg_80_1.var_.alphaMatValueH01a.color

					var_83_22.a = var_83_21
					arg_80_1.var_.alphaMatValueH01a.color = var_83_22
				end
			end

			if arg_80_1.time_ >= var_83_17 + var_83_19 and arg_80_1.time_ < var_83_17 + var_83_19 + arg_83_0 and arg_80_1.var_.alphaMatValueH01a then
				local var_83_23 = arg_80_1.var_.alphaMatValueH01a
				local var_83_24 = var_83_23.color

				var_83_24.a = 0
				var_83_23.color = var_83_24
			end

			local var_83_25 = 2

			if var_83_25 < arg_80_1.time_ and arg_80_1.time_ <= var_83_25 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_26 = 2

			if var_83_25 <= arg_80_1.time_ and arg_80_1.time_ < var_83_25 + var_83_26 then
				local var_83_27 = (arg_80_1.time_ - var_83_25) / var_83_26
				local var_83_28 = Color.New(0, 0, 0)

				var_83_28.a = Mathf.Lerp(1, 0, var_83_27)
				arg_80_1.mask_.color = var_83_28
			end

			if arg_80_1.time_ >= var_83_25 + var_83_26 and arg_80_1.time_ < var_83_25 + var_83_26 + arg_83_0 then
				local var_83_29 = Color.New(0, 0, 0)
				local var_83_30 = 0

				arg_80_1.mask_.enabled = false
				var_83_29.a = var_83_30
				arg_80_1.mask_.color = var_83_29
			end

			local var_83_31 = arg_80_1.bgs_.SA0103.transform
			local var_83_32 = 2

			if var_83_32 < arg_80_1.time_ and arg_80_1.time_ <= var_83_32 + arg_83_0 then
				arg_80_1.var_.moveOldPosSA0103 = var_83_31.localPosition
			end

			local var_83_33 = 2.625

			if var_83_32 <= arg_80_1.time_ and arg_80_1.time_ < var_83_32 + var_83_33 then
				local var_83_34 = (arg_80_1.time_ - var_83_32) / var_83_33
				local var_83_35 = Vector3.New(0, 1, 9.5)

				var_83_31.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPosSA0103, var_83_35, var_83_34)
			end

			if arg_80_1.time_ >= var_83_32 + var_83_33 and arg_80_1.time_ < var_83_32 + var_83_33 + arg_83_0 then
				var_83_31.localPosition = Vector3.New(0, 1, 9.5)
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_36 = 4
			local var_83_37 = 0.625

			if var_83_36 < arg_80_1.time_ and arg_80_1.time_ <= var_83_36 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_38 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_38:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_39 = arg_80_1:GetWordFromCfg(112081020)
				local var_83_40 = arg_80_1:FormatText(var_83_39.content)

				arg_80_1.text_.text = var_83_40

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_41 = 25
				local var_83_42 = utf8.len(var_83_40)
				local var_83_43 = var_83_41 <= 0 and var_83_37 or var_83_37 * (var_83_42 / var_83_41)

				if var_83_43 > 0 and var_83_37 < var_83_43 then
					arg_80_1.talkMaxDuration = var_83_43
					var_83_36 = var_83_36 + 0.3

					if var_83_43 + var_83_36 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_43 + var_83_36
					end
				end

				arg_80_1.text_.text = var_83_40
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_44 = var_83_36 + 0.3
			local var_83_45 = math.max(var_83_37, arg_80_1.talkMaxDuration)

			if var_83_44 <= arg_80_1.time_ and arg_80_1.time_ < var_83_44 + var_83_45 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_44) / var_83_45

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_44 + var_83_45 and arg_80_1.time_ < var_83_44 + var_83_45 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SA0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.625,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play112081021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 112081021
		arg_86_1.duration_ = 2.53

		local var_86_0 = {
			ja = 2.433,
			ko = 2.533,
			zh = 2.1,
			en = 2.2
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play112081022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.175

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[202].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_3 = arg_86_1:GetWordFromCfg(112081021)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 7
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112081", "112081021", "story_v_out_112081.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_112081", "112081021", "story_v_out_112081.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_112081", "112081021", "story_v_out_112081.awb")

						arg_86_1:RecordAudio("112081021", var_89_9)
						arg_86_1:RecordAudio("112081021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_112081", "112081021", "story_v_out_112081.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_112081", "112081021", "story_v_out_112081.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play112081022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 112081022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play112081023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.7

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(112081022)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 28
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play112081023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 112081023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
			arg_94_1.auto_ = false
		end

		function arg_94_1.playNext_(arg_96_0)
			arg_94_1.onStoryFinished_()
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.575

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

				local var_97_2 = arg_94_1:GetWordFromCfg(112081023)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 23
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
	assets = {
		"TextureConfig/Background/H01a",
		"TextureConfig/Background/SA0103"
	},
	voices = {
		"story_v_out_112081.awb"
	}
}
