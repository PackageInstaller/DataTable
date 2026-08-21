return {
	Play107011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 107011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play107011002(arg_1_1)
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

			local var_4_16 = arg_1_1.bgs_.A00
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueA00 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueA00 = var_4_18
				end

				arg_1_1.var_.alphaOldValueA00 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueA00, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueA00 then
					local var_4_22 = arg_1_1.var_.alphaMatValueA00.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueA00.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueA00 then
				local var_4_23 = arg_1_1.var_.alphaMatValueA00
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_4_30 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_30 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_30

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_30
						arg_1_1.bgmTxt2_.text = var_4_30
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

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 1.5

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2
			local var_4_34 = 0.2

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_36 = arg_1_1:GetWordFromCfg(107011001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 8
				local var_4_39 = utf8.len(var_4_37)
				local var_4_40 = var_4_38 <= 0 and var_4_34 or var_4_34 * (var_4_39 / var_4_38)

				if var_4_40 > 0 and var_4_34 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40
					var_4_33 = var_4_33 + 0.3

					if var_4_40 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_33 + 0.3
			local var_4_42 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_41) / var_4_42

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play107011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 107011002
		arg_8_1.duration_ = 3.1

		local var_8_0 = {
			ja = 3.1,
			ko = 1.999999999999,
			zh = 2.466,
			en = 2.766
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
				arg_8_0:Play107011003(arg_8_1)
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

			local var_11_5 = arg_8_1.actors_["1019ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["1019ui_story"].transform
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.var_.moveOldPos1019ui_story = var_11_9.localPosition
			end

			local var_11_11 = 0.001

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11
				local var_11_13 = Vector3.New(-0.2, -1.08, -5.9)

				var_11_9.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1019ui_story, var_11_13, var_11_12)

				local var_11_14 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_14.x, var_11_14.y, var_11_14.z)

				local var_11_15 = var_11_9.localEulerAngles

				var_11_15.z = 0
				var_11_15.x = 0
				var_11_9.localEulerAngles = var_11_15
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 then
				var_11_9.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_11_16 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_16.x, var_11_16.y, var_11_16.z)

				local var_11_17 = var_11_9.localEulerAngles

				var_11_17.z = 0
				var_11_17.x = 0
				var_11_9.localEulerAngles = var_11_17
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
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

				local var_11_23 = arg_8_1:GetWordFromCfg(107011002)
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

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011002", "story_v_out_107011.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_107011", "107011002", "story_v_out_107011.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_107011", "107011002", "story_v_out_107011.awb")

						arg_8_1:RecordAudio("107011002", var_11_29)
						arg_8_1:RecordAudio("107011002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_107011", "107011002", "story_v_out_107011.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_107011", "107011002", "story_v_out_107011.awb")
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play107011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 107011003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play107011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1019ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1019ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1019ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1019ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.65

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

				local var_15_8 = arg_12_1:GetWordFromCfg(107011003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 26
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
	Play107011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 107011004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play107011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.725

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(107011004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 29
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play107011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 107011005
		arg_20_1.duration_ = 3.77

		local var_20_0 = {
			ja = 2.433,
			ko = 2.366,
			zh = 3.766,
			en = 3.066
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
				arg_20_0:Play107011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1019ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1019ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_23_4 = 0

			if var_23_4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action475")
			end

			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_6 = 0
			local var_23_7 = 0.3

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[13].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_9 = arg_20_1:GetWordFromCfg(107011005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 12
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011005", "story_v_out_107011.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_107011", "107011005", "story_v_out_107011.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_107011", "107011005", "story_v_out_107011.awb")

						arg_20_1:RecordAudio("107011005", var_23_15)
						arg_20_1:RecordAudio("107011005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_107011", "107011005", "story_v_out_107011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_107011", "107011005", "story_v_out_107011.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_16 and arg_20_1.time_ < var_23_6 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play107011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 107011006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play107011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1019ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

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
			local var_27_7 = 0.8

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

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_9 = arg_24_1:GetWordFromCfg(107011006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 33
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
	Play107011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 107011007
		arg_28_1.duration_ = 6.3

		local var_28_0 = {
			ja = 5.933,
			ko = 5.633,
			zh = 5.466,
			en = 6.3
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
				arg_28_0:Play107011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1019ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

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
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_31_5 = 0
			local var_31_6 = 0.775

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_7 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_8 = arg_28_1:GetWordFromCfg(107011007)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_10 = 27
				local var_31_11 = utf8.len(var_31_9)
				local var_31_12 = var_31_10 <= 0 and var_31_6 or var_31_6 * (var_31_11 / var_31_10)

				if var_31_12 > 0 and var_31_6 < var_31_12 then
					arg_28_1.talkMaxDuration = var_31_12

					if var_31_12 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_5
					end
				end

				arg_28_1.text_.text = var_31_9
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011007", "story_v_out_107011.awb") ~= 0 then
					local var_31_13 = manager.audio:GetVoiceLength("story_v_out_107011", "107011007", "story_v_out_107011.awb") / 1000

					if var_31_13 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_5
					end

					if var_31_8.prefab_name ~= "" and arg_28_1.actors_[var_31_8.prefab_name] ~= nil then
						local var_31_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_8.prefab_name].transform, "story_v_out_107011", "107011007", "story_v_out_107011.awb")

						arg_28_1:RecordAudio("107011007", var_31_14)
						arg_28_1:RecordAudio("107011007", var_31_14)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_107011", "107011007", "story_v_out_107011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_107011", "107011007", "story_v_out_107011.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_15 = math.max(var_31_6, arg_28_1.talkMaxDuration)

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_15 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_5) / var_31_15

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_5 + var_31_15 and arg_28_1.time_ < var_31_5 + var_31_15 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play107011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 107011008
		arg_32_1.duration_ = 13.1

		local var_32_0 = {
			ja = 13.1,
			ko = 12.5,
			zh = 13,
			en = 11.4
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
				arg_32_0:Play107011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_35_2 = 0
			local var_35_3 = 1.25

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_4 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:GetWordFromCfg(107011008)
				local var_35_6 = arg_32_1:FormatText(var_35_5.content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 50
				local var_35_8 = utf8.len(var_35_6)
				local var_35_9 = var_35_7 <= 0 and var_35_3 or var_35_3 * (var_35_8 / var_35_7)

				if var_35_9 > 0 and var_35_3 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_6
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011008", "story_v_out_107011.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_107011", "107011008", "story_v_out_107011.awb") / 1000

					if var_35_10 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_2
					end

					if var_35_5.prefab_name ~= "" and arg_32_1.actors_[var_35_5.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_5.prefab_name].transform, "story_v_out_107011", "107011008", "story_v_out_107011.awb")

						arg_32_1:RecordAudio("107011008", var_35_11)
						arg_32_1:RecordAudio("107011008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_107011", "107011008", "story_v_out_107011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_107011", "107011008", "story_v_out_107011.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_12 and arg_32_1.time_ < var_35_2 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play107011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 107011009
		arg_36_1.duration_ = 0.1

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"

			SetActive(arg_36_1.choicesGo_, true)

			for iter_37_0, iter_37_1 in ipairs(arg_36_1.choices_) do
				local var_37_0 = iter_37_0 <= 1

				SetActive(iter_37_1.go, var_37_0)
			end

			arg_36_1.choices_[1].txt.text = arg_36_1:FormatText(StoryChoiceCfg[36].name)
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play107011010(arg_36_1)
			end

			arg_36_1:RecordChoiceLog(107011009, 36)
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1019ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_5
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play107011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 107011010
		arg_40_1.duration_ = 6.87

		local var_40_0 = {
			ja = 6.8,
			ko = 5.3,
			zh = 6.866,
			en = 5.766
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
				arg_40_0:Play107011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1019ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1019ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1019ui_story then
				arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_43_4 = 0

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_43_5 = 0
			local var_43_6 = 0.725

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_7 = arg_40_1:FormatText(StoryNameCfg[13].name)

				arg_40_1.leftNameTxt_.text = var_43_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_8 = arg_40_1:GetWordFromCfg(107011010)
				local var_43_9 = arg_40_1:FormatText(var_43_8.content)

				arg_40_1.text_.text = var_43_9

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_10 = 29
				local var_43_11 = utf8.len(var_43_9)
				local var_43_12 = var_43_10 <= 0 and var_43_6 or var_43_6 * (var_43_11 / var_43_10)

				if var_43_12 > 0 and var_43_6 < var_43_12 then
					arg_40_1.talkMaxDuration = var_43_12

					if var_43_12 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_5
					end
				end

				arg_40_1.text_.text = var_43_9
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011010", "story_v_out_107011.awb") ~= 0 then
					local var_43_13 = manager.audio:GetVoiceLength("story_v_out_107011", "107011010", "story_v_out_107011.awb") / 1000

					if var_43_13 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_5
					end

					if var_43_8.prefab_name ~= "" and arg_40_1.actors_[var_43_8.prefab_name] ~= nil then
						local var_43_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_8.prefab_name].transform, "story_v_out_107011", "107011010", "story_v_out_107011.awb")

						arg_40_1:RecordAudio("107011010", var_43_14)
						arg_40_1:RecordAudio("107011010", var_43_14)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_107011", "107011010", "story_v_out_107011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_107011", "107011010", "story_v_out_107011.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_15 = math.max(var_43_6, arg_40_1.talkMaxDuration)

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_15 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_5) / var_43_15

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_5 + var_43_15 and arg_40_1.time_ < var_43_5 + var_43_15 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play107011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 107011011
		arg_44_1.duration_ = 4.37

		local var_44_0 = {
			ja = 2.966,
			ko = 4.366,
			zh = 3.1,
			en = 3.133
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
				arg_44_0:Play107011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "1084ui_story"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_44_1.stage_.transform)

					var_47_2.name = var_47_0
					var_47_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_0] = var_47_2

					local var_47_3 = var_47_2:GetComponentInChildren(typeof(CharacterEffect))

					var_47_3.enabled = true

					local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_2, typeof(DynamicBoneHelper))

					if var_47_4 then
						var_47_4:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_3.transform, false)

					arg_44_1.var_[var_47_0 .. "Animator"] = var_47_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_0 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_0 .. "LipSync"] = var_47_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_5 = arg_44_1.actors_["1084ui_story"]
			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_7 = 0.1

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_7 and not isNil(var_47_5) then
				local var_47_8 = (arg_44_1.time_ - var_47_6) / var_47_7

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_5) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_6 + var_47_7 and arg_44_1.time_ < var_47_6 + var_47_7 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_9 = arg_44_1.actors_["1019ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.1

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_9) then
					local var_47_13 = Mathf.Lerp(0, 0.5, var_47_12)

					arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1019ui_story.fillRatio = var_47_13
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1019ui_story then
				local var_47_14 = 0.5

				arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1019ui_story.fillRatio = var_47_14
			end

			local var_47_15 = arg_44_1.actors_["1019ui_story"].transform
			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_15.localPosition
			end

			local var_47_17 = 0.001

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_17 then
				local var_47_18 = (arg_44_1.time_ - var_47_16) / var_47_17
				local var_47_19 = Vector3.New(-0.2, -1.08, -5.9)

				var_47_15.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, var_47_19, var_47_18)

				local var_47_20 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_20.x, var_47_20.y, var_47_20.z)

				local var_47_21 = var_47_15.localEulerAngles

				var_47_21.z = 0
				var_47_21.x = 0
				var_47_15.localEulerAngles = var_47_21
			end

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				var_47_15.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_47_22 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_22.x, var_47_22.y, var_47_22.z)

				local var_47_23 = var_47_15.localEulerAngles

				var_47_23.z = 0
				var_47_23.x = 0
				var_47_15.localEulerAngles = var_47_23
			end

			local var_47_24 = arg_44_1.actors_["1019ui_story"].transform
			local var_47_25 = 0.033

			if var_47_25 < arg_44_1.time_ and arg_44_1.time_ <= var_47_25 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_24.localPosition
			end

			local var_47_26 = 0.5

			if var_47_25 <= arg_44_1.time_ and arg_44_1.time_ < var_47_25 + var_47_26 then
				local var_47_27 = (arg_44_1.time_ - var_47_25) / var_47_26
				local var_47_28 = Vector3.New(-0.7, -1.08, -5.9)

				var_47_24.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, var_47_28, var_47_27)

				local var_47_29 = manager.ui.mainCamera.transform.position - var_47_24.position

				var_47_24.forward = Vector3.New(var_47_29.x, var_47_29.y, var_47_29.z)

				local var_47_30 = var_47_24.localEulerAngles

				var_47_30.z = 0
				var_47_30.x = 0
				var_47_24.localEulerAngles = var_47_30
			end

			if arg_44_1.time_ >= var_47_25 + var_47_26 and arg_44_1.time_ < var_47_25 + var_47_26 + arg_47_0 then
				var_47_24.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_47_31 = manager.ui.mainCamera.transform.position - var_47_24.position

				var_47_24.forward = Vector3.New(var_47_31.x, var_47_31.y, var_47_31.z)

				local var_47_32 = var_47_24.localEulerAngles

				var_47_32.z = 0
				var_47_32.x = 0
				var_47_24.localEulerAngles = var_47_32
			end

			local var_47_33 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_34 = 0

			if var_47_34 < arg_44_1.time_ and arg_44_1.time_ <= var_47_34 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_33.localPosition
			end

			local var_47_35 = 0.001

			if var_47_34 <= arg_44_1.time_ and arg_44_1.time_ < var_47_34 + var_47_35 then
				local var_47_36 = (arg_44_1.time_ - var_47_34) / var_47_35
				local var_47_37 = Vector3.New(0.7, -0.97, -6)

				var_47_33.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_37, var_47_36)

				local var_47_38 = manager.ui.mainCamera.transform.position - var_47_33.position

				var_47_33.forward = Vector3.New(var_47_38.x, var_47_38.y, var_47_38.z)

				local var_47_39 = var_47_33.localEulerAngles

				var_47_39.z = 0
				var_47_39.x = 0
				var_47_33.localEulerAngles = var_47_39
			end

			if arg_44_1.time_ >= var_47_34 + var_47_35 and arg_44_1.time_ < var_47_34 + var_47_35 + arg_47_0 then
				var_47_33.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_47_40 = manager.ui.mainCamera.transform.position - var_47_33.position

				var_47_33.forward = Vector3.New(var_47_40.x, var_47_40.y, var_47_40.z)

				local var_47_41 = var_47_33.localEulerAngles

				var_47_41.z = 0
				var_47_41.x = 0
				var_47_33.localEulerAngles = var_47_41
			end

			local var_47_42 = 0

			if var_47_42 < arg_44_1.time_ and arg_44_1.time_ <= var_47_42 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			local var_47_43 = 0

			if var_47_43 < arg_44_1.time_ and arg_44_1.time_ <= var_47_43 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_44 = 0
			local var_47_45 = 0.425

			if var_47_44 < arg_44_1.time_ and arg_44_1.time_ <= var_47_44 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_46 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_47 = arg_44_1:GetWordFromCfg(107011011)
				local var_47_48 = arg_44_1:FormatText(var_47_47.content)

				arg_44_1.text_.text = var_47_48

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_49 = 17
				local var_47_50 = utf8.len(var_47_48)
				local var_47_51 = var_47_49 <= 0 and var_47_45 or var_47_45 * (var_47_50 / var_47_49)

				if var_47_51 > 0 and var_47_45 < var_47_51 then
					arg_44_1.talkMaxDuration = var_47_51

					if var_47_51 + var_47_44 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_51 + var_47_44
					end
				end

				arg_44_1.text_.text = var_47_48
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011011", "story_v_out_107011.awb") ~= 0 then
					local var_47_52 = manager.audio:GetVoiceLength("story_v_out_107011", "107011011", "story_v_out_107011.awb") / 1000

					if var_47_52 + var_47_44 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_52 + var_47_44
					end

					if var_47_47.prefab_name ~= "" and arg_44_1.actors_[var_47_47.prefab_name] ~= nil then
						local var_47_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_47.prefab_name].transform, "story_v_out_107011", "107011011", "story_v_out_107011.awb")

						arg_44_1:RecordAudio("107011011", var_47_53)
						arg_44_1:RecordAudio("107011011", var_47_53)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_107011", "107011011", "story_v_out_107011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_107011", "107011011", "story_v_out_107011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_54 = math.max(var_47_45, arg_44_1.talkMaxDuration)

			if var_47_44 <= arg_44_1.time_ and arg_44_1.time_ < var_47_44 + var_47_54 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_44) / var_47_54

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_44 + var_47_54 and arg_44_1.time_ < var_47_44 + var_47_54 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play107011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 107011012
		arg_48_1.duration_ = 2.83

		local var_48_0 = {
			ja = 2.833,
			ko = 2.8,
			zh = 2.833,
			en = 2.733
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
				arg_48_0:Play107011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1019ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1019ui_story then
				arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1084ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1084ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_51_11 = 0
			local var_51_12 = 0.375

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_13 = arg_48_1:FormatText(StoryNameCfg[13].name)

				arg_48_1.leftNameTxt_.text = var_51_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_14 = arg_48_1:GetWordFromCfg(107011012)
				local var_51_15 = arg_48_1:FormatText(var_51_14.content)

				arg_48_1.text_.text = var_51_15

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_16 = 15
				local var_51_17 = utf8.len(var_51_15)
				local var_51_18 = var_51_16 <= 0 and var_51_12 or var_51_12 * (var_51_17 / var_51_16)

				if var_51_18 > 0 and var_51_12 < var_51_18 then
					arg_48_1.talkMaxDuration = var_51_18

					if var_51_18 + var_51_11 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_11
					end
				end

				arg_48_1.text_.text = var_51_15
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011012", "story_v_out_107011.awb") ~= 0 then
					local var_51_19 = manager.audio:GetVoiceLength("story_v_out_107011", "107011012", "story_v_out_107011.awb") / 1000

					if var_51_19 + var_51_11 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_11
					end

					if var_51_14.prefab_name ~= "" and arg_48_1.actors_[var_51_14.prefab_name] ~= nil then
						local var_51_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_14.prefab_name].transform, "story_v_out_107011", "107011012", "story_v_out_107011.awb")

						arg_48_1:RecordAudio("107011012", var_51_20)
						arg_48_1:RecordAudio("107011012", var_51_20)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_107011", "107011012", "story_v_out_107011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_107011", "107011012", "story_v_out_107011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_21 = math.max(var_51_12, arg_48_1.talkMaxDuration)

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_21 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_11) / var_51_21

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_11 + var_51_21 and arg_48_1.time_ < var_51_11 + var_51_21 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play107011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 107011013
		arg_52_1.duration_ = 0.1

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"

			SetActive(arg_52_1.choicesGo_, true)

			for iter_53_0, iter_53_1 in ipairs(arg_52_1.choices_) do
				local var_53_0 = iter_53_0 <= 1

				SetActive(iter_53_1.go, var_53_0)
			end

			arg_52_1.choices_[1].txt.text = arg_52_1:FormatText(StoryChoiceCfg[37].name)
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play107011014(arg_52_1)
			end

			arg_52_1:RecordChoiceLog(107011013, 37)
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1019ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1019ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1019ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1019ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1019ui_story.fillRatio = var_55_5
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play107011014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 107011014
		arg_56_1.duration_ = 7

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play107011015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.bgs_.A00.transform
			local var_59_1 = 1.5

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPosA00 = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, -100, 10)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosA00, var_59_4, var_59_3)
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_59_5 = "B13"

			if arg_56_1.bgs_[var_59_5] == nil then
				local var_59_6 = Object.Instantiate(arg_56_1.paintGo_)

				var_59_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_59_5)
				var_59_6.name = var_59_5
				var_59_6.transform.parent = arg_56_1.stage_.transform
				var_59_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.bgs_[var_59_5] = var_59_6
			end

			local var_59_7 = 1.4

			if var_59_7 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				local var_59_8 = manager.ui.mainCamera.transform.localPosition
				local var_59_9 = Vector3.New(0, 0, 10) + Vector3.New(var_59_8.x, var_59_8.y, 0)
				local var_59_10 = arg_56_1.bgs_.B13

				var_59_10.transform.localPosition = var_59_9
				var_59_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_59_11 = var_59_10:GetComponent("SpriteRenderer")

				if var_59_11 and var_59_11.sprite then
					local var_59_12 = (var_59_10.transform.localPosition - var_59_8).z
					local var_59_13 = manager.ui.mainCameraCom_
					local var_59_14 = 2 * var_59_12 * Mathf.Tan(var_59_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_59_15 = var_59_14 * var_59_13.aspect
					local var_59_16 = var_59_11.sprite.bounds.size.x
					local var_59_17 = var_59_11.sprite.bounds.size.y
					local var_59_18 = var_59_15 / var_59_16
					local var_59_19 = var_59_14 / var_59_17
					local var_59_20 = var_59_19 < var_59_18 and var_59_18 or var_59_19

					var_59_10.transform.localScale = Vector3.New(var_59_20, var_59_20, 0)
				end

				for iter_59_0, iter_59_1 in pairs(arg_56_1.bgs_) do
					if iter_59_0 ~= "B13" then
						iter_59_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_59_21 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_22 = 0

			if var_59_22 < arg_56_1.time_ and arg_56_1.time_ <= var_59_22 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_21.localPosition
			end

			local var_59_23 = 0.001

			if var_59_22 <= arg_56_1.time_ and arg_56_1.time_ < var_59_22 + var_59_23 then
				local var_59_24 = (arg_56_1.time_ - var_59_22) / var_59_23
				local var_59_25 = Vector3.New(0, 100, 0)

				var_59_21.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_25, var_59_24)

				local var_59_26 = manager.ui.mainCamera.transform.position - var_59_21.position

				var_59_21.forward = Vector3.New(var_59_26.x, var_59_26.y, var_59_26.z)

				local var_59_27 = var_59_21.localEulerAngles

				var_59_27.z = 0
				var_59_27.x = 0
				var_59_21.localEulerAngles = var_59_27
			end

			if arg_56_1.time_ >= var_59_22 + var_59_23 and arg_56_1.time_ < var_59_22 + var_59_23 + arg_59_0 then
				var_59_21.localPosition = Vector3.New(0, 100, 0)

				local var_59_28 = manager.ui.mainCamera.transform.position - var_59_21.position

				var_59_21.forward = Vector3.New(var_59_28.x, var_59_28.y, var_59_28.z)

				local var_59_29 = var_59_21.localEulerAngles

				var_59_29.z = 0
				var_59_29.x = 0
				var_59_21.localEulerAngles = var_59_29
			end

			local var_59_30 = arg_56_1.actors_["1019ui_story"].transform
			local var_59_31 = 0

			if var_59_31 < arg_56_1.time_ and arg_56_1.time_ <= var_59_31 + arg_59_0 then
				arg_56_1.var_.moveOldPos1019ui_story = var_59_30.localPosition
			end

			local var_59_32 = 0.001

			if var_59_31 <= arg_56_1.time_ and arg_56_1.time_ < var_59_31 + var_59_32 then
				local var_59_33 = (arg_56_1.time_ - var_59_31) / var_59_32
				local var_59_34 = Vector3.New(0, 100, 0)

				var_59_30.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1019ui_story, var_59_34, var_59_33)

				local var_59_35 = manager.ui.mainCamera.transform.position - var_59_30.position

				var_59_30.forward = Vector3.New(var_59_35.x, var_59_35.y, var_59_35.z)

				local var_59_36 = var_59_30.localEulerAngles

				var_59_36.z = 0
				var_59_36.x = 0
				var_59_30.localEulerAngles = var_59_36
			end

			if arg_56_1.time_ >= var_59_31 + var_59_32 and arg_56_1.time_ < var_59_31 + var_59_32 + arg_59_0 then
				var_59_30.localPosition = Vector3.New(0, 100, 0)

				local var_59_37 = manager.ui.mainCamera.transform.position - var_59_30.position

				var_59_30.forward = Vector3.New(var_59_37.x, var_59_37.y, var_59_37.z)

				local var_59_38 = var_59_30.localEulerAngles

				var_59_38.z = 0
				var_59_38.x = 0
				var_59_30.localEulerAngles = var_59_38
			end

			local var_59_39 = arg_56_1.bgs_.A00
			local var_59_40 = 0

			if var_59_40 < arg_56_1.time_ and arg_56_1.time_ <= var_59_40 + arg_59_0 then
				local var_59_41 = var_59_39:GetComponent("SpriteRenderer")

				if var_59_41 then
					arg_56_1.var_.alphaOldValueA00 = var_59_41.color.a
					arg_56_1.var_.alphaMatValueA00 = var_59_41
				end

				arg_56_1.var_.alphaOldValueA00 = 1
			end

			local var_59_42 = 1.5

			if var_59_40 <= arg_56_1.time_ and arg_56_1.time_ < var_59_40 + var_59_42 then
				local var_59_43 = (arg_56_1.time_ - var_59_40) / var_59_42
				local var_59_44 = Mathf.Lerp(arg_56_1.var_.alphaOldValueA00, 0, var_59_43)

				if arg_56_1.var_.alphaMatValueA00 then
					local var_59_45 = arg_56_1.var_.alphaMatValueA00.color

					var_59_45.a = var_59_44
					arg_56_1.var_.alphaMatValueA00.color = var_59_45
				end
			end

			if arg_56_1.time_ >= var_59_40 + var_59_42 and arg_56_1.time_ < var_59_40 + var_59_42 + arg_59_0 and arg_56_1.var_.alphaMatValueA00 then
				local var_59_46 = arg_56_1.var_.alphaMatValueA00
				local var_59_47 = var_59_46.color

				var_59_47.a = 0
				var_59_46.color = var_59_47
			end

			local var_59_48 = arg_56_1.bgs_.B13
			local var_59_49 = 1.5

			if var_59_49 < arg_56_1.time_ and arg_56_1.time_ <= var_59_49 + arg_59_0 then
				local var_59_50 = var_59_48:GetComponent("SpriteRenderer")

				if var_59_50 then
					arg_56_1.var_.alphaOldValueB13 = var_59_50.color.a
					arg_56_1.var_.alphaMatValueB13 = var_59_50
				end

				arg_56_1.var_.alphaOldValueB13 = 0
			end

			local var_59_51 = 1.5

			if var_59_49 <= arg_56_1.time_ and arg_56_1.time_ < var_59_49 + var_59_51 then
				local var_59_52 = (arg_56_1.time_ - var_59_49) / var_59_51
				local var_59_53 = Mathf.Lerp(arg_56_1.var_.alphaOldValueB13, 1, var_59_52)

				if arg_56_1.var_.alphaMatValueB13 then
					local var_59_54 = arg_56_1.var_.alphaMatValueB13.color

					var_59_54.a = var_59_53
					arg_56_1.var_.alphaMatValueB13.color = var_59_54
				end
			end

			if arg_56_1.time_ >= var_59_49 + var_59_51 and arg_56_1.time_ < var_59_49 + var_59_51 + arg_59_0 and arg_56_1.var_.alphaMatValueB13 then
				local var_59_55 = arg_56_1.var_.alphaMatValueB13
				local var_59_56 = var_59_55.color

				var_59_56.a = 1
				var_59_55.color = var_59_56
			end

			local var_59_57 = 0

			if var_59_57 < arg_56_1.time_ and arg_56_1.time_ <= var_59_57 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			local var_59_58 = 2

			if arg_56_1.time_ >= var_59_57 + var_59_58 and arg_56_1.time_ < var_59_57 + var_59_58 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_59 = 2
			local var_59_60 = 0.4

			if var_59_59 < arg_56_1.time_ and arg_56_1.time_ <= var_59_59 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_61 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_61:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_62 = arg_56_1:GetWordFromCfg(107011014)
				local var_59_63 = arg_56_1:FormatText(var_59_62.content)

				arg_56_1.text_.text = var_59_63

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_64 = 16
				local var_59_65 = utf8.len(var_59_63)
				local var_59_66 = var_59_64 <= 0 and var_59_60 or var_59_60 * (var_59_65 / var_59_64)

				if var_59_66 > 0 and var_59_60 < var_59_66 then
					arg_56_1.talkMaxDuration = var_59_66
					var_59_59 = var_59_59 + 0.3

					if var_59_66 + var_59_59 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_66 + var_59_59
					end
				end

				arg_56_1.text_.text = var_59_63
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_67 = var_59_59 + 0.3
			local var_59_68 = math.max(var_59_60, arg_56_1.talkMaxDuration)

			if var_59_67 <= arg_56_1.time_ and arg_56_1.time_ < var_59_67 + var_59_68 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_67) / var_59_68

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_67 + var_59_68 and arg_56_1.time_ < var_59_67 + var_59_68 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "A00",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play107011015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 107011015
		arg_62_1.duration_ = 5.03

		local var_62_0 = {
			ja = 5.033,
			ko = 3.833,
			zh = 5.033,
			en = 4.433
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play107011016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = "S0701"

			if arg_62_1.bgs_[var_65_0] == nil then
				local var_65_1 = Object.Instantiate(arg_62_1.paintGo_)

				var_65_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_65_0)
				var_65_1.name = var_65_0
				var_65_1.transform.parent = arg_62_1.stage_.transform
				var_65_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.bgs_[var_65_0] = var_65_1
			end

			local var_65_2 = 1

			if var_65_2 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				local var_65_3 = manager.ui.mainCamera.transform.localPosition
				local var_65_4 = Vector3.New(0, 0, 10) + Vector3.New(var_65_3.x, var_65_3.y, 0)
				local var_65_5 = arg_62_1.bgs_.S0701

				var_65_5.transform.localPosition = var_65_4
				var_65_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_65_6 = var_65_5:GetComponent("SpriteRenderer")

				if var_65_6 and var_65_6.sprite then
					local var_65_7 = (var_65_5.transform.localPosition - var_65_3).z
					local var_65_8 = manager.ui.mainCameraCom_
					local var_65_9 = 2 * var_65_7 * Mathf.Tan(var_65_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_65_10 = var_65_9 * var_65_8.aspect
					local var_65_11 = var_65_6.sprite.bounds.size.x
					local var_65_12 = var_65_6.sprite.bounds.size.y
					local var_65_13 = var_65_10 / var_65_11
					local var_65_14 = var_65_9 / var_65_12
					local var_65_15 = var_65_14 < var_65_13 and var_65_13 or var_65_14

					var_65_5.transform.localScale = Vector3.New(var_65_15, var_65_15, 0)
				end

				for iter_65_0, iter_65_1 in pairs(arg_62_1.bgs_) do
					if iter_65_0 ~= "S0701" then
						iter_65_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_65_16 = arg_62_1.bgs_.B13
			local var_65_17 = 0

			if var_65_17 < arg_62_1.time_ and arg_62_1.time_ <= var_65_17 + arg_65_0 then
				local var_65_18 = var_65_16:GetComponent("SpriteRenderer")

				if var_65_18 then
					arg_62_1.var_.alphaOldValueB13 = var_65_18.color.a
					arg_62_1.var_.alphaMatValueB13 = var_65_18
				end

				arg_62_1.var_.alphaOldValueB13 = 1
			end

			local var_65_19 = 1

			if var_65_17 <= arg_62_1.time_ and arg_62_1.time_ < var_65_17 + var_65_19 then
				local var_65_20 = (arg_62_1.time_ - var_65_17) / var_65_19
				local var_65_21 = Mathf.Lerp(arg_62_1.var_.alphaOldValueB13, 0, var_65_20)

				if arg_62_1.var_.alphaMatValueB13 then
					local var_65_22 = arg_62_1.var_.alphaMatValueB13.color

					var_65_22.a = var_65_21
					arg_62_1.var_.alphaMatValueB13.color = var_65_22
				end
			end

			if arg_62_1.time_ >= var_65_17 + var_65_19 and arg_62_1.time_ < var_65_17 + var_65_19 + arg_65_0 and arg_62_1.var_.alphaMatValueB13 then
				local var_65_23 = arg_62_1.var_.alphaMatValueB13
				local var_65_24 = var_65_23.color

				var_65_24.a = 0
				var_65_23.color = var_65_24
			end

			local var_65_25 = arg_62_1.bgs_.S0701
			local var_65_26 = 1

			if var_65_26 < arg_62_1.time_ and arg_62_1.time_ <= var_65_26 + arg_65_0 then
				local var_65_27 = var_65_25:GetComponent("SpriteRenderer")

				if var_65_27 then
					arg_62_1.var_.alphaOldValueS0701 = var_65_27.color.a
					arg_62_1.var_.alphaMatValueS0701 = var_65_27
				end

				arg_62_1.var_.alphaOldValueS0701 = 0
			end

			local var_65_28 = 1

			if var_65_26 <= arg_62_1.time_ and arg_62_1.time_ < var_65_26 + var_65_28 then
				local var_65_29 = (arg_62_1.time_ - var_65_26) / var_65_28
				local var_65_30 = Mathf.Lerp(arg_62_1.var_.alphaOldValueS0701, 1, var_65_29)

				if arg_62_1.var_.alphaMatValueS0701 then
					local var_65_31 = arg_62_1.var_.alphaMatValueS0701.color

					var_65_31.a = var_65_30
					arg_62_1.var_.alphaMatValueS0701.color = var_65_31
				end
			end

			if arg_62_1.time_ >= var_65_26 + var_65_28 and arg_62_1.time_ < var_65_26 + var_65_28 + arg_65_0 and arg_62_1.var_.alphaMatValueS0701 then
				local var_65_32 = arg_62_1.var_.alphaMatValueS0701
				local var_65_33 = var_65_32.color

				var_65_33.a = 1
				var_65_32.color = var_65_33
			end

			local var_65_34 = arg_62_1.bgs_.B13.transform
			local var_65_35 = 1

			if var_65_35 < arg_62_1.time_ and arg_62_1.time_ <= var_65_35 + arg_65_0 then
				arg_62_1.var_.moveOldPosB13 = var_65_34.localPosition
			end

			local var_65_36 = 0.001

			if var_65_35 <= arg_62_1.time_ and arg_62_1.time_ < var_65_35 + var_65_36 then
				local var_65_37 = (arg_62_1.time_ - var_65_35) / var_65_36
				local var_65_38 = Vector3.New(0, 100, 0)

				var_65_34.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPosB13, var_65_38, var_65_37)
			end

			if arg_62_1.time_ >= var_65_35 + var_65_36 and arg_62_1.time_ < var_65_35 + var_65_36 + arg_65_0 then
				var_65_34.localPosition = Vector3.New(0, 100, 0)
			end

			local var_65_39 = 0

			if var_65_39 < arg_62_1.time_ and arg_62_1.time_ <= var_65_39 + arg_65_0 then
				arg_62_1.allBtn_.enabled = false
			end

			local var_65_40 = 2

			if arg_62_1.time_ >= var_65_39 + var_65_40 and arg_62_1.time_ < var_65_39 + var_65_40 + arg_65_0 then
				arg_62_1.allBtn_.enabled = true
			end

			if arg_62_1.frameCnt_ <= 1 then
				arg_62_1.dialog_:SetActive(false)
			end

			local var_65_41 = 2
			local var_65_42 = 0.225

			if var_65_41 < arg_62_1.time_ and arg_62_1.time_ <= var_65_41 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				arg_62_1.dialog_:SetActive(true)

				arg_62_1.dialogCg_.alpha = 0

				local var_65_43 = LeanTween.value(arg_62_1.dialog_, 0, 1, 0.3)

				var_65_43:setOnUpdate(LuaHelper.FloatAction(function(arg_66_0)
					arg_62_1.dialogCg_.alpha = arg_66_0
				end))
				var_65_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_62_1.dialog_)
					var_65_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_62_1.duration_ = arg_62_1.duration_ + 0.3

				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_44 = arg_62_1:FormatText(StoryNameCfg[94].name)

				arg_62_1.leftNameTxt_.text = var_65_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_45 = arg_62_1:GetWordFromCfg(107011015)
				local var_65_46 = arg_62_1:FormatText(var_65_45.content)

				arg_62_1.text_.text = var_65_46

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_47 = 9
				local var_65_48 = utf8.len(var_65_46)
				local var_65_49 = var_65_47 <= 0 and var_65_42 or var_65_42 * (var_65_48 / var_65_47)

				if var_65_49 > 0 and var_65_42 < var_65_49 then
					arg_62_1.talkMaxDuration = var_65_49
					var_65_41 = var_65_41 + 0.3

					if var_65_49 + var_65_41 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_49 + var_65_41
					end
				end

				arg_62_1.text_.text = var_65_46
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011015", "story_v_out_107011.awb") ~= 0 then
					local var_65_50 = manager.audio:GetVoiceLength("story_v_out_107011", "107011015", "story_v_out_107011.awb") / 1000

					if var_65_50 + var_65_41 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_50 + var_65_41
					end

					if var_65_45.prefab_name ~= "" and arg_62_1.actors_[var_65_45.prefab_name] ~= nil then
						local var_65_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_45.prefab_name].transform, "story_v_out_107011", "107011015", "story_v_out_107011.awb")

						arg_62_1:RecordAudio("107011015", var_65_51)
						arg_62_1:RecordAudio("107011015", var_65_51)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_107011", "107011015", "story_v_out_107011.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_107011", "107011015", "story_v_out_107011.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_52 = var_65_41 + 0.3
			local var_65_53 = math.max(var_65_42, arg_62_1.talkMaxDuration)

			if var_65_52 <= arg_62_1.time_ and arg_62_1.time_ < var_65_52 + var_65_53 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_52) / var_65_53

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_52 + var_65_53 and arg_62_1.time_ < var_65_52 + var_65_53 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B13",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play107011016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 107011016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play107011017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 1.125

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(107011016)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 45
				local var_71_5 = utf8.len(var_71_3)
				local var_71_6 = var_71_4 <= 0 and var_71_1 or var_71_1 * (var_71_5 / var_71_4)

				if var_71_6 > 0 and var_71_1 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_7 and arg_68_1.time_ < var_71_0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play107011017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 107011017
		arg_72_1.duration_ = 11.97

		local var_72_0 = {
			ja = 10.833,
			ko = 9.8,
			zh = 8.9,
			en = 11.966
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
				arg_72_0:Play107011018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = "1038ui_story"

			if arg_72_1.actors_[var_75_0] == nil then
				local var_75_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_75_1) then
					local var_75_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_72_1.stage_.transform)

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

			local var_75_5 = arg_72_1.actors_["1038ui_story"]
			local var_75_6 = 0

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1038ui_story == nil then
				arg_72_1.var_.characterEffect1038ui_story = var_75_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_7 = 0.1

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_7 and not isNil(var_75_5) then
				local var_75_8 = (arg_72_1.time_ - var_75_6) / var_75_7

				if arg_72_1.var_.characterEffect1038ui_story and not isNil(var_75_5) then
					arg_72_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_6 + var_75_7 and arg_72_1.time_ < var_75_6 + var_75_7 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1038ui_story then
				arg_72_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_75_9 = 0
			local var_75_10 = 1

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_11 = arg_72_1:FormatText(StoryNameCfg[94].name)

				arg_72_1.leftNameTxt_.text = var_75_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_12 = arg_72_1:GetWordFromCfg(107011017)
				local var_75_13 = arg_72_1:FormatText(var_75_12.content)

				arg_72_1.text_.text = var_75_13

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_14 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011017", "story_v_out_107011.awb") ~= 0 then
					local var_75_17 = manager.audio:GetVoiceLength("story_v_out_107011", "107011017", "story_v_out_107011.awb") / 1000

					if var_75_17 + var_75_9 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_17 + var_75_9
					end

					if var_75_12.prefab_name ~= "" and arg_72_1.actors_[var_75_12.prefab_name] ~= nil then
						local var_75_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_12.prefab_name].transform, "story_v_out_107011", "107011017", "story_v_out_107011.awb")

						arg_72_1:RecordAudio("107011017", var_75_18)
						arg_72_1:RecordAudio("107011017", var_75_18)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_107011", "107011017", "story_v_out_107011.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_107011", "107011017", "story_v_out_107011.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_19 = math.max(var_75_10, arg_72_1.talkMaxDuration)

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_19 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_9) / var_75_19

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_9 + var_75_19 and arg_72_1.time_ < var_75_9 + var_75_19 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play107011018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 107011018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play107011019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1038ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1038ui_story == nil then
				arg_76_1.var_.characterEffect1038ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1038ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1038ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1038ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1038ui_story.fillRatio = var_79_5
			end

			local var_79_6 = 0
			local var_79_7 = 0.1

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

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_9 = arg_76_1:GetWordFromCfg(107011018)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 4
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
	Play107011019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 107011019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play107011020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.525

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_2 = arg_80_1:GetWordFromCfg(107011019)
				local var_83_3 = arg_80_1:FormatText(var_83_2.content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 21
				local var_83_5 = utf8.len(var_83_3)
				local var_83_6 = var_83_4 <= 0 and var_83_1 or var_83_1 * (var_83_5 / var_83_4)

				if var_83_6 > 0 and var_83_1 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_7 and arg_80_1.time_ < var_83_0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play107011020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 107011020
		arg_84_1.duration_ = 6.53

		local var_84_0 = {
			ja = 2.933,
			ko = 4.066,
			zh = 4.2,
			en = 6.533
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
				arg_84_0:Play107011021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1019ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1019ui_story == nil then
				arg_84_1.var_.characterEffect1019ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1019ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1019ui_story then
				arg_84_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_87_4 = 0

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_87_5 = 0
			local var_87_6 = 0.5

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_7 = arg_84_1:FormatText(StoryNameCfg[13].name)

				arg_84_1.leftNameTxt_.text = var_87_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_8 = arg_84_1:GetWordFromCfg(107011020)
				local var_87_9 = arg_84_1:FormatText(var_87_8.content)

				arg_84_1.text_.text = var_87_9

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_10 = 20
				local var_87_11 = utf8.len(var_87_9)
				local var_87_12 = var_87_10 <= 0 and var_87_6 or var_87_6 * (var_87_11 / var_87_10)

				if var_87_12 > 0 and var_87_6 < var_87_12 then
					arg_84_1.talkMaxDuration = var_87_12

					if var_87_12 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_5
					end
				end

				arg_84_1.text_.text = var_87_9
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011020", "story_v_out_107011.awb") ~= 0 then
					local var_87_13 = manager.audio:GetVoiceLength("story_v_out_107011", "107011020", "story_v_out_107011.awb") / 1000

					if var_87_13 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_5
					end

					if var_87_8.prefab_name ~= "" and arg_84_1.actors_[var_87_8.prefab_name] ~= nil then
						local var_87_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_8.prefab_name].transform, "story_v_out_107011", "107011020", "story_v_out_107011.awb")

						arg_84_1:RecordAudio("107011020", var_87_14)
						arg_84_1:RecordAudio("107011020", var_87_14)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_107011", "107011020", "story_v_out_107011.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_107011", "107011020", "story_v_out_107011.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_15 = math.max(var_87_6, arg_84_1.talkMaxDuration)

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_15 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_5) / var_87_15

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_5 + var_87_15 and arg_84_1.time_ < var_87_5 + var_87_15 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play107011021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 107011021
		arg_88_1.duration_ = 1.47

		local var_88_0 = {
			ja = 1.466,
			ko = 0.999999999999,
			zh = 0.999999999999,
			en = 1.433
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
				arg_88_0:Play107011022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1038ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1038ui_story == nil then
				arg_88_1.var_.characterEffect1038ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1038ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1038ui_story then
				arg_88_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["1019ui_story"]
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1019ui_story == nil then
				arg_88_1.var_.characterEffect1019ui_story = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.1

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 and not isNil(var_91_4) then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6

				if arg_88_1.var_.characterEffect1019ui_story and not isNil(var_91_4) then
					local var_91_8 = Mathf.Lerp(0, 0.5, var_91_7)

					arg_88_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1019ui_story.fillRatio = var_91_8
				end
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1019ui_story then
				local var_91_9 = 0.5

				arg_88_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1019ui_story.fillRatio = var_91_9
			end

			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_91_11 = 0
			local var_91_12 = 0.05

			if var_91_11 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_13 = arg_88_1:FormatText(StoryNameCfg[94].name)

				arg_88_1.leftNameTxt_.text = var_91_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_14 = arg_88_1:GetWordFromCfg(107011021)
				local var_91_15 = arg_88_1:FormatText(var_91_14.content)

				arg_88_1.text_.text = var_91_15

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_16 = 2
				local var_91_17 = utf8.len(var_91_15)
				local var_91_18 = var_91_16 <= 0 and var_91_12 or var_91_12 * (var_91_17 / var_91_16)

				if var_91_18 > 0 and var_91_12 < var_91_18 then
					arg_88_1.talkMaxDuration = var_91_18

					if var_91_18 + var_91_11 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_18 + var_91_11
					end
				end

				arg_88_1.text_.text = var_91_15
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011021", "story_v_out_107011.awb") ~= 0 then
					local var_91_19 = manager.audio:GetVoiceLength("story_v_out_107011", "107011021", "story_v_out_107011.awb") / 1000

					if var_91_19 + var_91_11 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_19 + var_91_11
					end

					if var_91_14.prefab_name ~= "" and arg_88_1.actors_[var_91_14.prefab_name] ~= nil then
						local var_91_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_14.prefab_name].transform, "story_v_out_107011", "107011021", "story_v_out_107011.awb")

						arg_88_1:RecordAudio("107011021", var_91_20)
						arg_88_1:RecordAudio("107011021", var_91_20)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_107011", "107011021", "story_v_out_107011.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_107011", "107011021", "story_v_out_107011.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_21 = math.max(var_91_12, arg_88_1.talkMaxDuration)

			if var_91_11 <= arg_88_1.time_ and arg_88_1.time_ < var_91_11 + var_91_21 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_11) / var_91_21

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_11 + var_91_21 and arg_88_1.time_ < var_91_11 + var_91_21 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play107011022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 107011022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play107011023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1038ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1038ui_story == nil then
				arg_92_1.var_.characterEffect1038ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1038ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1038ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1038ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1038ui_story.fillRatio = var_95_5
			end

			local var_95_6 = 0
			local var_95_7 = 0.725

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_8 = arg_92_1:GetWordFromCfg(107011022)
				local var_95_9 = arg_92_1:FormatText(var_95_8.content)

				arg_92_1.text_.text = var_95_9

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 29
				local var_95_11 = utf8.len(var_95_9)
				local var_95_12 = var_95_10 <= 0 and var_95_7 or var_95_7 * (var_95_11 / var_95_10)

				if var_95_12 > 0 and var_95_7 < var_95_12 then
					arg_92_1.talkMaxDuration = var_95_12

					if var_95_12 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_9
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_13 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_13 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_13

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_13 and arg_92_1.time_ < var_95_6 + var_95_13 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play107011023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 107011023
		arg_96_1.duration_ = 3.57

		local var_96_0 = {
			ja = 2.6,
			ko = 2.233,
			zh = 3.066,
			en = 3.566
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
				arg_96_0:Play107011024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1038ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1038ui_story == nil then
				arg_96_1.var_.characterEffect1038ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1038ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1038ui_story then
				arg_96_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_99_4 = 0

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_99_5 = 0
			local var_99_6 = 0.2

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_7 = arg_96_1:FormatText(StoryNameCfg[94].name)

				arg_96_1.leftNameTxt_.text = var_99_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_8 = arg_96_1:GetWordFromCfg(107011023)
				local var_99_9 = arg_96_1:FormatText(var_99_8.content)

				arg_96_1.text_.text = var_99_9

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_10 = 8
				local var_99_11 = utf8.len(var_99_9)
				local var_99_12 = var_99_10 <= 0 and var_99_6 or var_99_6 * (var_99_11 / var_99_10)

				if var_99_12 > 0 and var_99_6 < var_99_12 then
					arg_96_1.talkMaxDuration = var_99_12

					if var_99_12 + var_99_5 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_5
					end
				end

				arg_96_1.text_.text = var_99_9
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011023", "story_v_out_107011.awb") ~= 0 then
					local var_99_13 = manager.audio:GetVoiceLength("story_v_out_107011", "107011023", "story_v_out_107011.awb") / 1000

					if var_99_13 + var_99_5 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_5
					end

					if var_99_8.prefab_name ~= "" and arg_96_1.actors_[var_99_8.prefab_name] ~= nil then
						local var_99_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_8.prefab_name].transform, "story_v_out_107011", "107011023", "story_v_out_107011.awb")

						arg_96_1:RecordAudio("107011023", var_99_14)
						arg_96_1:RecordAudio("107011023", var_99_14)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_107011", "107011023", "story_v_out_107011.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_107011", "107011023", "story_v_out_107011.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_15 = math.max(var_99_6, arg_96_1.talkMaxDuration)

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_15 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_5) / var_99_15

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_5 + var_99_15 and arg_96_1.time_ < var_99_5 + var_99_15 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play107011024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 107011024
		arg_100_1.duration_ = 3.4

		local var_100_0 = {
			ja = 3.4,
			ko = 1.933,
			zh = 2.233,
			en = 2.4
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
				arg_100_0:Play107011025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1019ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1019ui_story == nil then
				arg_100_1.var_.characterEffect1019ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1019ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1019ui_story then
				arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["1038ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1038ui_story == nil then
				arg_100_1.var_.characterEffect1038ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.1

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect1038ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1038ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1038ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1038ui_story.fillRatio = var_103_9
			end

			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_103_11 = 0
			local var_103_12 = 0.3

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_13 = arg_100_1:FormatText(StoryNameCfg[13].name)

				arg_100_1.leftNameTxt_.text = var_103_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_14 = arg_100_1:GetWordFromCfg(107011024)
				local var_103_15 = arg_100_1:FormatText(var_103_14.content)

				arg_100_1.text_.text = var_103_15

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_16 = 23
				local var_103_17 = utf8.len(var_103_15)
				local var_103_18 = var_103_16 <= 0 and var_103_12 or var_103_12 * (var_103_17 / var_103_16)

				if var_103_18 > 0 and var_103_12 < var_103_18 then
					arg_100_1.talkMaxDuration = var_103_18

					if var_103_18 + var_103_11 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_18 + var_103_11
					end
				end

				arg_100_1.text_.text = var_103_15
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011024", "story_v_out_107011.awb") ~= 0 then
					local var_103_19 = manager.audio:GetVoiceLength("story_v_out_107011", "107011024", "story_v_out_107011.awb") / 1000

					if var_103_19 + var_103_11 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_19 + var_103_11
					end

					if var_103_14.prefab_name ~= "" and arg_100_1.actors_[var_103_14.prefab_name] ~= nil then
						local var_103_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_14.prefab_name].transform, "story_v_out_107011", "107011024", "story_v_out_107011.awb")

						arg_100_1:RecordAudio("107011024", var_103_20)
						arg_100_1:RecordAudio("107011024", var_103_20)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_107011", "107011024", "story_v_out_107011.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_107011", "107011024", "story_v_out_107011.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_21 = math.max(var_103_12, arg_100_1.talkMaxDuration)

			if var_103_11 <= arg_100_1.time_ and arg_100_1.time_ < var_103_11 + var_103_21 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_11) / var_103_21

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_11 + var_103_21 and arg_100_1.time_ < var_103_11 + var_103_21 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play107011025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 107011025
		arg_104_1.duration_ = 11.67

		local var_104_0 = {
			ja = 11.666,
			ko = 7.533,
			zh = 6,
			en = 8.1
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
				arg_104_0:Play107011026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1038ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1038ui_story == nil then
				arg_104_1.var_.characterEffect1038ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.1

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1038ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1038ui_story then
				arg_104_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_107_4 = arg_104_1.actors_["1019ui_story"]
			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1019ui_story == nil then
				arg_104_1.var_.characterEffect1019ui_story = var_107_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_6 = 0.1

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 and not isNil(var_107_4) then
				local var_107_7 = (arg_104_1.time_ - var_107_5) / var_107_6

				if arg_104_1.var_.characterEffect1019ui_story and not isNil(var_107_4) then
					local var_107_8 = Mathf.Lerp(0, 0.5, var_107_7)

					arg_104_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1019ui_story.fillRatio = var_107_8
				end
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1019ui_story then
				local var_107_9 = 0.5

				arg_104_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1019ui_story.fillRatio = var_107_9
			end

			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_107_11 = 0
			local var_107_12 = 0.65

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_13 = arg_104_1:FormatText(StoryNameCfg[94].name)

				arg_104_1.leftNameTxt_.text = var_107_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_14 = arg_104_1:GetWordFromCfg(107011025)
				local var_107_15 = arg_104_1:FormatText(var_107_14.content)

				arg_104_1.text_.text = var_107_15

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_16 = 26
				local var_107_17 = utf8.len(var_107_15)
				local var_107_18 = var_107_16 <= 0 and var_107_12 or var_107_12 * (var_107_17 / var_107_16)

				if var_107_18 > 0 and var_107_12 < var_107_18 then
					arg_104_1.talkMaxDuration = var_107_18

					if var_107_18 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_18 + var_107_11
					end
				end

				arg_104_1.text_.text = var_107_15
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011025", "story_v_out_107011.awb") ~= 0 then
					local var_107_19 = manager.audio:GetVoiceLength("story_v_out_107011", "107011025", "story_v_out_107011.awb") / 1000

					if var_107_19 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_19 + var_107_11
					end

					if var_107_14.prefab_name ~= "" and arg_104_1.actors_[var_107_14.prefab_name] ~= nil then
						local var_107_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_14.prefab_name].transform, "story_v_out_107011", "107011025", "story_v_out_107011.awb")

						arg_104_1:RecordAudio("107011025", var_107_20)
						arg_104_1:RecordAudio("107011025", var_107_20)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_107011", "107011025", "story_v_out_107011.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_107011", "107011025", "story_v_out_107011.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_21 = math.max(var_107_12, arg_104_1.talkMaxDuration)

			if var_107_11 <= arg_104_1.time_ and arg_104_1.time_ < var_107_11 + var_107_21 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_11) / var_107_21

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_11 + var_107_21 and arg_104_1.time_ < var_107_11 + var_107_21 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play107011026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 107011026
		arg_108_1.duration_ = 6.4

		local var_108_0 = {
			ja = 5.8,
			ko = 5.1,
			zh = 4.9,
			en = 6.4
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
				arg_108_0:Play107011027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_111_1 = 0
			local var_111_2 = 0.5

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_3 = arg_108_1:FormatText(StoryNameCfg[94].name)

				arg_108_1.leftNameTxt_.text = var_111_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_4 = arg_108_1:GetWordFromCfg(107011026)
				local var_111_5 = arg_108_1:FormatText(var_111_4.content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_6 = 20
				local var_111_7 = utf8.len(var_111_5)
				local var_111_8 = var_111_6 <= 0 and var_111_2 or var_111_2 * (var_111_7 / var_111_6)

				if var_111_8 > 0 and var_111_2 < var_111_8 then
					arg_108_1.talkMaxDuration = var_111_8

					if var_111_8 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011026", "story_v_out_107011.awb") ~= 0 then
					local var_111_9 = manager.audio:GetVoiceLength("story_v_out_107011", "107011026", "story_v_out_107011.awb") / 1000

					if var_111_9 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_1
					end

					if var_111_4.prefab_name ~= "" and arg_108_1.actors_[var_111_4.prefab_name] ~= nil then
						local var_111_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_4.prefab_name].transform, "story_v_out_107011", "107011026", "story_v_out_107011.awb")

						arg_108_1:RecordAudio("107011026", var_111_10)
						arg_108_1:RecordAudio("107011026", var_111_10)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_107011", "107011026", "story_v_out_107011.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_107011", "107011026", "story_v_out_107011.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_11 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_11 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_11

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_11 and arg_108_1.time_ < var_111_1 + var_111_11 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play107011027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 107011027
		arg_112_1.duration_ = 6.6

		local var_112_0 = {
			ja = 6.066,
			ko = 6.6,
			zh = 4.566,
			en = 4.433
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
				arg_112_0:Play107011028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1084ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.1

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1084ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1084ui_story then
				arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_115_4 = arg_112_1.actors_["1038ui_story"]
			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1038ui_story == nil then
				arg_112_1.var_.characterEffect1038ui_story = var_115_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_6 = 0.1

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_6 and not isNil(var_115_4) then
				local var_115_7 = (arg_112_1.time_ - var_115_5) / var_115_6

				if arg_112_1.var_.characterEffect1038ui_story and not isNil(var_115_4) then
					local var_115_8 = Mathf.Lerp(0, 0.5, var_115_7)

					arg_112_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1038ui_story.fillRatio = var_115_8
				end
			end

			if arg_112_1.time_ >= var_115_5 + var_115_6 and arg_112_1.time_ < var_115_5 + var_115_6 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1038ui_story then
				local var_115_9 = 0.5

				arg_112_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1038ui_story.fillRatio = var_115_9
			end

			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_115_11 = 0
			local var_115_12 = 0.65

			if var_115_11 < arg_112_1.time_ and arg_112_1.time_ <= var_115_11 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_13 = arg_112_1:FormatText(StoryNameCfg[6].name)

				arg_112_1.leftNameTxt_.text = var_115_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_14 = arg_112_1:GetWordFromCfg(107011027)
				local var_115_15 = arg_112_1:FormatText(var_115_14.content)

				arg_112_1.text_.text = var_115_15

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_16 = 37
				local var_115_17 = utf8.len(var_115_15)
				local var_115_18 = var_115_16 <= 0 and var_115_12 or var_115_12 * (var_115_17 / var_115_16)

				if var_115_18 > 0 and var_115_12 < var_115_18 then
					arg_112_1.talkMaxDuration = var_115_18

					if var_115_18 + var_115_11 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_18 + var_115_11
					end
				end

				arg_112_1.text_.text = var_115_15
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011027", "story_v_out_107011.awb") ~= 0 then
					local var_115_19 = manager.audio:GetVoiceLength("story_v_out_107011", "107011027", "story_v_out_107011.awb") / 1000

					if var_115_19 + var_115_11 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_19 + var_115_11
					end

					if var_115_14.prefab_name ~= "" and arg_112_1.actors_[var_115_14.prefab_name] ~= nil then
						local var_115_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_14.prefab_name].transform, "story_v_out_107011", "107011027", "story_v_out_107011.awb")

						arg_112_1:RecordAudio("107011027", var_115_20)
						arg_112_1:RecordAudio("107011027", var_115_20)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_107011", "107011027", "story_v_out_107011.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_107011", "107011027", "story_v_out_107011.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_21 = math.max(var_115_12, arg_112_1.talkMaxDuration)

			if var_115_11 <= arg_112_1.time_ and arg_112_1.time_ < var_115_11 + var_115_21 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_11) / var_115_21

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_11 + var_115_21 and arg_112_1.time_ < var_115_11 + var_115_21 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play107011028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 107011028
		arg_116_1.duration_ = 6.57

		local var_116_0 = {
			ja = 5.1,
			ko = 6.566,
			zh = 4.9,
			en = 3.766
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play107011029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1019ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1019ui_story == nil then
				arg_116_1.var_.characterEffect1019ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.1

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1019ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1019ui_story then
				arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_119_4 = arg_116_1.actors_["1038ui_story"]
			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect1038ui_story == nil then
				arg_116_1.var_.characterEffect1038ui_story = var_119_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.1

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 and not isNil(var_119_4) then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6

				if arg_116_1.var_.characterEffect1038ui_story and not isNil(var_119_4) then
					local var_119_8 = Mathf.Lerp(0, 0.5, var_119_7)

					arg_116_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1038ui_story.fillRatio = var_119_8
				end
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect1038ui_story then
				local var_119_9 = 0.5

				arg_116_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1038ui_story.fillRatio = var_119_9
			end

			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_119_11 = 0
			local var_119_12 = 0.7

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_13 = arg_116_1:FormatText(StoryNameCfg[13].name)

				arg_116_1.leftNameTxt_.text = var_119_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_14 = arg_116_1:GetWordFromCfg(107011028)
				local var_119_15 = arg_116_1:FormatText(var_119_14.content)

				arg_116_1.text_.text = var_119_15

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_16 = 50
				local var_119_17 = utf8.len(var_119_15)
				local var_119_18 = var_119_16 <= 0 and var_119_12 or var_119_12 * (var_119_17 / var_119_16)

				if var_119_18 > 0 and var_119_12 < var_119_18 then
					arg_116_1.talkMaxDuration = var_119_18

					if var_119_18 + var_119_11 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_18 + var_119_11
					end
				end

				arg_116_1.text_.text = var_119_15
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011028", "story_v_out_107011.awb") ~= 0 then
					local var_119_19 = manager.audio:GetVoiceLength("story_v_out_107011", "107011028", "story_v_out_107011.awb") / 1000

					if var_119_19 + var_119_11 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_19 + var_119_11
					end

					if var_119_14.prefab_name ~= "" and arg_116_1.actors_[var_119_14.prefab_name] ~= nil then
						local var_119_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_14.prefab_name].transform, "story_v_out_107011", "107011028", "story_v_out_107011.awb")

						arg_116_1:RecordAudio("107011028", var_119_20)
						arg_116_1:RecordAudio("107011028", var_119_20)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_107011", "107011028", "story_v_out_107011.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_107011", "107011028", "story_v_out_107011.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_21 = math.max(var_119_12, arg_116_1.talkMaxDuration)

			if var_119_11 <= arg_116_1.time_ and arg_116_1.time_ < var_119_11 + var_119_21 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_11) / var_119_21

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_11 + var_119_21 and arg_116_1.time_ < var_119_11 + var_119_21 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play107011029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 107011029
		arg_120_1.duration_ = 4.7

		local var_120_0 = {
			ja = 4.7,
			ko = 3.233,
			zh = 4.1,
			en = 3.9
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
				arg_120_0:Play107011030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1038ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1038ui_story == nil then
				arg_120_1.var_.characterEffect1038ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.1

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1038ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1038ui_story then
				arg_120_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_123_4 = arg_120_1.actors_["1019ui_story"]
			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect1019ui_story == nil then
				arg_120_1.var_.characterEffect1019ui_story = var_123_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_6 = 0.1

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_6 and not isNil(var_123_4) then
				local var_123_7 = (arg_120_1.time_ - var_123_5) / var_123_6

				if arg_120_1.var_.characterEffect1019ui_story and not isNil(var_123_4) then
					local var_123_8 = Mathf.Lerp(0, 0.5, var_123_7)

					arg_120_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1019ui_story.fillRatio = var_123_8
				end
			end

			if arg_120_1.time_ >= var_123_5 + var_123_6 and arg_120_1.time_ < var_123_5 + var_123_6 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect1019ui_story then
				local var_123_9 = 0.5

				arg_120_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1019ui_story.fillRatio = var_123_9
			end

			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_123_11 = 0
			local var_123_12 = 0.275

			if var_123_11 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_13 = arg_120_1:FormatText(StoryNameCfg[94].name)

				arg_120_1.leftNameTxt_.text = var_123_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_14 = arg_120_1:GetWordFromCfg(107011029)
				local var_123_15 = arg_120_1:FormatText(var_123_14.content)

				arg_120_1.text_.text = var_123_15

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_16 = 11
				local var_123_17 = utf8.len(var_123_15)
				local var_123_18 = var_123_16 <= 0 and var_123_12 or var_123_12 * (var_123_17 / var_123_16)

				if var_123_18 > 0 and var_123_12 < var_123_18 then
					arg_120_1.talkMaxDuration = var_123_18

					if var_123_18 + var_123_11 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_18 + var_123_11
					end
				end

				arg_120_1.text_.text = var_123_15
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011029", "story_v_out_107011.awb") ~= 0 then
					local var_123_19 = manager.audio:GetVoiceLength("story_v_out_107011", "107011029", "story_v_out_107011.awb") / 1000

					if var_123_19 + var_123_11 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_19 + var_123_11
					end

					if var_123_14.prefab_name ~= "" and arg_120_1.actors_[var_123_14.prefab_name] ~= nil then
						local var_123_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_14.prefab_name].transform, "story_v_out_107011", "107011029", "story_v_out_107011.awb")

						arg_120_1:RecordAudio("107011029", var_123_20)
						arg_120_1:RecordAudio("107011029", var_123_20)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_107011", "107011029", "story_v_out_107011.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_107011", "107011029", "story_v_out_107011.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_21 = math.max(var_123_12, arg_120_1.talkMaxDuration)

			if var_123_11 <= arg_120_1.time_ and arg_120_1.time_ < var_123_11 + var_123_21 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_11) / var_123_21

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_11 + var_123_21 and arg_120_1.time_ < var_123_11 + var_123_21 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play107011030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 107011030
		arg_124_1.duration_ = 13.7

		local var_124_0 = {
			ja = 13.7,
			ko = 8.933,
			zh = 9.5,
			en = 9.333
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
				arg_124_0:Play107011031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1019ui_story"]
			local var_127_1 = 1.8

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1019ui_story == nil then
				arg_124_1.var_.characterEffect1019ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.1

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1019ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1019ui_story then
				arg_124_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_127_4 = 1.5

			if var_127_4 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				local var_127_5 = manager.ui.mainCamera.transform.localPosition
				local var_127_6 = Vector3.New(0, 0, 10) + Vector3.New(var_127_5.x, var_127_5.y, 0)
				local var_127_7 = arg_124_1.bgs_.B13

				var_127_7.transform.localPosition = var_127_6
				var_127_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_127_8 = var_127_7:GetComponent("SpriteRenderer")

				if var_127_8 and var_127_8.sprite then
					local var_127_9 = (var_127_7.transform.localPosition - var_127_5).z
					local var_127_10 = manager.ui.mainCameraCom_
					local var_127_11 = 2 * var_127_9 * Mathf.Tan(var_127_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_127_12 = var_127_11 * var_127_10.aspect
					local var_127_13 = var_127_8.sprite.bounds.size.x
					local var_127_14 = var_127_8.sprite.bounds.size.y
					local var_127_15 = var_127_12 / var_127_13
					local var_127_16 = var_127_11 / var_127_14
					local var_127_17 = var_127_16 < var_127_15 and var_127_15 or var_127_16

					var_127_7.transform.localScale = Vector3.New(var_127_17, var_127_17, 0)
				end

				for iter_127_0, iter_127_1 in pairs(arg_124_1.bgs_) do
					if iter_127_0 ~= "B13" then
						iter_127_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_127_18 = arg_124_1.actors_["1019ui_story"].transform
			local var_127_19 = 1.8

			if var_127_19 < arg_124_1.time_ and arg_124_1.time_ <= var_127_19 + arg_127_0 then
				arg_124_1.var_.moveOldPos1019ui_story = var_127_18.localPosition
			end

			local var_127_20 = 0.001

			if var_127_19 <= arg_124_1.time_ and arg_124_1.time_ < var_127_19 + var_127_20 then
				local var_127_21 = (arg_124_1.time_ - var_127_19) / var_127_20
				local var_127_22 = Vector3.New(-0.2, -1.08, -5.9)

				var_127_18.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1019ui_story, var_127_22, var_127_21)

				local var_127_23 = manager.ui.mainCamera.transform.position - var_127_18.position

				var_127_18.forward = Vector3.New(var_127_23.x, var_127_23.y, var_127_23.z)

				local var_127_24 = var_127_18.localEulerAngles

				var_127_24.z = 0
				var_127_24.x = 0
				var_127_18.localEulerAngles = var_127_24
			end

			if arg_124_1.time_ >= var_127_19 + var_127_20 and arg_124_1.time_ < var_127_19 + var_127_20 + arg_127_0 then
				var_127_18.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_127_25 = manager.ui.mainCamera.transform.position - var_127_18.position

				var_127_18.forward = Vector3.New(var_127_25.x, var_127_25.y, var_127_25.z)

				local var_127_26 = var_127_18.localEulerAngles

				var_127_26.z = 0
				var_127_26.x = 0
				var_127_18.localEulerAngles = var_127_26
			end

			local var_127_27 = 1.8

			if var_127_27 < arg_124_1.time_ and arg_124_1.time_ <= var_127_27 + arg_127_0 then
				arg_124_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_127_28 = arg_124_1.bgs_.S0701
			local var_127_29 = 0

			if var_127_29 < arg_124_1.time_ and arg_124_1.time_ <= var_127_29 + arg_127_0 then
				local var_127_30 = var_127_28:GetComponent("SpriteRenderer")

				if var_127_30 then
					arg_124_1.var_.alphaOldValueS0701 = var_127_30.color.a
					arg_124_1.var_.alphaMatValueS0701 = var_127_30
				end

				arg_124_1.var_.alphaOldValueS0701 = 1
			end

			local var_127_31 = 1.5

			if var_127_29 <= arg_124_1.time_ and arg_124_1.time_ < var_127_29 + var_127_31 then
				local var_127_32 = (arg_124_1.time_ - var_127_29) / var_127_31
				local var_127_33 = Mathf.Lerp(arg_124_1.var_.alphaOldValueS0701, 0, var_127_32)

				if arg_124_1.var_.alphaMatValueS0701 then
					local var_127_34 = arg_124_1.var_.alphaMatValueS0701.color

					var_127_34.a = var_127_33
					arg_124_1.var_.alphaMatValueS0701.color = var_127_34
				end
			end

			if arg_124_1.time_ >= var_127_29 + var_127_31 and arg_124_1.time_ < var_127_29 + var_127_31 + arg_127_0 and arg_124_1.var_.alphaMatValueS0701 then
				local var_127_35 = arg_124_1.var_.alphaMatValueS0701
				local var_127_36 = var_127_35.color

				var_127_36.a = 0
				var_127_35.color = var_127_36
			end

			local var_127_37 = arg_124_1.bgs_.B13
			local var_127_38 = 1.5

			if var_127_38 < arg_124_1.time_ and arg_124_1.time_ <= var_127_38 + arg_127_0 then
				local var_127_39 = var_127_37:GetComponent("SpriteRenderer")

				if var_127_39 then
					arg_124_1.var_.alphaOldValueB13 = var_127_39.color.a
					arg_124_1.var_.alphaMatValueB13 = var_127_39
				end

				arg_124_1.var_.alphaOldValueB13 = 0
			end

			local var_127_40 = 1.5

			if var_127_38 <= arg_124_1.time_ and arg_124_1.time_ < var_127_38 + var_127_40 then
				local var_127_41 = (arg_124_1.time_ - var_127_38) / var_127_40
				local var_127_42 = Mathf.Lerp(arg_124_1.var_.alphaOldValueB13, 1, var_127_41)

				if arg_124_1.var_.alphaMatValueB13 then
					local var_127_43 = arg_124_1.var_.alphaMatValueB13.color

					var_127_43.a = var_127_42
					arg_124_1.var_.alphaMatValueB13.color = var_127_43
				end
			end

			if arg_124_1.time_ >= var_127_38 + var_127_40 and arg_124_1.time_ < var_127_38 + var_127_40 + arg_127_0 and arg_124_1.var_.alphaMatValueB13 then
				local var_127_44 = arg_124_1.var_.alphaMatValueB13
				local var_127_45 = var_127_44.color

				var_127_45.a = 1
				var_127_44.color = var_127_45
			end

			local var_127_46 = arg_124_1.bgs_.S0701.transform
			local var_127_47 = 1.5

			if var_127_47 < arg_124_1.time_ and arg_124_1.time_ <= var_127_47 + arg_127_0 then
				arg_124_1.var_.moveOldPosS0701 = var_127_46.localPosition
			end

			local var_127_48 = 0.001

			if var_127_47 <= arg_124_1.time_ and arg_124_1.time_ < var_127_47 + var_127_48 then
				local var_127_49 = (arg_124_1.time_ - var_127_47) / var_127_48
				local var_127_50 = Vector3.New(0, 100, 0)

				var_127_46.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPosS0701, var_127_50, var_127_49)
			end

			if arg_124_1.time_ >= var_127_47 + var_127_48 and arg_124_1.time_ < var_127_47 + var_127_48 + arg_127_0 then
				var_127_46.localPosition = Vector3.New(0, 100, 0)
			end

			local var_127_51 = 0

			if var_127_51 < arg_124_1.time_ and arg_124_1.time_ <= var_127_51 + arg_127_0 then
				arg_124_1.allBtn_.enabled = false
			end

			local var_127_52 = 2

			if arg_124_1.time_ >= var_127_51 + var_127_52 and arg_124_1.time_ < var_127_51 + var_127_52 + arg_127_0 then
				arg_124_1.allBtn_.enabled = true
			end

			local var_127_53 = 0

			if var_127_53 < arg_124_1.time_ and arg_124_1.time_ <= var_127_53 + arg_127_0 then
				arg_124_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if arg_124_1.frameCnt_ <= 1 then
				arg_124_1.dialog_:SetActive(false)
			end

			local var_127_54 = 2
			local var_127_55 = 0.925

			if var_127_54 < arg_124_1.time_ and arg_124_1.time_ <= var_127_54 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0

				arg_124_1.dialog_:SetActive(true)

				arg_124_1.dialogCg_.alpha = 0

				local var_127_56 = LeanTween.value(arg_124_1.dialog_, 0, 1, 0.3)

				var_127_56:setOnUpdate(LuaHelper.FloatAction(function(arg_128_0)
					arg_124_1.dialogCg_.alpha = arg_128_0
				end))
				var_127_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_124_1.dialog_)
					var_127_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_124_1.duration_ = arg_124_1.duration_ + 0.3

				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_57 = arg_124_1:FormatText(StoryNameCfg[13].name)

				arg_124_1.leftNameTxt_.text = var_127_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_58 = arg_124_1:GetWordFromCfg(107011030)
				local var_127_59 = arg_124_1:FormatText(var_127_58.content)

				arg_124_1.text_.text = var_127_59

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_60 = 37
				local var_127_61 = utf8.len(var_127_59)
				local var_127_62 = var_127_60 <= 0 and var_127_55 or var_127_55 * (var_127_61 / var_127_60)

				if var_127_62 > 0 and var_127_55 < var_127_62 then
					arg_124_1.talkMaxDuration = var_127_62
					var_127_54 = var_127_54 + 0.3

					if var_127_62 + var_127_54 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_62 + var_127_54
					end
				end

				arg_124_1.text_.text = var_127_59
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011030", "story_v_out_107011.awb") ~= 0 then
					local var_127_63 = manager.audio:GetVoiceLength("story_v_out_107011", "107011030", "story_v_out_107011.awb") / 1000

					if var_127_63 + var_127_54 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_63 + var_127_54
					end

					if var_127_58.prefab_name ~= "" and arg_124_1.actors_[var_127_58.prefab_name] ~= nil then
						local var_127_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_58.prefab_name].transform, "story_v_out_107011", "107011030", "story_v_out_107011.awb")

						arg_124_1:RecordAudio("107011030", var_127_64)
						arg_124_1:RecordAudio("107011030", var_127_64)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_107011", "107011030", "story_v_out_107011.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_107011", "107011030", "story_v_out_107011.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_65 = var_127_54 + 0.3
			local var_127_66 = math.max(var_127_55, arg_124_1.talkMaxDuration)

			if var_127_65 <= arg_124_1.time_ and arg_124_1.time_ < var_127_65 + var_127_66 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_65) / var_127_66

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_65 + var_127_66 and arg_124_1.time_ < var_127_65 + var_127_66 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "S0701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play107011031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 107011031
		arg_130_1.duration_ = 6.93

		local var_130_0 = {
			ja = 6.933,
			ko = 1.999999999999,
			zh = 5.8,
			en = 4.6
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
			arg_130_1.auto_ = false
		end

		function arg_130_1.playNext_(arg_132_0)
			arg_130_1.onStoryFinished_()
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_133_2 = 0
			local var_133_3 = 0.65

			if var_133_2 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_4 = arg_130_1:FormatText(StoryNameCfg[13].name)

				arg_130_1.leftNameTxt_.text = var_133_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_5 = arg_130_1:GetWordFromCfg(107011031)
				local var_133_6 = arg_130_1:FormatText(var_133_5.content)

				arg_130_1.text_.text = var_133_6

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_7 = 25
				local var_133_8 = utf8.len(var_133_6)
				local var_133_9 = var_133_7 <= 0 and var_133_3 or var_133_3 * (var_133_8 / var_133_7)

				if var_133_9 > 0 and var_133_3 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_2
					end
				end

				arg_130_1.text_.text = var_133_6
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107011", "107011031", "story_v_out_107011.awb") ~= 0 then
					local var_133_10 = manager.audio:GetVoiceLength("story_v_out_107011", "107011031", "story_v_out_107011.awb") / 1000

					if var_133_10 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_2
					end

					if var_133_5.prefab_name ~= "" and arg_130_1.actors_[var_133_5.prefab_name] ~= nil then
						local var_133_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_5.prefab_name].transform, "story_v_out_107011", "107011031", "story_v_out_107011.awb")

						arg_130_1:RecordAudio("107011031", var_133_11)
						arg_130_1:RecordAudio("107011031", var_133_11)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_107011", "107011031", "story_v_out_107011.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_107011", "107011031", "story_v_out_107011.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_12 = math.max(var_133_3, arg_130_1.talkMaxDuration)

			if var_133_2 <= arg_130_1.time_ and arg_130_1.time_ < var_133_2 + var_133_12 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_2) / var_133_12

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_2 + var_133_12 and arg_130_1.time_ < var_133_2 + var_133_12 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/S0701"
	},
	voices = {
		"story_v_out_107011.awb"
	}
}
