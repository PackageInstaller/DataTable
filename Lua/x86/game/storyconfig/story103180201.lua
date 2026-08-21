return {
	Play318021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K10g"

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
				local var_4_5 = arg_1_1.bgs_.K10g

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
					if iter_4_0 ~= "K10g" then
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
			local var_4_23 = 0.433333333333333

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

			local var_4_28 = 1.26666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden")

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
			local var_4_35 = 1.325

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

				local var_4_37 = arg_1_1:GetWordFromCfg(318021001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 53
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
	Play318021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318021002
		arg_9_1.duration_ = 4.17

		local var_9_0 = {
			zh = 3.533,
			ja = 4.166
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
				arg_9_0:Play318021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1049ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1049ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1049ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1049ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -1.2, -6)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1049ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -1.2, -6)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1049ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1049ui_story == nil then
				arg_9_1.var_.characterEffect1049ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1049ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1049ui_story then
				arg_9_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.4

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[562].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(318021002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021002", "story_v_out_318021.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_318021", "318021002", "story_v_out_318021.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_318021", "318021002", "story_v_out_318021.awb")

						arg_9_1:RecordAudio("318021002", var_12_29)
						arg_9_1:RecordAudio("318021002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_318021", "318021002", "story_v_out_318021.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_318021", "318021002", "story_v_out_318021.awb")
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
				actorName = "1049ui_story",
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
	Play318021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318021003
		arg_13_1.duration_ = 5.87

		local var_13_0 = {
			zh = 5.866,
			ja = 4.466
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
				arg_13_0:Play318021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10053ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "10053ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["10053ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos10053ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0.7, -1.12, -5.99)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10053ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["10053ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10053ui_story == nil then
				arg_13_1.var_.characterEffect10053ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect10053ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10053ui_story then
				arg_13_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_20 = arg_13_1.actors_["1049ui_story"].transform
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.var_.moveOldPos1049ui_story = var_16_20.localPosition
			end

			local var_16_22 = 0.001

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_21) / var_16_22
				local var_16_24 = Vector3.New(-0.7, -1.2, -6)

				var_16_20.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1049ui_story, var_16_24, var_16_23)

				local var_16_25 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_25.x, var_16_25.y, var_16_25.z)

				local var_16_26 = var_16_20.localEulerAngles

				var_16_26.z = 0
				var_16_26.x = 0
				var_16_20.localEulerAngles = var_16_26
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 then
				var_16_20.localPosition = Vector3.New(-0.7, -1.2, -6)

				local var_16_27 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_27.x, var_16_27.y, var_16_27.z)

				local var_16_28 = var_16_20.localEulerAngles

				var_16_28.z = 0
				var_16_28.x = 0
				var_16_20.localEulerAngles = var_16_28
			end

			local var_16_29 = arg_13_1.actors_["1049ui_story"]
			local var_16_30 = 0

			if var_16_30 < arg_13_1.time_ and arg_13_1.time_ <= var_16_30 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect1049ui_story == nil then
				arg_13_1.var_.characterEffect1049ui_story = var_16_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_31 = 0.200000002980232

			if var_16_30 <= arg_13_1.time_ and arg_13_1.time_ < var_16_30 + var_16_31 and not isNil(var_16_29) then
				local var_16_32 = (arg_13_1.time_ - var_16_30) / var_16_31

				if arg_13_1.var_.characterEffect1049ui_story and not isNil(var_16_29) then
					local var_16_33 = Mathf.Lerp(0, 0.5, var_16_32)

					arg_13_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1049ui_story.fillRatio = var_16_33
				end
			end

			if arg_13_1.time_ >= var_16_30 + var_16_31 and arg_13_1.time_ < var_16_30 + var_16_31 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect1049ui_story then
				local var_16_34 = 0.5

				arg_13_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1049ui_story.fillRatio = var_16_34
			end

			local var_16_35 = 0
			local var_16_36 = 0.65

			if var_16_35 < arg_13_1.time_ and arg_13_1.time_ <= var_16_35 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_37 = arg_13_1:FormatText(StoryNameCfg[477].name)

				arg_13_1.leftNameTxt_.text = var_16_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_38 = arg_13_1:GetWordFromCfg(318021003)
				local var_16_39 = arg_13_1:FormatText(var_16_38.content)

				arg_13_1.text_.text = var_16_39

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_40 = 26
				local var_16_41 = utf8.len(var_16_39)
				local var_16_42 = var_16_40 <= 0 and var_16_36 or var_16_36 * (var_16_41 / var_16_40)

				if var_16_42 > 0 and var_16_36 < var_16_42 then
					arg_13_1.talkMaxDuration = var_16_42

					if var_16_42 + var_16_35 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_42 + var_16_35
					end
				end

				arg_13_1.text_.text = var_16_39
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021003", "story_v_out_318021.awb") ~= 0 then
					local var_16_43 = manager.audio:GetVoiceLength("story_v_out_318021", "318021003", "story_v_out_318021.awb") / 1000

					if var_16_43 + var_16_35 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_43 + var_16_35
					end

					if var_16_38.prefab_name ~= "" and arg_13_1.actors_[var_16_38.prefab_name] ~= nil then
						local var_16_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_38.prefab_name].transform, "story_v_out_318021", "318021003", "story_v_out_318021.awb")

						arg_13_1:RecordAudio("318021003", var_16_44)
						arg_13_1:RecordAudio("318021003", var_16_44)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_318021", "318021003", "story_v_out_318021.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_318021", "318021003", "story_v_out_318021.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_45 = math.max(var_16_36, arg_13_1.talkMaxDuration)

			if var_16_35 <= arg_13_1.time_ and arg_13_1.time_ < var_16_35 + var_16_45 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_35) / var_16_45

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_35 + var_16_45 and arg_13_1.time_ < var_16_35 + var_16_45 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play318021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318021004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play318021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10053ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10053ui_story == nil then
				arg_17_1.var_.characterEffect10053ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect10053ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10053ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10053ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10053ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.675

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(318021004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 27
				local var_20_11 = utf8.len(var_20_9)
				local var_20_12 = var_20_10 <= 0 and var_20_7 or var_20_7 * (var_20_11 / var_20_10)

				if var_20_12 > 0 and var_20_7 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_13 and arg_17_1.time_ < var_20_6 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play318021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318021005
		arg_21_1.duration_ = 10.23

		local var_21_0 = {
			zh = 6.733,
			ja = 10.233
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
				arg_21_0:Play318021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10053ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10053ui_story == nil then
				arg_21_1.var_.characterEffect10053ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect10053ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10053ui_story then
				arg_21_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_24_4 = 0
			local var_24_5 = 0.7

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_6 = arg_21_1:FormatText(StoryNameCfg[477].name)

				arg_21_1.leftNameTxt_.text = var_24_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(318021005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 28
				local var_24_10 = utf8.len(var_24_8)
				local var_24_11 = var_24_9 <= 0 and var_24_5 or var_24_5 * (var_24_10 / var_24_9)

				if var_24_11 > 0 and var_24_5 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021005", "story_v_out_318021.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_318021", "318021005", "story_v_out_318021.awb") / 1000

					if var_24_12 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_4
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_318021", "318021005", "story_v_out_318021.awb")

						arg_21_1:RecordAudio("318021005", var_24_13)
						arg_21_1:RecordAudio("318021005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_318021", "318021005", "story_v_out_318021.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_318021", "318021005", "story_v_out_318021.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_14 and arg_21_1.time_ < var_24_4 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play318021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318021006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play318021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10053ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect10053ui_story == nil then
				arg_25_1.var_.characterEffect10053ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect10053ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10053ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect10053ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10053ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.125

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(318021006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 5
				local var_28_11 = utf8.len(var_28_9)
				local var_28_12 = var_28_10 <= 0 and var_28_7 or var_28_7 * (var_28_11 / var_28_10)

				if var_28_12 > 0 and var_28_7 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_13 and arg_25_1.time_ < var_28_6 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play318021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318021007
		arg_29_1.duration_ = 9.13

		local var_29_0 = {
			zh = 5.9,
			ja = 9.133
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
				arg_29_0:Play318021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10053ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10053ui_story == nil then
				arg_29_1.var_.characterEffect10053ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect10053ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10053ui_story then
				arg_29_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action4415")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_6 = 0
			local var_32_7 = 0.625

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[477].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(318021007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021007", "story_v_out_318021.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_318021", "318021007", "story_v_out_318021.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_318021", "318021007", "story_v_out_318021.awb")

						arg_29_1:RecordAudio("318021007", var_32_15)
						arg_29_1:RecordAudio("318021007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_318021", "318021007", "story_v_out_318021.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_318021", "318021007", "story_v_out_318021.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_16 and arg_29_1.time_ < var_32_6 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play318021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318021008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play318021009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10053ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10053ui_story == nil then
				arg_33_1.var_.characterEffect10053ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10053ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10053ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10053ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10053ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.125

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(318021008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 5
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_7 or var_36_7 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_7 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_13 and arg_33_1.time_ < var_36_6 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play318021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 318021009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play318021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.125

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(318021009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 45
				local var_40_5 = utf8.len(var_40_3)
				local var_40_6 = var_40_4 <= 0 and var_40_1 or var_40_1 * (var_40_5 / var_40_4)

				if var_40_6 > 0 and var_40_1 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_7 and arg_37_1.time_ < var_40_0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play318021010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 318021010
		arg_41_1.duration_ = 7.07

		local var_41_0 = {
			zh = 7.066,
			ja = 5.3
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
				arg_41_0:Play318021011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1049ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1049ui_story == nil then
				arg_41_1.var_.characterEffect1049ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1049ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1049ui_story then
				arg_41_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_2")
			end

			local var_44_6 = 0
			local var_44_7 = 0.8

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[562].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(318021010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 32
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021010", "story_v_out_318021.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_318021", "318021010", "story_v_out_318021.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_318021", "318021010", "story_v_out_318021.awb")

						arg_41_1:RecordAudio("318021010", var_44_15)
						arg_41_1:RecordAudio("318021010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_318021", "318021010", "story_v_out_318021.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_318021", "318021010", "story_v_out_318021.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_16 and arg_41_1.time_ < var_44_6 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play318021011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 318021011
		arg_45_1.duration_ = 10.2

		local var_45_0 = {
			zh = 10.2,
			ja = 9.966
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
				arg_45_0:Play318021012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.85

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[562].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(318021011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021011", "story_v_out_318021.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_318021", "318021011", "story_v_out_318021.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_318021", "318021011", "story_v_out_318021.awb")

						arg_45_1:RecordAudio("318021011", var_48_9)
						arg_45_1:RecordAudio("318021011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_318021", "318021011", "story_v_out_318021.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_318021", "318021011", "story_v_out_318021.awb")
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
	Play318021012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 318021012
		arg_49_1.duration_ = 2

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play318021013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10053ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10053ui_story == nil then
				arg_49_1.var_.characterEffect10053ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10053ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10053ui_story then
				arg_49_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action41534")
			end

			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_6 = arg_49_1.actors_["1049ui_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1049ui_story == nil then
				arg_49_1.var_.characterEffect1049ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.200000002980232

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect1049ui_story and not isNil(var_52_6) then
					local var_52_10 = Mathf.Lerp(0, 0.5, var_52_9)

					arg_49_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1049ui_story.fillRatio = var_52_10
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1049ui_story then
				local var_52_11 = 0.5

				arg_49_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1049ui_story.fillRatio = var_52_11
			end

			local var_52_12 = 0
			local var_52_13 = 0.075

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[477].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(318021012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 3
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_13 or var_52_13 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_13 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021012", "story_v_out_318021.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_out_318021", "318021012", "story_v_out_318021.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_318021", "318021012", "story_v_out_318021.awb")

						arg_49_1:RecordAudio("318021012", var_52_21)
						arg_49_1:RecordAudio("318021012", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_318021", "318021012", "story_v_out_318021.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_318021", "318021012", "story_v_out_318021.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_22 and arg_49_1.time_ < var_52_12 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play318021013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 318021013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play318021014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10053ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10053ui_story == nil then
				arg_53_1.var_.characterEffect10053ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect10053ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10053ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10053ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10053ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.433333333333333

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				local var_56_8 = "play"
				local var_56_9 = "effect"

				arg_53_1:AudioAction(var_56_8, var_56_9, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_56_10 = arg_53_1.actors_["1049ui_story"].transform
			local var_56_11 = 0

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.var_.moveOldPos1049ui_story = var_56_10.localPosition
			end

			local var_56_12 = 0.001

			if var_56_11 <= arg_53_1.time_ and arg_53_1.time_ < var_56_11 + var_56_12 then
				local var_56_13 = (arg_53_1.time_ - var_56_11) / var_56_12
				local var_56_14 = Vector3.New(0, 100, 0)

				var_56_10.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1049ui_story, var_56_14, var_56_13)

				local var_56_15 = manager.ui.mainCamera.transform.position - var_56_10.position

				var_56_10.forward = Vector3.New(var_56_15.x, var_56_15.y, var_56_15.z)

				local var_56_16 = var_56_10.localEulerAngles

				var_56_16.z = 0
				var_56_16.x = 0
				var_56_10.localEulerAngles = var_56_16
			end

			if arg_53_1.time_ >= var_56_11 + var_56_12 and arg_53_1.time_ < var_56_11 + var_56_12 + arg_56_0 then
				var_56_10.localPosition = Vector3.New(0, 100, 0)

				local var_56_17 = manager.ui.mainCamera.transform.position - var_56_10.position

				var_56_10.forward = Vector3.New(var_56_17.x, var_56_17.y, var_56_17.z)

				local var_56_18 = var_56_10.localEulerAngles

				var_56_18.z = 0
				var_56_18.x = 0
				var_56_10.localEulerAngles = var_56_18
			end

			local var_56_19 = arg_53_1.actors_["10053ui_story"].transform
			local var_56_20 = 0

			if var_56_20 < arg_53_1.time_ and arg_53_1.time_ <= var_56_20 + arg_56_0 then
				arg_53_1.var_.moveOldPos10053ui_story = var_56_19.localPosition
			end

			local var_56_21 = 0.001

			if var_56_20 <= arg_53_1.time_ and arg_53_1.time_ < var_56_20 + var_56_21 then
				local var_56_22 = (arg_53_1.time_ - var_56_20) / var_56_21
				local var_56_23 = Vector3.New(0, 100, 0)

				var_56_19.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10053ui_story, var_56_23, var_56_22)

				local var_56_24 = manager.ui.mainCamera.transform.position - var_56_19.position

				var_56_19.forward = Vector3.New(var_56_24.x, var_56_24.y, var_56_24.z)

				local var_56_25 = var_56_19.localEulerAngles

				var_56_25.z = 0
				var_56_25.x = 0
				var_56_19.localEulerAngles = var_56_25
			end

			if arg_53_1.time_ >= var_56_20 + var_56_21 and arg_53_1.time_ < var_56_20 + var_56_21 + arg_56_0 then
				var_56_19.localPosition = Vector3.New(0, 100, 0)

				local var_56_26 = manager.ui.mainCamera.transform.position - var_56_19.position

				var_56_19.forward = Vector3.New(var_56_26.x, var_56_26.y, var_56_26.z)

				local var_56_27 = var_56_19.localEulerAngles

				var_56_27.z = 0
				var_56_27.x = 0
				var_56_19.localEulerAngles = var_56_27
			end

			local var_56_28 = 0

			if var_56_28 < arg_53_1.time_ and arg_53_1.time_ <= var_56_28 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_29 = 1

			if var_56_28 <= arg_53_1.time_ and arg_53_1.time_ < var_56_28 + var_56_29 then
				local var_56_30 = (arg_53_1.time_ - var_56_28) / var_56_29
				local var_56_31 = Color.New(1, 1, 1)

				var_56_31.a = Mathf.Lerp(1, 0, var_56_30)
				arg_53_1.mask_.color = var_56_31
			end

			if arg_53_1.time_ >= var_56_28 + var_56_29 and arg_53_1.time_ < var_56_28 + var_56_29 + arg_56_0 then
				local var_56_32 = Color.New(1, 1, 1)
				local var_56_33 = 0

				arg_53_1.mask_.enabled = false
				var_56_32.a = var_56_33
				arg_53_1.mask_.color = var_56_32
			end

			local var_56_34 = manager.ui.mainCamera.transform
			local var_56_35 = 0

			if var_56_35 < arg_53_1.time_ and arg_53_1.time_ <= var_56_35 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_34.localPosition
			end

			local var_56_36 = 1

			if var_56_35 <= arg_53_1.time_ and arg_53_1.time_ < var_56_35 + var_56_36 then
				local var_56_37 = (arg_53_1.time_ - var_56_35) / 0.066
				local var_56_38, var_56_39 = math.modf(var_56_37)

				var_56_34.localPosition = Vector3.New(var_56_39 * 0.13, var_56_39 * 0.13, var_56_39 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= var_56_35 + var_56_36 and arg_53_1.time_ < var_56_35 + var_56_36 + arg_56_0 then
				var_56_34.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_40 = 0
			local var_56_41 = 1.175

			if var_56_40 < arg_53_1.time_ and arg_53_1.time_ <= var_56_40 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_42 = arg_53_1:GetWordFromCfg(318021013)
				local var_56_43 = arg_53_1:FormatText(var_56_42.content)

				arg_53_1.text_.text = var_56_43

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_44 = 47
				local var_56_45 = utf8.len(var_56_43)
				local var_56_46 = var_56_44 <= 0 and var_56_41 or var_56_41 * (var_56_45 / var_56_44)

				if var_56_46 > 0 and var_56_41 < var_56_46 then
					arg_53_1.talkMaxDuration = var_56_46

					if var_56_46 + var_56_40 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_46 + var_56_40
					end
				end

				arg_53_1.text_.text = var_56_43
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_47 = math.max(var_56_41, arg_53_1.talkMaxDuration)

			if var_56_40 <= arg_53_1.time_ and arg_53_1.time_ < var_56_40 + var_56_47 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_40) / var_56_47

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_40 + var_56_47 and arg_53_1.time_ < var_56_40 + var_56_47 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play318021014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 318021014
		arg_57_1.duration_ = 9

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play318021015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = "K11g"

			if arg_57_1.bgs_[var_60_0] == nil then
				local var_60_1 = Object.Instantiate(arg_57_1.paintGo_)

				var_60_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_60_0)
				var_60_1.name = var_60_0
				var_60_1.transform.parent = arg_57_1.stage_.transform
				var_60_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.bgs_[var_60_0] = var_60_1
			end

			local var_60_2 = 2

			if var_60_2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				local var_60_3 = manager.ui.mainCamera.transform.localPosition
				local var_60_4 = Vector3.New(0, 0, 10) + Vector3.New(var_60_3.x, var_60_3.y, 0)
				local var_60_5 = arg_57_1.bgs_.K11g

				var_60_5.transform.localPosition = var_60_4
				var_60_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_6 = var_60_5:GetComponent("SpriteRenderer")

				if var_60_6 and var_60_6.sprite then
					local var_60_7 = (var_60_5.transform.localPosition - var_60_3).z
					local var_60_8 = manager.ui.mainCameraCom_
					local var_60_9 = 2 * var_60_7 * Mathf.Tan(var_60_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_60_10 = var_60_9 * var_60_8.aspect
					local var_60_11 = var_60_6.sprite.bounds.size.x
					local var_60_12 = var_60_6.sprite.bounds.size.y
					local var_60_13 = var_60_10 / var_60_11
					local var_60_14 = var_60_9 / var_60_12
					local var_60_15 = var_60_14 < var_60_13 and var_60_13 or var_60_14

					var_60_5.transform.localScale = Vector3.New(var_60_15, var_60_15, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "K11g" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_17 = 2

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_17 then
				local var_60_18 = (arg_57_1.time_ - var_60_16) / var_60_17
				local var_60_19 = Color.New(0, 0, 0)

				var_60_19.a = Mathf.Lerp(0, 1, var_60_18)
				arg_57_1.mask_.color = var_60_19
			end

			if arg_57_1.time_ >= var_60_16 + var_60_17 and arg_57_1.time_ < var_60_16 + var_60_17 + arg_60_0 then
				local var_60_20 = Color.New(0, 0, 0)

				var_60_20.a = 1
				arg_57_1.mask_.color = var_60_20
			end

			local var_60_21 = 2

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_22 = 2

			if var_60_21 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_22 then
				local var_60_23 = (arg_57_1.time_ - var_60_21) / var_60_22
				local var_60_24 = Color.New(0, 0, 0)

				var_60_24.a = Mathf.Lerp(1, 0, var_60_23)
				arg_57_1.mask_.color = var_60_24
			end

			if arg_57_1.time_ >= var_60_21 + var_60_22 and arg_57_1.time_ < var_60_21 + var_60_22 + arg_60_0 then
				local var_60_25 = Color.New(0, 0, 0)
				local var_60_26 = 0

				arg_57_1.mask_.enabled = false
				var_60_25.a = var_60_26
				arg_57_1.mask_.color = var_60_25
			end

			local var_60_27 = 0
			local var_60_28 = 0.433333333333333

			if var_60_27 < arg_57_1.time_ and arg_57_1.time_ <= var_60_27 + arg_60_0 then
				local var_60_29 = "play"
				local var_60_30 = "effect"

				arg_57_1:AudioAction(var_60_29, var_60_30, "se_story_1210", "se_story_1210_blast_loop", "")
			end

			local var_60_31 = arg_57_1.actors_["1049ui_story"].transform
			local var_60_32 = 2

			if var_60_32 < arg_57_1.time_ and arg_57_1.time_ <= var_60_32 + arg_60_0 then
				arg_57_1.var_.moveOldPos1049ui_story = var_60_31.localPosition
			end

			local var_60_33 = 0.001

			if var_60_32 <= arg_57_1.time_ and arg_57_1.time_ < var_60_32 + var_60_33 then
				local var_60_34 = (arg_57_1.time_ - var_60_32) / var_60_33
				local var_60_35 = Vector3.New(0, 100, 0)

				var_60_31.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1049ui_story, var_60_35, var_60_34)

				local var_60_36 = manager.ui.mainCamera.transform.position - var_60_31.position

				var_60_31.forward = Vector3.New(var_60_36.x, var_60_36.y, var_60_36.z)

				local var_60_37 = var_60_31.localEulerAngles

				var_60_37.z = 0
				var_60_37.x = 0
				var_60_31.localEulerAngles = var_60_37
			end

			if arg_57_1.time_ >= var_60_32 + var_60_33 and arg_57_1.time_ < var_60_32 + var_60_33 + arg_60_0 then
				var_60_31.localPosition = Vector3.New(0, 100, 0)

				local var_60_38 = manager.ui.mainCamera.transform.position - var_60_31.position

				var_60_31.forward = Vector3.New(var_60_38.x, var_60_38.y, var_60_38.z)

				local var_60_39 = var_60_31.localEulerAngles

				var_60_39.z = 0
				var_60_39.x = 0
				var_60_31.localEulerAngles = var_60_39
			end

			local var_60_40 = arg_57_1.actors_["10053ui_story"].transform
			local var_60_41 = 2

			if var_60_41 < arg_57_1.time_ and arg_57_1.time_ <= var_60_41 + arg_60_0 then
				arg_57_1.var_.moveOldPos10053ui_story = var_60_40.localPosition
			end

			local var_60_42 = 0.001

			if var_60_41 <= arg_57_1.time_ and arg_57_1.time_ < var_60_41 + var_60_42 then
				local var_60_43 = (arg_57_1.time_ - var_60_41) / var_60_42
				local var_60_44 = Vector3.New(0, 100, 0)

				var_60_40.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10053ui_story, var_60_44, var_60_43)

				local var_60_45 = manager.ui.mainCamera.transform.position - var_60_40.position

				var_60_40.forward = Vector3.New(var_60_45.x, var_60_45.y, var_60_45.z)

				local var_60_46 = var_60_40.localEulerAngles

				var_60_46.z = 0
				var_60_46.x = 0
				var_60_40.localEulerAngles = var_60_46
			end

			if arg_57_1.time_ >= var_60_41 + var_60_42 and arg_57_1.time_ < var_60_41 + var_60_42 + arg_60_0 then
				var_60_40.localPosition = Vector3.New(0, 100, 0)

				local var_60_47 = manager.ui.mainCamera.transform.position - var_60_40.position

				var_60_40.forward = Vector3.New(var_60_47.x, var_60_47.y, var_60_47.z)

				local var_60_48 = var_60_40.localEulerAngles

				var_60_48.z = 0
				var_60_48.x = 0
				var_60_40.localEulerAngles = var_60_48
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_49 = 4
			local var_60_50 = 0.1

			if var_60_49 < arg_57_1.time_ and arg_57_1.time_ <= var_60_49 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_51 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_51:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_52 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_53 = arg_57_1:GetWordFromCfg(318021014)
				local var_60_54 = arg_57_1:FormatText(var_60_53.content)

				arg_57_1.text_.text = var_60_54

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_55 = 4
				local var_60_56 = utf8.len(var_60_54)
				local var_60_57 = var_60_55 <= 0 and var_60_50 or var_60_50 * (var_60_56 / var_60_55)

				if var_60_57 > 0 and var_60_50 < var_60_57 then
					arg_57_1.talkMaxDuration = var_60_57
					var_60_49 = var_60_49 + 0.3

					if var_60_57 + var_60_49 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_57 + var_60_49
					end
				end

				arg_57_1.text_.text = var_60_54
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_58 = var_60_49 + 0.3
			local var_60_59 = math.max(var_60_50, arg_57_1.talkMaxDuration)

			if var_60_58 <= arg_57_1.time_ and arg_57_1.time_ < var_60_58 + var_60_59 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_58) / var_60_59

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_58 + var_60_59 and arg_57_1.time_ < var_60_58 + var_60_59 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play318021015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 318021015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play318021016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 1.475

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:GetWordFromCfg(318021015)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 59
				local var_66_5 = utf8.len(var_66_3)
				local var_66_6 = var_66_4 <= 0 and var_66_1 or var_66_1 * (var_66_5 / var_66_4)

				if var_66_6 > 0 and var_66_1 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_7 and arg_63_1.time_ < var_66_0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play318021016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 318021016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play318021017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.875

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_2 = arg_67_1:GetWordFromCfg(318021016)
				local var_70_3 = arg_67_1:FormatText(var_70_2.content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 35
				local var_70_5 = utf8.len(var_70_3)
				local var_70_6 = var_70_4 <= 0 and var_70_1 or var_70_1 * (var_70_5 / var_70_4)

				if var_70_6 > 0 and var_70_1 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_7 and arg_67_1.time_ < var_70_0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play318021017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 318021017
		arg_71_1.duration_ = 4.57

		local var_71_0 = {
			zh = 2.733,
			ja = 4.566
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
				arg_71_0:Play318021018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = "1015ui_story"

			if arg_71_1.actors_[var_74_0] == nil then
				local var_74_1 = Asset.Load("Char/" .. "1015ui_story")

				if not isNil(var_74_1) then
					local var_74_2 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_71_1.stage_.transform)

					var_74_2.name = var_74_0
					var_74_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_71_1.actors_[var_74_0] = var_74_2

					local var_74_3 = var_74_2:GetComponentInChildren(typeof(CharacterEffect))

					var_74_3.enabled = true

					local var_74_4 = GameObjectTools.GetOrAddComponent(var_74_2, typeof(DynamicBoneHelper))

					if var_74_4 then
						var_74_4:EnableDynamicBone(false)
					end

					arg_71_1:ShowWeapon(var_74_3.transform, false)

					arg_71_1.var_[var_74_0 .. "Animator"] = var_74_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_71_1.var_[var_74_0 .. "Animator"].applyRootMotion = true
					arg_71_1.var_[var_74_0 .. "LipSync"] = var_74_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_74_5 = arg_71_1.actors_["1015ui_story"].transform
			local var_74_6 = 0

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.var_.moveOldPos1015ui_story = var_74_5.localPosition
			end

			local var_74_7 = 0.001

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_7 then
				local var_74_8 = (arg_71_1.time_ - var_74_6) / var_74_7
				local var_74_9 = Vector3.New(0, -1.15, -6.2)

				var_74_5.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1015ui_story, var_74_9, var_74_8)

				local var_74_10 = manager.ui.mainCamera.transform.position - var_74_5.position

				var_74_5.forward = Vector3.New(var_74_10.x, var_74_10.y, var_74_10.z)

				local var_74_11 = var_74_5.localEulerAngles

				var_74_11.z = 0
				var_74_11.x = 0
				var_74_5.localEulerAngles = var_74_11
			end

			if arg_71_1.time_ >= var_74_6 + var_74_7 and arg_71_1.time_ < var_74_6 + var_74_7 + arg_74_0 then
				var_74_5.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_74_12 = manager.ui.mainCamera.transform.position - var_74_5.position

				var_74_5.forward = Vector3.New(var_74_12.x, var_74_12.y, var_74_12.z)

				local var_74_13 = var_74_5.localEulerAngles

				var_74_13.z = 0
				var_74_13.x = 0
				var_74_5.localEulerAngles = var_74_13
			end

			local var_74_14 = arg_71_1.actors_["1015ui_story"]
			local var_74_15 = 0

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 and not isNil(var_74_14) and arg_71_1.var_.characterEffect1015ui_story == nil then
				arg_71_1.var_.characterEffect1015ui_story = var_74_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_16 = 0.200000002980232

			if var_74_15 <= arg_71_1.time_ and arg_71_1.time_ < var_74_15 + var_74_16 and not isNil(var_74_14) then
				local var_74_17 = (arg_71_1.time_ - var_74_15) / var_74_16

				if arg_71_1.var_.characterEffect1015ui_story and not isNil(var_74_14) then
					arg_71_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_15 + var_74_16 and arg_71_1.time_ < var_74_15 + var_74_16 + arg_74_0 and not isNil(var_74_14) and arg_71_1.var_.characterEffect1015ui_story then
				arg_71_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_74_18 = 0

			if var_74_18 < arg_71_1.time_ and arg_71_1.time_ <= var_74_18 + arg_74_0 then
				arg_71_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_74_19 = 0

			if var_74_19 < arg_71_1.time_ and arg_71_1.time_ <= var_74_19 + arg_74_0 then
				arg_71_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_74_20 = 0
			local var_74_21 = 0.375

			if var_74_20 < arg_71_1.time_ and arg_71_1.time_ <= var_74_20 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_22 = arg_71_1:FormatText(StoryNameCfg[479].name)

				arg_71_1.leftNameTxt_.text = var_74_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_23 = arg_71_1:GetWordFromCfg(318021017)
				local var_74_24 = arg_71_1:FormatText(var_74_23.content)

				arg_71_1.text_.text = var_74_24

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_25 = 15
				local var_74_26 = utf8.len(var_74_24)
				local var_74_27 = var_74_25 <= 0 and var_74_21 or var_74_21 * (var_74_26 / var_74_25)

				if var_74_27 > 0 and var_74_21 < var_74_27 then
					arg_71_1.talkMaxDuration = var_74_27

					if var_74_27 + var_74_20 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_27 + var_74_20
					end
				end

				arg_71_1.text_.text = var_74_24
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021017", "story_v_out_318021.awb") ~= 0 then
					local var_74_28 = manager.audio:GetVoiceLength("story_v_out_318021", "318021017", "story_v_out_318021.awb") / 1000

					if var_74_28 + var_74_20 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_28 + var_74_20
					end

					if var_74_23.prefab_name ~= "" and arg_71_1.actors_[var_74_23.prefab_name] ~= nil then
						local var_74_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_23.prefab_name].transform, "story_v_out_318021", "318021017", "story_v_out_318021.awb")

						arg_71_1:RecordAudio("318021017", var_74_29)
						arg_71_1:RecordAudio("318021017", var_74_29)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_318021", "318021017", "story_v_out_318021.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_318021", "318021017", "story_v_out_318021.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_30 = math.max(var_74_21, arg_71_1.talkMaxDuration)

			if var_74_20 <= arg_71_1.time_ and arg_71_1.time_ < var_74_20 + var_74_30 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_20) / var_74_30

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_20 + var_74_30 and arg_71_1.time_ < var_74_20 + var_74_30 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play318021018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 318021018
		arg_75_1.duration_ = 4

		local var_75_0 = {
			zh = 2.9,
			ja = 4
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
				arg_75_0:Play318021019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "1093ui_story"

			if arg_75_1.actors_[var_78_0] == nil then
				local var_78_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_78_1) then
					local var_78_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_75_1.stage_.transform)

					var_78_2.name = var_78_0
					var_78_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_75_1.actors_[var_78_0] = var_78_2

					local var_78_3 = var_78_2:GetComponentInChildren(typeof(CharacterEffect))

					var_78_3.enabled = true

					local var_78_4 = GameObjectTools.GetOrAddComponent(var_78_2, typeof(DynamicBoneHelper))

					if var_78_4 then
						var_78_4:EnableDynamicBone(false)
					end

					arg_75_1:ShowWeapon(var_78_3.transform, false)

					arg_75_1.var_[var_78_0 .. "Animator"] = var_78_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_75_1.var_[var_78_0 .. "Animator"].applyRootMotion = true
					arg_75_1.var_[var_78_0 .. "LipSync"] = var_78_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_78_5 = 0

			if var_78_5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_78_6 = arg_75_1.actors_["1015ui_story"].transform
			local var_78_7 = 0

			if var_78_7 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 then
				arg_75_1.var_.moveOldPos1015ui_story = var_78_6.localPosition
			end

			local var_78_8 = 0.001

			if var_78_7 <= arg_75_1.time_ and arg_75_1.time_ < var_78_7 + var_78_8 then
				local var_78_9 = (arg_75_1.time_ - var_78_7) / var_78_8
				local var_78_10 = Vector3.New(0, -1.15, -6.2)

				var_78_6.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1015ui_story, var_78_10, var_78_9)

				local var_78_11 = manager.ui.mainCamera.transform.position - var_78_6.position

				var_78_6.forward = Vector3.New(var_78_11.x, var_78_11.y, var_78_11.z)

				local var_78_12 = var_78_6.localEulerAngles

				var_78_12.z = 0
				var_78_12.x = 0
				var_78_6.localEulerAngles = var_78_12
			end

			if arg_75_1.time_ >= var_78_7 + var_78_8 and arg_75_1.time_ < var_78_7 + var_78_8 + arg_78_0 then
				var_78_6.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_78_13 = manager.ui.mainCamera.transform.position - var_78_6.position

				var_78_6.forward = Vector3.New(var_78_13.x, var_78_13.y, var_78_13.z)

				local var_78_14 = var_78_6.localEulerAngles

				var_78_14.z = 0
				var_78_14.x = 0
				var_78_6.localEulerAngles = var_78_14
			end

			local var_78_15 = arg_75_1.actors_["1015ui_story"]
			local var_78_16 = 0

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 and not isNil(var_78_15) and arg_75_1.var_.characterEffect1015ui_story == nil then
				arg_75_1.var_.characterEffect1015ui_story = var_78_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_17 = 0.200000002980232

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_17 and not isNil(var_78_15) then
				local var_78_18 = (arg_75_1.time_ - var_78_16) / var_78_17

				if arg_75_1.var_.characterEffect1015ui_story and not isNil(var_78_15) then
					local var_78_19 = Mathf.Lerp(0, 0.5, var_78_18)

					arg_75_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1015ui_story.fillRatio = var_78_19
				end
			end

			if arg_75_1.time_ >= var_78_16 + var_78_17 and arg_75_1.time_ < var_78_16 + var_78_17 + arg_78_0 and not isNil(var_78_15) and arg_75_1.var_.characterEffect1015ui_story then
				local var_78_20 = 0.5

				arg_75_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1015ui_story.fillRatio = var_78_20
			end

			local var_78_21 = 0
			local var_78_22 = 0.4

			if var_78_21 < arg_75_1.time_ and arg_75_1.time_ <= var_78_21 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_23 = arg_75_1:FormatText(StoryNameCfg[73].name)

				arg_75_1.leftNameTxt_.text = var_78_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_24 = arg_75_1:GetWordFromCfg(318021018)
				local var_78_25 = arg_75_1:FormatText(var_78_24.content)

				arg_75_1.text_.text = var_78_25

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_26 = 16
				local var_78_27 = utf8.len(var_78_25)
				local var_78_28 = var_78_26 <= 0 and var_78_22 or var_78_22 * (var_78_27 / var_78_26)

				if var_78_28 > 0 and var_78_22 < var_78_28 then
					arg_75_1.talkMaxDuration = var_78_28

					if var_78_28 + var_78_21 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_28 + var_78_21
					end
				end

				arg_75_1.text_.text = var_78_25
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021018", "story_v_out_318021.awb") ~= 0 then
					local var_78_29 = manager.audio:GetVoiceLength("story_v_out_318021", "318021018", "story_v_out_318021.awb") / 1000

					if var_78_29 + var_78_21 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_29 + var_78_21
					end

					if var_78_24.prefab_name ~= "" and arg_75_1.actors_[var_78_24.prefab_name] ~= nil then
						local var_78_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_24.prefab_name].transform, "story_v_out_318021", "318021018", "story_v_out_318021.awb")

						arg_75_1:RecordAudio("318021018", var_78_30)
						arg_75_1:RecordAudio("318021018", var_78_30)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_318021", "318021018", "story_v_out_318021.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_318021", "318021018", "story_v_out_318021.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_31 = math.max(var_78_22, arg_75_1.talkMaxDuration)

			if var_78_21 <= arg_75_1.time_ and arg_75_1.time_ < var_78_21 + var_78_31 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_21) / var_78_31

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_21 + var_78_31 and arg_75_1.time_ < var_78_21 + var_78_31 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play318021019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 318021019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play318021020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 1.025

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(318021019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 41
				local var_82_5 = utf8.len(var_82_3)
				local var_82_6 = var_82_4 <= 0 and var_82_1 or var_82_1 * (var_82_5 / var_82_4)

				if var_82_6 > 0 and var_82_1 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_7 and arg_79_1.time_ < var_82_0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play318021020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 318021020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play318021021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 1.5

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(318021020)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 60
				local var_86_5 = utf8.len(var_86_3)
				local var_86_6 = var_86_4 <= 0 and var_86_1 or var_86_1 * (var_86_5 / var_86_4)

				if var_86_6 > 0 and var_86_1 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_7 and arg_83_1.time_ < var_86_0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play318021021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 318021021
		arg_87_1.duration_ = 3.4

		local var_87_0 = {
			zh = 2.466,
			ja = 3.4
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play318021022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1015ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1015ui_story == nil then
				arg_87_1.var_.characterEffect1015ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect1015ui_story and not isNil(var_90_0) then
					arg_87_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1015ui_story then
				arg_87_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_90_4 = 0
			local var_90_5 = 0.35

			if var_90_4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_6 = arg_87_1:FormatText(StoryNameCfg[479].name)

				arg_87_1.leftNameTxt_.text = var_90_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_7 = arg_87_1:GetWordFromCfg(318021021)
				local var_90_8 = arg_87_1:FormatText(var_90_7.content)

				arg_87_1.text_.text = var_90_8

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 14
				local var_90_10 = utf8.len(var_90_8)
				local var_90_11 = var_90_9 <= 0 and var_90_5 or var_90_5 * (var_90_10 / var_90_9)

				if var_90_11 > 0 and var_90_5 < var_90_11 then
					arg_87_1.talkMaxDuration = var_90_11

					if var_90_11 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_11 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_8
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021021", "story_v_out_318021.awb") ~= 0 then
					local var_90_12 = manager.audio:GetVoiceLength("story_v_out_318021", "318021021", "story_v_out_318021.awb") / 1000

					if var_90_12 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_4
					end

					if var_90_7.prefab_name ~= "" and arg_87_1.actors_[var_90_7.prefab_name] ~= nil then
						local var_90_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_7.prefab_name].transform, "story_v_out_318021", "318021021", "story_v_out_318021.awb")

						arg_87_1:RecordAudio("318021021", var_90_13)
						arg_87_1:RecordAudio("318021021", var_90_13)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_318021", "318021021", "story_v_out_318021.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_318021", "318021021", "story_v_out_318021.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_14 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_14 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_14

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_14 and arg_87_1.time_ < var_90_4 + var_90_14 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play318021022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 318021022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play318021023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1015ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1015ui_story == nil then
				arg_91_1.var_.characterEffect1015ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1015ui_story and not isNil(var_94_0) then
					local var_94_4 = Mathf.Lerp(0, 0.5, var_94_3)

					arg_91_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1015ui_story.fillRatio = var_94_4
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1015ui_story then
				local var_94_5 = 0.5

				arg_91_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1015ui_story.fillRatio = var_94_5
			end

			local var_94_6 = 0
			local var_94_7 = 0.525

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_8 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_9 = arg_91_1:GetWordFromCfg(318021022)
				local var_94_10 = arg_91_1:FormatText(var_94_9.content)

				arg_91_1.text_.text = var_94_10

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 21
				local var_94_12 = utf8.len(var_94_10)
				local var_94_13 = var_94_11 <= 0 and var_94_7 or var_94_7 * (var_94_12 / var_94_11)

				if var_94_13 > 0 and var_94_7 < var_94_13 then
					arg_91_1.talkMaxDuration = var_94_13

					if var_94_13 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_10
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_14 and arg_91_1.time_ < var_94_6 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play318021023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 318021023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play318021024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1015ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1015ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, 100, 0)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1015ui_story, var_98_4, var_98_3)

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
			local var_98_10 = 1.25

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

				local var_98_11 = arg_95_1:GetWordFromCfg(318021023)
				local var_98_12 = arg_95_1:FormatText(var_98_11.content)

				arg_95_1.text_.text = var_98_12

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_13 = 50
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
				actorName = "1015ui_story",
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
	Play318021024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 318021024
		arg_99_1.duration_ = 2

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play318021025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = "1199ui_story"

			if arg_99_1.actors_[var_102_0] == nil then
				local var_102_1 = Asset.Load("Char/" .. "1199ui_story")

				if not isNil(var_102_1) then
					local var_102_2 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_99_1.stage_.transform)

					var_102_2.name = var_102_0
					var_102_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_99_1.actors_[var_102_0] = var_102_2

					local var_102_3 = var_102_2:GetComponentInChildren(typeof(CharacterEffect))

					var_102_3.enabled = true

					local var_102_4 = GameObjectTools.GetOrAddComponent(var_102_2, typeof(DynamicBoneHelper))

					if var_102_4 then
						var_102_4:EnableDynamicBone(false)
					end

					arg_99_1:ShowWeapon(var_102_3.transform, false)

					arg_99_1.var_[var_102_0 .. "Animator"] = var_102_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_99_1.var_[var_102_0 .. "Animator"].applyRootMotion = true
					arg_99_1.var_[var_102_0 .. "LipSync"] = var_102_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_102_5 = arg_99_1.actors_["1199ui_story"].transform
			local var_102_6 = 0

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.var_.moveOldPos1199ui_story = var_102_5.localPosition
			end

			local var_102_7 = 0.001

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_7 then
				local var_102_8 = (arg_99_1.time_ - var_102_6) / var_102_7
				local var_102_9 = Vector3.New(0, -1.08, -5.9)

				var_102_5.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1199ui_story, var_102_9, var_102_8)

				local var_102_10 = manager.ui.mainCamera.transform.position - var_102_5.position

				var_102_5.forward = Vector3.New(var_102_10.x, var_102_10.y, var_102_10.z)

				local var_102_11 = var_102_5.localEulerAngles

				var_102_11.z = 0
				var_102_11.x = 0
				var_102_5.localEulerAngles = var_102_11
			end

			if arg_99_1.time_ >= var_102_6 + var_102_7 and arg_99_1.time_ < var_102_6 + var_102_7 + arg_102_0 then
				var_102_5.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_102_12 = manager.ui.mainCamera.transform.position - var_102_5.position

				var_102_5.forward = Vector3.New(var_102_12.x, var_102_12.y, var_102_12.z)

				local var_102_13 = var_102_5.localEulerAngles

				var_102_13.z = 0
				var_102_13.x = 0
				var_102_5.localEulerAngles = var_102_13
			end

			local var_102_14 = arg_99_1.actors_["1199ui_story"]
			local var_102_15 = 0

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 and not isNil(var_102_14) and arg_99_1.var_.characterEffect1199ui_story == nil then
				arg_99_1.var_.characterEffect1199ui_story = var_102_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_16 = 0.200000002980232

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_16 and not isNil(var_102_14) then
				local var_102_17 = (arg_99_1.time_ - var_102_15) / var_102_16

				if arg_99_1.var_.characterEffect1199ui_story and not isNil(var_102_14) then
					arg_99_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_15 + var_102_16 and arg_99_1.time_ < var_102_15 + var_102_16 + arg_102_0 and not isNil(var_102_14) and arg_99_1.var_.characterEffect1199ui_story then
				arg_99_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_102_18 = 0

			if var_102_18 < arg_99_1.time_ and arg_99_1.time_ <= var_102_18 + arg_102_0 then
				arg_99_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action5_1")
			end

			local var_102_19 = 0

			if var_102_19 < arg_99_1.time_ and arg_99_1.time_ <= var_102_19 + arg_102_0 then
				arg_99_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_102_20 = 0
			local var_102_21 = 0.15

			if var_102_20 < arg_99_1.time_ and arg_99_1.time_ <= var_102_20 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_22 = arg_99_1:FormatText(StoryNameCfg[84].name)

				arg_99_1.leftNameTxt_.text = var_102_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_23 = arg_99_1:GetWordFromCfg(318021024)
				local var_102_24 = arg_99_1:FormatText(var_102_23.content)

				arg_99_1.text_.text = var_102_24

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_25 = 6
				local var_102_26 = utf8.len(var_102_24)
				local var_102_27 = var_102_25 <= 0 and var_102_21 or var_102_21 * (var_102_26 / var_102_25)

				if var_102_27 > 0 and var_102_21 < var_102_27 then
					arg_99_1.talkMaxDuration = var_102_27

					if var_102_27 + var_102_20 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_27 + var_102_20
					end
				end

				arg_99_1.text_.text = var_102_24
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021024", "story_v_out_318021.awb") ~= 0 then
					local var_102_28 = manager.audio:GetVoiceLength("story_v_out_318021", "318021024", "story_v_out_318021.awb") / 1000

					if var_102_28 + var_102_20 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_28 + var_102_20
					end

					if var_102_23.prefab_name ~= "" and arg_99_1.actors_[var_102_23.prefab_name] ~= nil then
						local var_102_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_23.prefab_name].transform, "story_v_out_318021", "318021024", "story_v_out_318021.awb")

						arg_99_1:RecordAudio("318021024", var_102_29)
						arg_99_1:RecordAudio("318021024", var_102_29)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_318021", "318021024", "story_v_out_318021.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_318021", "318021024", "story_v_out_318021.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_30 = math.max(var_102_21, arg_99_1.talkMaxDuration)

			if var_102_20 <= arg_99_1.time_ and arg_99_1.time_ < var_102_20 + var_102_30 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_20) / var_102_30

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_20 + var_102_30 and arg_99_1.time_ < var_102_20 + var_102_30 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318021025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 318021025
		arg_103_1.duration_ = 3.1

		local var_103_0 = {
			zh = 2.666,
			ja = 3.1
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
				arg_103_0:Play318021026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1093ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1093ui_story = var_106_0.localPosition
			end

			local var_106_2 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2
				local var_106_4 = Vector3.New(0.7, -1.11, -5.88)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1093ui_story, var_106_4, var_106_3)

				local var_106_5 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_5.x, var_106_5.y, var_106_5.z)

				local var_106_6 = var_106_0.localEulerAngles

				var_106_6.z = 0
				var_106_6.x = 0
				var_106_0.localEulerAngles = var_106_6
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_106_7 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_7.x, var_106_7.y, var_106_7.z)

				local var_106_8 = var_106_0.localEulerAngles

				var_106_8.z = 0
				var_106_8.x = 0
				var_106_0.localEulerAngles = var_106_8
			end

			local var_106_9 = arg_103_1.actors_["1093ui_story"]
			local var_106_10 = 0

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1093ui_story == nil then
				arg_103_1.var_.characterEffect1093ui_story = var_106_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_11 = 0.200000002980232

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_11 and not isNil(var_106_9) then
				local var_106_12 = (arg_103_1.time_ - var_106_10) / var_106_11

				if arg_103_1.var_.characterEffect1093ui_story and not isNil(var_106_9) then
					arg_103_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_10 + var_106_11 and arg_103_1.time_ < var_106_10 + var_106_11 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1093ui_story then
				arg_103_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_106_13 = arg_103_1.actors_["1199ui_story"].transform
			local var_106_14 = 0

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1.var_.moveOldPos1199ui_story = var_106_13.localPosition
			end

			local var_106_15 = 0.001

			if var_106_14 <= arg_103_1.time_ and arg_103_1.time_ < var_106_14 + var_106_15 then
				local var_106_16 = (arg_103_1.time_ - var_106_14) / var_106_15
				local var_106_17 = Vector3.New(-0.7, -1.08, -5.9)

				var_106_13.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1199ui_story, var_106_17, var_106_16)

				local var_106_18 = manager.ui.mainCamera.transform.position - var_106_13.position

				var_106_13.forward = Vector3.New(var_106_18.x, var_106_18.y, var_106_18.z)

				local var_106_19 = var_106_13.localEulerAngles

				var_106_19.z = 0
				var_106_19.x = 0
				var_106_13.localEulerAngles = var_106_19
			end

			if arg_103_1.time_ >= var_106_14 + var_106_15 and arg_103_1.time_ < var_106_14 + var_106_15 + arg_106_0 then
				var_106_13.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_106_20 = manager.ui.mainCamera.transform.position - var_106_13.position

				var_106_13.forward = Vector3.New(var_106_20.x, var_106_20.y, var_106_20.z)

				local var_106_21 = var_106_13.localEulerAngles

				var_106_21.z = 0
				var_106_21.x = 0
				var_106_13.localEulerAngles = var_106_21
			end

			local var_106_22 = arg_103_1.actors_["1199ui_story"]
			local var_106_23 = 0

			if var_106_23 < arg_103_1.time_ and arg_103_1.time_ <= var_106_23 + arg_106_0 and not isNil(var_106_22) and arg_103_1.var_.characterEffect1199ui_story == nil then
				arg_103_1.var_.characterEffect1199ui_story = var_106_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_24 = 0.200000002980232

			if var_106_23 <= arg_103_1.time_ and arg_103_1.time_ < var_106_23 + var_106_24 and not isNil(var_106_22) then
				local var_106_25 = (arg_103_1.time_ - var_106_23) / var_106_24

				if arg_103_1.var_.characterEffect1199ui_story and not isNil(var_106_22) then
					local var_106_26 = Mathf.Lerp(0, 0.5, var_106_25)

					arg_103_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1199ui_story.fillRatio = var_106_26
				end
			end

			if arg_103_1.time_ >= var_106_23 + var_106_24 and arg_103_1.time_ < var_106_23 + var_106_24 + arg_106_0 and not isNil(var_106_22) and arg_103_1.var_.characterEffect1199ui_story then
				local var_106_27 = 0.5

				arg_103_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1199ui_story.fillRatio = var_106_27
			end

			local var_106_28 = 0

			if var_106_28 < arg_103_1.time_ and arg_103_1.time_ <= var_106_28 + arg_106_0 then
				arg_103_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			local var_106_29 = 0
			local var_106_30 = 0.2

			if var_106_29 < arg_103_1.time_ and arg_103_1.time_ <= var_106_29 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_31 = arg_103_1:FormatText(StoryNameCfg[73].name)

				arg_103_1.leftNameTxt_.text = var_106_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_32 = arg_103_1:GetWordFromCfg(318021025)
				local var_106_33 = arg_103_1:FormatText(var_106_32.content)

				arg_103_1.text_.text = var_106_33

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_34 = 8
				local var_106_35 = utf8.len(var_106_33)
				local var_106_36 = var_106_34 <= 0 and var_106_30 or var_106_30 * (var_106_35 / var_106_34)

				if var_106_36 > 0 and var_106_30 < var_106_36 then
					arg_103_1.talkMaxDuration = var_106_36

					if var_106_36 + var_106_29 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_36 + var_106_29
					end
				end

				arg_103_1.text_.text = var_106_33
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021025", "story_v_out_318021.awb") ~= 0 then
					local var_106_37 = manager.audio:GetVoiceLength("story_v_out_318021", "318021025", "story_v_out_318021.awb") / 1000

					if var_106_37 + var_106_29 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_37 + var_106_29
					end

					if var_106_32.prefab_name ~= "" and arg_103_1.actors_[var_106_32.prefab_name] ~= nil then
						local var_106_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_32.prefab_name].transform, "story_v_out_318021", "318021025", "story_v_out_318021.awb")

						arg_103_1:RecordAudio("318021025", var_106_38)
						arg_103_1:RecordAudio("318021025", var_106_38)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_318021", "318021025", "story_v_out_318021.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_318021", "318021025", "story_v_out_318021.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_39 = math.max(var_106_30, arg_103_1.talkMaxDuration)

			if var_106_29 <= arg_103_1.time_ and arg_103_1.time_ < var_106_29 + var_106_39 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_29) / var_106_39

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_29 + var_106_39 and arg_103_1.time_ < var_106_29 + var_106_39 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play318021026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 318021026
		arg_107_1.duration_ = 12.77

		local var_107_0 = {
			zh = 12.766,
			ja = 9.066
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
				arg_107_0:Play318021027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1093ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1093ui_story == nil then
				arg_107_1.var_.characterEffect1093ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1093ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1093ui_story then
				arg_107_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_110_4 = 0
			local var_110_5 = 1.075

			if var_110_4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_6 = arg_107_1:FormatText(StoryNameCfg[73].name)

				arg_107_1.leftNameTxt_.text = var_110_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_7 = arg_107_1:GetWordFromCfg(318021026)
				local var_110_8 = arg_107_1:FormatText(var_110_7.content)

				arg_107_1.text_.text = var_110_8

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 43
				local var_110_10 = utf8.len(var_110_8)
				local var_110_11 = var_110_9 <= 0 and var_110_5 or var_110_5 * (var_110_10 / var_110_9)

				if var_110_11 > 0 and var_110_5 < var_110_11 then
					arg_107_1.talkMaxDuration = var_110_11

					if var_110_11 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_8
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021026", "story_v_out_318021.awb") ~= 0 then
					local var_110_12 = manager.audio:GetVoiceLength("story_v_out_318021", "318021026", "story_v_out_318021.awb") / 1000

					if var_110_12 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_4
					end

					if var_110_7.prefab_name ~= "" and arg_107_1.actors_[var_110_7.prefab_name] ~= nil then
						local var_110_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_7.prefab_name].transform, "story_v_out_318021", "318021026", "story_v_out_318021.awb")

						arg_107_1:RecordAudio("318021026", var_110_13)
						arg_107_1:RecordAudio("318021026", var_110_13)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_318021", "318021026", "story_v_out_318021.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_318021", "318021026", "story_v_out_318021.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_14 and arg_107_1.time_ < var_110_4 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play318021027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 318021027
		arg_111_1.duration_ = 8.3

		local var_111_0 = {
			zh = 4.7,
			ja = 8.3
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
				arg_111_0:Play318021028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1015ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1015ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(0, -1.15, -6.2)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1015ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["1015ui_story"]
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect1015ui_story == nil then
				arg_111_1.var_.characterEffect1015ui_story = var_114_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_11 = 0.200000002980232

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 and not isNil(var_114_9) then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11

				if arg_111_1.var_.characterEffect1015ui_story and not isNil(var_114_9) then
					arg_111_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect1015ui_story then
				arg_111_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_114_13 = 0

			if var_114_13 < arg_111_1.time_ and arg_111_1.time_ <= var_114_13 + arg_114_0 then
				arg_111_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_114_14 = 0

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				arg_111_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_114_15 = arg_111_1.actors_["1093ui_story"].transform
			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.var_.moveOldPos1093ui_story = var_114_15.localPosition
			end

			local var_114_17 = 0.001

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_17 then
				local var_114_18 = (arg_111_1.time_ - var_114_16) / var_114_17
				local var_114_19 = Vector3.New(0, 100, 0)

				var_114_15.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1093ui_story, var_114_19, var_114_18)

				local var_114_20 = manager.ui.mainCamera.transform.position - var_114_15.position

				var_114_15.forward = Vector3.New(var_114_20.x, var_114_20.y, var_114_20.z)

				local var_114_21 = var_114_15.localEulerAngles

				var_114_21.z = 0
				var_114_21.x = 0
				var_114_15.localEulerAngles = var_114_21
			end

			if arg_111_1.time_ >= var_114_16 + var_114_17 and arg_111_1.time_ < var_114_16 + var_114_17 + arg_114_0 then
				var_114_15.localPosition = Vector3.New(0, 100, 0)

				local var_114_22 = manager.ui.mainCamera.transform.position - var_114_15.position

				var_114_15.forward = Vector3.New(var_114_22.x, var_114_22.y, var_114_22.z)

				local var_114_23 = var_114_15.localEulerAngles

				var_114_23.z = 0
				var_114_23.x = 0
				var_114_15.localEulerAngles = var_114_23
			end

			local var_114_24 = arg_111_1.actors_["1093ui_story"]
			local var_114_25 = 0

			if var_114_25 < arg_111_1.time_ and arg_111_1.time_ <= var_114_25 + arg_114_0 and not isNil(var_114_24) and arg_111_1.var_.characterEffect1093ui_story == nil then
				arg_111_1.var_.characterEffect1093ui_story = var_114_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_26 = 0.200000002980232

			if var_114_25 <= arg_111_1.time_ and arg_111_1.time_ < var_114_25 + var_114_26 and not isNil(var_114_24) then
				local var_114_27 = (arg_111_1.time_ - var_114_25) / var_114_26

				if arg_111_1.var_.characterEffect1093ui_story and not isNil(var_114_24) then
					local var_114_28 = Mathf.Lerp(0, 0.5, var_114_27)

					arg_111_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1093ui_story.fillRatio = var_114_28
				end
			end

			if arg_111_1.time_ >= var_114_25 + var_114_26 and arg_111_1.time_ < var_114_25 + var_114_26 + arg_114_0 and not isNil(var_114_24) and arg_111_1.var_.characterEffect1093ui_story then
				local var_114_29 = 0.5

				arg_111_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1093ui_story.fillRatio = var_114_29
			end

			local var_114_30 = arg_111_1.actors_["1199ui_story"].transform
			local var_114_31 = 0

			if var_114_31 < arg_111_1.time_ and arg_111_1.time_ <= var_114_31 + arg_114_0 then
				arg_111_1.var_.moveOldPos1199ui_story = var_114_30.localPosition
			end

			local var_114_32 = 0.001

			if var_114_31 <= arg_111_1.time_ and arg_111_1.time_ < var_114_31 + var_114_32 then
				local var_114_33 = (arg_111_1.time_ - var_114_31) / var_114_32
				local var_114_34 = Vector3.New(0, 100, 0)

				var_114_30.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1199ui_story, var_114_34, var_114_33)

				local var_114_35 = manager.ui.mainCamera.transform.position - var_114_30.position

				var_114_30.forward = Vector3.New(var_114_35.x, var_114_35.y, var_114_35.z)

				local var_114_36 = var_114_30.localEulerAngles

				var_114_36.z = 0
				var_114_36.x = 0
				var_114_30.localEulerAngles = var_114_36
			end

			if arg_111_1.time_ >= var_114_31 + var_114_32 and arg_111_1.time_ < var_114_31 + var_114_32 + arg_114_0 then
				var_114_30.localPosition = Vector3.New(0, 100, 0)

				local var_114_37 = manager.ui.mainCamera.transform.position - var_114_30.position

				var_114_30.forward = Vector3.New(var_114_37.x, var_114_37.y, var_114_37.z)

				local var_114_38 = var_114_30.localEulerAngles

				var_114_38.z = 0
				var_114_38.x = 0
				var_114_30.localEulerAngles = var_114_38
			end

			local var_114_39 = 0
			local var_114_40 = 0.775

			if var_114_39 < arg_111_1.time_ and arg_111_1.time_ <= var_114_39 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_41 = arg_111_1:FormatText(StoryNameCfg[479].name)

				arg_111_1.leftNameTxt_.text = var_114_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_42 = arg_111_1:GetWordFromCfg(318021027)
				local var_114_43 = arg_111_1:FormatText(var_114_42.content)

				arg_111_1.text_.text = var_114_43

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_44 = 31
				local var_114_45 = utf8.len(var_114_43)
				local var_114_46 = var_114_44 <= 0 and var_114_40 or var_114_40 * (var_114_45 / var_114_44)

				if var_114_46 > 0 and var_114_40 < var_114_46 then
					arg_111_1.talkMaxDuration = var_114_46

					if var_114_46 + var_114_39 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_46 + var_114_39
					end
				end

				arg_111_1.text_.text = var_114_43
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021027", "story_v_out_318021.awb") ~= 0 then
					local var_114_47 = manager.audio:GetVoiceLength("story_v_out_318021", "318021027", "story_v_out_318021.awb") / 1000

					if var_114_47 + var_114_39 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_47 + var_114_39
					end

					if var_114_42.prefab_name ~= "" and arg_111_1.actors_[var_114_42.prefab_name] ~= nil then
						local var_114_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_42.prefab_name].transform, "story_v_out_318021", "318021027", "story_v_out_318021.awb")

						arg_111_1:RecordAudio("318021027", var_114_48)
						arg_111_1:RecordAudio("318021027", var_114_48)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_318021", "318021027", "story_v_out_318021.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_318021", "318021027", "story_v_out_318021.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_49 = math.max(var_114_40, arg_111_1.talkMaxDuration)

			if var_114_39 <= arg_111_1.time_ and arg_111_1.time_ < var_114_39 + var_114_49 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_39) / var_114_49

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_39 + var_114_49 and arg_111_1.time_ < var_114_39 + var_114_49 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318021028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 318021028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play318021029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1015ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1015ui_story == nil then
				arg_115_1.var_.characterEffect1015ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1015ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1015ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1015ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1015ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 0.6

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_8 = arg_115_1:FormatText(StoryNameCfg[7].name)

				arg_115_1.leftNameTxt_.text = var_118_8

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

				local var_118_9 = arg_115_1:GetWordFromCfg(318021028)
				local var_118_10 = arg_115_1:FormatText(var_118_9.content)

				arg_115_1.text_.text = var_118_10

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 24
				local var_118_12 = utf8.len(var_118_10)
				local var_118_13 = var_118_11 <= 0 and var_118_7 or var_118_7 * (var_118_12 / var_118_11)

				if var_118_13 > 0 and var_118_7 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_10
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_14 and arg_115_1.time_ < var_118_6 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play318021029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 318021029
		arg_119_1.duration_ = 7.23

		local var_119_0 = {
			zh = 6.2,
			ja = 7.233
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
				arg_119_0:Play318021030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 2

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				local var_122_1 = manager.ui.mainCamera.transform.localPosition
				local var_122_2 = Vector3.New(0, 0, 10) + Vector3.New(var_122_1.x, var_122_1.y, 0)
				local var_122_3 = arg_119_1.bgs_.K10g

				var_122_3.transform.localPosition = var_122_2
				var_122_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_4 = var_122_3:GetComponent("SpriteRenderer")

				if var_122_4 and var_122_4.sprite then
					local var_122_5 = (var_122_3.transform.localPosition - var_122_1).z
					local var_122_6 = manager.ui.mainCameraCom_
					local var_122_7 = 2 * var_122_5 * Mathf.Tan(var_122_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_122_8 = var_122_7 * var_122_6.aspect
					local var_122_9 = var_122_4.sprite.bounds.size.x
					local var_122_10 = var_122_4.sprite.bounds.size.y
					local var_122_11 = var_122_8 / var_122_9
					local var_122_12 = var_122_7 / var_122_10
					local var_122_13 = var_122_12 < var_122_11 and var_122_11 or var_122_12

					var_122_3.transform.localScale = Vector3.New(var_122_13, var_122_13, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "K10g" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_14 = 0

			if var_122_14 < arg_119_1.time_ and arg_119_1.time_ <= var_122_14 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_15 = 2

			if var_122_14 <= arg_119_1.time_ and arg_119_1.time_ < var_122_14 + var_122_15 then
				local var_122_16 = (arg_119_1.time_ - var_122_14) / var_122_15
				local var_122_17 = Color.New(0, 0, 0)

				var_122_17.a = Mathf.Lerp(0, 1, var_122_16)
				arg_119_1.mask_.color = var_122_17
			end

			if arg_119_1.time_ >= var_122_14 + var_122_15 and arg_119_1.time_ < var_122_14 + var_122_15 + arg_122_0 then
				local var_122_18 = Color.New(0, 0, 0)

				var_122_18.a = 1
				arg_119_1.mask_.color = var_122_18
			end

			local var_122_19 = 2

			if var_122_19 < arg_119_1.time_ and arg_119_1.time_ <= var_122_19 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_20 = 2

			if var_122_19 <= arg_119_1.time_ and arg_119_1.time_ < var_122_19 + var_122_20 then
				local var_122_21 = (arg_119_1.time_ - var_122_19) / var_122_20
				local var_122_22 = Color.New(0, 0, 0)

				var_122_22.a = Mathf.Lerp(1, 0, var_122_21)
				arg_119_1.mask_.color = var_122_22
			end

			if arg_119_1.time_ >= var_122_19 + var_122_20 and arg_119_1.time_ < var_122_19 + var_122_20 + arg_122_0 then
				local var_122_23 = Color.New(0, 0, 0)
				local var_122_24 = 0

				arg_119_1.mask_.enabled = false
				var_122_23.a = var_122_24
				arg_119_1.mask_.color = var_122_23
			end

			local var_122_25 = arg_119_1.actors_["1049ui_story"].transform
			local var_122_26 = 4

			if var_122_26 < arg_119_1.time_ and arg_119_1.time_ <= var_122_26 + arg_122_0 then
				arg_119_1.var_.moveOldPos1049ui_story = var_122_25.localPosition
			end

			local var_122_27 = 0.001

			if var_122_26 <= arg_119_1.time_ and arg_119_1.time_ < var_122_26 + var_122_27 then
				local var_122_28 = (arg_119_1.time_ - var_122_26) / var_122_27
				local var_122_29 = Vector3.New(0, -1.2, -6)

				var_122_25.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1049ui_story, var_122_29, var_122_28)

				local var_122_30 = manager.ui.mainCamera.transform.position - var_122_25.position

				var_122_25.forward = Vector3.New(var_122_30.x, var_122_30.y, var_122_30.z)

				local var_122_31 = var_122_25.localEulerAngles

				var_122_31.z = 0
				var_122_31.x = 0
				var_122_25.localEulerAngles = var_122_31
			end

			if arg_119_1.time_ >= var_122_26 + var_122_27 and arg_119_1.time_ < var_122_26 + var_122_27 + arg_122_0 then
				var_122_25.localPosition = Vector3.New(0, -1.2, -6)

				local var_122_32 = manager.ui.mainCamera.transform.position - var_122_25.position

				var_122_25.forward = Vector3.New(var_122_32.x, var_122_32.y, var_122_32.z)

				local var_122_33 = var_122_25.localEulerAngles

				var_122_33.z = 0
				var_122_33.x = 0
				var_122_25.localEulerAngles = var_122_33
			end

			local var_122_34 = arg_119_1.actors_["1049ui_story"]
			local var_122_35 = 4

			if var_122_35 < arg_119_1.time_ and arg_119_1.time_ <= var_122_35 + arg_122_0 and not isNil(var_122_34) and arg_119_1.var_.characterEffect1049ui_story == nil then
				arg_119_1.var_.characterEffect1049ui_story = var_122_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_36 = 0.200000002980232

			if var_122_35 <= arg_119_1.time_ and arg_119_1.time_ < var_122_35 + var_122_36 and not isNil(var_122_34) then
				local var_122_37 = (arg_119_1.time_ - var_122_35) / var_122_36

				if arg_119_1.var_.characterEffect1049ui_story and not isNil(var_122_34) then
					arg_119_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_35 + var_122_36 and arg_119_1.time_ < var_122_35 + var_122_36 + arg_122_0 and not isNil(var_122_34) and arg_119_1.var_.characterEffect1049ui_story then
				arg_119_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_122_38 = 4

			if var_122_38 < arg_119_1.time_ and arg_119_1.time_ <= var_122_38 + arg_122_0 then
				arg_119_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_2")
			end

			local var_122_39 = 4

			if var_122_39 < arg_119_1.time_ and arg_119_1.time_ <= var_122_39 + arg_122_0 then
				arg_119_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_122_40 = arg_119_1.actors_["1015ui_story"].transform
			local var_122_41 = 2

			if var_122_41 < arg_119_1.time_ and arg_119_1.time_ <= var_122_41 + arg_122_0 then
				arg_119_1.var_.moveOldPos1015ui_story = var_122_40.localPosition
			end

			local var_122_42 = 0.001

			if var_122_41 <= arg_119_1.time_ and arg_119_1.time_ < var_122_41 + var_122_42 then
				local var_122_43 = (arg_119_1.time_ - var_122_41) / var_122_42
				local var_122_44 = Vector3.New(0, 100, 0)

				var_122_40.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1015ui_story, var_122_44, var_122_43)

				local var_122_45 = manager.ui.mainCamera.transform.position - var_122_40.position

				var_122_40.forward = Vector3.New(var_122_45.x, var_122_45.y, var_122_45.z)

				local var_122_46 = var_122_40.localEulerAngles

				var_122_46.z = 0
				var_122_46.x = 0
				var_122_40.localEulerAngles = var_122_46
			end

			if arg_119_1.time_ >= var_122_41 + var_122_42 and arg_119_1.time_ < var_122_41 + var_122_42 + arg_122_0 then
				var_122_40.localPosition = Vector3.New(0, 100, 0)

				local var_122_47 = manager.ui.mainCamera.transform.position - var_122_40.position

				var_122_40.forward = Vector3.New(var_122_47.x, var_122_47.y, var_122_47.z)

				local var_122_48 = var_122_40.localEulerAngles

				var_122_48.z = 0
				var_122_48.x = 0
				var_122_40.localEulerAngles = var_122_48
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_49 = 4
			local var_122_50 = 0.15

			if var_122_49 < arg_119_1.time_ and arg_119_1.time_ <= var_122_49 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_51 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_51:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_52 = arg_119_1:FormatText(StoryNameCfg[562].name)

				arg_119_1.leftNameTxt_.text = var_122_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_53 = arg_119_1:GetWordFromCfg(318021029)
				local var_122_54 = arg_119_1:FormatText(var_122_53.content)

				arg_119_1.text_.text = var_122_54

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_55 = 6
				local var_122_56 = utf8.len(var_122_54)
				local var_122_57 = var_122_55 <= 0 and var_122_50 or var_122_50 * (var_122_56 / var_122_55)

				if var_122_57 > 0 and var_122_50 < var_122_57 then
					arg_119_1.talkMaxDuration = var_122_57
					var_122_49 = var_122_49 + 0.3

					if var_122_57 + var_122_49 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_57 + var_122_49
					end
				end

				arg_119_1.text_.text = var_122_54
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021029", "story_v_out_318021.awb") ~= 0 then
					local var_122_58 = manager.audio:GetVoiceLength("story_v_out_318021", "318021029", "story_v_out_318021.awb") / 1000

					if var_122_58 + var_122_49 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_58 + var_122_49
					end

					if var_122_53.prefab_name ~= "" and arg_119_1.actors_[var_122_53.prefab_name] ~= nil then
						local var_122_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_53.prefab_name].transform, "story_v_out_318021", "318021029", "story_v_out_318021.awb")

						arg_119_1:RecordAudio("318021029", var_122_59)
						arg_119_1:RecordAudio("318021029", var_122_59)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_318021", "318021029", "story_v_out_318021.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_318021", "318021029", "story_v_out_318021.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_60 = var_122_49 + 0.3
			local var_122_61 = math.max(var_122_50, arg_119_1.talkMaxDuration)

			if var_122_60 <= arg_119_1.time_ and arg_119_1.time_ < var_122_60 + var_122_61 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_60) / var_122_61

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_60 + var_122_61 and arg_119_1.time_ < var_122_60 + var_122_61 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play318021030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 318021030
		arg_125_1.duration_ = 6.93

		local var_125_0 = {
			zh = 6.933,
			ja = 4.266
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
				arg_125_0:Play318021031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10053ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos10053ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0.7, -1.12, -5.99)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10053ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["10053ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect10053ui_story == nil then
				arg_125_1.var_.characterEffect10053ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect10053ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect10053ui_story then
				arg_125_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action34_1")
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_128_15 = arg_125_1.actors_["1049ui_story"].transform
			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.var_.moveOldPos1049ui_story = var_128_15.localPosition
			end

			local var_128_17 = 0.001

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17
				local var_128_19 = Vector3.New(-0.7, -1.2, -6)

				var_128_15.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1049ui_story, var_128_19, var_128_18)

				local var_128_20 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_20.x, var_128_20.y, var_128_20.z)

				local var_128_21 = var_128_15.localEulerAngles

				var_128_21.z = 0
				var_128_21.x = 0
				var_128_15.localEulerAngles = var_128_21
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 then
				var_128_15.localPosition = Vector3.New(-0.7, -1.2, -6)

				local var_128_22 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_22.x, var_128_22.y, var_128_22.z)

				local var_128_23 = var_128_15.localEulerAngles

				var_128_23.z = 0
				var_128_23.x = 0
				var_128_15.localEulerAngles = var_128_23
			end

			local var_128_24 = arg_125_1.actors_["1049ui_story"]
			local var_128_25 = 0

			if var_128_25 < arg_125_1.time_ and arg_125_1.time_ <= var_128_25 + arg_128_0 and not isNil(var_128_24) and arg_125_1.var_.characterEffect1049ui_story == nil then
				arg_125_1.var_.characterEffect1049ui_story = var_128_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_26 = 0.200000002980232

			if var_128_25 <= arg_125_1.time_ and arg_125_1.time_ < var_128_25 + var_128_26 and not isNil(var_128_24) then
				local var_128_27 = (arg_125_1.time_ - var_128_25) / var_128_26

				if arg_125_1.var_.characterEffect1049ui_story and not isNil(var_128_24) then
					local var_128_28 = Mathf.Lerp(0, 0.5, var_128_27)

					arg_125_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1049ui_story.fillRatio = var_128_28
				end
			end

			if arg_125_1.time_ >= var_128_25 + var_128_26 and arg_125_1.time_ < var_128_25 + var_128_26 + arg_128_0 and not isNil(var_128_24) and arg_125_1.var_.characterEffect1049ui_story then
				local var_128_29 = 0.5

				arg_125_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1049ui_story.fillRatio = var_128_29
			end

			local var_128_30 = 0
			local var_128_31 = 0.325

			if var_128_30 < arg_125_1.time_ and arg_125_1.time_ <= var_128_30 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_32 = arg_125_1:FormatText(StoryNameCfg[477].name)

				arg_125_1.leftNameTxt_.text = var_128_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_33 = arg_125_1:GetWordFromCfg(318021030)
				local var_128_34 = arg_125_1:FormatText(var_128_33.content)

				arg_125_1.text_.text = var_128_34

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_35 = 13
				local var_128_36 = utf8.len(var_128_34)
				local var_128_37 = var_128_35 <= 0 and var_128_31 or var_128_31 * (var_128_36 / var_128_35)

				if var_128_37 > 0 and var_128_31 < var_128_37 then
					arg_125_1.talkMaxDuration = var_128_37

					if var_128_37 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_37 + var_128_30
					end
				end

				arg_125_1.text_.text = var_128_34
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021030", "story_v_out_318021.awb") ~= 0 then
					local var_128_38 = manager.audio:GetVoiceLength("story_v_out_318021", "318021030", "story_v_out_318021.awb") / 1000

					if var_128_38 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_38 + var_128_30
					end

					if var_128_33.prefab_name ~= "" and arg_125_1.actors_[var_128_33.prefab_name] ~= nil then
						local var_128_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_33.prefab_name].transform, "story_v_out_318021", "318021030", "story_v_out_318021.awb")

						arg_125_1:RecordAudio("318021030", var_128_39)
						arg_125_1:RecordAudio("318021030", var_128_39)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_318021", "318021030", "story_v_out_318021.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_318021", "318021030", "story_v_out_318021.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_40 = math.max(var_128_31, arg_125_1.talkMaxDuration)

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_40 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_30) / var_128_40

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_30 + var_128_40 and arg_125_1.time_ < var_128_30 + var_128_40 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play318021031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 318021031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play318021032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10053ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10053ui_story == nil then
				arg_129_1.var_.characterEffect10053ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect10053ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10053ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10053ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10053ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 1.875

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(318021031)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 75
				local var_132_11 = utf8.len(var_132_9)
				local var_132_12 = var_132_10 <= 0 and var_132_7 or var_132_7 * (var_132_11 / var_132_10)

				if var_132_12 > 0 and var_132_7 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_13 and arg_129_1.time_ < var_132_6 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play318021032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 318021032
		arg_133_1.duration_ = 2

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play318021033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = "1058ui_story"

			if arg_133_1.actors_[var_136_0] == nil then
				local var_136_1 = Asset.Load("Char/" .. "1058ui_story")

				if not isNil(var_136_1) then
					local var_136_2 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_133_1.stage_.transform)

					var_136_2.name = var_136_0
					var_136_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_133_1.actors_[var_136_0] = var_136_2

					local var_136_3 = var_136_2:GetComponentInChildren(typeof(CharacterEffect))

					var_136_3.enabled = true

					local var_136_4 = GameObjectTools.GetOrAddComponent(var_136_2, typeof(DynamicBoneHelper))

					if var_136_4 then
						var_136_4:EnableDynamicBone(false)
					end

					arg_133_1:ShowWeapon(var_136_3.transform, false)

					arg_133_1.var_[var_136_0 .. "Animator"] = var_136_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_133_1.var_[var_136_0 .. "Animator"].applyRootMotion = true
					arg_133_1.var_[var_136_0 .. "LipSync"] = var_136_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_136_5 = arg_133_1.actors_["1058ui_story"].transform
			local var_136_6 = 0

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.var_.moveOldPos1058ui_story = var_136_5.localPosition
			end

			local var_136_7 = 0.001

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_7 then
				local var_136_8 = (arg_133_1.time_ - var_136_6) / var_136_7
				local var_136_9 = Vector3.New(0, -0.95, -5.88)

				var_136_5.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1058ui_story, var_136_9, var_136_8)

				local var_136_10 = manager.ui.mainCamera.transform.position - var_136_5.position

				var_136_5.forward = Vector3.New(var_136_10.x, var_136_10.y, var_136_10.z)

				local var_136_11 = var_136_5.localEulerAngles

				var_136_11.z = 0
				var_136_11.x = 0
				var_136_5.localEulerAngles = var_136_11
			end

			if arg_133_1.time_ >= var_136_6 + var_136_7 and arg_133_1.time_ < var_136_6 + var_136_7 + arg_136_0 then
				var_136_5.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_136_12 = manager.ui.mainCamera.transform.position - var_136_5.position

				var_136_5.forward = Vector3.New(var_136_12.x, var_136_12.y, var_136_12.z)

				local var_136_13 = var_136_5.localEulerAngles

				var_136_13.z = 0
				var_136_13.x = 0
				var_136_5.localEulerAngles = var_136_13
			end

			local var_136_14 = arg_133_1.actors_["1058ui_story"]
			local var_136_15 = 0

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 and not isNil(var_136_14) and arg_133_1.var_.characterEffect1058ui_story == nil then
				arg_133_1.var_.characterEffect1058ui_story = var_136_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_16 = 0.200000002980232

			if var_136_15 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_16 and not isNil(var_136_14) then
				local var_136_17 = (arg_133_1.time_ - var_136_15) / var_136_16

				if arg_133_1.var_.characterEffect1058ui_story and not isNil(var_136_14) then
					arg_133_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_15 + var_136_16 and arg_133_1.time_ < var_136_15 + var_136_16 + arg_136_0 and not isNil(var_136_14) and arg_133_1.var_.characterEffect1058ui_story then
				arg_133_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_136_18 = 0

			if var_136_18 < arg_133_1.time_ and arg_133_1.time_ <= var_136_18 + arg_136_0 then
				arg_133_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			local var_136_19 = 0

			if var_136_19 < arg_133_1.time_ and arg_133_1.time_ <= var_136_19 + arg_136_0 then
				arg_133_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_136_20 = arg_133_1.actors_["10053ui_story"].transform
			local var_136_21 = 0

			if var_136_21 < arg_133_1.time_ and arg_133_1.time_ <= var_136_21 + arg_136_0 then
				arg_133_1.var_.moveOldPos10053ui_story = var_136_20.localPosition
			end

			local var_136_22 = 0.001

			if var_136_21 <= arg_133_1.time_ and arg_133_1.time_ < var_136_21 + var_136_22 then
				local var_136_23 = (arg_133_1.time_ - var_136_21) / var_136_22
				local var_136_24 = Vector3.New(0, 100, 0)

				var_136_20.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10053ui_story, var_136_24, var_136_23)

				local var_136_25 = manager.ui.mainCamera.transform.position - var_136_20.position

				var_136_20.forward = Vector3.New(var_136_25.x, var_136_25.y, var_136_25.z)

				local var_136_26 = var_136_20.localEulerAngles

				var_136_26.z = 0
				var_136_26.x = 0
				var_136_20.localEulerAngles = var_136_26
			end

			if arg_133_1.time_ >= var_136_21 + var_136_22 and arg_133_1.time_ < var_136_21 + var_136_22 + arg_136_0 then
				var_136_20.localPosition = Vector3.New(0, 100, 0)

				local var_136_27 = manager.ui.mainCamera.transform.position - var_136_20.position

				var_136_20.forward = Vector3.New(var_136_27.x, var_136_27.y, var_136_27.z)

				local var_136_28 = var_136_20.localEulerAngles

				var_136_28.z = 0
				var_136_28.x = 0
				var_136_20.localEulerAngles = var_136_28
			end

			local var_136_29 = arg_133_1.actors_["1049ui_story"].transform
			local var_136_30 = 0

			if var_136_30 < arg_133_1.time_ and arg_133_1.time_ <= var_136_30 + arg_136_0 then
				arg_133_1.var_.moveOldPos1049ui_story = var_136_29.localPosition
			end

			local var_136_31 = 0.001

			if var_136_30 <= arg_133_1.time_ and arg_133_1.time_ < var_136_30 + var_136_31 then
				local var_136_32 = (arg_133_1.time_ - var_136_30) / var_136_31
				local var_136_33 = Vector3.New(0, 100, 0)

				var_136_29.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1049ui_story, var_136_33, var_136_32)

				local var_136_34 = manager.ui.mainCamera.transform.position - var_136_29.position

				var_136_29.forward = Vector3.New(var_136_34.x, var_136_34.y, var_136_34.z)

				local var_136_35 = var_136_29.localEulerAngles

				var_136_35.z = 0
				var_136_35.x = 0
				var_136_29.localEulerAngles = var_136_35
			end

			if arg_133_1.time_ >= var_136_30 + var_136_31 and arg_133_1.time_ < var_136_30 + var_136_31 + arg_136_0 then
				var_136_29.localPosition = Vector3.New(0, 100, 0)

				local var_136_36 = manager.ui.mainCamera.transform.position - var_136_29.position

				var_136_29.forward = Vector3.New(var_136_36.x, var_136_36.y, var_136_36.z)

				local var_136_37 = var_136_29.localEulerAngles

				var_136_37.z = 0
				var_136_37.x = 0
				var_136_29.localEulerAngles = var_136_37
			end

			local var_136_38 = 0
			local var_136_39 = 0.125

			if var_136_38 < arg_133_1.time_ and arg_133_1.time_ <= var_136_38 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_40 = arg_133_1:FormatText(StoryNameCfg[92].name)

				arg_133_1.leftNameTxt_.text = var_136_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_41 = arg_133_1:GetWordFromCfg(318021032)
				local var_136_42 = arg_133_1:FormatText(var_136_41.content)

				arg_133_1.text_.text = var_136_42

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_43 = 5
				local var_136_44 = utf8.len(var_136_42)
				local var_136_45 = var_136_43 <= 0 and var_136_39 or var_136_39 * (var_136_44 / var_136_43)

				if var_136_45 > 0 and var_136_39 < var_136_45 then
					arg_133_1.talkMaxDuration = var_136_45

					if var_136_45 + var_136_38 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_45 + var_136_38
					end
				end

				arg_133_1.text_.text = var_136_42
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021032", "story_v_out_318021.awb") ~= 0 then
					local var_136_46 = manager.audio:GetVoiceLength("story_v_out_318021", "318021032", "story_v_out_318021.awb") / 1000

					if var_136_46 + var_136_38 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_46 + var_136_38
					end

					if var_136_41.prefab_name ~= "" and arg_133_1.actors_[var_136_41.prefab_name] ~= nil then
						local var_136_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_41.prefab_name].transform, "story_v_out_318021", "318021032", "story_v_out_318021.awb")

						arg_133_1:RecordAudio("318021032", var_136_47)
						arg_133_1:RecordAudio("318021032", var_136_47)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_318021", "318021032", "story_v_out_318021.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_318021", "318021032", "story_v_out_318021.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_48 = math.max(var_136_39, arg_133_1.talkMaxDuration)

			if var_136_38 <= arg_133_1.time_ and arg_133_1.time_ < var_136_38 + var_136_48 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_38) / var_136_48

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_38 + var_136_48 and arg_133_1.time_ < var_136_38 + var_136_48 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play318021033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 318021033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play318021034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1058ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1058ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1058ui_story, var_140_4, var_140_3)

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

			local var_140_9 = arg_137_1.actors_["1058ui_story"]
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect1058ui_story == nil then
				arg_137_1.var_.characterEffect1058ui_story = var_140_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_11 = 0.200000002980232

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 and not isNil(var_140_9) then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11

				if arg_137_1.var_.characterEffect1058ui_story and not isNil(var_140_9) then
					local var_140_13 = Mathf.Lerp(0, 0.5, var_140_12)

					arg_137_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1058ui_story.fillRatio = var_140_13
				end
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect1058ui_story then
				local var_140_14 = 0.5

				arg_137_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1058ui_story.fillRatio = var_140_14
			end

			local var_140_15 = manager.ui.mainCamera.transform
			local var_140_16 = 0

			if var_140_16 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
				local var_140_17 = arg_137_1.var_.effecthuoyan1
				local var_140_18
				local var_140_19 = var_140_15

				if not var_140_17 then
					var_140_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_140_19)
					var_140_17.name = "huoyan1"
					arg_137_1.var_.effecthuoyan1 = var_140_17
				else
					var_140_17.transform:SetParent(var_140_19)
				end

				var_140_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_140_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_140_20 = manager.ui.mainCamera.transform
			local var_140_21 = 2

			if var_140_21 < arg_137_1.time_ and arg_137_1.time_ <= var_140_21 + arg_140_0 then
				local var_140_22 = arg_137_1.var_.effecthuoyan1

				if var_140_22 then
					Object.Destroy(var_140_22)

					arg_137_1.var_.effecthuoyan1 = nil
				end
			end

			local var_140_23 = 0

			if var_140_23 < arg_137_1.time_ and arg_137_1.time_ <= var_140_23 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = false

				arg_137_1:SetGaussion(false)
			end

			local var_140_24 = 0.5

			if var_140_23 <= arg_137_1.time_ and arg_137_1.time_ < var_140_23 + var_140_24 then
				local var_140_25 = (arg_137_1.time_ - var_140_23) / var_140_24
				local var_140_26 = Color.New(1, 0.4079707, 0.03301889)

				var_140_26.a = Mathf.Lerp(1, 0, var_140_25)
				arg_137_1.mask_.color = var_140_26
			end

			if arg_137_1.time_ >= var_140_23 + var_140_24 and arg_137_1.time_ < var_140_23 + var_140_24 + arg_140_0 then
				local var_140_27 = Color.New(1, 0.4079707, 0.03301889)
				local var_140_28 = 0

				arg_137_1.mask_.enabled = false
				var_140_27.a = var_140_28
				arg_137_1.mask_.color = var_140_27
			end

			local var_140_29 = manager.ui.mainCamera.transform
			local var_140_30 = 0

			if var_140_30 < arg_137_1.time_ and arg_137_1.time_ <= var_140_30 + arg_140_0 then
				local var_140_31 = arg_137_1.var_.effectjiajutuhuoyan1
				local var_140_32
				local var_140_33 = var_140_29

				if not var_140_31 then
					var_140_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), var_140_33)
					var_140_31.name = "jiajutuhuoyan1"
					arg_137_1.var_.effectjiajutuhuoyan1 = var_140_31
				else
					var_140_31.transform:SetParent(var_140_33)
				end

				var_140_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_140_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_140_34 = 0
			local var_140_35 = 1

			if var_140_34 < arg_137_1.time_ and arg_137_1.time_ <= var_140_34 + arg_140_0 then
				local var_140_36 = "play"
				local var_140_37 = "effect"

				arg_137_1:AudioAction(var_140_36, var_140_37, "se_story_123_02", "se_story_123_02_fire", "")
			end

			local var_140_38 = 0
			local var_140_39 = 1.75

			if var_140_38 < arg_137_1.time_ and arg_137_1.time_ <= var_140_38 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_40 = arg_137_1:GetWordFromCfg(318021033)
				local var_140_41 = arg_137_1:FormatText(var_140_40.content)

				arg_137_1.text_.text = var_140_41

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_42 = 70
				local var_140_43 = utf8.len(var_140_41)
				local var_140_44 = var_140_42 <= 0 and var_140_39 or var_140_39 * (var_140_43 / var_140_42)

				if var_140_44 > 0 and var_140_39 < var_140_44 then
					arg_137_1.talkMaxDuration = var_140_44

					if var_140_44 + var_140_38 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_44 + var_140_38
					end
				end

				arg_137_1.text_.text = var_140_41
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_45 = math.max(var_140_39, arg_137_1.talkMaxDuration)

			if var_140_38 <= arg_137_1.time_ and arg_137_1.time_ < var_140_38 + var_140_45 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_38) / var_140_45

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_38 + var_140_45 and arg_137_1.time_ < var_140_38 + var_140_45 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play318021034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 318021034
		arg_141_1.duration_ = 3.3

		local var_141_0 = {
			zh = 3.3,
			ja = 2.866
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
				arg_141_0:Play318021035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1049ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1049ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, -1.2, -6)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1049ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1049ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1049ui_story == nil then
				arg_141_1.var_.characterEffect1049ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect1049ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1049ui_story then
				arg_141_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_144_13 = manager.ui.mainCamera.transform
			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				local var_144_15 = arg_141_1.var_.effectjiajutuhuoyan1

				if var_144_15 then
					Object.Destroy(var_144_15)

					arg_141_1.var_.effectjiajutuhuoyan1 = nil
				end
			end

			local var_144_16 = 0
			local var_144_17 = 0.2

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_18 = arg_141_1:FormatText(StoryNameCfg[562].name)

				arg_141_1.leftNameTxt_.text = var_144_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_19 = arg_141_1:GetWordFromCfg(318021034)
				local var_144_20 = arg_141_1:FormatText(var_144_19.content)

				arg_141_1.text_.text = var_144_20

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_21 = 8
				local var_144_22 = utf8.len(var_144_20)
				local var_144_23 = var_144_21 <= 0 and var_144_17 or var_144_17 * (var_144_22 / var_144_21)

				if var_144_23 > 0 and var_144_17 < var_144_23 then
					arg_141_1.talkMaxDuration = var_144_23

					if var_144_23 + var_144_16 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_16
					end
				end

				arg_141_1.text_.text = var_144_20
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021034", "story_v_out_318021.awb") ~= 0 then
					local var_144_24 = manager.audio:GetVoiceLength("story_v_out_318021", "318021034", "story_v_out_318021.awb") / 1000

					if var_144_24 + var_144_16 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_24 + var_144_16
					end

					if var_144_19.prefab_name ~= "" and arg_141_1.actors_[var_144_19.prefab_name] ~= nil then
						local var_144_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_19.prefab_name].transform, "story_v_out_318021", "318021034", "story_v_out_318021.awb")

						arg_141_1:RecordAudio("318021034", var_144_25)
						arg_141_1:RecordAudio("318021034", var_144_25)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_318021", "318021034", "story_v_out_318021.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_318021", "318021034", "story_v_out_318021.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_26 = math.max(var_144_17, arg_141_1.talkMaxDuration)

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_26 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_16) / var_144_26

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_16 + var_144_26 and arg_141_1.time_ < var_144_16 + var_144_26 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play318021035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 318021035
		arg_145_1.duration_ = 10.6

		local var_145_0 = {
			zh = 10.6,
			ja = 8.633
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
				arg_145_0:Play318021036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10053ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10053ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0.7, -1.12, -5.99)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10053ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["10053ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect10053ui_story == nil then
				arg_145_1.var_.characterEffect10053ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect10053ui_story and not isNil(var_148_9) then
					arg_145_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect10053ui_story then
				arg_145_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_148_13 = arg_145_1.actors_["1049ui_story"].transform
			local var_148_14 = 0

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1.var_.moveOldPos1049ui_story = var_148_13.localPosition
			end

			local var_148_15 = 0.001

			if var_148_14 <= arg_145_1.time_ and arg_145_1.time_ < var_148_14 + var_148_15 then
				local var_148_16 = (arg_145_1.time_ - var_148_14) / var_148_15
				local var_148_17 = Vector3.New(-0.7, -1.2, -6)

				var_148_13.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1049ui_story, var_148_17, var_148_16)

				local var_148_18 = manager.ui.mainCamera.transform.position - var_148_13.position

				var_148_13.forward = Vector3.New(var_148_18.x, var_148_18.y, var_148_18.z)

				local var_148_19 = var_148_13.localEulerAngles

				var_148_19.z = 0
				var_148_19.x = 0
				var_148_13.localEulerAngles = var_148_19
			end

			if arg_145_1.time_ >= var_148_14 + var_148_15 and arg_145_1.time_ < var_148_14 + var_148_15 + arg_148_0 then
				var_148_13.localPosition = Vector3.New(-0.7, -1.2, -6)

				local var_148_20 = manager.ui.mainCamera.transform.position - var_148_13.position

				var_148_13.forward = Vector3.New(var_148_20.x, var_148_20.y, var_148_20.z)

				local var_148_21 = var_148_13.localEulerAngles

				var_148_21.z = 0
				var_148_21.x = 0
				var_148_13.localEulerAngles = var_148_21
			end

			local var_148_22 = arg_145_1.actors_["1049ui_story"]
			local var_148_23 = 0

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 and not isNil(var_148_22) and arg_145_1.var_.characterEffect1049ui_story == nil then
				arg_145_1.var_.characterEffect1049ui_story = var_148_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_24 = 0.200000002980232

			if var_148_23 <= arg_145_1.time_ and arg_145_1.time_ < var_148_23 + var_148_24 and not isNil(var_148_22) then
				local var_148_25 = (arg_145_1.time_ - var_148_23) / var_148_24

				if arg_145_1.var_.characterEffect1049ui_story and not isNil(var_148_22) then
					local var_148_26 = Mathf.Lerp(0, 0.5, var_148_25)

					arg_145_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1049ui_story.fillRatio = var_148_26
				end
			end

			if arg_145_1.time_ >= var_148_23 + var_148_24 and arg_145_1.time_ < var_148_23 + var_148_24 + arg_148_0 and not isNil(var_148_22) and arg_145_1.var_.characterEffect1049ui_story then
				local var_148_27 = 0.5

				arg_145_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1049ui_story.fillRatio = var_148_27
			end

			local var_148_28 = 0
			local var_148_29 = 0.8

			if var_148_28 < arg_145_1.time_ and arg_145_1.time_ <= var_148_28 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_30 = arg_145_1:FormatText(StoryNameCfg[477].name)

				arg_145_1.leftNameTxt_.text = var_148_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_31 = arg_145_1:GetWordFromCfg(318021035)
				local var_148_32 = arg_145_1:FormatText(var_148_31.content)

				arg_145_1.text_.text = var_148_32

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_33 = 32
				local var_148_34 = utf8.len(var_148_32)
				local var_148_35 = var_148_33 <= 0 and var_148_29 or var_148_29 * (var_148_34 / var_148_33)

				if var_148_35 > 0 and var_148_29 < var_148_35 then
					arg_145_1.talkMaxDuration = var_148_35

					if var_148_35 + var_148_28 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_35 + var_148_28
					end
				end

				arg_145_1.text_.text = var_148_32
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021035", "story_v_out_318021.awb") ~= 0 then
					local var_148_36 = manager.audio:GetVoiceLength("story_v_out_318021", "318021035", "story_v_out_318021.awb") / 1000

					if var_148_36 + var_148_28 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_36 + var_148_28
					end

					if var_148_31.prefab_name ~= "" and arg_145_1.actors_[var_148_31.prefab_name] ~= nil then
						local var_148_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_31.prefab_name].transform, "story_v_out_318021", "318021035", "story_v_out_318021.awb")

						arg_145_1:RecordAudio("318021035", var_148_37)
						arg_145_1:RecordAudio("318021035", var_148_37)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_318021", "318021035", "story_v_out_318021.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_318021", "318021035", "story_v_out_318021.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_38 = math.max(var_148_29, arg_145_1.talkMaxDuration)

			if var_148_28 <= arg_145_1.time_ and arg_145_1.time_ < var_148_28 + var_148_38 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_28) / var_148_38

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_28 + var_148_38 and arg_145_1.time_ < var_148_28 + var_148_38 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play318021036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 318021036
		arg_149_1.duration_ = 5

		local var_149_0 = {
			zh = 4.533,
			ja = 5
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
				arg_149_0:Play318021037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1049ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1049ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(-0.7, -1.2, -6)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1049ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-0.7, -1.2, -6)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1049ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1049ui_story == nil then
				arg_149_1.var_.characterEffect1049ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect1049ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1049ui_story then
				arg_149_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_152_13 = arg_149_1.actors_["10053ui_story"]
			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 and not isNil(var_152_13) and arg_149_1.var_.characterEffect10053ui_story == nil then
				arg_149_1.var_.characterEffect10053ui_story = var_152_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_15 = 0.200000002980232

			if var_152_14 <= arg_149_1.time_ and arg_149_1.time_ < var_152_14 + var_152_15 and not isNil(var_152_13) then
				local var_152_16 = (arg_149_1.time_ - var_152_14) / var_152_15

				if arg_149_1.var_.characterEffect10053ui_story and not isNil(var_152_13) then
					local var_152_17 = Mathf.Lerp(0, 0.5, var_152_16)

					arg_149_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10053ui_story.fillRatio = var_152_17
				end
			end

			if arg_149_1.time_ >= var_152_14 + var_152_15 and arg_149_1.time_ < var_152_14 + var_152_15 + arg_152_0 and not isNil(var_152_13) and arg_149_1.var_.characterEffect10053ui_story then
				local var_152_18 = 0.5

				arg_149_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10053ui_story.fillRatio = var_152_18
			end

			local var_152_19 = 0
			local var_152_20 = 0.4

			if var_152_19 < arg_149_1.time_ and arg_149_1.time_ <= var_152_19 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_21 = arg_149_1:FormatText(StoryNameCfg[562].name)

				arg_149_1.leftNameTxt_.text = var_152_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_22 = arg_149_1:GetWordFromCfg(318021036)
				local var_152_23 = arg_149_1:FormatText(var_152_22.content)

				arg_149_1.text_.text = var_152_23

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_24 = 16
				local var_152_25 = utf8.len(var_152_23)
				local var_152_26 = var_152_24 <= 0 and var_152_20 or var_152_20 * (var_152_25 / var_152_24)

				if var_152_26 > 0 and var_152_20 < var_152_26 then
					arg_149_1.talkMaxDuration = var_152_26

					if var_152_26 + var_152_19 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_26 + var_152_19
					end
				end

				arg_149_1.text_.text = var_152_23
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021036", "story_v_out_318021.awb") ~= 0 then
					local var_152_27 = manager.audio:GetVoiceLength("story_v_out_318021", "318021036", "story_v_out_318021.awb") / 1000

					if var_152_27 + var_152_19 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_27 + var_152_19
					end

					if var_152_22.prefab_name ~= "" and arg_149_1.actors_[var_152_22.prefab_name] ~= nil then
						local var_152_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_22.prefab_name].transform, "story_v_out_318021", "318021036", "story_v_out_318021.awb")

						arg_149_1:RecordAudio("318021036", var_152_28)
						arg_149_1:RecordAudio("318021036", var_152_28)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_318021", "318021036", "story_v_out_318021.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_318021", "318021036", "story_v_out_318021.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_29 = math.max(var_152_20, arg_149_1.talkMaxDuration)

			if var_152_19 <= arg_149_1.time_ and arg_149_1.time_ < var_152_19 + var_152_29 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_19) / var_152_29

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_19 + var_152_29 and arg_149_1.time_ < var_152_19 + var_152_29 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play318021037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 318021037
		arg_153_1.duration_ = 8.83

		local var_153_0 = {
			zh = 8.833,
			ja = 4.5
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
				arg_153_0:Play318021038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1049ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1049ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(-0.7, -1.2, -6)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1049ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(-0.7, -1.2, -6)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["1049ui_story"]
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1049ui_story == nil then
				arg_153_1.var_.characterEffect1049ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_11 = 0.200000002980232

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 and not isNil(var_156_9) then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11

				if arg_153_1.var_.characterEffect1049ui_story and not isNil(var_156_9) then
					arg_153_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1049ui_story then
				arg_153_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_1")
			end

			local var_156_14 = 0
			local var_156_15 = 0.7

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_16 = arg_153_1:FormatText(StoryNameCfg[562].name)

				arg_153_1.leftNameTxt_.text = var_156_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_17 = arg_153_1:GetWordFromCfg(318021037)
				local var_156_18 = arg_153_1:FormatText(var_156_17.content)

				arg_153_1.text_.text = var_156_18

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_19 = 28
				local var_156_20 = utf8.len(var_156_18)
				local var_156_21 = var_156_19 <= 0 and var_156_15 or var_156_15 * (var_156_20 / var_156_19)

				if var_156_21 > 0 and var_156_15 < var_156_21 then
					arg_153_1.talkMaxDuration = var_156_21

					if var_156_21 + var_156_14 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_21 + var_156_14
					end
				end

				arg_153_1.text_.text = var_156_18
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021037", "story_v_out_318021.awb") ~= 0 then
					local var_156_22 = manager.audio:GetVoiceLength("story_v_out_318021", "318021037", "story_v_out_318021.awb") / 1000

					if var_156_22 + var_156_14 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_22 + var_156_14
					end

					if var_156_17.prefab_name ~= "" and arg_153_1.actors_[var_156_17.prefab_name] ~= nil then
						local var_156_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_17.prefab_name].transform, "story_v_out_318021", "318021037", "story_v_out_318021.awb")

						arg_153_1:RecordAudio("318021037", var_156_23)
						arg_153_1:RecordAudio("318021037", var_156_23)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_318021", "318021037", "story_v_out_318021.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_318021", "318021037", "story_v_out_318021.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_24 = math.max(var_156_15, arg_153_1.talkMaxDuration)

			if var_156_14 <= arg_153_1.time_ and arg_153_1.time_ < var_156_14 + var_156_24 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_14) / var_156_24

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_14 + var_156_24 and arg_153_1.time_ < var_156_14 + var_156_24 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play318021038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 318021038
		arg_157_1.duration_ = 2

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play318021039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10053ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10053ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0.7, -1.12, -5.99)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10053ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["10053ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect10053ui_story == nil then
				arg_157_1.var_.characterEffect10053ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.200000002980232

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect10053ui_story and not isNil(var_160_9) then
					arg_157_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect10053ui_story then
				arg_157_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_160_13 = 0

			if var_160_13 < arg_157_1.time_ and arg_157_1.time_ <= var_160_13 + arg_160_0 then
				arg_157_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action34_2")
			end

			local var_160_14 = 0

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 then
				arg_157_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_160_15 = arg_157_1.actors_["1049ui_story"]
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.characterEffect1049ui_story == nil then
				arg_157_1.var_.characterEffect1049ui_story = var_160_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_17 = 0.200000002980232

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 and not isNil(var_160_15) then
				local var_160_18 = (arg_157_1.time_ - var_160_16) / var_160_17

				if arg_157_1.var_.characterEffect1049ui_story and not isNil(var_160_15) then
					local var_160_19 = Mathf.Lerp(0, 0.5, var_160_18)

					arg_157_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1049ui_story.fillRatio = var_160_19
				end
			end

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.characterEffect1049ui_story then
				local var_160_20 = 0.5

				arg_157_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1049ui_story.fillRatio = var_160_20
			end

			local var_160_21 = 0
			local var_160_22 = 0.1

			if var_160_21 < arg_157_1.time_ and arg_157_1.time_ <= var_160_21 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_23 = arg_157_1:FormatText(StoryNameCfg[477].name)

				arg_157_1.leftNameTxt_.text = var_160_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_24 = arg_157_1:GetWordFromCfg(318021038)
				local var_160_25 = arg_157_1:FormatText(var_160_24.content)

				arg_157_1.text_.text = var_160_25

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_26 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021038", "story_v_out_318021.awb") ~= 0 then
					local var_160_29 = manager.audio:GetVoiceLength("story_v_out_318021", "318021038", "story_v_out_318021.awb") / 1000

					if var_160_29 + var_160_21 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_29 + var_160_21
					end

					if var_160_24.prefab_name ~= "" and arg_157_1.actors_[var_160_24.prefab_name] ~= nil then
						local var_160_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_24.prefab_name].transform, "story_v_out_318021", "318021038", "story_v_out_318021.awb")

						arg_157_1:RecordAudio("318021038", var_160_30)
						arg_157_1:RecordAudio("318021038", var_160_30)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_318021", "318021038", "story_v_out_318021.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_318021", "318021038", "story_v_out_318021.awb")
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
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play318021039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318021039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play318021040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10053ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos10053ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(0, 100, 0)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10053ui_story, var_164_4, var_164_3)

				local var_164_5 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_5.x, var_164_5.y, var_164_5.z)

				local var_164_6 = var_164_0.localEulerAngles

				var_164_6.z = 0
				var_164_6.x = 0
				var_164_0.localEulerAngles = var_164_6
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0, 100, 0)

				local var_164_7 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_7.x, var_164_7.y, var_164_7.z)

				local var_164_8 = var_164_0.localEulerAngles

				var_164_8.z = 0
				var_164_8.x = 0
				var_164_0.localEulerAngles = var_164_8
			end

			local var_164_9 = arg_161_1.actors_["10053ui_story"]
			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect10053ui_story == nil then
				arg_161_1.var_.characterEffect10053ui_story = var_164_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_11 = 0.200000002980232

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 and not isNil(var_164_9) then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11

				if arg_161_1.var_.characterEffect10053ui_story and not isNil(var_164_9) then
					local var_164_13 = Mathf.Lerp(0, 0.5, var_164_12)

					arg_161_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10053ui_story.fillRatio = var_164_13
				end
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect10053ui_story then
				local var_164_14 = 0.5

				arg_161_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10053ui_story.fillRatio = var_164_14
			end

			local var_164_15 = arg_161_1.actors_["1049ui_story"].transform
			local var_164_16 = 0

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1.var_.moveOldPos1049ui_story = var_164_15.localPosition
			end

			local var_164_17 = 0.001

			if var_164_16 <= arg_161_1.time_ and arg_161_1.time_ < var_164_16 + var_164_17 then
				local var_164_18 = (arg_161_1.time_ - var_164_16) / var_164_17
				local var_164_19 = Vector3.New(0, 100, 0)

				var_164_15.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1049ui_story, var_164_19, var_164_18)

				local var_164_20 = manager.ui.mainCamera.transform.position - var_164_15.position

				var_164_15.forward = Vector3.New(var_164_20.x, var_164_20.y, var_164_20.z)

				local var_164_21 = var_164_15.localEulerAngles

				var_164_21.z = 0
				var_164_21.x = 0
				var_164_15.localEulerAngles = var_164_21
			end

			if arg_161_1.time_ >= var_164_16 + var_164_17 and arg_161_1.time_ < var_164_16 + var_164_17 + arg_164_0 then
				var_164_15.localPosition = Vector3.New(0, 100, 0)

				local var_164_22 = manager.ui.mainCamera.transform.position - var_164_15.position

				var_164_15.forward = Vector3.New(var_164_22.x, var_164_22.y, var_164_22.z)

				local var_164_23 = var_164_15.localEulerAngles

				var_164_23.z = 0
				var_164_23.x = 0
				var_164_15.localEulerAngles = var_164_23
			end

			local var_164_24 = arg_161_1.actors_["1049ui_story"]
			local var_164_25 = 0

			if var_164_25 < arg_161_1.time_ and arg_161_1.time_ <= var_164_25 + arg_164_0 and not isNil(var_164_24) and arg_161_1.var_.characterEffect1049ui_story == nil then
				arg_161_1.var_.characterEffect1049ui_story = var_164_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_26 = 0.200000002980232

			if var_164_25 <= arg_161_1.time_ and arg_161_1.time_ < var_164_25 + var_164_26 and not isNil(var_164_24) then
				local var_164_27 = (arg_161_1.time_ - var_164_25) / var_164_26

				if arg_161_1.var_.characterEffect1049ui_story and not isNil(var_164_24) then
					local var_164_28 = Mathf.Lerp(0, 0.5, var_164_27)

					arg_161_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1049ui_story.fillRatio = var_164_28
				end
			end

			if arg_161_1.time_ >= var_164_25 + var_164_26 and arg_161_1.time_ < var_164_25 + var_164_26 + arg_164_0 and not isNil(var_164_24) and arg_161_1.var_.characterEffect1049ui_story then
				local var_164_29 = 0.5

				arg_161_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1049ui_story.fillRatio = var_164_29
			end

			local var_164_30 = 0
			local var_164_31 = 1.425

			if var_164_30 < arg_161_1.time_ and arg_161_1.time_ <= var_164_30 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_32 = arg_161_1:GetWordFromCfg(318021039)
				local var_164_33 = arg_161_1:FormatText(var_164_32.content)

				arg_161_1.text_.text = var_164_33

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_34 = 57
				local var_164_35 = utf8.len(var_164_33)
				local var_164_36 = var_164_34 <= 0 and var_164_31 or var_164_31 * (var_164_35 / var_164_34)

				if var_164_36 > 0 and var_164_31 < var_164_36 then
					arg_161_1.talkMaxDuration = var_164_36

					if var_164_36 + var_164_30 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_36 + var_164_30
					end
				end

				arg_161_1.text_.text = var_164_33
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_37 = math.max(var_164_31, arg_161_1.talkMaxDuration)

			if var_164_30 <= arg_161_1.time_ and arg_161_1.time_ < var_164_30 + var_164_37 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_30) / var_164_37

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_30 + var_164_37 and arg_161_1.time_ < var_164_30 + var_164_37 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play318021040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 318021040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play318021041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 1.65

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

				local var_168_2 = arg_165_1:GetWordFromCfg(318021040)
				local var_168_3 = arg_165_1:FormatText(var_168_2.content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 66
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
	Play318021041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 318021041
		arg_169_1.duration_ = 4.17

		local var_169_0 = {
			zh = 1.999999999999,
			ja = 4.166
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
				arg_169_0:Play318021042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1049ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1049ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, -1.2, -6)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1049ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1049ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1049ui_story == nil then
				arg_169_1.var_.characterEffect1049ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1049ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1049ui_story then
				arg_169_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_172_13 = 0

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_172_14 = 0
			local var_172_15 = 0.25

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_16 = arg_169_1:FormatText(StoryNameCfg[562].name)

				arg_169_1.leftNameTxt_.text = var_172_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_17 = arg_169_1:GetWordFromCfg(318021041)
				local var_172_18 = arg_169_1:FormatText(var_172_17.content)

				arg_169_1.text_.text = var_172_18

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_19 = 10
				local var_172_20 = utf8.len(var_172_18)
				local var_172_21 = var_172_19 <= 0 and var_172_15 or var_172_15 * (var_172_20 / var_172_19)

				if var_172_21 > 0 and var_172_15 < var_172_21 then
					arg_169_1.talkMaxDuration = var_172_21

					if var_172_21 + var_172_14 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_21 + var_172_14
					end
				end

				arg_169_1.text_.text = var_172_18
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021041", "story_v_out_318021.awb") ~= 0 then
					local var_172_22 = manager.audio:GetVoiceLength("story_v_out_318021", "318021041", "story_v_out_318021.awb") / 1000

					if var_172_22 + var_172_14 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_22 + var_172_14
					end

					if var_172_17.prefab_name ~= "" and arg_169_1.actors_[var_172_17.prefab_name] ~= nil then
						local var_172_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_17.prefab_name].transform, "story_v_out_318021", "318021041", "story_v_out_318021.awb")

						arg_169_1:RecordAudio("318021041", var_172_23)
						arg_169_1:RecordAudio("318021041", var_172_23)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_318021", "318021041", "story_v_out_318021.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_318021", "318021041", "story_v_out_318021.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_24 = math.max(var_172_15, arg_169_1.talkMaxDuration)

			if var_172_14 <= arg_169_1.time_ and arg_169_1.time_ < var_172_14 + var_172_24 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_14) / var_172_24

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_14 + var_172_24 and arg_169_1.time_ < var_172_14 + var_172_24 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play318021042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 318021042
		arg_173_1.duration_ = 8.77

		local var_173_0 = {
			zh = 5.733,
			ja = 8.766
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
				arg_173_0:Play318021043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10053ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos10053ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0.7, -1.12, -5.99)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10053ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["10053ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect10053ui_story == nil then
				arg_173_1.var_.characterEffect10053ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect10053ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect10053ui_story then
				arg_173_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_15 = arg_173_1.actors_["1049ui_story"].transform
			local var_176_16 = 0

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 then
				arg_173_1.var_.moveOldPos1049ui_story = var_176_15.localPosition
			end

			local var_176_17 = 0.001

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_17 then
				local var_176_18 = (arg_173_1.time_ - var_176_16) / var_176_17
				local var_176_19 = Vector3.New(-0.7, -1.2, -6)

				var_176_15.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1049ui_story, var_176_19, var_176_18)

				local var_176_20 = manager.ui.mainCamera.transform.position - var_176_15.position

				var_176_15.forward = Vector3.New(var_176_20.x, var_176_20.y, var_176_20.z)

				local var_176_21 = var_176_15.localEulerAngles

				var_176_21.z = 0
				var_176_21.x = 0
				var_176_15.localEulerAngles = var_176_21
			end

			if arg_173_1.time_ >= var_176_16 + var_176_17 and arg_173_1.time_ < var_176_16 + var_176_17 + arg_176_0 then
				var_176_15.localPosition = Vector3.New(-0.7, -1.2, -6)

				local var_176_22 = manager.ui.mainCamera.transform.position - var_176_15.position

				var_176_15.forward = Vector3.New(var_176_22.x, var_176_22.y, var_176_22.z)

				local var_176_23 = var_176_15.localEulerAngles

				var_176_23.z = 0
				var_176_23.x = 0
				var_176_15.localEulerAngles = var_176_23
			end

			local var_176_24 = arg_173_1.actors_["1049ui_story"]
			local var_176_25 = 0

			if var_176_25 < arg_173_1.time_ and arg_173_1.time_ <= var_176_25 + arg_176_0 and not isNil(var_176_24) and arg_173_1.var_.characterEffect1049ui_story == nil then
				arg_173_1.var_.characterEffect1049ui_story = var_176_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_26 = 0.200000002980232

			if var_176_25 <= arg_173_1.time_ and arg_173_1.time_ < var_176_25 + var_176_26 and not isNil(var_176_24) then
				local var_176_27 = (arg_173_1.time_ - var_176_25) / var_176_26

				if arg_173_1.var_.characterEffect1049ui_story and not isNil(var_176_24) then
					local var_176_28 = Mathf.Lerp(0, 0.5, var_176_27)

					arg_173_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1049ui_story.fillRatio = var_176_28
				end
			end

			if arg_173_1.time_ >= var_176_25 + var_176_26 and arg_173_1.time_ < var_176_25 + var_176_26 + arg_176_0 and not isNil(var_176_24) and arg_173_1.var_.characterEffect1049ui_story then
				local var_176_29 = 0.5

				arg_173_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1049ui_story.fillRatio = var_176_29
			end

			local var_176_30 = 0
			local var_176_31 = 0.475

			if var_176_30 < arg_173_1.time_ and arg_173_1.time_ <= var_176_30 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_32 = arg_173_1:FormatText(StoryNameCfg[477].name)

				arg_173_1.leftNameTxt_.text = var_176_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_33 = arg_173_1:GetWordFromCfg(318021042)
				local var_176_34 = arg_173_1:FormatText(var_176_33.content)

				arg_173_1.text_.text = var_176_34

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_35 = 19
				local var_176_36 = utf8.len(var_176_34)
				local var_176_37 = var_176_35 <= 0 and var_176_31 or var_176_31 * (var_176_36 / var_176_35)

				if var_176_37 > 0 and var_176_31 < var_176_37 then
					arg_173_1.talkMaxDuration = var_176_37

					if var_176_37 + var_176_30 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_37 + var_176_30
					end
				end

				arg_173_1.text_.text = var_176_34
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021042", "story_v_out_318021.awb") ~= 0 then
					local var_176_38 = manager.audio:GetVoiceLength("story_v_out_318021", "318021042", "story_v_out_318021.awb") / 1000

					if var_176_38 + var_176_30 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_38 + var_176_30
					end

					if var_176_33.prefab_name ~= "" and arg_173_1.actors_[var_176_33.prefab_name] ~= nil then
						local var_176_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_33.prefab_name].transform, "story_v_out_318021", "318021042", "story_v_out_318021.awb")

						arg_173_1:RecordAudio("318021042", var_176_39)
						arg_173_1:RecordAudio("318021042", var_176_39)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_318021", "318021042", "story_v_out_318021.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_318021", "318021042", "story_v_out_318021.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_40 = math.max(var_176_31, arg_173_1.talkMaxDuration)

			if var_176_30 <= arg_173_1.time_ and arg_173_1.time_ < var_176_30 + var_176_40 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_30) / var_176_40

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_30 + var_176_40 and arg_173_1.time_ < var_176_30 + var_176_40 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play318021043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 318021043
		arg_177_1.duration_ = 7.5

		local var_177_0 = {
			zh = 7.5,
			ja = 7.333
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
				arg_177_0:Play318021044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1049ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1049ui_story == nil then
				arg_177_1.var_.characterEffect1049ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1049ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1049ui_story then
				arg_177_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["10053ui_story"]
			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect10053ui_story == nil then
				arg_177_1.var_.characterEffect10053ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_6 = 0.200000002980232

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_6 and not isNil(var_180_4) then
				local var_180_7 = (arg_177_1.time_ - var_180_5) / var_180_6

				if arg_177_1.var_.characterEffect10053ui_story and not isNil(var_180_4) then
					local var_180_8 = Mathf.Lerp(0, 0.5, var_180_7)

					arg_177_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10053ui_story.fillRatio = var_180_8
				end
			end

			if arg_177_1.time_ >= var_180_5 + var_180_6 and arg_177_1.time_ < var_180_5 + var_180_6 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect10053ui_story then
				local var_180_9 = 0.5

				arg_177_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10053ui_story.fillRatio = var_180_9
			end

			local var_180_10 = 0
			local var_180_11 = 0.875

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_12 = arg_177_1:FormatText(StoryNameCfg[562].name)

				arg_177_1.leftNameTxt_.text = var_180_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_13 = arg_177_1:GetWordFromCfg(318021043)
				local var_180_14 = arg_177_1:FormatText(var_180_13.content)

				arg_177_1.text_.text = var_180_14

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_15 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021043", "story_v_out_318021.awb") ~= 0 then
					local var_180_18 = manager.audio:GetVoiceLength("story_v_out_318021", "318021043", "story_v_out_318021.awb") / 1000

					if var_180_18 + var_180_10 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_18 + var_180_10
					end

					if var_180_13.prefab_name ~= "" and arg_177_1.actors_[var_180_13.prefab_name] ~= nil then
						local var_180_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_13.prefab_name].transform, "story_v_out_318021", "318021043", "story_v_out_318021.awb")

						arg_177_1:RecordAudio("318021043", var_180_19)
						arg_177_1:RecordAudio("318021043", var_180_19)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_318021", "318021043", "story_v_out_318021.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_318021", "318021043", "story_v_out_318021.awb")
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
	Play318021044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 318021044
		arg_181_1.duration_ = 1.83

		local var_181_0 = {
			zh = 1.5,
			ja = 1.833
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play318021045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1049ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1049ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, 100, 0)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1049ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, 100, 0)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["1049ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1049ui_story == nil then
				arg_181_1.var_.characterEffect1049ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect1049ui_story and not isNil(var_184_9) then
					local var_184_13 = Mathf.Lerp(0, 0.5, var_184_12)

					arg_181_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1049ui_story.fillRatio = var_184_13
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1049ui_story then
				local var_184_14 = 0.5

				arg_181_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1049ui_story.fillRatio = var_184_14
			end

			local var_184_15 = arg_181_1.actors_["10053ui_story"].transform
			local var_184_16 = 0

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.var_.moveOldPos10053ui_story = var_184_15.localPosition
			end

			local var_184_17 = 0.001

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_17 then
				local var_184_18 = (arg_181_1.time_ - var_184_16) / var_184_17
				local var_184_19 = Vector3.New(0, 100, 0)

				var_184_15.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10053ui_story, var_184_19, var_184_18)

				local var_184_20 = manager.ui.mainCamera.transform.position - var_184_15.position

				var_184_15.forward = Vector3.New(var_184_20.x, var_184_20.y, var_184_20.z)

				local var_184_21 = var_184_15.localEulerAngles

				var_184_21.z = 0
				var_184_21.x = 0
				var_184_15.localEulerAngles = var_184_21
			end

			if arg_181_1.time_ >= var_184_16 + var_184_17 and arg_181_1.time_ < var_184_16 + var_184_17 + arg_184_0 then
				var_184_15.localPosition = Vector3.New(0, 100, 0)

				local var_184_22 = manager.ui.mainCamera.transform.position - var_184_15.position

				var_184_15.forward = Vector3.New(var_184_22.x, var_184_22.y, var_184_22.z)

				local var_184_23 = var_184_15.localEulerAngles

				var_184_23.z = 0
				var_184_23.x = 0
				var_184_15.localEulerAngles = var_184_23
			end

			local var_184_24 = 0
			local var_184_25 = 0.175

			if var_184_24 < arg_181_1.time_ and arg_181_1.time_ <= var_184_24 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_26 = arg_181_1:FormatText(StoryNameCfg[479].name)

				arg_181_1.leftNameTxt_.text = var_184_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_27 = arg_181_1:GetWordFromCfg(318021044)
				local var_184_28 = arg_181_1:FormatText(var_184_27.content)

				arg_181_1.text_.text = var_184_28

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_29 = 7
				local var_184_30 = utf8.len(var_184_28)
				local var_184_31 = var_184_29 <= 0 and var_184_25 or var_184_25 * (var_184_30 / var_184_29)

				if var_184_31 > 0 and var_184_25 < var_184_31 then
					arg_181_1.talkMaxDuration = var_184_31

					if var_184_31 + var_184_24 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_31 + var_184_24
					end
				end

				arg_181_1.text_.text = var_184_28
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021044", "story_v_out_318021.awb") ~= 0 then
					local var_184_32 = manager.audio:GetVoiceLength("story_v_out_318021", "318021044", "story_v_out_318021.awb") / 1000

					if var_184_32 + var_184_24 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_32 + var_184_24
					end

					if var_184_27.prefab_name ~= "" and arg_181_1.actors_[var_184_27.prefab_name] ~= nil then
						local var_184_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_27.prefab_name].transform, "story_v_out_318021", "318021044", "story_v_out_318021.awb")

						arg_181_1:RecordAudio("318021044", var_184_33)
						arg_181_1:RecordAudio("318021044", var_184_33)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_318021", "318021044", "story_v_out_318021.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_318021", "318021044", "story_v_out_318021.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_34 = math.max(var_184_25, arg_181_1.talkMaxDuration)

			if var_184_24 <= arg_181_1.time_ and arg_181_1.time_ < var_184_24 + var_184_34 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_24) / var_184_34

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_24 + var_184_34 and arg_181_1.time_ < var_184_24 + var_184_34 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play318021045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 318021045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play318021046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1015ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1015ui_story == nil then
				arg_185_1.var_.characterEffect1015ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1015ui_story and not isNil(var_188_0) then
					local var_188_4 = Mathf.Lerp(0, 0.5, var_188_3)

					arg_185_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1015ui_story.fillRatio = var_188_4
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1015ui_story then
				local var_188_5 = 0.5

				arg_185_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1015ui_story.fillRatio = var_188_5
			end

			local var_188_6 = 0
			local var_188_7 = 0.85

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_8 = arg_185_1:GetWordFromCfg(318021045)
				local var_188_9 = arg_185_1:FormatText(var_188_8.content)

				arg_185_1.text_.text = var_188_9

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_10 = 34
				local var_188_11 = utf8.len(var_188_9)
				local var_188_12 = var_188_10 <= 0 and var_188_7 or var_188_7 * (var_188_11 / var_188_10)

				if var_188_12 > 0 and var_188_7 < var_188_12 then
					arg_185_1.talkMaxDuration = var_188_12

					if var_188_12 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_9
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_13 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_13 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_13

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_13 and arg_185_1.time_ < var_188_6 + var_188_13 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play318021046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 318021046
		arg_189_1.duration_ = 2.37

		local var_189_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_189_0:Play318021047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1049ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1049ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0, -1.2, -6)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1049ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["1049ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1049ui_story == nil then
				arg_189_1.var_.characterEffect1049ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect1049ui_story and not isNil(var_192_9) then
					arg_189_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1049ui_story then
				arg_189_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_192_13 = 0

			if var_192_13 < arg_189_1.time_ and arg_189_1.time_ <= var_192_13 + arg_192_0 then
				arg_189_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_192_14 = 0

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_15 = arg_189_1.actors_["1015ui_story"].transform
			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.var_.moveOldPos1015ui_story = var_192_15.localPosition
			end

			local var_192_17 = 0.001

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_17 then
				local var_192_18 = (arg_189_1.time_ - var_192_16) / var_192_17
				local var_192_19 = Vector3.New(0, 100, 0)

				var_192_15.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1015ui_story, var_192_19, var_192_18)

				local var_192_20 = manager.ui.mainCamera.transform.position - var_192_15.position

				var_192_15.forward = Vector3.New(var_192_20.x, var_192_20.y, var_192_20.z)

				local var_192_21 = var_192_15.localEulerAngles

				var_192_21.z = 0
				var_192_21.x = 0
				var_192_15.localEulerAngles = var_192_21
			end

			if arg_189_1.time_ >= var_192_16 + var_192_17 and arg_189_1.time_ < var_192_16 + var_192_17 + arg_192_0 then
				var_192_15.localPosition = Vector3.New(0, 100, 0)

				local var_192_22 = manager.ui.mainCamera.transform.position - var_192_15.position

				var_192_15.forward = Vector3.New(var_192_22.x, var_192_22.y, var_192_22.z)

				local var_192_23 = var_192_15.localEulerAngles

				var_192_23.z = 0
				var_192_23.x = 0
				var_192_15.localEulerAngles = var_192_23
			end

			local var_192_24 = 0
			local var_192_25 = 0.1

			if var_192_24 < arg_189_1.time_ and arg_189_1.time_ <= var_192_24 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_26 = arg_189_1:FormatText(StoryNameCfg[562].name)

				arg_189_1.leftNameTxt_.text = var_192_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_27 = arg_189_1:GetWordFromCfg(318021046)
				local var_192_28 = arg_189_1:FormatText(var_192_27.content)

				arg_189_1.text_.text = var_192_28

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_29 = 4
				local var_192_30 = utf8.len(var_192_28)
				local var_192_31 = var_192_29 <= 0 and var_192_25 or var_192_25 * (var_192_30 / var_192_29)

				if var_192_31 > 0 and var_192_25 < var_192_31 then
					arg_189_1.talkMaxDuration = var_192_31

					if var_192_31 + var_192_24 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_31 + var_192_24
					end
				end

				arg_189_1.text_.text = var_192_28
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021046", "story_v_out_318021.awb") ~= 0 then
					local var_192_32 = manager.audio:GetVoiceLength("story_v_out_318021", "318021046", "story_v_out_318021.awb") / 1000

					if var_192_32 + var_192_24 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_32 + var_192_24
					end

					if var_192_27.prefab_name ~= "" and arg_189_1.actors_[var_192_27.prefab_name] ~= nil then
						local var_192_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_27.prefab_name].transform, "story_v_out_318021", "318021046", "story_v_out_318021.awb")

						arg_189_1:RecordAudio("318021046", var_192_33)
						arg_189_1:RecordAudio("318021046", var_192_33)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_318021", "318021046", "story_v_out_318021.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_318021", "318021046", "story_v_out_318021.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_34 = math.max(var_192_25, arg_189_1.talkMaxDuration)

			if var_192_24 <= arg_189_1.time_ and arg_189_1.time_ < var_192_24 + var_192_34 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_24) / var_192_34

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_24 + var_192_34 and arg_189_1.time_ < var_192_24 + var_192_34 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play318021047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 318021047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play318021048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1049ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1049ui_story == nil then
				arg_193_1.var_.characterEffect1049ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1049ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1049ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1049ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1049ui_story.fillRatio = var_196_5
			end

			local var_196_6 = 0
			local var_196_7 = 0.35

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_8 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_9 = arg_193_1:GetWordFromCfg(318021047)
				local var_196_10 = arg_193_1:FormatText(var_196_9.content)

				arg_193_1.text_.text = var_196_10

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 14
				local var_196_12 = utf8.len(var_196_10)
				local var_196_13 = var_196_11 <= 0 and var_196_7 or var_196_7 * (var_196_12 / var_196_11)

				if var_196_13 > 0 and var_196_7 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_10
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play318021048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 318021048
		arg_197_1.duration_ = 9.33

		local var_197_0 = {
			zh = 4.166,
			ja = 9.333
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
				arg_197_0:Play318021049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10053ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10053ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0.7, -1.12, -5.99)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10053ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["10053ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect10053ui_story == nil then
				arg_197_1.var_.characterEffect10053ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect10053ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect10053ui_story then
				arg_197_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_200_15 = arg_197_1.actors_["1049ui_story"].transform
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.var_.moveOldPos1049ui_story = var_200_15.localPosition
			end

			local var_200_17 = 0.001

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17
				local var_200_19 = Vector3.New(-0.7, -1.2, -6)

				var_200_15.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1049ui_story, var_200_19, var_200_18)

				local var_200_20 = manager.ui.mainCamera.transform.position - var_200_15.position

				var_200_15.forward = Vector3.New(var_200_20.x, var_200_20.y, var_200_20.z)

				local var_200_21 = var_200_15.localEulerAngles

				var_200_21.z = 0
				var_200_21.x = 0
				var_200_15.localEulerAngles = var_200_21
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 then
				var_200_15.localPosition = Vector3.New(-0.7, -1.2, -6)

				local var_200_22 = manager.ui.mainCamera.transform.position - var_200_15.position

				var_200_15.forward = Vector3.New(var_200_22.x, var_200_22.y, var_200_22.z)

				local var_200_23 = var_200_15.localEulerAngles

				var_200_23.z = 0
				var_200_23.x = 0
				var_200_15.localEulerAngles = var_200_23
			end

			local var_200_24 = 0
			local var_200_25 = 0.35

			if var_200_24 < arg_197_1.time_ and arg_197_1.time_ <= var_200_24 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_26 = arg_197_1:FormatText(StoryNameCfg[477].name)

				arg_197_1.leftNameTxt_.text = var_200_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_27 = arg_197_1:GetWordFromCfg(318021048)
				local var_200_28 = arg_197_1:FormatText(var_200_27.content)

				arg_197_1.text_.text = var_200_28

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_29 = 14
				local var_200_30 = utf8.len(var_200_28)
				local var_200_31 = var_200_29 <= 0 and var_200_25 or var_200_25 * (var_200_30 / var_200_29)

				if var_200_31 > 0 and var_200_25 < var_200_31 then
					arg_197_1.talkMaxDuration = var_200_31

					if var_200_31 + var_200_24 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_31 + var_200_24
					end
				end

				arg_197_1.text_.text = var_200_28
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318021", "318021048", "story_v_out_318021.awb") ~= 0 then
					local var_200_32 = manager.audio:GetVoiceLength("story_v_out_318021", "318021048", "story_v_out_318021.awb") / 1000

					if var_200_32 + var_200_24 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_32 + var_200_24
					end

					if var_200_27.prefab_name ~= "" and arg_197_1.actors_[var_200_27.prefab_name] ~= nil then
						local var_200_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_27.prefab_name].transform, "story_v_out_318021", "318021048", "story_v_out_318021.awb")

						arg_197_1:RecordAudio("318021048", var_200_33)
						arg_197_1:RecordAudio("318021048", var_200_33)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_318021", "318021048", "story_v_out_318021.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_318021", "318021048", "story_v_out_318021.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_34 = math.max(var_200_25, arg_197_1.talkMaxDuration)

			if var_200_24 <= arg_197_1.time_ and arg_197_1.time_ < var_200_24 + var_200_34 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_24) / var_200_34

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_24 + var_200_34 and arg_197_1.time_ < var_200_24 + var_200_34 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play318021049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 318021049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play318021050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10053ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect10053ui_story == nil then
				arg_201_1.var_.characterEffect10053ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect10053ui_story and not isNil(var_204_0) then
					local var_204_4 = Mathf.Lerp(0, 0.5, var_204_3)

					arg_201_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10053ui_story.fillRatio = var_204_4
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect10053ui_story then
				local var_204_5 = 0.5

				arg_201_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10053ui_story.fillRatio = var_204_5
			end

			local var_204_6 = 0
			local var_204_7 = 1.175

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_8 = arg_201_1:GetWordFromCfg(318021049)
				local var_204_9 = arg_201_1:FormatText(var_204_8.content)

				arg_201_1.text_.text = var_204_9

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 47
				local var_204_11 = utf8.len(var_204_9)
				local var_204_12 = var_204_10 <= 0 and var_204_7 or var_204_7 * (var_204_11 / var_204_10)

				if var_204_12 > 0 and var_204_7 < var_204_12 then
					arg_201_1.talkMaxDuration = var_204_12

					if var_204_12 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_12 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_9
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_13 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_13 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_13

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_13 and arg_201_1.time_ < var_204_6 + var_204_13 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play318021050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 318021050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
			arg_205_1.auto_ = false
		end

		function arg_205_1.playNext_(arg_207_0)
			arg_205_1.onStoryFinished_()
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.35

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

				local var_208_3 = arg_205_1:GetWordFromCfg(318021050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 14
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
	assets = {
		"TextureConfig/Background/K10g",
		"TextureConfig/Background/K11g"
	},
	voices = {
		"story_v_out_318021.awb"
	}
}
