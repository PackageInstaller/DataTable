return {
	Play122432001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122432001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play122432002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J10h"

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
				local var_4_5 = arg_1_1.bgs_.J10h

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
					if iter_4_0 ~= "J10h" then
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

			local var_4_28 = 1.5
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

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
			local var_4_35 = 1.1

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

				local var_4_37 = arg_1_1:GetWordFromCfg(122432001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 44
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
	Play122432002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 122432002
		arg_9_1.duration_ = 9.67

		local var_9_0 = {
			ja = 9.666,
			ko = 5.766,
			zh = 5.766
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
				arg_9_0:Play122432003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "2079ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["2079ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos2079ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -1.28, -5.6)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos2079ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["2079ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect2079ui_story == nil then
				arg_9_1.var_.characterEffect2079ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect2079ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect2079ui_story then
				arg_9_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.775

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[469].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(122432002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432002", "story_v_out_122432.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_122432", "122432002", "story_v_out_122432.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_122432", "122432002", "story_v_out_122432.awb")

						arg_9_1:RecordAudio("122432002", var_12_29)
						arg_9_1:RecordAudio("122432002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_122432", "122432002", "story_v_out_122432.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_122432", "122432002", "story_v_out_122432.awb")
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
				actorName = "2079ui_story",
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
	Play122432003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 122432003
		arg_13_1.duration_ = 11

		local var_13_0 = {
			ja = 11,
			ko = 6.233,
			zh = 6.233
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
				arg_13_0:Play122432004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["2079ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos2079ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos2079ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["2079ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect2079ui_story == nil then
				arg_13_1.var_.characterEffect2079ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect2079ui_story and not isNil(var_16_9) then
					local var_16_13 = Mathf.Lerp(0, 0.5, var_16_12)

					arg_13_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_13_1.var_.characterEffect2079ui_story.fillRatio = var_16_13
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect2079ui_story then
				local var_16_14 = 0.5

				arg_13_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_13_1.var_.characterEffect2079ui_story.fillRatio = var_16_14
			end

			local var_16_15 = "1072ui_story"

			if arg_13_1.actors_[var_16_15] == nil then
				local var_16_16 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_16_16) then
					local var_16_17 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_13_1.stage_.transform)

					var_16_17.name = var_16_15
					var_16_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_15] = var_16_17

					local var_16_18 = var_16_17:GetComponentInChildren(typeof(CharacterEffect))

					var_16_18.enabled = true

					local var_16_19 = GameObjectTools.GetOrAddComponent(var_16_17, typeof(DynamicBoneHelper))

					if var_16_19 then
						var_16_19:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_18.transform, false)

					arg_13_1.var_[var_16_15 .. "Animator"] = var_16_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_15 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_15 .. "LipSync"] = var_16_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_20 = arg_13_1.actors_["1072ui_story"].transform
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.var_.moveOldPos1072ui_story = var_16_20.localPosition
			end

			local var_16_22 = 0.001

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_21) / var_16_22
				local var_16_24 = Vector3.New(0.7, -0.71, -6)

				var_16_20.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1072ui_story, var_16_24, var_16_23)

				local var_16_25 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_25.x, var_16_25.y, var_16_25.z)

				local var_16_26 = var_16_20.localEulerAngles

				var_16_26.z = 0
				var_16_26.x = 0
				var_16_20.localEulerAngles = var_16_26
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 then
				var_16_20.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_16_27 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_27.x, var_16_27.y, var_16_27.z)

				local var_16_28 = var_16_20.localEulerAngles

				var_16_28.z = 0
				var_16_28.x = 0
				var_16_20.localEulerAngles = var_16_28
			end

			local var_16_29 = arg_13_1.actors_["1072ui_story"]
			local var_16_30 = 0

			if var_16_30 < arg_13_1.time_ and arg_13_1.time_ <= var_16_30 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect1072ui_story == nil then
				arg_13_1.var_.characterEffect1072ui_story = var_16_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_31 = 0.200000002980232

			if var_16_30 <= arg_13_1.time_ and arg_13_1.time_ < var_16_30 + var_16_31 and not isNil(var_16_29) then
				local var_16_32 = (arg_13_1.time_ - var_16_30) / var_16_31

				if arg_13_1.var_.characterEffect1072ui_story and not isNil(var_16_29) then
					arg_13_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_30 + var_16_31 and arg_13_1.time_ < var_16_30 + var_16_31 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect1072ui_story then
				arg_13_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_16_33 = 0

			if var_16_33 < arg_13_1.time_ and arg_13_1.time_ <= var_16_33 + arg_16_0 then
				arg_13_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_16_34 = 0

			if var_16_34 < arg_13_1.time_ and arg_13_1.time_ <= var_16_34 + arg_16_0 then
				arg_13_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_35 = 0
			local var_16_36 = 0.8

			if var_16_35 < arg_13_1.time_ and arg_13_1.time_ <= var_16_35 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_37 = arg_13_1:FormatText(StoryNameCfg[379].name)

				arg_13_1.leftNameTxt_.text = var_16_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_38 = arg_13_1:GetWordFromCfg(122432003)
				local var_16_39 = arg_13_1:FormatText(var_16_38.content)

				arg_13_1.text_.text = var_16_39

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_40 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432003", "story_v_out_122432.awb") ~= 0 then
					local var_16_43 = manager.audio:GetVoiceLength("story_v_out_122432", "122432003", "story_v_out_122432.awb") / 1000

					if var_16_43 + var_16_35 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_43 + var_16_35
					end

					if var_16_38.prefab_name ~= "" and arg_13_1.actors_[var_16_38.prefab_name] ~= nil then
						local var_16_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_38.prefab_name].transform, "story_v_out_122432", "122432003", "story_v_out_122432.awb")

						arg_13_1:RecordAudio("122432003", var_16_44)
						arg_13_1:RecordAudio("122432003", var_16_44)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_122432", "122432003", "story_v_out_122432.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_122432", "122432003", "story_v_out_122432.awb")
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play122432004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 122432004
		arg_17_1.duration_ = 9.4

		local var_17_0 = {
			ja = 9.4,
			ko = 2.633,
			zh = 2.633
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
				arg_17_0:Play122432005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["2079ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect2079ui_story == nil then
				arg_17_1.var_.characterEffect2079ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect2079ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect2079ui_story then
				arg_17_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_20_4 = 0

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_6 = arg_17_1.actors_["1072ui_story"]
			local var_20_7 = 0

			if var_20_7 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1072ui_story == nil then
				arg_17_1.var_.characterEffect1072ui_story = var_20_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.200000002980232

			if var_20_7 <= arg_17_1.time_ and arg_17_1.time_ < var_20_7 + var_20_8 and not isNil(var_20_6) then
				local var_20_9 = (arg_17_1.time_ - var_20_7) / var_20_8

				if arg_17_1.var_.characterEffect1072ui_story and not isNil(var_20_6) then
					local var_20_10 = Mathf.Lerp(0, 0.5, var_20_9)

					arg_17_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1072ui_story.fillRatio = var_20_10
				end
			end

			if arg_17_1.time_ >= var_20_7 + var_20_8 and arg_17_1.time_ < var_20_7 + var_20_8 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1072ui_story then
				local var_20_11 = 0.5

				arg_17_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1072ui_story.fillRatio = var_20_11
			end

			local var_20_12 = 0
			local var_20_13 = 0.4

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_14 = arg_17_1:FormatText(StoryNameCfg[469].name)

				arg_17_1.leftNameTxt_.text = var_20_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_15 = arg_17_1:GetWordFromCfg(122432004)
				local var_20_16 = arg_17_1:FormatText(var_20_15.content)

				arg_17_1.text_.text = var_20_16

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 16
				local var_20_18 = utf8.len(var_20_16)
				local var_20_19 = var_20_17 <= 0 and var_20_13 or var_20_13 * (var_20_18 / var_20_17)

				if var_20_19 > 0 and var_20_13 < var_20_19 then
					arg_17_1.talkMaxDuration = var_20_19

					if var_20_19 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_19 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_16
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432004", "story_v_out_122432.awb") ~= 0 then
					local var_20_20 = manager.audio:GetVoiceLength("story_v_out_122432", "122432004", "story_v_out_122432.awb") / 1000

					if var_20_20 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_20 + var_20_12
					end

					if var_20_15.prefab_name ~= "" and arg_17_1.actors_[var_20_15.prefab_name] ~= nil then
						local var_20_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_15.prefab_name].transform, "story_v_out_122432", "122432004", "story_v_out_122432.awb")

						arg_17_1:RecordAudio("122432004", var_20_21)
						arg_17_1:RecordAudio("122432004", var_20_21)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_122432", "122432004", "story_v_out_122432.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_122432", "122432004", "story_v_out_122432.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_22 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_22 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_22

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_22 and arg_17_1.time_ < var_20_12 + var_20_22 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play122432005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 122432005
		arg_21_1.duration_ = 5.33

		local var_21_0 = {
			ja = 5.333,
			ko = 2.466,
			zh = 2.466
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
				arg_21_0:Play122432006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1072ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1072ui_story == nil then
				arg_21_1.var_.characterEffect1072ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1072ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1072ui_story then
				arg_21_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_6 = arg_21_1.actors_["2079ui_story"]
			local var_24_7 = 0

			if var_24_7 < arg_21_1.time_ and arg_21_1.time_ <= var_24_7 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect2079ui_story == nil then
				arg_21_1.var_.characterEffect2079ui_story = var_24_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_8 = 0.200000002980232

			if var_24_7 <= arg_21_1.time_ and arg_21_1.time_ < var_24_7 + var_24_8 and not isNil(var_24_6) then
				local var_24_9 = (arg_21_1.time_ - var_24_7) / var_24_8

				if arg_21_1.var_.characterEffect2079ui_story and not isNil(var_24_6) then
					local var_24_10 = Mathf.Lerp(0, 0.5, var_24_9)

					arg_21_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_21_1.var_.characterEffect2079ui_story.fillRatio = var_24_10
				end
			end

			if arg_21_1.time_ >= var_24_7 + var_24_8 and arg_21_1.time_ < var_24_7 + var_24_8 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect2079ui_story then
				local var_24_11 = 0.5

				arg_21_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_21_1.var_.characterEffect2079ui_story.fillRatio = var_24_11
			end

			local var_24_12 = 0
			local var_24_13 = 0.225

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_14 = arg_21_1:FormatText(StoryNameCfg[379].name)

				arg_21_1.leftNameTxt_.text = var_24_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_15 = arg_21_1:GetWordFromCfg(122432005)
				local var_24_16 = arg_21_1:FormatText(var_24_15.content)

				arg_21_1.text_.text = var_24_16

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 9
				local var_24_18 = utf8.len(var_24_16)
				local var_24_19 = var_24_17 <= 0 and var_24_13 or var_24_13 * (var_24_18 / var_24_17)

				if var_24_19 > 0 and var_24_13 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19

					if var_24_19 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_16
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432005", "story_v_out_122432.awb") ~= 0 then
					local var_24_20 = manager.audio:GetVoiceLength("story_v_out_122432", "122432005", "story_v_out_122432.awb") / 1000

					if var_24_20 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_20 + var_24_12
					end

					if var_24_15.prefab_name ~= "" and arg_21_1.actors_[var_24_15.prefab_name] ~= nil then
						local var_24_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_15.prefab_name].transform, "story_v_out_122432", "122432005", "story_v_out_122432.awb")

						arg_21_1:RecordAudio("122432005", var_24_21)
						arg_21_1:RecordAudio("122432005", var_24_21)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_122432", "122432005", "story_v_out_122432.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_122432", "122432005", "story_v_out_122432.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = math.max(var_24_13, arg_21_1.talkMaxDuration)

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_12) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_12 + var_24_22 and arg_21_1.time_ < var_24_12 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play122432006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 122432006
		arg_25_1.duration_ = 9.67

		local var_25_0 = {
			ja = 9.666,
			ko = 4,
			zh = 4
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
				arg_25_0:Play122432007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["2079ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos2079ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(-0.7, -1.28, -5.6)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos2079ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["2079ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect2079ui_story == nil then
				arg_25_1.var_.characterEffect2079ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect2079ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect2079ui_story then
				arg_25_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_15 = arg_25_1.actors_["1072ui_story"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect1072ui_story == nil then
				arg_25_1.var_.characterEffect1072ui_story = var_28_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_17 = 0.200000002980232

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.characterEffect1072ui_story and not isNil(var_28_15) then
					local var_28_19 = Mathf.Lerp(0, 0.5, var_28_18)

					arg_25_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1072ui_story.fillRatio = var_28_19
				end
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect1072ui_story then
				local var_28_20 = 0.5

				arg_25_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1072ui_story.fillRatio = var_28_20
			end

			local var_28_21 = 0
			local var_28_22 = 0.6

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_23 = arg_25_1:FormatText(StoryNameCfg[469].name)

				arg_25_1.leftNameTxt_.text = var_28_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_24 = arg_25_1:GetWordFromCfg(122432006)
				local var_28_25 = arg_25_1:FormatText(var_28_24.content)

				arg_25_1.text_.text = var_28_25

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_26 = 24
				local var_28_27 = utf8.len(var_28_25)
				local var_28_28 = var_28_26 <= 0 and var_28_22 or var_28_22 * (var_28_27 / var_28_26)

				if var_28_28 > 0 and var_28_22 < var_28_28 then
					arg_25_1.talkMaxDuration = var_28_28

					if var_28_28 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_21
					end
				end

				arg_25_1.text_.text = var_28_25
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432006", "story_v_out_122432.awb") ~= 0 then
					local var_28_29 = manager.audio:GetVoiceLength("story_v_out_122432", "122432006", "story_v_out_122432.awb") / 1000

					if var_28_29 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_29 + var_28_21
					end

					if var_28_24.prefab_name ~= "" and arg_25_1.actors_[var_28_24.prefab_name] ~= nil then
						local var_28_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_24.prefab_name].transform, "story_v_out_122432", "122432006", "story_v_out_122432.awb")

						arg_25_1:RecordAudio("122432006", var_28_30)
						arg_25_1:RecordAudio("122432006", var_28_30)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_122432", "122432006", "story_v_out_122432.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_122432", "122432006", "story_v_out_122432.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_31 = math.max(var_28_22, arg_25_1.talkMaxDuration)

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_31 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_21) / var_28_31

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_21 + var_28_31 and arg_25_1.time_ < var_28_21 + var_28_31 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play122432007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 122432007
		arg_29_1.duration_ = 5.13

		local var_29_0 = {
			ja = 5.133,
			ko = 2.5,
			zh = 2.5
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
				arg_29_0:Play122432008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1072ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1072ui_story == nil then
				arg_29_1.var_.characterEffect1072ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1072ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1072ui_story then
				arg_29_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action473")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_6 = arg_29_1.actors_["2079ui_story"]
			local var_32_7 = 0

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect2079ui_story == nil then
				arg_29_1.var_.characterEffect2079ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.200000002980232

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 and not isNil(var_32_6) then
				local var_32_9 = (arg_29_1.time_ - var_32_7) / var_32_8

				if arg_29_1.var_.characterEffect2079ui_story and not isNil(var_32_6) then
					local var_32_10 = Mathf.Lerp(0, 0.5, var_32_9)

					arg_29_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_29_1.var_.characterEffect2079ui_story.fillRatio = var_32_10
				end
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect2079ui_story then
				local var_32_11 = 0.5

				arg_29_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_29_1.var_.characterEffect2079ui_story.fillRatio = var_32_11
			end

			local var_32_12 = 0
			local var_32_13 = 0.3

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_14 = arg_29_1:FormatText(StoryNameCfg[379].name)

				arg_29_1.leftNameTxt_.text = var_32_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(122432007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432007", "story_v_out_122432.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_122432", "122432007", "story_v_out_122432.awb") / 1000

					if var_32_20 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_122432", "122432007", "story_v_out_122432.awb")

						arg_29_1:RecordAudio("122432007", var_32_21)
						arg_29_1:RecordAudio("122432007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_122432", "122432007", "story_v_out_122432.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_122432", "122432007", "story_v_out_122432.awb")
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
	Play122432008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 122432008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play122432009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["2079ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos2079ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos2079ui_story, var_36_4, var_36_3)

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

			local var_36_9 = arg_33_1.actors_["1072ui_story"].transform
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.var_.moveOldPos1072ui_story = var_36_9.localPosition
			end

			local var_36_11 = 0.001

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11
				local var_36_13 = Vector3.New(0, 100, 0)

				var_36_9.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1072ui_story, var_36_13, var_36_12)

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
			local var_36_19 = 1.425

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_20 = arg_33_1:GetWordFromCfg(122432008)
				local var_36_21 = arg_33_1:FormatText(var_36_20.content)

				arg_33_1.text_.text = var_36_21

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_22 = 57
				local var_36_23 = utf8.len(var_36_21)
				local var_36_24 = var_36_22 <= 0 and var_36_19 or var_36_19 * (var_36_23 / var_36_22)

				if var_36_24 > 0 and var_36_19 < var_36_24 then
					arg_33_1.talkMaxDuration = var_36_24

					if var_36_24 + var_36_18 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_24 + var_36_18
					end
				end

				arg_33_1.text_.text = var_36_21
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_19, arg_33_1.talkMaxDuration)

			if var_36_18 <= arg_33_1.time_ and arg_33_1.time_ < var_36_18 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_18) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_18 + var_36_25 and arg_33_1.time_ < var_36_18 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play122432009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 122432009
		arg_37_1.duration_ = 9.37

		local var_37_0 = {
			ja = 9.366,
			ko = 4.8,
			zh = 4.8
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
				arg_37_0:Play122432010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1072ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1072ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -0.71, -6)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1072ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1072ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1072ui_story == nil then
				arg_37_1.var_.characterEffect1072ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1072ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1072ui_story then
				arg_37_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_15 = 0
			local var_40_16 = 0.525

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[379].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(122432009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 21
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432009", "story_v_out_122432.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_122432", "122432009", "story_v_out_122432.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_122432", "122432009", "story_v_out_122432.awb")

						arg_37_1:RecordAudio("122432009", var_40_24)
						arg_37_1:RecordAudio("122432009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_122432", "122432009", "story_v_out_122432.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_122432", "122432009", "story_v_out_122432.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play122432010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 122432010
		arg_41_1.duration_ = 3

		local var_41_0 = {
			ja = 3,
			ko = 1.766,
			zh = 1.766
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
				arg_41_0:Play122432011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1072ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1072ui_story == nil then
				arg_41_1.var_.characterEffect1072ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1072ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1072ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1072ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1072ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.25

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[443].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(122432010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432010", "story_v_out_122432.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_122432", "122432010", "story_v_out_122432.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_122432", "122432010", "story_v_out_122432.awb")

						arg_41_1:RecordAudio("122432010", var_44_15)
						arg_41_1:RecordAudio("122432010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_122432", "122432010", "story_v_out_122432.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_122432", "122432010", "story_v_out_122432.awb")
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
	Play122432011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 122432011
		arg_45_1.duration_ = 4.07

		local var_45_0 = {
			ja = 4.066,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_45_0:Play122432012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1072ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1072ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, -0.71, -6)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1072ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1072ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1072ui_story == nil then
				arg_45_1.var_.characterEffect1072ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1072ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1072ui_story then
				arg_45_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_48_15 = 0
			local var_48_16 = 0.2

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[379].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(122432011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 8
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432011", "story_v_out_122432.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_122432", "122432011", "story_v_out_122432.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_122432", "122432011", "story_v_out_122432.awb")

						arg_45_1:RecordAudio("122432011", var_48_24)
						arg_45_1:RecordAudio("122432011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_122432", "122432011", "story_v_out_122432.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_122432", "122432011", "story_v_out_122432.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play122432012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 122432012
		arg_49_1.duration_ = 5.9

		local var_49_0 = {
			ja = 5.9,
			ko = 4.2,
			zh = 4.2
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
				arg_49_0:Play122432013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1072ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1072ui_story == nil then
				arg_49_1.var_.characterEffect1072ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1072ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1072ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1072ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1072ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.425

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[443].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(122432012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 17
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432012", "story_v_out_122432.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_122432", "122432012", "story_v_out_122432.awb") / 1000

					if var_52_14 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_6
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_out_122432", "122432012", "story_v_out_122432.awb")

						arg_49_1:RecordAudio("122432012", var_52_15)
						arg_49_1:RecordAudio("122432012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_122432", "122432012", "story_v_out_122432.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_122432", "122432012", "story_v_out_122432.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_16 and arg_49_1.time_ < var_52_6 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play122432013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122432013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play122432014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1072ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1072ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1072ui_story, var_56_4, var_56_3)

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
			local var_56_10 = 0.45

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

				local var_56_11 = arg_53_1:GetWordFromCfg(122432013)
				local var_56_12 = arg_53_1:FormatText(var_56_11.content)

				arg_53_1.text_.text = var_56_12

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 18
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
				actorName = "1072ui_story",
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
	Play122432014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 122432014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play122432015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				local var_60_2 = "play"
				local var_60_3 = "effect"

				arg_57_1:AudioAction(var_60_2, var_60_3, "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			local var_60_4 = 0
			local var_60_5 = 1.575

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(122432014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_8 = 63
				local var_60_9 = utf8.len(var_60_7)
				local var_60_10 = var_60_8 <= 0 and var_60_5 or var_60_5 * (var_60_9 / var_60_8)

				if var_60_10 > 0 and var_60_5 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_11 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_11 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_11

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_11 and arg_57_1.time_ < var_60_4 + var_60_11 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play122432015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 122432015
		arg_61_1.duration_ = 14.27

		local var_61_0 = {
			ja = 14.266,
			ko = 8.933,
			zh = 8.933
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
				arg_61_0:Play122432016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1072ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1072ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, -0.71, -6)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1072ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1072ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1072ui_story == nil then
				arg_61_1.var_.characterEffect1072ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1072ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1072ui_story then
				arg_61_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_64_15 = 0
			local var_64_16 = 0.875

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[379].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(122432015)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432015", "story_v_out_122432.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_out_122432", "122432015", "story_v_out_122432.awb") / 1000

					if var_64_23 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_15
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_out_122432", "122432015", "story_v_out_122432.awb")

						arg_61_1:RecordAudio("122432015", var_64_24)
						arg_61_1:RecordAudio("122432015", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_122432", "122432015", "story_v_out_122432.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_122432", "122432015", "story_v_out_122432.awb")
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
				actorName = "1072ui_story",
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
	Play122432016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122432016
		arg_65_1.duration_ = 11.8

		local var_65_0 = {
			ja = 11.8,
			ko = 6.8,
			zh = 6.8
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
				arg_65_0:Play122432017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_68_2 = 0
			local var_68_3 = 0.825

			if var_68_2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_4 = arg_65_1:FormatText(StoryNameCfg[379].name)

				arg_65_1.leftNameTxt_.text = var_68_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_5 = arg_65_1:GetWordFromCfg(122432016)
				local var_68_6 = arg_65_1:FormatText(var_68_5.content)

				arg_65_1.text_.text = var_68_6

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 33
				local var_68_8 = utf8.len(var_68_6)
				local var_68_9 = var_68_7 <= 0 and var_68_3 or var_68_3 * (var_68_8 / var_68_7)

				if var_68_9 > 0 and var_68_3 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_6
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432016", "story_v_out_122432.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_122432", "122432016", "story_v_out_122432.awb") / 1000

					if var_68_10 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_2
					end

					if var_68_5.prefab_name ~= "" and arg_65_1.actors_[var_68_5.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_5.prefab_name].transform, "story_v_out_122432", "122432016", "story_v_out_122432.awb")

						arg_65_1:RecordAudio("122432016", var_68_11)
						arg_65_1:RecordAudio("122432016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_122432", "122432016", "story_v_out_122432.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_122432", "122432016", "story_v_out_122432.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_12 and arg_65_1.time_ < var_68_2 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play122432017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122432017
		arg_69_1.duration_ = 4.03

		local var_69_0 = {
			ja = 4.033,
			ko = 3.633,
			zh = 3.633
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
				arg_69_0:Play122432018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1072ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1072ui_story == nil then
				arg_69_1.var_.characterEffect1072ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1072ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1072ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1072ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1072ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.525

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[443].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(122432017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432017", "story_v_out_122432.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_122432", "122432017", "story_v_out_122432.awb") / 1000

					if var_72_14 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_6
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_out_122432", "122432017", "story_v_out_122432.awb")

						arg_69_1:RecordAudio("122432017", var_72_15)
						arg_69_1:RecordAudio("122432017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_122432", "122432017", "story_v_out_122432.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_122432", "122432017", "story_v_out_122432.awb")
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
	Play122432018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 122432018
		arg_73_1.duration_ = 5.27

		local var_73_0 = {
			ja = 5.266,
			ko = 3.8,
			zh = 3.8
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
				arg_73_0:Play122432019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.425

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[443].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(122432018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 17
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432018", "story_v_out_122432.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_122432", "122432018", "story_v_out_122432.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_122432", "122432018", "story_v_out_122432.awb")

						arg_73_1:RecordAudio("122432018", var_76_9)
						arg_73_1:RecordAudio("122432018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_122432", "122432018", "story_v_out_122432.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_122432", "122432018", "story_v_out_122432.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play122432019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 122432019
		arg_77_1.duration_ = 17.2

		local var_77_0 = {
			ja = 17.2,
			ko = 6,
			zh = 6
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
				arg_77_0:Play122432020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1072ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1072ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1072ui_story, var_80_4, var_80_3)

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

			local var_80_9 = 0
			local var_80_10 = 0.475

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_11 = arg_77_1:FormatText(StoryNameCfg[36].name)

				arg_77_1.leftNameTxt_.text = var_80_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_12 = arg_77_1:GetWordFromCfg(122432019)
				local var_80_13 = arg_77_1:FormatText(var_80_12.content)

				arg_77_1.text_.text = var_80_13

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_14 = 19
				local var_80_15 = utf8.len(var_80_13)
				local var_80_16 = var_80_14 <= 0 and var_80_10 or var_80_10 * (var_80_15 / var_80_14)

				if var_80_16 > 0 and var_80_10 < var_80_16 then
					arg_77_1.talkMaxDuration = var_80_16

					if var_80_16 + var_80_9 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_9
					end
				end

				arg_77_1.text_.text = var_80_13
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432019", "story_v_out_122432.awb") ~= 0 then
					local var_80_17 = manager.audio:GetVoiceLength("story_v_out_122432", "122432019", "story_v_out_122432.awb") / 1000

					if var_80_17 + var_80_9 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_9
					end

					if var_80_12.prefab_name ~= "" and arg_77_1.actors_[var_80_12.prefab_name] ~= nil then
						local var_80_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_12.prefab_name].transform, "story_v_out_122432", "122432019", "story_v_out_122432.awb")

						arg_77_1:RecordAudio("122432019", var_80_18)
						arg_77_1:RecordAudio("122432019", var_80_18)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_122432", "122432019", "story_v_out_122432.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_122432", "122432019", "story_v_out_122432.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_19 = math.max(var_80_10, arg_77_1.talkMaxDuration)

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_19 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_9) / var_80_19

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_9 + var_80_19 and arg_77_1.time_ < var_80_9 + var_80_19 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play122432020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 122432020
		arg_81_1.duration_ = 16.23

		local var_81_0 = {
			ja = 16.233,
			ko = 9.933,
			zh = 9.933
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
				arg_81_0:Play122432021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 1.175

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[36].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(122432020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 47
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432020", "story_v_out_122432.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_122432", "122432020", "story_v_out_122432.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_122432", "122432020", "story_v_out_122432.awb")

						arg_81_1:RecordAudio("122432020", var_84_9)
						arg_81_1:RecordAudio("122432020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_122432", "122432020", "story_v_out_122432.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_122432", "122432020", "story_v_out_122432.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play122432021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 122432021
		arg_85_1.duration_ = 4.07

		local var_85_0 = {
			ja = 4.066,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_85_0:Play122432022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["2079ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos2079ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, -1.28, -5.6)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos2079ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["2079ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect2079ui_story == nil then
				arg_85_1.var_.characterEffect2079ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect2079ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect2079ui_story then
				arg_85_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_15 = 0
			local var_88_16 = 0.075

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[469].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(122432021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 3
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432021", "story_v_out_122432.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_122432", "122432021", "story_v_out_122432.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_122432", "122432021", "story_v_out_122432.awb")

						arg_85_1:RecordAudio("122432021", var_88_24)
						arg_85_1:RecordAudio("122432021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_122432", "122432021", "story_v_out_122432.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_122432", "122432021", "story_v_out_122432.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play122432022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 122432022
		arg_89_1.duration_ = 8.33

		local var_89_0 = {
			ja = 8.333,
			ko = 3.9,
			zh = 3.9
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
				arg_89_0:Play122432023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["2079ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect2079ui_story == nil then
				arg_89_1.var_.characterEffect2079ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect2079ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_89_1.var_.characterEffect2079ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect2079ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_89_1.var_.characterEffect2079ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.475

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_8 = arg_89_1:FormatText(StoryNameCfg[36].name)

				arg_89_1.leftNameTxt_.text = var_92_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_9 = arg_89_1:GetWordFromCfg(122432022)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 19
				local var_92_12 = utf8.len(var_92_10)
				local var_92_13 = var_92_11 <= 0 and var_92_7 or var_92_7 * (var_92_12 / var_92_11)

				if var_92_13 > 0 and var_92_7 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_10
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432022", "story_v_out_122432.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_122432", "122432022", "story_v_out_122432.awb") / 1000

					if var_92_14 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_6
					end

					if var_92_9.prefab_name ~= "" and arg_89_1.actors_[var_92_9.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_9.prefab_name].transform, "story_v_out_122432", "122432022", "story_v_out_122432.awb")

						arg_89_1:RecordAudio("122432022", var_92_15)
						arg_89_1:RecordAudio("122432022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_122432", "122432022", "story_v_out_122432.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_122432", "122432022", "story_v_out_122432.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_16 and arg_89_1.time_ < var_92_6 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play122432023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 122432023
		arg_93_1.duration_ = 7.77

		local var_93_0 = {
			ja = 7.766,
			ko = 2.8,
			zh = 2.8
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play122432024(arg_93_1)
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

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[36].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(122432023)
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

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432023", "story_v_out_122432.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_122432", "122432023", "story_v_out_122432.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_122432", "122432023", "story_v_out_122432.awb")

						arg_93_1:RecordAudio("122432023", var_96_9)
						arg_93_1:RecordAudio("122432023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_122432", "122432023", "story_v_out_122432.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_122432", "122432023", "story_v_out_122432.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play122432024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 122432024
		arg_97_1.duration_ = 9

		local var_97_0 = {
			ja = 8.833,
			ko = 9,
			zh = 9
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
				arg_97_0:Play122432025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = "ST42a"

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
				local var_100_5 = arg_97_1.bgs_.ST42a

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
					if iter_100_0 ~= "ST42a" then
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

			local var_100_27 = arg_97_1.actors_["2079ui_story"].transform
			local var_100_28 = 1.96599999815226

			if var_100_28 < arg_97_1.time_ and arg_97_1.time_ <= var_100_28 + arg_100_0 then
				arg_97_1.var_.moveOldPos2079ui_story = var_100_27.localPosition
			end

			local var_100_29 = 0.001

			if var_100_28 <= arg_97_1.time_ and arg_97_1.time_ < var_100_28 + var_100_29 then
				local var_100_30 = (arg_97_1.time_ - var_100_28) / var_100_29
				local var_100_31 = Vector3.New(0, 100, 0)

				var_100_27.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos2079ui_story, var_100_31, var_100_30)

				local var_100_32 = manager.ui.mainCamera.transform.position - var_100_27.position

				var_100_27.forward = Vector3.New(var_100_32.x, var_100_32.y, var_100_32.z)

				local var_100_33 = var_100_27.localEulerAngles

				var_100_33.z = 0
				var_100_33.x = 0
				var_100_27.localEulerAngles = var_100_33
			end

			if arg_97_1.time_ >= var_100_28 + var_100_29 and arg_97_1.time_ < var_100_28 + var_100_29 + arg_100_0 then
				var_100_27.localPosition = Vector3.New(0, 100, 0)

				local var_100_34 = manager.ui.mainCamera.transform.position - var_100_27.position

				var_100_27.forward = Vector3.New(var_100_34.x, var_100_34.y, var_100_34.z)

				local var_100_35 = var_100_27.localEulerAngles

				var_100_35.z = 0
				var_100_35.x = 0
				var_100_27.localEulerAngles = var_100_35
			end

			local var_100_36 = "1074ui_story"

			if arg_97_1.actors_[var_100_36] == nil then
				local var_100_37 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_100_37) then
					local var_100_38 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_97_1.stage_.transform)

					var_100_38.name = var_100_36
					var_100_38.transform.localPosition = Vector3.New(0, 100, 0)
					arg_97_1.actors_[var_100_36] = var_100_38

					local var_100_39 = var_100_38:GetComponentInChildren(typeof(CharacterEffect))

					var_100_39.enabled = true

					local var_100_40 = GameObjectTools.GetOrAddComponent(var_100_38, typeof(DynamicBoneHelper))

					if var_100_40 then
						var_100_40:EnableDynamicBone(false)
					end

					arg_97_1:ShowWeapon(var_100_39.transform, false)

					arg_97_1.var_[var_100_36 .. "Animator"] = var_100_39.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_97_1.var_[var_100_36 .. "Animator"].applyRootMotion = true
					arg_97_1.var_[var_100_36 .. "LipSync"] = var_100_39.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_100_41 = arg_97_1.actors_["1074ui_story"].transform
			local var_100_42 = 4

			if var_100_42 < arg_97_1.time_ and arg_97_1.time_ <= var_100_42 + arg_100_0 then
				arg_97_1.var_.moveOldPos1074ui_story = var_100_41.localPosition
			end

			local var_100_43 = 0.001

			if var_100_42 <= arg_97_1.time_ and arg_97_1.time_ < var_100_42 + var_100_43 then
				local var_100_44 = (arg_97_1.time_ - var_100_42) / var_100_43
				local var_100_45 = Vector3.New(0, -1.055, -6.12)

				var_100_41.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1074ui_story, var_100_45, var_100_44)

				local var_100_46 = manager.ui.mainCamera.transform.position - var_100_41.position

				var_100_41.forward = Vector3.New(var_100_46.x, var_100_46.y, var_100_46.z)

				local var_100_47 = var_100_41.localEulerAngles

				var_100_47.z = 0
				var_100_47.x = 0
				var_100_41.localEulerAngles = var_100_47
			end

			if arg_97_1.time_ >= var_100_42 + var_100_43 and arg_97_1.time_ < var_100_42 + var_100_43 + arg_100_0 then
				var_100_41.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_100_48 = manager.ui.mainCamera.transform.position - var_100_41.position

				var_100_41.forward = Vector3.New(var_100_48.x, var_100_48.y, var_100_48.z)

				local var_100_49 = var_100_41.localEulerAngles

				var_100_49.z = 0
				var_100_49.x = 0
				var_100_41.localEulerAngles = var_100_49
			end

			local var_100_50 = arg_97_1.actors_["1074ui_story"]
			local var_100_51 = 4

			if var_100_51 < arg_97_1.time_ and arg_97_1.time_ <= var_100_51 + arg_100_0 and not isNil(var_100_50) and arg_97_1.var_.characterEffect1074ui_story == nil then
				arg_97_1.var_.characterEffect1074ui_story = var_100_50:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_52 = 0.200000002980232

			if var_100_51 <= arg_97_1.time_ and arg_97_1.time_ < var_100_51 + var_100_52 and not isNil(var_100_50) then
				local var_100_53 = (arg_97_1.time_ - var_100_51) / var_100_52

				if arg_97_1.var_.characterEffect1074ui_story and not isNil(var_100_50) then
					arg_97_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_51 + var_100_52 and arg_97_1.time_ < var_100_51 + var_100_52 + arg_100_0 and not isNil(var_100_50) and arg_97_1.var_.characterEffect1074ui_story then
				arg_97_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_100_54 = 4

			if var_100_54 < arg_97_1.time_ and arg_97_1.time_ <= var_100_54 + arg_100_0 then
				arg_97_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_100_55 = 4

			if var_100_55 < arg_97_1.time_ and arg_97_1.time_ <= var_100_55 + arg_100_0 then
				arg_97_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_100_56 = 0
			local var_100_57 = 1

			if var_100_56 < arg_97_1.time_ and arg_97_1.time_ <= var_100_56 + arg_100_0 then
				local var_100_58 = "stop"
				local var_100_59 = "effect"

				arg_97_1:AudioAction(var_100_58, var_100_59, "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_60 = 4
			local var_100_61 = 0.25

			if var_100_60 < arg_97_1.time_ and arg_97_1.time_ <= var_100_60 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_62 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_62:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_63 = arg_97_1:FormatText(StoryNameCfg[410].name)

				arg_97_1.leftNameTxt_.text = var_100_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_64 = arg_97_1:GetWordFromCfg(122432024)
				local var_100_65 = arg_97_1:FormatText(var_100_64.content)

				arg_97_1.text_.text = var_100_65

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_66 = 10
				local var_100_67 = utf8.len(var_100_65)
				local var_100_68 = var_100_66 <= 0 and var_100_61 or var_100_61 * (var_100_67 / var_100_66)

				if var_100_68 > 0 and var_100_61 < var_100_68 then
					arg_97_1.talkMaxDuration = var_100_68
					var_100_60 = var_100_60 + 0.3

					if var_100_68 + var_100_60 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_68 + var_100_60
					end
				end

				arg_97_1.text_.text = var_100_65
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432024", "story_v_out_122432.awb") ~= 0 then
					local var_100_69 = manager.audio:GetVoiceLength("story_v_out_122432", "122432024", "story_v_out_122432.awb") / 1000

					if var_100_69 + var_100_60 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_69 + var_100_60
					end

					if var_100_64.prefab_name ~= "" and arg_97_1.actors_[var_100_64.prefab_name] ~= nil then
						local var_100_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_64.prefab_name].transform, "story_v_out_122432", "122432024", "story_v_out_122432.awb")

						arg_97_1:RecordAudio("122432024", var_100_70)
						arg_97_1:RecordAudio("122432024", var_100_70)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_122432", "122432024", "story_v_out_122432.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_122432", "122432024", "story_v_out_122432.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_71 = var_100_60 + 0.3
			local var_100_72 = math.max(var_100_61, arg_97_1.talkMaxDuration)

			if var_100_71 <= arg_97_1.time_ and arg_97_1.time_ < var_100_71 + var_100_72 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_71) / var_100_72

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_71 + var_100_72 and arg_97_1.time_ < var_100_71 + var_100_72 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play122432025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 122432025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play122432026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1074ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1074ui_story = var_106_0.localPosition
			end

			local var_106_2 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2
				local var_106_4 = Vector3.New(0, 100, 0)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1074ui_story, var_106_4, var_106_3)

				local var_106_5 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_5.x, var_106_5.y, var_106_5.z)

				local var_106_6 = var_106_0.localEulerAngles

				var_106_6.z = 0
				var_106_6.x = 0
				var_106_0.localEulerAngles = var_106_6
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, 100, 0)

				local var_106_7 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_7.x, var_106_7.y, var_106_7.z)

				local var_106_8 = var_106_0.localEulerAngles

				var_106_8.z = 0
				var_106_8.x = 0
				var_106_0.localEulerAngles = var_106_8
			end

			local var_106_9 = 0
			local var_106_10 = 1.525

			if var_106_9 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_11 = arg_103_1:GetWordFromCfg(122432025)
				local var_106_12 = arg_103_1:FormatText(var_106_11.content)

				arg_103_1.text_.text = var_106_12

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 61
				local var_106_14 = utf8.len(var_106_12)
				local var_106_15 = var_106_13 <= 0 and var_106_10 or var_106_10 * (var_106_14 / var_106_13)

				if var_106_15 > 0 and var_106_10 < var_106_15 then
					arg_103_1.talkMaxDuration = var_106_15

					if var_106_15 + var_106_9 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_15 + var_106_9
					end
				end

				arg_103_1.text_.text = var_106_12
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_16 = math.max(var_106_10, arg_103_1.talkMaxDuration)

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_16 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_9) / var_106_16

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_9 + var_106_16 and arg_103_1.time_ < var_106_9 + var_106_16 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play122432026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 122432026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play122432027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1.125

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

				local var_110_2 = arg_107_1:GetWordFromCfg(122432026)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 45
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
	Play122432027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 122432027
		arg_111_1.duration_ = 15.73

		local var_111_0 = {
			ja = 15.733,
			ko = 9,
			zh = 9
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
				arg_111_0:Play122432028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1074ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1074ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1074ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["1074ui_story"]
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect1074ui_story == nil then
				arg_111_1.var_.characterEffect1074ui_story = var_114_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_11 = 0.200000002980232

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 and not isNil(var_114_9) then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11

				if arg_111_1.var_.characterEffect1074ui_story and not isNil(var_114_9) then
					arg_111_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect1074ui_story then
				arg_111_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_114_13 = 0

			if var_114_13 < arg_111_1.time_ and arg_111_1.time_ <= var_114_13 + arg_114_0 then
				arg_111_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_114_14 = 0

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				arg_111_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_15 = "1075ui_story"

			if arg_111_1.actors_[var_114_15] == nil then
				local var_114_16 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_114_16) then
					local var_114_17 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_111_1.stage_.transform)

					var_114_17.name = var_114_15
					var_114_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_111_1.actors_[var_114_15] = var_114_17

					local var_114_18 = var_114_17:GetComponentInChildren(typeof(CharacterEffect))

					var_114_18.enabled = true

					local var_114_19 = GameObjectTools.GetOrAddComponent(var_114_17, typeof(DynamicBoneHelper))

					if var_114_19 then
						var_114_19:EnableDynamicBone(false)
					end

					arg_111_1:ShowWeapon(var_114_18.transform, false)

					arg_111_1.var_[var_114_15 .. "Animator"] = var_114_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_111_1.var_[var_114_15 .. "Animator"].applyRootMotion = true
					arg_111_1.var_[var_114_15 .. "LipSync"] = var_114_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_114_20 = arg_111_1.actors_["1075ui_story"].transform
			local var_114_21 = 0

			if var_114_21 < arg_111_1.time_ and arg_111_1.time_ <= var_114_21 + arg_114_0 then
				arg_111_1.var_.moveOldPos1075ui_story = var_114_20.localPosition
			end

			local var_114_22 = 0.001

			if var_114_21 <= arg_111_1.time_ and arg_111_1.time_ < var_114_21 + var_114_22 then
				local var_114_23 = (arg_111_1.time_ - var_114_21) / var_114_22
				local var_114_24 = Vector3.New(0.7, -1.055, -6.16)

				var_114_20.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1075ui_story, var_114_24, var_114_23)

				local var_114_25 = manager.ui.mainCamera.transform.position - var_114_20.position

				var_114_20.forward = Vector3.New(var_114_25.x, var_114_25.y, var_114_25.z)

				local var_114_26 = var_114_20.localEulerAngles

				var_114_26.z = 0
				var_114_26.x = 0
				var_114_20.localEulerAngles = var_114_26
			end

			if arg_111_1.time_ >= var_114_21 + var_114_22 and arg_111_1.time_ < var_114_21 + var_114_22 + arg_114_0 then
				var_114_20.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_114_27 = manager.ui.mainCamera.transform.position - var_114_20.position

				var_114_20.forward = Vector3.New(var_114_27.x, var_114_27.y, var_114_27.z)

				local var_114_28 = var_114_20.localEulerAngles

				var_114_28.z = 0
				var_114_28.x = 0
				var_114_20.localEulerAngles = var_114_28
			end

			local var_114_29 = arg_111_1.actors_["1075ui_story"]
			local var_114_30 = 0

			if var_114_30 < arg_111_1.time_ and arg_111_1.time_ <= var_114_30 + arg_114_0 and not isNil(var_114_29) and arg_111_1.var_.characterEffect1075ui_story == nil then
				arg_111_1.var_.characterEffect1075ui_story = var_114_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_31 = 0.200000002980232

			if var_114_30 <= arg_111_1.time_ and arg_111_1.time_ < var_114_30 + var_114_31 and not isNil(var_114_29) then
				local var_114_32 = (arg_111_1.time_ - var_114_30) / var_114_31

				if arg_111_1.var_.characterEffect1075ui_story and not isNil(var_114_29) then
					local var_114_33 = Mathf.Lerp(0, 0.5, var_114_32)

					arg_111_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1075ui_story.fillRatio = var_114_33
				end
			end

			if arg_111_1.time_ >= var_114_30 + var_114_31 and arg_111_1.time_ < var_114_30 + var_114_31 + arg_114_0 and not isNil(var_114_29) and arg_111_1.var_.characterEffect1075ui_story then
				local var_114_34 = 0.5

				arg_111_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1075ui_story.fillRatio = var_114_34
			end

			local var_114_35 = 0

			if var_114_35 < arg_111_1.time_ and arg_111_1.time_ <= var_114_35 + arg_114_0 then
				arg_111_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_114_36 = 0

			if var_114_36 < arg_111_1.time_ and arg_111_1.time_ <= var_114_36 + arg_114_0 then
				arg_111_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_37 = 0
			local var_114_38 = 1.175

			if var_114_37 < arg_111_1.time_ and arg_111_1.time_ <= var_114_37 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_39 = arg_111_1:FormatText(StoryNameCfg[410].name)

				arg_111_1.leftNameTxt_.text = var_114_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_40 = arg_111_1:GetWordFromCfg(122432027)
				local var_114_41 = arg_111_1:FormatText(var_114_40.content)

				arg_111_1.text_.text = var_114_41

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_42 = 47
				local var_114_43 = utf8.len(var_114_41)
				local var_114_44 = var_114_42 <= 0 and var_114_38 or var_114_38 * (var_114_43 / var_114_42)

				if var_114_44 > 0 and var_114_38 < var_114_44 then
					arg_111_1.talkMaxDuration = var_114_44

					if var_114_44 + var_114_37 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_44 + var_114_37
					end
				end

				arg_111_1.text_.text = var_114_41
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432027", "story_v_out_122432.awb") ~= 0 then
					local var_114_45 = manager.audio:GetVoiceLength("story_v_out_122432", "122432027", "story_v_out_122432.awb") / 1000

					if var_114_45 + var_114_37 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_45 + var_114_37
					end

					if var_114_40.prefab_name ~= "" and arg_111_1.actors_[var_114_40.prefab_name] ~= nil then
						local var_114_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_40.prefab_name].transform, "story_v_out_122432", "122432027", "story_v_out_122432.awb")

						arg_111_1:RecordAudio("122432027", var_114_46)
						arg_111_1:RecordAudio("122432027", var_114_46)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_122432", "122432027", "story_v_out_122432.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_122432", "122432027", "story_v_out_122432.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_47 = math.max(var_114_38, arg_111_1.talkMaxDuration)

			if var_114_37 <= arg_111_1.time_ and arg_111_1.time_ < var_114_37 + var_114_47 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_37) / var_114_47

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_37 + var_114_47 and arg_111_1.time_ < var_114_37 + var_114_47 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play122432028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 122432028
		arg_115_1.duration_ = 11.27

		local var_115_0 = {
			ja = 11.266,
			ko = 8,
			zh = 8
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
				arg_115_0:Play122432029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1075ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1075ui_story == nil then
				arg_115_1.var_.characterEffect1075ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1075ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1075ui_story then
				arg_115_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_118_4 = 0

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_6 = arg_115_1.actors_["1074ui_story"]
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect1074ui_story == nil then
				arg_115_1.var_.characterEffect1074ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.200000002980232

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 and not isNil(var_118_6) then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / var_118_8

				if arg_115_1.var_.characterEffect1074ui_story and not isNil(var_118_6) then
					local var_118_10 = Mathf.Lerp(0, 0.5, var_118_9)

					arg_115_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1074ui_story.fillRatio = var_118_10
				end
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect1074ui_story then
				local var_118_11 = 0.5

				arg_115_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1074ui_story.fillRatio = var_118_11
			end

			local var_118_12 = 0
			local var_118_13 = 0.825

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_14 = arg_115_1:FormatText(StoryNameCfg[381].name)

				arg_115_1.leftNameTxt_.text = var_118_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_15 = arg_115_1:GetWordFromCfg(122432028)
				local var_118_16 = arg_115_1:FormatText(var_118_15.content)

				arg_115_1.text_.text = var_118_16

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 33
				local var_118_18 = utf8.len(var_118_16)
				local var_118_19 = var_118_17 <= 0 and var_118_13 or var_118_13 * (var_118_18 / var_118_17)

				if var_118_19 > 0 and var_118_13 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19

					if var_118_19 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_16
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432028", "story_v_out_122432.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_out_122432", "122432028", "story_v_out_122432.awb") / 1000

					if var_118_20 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_12
					end

					if var_118_15.prefab_name ~= "" and arg_115_1.actors_[var_118_15.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_15.prefab_name].transform, "story_v_out_122432", "122432028", "story_v_out_122432.awb")

						arg_115_1:RecordAudio("122432028", var_118_21)
						arg_115_1:RecordAudio("122432028", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_122432", "122432028", "story_v_out_122432.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_122432", "122432028", "story_v_out_122432.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_22 and arg_115_1.time_ < var_118_12 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play122432029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 122432029
		arg_119_1.duration_ = 6.9

		local var_119_0 = {
			ja = 6.9,
			ko = 5.366,
			zh = 5.366
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
				arg_119_0:Play122432030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1074ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1074ui_story == nil then
				arg_119_1.var_.characterEffect1074ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1074ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1074ui_story then
				arg_119_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_122_4 = 0

			if var_122_4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_1")
			end

			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_122_6 = arg_119_1.actors_["1075ui_story"]
			local var_122_7 = 0

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1075ui_story == nil then
				arg_119_1.var_.characterEffect1075ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_8 = 0.200000002980232

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 and not isNil(var_122_6) then
				local var_122_9 = (arg_119_1.time_ - var_122_7) / var_122_8

				if arg_119_1.var_.characterEffect1075ui_story and not isNil(var_122_6) then
					local var_122_10 = Mathf.Lerp(0, 0.5, var_122_9)

					arg_119_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1075ui_story.fillRatio = var_122_10
				end
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1075ui_story then
				local var_122_11 = 0.5

				arg_119_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1075ui_story.fillRatio = var_122_11
			end

			local var_122_12 = 0
			local var_122_13 = 0.5

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_14 = arg_119_1:FormatText(StoryNameCfg[410].name)

				arg_119_1.leftNameTxt_.text = var_122_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_15 = arg_119_1:GetWordFromCfg(122432029)
				local var_122_16 = arg_119_1:FormatText(var_122_15.content)

				arg_119_1.text_.text = var_122_16

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_17 = 20
				local var_122_18 = utf8.len(var_122_16)
				local var_122_19 = var_122_17 <= 0 and var_122_13 or var_122_13 * (var_122_18 / var_122_17)

				if var_122_19 > 0 and var_122_13 < var_122_19 then
					arg_119_1.talkMaxDuration = var_122_19

					if var_122_19 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_19 + var_122_12
					end
				end

				arg_119_1.text_.text = var_122_16
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432029", "story_v_out_122432.awb") ~= 0 then
					local var_122_20 = manager.audio:GetVoiceLength("story_v_out_122432", "122432029", "story_v_out_122432.awb") / 1000

					if var_122_20 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_20 + var_122_12
					end

					if var_122_15.prefab_name ~= "" and arg_119_1.actors_[var_122_15.prefab_name] ~= nil then
						local var_122_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_15.prefab_name].transform, "story_v_out_122432", "122432029", "story_v_out_122432.awb")

						arg_119_1:RecordAudio("122432029", var_122_21)
						arg_119_1:RecordAudio("122432029", var_122_21)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_122432", "122432029", "story_v_out_122432.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_122432", "122432029", "story_v_out_122432.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_22 = math.max(var_122_13, arg_119_1.talkMaxDuration)

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_22 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_12) / var_122_22

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_12 + var_122_22 and arg_119_1.time_ < var_122_12 + var_122_22 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play122432030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 122432030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play122432031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1074ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1074ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, 100, 0)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1074ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, 100, 0)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["1075ui_story"].transform
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.var_.moveOldPos1075ui_story = var_126_9.localPosition
			end

			local var_126_11 = 0.001

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11
				local var_126_13 = Vector3.New(0, 100, 0)

				var_126_9.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1075ui_story, var_126_13, var_126_12)

				local var_126_14 = manager.ui.mainCamera.transform.position - var_126_9.position

				var_126_9.forward = Vector3.New(var_126_14.x, var_126_14.y, var_126_14.z)

				local var_126_15 = var_126_9.localEulerAngles

				var_126_15.z = 0
				var_126_15.x = 0
				var_126_9.localEulerAngles = var_126_15
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 then
				var_126_9.localPosition = Vector3.New(0, 100, 0)

				local var_126_16 = manager.ui.mainCamera.transform.position - var_126_9.position

				var_126_9.forward = Vector3.New(var_126_16.x, var_126_16.y, var_126_16.z)

				local var_126_17 = var_126_9.localEulerAngles

				var_126_17.z = 0
				var_126_17.x = 0
				var_126_9.localEulerAngles = var_126_17
			end

			local var_126_18 = 0
			local var_126_19 = 0.85

			if var_126_18 < arg_123_1.time_ and arg_123_1.time_ <= var_126_18 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_20 = arg_123_1:GetWordFromCfg(122432030)
				local var_126_21 = arg_123_1:FormatText(var_126_20.content)

				arg_123_1.text_.text = var_126_21

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_22 = 34
				local var_126_23 = utf8.len(var_126_21)
				local var_126_24 = var_126_22 <= 0 and var_126_19 or var_126_19 * (var_126_23 / var_126_22)

				if var_126_24 > 0 and var_126_19 < var_126_24 then
					arg_123_1.talkMaxDuration = var_126_24

					if var_126_24 + var_126_18 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_24 + var_126_18
					end
				end

				arg_123_1.text_.text = var_126_21
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_25 = math.max(var_126_19, arg_123_1.talkMaxDuration)

			if var_126_18 <= arg_123_1.time_ and arg_123_1.time_ < var_126_18 + var_126_25 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_18) / var_126_25

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_18 + var_126_25 and arg_123_1.time_ < var_126_18 + var_126_25 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play122432031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 122432031
		arg_127_1.duration_ = 9.07

		local var_127_0 = {
			ja = 9.066,
			ko = 4.633,
			zh = 4.633
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
				arg_127_0:Play122432032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "10044ui_story"

			if arg_127_1.actors_[var_130_0] == nil then
				local var_130_1 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_130_1) then
					local var_130_2 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_127_1.stage_.transform)

					var_130_2.name = var_130_0
					var_130_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_127_1.actors_[var_130_0] = var_130_2

					local var_130_3 = var_130_2:GetComponentInChildren(typeof(CharacterEffect))

					var_130_3.enabled = true

					local var_130_4 = GameObjectTools.GetOrAddComponent(var_130_2, typeof(DynamicBoneHelper))

					if var_130_4 then
						var_130_4:EnableDynamicBone(false)
					end

					arg_127_1:ShowWeapon(var_130_3.transform, false)

					arg_127_1.var_[var_130_0 .. "Animator"] = var_130_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_127_1.var_[var_130_0 .. "Animator"].applyRootMotion = true
					arg_127_1.var_[var_130_0 .. "LipSync"] = var_130_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_130_5 = arg_127_1.actors_["10044ui_story"].transform
			local var_130_6 = 0

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.var_.moveOldPos10044ui_story = var_130_5.localPosition
			end

			local var_130_7 = 0.001

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_7 then
				local var_130_8 = (arg_127_1.time_ - var_130_6) / var_130_7
				local var_130_9 = Vector3.New(0, -0.72, -6.3)

				var_130_5.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10044ui_story, var_130_9, var_130_8)

				local var_130_10 = manager.ui.mainCamera.transform.position - var_130_5.position

				var_130_5.forward = Vector3.New(var_130_10.x, var_130_10.y, var_130_10.z)

				local var_130_11 = var_130_5.localEulerAngles

				var_130_11.z = 0
				var_130_11.x = 0
				var_130_5.localEulerAngles = var_130_11
			end

			if arg_127_1.time_ >= var_130_6 + var_130_7 and arg_127_1.time_ < var_130_6 + var_130_7 + arg_130_0 then
				var_130_5.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_130_12 = manager.ui.mainCamera.transform.position - var_130_5.position

				var_130_5.forward = Vector3.New(var_130_12.x, var_130_12.y, var_130_12.z)

				local var_130_13 = var_130_5.localEulerAngles

				var_130_13.z = 0
				var_130_13.x = 0
				var_130_5.localEulerAngles = var_130_13
			end

			local var_130_14 = arg_127_1.actors_["10044ui_story"]
			local var_130_15 = 0

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.characterEffect10044ui_story == nil then
				arg_127_1.var_.characterEffect10044ui_story = var_130_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_16 = 0.200000002980232

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_16 and not isNil(var_130_14) then
				local var_130_17 = (arg_127_1.time_ - var_130_15) / var_130_16

				if arg_127_1.var_.characterEffect10044ui_story and not isNil(var_130_14) then
					arg_127_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_15 + var_130_16 and arg_127_1.time_ < var_130_15 + var_130_16 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.characterEffect10044ui_story then
				arg_127_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_130_18 = 0

			if var_130_18 < arg_127_1.time_ and arg_127_1.time_ <= var_130_18 + arg_130_0 then
				arg_127_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_130_19 = 0

			if var_130_19 < arg_127_1.time_ and arg_127_1.time_ <= var_130_19 + arg_130_0 then
				arg_127_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_130_20 = 0
			local var_130_21 = 0.4

			if var_130_20 < arg_127_1.time_ and arg_127_1.time_ <= var_130_20 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_22 = arg_127_1:FormatText(StoryNameCfg[380].name)

				arg_127_1.leftNameTxt_.text = var_130_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_23 = arg_127_1:GetWordFromCfg(122432031)
				local var_130_24 = arg_127_1:FormatText(var_130_23.content)

				arg_127_1.text_.text = var_130_24

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_25 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432031", "story_v_out_122432.awb") ~= 0 then
					local var_130_28 = manager.audio:GetVoiceLength("story_v_out_122432", "122432031", "story_v_out_122432.awb") / 1000

					if var_130_28 + var_130_20 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_28 + var_130_20
					end

					if var_130_23.prefab_name ~= "" and arg_127_1.actors_[var_130_23.prefab_name] ~= nil then
						local var_130_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_23.prefab_name].transform, "story_v_out_122432", "122432031", "story_v_out_122432.awb")

						arg_127_1:RecordAudio("122432031", var_130_29)
						arg_127_1:RecordAudio("122432031", var_130_29)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_122432", "122432031", "story_v_out_122432.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_122432", "122432031", "story_v_out_122432.awb")
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play122432032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 122432032
		arg_131_1.duration_ = 8.13

		local var_131_0 = {
			ja = 8.133,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_131_0:Play122432033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1074ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1074ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, -1.055, -6.12)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1074ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["1074ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1074ui_story == nil then
				arg_131_1.var_.characterEffect1074ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect1074ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1074ui_story then
				arg_131_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_134_15 = arg_131_1.actors_["10044ui_story"].transform
			local var_134_16 = 0

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 then
				arg_131_1.var_.moveOldPos10044ui_story = var_134_15.localPosition
			end

			local var_134_17 = 0.001

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_17 then
				local var_134_18 = (arg_131_1.time_ - var_134_16) / var_134_17
				local var_134_19 = Vector3.New(0, 100, 0)

				var_134_15.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10044ui_story, var_134_19, var_134_18)

				local var_134_20 = manager.ui.mainCamera.transform.position - var_134_15.position

				var_134_15.forward = Vector3.New(var_134_20.x, var_134_20.y, var_134_20.z)

				local var_134_21 = var_134_15.localEulerAngles

				var_134_21.z = 0
				var_134_21.x = 0
				var_134_15.localEulerAngles = var_134_21
			end

			if arg_131_1.time_ >= var_134_16 + var_134_17 and arg_131_1.time_ < var_134_16 + var_134_17 + arg_134_0 then
				var_134_15.localPosition = Vector3.New(0, 100, 0)

				local var_134_22 = manager.ui.mainCamera.transform.position - var_134_15.position

				var_134_15.forward = Vector3.New(var_134_22.x, var_134_22.y, var_134_22.z)

				local var_134_23 = var_134_15.localEulerAngles

				var_134_23.z = 0
				var_134_23.x = 0
				var_134_15.localEulerAngles = var_134_23
			end

			local var_134_24 = 0
			local var_134_25 = 0.275

			if var_134_24 < arg_131_1.time_ and arg_131_1.time_ <= var_134_24 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_26 = arg_131_1:FormatText(StoryNameCfg[410].name)

				arg_131_1.leftNameTxt_.text = var_134_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_27 = arg_131_1:GetWordFromCfg(122432032)
				local var_134_28 = arg_131_1:FormatText(var_134_27.content)

				arg_131_1.text_.text = var_134_28

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_29 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432032", "story_v_out_122432.awb") ~= 0 then
					local var_134_32 = manager.audio:GetVoiceLength("story_v_out_122432", "122432032", "story_v_out_122432.awb") / 1000

					if var_134_32 + var_134_24 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_32 + var_134_24
					end

					if var_134_27.prefab_name ~= "" and arg_131_1.actors_[var_134_27.prefab_name] ~= nil then
						local var_134_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_27.prefab_name].transform, "story_v_out_122432", "122432032", "story_v_out_122432.awb")

						arg_131_1:RecordAudio("122432032", var_134_33)
						arg_131_1:RecordAudio("122432032", var_134_33)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_122432", "122432032", "story_v_out_122432.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_122432", "122432032", "story_v_out_122432.awb")
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
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play122432033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 122432033
		arg_135_1.duration_ = 2.3

		local var_135_0 = {
			ja = 2.3,
			ko = 1.266,
			zh = 1.266
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
				arg_135_0:Play122432034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1074ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1074ui_story == nil then
				arg_135_1.var_.characterEffect1074ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1074ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1074ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1074ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1074ui_story.fillRatio = var_138_5
			end

			local var_138_6 = arg_135_1.actors_["1074ui_story"].transform
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 then
				arg_135_1.var_.moveOldPos1074ui_story = var_138_6.localPosition
			end

			local var_138_8 = 0.001

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 then
				local var_138_9 = (arg_135_1.time_ - var_138_7) / var_138_8
				local var_138_10 = Vector3.New(0, 100, 0)

				var_138_6.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1074ui_story, var_138_10, var_138_9)

				local var_138_11 = manager.ui.mainCamera.transform.position - var_138_6.position

				var_138_6.forward = Vector3.New(var_138_11.x, var_138_11.y, var_138_11.z)

				local var_138_12 = var_138_6.localEulerAngles

				var_138_12.z = 0
				var_138_12.x = 0
				var_138_6.localEulerAngles = var_138_12
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 then
				var_138_6.localPosition = Vector3.New(0, 100, 0)

				local var_138_13 = manager.ui.mainCamera.transform.position - var_138_6.position

				var_138_6.forward = Vector3.New(var_138_13.x, var_138_13.y, var_138_13.z)

				local var_138_14 = var_138_6.localEulerAngles

				var_138_14.z = 0
				var_138_14.x = 0
				var_138_6.localEulerAngles = var_138_14
			end

			local var_138_15 = 0
			local var_138_16 = 0.1

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_17 = arg_135_1:FormatText(StoryNameCfg[381].name)

				arg_135_1.leftNameTxt_.text = var_138_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_18 = arg_135_1:GetWordFromCfg(122432033)
				local var_138_19 = arg_135_1:FormatText(var_138_18.content)

				arg_135_1.text_.text = var_138_19

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_20 = 4
				local var_138_21 = utf8.len(var_138_19)
				local var_138_22 = var_138_20 <= 0 and var_138_16 or var_138_16 * (var_138_21 / var_138_20)

				if var_138_22 > 0 and var_138_16 < var_138_22 then
					arg_135_1.talkMaxDuration = var_138_22

					if var_138_22 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_22 + var_138_15
					end
				end

				arg_135_1.text_.text = var_138_19
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432033", "story_v_out_122432.awb") ~= 0 then
					local var_138_23 = manager.audio:GetVoiceLength("story_v_out_122432", "122432033", "story_v_out_122432.awb") / 1000

					if var_138_23 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_23 + var_138_15
					end

					if var_138_18.prefab_name ~= "" and arg_135_1.actors_[var_138_18.prefab_name] ~= nil then
						local var_138_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_18.prefab_name].transform, "story_v_out_122432", "122432033", "story_v_out_122432.awb")

						arg_135_1:RecordAudio("122432033", var_138_24)
						arg_135_1:RecordAudio("122432033", var_138_24)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_122432", "122432033", "story_v_out_122432.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_122432", "122432033", "story_v_out_122432.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_25 = math.max(var_138_16, arg_135_1.talkMaxDuration)

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_25 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_15) / var_138_25

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_15 + var_138_25 and arg_135_1.time_ < var_138_15 + var_138_25 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play122432034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 122432034
		arg_139_1.duration_ = 11.77

		local var_139_0 = {
			ja = 11.766,
			ko = 9.433,
			zh = 9.433
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
				arg_139_0:Play122432035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10044ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10044ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, -0.72, -6.3)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10044ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["10044ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10044ui_story == nil then
				arg_139_1.var_.characterEffect10044ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect10044ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10044ui_story then
				arg_139_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_142_15 = 0
			local var_142_16 = 1.05

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[380].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(122432034)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 42
				local var_142_21 = utf8.len(var_142_19)
				local var_142_22 = var_142_20 <= 0 and var_142_16 or var_142_16 * (var_142_21 / var_142_20)

				if var_142_22 > 0 and var_142_16 < var_142_22 then
					arg_139_1.talkMaxDuration = var_142_22

					if var_142_22 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_19
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432034", "story_v_out_122432.awb") ~= 0 then
					local var_142_23 = manager.audio:GetVoiceLength("story_v_out_122432", "122432034", "story_v_out_122432.awb") / 1000

					if var_142_23 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_out_122432", "122432034", "story_v_out_122432.awb")

						arg_139_1:RecordAudio("122432034", var_142_24)
						arg_139_1:RecordAudio("122432034", var_142_24)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_122432", "122432034", "story_v_out_122432.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_122432", "122432034", "story_v_out_122432.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_25 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_25 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_15) / var_142_25

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_15 + var_142_25 and arg_139_1.time_ < var_142_15 + var_142_25 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play122432035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 122432035
		arg_143_1.duration_ = 8.53

		local var_143_0 = {
			ja = 8.533,
			ko = 5.8,
			zh = 5.8
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
				arg_143_0:Play122432036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_146_1 = 0
			local var_146_2 = 0.825

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_3 = arg_143_1:FormatText(StoryNameCfg[380].name)

				arg_143_1.leftNameTxt_.text = var_146_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(122432035)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432035", "story_v_out_122432.awb") ~= 0 then
					local var_146_9 = manager.audio:GetVoiceLength("story_v_out_122432", "122432035", "story_v_out_122432.awb") / 1000

					if var_146_9 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_1
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_122432", "122432035", "story_v_out_122432.awb")

						arg_143_1:RecordAudio("122432035", var_146_10)
						arg_143_1:RecordAudio("122432035", var_146_10)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_122432", "122432035", "story_v_out_122432.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_122432", "122432035", "story_v_out_122432.awb")
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
	Play122432036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 122432036
		arg_147_1.duration_ = 7.2

		local var_147_0 = {
			ja = 7.2,
			ko = 3.633,
			zh = 3.633
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play122432037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1074ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1074ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, -1.055, -6.12)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1074ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1074ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1074ui_story == nil then
				arg_147_1.var_.characterEffect1074ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect1074ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1074ui_story then
				arg_147_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_15 = arg_147_1.actors_["10044ui_story"].transform
			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.var_.moveOldPos10044ui_story = var_150_15.localPosition
			end

			local var_150_17 = 0.001

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17
				local var_150_19 = Vector3.New(0, 100, 0)

				var_150_15.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10044ui_story, var_150_19, var_150_18)

				local var_150_20 = manager.ui.mainCamera.transform.position - var_150_15.position

				var_150_15.forward = Vector3.New(var_150_20.x, var_150_20.y, var_150_20.z)

				local var_150_21 = var_150_15.localEulerAngles

				var_150_21.z = 0
				var_150_21.x = 0
				var_150_15.localEulerAngles = var_150_21
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 then
				var_150_15.localPosition = Vector3.New(0, 100, 0)

				local var_150_22 = manager.ui.mainCamera.transform.position - var_150_15.position

				var_150_15.forward = Vector3.New(var_150_22.x, var_150_22.y, var_150_22.z)

				local var_150_23 = var_150_15.localEulerAngles

				var_150_23.z = 0
				var_150_23.x = 0
				var_150_15.localEulerAngles = var_150_23
			end

			local var_150_24 = 0
			local var_150_25 = 0.425

			if var_150_24 < arg_147_1.time_ and arg_147_1.time_ <= var_150_24 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_26 = arg_147_1:FormatText(StoryNameCfg[410].name)

				arg_147_1.leftNameTxt_.text = var_150_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_27 = arg_147_1:GetWordFromCfg(122432036)
				local var_150_28 = arg_147_1:FormatText(var_150_27.content)

				arg_147_1.text_.text = var_150_28

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_29 = 17
				local var_150_30 = utf8.len(var_150_28)
				local var_150_31 = var_150_29 <= 0 and var_150_25 or var_150_25 * (var_150_30 / var_150_29)

				if var_150_31 > 0 and var_150_25 < var_150_31 then
					arg_147_1.talkMaxDuration = var_150_31

					if var_150_31 + var_150_24 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_31 + var_150_24
					end
				end

				arg_147_1.text_.text = var_150_28
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432036", "story_v_out_122432.awb") ~= 0 then
					local var_150_32 = manager.audio:GetVoiceLength("story_v_out_122432", "122432036", "story_v_out_122432.awb") / 1000

					if var_150_32 + var_150_24 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_32 + var_150_24
					end

					if var_150_27.prefab_name ~= "" and arg_147_1.actors_[var_150_27.prefab_name] ~= nil then
						local var_150_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_27.prefab_name].transform, "story_v_out_122432", "122432036", "story_v_out_122432.awb")

						arg_147_1:RecordAudio("122432036", var_150_33)
						arg_147_1:RecordAudio("122432036", var_150_33)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_122432", "122432036", "story_v_out_122432.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_122432", "122432036", "story_v_out_122432.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_34 = math.max(var_150_25, arg_147_1.talkMaxDuration)

			if var_150_24 <= arg_147_1.time_ and arg_147_1.time_ < var_150_24 + var_150_34 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_24) / var_150_34

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_24 + var_150_34 and arg_147_1.time_ < var_150_24 + var_150_34 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play122432037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 122432037
		arg_151_1.duration_ = 15.5

		local var_151_0 = {
			ja = 15.5,
			ko = 11.8,
			zh = 11.8
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play122432038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10044ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos10044ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, -0.72, -6.3)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10044ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["10044ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect10044ui_story == nil then
				arg_151_1.var_.characterEffect10044ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 and not isNil(var_154_9) then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect10044ui_story and not isNil(var_154_9) then
					arg_151_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect10044ui_story then
				arg_151_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_154_13 = 0

			if var_154_13 < arg_151_1.time_ and arg_151_1.time_ <= var_154_13 + arg_154_0 then
				arg_151_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action435")
			end

			local var_154_14 = 0

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_154_15 = arg_151_1.actors_["1074ui_story"].transform
			local var_154_16 = 0

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.var_.moveOldPos1074ui_story = var_154_15.localPosition
			end

			local var_154_17 = 0.001

			if var_154_16 <= arg_151_1.time_ and arg_151_1.time_ < var_154_16 + var_154_17 then
				local var_154_18 = (arg_151_1.time_ - var_154_16) / var_154_17
				local var_154_19 = Vector3.New(0, 100, 0)

				var_154_15.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1074ui_story, var_154_19, var_154_18)

				local var_154_20 = manager.ui.mainCamera.transform.position - var_154_15.position

				var_154_15.forward = Vector3.New(var_154_20.x, var_154_20.y, var_154_20.z)

				local var_154_21 = var_154_15.localEulerAngles

				var_154_21.z = 0
				var_154_21.x = 0
				var_154_15.localEulerAngles = var_154_21
			end

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 then
				var_154_15.localPosition = Vector3.New(0, 100, 0)

				local var_154_22 = manager.ui.mainCamera.transform.position - var_154_15.position

				var_154_15.forward = Vector3.New(var_154_22.x, var_154_22.y, var_154_22.z)

				local var_154_23 = var_154_15.localEulerAngles

				var_154_23.z = 0
				var_154_23.x = 0
				var_154_15.localEulerAngles = var_154_23
			end

			local var_154_24 = 0
			local var_154_25 = 1.45

			if var_154_24 < arg_151_1.time_ and arg_151_1.time_ <= var_154_24 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_26 = arg_151_1:FormatText(StoryNameCfg[380].name)

				arg_151_1.leftNameTxt_.text = var_154_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_27 = arg_151_1:GetWordFromCfg(122432037)
				local var_154_28 = arg_151_1:FormatText(var_154_27.content)

				arg_151_1.text_.text = var_154_28

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_29 = 58
				local var_154_30 = utf8.len(var_154_28)
				local var_154_31 = var_154_29 <= 0 and var_154_25 or var_154_25 * (var_154_30 / var_154_29)

				if var_154_31 > 0 and var_154_25 < var_154_31 then
					arg_151_1.talkMaxDuration = var_154_31

					if var_154_31 + var_154_24 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_31 + var_154_24
					end
				end

				arg_151_1.text_.text = var_154_28
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432037", "story_v_out_122432.awb") ~= 0 then
					local var_154_32 = manager.audio:GetVoiceLength("story_v_out_122432", "122432037", "story_v_out_122432.awb") / 1000

					if var_154_32 + var_154_24 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_32 + var_154_24
					end

					if var_154_27.prefab_name ~= "" and arg_151_1.actors_[var_154_27.prefab_name] ~= nil then
						local var_154_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_27.prefab_name].transform, "story_v_out_122432", "122432037", "story_v_out_122432.awb")

						arg_151_1:RecordAudio("122432037", var_154_33)
						arg_151_1:RecordAudio("122432037", var_154_33)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_122432", "122432037", "story_v_out_122432.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_122432", "122432037", "story_v_out_122432.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_34 = math.max(var_154_25, arg_151_1.talkMaxDuration)

			if var_154_24 <= arg_151_1.time_ and arg_151_1.time_ < var_154_24 + var_154_34 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_24) / var_154_34

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_24 + var_154_34 and arg_151_1.time_ < var_154_24 + var_154_34 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play122432038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 122432038
		arg_155_1.duration_ = 3.9

		local var_155_0 = {
			ja = 3.9,
			ko = 2.2,
			zh = 2.2
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play122432039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.35

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[380].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(122432038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 14
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432038", "story_v_out_122432.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_122432", "122432038", "story_v_out_122432.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_122432", "122432038", "story_v_out_122432.awb")

						arg_155_1:RecordAudio("122432038", var_158_9)
						arg_155_1:RecordAudio("122432038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_122432", "122432038", "story_v_out_122432.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_122432", "122432038", "story_v_out_122432.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play122432039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 122432039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play122432040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10044ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos10044ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, 100, 0)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10044ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, 100, 0)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = 0
			local var_162_10 = 1.375

			if var_162_9 < arg_159_1.time_ and arg_159_1.time_ <= var_162_9 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_11 = arg_159_1:GetWordFromCfg(122432039)
				local var_162_12 = arg_159_1:FormatText(var_162_11.content)

				arg_159_1.text_.text = var_162_12

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 55
				local var_162_14 = utf8.len(var_162_12)
				local var_162_15 = var_162_13 <= 0 and var_162_10 or var_162_10 * (var_162_14 / var_162_13)

				if var_162_15 > 0 and var_162_10 < var_162_15 then
					arg_159_1.talkMaxDuration = var_162_15

					if var_162_15 + var_162_9 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_15 + var_162_9
					end
				end

				arg_159_1.text_.text = var_162_12
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_10, arg_159_1.talkMaxDuration)

			if var_162_9 <= arg_159_1.time_ and arg_159_1.time_ < var_162_9 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_9) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_9 + var_162_16 and arg_159_1.time_ < var_162_9 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play122432040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 122432040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play122432041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 1.75

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

				local var_166_2 = arg_163_1:GetWordFromCfg(122432040)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 70
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
	Play122432041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 122432041
		arg_167_1.duration_ = 10.5

		local var_167_0 = {
			ja = 10.5,
			ko = 4.766,
			zh = 4.766
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play122432042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10044ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10044ui_story == nil then
				arg_167_1.var_.characterEffect10044ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect10044ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10044ui_story then
				arg_167_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_170_4 = 0

			if var_170_4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_2")
			end

			local var_170_5 = 0

			if var_170_5 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_170_6 = arg_167_1.actors_["10044ui_story"].transform
			local var_170_7 = 0

			if var_170_7 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 then
				arg_167_1.var_.moveOldPos10044ui_story = var_170_6.localPosition
			end

			local var_170_8 = 0.001

			if var_170_7 <= arg_167_1.time_ and arg_167_1.time_ < var_170_7 + var_170_8 then
				local var_170_9 = (arg_167_1.time_ - var_170_7) / var_170_8
				local var_170_10 = Vector3.New(0, -0.72, -6.3)

				var_170_6.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10044ui_story, var_170_10, var_170_9)

				local var_170_11 = manager.ui.mainCamera.transform.position - var_170_6.position

				var_170_6.forward = Vector3.New(var_170_11.x, var_170_11.y, var_170_11.z)

				local var_170_12 = var_170_6.localEulerAngles

				var_170_12.z = 0
				var_170_12.x = 0
				var_170_6.localEulerAngles = var_170_12
			end

			if arg_167_1.time_ >= var_170_7 + var_170_8 and arg_167_1.time_ < var_170_7 + var_170_8 + arg_170_0 then
				var_170_6.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_170_13 = manager.ui.mainCamera.transform.position - var_170_6.position

				var_170_6.forward = Vector3.New(var_170_13.x, var_170_13.y, var_170_13.z)

				local var_170_14 = var_170_6.localEulerAngles

				var_170_14.z = 0
				var_170_14.x = 0
				var_170_6.localEulerAngles = var_170_14
			end

			local var_170_15 = 0
			local var_170_16 = 0.65

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_17 = arg_167_1:FormatText(StoryNameCfg[380].name)

				arg_167_1.leftNameTxt_.text = var_170_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_18 = arg_167_1:GetWordFromCfg(122432041)
				local var_170_19 = arg_167_1:FormatText(var_170_18.content)

				arg_167_1.text_.text = var_170_19

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_20 = 26
				local var_170_21 = utf8.len(var_170_19)
				local var_170_22 = var_170_20 <= 0 and var_170_16 or var_170_16 * (var_170_21 / var_170_20)

				if var_170_22 > 0 and var_170_16 < var_170_22 then
					arg_167_1.talkMaxDuration = var_170_22

					if var_170_22 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_22 + var_170_15
					end
				end

				arg_167_1.text_.text = var_170_19
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432041", "story_v_out_122432.awb") ~= 0 then
					local var_170_23 = manager.audio:GetVoiceLength("story_v_out_122432", "122432041", "story_v_out_122432.awb") / 1000

					if var_170_23 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_23 + var_170_15
					end

					if var_170_18.prefab_name ~= "" and arg_167_1.actors_[var_170_18.prefab_name] ~= nil then
						local var_170_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_18.prefab_name].transform, "story_v_out_122432", "122432041", "story_v_out_122432.awb")

						arg_167_1:RecordAudio("122432041", var_170_24)
						arg_167_1:RecordAudio("122432041", var_170_24)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_122432", "122432041", "story_v_out_122432.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_122432", "122432041", "story_v_out_122432.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_25 = math.max(var_170_16, arg_167_1.talkMaxDuration)

			if var_170_15 <= arg_167_1.time_ and arg_167_1.time_ < var_170_15 + var_170_25 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_15) / var_170_25

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_15 + var_170_25 and arg_167_1.time_ < var_170_15 + var_170_25 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play122432042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 122432042
		arg_171_1.duration_ = 7.9

		local var_171_0 = {
			ja = 7.9,
			ko = 6,
			zh = 6
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
				arg_171_0:Play122432043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1075ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1075ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, -1.055, -6.16)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1075ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["1075ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1075ui_story == nil then
				arg_171_1.var_.characterEffect1075ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect1075ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1075ui_story then
				arg_171_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_174_13 = 0

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				arg_171_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_15 = arg_171_1.actors_["10044ui_story"].transform
			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.var_.moveOldPos10044ui_story = var_174_15.localPosition
			end

			local var_174_17 = 0.001

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 then
				local var_174_18 = (arg_171_1.time_ - var_174_16) / var_174_17
				local var_174_19 = Vector3.New(0, 100, 0)

				var_174_15.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10044ui_story, var_174_19, var_174_18)

				local var_174_20 = manager.ui.mainCamera.transform.position - var_174_15.position

				var_174_15.forward = Vector3.New(var_174_20.x, var_174_20.y, var_174_20.z)

				local var_174_21 = var_174_15.localEulerAngles

				var_174_21.z = 0
				var_174_21.x = 0
				var_174_15.localEulerAngles = var_174_21
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 then
				var_174_15.localPosition = Vector3.New(0, 100, 0)

				local var_174_22 = manager.ui.mainCamera.transform.position - var_174_15.position

				var_174_15.forward = Vector3.New(var_174_22.x, var_174_22.y, var_174_22.z)

				local var_174_23 = var_174_15.localEulerAngles

				var_174_23.z = 0
				var_174_23.x = 0
				var_174_15.localEulerAngles = var_174_23
			end

			local var_174_24 = 0
			local var_174_25 = 0.65

			if var_174_24 < arg_171_1.time_ and arg_171_1.time_ <= var_174_24 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_26 = arg_171_1:FormatText(StoryNameCfg[381].name)

				arg_171_1.leftNameTxt_.text = var_174_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_27 = arg_171_1:GetWordFromCfg(122432042)
				local var_174_28 = arg_171_1:FormatText(var_174_27.content)

				arg_171_1.text_.text = var_174_28

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_29 = 26
				local var_174_30 = utf8.len(var_174_28)
				local var_174_31 = var_174_29 <= 0 and var_174_25 or var_174_25 * (var_174_30 / var_174_29)

				if var_174_31 > 0 and var_174_25 < var_174_31 then
					arg_171_1.talkMaxDuration = var_174_31

					if var_174_31 + var_174_24 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_31 + var_174_24
					end
				end

				arg_171_1.text_.text = var_174_28
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432042", "story_v_out_122432.awb") ~= 0 then
					local var_174_32 = manager.audio:GetVoiceLength("story_v_out_122432", "122432042", "story_v_out_122432.awb") / 1000

					if var_174_32 + var_174_24 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_32 + var_174_24
					end

					if var_174_27.prefab_name ~= "" and arg_171_1.actors_[var_174_27.prefab_name] ~= nil then
						local var_174_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_27.prefab_name].transform, "story_v_out_122432", "122432042", "story_v_out_122432.awb")

						arg_171_1:RecordAudio("122432042", var_174_33)
						arg_171_1:RecordAudio("122432042", var_174_33)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_122432", "122432042", "story_v_out_122432.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_122432", "122432042", "story_v_out_122432.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_34 = math.max(var_174_25, arg_171_1.talkMaxDuration)

			if var_174_24 <= arg_171_1.time_ and arg_171_1.time_ < var_174_24 + var_174_34 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_24) / var_174_34

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_24 + var_174_34 and arg_171_1.time_ < var_174_24 + var_174_34 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play122432043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 122432043
		arg_175_1.duration_ = 11.97

		local var_175_0 = {
			ja = 11.966,
			ko = 5.933,
			zh = 5.933
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play122432044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			local var_178_2 = 2

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_3 = 2

			if var_178_3 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action452")
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_4 = 2
			local var_178_5 = 0.9

			if var_178_4 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_6 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_6:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_7 = arg_175_1:FormatText(StoryNameCfg[381].name)

				arg_175_1.leftNameTxt_.text = var_178_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_8 = arg_175_1:GetWordFromCfg(122432043)
				local var_178_9 = arg_175_1:FormatText(var_178_8.content)

				arg_175_1.text_.text = var_178_9

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_10 = 36
				local var_178_11 = utf8.len(var_178_9)
				local var_178_12 = var_178_10 <= 0 and var_178_5 or var_178_5 * (var_178_11 / var_178_10)

				if var_178_12 > 0 and var_178_5 < var_178_12 then
					arg_175_1.talkMaxDuration = var_178_12
					var_178_4 = var_178_4 + 0.3

					if var_178_12 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_12 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_9
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432043", "story_v_out_122432.awb") ~= 0 then
					local var_178_13 = manager.audio:GetVoiceLength("story_v_out_122432", "122432043", "story_v_out_122432.awb") / 1000

					if var_178_13 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_4
					end

					if var_178_8.prefab_name ~= "" and arg_175_1.actors_[var_178_8.prefab_name] ~= nil then
						local var_178_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_8.prefab_name].transform, "story_v_out_122432", "122432043", "story_v_out_122432.awb")

						arg_175_1:RecordAudio("122432043", var_178_14)
						arg_175_1:RecordAudio("122432043", var_178_14)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_122432", "122432043", "story_v_out_122432.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_122432", "122432043", "story_v_out_122432.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_15 = var_178_4 + 0.3
			local var_178_16 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_16 and arg_175_1.time_ < var_178_15 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play122432044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 122432044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play122432045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1075ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1075ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, 100, 0)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1075ui_story, var_184_4, var_184_3)

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

			local var_184_9 = 0
			local var_184_10 = 1.15

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_11 = arg_181_1:GetWordFromCfg(122432044)
				local var_184_12 = arg_181_1:FormatText(var_184_11.content)

				arg_181_1.text_.text = var_184_12

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 46
				local var_184_14 = utf8.len(var_184_12)
				local var_184_15 = var_184_13 <= 0 and var_184_10 or var_184_10 * (var_184_14 / var_184_13)

				if var_184_15 > 0 and var_184_10 < var_184_15 then
					arg_181_1.talkMaxDuration = var_184_15

					if var_184_15 + var_184_9 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_15 + var_184_9
					end
				end

				arg_181_1.text_.text = var_184_12
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_10, arg_181_1.talkMaxDuration)

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_9) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_9 + var_184_16 and arg_181_1.time_ < var_184_9 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play122432045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 122432045
		arg_185_1.duration_ = 3.4

		local var_185_0 = {
			ja = 3.4,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play122432046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1074ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1074ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1074ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = arg_185_1.actors_["1074ui_story"]
			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1074ui_story == nil then
				arg_185_1.var_.characterEffect1074ui_story = var_188_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_11 = 0.200000002980232

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_11 and not isNil(var_188_9) then
				local var_188_12 = (arg_185_1.time_ - var_188_10) / var_188_11

				if arg_185_1.var_.characterEffect1074ui_story and not isNil(var_188_9) then
					arg_185_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_10 + var_188_11 and arg_185_1.time_ < var_188_10 + var_188_11 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1074ui_story then
				arg_185_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_188_13 = 0

			if var_188_13 < arg_185_1.time_ and arg_185_1.time_ <= var_188_13 + arg_188_0 then
				arg_185_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_188_14 = 0

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_15 = arg_185_1.actors_["1075ui_story"].transform
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.var_.moveOldPos1075ui_story = var_188_15.localPosition
			end

			local var_188_17 = 0.001

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17
				local var_188_19 = Vector3.New(0.7, -1.055, -6.16)

				var_188_15.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1075ui_story, var_188_19, var_188_18)

				local var_188_20 = manager.ui.mainCamera.transform.position - var_188_15.position

				var_188_15.forward = Vector3.New(var_188_20.x, var_188_20.y, var_188_20.z)

				local var_188_21 = var_188_15.localEulerAngles

				var_188_21.z = 0
				var_188_21.x = 0
				var_188_15.localEulerAngles = var_188_21
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 then
				var_188_15.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_188_22 = manager.ui.mainCamera.transform.position - var_188_15.position

				var_188_15.forward = Vector3.New(var_188_22.x, var_188_22.y, var_188_22.z)

				local var_188_23 = var_188_15.localEulerAngles

				var_188_23.z = 0
				var_188_23.x = 0
				var_188_15.localEulerAngles = var_188_23
			end

			local var_188_24 = arg_185_1.actors_["1075ui_story"]
			local var_188_25 = 0

			if var_188_25 < arg_185_1.time_ and arg_185_1.time_ <= var_188_25 + arg_188_0 and not isNil(var_188_24) and arg_185_1.var_.characterEffect1075ui_story == nil then
				arg_185_1.var_.characterEffect1075ui_story = var_188_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_26 = 0.200000002980232

			if var_188_25 <= arg_185_1.time_ and arg_185_1.time_ < var_188_25 + var_188_26 and not isNil(var_188_24) then
				local var_188_27 = (arg_185_1.time_ - var_188_25) / var_188_26

				if arg_185_1.var_.characterEffect1075ui_story and not isNil(var_188_24) then
					local var_188_28 = Mathf.Lerp(0, 0.5, var_188_27)

					arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1075ui_story.fillRatio = var_188_28
				end
			end

			if arg_185_1.time_ >= var_188_25 + var_188_26 and arg_185_1.time_ < var_188_25 + var_188_26 + arg_188_0 and not isNil(var_188_24) and arg_185_1.var_.characterEffect1075ui_story then
				local var_188_29 = 0.5

				arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1075ui_story.fillRatio = var_188_29
			end

			local var_188_30 = 0

			if var_188_30 < arg_185_1.time_ and arg_185_1.time_ <= var_188_30 + arg_188_0 then
				arg_185_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_188_31 = 0
			local var_188_32 = 0.175

			if var_188_31 < arg_185_1.time_ and arg_185_1.time_ <= var_188_31 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_33 = arg_185_1:FormatText(StoryNameCfg[410].name)

				arg_185_1.leftNameTxt_.text = var_188_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_34 = arg_185_1:GetWordFromCfg(122432045)
				local var_188_35 = arg_185_1:FormatText(var_188_34.content)

				arg_185_1.text_.text = var_188_35

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_36 = 7
				local var_188_37 = utf8.len(var_188_35)
				local var_188_38 = var_188_36 <= 0 and var_188_32 or var_188_32 * (var_188_37 / var_188_36)

				if var_188_38 > 0 and var_188_32 < var_188_38 then
					arg_185_1.talkMaxDuration = var_188_38

					if var_188_38 + var_188_31 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_38 + var_188_31
					end
				end

				arg_185_1.text_.text = var_188_35
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432045", "story_v_out_122432.awb") ~= 0 then
					local var_188_39 = manager.audio:GetVoiceLength("story_v_out_122432", "122432045", "story_v_out_122432.awb") / 1000

					if var_188_39 + var_188_31 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_39 + var_188_31
					end

					if var_188_34.prefab_name ~= "" and arg_185_1.actors_[var_188_34.prefab_name] ~= nil then
						local var_188_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_34.prefab_name].transform, "story_v_out_122432", "122432045", "story_v_out_122432.awb")

						arg_185_1:RecordAudio("122432045", var_188_40)
						arg_185_1:RecordAudio("122432045", var_188_40)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_122432", "122432045", "story_v_out_122432.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_122432", "122432045", "story_v_out_122432.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_41 = math.max(var_188_32, arg_185_1.talkMaxDuration)

			if var_188_31 <= arg_185_1.time_ and arg_185_1.time_ < var_188_31 + var_188_41 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_31) / var_188_41

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_31 + var_188_41 and arg_185_1.time_ < var_188_31 + var_188_41 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play122432046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 122432046
		arg_189_1.duration_ = 10.13

		local var_189_0 = {
			ja = 10.133,
			ko = 4.9,
			zh = 4.9
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
				arg_189_0:Play122432047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1075ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1075ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0.7, -1.055, -6.16)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1075ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["1075ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1075ui_story == nil then
				arg_189_1.var_.characterEffect1075ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect1075ui_story and not isNil(var_192_9) then
					arg_189_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1075ui_story then
				arg_189_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_192_13 = 0

			if var_192_13 < arg_189_1.time_ and arg_189_1.time_ <= var_192_13 + arg_192_0 then
				arg_189_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_192_14 = 0

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_15 = arg_189_1.actors_["1074ui_story"]
			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 and not isNil(var_192_15) and arg_189_1.var_.characterEffect1074ui_story == nil then
				arg_189_1.var_.characterEffect1074ui_story = var_192_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_17 = 0.200000002980232

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_17 and not isNil(var_192_15) then
				local var_192_18 = (arg_189_1.time_ - var_192_16) / var_192_17

				if arg_189_1.var_.characterEffect1074ui_story and not isNil(var_192_15) then
					local var_192_19 = Mathf.Lerp(0, 0.5, var_192_18)

					arg_189_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1074ui_story.fillRatio = var_192_19
				end
			end

			if arg_189_1.time_ >= var_192_16 + var_192_17 and arg_189_1.time_ < var_192_16 + var_192_17 + arg_192_0 and not isNil(var_192_15) and arg_189_1.var_.characterEffect1074ui_story then
				local var_192_20 = 0.5

				arg_189_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1074ui_story.fillRatio = var_192_20
			end

			local var_192_21 = 0
			local var_192_22 = 0.65

			if var_192_21 < arg_189_1.time_ and arg_189_1.time_ <= var_192_21 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_23 = arg_189_1:FormatText(StoryNameCfg[381].name)

				arg_189_1.leftNameTxt_.text = var_192_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_24 = arg_189_1:GetWordFromCfg(122432046)
				local var_192_25 = arg_189_1:FormatText(var_192_24.content)

				arg_189_1.text_.text = var_192_25

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_26 = 26
				local var_192_27 = utf8.len(var_192_25)
				local var_192_28 = var_192_26 <= 0 and var_192_22 or var_192_22 * (var_192_27 / var_192_26)

				if var_192_28 > 0 and var_192_22 < var_192_28 then
					arg_189_1.talkMaxDuration = var_192_28

					if var_192_28 + var_192_21 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_28 + var_192_21
					end
				end

				arg_189_1.text_.text = var_192_25
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432046", "story_v_out_122432.awb") ~= 0 then
					local var_192_29 = manager.audio:GetVoiceLength("story_v_out_122432", "122432046", "story_v_out_122432.awb") / 1000

					if var_192_29 + var_192_21 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_29 + var_192_21
					end

					if var_192_24.prefab_name ~= "" and arg_189_1.actors_[var_192_24.prefab_name] ~= nil then
						local var_192_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_24.prefab_name].transform, "story_v_out_122432", "122432046", "story_v_out_122432.awb")

						arg_189_1:RecordAudio("122432046", var_192_30)
						arg_189_1:RecordAudio("122432046", var_192_30)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_122432", "122432046", "story_v_out_122432.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_122432", "122432046", "story_v_out_122432.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_31 = math.max(var_192_22, arg_189_1.talkMaxDuration)

			if var_192_21 <= arg_189_1.time_ and arg_189_1.time_ < var_192_21 + var_192_31 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_21) / var_192_31

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_21 + var_192_31 and arg_189_1.time_ < var_192_21 + var_192_31 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play122432047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 122432047
		arg_193_1.duration_ = 8.63

		local var_193_0 = {
			ja = 8.633,
			ko = 2.6,
			zh = 2.6
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play122432048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1074ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1074ui_story == nil then
				arg_193_1.var_.characterEffect1074ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1074ui_story and not isNil(var_196_0) then
					arg_193_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1074ui_story then
				arg_193_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_196_4 = 0

			if var_196_4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_196_5 = 0

			if var_196_5 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_196_6 = arg_193_1.actors_["1075ui_story"]
			local var_196_7 = 0

			if var_196_7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1075ui_story == nil then
				arg_193_1.var_.characterEffect1075ui_story = var_196_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_8 = 0.200000002980232

			if var_196_7 <= arg_193_1.time_ and arg_193_1.time_ < var_196_7 + var_196_8 and not isNil(var_196_6) then
				local var_196_9 = (arg_193_1.time_ - var_196_7) / var_196_8

				if arg_193_1.var_.characterEffect1075ui_story and not isNil(var_196_6) then
					local var_196_10 = Mathf.Lerp(0, 0.5, var_196_9)

					arg_193_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1075ui_story.fillRatio = var_196_10
				end
			end

			if arg_193_1.time_ >= var_196_7 + var_196_8 and arg_193_1.time_ < var_196_7 + var_196_8 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1075ui_story then
				local var_196_11 = 0.5

				arg_193_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1075ui_story.fillRatio = var_196_11
			end

			local var_196_12 = 0
			local var_196_13 = 0.3

			if var_196_12 < arg_193_1.time_ and arg_193_1.time_ <= var_196_12 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_14 = arg_193_1:FormatText(StoryNameCfg[410].name)

				arg_193_1.leftNameTxt_.text = var_196_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_15 = arg_193_1:GetWordFromCfg(122432047)
				local var_196_16 = arg_193_1:FormatText(var_196_15.content)

				arg_193_1.text_.text = var_196_16

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_17 = 12
				local var_196_18 = utf8.len(var_196_16)
				local var_196_19 = var_196_17 <= 0 and var_196_13 or var_196_13 * (var_196_18 / var_196_17)

				if var_196_19 > 0 and var_196_13 < var_196_19 then
					arg_193_1.talkMaxDuration = var_196_19

					if var_196_19 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_19 + var_196_12
					end
				end

				arg_193_1.text_.text = var_196_16
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432047", "story_v_out_122432.awb") ~= 0 then
					local var_196_20 = manager.audio:GetVoiceLength("story_v_out_122432", "122432047", "story_v_out_122432.awb") / 1000

					if var_196_20 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_20 + var_196_12
					end

					if var_196_15.prefab_name ~= "" and arg_193_1.actors_[var_196_15.prefab_name] ~= nil then
						local var_196_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_15.prefab_name].transform, "story_v_out_122432", "122432047", "story_v_out_122432.awb")

						arg_193_1:RecordAudio("122432047", var_196_21)
						arg_193_1:RecordAudio("122432047", var_196_21)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_122432", "122432047", "story_v_out_122432.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_122432", "122432047", "story_v_out_122432.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_22 = math.max(var_196_13, arg_193_1.talkMaxDuration)

			if var_196_12 <= arg_193_1.time_ and arg_193_1.time_ < var_196_12 + var_196_22 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_12) / var_196_22

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_12 + var_196_22 and arg_193_1.time_ < var_196_12 + var_196_22 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play122432048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 122432048
		arg_197_1.duration_ = 10.7

		local var_197_0 = {
			ja = 10.7,
			ko = 8.333,
			zh = 8.333
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
				arg_197_0:Play122432049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1075ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1075ui_story == nil then
				arg_197_1.var_.characterEffect1075ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1075ui_story and not isNil(var_200_0) then
					arg_197_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1075ui_story then
				arg_197_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_200_4 = 0

			if var_200_4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			local var_200_5 = 0

			if var_200_5 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_200_6 = arg_197_1.actors_["1074ui_story"]
			local var_200_7 = 0

			if var_200_7 < arg_197_1.time_ and arg_197_1.time_ <= var_200_7 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect1074ui_story == nil then
				arg_197_1.var_.characterEffect1074ui_story = var_200_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_8 = 0.200000002980232

			if var_200_7 <= arg_197_1.time_ and arg_197_1.time_ < var_200_7 + var_200_8 and not isNil(var_200_6) then
				local var_200_9 = (arg_197_1.time_ - var_200_7) / var_200_8

				if arg_197_1.var_.characterEffect1074ui_story and not isNil(var_200_6) then
					local var_200_10 = Mathf.Lerp(0, 0.5, var_200_9)

					arg_197_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1074ui_story.fillRatio = var_200_10
				end
			end

			if arg_197_1.time_ >= var_200_7 + var_200_8 and arg_197_1.time_ < var_200_7 + var_200_8 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect1074ui_story then
				local var_200_11 = 0.5

				arg_197_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1074ui_story.fillRatio = var_200_11
			end

			local var_200_12 = 0
			local var_200_13 = 1.025

			if var_200_12 < arg_197_1.time_ and arg_197_1.time_ <= var_200_12 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_14 = arg_197_1:FormatText(StoryNameCfg[381].name)

				arg_197_1.leftNameTxt_.text = var_200_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_15 = arg_197_1:GetWordFromCfg(122432048)
				local var_200_16 = arg_197_1:FormatText(var_200_15.content)

				arg_197_1.text_.text = var_200_16

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_17 = 41
				local var_200_18 = utf8.len(var_200_16)
				local var_200_19 = var_200_17 <= 0 and var_200_13 or var_200_13 * (var_200_18 / var_200_17)

				if var_200_19 > 0 and var_200_13 < var_200_19 then
					arg_197_1.talkMaxDuration = var_200_19

					if var_200_19 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_19 + var_200_12
					end
				end

				arg_197_1.text_.text = var_200_16
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432048", "story_v_out_122432.awb") ~= 0 then
					local var_200_20 = manager.audio:GetVoiceLength("story_v_out_122432", "122432048", "story_v_out_122432.awb") / 1000

					if var_200_20 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_20 + var_200_12
					end

					if var_200_15.prefab_name ~= "" and arg_197_1.actors_[var_200_15.prefab_name] ~= nil then
						local var_200_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_15.prefab_name].transform, "story_v_out_122432", "122432048", "story_v_out_122432.awb")

						arg_197_1:RecordAudio("122432048", var_200_21)
						arg_197_1:RecordAudio("122432048", var_200_21)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_122432", "122432048", "story_v_out_122432.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_122432", "122432048", "story_v_out_122432.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_22 = math.max(var_200_13, arg_197_1.talkMaxDuration)

			if var_200_12 <= arg_197_1.time_ and arg_197_1.time_ < var_200_12 + var_200_22 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_12) / var_200_22

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_12 + var_200_22 and arg_197_1.time_ < var_200_12 + var_200_22 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play122432049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 122432049
		arg_201_1.duration_ = 12.97

		local var_201_0 = {
			ja = 12.966,
			ko = 6.766,
			zh = 6.766
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play122432050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_2 = 0
			local var_204_3 = 0.825

			if var_204_2 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_4 = arg_201_1:FormatText(StoryNameCfg[381].name)

				arg_201_1.leftNameTxt_.text = var_204_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_5 = arg_201_1:GetWordFromCfg(122432049)
				local var_204_6 = arg_201_1:FormatText(var_204_5.content)

				arg_201_1.text_.text = var_204_6

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 33
				local var_204_8 = utf8.len(var_204_6)
				local var_204_9 = var_204_7 <= 0 and var_204_3 or var_204_3 * (var_204_8 / var_204_7)

				if var_204_9 > 0 and var_204_3 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_6
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432049", "story_v_out_122432.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_out_122432", "122432049", "story_v_out_122432.awb") / 1000

					if var_204_10 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_2
					end

					if var_204_5.prefab_name ~= "" and arg_201_1.actors_[var_204_5.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_5.prefab_name].transform, "story_v_out_122432", "122432049", "story_v_out_122432.awb")

						arg_201_1:RecordAudio("122432049", var_204_11)
						arg_201_1:RecordAudio("122432049", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_122432", "122432049", "story_v_out_122432.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_122432", "122432049", "story_v_out_122432.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_3, arg_201_1.talkMaxDuration)

			if var_204_2 <= arg_201_1.time_ and arg_201_1.time_ < var_204_2 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_2) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_2 + var_204_12 and arg_201_1.time_ < var_204_2 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play122432050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 122432050
		arg_205_1.duration_ = 5.33

		local var_205_0 = {
			ja = 5.333,
			ko = 3.3,
			zh = 3.3
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play122432051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10044ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10044ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, -0.72, -6.3)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10044ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["10044ui_story"]
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect10044ui_story == nil then
				arg_205_1.var_.characterEffect10044ui_story = var_208_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_11 = 0.200000002980232

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 and not isNil(var_208_9) then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11

				if arg_205_1.var_.characterEffect10044ui_story and not isNil(var_208_9) then
					arg_205_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect10044ui_story then
				arg_205_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_208_13 = 0

			if var_208_13 < arg_205_1.time_ and arg_205_1.time_ <= var_208_13 + arg_208_0 then
				arg_205_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action2_1")
			end

			local var_208_14 = 0

			if var_208_14 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 then
				arg_205_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_208_15 = arg_205_1.actors_["1074ui_story"].transform
			local var_208_16 = 0

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 then
				arg_205_1.var_.moveOldPos1074ui_story = var_208_15.localPosition
			end

			local var_208_17 = 0.001

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_17 then
				local var_208_18 = (arg_205_1.time_ - var_208_16) / var_208_17
				local var_208_19 = Vector3.New(0, 100, 0)

				var_208_15.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1074ui_story, var_208_19, var_208_18)

				local var_208_20 = manager.ui.mainCamera.transform.position - var_208_15.position

				var_208_15.forward = Vector3.New(var_208_20.x, var_208_20.y, var_208_20.z)

				local var_208_21 = var_208_15.localEulerAngles

				var_208_21.z = 0
				var_208_21.x = 0
				var_208_15.localEulerAngles = var_208_21
			end

			if arg_205_1.time_ >= var_208_16 + var_208_17 and arg_205_1.time_ < var_208_16 + var_208_17 + arg_208_0 then
				var_208_15.localPosition = Vector3.New(0, 100, 0)

				local var_208_22 = manager.ui.mainCamera.transform.position - var_208_15.position

				var_208_15.forward = Vector3.New(var_208_22.x, var_208_22.y, var_208_22.z)

				local var_208_23 = var_208_15.localEulerAngles

				var_208_23.z = 0
				var_208_23.x = 0
				var_208_15.localEulerAngles = var_208_23
			end

			local var_208_24 = arg_205_1.actors_["1075ui_story"].transform
			local var_208_25 = 0

			if var_208_25 < arg_205_1.time_ and arg_205_1.time_ <= var_208_25 + arg_208_0 then
				arg_205_1.var_.moveOldPos1075ui_story = var_208_24.localPosition
			end

			local var_208_26 = 0.001

			if var_208_25 <= arg_205_1.time_ and arg_205_1.time_ < var_208_25 + var_208_26 then
				local var_208_27 = (arg_205_1.time_ - var_208_25) / var_208_26
				local var_208_28 = Vector3.New(0, 100, 0)

				var_208_24.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1075ui_story, var_208_28, var_208_27)

				local var_208_29 = manager.ui.mainCamera.transform.position - var_208_24.position

				var_208_24.forward = Vector3.New(var_208_29.x, var_208_29.y, var_208_29.z)

				local var_208_30 = var_208_24.localEulerAngles

				var_208_30.z = 0
				var_208_30.x = 0
				var_208_24.localEulerAngles = var_208_30
			end

			if arg_205_1.time_ >= var_208_25 + var_208_26 and arg_205_1.time_ < var_208_25 + var_208_26 + arg_208_0 then
				var_208_24.localPosition = Vector3.New(0, 100, 0)

				local var_208_31 = manager.ui.mainCamera.transform.position - var_208_24.position

				var_208_24.forward = Vector3.New(var_208_31.x, var_208_31.y, var_208_31.z)

				local var_208_32 = var_208_24.localEulerAngles

				var_208_32.z = 0
				var_208_32.x = 0
				var_208_24.localEulerAngles = var_208_32
			end

			local var_208_33 = 0
			local var_208_34 = 0.45

			if var_208_33 < arg_205_1.time_ and arg_205_1.time_ <= var_208_33 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_35 = arg_205_1:FormatText(StoryNameCfg[380].name)

				arg_205_1.leftNameTxt_.text = var_208_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_36 = arg_205_1:GetWordFromCfg(122432050)
				local var_208_37 = arg_205_1:FormatText(var_208_36.content)

				arg_205_1.text_.text = var_208_37

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_38 = 18
				local var_208_39 = utf8.len(var_208_37)
				local var_208_40 = var_208_38 <= 0 and var_208_34 or var_208_34 * (var_208_39 / var_208_38)

				if var_208_40 > 0 and var_208_34 < var_208_40 then
					arg_205_1.talkMaxDuration = var_208_40

					if var_208_40 + var_208_33 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_40 + var_208_33
					end
				end

				arg_205_1.text_.text = var_208_37
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432050", "story_v_out_122432.awb") ~= 0 then
					local var_208_41 = manager.audio:GetVoiceLength("story_v_out_122432", "122432050", "story_v_out_122432.awb") / 1000

					if var_208_41 + var_208_33 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_41 + var_208_33
					end

					if var_208_36.prefab_name ~= "" and arg_205_1.actors_[var_208_36.prefab_name] ~= nil then
						local var_208_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_36.prefab_name].transform, "story_v_out_122432", "122432050", "story_v_out_122432.awb")

						arg_205_1:RecordAudio("122432050", var_208_42)
						arg_205_1:RecordAudio("122432050", var_208_42)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_122432", "122432050", "story_v_out_122432.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_122432", "122432050", "story_v_out_122432.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_43 = math.max(var_208_34, arg_205_1.talkMaxDuration)

			if var_208_33 <= arg_205_1.time_ and arg_205_1.time_ < var_208_33 + var_208_43 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_33) / var_208_43

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_33 + var_208_43 and arg_205_1.time_ < var_208_33 + var_208_43 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play122432051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 122432051
		arg_209_1.duration_ = 9.07

		local var_209_0 = {
			ja = 9.066,
			ko = 6.833,
			zh = 6.833
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
				arg_209_0:Play122432052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1075ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1075ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0, -1.055, -6.16)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1075ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["1075ui_story"]
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1075ui_story == nil then
				arg_209_1.var_.characterEffect1075ui_story = var_212_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_11 = 0.200000002980232

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 and not isNil(var_212_9) then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11

				if arg_209_1.var_.characterEffect1075ui_story and not isNil(var_212_9) then
					arg_209_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1075ui_story then
				arg_209_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_212_13 = 0

			if var_212_13 < arg_209_1.time_ and arg_209_1.time_ <= var_212_13 + arg_212_0 then
				arg_209_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_212_14 = 0

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_15 = arg_209_1.actors_["10044ui_story"].transform
			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.var_.moveOldPos10044ui_story = var_212_15.localPosition
			end

			local var_212_17 = 0.001

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17
				local var_212_19 = Vector3.New(0, 100, 0)

				var_212_15.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10044ui_story, var_212_19, var_212_18)

				local var_212_20 = manager.ui.mainCamera.transform.position - var_212_15.position

				var_212_15.forward = Vector3.New(var_212_20.x, var_212_20.y, var_212_20.z)

				local var_212_21 = var_212_15.localEulerAngles

				var_212_21.z = 0
				var_212_21.x = 0
				var_212_15.localEulerAngles = var_212_21
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				var_212_15.localPosition = Vector3.New(0, 100, 0)

				local var_212_22 = manager.ui.mainCamera.transform.position - var_212_15.position

				var_212_15.forward = Vector3.New(var_212_22.x, var_212_22.y, var_212_22.z)

				local var_212_23 = var_212_15.localEulerAngles

				var_212_23.z = 0
				var_212_23.x = 0
				var_212_15.localEulerAngles = var_212_23
			end

			local var_212_24 = 0
			local var_212_25 = 0.8

			if var_212_24 < arg_209_1.time_ and arg_209_1.time_ <= var_212_24 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_26 = arg_209_1:FormatText(StoryNameCfg[381].name)

				arg_209_1.leftNameTxt_.text = var_212_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_27 = arg_209_1:GetWordFromCfg(122432051)
				local var_212_28 = arg_209_1:FormatText(var_212_27.content)

				arg_209_1.text_.text = var_212_28

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_29 = 32
				local var_212_30 = utf8.len(var_212_28)
				local var_212_31 = var_212_29 <= 0 and var_212_25 or var_212_25 * (var_212_30 / var_212_29)

				if var_212_31 > 0 and var_212_25 < var_212_31 then
					arg_209_1.talkMaxDuration = var_212_31

					if var_212_31 + var_212_24 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_31 + var_212_24
					end
				end

				arg_209_1.text_.text = var_212_28
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432051", "story_v_out_122432.awb") ~= 0 then
					local var_212_32 = manager.audio:GetVoiceLength("story_v_out_122432", "122432051", "story_v_out_122432.awb") / 1000

					if var_212_32 + var_212_24 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_32 + var_212_24
					end

					if var_212_27.prefab_name ~= "" and arg_209_1.actors_[var_212_27.prefab_name] ~= nil then
						local var_212_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_27.prefab_name].transform, "story_v_out_122432", "122432051", "story_v_out_122432.awb")

						arg_209_1:RecordAudio("122432051", var_212_33)
						arg_209_1:RecordAudio("122432051", var_212_33)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_122432", "122432051", "story_v_out_122432.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_122432", "122432051", "story_v_out_122432.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_34 = math.max(var_212_25, arg_209_1.talkMaxDuration)

			if var_212_24 <= arg_209_1.time_ and arg_209_1.time_ < var_212_24 + var_212_34 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_24) / var_212_34

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_24 + var_212_34 and arg_209_1.time_ < var_212_24 + var_212_34 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play122432052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 122432052
		arg_213_1.duration_ = 8.87

		local var_213_0 = {
			ja = 8.866,
			ko = 5,
			zh = 5
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
			arg_213_1.auto_ = false
		end

		function arg_213_1.playNext_(arg_215_0)
			arg_213_1.onStoryFinished_()
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_216_2 = 0
			local var_216_3 = 0.6

			if var_216_2 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_4 = arg_213_1:FormatText(StoryNameCfg[381].name)

				arg_213_1.leftNameTxt_.text = var_216_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_5 = arg_213_1:GetWordFromCfg(122432052)
				local var_216_6 = arg_213_1:FormatText(var_216_5.content)

				arg_213_1.text_.text = var_216_6

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_7 = 24
				local var_216_8 = utf8.len(var_216_6)
				local var_216_9 = var_216_7 <= 0 and var_216_3 or var_216_3 * (var_216_8 / var_216_7)

				if var_216_9 > 0 and var_216_3 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_2
					end
				end

				arg_213_1.text_.text = var_216_6
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122432", "122432052", "story_v_out_122432.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_122432", "122432052", "story_v_out_122432.awb") / 1000

					if var_216_10 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_2
					end

					if var_216_5.prefab_name ~= "" and arg_213_1.actors_[var_216_5.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_5.prefab_name].transform, "story_v_out_122432", "122432052", "story_v_out_122432.awb")

						arg_213_1:RecordAudio("122432052", var_216_11)
						arg_213_1:RecordAudio("122432052", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_122432", "122432052", "story_v_out_122432.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_122432", "122432052", "story_v_out_122432.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_3, arg_213_1.talkMaxDuration)

			if var_216_2 <= arg_213_1.time_ and arg_213_1.time_ < var_216_2 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_2) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_2 + var_216_12 and arg_213_1.time_ < var_216_2 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J10h",
		"TextureConfig/Background/ST42a"
	},
	voices = {
		"story_v_out_122432.awb"
	}
}
