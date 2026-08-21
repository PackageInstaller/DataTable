return {
	Play412082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412082001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play412082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I09h"

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
				local var_4_5 = arg_1_1.bgs_.I09h

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
					if iter_4_0 ~= "I09h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

			local var_4_24 = 0
			local var_4_25 = 0.233333333333333

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.266666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 1.999999999999
			local var_4_37 = 1.125

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
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

				local var_4_39 = arg_1_1:GetWordFromCfg(412082001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 45
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
	Play412082002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412082002
		arg_9_1.duration_ = 4

		local var_9_0 = {
			zh = 2.5,
			ja = 4
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
				arg_9_0:Play412082003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1097ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1097ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1097ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -0.54, -6.3)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1097ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1097ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1097ui_story == nil then
				arg_9_1.var_.characterEffect1097ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1097ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1097ui_story then
				arg_9_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.225

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[216].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(412082002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082002", "story_v_out_412082.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_412082", "412082002", "story_v_out_412082.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_412082", "412082002", "story_v_out_412082.awb")

						arg_9_1:RecordAudio("412082002", var_12_29)
						arg_9_1:RecordAudio("412082002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_412082", "412082002", "story_v_out_412082.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_412082", "412082002", "story_v_out_412082.awb")
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
				actorName = "1097ui_story",
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
	Play412082003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412082003
		arg_13_1.duration_ = 3.17

		local var_13_0 = {
			zh = 3.166,
			ja = 1.999999999999
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
				arg_13_0:Play412082004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10078ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "10078ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["10078ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos10078ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -0.5, -6.3)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10078ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["10078ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10078ui_story == nil then
				arg_13_1.var_.characterEffect10078ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect10078ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10078ui_story then
				arg_13_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_20 = arg_13_1.actors_["1097ui_story"].transform
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.var_.moveOldPos1097ui_story = var_16_20.localPosition
			end

			local var_16_22 = 0.001

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_21) / var_16_22
				local var_16_24 = Vector3.New(0, 100, 0)

				var_16_20.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1097ui_story, var_16_24, var_16_23)

				local var_16_25 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_25.x, var_16_25.y, var_16_25.z)

				local var_16_26 = var_16_20.localEulerAngles

				var_16_26.z = 0
				var_16_26.x = 0
				var_16_20.localEulerAngles = var_16_26
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 then
				var_16_20.localPosition = Vector3.New(0, 100, 0)

				local var_16_27 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_27.x, var_16_27.y, var_16_27.z)

				local var_16_28 = var_16_20.localEulerAngles

				var_16_28.z = 0
				var_16_28.x = 0
				var_16_20.localEulerAngles = var_16_28
			end

			local var_16_29 = arg_13_1.actors_["1097ui_story"]
			local var_16_30 = 0

			if var_16_30 < arg_13_1.time_ and arg_13_1.time_ <= var_16_30 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect1097ui_story == nil then
				arg_13_1.var_.characterEffect1097ui_story = var_16_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_31 = 0.200000002980232

			if var_16_30 <= arg_13_1.time_ and arg_13_1.time_ < var_16_30 + var_16_31 and not isNil(var_16_29) then
				local var_16_32 = (arg_13_1.time_ - var_16_30) / var_16_31

				if arg_13_1.var_.characterEffect1097ui_story and not isNil(var_16_29) then
					local var_16_33 = Mathf.Lerp(0, 0.5, var_16_32)

					arg_13_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1097ui_story.fillRatio = var_16_33
				end
			end

			if arg_13_1.time_ >= var_16_30 + var_16_31 and arg_13_1.time_ < var_16_30 + var_16_31 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect1097ui_story then
				local var_16_34 = 0.5

				arg_13_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1097ui_story.fillRatio = var_16_34
			end

			local var_16_35 = 0
			local var_16_36 = 0.25

			if var_16_35 < arg_13_1.time_ and arg_13_1.time_ <= var_16_35 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_37 = arg_13_1:FormatText(StoryNameCfg[919].name)

				arg_13_1.leftNameTxt_.text = var_16_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_38 = arg_13_1:GetWordFromCfg(412082003)
				local var_16_39 = arg_13_1:FormatText(var_16_38.content)

				arg_13_1.text_.text = var_16_39

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_40 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082003", "story_v_out_412082.awb") ~= 0 then
					local var_16_43 = manager.audio:GetVoiceLength("story_v_out_412082", "412082003", "story_v_out_412082.awb") / 1000

					if var_16_43 + var_16_35 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_43 + var_16_35
					end

					if var_16_38.prefab_name ~= "" and arg_13_1.actors_[var_16_38.prefab_name] ~= nil then
						local var_16_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_38.prefab_name].transform, "story_v_out_412082", "412082003", "story_v_out_412082.awb")

						arg_13_1:RecordAudio("412082003", var_16_44)
						arg_13_1:RecordAudio("412082003", var_16_44)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_412082", "412082003", "story_v_out_412082.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_412082", "412082003", "story_v_out_412082.awb")
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
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412082004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412082004
		arg_17_1.duration_ = 2.13

		local var_17_0 = {
			zh = 2.133,
			ja = 1.999999999999
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
				arg_17_0:Play412082005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1097ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1097ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1097ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1097ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1097ui_story == nil then
				arg_17_1.var_.characterEffect1097ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1097ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1097ui_story then
				arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_15 = arg_17_1.actors_["10078ui_story"].transform
			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.var_.moveOldPos10078ui_story = var_20_15.localPosition
			end

			local var_20_17 = 0.001

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_17 then
				local var_20_18 = (arg_17_1.time_ - var_20_16) / var_20_17
				local var_20_19 = Vector3.New(0.7, -0.5, -6.3)

				var_20_15.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10078ui_story, var_20_19, var_20_18)

				local var_20_20 = manager.ui.mainCamera.transform.position - var_20_15.position

				var_20_15.forward = Vector3.New(var_20_20.x, var_20_20.y, var_20_20.z)

				local var_20_21 = var_20_15.localEulerAngles

				var_20_21.z = 0
				var_20_21.x = 0
				var_20_15.localEulerAngles = var_20_21
			end

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 then
				var_20_15.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_20_22 = manager.ui.mainCamera.transform.position - var_20_15.position

				var_20_15.forward = Vector3.New(var_20_22.x, var_20_22.y, var_20_22.z)

				local var_20_23 = var_20_15.localEulerAngles

				var_20_23.z = 0
				var_20_23.x = 0
				var_20_15.localEulerAngles = var_20_23
			end

			local var_20_24 = arg_17_1.actors_["10078ui_story"]
			local var_20_25 = 0

			if var_20_25 < arg_17_1.time_ and arg_17_1.time_ <= var_20_25 + arg_20_0 and not isNil(var_20_24) and arg_17_1.var_.characterEffect10078ui_story == nil then
				arg_17_1.var_.characterEffect10078ui_story = var_20_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_26 = 0.200000002980232

			if var_20_25 <= arg_17_1.time_ and arg_17_1.time_ < var_20_25 + var_20_26 and not isNil(var_20_24) then
				local var_20_27 = (arg_17_1.time_ - var_20_25) / var_20_26

				if arg_17_1.var_.characterEffect10078ui_story and not isNil(var_20_24) then
					local var_20_28 = Mathf.Lerp(0, 0.5, var_20_27)

					arg_17_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10078ui_story.fillRatio = var_20_28
				end
			end

			if arg_17_1.time_ >= var_20_25 + var_20_26 and arg_17_1.time_ < var_20_25 + var_20_26 + arg_20_0 and not isNil(var_20_24) and arg_17_1.var_.characterEffect10078ui_story then
				local var_20_29 = 0.5

				arg_17_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10078ui_story.fillRatio = var_20_29
			end

			local var_20_30 = 0
			local var_20_31 = 0.15

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_32 = arg_17_1:FormatText(StoryNameCfg[216].name)

				arg_17_1.leftNameTxt_.text = var_20_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_33 = arg_17_1:GetWordFromCfg(412082004)
				local var_20_34 = arg_17_1:FormatText(var_20_33.content)

				arg_17_1.text_.text = var_20_34

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_35 = 6
				local var_20_36 = utf8.len(var_20_34)
				local var_20_37 = var_20_35 <= 0 and var_20_31 or var_20_31 * (var_20_36 / var_20_35)

				if var_20_37 > 0 and var_20_31 < var_20_37 then
					arg_17_1.talkMaxDuration = var_20_37

					if var_20_37 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_37 + var_20_30
					end
				end

				arg_17_1.text_.text = var_20_34
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082004", "story_v_out_412082.awb") ~= 0 then
					local var_20_38 = manager.audio:GetVoiceLength("story_v_out_412082", "412082004", "story_v_out_412082.awb") / 1000

					if var_20_38 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_38 + var_20_30
					end

					if var_20_33.prefab_name ~= "" and arg_17_1.actors_[var_20_33.prefab_name] ~= nil then
						local var_20_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_33.prefab_name].transform, "story_v_out_412082", "412082004", "story_v_out_412082.awb")

						arg_17_1:RecordAudio("412082004", var_20_39)
						arg_17_1:RecordAudio("412082004", var_20_39)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_412082", "412082004", "story_v_out_412082.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_412082", "412082004", "story_v_out_412082.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_40 = math.max(var_20_31, arg_17_1.talkMaxDuration)

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_40 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_30) / var_20_40

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_30 + var_20_40 and arg_17_1.time_ < var_20_30 + var_20_40 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play412082005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 412082005
		arg_21_1.duration_ = 3.1

		local var_21_0 = {
			zh = 2.6,
			ja = 3.1
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
				arg_21_0:Play412082006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "10083ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "10083ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "10083ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["10083ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos10083ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(1, -2.6, -2.8)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10083ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(1, -2.6, -2.8)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["10083ui_story"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect10083ui_story == nil then
				arg_21_1.var_.characterEffect10083ui_story = var_24_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_16 = 0.200000002980232

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.characterEffect10083ui_story and not isNil(var_24_14) then
					arg_21_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect10083ui_story then
				arg_21_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_20 = arg_21_1.actors_["1097ui_story"]
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.characterEffect1097ui_story == nil then
				arg_21_1.var_.characterEffect1097ui_story = var_24_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_22 = 0.200000002980232

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 and not isNil(var_24_20) then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22

				if arg_21_1.var_.characterEffect1097ui_story and not isNil(var_24_20) then
					local var_24_24 = Mathf.Lerp(0, 0.5, var_24_23)

					arg_21_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1097ui_story.fillRatio = var_24_24
				end
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.characterEffect1097ui_story then
				local var_24_25 = 0.5

				arg_21_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1097ui_story.fillRatio = var_24_25
			end

			local var_24_26 = arg_21_1.actors_["10078ui_story"].transform
			local var_24_27 = 0

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				arg_21_1.var_.moveOldPos10078ui_story = var_24_26.localPosition
			end

			local var_24_28 = 0.001

			if var_24_27 <= arg_21_1.time_ and arg_21_1.time_ < var_24_27 + var_24_28 then
				local var_24_29 = (arg_21_1.time_ - var_24_27) / var_24_28
				local var_24_30 = Vector3.New(0, 100, 0)

				var_24_26.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10078ui_story, var_24_30, var_24_29)

				local var_24_31 = manager.ui.mainCamera.transform.position - var_24_26.position

				var_24_26.forward = Vector3.New(var_24_31.x, var_24_31.y, var_24_31.z)

				local var_24_32 = var_24_26.localEulerAngles

				var_24_32.z = 0
				var_24_32.x = 0
				var_24_26.localEulerAngles = var_24_32
			end

			if arg_21_1.time_ >= var_24_27 + var_24_28 and arg_21_1.time_ < var_24_27 + var_24_28 + arg_24_0 then
				var_24_26.localPosition = Vector3.New(0, 100, 0)

				local var_24_33 = manager.ui.mainCamera.transform.position - var_24_26.position

				var_24_26.forward = Vector3.New(var_24_33.x, var_24_33.y, var_24_33.z)

				local var_24_34 = var_24_26.localEulerAngles

				var_24_34.z = 0
				var_24_34.x = 0
				var_24_26.localEulerAngles = var_24_34
			end

			local var_24_35 = 0
			local var_24_36 = 0.25

			if var_24_35 < arg_21_1.time_ and arg_21_1.time_ <= var_24_35 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_37 = arg_21_1:FormatText(StoryNameCfg[918].name)

				arg_21_1.leftNameTxt_.text = var_24_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_38 = arg_21_1:GetWordFromCfg(412082005)
				local var_24_39 = arg_21_1:FormatText(var_24_38.content)

				arg_21_1.text_.text = var_24_39

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_40 = 10
				local var_24_41 = utf8.len(var_24_39)
				local var_24_42 = var_24_40 <= 0 and var_24_36 or var_24_36 * (var_24_41 / var_24_40)

				if var_24_42 > 0 and var_24_36 < var_24_42 then
					arg_21_1.talkMaxDuration = var_24_42

					if var_24_42 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_42 + var_24_35
					end
				end

				arg_21_1.text_.text = var_24_39
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082005", "story_v_out_412082.awb") ~= 0 then
					local var_24_43 = manager.audio:GetVoiceLength("story_v_out_412082", "412082005", "story_v_out_412082.awb") / 1000

					if var_24_43 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_43 + var_24_35
					end

					if var_24_38.prefab_name ~= "" and arg_21_1.actors_[var_24_38.prefab_name] ~= nil then
						local var_24_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_38.prefab_name].transform, "story_v_out_412082", "412082005", "story_v_out_412082.awb")

						arg_21_1:RecordAudio("412082005", var_24_44)
						arg_21_1:RecordAudio("412082005", var_24_44)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_412082", "412082005", "story_v_out_412082.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_412082", "412082005", "story_v_out_412082.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_45 = math.max(var_24_36, arg_21_1.talkMaxDuration)

			if var_24_35 <= arg_21_1.time_ and arg_21_1.time_ < var_24_35 + var_24_45 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_35) / var_24_45

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_35 + var_24_45 and arg_21_1.time_ < var_24_35 + var_24_45 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play412082006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 412082006
		arg_25_1.duration_ = 6.33

		local var_25_0 = {
			zh = 5.666,
			ja = 6.333
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
				arg_25_0:Play412082007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1097ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1097ui_story == nil then
				arg_25_1.var_.characterEffect1097ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1097ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1097ui_story then
				arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_6 = arg_25_1.actors_["10083ui_story"]
			local var_28_7 = 0

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10083ui_story == nil then
				arg_25_1.var_.characterEffect10083ui_story = var_28_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.200000002980232

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_8 and not isNil(var_28_6) then
				local var_28_9 = (arg_25_1.time_ - var_28_7) / var_28_8

				if arg_25_1.var_.characterEffect10083ui_story and not isNil(var_28_6) then
					local var_28_10 = Mathf.Lerp(0, 0.5, var_28_9)

					arg_25_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10083ui_story.fillRatio = var_28_10
				end
			end

			if arg_25_1.time_ >= var_28_7 + var_28_8 and arg_25_1.time_ < var_28_7 + var_28_8 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10083ui_story then
				local var_28_11 = 0.5

				arg_25_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10083ui_story.fillRatio = var_28_11
			end

			local var_28_12 = 0
			local var_28_13 = 0.575

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_14 = arg_25_1:FormatText(StoryNameCfg[216].name)

				arg_25_1.leftNameTxt_.text = var_28_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_15 = arg_25_1:GetWordFromCfg(412082006)
				local var_28_16 = arg_25_1:FormatText(var_28_15.content)

				arg_25_1.text_.text = var_28_16

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_17 = 23
				local var_28_18 = utf8.len(var_28_16)
				local var_28_19 = var_28_17 <= 0 and var_28_13 or var_28_13 * (var_28_18 / var_28_17)

				if var_28_19 > 0 and var_28_13 < var_28_19 then
					arg_25_1.talkMaxDuration = var_28_19

					if var_28_19 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_12
					end
				end

				arg_25_1.text_.text = var_28_16
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082006", "story_v_out_412082.awb") ~= 0 then
					local var_28_20 = manager.audio:GetVoiceLength("story_v_out_412082", "412082006", "story_v_out_412082.awb") / 1000

					if var_28_20 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_20 + var_28_12
					end

					if var_28_15.prefab_name ~= "" and arg_25_1.actors_[var_28_15.prefab_name] ~= nil then
						local var_28_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_15.prefab_name].transform, "story_v_out_412082", "412082006", "story_v_out_412082.awb")

						arg_25_1:RecordAudio("412082006", var_28_21)
						arg_25_1:RecordAudio("412082006", var_28_21)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_412082", "412082006", "story_v_out_412082.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_412082", "412082006", "story_v_out_412082.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_13, arg_25_1.talkMaxDuration)

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_12) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_12 + var_28_22 and arg_25_1.time_ < var_28_12 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play412082007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 412082007
		arg_29_1.duration_ = 7.7

		local var_29_0 = {
			zh = 7.333,
			ja = 7.7
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
				arg_29_0:Play412082008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10083ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10083ui_story == nil then
				arg_29_1.var_.characterEffect10083ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect10083ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10083ui_story then
				arg_29_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_2")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_6 = arg_29_1.actors_["1097ui_story"]
			local var_32_7 = 0

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.200000002980232

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 and not isNil(var_32_6) then
				local var_32_9 = (arg_29_1.time_ - var_32_7) / var_32_8

				if arg_29_1.var_.characterEffect1097ui_story and not isNil(var_32_6) then
					local var_32_10 = Mathf.Lerp(0, 0.5, var_32_9)

					arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1097ui_story.fillRatio = var_32_10
				end
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1097ui_story then
				local var_32_11 = 0.5

				arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1097ui_story.fillRatio = var_32_11
			end

			local var_32_12 = 0
			local var_32_13 = 0.875

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_14 = arg_29_1:FormatText(StoryNameCfg[918].name)

				arg_29_1.leftNameTxt_.text = var_32_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(412082007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 35
				local var_32_18 = utf8.len(var_32_16)
				local var_32_19 = var_32_17 <= 0 and var_32_13 or var_32_13 * (var_32_18 / var_32_17)

				if var_32_19 > 0 and var_32_13 < var_32_19 then
					arg_29_1.talkMaxDuration = var_32_19

					if var_32_19 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082007", "story_v_out_412082.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_412082", "412082007", "story_v_out_412082.awb") / 1000

					if var_32_20 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_412082", "412082007", "story_v_out_412082.awb")

						arg_29_1:RecordAudio("412082007", var_32_21)
						arg_29_1:RecordAudio("412082007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_412082", "412082007", "story_v_out_412082.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_412082", "412082007", "story_v_out_412082.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_22 and arg_29_1.time_ < var_32_12 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play412082008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 412082008
		arg_33_1.duration_ = 9.33

		local var_33_0 = {
			zh = 9.333,
			ja = 7.366
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
				arg_33_0:Play412082009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.1

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[918].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(412082008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 44
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082008", "story_v_out_412082.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_412082", "412082008", "story_v_out_412082.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_412082", "412082008", "story_v_out_412082.awb")

						arg_33_1:RecordAudio("412082008", var_36_9)
						arg_33_1:RecordAudio("412082008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_412082", "412082008", "story_v_out_412082.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_412082", "412082008", "story_v_out_412082.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play412082009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 412082009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play412082010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1097ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1097ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, 100, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1097ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, 100, 0)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1097ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1097ui_story == nil then
				arg_37_1.var_.characterEffect1097ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1097ui_story and not isNil(var_40_9) then
					local var_40_13 = Mathf.Lerp(0, 0.5, var_40_12)

					arg_37_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1097ui_story.fillRatio = var_40_13
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1097ui_story then
				local var_40_14 = 0.5

				arg_37_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1097ui_story.fillRatio = var_40_14
			end

			local var_40_15 = arg_37_1.actors_["10083ui_story"].transform
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.var_.moveOldPos10083ui_story = var_40_15.localPosition
			end

			local var_40_17 = 0.001

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17
				local var_40_19 = Vector3.New(0, 100, 0)

				var_40_15.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10083ui_story, var_40_19, var_40_18)

				local var_40_20 = manager.ui.mainCamera.transform.position - var_40_15.position

				var_40_15.forward = Vector3.New(var_40_20.x, var_40_20.y, var_40_20.z)

				local var_40_21 = var_40_15.localEulerAngles

				var_40_21.z = 0
				var_40_21.x = 0
				var_40_15.localEulerAngles = var_40_21
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 then
				var_40_15.localPosition = Vector3.New(0, 100, 0)

				local var_40_22 = manager.ui.mainCamera.transform.position - var_40_15.position

				var_40_15.forward = Vector3.New(var_40_22.x, var_40_22.y, var_40_22.z)

				local var_40_23 = var_40_15.localEulerAngles

				var_40_23.z = 0
				var_40_23.x = 0
				var_40_15.localEulerAngles = var_40_23
			end

			local var_40_24 = arg_37_1.actors_["10083ui_story"]
			local var_40_25 = 0

			if var_40_25 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 and not isNil(var_40_24) and arg_37_1.var_.characterEffect10083ui_story == nil then
				arg_37_1.var_.characterEffect10083ui_story = var_40_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_26 = 0.200000002980232

			if var_40_25 <= arg_37_1.time_ and arg_37_1.time_ < var_40_25 + var_40_26 and not isNil(var_40_24) then
				local var_40_27 = (arg_37_1.time_ - var_40_25) / var_40_26

				if arg_37_1.var_.characterEffect10083ui_story and not isNil(var_40_24) then
					local var_40_28 = Mathf.Lerp(0, 0.5, var_40_27)

					arg_37_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10083ui_story.fillRatio = var_40_28
				end
			end

			if arg_37_1.time_ >= var_40_25 + var_40_26 and arg_37_1.time_ < var_40_25 + var_40_26 + arg_40_0 and not isNil(var_40_24) and arg_37_1.var_.characterEffect10083ui_story then
				local var_40_29 = 0.5

				arg_37_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10083ui_story.fillRatio = var_40_29
			end

			local var_40_30 = 0
			local var_40_31 = 0.825

			if var_40_30 < arg_37_1.time_ and arg_37_1.time_ <= var_40_30 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_32 = arg_37_1:GetWordFromCfg(412082009)
				local var_40_33 = arg_37_1:FormatText(var_40_32.content)

				arg_37_1.text_.text = var_40_33

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_34 = 33
				local var_40_35 = utf8.len(var_40_33)
				local var_40_36 = var_40_34 <= 0 and var_40_31 or var_40_31 * (var_40_35 / var_40_34)

				if var_40_36 > 0 and var_40_31 < var_40_36 then
					arg_37_1.talkMaxDuration = var_40_36

					if var_40_36 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_36 + var_40_30
					end
				end

				arg_37_1.text_.text = var_40_33
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_37 = math.max(var_40_31, arg_37_1.talkMaxDuration)

			if var_40_30 <= arg_37_1.time_ and arg_37_1.time_ < var_40_30 + var_40_37 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_30) / var_40_37

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_30 + var_40_37 and arg_37_1.time_ < var_40_30 + var_40_37 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412082010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 412082010
		arg_41_1.duration_ = 7.1

		local var_41_0 = {
			zh = 3.7,
			ja = 7.1
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
				arg_41_0:Play412082011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10083ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10083ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(1, -2.6, -2.8)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10083ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(1, -2.6, -2.8)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["10083ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10083ui_story == nil then
				arg_41_1.var_.characterEffect10083ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect10083ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10083ui_story then
				arg_41_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_15 = 0
			local var_44_16 = 0.5

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[918].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(412082010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 20
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082010", "story_v_out_412082.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_412082", "412082010", "story_v_out_412082.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_412082", "412082010", "story_v_out_412082.awb")

						arg_41_1:RecordAudio("412082010", var_44_24)
						arg_41_1:RecordAudio("412082010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_412082", "412082010", "story_v_out_412082.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_412082", "412082010", "story_v_out_412082.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412082011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 412082011
		arg_45_1.duration_ = 7.6

		local var_45_0 = {
			zh = 3.466,
			ja = 7.6
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
				arg_45_0:Play412082012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1097ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1097ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1097ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1097ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1097ui_story == nil then
				arg_45_1.var_.characterEffect1097ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1097ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1097ui_story then
				arg_45_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_15 = arg_45_1.actors_["10083ui_story"]
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.characterEffect10083ui_story == nil then
				arg_45_1.var_.characterEffect10083ui_story = var_48_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_17 = 0.200000002980232

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 and not isNil(var_48_15) then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17

				if arg_45_1.var_.characterEffect10083ui_story and not isNil(var_48_15) then
					local var_48_19 = Mathf.Lerp(0, 0.5, var_48_18)

					arg_45_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10083ui_story.fillRatio = var_48_19
				end
			end

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.characterEffect10083ui_story then
				local var_48_20 = 0.5

				arg_45_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10083ui_story.fillRatio = var_48_20
			end

			local var_48_21 = 0
			local var_48_22 = 0.375

			if var_48_21 < arg_45_1.time_ and arg_45_1.time_ <= var_48_21 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_23 = arg_45_1:FormatText(StoryNameCfg[216].name)

				arg_45_1.leftNameTxt_.text = var_48_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_24 = arg_45_1:GetWordFromCfg(412082011)
				local var_48_25 = arg_45_1:FormatText(var_48_24.content)

				arg_45_1.text_.text = var_48_25

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_26 = 15
				local var_48_27 = utf8.len(var_48_25)
				local var_48_28 = var_48_26 <= 0 and var_48_22 or var_48_22 * (var_48_27 / var_48_26)

				if var_48_28 > 0 and var_48_22 < var_48_28 then
					arg_45_1.talkMaxDuration = var_48_28

					if var_48_28 + var_48_21 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_28 + var_48_21
					end
				end

				arg_45_1.text_.text = var_48_25
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082011", "story_v_out_412082.awb") ~= 0 then
					local var_48_29 = manager.audio:GetVoiceLength("story_v_out_412082", "412082011", "story_v_out_412082.awb") / 1000

					if var_48_29 + var_48_21 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_29 + var_48_21
					end

					if var_48_24.prefab_name ~= "" and arg_45_1.actors_[var_48_24.prefab_name] ~= nil then
						local var_48_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_24.prefab_name].transform, "story_v_out_412082", "412082011", "story_v_out_412082.awb")

						arg_45_1:RecordAudio("412082011", var_48_30)
						arg_45_1:RecordAudio("412082011", var_48_30)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_412082", "412082011", "story_v_out_412082.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_412082", "412082011", "story_v_out_412082.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_31 = math.max(var_48_22, arg_45_1.talkMaxDuration)

			if var_48_21 <= arg_45_1.time_ and arg_45_1.time_ < var_48_21 + var_48_31 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_21) / var_48_31

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_21 + var_48_31 and arg_45_1.time_ < var_48_21 + var_48_31 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play412082012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 412082012
		arg_49_1.duration_ = 1.77

		local var_49_0 = {
			zh = 1.766,
			ja = 1.4
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
				arg_49_0:Play412082013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1097ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1097ui_story == nil then
				arg_49_1.var_.characterEffect1097ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1097ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1097ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1097ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1097ui_story.fillRatio = var_52_5
			end

			local var_52_6 = arg_49_1.actors_["10083ui_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect10083ui_story == nil then
				arg_49_1.var_.characterEffect10083ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.200000002980232

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect10083ui_story and not isNil(var_52_6) then
					arg_49_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect10083ui_story then
				arg_49_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_52_10 = 0
			local var_52_11 = 0.125

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_12 = arg_49_1:FormatText(StoryNameCfg[918].name)

				arg_49_1.leftNameTxt_.text = var_52_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(412082012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 5
				local var_52_16 = utf8.len(var_52_14)
				local var_52_17 = var_52_15 <= 0 and var_52_11 or var_52_11 * (var_52_16 / var_52_15)

				if var_52_17 > 0 and var_52_11 < var_52_17 then
					arg_49_1.talkMaxDuration = var_52_17

					if var_52_17 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_10
					end
				end

				arg_49_1.text_.text = var_52_14
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082012", "story_v_out_412082.awb") ~= 0 then
					local var_52_18 = manager.audio:GetVoiceLength("story_v_out_412082", "412082012", "story_v_out_412082.awb") / 1000

					if var_52_18 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_10
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_412082", "412082012", "story_v_out_412082.awb")

						arg_49_1:RecordAudio("412082012", var_52_19)
						arg_49_1:RecordAudio("412082012", var_52_19)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_412082", "412082012", "story_v_out_412082.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_412082", "412082012", "story_v_out_412082.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_20 = math.max(var_52_11, arg_49_1.talkMaxDuration)

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_20 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_10) / var_52_20

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_10 + var_52_20 and arg_49_1.time_ < var_52_10 + var_52_20 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play412082013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 412082013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play412082014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1097ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1097ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1097ui_story, var_56_4, var_56_3)

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

			local var_56_9 = arg_53_1.actors_["1097ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1097ui_story == nil then
				arg_53_1.var_.characterEffect1097ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 and not isNil(var_56_9) then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect1097ui_story and not isNil(var_56_9) then
					local var_56_13 = Mathf.Lerp(0, 0.5, var_56_12)

					arg_53_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1097ui_story.fillRatio = var_56_13
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1097ui_story then
				local var_56_14 = 0.5

				arg_53_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1097ui_story.fillRatio = var_56_14
			end

			local var_56_15 = arg_53_1.actors_["10083ui_story"].transform
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.var_.moveOldPos10083ui_story = var_56_15.localPosition
			end

			local var_56_17 = 0.001

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17
				local var_56_19 = Vector3.New(0, 100, 0)

				var_56_15.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10083ui_story, var_56_19, var_56_18)

				local var_56_20 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_20.x, var_56_20.y, var_56_20.z)

				local var_56_21 = var_56_15.localEulerAngles

				var_56_21.z = 0
				var_56_21.x = 0
				var_56_15.localEulerAngles = var_56_21
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				var_56_15.localPosition = Vector3.New(0, 100, 0)

				local var_56_22 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_22.x, var_56_22.y, var_56_22.z)

				local var_56_23 = var_56_15.localEulerAngles

				var_56_23.z = 0
				var_56_23.x = 0
				var_56_15.localEulerAngles = var_56_23
			end

			local var_56_24 = arg_53_1.actors_["10083ui_story"]
			local var_56_25 = 0

			if var_56_25 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect10083ui_story == nil then
				arg_53_1.var_.characterEffect10083ui_story = var_56_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_26 = 0.200000002980232

			if var_56_25 <= arg_53_1.time_ and arg_53_1.time_ < var_56_25 + var_56_26 and not isNil(var_56_24) then
				local var_56_27 = (arg_53_1.time_ - var_56_25) / var_56_26

				if arg_53_1.var_.characterEffect10083ui_story and not isNil(var_56_24) then
					local var_56_28 = Mathf.Lerp(0, 0.5, var_56_27)

					arg_53_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10083ui_story.fillRatio = var_56_28
				end
			end

			if arg_53_1.time_ >= var_56_25 + var_56_26 and arg_53_1.time_ < var_56_25 + var_56_26 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect10083ui_story then
				local var_56_29 = 0.5

				arg_53_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10083ui_story.fillRatio = var_56_29
			end

			local var_56_30 = 0
			local var_56_31 = 0.875

			if var_56_30 < arg_53_1.time_ and arg_53_1.time_ <= var_56_30 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_32 = arg_53_1:GetWordFromCfg(412082013)
				local var_56_33 = arg_53_1:FormatText(var_56_32.content)

				arg_53_1.text_.text = var_56_33

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_34 = 35
				local var_56_35 = utf8.len(var_56_33)
				local var_56_36 = var_56_34 <= 0 and var_56_31 or var_56_31 * (var_56_35 / var_56_34)

				if var_56_36 > 0 and var_56_31 < var_56_36 then
					arg_53_1.talkMaxDuration = var_56_36

					if var_56_36 + var_56_30 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_36 + var_56_30
					end
				end

				arg_53_1.text_.text = var_56_33
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_37 = math.max(var_56_31, arg_53_1.talkMaxDuration)

			if var_56_30 <= arg_53_1.time_ and arg_53_1.time_ < var_56_30 + var_56_37 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_30) / var_56_37

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_30 + var_56_37 and arg_53_1.time_ < var_56_30 + var_56_37 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play412082014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 412082014
		arg_57_1.duration_ = 2.7

		local var_57_0 = {
			zh = 2.333,
			ja = 2.7
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
				arg_57_0:Play412082015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10083ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10083ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(-1, -2.6, -2.8)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10083ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-1, -2.6, -2.8)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["10083ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect10083ui_story == nil then
				arg_57_1.var_.characterEffect10083ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect10083ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect10083ui_story then
				arg_57_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action2_1")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_15 = 0
			local var_60_16 = 0.275

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[918].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(412082014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 11
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_16 or var_60_16 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_16 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082014", "story_v_out_412082.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_412082", "412082014", "story_v_out_412082.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_412082", "412082014", "story_v_out_412082.awb")

						arg_57_1:RecordAudio("412082014", var_60_24)
						arg_57_1:RecordAudio("412082014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_412082", "412082014", "story_v_out_412082.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_412082", "412082014", "story_v_out_412082.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_25 and arg_57_1.time_ < var_60_15 + var_60_25 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412082015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 412082015
		arg_61_1.duration_ = 2.87

		local var_61_0 = {
			zh = 2.866,
			ja = 1.999999999999
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
				arg_61_0:Play412082016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10078ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10078ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0.7, -0.5, -6.3)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10078ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["10078ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10078ui_story == nil then
				arg_61_1.var_.characterEffect10078ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect10078ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10078ui_story then
				arg_61_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_15 = arg_61_1.actors_["10083ui_story"]
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.characterEffect10083ui_story == nil then
				arg_61_1.var_.characterEffect10083ui_story = var_64_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_17 = 0.200000002980232

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 and not isNil(var_64_15) then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17

				if arg_61_1.var_.characterEffect10083ui_story and not isNil(var_64_15) then
					local var_64_19 = Mathf.Lerp(0, 0.5, var_64_18)

					arg_61_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10083ui_story.fillRatio = var_64_19
				end
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.characterEffect10083ui_story then
				local var_64_20 = 0.5

				arg_61_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10083ui_story.fillRatio = var_64_20
			end

			local var_64_21 = 0
			local var_64_22 = 0.25

			if var_64_21 < arg_61_1.time_ and arg_61_1.time_ <= var_64_21 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_23 = arg_61_1:FormatText(StoryNameCfg[919].name)

				arg_61_1.leftNameTxt_.text = var_64_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_24 = arg_61_1:GetWordFromCfg(412082015)
				local var_64_25 = arg_61_1:FormatText(var_64_24.content)

				arg_61_1.text_.text = var_64_25

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_26 = 10
				local var_64_27 = utf8.len(var_64_25)
				local var_64_28 = var_64_26 <= 0 and var_64_22 or var_64_22 * (var_64_27 / var_64_26)

				if var_64_28 > 0 and var_64_22 < var_64_28 then
					arg_61_1.talkMaxDuration = var_64_28

					if var_64_28 + var_64_21 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_28 + var_64_21
					end
				end

				arg_61_1.text_.text = var_64_25
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082015", "story_v_out_412082.awb") ~= 0 then
					local var_64_29 = manager.audio:GetVoiceLength("story_v_out_412082", "412082015", "story_v_out_412082.awb") / 1000

					if var_64_29 + var_64_21 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_29 + var_64_21
					end

					if var_64_24.prefab_name ~= "" and arg_61_1.actors_[var_64_24.prefab_name] ~= nil then
						local var_64_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_24.prefab_name].transform, "story_v_out_412082", "412082015", "story_v_out_412082.awb")

						arg_61_1:RecordAudio("412082015", var_64_30)
						arg_61_1:RecordAudio("412082015", var_64_30)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_412082", "412082015", "story_v_out_412082.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_412082", "412082015", "story_v_out_412082.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_31 = math.max(var_64_22, arg_61_1.talkMaxDuration)

			if var_64_21 <= arg_61_1.time_ and arg_61_1.time_ < var_64_21 + var_64_31 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_21) / var_64_31

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_21 + var_64_31 and arg_61_1.time_ < var_64_21 + var_64_31 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play412082016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 412082016
		arg_65_1.duration_ = 2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play412082017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10083ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10083ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, -2.6, -2.8)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10083ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["10083ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10083ui_story == nil then
				arg_65_1.var_.characterEffect10083ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect10083ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10083ui_story then
				arg_65_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083actionlink/10083action424")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_15 = arg_65_1.actors_["10078ui_story"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect10078ui_story == nil then
				arg_65_1.var_.characterEffect10078ui_story = var_68_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_17 = 0.200000002980232

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.characterEffect10078ui_story and not isNil(var_68_15) then
					local var_68_19 = Mathf.Lerp(0, 0.5, var_68_18)

					arg_65_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10078ui_story.fillRatio = var_68_19
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect10078ui_story then
				local var_68_20 = 0.5

				arg_65_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10078ui_story.fillRatio = var_68_20
			end

			local var_68_21 = arg_65_1.actors_["10078ui_story"].transform
			local var_68_22 = 0

			if var_68_22 < arg_65_1.time_ and arg_65_1.time_ <= var_68_22 + arg_68_0 then
				arg_65_1.var_.moveOldPos10078ui_story = var_68_21.localPosition
			end

			local var_68_23 = 0.001

			if var_68_22 <= arg_65_1.time_ and arg_65_1.time_ < var_68_22 + var_68_23 then
				local var_68_24 = (arg_65_1.time_ - var_68_22) / var_68_23
				local var_68_25 = Vector3.New(0, 100, 0)

				var_68_21.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10078ui_story, var_68_25, var_68_24)

				local var_68_26 = manager.ui.mainCamera.transform.position - var_68_21.position

				var_68_21.forward = Vector3.New(var_68_26.x, var_68_26.y, var_68_26.z)

				local var_68_27 = var_68_21.localEulerAngles

				var_68_27.z = 0
				var_68_27.x = 0
				var_68_21.localEulerAngles = var_68_27
			end

			if arg_65_1.time_ >= var_68_22 + var_68_23 and arg_65_1.time_ < var_68_22 + var_68_23 + arg_68_0 then
				var_68_21.localPosition = Vector3.New(0, 100, 0)

				local var_68_28 = manager.ui.mainCamera.transform.position - var_68_21.position

				var_68_21.forward = Vector3.New(var_68_28.x, var_68_28.y, var_68_28.z)

				local var_68_29 = var_68_21.localEulerAngles

				var_68_29.z = 0
				var_68_29.x = 0
				var_68_21.localEulerAngles = var_68_29
			end

			local var_68_30 = 0
			local var_68_31 = 0.0329999998211861

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_32 = arg_65_1:FormatText(StoryNameCfg[918].name)

				arg_65_1.leftNameTxt_.text = var_68_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_33 = arg_65_1:GetWordFromCfg(412082016)
				local var_68_34 = arg_65_1:FormatText(var_68_33.content)

				arg_65_1.text_.text = var_68_34

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_35 = 1
				local var_68_36 = utf8.len(var_68_34)
				local var_68_37 = var_68_35 <= 0 and var_68_31 or var_68_31 * (var_68_36 / var_68_35)

				if var_68_37 > 0 and var_68_31 < var_68_37 then
					arg_65_1.talkMaxDuration = var_68_37

					if var_68_37 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_37 + var_68_30
					end
				end

				arg_65_1.text_.text = var_68_34
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082016", "story_v_out_412082.awb") ~= 0 then
					local var_68_38 = manager.audio:GetVoiceLength("story_v_out_412082", "412082016", "story_v_out_412082.awb") / 1000

					if var_68_38 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_38 + var_68_30
					end

					if var_68_33.prefab_name ~= "" and arg_65_1.actors_[var_68_33.prefab_name] ~= nil then
						local var_68_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_33.prefab_name].transform, "story_v_out_412082", "412082016", "story_v_out_412082.awb")

						arg_65_1:RecordAudio("412082016", var_68_39)
						arg_65_1:RecordAudio("412082016", var_68_39)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_412082", "412082016", "story_v_out_412082.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_412082", "412082016", "story_v_out_412082.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_40 = math.max(var_68_31, arg_65_1.talkMaxDuration)

			if var_68_30 <= arg_65_1.time_ and arg_65_1.time_ < var_68_30 + var_68_40 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_30) / var_68_40

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_30 + var_68_40 and arg_65_1.time_ < var_68_30 + var_68_40 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412082017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 412082017
		arg_69_1.duration_ = 4.8

		local var_69_0 = {
			zh = 4.8,
			ja = 4.7
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
				arg_69_0:Play412082018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10078ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10078ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, 100, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10078ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, 100, 0)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["10078ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10078ui_story == nil then
				arg_69_1.var_.characterEffect10078ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect10078ui_story and not isNil(var_72_9) then
					arg_69_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10078ui_story then
				arg_69_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_72_13 = 0

			if var_72_13 < arg_69_1.time_ and arg_69_1.time_ <= var_72_13 + arg_72_0 then
				arg_69_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_72_14 = 0

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_15 = arg_69_1.actors_["10083ui_story"]
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.characterEffect10083ui_story == nil then
				arg_69_1.var_.characterEffect10083ui_story = var_72_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_17 = 0.200000002980232

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 and not isNil(var_72_15) then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17

				if arg_69_1.var_.characterEffect10083ui_story and not isNil(var_72_15) then
					local var_72_19 = Mathf.Lerp(0, 0.5, var_72_18)

					arg_69_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10083ui_story.fillRatio = var_72_19
				end
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.characterEffect10083ui_story then
				local var_72_20 = 0.5

				arg_69_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10083ui_story.fillRatio = var_72_20
			end

			local var_72_21 = arg_69_1.actors_["10083ui_story"].transform
			local var_72_22 = 0

			if var_72_22 < arg_69_1.time_ and arg_69_1.time_ <= var_72_22 + arg_72_0 then
				arg_69_1.var_.moveOldPos10083ui_story = var_72_21.localPosition
			end

			local var_72_23 = 0.001

			if var_72_22 <= arg_69_1.time_ and arg_69_1.time_ < var_72_22 + var_72_23 then
				local var_72_24 = (arg_69_1.time_ - var_72_22) / var_72_23
				local var_72_25 = Vector3.New(0, -2.6, -2.8)

				var_72_21.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10083ui_story, var_72_25, var_72_24)

				local var_72_26 = manager.ui.mainCamera.transform.position - var_72_21.position

				var_72_21.forward = Vector3.New(var_72_26.x, var_72_26.y, var_72_26.z)

				local var_72_27 = var_72_21.localEulerAngles

				var_72_27.z = 0
				var_72_27.x = 0
				var_72_21.localEulerAngles = var_72_27
			end

			if arg_69_1.time_ >= var_72_22 + var_72_23 and arg_69_1.time_ < var_72_22 + var_72_23 + arg_72_0 then
				var_72_21.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_72_28 = manager.ui.mainCamera.transform.position - var_72_21.position

				var_72_21.forward = Vector3.New(var_72_28.x, var_72_28.y, var_72_28.z)

				local var_72_29 = var_72_21.localEulerAngles

				var_72_29.z = 0
				var_72_29.x = 0
				var_72_21.localEulerAngles = var_72_29
			end

			local var_72_30 = 0
			local var_72_31 = 0.475

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_32 = arg_69_1:FormatText(StoryNameCfg[919].name)

				arg_69_1.leftNameTxt_.text = var_72_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10078")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_33 = arg_69_1:GetWordFromCfg(412082017)
				local var_72_34 = arg_69_1:FormatText(var_72_33.content)

				arg_69_1.text_.text = var_72_34

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_35 = 19
				local var_72_36 = utf8.len(var_72_34)
				local var_72_37 = var_72_35 <= 0 and var_72_31 or var_72_31 * (var_72_36 / var_72_35)

				if var_72_37 > 0 and var_72_31 < var_72_37 then
					arg_69_1.talkMaxDuration = var_72_37

					if var_72_37 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_37 + var_72_30
					end
				end

				arg_69_1.text_.text = var_72_34
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082017", "story_v_out_412082.awb") ~= 0 then
					local var_72_38 = manager.audio:GetVoiceLength("story_v_out_412082", "412082017", "story_v_out_412082.awb") / 1000

					if var_72_38 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_38 + var_72_30
					end

					if var_72_33.prefab_name ~= "" and arg_69_1.actors_[var_72_33.prefab_name] ~= nil then
						local var_72_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_33.prefab_name].transform, "story_v_out_412082", "412082017", "story_v_out_412082.awb")

						arg_69_1:RecordAudio("412082017", var_72_39)
						arg_69_1:RecordAudio("412082017", var_72_39)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_412082", "412082017", "story_v_out_412082.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_412082", "412082017", "story_v_out_412082.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_40 = math.max(var_72_31, arg_69_1.talkMaxDuration)

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_40 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_30) / var_72_40

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_30 + var_72_40 and arg_69_1.time_ < var_72_30 + var_72_40 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play412082018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 412082018
		arg_73_1.duration_ = 4.87

		local var_73_0 = {
			zh = 2.233,
			ja = 4.866
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
				arg_73_0:Play412082019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10083ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10083ui_story == nil then
				arg_73_1.var_.characterEffect10083ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect10083ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10083ui_story then
				arg_73_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_76_4 = 0

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_2")
			end

			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_6 = arg_73_1.actors_["10078ui_story"]
			local var_76_7 = 0

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect10078ui_story == nil then
				arg_73_1.var_.characterEffect10078ui_story = var_76_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_8 = 0.200000002980232

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_8 and not isNil(var_76_6) then
				local var_76_9 = (arg_73_1.time_ - var_76_7) / var_76_8

				if arg_73_1.var_.characterEffect10078ui_story and not isNil(var_76_6) then
					local var_76_10 = Mathf.Lerp(0, 0.5, var_76_9)

					arg_73_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10078ui_story.fillRatio = var_76_10
				end
			end

			if arg_73_1.time_ >= var_76_7 + var_76_8 and arg_73_1.time_ < var_76_7 + var_76_8 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect10078ui_story then
				local var_76_11 = 0.5

				arg_73_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10078ui_story.fillRatio = var_76_11
			end

			local var_76_12 = 0
			local var_76_13 = 0.25

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_14 = arg_73_1:FormatText(StoryNameCfg[918].name)

				arg_73_1.leftNameTxt_.text = var_76_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_15 = arg_73_1:GetWordFromCfg(412082018)
				local var_76_16 = arg_73_1:FormatText(var_76_15.content)

				arg_73_1.text_.text = var_76_16

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 10
				local var_76_18 = utf8.len(var_76_16)
				local var_76_19 = var_76_17 <= 0 and var_76_13 or var_76_13 * (var_76_18 / var_76_17)

				if var_76_19 > 0 and var_76_13 < var_76_19 then
					arg_73_1.talkMaxDuration = var_76_19

					if var_76_19 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_16
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082018", "story_v_out_412082.awb") ~= 0 then
					local var_76_20 = manager.audio:GetVoiceLength("story_v_out_412082", "412082018", "story_v_out_412082.awb") / 1000

					if var_76_20 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_20 + var_76_12
					end

					if var_76_15.prefab_name ~= "" and arg_73_1.actors_[var_76_15.prefab_name] ~= nil then
						local var_76_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_15.prefab_name].transform, "story_v_out_412082", "412082018", "story_v_out_412082.awb")

						arg_73_1:RecordAudio("412082018", var_76_21)
						arg_73_1:RecordAudio("412082018", var_76_21)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_412082", "412082018", "story_v_out_412082.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_412082", "412082018", "story_v_out_412082.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_22 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_22

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_22 and arg_73_1.time_ < var_76_12 + var_76_22 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play412082019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 412082019
		arg_77_1.duration_ = 4.2

		local var_77_0 = {
			zh = 2.266,
			ja = 4.2
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
				arg_77_0:Play412082020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10083ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10083ui_story == nil then
				arg_77_1.var_.characterEffect10083ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect10083ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10083ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10083ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10083ui_story.fillRatio = var_80_5
			end

			local var_80_6 = arg_77_1.actors_["10078ui_story"]
			local var_80_7 = 0

			if var_80_7 < arg_77_1.time_ and arg_77_1.time_ <= var_80_7 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect10078ui_story == nil then
				arg_77_1.var_.characterEffect10078ui_story = var_80_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_8 = 0.200000002980232

			if var_80_7 <= arg_77_1.time_ and arg_77_1.time_ < var_80_7 + var_80_8 and not isNil(var_80_6) then
				local var_80_9 = (arg_77_1.time_ - var_80_7) / var_80_8

				if arg_77_1.var_.characterEffect10078ui_story and not isNil(var_80_6) then
					arg_77_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_7 + var_80_8 and arg_77_1.time_ < var_80_7 + var_80_8 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect10078ui_story then
				arg_77_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_80_10 = 0
			local var_80_11 = 0.25

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_12 = arg_77_1:FormatText(StoryNameCfg[919].name)

				arg_77_1.leftNameTxt_.text = var_80_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10078")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_13 = arg_77_1:GetWordFromCfg(412082019)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 10
				local var_80_16 = utf8.len(var_80_14)
				local var_80_17 = var_80_15 <= 0 and var_80_11 or var_80_11 * (var_80_16 / var_80_15)

				if var_80_17 > 0 and var_80_11 < var_80_17 then
					arg_77_1.talkMaxDuration = var_80_17

					if var_80_17 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082019", "story_v_out_412082.awb") ~= 0 then
					local var_80_18 = manager.audio:GetVoiceLength("story_v_out_412082", "412082019", "story_v_out_412082.awb") / 1000

					if var_80_18 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_10
					end

					if var_80_13.prefab_name ~= "" and arg_77_1.actors_[var_80_13.prefab_name] ~= nil then
						local var_80_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_13.prefab_name].transform, "story_v_out_412082", "412082019", "story_v_out_412082.awb")

						arg_77_1:RecordAudio("412082019", var_80_19)
						arg_77_1:RecordAudio("412082019", var_80_19)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_412082", "412082019", "story_v_out_412082.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_412082", "412082019", "story_v_out_412082.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_20 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_20 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_20

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_20 and arg_77_1.time_ < var_80_10 + var_80_20 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play412082020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 412082020
		arg_81_1.duration_ = 6.63

		local var_81_0 = {
			zh = 4.033,
			ja = 6.633
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
				arg_81_0:Play412082021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1097ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1097ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, -0.54, -6.3)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1097ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["1097ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1097ui_story == nil then
				arg_81_1.var_.characterEffect1097ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect1097ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1097ui_story then
				arg_81_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_84_15 = arg_81_1.actors_["10078ui_story"].transform
			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.var_.moveOldPos10078ui_story = var_84_15.localPosition
			end

			local var_84_17 = 0.001

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_17 then
				local var_84_18 = (arg_81_1.time_ - var_84_16) / var_84_17
				local var_84_19 = Vector3.New(0, 100, 0)

				var_84_15.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10078ui_story, var_84_19, var_84_18)

				local var_84_20 = manager.ui.mainCamera.transform.position - var_84_15.position

				var_84_15.forward = Vector3.New(var_84_20.x, var_84_20.y, var_84_20.z)

				local var_84_21 = var_84_15.localEulerAngles

				var_84_21.z = 0
				var_84_21.x = 0
				var_84_15.localEulerAngles = var_84_21
			end

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 then
				var_84_15.localPosition = Vector3.New(0, 100, 0)

				local var_84_22 = manager.ui.mainCamera.transform.position - var_84_15.position

				var_84_15.forward = Vector3.New(var_84_22.x, var_84_22.y, var_84_22.z)

				local var_84_23 = var_84_15.localEulerAngles

				var_84_23.z = 0
				var_84_23.x = 0
				var_84_15.localEulerAngles = var_84_23
			end

			local var_84_24 = arg_81_1.actors_["10078ui_story"]
			local var_84_25 = 0

			if var_84_25 < arg_81_1.time_ and arg_81_1.time_ <= var_84_25 + arg_84_0 and not isNil(var_84_24) and arg_81_1.var_.characterEffect10078ui_story == nil then
				arg_81_1.var_.characterEffect10078ui_story = var_84_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_26 = 0.200000002980232

			if var_84_25 <= arg_81_1.time_ and arg_81_1.time_ < var_84_25 + var_84_26 and not isNil(var_84_24) then
				local var_84_27 = (arg_81_1.time_ - var_84_25) / var_84_26

				if arg_81_1.var_.characterEffect10078ui_story and not isNil(var_84_24) then
					local var_84_28 = Mathf.Lerp(0, 0.5, var_84_27)

					arg_81_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10078ui_story.fillRatio = var_84_28
				end
			end

			if arg_81_1.time_ >= var_84_25 + var_84_26 and arg_81_1.time_ < var_84_25 + var_84_26 + arg_84_0 and not isNil(var_84_24) and arg_81_1.var_.characterEffect10078ui_story then
				local var_84_29 = 0.5

				arg_81_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10078ui_story.fillRatio = var_84_29
			end

			local var_84_30 = arg_81_1.actors_["10083ui_story"].transform
			local var_84_31 = 0

			if var_84_31 < arg_81_1.time_ and arg_81_1.time_ <= var_84_31 + arg_84_0 then
				arg_81_1.var_.moveOldPos10083ui_story = var_84_30.localPosition
			end

			local var_84_32 = 0.001

			if var_84_31 <= arg_81_1.time_ and arg_81_1.time_ < var_84_31 + var_84_32 then
				local var_84_33 = (arg_81_1.time_ - var_84_31) / var_84_32
				local var_84_34 = Vector3.New(0, 100, 0)

				var_84_30.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10083ui_story, var_84_34, var_84_33)

				local var_84_35 = manager.ui.mainCamera.transform.position - var_84_30.position

				var_84_30.forward = Vector3.New(var_84_35.x, var_84_35.y, var_84_35.z)

				local var_84_36 = var_84_30.localEulerAngles

				var_84_36.z = 0
				var_84_36.x = 0
				var_84_30.localEulerAngles = var_84_36
			end

			if arg_81_1.time_ >= var_84_31 + var_84_32 and arg_81_1.time_ < var_84_31 + var_84_32 + arg_84_0 then
				var_84_30.localPosition = Vector3.New(0, 100, 0)

				local var_84_37 = manager.ui.mainCamera.transform.position - var_84_30.position

				var_84_30.forward = Vector3.New(var_84_37.x, var_84_37.y, var_84_37.z)

				local var_84_38 = var_84_30.localEulerAngles

				var_84_38.z = 0
				var_84_38.x = 0
				var_84_30.localEulerAngles = var_84_38
			end

			local var_84_39 = arg_81_1.actors_["10083ui_story"]
			local var_84_40 = 0

			if var_84_40 < arg_81_1.time_ and arg_81_1.time_ <= var_84_40 + arg_84_0 and not isNil(var_84_39) and arg_81_1.var_.characterEffect10083ui_story == nil then
				arg_81_1.var_.characterEffect10083ui_story = var_84_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_41 = 0.200000002980232

			if var_84_40 <= arg_81_1.time_ and arg_81_1.time_ < var_84_40 + var_84_41 and not isNil(var_84_39) then
				local var_84_42 = (arg_81_1.time_ - var_84_40) / var_84_41

				if arg_81_1.var_.characterEffect10083ui_story and not isNil(var_84_39) then
					local var_84_43 = Mathf.Lerp(0, 0.5, var_84_42)

					arg_81_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10083ui_story.fillRatio = var_84_43
				end
			end

			if arg_81_1.time_ >= var_84_40 + var_84_41 and arg_81_1.time_ < var_84_40 + var_84_41 + arg_84_0 and not isNil(var_84_39) and arg_81_1.var_.characterEffect10083ui_story then
				local var_84_44 = 0.5

				arg_81_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10083ui_story.fillRatio = var_84_44
			end

			local var_84_45 = 0
			local var_84_46 = 0.45

			if var_84_45 < arg_81_1.time_ and arg_81_1.time_ <= var_84_45 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_47 = arg_81_1:FormatText(StoryNameCfg[216].name)

				arg_81_1.leftNameTxt_.text = var_84_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_48 = arg_81_1:GetWordFromCfg(412082020)
				local var_84_49 = arg_81_1:FormatText(var_84_48.content)

				arg_81_1.text_.text = var_84_49

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_50 = 18
				local var_84_51 = utf8.len(var_84_49)
				local var_84_52 = var_84_50 <= 0 and var_84_46 or var_84_46 * (var_84_51 / var_84_50)

				if var_84_52 > 0 and var_84_46 < var_84_52 then
					arg_81_1.talkMaxDuration = var_84_52

					if var_84_52 + var_84_45 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_52 + var_84_45
					end
				end

				arg_81_1.text_.text = var_84_49
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082020", "story_v_out_412082.awb") ~= 0 then
					local var_84_53 = manager.audio:GetVoiceLength("story_v_out_412082", "412082020", "story_v_out_412082.awb") / 1000

					if var_84_53 + var_84_45 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_53 + var_84_45
					end

					if var_84_48.prefab_name ~= "" and arg_81_1.actors_[var_84_48.prefab_name] ~= nil then
						local var_84_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_48.prefab_name].transform, "story_v_out_412082", "412082020", "story_v_out_412082.awb")

						arg_81_1:RecordAudio("412082020", var_84_54)
						arg_81_1:RecordAudio("412082020", var_84_54)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_412082", "412082020", "story_v_out_412082.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_412082", "412082020", "story_v_out_412082.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_55 = math.max(var_84_46, arg_81_1.talkMaxDuration)

			if var_84_45 <= arg_81_1.time_ and arg_81_1.time_ < var_84_45 + var_84_55 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_45) / var_84_55

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_45 + var_84_55 and arg_81_1.time_ < var_84_45 + var_84_55 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play412082021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 412082021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play412082022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1097ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1097ui_story == nil then
				arg_85_1.var_.characterEffect1097ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1097ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1097ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1097ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1097ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.7

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(412082021)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 28
				local var_88_11 = utf8.len(var_88_9)
				local var_88_12 = var_88_10 <= 0 and var_88_7 or var_88_7 * (var_88_11 / var_88_10)

				if var_88_12 > 0 and var_88_7 < var_88_12 then
					arg_85_1.talkMaxDuration = var_88_12

					if var_88_12 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_13 and arg_85_1.time_ < var_88_6 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play412082022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 412082022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play412082023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.975

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(412082022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 39
				local var_92_5 = utf8.len(var_92_3)
				local var_92_6 = var_92_4 <= 0 and var_92_1 or var_92_1 * (var_92_5 / var_92_4)

				if var_92_6 > 0 and var_92_1 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_7 and arg_89_1.time_ < var_92_0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play412082023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 412082023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play412082024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.025

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(412082023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 41
				local var_96_5 = utf8.len(var_96_3)
				local var_96_6 = var_96_4 <= 0 and var_96_1 or var_96_1 * (var_96_5 / var_96_4)

				if var_96_6 > 0 and var_96_1 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_7 and arg_93_1.time_ < var_96_0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play412082024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 412082024
		arg_97_1.duration_ = 8.23

		local var_97_0 = {
			zh = 7.566,
			ja = 8.233
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
				arg_97_0:Play412082025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1097ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1097ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, -0.54, -6.3)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1097ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["1097ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1097ui_story == nil then
				arg_97_1.var_.characterEffect1097ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect1097ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1097ui_story then
				arg_97_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_15 = 0
			local var_100_16 = 0.725

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[216].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(412082024)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 29
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082024", "story_v_out_412082.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_412082", "412082024", "story_v_out_412082.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_412082", "412082024", "story_v_out_412082.awb")

						arg_97_1:RecordAudio("412082024", var_100_24)
						arg_97_1:RecordAudio("412082024", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_412082", "412082024", "story_v_out_412082.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_412082", "412082024", "story_v_out_412082.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_25 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_25 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_25

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_25 and arg_97_1.time_ < var_100_15 + var_100_25 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play412082025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 412082025
		arg_101_1.duration_ = 14.4

		local var_101_0 = {
			zh = 14.4,
			ja = 13.5
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
				arg_101_0:Play412082026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.125

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[216].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(412082025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 45
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082025", "story_v_out_412082.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_412082", "412082025", "story_v_out_412082.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_412082", "412082025", "story_v_out_412082.awb")

						arg_101_1:RecordAudio("412082025", var_104_9)
						arg_101_1:RecordAudio("412082025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_412082", "412082025", "story_v_out_412082.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_412082", "412082025", "story_v_out_412082.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_10 and arg_101_1.time_ < var_104_0 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play412082026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 412082026
		arg_105_1.duration_ = 16.27

		local var_105_0 = {
			zh = 9.666,
			ja = 16.266
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play412082027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_108_2 = 0
			local var_108_3 = 1

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_4 = arg_105_1:FormatText(StoryNameCfg[216].name)

				arg_105_1.leftNameTxt_.text = var_108_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:GetWordFromCfg(412082026)
				local var_108_6 = arg_105_1:FormatText(var_108_5.content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 40
				local var_108_8 = utf8.len(var_108_6)
				local var_108_9 = var_108_7 <= 0 and var_108_3 or var_108_3 * (var_108_8 / var_108_7)

				if var_108_9 > 0 and var_108_3 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082026", "story_v_out_412082.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_412082", "412082026", "story_v_out_412082.awb") / 1000

					if var_108_10 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_2
					end

					if var_108_5.prefab_name ~= "" and arg_105_1.actors_[var_108_5.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_5.prefab_name].transform, "story_v_out_412082", "412082026", "story_v_out_412082.awb")

						arg_105_1:RecordAudio("412082026", var_108_11)
						arg_105_1:RecordAudio("412082026", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_412082", "412082026", "story_v_out_412082.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_412082", "412082026", "story_v_out_412082.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_12 and arg_105_1.time_ < var_108_2 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play412082027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 412082027
		arg_109_1.duration_ = 9.97

		local var_109_0 = {
			zh = 9.966,
			ja = 9.766
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
				arg_109_0:Play412082028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_112_2 = 0
			local var_112_3 = 0.9

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_4 = arg_109_1:FormatText(StoryNameCfg[216].name)

				arg_109_1.leftNameTxt_.text = var_112_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:GetWordFromCfg(412082027)
				local var_112_6 = arg_109_1:FormatText(var_112_5.content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 36
				local var_112_8 = utf8.len(var_112_6)
				local var_112_9 = var_112_7 <= 0 and var_112_3 or var_112_3 * (var_112_8 / var_112_7)

				if var_112_9 > 0 and var_112_3 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082027", "story_v_out_412082.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_412082", "412082027", "story_v_out_412082.awb") / 1000

					if var_112_10 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_2
					end

					if var_112_5.prefab_name ~= "" and arg_109_1.actors_[var_112_5.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_5.prefab_name].transform, "story_v_out_412082", "412082027", "story_v_out_412082.awb")

						arg_109_1:RecordAudio("412082027", var_112_11)
						arg_109_1:RecordAudio("412082027", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_412082", "412082027", "story_v_out_412082.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_412082", "412082027", "story_v_out_412082.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_12 and arg_109_1.time_ < var_112_2 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play412082028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 412082028
		arg_113_1.duration_ = 18.1

		local var_113_0 = {
			zh = 8.833,
			ja = 18.1
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play412082029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_116_2 = 0
			local var_116_3 = 0.85

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_4 = arg_113_1:FormatText(StoryNameCfg[216].name)

				arg_113_1.leftNameTxt_.text = var_116_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:GetWordFromCfg(412082028)
				local var_116_6 = arg_113_1:FormatText(var_116_5.content)

				arg_113_1.text_.text = var_116_6

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 34
				local var_116_8 = utf8.len(var_116_6)
				local var_116_9 = var_116_7 <= 0 and var_116_3 or var_116_3 * (var_116_8 / var_116_7)

				if var_116_9 > 0 and var_116_3 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_6
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082028", "story_v_out_412082.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_412082", "412082028", "story_v_out_412082.awb") / 1000

					if var_116_10 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_2
					end

					if var_116_5.prefab_name ~= "" and arg_113_1.actors_[var_116_5.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_5.prefab_name].transform, "story_v_out_412082", "412082028", "story_v_out_412082.awb")

						arg_113_1:RecordAudio("412082028", var_116_11)
						arg_113_1:RecordAudio("412082028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_412082", "412082028", "story_v_out_412082.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_412082", "412082028", "story_v_out_412082.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_12 and arg_113_1.time_ < var_116_2 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play412082029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 412082029
		arg_117_1.duration_ = 2.77

		local var_117_0 = {
			zh = 2.766,
			ja = 1.566
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
				arg_117_0:Play412082030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1097ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1097ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, 100, 0)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1097ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, 100, 0)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1097ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1097ui_story == nil then
				arg_117_1.var_.characterEffect1097ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect1097ui_story and not isNil(var_120_9) then
					local var_120_13 = Mathf.Lerp(0, 0.5, var_120_12)

					arg_117_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1097ui_story.fillRatio = var_120_13
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1097ui_story then
				local var_120_14 = 0.5

				arg_117_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1097ui_story.fillRatio = var_120_14
			end

			local var_120_15 = 0
			local var_120_16 = 0.275

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[919].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10078")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_18 = arg_117_1:GetWordFromCfg(412082029)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 11
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082029", "story_v_out_412082.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_out_412082", "412082029", "story_v_out_412082.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_out_412082", "412082029", "story_v_out_412082.awb")

						arg_117_1:RecordAudio("412082029", var_120_24)
						arg_117_1:RecordAudio("412082029", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_412082", "412082029", "story_v_out_412082.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_412082", "412082029", "story_v_out_412082.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_25 and arg_117_1.time_ < var_120_15 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play412082030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 412082030
		arg_121_1.duration_ = 2

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play412082031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1097ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1097ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, -0.54, -6.3)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1097ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["1097ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1097ui_story == nil then
				arg_121_1.var_.characterEffect1097ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect1097ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1097ui_story then
				arg_121_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_124_13 = 0

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_15 = arg_121_1.actors_["10078ui_story"].transform
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.var_.moveOldPos10078ui_story = var_124_15.localPosition
			end

			local var_124_17 = 0.001

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / var_124_17
				local var_124_19 = Vector3.New(0, 100, 0)

				var_124_15.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10078ui_story, var_124_19, var_124_18)

				local var_124_20 = manager.ui.mainCamera.transform.position - var_124_15.position

				var_124_15.forward = Vector3.New(var_124_20.x, var_124_20.y, var_124_20.z)

				local var_124_21 = var_124_15.localEulerAngles

				var_124_21.z = 0
				var_124_21.x = 0
				var_124_15.localEulerAngles = var_124_21
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 then
				var_124_15.localPosition = Vector3.New(0, 100, 0)

				local var_124_22 = manager.ui.mainCamera.transform.position - var_124_15.position

				var_124_15.forward = Vector3.New(var_124_22.x, var_124_22.y, var_124_22.z)

				local var_124_23 = var_124_15.localEulerAngles

				var_124_23.z = 0
				var_124_23.x = 0
				var_124_15.localEulerAngles = var_124_23
			end

			local var_124_24 = arg_121_1.actors_["10078ui_story"]
			local var_124_25 = 0

			if var_124_25 < arg_121_1.time_ and arg_121_1.time_ <= var_124_25 + arg_124_0 and not isNil(var_124_24) and arg_121_1.var_.characterEffect10078ui_story == nil then
				arg_121_1.var_.characterEffect10078ui_story = var_124_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_26 = 0.200000002980232

			if var_124_25 <= arg_121_1.time_ and arg_121_1.time_ < var_124_25 + var_124_26 and not isNil(var_124_24) then
				local var_124_27 = (arg_121_1.time_ - var_124_25) / var_124_26

				if arg_121_1.var_.characterEffect10078ui_story and not isNil(var_124_24) then
					local var_124_28 = Mathf.Lerp(0, 0.5, var_124_27)

					arg_121_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10078ui_story.fillRatio = var_124_28
				end
			end

			if arg_121_1.time_ >= var_124_25 + var_124_26 and arg_121_1.time_ < var_124_25 + var_124_26 + arg_124_0 and not isNil(var_124_24) and arg_121_1.var_.characterEffect10078ui_story then
				local var_124_29 = 0.5

				arg_121_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10078ui_story.fillRatio = var_124_29
			end

			local var_124_30 = 0
			local var_124_31 = 0.05

			if var_124_30 < arg_121_1.time_ and arg_121_1.time_ <= var_124_30 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_32 = arg_121_1:FormatText(StoryNameCfg[216].name)

				arg_121_1.leftNameTxt_.text = var_124_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_33 = arg_121_1:GetWordFromCfg(412082030)
				local var_124_34 = arg_121_1:FormatText(var_124_33.content)

				arg_121_1.text_.text = var_124_34

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_35 = 2
				local var_124_36 = utf8.len(var_124_34)
				local var_124_37 = var_124_35 <= 0 and var_124_31 or var_124_31 * (var_124_36 / var_124_35)

				if var_124_37 > 0 and var_124_31 < var_124_37 then
					arg_121_1.talkMaxDuration = var_124_37

					if var_124_37 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_37 + var_124_30
					end
				end

				arg_121_1.text_.text = var_124_34
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412082", "412082030", "story_v_out_412082.awb") ~= 0 then
					local var_124_38 = manager.audio:GetVoiceLength("story_v_out_412082", "412082030", "story_v_out_412082.awb") / 1000

					if var_124_38 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_38 + var_124_30
					end

					if var_124_33.prefab_name ~= "" and arg_121_1.actors_[var_124_33.prefab_name] ~= nil then
						local var_124_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_33.prefab_name].transform, "story_v_out_412082", "412082030", "story_v_out_412082.awb")

						arg_121_1:RecordAudio("412082030", var_124_39)
						arg_121_1:RecordAudio("412082030", var_124_39)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_412082", "412082030", "story_v_out_412082.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_412082", "412082030", "story_v_out_412082.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_40 = math.max(var_124_31, arg_121_1.talkMaxDuration)

			if var_124_30 <= arg_121_1.time_ and arg_121_1.time_ < var_124_30 + var_124_40 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_30) / var_124_40

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_30 + var_124_40 and arg_121_1.time_ < var_124_30 + var_124_40 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play412082031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 412082031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play412082032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1097ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1097ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, 100, 0)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1097ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, 100, 0)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["1097ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1097ui_story == nil then
				arg_125_1.var_.characterEffect1097ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect1097ui_story and not isNil(var_128_9) then
					local var_128_13 = Mathf.Lerp(0, 0.5, var_128_12)

					arg_125_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1097ui_story.fillRatio = var_128_13
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1097ui_story then
				local var_128_14 = 0.5

				arg_125_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1097ui_story.fillRatio = var_128_14
			end

			local var_128_15 = 0
			local var_128_16 = 1.6

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_17 = arg_125_1:GetWordFromCfg(412082031)
				local var_128_18 = arg_125_1:FormatText(var_128_17.content)

				arg_125_1.text_.text = var_128_18

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_19 = 64
				local var_128_20 = utf8.len(var_128_18)
				local var_128_21 = var_128_19 <= 0 and var_128_16 or var_128_16 * (var_128_20 / var_128_19)

				if var_128_21 > 0 and var_128_16 < var_128_21 then
					arg_125_1.talkMaxDuration = var_128_21

					if var_128_21 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_21 + var_128_15
					end
				end

				arg_125_1.text_.text = var_128_18
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_22 = math.max(var_128_16, arg_125_1.talkMaxDuration)

			if var_128_15 <= arg_125_1.time_ and arg_125_1.time_ < var_128_15 + var_128_22 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_15) / var_128_22

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_15 + var_128_22 and arg_125_1.time_ < var_128_15 + var_128_22 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412082032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 412082032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
			arg_129_1.auto_ = false
		end

		function arg_129_1.playNext_(arg_131_0)
			arg_129_1.onStoryFinished_()
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.925

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(412082032)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 37
				local var_132_5 = utf8.len(var_132_3)
				local var_132_6 = var_132_4 <= 0 and var_132_1 or var_132_1 * (var_132_5 / var_132_4)

				if var_132_6 > 0 and var_132_1 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_7 and arg_129_1.time_ < var_132_0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I09h"
	},
	voices = {
		"story_v_out_412082.awb"
	}
}
