return {
	Play120111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J13g"

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
				local var_4_5 = arg_1_1.bgs_.J13g

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
					if iter_4_0 ~= "J13g" then
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

			local var_4_28 = 0.233333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu")

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
			local var_4_35 = 0.125

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(120111001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 5
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_34 + 0.3
			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play120111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120111002
		arg_9_1.duration_ = 5.03

		local var_9_0 = {
			zh = 5.033,
			ja = 4.733
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
				arg_9_0:Play120111003(arg_9_1)
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

			local var_12_14 = arg_9_1.actors_["1184ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1184ui_story == nil then
				arg_9_1.var_.characterEffect1184ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.2

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1184ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1184ui_story then
				arg_9_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.475

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

				local var_12_23 = arg_9_1:GetWordFromCfg(120111002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111002", "story_v_out_120111.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_120111", "120111002", "story_v_out_120111.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_120111", "120111002", "story_v_out_120111.awb")

						arg_9_1:RecordAudio("120111002", var_12_29)
						arg_9_1:RecordAudio("120111002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_120111", "120111002", "story_v_out_120111.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_120111", "120111002", "story_v_out_120111.awb")
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
	Play120111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120111003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play120111004(arg_13_1)
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
			local var_16_10 = 1.025

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_11 = arg_13_1:GetWordFromCfg(120111003)
				local var_16_12 = arg_13_1:FormatText(var_16_11.content)

				arg_13_1.text_.text = var_16_12

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 41
				local var_16_14 = utf8.len(var_16_12)
				local var_16_15 = var_16_13 <= 0 and var_16_10 or var_16_10 * (var_16_14 / var_16_13)

				if var_16_15 > 0 and var_16_10 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_9 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_9
					end
				end

				arg_13_1.text_.text = var_16_12
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_10, arg_13_1.talkMaxDuration)

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_9) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_9 + var_16_16 and arg_13_1.time_ < var_16_9 + var_16_16 + arg_16_0 then
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
	Play120111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120111004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play120111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.175

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(120111004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 47
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play120111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120111005
		arg_21_1.duration_ = 9

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play120111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "J04f"

			if arg_21_1.bgs_[var_24_0] == nil then
				local var_24_1 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_24_0)
				var_24_1.name = var_24_0
				var_24_1.transform.parent = arg_21_1.stage_.transform
				var_24_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_[var_24_0] = var_24_1
			end

			local var_24_2 = 2

			if var_24_2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				local var_24_3 = manager.ui.mainCamera.transform.localPosition
				local var_24_4 = Vector3.New(0, 0, 10) + Vector3.New(var_24_3.x, var_24_3.y, 0)
				local var_24_5 = arg_21_1.bgs_.J04f

				var_24_5.transform.localPosition = var_24_4
				var_24_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_6 = var_24_5:GetComponent("SpriteRenderer")

				if var_24_6 and var_24_6.sprite then
					local var_24_7 = (var_24_5.transform.localPosition - var_24_3).z
					local var_24_8 = manager.ui.mainCameraCom_
					local var_24_9 = 2 * var_24_7 * Mathf.Tan(var_24_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_24_10 = var_24_9 * var_24_8.aspect
					local var_24_11 = var_24_6.sprite.bounds.size.x
					local var_24_12 = var_24_6.sprite.bounds.size.y
					local var_24_13 = var_24_10 / var_24_11
					local var_24_14 = var_24_9 / var_24_12
					local var_24_15 = var_24_14 < var_24_13 and var_24_13 or var_24_14

					var_24_5.transform.localScale = Vector3.New(var_24_15, var_24_15, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "J04f" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_17 = 2

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17
				local var_24_19 = Color.New(0, 0, 0)

				var_24_19.a = Mathf.Lerp(0, 1, var_24_18)
				arg_21_1.mask_.color = var_24_19
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 then
				local var_24_20 = Color.New(0, 0, 0)

				var_24_20.a = 1
				arg_21_1.mask_.color = var_24_20
			end

			local var_24_21 = 2

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_22 = 2

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22
				local var_24_24 = Color.New(0, 0, 0)

				var_24_24.a = Mathf.Lerp(1, 0, var_24_23)
				arg_21_1.mask_.color = var_24_24
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 then
				local var_24_25 = Color.New(0, 0, 0)
				local var_24_26 = 0

				arg_21_1.mask_.enabled = false
				var_24_25.a = var_24_26
				arg_21_1.mask_.color = var_24_25
			end

			local var_24_27 = 2
			local var_24_28 = 0.099999999999

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				local var_24_29 = "play"
				local var_24_30 = "effect"

				arg_21_1:AudioAction(var_24_29, var_24_30, "se_story_120_00", "se_story_120_00_door_wood", "")
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_31 = 4
			local var_24_32 = 0.1

			if var_24_31 < arg_21_1.time_ and arg_21_1.time_ <= var_24_31 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_33 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_33:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_34 = arg_21_1:GetWordFromCfg(120111005)
				local var_24_35 = arg_21_1:FormatText(var_24_34.content)

				arg_21_1.text_.text = var_24_35

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_36 = 4
				local var_24_37 = utf8.len(var_24_35)
				local var_24_38 = var_24_36 <= 0 and var_24_32 or var_24_32 * (var_24_37 / var_24_36)

				if var_24_38 > 0 and var_24_32 < var_24_38 then
					arg_21_1.talkMaxDuration = var_24_38
					var_24_31 = var_24_31 + 0.3

					if var_24_38 + var_24_31 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_38 + var_24_31
					end
				end

				arg_21_1.text_.text = var_24_35
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_39 = var_24_31 + 0.3
			local var_24_40 = math.max(var_24_32, arg_21_1.talkMaxDuration)

			if var_24_39 <= arg_21_1.time_ and arg_21_1.time_ < var_24_39 + var_24_40 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_39) / var_24_40

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_39 + var_24_40 and arg_21_1.time_ < var_24_39 + var_24_40 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play120111006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 120111006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play120111007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.25

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[7].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_3 = arg_27_1:GetWordFromCfg(120111006)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 10
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_8 and arg_27_1.time_ < var_30_0 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play120111007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 120111007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play120111008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 1.05

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_2 = arg_31_1:GetWordFromCfg(120111007)
				local var_34_3 = arg_31_1:FormatText(var_34_2.content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 42
				local var_34_5 = utf8.len(var_34_3)
				local var_34_6 = var_34_4 <= 0 and var_34_1 or var_34_1 * (var_34_5 / var_34_4)

				if var_34_6 > 0 and var_34_1 < var_34_6 then
					arg_31_1.talkMaxDuration = var_34_6

					if var_34_6 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_6 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_7 and arg_31_1.time_ < var_34_0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play120111008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 120111008
		arg_35_1.duration_ = 2.9

		local var_35_0 = {
			zh = 2.499999999999,
			ja = 2.9
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play120111009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = "10044ui_story"

			if arg_35_1.actors_[var_38_0] == nil then
				local var_38_1 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_38_1) then
					local var_38_2 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_35_1.stage_.transform)

					var_38_2.name = var_38_0
					var_38_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_35_1.actors_[var_38_0] = var_38_2

					local var_38_3 = var_38_2:GetComponentInChildren(typeof(CharacterEffect))

					var_38_3.enabled = true

					local var_38_4 = GameObjectTools.GetOrAddComponent(var_38_2, typeof(DynamicBoneHelper))

					if var_38_4 then
						var_38_4:EnableDynamicBone(false)
					end

					arg_35_1:ShowWeapon(var_38_3.transform, false)

					arg_35_1.var_[var_38_0 .. "Animator"] = var_38_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_35_1.var_[var_38_0 .. "Animator"].applyRootMotion = true
					arg_35_1.var_[var_38_0 .. "LipSync"] = var_38_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_38_5 = arg_35_1.actors_["10044ui_story"].transform
			local var_38_6 = 0

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.var_.moveOldPos10044ui_story = var_38_5.localPosition
			end

			local var_38_7 = 0.001

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_7 then
				local var_38_8 = (arg_35_1.time_ - var_38_6) / var_38_7
				local var_38_9 = Vector3.New(0, -0.72, -6.3)

				var_38_5.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10044ui_story, var_38_9, var_38_8)

				local var_38_10 = manager.ui.mainCamera.transform.position - var_38_5.position

				var_38_5.forward = Vector3.New(var_38_10.x, var_38_10.y, var_38_10.z)

				local var_38_11 = var_38_5.localEulerAngles

				var_38_11.z = 0
				var_38_11.x = 0
				var_38_5.localEulerAngles = var_38_11
			end

			if arg_35_1.time_ >= var_38_6 + var_38_7 and arg_35_1.time_ < var_38_6 + var_38_7 + arg_38_0 then
				var_38_5.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_38_12 = manager.ui.mainCamera.transform.position - var_38_5.position

				var_38_5.forward = Vector3.New(var_38_12.x, var_38_12.y, var_38_12.z)

				local var_38_13 = var_38_5.localEulerAngles

				var_38_13.z = 0
				var_38_13.x = 0
				var_38_5.localEulerAngles = var_38_13
			end

			local var_38_14 = arg_35_1.actors_["10044ui_story"]
			local var_38_15 = 0

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 and not isNil(var_38_14) and arg_35_1.var_.characterEffect10044ui_story == nil then
				arg_35_1.var_.characterEffect10044ui_story = var_38_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_16 = 0.2

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_16 and not isNil(var_38_14) then
				local var_38_17 = (arg_35_1.time_ - var_38_15) / var_38_16

				if arg_35_1.var_.characterEffect10044ui_story and not isNil(var_38_14) then
					arg_35_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_15 + var_38_16 and arg_35_1.time_ < var_38_15 + var_38_16 + arg_38_0 and not isNil(var_38_14) and arg_35_1.var_.characterEffect10044ui_story then
				arg_35_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_38_18 = 0

			if var_38_18 < arg_35_1.time_ and arg_35_1.time_ <= var_38_18 + arg_38_0 then
				arg_35_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_38_19 = 0

			if var_38_19 < arg_35_1.time_ and arg_35_1.time_ <= var_38_19 + arg_38_0 then
				arg_35_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_38_20 = 0
			local var_38_21 = 0.125

			if var_38_20 < arg_35_1.time_ and arg_35_1.time_ <= var_38_20 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_22 = arg_35_1:FormatText(StoryNameCfg[380].name)

				arg_35_1.leftNameTxt_.text = var_38_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_23 = arg_35_1:GetWordFromCfg(120111008)
				local var_38_24 = arg_35_1:FormatText(var_38_23.content)

				arg_35_1.text_.text = var_38_24

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_25 = 5
				local var_38_26 = utf8.len(var_38_24)
				local var_38_27 = var_38_25 <= 0 and var_38_21 or var_38_21 * (var_38_26 / var_38_25)

				if var_38_27 > 0 and var_38_21 < var_38_27 then
					arg_35_1.talkMaxDuration = var_38_27

					if var_38_27 + var_38_20 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_27 + var_38_20
					end
				end

				arg_35_1.text_.text = var_38_24
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111008", "story_v_out_120111.awb") ~= 0 then
					local var_38_28 = manager.audio:GetVoiceLength("story_v_out_120111", "120111008", "story_v_out_120111.awb") / 1000

					if var_38_28 + var_38_20 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_28 + var_38_20
					end

					if var_38_23.prefab_name ~= "" and arg_35_1.actors_[var_38_23.prefab_name] ~= nil then
						local var_38_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_23.prefab_name].transform, "story_v_out_120111", "120111008", "story_v_out_120111.awb")

						arg_35_1:RecordAudio("120111008", var_38_29)
						arg_35_1:RecordAudio("120111008", var_38_29)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_120111", "120111008", "story_v_out_120111.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_120111", "120111008", "story_v_out_120111.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_30 = math.max(var_38_21, arg_35_1.talkMaxDuration)

			if var_38_20 <= arg_35_1.time_ and arg_35_1.time_ < var_38_20 + var_38_30 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_20) / var_38_30

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_20 + var_38_30 and arg_35_1.time_ < var_38_20 + var_38_30 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play120111009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 120111009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play120111010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["10044ui_story"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos10044ui_story = var_42_0.localPosition
			end

			local var_42_2 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2
				local var_42_4 = Vector3.New(0, 100, 0)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10044ui_story, var_42_4, var_42_3)

				local var_42_5 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_5.x, var_42_5.y, var_42_5.z)

				local var_42_6 = var_42_0.localEulerAngles

				var_42_6.z = 0
				var_42_6.x = 0
				var_42_0.localEulerAngles = var_42_6
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(0, 100, 0)

				local var_42_7 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_7.x, var_42_7.y, var_42_7.z)

				local var_42_8 = var_42_0.localEulerAngles

				var_42_8.z = 0
				var_42_8.x = 0
				var_42_0.localEulerAngles = var_42_8
			end

			local var_42_9 = 0
			local var_42_10 = 1

			if var_42_9 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_11 = arg_39_1:GetWordFromCfg(120111009)
				local var_42_12 = arg_39_1:FormatText(var_42_11.content)

				arg_39_1.text_.text = var_42_12

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 40
				local var_42_14 = utf8.len(var_42_12)
				local var_42_15 = var_42_13 <= 0 and var_42_10 or var_42_10 * (var_42_14 / var_42_13)

				if var_42_15 > 0 and var_42_10 < var_42_15 then
					arg_39_1.talkMaxDuration = var_42_15

					if var_42_15 + var_42_9 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_15 + var_42_9
					end
				end

				arg_39_1.text_.text = var_42_12
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_10, arg_39_1.talkMaxDuration)

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_9) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_9 + var_42_16 and arg_39_1.time_ < var_42_9 + var_42_16 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play120111010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 120111010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play120111011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.7

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

				local var_46_3 = arg_43_1:GetWordFromCfg(120111010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 28
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
	Play120111011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 120111011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play120111012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 1.325

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_2 = arg_47_1:GetWordFromCfg(120111011)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 53
				local var_50_5 = utf8.len(var_50_3)
				local var_50_6 = var_50_4 <= 0 and var_50_1 or var_50_1 * (var_50_5 / var_50_4)

				if var_50_6 > 0 and var_50_1 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6

					if var_50_6 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_7 and arg_47_1.time_ < var_50_0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play120111012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 120111012
		arg_51_1.duration_ = 8.3

		local var_51_0 = {
			zh = 4.1,
			ja = 8.3
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
				arg_51_0:Play120111013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1184ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1184ui_story = var_54_0.localPosition

				local var_54_2 = "1184ui_story"

				arg_51_1:ShowWeapon(arg_51_1.var_[var_54_2 .. "Animator"].transform, true)
			end

			local var_54_3 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_3 then
				local var_54_4 = (arg_51_1.time_ - var_54_1) / var_54_3
				local var_54_5 = Vector3.New(0, -0.97, -6)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1184ui_story, var_54_5, var_54_4)

				local var_54_6 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_6.x, var_54_6.y, var_54_6.z)

				local var_54_7 = var_54_0.localEulerAngles

				var_54_7.z = 0
				var_54_7.x = 0
				var_54_0.localEulerAngles = var_54_7
			end

			if arg_51_1.time_ >= var_54_1 + var_54_3 and arg_51_1.time_ < var_54_1 + var_54_3 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_54_8 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_8.x, var_54_8.y, var_54_8.z)

				local var_54_9 = var_54_0.localEulerAngles

				var_54_9.z = 0
				var_54_9.x = 0
				var_54_0.localEulerAngles = var_54_9
			end

			local var_54_10 = arg_51_1.actors_["1184ui_story"]
			local var_54_11 = 0

			if var_54_11 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 and not isNil(var_54_10) and arg_51_1.var_.characterEffect1184ui_story == nil then
				arg_51_1.var_.characterEffect1184ui_story = var_54_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_12 = 0.2

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_12 and not isNil(var_54_10) then
				local var_54_13 = (arg_51_1.time_ - var_54_11) / var_54_12

				if arg_51_1.var_.characterEffect1184ui_story and not isNil(var_54_10) then
					arg_51_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_11 + var_54_12 and arg_51_1.time_ < var_54_11 + var_54_12 + arg_54_0 and not isNil(var_54_10) and arg_51_1.var_.characterEffect1184ui_story then
				arg_51_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_54_14 = 0

			if var_54_14 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 then
				arg_51_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_54_15 = 0

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_54_16 = 0
			local var_54_17 = 0.475

			if var_54_16 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_18 = arg_51_1:FormatText(StoryNameCfg[6].name)

				arg_51_1.leftNameTxt_.text = var_54_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_19 = arg_51_1:GetWordFromCfg(120111012)
				local var_54_20 = arg_51_1:FormatText(var_54_19.content)

				arg_51_1.text_.text = var_54_20

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_21 = 19
				local var_54_22 = utf8.len(var_54_20)
				local var_54_23 = var_54_21 <= 0 and var_54_17 or var_54_17 * (var_54_22 / var_54_21)

				if var_54_23 > 0 and var_54_17 < var_54_23 then
					arg_51_1.talkMaxDuration = var_54_23

					if var_54_23 + var_54_16 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_23 + var_54_16
					end
				end

				arg_51_1.text_.text = var_54_20
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111012", "story_v_out_120111.awb") ~= 0 then
					local var_54_24 = manager.audio:GetVoiceLength("story_v_out_120111", "120111012", "story_v_out_120111.awb") / 1000

					if var_54_24 + var_54_16 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_24 + var_54_16
					end

					if var_54_19.prefab_name ~= "" and arg_51_1.actors_[var_54_19.prefab_name] ~= nil then
						local var_54_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_19.prefab_name].transform, "story_v_out_120111", "120111012", "story_v_out_120111.awb")

						arg_51_1:RecordAudio("120111012", var_54_25)
						arg_51_1:RecordAudio("120111012", var_54_25)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_120111", "120111012", "story_v_out_120111.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_120111", "120111012", "story_v_out_120111.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_26 = math.max(var_54_17, arg_51_1.talkMaxDuration)

			if var_54_16 <= arg_51_1.time_ and arg_51_1.time_ < var_54_16 + var_54_26 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_16) / var_54_26

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_16 + var_54_26 and arg_51_1.time_ < var_54_16 + var_54_26 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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

		arg_51_1:InitPlayNodeList()
	end,
	Play120111013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 120111013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play120111014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1184ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1184ui_story = var_58_0.localPosition

				local var_58_2 = "1184ui_story"

				arg_55_1:ShowWeapon(arg_55_1.var_[var_58_2 .. "Animator"].transform, false)
			end

			local var_58_3 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_3 then
				local var_58_4 = (arg_55_1.time_ - var_58_1) / var_58_3
				local var_58_5 = Vector3.New(0, 100, 0)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1184ui_story, var_58_5, var_58_4)

				local var_58_6 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_6.x, var_58_6.y, var_58_6.z)

				local var_58_7 = var_58_0.localEulerAngles

				var_58_7.z = 0
				var_58_7.x = 0
				var_58_0.localEulerAngles = var_58_7
			end

			if arg_55_1.time_ >= var_58_1 + var_58_3 and arg_55_1.time_ < var_58_1 + var_58_3 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, 100, 0)

				local var_58_8 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_8.x, var_58_8.y, var_58_8.z)

				local var_58_9 = var_58_0.localEulerAngles

				var_58_9.z = 0
				var_58_9.x = 0
				var_58_0.localEulerAngles = var_58_9
			end

			local var_58_10 = arg_55_1.bgs_.J04f.transform
			local var_58_11 = 0

			if var_58_11 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				arg_55_1.var_.moveOldPosJ04f = var_58_10.localPosition
			end

			local var_58_12 = 2.1

			if var_58_11 <= arg_55_1.time_ and arg_55_1.time_ < var_58_11 + var_58_12 then
				local var_58_13 = (arg_55_1.time_ - var_58_11) / var_58_12
				local var_58_14 = Vector3.New(0, 1, 9.5)

				var_58_10.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPosJ04f, var_58_14, var_58_13)
			end

			if arg_55_1.time_ >= var_58_11 + var_58_12 and arg_55_1.time_ < var_58_11 + var_58_12 + arg_58_0 then
				var_58_10.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_58_15 = 0

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			local var_58_16 = 2.1

			if arg_55_1.time_ >= var_58_15 + var_58_16 and arg_55_1.time_ < var_58_15 + var_58_16 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end

			local var_58_17 = 0
			local var_58_18 = 0.475

			if var_58_17 < arg_55_1.time_ and arg_55_1.time_ <= var_58_17 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_19 = arg_55_1:GetWordFromCfg(120111013)
				local var_58_20 = arg_55_1:FormatText(var_58_19.content)

				arg_55_1.text_.text = var_58_20

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_21 = 19
				local var_58_22 = utf8.len(var_58_20)
				local var_58_23 = var_58_21 <= 0 and var_58_18 or var_58_18 * (var_58_22 / var_58_21)

				if var_58_23 > 0 and var_58_18 < var_58_23 then
					arg_55_1.talkMaxDuration = var_58_23

					if var_58_23 + var_58_17 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_17
					end
				end

				arg_55_1.text_.text = var_58_20
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_24 = math.max(var_58_18, arg_55_1.talkMaxDuration)

			if var_58_17 <= arg_55_1.time_ and arg_55_1.time_ < var_58_17 + var_58_24 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_17) / var_58_24

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_17 + var_58_24 and arg_55_1.time_ < var_58_17 + var_58_24 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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
				actorName = "J04f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play120111014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 120111014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play120111015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 1.25

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(120111014)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 50
				local var_62_5 = utf8.len(var_62_3)
				local var_62_6 = var_62_4 <= 0 and var_62_1 or var_62_1 * (var_62_5 / var_62_4)

				if var_62_6 > 0 and var_62_1 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_7 and arg_59_1.time_ < var_62_0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play120111015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 120111015
		arg_63_1.duration_ = 3.47

		local var_63_0 = {
			zh = 1.999999999999,
			ja = 3.466
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
				arg_63_0:Play120111016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1184ui_story"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos1184ui_story = var_66_0.localPosition
			end

			local var_66_2 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2
				local var_66_4 = Vector3.New(0, -0.97, -6)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1184ui_story, var_66_4, var_66_3)

				local var_66_5 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_5.x, var_66_5.y, var_66_5.z)

				local var_66_6 = var_66_0.localEulerAngles

				var_66_6.z = 0
				var_66_6.x = 0
				var_66_0.localEulerAngles = var_66_6
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_66_7 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_7.x, var_66_7.y, var_66_7.z)

				local var_66_8 = var_66_0.localEulerAngles

				var_66_8.z = 0
				var_66_8.x = 0
				var_66_0.localEulerAngles = var_66_8
			end

			local var_66_9 = arg_63_1.actors_["1184ui_story"]
			local var_66_10 = 0

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 and not isNil(var_66_9) and arg_63_1.var_.characterEffect1184ui_story == nil then
				arg_63_1.var_.characterEffect1184ui_story = var_66_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_11 = 0.2

			if var_66_10 <= arg_63_1.time_ and arg_63_1.time_ < var_66_10 + var_66_11 and not isNil(var_66_9) then
				local var_66_12 = (arg_63_1.time_ - var_66_10) / var_66_11

				if arg_63_1.var_.characterEffect1184ui_story and not isNil(var_66_9) then
					arg_63_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_10 + var_66_11 and arg_63_1.time_ < var_66_10 + var_66_11 + arg_66_0 and not isNil(var_66_9) and arg_63_1.var_.characterEffect1184ui_story then
				arg_63_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_66_13 = 0

			if var_66_13 < arg_63_1.time_ and arg_63_1.time_ <= var_66_13 + arg_66_0 then
				arg_63_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_66_14 = 0

			if var_66_14 < arg_63_1.time_ and arg_63_1.time_ <= var_66_14 + arg_66_0 then
				arg_63_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_66_15 = 0
			local var_66_16 = 0.225

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_17 = arg_63_1:FormatText(StoryNameCfg[6].name)

				arg_63_1.leftNameTxt_.text = var_66_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_18 = arg_63_1:GetWordFromCfg(120111015)
				local var_66_19 = arg_63_1:FormatText(var_66_18.content)

				arg_63_1.text_.text = var_66_19

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_20 = 9
				local var_66_21 = utf8.len(var_66_19)
				local var_66_22 = var_66_20 <= 0 and var_66_16 or var_66_16 * (var_66_21 / var_66_20)

				if var_66_22 > 0 and var_66_16 < var_66_22 then
					arg_63_1.talkMaxDuration = var_66_22

					if var_66_22 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_22 + var_66_15
					end
				end

				arg_63_1.text_.text = var_66_19
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111015", "story_v_out_120111.awb") ~= 0 then
					local var_66_23 = manager.audio:GetVoiceLength("story_v_out_120111", "120111015", "story_v_out_120111.awb") / 1000

					if var_66_23 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_15
					end

					if var_66_18.prefab_name ~= "" and arg_63_1.actors_[var_66_18.prefab_name] ~= nil then
						local var_66_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_18.prefab_name].transform, "story_v_out_120111", "120111015", "story_v_out_120111.awb")

						arg_63_1:RecordAudio("120111015", var_66_24)
						arg_63_1:RecordAudio("120111015", var_66_24)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_120111", "120111015", "story_v_out_120111.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_120111", "120111015", "story_v_out_120111.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_25 = math.max(var_66_16, arg_63_1.talkMaxDuration)

			if var_66_15 <= arg_63_1.time_ and arg_63_1.time_ < var_66_15 + var_66_25 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_15) / var_66_25

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_15 + var_66_25 and arg_63_1.time_ < var_66_15 + var_66_25 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play120111016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 120111016
		arg_67_1.duration_ = 8.2

		local var_67_0 = {
			zh = 7.333,
			ja = 8.2
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
				arg_67_0:Play120111017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1184ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1184ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, 100, 0)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1184ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, 100, 0)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["10044ui_story"].transform
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1.var_.moveOldPos10044ui_story = var_70_9.localPosition
			end

			local var_70_11 = 0.001

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11
				local var_70_13 = Vector3.New(0, -0.72, -6.3)

				var_70_9.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10044ui_story, var_70_13, var_70_12)

				local var_70_14 = manager.ui.mainCamera.transform.position - var_70_9.position

				var_70_9.forward = Vector3.New(var_70_14.x, var_70_14.y, var_70_14.z)

				local var_70_15 = var_70_9.localEulerAngles

				var_70_15.z = 0
				var_70_15.x = 0
				var_70_9.localEulerAngles = var_70_15
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 then
				var_70_9.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_70_16 = manager.ui.mainCamera.transform.position - var_70_9.position

				var_70_9.forward = Vector3.New(var_70_16.x, var_70_16.y, var_70_16.z)

				local var_70_17 = var_70_9.localEulerAngles

				var_70_17.z = 0
				var_70_17.x = 0
				var_70_9.localEulerAngles = var_70_17
			end

			local var_70_18 = arg_67_1.actors_["10044ui_story"]
			local var_70_19 = 0

			if var_70_19 < arg_67_1.time_ and arg_67_1.time_ <= var_70_19 + arg_70_0 and not isNil(var_70_18) and arg_67_1.var_.characterEffect10044ui_story == nil then
				arg_67_1.var_.characterEffect10044ui_story = var_70_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_20 = 0.2

			if var_70_19 <= arg_67_1.time_ and arg_67_1.time_ < var_70_19 + var_70_20 and not isNil(var_70_18) then
				local var_70_21 = (arg_67_1.time_ - var_70_19) / var_70_20

				if arg_67_1.var_.characterEffect10044ui_story and not isNil(var_70_18) then
					arg_67_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_19 + var_70_20 and arg_67_1.time_ < var_70_19 + var_70_20 + arg_70_0 and not isNil(var_70_18) and arg_67_1.var_.characterEffect10044ui_story then
				arg_67_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_70_22 = 0

			if var_70_22 < arg_67_1.time_ and arg_67_1.time_ <= var_70_22 + arg_70_0 then
				arg_67_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_1")
			end

			local var_70_23 = 0

			if var_70_23 < arg_67_1.time_ and arg_67_1.time_ <= var_70_23 + arg_70_0 then
				arg_67_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_70_24 = 0
			local var_70_25 = 0.95

			if var_70_24 < arg_67_1.time_ and arg_67_1.time_ <= var_70_24 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_26 = arg_67_1:FormatText(StoryNameCfg[380].name)

				arg_67_1.leftNameTxt_.text = var_70_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_27 = arg_67_1:GetWordFromCfg(120111016)
				local var_70_28 = arg_67_1:FormatText(var_70_27.content)

				arg_67_1.text_.text = var_70_28

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_29 = 38
				local var_70_30 = utf8.len(var_70_28)
				local var_70_31 = var_70_29 <= 0 and var_70_25 or var_70_25 * (var_70_30 / var_70_29)

				if var_70_31 > 0 and var_70_25 < var_70_31 then
					arg_67_1.talkMaxDuration = var_70_31

					if var_70_31 + var_70_24 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_31 + var_70_24
					end
				end

				arg_67_1.text_.text = var_70_28
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111016", "story_v_out_120111.awb") ~= 0 then
					local var_70_32 = manager.audio:GetVoiceLength("story_v_out_120111", "120111016", "story_v_out_120111.awb") / 1000

					if var_70_32 + var_70_24 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_32 + var_70_24
					end

					if var_70_27.prefab_name ~= "" and arg_67_1.actors_[var_70_27.prefab_name] ~= nil then
						local var_70_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_27.prefab_name].transform, "story_v_out_120111", "120111016", "story_v_out_120111.awb")

						arg_67_1:RecordAudio("120111016", var_70_33)
						arg_67_1:RecordAudio("120111016", var_70_33)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_120111", "120111016", "story_v_out_120111.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_120111", "120111016", "story_v_out_120111.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_34 = math.max(var_70_25, arg_67_1.talkMaxDuration)

			if var_70_24 <= arg_67_1.time_ and arg_67_1.time_ < var_70_24 + var_70_34 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_24) / var_70_34

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_24 + var_70_34 and arg_67_1.time_ < var_70_24 + var_70_34 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play120111017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 120111017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play120111018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10044ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10044ui_story == nil then
				arg_71_1.var_.characterEffect10044ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect10044ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10044ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10044ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10044ui_story.fillRatio = var_74_5
			end

			local var_74_6 = 0

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_2")
			end

			local var_74_7 = 0
			local var_74_8 = 1.425

			if var_74_7 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_9 = arg_71_1:FormatText(StoryNameCfg[7].name)

				arg_71_1.leftNameTxt_.text = var_74_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_10 = arg_71_1:GetWordFromCfg(120111017)
				local var_74_11 = arg_71_1:FormatText(var_74_10.content)

				arg_71_1.text_.text = var_74_11

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_12 = 57
				local var_74_13 = utf8.len(var_74_11)
				local var_74_14 = var_74_12 <= 0 and var_74_8 or var_74_8 * (var_74_13 / var_74_12)

				if var_74_14 > 0 and var_74_8 < var_74_14 then
					arg_71_1.talkMaxDuration = var_74_14

					if var_74_14 + var_74_7 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_14 + var_74_7
					end
				end

				arg_71_1.text_.text = var_74_11
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_15 = math.max(var_74_8, arg_71_1.talkMaxDuration)

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_15 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_7) / var_74_15

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_7 + var_74_15 and arg_71_1.time_ < var_74_7 + var_74_15 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play120111018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 120111018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play120111019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.575

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[7].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:GetWordFromCfg(120111018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 23
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_8 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_8 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_8

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_8 and arg_75_1.time_ < var_78_0 + var_78_8 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play120111019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 120111019
		arg_79_1.duration_ = 9.03

		local var_79_0 = {
			zh = 7.3,
			ja = 9.033
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
				arg_79_0:Play120111020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10044ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10044ui_story == nil then
				arg_79_1.var_.characterEffect10044ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect10044ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10044ui_story then
				arg_79_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_82_4 = 0

			if var_82_4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action7_1")
			end

			local var_82_5 = 0

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_82_6 = 0
			local var_82_7 = 0.675

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[380].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_9 = arg_79_1:GetWordFromCfg(120111019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 27
				local var_82_12 = utf8.len(var_82_10)
				local var_82_13 = var_82_11 <= 0 and var_82_7 or var_82_7 * (var_82_12 / var_82_11)

				if var_82_13 > 0 and var_82_7 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111019", "story_v_out_120111.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_120111", "120111019", "story_v_out_120111.awb") / 1000

					if var_82_14 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_6
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_out_120111", "120111019", "story_v_out_120111.awb")

						arg_79_1:RecordAudio("120111019", var_82_15)
						arg_79_1:RecordAudio("120111019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_120111", "120111019", "story_v_out_120111.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_120111", "120111019", "story_v_out_120111.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_16 and arg_79_1.time_ < var_82_6 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play120111020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 120111020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play120111021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10044ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10044ui_story == nil then
				arg_83_1.var_.characterEffect10044ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect10044ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10044ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10044ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10044ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0
			local var_86_7 = 0.8

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_8 = arg_83_1:FormatText(StoryNameCfg[7].name)

				arg_83_1.leftNameTxt_.text = var_86_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_9 = arg_83_1:GetWordFromCfg(120111020)
				local var_86_10 = arg_83_1:FormatText(var_86_9.content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 31
				local var_86_12 = utf8.len(var_86_10)
				local var_86_13 = var_86_11 <= 0 and var_86_7 or var_86_7 * (var_86_12 / var_86_11)

				if var_86_13 > 0 and var_86_7 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_14 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_14 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_14

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_14 and arg_83_1.time_ < var_86_6 + var_86_14 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play120111021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 120111021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play120111022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.425

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[7].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(120111021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 17
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_8 and arg_87_1.time_ < var_90_0 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play120111022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 120111022
		arg_91_1.duration_ = 6.4

		local var_91_0 = {
			zh = 3.333,
			ja = 6.4
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
				arg_91_0:Play120111023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10044ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos10044ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10044ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, 100, 0)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = arg_91_1.actors_["1184ui_story"].transform
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
				arg_91_1.var_.moveOldPos1184ui_story = var_94_9.localPosition
			end

			local var_94_11 = 0.001

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11
				local var_94_13 = Vector3.New(0, -0.97, -6)

				var_94_9.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1184ui_story, var_94_13, var_94_12)

				local var_94_14 = manager.ui.mainCamera.transform.position - var_94_9.position

				var_94_9.forward = Vector3.New(var_94_14.x, var_94_14.y, var_94_14.z)

				local var_94_15 = var_94_9.localEulerAngles

				var_94_15.z = 0
				var_94_15.x = 0
				var_94_9.localEulerAngles = var_94_15
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 then
				var_94_9.localPosition = Vector3.New(0, -0.97, -6)

				local var_94_16 = manager.ui.mainCamera.transform.position - var_94_9.position

				var_94_9.forward = Vector3.New(var_94_16.x, var_94_16.y, var_94_16.z)

				local var_94_17 = var_94_9.localEulerAngles

				var_94_17.z = 0
				var_94_17.x = 0
				var_94_9.localEulerAngles = var_94_17
			end

			local var_94_18 = arg_91_1.actors_["1184ui_story"]
			local var_94_19 = 0

			if var_94_19 < arg_91_1.time_ and arg_91_1.time_ <= var_94_19 + arg_94_0 and not isNil(var_94_18) and arg_91_1.var_.characterEffect1184ui_story == nil then
				arg_91_1.var_.characterEffect1184ui_story = var_94_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_20 = 0.2

			if var_94_19 <= arg_91_1.time_ and arg_91_1.time_ < var_94_19 + var_94_20 and not isNil(var_94_18) then
				local var_94_21 = (arg_91_1.time_ - var_94_19) / var_94_20

				if arg_91_1.var_.characterEffect1184ui_story and not isNil(var_94_18) then
					arg_91_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_19 + var_94_20 and arg_91_1.time_ < var_94_19 + var_94_20 + arg_94_0 and not isNil(var_94_18) and arg_91_1.var_.characterEffect1184ui_story then
				arg_91_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_94_22 = 0

			if var_94_22 < arg_91_1.time_ and arg_91_1.time_ <= var_94_22 + arg_94_0 then
				arg_91_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_94_23 = 0

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_94_24 = 0
			local var_94_25 = 0.475

			if var_94_24 < arg_91_1.time_ and arg_91_1.time_ <= var_94_24 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_26 = arg_91_1:FormatText(StoryNameCfg[6].name)

				arg_91_1.leftNameTxt_.text = var_94_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_27 = arg_91_1:GetWordFromCfg(120111022)
				local var_94_28 = arg_91_1:FormatText(var_94_27.content)

				arg_91_1.text_.text = var_94_28

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_29 = 19
				local var_94_30 = utf8.len(var_94_28)
				local var_94_31 = var_94_29 <= 0 and var_94_25 or var_94_25 * (var_94_30 / var_94_29)

				if var_94_31 > 0 and var_94_25 < var_94_31 then
					arg_91_1.talkMaxDuration = var_94_31

					if var_94_31 + var_94_24 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_31 + var_94_24
					end
				end

				arg_91_1.text_.text = var_94_28
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111022", "story_v_out_120111.awb") ~= 0 then
					local var_94_32 = manager.audio:GetVoiceLength("story_v_out_120111", "120111022", "story_v_out_120111.awb") / 1000

					if var_94_32 + var_94_24 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_32 + var_94_24
					end

					if var_94_27.prefab_name ~= "" and arg_91_1.actors_[var_94_27.prefab_name] ~= nil then
						local var_94_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_27.prefab_name].transform, "story_v_out_120111", "120111022", "story_v_out_120111.awb")

						arg_91_1:RecordAudio("120111022", var_94_33)
						arg_91_1:RecordAudio("120111022", var_94_33)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_120111", "120111022", "story_v_out_120111.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_120111", "120111022", "story_v_out_120111.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_34 = math.max(var_94_25, arg_91_1.talkMaxDuration)

			if var_94_24 <= arg_91_1.time_ and arg_91_1.time_ < var_94_24 + var_94_34 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_24) / var_94_34

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_24 + var_94_34 and arg_91_1.time_ < var_94_24 + var_94_34 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play120111023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 120111023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play120111024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1184ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1184ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, 100, 0)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1184ui_story, var_98_4, var_98_3)

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

			local var_98_9 = 0
			local var_98_10 = 0.975

			if var_98_9 < arg_95_1.time_ and arg_95_1.time_ <= var_98_9 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_11 = arg_95_1:GetWordFromCfg(120111023)
				local var_98_12 = arg_95_1:FormatText(var_98_11.content)

				arg_95_1.text_.text = var_98_12

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_13 = 39
				local var_98_14 = utf8.len(var_98_12)
				local var_98_15 = var_98_13 <= 0 and var_98_10 or var_98_10 * (var_98_14 / var_98_13)

				if var_98_15 > 0 and var_98_10 < var_98_15 then
					arg_95_1.talkMaxDuration = var_98_15

					if var_98_15 + var_98_9 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_15 + var_98_9
					end
				end

				arg_95_1.text_.text = var_98_12
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_10, arg_95_1.talkMaxDuration)

			if var_98_9 <= arg_95_1.time_ and arg_95_1.time_ < var_98_9 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_9) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_9 + var_98_16 and arg_95_1.time_ < var_98_9 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play120111024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 120111024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play120111025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.125

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(120111024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 45
				local var_102_5 = utf8.len(var_102_3)
				local var_102_6 = var_102_4 <= 0 and var_102_1 or var_102_1 * (var_102_5 / var_102_4)

				if var_102_6 > 0 and var_102_1 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_7 and arg_99_1.time_ < var_102_0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play120111025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 120111025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play120111026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.175

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[7].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:GetWordFromCfg(120111025)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 7
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_8 and arg_103_1.time_ < var_106_0 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play120111026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 120111026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play120111027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				local var_110_2 = "play"
				local var_110_3 = "effect"

				arg_107_1:AudioAction(var_110_2, var_110_3, "se_story_120_00", "se_story_120_00_scan", "")
			end

			local var_110_4 = 0
			local var_110_5 = 1.075

			if var_110_4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(120111026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_8 = 43
				local var_110_9 = utf8.len(var_110_7)
				local var_110_10 = var_110_8 <= 0 and var_110_5 or var_110_5 * (var_110_9 / var_110_8)

				if var_110_10 > 0 and var_110_5 < var_110_10 then
					arg_107_1.talkMaxDuration = var_110_10

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_11 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_11 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_11

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_11 and arg_107_1.time_ < var_110_4 + var_110_11 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play120111027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 120111027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play120111028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.875

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(120111027)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 35
				local var_114_5 = utf8.len(var_114_3)
				local var_114_6 = var_114_4 <= 0 and var_114_1 or var_114_1 * (var_114_5 / var_114_4)

				if var_114_6 > 0 and var_114_1 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_7 and arg_111_1.time_ < var_114_0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play120111028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 120111028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play120111029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.125

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[7].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:GetWordFromCfg(120111028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 5
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_8 and arg_115_1.time_ < var_118_0 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play120111029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 120111029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play120111030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 1.05

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:GetWordFromCfg(120111029)
				local var_122_3 = arg_119_1:FormatText(var_122_2.content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 42
				local var_122_5 = utf8.len(var_122_3)
				local var_122_6 = var_122_4 <= 0 and var_122_1 or var_122_1 * (var_122_5 / var_122_4)

				if var_122_6 > 0 and var_122_1 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_7 and arg_119_1.time_ < var_122_0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play120111030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 120111030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play120111031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.25

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[7].name)

				arg_123_1.leftNameTxt_.text = var_126_2

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

				local var_126_3 = arg_123_1:GetWordFromCfg(120111030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 10
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_8 and arg_123_1.time_ < var_126_0 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play120111031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 120111031
		arg_127_1.duration_ = 2

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play120111032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1184ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1184ui_story == nil then
				arg_127_1.var_.characterEffect1184ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1184ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1184ui_story then
				arg_127_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_130_4 = arg_127_1.actors_["1184ui_story"].transform
			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.var_.moveOldPos1184ui_story = var_130_4.localPosition

				local var_130_6 = "1184ui_story"

				arg_127_1:ShowWeapon(arg_127_1.var_[var_130_6 .. "Animator"].transform, true)
			end

			local var_130_7 = 0.001

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_7 then
				local var_130_8 = (arg_127_1.time_ - var_130_5) / var_130_7
				local var_130_9 = Vector3.New(0, -0.97, -6)

				var_130_4.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1184ui_story, var_130_9, var_130_8)

				local var_130_10 = manager.ui.mainCamera.transform.position - var_130_4.position

				var_130_4.forward = Vector3.New(var_130_10.x, var_130_10.y, var_130_10.z)

				local var_130_11 = var_130_4.localEulerAngles

				var_130_11.z = 0
				var_130_11.x = 0
				var_130_4.localEulerAngles = var_130_11
			end

			if arg_127_1.time_ >= var_130_5 + var_130_7 and arg_127_1.time_ < var_130_5 + var_130_7 + arg_130_0 then
				var_130_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_130_12 = manager.ui.mainCamera.transform.position - var_130_4.position

				var_130_4.forward = Vector3.New(var_130_12.x, var_130_12.y, var_130_12.z)

				local var_130_13 = var_130_4.localEulerAngles

				var_130_13.z = 0
				var_130_13.x = 0
				var_130_4.localEulerAngles = var_130_13
			end

			local var_130_14 = 0

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_130_15 = 0

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_130_16 = 0
			local var_130_17 = 1

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				local var_130_18 = "play"
				local var_130_19 = "effect"

				arg_127_1:AudioAction(var_130_18, var_130_19, "se_story_120_00", "se_story_120_00_sword03", "")
			end

			local var_130_20 = 0
			local var_130_21 = 0.1

			if var_130_20 < arg_127_1.time_ and arg_127_1.time_ <= var_130_20 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_22 = arg_127_1:FormatText(StoryNameCfg[6].name)

				arg_127_1.leftNameTxt_.text = var_130_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_23 = arg_127_1:GetWordFromCfg(120111031)
				local var_130_24 = arg_127_1:FormatText(var_130_23.content)

				arg_127_1.text_.text = var_130_24

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_25 = 4
				local var_130_26 = utf8.len(var_130_24)
				local var_130_27 = var_130_25 <= 0 and var_130_21 or var_130_21 * (var_130_26 / var_130_25)

				if var_130_27 > 0 and var_130_21 < var_130_27 then
					arg_127_1.talkMaxDuration = var_130_27

					if var_130_27 + var_130_20 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_27 + var_130_20
					end
				end

				arg_127_1.text_.text = var_130_24
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111031", "story_v_out_120111.awb") ~= 0 then
					local var_130_28 = manager.audio:GetVoiceLength("story_v_out_120111", "120111031", "story_v_out_120111.awb") / 1000

					if var_130_28 + var_130_20 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_28 + var_130_20
					end

					if var_130_23.prefab_name ~= "" and arg_127_1.actors_[var_130_23.prefab_name] ~= nil then
						local var_130_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_23.prefab_name].transform, "story_v_out_120111", "120111031", "story_v_out_120111.awb")

						arg_127_1:RecordAudio("120111031", var_130_29)
						arg_127_1:RecordAudio("120111031", var_130_29)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_120111", "120111031", "story_v_out_120111.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_120111", "120111031", "story_v_out_120111.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_30 = math.max(var_130_21, arg_127_1.talkMaxDuration)

			if var_130_20 <= arg_127_1.time_ and arg_127_1.time_ < var_130_20 + var_130_30 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_20) / var_130_30

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_20 + var_130_30 and arg_127_1.time_ < var_130_20 + var_130_30 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play120111032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 120111032
		arg_131_1.duration_ = 3.37

		local var_131_0 = {
			zh = 3.366,
			ja = 3.3
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play120111033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10044ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10044ui_story == nil then
				arg_131_1.var_.characterEffect10044ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect10044ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10044ui_story then
				arg_131_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_134_4 = arg_131_1.actors_["1184ui_story"].transform
			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.var_.moveOldPos1184ui_story = var_134_4.localPosition
			end

			local var_134_6 = 0.001

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_6 then
				local var_134_7 = (arg_131_1.time_ - var_134_5) / var_134_6
				local var_134_8 = Vector3.New(0, 100, 0)

				var_134_4.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1184ui_story, var_134_8, var_134_7)

				local var_134_9 = manager.ui.mainCamera.transform.position - var_134_4.position

				var_134_4.forward = Vector3.New(var_134_9.x, var_134_9.y, var_134_9.z)

				local var_134_10 = var_134_4.localEulerAngles

				var_134_10.z = 0
				var_134_10.x = 0
				var_134_4.localEulerAngles = var_134_10
			end

			if arg_131_1.time_ >= var_134_5 + var_134_6 and arg_131_1.time_ < var_134_5 + var_134_6 + arg_134_0 then
				var_134_4.localPosition = Vector3.New(0, 100, 0)

				local var_134_11 = manager.ui.mainCamera.transform.position - var_134_4.position

				var_134_4.forward = Vector3.New(var_134_11.x, var_134_11.y, var_134_11.z)

				local var_134_12 = var_134_4.localEulerAngles

				var_134_12.z = 0
				var_134_12.x = 0
				var_134_4.localEulerAngles = var_134_12
			end

			local var_134_13 = arg_131_1.actors_["10044ui_story"].transform
			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1.var_.moveOldPos10044ui_story = var_134_13.localPosition
			end

			local var_134_15 = 0.001

			if var_134_14 <= arg_131_1.time_ and arg_131_1.time_ < var_134_14 + var_134_15 then
				local var_134_16 = (arg_131_1.time_ - var_134_14) / var_134_15
				local var_134_17 = Vector3.New(0, -0.72, -6.3)

				var_134_13.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10044ui_story, var_134_17, var_134_16)

				local var_134_18 = manager.ui.mainCamera.transform.position - var_134_13.position

				var_134_13.forward = Vector3.New(var_134_18.x, var_134_18.y, var_134_18.z)

				local var_134_19 = var_134_13.localEulerAngles

				var_134_19.z = 0
				var_134_19.x = 0
				var_134_13.localEulerAngles = var_134_19
			end

			if arg_131_1.time_ >= var_134_14 + var_134_15 and arg_131_1.time_ < var_134_14 + var_134_15 + arg_134_0 then
				var_134_13.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_134_20 = manager.ui.mainCamera.transform.position - var_134_13.position

				var_134_13.forward = Vector3.New(var_134_20.x, var_134_20.y, var_134_20.z)

				local var_134_21 = var_134_13.localEulerAngles

				var_134_21.z = 0
				var_134_21.x = 0
				var_134_13.localEulerAngles = var_134_21
			end

			local var_134_22 = 0

			if var_134_22 < arg_131_1.time_ and arg_131_1.time_ <= var_134_22 + arg_134_0 then
				arg_131_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action6_1")
			end

			local var_134_23 = 0

			if var_134_23 < arg_131_1.time_ and arg_131_1.time_ <= var_134_23 + arg_134_0 then
				arg_131_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_134_24 = 0
			local var_134_25 = 0.25

			if var_134_24 < arg_131_1.time_ and arg_131_1.time_ <= var_134_24 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_26 = arg_131_1:FormatText(StoryNameCfg[387].name)

				arg_131_1.leftNameTxt_.text = var_134_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_27 = arg_131_1:GetWordFromCfg(120111032)
				local var_134_28 = arg_131_1:FormatText(var_134_27.content)

				arg_131_1.text_.text = var_134_28

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_29 = 10
				local var_134_30 = utf8.len(var_134_28)
				local var_134_31 = var_134_29 <= 0 and var_134_25 or var_134_25 * (var_134_30 / var_134_29)

				if var_134_31 > 0 and var_134_25 < var_134_31 then
					arg_131_1.talkMaxDuration = var_134_31

					if var_134_31 + var_134_24 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_31 + var_134_24
					end
				end

				arg_131_1.text_.text = var_134_28
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111032", "story_v_out_120111.awb") ~= 0 then
					local var_134_32 = manager.audio:GetVoiceLength("story_v_out_120111", "120111032", "story_v_out_120111.awb") / 1000

					if var_134_32 + var_134_24 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_32 + var_134_24
					end

					if var_134_27.prefab_name ~= "" and arg_131_1.actors_[var_134_27.prefab_name] ~= nil then
						local var_134_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_27.prefab_name].transform, "story_v_out_120111", "120111032", "story_v_out_120111.awb")

						arg_131_1:RecordAudio("120111032", var_134_33)
						arg_131_1:RecordAudio("120111032", var_134_33)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_120111", "120111032", "story_v_out_120111.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_120111", "120111032", "story_v_out_120111.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_34 = math.max(var_134_25, arg_131_1.talkMaxDuration)

			if var_134_24 <= arg_131_1.time_ and arg_131_1.time_ < var_134_24 + var_134_34 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_24) / var_134_34

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_24 + var_134_34 and arg_131_1.time_ < var_134_24 + var_134_34 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play120111033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 120111033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play120111034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1184ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1184ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, 100, 0)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1184ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, 100, 0)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = arg_135_1.actors_["10044ui_story"].transform
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.var_.moveOldPos10044ui_story = var_138_9.localPosition
			end

			local var_138_11 = 0.001

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11
				local var_138_13 = Vector3.New(0, 100, 0)

				var_138_9.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10044ui_story, var_138_13, var_138_12)

				local var_138_14 = manager.ui.mainCamera.transform.position - var_138_9.position

				var_138_9.forward = Vector3.New(var_138_14.x, var_138_14.y, var_138_14.z)

				local var_138_15 = var_138_9.localEulerAngles

				var_138_15.z = 0
				var_138_15.x = 0
				var_138_9.localEulerAngles = var_138_15
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 then
				var_138_9.localPosition = Vector3.New(0, 100, 0)

				local var_138_16 = manager.ui.mainCamera.transform.position - var_138_9.position

				var_138_9.forward = Vector3.New(var_138_16.x, var_138_16.y, var_138_16.z)

				local var_138_17 = var_138_9.localEulerAngles

				var_138_17.z = 0
				var_138_17.x = 0
				var_138_9.localEulerAngles = var_138_17
			end

			local var_138_18 = 0
			local var_138_19 = 0.775

			if var_138_18 < arg_135_1.time_ and arg_135_1.time_ <= var_138_18 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_20 = arg_135_1:GetWordFromCfg(120111033)
				local var_138_21 = arg_135_1:FormatText(var_138_20.content)

				arg_135_1.text_.text = var_138_21

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_22 = 31
				local var_138_23 = utf8.len(var_138_21)
				local var_138_24 = var_138_22 <= 0 and var_138_19 or var_138_19 * (var_138_23 / var_138_22)

				if var_138_24 > 0 and var_138_19 < var_138_24 then
					arg_135_1.talkMaxDuration = var_138_24

					if var_138_24 + var_138_18 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_24 + var_138_18
					end
				end

				arg_135_1.text_.text = var_138_21
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_25 = math.max(var_138_19, arg_135_1.talkMaxDuration)

			if var_138_18 <= arg_135_1.time_ and arg_135_1.time_ < var_138_18 + var_138_25 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_18) / var_138_25

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_18 + var_138_25 and arg_135_1.time_ < var_138_18 + var_138_25 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play120111034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 120111034
		arg_139_1.duration_ = 5.6

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play120111035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 1

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				local var_142_2 = "play"
				local var_142_3 = "effect"

				arg_139_1:AudioAction(var_142_2, var_142_3, "se_story_120_00", "se_story_120_00_hurt", "")
			end

			local var_142_4 = manager.ui.mainCamera.transform
			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.var_.shakeOldPos = var_142_4.localPosition
			end

			local var_142_6 = 0.6

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_6 then
				local var_142_7 = (arg_139_1.time_ - var_142_5) / 0.066
				local var_142_8, var_142_9 = math.modf(var_142_7)

				var_142_4.localPosition = Vector3.New(var_142_9 * 0.13, var_142_9 * 0.13, var_142_9 * 0.13) + arg_139_1.var_.shakeOldPos
			end

			if arg_139_1.time_ >= var_142_5 + var_142_6 and arg_139_1.time_ < var_142_5 + var_142_6 + arg_142_0 then
				var_142_4.localPosition = arg_139_1.var_.shakeOldPos
			end

			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			local var_142_11 = 0.6

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_12 = manager.ui.mainCamera.transform
			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				local var_142_14 = arg_139_1.var_.effecthongguang1
				local var_142_15
				local var_142_16 = var_142_12

				if not var_142_14 then
					var_142_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_142_16)
					var_142_14.name = "hongguang1"
					arg_139_1.var_.effecthongguang1 = var_142_14
				else
					var_142_14.transform:SetParent(var_142_16)
				end

				var_142_14.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_142_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_142_17 = manager.ui.mainCamera.transform
			local var_142_18 = 1.2

			if var_142_18 < arg_139_1.time_ and arg_139_1.time_ <= var_142_18 + arg_142_0 then
				local var_142_19 = arg_139_1.var_.effecthongguang1
				local var_142_20
				local var_142_21 = var_142_17

				if not var_142_19 then
					var_142_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_142_21)
					var_142_19.name = "hongguang1"
					arg_139_1.var_.effecthongguang1 = var_142_19
				else
					var_142_19.transform:SetParent(var_142_21)
				end

				var_142_19.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_142_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_22 = 0.6
			local var_142_23 = 1

			if var_142_22 < arg_139_1.time_ and arg_139_1.time_ <= var_142_22 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_24 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_24:setOnUpdate(LuaHelper.FloatAction(function(arg_143_0)
					arg_139_1.dialogCg_.alpha = arg_143_0
				end))
				var_142_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_25 = arg_139_1:GetWordFromCfg(120111034)
				local var_142_26 = arg_139_1:FormatText(var_142_25.content)

				arg_139_1.text_.text = var_142_26

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_27 = 40
				local var_142_28 = utf8.len(var_142_26)
				local var_142_29 = var_142_27 <= 0 and var_142_23 or var_142_23 * (var_142_28 / var_142_27)

				if var_142_29 > 0 and var_142_23 < var_142_29 then
					arg_139_1.talkMaxDuration = var_142_29
					var_142_22 = var_142_22 + 0.3

					if var_142_29 + var_142_22 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_29 + var_142_22
					end
				end

				arg_139_1.text_.text = var_142_26
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_30 = var_142_22 + 0.3
			local var_142_31 = math.max(var_142_23, arg_139_1.talkMaxDuration)

			if var_142_30 <= arg_139_1.time_ and arg_139_1.time_ < var_142_30 + var_142_31 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_30) / var_142_31

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_30 + var_142_31 and arg_139_1.time_ < var_142_30 + var_142_31 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play120111035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 120111035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play120111036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = manager.ui.mainCamera.transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.shakeOldPos = var_148_0.localPosition
			end

			local var_148_2 = 1

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / 0.066
				local var_148_4, var_148_5 = math.modf(var_148_3)

				var_148_0.localPosition = Vector3.New(var_148_5 * 0.13, var_148_5 * 0.13, var_148_5 * 0.13) + arg_145_1.var_.shakeOldPos
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = arg_145_1.var_.shakeOldPos
			end

			local var_148_6 = 0
			local var_148_7 = 1

			if var_148_6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				local var_148_8 = "play"
				local var_148_9 = "effect"

				arg_145_1:AudioAction(var_148_8, var_148_9, "se_story_120_00", "se_story_120_00_block", "")
			end

			local var_148_10 = 0
			local var_148_11 = 1.45

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_12 = arg_145_1:GetWordFromCfg(120111035)
				local var_148_13 = arg_145_1:FormatText(var_148_12.content)

				arg_145_1.text_.text = var_148_13

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_14 = 58
				local var_148_15 = utf8.len(var_148_13)
				local var_148_16 = var_148_14 <= 0 and var_148_11 or var_148_11 * (var_148_15 / var_148_14)

				if var_148_16 > 0 and var_148_11 < var_148_16 then
					arg_145_1.talkMaxDuration = var_148_16

					if var_148_16 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_16 + var_148_10
					end
				end

				arg_145_1.text_.text = var_148_13
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_17 = math.max(var_148_11, arg_145_1.talkMaxDuration)

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_17 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_10) / var_148_17

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_10 + var_148_17 and arg_145_1.time_ < var_148_10 + var_148_17 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play120111036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 120111036
		arg_149_1.duration_ = 2.37

		local var_149_0 = {
			zh = 2.366,
			ja = 2.066
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
				arg_149_0:Play120111037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1184ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1184ui_story = var_152_0.localPosition

				local var_152_2 = "1184ui_story"

				arg_149_1:ShowWeapon(arg_149_1.var_[var_152_2 .. "Animator"].transform, false)
			end

			local var_152_3 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_3 then
				local var_152_4 = (arg_149_1.time_ - var_152_1) / var_152_3
				local var_152_5 = Vector3.New(0, -0.97, -6)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1184ui_story, var_152_5, var_152_4)

				local var_152_6 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_6.x, var_152_6.y, var_152_6.z)

				local var_152_7 = var_152_0.localEulerAngles

				var_152_7.z = 0
				var_152_7.x = 0
				var_152_0.localEulerAngles = var_152_7
			end

			if arg_149_1.time_ >= var_152_1 + var_152_3 and arg_149_1.time_ < var_152_1 + var_152_3 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_152_8 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_8.x, var_152_8.y, var_152_8.z)

				local var_152_9 = var_152_0.localEulerAngles

				var_152_9.z = 0
				var_152_9.x = 0
				var_152_0.localEulerAngles = var_152_9
			end

			local var_152_10 = arg_149_1.actors_["1184ui_story"]
			local var_152_11 = 0

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 and not isNil(var_152_10) and arg_149_1.var_.characterEffect1184ui_story == nil then
				arg_149_1.var_.characterEffect1184ui_story = var_152_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_12 = 0.2

			if var_152_11 <= arg_149_1.time_ and arg_149_1.time_ < var_152_11 + var_152_12 and not isNil(var_152_10) then
				local var_152_13 = (arg_149_1.time_ - var_152_11) / var_152_12

				if arg_149_1.var_.characterEffect1184ui_story and not isNil(var_152_10) then
					arg_149_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_11 + var_152_12 and arg_149_1.time_ < var_152_11 + var_152_12 + arg_152_0 and not isNil(var_152_10) and arg_149_1.var_.characterEffect1184ui_story then
				arg_149_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_152_15 = 0

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 then
				arg_149_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_152_16 = 0
			local var_152_17 = 0.25

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_18 = arg_149_1:FormatText(StoryNameCfg[6].name)

				arg_149_1.leftNameTxt_.text = var_152_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_19 = arg_149_1:GetWordFromCfg(120111036)
				local var_152_20 = arg_149_1:FormatText(var_152_19.content)

				arg_149_1.text_.text = var_152_20

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_21 = 10
				local var_152_22 = utf8.len(var_152_20)
				local var_152_23 = var_152_21 <= 0 and var_152_17 or var_152_17 * (var_152_22 / var_152_21)

				if var_152_23 > 0 and var_152_17 < var_152_23 then
					arg_149_1.talkMaxDuration = var_152_23

					if var_152_23 + var_152_16 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_23 + var_152_16
					end
				end

				arg_149_1.text_.text = var_152_20
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111036", "story_v_out_120111.awb") ~= 0 then
					local var_152_24 = manager.audio:GetVoiceLength("story_v_out_120111", "120111036", "story_v_out_120111.awb") / 1000

					if var_152_24 + var_152_16 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_24 + var_152_16
					end

					if var_152_19.prefab_name ~= "" and arg_149_1.actors_[var_152_19.prefab_name] ~= nil then
						local var_152_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_19.prefab_name].transform, "story_v_out_120111", "120111036", "story_v_out_120111.awb")

						arg_149_1:RecordAudio("120111036", var_152_25)
						arg_149_1:RecordAudio("120111036", var_152_25)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_120111", "120111036", "story_v_out_120111.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_120111", "120111036", "story_v_out_120111.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_26 = math.max(var_152_17, arg_149_1.talkMaxDuration)

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_26 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_16) / var_152_26

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_16 + var_152_26 and arg_149_1.time_ < var_152_16 + var_152_26 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play120111037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 120111037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play120111038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1184ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1184ui_story == nil then
				arg_153_1.var_.characterEffect1184ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1184ui_story and not isNil(var_156_0) then
					local var_156_4 = Mathf.Lerp(0, 0.5, var_156_3)

					arg_153_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1184ui_story.fillRatio = var_156_4
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1184ui_story then
				local var_156_5 = 0.5

				arg_153_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1184ui_story.fillRatio = var_156_5
			end

			local var_156_6 = 0
			local var_156_7 = 0.5

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_8 = arg_153_1:FormatText(StoryNameCfg[7].name)

				arg_153_1.leftNameTxt_.text = var_156_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_9 = arg_153_1:GetWordFromCfg(120111037)
				local var_156_10 = arg_153_1:FormatText(var_156_9.content)

				arg_153_1.text_.text = var_156_10

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 20
				local var_156_12 = utf8.len(var_156_10)
				local var_156_13 = var_156_11 <= 0 and var_156_7 or var_156_7 * (var_156_12 / var_156_11)

				if var_156_13 > 0 and var_156_7 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_10
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_14 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_14 and arg_153_1.time_ < var_156_6 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play120111038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 120111038
		arg_157_1.duration_ = 6.4

		local var_157_0 = {
			zh = 4.066,
			ja = 6.4
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
				arg_157_0:Play120111039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10044ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10044ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0, -0.72, -6.3)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10044ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1184ui_story"].transform
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.var_.moveOldPos1184ui_story = var_160_9.localPosition
			end

			local var_160_11 = 0.001

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11
				local var_160_13 = Vector3.New(0, 100, 0)

				var_160_9.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1184ui_story, var_160_13, var_160_12)

				local var_160_14 = manager.ui.mainCamera.transform.position - var_160_9.position

				var_160_9.forward = Vector3.New(var_160_14.x, var_160_14.y, var_160_14.z)

				local var_160_15 = var_160_9.localEulerAngles

				var_160_15.z = 0
				var_160_15.x = 0
				var_160_9.localEulerAngles = var_160_15
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 then
				var_160_9.localPosition = Vector3.New(0, 100, 0)

				local var_160_16 = manager.ui.mainCamera.transform.position - var_160_9.position

				var_160_9.forward = Vector3.New(var_160_16.x, var_160_16.y, var_160_16.z)

				local var_160_17 = var_160_9.localEulerAngles

				var_160_17.z = 0
				var_160_17.x = 0
				var_160_9.localEulerAngles = var_160_17
			end

			local var_160_18 = arg_157_1.actors_["10044ui_story"]
			local var_160_19 = 0

			if var_160_19 < arg_157_1.time_ and arg_157_1.time_ <= var_160_19 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.characterEffect10044ui_story == nil then
				arg_157_1.var_.characterEffect10044ui_story = var_160_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_20 = 0.2

			if var_160_19 <= arg_157_1.time_ and arg_157_1.time_ < var_160_19 + var_160_20 and not isNil(var_160_18) then
				local var_160_21 = (arg_157_1.time_ - var_160_19) / var_160_20

				if arg_157_1.var_.characterEffect10044ui_story and not isNil(var_160_18) then
					arg_157_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_19 + var_160_20 and arg_157_1.time_ < var_160_19 + var_160_20 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.characterEffect10044ui_story then
				arg_157_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_160_22 = 0

			if var_160_22 < arg_157_1.time_ and arg_157_1.time_ <= var_160_22 + arg_160_0 then
				arg_157_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_160_23 = 0
			local var_160_24 = 0.375

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_25 = arg_157_1:FormatText(StoryNameCfg[387].name)

				arg_157_1.leftNameTxt_.text = var_160_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_26 = arg_157_1:GetWordFromCfg(120111038)
				local var_160_27 = arg_157_1:FormatText(var_160_26.content)

				arg_157_1.text_.text = var_160_27

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_28 = 15
				local var_160_29 = utf8.len(var_160_27)
				local var_160_30 = var_160_28 <= 0 and var_160_24 or var_160_24 * (var_160_29 / var_160_28)

				if var_160_30 > 0 and var_160_24 < var_160_30 then
					arg_157_1.talkMaxDuration = var_160_30

					if var_160_30 + var_160_23 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_30 + var_160_23
					end
				end

				arg_157_1.text_.text = var_160_27
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111038", "story_v_out_120111.awb") ~= 0 then
					local var_160_31 = manager.audio:GetVoiceLength("story_v_out_120111", "120111038", "story_v_out_120111.awb") / 1000

					if var_160_31 + var_160_23 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_31 + var_160_23
					end

					if var_160_26.prefab_name ~= "" and arg_157_1.actors_[var_160_26.prefab_name] ~= nil then
						local var_160_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_26.prefab_name].transform, "story_v_out_120111", "120111038", "story_v_out_120111.awb")

						arg_157_1:RecordAudio("120111038", var_160_32)
						arg_157_1:RecordAudio("120111038", var_160_32)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_120111", "120111038", "story_v_out_120111.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_120111", "120111038", "story_v_out_120111.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_33 = math.max(var_160_24, arg_157_1.talkMaxDuration)

			if var_160_23 <= arg_157_1.time_ and arg_157_1.time_ < var_160_23 + var_160_33 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_23) / var_160_33

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_23 + var_160_33 and arg_157_1.time_ < var_160_23 + var_160_33 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play120111039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 120111039
		arg_161_1.duration_ = 10.1

		local var_161_0 = {
			zh = 10.1,
			ja = 8.833
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
			arg_161_1.auto_ = false
		end

		function arg_161_1.playNext_(arg_163_0)
			arg_161_1.onStoryFinished_()
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_164_1 = 0
			local var_164_2 = 0.725

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_3 = arg_161_1:FormatText(StoryNameCfg[387].name)

				arg_161_1.leftNameTxt_.text = var_164_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_4 = arg_161_1:GetWordFromCfg(120111039)
				local var_164_5 = arg_161_1:FormatText(var_164_4.content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_6 = 29
				local var_164_7 = utf8.len(var_164_5)
				local var_164_8 = var_164_6 <= 0 and var_164_2 or var_164_2 * (var_164_7 / var_164_6)

				if var_164_8 > 0 and var_164_2 < var_164_8 then
					arg_161_1.talkMaxDuration = var_164_8

					if var_164_8 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120111", "120111039", "story_v_out_120111.awb") ~= 0 then
					local var_164_9 = manager.audio:GetVoiceLength("story_v_out_120111", "120111039", "story_v_out_120111.awb") / 1000

					if var_164_9 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_1
					end

					if var_164_4.prefab_name ~= "" and arg_161_1.actors_[var_164_4.prefab_name] ~= nil then
						local var_164_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_4.prefab_name].transform, "story_v_out_120111", "120111039", "story_v_out_120111.awb")

						arg_161_1:RecordAudio("120111039", var_164_10)
						arg_161_1:RecordAudio("120111039", var_164_10)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_120111", "120111039", "story_v_out_120111.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_120111", "120111039", "story_v_out_120111.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_11 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_11 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_11

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_11 and arg_161_1.time_ < var_164_1 + var_164_11 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J13g",
		"TextureConfig/Background/J04f"
	},
	voices = {
		"story_v_out_120111.awb"
	}
}
