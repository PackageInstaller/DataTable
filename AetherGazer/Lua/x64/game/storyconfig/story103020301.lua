return {
	Play302031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 302031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play302031002(arg_1_1)
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

			local var_4_16 = 2

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

			local var_4_24 = 0.2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

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

			local var_4_34 = 0
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 1.925

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

				local var_4_41 = arg_1_1:GetWordFromCfg(302031001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 77
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
	Play302031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 302031002
		arg_8_1.duration_ = 3.5

		local var_8_0 = {
			zh = 2.733,
			ja = 3.5
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
				arg_8_0:Play302031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1019ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1019ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1019ui_story = var_11_5.localPosition
			end

			local var_11_7 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7
				local var_11_9 = Vector3.New(-0.7, -1.08, -5.9)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1019ui_story, var_11_9, var_11_8)

				local var_11_10 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_10.x, var_11_10.y, var_11_10.z)

				local var_11_11 = var_11_5.localEulerAngles

				var_11_11.z = 0
				var_11_11.x = 0
				var_11_5.localEulerAngles = var_11_11
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_11_12 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_12.x, var_11_12.y, var_11_12.z)

				local var_11_13 = var_11_5.localEulerAngles

				var_11_13.z = 0
				var_11_13.x = 0
				var_11_5.localEulerAngles = var_11_13
			end

			local var_11_14 = arg_8_1.actors_["1019ui_story"]
			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_16 = 0.200000002980232

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_16 and not isNil(var_11_14) then
				local var_11_17 = (arg_8_1.time_ - var_11_15) / var_11_16

				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_14) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_15 + var_11_16 and arg_8_1.time_ < var_11_15 + var_11_16 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_20 = 0
			local var_11_21 = 0.325

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[13].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(302031002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031002", "story_v_out_302031.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_302031", "302031002", "story_v_out_302031.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_302031", "302031002", "story_v_out_302031.awb")

						arg_8_1:RecordAudio("302031002", var_11_29)
						arg_8_1:RecordAudio("302031002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_302031", "302031002", "story_v_out_302031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_302031", "302031002", "story_v_out_302031.awb")
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
				actorName = "1019ui_story",
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
	Play302031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 302031003
		arg_12_1.duration_ = 4.5

		local var_12_0 = {
			zh = 3.666,
			ja = 4.5
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
				arg_12_0:Play302031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1084ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_5.localPosition
			end

			local var_15_7 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7
				local var_15_9 = Vector3.New(0.7, -0.97, -6)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_9, var_15_8)

				local var_15_10 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_10.x, var_15_10.y, var_15_10.z)

				local var_15_11 = var_15_5.localEulerAngles

				var_15_11.z = 0
				var_15_11.x = 0
				var_15_5.localEulerAngles = var_15_11
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_5.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_5.localEulerAngles = var_15_13
			end

			local var_15_14 = arg_12_1.actors_["1084ui_story"]
			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_16 = 0.200000002980232

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_16 and not isNil(var_15_14) then
				local var_15_17 = (arg_12_1.time_ - var_15_15) / var_15_16

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_14) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_15 + var_15_16 and arg_12_1.time_ < var_15_15 + var_15_16 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_18 = arg_12_1.actors_["1019ui_story"]
			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 and not isNil(var_15_18) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_20 = 0.200000002980232

			if var_15_19 <= arg_12_1.time_ and arg_12_1.time_ < var_15_19 + var_15_20 and not isNil(var_15_18) then
				local var_15_21 = (arg_12_1.time_ - var_15_19) / var_15_20

				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_18) then
					local var_15_22 = Mathf.Lerp(0, 0.5, var_15_21)

					arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1019ui_story.fillRatio = var_15_22
				end
			end

			if arg_12_1.time_ >= var_15_19 + var_15_20 and arg_12_1.time_ < var_15_19 + var_15_20 + arg_15_0 and not isNil(var_15_18) and arg_12_1.var_.characterEffect1019ui_story then
				local var_15_23 = 0.5

				arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1019ui_story.fillRatio = var_15_23
			end

			local var_15_24 = 0

			if var_15_24 < arg_12_1.time_ and arg_12_1.time_ <= var_15_24 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_15_25 = 0

			if var_15_25 < arg_12_1.time_ and arg_12_1.time_ <= var_15_25 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_15_26 = 0
			local var_15_27 = 0.325

			if var_15_26 < arg_12_1.time_ and arg_12_1.time_ <= var_15_26 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_28 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_29 = arg_12_1:GetWordFromCfg(302031003)
				local var_15_30 = arg_12_1:FormatText(var_15_29.content)

				arg_12_1.text_.text = var_15_30

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_31 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031003", "story_v_out_302031.awb") ~= 0 then
					local var_15_34 = manager.audio:GetVoiceLength("story_v_out_302031", "302031003", "story_v_out_302031.awb") / 1000

					if var_15_34 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_34 + var_15_26
					end

					if var_15_29.prefab_name ~= "" and arg_12_1.actors_[var_15_29.prefab_name] ~= nil then
						local var_15_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_29.prefab_name].transform, "story_v_out_302031", "302031003", "story_v_out_302031.awb")

						arg_12_1:RecordAudio("302031003", var_15_35)
						arg_12_1:RecordAudio("302031003", var_15_35)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_302031", "302031003", "story_v_out_302031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_302031", "302031003", "story_v_out_302031.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play302031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 302031004
		arg_16_1.duration_ = 8.73

		local var_16_0 = {
			zh = 7.866,
			ja = 8.733
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play302031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1019ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["1084ui_story"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.200000002980232

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 and not isNil(var_19_4) then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_4) then
					local var_19_8 = Mathf.Lerp(0, 0.5, var_19_7)

					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_8
				end
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1084ui_story then
				local var_19_9 = 0.5

				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_9
			end

			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_19_11 = 0

			if var_19_11 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_12 = 0
			local var_19_13 = 0.85

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_14 = arg_16_1:FormatText(StoryNameCfg[13].name)

				arg_16_1.leftNameTxt_.text = var_19_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_15 = arg_16_1:GetWordFromCfg(302031004)
				local var_19_16 = arg_16_1:FormatText(var_19_15.content)

				arg_16_1.text_.text = var_19_16

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 34
				local var_19_18 = utf8.len(var_19_16)
				local var_19_19 = var_19_17 <= 0 and var_19_13 or var_19_13 * (var_19_18 / var_19_17)

				if var_19_19 > 0 and var_19_13 < var_19_19 then
					arg_16_1.talkMaxDuration = var_19_19

					if var_19_19 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_19 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_16
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031004", "story_v_out_302031.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_302031", "302031004", "story_v_out_302031.awb") / 1000

					if var_19_20 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_12
					end

					if var_19_15.prefab_name ~= "" and arg_16_1.actors_[var_19_15.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_15.prefab_name].transform, "story_v_out_302031", "302031004", "story_v_out_302031.awb")

						arg_16_1:RecordAudio("302031004", var_19_21)
						arg_16_1:RecordAudio("302031004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_302031", "302031004", "story_v_out_302031.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_302031", "302031004", "story_v_out_302031.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_22 and arg_16_1.time_ < var_19_12 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play302031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 302031005
		arg_20_1.duration_ = 11.73

		local var_20_0 = {
			zh = 5.9,
			ja = 11.733
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
				arg_20_0:Play302031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_2 = 0
			local var_23_3 = 0.775

			if var_23_2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_4 = arg_20_1:FormatText(StoryNameCfg[13].name)

				arg_20_1.leftNameTxt_.text = var_23_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_5 = arg_20_1:GetWordFromCfg(302031005)
				local var_23_6 = arg_20_1:FormatText(var_23_5.content)

				arg_20_1.text_.text = var_23_6

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 31
				local var_23_8 = utf8.len(var_23_6)
				local var_23_9 = var_23_7 <= 0 and var_23_3 or var_23_3 * (var_23_8 / var_23_7)

				if var_23_9 > 0 and var_23_3 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_6
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031005", "story_v_out_302031.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031005", "story_v_out_302031.awb") / 1000

					if var_23_10 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_2
					end

					if var_23_5.prefab_name ~= "" and arg_20_1.actors_[var_23_5.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_5.prefab_name].transform, "story_v_out_302031", "302031005", "story_v_out_302031.awb")

						arg_20_1:RecordAudio("302031005", var_23_11)
						arg_20_1:RecordAudio("302031005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_302031", "302031005", "story_v_out_302031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_302031", "302031005", "story_v_out_302031.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_12 and arg_20_1.time_ < var_23_2 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play302031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 302031006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play302031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1019ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.4

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_9 = arg_24_1:GetWordFromCfg(302031006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 16
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_14 and arg_24_1.time_ < var_27_6 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play302031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 302031007
		arg_28_1.duration_ = 5.77

		local var_28_0 = {
			zh = 3.9,
			ja = 5.766
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
				arg_28_0:Play302031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1019ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_4 = 0

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_6 = 0
			local var_31_7 = 0.525

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_9 = arg_28_1:GetWordFromCfg(302031007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 21
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031007", "story_v_out_302031.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031007", "story_v_out_302031.awb") / 1000

					if var_31_14 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_6
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_302031", "302031007", "story_v_out_302031.awb")

						arg_28_1:RecordAudio("302031007", var_31_15)
						arg_28_1:RecordAudio("302031007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_302031", "302031007", "story_v_out_302031.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_302031", "302031007", "story_v_out_302031.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_16 and arg_28_1.time_ < var_31_6 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play302031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 302031008
		arg_32_1.duration_ = 10.1

		local var_32_0 = {
			zh = 7.5,
			ja = 10.1
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
				arg_32_0:Play302031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.925

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(302031008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 37
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031008", "story_v_out_302031.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_302031", "302031008", "story_v_out_302031.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_302031", "302031008", "story_v_out_302031.awb")

						arg_32_1:RecordAudio("302031008", var_35_9)
						arg_32_1:RecordAudio("302031008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_302031", "302031008", "story_v_out_302031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_302031", "302031008", "story_v_out_302031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play302031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 302031009
		arg_36_1.duration_ = 8.47

		local var_36_0 = {
			zh = 6.6,
			ja = 8.466
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
				arg_36_0:Play302031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_2 = 0
			local var_39_3 = 0.85

			if var_39_2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_4 = arg_36_1:FormatText(StoryNameCfg[13].name)

				arg_36_1.leftNameTxt_.text = var_39_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_5 = arg_36_1:GetWordFromCfg(302031009)
				local var_39_6 = arg_36_1:FormatText(var_39_5.content)

				arg_36_1.text_.text = var_39_6

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 34
				local var_39_8 = utf8.len(var_39_6)
				local var_39_9 = var_39_7 <= 0 and var_39_3 or var_39_3 * (var_39_8 / var_39_7)

				if var_39_9 > 0 and var_39_3 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_6
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031009", "story_v_out_302031.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031009", "story_v_out_302031.awb") / 1000

					if var_39_10 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_2
					end

					if var_39_5.prefab_name ~= "" and arg_36_1.actors_[var_39_5.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_5.prefab_name].transform, "story_v_out_302031", "302031009", "story_v_out_302031.awb")

						arg_36_1:RecordAudio("302031009", var_39_11)
						arg_36_1:RecordAudio("302031009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_302031", "302031009", "story_v_out_302031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_302031", "302031009", "story_v_out_302031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_12 and arg_36_1.time_ < var_39_2 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play302031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 302031010
		arg_40_1.duration_ = 2.5

		local var_40_0 = {
			zh = 2.5,
			ja = 1.999999999999
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
				arg_40_0:Play302031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "1166ui_story"

			if arg_40_1.actors_[var_43_0] == nil then
				local var_43_1 = Asset.Load("Char/" .. "1166ui_story")

				if not isNil(var_43_1) then
					local var_43_2 = Object.Instantiate(Asset.Load("Char/" .. "1166ui_story"), arg_40_1.stage_.transform)

					var_43_2.name = var_43_0
					var_43_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_0] = var_43_2

					local var_43_3 = var_43_2:GetComponentInChildren(typeof(CharacterEffect))

					var_43_3.enabled = true

					local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_2, typeof(DynamicBoneHelper))

					if var_43_4 then
						var_43_4:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_3.transform, false)

					arg_40_1.var_[var_43_0 .. "Animator"] = var_43_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_0 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_0 .. "LipSync"] = var_43_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_5 = arg_40_1.actors_["1166ui_story"].transform
			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.var_.moveOldPos1166ui_story = var_43_5.localPosition

				local var_43_7 = GameObjectTools.GetOrAddComponent(var_43_5.gameObject, typeof(DynamicBoneHelper))

				if var_43_7 then
					var_43_7:EnableDynamicBone(false)
				end
			end

			local var_43_8 = 0.001

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_8 then
				local var_43_9 = (arg_40_1.time_ - var_43_6) / var_43_8
				local var_43_10 = Vector3.New(0.7, -0.75, -6.25)

				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1166ui_story, var_43_10, var_43_9)

				local var_43_11 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_11.x, var_43_11.y, var_43_11.z)

				local var_43_12 = var_43_5.localEulerAngles

				var_43_12.z = 0
				var_43_12.x = 0
				var_43_5.localEulerAngles = var_43_12
			end

			if arg_40_1.time_ >= var_43_6 + var_43_8 and arg_40_1.time_ < var_43_6 + var_43_8 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(0.7, -0.75, -6.25)

				local var_43_13 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_13.x, var_43_13.y, var_43_13.z)

				local var_43_14 = var_43_5.localEulerAngles

				var_43_14.z = 0
				var_43_14.x = 0
				var_43_5.localEulerAngles = var_43_14

				local var_43_15 = GameObjectTools.GetOrAddComponent(var_43_5.gameObject, typeof(DynamicBoneHelper))

				if var_43_15 then
					var_43_15:EnableDynamicBone(true)
				end
			end

			local var_43_16 = arg_40_1.actors_["1084ui_story"].transform
			local var_43_17 = 0

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = var_43_16.localPosition
			end

			local var_43_18 = 0.001

			if var_43_17 <= arg_40_1.time_ and arg_40_1.time_ < var_43_17 + var_43_18 then
				local var_43_19 = (arg_40_1.time_ - var_43_17) / var_43_18
				local var_43_20 = Vector3.New(0, 100, 0)

				var_43_16.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, var_43_20, var_43_19)

				local var_43_21 = manager.ui.mainCamera.transform.position - var_43_16.position

				var_43_16.forward = Vector3.New(var_43_21.x, var_43_21.y, var_43_21.z)

				local var_43_22 = var_43_16.localEulerAngles

				var_43_22.z = 0
				var_43_22.x = 0
				var_43_16.localEulerAngles = var_43_22
			end

			if arg_40_1.time_ >= var_43_17 + var_43_18 and arg_40_1.time_ < var_43_17 + var_43_18 + arg_43_0 then
				var_43_16.localPosition = Vector3.New(0, 100, 0)

				local var_43_23 = manager.ui.mainCamera.transform.position - var_43_16.position

				var_43_16.forward = Vector3.New(var_43_23.x, var_43_23.y, var_43_23.z)

				local var_43_24 = var_43_16.localEulerAngles

				var_43_24.z = 0
				var_43_24.x = 0
				var_43_16.localEulerAngles = var_43_24
			end

			local var_43_25 = arg_40_1.actors_["1166ui_story"]
			local var_43_26 = 0

			if var_43_26 < arg_40_1.time_ and arg_40_1.time_ <= var_43_26 + arg_43_0 and not isNil(var_43_25) and arg_40_1.var_.characterEffect1166ui_story == nil then
				arg_40_1.var_.characterEffect1166ui_story = var_43_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_27 = 0.200000002980232

			if var_43_26 <= arg_40_1.time_ and arg_40_1.time_ < var_43_26 + var_43_27 and not isNil(var_43_25) then
				local var_43_28 = (arg_40_1.time_ - var_43_26) / var_43_27

				if arg_40_1.var_.characterEffect1166ui_story and not isNil(var_43_25) then
					arg_40_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_26 + var_43_27 and arg_40_1.time_ < var_43_26 + var_43_27 + arg_43_0 and not isNil(var_43_25) and arg_40_1.var_.characterEffect1166ui_story then
				arg_40_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_43_29 = arg_40_1.actors_["1019ui_story"]
			local var_43_30 = 0

			if var_43_30 < arg_40_1.time_ and arg_40_1.time_ <= var_43_30 + arg_43_0 and not isNil(var_43_29) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = var_43_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_31 = 0.200000002980232

			if var_43_30 <= arg_40_1.time_ and arg_40_1.time_ < var_43_30 + var_43_31 and not isNil(var_43_29) then
				local var_43_32 = (arg_40_1.time_ - var_43_30) / var_43_31

				if arg_40_1.var_.characterEffect1019ui_story and not isNil(var_43_29) then
					local var_43_33 = Mathf.Lerp(0, 0.5, var_43_32)

					arg_40_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1019ui_story.fillRatio = var_43_33
				end
			end

			if arg_40_1.time_ >= var_43_30 + var_43_31 and arg_40_1.time_ < var_43_30 + var_43_31 + arg_43_0 and not isNil(var_43_29) and arg_40_1.var_.characterEffect1019ui_story then
				local var_43_34 = 0.5

				arg_40_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1019ui_story.fillRatio = var_43_34
			end

			local var_43_35 = 0

			if var_43_35 < arg_40_1.time_ and arg_40_1.time_ <= var_43_35 + arg_43_0 then
				arg_40_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			local var_43_36 = 0

			if var_43_36 < arg_40_1.time_ and arg_40_1.time_ <= var_43_36 + arg_43_0 then
				arg_40_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganB", "EmotionTimelineAnimator")
			end

			local var_43_37 = 0
			local var_43_38 = 0.175

			if var_43_37 < arg_40_1.time_ and arg_40_1.time_ <= var_43_37 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_39 = arg_40_1:FormatText(StoryNameCfg[32].name)

				arg_40_1.leftNameTxt_.text = var_43_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_40 = arg_40_1:GetWordFromCfg(302031010)
				local var_43_41 = arg_40_1:FormatText(var_43_40.content)

				arg_40_1.text_.text = var_43_41

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_42 = 7
				local var_43_43 = utf8.len(var_43_41)
				local var_43_44 = var_43_42 <= 0 and var_43_38 or var_43_38 * (var_43_43 / var_43_42)

				if var_43_44 > 0 and var_43_38 < var_43_44 then
					arg_40_1.talkMaxDuration = var_43_44

					if var_43_44 + var_43_37 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_44 + var_43_37
					end
				end

				arg_40_1.text_.text = var_43_41
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031010", "story_v_out_302031.awb") ~= 0 then
					local var_43_45 = manager.audio:GetVoiceLength("story_v_out_302031", "302031010", "story_v_out_302031.awb") / 1000

					if var_43_45 + var_43_37 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_45 + var_43_37
					end

					if var_43_40.prefab_name ~= "" and arg_40_1.actors_[var_43_40.prefab_name] ~= nil then
						local var_43_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_40.prefab_name].transform, "story_v_out_302031", "302031010", "story_v_out_302031.awb")

						arg_40_1:RecordAudio("302031010", var_43_46)
						arg_40_1:RecordAudio("302031010", var_43_46)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_302031", "302031010", "story_v_out_302031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_302031", "302031010", "story_v_out_302031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_47 = math.max(var_43_38, arg_40_1.talkMaxDuration)

			if var_43_37 <= arg_40_1.time_ and arg_40_1.time_ < var_43_37 + var_43_47 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_37) / var_43_47

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_37 + var_43_47 and arg_40_1.time_ < var_43_37 + var_43_47 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play302031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 302031011
		arg_44_1.duration_ = 6.7

		local var_44_0 = {
			zh = 5.9,
			ja = 6.7
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
				arg_44_0:Play302031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1019ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1166ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1166ui_story == nil then
				arg_44_1.var_.characterEffect1166ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.200000002980232

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1166ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1166ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1166ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1166ui_story.fillRatio = var_47_9
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_47_12 = 0
			local var_47_13 = 0.725

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[13].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(302031011)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031011", "story_v_out_302031.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_302031", "302031011", "story_v_out_302031.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_302031", "302031011", "story_v_out_302031.awb")

						arg_44_1:RecordAudio("302031011", var_47_21)
						arg_44_1:RecordAudio("302031011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_302031", "302031011", "story_v_out_302031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_302031", "302031011", "story_v_out_302031.awb")
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
	Play302031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 302031012
		arg_48_1.duration_ = 8.83

		local var_48_0 = {
			zh = 5.666,
			ja = 8.833
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
				arg_48_0:Play302031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_2 = 0
			local var_51_3 = 0.7

			if var_51_2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_4 = arg_48_1:FormatText(StoryNameCfg[13].name)

				arg_48_1.leftNameTxt_.text = var_51_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_5 = arg_48_1:GetWordFromCfg(302031012)
				local var_51_6 = arg_48_1:FormatText(var_51_5.content)

				arg_48_1.text_.text = var_51_6

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 28
				local var_51_8 = utf8.len(var_51_6)
				local var_51_9 = var_51_7 <= 0 and var_51_3 or var_51_3 * (var_51_8 / var_51_7)

				if var_51_9 > 0 and var_51_3 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_6
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031012", "story_v_out_302031.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031012", "story_v_out_302031.awb") / 1000

					if var_51_10 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_2
					end

					if var_51_5.prefab_name ~= "" and arg_48_1.actors_[var_51_5.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_5.prefab_name].transform, "story_v_out_302031", "302031012", "story_v_out_302031.awb")

						arg_48_1:RecordAudio("302031012", var_51_11)
						arg_48_1:RecordAudio("302031012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_302031", "302031012", "story_v_out_302031.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_302031", "302031012", "story_v_out_302031.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_3, arg_48_1.talkMaxDuration)

			if var_51_2 <= arg_48_1.time_ and arg_48_1.time_ < var_51_2 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_2) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_2 + var_51_12 and arg_48_1.time_ < var_51_2 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play302031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 302031013
		arg_52_1.duration_ = 4.7

		local var_52_0 = {
			zh = 4.7,
			ja = 4.566
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
				arg_52_0:Play302031014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1166ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1166ui_story = var_55_0.localPosition

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end
			end

			local var_55_3 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_3 then
				local var_55_4 = (arg_52_1.time_ - var_55_1) / var_55_3
				local var_55_5 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1166ui_story, var_55_5, var_55_4)

				local var_55_6 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_6.x, var_55_6.y, var_55_6.z)

				local var_55_7 = var_55_0.localEulerAngles

				var_55_7.z = 0
				var_55_7.x = 0
				var_55_0.localEulerAngles = var_55_7
			end

			if arg_52_1.time_ >= var_55_1 + var_55_3 and arg_52_1.time_ < var_55_1 + var_55_3 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_8 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_8.x, var_55_8.y, var_55_8.z)

				local var_55_9 = var_55_0.localEulerAngles

				var_55_9.z = 0
				var_55_9.x = 0
				var_55_0.localEulerAngles = var_55_9

				local var_55_10 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_10 then
					var_55_10:EnableDynamicBone(true)
				end
			end

			local var_55_11 = arg_52_1.actors_["1084ui_story"].transform
			local var_55_12 = 0

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.var_.moveOldPos1084ui_story = var_55_11.localPosition
			end

			local var_55_13 = 0.001

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_13 then
				local var_55_14 = (arg_52_1.time_ - var_55_12) / var_55_13
				local var_55_15 = Vector3.New(0.7, -0.97, -6)

				var_55_11.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1084ui_story, var_55_15, var_55_14)

				local var_55_16 = manager.ui.mainCamera.transform.position - var_55_11.position

				var_55_11.forward = Vector3.New(var_55_16.x, var_55_16.y, var_55_16.z)

				local var_55_17 = var_55_11.localEulerAngles

				var_55_17.z = 0
				var_55_17.x = 0
				var_55_11.localEulerAngles = var_55_17
			end

			if arg_52_1.time_ >= var_55_12 + var_55_13 and arg_52_1.time_ < var_55_12 + var_55_13 + arg_55_0 then
				var_55_11.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_55_18 = manager.ui.mainCamera.transform.position - var_55_11.position

				var_55_11.forward = Vector3.New(var_55_18.x, var_55_18.y, var_55_18.z)

				local var_55_19 = var_55_11.localEulerAngles

				var_55_19.z = 0
				var_55_19.x = 0
				var_55_11.localEulerAngles = var_55_19
			end

			local var_55_20 = arg_52_1.actors_["1084ui_story"]
			local var_55_21 = 0

			if var_55_21 < arg_52_1.time_ and arg_52_1.time_ <= var_55_21 + arg_55_0 and not isNil(var_55_20) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_22 = 0.200000002980232

			if var_55_21 <= arg_52_1.time_ and arg_52_1.time_ < var_55_21 + var_55_22 and not isNil(var_55_20) then
				local var_55_23 = (arg_52_1.time_ - var_55_21) / var_55_22

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_20) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_21 + var_55_22 and arg_52_1.time_ < var_55_21 + var_55_22 + arg_55_0 and not isNil(var_55_20) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_55_24 = arg_52_1.actors_["1019ui_story"]
			local var_55_25 = 0

			if var_55_25 < arg_52_1.time_ and arg_52_1.time_ <= var_55_25 + arg_55_0 and not isNil(var_55_24) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = var_55_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_26 = 0.200000002980232

			if var_55_25 <= arg_52_1.time_ and arg_52_1.time_ < var_55_25 + var_55_26 and not isNil(var_55_24) then
				local var_55_27 = (arg_52_1.time_ - var_55_25) / var_55_26

				if arg_52_1.var_.characterEffect1019ui_story and not isNil(var_55_24) then
					local var_55_28 = Mathf.Lerp(0, 0.5, var_55_27)

					arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1019ui_story.fillRatio = var_55_28
				end
			end

			if arg_52_1.time_ >= var_55_25 + var_55_26 and arg_52_1.time_ < var_55_25 + var_55_26 + arg_55_0 and not isNil(var_55_24) and arg_52_1.var_.characterEffect1019ui_story then
				local var_55_29 = 0.5

				arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1019ui_story.fillRatio = var_55_29
			end

			local var_55_30 = 0

			if var_55_30 < arg_52_1.time_ and arg_52_1.time_ <= var_55_30 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_55_31 = 0

			if var_55_31 < arg_52_1.time_ and arg_52_1.time_ <= var_55_31 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_32 = 0
			local var_55_33 = 0.5

			if var_55_32 < arg_52_1.time_ and arg_52_1.time_ <= var_55_32 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_34 = arg_52_1:FormatText(StoryNameCfg[6].name)

				arg_52_1.leftNameTxt_.text = var_55_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_35 = arg_52_1:GetWordFromCfg(302031013)
				local var_55_36 = arg_52_1:FormatText(var_55_35.content)

				arg_52_1.text_.text = var_55_36

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_37 = 20
				local var_55_38 = utf8.len(var_55_36)
				local var_55_39 = var_55_37 <= 0 and var_55_33 or var_55_33 * (var_55_38 / var_55_37)

				if var_55_39 > 0 and var_55_33 < var_55_39 then
					arg_52_1.talkMaxDuration = var_55_39

					if var_55_39 + var_55_32 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_39 + var_55_32
					end
				end

				arg_52_1.text_.text = var_55_36
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031013", "story_v_out_302031.awb") ~= 0 then
					local var_55_40 = manager.audio:GetVoiceLength("story_v_out_302031", "302031013", "story_v_out_302031.awb") / 1000

					if var_55_40 + var_55_32 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_40 + var_55_32
					end

					if var_55_35.prefab_name ~= "" and arg_52_1.actors_[var_55_35.prefab_name] ~= nil then
						local var_55_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_35.prefab_name].transform, "story_v_out_302031", "302031013", "story_v_out_302031.awb")

						arg_52_1:RecordAudio("302031013", var_55_41)
						arg_52_1:RecordAudio("302031013", var_55_41)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_302031", "302031013", "story_v_out_302031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_302031", "302031013", "story_v_out_302031.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_42 = math.max(var_55_33, arg_52_1.talkMaxDuration)

			if var_55_32 <= arg_52_1.time_ and arg_52_1.time_ < var_55_32 + var_55_42 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_32) / var_55_42

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_32 + var_55_42 and arg_52_1.time_ < var_55_32 + var_55_42 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play302031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 302031014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play302031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1084ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1084ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1084ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1084ui_story.fillRatio = var_59_5
			end

			local var_59_6 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_7 = 0

			if var_59_7 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_6.localPosition
			end

			local var_59_8 = 0.001

			if var_59_7 <= arg_56_1.time_ and arg_56_1.time_ < var_59_7 + var_59_8 then
				local var_59_9 = (arg_56_1.time_ - var_59_7) / var_59_8
				local var_59_10 = Vector3.New(0, 100, 0)

				var_59_6.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_10, var_59_9)

				local var_59_11 = manager.ui.mainCamera.transform.position - var_59_6.position

				var_59_6.forward = Vector3.New(var_59_11.x, var_59_11.y, var_59_11.z)

				local var_59_12 = var_59_6.localEulerAngles

				var_59_12.z = 0
				var_59_12.x = 0
				var_59_6.localEulerAngles = var_59_12
			end

			if arg_56_1.time_ >= var_59_7 + var_59_8 and arg_56_1.time_ < var_59_7 + var_59_8 + arg_59_0 then
				var_59_6.localPosition = Vector3.New(0, 100, 0)

				local var_59_13 = manager.ui.mainCamera.transform.position - var_59_6.position

				var_59_6.forward = Vector3.New(var_59_13.x, var_59_13.y, var_59_13.z)

				local var_59_14 = var_59_6.localEulerAngles

				var_59_14.z = 0
				var_59_14.x = 0
				var_59_6.localEulerAngles = var_59_14
			end

			local var_59_15 = arg_56_1.actors_["1019ui_story"].transform
			local var_59_16 = 0

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.var_.moveOldPos1019ui_story = var_59_15.localPosition
			end

			local var_59_17 = 0.001

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_17 then
				local var_59_18 = (arg_56_1.time_ - var_59_16) / var_59_17
				local var_59_19 = Vector3.New(0, 100, 0)

				var_59_15.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1019ui_story, var_59_19, var_59_18)

				local var_59_20 = manager.ui.mainCamera.transform.position - var_59_15.position

				var_59_15.forward = Vector3.New(var_59_20.x, var_59_20.y, var_59_20.z)

				local var_59_21 = var_59_15.localEulerAngles

				var_59_21.z = 0
				var_59_21.x = 0
				var_59_15.localEulerAngles = var_59_21
			end

			if arg_56_1.time_ >= var_59_16 + var_59_17 and arg_56_1.time_ < var_59_16 + var_59_17 + arg_59_0 then
				var_59_15.localPosition = Vector3.New(0, 100, 0)

				local var_59_22 = manager.ui.mainCamera.transform.position - var_59_15.position

				var_59_15.forward = Vector3.New(var_59_22.x, var_59_22.y, var_59_22.z)

				local var_59_23 = var_59_15.localEulerAngles

				var_59_23.z = 0
				var_59_23.x = 0
				var_59_15.localEulerAngles = var_59_23
			end

			local var_59_24 = 0
			local var_59_25 = 1

			if var_59_24 < arg_56_1.time_ and arg_56_1.time_ <= var_59_24 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_26 = arg_56_1:GetWordFromCfg(302031014)
				local var_59_27 = arg_56_1:FormatText(var_59_26.content)

				arg_56_1.text_.text = var_59_27

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_28 = 40
				local var_59_29 = utf8.len(var_59_27)
				local var_59_30 = var_59_28 <= 0 and var_59_25 or var_59_25 * (var_59_29 / var_59_28)

				if var_59_30 > 0 and var_59_25 < var_59_30 then
					arg_56_1.talkMaxDuration = var_59_30

					if var_59_30 + var_59_24 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_30 + var_59_24
					end
				end

				arg_56_1.text_.text = var_59_27
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_31 = math.max(var_59_25, arg_56_1.talkMaxDuration)

			if var_59_24 <= arg_56_1.time_ and arg_56_1.time_ < var_59_24 + var_59_31 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_24) / var_59_31

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_24 + var_59_31 and arg_56_1.time_ < var_59_24 + var_59_31 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play302031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 302031015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play302031016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 1.825

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(302031015)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 73
				local var_63_5 = utf8.len(var_63_3)
				local var_63_6 = var_63_4 <= 0 and var_63_1 or var_63_1 * (var_63_5 / var_63_4)

				if var_63_6 > 0 and var_63_1 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_7 and arg_60_1.time_ < var_63_0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play302031016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 302031016
		arg_64_1.duration_ = 10.97

		local var_64_0 = {
			zh = 9.233,
			ja = 10.966
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
				arg_64_0:Play302031017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1019ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1019ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1019ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1019ui_story"]
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 and not isNil(var_67_9) then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11

				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_9) then
					arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1019ui_story then
				arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_67_13 = 0

			if var_67_13 < arg_64_1.time_ and arg_64_1.time_ <= var_67_13 + arg_67_0 then
				arg_64_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_15 = 0
			local var_67_16 = 1.225

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_17 = arg_64_1:FormatText(StoryNameCfg[13].name)

				arg_64_1.leftNameTxt_.text = var_67_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_18 = arg_64_1:GetWordFromCfg(302031016)
				local var_67_19 = arg_64_1:FormatText(var_67_18.content)

				arg_64_1.text_.text = var_67_19

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_20 = 49
				local var_67_21 = utf8.len(var_67_19)
				local var_67_22 = var_67_20 <= 0 and var_67_16 or var_67_16 * (var_67_21 / var_67_20)

				if var_67_22 > 0 and var_67_16 < var_67_22 then
					arg_64_1.talkMaxDuration = var_67_22

					if var_67_22 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_22 + var_67_15
					end
				end

				arg_64_1.text_.text = var_67_19
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031016", "story_v_out_302031.awb") ~= 0 then
					local var_67_23 = manager.audio:GetVoiceLength("story_v_out_302031", "302031016", "story_v_out_302031.awb") / 1000

					if var_67_23 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_15
					end

					if var_67_18.prefab_name ~= "" and arg_64_1.actors_[var_67_18.prefab_name] ~= nil then
						local var_67_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_18.prefab_name].transform, "story_v_out_302031", "302031016", "story_v_out_302031.awb")

						arg_64_1:RecordAudio("302031016", var_67_24)
						arg_64_1:RecordAudio("302031016", var_67_24)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_302031", "302031016", "story_v_out_302031.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_302031", "302031016", "story_v_out_302031.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_25 = math.max(var_67_16, arg_64_1.talkMaxDuration)

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_25 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_15) / var_67_25

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_15 + var_67_25 and arg_64_1.time_ < var_67_15 + var_67_25 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play302031017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 302031017
		arg_68_1.duration_ = 7.3

		local var_68_0 = {
			zh = 5.266,
			ja = 7.3
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
				arg_68_0:Play302031018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_71_2 = 0
			local var_71_3 = 0.7

			if var_71_2 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_4 = arg_68_1:FormatText(StoryNameCfg[13].name)

				arg_68_1.leftNameTxt_.text = var_71_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_5 = arg_68_1:GetWordFromCfg(302031017)
				local var_71_6 = arg_68_1:FormatText(var_71_5.content)

				arg_68_1.text_.text = var_71_6

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 28
				local var_71_8 = utf8.len(var_71_6)
				local var_71_9 = var_71_7 <= 0 and var_71_3 or var_71_3 * (var_71_8 / var_71_7)

				if var_71_9 > 0 and var_71_3 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_6
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031017", "story_v_out_302031.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031017", "story_v_out_302031.awb") / 1000

					if var_71_10 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_2
					end

					if var_71_5.prefab_name ~= "" and arg_68_1.actors_[var_71_5.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_5.prefab_name].transform, "story_v_out_302031", "302031017", "story_v_out_302031.awb")

						arg_68_1:RecordAudio("302031017", var_71_11)
						arg_68_1:RecordAudio("302031017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_302031", "302031017", "story_v_out_302031.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_302031", "302031017", "story_v_out_302031.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_12 and arg_68_1.time_ < var_71_2 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play302031018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 302031018
		arg_72_1.duration_ = 2.27

		local var_72_0 = {
			zh = 2.266,
			ja = 1.999999999999
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
				arg_72_0:Play302031019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = "1080ui_story"

			if arg_72_1.actors_[var_75_0] == nil then
				local var_75_1 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_75_1) then
					local var_75_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_72_1.stage_.transform)

					var_75_2.name = var_75_0
					var_75_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_72_1.actors_[var_75_0] = var_75_2

					local var_75_3 = var_75_2:GetComponentInChildren(typeof(CharacterEffect))

					var_75_3.enabled = true

					local var_75_4 = GameObjectTools.GetOrAddComponent(var_75_2, typeof(DynamicBoneHelper))

					if var_75_4 then
						var_75_4:EnableDynamicBone(false)
					end

					arg_72_1:ShowWeapon(var_75_3.transform, false)

					arg_72_1.var_[var_75_0 .. "Animator"] = var_75_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_72_1.var_[var_75_0 .. "Animator"].applyRootMotion = true
					arg_72_1.var_[var_75_0 .. "LipSync"] = var_75_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_75_5 = arg_72_1.actors_["1080ui_story"].transform
			local var_75_6 = 0

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.var_.moveOldPos1080ui_story = var_75_5.localPosition
			end

			local var_75_7 = 0.001

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_7 then
				local var_75_8 = (arg_72_1.time_ - var_75_6) / var_75_7
				local var_75_9 = Vector3.New(0.7, -1.01, -6.05)

				var_75_5.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1080ui_story, var_75_9, var_75_8)

				local var_75_10 = manager.ui.mainCamera.transform.position - var_75_5.position

				var_75_5.forward = Vector3.New(var_75_10.x, var_75_10.y, var_75_10.z)

				local var_75_11 = var_75_5.localEulerAngles

				var_75_11.z = 0
				var_75_11.x = 0
				var_75_5.localEulerAngles = var_75_11
			end

			if arg_72_1.time_ >= var_75_6 + var_75_7 and arg_72_1.time_ < var_75_6 + var_75_7 + arg_75_0 then
				var_75_5.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_75_12 = manager.ui.mainCamera.transform.position - var_75_5.position

				var_75_5.forward = Vector3.New(var_75_12.x, var_75_12.y, var_75_12.z)

				local var_75_13 = var_75_5.localEulerAngles

				var_75_13.z = 0
				var_75_13.x = 0
				var_75_5.localEulerAngles = var_75_13
			end

			local var_75_14 = arg_72_1.actors_["1019ui_story"].transform
			local var_75_15 = 0

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.var_.moveOldPos1019ui_story = var_75_14.localPosition
			end

			local var_75_16 = 0.001

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_16 then
				local var_75_17 = (arg_72_1.time_ - var_75_15) / var_75_16
				local var_75_18 = Vector3.New(-0.7, -1.08, -5.9)

				var_75_14.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1019ui_story, var_75_18, var_75_17)

				local var_75_19 = manager.ui.mainCamera.transform.position - var_75_14.position

				var_75_14.forward = Vector3.New(var_75_19.x, var_75_19.y, var_75_19.z)

				local var_75_20 = var_75_14.localEulerAngles

				var_75_20.z = 0
				var_75_20.x = 0
				var_75_14.localEulerAngles = var_75_20
			end

			if arg_72_1.time_ >= var_75_15 + var_75_16 and arg_72_1.time_ < var_75_15 + var_75_16 + arg_75_0 then
				var_75_14.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_75_21 = manager.ui.mainCamera.transform.position - var_75_14.position

				var_75_14.forward = Vector3.New(var_75_21.x, var_75_21.y, var_75_21.z)

				local var_75_22 = var_75_14.localEulerAngles

				var_75_22.z = 0
				var_75_22.x = 0
				var_75_14.localEulerAngles = var_75_22
			end

			local var_75_23 = arg_72_1.actors_["1080ui_story"]
			local var_75_24 = 0

			if var_75_24 < arg_72_1.time_ and arg_72_1.time_ <= var_75_24 + arg_75_0 and not isNil(var_75_23) and arg_72_1.var_.characterEffect1080ui_story == nil then
				arg_72_1.var_.characterEffect1080ui_story = var_75_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_25 = 0.200000002980232

			if var_75_24 <= arg_72_1.time_ and arg_72_1.time_ < var_75_24 + var_75_25 and not isNil(var_75_23) then
				local var_75_26 = (arg_72_1.time_ - var_75_24) / var_75_25

				if arg_72_1.var_.characterEffect1080ui_story and not isNil(var_75_23) then
					arg_72_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_24 + var_75_25 and arg_72_1.time_ < var_75_24 + var_75_25 + arg_75_0 and not isNil(var_75_23) and arg_72_1.var_.characterEffect1080ui_story then
				arg_72_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_75_27 = arg_72_1.actors_["1019ui_story"]
			local var_75_28 = 0

			if var_75_28 < arg_72_1.time_ and arg_72_1.time_ <= var_75_28 + arg_75_0 and not isNil(var_75_27) and arg_72_1.var_.characterEffect1019ui_story == nil then
				arg_72_1.var_.characterEffect1019ui_story = var_75_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_29 = 0.200000002980232

			if var_75_28 <= arg_72_1.time_ and arg_72_1.time_ < var_75_28 + var_75_29 and not isNil(var_75_27) then
				local var_75_30 = (arg_72_1.time_ - var_75_28) / var_75_29

				if arg_72_1.var_.characterEffect1019ui_story and not isNil(var_75_27) then
					local var_75_31 = Mathf.Lerp(0, 0.5, var_75_30)

					arg_72_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1019ui_story.fillRatio = var_75_31
				end
			end

			if arg_72_1.time_ >= var_75_28 + var_75_29 and arg_72_1.time_ < var_75_28 + var_75_29 + arg_75_0 and not isNil(var_75_27) and arg_72_1.var_.characterEffect1019ui_story then
				local var_75_32 = 0.5

				arg_72_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1019ui_story.fillRatio = var_75_32
			end

			local var_75_33 = 0

			if var_75_33 < arg_72_1.time_ and arg_72_1.time_ <= var_75_33 + arg_75_0 then
				arg_72_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			local var_75_34 = 0

			if var_75_34 < arg_72_1.time_ and arg_72_1.time_ <= var_75_34 + arg_75_0 then
				arg_72_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_75_35 = 0
			local var_75_36 = 0.225

			if var_75_35 < arg_72_1.time_ and arg_72_1.time_ <= var_75_35 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_37 = arg_72_1:FormatText(StoryNameCfg[55].name)

				arg_72_1.leftNameTxt_.text = var_75_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_38 = arg_72_1:GetWordFromCfg(302031018)
				local var_75_39 = arg_72_1:FormatText(var_75_38.content)

				arg_72_1.text_.text = var_75_39

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_40 = 9
				local var_75_41 = utf8.len(var_75_39)
				local var_75_42 = var_75_40 <= 0 and var_75_36 or var_75_36 * (var_75_41 / var_75_40)

				if var_75_42 > 0 and var_75_36 < var_75_42 then
					arg_72_1.talkMaxDuration = var_75_42

					if var_75_42 + var_75_35 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_42 + var_75_35
					end
				end

				arg_72_1.text_.text = var_75_39
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031018", "story_v_out_302031.awb") ~= 0 then
					local var_75_43 = manager.audio:GetVoiceLength("story_v_out_302031", "302031018", "story_v_out_302031.awb") / 1000

					if var_75_43 + var_75_35 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_43 + var_75_35
					end

					if var_75_38.prefab_name ~= "" and arg_72_1.actors_[var_75_38.prefab_name] ~= nil then
						local var_75_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_38.prefab_name].transform, "story_v_out_302031", "302031018", "story_v_out_302031.awb")

						arg_72_1:RecordAudio("302031018", var_75_44)
						arg_72_1:RecordAudio("302031018", var_75_44)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_302031", "302031018", "story_v_out_302031.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_302031", "302031018", "story_v_out_302031.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_45 = math.max(var_75_36, arg_72_1.talkMaxDuration)

			if var_75_35 <= arg_72_1.time_ and arg_72_1.time_ < var_75_35 + var_75_45 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_35) / var_75_45

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_35 + var_75_45 and arg_72_1.time_ < var_75_35 + var_75_45 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play302031019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 302031019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play302031020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1080ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1080ui_story == nil then
				arg_76_1.var_.characterEffect1080ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1080ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1080ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1080ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1080ui_story.fillRatio = var_79_5
			end

			local var_79_6 = 0
			local var_79_7 = 0.2

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_9 = arg_76_1:GetWordFromCfg(302031019)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 8
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play302031020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 302031020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play302031021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1080ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1080ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0, 100, 0)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1080ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, 100, 0)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["1019ui_story"].transform
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.var_.moveOldPos1019ui_story = var_83_9.localPosition
			end

			local var_83_11 = 0.001

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11
				local var_83_13 = Vector3.New(0, 100, 0)

				var_83_9.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1019ui_story, var_83_13, var_83_12)

				local var_83_14 = manager.ui.mainCamera.transform.position - var_83_9.position

				var_83_9.forward = Vector3.New(var_83_14.x, var_83_14.y, var_83_14.z)

				local var_83_15 = var_83_9.localEulerAngles

				var_83_15.z = 0
				var_83_15.x = 0
				var_83_9.localEulerAngles = var_83_15
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 then
				var_83_9.localPosition = Vector3.New(0, 100, 0)

				local var_83_16 = manager.ui.mainCamera.transform.position - var_83_9.position

				var_83_9.forward = Vector3.New(var_83_16.x, var_83_16.y, var_83_16.z)

				local var_83_17 = var_83_9.localEulerAngles

				var_83_17.z = 0
				var_83_17.x = 0
				var_83_9.localEulerAngles = var_83_17
			end

			local var_83_18 = 0
			local var_83_19 = 1.55

			if var_83_18 < arg_80_1.time_ and arg_80_1.time_ <= var_83_18 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_20 = arg_80_1:GetWordFromCfg(302031020)
				local var_83_21 = arg_80_1:FormatText(var_83_20.content)

				arg_80_1.text_.text = var_83_21

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_22 = 62
				local var_83_23 = utf8.len(var_83_21)
				local var_83_24 = var_83_22 <= 0 and var_83_19 or var_83_19 * (var_83_23 / var_83_22)

				if var_83_24 > 0 and var_83_19 < var_83_24 then
					arg_80_1.talkMaxDuration = var_83_24

					if var_83_24 + var_83_18 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_24 + var_83_18
					end
				end

				arg_80_1.text_.text = var_83_21
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_25 = math.max(var_83_19, arg_80_1.talkMaxDuration)

			if var_83_18 <= arg_80_1.time_ and arg_80_1.time_ < var_83_18 + var_83_25 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_18) / var_83_25

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_18 + var_83_25 and arg_80_1.time_ < var_83_18 + var_83_25 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play302031021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 302031021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play302031022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.325

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[7].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(302031021)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 13
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_8 and arg_84_1.time_ < var_87_0 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play302031022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 302031022
		arg_88_1.duration_ = 8.97

		local var_88_0 = {
			zh = 6.1,
			ja = 8.966
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
				arg_88_0:Play302031023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = "1027ui_story"

			if arg_88_1.actors_[var_91_0] == nil then
				local var_91_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_91_1) then
					local var_91_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_88_1.stage_.transform)

					var_91_2.name = var_91_0
					var_91_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_88_1.actors_[var_91_0] = var_91_2

					local var_91_3 = var_91_2:GetComponentInChildren(typeof(CharacterEffect))

					var_91_3.enabled = true

					local var_91_4 = GameObjectTools.GetOrAddComponent(var_91_2, typeof(DynamicBoneHelper))

					if var_91_4 then
						var_91_4:EnableDynamicBone(false)
					end

					arg_88_1:ShowWeapon(var_91_3.transform, false)

					arg_88_1.var_[var_91_0 .. "Animator"] = var_91_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_88_1.var_[var_91_0 .. "Animator"].applyRootMotion = true
					arg_88_1.var_[var_91_0 .. "LipSync"] = var_91_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_91_5 = arg_88_1.actors_["1027ui_story"].transform
			local var_91_6 = 0

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.var_.moveOldPos1027ui_story = var_91_5.localPosition
			end

			local var_91_7 = 0.001

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_7 then
				local var_91_8 = (arg_88_1.time_ - var_91_6) / var_91_7
				local var_91_9 = Vector3.New(-0.7, -0.81, -5.8)

				var_91_5.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1027ui_story, var_91_9, var_91_8)

				local var_91_10 = manager.ui.mainCamera.transform.position - var_91_5.position

				var_91_5.forward = Vector3.New(var_91_10.x, var_91_10.y, var_91_10.z)

				local var_91_11 = var_91_5.localEulerAngles

				var_91_11.z = 0
				var_91_11.x = 0
				var_91_5.localEulerAngles = var_91_11
			end

			if arg_88_1.time_ >= var_91_6 + var_91_7 and arg_88_1.time_ < var_91_6 + var_91_7 + arg_91_0 then
				var_91_5.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_91_12 = manager.ui.mainCamera.transform.position - var_91_5.position

				var_91_5.forward = Vector3.New(var_91_12.x, var_91_12.y, var_91_12.z)

				local var_91_13 = var_91_5.localEulerAngles

				var_91_13.z = 0
				var_91_13.x = 0
				var_91_5.localEulerAngles = var_91_13
			end

			local var_91_14 = arg_88_1.actors_["1027ui_story"]
			local var_91_15 = 0

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 and not isNil(var_91_14) and arg_88_1.var_.characterEffect1027ui_story == nil then
				arg_88_1.var_.characterEffect1027ui_story = var_91_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_16 = 0.200000002980232

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_16 and not isNil(var_91_14) then
				local var_91_17 = (arg_88_1.time_ - var_91_15) / var_91_16

				if arg_88_1.var_.characterEffect1027ui_story and not isNil(var_91_14) then
					arg_88_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_15 + var_91_16 and arg_88_1.time_ < var_91_15 + var_91_16 + arg_91_0 and not isNil(var_91_14) and arg_88_1.var_.characterEffect1027ui_story then
				arg_88_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_91_18 = 0

			if var_91_18 < arg_88_1.time_ and arg_88_1.time_ <= var_91_18 + arg_91_0 then
				arg_88_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			local var_91_19 = 0

			if var_91_19 < arg_88_1.time_ and arg_88_1.time_ <= var_91_19 + arg_91_0 then
				arg_88_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_91_20 = 0
			local var_91_21 = 0.7

			if var_91_20 < arg_88_1.time_ and arg_88_1.time_ <= var_91_20 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_22 = arg_88_1:FormatText(StoryNameCfg[56].name)

				arg_88_1.leftNameTxt_.text = var_91_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_23 = arg_88_1:GetWordFromCfg(302031022)
				local var_91_24 = arg_88_1:FormatText(var_91_23.content)

				arg_88_1.text_.text = var_91_24

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_25 = 28
				local var_91_26 = utf8.len(var_91_24)
				local var_91_27 = var_91_25 <= 0 and var_91_21 or var_91_21 * (var_91_26 / var_91_25)

				if var_91_27 > 0 and var_91_21 < var_91_27 then
					arg_88_1.talkMaxDuration = var_91_27

					if var_91_27 + var_91_20 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_27 + var_91_20
					end
				end

				arg_88_1.text_.text = var_91_24
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031022", "story_v_out_302031.awb") ~= 0 then
					local var_91_28 = manager.audio:GetVoiceLength("story_v_out_302031", "302031022", "story_v_out_302031.awb") / 1000

					if var_91_28 + var_91_20 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_28 + var_91_20
					end

					if var_91_23.prefab_name ~= "" and arg_88_1.actors_[var_91_23.prefab_name] ~= nil then
						local var_91_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_23.prefab_name].transform, "story_v_out_302031", "302031022", "story_v_out_302031.awb")

						arg_88_1:RecordAudio("302031022", var_91_29)
						arg_88_1:RecordAudio("302031022", var_91_29)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_302031", "302031022", "story_v_out_302031.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_302031", "302031022", "story_v_out_302031.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_30 = math.max(var_91_21, arg_88_1.talkMaxDuration)

			if var_91_20 <= arg_88_1.time_ and arg_88_1.time_ < var_91_20 + var_91_30 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_20) / var_91_30

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_20 + var_91_30 and arg_88_1.time_ < var_91_20 + var_91_30 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play302031023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 302031023
		arg_92_1.duration_ = 8

		local var_92_0 = {
			zh = 7.1,
			ja = 8
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
				arg_92_0:Play302031024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1084ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(0.7, -0.97, -6)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = arg_92_1.actors_["1084ui_story"]
			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_11 = 0.200000002980232

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_11 and not isNil(var_95_9) then
				local var_95_12 = (arg_92_1.time_ - var_95_10) / var_95_11

				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_9) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_10 + var_95_11 and arg_92_1.time_ < var_95_10 + var_95_11 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_95_13 = arg_92_1.actors_["1027ui_story"]
			local var_95_14 = 0

			if var_95_14 < arg_92_1.time_ and arg_92_1.time_ <= var_95_14 + arg_95_0 and not isNil(var_95_13) and arg_92_1.var_.characterEffect1027ui_story == nil then
				arg_92_1.var_.characterEffect1027ui_story = var_95_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_15 = 0.200000002980232

			if var_95_14 <= arg_92_1.time_ and arg_92_1.time_ < var_95_14 + var_95_15 and not isNil(var_95_13) then
				local var_95_16 = (arg_92_1.time_ - var_95_14) / var_95_15

				if arg_92_1.var_.characterEffect1027ui_story and not isNil(var_95_13) then
					local var_95_17 = Mathf.Lerp(0, 0.5, var_95_16)

					arg_92_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1027ui_story.fillRatio = var_95_17
				end
			end

			if arg_92_1.time_ >= var_95_14 + var_95_15 and arg_92_1.time_ < var_95_14 + var_95_15 + arg_95_0 and not isNil(var_95_13) and arg_92_1.var_.characterEffect1027ui_story then
				local var_95_18 = 0.5

				arg_92_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1027ui_story.fillRatio = var_95_18
			end

			local var_95_19 = 0

			if var_95_19 < arg_92_1.time_ and arg_92_1.time_ <= var_95_19 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_95_20 = 0

			if var_95_20 < arg_92_1.time_ and arg_92_1.time_ <= var_95_20 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_95_21 = 0
			local var_95_22 = 0.925

			if var_95_21 < arg_92_1.time_ and arg_92_1.time_ <= var_95_21 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_23 = arg_92_1:FormatText(StoryNameCfg[6].name)

				arg_92_1.leftNameTxt_.text = var_95_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_24 = arg_92_1:GetWordFromCfg(302031023)
				local var_95_25 = arg_92_1:FormatText(var_95_24.content)

				arg_92_1.text_.text = var_95_25

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_26 = 37
				local var_95_27 = utf8.len(var_95_25)
				local var_95_28 = var_95_26 <= 0 and var_95_22 or var_95_22 * (var_95_27 / var_95_26)

				if var_95_28 > 0 and var_95_22 < var_95_28 then
					arg_92_1.talkMaxDuration = var_95_28

					if var_95_28 + var_95_21 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_28 + var_95_21
					end
				end

				arg_92_1.text_.text = var_95_25
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031023", "story_v_out_302031.awb") ~= 0 then
					local var_95_29 = manager.audio:GetVoiceLength("story_v_out_302031", "302031023", "story_v_out_302031.awb") / 1000

					if var_95_29 + var_95_21 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_29 + var_95_21
					end

					if var_95_24.prefab_name ~= "" and arg_92_1.actors_[var_95_24.prefab_name] ~= nil then
						local var_95_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_24.prefab_name].transform, "story_v_out_302031", "302031023", "story_v_out_302031.awb")

						arg_92_1:RecordAudio("302031023", var_95_30)
						arg_92_1:RecordAudio("302031023", var_95_30)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_302031", "302031023", "story_v_out_302031.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_302031", "302031023", "story_v_out_302031.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_31 = math.max(var_95_22, arg_92_1.talkMaxDuration)

			if var_95_21 <= arg_92_1.time_ and arg_92_1.time_ < var_95_21 + var_95_31 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_21) / var_95_31

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_21 + var_95_31 and arg_92_1.time_ < var_95_21 + var_95_31 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play302031024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 302031024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play302031025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1084ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1084ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1084ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_2")
			end

			local var_99_7 = 0
			local var_99_8 = 0.325

			if var_99_7 < arg_96_1.time_ and arg_96_1.time_ <= var_99_7 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_9 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_10 = arg_96_1:GetWordFromCfg(302031024)
				local var_99_11 = arg_96_1:FormatText(var_99_10.content)

				arg_96_1.text_.text = var_99_11

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_12 = 13
				local var_99_13 = utf8.len(var_99_11)
				local var_99_14 = var_99_12 <= 0 and var_99_8 or var_99_8 * (var_99_13 / var_99_12)

				if var_99_14 > 0 and var_99_8 < var_99_14 then
					arg_96_1.talkMaxDuration = var_99_14

					if var_99_14 + var_99_7 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_7
					end
				end

				arg_96_1.text_.text = var_99_11
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_15 = math.max(var_99_8, arg_96_1.talkMaxDuration)

			if var_99_7 <= arg_96_1.time_ and arg_96_1.time_ < var_99_7 + var_99_15 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_7) / var_99_15

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_7 + var_99_15 and arg_96_1.time_ < var_99_7 + var_99_15 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play302031025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 302031025
		arg_100_1.duration_ = 6.77

		local var_100_0 = {
			zh = 5.033,
			ja = 6.766
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
				arg_100_0:Play302031026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1084ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1084ui_story == nil then
				arg_100_1.var_.characterEffect1084ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1084ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1084ui_story then
				arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_103_4 = 0

			if var_103_4 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_103_6 = 0
			local var_103_7 = 0.525

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[6].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_9 = arg_100_1:GetWordFromCfg(302031025)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 21
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031025", "story_v_out_302031.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031025", "story_v_out_302031.awb") / 1000

					if var_103_14 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_6
					end

					if var_103_9.prefab_name ~= "" and arg_100_1.actors_[var_103_9.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_9.prefab_name].transform, "story_v_out_302031", "302031025", "story_v_out_302031.awb")

						arg_100_1:RecordAudio("302031025", var_103_15)
						arg_100_1:RecordAudio("302031025", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_302031", "302031025", "story_v_out_302031.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_302031", "302031025", "story_v_out_302031.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_16 and arg_100_1.time_ < var_103_6 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play302031026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 302031026
		arg_104_1.duration_ = 9.8

		local var_104_0 = {
			zh = 5.033,
			ja = 9.8
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play302031027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_2 = 0
			local var_107_3 = 0.55

			if var_107_2 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_4 = arg_104_1:FormatText(StoryNameCfg[6].name)

				arg_104_1.leftNameTxt_.text = var_107_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_5 = arg_104_1:GetWordFromCfg(302031026)
				local var_107_6 = arg_104_1:FormatText(var_107_5.content)

				arg_104_1.text_.text = var_107_6

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 22
				local var_107_8 = utf8.len(var_107_6)
				local var_107_9 = var_107_7 <= 0 and var_107_3 or var_107_3 * (var_107_8 / var_107_7)

				if var_107_9 > 0 and var_107_3 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_6
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031026", "story_v_out_302031.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031026", "story_v_out_302031.awb") / 1000

					if var_107_10 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_2
					end

					if var_107_5.prefab_name ~= "" and arg_104_1.actors_[var_107_5.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_5.prefab_name].transform, "story_v_out_302031", "302031026", "story_v_out_302031.awb")

						arg_104_1:RecordAudio("302031026", var_107_11)
						arg_104_1:RecordAudio("302031026", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_302031", "302031026", "story_v_out_302031.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_302031", "302031026", "story_v_out_302031.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_12 and arg_104_1.time_ < var_107_2 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play302031027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 302031027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play302031028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1084ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1084ui_story == nil then
				arg_108_1.var_.characterEffect1084ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1084ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1084ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1084ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1084ui_story.fillRatio = var_111_5
			end

			local var_111_6 = 0
			local var_111_7 = 0.65

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[7].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_9 = arg_108_1:GetWordFromCfg(302031027)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 26
				local var_111_12 = utf8.len(var_111_10)
				local var_111_13 = var_111_11 <= 0 and var_111_7 or var_111_7 * (var_111_12 / var_111_11)

				if var_111_13 > 0 and var_111_7 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_10
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_14 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_14 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_14

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_14 and arg_108_1.time_ < var_111_6 + var_111_14 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play302031028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 302031028
		arg_112_1.duration_ = 5.87

		local var_112_0 = {
			zh = 5.4,
			ja = 5.866
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
				arg_112_0:Play302031029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1084ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1084ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1084ui_story then
				arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_115_4 = 0

			if var_115_4 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_115_6 = 0
			local var_115_7 = 0.725

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_8 = arg_112_1:FormatText(StoryNameCfg[6].name)

				arg_112_1.leftNameTxt_.text = var_115_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_9 = arg_112_1:GetWordFromCfg(302031028)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 29
				local var_115_12 = utf8.len(var_115_10)
				local var_115_13 = var_115_11 <= 0 and var_115_7 or var_115_7 * (var_115_12 / var_115_11)

				if var_115_13 > 0 and var_115_7 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031028", "story_v_out_302031.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031028", "story_v_out_302031.awb") / 1000

					if var_115_14 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_6
					end

					if var_115_9.prefab_name ~= "" and arg_112_1.actors_[var_115_9.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_9.prefab_name].transform, "story_v_out_302031", "302031028", "story_v_out_302031.awb")

						arg_112_1:RecordAudio("302031028", var_115_15)
						arg_112_1:RecordAudio("302031028", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_302031", "302031028", "story_v_out_302031.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_302031", "302031028", "story_v_out_302031.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_16 and arg_112_1.time_ < var_115_6 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play302031029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 302031029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play302031030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1084ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1084ui_story == nil then
				arg_116_1.var_.characterEffect1084ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1084ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1084ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1084ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1084ui_story.fillRatio = var_119_5
			end

			local var_119_6 = 0
			local var_119_7 = 0.35

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_9 = arg_116_1:GetWordFromCfg(302031029)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 14
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_14 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_14 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_14

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_14 and arg_116_1.time_ < var_119_6 + var_119_14 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play302031030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 302031030
		arg_120_1.duration_ = 6.9

		local var_120_0 = {
			zh = 6.9,
			ja = 5.4
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
				arg_120_0:Play302031031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1027ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1027ui_story == nil then
				arg_120_1.var_.characterEffect1027ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1027ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1027ui_story then
				arg_120_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_123_4 = 0

			if var_123_4 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_6 = 0
			local var_123_7 = 0.85

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[56].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_9 = arg_120_1:GetWordFromCfg(302031030)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 34
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031030", "story_v_out_302031.awb") ~= 0 then
					local var_123_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031030", "story_v_out_302031.awb") / 1000

					if var_123_14 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_6
					end

					if var_123_9.prefab_name ~= "" and arg_120_1.actors_[var_123_9.prefab_name] ~= nil then
						local var_123_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_9.prefab_name].transform, "story_v_out_302031", "302031030", "story_v_out_302031.awb")

						arg_120_1:RecordAudio("302031030", var_123_15)
						arg_120_1:RecordAudio("302031030", var_123_15)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_302031", "302031030", "story_v_out_302031.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_302031", "302031030", "story_v_out_302031.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_16 and arg_120_1.time_ < var_123_6 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play302031031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 302031031
		arg_124_1.duration_ = 1

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"

			SetActive(arg_124_1.choicesGo_, true)

			for iter_125_0, iter_125_1 in ipairs(arg_124_1.choices_) do
				local var_125_0 = iter_125_0 <= 2

				SetActive(iter_125_1.go, var_125_0)
			end

			arg_124_1.choices_[1].txt.text = arg_124_1:FormatText(StoryChoiceCfg[1732].name)
			arg_124_1.choices_[2].txt.text = arg_124_1:FormatText(StoryChoiceCfg[1733].name)
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play302031032(arg_124_1)
			end

			if arg_126_0 == 2 then
				arg_124_0:Play302031034(arg_124_1)
			end

			arg_124_1:RecordChoiceLog(302031031, 1732, 1733)
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.allBtn_.enabled = false
			end

			local var_127_1 = 1

			if arg_124_1.time_ >= var_127_0 + var_127_1 and arg_124_1.time_ < var_127_0 + var_127_1 + arg_127_0 then
				arg_124_1.allBtn_.enabled = true
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play302031032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 302031032
		arg_128_1.duration_ = 8.27

		local var_128_0 = {
			zh = 5.5,
			ja = 8.266
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
				arg_128_0:Play302031033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1027ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1027ui_story == nil then
				arg_128_1.var_.characterEffect1027ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1027ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1027ui_story then
				arg_128_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_131_4 = 0

			if var_131_4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_131_6 = 0
			local var_131_7 = 0.675

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_8 = arg_128_1:FormatText(StoryNameCfg[56].name)

				arg_128_1.leftNameTxt_.text = var_131_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_9 = arg_128_1:GetWordFromCfg(302031032)
				local var_131_10 = arg_128_1:FormatText(var_131_9.content)

				arg_128_1.text_.text = var_131_10

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 27
				local var_131_12 = utf8.len(var_131_10)
				local var_131_13 = var_131_11 <= 0 and var_131_7 or var_131_7 * (var_131_12 / var_131_11)

				if var_131_13 > 0 and var_131_7 < var_131_13 then
					arg_128_1.talkMaxDuration = var_131_13

					if var_131_13 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_10
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031032", "story_v_out_302031.awb") ~= 0 then
					local var_131_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031032", "story_v_out_302031.awb") / 1000

					if var_131_14 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_14 + var_131_6
					end

					if var_131_9.prefab_name ~= "" and arg_128_1.actors_[var_131_9.prefab_name] ~= nil then
						local var_131_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_9.prefab_name].transform, "story_v_out_302031", "302031032", "story_v_out_302031.awb")

						arg_128_1:RecordAudio("302031032", var_131_15)
						arg_128_1:RecordAudio("302031032", var_131_15)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_302031", "302031032", "story_v_out_302031.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_302031", "302031032", "story_v_out_302031.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_16 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_16 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_16

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_16 and arg_128_1.time_ < var_131_6 + var_131_16 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play302031033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 302031033
		arg_132_1.duration_ = 7.83

		local var_132_0 = {
			zh = 7.833,
			ja = 6
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play302031036(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.975

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[56].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(302031033)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 39
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031033", "story_v_out_302031.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_302031", "302031033", "story_v_out_302031.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_302031", "302031033", "story_v_out_302031.awb")

						arg_132_1:RecordAudio("302031033", var_135_9)
						arg_132_1:RecordAudio("302031033", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_302031", "302031033", "story_v_out_302031.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_302031", "302031033", "story_v_out_302031.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play302031036 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 302031036
		arg_136_1.duration_ = 5.6

		local var_136_0 = {
			zh = 4.066,
			ja = 5.6
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
				arg_136_0:Play302031037(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1084ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos1084ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0, 100, 0)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1084ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, 100, 0)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = arg_136_1.actors_["1019ui_story"].transform
			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1.var_.moveOldPos1019ui_story = var_139_9.localPosition
			end

			local var_139_11 = 0.001

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_11 then
				local var_139_12 = (arg_136_1.time_ - var_139_10) / var_139_11
				local var_139_13 = Vector3.New(0.7, -1.08, -5.9)

				var_139_9.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1019ui_story, var_139_13, var_139_12)

				local var_139_14 = manager.ui.mainCamera.transform.position - var_139_9.position

				var_139_9.forward = Vector3.New(var_139_14.x, var_139_14.y, var_139_14.z)

				local var_139_15 = var_139_9.localEulerAngles

				var_139_15.z = 0
				var_139_15.x = 0
				var_139_9.localEulerAngles = var_139_15
			end

			if arg_136_1.time_ >= var_139_10 + var_139_11 and arg_136_1.time_ < var_139_10 + var_139_11 + arg_139_0 then
				var_139_9.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_139_16 = manager.ui.mainCamera.transform.position - var_139_9.position

				var_139_9.forward = Vector3.New(var_139_16.x, var_139_16.y, var_139_16.z)

				local var_139_17 = var_139_9.localEulerAngles

				var_139_17.z = 0
				var_139_17.x = 0
				var_139_9.localEulerAngles = var_139_17
			end

			local var_139_18 = arg_136_1.actors_["1019ui_story"]
			local var_139_19 = 0

			if var_139_19 < arg_136_1.time_ and arg_136_1.time_ <= var_139_19 + arg_139_0 and not isNil(var_139_18) and arg_136_1.var_.characterEffect1019ui_story == nil then
				arg_136_1.var_.characterEffect1019ui_story = var_139_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_20 = 0.200000002980232

			if var_139_19 <= arg_136_1.time_ and arg_136_1.time_ < var_139_19 + var_139_20 and not isNil(var_139_18) then
				local var_139_21 = (arg_136_1.time_ - var_139_19) / var_139_20

				if arg_136_1.var_.characterEffect1019ui_story and not isNil(var_139_18) then
					arg_136_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_19 + var_139_20 and arg_136_1.time_ < var_139_19 + var_139_20 + arg_139_0 and not isNil(var_139_18) and arg_136_1.var_.characterEffect1019ui_story then
				arg_136_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_139_22 = arg_136_1.actors_["1027ui_story"]
			local var_139_23 = 0

			if var_139_23 < arg_136_1.time_ and arg_136_1.time_ <= var_139_23 + arg_139_0 and not isNil(var_139_22) and arg_136_1.var_.characterEffect1027ui_story == nil then
				arg_136_1.var_.characterEffect1027ui_story = var_139_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_24 = 0.200000002980232

			if var_139_23 <= arg_136_1.time_ and arg_136_1.time_ < var_139_23 + var_139_24 and not isNil(var_139_22) then
				local var_139_25 = (arg_136_1.time_ - var_139_23) / var_139_24

				if arg_136_1.var_.characterEffect1027ui_story and not isNil(var_139_22) then
					local var_139_26 = Mathf.Lerp(0, 0.5, var_139_25)

					arg_136_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1027ui_story.fillRatio = var_139_26
				end
			end

			if arg_136_1.time_ >= var_139_23 + var_139_24 and arg_136_1.time_ < var_139_23 + var_139_24 + arg_139_0 and not isNil(var_139_22) and arg_136_1.var_.characterEffect1027ui_story then
				local var_139_27 = 0.5

				arg_136_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1027ui_story.fillRatio = var_139_27
			end

			local var_139_28 = 0

			if var_139_28 < arg_136_1.time_ and arg_136_1.time_ <= var_139_28 + arg_139_0 then
				arg_136_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_139_29 = 0

			if var_139_29 < arg_136_1.time_ and arg_136_1.time_ <= var_139_29 + arg_139_0 then
				arg_136_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_139_30 = 0
			local var_139_31 = 0.45

			if var_139_30 < arg_136_1.time_ and arg_136_1.time_ <= var_139_30 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_32 = arg_136_1:FormatText(StoryNameCfg[13].name)

				arg_136_1.leftNameTxt_.text = var_139_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_33 = arg_136_1:GetWordFromCfg(302031036)
				local var_139_34 = arg_136_1:FormatText(var_139_33.content)

				arg_136_1.text_.text = var_139_34

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_35 = 18
				local var_139_36 = utf8.len(var_139_34)
				local var_139_37 = var_139_35 <= 0 and var_139_31 or var_139_31 * (var_139_36 / var_139_35)

				if var_139_37 > 0 and var_139_31 < var_139_37 then
					arg_136_1.talkMaxDuration = var_139_37

					if var_139_37 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_37 + var_139_30
					end
				end

				arg_136_1.text_.text = var_139_34
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031036", "story_v_out_302031.awb") ~= 0 then
					local var_139_38 = manager.audio:GetVoiceLength("story_v_out_302031", "302031036", "story_v_out_302031.awb") / 1000

					if var_139_38 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_38 + var_139_30
					end

					if var_139_33.prefab_name ~= "" and arg_136_1.actors_[var_139_33.prefab_name] ~= nil then
						local var_139_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_33.prefab_name].transform, "story_v_out_302031", "302031036", "story_v_out_302031.awb")

						arg_136_1:RecordAudio("302031036", var_139_39)
						arg_136_1:RecordAudio("302031036", var_139_39)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_302031", "302031036", "story_v_out_302031.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_302031", "302031036", "story_v_out_302031.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_40 = math.max(var_139_31, arg_136_1.talkMaxDuration)

			if var_139_30 <= arg_136_1.time_ and arg_136_1.time_ < var_139_30 + var_139_40 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_30) / var_139_40

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_30 + var_139_40 and arg_136_1.time_ < var_139_30 + var_139_40 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play302031037 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 302031037
		arg_140_1.duration_ = 6.9

		local var_140_0 = {
			zh = 3.866,
			ja = 6.9
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
				arg_140_0:Play302031038(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_143_2 = 0
			local var_143_3 = 0.5

			if var_143_2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_4 = arg_140_1:FormatText(StoryNameCfg[13].name)

				arg_140_1.leftNameTxt_.text = var_143_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_5 = arg_140_1:GetWordFromCfg(302031037)
				local var_143_6 = arg_140_1:FormatText(var_143_5.content)

				arg_140_1.text_.text = var_143_6

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 20
				local var_143_8 = utf8.len(var_143_6)
				local var_143_9 = var_143_7 <= 0 and var_143_3 or var_143_3 * (var_143_8 / var_143_7)

				if var_143_9 > 0 and var_143_3 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_6
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031037", "story_v_out_302031.awb") ~= 0 then
					local var_143_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031037", "story_v_out_302031.awb") / 1000

					if var_143_10 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_2
					end

					if var_143_5.prefab_name ~= "" and arg_140_1.actors_[var_143_5.prefab_name] ~= nil then
						local var_143_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_5.prefab_name].transform, "story_v_out_302031", "302031037", "story_v_out_302031.awb")

						arg_140_1:RecordAudio("302031037", var_143_11)
						arg_140_1:RecordAudio("302031037", var_143_11)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_302031", "302031037", "story_v_out_302031.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_302031", "302031037", "story_v_out_302031.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_12 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_12 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_12

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_12 and arg_140_1.time_ < var_143_2 + var_143_12 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play302031038 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 302031038
		arg_144_1.duration_ = 4.8

		local var_144_0 = {
			zh = 4.8,
			ja = 1.999999999999
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
				arg_144_0:Play302031039(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1166ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1166ui_story = var_147_0.localPosition

				local var_147_2 = GameObjectTools.GetOrAddComponent(var_147_0.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(false)
				end
			end

			local var_147_3 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_3 then
				local var_147_4 = (arg_144_1.time_ - var_147_1) / var_147_3
				local var_147_5 = Vector3.New(-0.7, -0.75, -6.25)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1166ui_story, var_147_5, var_147_4)

				local var_147_6 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_6.x, var_147_6.y, var_147_6.z)

				local var_147_7 = var_147_0.localEulerAngles

				var_147_7.z = 0
				var_147_7.x = 0
				var_147_0.localEulerAngles = var_147_7
			end

			if arg_144_1.time_ >= var_147_1 + var_147_3 and arg_144_1.time_ < var_147_1 + var_147_3 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(-0.7, -0.75, -6.25)

				local var_147_8 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_8.x, var_147_8.y, var_147_8.z)

				local var_147_9 = var_147_0.localEulerAngles

				var_147_9.z = 0
				var_147_9.x = 0
				var_147_0.localEulerAngles = var_147_9

				local var_147_10 = GameObjectTools.GetOrAddComponent(var_147_0.gameObject, typeof(DynamicBoneHelper))

				if var_147_10 then
					var_147_10:EnableDynamicBone(true)
				end
			end

			local var_147_11 = arg_144_1.actors_["1027ui_story"].transform
			local var_147_12 = 0

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 then
				arg_144_1.var_.moveOldPos1027ui_story = var_147_11.localPosition
			end

			local var_147_13 = 0.001

			if var_147_12 <= arg_144_1.time_ and arg_144_1.time_ < var_147_12 + var_147_13 then
				local var_147_14 = (arg_144_1.time_ - var_147_12) / var_147_13
				local var_147_15 = Vector3.New(0, 100, 0)

				var_147_11.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1027ui_story, var_147_15, var_147_14)

				local var_147_16 = manager.ui.mainCamera.transform.position - var_147_11.position

				var_147_11.forward = Vector3.New(var_147_16.x, var_147_16.y, var_147_16.z)

				local var_147_17 = var_147_11.localEulerAngles

				var_147_17.z = 0
				var_147_17.x = 0
				var_147_11.localEulerAngles = var_147_17
			end

			if arg_144_1.time_ >= var_147_12 + var_147_13 and arg_144_1.time_ < var_147_12 + var_147_13 + arg_147_0 then
				var_147_11.localPosition = Vector3.New(0, 100, 0)

				local var_147_18 = manager.ui.mainCamera.transform.position - var_147_11.position

				var_147_11.forward = Vector3.New(var_147_18.x, var_147_18.y, var_147_18.z)

				local var_147_19 = var_147_11.localEulerAngles

				var_147_19.z = 0
				var_147_19.x = 0
				var_147_11.localEulerAngles = var_147_19
			end

			local var_147_20 = arg_144_1.actors_["1166ui_story"]
			local var_147_21 = 0

			if var_147_21 < arg_144_1.time_ and arg_144_1.time_ <= var_147_21 + arg_147_0 and not isNil(var_147_20) and arg_144_1.var_.characterEffect1166ui_story == nil then
				arg_144_1.var_.characterEffect1166ui_story = var_147_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_22 = 0.200000002980232

			if var_147_21 <= arg_144_1.time_ and arg_144_1.time_ < var_147_21 + var_147_22 and not isNil(var_147_20) then
				local var_147_23 = (arg_144_1.time_ - var_147_21) / var_147_22

				if arg_144_1.var_.characterEffect1166ui_story and not isNil(var_147_20) then
					arg_144_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_21 + var_147_22 and arg_144_1.time_ < var_147_21 + var_147_22 + arg_147_0 and not isNil(var_147_20) and arg_144_1.var_.characterEffect1166ui_story then
				arg_144_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_147_24 = arg_144_1.actors_["1019ui_story"]
			local var_147_25 = 0

			if var_147_25 < arg_144_1.time_ and arg_144_1.time_ <= var_147_25 + arg_147_0 and not isNil(var_147_24) and arg_144_1.var_.characterEffect1019ui_story == nil then
				arg_144_1.var_.characterEffect1019ui_story = var_147_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_26 = 0.200000002980232

			if var_147_25 <= arg_144_1.time_ and arg_144_1.time_ < var_147_25 + var_147_26 and not isNil(var_147_24) then
				local var_147_27 = (arg_144_1.time_ - var_147_25) / var_147_26

				if arg_144_1.var_.characterEffect1019ui_story and not isNil(var_147_24) then
					local var_147_28 = Mathf.Lerp(0, 0.5, var_147_27)

					arg_144_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1019ui_story.fillRatio = var_147_28
				end
			end

			if arg_144_1.time_ >= var_147_25 + var_147_26 and arg_144_1.time_ < var_147_25 + var_147_26 + arg_147_0 and not isNil(var_147_24) and arg_144_1.var_.characterEffect1019ui_story then
				local var_147_29 = 0.5

				arg_144_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1019ui_story.fillRatio = var_147_29
			end

			local var_147_30 = 0

			if var_147_30 < arg_144_1.time_ and arg_144_1.time_ <= var_147_30 + arg_147_0 then
				arg_144_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			local var_147_31 = 0

			if var_147_31 < arg_144_1.time_ and arg_144_1.time_ <= var_147_31 + arg_147_0 then
				arg_144_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_147_32 = 0
			local var_147_33 = 1

			if var_147_32 < arg_144_1.time_ and arg_144_1.time_ <= var_147_32 + arg_147_0 then
				local var_147_34 = "play"
				local var_147_35 = "effect"

				arg_144_1:AudioAction(var_147_34, var_147_35, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_147_36 = 0
			local var_147_37 = 0.55

			if var_147_36 < arg_144_1.time_ and arg_144_1.time_ <= var_147_36 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_38 = arg_144_1:FormatText(StoryNameCfg[32].name)

				arg_144_1.leftNameTxt_.text = var_147_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_39 = arg_144_1:GetWordFromCfg(302031038)
				local var_147_40 = arg_144_1:FormatText(var_147_39.content)

				arg_144_1.text_.text = var_147_40

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_41 = 22
				local var_147_42 = utf8.len(var_147_40)
				local var_147_43 = var_147_41 <= 0 and var_147_37 or var_147_37 * (var_147_42 / var_147_41)

				if var_147_43 > 0 and var_147_37 < var_147_43 then
					arg_144_1.talkMaxDuration = var_147_43

					if var_147_43 + var_147_36 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_43 + var_147_36
					end
				end

				arg_144_1.text_.text = var_147_40
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031038", "story_v_out_302031.awb") ~= 0 then
					local var_147_44 = manager.audio:GetVoiceLength("story_v_out_302031", "302031038", "story_v_out_302031.awb") / 1000

					if var_147_44 + var_147_36 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_44 + var_147_36
					end

					if var_147_39.prefab_name ~= "" and arg_144_1.actors_[var_147_39.prefab_name] ~= nil then
						local var_147_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_39.prefab_name].transform, "story_v_out_302031", "302031038", "story_v_out_302031.awb")

						arg_144_1:RecordAudio("302031038", var_147_45)
						arg_144_1:RecordAudio("302031038", var_147_45)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_302031", "302031038", "story_v_out_302031.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_302031", "302031038", "story_v_out_302031.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_46 = math.max(var_147_37, arg_144_1.talkMaxDuration)

			if var_147_36 <= arg_144_1.time_ and arg_144_1.time_ < var_147_36 + var_147_46 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_36) / var_147_46

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_36 + var_147_46 and arg_144_1.time_ < var_147_36 + var_147_46 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play302031039 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 302031039
		arg_148_1.duration_ = 9

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play302031040(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = "I27f"

			if arg_148_1.bgs_[var_151_0] == nil then
				local var_151_1 = Object.Instantiate(arg_148_1.paintGo_)

				var_151_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_0)
				var_151_1.name = var_151_0
				var_151_1.transform.parent = arg_148_1.stage_.transform
				var_151_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_0] = var_151_1
			end

			local var_151_2 = 2

			if var_151_2 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				local var_151_3 = manager.ui.mainCamera.transform.localPosition
				local var_151_4 = Vector3.New(0, 0, 10) + Vector3.New(var_151_3.x, var_151_3.y, 0)
				local var_151_5 = arg_148_1.bgs_.I27f

				var_151_5.transform.localPosition = var_151_4
				var_151_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_6 = var_151_5:GetComponent("SpriteRenderer")

				if var_151_6 and var_151_6.sprite then
					local var_151_7 = (var_151_5.transform.localPosition - var_151_3).z
					local var_151_8 = manager.ui.mainCameraCom_
					local var_151_9 = 2 * var_151_7 * Mathf.Tan(var_151_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_151_10 = var_151_9 * var_151_8.aspect
					local var_151_11 = var_151_6.sprite.bounds.size.x
					local var_151_12 = var_151_6.sprite.bounds.size.y
					local var_151_13 = var_151_10 / var_151_11
					local var_151_14 = var_151_9 / var_151_12
					local var_151_15 = var_151_14 < var_151_13 and var_151_13 or var_151_14

					var_151_5.transform.localScale = Vector3.New(var_151_15, var_151_15, 0)
				end

				for iter_151_0, iter_151_1 in pairs(arg_148_1.bgs_) do
					if iter_151_0 ~= "I27f" then
						iter_151_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_16 = 3.999999999999

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.allBtn_.enabled = false
			end

			local var_151_17 = 0.3

			if arg_148_1.time_ >= var_151_16 + var_151_17 and arg_148_1.time_ < var_151_16 + var_151_17 + arg_151_0 then
				arg_148_1.allBtn_.enabled = true
			end

			local var_151_18 = 0

			if var_151_18 < arg_148_1.time_ and arg_148_1.time_ <= var_151_18 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_19 = 2

			if var_151_18 <= arg_148_1.time_ and arg_148_1.time_ < var_151_18 + var_151_19 then
				local var_151_20 = (arg_148_1.time_ - var_151_18) / var_151_19
				local var_151_21 = Color.New(0, 0, 0)

				var_151_21.a = Mathf.Lerp(0, 1, var_151_20)
				arg_148_1.mask_.color = var_151_21
			end

			if arg_148_1.time_ >= var_151_18 + var_151_19 and arg_148_1.time_ < var_151_18 + var_151_19 + arg_151_0 then
				local var_151_22 = Color.New(0, 0, 0)

				var_151_22.a = 1
				arg_148_1.mask_.color = var_151_22
			end

			local var_151_23 = 2

			if var_151_23 < arg_148_1.time_ and arg_148_1.time_ <= var_151_23 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_24 = 2

			if var_151_23 <= arg_148_1.time_ and arg_148_1.time_ < var_151_23 + var_151_24 then
				local var_151_25 = (arg_148_1.time_ - var_151_23) / var_151_24
				local var_151_26 = Color.New(0, 0, 0)

				var_151_26.a = Mathf.Lerp(1, 0, var_151_25)
				arg_148_1.mask_.color = var_151_26
			end

			if arg_148_1.time_ >= var_151_23 + var_151_24 and arg_148_1.time_ < var_151_23 + var_151_24 + arg_151_0 then
				local var_151_27 = Color.New(0, 0, 0)
				local var_151_28 = 0

				arg_148_1.mask_.enabled = false
				var_151_27.a = var_151_28
				arg_148_1.mask_.color = var_151_27
			end

			local var_151_29 = arg_148_1.actors_["1166ui_story"].transform
			local var_151_30 = 1.96599999815226

			if var_151_30 < arg_148_1.time_ and arg_148_1.time_ <= var_151_30 + arg_151_0 then
				arg_148_1.var_.moveOldPos1166ui_story = var_151_29.localPosition

				local var_151_31 = GameObjectTools.GetOrAddComponent(var_151_29.gameObject, typeof(DynamicBoneHelper))

				if var_151_31 then
					var_151_31:EnableDynamicBone(false)
				end
			end

			local var_151_32 = 0.001

			if var_151_30 <= arg_148_1.time_ and arg_148_1.time_ < var_151_30 + var_151_32 then
				local var_151_33 = (arg_148_1.time_ - var_151_30) / var_151_32
				local var_151_34 = Vector3.New(0, 100, 0)

				var_151_29.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1166ui_story, var_151_34, var_151_33)

				local var_151_35 = manager.ui.mainCamera.transform.position - var_151_29.position

				var_151_29.forward = Vector3.New(var_151_35.x, var_151_35.y, var_151_35.z)

				local var_151_36 = var_151_29.localEulerAngles

				var_151_36.z = 0
				var_151_36.x = 0
				var_151_29.localEulerAngles = var_151_36
			end

			if arg_148_1.time_ >= var_151_30 + var_151_32 and arg_148_1.time_ < var_151_30 + var_151_32 + arg_151_0 then
				var_151_29.localPosition = Vector3.New(0, 100, 0)

				local var_151_37 = manager.ui.mainCamera.transform.position - var_151_29.position

				var_151_29.forward = Vector3.New(var_151_37.x, var_151_37.y, var_151_37.z)

				local var_151_38 = var_151_29.localEulerAngles

				var_151_38.z = 0
				var_151_38.x = 0
				var_151_29.localEulerAngles = var_151_38

				local var_151_39 = GameObjectTools.GetOrAddComponent(var_151_29.gameObject, typeof(DynamicBoneHelper))

				if var_151_39 then
					var_151_39:EnableDynamicBone(true)
				end
			end

			local var_151_40 = arg_148_1.actors_["1019ui_story"].transform
			local var_151_41 = 1.96599999815226

			if var_151_41 < arg_148_1.time_ and arg_148_1.time_ <= var_151_41 + arg_151_0 then
				arg_148_1.var_.moveOldPos1019ui_story = var_151_40.localPosition
			end

			local var_151_42 = 0.001

			if var_151_41 <= arg_148_1.time_ and arg_148_1.time_ < var_151_41 + var_151_42 then
				local var_151_43 = (arg_148_1.time_ - var_151_41) / var_151_42
				local var_151_44 = Vector3.New(0, 100, 0)

				var_151_40.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1019ui_story, var_151_44, var_151_43)

				local var_151_45 = manager.ui.mainCamera.transform.position - var_151_40.position

				var_151_40.forward = Vector3.New(var_151_45.x, var_151_45.y, var_151_45.z)

				local var_151_46 = var_151_40.localEulerAngles

				var_151_46.z = 0
				var_151_46.x = 0
				var_151_40.localEulerAngles = var_151_46
			end

			if arg_148_1.time_ >= var_151_41 + var_151_42 and arg_148_1.time_ < var_151_41 + var_151_42 + arg_151_0 then
				var_151_40.localPosition = Vector3.New(0, 100, 0)

				local var_151_47 = manager.ui.mainCamera.transform.position - var_151_40.position

				var_151_40.forward = Vector3.New(var_151_47.x, var_151_47.y, var_151_47.z)

				local var_151_48 = var_151_40.localEulerAngles

				var_151_48.z = 0
				var_151_48.x = 0
				var_151_40.localEulerAngles = var_151_48
			end

			local var_151_49 = arg_148_1.actors_["1166ui_story"]
			local var_151_50 = 1.96599999815226

			if var_151_50 < arg_148_1.time_ and arg_148_1.time_ <= var_151_50 + arg_151_0 and not isNil(var_151_49) and arg_148_1.var_.characterEffect1166ui_story == nil then
				arg_148_1.var_.characterEffect1166ui_story = var_151_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_51 = 0.034000001847744

			if var_151_50 <= arg_148_1.time_ and arg_148_1.time_ < var_151_50 + var_151_51 and not isNil(var_151_49) then
				local var_151_52 = (arg_148_1.time_ - var_151_50) / var_151_51

				if arg_148_1.var_.characterEffect1166ui_story and not isNil(var_151_49) then
					local var_151_53 = Mathf.Lerp(0, 0.5, var_151_52)

					arg_148_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1166ui_story.fillRatio = var_151_53
				end
			end

			if arg_148_1.time_ >= var_151_50 + var_151_51 and arg_148_1.time_ < var_151_50 + var_151_51 + arg_151_0 and not isNil(var_151_49) and arg_148_1.var_.characterEffect1166ui_story then
				local var_151_54 = 0.5

				arg_148_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1166ui_story.fillRatio = var_151_54
			end

			local var_151_55 = 1.2
			local var_151_56 = 1

			if var_151_55 < arg_148_1.time_ and arg_148_1.time_ <= var_151_55 + arg_151_0 then
				local var_151_57 = "play"
				local var_151_58 = "effect"

				arg_148_1:AudioAction(var_151_57, var_151_58, "se_story_140", "se_story_140_amb_street01", "")
			end

			local var_151_59 = 0.2
			local var_151_60 = 1

			if var_151_59 < arg_148_1.time_ and arg_148_1.time_ <= var_151_59 + arg_151_0 then
				local var_151_61 = "stop"
				local var_151_62 = "effect"

				arg_148_1:AudioAction(var_151_61, var_151_62, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			local var_151_63 = 1
			local var_151_64 = 1

			if var_151_63 < arg_148_1.time_ and arg_148_1.time_ <= var_151_63 + arg_151_0 then
				local var_151_65 = "play"
				local var_151_66 = "music"

				arg_148_1:AudioAction(var_151_65, var_151_66, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_151_67 = ""
				local var_151_68 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if var_151_68 ~= "" then
					if arg_148_1.bgmTxt_.text ~= var_151_68 and arg_148_1.bgmTxt_.text ~= "" then
						if arg_148_1.bgmTxt2_.text ~= "" then
							arg_148_1.bgmTxt_.text = arg_148_1.bgmTxt2_.text
						end

						arg_148_1.bgmTxt2_.text = var_151_68

						arg_148_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_148_1.bgmTxt_.text = var_151_68
						arg_148_1.bgmTxt2_.text = var_151_68
					end

					if arg_148_1.bgmTimer then
						arg_148_1.bgmTimer:Stop()

						arg_148_1.bgmTimer = nil
					end

					if arg_148_1.settingData.show_music_name == 1 then
						arg_148_1.musicController:SetSelectedState("show")
						arg_148_1.musicAnimator_:Play("open", 0, 0)

						if arg_148_1.settingData.music_time ~= 0 then
							arg_148_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_148_1.settingData.music_time), function()
								if arg_148_1 == nil or isNil(arg_148_1.bgmTxt_) then
									return
								end

								arg_148_1.musicController:SetSelectedState("hide")
								arg_148_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_148_1.frameCnt_ <= 1 then
				arg_148_1.dialog_:SetActive(false)
			end

			local var_151_69 = 4
			local var_151_70 = 0.175

			if var_151_69 < arg_148_1.time_ and arg_148_1.time_ <= var_151_69 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				arg_148_1.dialog_:SetActive(true)

				arg_148_1.dialogCg_.alpha = 0

				local var_151_71 = LeanTween.value(arg_148_1.dialog_, 0, 1, 0.3)

				var_151_71:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_148_1.dialogCg_.alpha = arg_153_0
				end))
				var_151_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_148_1.dialog_)
					var_151_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_148_1.duration_ = arg_148_1.duration_ + 0.3

				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_72 = arg_148_1:FormatText(StoryNameCfg[7].name)

				arg_148_1.leftNameTxt_.text = var_151_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_73 = arg_148_1:GetWordFromCfg(302031039)
				local var_151_74 = arg_148_1:FormatText(var_151_73.content)

				arg_148_1.text_.text = var_151_74

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_75 = 7
				local var_151_76 = utf8.len(var_151_74)
				local var_151_77 = var_151_75 <= 0 and var_151_70 or var_151_70 * (var_151_76 / var_151_75)

				if var_151_77 > 0 and var_151_70 < var_151_77 then
					arg_148_1.talkMaxDuration = var_151_77
					var_151_69 = var_151_69 + 0.3

					if var_151_77 + var_151_69 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_77 + var_151_69
					end
				end

				arg_148_1.text_.text = var_151_74
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_78 = var_151_69 + 0.3
			local var_151_79 = math.max(var_151_70, arg_148_1.talkMaxDuration)

			if var_151_78 <= arg_148_1.time_ and arg_148_1.time_ < var_151_78 + var_151_79 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_78) / var_151_79

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_78 + var_151_79 and arg_148_1.time_ < var_151_78 + var_151_79 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play302031040 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 302031040
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play302031041(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1.575

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

				local var_158_2 = arg_155_1:GetWordFromCfg(302031040)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 63
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
	Play302031041 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 302031041
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play302031042(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.375

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

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(302031041)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 15
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
	Play302031042 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 302031042
		arg_163_1.duration_ = 6.63

		local var_163_0 = {
			zh = 6.633,
			ja = 1.999999999999
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play302031043(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1166ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1166ui_story = var_166_0.localPosition

				local var_166_2 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(false)
				end
			end

			local var_166_3 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_3 then
				local var_166_4 = (arg_163_1.time_ - var_166_1) / var_166_3
				local var_166_5 = Vector3.New(0, -0.75, -6.25)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1166ui_story, var_166_5, var_166_4)

				local var_166_6 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_6.x, var_166_6.y, var_166_6.z)

				local var_166_7 = var_166_0.localEulerAngles

				var_166_7.z = 0
				var_166_7.x = 0
				var_166_0.localEulerAngles = var_166_7
			end

			if arg_163_1.time_ >= var_166_1 + var_166_3 and arg_163_1.time_ < var_166_1 + var_166_3 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -0.75, -6.25)

				local var_166_8 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_8.x, var_166_8.y, var_166_8.z)

				local var_166_9 = var_166_0.localEulerAngles

				var_166_9.z = 0
				var_166_9.x = 0
				var_166_0.localEulerAngles = var_166_9

				local var_166_10 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_10 then
					var_166_10:EnableDynamicBone(true)
				end
			end

			local var_166_11 = arg_163_1.actors_["1166ui_story"]
			local var_166_12 = 0

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect1166ui_story == nil then
				arg_163_1.var_.characterEffect1166ui_story = var_166_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_13 = 0.200000002980232

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_13 and not isNil(var_166_11) then
				local var_166_14 = (arg_163_1.time_ - var_166_12) / var_166_13

				if arg_163_1.var_.characterEffect1166ui_story and not isNil(var_166_11) then
					arg_163_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_12 + var_166_13 and arg_163_1.time_ < var_166_12 + var_166_13 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect1166ui_story then
				arg_163_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_166_15 = 0

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganB", "EmotionTimelineAnimator")
			end

			local var_166_17 = 0
			local var_166_18 = 0.775

			if var_166_17 < arg_163_1.time_ and arg_163_1.time_ <= var_166_17 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_19 = arg_163_1:FormatText(StoryNameCfg[32].name)

				arg_163_1.leftNameTxt_.text = var_166_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_20 = arg_163_1:GetWordFromCfg(302031042)
				local var_166_21 = arg_163_1:FormatText(var_166_20.content)

				arg_163_1.text_.text = var_166_21

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_22 = 31
				local var_166_23 = utf8.len(var_166_21)
				local var_166_24 = var_166_22 <= 0 and var_166_18 or var_166_18 * (var_166_23 / var_166_22)

				if var_166_24 > 0 and var_166_18 < var_166_24 then
					arg_163_1.talkMaxDuration = var_166_24

					if var_166_24 + var_166_17 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_24 + var_166_17
					end
				end

				arg_163_1.text_.text = var_166_21
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031042", "story_v_out_302031.awb") ~= 0 then
					local var_166_25 = manager.audio:GetVoiceLength("story_v_out_302031", "302031042", "story_v_out_302031.awb") / 1000

					if var_166_25 + var_166_17 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_25 + var_166_17
					end

					if var_166_20.prefab_name ~= "" and arg_163_1.actors_[var_166_20.prefab_name] ~= nil then
						local var_166_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_20.prefab_name].transform, "story_v_out_302031", "302031042", "story_v_out_302031.awb")

						arg_163_1:RecordAudio("302031042", var_166_26)
						arg_163_1:RecordAudio("302031042", var_166_26)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_302031", "302031042", "story_v_out_302031.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_302031", "302031042", "story_v_out_302031.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_27 = math.max(var_166_18, arg_163_1.talkMaxDuration)

			if var_166_17 <= arg_163_1.time_ and arg_163_1.time_ < var_166_17 + var_166_27 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_17) / var_166_27

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_17 + var_166_27 and arg_163_1.time_ < var_166_17 + var_166_27 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play302031043 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 302031043
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play302031044(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1166ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1166ui_story == nil then
				arg_167_1.var_.characterEffect1166ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1166ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1166ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1166ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1166ui_story.fillRatio = var_170_5
			end

			local var_170_6 = 0
			local var_170_7 = 0.875

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_8 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_9 = arg_167_1:GetWordFromCfg(302031043)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 35
				local var_170_12 = utf8.len(var_170_10)
				local var_170_13 = var_170_11 <= 0 and var_170_7 or var_170_7 * (var_170_12 / var_170_11)

				if var_170_13 > 0 and var_170_7 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play302031044 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 302031044
		arg_171_1.duration_ = 7.47

		local var_171_0 = {
			zh = 5.766,
			ja = 7.466
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
				arg_171_0:Play302031045(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1084ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1084ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0.7, -0.97, -6)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1084ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["1166ui_story"].transform
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1.var_.moveOldPos1166ui_story = var_174_9.localPosition

				local var_174_11 = GameObjectTools.GetOrAddComponent(var_174_9.gameObject, typeof(DynamicBoneHelper))

				if var_174_11 then
					var_174_11:EnableDynamicBone(false)
				end
			end

			local var_174_12 = 0.001

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_12 then
				local var_174_13 = (arg_171_1.time_ - var_174_10) / var_174_12
				local var_174_14 = Vector3.New(-0.7, -0.75, -6.25)

				var_174_9.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1166ui_story, var_174_14, var_174_13)

				local var_174_15 = manager.ui.mainCamera.transform.position - var_174_9.position

				var_174_9.forward = Vector3.New(var_174_15.x, var_174_15.y, var_174_15.z)

				local var_174_16 = var_174_9.localEulerAngles

				var_174_16.z = 0
				var_174_16.x = 0
				var_174_9.localEulerAngles = var_174_16
			end

			if arg_171_1.time_ >= var_174_10 + var_174_12 and arg_171_1.time_ < var_174_10 + var_174_12 + arg_174_0 then
				var_174_9.localPosition = Vector3.New(-0.7, -0.75, -6.25)

				local var_174_17 = manager.ui.mainCamera.transform.position - var_174_9.position

				var_174_9.forward = Vector3.New(var_174_17.x, var_174_17.y, var_174_17.z)

				local var_174_18 = var_174_9.localEulerAngles

				var_174_18.z = 0
				var_174_18.x = 0
				var_174_9.localEulerAngles = var_174_18

				local var_174_19 = GameObjectTools.GetOrAddComponent(var_174_9.gameObject, typeof(DynamicBoneHelper))

				if var_174_19 then
					var_174_19:EnableDynamicBone(true)
				end
			end

			local var_174_20 = arg_171_1.actors_["1084ui_story"]
			local var_174_21 = 0

			if var_174_21 < arg_171_1.time_ and arg_171_1.time_ <= var_174_21 + arg_174_0 and not isNil(var_174_20) and arg_171_1.var_.characterEffect1084ui_story == nil then
				arg_171_1.var_.characterEffect1084ui_story = var_174_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_22 = 0.200000002980232

			if var_174_21 <= arg_171_1.time_ and arg_171_1.time_ < var_174_21 + var_174_22 and not isNil(var_174_20) then
				local var_174_23 = (arg_171_1.time_ - var_174_21) / var_174_22

				if arg_171_1.var_.characterEffect1084ui_story and not isNil(var_174_20) then
					arg_171_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_21 + var_174_22 and arg_171_1.time_ < var_174_21 + var_174_22 + arg_174_0 and not isNil(var_174_20) and arg_171_1.var_.characterEffect1084ui_story then
				arg_171_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_174_24 = 0

			if var_174_24 < arg_171_1.time_ and arg_171_1.time_ <= var_174_24 + arg_174_0 then
				arg_171_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_174_25 = 0

			if var_174_25 < arg_171_1.time_ and arg_171_1.time_ <= var_174_25 + arg_174_0 then
				arg_171_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_174_26 = 0
			local var_174_27 = 0.625

			if var_174_26 < arg_171_1.time_ and arg_171_1.time_ <= var_174_26 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_28 = arg_171_1:FormatText(StoryNameCfg[6].name)

				arg_171_1.leftNameTxt_.text = var_174_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_29 = arg_171_1:GetWordFromCfg(302031044)
				local var_174_30 = arg_171_1:FormatText(var_174_29.content)

				arg_171_1.text_.text = var_174_30

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_31 = 25
				local var_174_32 = utf8.len(var_174_30)
				local var_174_33 = var_174_31 <= 0 and var_174_27 or var_174_27 * (var_174_32 / var_174_31)

				if var_174_33 > 0 and var_174_27 < var_174_33 then
					arg_171_1.talkMaxDuration = var_174_33

					if var_174_33 + var_174_26 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_33 + var_174_26
					end
				end

				arg_171_1.text_.text = var_174_30
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031044", "story_v_out_302031.awb") ~= 0 then
					local var_174_34 = manager.audio:GetVoiceLength("story_v_out_302031", "302031044", "story_v_out_302031.awb") / 1000

					if var_174_34 + var_174_26 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_34 + var_174_26
					end

					if var_174_29.prefab_name ~= "" and arg_171_1.actors_[var_174_29.prefab_name] ~= nil then
						local var_174_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_29.prefab_name].transform, "story_v_out_302031", "302031044", "story_v_out_302031.awb")

						arg_171_1:RecordAudio("302031044", var_174_35)
						arg_171_1:RecordAudio("302031044", var_174_35)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_302031", "302031044", "story_v_out_302031.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_302031", "302031044", "story_v_out_302031.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_36 = math.max(var_174_27, arg_171_1.talkMaxDuration)

			if var_174_26 <= arg_171_1.time_ and arg_171_1.time_ < var_174_26 + var_174_36 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_26) / var_174_36

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_26 + var_174_36 and arg_171_1.time_ < var_174_26 + var_174_36 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play302031045 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 302031045
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play302031046(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1084ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1084ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, 100, 0)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1084ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, 100, 0)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["1166ui_story"].transform
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.var_.moveOldPos1166ui_story = var_178_9.localPosition

				local var_178_11 = GameObjectTools.GetOrAddComponent(var_178_9.gameObject, typeof(DynamicBoneHelper))

				if var_178_11 then
					var_178_11:EnableDynamicBone(false)
				end
			end

			local var_178_12 = 0.001

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_12 then
				local var_178_13 = (arg_175_1.time_ - var_178_10) / var_178_12
				local var_178_14 = Vector3.New(0, 100, 0)

				var_178_9.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1166ui_story, var_178_14, var_178_13)

				local var_178_15 = manager.ui.mainCamera.transform.position - var_178_9.position

				var_178_9.forward = Vector3.New(var_178_15.x, var_178_15.y, var_178_15.z)

				local var_178_16 = var_178_9.localEulerAngles

				var_178_16.z = 0
				var_178_16.x = 0
				var_178_9.localEulerAngles = var_178_16
			end

			if arg_175_1.time_ >= var_178_10 + var_178_12 and arg_175_1.time_ < var_178_10 + var_178_12 + arg_178_0 then
				var_178_9.localPosition = Vector3.New(0, 100, 0)

				local var_178_17 = manager.ui.mainCamera.transform.position - var_178_9.position

				var_178_9.forward = Vector3.New(var_178_17.x, var_178_17.y, var_178_17.z)

				local var_178_18 = var_178_9.localEulerAngles

				var_178_18.z = 0
				var_178_18.x = 0
				var_178_9.localEulerAngles = var_178_18

				local var_178_19 = GameObjectTools.GetOrAddComponent(var_178_9.gameObject, typeof(DynamicBoneHelper))

				if var_178_19 then
					var_178_19:EnableDynamicBone(true)
				end
			end

			local var_178_20 = arg_175_1.actors_["1084ui_story"]
			local var_178_21 = 0

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 and not isNil(var_178_20) and arg_175_1.var_.characterEffect1084ui_story == nil then
				arg_175_1.var_.characterEffect1084ui_story = var_178_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_22 = 0.200000002980232

			if var_178_21 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_22 and not isNil(var_178_20) then
				local var_178_23 = (arg_175_1.time_ - var_178_21) / var_178_22

				if arg_175_1.var_.characterEffect1084ui_story and not isNil(var_178_20) then
					local var_178_24 = Mathf.Lerp(0, 0.5, var_178_23)

					arg_175_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1084ui_story.fillRatio = var_178_24
				end
			end

			if arg_175_1.time_ >= var_178_21 + var_178_22 and arg_175_1.time_ < var_178_21 + var_178_22 + arg_178_0 and not isNil(var_178_20) and arg_175_1.var_.characterEffect1084ui_story then
				local var_178_25 = 0.5

				arg_175_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1084ui_story.fillRatio = var_178_25
			end

			local var_178_26 = 0
			local var_178_27 = 1.325

			if var_178_26 < arg_175_1.time_ and arg_175_1.time_ <= var_178_26 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_28 = arg_175_1:GetWordFromCfg(302031045)
				local var_178_29 = arg_175_1:FormatText(var_178_28.content)

				arg_175_1.text_.text = var_178_29

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_30 = 53
				local var_178_31 = utf8.len(var_178_29)
				local var_178_32 = var_178_30 <= 0 and var_178_27 or var_178_27 * (var_178_31 / var_178_30)

				if var_178_32 > 0 and var_178_27 < var_178_32 then
					arg_175_1.talkMaxDuration = var_178_32

					if var_178_32 + var_178_26 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_32 + var_178_26
					end
				end

				arg_175_1.text_.text = var_178_29
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_33 = math.max(var_178_27, arg_175_1.talkMaxDuration)

			if var_178_26 <= arg_175_1.time_ and arg_175_1.time_ < var_178_26 + var_178_33 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_26) / var_178_33

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_26 + var_178_33 and arg_175_1.time_ < var_178_26 + var_178_33 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play302031046 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 302031046
		arg_179_1.duration_ = 2.13

		local var_179_0 = {
			zh = 2.133,
			ja = 1.999999999999
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
				arg_179_0:Play302031047(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1166ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos1166ui_story = var_182_0.localPosition

				local var_182_2 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(false)
				end
			end

			local var_182_3 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_3 then
				local var_182_4 = (arg_179_1.time_ - var_182_1) / var_182_3
				local var_182_5 = Vector3.New(0, -0.75, -6.25)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1166ui_story, var_182_5, var_182_4)

				local var_182_6 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_6.x, var_182_6.y, var_182_6.z)

				local var_182_7 = var_182_0.localEulerAngles

				var_182_7.z = 0
				var_182_7.x = 0
				var_182_0.localEulerAngles = var_182_7
			end

			if arg_179_1.time_ >= var_182_1 + var_182_3 and arg_179_1.time_ < var_182_1 + var_182_3 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0, -0.75, -6.25)

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

			local var_182_11 = arg_179_1.actors_["1166ui_story"]
			local var_182_12 = 0

			if var_182_12 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect1166ui_story == nil then
				arg_179_1.var_.characterEffect1166ui_story = var_182_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_13 = 0.200000002980232

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_13 and not isNil(var_182_11) then
				local var_182_14 = (arg_179_1.time_ - var_182_12) / var_182_13

				if arg_179_1.var_.characterEffect1166ui_story and not isNil(var_182_11) then
					arg_179_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_12 + var_182_13 and arg_179_1.time_ < var_182_12 + var_182_13 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect1166ui_story then
				arg_179_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_182_15 = 0

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 then
				arg_179_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			local var_182_16 = 0

			if var_182_16 < arg_179_1.time_ and arg_179_1.time_ <= var_182_16 + arg_182_0 then
				arg_179_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_182_17 = 0
			local var_182_18 = 0.25

			if var_182_17 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_19 = arg_179_1:FormatText(StoryNameCfg[32].name)

				arg_179_1.leftNameTxt_.text = var_182_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_20 = arg_179_1:GetWordFromCfg(302031046)
				local var_182_21 = arg_179_1:FormatText(var_182_20.content)

				arg_179_1.text_.text = var_182_21

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_22 = 10
				local var_182_23 = utf8.len(var_182_21)
				local var_182_24 = var_182_22 <= 0 and var_182_18 or var_182_18 * (var_182_23 / var_182_22)

				if var_182_24 > 0 and var_182_18 < var_182_24 then
					arg_179_1.talkMaxDuration = var_182_24

					if var_182_24 + var_182_17 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_24 + var_182_17
					end
				end

				arg_179_1.text_.text = var_182_21
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031046", "story_v_out_302031.awb") ~= 0 then
					local var_182_25 = manager.audio:GetVoiceLength("story_v_out_302031", "302031046", "story_v_out_302031.awb") / 1000

					if var_182_25 + var_182_17 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_25 + var_182_17
					end

					if var_182_20.prefab_name ~= "" and arg_179_1.actors_[var_182_20.prefab_name] ~= nil then
						local var_182_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_20.prefab_name].transform, "story_v_out_302031", "302031046", "story_v_out_302031.awb")

						arg_179_1:RecordAudio("302031046", var_182_26)
						arg_179_1:RecordAudio("302031046", var_182_26)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_302031", "302031046", "story_v_out_302031.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_302031", "302031046", "story_v_out_302031.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_27 = math.max(var_182_18, arg_179_1.talkMaxDuration)

			if var_182_17 <= arg_179_1.time_ and arg_179_1.time_ < var_182_17 + var_182_27 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_17) / var_182_27

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_17 + var_182_27 and arg_179_1.time_ < var_182_17 + var_182_27 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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
	Play302031047 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 302031047
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play302031048(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1166ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1166ui_story == nil then
				arg_183_1.var_.characterEffect1166ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1166ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1166ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1166ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1166ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 0.275

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_8 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_9 = arg_183_1:GetWordFromCfg(302031047)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 11
				local var_186_12 = utf8.len(var_186_10)
				local var_186_13 = var_186_11 <= 0 and var_186_7 or var_186_7 * (var_186_12 / var_186_11)

				if var_186_13 > 0 and var_186_7 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_10
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play302031048 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 302031048
		arg_187_1.duration_ = 4.2

		local var_187_0 = {
			zh = 4.2,
			ja = 1.333
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
				arg_187_0:Play302031049(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1166ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1166ui_story == nil then
				arg_187_1.var_.characterEffect1166ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1166ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1166ui_story then
				arg_187_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_190_4 = 0
			local var_190_5 = 0.525

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_6 = arg_187_1:FormatText(StoryNameCfg[32].name)

				arg_187_1.leftNameTxt_.text = var_190_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_7 = arg_187_1:GetWordFromCfg(302031048)
				local var_190_8 = arg_187_1:FormatText(var_190_7.content)

				arg_187_1.text_.text = var_190_8

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 21
				local var_190_10 = utf8.len(var_190_8)
				local var_190_11 = var_190_9 <= 0 and var_190_5 or var_190_5 * (var_190_10 / var_190_9)

				if var_190_11 > 0 and var_190_5 < var_190_11 then
					arg_187_1.talkMaxDuration = var_190_11

					if var_190_11 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_11 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_8
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031048", "story_v_out_302031.awb") ~= 0 then
					local var_190_12 = manager.audio:GetVoiceLength("story_v_out_302031", "302031048", "story_v_out_302031.awb") / 1000

					if var_190_12 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_12 + var_190_4
					end

					if var_190_7.prefab_name ~= "" and arg_187_1.actors_[var_190_7.prefab_name] ~= nil then
						local var_190_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_7.prefab_name].transform, "story_v_out_302031", "302031048", "story_v_out_302031.awb")

						arg_187_1:RecordAudio("302031048", var_190_13)
						arg_187_1:RecordAudio("302031048", var_190_13)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_302031", "302031048", "story_v_out_302031.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_302031", "302031048", "story_v_out_302031.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_14 and arg_187_1.time_ < var_190_4 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play302031049 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 302031049
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play302031050(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1166ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1166ui_story = var_194_0.localPosition

				local var_194_2 = GameObjectTools.GetOrAddComponent(var_194_0.gameObject, typeof(DynamicBoneHelper))

				if var_194_2 then
					var_194_2:EnableDynamicBone(false)
				end
			end

			local var_194_3 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_3 then
				local var_194_4 = (arg_191_1.time_ - var_194_1) / var_194_3
				local var_194_5 = Vector3.New(0, 100, 0)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1166ui_story, var_194_5, var_194_4)

				local var_194_6 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_6.x, var_194_6.y, var_194_6.z)

				local var_194_7 = var_194_0.localEulerAngles

				var_194_7.z = 0
				var_194_7.x = 0
				var_194_0.localEulerAngles = var_194_7
			end

			if arg_191_1.time_ >= var_194_1 + var_194_3 and arg_191_1.time_ < var_194_1 + var_194_3 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, 100, 0)

				local var_194_8 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_8.x, var_194_8.y, var_194_8.z)

				local var_194_9 = var_194_0.localEulerAngles

				var_194_9.z = 0
				var_194_9.x = 0
				var_194_0.localEulerAngles = var_194_9

				local var_194_10 = GameObjectTools.GetOrAddComponent(var_194_0.gameObject, typeof(DynamicBoneHelper))

				if var_194_10 then
					var_194_10:EnableDynamicBone(true)
				end
			end

			local var_194_11 = arg_191_1.actors_["1166ui_story"]
			local var_194_12 = 0

			if var_194_12 < arg_191_1.time_ and arg_191_1.time_ <= var_194_12 + arg_194_0 and not isNil(var_194_11) and arg_191_1.var_.characterEffect1166ui_story == nil then
				arg_191_1.var_.characterEffect1166ui_story = var_194_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_13 = 0.200000002980232

			if var_194_12 <= arg_191_1.time_ and arg_191_1.time_ < var_194_12 + var_194_13 and not isNil(var_194_11) then
				local var_194_14 = (arg_191_1.time_ - var_194_12) / var_194_13

				if arg_191_1.var_.characterEffect1166ui_story and not isNil(var_194_11) then
					local var_194_15 = Mathf.Lerp(0, 0.5, var_194_14)

					arg_191_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1166ui_story.fillRatio = var_194_15
				end
			end

			if arg_191_1.time_ >= var_194_12 + var_194_13 and arg_191_1.time_ < var_194_12 + var_194_13 + arg_194_0 and not isNil(var_194_11) and arg_191_1.var_.characterEffect1166ui_story then
				local var_194_16 = 0.5

				arg_191_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1166ui_story.fillRatio = var_194_16
			end

			local var_194_17 = 0
			local var_194_18 = 1.025

			if var_194_17 < arg_191_1.time_ and arg_191_1.time_ <= var_194_17 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_19 = arg_191_1:GetWordFromCfg(302031049)
				local var_194_20 = arg_191_1:FormatText(var_194_19.content)

				arg_191_1.text_.text = var_194_20

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_21 = 41
				local var_194_22 = utf8.len(var_194_20)
				local var_194_23 = var_194_21 <= 0 and var_194_18 or var_194_18 * (var_194_22 / var_194_21)

				if var_194_23 > 0 and var_194_18 < var_194_23 then
					arg_191_1.talkMaxDuration = var_194_23

					if var_194_23 + var_194_17 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_17
					end
				end

				arg_191_1.text_.text = var_194_20
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_24 = math.max(var_194_18, arg_191_1.talkMaxDuration)

			if var_194_17 <= arg_191_1.time_ and arg_191_1.time_ < var_194_17 + var_194_24 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_17) / var_194_24

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_17 + var_194_24 and arg_191_1.time_ < var_194_17 + var_194_24 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play302031050 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 302031050
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play302031051(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 1.775

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(302031050)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 71
				local var_198_5 = utf8.len(var_198_3)
				local var_198_6 = var_198_4 <= 0 and var_198_1 or var_198_1 * (var_198_5 / var_198_4)

				if var_198_6 > 0 and var_198_1 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_7 and arg_195_1.time_ < var_198_0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play302031051 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 302031051
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play302031052(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.175

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(302031051)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 7
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_8 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_8 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_8

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_8 and arg_199_1.time_ < var_202_0 + var_202_8 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play302031052 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 302031052
		arg_203_1.duration_ = 5.3

		local var_203_0 = {
			zh = 5.3,
			ja = 1.333
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
				arg_203_0:Play302031053(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1166ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1166ui_story = var_206_0.localPosition

				local var_206_2 = GameObjectTools.GetOrAddComponent(var_206_0.gameObject, typeof(DynamicBoneHelper))

				if var_206_2 then
					var_206_2:EnableDynamicBone(false)
				end
			end

			local var_206_3 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_3 then
				local var_206_4 = (arg_203_1.time_ - var_206_1) / var_206_3
				local var_206_5 = Vector3.New(-0.7, -0.75, -6.25)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1166ui_story, var_206_5, var_206_4)

				local var_206_6 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_6.x, var_206_6.y, var_206_6.z)

				local var_206_7 = var_206_0.localEulerAngles

				var_206_7.z = 0
				var_206_7.x = 0
				var_206_0.localEulerAngles = var_206_7
			end

			if arg_203_1.time_ >= var_206_1 + var_206_3 and arg_203_1.time_ < var_206_1 + var_206_3 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(-0.7, -0.75, -6.25)

				local var_206_8 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_8.x, var_206_8.y, var_206_8.z)

				local var_206_9 = var_206_0.localEulerAngles

				var_206_9.z = 0
				var_206_9.x = 0
				var_206_0.localEulerAngles = var_206_9

				local var_206_10 = GameObjectTools.GetOrAddComponent(var_206_0.gameObject, typeof(DynamicBoneHelper))

				if var_206_10 then
					var_206_10:EnableDynamicBone(true)
				end
			end

			local var_206_11 = arg_203_1.actors_["1166ui_story"]
			local var_206_12 = 0

			if var_206_12 < arg_203_1.time_ and arg_203_1.time_ <= var_206_12 + arg_206_0 and not isNil(var_206_11) and arg_203_1.var_.characterEffect1166ui_story == nil then
				arg_203_1.var_.characterEffect1166ui_story = var_206_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_13 = 0.200000002980232

			if var_206_12 <= arg_203_1.time_ and arg_203_1.time_ < var_206_12 + var_206_13 and not isNil(var_206_11) then
				local var_206_14 = (arg_203_1.time_ - var_206_12) / var_206_13

				if arg_203_1.var_.characterEffect1166ui_story and not isNil(var_206_11) then
					arg_203_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_12 + var_206_13 and arg_203_1.time_ < var_206_12 + var_206_13 + arg_206_0 and not isNil(var_206_11) and arg_203_1.var_.characterEffect1166ui_story then
				arg_203_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_206_15 = 0

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_206_17 = 0
			local var_206_18 = 0.55

			if var_206_17 < arg_203_1.time_ and arg_203_1.time_ <= var_206_17 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_19 = arg_203_1:FormatText(StoryNameCfg[32].name)

				arg_203_1.leftNameTxt_.text = var_206_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_20 = arg_203_1:GetWordFromCfg(302031052)
				local var_206_21 = arg_203_1:FormatText(var_206_20.content)

				arg_203_1.text_.text = var_206_21

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_22 = 22
				local var_206_23 = utf8.len(var_206_21)
				local var_206_24 = var_206_22 <= 0 and var_206_18 or var_206_18 * (var_206_23 / var_206_22)

				if var_206_24 > 0 and var_206_18 < var_206_24 then
					arg_203_1.talkMaxDuration = var_206_24

					if var_206_24 + var_206_17 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_24 + var_206_17
					end
				end

				arg_203_1.text_.text = var_206_21
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031052", "story_v_out_302031.awb") ~= 0 then
					local var_206_25 = manager.audio:GetVoiceLength("story_v_out_302031", "302031052", "story_v_out_302031.awb") / 1000

					if var_206_25 + var_206_17 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_25 + var_206_17
					end

					if var_206_20.prefab_name ~= "" and arg_203_1.actors_[var_206_20.prefab_name] ~= nil then
						local var_206_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_20.prefab_name].transform, "story_v_out_302031", "302031052", "story_v_out_302031.awb")

						arg_203_1:RecordAudio("302031052", var_206_26)
						arg_203_1:RecordAudio("302031052", var_206_26)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_302031", "302031052", "story_v_out_302031.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_302031", "302031052", "story_v_out_302031.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_27 = math.max(var_206_18, arg_203_1.talkMaxDuration)

			if var_206_17 <= arg_203_1.time_ and arg_203_1.time_ < var_206_17 + var_206_27 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_17) / var_206_27

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_17 + var_206_27 and arg_203_1.time_ < var_206_17 + var_206_27 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play302031053 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 302031053
		arg_207_1.duration_ = 3.97

		local var_207_0 = {
			zh = 2.2,
			ja = 3.966
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play302031054(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1084ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1084ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0.7, -0.97, -6)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1084ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1084ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1084ui_story == nil then
				arg_207_1.var_.characterEffect1084ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect1084ui_story and not isNil(var_210_9) then
					arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1084ui_story then
				arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_210_13 = arg_207_1.actors_["1166ui_story"]
			local var_210_14 = 0

			if var_210_14 < arg_207_1.time_ and arg_207_1.time_ <= var_210_14 + arg_210_0 and not isNil(var_210_13) and arg_207_1.var_.characterEffect1166ui_story == nil then
				arg_207_1.var_.characterEffect1166ui_story = var_210_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_15 = 0.200000002980232

			if var_210_14 <= arg_207_1.time_ and arg_207_1.time_ < var_210_14 + var_210_15 and not isNil(var_210_13) then
				local var_210_16 = (arg_207_1.time_ - var_210_14) / var_210_15

				if arg_207_1.var_.characterEffect1166ui_story and not isNil(var_210_13) then
					local var_210_17 = Mathf.Lerp(0, 0.5, var_210_16)

					arg_207_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1166ui_story.fillRatio = var_210_17
				end
			end

			if arg_207_1.time_ >= var_210_14 + var_210_15 and arg_207_1.time_ < var_210_14 + var_210_15 + arg_210_0 and not isNil(var_210_13) and arg_207_1.var_.characterEffect1166ui_story then
				local var_210_18 = 0.5

				arg_207_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1166ui_story.fillRatio = var_210_18
			end

			local var_210_19 = 0

			if var_210_19 < arg_207_1.time_ and arg_207_1.time_ <= var_210_19 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_210_20 = 0

			if var_210_20 < arg_207_1.time_ and arg_207_1.time_ <= var_210_20 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_210_21 = 0
			local var_210_22 = 0.2

			if var_210_21 < arg_207_1.time_ and arg_207_1.time_ <= var_210_21 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_23 = arg_207_1:FormatText(StoryNameCfg[6].name)

				arg_207_1.leftNameTxt_.text = var_210_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_24 = arg_207_1:GetWordFromCfg(302031053)
				local var_210_25 = arg_207_1:FormatText(var_210_24.content)

				arg_207_1.text_.text = var_210_25

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_26 = 8
				local var_210_27 = utf8.len(var_210_25)
				local var_210_28 = var_210_26 <= 0 and var_210_22 or var_210_22 * (var_210_27 / var_210_26)

				if var_210_28 > 0 and var_210_22 < var_210_28 then
					arg_207_1.talkMaxDuration = var_210_28

					if var_210_28 + var_210_21 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_28 + var_210_21
					end
				end

				arg_207_1.text_.text = var_210_25
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031053", "story_v_out_302031.awb") ~= 0 then
					local var_210_29 = manager.audio:GetVoiceLength("story_v_out_302031", "302031053", "story_v_out_302031.awb") / 1000

					if var_210_29 + var_210_21 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_29 + var_210_21
					end

					if var_210_24.prefab_name ~= "" and arg_207_1.actors_[var_210_24.prefab_name] ~= nil then
						local var_210_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_24.prefab_name].transform, "story_v_out_302031", "302031053", "story_v_out_302031.awb")

						arg_207_1:RecordAudio("302031053", var_210_30)
						arg_207_1:RecordAudio("302031053", var_210_30)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_302031", "302031053", "story_v_out_302031.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_302031", "302031053", "story_v_out_302031.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_31 = math.max(var_210_22, arg_207_1.talkMaxDuration)

			if var_210_21 <= arg_207_1.time_ and arg_207_1.time_ < var_210_21 + var_210_31 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_21) / var_210_31

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_21 + var_210_31 and arg_207_1.time_ < var_210_21 + var_210_31 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play302031054 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 302031054
		arg_211_1.duration_ = 2.43

		local var_211_0 = {
			zh = 2.433,
			ja = 1.999999999999
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
				arg_211_0:Play302031055(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1166ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1166ui_story == nil then
				arg_211_1.var_.characterEffect1166ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect1166ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1166ui_story then
				arg_211_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_214_4 = arg_211_1.actors_["1084ui_story"]
			local var_214_5 = 0

			if var_214_5 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect1084ui_story == nil then
				arg_211_1.var_.characterEffect1084ui_story = var_214_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_6 = 0.200000002980232

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_6 and not isNil(var_214_4) then
				local var_214_7 = (arg_211_1.time_ - var_214_5) / var_214_6

				if arg_211_1.var_.characterEffect1084ui_story and not isNil(var_214_4) then
					local var_214_8 = Mathf.Lerp(0, 0.5, var_214_7)

					arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1084ui_story.fillRatio = var_214_8
				end
			end

			if arg_211_1.time_ >= var_214_5 + var_214_6 and arg_211_1.time_ < var_214_5 + var_214_6 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect1084ui_story then
				local var_214_9 = 0.5

				arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1084ui_story.fillRatio = var_214_9
			end

			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 then
				arg_211_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_1")
			end

			local var_214_11 = 0

			if var_214_11 < arg_211_1.time_ and arg_211_1.time_ <= var_214_11 + arg_214_0 then
				arg_211_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_214_12 = 0
			local var_214_13 = 0.25

			if var_214_12 < arg_211_1.time_ and arg_211_1.time_ <= var_214_12 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_14 = arg_211_1:FormatText(StoryNameCfg[32].name)

				arg_211_1.leftNameTxt_.text = var_214_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_15 = arg_211_1:GetWordFromCfg(302031054)
				local var_214_16 = arg_211_1:FormatText(var_214_15.content)

				arg_211_1.text_.text = var_214_16

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_17 = 10
				local var_214_18 = utf8.len(var_214_16)
				local var_214_19 = var_214_17 <= 0 and var_214_13 or var_214_13 * (var_214_18 / var_214_17)

				if var_214_19 > 0 and var_214_13 < var_214_19 then
					arg_211_1.talkMaxDuration = var_214_19

					if var_214_19 + var_214_12 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_19 + var_214_12
					end
				end

				arg_211_1.text_.text = var_214_16
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031054", "story_v_out_302031.awb") ~= 0 then
					local var_214_20 = manager.audio:GetVoiceLength("story_v_out_302031", "302031054", "story_v_out_302031.awb") / 1000

					if var_214_20 + var_214_12 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_20 + var_214_12
					end

					if var_214_15.prefab_name ~= "" and arg_211_1.actors_[var_214_15.prefab_name] ~= nil then
						local var_214_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_15.prefab_name].transform, "story_v_out_302031", "302031054", "story_v_out_302031.awb")

						arg_211_1:RecordAudio("302031054", var_214_21)
						arg_211_1:RecordAudio("302031054", var_214_21)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_302031", "302031054", "story_v_out_302031.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_302031", "302031054", "story_v_out_302031.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_22 = math.max(var_214_13, arg_211_1.talkMaxDuration)

			if var_214_12 <= arg_211_1.time_ and arg_211_1.time_ < var_214_12 + var_214_22 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_12) / var_214_22

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_12 + var_214_22 and arg_211_1.time_ < var_214_12 + var_214_22 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play302031055 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 302031055
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play302031056(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1166ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1166ui_story == nil then
				arg_215_1.var_.characterEffect1166ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1166ui_story and not isNil(var_218_0) then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1166ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1166ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1166ui_story.fillRatio = var_218_5
			end

			local var_218_6 = 0
			local var_218_7 = 0.175

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_8 = arg_215_1:FormatText(StoryNameCfg[7].name)

				arg_215_1.leftNameTxt_.text = var_218_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_9 = arg_215_1:GetWordFromCfg(302031055)
				local var_218_10 = arg_215_1:FormatText(var_218_9.content)

				arg_215_1.text_.text = var_218_10

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 7
				local var_218_12 = utf8.len(var_218_10)
				local var_218_13 = var_218_11 <= 0 and var_218_7 or var_218_7 * (var_218_12 / var_218_11)

				if var_218_13 > 0 and var_218_7 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_10
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_14 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_14 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_14

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_14 and arg_215_1.time_ < var_218_6 + var_218_14 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play302031056 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 302031056
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play302031057(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1166ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1166ui_story = var_222_0.localPosition

				local var_222_2 = GameObjectTools.GetOrAddComponent(var_222_0.gameObject, typeof(DynamicBoneHelper))

				if var_222_2 then
					var_222_2:EnableDynamicBone(false)
				end
			end

			local var_222_3 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_3 then
				local var_222_4 = (arg_219_1.time_ - var_222_1) / var_222_3
				local var_222_5 = Vector3.New(0, 100, 0)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1166ui_story, var_222_5, var_222_4)

				local var_222_6 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_6.x, var_222_6.y, var_222_6.z)

				local var_222_7 = var_222_0.localEulerAngles

				var_222_7.z = 0
				var_222_7.x = 0
				var_222_0.localEulerAngles = var_222_7
			end

			if arg_219_1.time_ >= var_222_1 + var_222_3 and arg_219_1.time_ < var_222_1 + var_222_3 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, 100, 0)

				local var_222_8 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_8.x, var_222_8.y, var_222_8.z)

				local var_222_9 = var_222_0.localEulerAngles

				var_222_9.z = 0
				var_222_9.x = 0
				var_222_0.localEulerAngles = var_222_9

				local var_222_10 = GameObjectTools.GetOrAddComponent(var_222_0.gameObject, typeof(DynamicBoneHelper))

				if var_222_10 then
					var_222_10:EnableDynamicBone(true)
				end
			end

			local var_222_11 = arg_219_1.actors_["1084ui_story"].transform
			local var_222_12 = 0

			if var_222_12 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 then
				arg_219_1.var_.moveOldPos1084ui_story = var_222_11.localPosition
			end

			local var_222_13 = 0.001

			if var_222_12 <= arg_219_1.time_ and arg_219_1.time_ < var_222_12 + var_222_13 then
				local var_222_14 = (arg_219_1.time_ - var_222_12) / var_222_13
				local var_222_15 = Vector3.New(0, 100, 0)

				var_222_11.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1084ui_story, var_222_15, var_222_14)

				local var_222_16 = manager.ui.mainCamera.transform.position - var_222_11.position

				var_222_11.forward = Vector3.New(var_222_16.x, var_222_16.y, var_222_16.z)

				local var_222_17 = var_222_11.localEulerAngles

				var_222_17.z = 0
				var_222_17.x = 0
				var_222_11.localEulerAngles = var_222_17
			end

			if arg_219_1.time_ >= var_222_12 + var_222_13 and arg_219_1.time_ < var_222_12 + var_222_13 + arg_222_0 then
				var_222_11.localPosition = Vector3.New(0, 100, 0)

				local var_222_18 = manager.ui.mainCamera.transform.position - var_222_11.position

				var_222_11.forward = Vector3.New(var_222_18.x, var_222_18.y, var_222_18.z)

				local var_222_19 = var_222_11.localEulerAngles

				var_222_19.z = 0
				var_222_19.x = 0
				var_222_11.localEulerAngles = var_222_19
			end

			local var_222_20 = 0
			local var_222_21 = 1.35

			if var_222_20 < arg_219_1.time_ and arg_219_1.time_ <= var_222_20 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_22 = arg_219_1:GetWordFromCfg(302031056)
				local var_222_23 = arg_219_1:FormatText(var_222_22.content)

				arg_219_1.text_.text = var_222_23

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_24 = 54
				local var_222_25 = utf8.len(var_222_23)
				local var_222_26 = var_222_24 <= 0 and var_222_21 or var_222_21 * (var_222_25 / var_222_24)

				if var_222_26 > 0 and var_222_21 < var_222_26 then
					arg_219_1.talkMaxDuration = var_222_26

					if var_222_26 + var_222_20 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_26 + var_222_20
					end
				end

				arg_219_1.text_.text = var_222_23
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_27 = math.max(var_222_21, arg_219_1.talkMaxDuration)

			if var_222_20 <= arg_219_1.time_ and arg_219_1.time_ < var_222_20 + var_222_27 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_20) / var_222_27

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_20 + var_222_27 and arg_219_1.time_ < var_222_20 + var_222_27 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play302031057 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 302031057
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play302031058(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 1.35

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

				local var_226_2 = arg_223_1:GetWordFromCfg(302031057)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 54
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
	Play302031058 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 302031058
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play302031059(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.15

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[7].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(302031058)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 6
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
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_8 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_8 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_8

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_8 and arg_227_1.time_ < var_230_0 + var_230_8 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play302031059 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 302031059
		arg_231_1.duration_ = 9

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play302031060(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 2

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				local var_234_1 = manager.ui.mainCamera.transform.localPosition
				local var_234_2 = Vector3.New(0, 0, 10) + Vector3.New(var_234_1.x, var_234_1.y, 0)
				local var_234_3 = arg_231_1.bgs_.I27f

				var_234_3.transform.localPosition = var_234_2
				var_234_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_4 = var_234_3:GetComponent("SpriteRenderer")

				if var_234_4 and var_234_4.sprite then
					local var_234_5 = (var_234_3.transform.localPosition - var_234_1).z
					local var_234_6 = manager.ui.mainCameraCom_
					local var_234_7 = 2 * var_234_5 * Mathf.Tan(var_234_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_234_8 = var_234_7 * var_234_6.aspect
					local var_234_9 = var_234_4.sprite.bounds.size.x
					local var_234_10 = var_234_4.sprite.bounds.size.y
					local var_234_11 = var_234_8 / var_234_9
					local var_234_12 = var_234_7 / var_234_10
					local var_234_13 = var_234_12 < var_234_11 and var_234_11 or var_234_12

					var_234_3.transform.localScale = Vector3.New(var_234_13, var_234_13, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "I27f" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_14 = 3.999999999999

			if var_234_14 < arg_231_1.time_ and arg_231_1.time_ <= var_234_14 + arg_234_0 then
				arg_231_1.allBtn_.enabled = false
			end

			local var_234_15 = 0.3

			if arg_231_1.time_ >= var_234_14 + var_234_15 and arg_231_1.time_ < var_234_14 + var_234_15 + arg_234_0 then
				arg_231_1.allBtn_.enabled = true
			end

			local var_234_16 = 0

			if var_234_16 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_17 = 2

			if var_234_16 <= arg_231_1.time_ and arg_231_1.time_ < var_234_16 + var_234_17 then
				local var_234_18 = (arg_231_1.time_ - var_234_16) / var_234_17
				local var_234_19 = Color.New(0, 0, 0)

				var_234_19.a = Mathf.Lerp(0, 1, var_234_18)
				arg_231_1.mask_.color = var_234_19
			end

			if arg_231_1.time_ >= var_234_16 + var_234_17 and arg_231_1.time_ < var_234_16 + var_234_17 + arg_234_0 then
				local var_234_20 = Color.New(0, 0, 0)

				var_234_20.a = 1
				arg_231_1.mask_.color = var_234_20
			end

			local var_234_21 = 2

			if var_234_21 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_22 = 2

			if var_234_21 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_22 then
				local var_234_23 = (arg_231_1.time_ - var_234_21) / var_234_22
				local var_234_24 = Color.New(0, 0, 0)

				var_234_24.a = Mathf.Lerp(1, 0, var_234_23)
				arg_231_1.mask_.color = var_234_24
			end

			if arg_231_1.time_ >= var_234_21 + var_234_22 and arg_231_1.time_ < var_234_21 + var_234_22 + arg_234_0 then
				local var_234_25 = Color.New(0, 0, 0)
				local var_234_26 = 0

				arg_231_1.mask_.enabled = false
				var_234_25.a = var_234_26
				arg_231_1.mask_.color = var_234_25
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_27 = 3.999999999999
			local var_234_28 = 1.55

			if var_234_27 < arg_231_1.time_ and arg_231_1.time_ <= var_234_27 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_29 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_29:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_30 = arg_231_1:GetWordFromCfg(302031059)
				local var_234_31 = arg_231_1:FormatText(var_234_30.content)

				arg_231_1.text_.text = var_234_31

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_32 = 62
				local var_234_33 = utf8.len(var_234_31)
				local var_234_34 = var_234_32 <= 0 and var_234_28 or var_234_28 * (var_234_33 / var_234_32)

				if var_234_34 > 0 and var_234_28 < var_234_34 then
					arg_231_1.talkMaxDuration = var_234_34
					var_234_27 = var_234_27 + 0.3

					if var_234_34 + var_234_27 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_34 + var_234_27
					end
				end

				arg_231_1.text_.text = var_234_31
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_35 = var_234_27 + 0.3
			local var_234_36 = math.max(var_234_28, arg_231_1.talkMaxDuration)

			if var_234_35 <= arg_231_1.time_ and arg_231_1.time_ < var_234_35 + var_234_36 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_35) / var_234_36

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_35 + var_234_36 and arg_231_1.time_ < var_234_35 + var_234_36 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play302031060 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 302031060
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play302031061(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 1.125

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_2 = arg_237_1:GetWordFromCfg(302031060)
				local var_240_3 = arg_237_1:FormatText(var_240_2.content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 45
				local var_240_5 = utf8.len(var_240_3)
				local var_240_6 = var_240_4 <= 0 and var_240_1 or var_240_1 * (var_240_5 / var_240_4)

				if var_240_6 > 0 and var_240_1 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_7 and arg_237_1.time_ < var_240_0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play302031061 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 302031061
		arg_241_1.duration_ = 4.43

		local var_241_0 = {
			zh = 4.433,
			ja = 3.866
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
				arg_241_0:Play302031062(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = "10141ui_story"

			if arg_241_1.actors_[var_244_0] == nil then
				local var_244_1 = Asset.Load("Char/" .. "10141ui_story")

				if not isNil(var_244_1) then
					local var_244_2 = Object.Instantiate(Asset.Load("Char/" .. "10141ui_story"), arg_241_1.stage_.transform)

					var_244_2.name = var_244_0
					var_244_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_241_1.actors_[var_244_0] = var_244_2

					local var_244_3 = var_244_2:GetComponentInChildren(typeof(CharacterEffect))

					var_244_3.enabled = true

					local var_244_4 = GameObjectTools.GetOrAddComponent(var_244_2, typeof(DynamicBoneHelper))

					if var_244_4 then
						var_244_4:EnableDynamicBone(false)
					end

					arg_241_1:ShowWeapon(var_244_3.transform, false)

					arg_241_1.var_[var_244_0 .. "Animator"] = var_244_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_241_1.var_[var_244_0 .. "Animator"].applyRootMotion = true
					arg_241_1.var_[var_244_0 .. "LipSync"] = var_244_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_244_5 = arg_241_1.actors_["10141ui_story"].transform
			local var_244_6 = 0

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.var_.moveOldPos10141ui_story = var_244_5.localPosition

				local var_244_7 = GameObjectTools.GetOrAddComponent(var_244_5.gameObject, typeof(DynamicBoneHelper))

				if var_244_7 then
					var_244_7:EnableDynamicBone(false)
				end
			end

			local var_244_8 = 0.001

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_8 then
				local var_244_9 = (arg_241_1.time_ - var_244_6) / var_244_8
				local var_244_10 = Vector3.New(0, -1.16, -6.15)

				var_244_5.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10141ui_story, var_244_10, var_244_9)

				local var_244_11 = manager.ui.mainCamera.transform.position - var_244_5.position

				var_244_5.forward = Vector3.New(var_244_11.x, var_244_11.y, var_244_11.z)

				local var_244_12 = var_244_5.localEulerAngles

				var_244_12.z = 0
				var_244_12.x = 0
				var_244_5.localEulerAngles = var_244_12
			end

			if arg_241_1.time_ >= var_244_6 + var_244_8 and arg_241_1.time_ < var_244_6 + var_244_8 + arg_244_0 then
				var_244_5.localPosition = Vector3.New(0, -1.16, -6.15)

				local var_244_13 = manager.ui.mainCamera.transform.position - var_244_5.position

				var_244_5.forward = Vector3.New(var_244_13.x, var_244_13.y, var_244_13.z)

				local var_244_14 = var_244_5.localEulerAngles

				var_244_14.z = 0
				var_244_14.x = 0
				var_244_5.localEulerAngles = var_244_14

				local var_244_15 = GameObjectTools.GetOrAddComponent(var_244_5.gameObject, typeof(DynamicBoneHelper))

				if var_244_15 then
					var_244_15:EnableDynamicBone(true)
				end
			end

			local var_244_16 = arg_241_1.actors_["10141ui_story"]
			local var_244_17 = 0

			if var_244_17 < arg_241_1.time_ and arg_241_1.time_ <= var_244_17 + arg_244_0 and not isNil(var_244_16) and arg_241_1.var_.characterEffect10141ui_story == nil then
				arg_241_1.var_.characterEffect10141ui_story = var_244_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_18 = 0.200000002980232

			if var_244_17 <= arg_241_1.time_ and arg_241_1.time_ < var_244_17 + var_244_18 and not isNil(var_244_16) then
				local var_244_19 = (arg_241_1.time_ - var_244_17) / var_244_18

				if arg_241_1.var_.characterEffect10141ui_story and not isNil(var_244_16) then
					arg_241_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_17 + var_244_18 and arg_241_1.time_ < var_244_17 + var_244_18 + arg_244_0 and not isNil(var_244_16) and arg_241_1.var_.characterEffect10141ui_story then
				arg_241_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_244_20 = 0

			if var_244_20 < arg_241_1.time_ and arg_241_1.time_ <= var_244_20 + arg_244_0 then
				arg_241_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action16_1")
			end

			local var_244_21 = 0

			if var_244_21 < arg_241_1.time_ and arg_241_1.time_ <= var_244_21 + arg_244_0 then
				arg_241_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_244_22 = 0
			local var_244_23 = 0.45

			if var_244_22 < arg_241_1.time_ and arg_241_1.time_ <= var_244_22 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_24 = arg_241_1:FormatText(StoryNameCfg[1551].name)

				arg_241_1.leftNameTxt_.text = var_244_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_25 = arg_241_1:GetWordFromCfg(302031061)
				local var_244_26 = arg_241_1:FormatText(var_244_25.content)

				arg_241_1.text_.text = var_244_26

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_27 = 18
				local var_244_28 = utf8.len(var_244_26)
				local var_244_29 = var_244_27 <= 0 and var_244_23 or var_244_23 * (var_244_28 / var_244_27)

				if var_244_29 > 0 and var_244_23 < var_244_29 then
					arg_241_1.talkMaxDuration = var_244_29

					if var_244_29 + var_244_22 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_29 + var_244_22
					end
				end

				arg_241_1.text_.text = var_244_26
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031061", "story_v_out_302031.awb") ~= 0 then
					local var_244_30 = manager.audio:GetVoiceLength("story_v_out_302031", "302031061", "story_v_out_302031.awb") / 1000

					if var_244_30 + var_244_22 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_30 + var_244_22
					end

					if var_244_25.prefab_name ~= "" and arg_241_1.actors_[var_244_25.prefab_name] ~= nil then
						local var_244_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_25.prefab_name].transform, "story_v_out_302031", "302031061", "story_v_out_302031.awb")

						arg_241_1:RecordAudio("302031061", var_244_31)
						arg_241_1:RecordAudio("302031061", var_244_31)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_302031", "302031061", "story_v_out_302031.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_302031", "302031061", "story_v_out_302031.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_32 = math.max(var_244_23, arg_241_1.talkMaxDuration)

			if var_244_22 <= arg_241_1.time_ and arg_241_1.time_ < var_244_22 + var_244_32 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_22) / var_244_32

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_22 + var_244_32 and arg_241_1.time_ < var_244_22 + var_244_32 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play302031062 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 302031062
		arg_245_1.duration_ = 7.17

		local var_245_0 = {
			zh = 7.166,
			ja = 5.933
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
				arg_245_0:Play302031063(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141actionlink/10141action41623")
			end

			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_248_2 = 0
			local var_248_3 = 0.875

			if var_248_2 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_4 = arg_245_1:FormatText(StoryNameCfg[1551].name)

				arg_245_1.leftNameTxt_.text = var_248_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_5 = arg_245_1:GetWordFromCfg(302031062)
				local var_248_6 = arg_245_1:FormatText(var_248_5.content)

				arg_245_1.text_.text = var_248_6

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031062", "story_v_out_302031.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031062", "story_v_out_302031.awb") / 1000

					if var_248_10 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_2
					end

					if var_248_5.prefab_name ~= "" and arg_245_1.actors_[var_248_5.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_5.prefab_name].transform, "story_v_out_302031", "302031062", "story_v_out_302031.awb")

						arg_245_1:RecordAudio("302031062", var_248_11)
						arg_245_1:RecordAudio("302031062", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_302031", "302031062", "story_v_out_302031.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_302031", "302031062", "story_v_out_302031.awb")
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
	Play302031063 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 302031063
		arg_249_1.duration_ = 4.13

		local var_249_0 = {
			zh = 4.133,
			ja = 3.3
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
				arg_249_0:Play302031064(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10141ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos10141ui_story = var_252_0.localPosition

				local var_252_2 = GameObjectTools.GetOrAddComponent(var_252_0.gameObject, typeof(DynamicBoneHelper))

				if var_252_2 then
					var_252_2:EnableDynamicBone(false)
				end
			end

			local var_252_3 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_3 then
				local var_252_4 = (arg_249_1.time_ - var_252_1) / var_252_3
				local var_252_5 = Vector3.New(0, 100, 0)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10141ui_story, var_252_5, var_252_4)

				local var_252_6 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_6.x, var_252_6.y, var_252_6.z)

				local var_252_7 = var_252_0.localEulerAngles

				var_252_7.z = 0
				var_252_7.x = 0
				var_252_0.localEulerAngles = var_252_7
			end

			if arg_249_1.time_ >= var_252_1 + var_252_3 and arg_249_1.time_ < var_252_1 + var_252_3 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, 100, 0)

				local var_252_8 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_8.x, var_252_8.y, var_252_8.z)

				local var_252_9 = var_252_0.localEulerAngles

				var_252_9.z = 0
				var_252_9.x = 0
				var_252_0.localEulerAngles = var_252_9

				local var_252_10 = GameObjectTools.GetOrAddComponent(var_252_0.gameObject, typeof(DynamicBoneHelper))

				if var_252_10 then
					var_252_10:EnableDynamicBone(true)
				end
			end

			local var_252_11 = arg_249_1.actors_["1084ui_story"].transform
			local var_252_12 = 0

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 then
				arg_249_1.var_.moveOldPos1084ui_story = var_252_11.localPosition
			end

			local var_252_13 = 0.001

			if var_252_12 <= arg_249_1.time_ and arg_249_1.time_ < var_252_12 + var_252_13 then
				local var_252_14 = (arg_249_1.time_ - var_252_12) / var_252_13
				local var_252_15 = Vector3.New(0, -0.97, -6)

				var_252_11.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1084ui_story, var_252_15, var_252_14)

				local var_252_16 = manager.ui.mainCamera.transform.position - var_252_11.position

				var_252_11.forward = Vector3.New(var_252_16.x, var_252_16.y, var_252_16.z)

				local var_252_17 = var_252_11.localEulerAngles

				var_252_17.z = 0
				var_252_17.x = 0
				var_252_11.localEulerAngles = var_252_17
			end

			if arg_249_1.time_ >= var_252_12 + var_252_13 and arg_249_1.time_ < var_252_12 + var_252_13 + arg_252_0 then
				var_252_11.localPosition = Vector3.New(0, -0.97, -6)

				local var_252_18 = manager.ui.mainCamera.transform.position - var_252_11.position

				var_252_11.forward = Vector3.New(var_252_18.x, var_252_18.y, var_252_18.z)

				local var_252_19 = var_252_11.localEulerAngles

				var_252_19.z = 0
				var_252_19.x = 0
				var_252_11.localEulerAngles = var_252_19
			end

			local var_252_20 = arg_249_1.actors_["1084ui_story"]
			local var_252_21 = 0

			if var_252_21 < arg_249_1.time_ and arg_249_1.time_ <= var_252_21 + arg_252_0 and not isNil(var_252_20) and arg_249_1.var_.characterEffect1084ui_story == nil then
				arg_249_1.var_.characterEffect1084ui_story = var_252_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_22 = 0.200000002980232

			if var_252_21 <= arg_249_1.time_ and arg_249_1.time_ < var_252_21 + var_252_22 and not isNil(var_252_20) then
				local var_252_23 = (arg_249_1.time_ - var_252_21) / var_252_22

				if arg_249_1.var_.characterEffect1084ui_story and not isNil(var_252_20) then
					arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_21 + var_252_22 and arg_249_1.time_ < var_252_21 + var_252_22 + arg_252_0 and not isNil(var_252_20) and arg_249_1.var_.characterEffect1084ui_story then
				arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_252_24 = arg_249_1.actors_["10141ui_story"]
			local var_252_25 = 0

			if var_252_25 < arg_249_1.time_ and arg_249_1.time_ <= var_252_25 + arg_252_0 and not isNil(var_252_24) and arg_249_1.var_.characterEffect10141ui_story == nil then
				arg_249_1.var_.characterEffect10141ui_story = var_252_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_26 = 0.200000002980232

			if var_252_25 <= arg_249_1.time_ and arg_249_1.time_ < var_252_25 + var_252_26 and not isNil(var_252_24) then
				local var_252_27 = (arg_249_1.time_ - var_252_25) / var_252_26

				if arg_249_1.var_.characterEffect10141ui_story and not isNil(var_252_24) then
					local var_252_28 = Mathf.Lerp(0, 0.5, var_252_27)

					arg_249_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10141ui_story.fillRatio = var_252_28
				end
			end

			if arg_249_1.time_ >= var_252_25 + var_252_26 and arg_249_1.time_ < var_252_25 + var_252_26 + arg_252_0 and not isNil(var_252_24) and arg_249_1.var_.characterEffect10141ui_story then
				local var_252_29 = 0.5

				arg_249_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10141ui_story.fillRatio = var_252_29
			end

			local var_252_30 = 0

			if var_252_30 < arg_249_1.time_ and arg_249_1.time_ <= var_252_30 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_252_31 = 0

			if var_252_31 < arg_249_1.time_ and arg_249_1.time_ <= var_252_31 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_252_32 = 0
			local var_252_33 = 0.35

			if var_252_32 < arg_249_1.time_ and arg_249_1.time_ <= var_252_32 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_34 = arg_249_1:FormatText(StoryNameCfg[6].name)

				arg_249_1.leftNameTxt_.text = var_252_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_35 = arg_249_1:GetWordFromCfg(302031063)
				local var_252_36 = arg_249_1:FormatText(var_252_35.content)

				arg_249_1.text_.text = var_252_36

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_37 = 14
				local var_252_38 = utf8.len(var_252_36)
				local var_252_39 = var_252_37 <= 0 and var_252_33 or var_252_33 * (var_252_38 / var_252_37)

				if var_252_39 > 0 and var_252_33 < var_252_39 then
					arg_249_1.talkMaxDuration = var_252_39

					if var_252_39 + var_252_32 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_39 + var_252_32
					end
				end

				arg_249_1.text_.text = var_252_36
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031063", "story_v_out_302031.awb") ~= 0 then
					local var_252_40 = manager.audio:GetVoiceLength("story_v_out_302031", "302031063", "story_v_out_302031.awb") / 1000

					if var_252_40 + var_252_32 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_40 + var_252_32
					end

					if var_252_35.prefab_name ~= "" and arg_249_1.actors_[var_252_35.prefab_name] ~= nil then
						local var_252_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_35.prefab_name].transform, "story_v_out_302031", "302031063", "story_v_out_302031.awb")

						arg_249_1:RecordAudio("302031063", var_252_41)
						arg_249_1:RecordAudio("302031063", var_252_41)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_302031", "302031063", "story_v_out_302031.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_302031", "302031063", "story_v_out_302031.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_42 = math.max(var_252_33, arg_249_1.talkMaxDuration)

			if var_252_32 <= arg_249_1.time_ and arg_249_1.time_ < var_252_32 + var_252_42 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_32) / var_252_42

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_32 + var_252_42 and arg_249_1.time_ < var_252_32 + var_252_42 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play302031064 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 302031064
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play302031065(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1084ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1084ui_story == nil then
				arg_253_1.var_.characterEffect1084ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1084ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1084ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1084ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1084ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.525

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[7].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_9 = arg_253_1:GetWordFromCfg(302031064)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 21
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
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play302031065 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 302031065
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play302031066(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.45

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(302031065)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 18
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
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_8 and arg_257_1.time_ < var_260_0 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play302031066 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 302031066
		arg_261_1.duration_ = 2.8

		local var_261_0 = {
			zh = 2.8,
			ja = 1.999999999999
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
				arg_261_0:Play302031067(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1084ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1084ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(-0.7, -0.97, -6)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1084ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = arg_261_1.actors_["1166ui_story"].transform
			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1.var_.moveOldPos1166ui_story = var_264_9.localPosition

				local var_264_11 = GameObjectTools.GetOrAddComponent(var_264_9.gameObject, typeof(DynamicBoneHelper))

				if var_264_11 then
					var_264_11:EnableDynamicBone(false)
				end
			end

			local var_264_12 = 0.001

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_12 then
				local var_264_13 = (arg_261_1.time_ - var_264_10) / var_264_12
				local var_264_14 = Vector3.New(0.7, -0.75, -6.25)

				var_264_9.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1166ui_story, var_264_14, var_264_13)

				local var_264_15 = manager.ui.mainCamera.transform.position - var_264_9.position

				var_264_9.forward = Vector3.New(var_264_15.x, var_264_15.y, var_264_15.z)

				local var_264_16 = var_264_9.localEulerAngles

				var_264_16.z = 0
				var_264_16.x = 0
				var_264_9.localEulerAngles = var_264_16
			end

			if arg_261_1.time_ >= var_264_10 + var_264_12 and arg_261_1.time_ < var_264_10 + var_264_12 + arg_264_0 then
				var_264_9.localPosition = Vector3.New(0.7, -0.75, -6.25)

				local var_264_17 = manager.ui.mainCamera.transform.position - var_264_9.position

				var_264_9.forward = Vector3.New(var_264_17.x, var_264_17.y, var_264_17.z)

				local var_264_18 = var_264_9.localEulerAngles

				var_264_18.z = 0
				var_264_18.x = 0
				var_264_9.localEulerAngles = var_264_18

				local var_264_19 = GameObjectTools.GetOrAddComponent(var_264_9.gameObject, typeof(DynamicBoneHelper))

				if var_264_19 then
					var_264_19:EnableDynamicBone(true)
				end
			end

			local var_264_20 = arg_261_1.actors_["1166ui_story"]
			local var_264_21 = 0

			if var_264_21 < arg_261_1.time_ and arg_261_1.time_ <= var_264_21 + arg_264_0 and not isNil(var_264_20) and arg_261_1.var_.characterEffect1166ui_story == nil then
				arg_261_1.var_.characterEffect1166ui_story = var_264_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_22 = 0.200000002980232

			if var_264_21 <= arg_261_1.time_ and arg_261_1.time_ < var_264_21 + var_264_22 and not isNil(var_264_20) then
				local var_264_23 = (arg_261_1.time_ - var_264_21) / var_264_22

				if arg_261_1.var_.characterEffect1166ui_story and not isNil(var_264_20) then
					arg_261_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_21 + var_264_22 and arg_261_1.time_ < var_264_21 + var_264_22 + arg_264_0 and not isNil(var_264_20) and arg_261_1.var_.characterEffect1166ui_story then
				arg_261_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_264_24 = 0

			if var_264_24 < arg_261_1.time_ and arg_261_1.time_ <= var_264_24 + arg_264_0 then
				arg_261_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_1")
			end

			local var_264_25 = 0

			if var_264_25 < arg_261_1.time_ and arg_261_1.time_ <= var_264_25 + arg_264_0 then
				arg_261_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_264_26 = 0
			local var_264_27 = 0.3

			if var_264_26 < arg_261_1.time_ and arg_261_1.time_ <= var_264_26 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_28 = arg_261_1:FormatText(StoryNameCfg[32].name)

				arg_261_1.leftNameTxt_.text = var_264_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_29 = arg_261_1:GetWordFromCfg(302031066)
				local var_264_30 = arg_261_1:FormatText(var_264_29.content)

				arg_261_1.text_.text = var_264_30

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_31 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031066", "story_v_out_302031.awb") ~= 0 then
					local var_264_34 = manager.audio:GetVoiceLength("story_v_out_302031", "302031066", "story_v_out_302031.awb") / 1000

					if var_264_34 + var_264_26 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_34 + var_264_26
					end

					if var_264_29.prefab_name ~= "" and arg_261_1.actors_[var_264_29.prefab_name] ~= nil then
						local var_264_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_29.prefab_name].transform, "story_v_out_302031", "302031066", "story_v_out_302031.awb")

						arg_261_1:RecordAudio("302031066", var_264_35)
						arg_261_1:RecordAudio("302031066", var_264_35)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_302031", "302031066", "story_v_out_302031.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_302031", "302031066", "story_v_out_302031.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play302031067 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 302031067
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play302031068(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1084ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1084ui_story = var_268_0.localPosition
			end

			local var_268_2 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2
				local var_268_4 = Vector3.New(0, 100, 0)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1084ui_story, var_268_4, var_268_3)

				local var_268_5 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_5.x, var_268_5.y, var_268_5.z)

				local var_268_6 = var_268_0.localEulerAngles

				var_268_6.z = 0
				var_268_6.x = 0
				var_268_0.localEulerAngles = var_268_6
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, 100, 0)

				local var_268_7 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_7.x, var_268_7.y, var_268_7.z)

				local var_268_8 = var_268_0.localEulerAngles

				var_268_8.z = 0
				var_268_8.x = 0
				var_268_0.localEulerAngles = var_268_8
			end

			local var_268_9 = arg_265_1.actors_["1166ui_story"].transform
			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 then
				arg_265_1.var_.moveOldPos1166ui_story = var_268_9.localPosition

				local var_268_11 = GameObjectTools.GetOrAddComponent(var_268_9.gameObject, typeof(DynamicBoneHelper))

				if var_268_11 then
					var_268_11:EnableDynamicBone(false)
				end
			end

			local var_268_12 = 0.001

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_12 then
				local var_268_13 = (arg_265_1.time_ - var_268_10) / var_268_12
				local var_268_14 = Vector3.New(0, 100, 0)

				var_268_9.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1166ui_story, var_268_14, var_268_13)

				local var_268_15 = manager.ui.mainCamera.transform.position - var_268_9.position

				var_268_9.forward = Vector3.New(var_268_15.x, var_268_15.y, var_268_15.z)

				local var_268_16 = var_268_9.localEulerAngles

				var_268_16.z = 0
				var_268_16.x = 0
				var_268_9.localEulerAngles = var_268_16
			end

			if arg_265_1.time_ >= var_268_10 + var_268_12 and arg_265_1.time_ < var_268_10 + var_268_12 + arg_268_0 then
				var_268_9.localPosition = Vector3.New(0, 100, 0)

				local var_268_17 = manager.ui.mainCamera.transform.position - var_268_9.position

				var_268_9.forward = Vector3.New(var_268_17.x, var_268_17.y, var_268_17.z)

				local var_268_18 = var_268_9.localEulerAngles

				var_268_18.z = 0
				var_268_18.x = 0
				var_268_9.localEulerAngles = var_268_18

				local var_268_19 = GameObjectTools.GetOrAddComponent(var_268_9.gameObject, typeof(DynamicBoneHelper))

				if var_268_19 then
					var_268_19:EnableDynamicBone(true)
				end
			end

			local var_268_20 = arg_265_1.actors_["1166ui_story"]
			local var_268_21 = 0

			if var_268_21 < arg_265_1.time_ and arg_265_1.time_ <= var_268_21 + arg_268_0 and not isNil(var_268_20) and arg_265_1.var_.characterEffect1166ui_story == nil then
				arg_265_1.var_.characterEffect1166ui_story = var_268_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_22 = 0.200000002980232

			if var_268_21 <= arg_265_1.time_ and arg_265_1.time_ < var_268_21 + var_268_22 and not isNil(var_268_20) then
				local var_268_23 = (arg_265_1.time_ - var_268_21) / var_268_22

				if arg_265_1.var_.characterEffect1166ui_story and not isNil(var_268_20) then
					local var_268_24 = Mathf.Lerp(0, 0.5, var_268_23)

					arg_265_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1166ui_story.fillRatio = var_268_24
				end
			end

			if arg_265_1.time_ >= var_268_21 + var_268_22 and arg_265_1.time_ < var_268_21 + var_268_22 + arg_268_0 and not isNil(var_268_20) and arg_265_1.var_.characterEffect1166ui_story then
				local var_268_25 = 0.5

				arg_265_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1166ui_story.fillRatio = var_268_25
			end

			local var_268_26 = 0
			local var_268_27 = 1.775

			if var_268_26 < arg_265_1.time_ and arg_265_1.time_ <= var_268_26 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_28 = arg_265_1:GetWordFromCfg(302031067)
				local var_268_29 = arg_265_1:FormatText(var_268_28.content)

				arg_265_1.text_.text = var_268_29

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_30 = 71
				local var_268_31 = utf8.len(var_268_29)
				local var_268_32 = var_268_30 <= 0 and var_268_27 or var_268_27 * (var_268_31 / var_268_30)

				if var_268_32 > 0 and var_268_27 < var_268_32 then
					arg_265_1.talkMaxDuration = var_268_32

					if var_268_32 + var_268_26 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_32 + var_268_26
					end
				end

				arg_265_1.text_.text = var_268_29
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_33 = math.max(var_268_27, arg_265_1.talkMaxDuration)

			if var_268_26 <= arg_265_1.time_ and arg_265_1.time_ < var_268_26 + var_268_33 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_26) / var_268_33

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_26 + var_268_33 and arg_265_1.time_ < var_268_26 + var_268_33 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play302031068 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 302031068
		arg_269_1.duration_ = 3.9

		local var_269_0 = {
			zh = 3.9,
			ja = 2.4
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
				arg_269_0:Play302031069(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1084ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1084ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, -0.97, -6)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1084ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1084ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1084ui_story == nil then
				arg_269_1.var_.characterEffect1084ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1084ui_story and not isNil(var_272_9) then
					arg_269_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1084ui_story then
				arg_269_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_272_13 = 0

			if var_272_13 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 then
				arg_269_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_272_15 = 0
			local var_272_16 = 0.375

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_17 = arg_269_1:FormatText(StoryNameCfg[6].name)

				arg_269_1.leftNameTxt_.text = var_272_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_18 = arg_269_1:GetWordFromCfg(302031068)
				local var_272_19 = arg_269_1:FormatText(var_272_18.content)

				arg_269_1.text_.text = var_272_19

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_20 = 15
				local var_272_21 = utf8.len(var_272_19)
				local var_272_22 = var_272_20 <= 0 and var_272_16 or var_272_16 * (var_272_21 / var_272_20)

				if var_272_22 > 0 and var_272_16 < var_272_22 then
					arg_269_1.talkMaxDuration = var_272_22

					if var_272_22 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_22 + var_272_15
					end
				end

				arg_269_1.text_.text = var_272_19
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031068", "story_v_out_302031.awb") ~= 0 then
					local var_272_23 = manager.audio:GetVoiceLength("story_v_out_302031", "302031068", "story_v_out_302031.awb") / 1000

					if var_272_23 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_15
					end

					if var_272_18.prefab_name ~= "" and arg_269_1.actors_[var_272_18.prefab_name] ~= nil then
						local var_272_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_18.prefab_name].transform, "story_v_out_302031", "302031068", "story_v_out_302031.awb")

						arg_269_1:RecordAudio("302031068", var_272_24)
						arg_269_1:RecordAudio("302031068", var_272_24)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_302031", "302031068", "story_v_out_302031.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_302031", "302031068", "story_v_out_302031.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_25 = math.max(var_272_16, arg_269_1.talkMaxDuration)

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_25 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_15) / var_272_25

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_15 + var_272_25 and arg_269_1.time_ < var_272_15 + var_272_25 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play302031069 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 302031069
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play302031070(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1084ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1084ui_story == nil then
				arg_273_1.var_.characterEffect1084ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1084ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1084ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1084ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1084ui_story.fillRatio = var_276_5
			end

			local var_276_6 = 0
			local var_276_7 = 0.3

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

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_9 = arg_273_1:GetWordFromCfg(302031069)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 12
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
	Play302031070 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 302031070
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play302031071(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.45

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

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(302031070)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 18
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
	Play302031071 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 302031071
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play302031072(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1084ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1084ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0, 100, 0)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1084ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, 100, 0)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = 0
			local var_284_10 = 1.6

			if var_284_9 < arg_281_1.time_ and arg_281_1.time_ <= var_284_9 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_11 = arg_281_1:GetWordFromCfg(302031071)
				local var_284_12 = arg_281_1:FormatText(var_284_11.content)

				arg_281_1.text_.text = var_284_12

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 64
				local var_284_14 = utf8.len(var_284_12)
				local var_284_15 = var_284_13 <= 0 and var_284_10 or var_284_10 * (var_284_14 / var_284_13)

				if var_284_15 > 0 and var_284_10 < var_284_15 then
					arg_281_1.talkMaxDuration = var_284_15

					if var_284_15 + var_284_9 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_15 + var_284_9
					end
				end

				arg_281_1.text_.text = var_284_12
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_16 = math.max(var_284_10, arg_281_1.talkMaxDuration)

			if var_284_9 <= arg_281_1.time_ and arg_281_1.time_ < var_284_9 + var_284_16 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_9) / var_284_16

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_9 + var_284_16 and arg_281_1.time_ < var_284_9 + var_284_16 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play302031072 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 302031072
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play302031073(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.15

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(302031072)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 6
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_8 and arg_285_1.time_ < var_288_0 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play302031073 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 302031073
		arg_289_1.duration_ = 4.1

		local var_289_0 = {
			zh = 4.1,
			ja = 1.999999999999
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
				arg_289_0:Play302031074(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1166ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1166ui_story = var_292_0.localPosition

				local var_292_2 = GameObjectTools.GetOrAddComponent(var_292_0.gameObject, typeof(DynamicBoneHelper))

				if var_292_2 then
					var_292_2:EnableDynamicBone(false)
				end
			end

			local var_292_3 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_3 then
				local var_292_4 = (arg_289_1.time_ - var_292_1) / var_292_3
				local var_292_5 = Vector3.New(0, -0.75, -6.25)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1166ui_story, var_292_5, var_292_4)

				local var_292_6 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_6.x, var_292_6.y, var_292_6.z)

				local var_292_7 = var_292_0.localEulerAngles

				var_292_7.z = 0
				var_292_7.x = 0
				var_292_0.localEulerAngles = var_292_7
			end

			if arg_289_1.time_ >= var_292_1 + var_292_3 and arg_289_1.time_ < var_292_1 + var_292_3 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0, -0.75, -6.25)

				local var_292_8 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_8.x, var_292_8.y, var_292_8.z)

				local var_292_9 = var_292_0.localEulerAngles

				var_292_9.z = 0
				var_292_9.x = 0
				var_292_0.localEulerAngles = var_292_9

				local var_292_10 = GameObjectTools.GetOrAddComponent(var_292_0.gameObject, typeof(DynamicBoneHelper))

				if var_292_10 then
					var_292_10:EnableDynamicBone(true)
				end
			end

			local var_292_11 = arg_289_1.actors_["1166ui_story"]
			local var_292_12 = 0

			if var_292_12 < arg_289_1.time_ and arg_289_1.time_ <= var_292_12 + arg_292_0 and not isNil(var_292_11) and arg_289_1.var_.characterEffect1166ui_story == nil then
				arg_289_1.var_.characterEffect1166ui_story = var_292_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_13 = 0.200000002980232

			if var_292_12 <= arg_289_1.time_ and arg_289_1.time_ < var_292_12 + var_292_13 and not isNil(var_292_11) then
				local var_292_14 = (arg_289_1.time_ - var_292_12) / var_292_13

				if arg_289_1.var_.characterEffect1166ui_story and not isNil(var_292_11) then
					arg_289_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_12 + var_292_13 and arg_289_1.time_ < var_292_12 + var_292_13 + arg_292_0 and not isNil(var_292_11) and arg_289_1.var_.characterEffect1166ui_story then
				arg_289_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_292_15 = 0

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 then
				arg_289_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_292_17 = 0
			local var_292_18 = 0.4

			if var_292_17 < arg_289_1.time_ and arg_289_1.time_ <= var_292_17 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_19 = arg_289_1:FormatText(StoryNameCfg[32].name)

				arg_289_1.leftNameTxt_.text = var_292_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_20 = arg_289_1:GetWordFromCfg(302031073)
				local var_292_21 = arg_289_1:FormatText(var_292_20.content)

				arg_289_1.text_.text = var_292_21

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_22 = 16
				local var_292_23 = utf8.len(var_292_21)
				local var_292_24 = var_292_22 <= 0 and var_292_18 or var_292_18 * (var_292_23 / var_292_22)

				if var_292_24 > 0 and var_292_18 < var_292_24 then
					arg_289_1.talkMaxDuration = var_292_24

					if var_292_24 + var_292_17 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_24 + var_292_17
					end
				end

				arg_289_1.text_.text = var_292_21
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031073", "story_v_out_302031.awb") ~= 0 then
					local var_292_25 = manager.audio:GetVoiceLength("story_v_out_302031", "302031073", "story_v_out_302031.awb") / 1000

					if var_292_25 + var_292_17 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_25 + var_292_17
					end

					if var_292_20.prefab_name ~= "" and arg_289_1.actors_[var_292_20.prefab_name] ~= nil then
						local var_292_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_20.prefab_name].transform, "story_v_out_302031", "302031073", "story_v_out_302031.awb")

						arg_289_1:RecordAudio("302031073", var_292_26)
						arg_289_1:RecordAudio("302031073", var_292_26)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_302031", "302031073", "story_v_out_302031.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_302031", "302031073", "story_v_out_302031.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_27 = math.max(var_292_18, arg_289_1.talkMaxDuration)

			if var_292_17 <= arg_289_1.time_ and arg_289_1.time_ < var_292_17 + var_292_27 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_17) / var_292_27

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_17 + var_292_27 and arg_289_1.time_ < var_292_17 + var_292_27 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play302031074 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 302031074
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play302031075(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1166ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1166ui_story == nil then
				arg_293_1.var_.characterEffect1166ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1166ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1166ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1166ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1166ui_story.fillRatio = var_296_5
			end

			local var_296_6 = 0
			local var_296_7 = 0.35

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

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_9 = arg_293_1:GetWordFromCfg(302031074)
				local var_296_10 = arg_293_1:FormatText(var_296_9.content)

				arg_293_1.text_.text = var_296_10

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 14
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
	Play302031075 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 302031075
		arg_297_1.duration_ = 8.53

		local var_297_0 = {
			zh = 4.3,
			ja = 8.533
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
				arg_297_0:Play302031076(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1084ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1084ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0.7, -0.97, -6)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1084ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = arg_297_1.actors_["1166ui_story"].transform
			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1.var_.moveOldPos1166ui_story = var_300_9.localPosition

				local var_300_11 = GameObjectTools.GetOrAddComponent(var_300_9.gameObject, typeof(DynamicBoneHelper))

				if var_300_11 then
					var_300_11:EnableDynamicBone(false)
				end
			end

			local var_300_12 = 0.001

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_12 then
				local var_300_13 = (arg_297_1.time_ - var_300_10) / var_300_12
				local var_300_14 = Vector3.New(-0.7, -0.75, -6.25)

				var_300_9.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1166ui_story, var_300_14, var_300_13)

				local var_300_15 = manager.ui.mainCamera.transform.position - var_300_9.position

				var_300_9.forward = Vector3.New(var_300_15.x, var_300_15.y, var_300_15.z)

				local var_300_16 = var_300_9.localEulerAngles

				var_300_16.z = 0
				var_300_16.x = 0
				var_300_9.localEulerAngles = var_300_16
			end

			if arg_297_1.time_ >= var_300_10 + var_300_12 and arg_297_1.time_ < var_300_10 + var_300_12 + arg_300_0 then
				var_300_9.localPosition = Vector3.New(-0.7, -0.75, -6.25)

				local var_300_17 = manager.ui.mainCamera.transform.position - var_300_9.position

				var_300_9.forward = Vector3.New(var_300_17.x, var_300_17.y, var_300_17.z)

				local var_300_18 = var_300_9.localEulerAngles

				var_300_18.z = 0
				var_300_18.x = 0
				var_300_9.localEulerAngles = var_300_18

				local var_300_19 = GameObjectTools.GetOrAddComponent(var_300_9.gameObject, typeof(DynamicBoneHelper))

				if var_300_19 then
					var_300_19:EnableDynamicBone(true)
				end
			end

			local var_300_20 = arg_297_1.actors_["1084ui_story"]
			local var_300_21 = 0

			if var_300_21 < arg_297_1.time_ and arg_297_1.time_ <= var_300_21 + arg_300_0 and not isNil(var_300_20) and arg_297_1.var_.characterEffect1084ui_story == nil then
				arg_297_1.var_.characterEffect1084ui_story = var_300_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_22 = 0.200000002980232

			if var_300_21 <= arg_297_1.time_ and arg_297_1.time_ < var_300_21 + var_300_22 and not isNil(var_300_20) then
				local var_300_23 = (arg_297_1.time_ - var_300_21) / var_300_22

				if arg_297_1.var_.characterEffect1084ui_story and not isNil(var_300_20) then
					arg_297_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_21 + var_300_22 and arg_297_1.time_ < var_300_21 + var_300_22 + arg_300_0 and not isNil(var_300_20) and arg_297_1.var_.characterEffect1084ui_story then
				arg_297_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_300_24 = 0

			if var_300_24 < arg_297_1.time_ and arg_297_1.time_ <= var_300_24 + arg_300_0 then
				arg_297_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_300_25 = 0

			if var_300_25 < arg_297_1.time_ and arg_297_1.time_ <= var_300_25 + arg_300_0 then
				arg_297_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_300_26 = 0
			local var_300_27 = 0.55

			if var_300_26 < arg_297_1.time_ and arg_297_1.time_ <= var_300_26 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_28 = arg_297_1:FormatText(StoryNameCfg[6].name)

				arg_297_1.leftNameTxt_.text = var_300_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_29 = arg_297_1:GetWordFromCfg(302031075)
				local var_300_30 = arg_297_1:FormatText(var_300_29.content)

				arg_297_1.text_.text = var_300_30

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_31 = 22
				local var_300_32 = utf8.len(var_300_30)
				local var_300_33 = var_300_31 <= 0 and var_300_27 or var_300_27 * (var_300_32 / var_300_31)

				if var_300_33 > 0 and var_300_27 < var_300_33 then
					arg_297_1.talkMaxDuration = var_300_33

					if var_300_33 + var_300_26 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_33 + var_300_26
					end
				end

				arg_297_1.text_.text = var_300_30
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031075", "story_v_out_302031.awb") ~= 0 then
					local var_300_34 = manager.audio:GetVoiceLength("story_v_out_302031", "302031075", "story_v_out_302031.awb") / 1000

					if var_300_34 + var_300_26 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_34 + var_300_26
					end

					if var_300_29.prefab_name ~= "" and arg_297_1.actors_[var_300_29.prefab_name] ~= nil then
						local var_300_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_29.prefab_name].transform, "story_v_out_302031", "302031075", "story_v_out_302031.awb")

						arg_297_1:RecordAudio("302031075", var_300_35)
						arg_297_1:RecordAudio("302031075", var_300_35)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_302031", "302031075", "story_v_out_302031.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_302031", "302031075", "story_v_out_302031.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_36 = math.max(var_300_27, arg_297_1.talkMaxDuration)

			if var_300_26 <= arg_297_1.time_ and arg_297_1.time_ < var_300_26 + var_300_36 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_26) / var_300_36

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_26 + var_300_36 and arg_297_1.time_ < var_300_26 + var_300_36 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play302031076 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 302031076
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play302031077(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1084ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1084ui_story == nil then
				arg_301_1.var_.characterEffect1084ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1084ui_story and not isNil(var_304_0) then
					local var_304_4 = Mathf.Lerp(0, 0.5, var_304_3)

					arg_301_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1084ui_story.fillRatio = var_304_4
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1084ui_story then
				local var_304_5 = 0.5

				arg_301_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1084ui_story.fillRatio = var_304_5
			end

			local var_304_6 = 0
			local var_304_7 = 1

			if var_304_6 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_8 = arg_301_1:FormatText(StoryNameCfg[7].name)

				arg_301_1.leftNameTxt_.text = var_304_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_9 = arg_301_1:GetWordFromCfg(302031076)
				local var_304_10 = arg_301_1:FormatText(var_304_9.content)

				arg_301_1.text_.text = var_304_10

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_11 = 40
				local var_304_12 = utf8.len(var_304_10)
				local var_304_13 = var_304_11 <= 0 and var_304_7 or var_304_7 * (var_304_12 / var_304_11)

				if var_304_13 > 0 and var_304_7 < var_304_13 then
					arg_301_1.talkMaxDuration = var_304_13

					if var_304_13 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_13 + var_304_6
					end
				end

				arg_301_1.text_.text = var_304_10
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_14 = math.max(var_304_7, arg_301_1.talkMaxDuration)

			if var_304_6 <= arg_301_1.time_ and arg_301_1.time_ < var_304_6 + var_304_14 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_6) / var_304_14

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_6 + var_304_14 and arg_301_1.time_ < var_304_6 + var_304_14 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play302031077 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 302031077
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play302031078(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.55

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(302031077)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 22
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_8 and arg_305_1.time_ < var_308_0 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play302031078 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 302031078
		arg_309_1.duration_ = 2.9

		local var_309_0 = {
			zh = 2.9,
			ja = 1.999999999999
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
				arg_309_0:Play302031079(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1166ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1166ui_story == nil then
				arg_309_1.var_.characterEffect1166ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1166ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1166ui_story then
				arg_309_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_312_4 = 0

			if var_312_4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_1")
			end

			local var_312_5 = 0

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_312_6 = 0
			local var_312_7 = 0.325

			if var_312_6 < arg_309_1.time_ and arg_309_1.time_ <= var_312_6 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_8 = arg_309_1:FormatText(StoryNameCfg[32].name)

				arg_309_1.leftNameTxt_.text = var_312_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_9 = arg_309_1:GetWordFromCfg(302031078)
				local var_312_10 = arg_309_1:FormatText(var_312_9.content)

				arg_309_1.text_.text = var_312_10

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_11 = 13
				local var_312_12 = utf8.len(var_312_10)
				local var_312_13 = var_312_11 <= 0 and var_312_7 or var_312_7 * (var_312_12 / var_312_11)

				if var_312_13 > 0 and var_312_7 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_6
					end
				end

				arg_309_1.text_.text = var_312_10
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031078", "story_v_out_302031.awb") ~= 0 then
					local var_312_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031078", "story_v_out_302031.awb") / 1000

					if var_312_14 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_14 + var_312_6
					end

					if var_312_9.prefab_name ~= "" and arg_309_1.actors_[var_312_9.prefab_name] ~= nil then
						local var_312_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_9.prefab_name].transform, "story_v_out_302031", "302031078", "story_v_out_302031.awb")

						arg_309_1:RecordAudio("302031078", var_312_15)
						arg_309_1:RecordAudio("302031078", var_312_15)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_302031", "302031078", "story_v_out_302031.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_302031", "302031078", "story_v_out_302031.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_16 = math.max(var_312_7, arg_309_1.talkMaxDuration)

			if var_312_6 <= arg_309_1.time_ and arg_309_1.time_ < var_312_6 + var_312_16 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_6) / var_312_16

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_6 + var_312_16 and arg_309_1.time_ < var_312_6 + var_312_16 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play302031079 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 302031079
		arg_313_1.duration_ = 5.83

		local var_313_0 = {
			zh = 4.866,
			ja = 5.833
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
				arg_313_0:Play302031080(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1084ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1084ui_story == nil then
				arg_313_1.var_.characterEffect1084ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1084ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1084ui_story then
				arg_313_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_316_4 = arg_313_1.actors_["1166ui_story"]
			local var_316_5 = 0

			if var_316_5 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 and not isNil(var_316_4) and arg_313_1.var_.characterEffect1166ui_story == nil then
				arg_313_1.var_.characterEffect1166ui_story = var_316_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_6 = 0.200000002980232

			if var_316_5 <= arg_313_1.time_ and arg_313_1.time_ < var_316_5 + var_316_6 and not isNil(var_316_4) then
				local var_316_7 = (arg_313_1.time_ - var_316_5) / var_316_6

				if arg_313_1.var_.characterEffect1166ui_story and not isNil(var_316_4) then
					local var_316_8 = Mathf.Lerp(0, 0.5, var_316_7)

					arg_313_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1166ui_story.fillRatio = var_316_8
				end
			end

			if arg_313_1.time_ >= var_316_5 + var_316_6 and arg_313_1.time_ < var_316_5 + var_316_6 + arg_316_0 and not isNil(var_316_4) and arg_313_1.var_.characterEffect1166ui_story then
				local var_316_9 = 0.5

				arg_313_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1166ui_story.fillRatio = var_316_9
			end

			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 then
				arg_313_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_316_11 = 0

			if var_316_11 < arg_313_1.time_ and arg_313_1.time_ <= var_316_11 + arg_316_0 then
				arg_313_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_316_12 = 0
			local var_316_13 = 0.525

			if var_316_12 < arg_313_1.time_ and arg_313_1.time_ <= var_316_12 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_14 = arg_313_1:FormatText(StoryNameCfg[6].name)

				arg_313_1.leftNameTxt_.text = var_316_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_15 = arg_313_1:GetWordFromCfg(302031079)
				local var_316_16 = arg_313_1:FormatText(var_316_15.content)

				arg_313_1.text_.text = var_316_16

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_17 = 21
				local var_316_18 = utf8.len(var_316_16)
				local var_316_19 = var_316_17 <= 0 and var_316_13 or var_316_13 * (var_316_18 / var_316_17)

				if var_316_19 > 0 and var_316_13 < var_316_19 then
					arg_313_1.talkMaxDuration = var_316_19

					if var_316_19 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_19 + var_316_12
					end
				end

				arg_313_1.text_.text = var_316_16
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031079", "story_v_out_302031.awb") ~= 0 then
					local var_316_20 = manager.audio:GetVoiceLength("story_v_out_302031", "302031079", "story_v_out_302031.awb") / 1000

					if var_316_20 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_20 + var_316_12
					end

					if var_316_15.prefab_name ~= "" and arg_313_1.actors_[var_316_15.prefab_name] ~= nil then
						local var_316_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_15.prefab_name].transform, "story_v_out_302031", "302031079", "story_v_out_302031.awb")

						arg_313_1:RecordAudio("302031079", var_316_21)
						arg_313_1:RecordAudio("302031079", var_316_21)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_302031", "302031079", "story_v_out_302031.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_302031", "302031079", "story_v_out_302031.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_22 = math.max(var_316_13, arg_313_1.talkMaxDuration)

			if var_316_12 <= arg_313_1.time_ and arg_313_1.time_ < var_316_12 + var_316_22 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_12) / var_316_22

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_12 + var_316_22 and arg_313_1.time_ < var_316_12 + var_316_22 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play302031080 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 302031080
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
			arg_317_1.auto_ = false
		end

		function arg_317_1.playNext_(arg_319_0)
			arg_317_1.onStoryFinished_()
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1084ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1084ui_story == nil then
				arg_317_1.var_.characterEffect1084ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1084ui_story and not isNil(var_320_0) then
					local var_320_4 = Mathf.Lerp(0, 0.5, var_320_3)

					arg_317_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1084ui_story.fillRatio = var_320_4
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1084ui_story then
				local var_320_5 = 0.5

				arg_317_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1084ui_story.fillRatio = var_320_5
			end

			local var_320_6 = 0
			local var_320_7 = 0.275

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_8 = arg_317_1:FormatText(StoryNameCfg[7].name)

				arg_317_1.leftNameTxt_.text = var_320_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_9 = arg_317_1:GetWordFromCfg(302031080)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 11
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
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_14 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_14 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_14

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_14 and arg_317_1.time_ < var_320_6 + var_320_14 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play302031034 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 302031034
		arg_321_1.duration_ = 6.1

		local var_321_0 = {
			zh = 4.9,
			ja = 6.1
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
				arg_321_0:Play302031035(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = "1027ui_story"

			if arg_321_1.actors_[var_324_0] == nil then
				local var_324_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_324_1) then
					local var_324_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_321_1.stage_.transform)

					var_324_2.name = var_324_0
					var_324_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_321_1.actors_[var_324_0] = var_324_2

					local var_324_3 = var_324_2:GetComponentInChildren(typeof(CharacterEffect))

					var_324_3.enabled = true

					local var_324_4 = GameObjectTools.GetOrAddComponent(var_324_2, typeof(DynamicBoneHelper))

					if var_324_4 then
						var_324_4:EnableDynamicBone(false)
					end

					arg_321_1:ShowWeapon(var_324_3.transform, false)

					arg_321_1.var_[var_324_0 .. "Animator"] = var_324_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_321_1.var_[var_324_0 .. "Animator"].applyRootMotion = true
					arg_321_1.var_[var_324_0 .. "LipSync"] = var_324_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_324_5 = 0

			if var_324_5 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_324_6 = "1027ui_story"

			if arg_321_1.actors_[var_324_6] == nil then
				local var_324_7 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_324_7) then
					local var_324_8 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_321_1.stage_.transform)

					var_324_8.name = var_324_6
					var_324_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_321_1.actors_[var_324_6] = var_324_8

					local var_324_9 = var_324_8:GetComponentInChildren(typeof(CharacterEffect))

					var_324_9.enabled = true

					local var_324_10 = GameObjectTools.GetOrAddComponent(var_324_8, typeof(DynamicBoneHelper))

					if var_324_10 then
						var_324_10:EnableDynamicBone(false)
					end

					arg_321_1:ShowWeapon(var_324_9.transform, false)

					arg_321_1.var_[var_324_6 .. "Animator"] = var_324_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_321_1.var_[var_324_6 .. "Animator"].applyRootMotion = true
					arg_321_1.var_[var_324_6 .. "LipSync"] = var_324_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_324_11 = 0

			if var_324_11 < arg_321_1.time_ and arg_321_1.time_ <= var_324_11 + arg_324_0 then
				arg_321_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_324_12 = 0
			local var_324_13 = 0.5

			if var_324_12 < arg_321_1.time_ and arg_321_1.time_ <= var_324_12 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_14 = arg_321_1:FormatText(StoryNameCfg[56].name)

				arg_321_1.leftNameTxt_.text = var_324_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_15 = arg_321_1:GetWordFromCfg(302031034)
				local var_324_16 = arg_321_1:FormatText(var_324_15.content)

				arg_321_1.text_.text = var_324_16

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_17 = 20
				local var_324_18 = utf8.len(var_324_16)
				local var_324_19 = var_324_17 <= 0 and var_324_13 or var_324_13 * (var_324_18 / var_324_17)

				if var_324_19 > 0 and var_324_13 < var_324_19 then
					arg_321_1.talkMaxDuration = var_324_19

					if var_324_19 + var_324_12 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_19 + var_324_12
					end
				end

				arg_321_1.text_.text = var_324_16
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031034", "story_v_out_302031.awb") ~= 0 then
					local var_324_20 = manager.audio:GetVoiceLength("story_v_out_302031", "302031034", "story_v_out_302031.awb") / 1000

					if var_324_20 + var_324_12 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_20 + var_324_12
					end

					if var_324_15.prefab_name ~= "" and arg_321_1.actors_[var_324_15.prefab_name] ~= nil then
						local var_324_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_15.prefab_name].transform, "story_v_out_302031", "302031034", "story_v_out_302031.awb")

						arg_321_1:RecordAudio("302031034", var_324_21)
						arg_321_1:RecordAudio("302031034", var_324_21)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_302031", "302031034", "story_v_out_302031.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_302031", "302031034", "story_v_out_302031.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_22 = math.max(var_324_13, arg_321_1.talkMaxDuration)

			if var_324_12 <= arg_321_1.time_ and arg_321_1.time_ < var_324_12 + var_324_22 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_12) / var_324_22

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_12 + var_324_22 and arg_321_1.time_ < var_324_12 + var_324_22 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play302031035 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 302031035
		arg_325_1.duration_ = 3.77

		local var_325_0 = {
			zh = 3.566,
			ja = 3.766
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
				arg_325_0:Play302031036(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_328_2 = 0
			local var_328_3 = 0.45

			if var_328_2 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_4 = arg_325_1:FormatText(StoryNameCfg[56].name)

				arg_325_1.leftNameTxt_.text = var_328_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_5 = arg_325_1:GetWordFromCfg(302031035)
				local var_328_6 = arg_325_1:FormatText(var_328_5.content)

				arg_325_1.text_.text = var_328_6

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 18
				local var_328_8 = utf8.len(var_328_6)
				local var_328_9 = var_328_7 <= 0 and var_328_3 or var_328_3 * (var_328_8 / var_328_7)

				if var_328_9 > 0 and var_328_3 < var_328_9 then
					arg_325_1.talkMaxDuration = var_328_9

					if var_328_9 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_6
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031035", "story_v_out_302031.awb") ~= 0 then
					local var_328_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031035", "story_v_out_302031.awb") / 1000

					if var_328_10 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_2
					end

					if var_328_5.prefab_name ~= "" and arg_325_1.actors_[var_328_5.prefab_name] ~= nil then
						local var_328_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_5.prefab_name].transform, "story_v_out_302031", "302031035", "story_v_out_302031.awb")

						arg_325_1:RecordAudio("302031035", var_328_11)
						arg_325_1:RecordAudio("302031035", var_328_11)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_302031", "302031035", "story_v_out_302031.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_302031", "302031035", "story_v_out_302031.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_12 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_12 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_12

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_12 and arg_325_1.time_ < var_328_2 + var_328_12 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/I27f"
	},
	voices = {
		"story_v_out_302031.awb"
	}
}
