return {
	Play1106702001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106702001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1106702002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST24"

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
				local var_4_5 = arg_1_1.bgs_.ST24

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
					if iter_4_0 ~= "ST24" then
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
			local var_4_23 = 0.48971840320155

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

			local var_4_28 = 0.866666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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

			local var_4_34 = 2
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_side_1067", "se_story_1067_alarmclock", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 1.15

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
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

				local var_4_41 = arg_1_1:GetWordFromCfg(1106702001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 46
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
	Play1106702002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1106702002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1106702003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1067ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1067ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1067ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1067ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -1.06, -6.2)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1067ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1067ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1067ui_story == nil then
				arg_9_1.var_.characterEffect1067ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.2

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1067ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1067ui_story then
				arg_9_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action7_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_12_20 = 0
			local var_12_21 = 1

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				local var_12_22 = "stop"
				local var_12_23 = "effect"

				arg_9_1:AudioAction(var_12_22, var_12_23, "se_story_side_1067", "se_story_1067_alarmclock", "")
			end

			local var_12_24 = 0
			local var_12_25 = 0.275

			if var_12_24 < arg_9_1.time_ and arg_9_1.time_ <= var_12_24 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_26 = arg_9_1:FormatText(StoryNameCfg[206].name)

				arg_9_1.leftNameTxt_.text = var_12_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_27 = arg_9_1:GetWordFromCfg(1106702002)
				local var_12_28 = arg_9_1:FormatText(var_12_27.content)

				arg_9_1.text_.text = var_12_28

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_29 = 11
				local var_12_30 = utf8.len(var_12_28)
				local var_12_31 = var_12_29 <= 0 and var_12_25 or var_12_25 * (var_12_30 / var_12_29)

				if var_12_31 > 0 and var_12_25 < var_12_31 then
					arg_9_1.talkMaxDuration = var_12_31

					if var_12_31 + var_12_24 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_31 + var_12_24
					end
				end

				arg_9_1.text_.text = var_12_28
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702002", "story_v_side_new_1106702.awb") ~= 0 then
					local var_12_32 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702002", "story_v_side_new_1106702.awb") / 1000

					if var_12_32 + var_12_24 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_32 + var_12_24
					end

					if var_12_27.prefab_name ~= "" and arg_9_1.actors_[var_12_27.prefab_name] ~= nil then
						local var_12_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_27.prefab_name].transform, "story_v_side_new_1106702", "1106702002", "story_v_side_new_1106702.awb")

						arg_9_1:RecordAudio("1106702002", var_12_33)
						arg_9_1:RecordAudio("1106702002", var_12_33)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702002", "story_v_side_new_1106702.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702002", "story_v_side_new_1106702.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_34 = math.max(var_12_25, arg_9_1.talkMaxDuration)

			if var_12_24 <= arg_9_1.time_ and arg_9_1.time_ < var_12_24 + var_12_34 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_24) / var_12_34

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_24 + var_12_34 and arg_9_1.time_ < var_12_24 + var_12_34 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play1106702003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1106702003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1106702004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1067ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1067ui_story == nil then
				arg_13_1.var_.characterEffect1067ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1067ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1067ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1067ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1067ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.975

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_8 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_9 = arg_13_1:GetWordFromCfg(1106702003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 39
				local var_16_12 = utf8.len(var_16_10)
				local var_16_13 = var_16_11 <= 0 and var_16_7 or var_16_7 * (var_16_12 / var_16_11)

				if var_16_13 > 0 and var_16_7 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_14 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_14 and arg_13_1.time_ < var_16_6 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1106702004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1106702004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1106702005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.675

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

				local var_20_2 = arg_17_1:GetWordFromCfg(1106702004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 27
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
	Play1106702005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1106702005
		arg_21_1.duration_ = 8.3

		local var_21_0 = {
			zh = 7,
			ja = 8.3
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
				arg_21_0:Play1106702006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1067ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1067ui_story == nil then
				arg_21_1.var_.characterEffect1067ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1067ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1067ui_story then
				arg_21_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_24_5 = 0
			local var_24_6 = 0.875

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_7 = arg_21_1:FormatText(StoryNameCfg[206].name)

				arg_21_1.leftNameTxt_.text = var_24_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(1106702005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 35
				local var_24_11 = utf8.len(var_24_9)
				local var_24_12 = var_24_10 <= 0 and var_24_6 or var_24_6 * (var_24_11 / var_24_10)

				if var_24_12 > 0 and var_24_6 < var_24_12 then
					arg_21_1.talkMaxDuration = var_24_12

					if var_24_12 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702005", "story_v_side_new_1106702.awb") ~= 0 then
					local var_24_13 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702005", "story_v_side_new_1106702.awb") / 1000

					if var_24_13 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_5
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_side_new_1106702", "1106702005", "story_v_side_new_1106702.awb")

						arg_21_1:RecordAudio("1106702005", var_24_14)
						arg_21_1:RecordAudio("1106702005", var_24_14)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702005", "story_v_side_new_1106702.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702005", "story_v_side_new_1106702.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_15 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_15 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_15

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_15 and arg_21_1.time_ < var_24_5 + var_24_15 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1106702006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1106702006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1106702007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1067ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1067ui_story == nil then
				arg_25_1.var_.characterEffect1067ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1067ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1067ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1067ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1067ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.375

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

				local var_28_9 = arg_25_1:GetWordFromCfg(1106702006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 15
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
	Play1106702007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1106702007
		arg_29_1.duration_ = 3.3

		local var_29_0 = {
			zh = 1.999999999999,
			ja = 3.3
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
				arg_29_0:Play1106702008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1067ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1067ui_story == nil then
				arg_29_1.var_.characterEffect1067ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1067ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1067ui_story then
				arg_29_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action7_2")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_32_6 = 0
			local var_32_7 = 0.2

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[206].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(1106702007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702007", "story_v_side_new_1106702.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702007", "story_v_side_new_1106702.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_side_new_1106702", "1106702007", "story_v_side_new_1106702.awb")

						arg_29_1:RecordAudio("1106702007", var_32_15)
						arg_29_1:RecordAudio("1106702007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702007", "story_v_side_new_1106702.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702007", "story_v_side_new_1106702.awb")
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
	Play1106702008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1106702008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1106702009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1067ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1067ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1067ui_story, var_36_4, var_36_3)

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

			local var_36_9 = 0
			local var_36_10 = 1.2

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_11 = arg_33_1:GetWordFromCfg(1106702008)
				local var_36_12 = arg_33_1:FormatText(var_36_11.content)

				arg_33_1.text_.text = var_36_12

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 48
				local var_36_14 = utf8.len(var_36_12)
				local var_36_15 = var_36_13 <= 0 and var_36_10 or var_36_10 * (var_36_14 / var_36_13)

				if var_36_15 > 0 and var_36_10 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_9 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_9
					end
				end

				arg_33_1.text_.text = var_36_12
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_10, arg_33_1.talkMaxDuration)

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_9) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_9 + var_36_16 and arg_33_1.time_ < var_36_9 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play1106702009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1106702009
		arg_37_1.duration_ = 8

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1106702010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_1 = 1.5

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_1 then
				local var_40_2 = (arg_37_1.time_ - var_40_0) / var_40_1
				local var_40_3 = Color.New(0, 0, 0)

				var_40_3.a = Mathf.Lerp(0, 1, var_40_2)
				arg_37_1.mask_.color = var_40_3
			end

			if arg_37_1.time_ >= var_40_0 + var_40_1 and arg_37_1.time_ < var_40_0 + var_40_1 + arg_40_0 then
				local var_40_4 = Color.New(0, 0, 0)

				var_40_4.a = 1
				arg_37_1.mask_.color = var_40_4
			end

			local var_40_5 = 1.5

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_6 = 1.5

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6
				local var_40_8 = Color.New(0, 0, 0)

				var_40_8.a = Mathf.Lerp(1, 0, var_40_7)
				arg_37_1.mask_.color = var_40_8
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 then
				local var_40_9 = Color.New(0, 0, 0)
				local var_40_10 = 0

				arg_37_1.mask_.enabled = false
				var_40_9.a = var_40_10
				arg_37_1.mask_.color = var_40_9
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_11 = 3
			local var_40_12 = 1.325

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_13 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_13:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(1106702009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 53
				local var_40_17 = utf8.len(var_40_15)
				local var_40_18 = var_40_16 <= 0 and var_40_12 or var_40_12 * (var_40_17 / var_40_16)

				if var_40_18 > 0 and var_40_12 < var_40_18 then
					arg_37_1.talkMaxDuration = var_40_18
					var_40_11 = var_40_11 + 0.3

					if var_40_18 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_19 = var_40_11 + 0.3
			local var_40_20 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_19 <= arg_37_1.time_ and arg_37_1.time_ < var_40_19 + var_40_20 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_19) / var_40_20

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_19 + var_40_20 and arg_37_1.time_ < var_40_19 + var_40_20 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1106702010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1106702010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1106702011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.85

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(1106702010)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 34
				local var_46_5 = utf8.len(var_46_3)
				local var_46_6 = var_46_4 <= 0 and var_46_1 or var_46_1 * (var_46_5 / var_46_4)

				if var_46_6 > 0 and var_46_1 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_7 and arg_43_1.time_ < var_46_0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play1106702011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1106702011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1106702012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.125

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[7].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:GetWordFromCfg(1106702011)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 5
				local var_50_6 = utf8.len(var_50_4)
				local var_50_7 = var_50_5 <= 0 and var_50_1 or var_50_1 * (var_50_6 / var_50_5)

				if var_50_7 > 0 and var_50_1 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_8 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_8 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_8

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_8 and arg_47_1.time_ < var_50_0 + var_50_8 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play1106702012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1106702012
		arg_51_1.duration_ = 3.17

		local var_51_0 = {
			zh = 1.999999999999,
			ja = 3.166
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
				arg_51_0:Play1106702013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1067ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1067ui_story = var_54_0.localPosition
			end

			local var_54_2 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2
				local var_54_4 = Vector3.New(0, -1.06, -6.2)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1067ui_story, var_54_4, var_54_3)

				local var_54_5 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_5.x, var_54_5.y, var_54_5.z)

				local var_54_6 = var_54_0.localEulerAngles

				var_54_6.z = 0
				var_54_6.x = 0
				var_54_0.localEulerAngles = var_54_6
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_54_7 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_7.x, var_54_7.y, var_54_7.z)

				local var_54_8 = var_54_0.localEulerAngles

				var_54_8.z = 0
				var_54_8.x = 0
				var_54_0.localEulerAngles = var_54_8
			end

			local var_54_9 = arg_51_1.actors_["1067ui_story"]
			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1067ui_story == nil then
				arg_51_1.var_.characterEffect1067ui_story = var_54_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_11 = 0.2

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_11 and not isNil(var_54_9) then
				local var_54_12 = (arg_51_1.time_ - var_54_10) / var_54_11

				if arg_51_1.var_.characterEffect1067ui_story and not isNil(var_54_9) then
					arg_51_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_10 + var_54_11 and arg_51_1.time_ < var_54_10 + var_54_11 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1067ui_story then
				arg_51_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_54_13 = 0

			if var_54_13 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 then
				arg_51_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_1")
			end

			local var_54_14 = 0

			if var_54_14 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 then
				arg_51_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_54_15 = 0
			local var_54_16 = 0.175

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_17 = arg_51_1:FormatText(StoryNameCfg[206].name)

				arg_51_1.leftNameTxt_.text = var_54_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_18 = arg_51_1:GetWordFromCfg(1106702012)
				local var_54_19 = arg_51_1:FormatText(var_54_18.content)

				arg_51_1.text_.text = var_54_19

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_20 = 7
				local var_54_21 = utf8.len(var_54_19)
				local var_54_22 = var_54_20 <= 0 and var_54_16 or var_54_16 * (var_54_21 / var_54_20)

				if var_54_22 > 0 and var_54_16 < var_54_22 then
					arg_51_1.talkMaxDuration = var_54_22

					if var_54_22 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_22 + var_54_15
					end
				end

				arg_51_1.text_.text = var_54_19
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702012", "story_v_side_new_1106702.awb") ~= 0 then
					local var_54_23 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702012", "story_v_side_new_1106702.awb") / 1000

					if var_54_23 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_23 + var_54_15
					end

					if var_54_18.prefab_name ~= "" and arg_51_1.actors_[var_54_18.prefab_name] ~= nil then
						local var_54_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_18.prefab_name].transform, "story_v_side_new_1106702", "1106702012", "story_v_side_new_1106702.awb")

						arg_51_1:RecordAudio("1106702012", var_54_24)
						arg_51_1:RecordAudio("1106702012", var_54_24)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702012", "story_v_side_new_1106702.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702012", "story_v_side_new_1106702.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_25 = math.max(var_54_16, arg_51_1.talkMaxDuration)

			if var_54_15 <= arg_51_1.time_ and arg_51_1.time_ < var_54_15 + var_54_25 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_15) / var_54_25

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_15 + var_54_25 and arg_51_1.time_ < var_54_15 + var_54_25 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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

		arg_51_1:InitPlayNodeList()
	end,
	Play1106702013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1106702013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1106702014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1067ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1067ui_story == nil then
				arg_55_1.var_.characterEffect1067ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect1067ui_story and not isNil(var_58_0) then
					local var_58_4 = Mathf.Lerp(0, 0.5, var_58_3)

					arg_55_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1067ui_story.fillRatio = var_58_4
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1067ui_story then
				local var_58_5 = 0.5

				arg_55_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1067ui_story.fillRatio = var_58_5
			end

			local var_58_6 = 0
			local var_58_7 = 0.225

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_8 = arg_55_1:FormatText(StoryNameCfg[7].name)

				arg_55_1.leftNameTxt_.text = var_58_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_9 = arg_55_1:GetWordFromCfg(1106702013)
				local var_58_10 = arg_55_1:FormatText(var_58_9.content)

				arg_55_1.text_.text = var_58_10

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 9
				local var_58_12 = utf8.len(var_58_10)
				local var_58_13 = var_58_11 <= 0 and var_58_7 or var_58_7 * (var_58_12 / var_58_11)

				if var_58_13 > 0 and var_58_7 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_10
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_14 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_14 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_14

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_14 and arg_55_1.time_ < var_58_6 + var_58_14 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1106702014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1106702014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1106702015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1067ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1067ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, 100, 0)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1067ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, 100, 0)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = 0
			local var_62_10 = 0.325

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_11 = arg_59_1:GetWordFromCfg(1106702014)
				local var_62_12 = arg_59_1:FormatText(var_62_11.content)

				arg_59_1.text_.text = var_62_12

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 13
				local var_62_14 = utf8.len(var_62_12)
				local var_62_15 = var_62_13 <= 0 and var_62_10 or var_62_10 * (var_62_14 / var_62_13)

				if var_62_15 > 0 and var_62_10 < var_62_15 then
					arg_59_1.talkMaxDuration = var_62_15

					if var_62_15 + var_62_9 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_15 + var_62_9
					end
				end

				arg_59_1.text_.text = var_62_12
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_10, arg_59_1.talkMaxDuration)

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_9) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_9 + var_62_16 and arg_59_1.time_ < var_62_9 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play1106702015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1106702015
		arg_63_1.duration_ = 5.93

		local var_63_0 = {
			zh = 3.166,
			ja = 5.933
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
				arg_63_0:Play1106702016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1067ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1067ui_story == nil then
				arg_63_1.var_.characterEffect1067ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1067ui_story and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1067ui_story then
				arg_63_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_66_4 = 0

			if var_66_4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action2_1")
			end

			local var_66_5 = 0

			if var_66_5 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_66_6 = arg_63_1.actors_["1067ui_story"].transform
			local var_66_7 = 0

			if var_66_7 < arg_63_1.time_ and arg_63_1.time_ <= var_66_7 + arg_66_0 then
				arg_63_1.var_.moveOldPos1067ui_story = var_66_6.localPosition
			end

			local var_66_8 = 0.001

			if var_66_7 <= arg_63_1.time_ and arg_63_1.time_ < var_66_7 + var_66_8 then
				local var_66_9 = (arg_63_1.time_ - var_66_7) / var_66_8
				local var_66_10 = Vector3.New(0, -1.06, -6.2)

				var_66_6.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1067ui_story, var_66_10, var_66_9)

				local var_66_11 = manager.ui.mainCamera.transform.position - var_66_6.position

				var_66_6.forward = Vector3.New(var_66_11.x, var_66_11.y, var_66_11.z)

				local var_66_12 = var_66_6.localEulerAngles

				var_66_12.z = 0
				var_66_12.x = 0
				var_66_6.localEulerAngles = var_66_12
			end

			if arg_63_1.time_ >= var_66_7 + var_66_8 and arg_63_1.time_ < var_66_7 + var_66_8 + arg_66_0 then
				var_66_6.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_66_13 = manager.ui.mainCamera.transform.position - var_66_6.position

				var_66_6.forward = Vector3.New(var_66_13.x, var_66_13.y, var_66_13.z)

				local var_66_14 = var_66_6.localEulerAngles

				var_66_14.z = 0
				var_66_14.x = 0
				var_66_6.localEulerAngles = var_66_14
			end

			local var_66_15 = 0
			local var_66_16 = 0.425

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_17 = arg_63_1:FormatText(StoryNameCfg[206].name)

				arg_63_1.leftNameTxt_.text = var_66_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_18 = arg_63_1:GetWordFromCfg(1106702015)
				local var_66_19 = arg_63_1:FormatText(var_66_18.content)

				arg_63_1.text_.text = var_66_19

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_20 = 17
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702015", "story_v_side_new_1106702.awb") ~= 0 then
					local var_66_23 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702015", "story_v_side_new_1106702.awb") / 1000

					if var_66_23 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_15
					end

					if var_66_18.prefab_name ~= "" and arg_63_1.actors_[var_66_18.prefab_name] ~= nil then
						local var_66_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_18.prefab_name].transform, "story_v_side_new_1106702", "1106702015", "story_v_side_new_1106702.awb")

						arg_63_1:RecordAudio("1106702015", var_66_24)
						arg_63_1:RecordAudio("1106702015", var_66_24)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702015", "story_v_side_new_1106702.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702015", "story_v_side_new_1106702.awb")
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
				actorName = "1067ui_story",
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
	Play1106702016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1106702016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1106702017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1067ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1067ui_story == nil then
				arg_67_1.var_.characterEffect1067ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1067ui_story and not isNil(var_70_0) then
					local var_70_4 = Mathf.Lerp(0, 0.5, var_70_3)

					arg_67_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1067ui_story.fillRatio = var_70_4
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1067ui_story then
				local var_70_5 = 0.5

				arg_67_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1067ui_story.fillRatio = var_70_5
			end

			local var_70_6 = 0
			local var_70_7 = 0.375

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_8 = arg_67_1:FormatText(StoryNameCfg[7].name)

				arg_67_1.leftNameTxt_.text = var_70_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_9 = arg_67_1:GetWordFromCfg(1106702016)
				local var_70_10 = arg_67_1:FormatText(var_70_9.content)

				arg_67_1.text_.text = var_70_10

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 15
				local var_70_12 = utf8.len(var_70_10)
				local var_70_13 = var_70_11 <= 0 and var_70_7 or var_70_7 * (var_70_12 / var_70_11)

				if var_70_13 > 0 and var_70_7 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_10
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_14 and arg_67_1.time_ < var_70_6 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1106702017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1106702017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1106702018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.875

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_2 = arg_71_1:GetWordFromCfg(1106702017)
				local var_74_3 = arg_71_1:FormatText(var_74_2.content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 35
				local var_74_5 = utf8.len(var_74_3)
				local var_74_6 = var_74_4 <= 0 and var_74_1 or var_74_1 * (var_74_5 / var_74_4)

				if var_74_6 > 0 and var_74_1 < var_74_6 then
					arg_71_1.talkMaxDuration = var_74_6

					if var_74_6 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_7 and arg_71_1.time_ < var_74_0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play1106702018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1106702018
		arg_75_1.duration_ = 2

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1106702019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1067ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1067ui_story == nil then
				arg_75_1.var_.characterEffect1067ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1067ui_story and not isNil(var_78_0) then
					arg_75_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1067ui_story then
				arg_75_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_78_4 = 0

			if var_78_4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action2_2")
			end

			local var_78_5 = 0

			if var_78_5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_78_6 = 0
			local var_78_7 = 0.1

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_8 = arg_75_1:FormatText(StoryNameCfg[206].name)

				arg_75_1.leftNameTxt_.text = var_78_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_9 = arg_75_1:GetWordFromCfg(1106702018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 4
				local var_78_12 = utf8.len(var_78_10)
				local var_78_13 = var_78_11 <= 0 and var_78_7 or var_78_7 * (var_78_12 / var_78_11)

				if var_78_13 > 0 and var_78_7 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702018", "story_v_side_new_1106702.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702018", "story_v_side_new_1106702.awb") / 1000

					if var_78_14 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_6
					end

					if var_78_9.prefab_name ~= "" and arg_75_1.actors_[var_78_9.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_9.prefab_name].transform, "story_v_side_new_1106702", "1106702018", "story_v_side_new_1106702.awb")

						arg_75_1:RecordAudio("1106702018", var_78_15)
						arg_75_1:RecordAudio("1106702018", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702018", "story_v_side_new_1106702.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702018", "story_v_side_new_1106702.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_16 and arg_75_1.time_ < var_78_6 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1106702019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1106702019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1106702020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1067ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1067ui_story == nil then
				arg_79_1.var_.characterEffect1067ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1067ui_story and not isNil(var_82_0) then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1067ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1067ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1067ui_story.fillRatio = var_82_5
			end

			local var_82_6 = 0
			local var_82_7 = 0.3

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[7].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_9 = arg_79_1:GetWordFromCfg(1106702019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 12
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
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_14 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_14 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_14

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_14 and arg_79_1.time_ < var_82_6 + var_82_14 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1106702020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1106702020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1106702021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1067ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1067ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1067ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = 0
			local var_86_10 = 0.425

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_11 = arg_83_1:GetWordFromCfg(1106702020)
				local var_86_12 = arg_83_1:FormatText(var_86_11.content)

				arg_83_1.text_.text = var_86_12

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_13 = 17
				local var_86_14 = utf8.len(var_86_12)
				local var_86_15 = var_86_13 <= 0 and var_86_10 or var_86_10 * (var_86_14 / var_86_13)

				if var_86_15 > 0 and var_86_10 < var_86_15 then
					arg_83_1.talkMaxDuration = var_86_15

					if var_86_15 + var_86_9 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_15 + var_86_9
					end
				end

				arg_83_1.text_.text = var_86_12
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_10, arg_83_1.talkMaxDuration)

			if var_86_9 <= arg_83_1.time_ and arg_83_1.time_ < var_86_9 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_9) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_9 + var_86_16 and arg_83_1.time_ < var_86_9 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play1106702021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1106702021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1106702022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.2

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

				local var_90_3 = arg_87_1:GetWordFromCfg(1106702021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 8
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
	Play1106702022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1106702022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1106702023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.65

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_2 = arg_91_1:GetWordFromCfg(1106702022)
				local var_94_3 = arg_91_1:FormatText(var_94_2.content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 26
				local var_94_5 = utf8.len(var_94_3)
				local var_94_6 = var_94_4 <= 0 and var_94_1 or var_94_1 * (var_94_5 / var_94_4)

				if var_94_6 > 0 and var_94_1 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_7 and arg_91_1.time_ < var_94_0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1106702023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1106702023
		arg_95_1.duration_ = 13.67

		local var_95_0 = {
			zh = 8.9,
			ja = 13.666
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1106702024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1067ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1067ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, -1.06, -6.2)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1067ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["1067ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1067ui_story == nil then
				arg_95_1.var_.characterEffect1067ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.2

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect1067ui_story and not isNil(var_98_9) then
					arg_95_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1067ui_story then
				arg_95_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_98_15 = 0
			local var_98_16 = 1.05

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[206].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(1106702023)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 42
				local var_98_21 = utf8.len(var_98_19)
				local var_98_22 = var_98_20 <= 0 and var_98_16 or var_98_16 * (var_98_21 / var_98_20)

				if var_98_22 > 0 and var_98_16 < var_98_22 then
					arg_95_1.talkMaxDuration = var_98_22

					if var_98_22 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_15
					end
				end

				arg_95_1.text_.text = var_98_19
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702023", "story_v_side_new_1106702.awb") ~= 0 then
					local var_98_23 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702023", "story_v_side_new_1106702.awb") / 1000

					if var_98_23 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_23 + var_98_15
					end

					if var_98_18.prefab_name ~= "" and arg_95_1.actors_[var_98_18.prefab_name] ~= nil then
						local var_98_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_18.prefab_name].transform, "story_v_side_new_1106702", "1106702023", "story_v_side_new_1106702.awb")

						arg_95_1:RecordAudio("1106702023", var_98_24)
						arg_95_1:RecordAudio("1106702023", var_98_24)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702023", "story_v_side_new_1106702.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702023", "story_v_side_new_1106702.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_25 = math.max(var_98_16, arg_95_1.talkMaxDuration)

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_25 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_15) / var_98_25

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_15 + var_98_25 and arg_95_1.time_ < var_98_15 + var_98_25 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play1106702024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1106702024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1106702025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1067ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1067ui_story == nil then
				arg_99_1.var_.characterEffect1067ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.2

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1067ui_story and not isNil(var_102_0) then
					local var_102_4 = Mathf.Lerp(0, 0.5, var_102_3)

					arg_99_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1067ui_story.fillRatio = var_102_4
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1067ui_story then
				local var_102_5 = 0.5

				arg_99_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1067ui_story.fillRatio = var_102_5
			end

			local var_102_6 = 0
			local var_102_7 = 0.275

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_8 = arg_99_1:FormatText(StoryNameCfg[7].name)

				arg_99_1.leftNameTxt_.text = var_102_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_9 = arg_99_1:GetWordFromCfg(1106702024)
				local var_102_10 = arg_99_1:FormatText(var_102_9.content)

				arg_99_1.text_.text = var_102_10

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 11
				local var_102_12 = utf8.len(var_102_10)
				local var_102_13 = var_102_11 <= 0 and var_102_7 or var_102_7 * (var_102_12 / var_102_11)

				if var_102_13 > 0 and var_102_7 < var_102_13 then
					arg_99_1.talkMaxDuration = var_102_13

					if var_102_13 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_10
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_14 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_14 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_14

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_14 and arg_99_1.time_ < var_102_6 + var_102_14 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1106702025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1106702025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1106702026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.4

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

				local var_106_2 = arg_103_1:GetWordFromCfg(1106702025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 16
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
	Play1106702026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1106702026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1106702027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_2")
			end

			local var_110_1 = 0
			local var_110_2 = 0.625

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_3 = arg_107_1:FormatText(StoryNameCfg[7].name)

				arg_107_1.leftNameTxt_.text = var_110_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_4 = arg_107_1:GetWordFromCfg(1106702026)
				local var_110_5 = arg_107_1:FormatText(var_110_4.content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 25
				local var_110_7 = utf8.len(var_110_5)
				local var_110_8 = var_110_6 <= 0 and var_110_2 or var_110_2 * (var_110_7 / var_110_6)

				if var_110_8 > 0 and var_110_2 < var_110_8 then
					arg_107_1.talkMaxDuration = var_110_8

					if var_110_8 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_9 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_9 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_9

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_9 and arg_107_1.time_ < var_110_1 + var_110_9 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play1106702027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1106702027
		arg_111_1.duration_ = 8.3

		local var_111_0 = {
			zh = 5.9,
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
				arg_111_0:Play1106702028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1067ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1067ui_story == nil then
				arg_111_1.var_.characterEffect1067ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1067ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1067ui_story then
				arg_111_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_114_4 = 0

			if var_114_4 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_114_5 = 0
			local var_114_6 = 0.675

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_7 = arg_111_1:FormatText(StoryNameCfg[206].name)

				arg_111_1.leftNameTxt_.text = var_114_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_8 = arg_111_1:GetWordFromCfg(1106702027)
				local var_114_9 = arg_111_1:FormatText(var_114_8.content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 27
				local var_114_11 = utf8.len(var_114_9)
				local var_114_12 = var_114_10 <= 0 and var_114_6 or var_114_6 * (var_114_11 / var_114_10)

				if var_114_12 > 0 and var_114_6 < var_114_12 then
					arg_111_1.talkMaxDuration = var_114_12

					if var_114_12 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_5
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702027", "story_v_side_new_1106702.awb") ~= 0 then
					local var_114_13 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702027", "story_v_side_new_1106702.awb") / 1000

					if var_114_13 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_5
					end

					if var_114_8.prefab_name ~= "" and arg_111_1.actors_[var_114_8.prefab_name] ~= nil then
						local var_114_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_8.prefab_name].transform, "story_v_side_new_1106702", "1106702027", "story_v_side_new_1106702.awb")

						arg_111_1:RecordAudio("1106702027", var_114_14)
						arg_111_1:RecordAudio("1106702027", var_114_14)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702027", "story_v_side_new_1106702.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702027", "story_v_side_new_1106702.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_15 = math.max(var_114_6, arg_111_1.talkMaxDuration)

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_15 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_5) / var_114_15

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_5 + var_114_15 and arg_111_1.time_ < var_114_5 + var_114_15 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1106702028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1106702028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1106702029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1067ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1067ui_story == nil then
				arg_115_1.var_.characterEffect1067ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.2

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1067ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1067ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1067ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1067ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 0.1

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

				local var_118_9 = arg_115_1:GetWordFromCfg(1106702028)
				local var_118_10 = arg_115_1:FormatText(var_118_9.content)

				arg_115_1.text_.text = var_118_10

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 4
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
	Play1106702029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1106702029
		arg_119_1.duration_ = 8

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1106702030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = "ST28"

			if arg_119_1.bgs_[var_122_0] == nil then
				local var_122_1 = Object.Instantiate(arg_119_1.paintGo_)

				var_122_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_122_0)
				var_122_1.name = var_122_0
				var_122_1.transform.parent = arg_119_1.stage_.transform
				var_122_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.bgs_[var_122_0] = var_122_1
			end

			local var_122_2 = 1.5

			if var_122_2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				local var_122_3 = manager.ui.mainCamera.transform.localPosition
				local var_122_4 = Vector3.New(0, 0, 10) + Vector3.New(var_122_3.x, var_122_3.y, 0)
				local var_122_5 = arg_119_1.bgs_.ST28

				var_122_5.transform.localPosition = var_122_4
				var_122_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_6 = var_122_5:GetComponent("SpriteRenderer")

				if var_122_6 and var_122_6.sprite then
					local var_122_7 = (var_122_5.transform.localPosition - var_122_3).z
					local var_122_8 = manager.ui.mainCameraCom_
					local var_122_9 = 2 * var_122_7 * Mathf.Tan(var_122_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_122_10 = var_122_9 * var_122_8.aspect
					local var_122_11 = var_122_6.sprite.bounds.size.x
					local var_122_12 = var_122_6.sprite.bounds.size.y
					local var_122_13 = var_122_10 / var_122_11
					local var_122_14 = var_122_9 / var_122_12
					local var_122_15 = var_122_14 < var_122_13 and var_122_13 or var_122_14

					var_122_5.transform.localScale = Vector3.New(var_122_15, var_122_15, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "ST28" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_16 = 0

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_17 = 1.5

			if var_122_16 <= arg_119_1.time_ and arg_119_1.time_ < var_122_16 + var_122_17 then
				local var_122_18 = (arg_119_1.time_ - var_122_16) / var_122_17
				local var_122_19 = Color.New(0, 0, 0)

				var_122_19.a = Mathf.Lerp(0, 1, var_122_18)
				arg_119_1.mask_.color = var_122_19
			end

			if arg_119_1.time_ >= var_122_16 + var_122_17 and arg_119_1.time_ < var_122_16 + var_122_17 + arg_122_0 then
				local var_122_20 = Color.New(0, 0, 0)

				var_122_20.a = 1
				arg_119_1.mask_.color = var_122_20
			end

			local var_122_21 = 1.5

			if var_122_21 < arg_119_1.time_ and arg_119_1.time_ <= var_122_21 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_22 = 1.5

			if var_122_21 <= arg_119_1.time_ and arg_119_1.time_ < var_122_21 + var_122_22 then
				local var_122_23 = (arg_119_1.time_ - var_122_21) / var_122_22
				local var_122_24 = Color.New(0, 0, 0)

				var_122_24.a = Mathf.Lerp(1, 0, var_122_23)
				arg_119_1.mask_.color = var_122_24
			end

			if arg_119_1.time_ >= var_122_21 + var_122_22 and arg_119_1.time_ < var_122_21 + var_122_22 + arg_122_0 then
				local var_122_25 = Color.New(0, 0, 0)
				local var_122_26 = 0

				arg_119_1.mask_.enabled = false
				var_122_25.a = var_122_26
				arg_119_1.mask_.color = var_122_25
			end

			local var_122_27 = arg_119_1.actors_["1067ui_story"].transform
			local var_122_28 = 1.5

			if var_122_28 < arg_119_1.time_ and arg_119_1.time_ <= var_122_28 + arg_122_0 then
				arg_119_1.var_.moveOldPos1067ui_story = var_122_27.localPosition
			end

			local var_122_29 = 0.001

			if var_122_28 <= arg_119_1.time_ and arg_119_1.time_ < var_122_28 + var_122_29 then
				local var_122_30 = (arg_119_1.time_ - var_122_28) / var_122_29
				local var_122_31 = Vector3.New(0, 100, 0)

				var_122_27.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1067ui_story, var_122_31, var_122_30)

				local var_122_32 = manager.ui.mainCamera.transform.position - var_122_27.position

				var_122_27.forward = Vector3.New(var_122_32.x, var_122_32.y, var_122_32.z)

				local var_122_33 = var_122_27.localEulerAngles

				var_122_33.z = 0
				var_122_33.x = 0
				var_122_27.localEulerAngles = var_122_33
			end

			if arg_119_1.time_ >= var_122_28 + var_122_29 and arg_119_1.time_ < var_122_28 + var_122_29 + arg_122_0 then
				var_122_27.localPosition = Vector3.New(0, 100, 0)

				local var_122_34 = manager.ui.mainCamera.transform.position - var_122_27.position

				var_122_27.forward = Vector3.New(var_122_34.x, var_122_34.y, var_122_34.z)

				local var_122_35 = var_122_27.localEulerAngles

				var_122_35.z = 0
				var_122_35.x = 0
				var_122_27.localEulerAngles = var_122_35
			end

			local var_122_36 = 1.8
			local var_122_37 = 0.725

			if var_122_36 < arg_119_1.time_ and arg_119_1.time_ <= var_122_36 + arg_122_0 then
				local var_122_38 = "play"
				local var_122_39 = "effect"

				arg_119_1:AudioAction(var_122_38, var_122_39, "se_story_side_1067", "se_story_1067_brid_loop", "")
			end

			local var_122_40 = 0

			if var_122_40 < arg_119_1.time_ and arg_119_1.time_ <= var_122_40 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			local var_122_41 = 3.5

			if arg_119_1.time_ >= var_122_40 + var_122_41 and arg_119_1.time_ < var_122_40 + var_122_41 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_42 = 3
			local var_122_43 = 0.825

			if var_122_42 < arg_119_1.time_ and arg_119_1.time_ <= var_122_42 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_44 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_44:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_45 = arg_119_1:GetWordFromCfg(1106702029)
				local var_122_46 = arg_119_1:FormatText(var_122_45.content)

				arg_119_1.text_.text = var_122_46

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_47 = 33
				local var_122_48 = utf8.len(var_122_46)
				local var_122_49 = var_122_47 <= 0 and var_122_43 or var_122_43 * (var_122_48 / var_122_47)

				if var_122_49 > 0 and var_122_43 < var_122_49 then
					arg_119_1.talkMaxDuration = var_122_49
					var_122_42 = var_122_42 + 0.3

					if var_122_49 + var_122_42 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_49 + var_122_42
					end
				end

				arg_119_1.text_.text = var_122_46
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_50 = var_122_42 + 0.3
			local var_122_51 = math.max(var_122_43, arg_119_1.talkMaxDuration)

			if var_122_50 <= arg_119_1.time_ and arg_119_1.time_ < var_122_50 + var_122_51 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_50) / var_122_51

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_50 + var_122_51 and arg_119_1.time_ < var_122_50 + var_122_51 + arg_122_0 then
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
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play1106702030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1106702030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1106702031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 1.025

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(1106702030)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 41
				local var_128_5 = utf8.len(var_128_3)
				local var_128_6 = var_128_4 <= 0 and var_128_1 or var_128_1 * (var_128_5 / var_128_4)

				if var_128_6 > 0 and var_128_1 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_7 and arg_125_1.time_ < var_128_0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1106702031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1106702031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1106702032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 1.425

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

				local var_132_2 = arg_129_1:GetWordFromCfg(1106702031)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 57
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
	Play1106702032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1106702032
		arg_133_1.duration_ = 1.57

		local var_133_0 = {
			zh = 1.266,
			ja = 1.566
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1106702033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.1

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[206].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(1106702032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 4
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702032", "story_v_side_new_1106702.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702032", "story_v_side_new_1106702.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_side_new_1106702", "1106702032", "story_v_side_new_1106702.awb")

						arg_133_1:RecordAudio("1106702032", var_136_9)
						arg_133_1:RecordAudio("1106702032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702032", "story_v_side_new_1106702.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702032", "story_v_side_new_1106702.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1106702033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1106702033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1106702034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.7

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(1106702033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 28
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1106702034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1106702034
		arg_141_1.duration_ = 5.57

		local var_141_0 = {
			zh = 5.566,
			ja = 3.766
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
				arg_141_0:Play1106702035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.475

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[206].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:GetWordFromCfg(1106702034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 19
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702034", "story_v_side_new_1106702.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702034", "story_v_side_new_1106702.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_side_new_1106702", "1106702034", "story_v_side_new_1106702.awb")

						arg_141_1:RecordAudio("1106702034", var_144_9)
						arg_141_1:RecordAudio("1106702034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702034", "story_v_side_new_1106702.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702034", "story_v_side_new_1106702.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_10 and arg_141_1.time_ < var_144_0 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1106702035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1106702035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1106702036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.75

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(1106702035)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 30
				local var_148_5 = utf8.len(var_148_3)
				local var_148_6 = var_148_4 <= 0 and var_148_1 or var_148_1 * (var_148_5 / var_148_4)

				if var_148_6 > 0 and var_148_1 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_7 and arg_145_1.time_ < var_148_0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1106702036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1106702036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1106702037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.9

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

				local var_152_2 = arg_149_1:GetWordFromCfg(1106702036)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 36
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
	Play1106702037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1106702037
		arg_153_1.duration_ = 8

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1106702038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_1 = 1.5

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_1 then
				local var_156_2 = (arg_153_1.time_ - var_156_0) / var_156_1
				local var_156_3 = Color.New(0, 0, 0)

				var_156_3.a = Mathf.Lerp(0, 1, var_156_2)
				arg_153_1.mask_.color = var_156_3
			end

			if arg_153_1.time_ >= var_156_0 + var_156_1 and arg_153_1.time_ < var_156_0 + var_156_1 + arg_156_0 then
				local var_156_4 = Color.New(0, 0, 0)

				var_156_4.a = 1
				arg_153_1.mask_.color = var_156_4
			end

			local var_156_5 = 1.5

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_6 = 1.5

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 then
				local var_156_7 = (arg_153_1.time_ - var_156_5) / var_156_6
				local var_156_8 = Color.New(0, 0, 0)

				var_156_8.a = Mathf.Lerp(1, 0, var_156_7)
				arg_153_1.mask_.color = var_156_8
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 then
				local var_156_9 = Color.New(0, 0, 0)
				local var_156_10 = 0

				arg_153_1.mask_.enabled = false
				var_156_9.a = var_156_10
				arg_153_1.mask_.color = var_156_9
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_11 = 3
			local var_156_12 = 0.95

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_13 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_13:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_14 = arg_153_1:GetWordFromCfg(1106702037)
				local var_156_15 = arg_153_1:FormatText(var_156_14.content)

				arg_153_1.text_.text = var_156_15

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 38
				local var_156_17 = utf8.len(var_156_15)
				local var_156_18 = var_156_16 <= 0 and var_156_12 or var_156_12 * (var_156_17 / var_156_16)

				if var_156_18 > 0 and var_156_12 < var_156_18 then
					arg_153_1.talkMaxDuration = var_156_18
					var_156_11 = var_156_11 + 0.3

					if var_156_18 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_11
					end
				end

				arg_153_1.text_.text = var_156_15
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_19 = var_156_11 + 0.3
			local var_156_20 = math.max(var_156_12, arg_153_1.talkMaxDuration)

			if var_156_19 <= arg_153_1.time_ and arg_153_1.time_ < var_156_19 + var_156_20 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_19) / var_156_20

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_19 + var_156_20 and arg_153_1.time_ < var_156_19 + var_156_20 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1106702038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1106702038
		arg_159_1.duration_ = 3.27

		local var_159_0 = {
			zh = 1.999999999999,
			ja = 3.266
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1106702039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1067ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1067ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, -1.06, -6.2)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1067ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1067ui_story"]
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1067ui_story == nil then
				arg_159_1.var_.characterEffect1067ui_story = var_162_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.2

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 and not isNil(var_162_9) then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11

				if arg_159_1.var_.characterEffect1067ui_story and not isNil(var_162_9) then
					arg_159_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1067ui_story then
				arg_159_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_162_13 = 0

			if var_162_13 < arg_159_1.time_ and arg_159_1.time_ <= var_162_13 + arg_162_0 then
				arg_159_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action7_1")
			end

			local var_162_14 = 0

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_162_15 = 0
			local var_162_16 = 0.2

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_17 = arg_159_1:FormatText(StoryNameCfg[206].name)

				arg_159_1.leftNameTxt_.text = var_162_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_18 = arg_159_1:GetWordFromCfg(1106702038)
				local var_162_19 = arg_159_1:FormatText(var_162_18.content)

				arg_159_1.text_.text = var_162_19

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_20 = 8
				local var_162_21 = utf8.len(var_162_19)
				local var_162_22 = var_162_20 <= 0 and var_162_16 or var_162_16 * (var_162_21 / var_162_20)

				if var_162_22 > 0 and var_162_16 < var_162_22 then
					arg_159_1.talkMaxDuration = var_162_22

					if var_162_22 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_22 + var_162_15
					end
				end

				arg_159_1.text_.text = var_162_19
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702038", "story_v_side_new_1106702.awb") ~= 0 then
					local var_162_23 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702038", "story_v_side_new_1106702.awb") / 1000

					if var_162_23 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_15
					end

					if var_162_18.prefab_name ~= "" and arg_159_1.actors_[var_162_18.prefab_name] ~= nil then
						local var_162_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_18.prefab_name].transform, "story_v_side_new_1106702", "1106702038", "story_v_side_new_1106702.awb")

						arg_159_1:RecordAudio("1106702038", var_162_24)
						arg_159_1:RecordAudio("1106702038", var_162_24)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702038", "story_v_side_new_1106702.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702038", "story_v_side_new_1106702.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_25 = math.max(var_162_16, arg_159_1.talkMaxDuration)

			if var_162_15 <= arg_159_1.time_ and arg_159_1.time_ < var_162_15 + var_162_25 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_15) / var_162_25

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_15 + var_162_25 and arg_159_1.time_ < var_162_15 + var_162_25 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play1106702039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1106702039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1106702040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1067ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1067ui_story == nil then
				arg_163_1.var_.characterEffect1067ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.2

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1067ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1067ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1067ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1067ui_story.fillRatio = var_166_5
			end

			local var_166_6 = 0
			local var_166_7 = 0.25

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_8 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_9 = arg_163_1:GetWordFromCfg(1106702039)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 10
				local var_166_12 = utf8.len(var_166_10)
				local var_166_13 = var_166_11 <= 0 and var_166_7 or var_166_7 * (var_166_12 / var_166_11)

				if var_166_13 > 0 and var_166_7 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1106702040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1106702040
		arg_167_1.duration_ = 8

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1106702041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = "ST22"

			if arg_167_1.bgs_[var_170_0] == nil then
				local var_170_1 = Object.Instantiate(arg_167_1.paintGo_)

				var_170_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_170_0)
				var_170_1.name = var_170_0
				var_170_1.transform.parent = arg_167_1.stage_.transform
				var_170_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.bgs_[var_170_0] = var_170_1
			end

			local var_170_2 = 1.5

			if var_170_2 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				local var_170_3 = manager.ui.mainCamera.transform.localPosition
				local var_170_4 = Vector3.New(0, 0, 10) + Vector3.New(var_170_3.x, var_170_3.y, 0)
				local var_170_5 = arg_167_1.bgs_.ST22

				var_170_5.transform.localPosition = var_170_4
				var_170_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_170_6 = var_170_5:GetComponent("SpriteRenderer")

				if var_170_6 and var_170_6.sprite then
					local var_170_7 = (var_170_5.transform.localPosition - var_170_3).z
					local var_170_8 = manager.ui.mainCameraCom_
					local var_170_9 = 2 * var_170_7 * Mathf.Tan(var_170_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_170_10 = var_170_9 * var_170_8.aspect
					local var_170_11 = var_170_6.sprite.bounds.size.x
					local var_170_12 = var_170_6.sprite.bounds.size.y
					local var_170_13 = var_170_10 / var_170_11
					local var_170_14 = var_170_9 / var_170_12
					local var_170_15 = var_170_14 < var_170_13 and var_170_13 or var_170_14

					var_170_5.transform.localScale = Vector3.New(var_170_15, var_170_15, 0)
				end

				for iter_170_0, iter_170_1 in pairs(arg_167_1.bgs_) do
					if iter_170_0 ~= "ST22" then
						iter_170_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				arg_167_1.mask_.enabled = true
				arg_167_1.mask_.raycastTarget = true

				arg_167_1:SetGaussion(false)
			end

			local var_170_17 = 1.5

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_17 then
				local var_170_18 = (arg_167_1.time_ - var_170_16) / var_170_17
				local var_170_19 = Color.New(0, 0, 0)

				var_170_19.a = Mathf.Lerp(0, 1, var_170_18)
				arg_167_1.mask_.color = var_170_19
			end

			if arg_167_1.time_ >= var_170_16 + var_170_17 and arg_167_1.time_ < var_170_16 + var_170_17 + arg_170_0 then
				local var_170_20 = Color.New(0, 0, 0)

				var_170_20.a = 1
				arg_167_1.mask_.color = var_170_20
			end

			local var_170_21 = 1.5

			if var_170_21 < arg_167_1.time_ and arg_167_1.time_ <= var_170_21 + arg_170_0 then
				arg_167_1.mask_.enabled = true
				arg_167_1.mask_.raycastTarget = true

				arg_167_1:SetGaussion(false)
			end

			local var_170_22 = 1.5

			if var_170_21 <= arg_167_1.time_ and arg_167_1.time_ < var_170_21 + var_170_22 then
				local var_170_23 = (arg_167_1.time_ - var_170_21) / var_170_22
				local var_170_24 = Color.New(0, 0, 0)

				var_170_24.a = Mathf.Lerp(1, 0, var_170_23)
				arg_167_1.mask_.color = var_170_24
			end

			if arg_167_1.time_ >= var_170_21 + var_170_22 and arg_167_1.time_ < var_170_21 + var_170_22 + arg_170_0 then
				local var_170_25 = Color.New(0, 0, 0)
				local var_170_26 = 0

				arg_167_1.mask_.enabled = false
				var_170_25.a = var_170_26
				arg_167_1.mask_.color = var_170_25
			end

			local var_170_27 = arg_167_1.actors_["1067ui_story"].transform
			local var_170_28 = 1.5

			if var_170_28 < arg_167_1.time_ and arg_167_1.time_ <= var_170_28 + arg_170_0 then
				arg_167_1.var_.moveOldPos1067ui_story = var_170_27.localPosition
			end

			local var_170_29 = 0.001

			if var_170_28 <= arg_167_1.time_ and arg_167_1.time_ < var_170_28 + var_170_29 then
				local var_170_30 = (arg_167_1.time_ - var_170_28) / var_170_29
				local var_170_31 = Vector3.New(0, 100, 0)

				var_170_27.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1067ui_story, var_170_31, var_170_30)

				local var_170_32 = manager.ui.mainCamera.transform.position - var_170_27.position

				var_170_27.forward = Vector3.New(var_170_32.x, var_170_32.y, var_170_32.z)

				local var_170_33 = var_170_27.localEulerAngles

				var_170_33.z = 0
				var_170_33.x = 0
				var_170_27.localEulerAngles = var_170_33
			end

			if arg_167_1.time_ >= var_170_28 + var_170_29 and arg_167_1.time_ < var_170_28 + var_170_29 + arg_170_0 then
				var_170_27.localPosition = Vector3.New(0, 100, 0)

				local var_170_34 = manager.ui.mainCamera.transform.position - var_170_27.position

				var_170_27.forward = Vector3.New(var_170_34.x, var_170_34.y, var_170_34.z)

				local var_170_35 = var_170_27.localEulerAngles

				var_170_35.z = 0
				var_170_35.x = 0
				var_170_27.localEulerAngles = var_170_35
			end

			local var_170_36 = 0
			local var_170_37 = 1

			if var_170_36 < arg_167_1.time_ and arg_167_1.time_ <= var_170_36 + arg_170_0 then
				local var_170_38 = "stop"
				local var_170_39 = "effect"

				arg_167_1:AudioAction(var_170_38, var_170_39, "se_story_side_1067", "se_story_1067_brid_loop", "")
			end

			if arg_167_1.frameCnt_ <= 1 then
				arg_167_1.dialog_:SetActive(false)
			end

			local var_170_40 = 3
			local var_170_41 = 1.05

			if var_170_40 < arg_167_1.time_ and arg_167_1.time_ <= var_170_40 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				arg_167_1.dialog_:SetActive(true)

				arg_167_1.dialogCg_.alpha = 0

				local var_170_42 = LeanTween.value(arg_167_1.dialog_, 0, 1, 0.3)

				var_170_42:setOnUpdate(LuaHelper.FloatAction(function(arg_171_0)
					arg_167_1.dialogCg_.alpha = arg_171_0
				end))
				var_170_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_167_1.dialog_)
					var_170_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_167_1.duration_ = arg_167_1.duration_ + 0.3

				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_43 = arg_167_1:GetWordFromCfg(1106702040)
				local var_170_44 = arg_167_1:FormatText(var_170_43.content)

				arg_167_1.text_.text = var_170_44

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_45 = 42
				local var_170_46 = utf8.len(var_170_44)
				local var_170_47 = var_170_45 <= 0 and var_170_41 or var_170_41 * (var_170_46 / var_170_45)

				if var_170_47 > 0 and var_170_41 < var_170_47 then
					arg_167_1.talkMaxDuration = var_170_47
					var_170_40 = var_170_40 + 0.3

					if var_170_47 + var_170_40 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_47 + var_170_40
					end
				end

				arg_167_1.text_.text = var_170_44
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_48 = var_170_40 + 0.3
			local var_170_49 = math.max(var_170_41, arg_167_1.talkMaxDuration)

			if var_170_48 <= arg_167_1.time_ and arg_167_1.time_ < var_170_48 + var_170_49 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_48) / var_170_49

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_48 + var_170_49 and arg_167_1.time_ < var_170_48 + var_170_49 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play1106702041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1106702041
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1106702042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.225

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[7].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:GetWordFromCfg(1106702041)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 9
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1106702042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1106702042
		arg_177_1.duration_ = 3.1

		local var_177_0 = {
			zh = 2.2,
			ja = 3.1
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
				arg_177_0:Play1106702043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1067ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1067ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, -1.06, -6.2)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1067ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["1067ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1067ui_story == nil then
				arg_177_1.var_.characterEffect1067ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.2

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1067ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1067ui_story then
				arg_177_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_180_13 = 0

			if var_180_13 < arg_177_1.time_ and arg_177_1.time_ <= var_180_13 + arg_180_0 then
				arg_177_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				arg_177_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_180_15 = 0
			local var_180_16 = 0.275

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_17 = arg_177_1:FormatText(StoryNameCfg[206].name)

				arg_177_1.leftNameTxt_.text = var_180_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_18 = arg_177_1:GetWordFromCfg(1106702042)
				local var_180_19 = arg_177_1:FormatText(var_180_18.content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 11
				local var_180_21 = utf8.len(var_180_19)
				local var_180_22 = var_180_20 <= 0 and var_180_16 or var_180_16 * (var_180_21 / var_180_20)

				if var_180_22 > 0 and var_180_16 < var_180_22 then
					arg_177_1.talkMaxDuration = var_180_22

					if var_180_22 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_22 + var_180_15
					end
				end

				arg_177_1.text_.text = var_180_19
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702042", "story_v_side_new_1106702.awb") ~= 0 then
					local var_180_23 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702042", "story_v_side_new_1106702.awb") / 1000

					if var_180_23 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_15
					end

					if var_180_18.prefab_name ~= "" and arg_177_1.actors_[var_180_18.prefab_name] ~= nil then
						local var_180_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_18.prefab_name].transform, "story_v_side_new_1106702", "1106702042", "story_v_side_new_1106702.awb")

						arg_177_1:RecordAudio("1106702042", var_180_24)
						arg_177_1:RecordAudio("1106702042", var_180_24)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702042", "story_v_side_new_1106702.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702042", "story_v_side_new_1106702.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_25 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_25 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_25

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_25 and arg_177_1.time_ < var_180_15 + var_180_25 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play1106702043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1106702043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1106702044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1067ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1067ui_story == nil then
				arg_181_1.var_.characterEffect1067ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1067ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1067ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1067ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1067ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.325

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_9 = arg_181_1:GetWordFromCfg(1106702043)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 13
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1106702044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1106702044
		arg_185_1.duration_ = 3.9

		local var_185_0 = {
			zh = 2.9,
			ja = 3.9
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
				arg_185_0:Play1106702045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1067ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1067ui_story == nil then
				arg_185_1.var_.characterEffect1067ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1067ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1067ui_story then
				arg_185_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_188_4 = 0

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_188_5 = 0

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_188_6 = 0
			local var_188_7 = 0.3

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_8 = arg_185_1:FormatText(StoryNameCfg[206].name)

				arg_185_1.leftNameTxt_.text = var_188_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_9 = arg_185_1:GetWordFromCfg(1106702044)
				local var_188_10 = arg_185_1:FormatText(var_188_9.content)

				arg_185_1.text_.text = var_188_10

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 12
				local var_188_12 = utf8.len(var_188_10)
				local var_188_13 = var_188_11 <= 0 and var_188_7 or var_188_7 * (var_188_12 / var_188_11)

				if var_188_13 > 0 and var_188_7 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_10
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702044", "story_v_side_new_1106702.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702044", "story_v_side_new_1106702.awb") / 1000

					if var_188_14 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_6
					end

					if var_188_9.prefab_name ~= "" and arg_185_1.actors_[var_188_9.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_9.prefab_name].transform, "story_v_side_new_1106702", "1106702044", "story_v_side_new_1106702.awb")

						arg_185_1:RecordAudio("1106702044", var_188_15)
						arg_185_1:RecordAudio("1106702044", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702044", "story_v_side_new_1106702.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702044", "story_v_side_new_1106702.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_16 and arg_185_1.time_ < var_188_6 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1106702045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1106702045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1106702046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1067ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1067ui_story == nil then
				arg_189_1.var_.characterEffect1067ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1067ui_story and not isNil(var_192_0) then
					local var_192_4 = Mathf.Lerp(0, 0.5, var_192_3)

					arg_189_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1067ui_story.fillRatio = var_192_4
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1067ui_story then
				local var_192_5 = 0.5

				arg_189_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1067ui_story.fillRatio = var_192_5
			end

			local var_192_6 = 0
			local var_192_7 = 0.2

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_8 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_9 = arg_189_1:GetWordFromCfg(1106702045)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 8
				local var_192_12 = utf8.len(var_192_10)
				local var_192_13 = var_192_11 <= 0 and var_192_7 or var_192_7 * (var_192_12 / var_192_11)

				if var_192_13 > 0 and var_192_7 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_14 and arg_189_1.time_ < var_192_6 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1106702046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1106702046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1106702047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.625

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

				local var_196_2 = arg_193_1:GetWordFromCfg(1106702046)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 25
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
	Play1106702047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1106702047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1106702048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.7

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(1106702047)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 28
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_8 and arg_197_1.time_ < var_200_0 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1106702048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1106702048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1106702049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.5

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(1106702048)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 20
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_8 and arg_201_1.time_ < var_204_0 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1106702049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1106702049
		arg_205_1.duration_ = 2

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1106702050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1067ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1067ui_story == nil then
				arg_205_1.var_.characterEffect1067ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect1067ui_story and not isNil(var_208_0) then
					arg_205_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1067ui_story then
				arg_205_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_208_4 = 0

			if var_208_4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action432")
			end

			local var_208_5 = 0

			if var_208_5 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_208_6 = 0
			local var_208_7 = 0.125

			if var_208_6 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_8 = arg_205_1:FormatText(StoryNameCfg[206].name)

				arg_205_1.leftNameTxt_.text = var_208_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_9 = arg_205_1:GetWordFromCfg(1106702049)
				local var_208_10 = arg_205_1:FormatText(var_208_9.content)

				arg_205_1.text_.text = var_208_10

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_11 = 5
				local var_208_12 = utf8.len(var_208_10)
				local var_208_13 = var_208_11 <= 0 and var_208_7 or var_208_7 * (var_208_12 / var_208_11)

				if var_208_13 > 0 and var_208_7 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_6
					end
				end

				arg_205_1.text_.text = var_208_10
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702049", "story_v_side_new_1106702.awb") ~= 0 then
					local var_208_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702049", "story_v_side_new_1106702.awb") / 1000

					if var_208_14 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_6
					end

					if var_208_9.prefab_name ~= "" and arg_205_1.actors_[var_208_9.prefab_name] ~= nil then
						local var_208_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_9.prefab_name].transform, "story_v_side_new_1106702", "1106702049", "story_v_side_new_1106702.awb")

						arg_205_1:RecordAudio("1106702049", var_208_15)
						arg_205_1:RecordAudio("1106702049", var_208_15)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702049", "story_v_side_new_1106702.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702049", "story_v_side_new_1106702.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_7, arg_205_1.talkMaxDuration)

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_6) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_6 + var_208_16 and arg_205_1.time_ < var_208_6 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1106702050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1106702050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1106702051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1067ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1067ui_story == nil then
				arg_209_1.var_.characterEffect1067ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1067ui_story and not isNil(var_212_0) then
					local var_212_4 = Mathf.Lerp(0, 0.5, var_212_3)

					arg_209_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1067ui_story.fillRatio = var_212_4
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1067ui_story then
				local var_212_5 = 0.5

				arg_209_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1067ui_story.fillRatio = var_212_5
			end

			local var_212_6 = 0
			local var_212_7 = 0.375

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_8 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_9 = arg_209_1:GetWordFromCfg(1106702050)
				local var_212_10 = arg_209_1:FormatText(var_212_9.content)

				arg_209_1.text_.text = var_212_10

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 15
				local var_212_12 = utf8.len(var_212_10)
				local var_212_13 = var_212_11 <= 0 and var_212_7 or var_212_7 * (var_212_12 / var_212_11)

				if var_212_13 > 0 and var_212_7 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_10
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1106702051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1106702051
		arg_213_1.duration_ = 2

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1106702052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1067ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1067ui_story == nil then
				arg_213_1.var_.characterEffect1067ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1067ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1067ui_story then
				arg_213_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_216_4 = 0

			if var_216_4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_216_5 = 0
			local var_216_6 = 0.175

			if var_216_5 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_7 = arg_213_1:FormatText(StoryNameCfg[206].name)

				arg_213_1.leftNameTxt_.text = var_216_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_8 = arg_213_1:GetWordFromCfg(1106702051)
				local var_216_9 = arg_213_1:FormatText(var_216_8.content)

				arg_213_1.text_.text = var_216_9

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_10 = 7
				local var_216_11 = utf8.len(var_216_9)
				local var_216_12 = var_216_10 <= 0 and var_216_6 or var_216_6 * (var_216_11 / var_216_10)

				if var_216_12 > 0 and var_216_6 < var_216_12 then
					arg_213_1.talkMaxDuration = var_216_12

					if var_216_12 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_12 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_9
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702051", "story_v_side_new_1106702.awb") ~= 0 then
					local var_216_13 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702051", "story_v_side_new_1106702.awb") / 1000

					if var_216_13 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_5
					end

					if var_216_8.prefab_name ~= "" and arg_213_1.actors_[var_216_8.prefab_name] ~= nil then
						local var_216_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_8.prefab_name].transform, "story_v_side_new_1106702", "1106702051", "story_v_side_new_1106702.awb")

						arg_213_1:RecordAudio("1106702051", var_216_14)
						arg_213_1:RecordAudio("1106702051", var_216_14)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702051", "story_v_side_new_1106702.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702051", "story_v_side_new_1106702.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_15 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_15 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_5) / var_216_15

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_5 + var_216_15 and arg_213_1.time_ < var_216_5 + var_216_15 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1106702052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1106702052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1106702053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1067ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1067ui_story == nil then
				arg_217_1.var_.characterEffect1067ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1067ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1067ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1067ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1067ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 0.475

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_8 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_9 = arg_217_1:GetWordFromCfg(1106702052)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 19
				local var_220_12 = utf8.len(var_220_10)
				local var_220_13 = var_220_11 <= 0 and var_220_7 or var_220_7 * (var_220_12 / var_220_11)

				if var_220_13 > 0 and var_220_7 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_10
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1106702053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1106702053
		arg_221_1.duration_ = 5.5

		local var_221_0 = {
			zh = 4.666,
			ja = 5.5
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1106702054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1067ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1067ui_story == nil then
				arg_221_1.var_.characterEffect1067ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1067ui_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1067ui_story then
				arg_221_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_224_4 = 0

			if var_224_4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_224_5 = 0
			local var_224_6 = 0.6

			if var_224_5 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_7 = arg_221_1:FormatText(StoryNameCfg[206].name)

				arg_221_1.leftNameTxt_.text = var_224_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_8 = arg_221_1:GetWordFromCfg(1106702053)
				local var_224_9 = arg_221_1:FormatText(var_224_8.content)

				arg_221_1.text_.text = var_224_9

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_10 = 24
				local var_224_11 = utf8.len(var_224_9)
				local var_224_12 = var_224_10 <= 0 and var_224_6 or var_224_6 * (var_224_11 / var_224_10)

				if var_224_12 > 0 and var_224_6 < var_224_12 then
					arg_221_1.talkMaxDuration = var_224_12

					if var_224_12 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_12 + var_224_5
					end
				end

				arg_221_1.text_.text = var_224_9
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702053", "story_v_side_new_1106702.awb") ~= 0 then
					local var_224_13 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702053", "story_v_side_new_1106702.awb") / 1000

					if var_224_13 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_5
					end

					if var_224_8.prefab_name ~= "" and arg_221_1.actors_[var_224_8.prefab_name] ~= nil then
						local var_224_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_8.prefab_name].transform, "story_v_side_new_1106702", "1106702053", "story_v_side_new_1106702.awb")

						arg_221_1:RecordAudio("1106702053", var_224_14)
						arg_221_1:RecordAudio("1106702053", var_224_14)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702053", "story_v_side_new_1106702.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702053", "story_v_side_new_1106702.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_15 = math.max(var_224_6, arg_221_1.talkMaxDuration)

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_15 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_5) / var_224_15

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_5 + var_224_15 and arg_221_1.time_ < var_224_5 + var_224_15 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1106702054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1106702054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1106702055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1067ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1067ui_story == nil then
				arg_225_1.var_.characterEffect1067ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1067ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1067ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1067ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1067ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.15

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_9 = arg_225_1:GetWordFromCfg(1106702054)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 6
				local var_228_12 = utf8.len(var_228_10)
				local var_228_13 = var_228_11 <= 0 and var_228_7 or var_228_7 * (var_228_12 / var_228_11)

				if var_228_13 > 0 and var_228_7 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1106702055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1106702055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1106702056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1067ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos1067ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(0, 100, 0)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1067ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, 100, 0)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = 0
			local var_232_10 = 1

			if var_232_9 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 then
				local var_232_11 = "play"
				local var_232_12 = "effect"

				arg_229_1:AudioAction(var_232_11, var_232_12, "se_story_side_1067", "se_story_1067_horse01", "")
			end

			local var_232_13 = 0
			local var_232_14 = 0.4

			if var_232_13 < arg_229_1.time_ and arg_229_1.time_ <= var_232_13 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_15 = arg_229_1:GetWordFromCfg(1106702055)
				local var_232_16 = arg_229_1:FormatText(var_232_15.content)

				arg_229_1.text_.text = var_232_16

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_17 = 16
				local var_232_18 = utf8.len(var_232_16)
				local var_232_19 = var_232_17 <= 0 and var_232_14 or var_232_14 * (var_232_18 / var_232_17)

				if var_232_19 > 0 and var_232_14 < var_232_19 then
					arg_229_1.talkMaxDuration = var_232_19

					if var_232_19 + var_232_13 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_19 + var_232_13
					end
				end

				arg_229_1.text_.text = var_232_16
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_20 = math.max(var_232_14, arg_229_1.talkMaxDuration)

			if var_232_13 <= arg_229_1.time_ and arg_229_1.time_ < var_232_13 + var_232_20 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_13) / var_232_20

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_13 + var_232_20 and arg_229_1.time_ < var_232_13 + var_232_20 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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

		arg_229_1:InitPlayNodeList()
	end,
	Play1106702056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1106702056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1106702057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 1

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				local var_236_2 = "play"
				local var_236_3 = "effect"

				arg_233_1:AudioAction(var_236_2, var_236_3, "se_story_side_1067", "se_story_1067_accident", "")
			end

			local var_236_4 = 0
			local var_236_5 = 1.85

			if var_236_4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(1106702056)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_8 = 74
				local var_236_9 = utf8.len(var_236_7)
				local var_236_10 = var_236_8 <= 0 and var_236_5 or var_236_5 * (var_236_9 / var_236_8)

				if var_236_10 > 0 and var_236_5 < var_236_10 then
					arg_233_1.talkMaxDuration = var_236_10

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_11 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_11 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_11

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_11 and arg_233_1.time_ < var_236_4 + var_236_11 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1106702057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1106702057
		arg_237_1.duration_ = 3.7

		local var_237_0 = {
			zh = 2,
			ja = 3.7
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
				arg_237_0:Play1106702058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1067ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1067ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(0, -1.06, -6.2)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1067ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = arg_237_1.actors_["1067ui_story"]
			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1067ui_story == nil then
				arg_237_1.var_.characterEffect1067ui_story = var_240_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_11 = 0.2

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_11 and not isNil(var_240_9) then
				local var_240_12 = (arg_237_1.time_ - var_240_10) / var_240_11

				if arg_237_1.var_.characterEffect1067ui_story and not isNil(var_240_9) then
					arg_237_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_10 + var_240_11 and arg_237_1.time_ < var_240_10 + var_240_11 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1067ui_story then
				arg_237_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_240_13 = 0

			if var_240_13 < arg_237_1.time_ and arg_237_1.time_ <= var_240_13 + arg_240_0 then
				arg_237_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_1")
			end

			local var_240_14 = 0

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_240_15 = 0
			local var_240_16 = 0.175

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_17 = arg_237_1:FormatText(StoryNameCfg[206].name)

				arg_237_1.leftNameTxt_.text = var_240_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_18 = arg_237_1:GetWordFromCfg(1106702057)
				local var_240_19 = arg_237_1:FormatText(var_240_18.content)

				arg_237_1.text_.text = var_240_19

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_20 = 7
				local var_240_21 = utf8.len(var_240_19)
				local var_240_22 = var_240_20 <= 0 and var_240_16 or var_240_16 * (var_240_21 / var_240_20)

				if var_240_22 > 0 and var_240_16 < var_240_22 then
					arg_237_1.talkMaxDuration = var_240_22

					if var_240_22 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_22 + var_240_15
					end
				end

				arg_237_1.text_.text = var_240_19
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702057", "story_v_side_new_1106702.awb") ~= 0 then
					local var_240_23 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702057", "story_v_side_new_1106702.awb") / 1000

					if var_240_23 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_23 + var_240_15
					end

					if var_240_18.prefab_name ~= "" and arg_237_1.actors_[var_240_18.prefab_name] ~= nil then
						local var_240_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_18.prefab_name].transform, "story_v_side_new_1106702", "1106702057", "story_v_side_new_1106702.awb")

						arg_237_1:RecordAudio("1106702057", var_240_24)
						arg_237_1:RecordAudio("1106702057", var_240_24)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702057", "story_v_side_new_1106702.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702057", "story_v_side_new_1106702.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_25 = math.max(var_240_16, arg_237_1.talkMaxDuration)

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_25 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_25

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_25 and arg_237_1.time_ < var_240_15 + var_240_25 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play1106702058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1106702058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1106702059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1067ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1067ui_story == nil then
				arg_241_1.var_.characterEffect1067ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.2

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1067ui_story and not isNil(var_244_0) then
					local var_244_4 = Mathf.Lerp(0, 0.5, var_244_3)

					arg_241_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1067ui_story.fillRatio = var_244_4
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1067ui_story then
				local var_244_5 = 0.5

				arg_241_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1067ui_story.fillRatio = var_244_5
			end

			local var_244_6 = 0
			local var_244_7 = 0.35

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_8 = arg_241_1:FormatText(StoryNameCfg[7].name)

				arg_241_1.leftNameTxt_.text = var_244_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_9 = arg_241_1:GetWordFromCfg(1106702058)
				local var_244_10 = arg_241_1:FormatText(var_244_9.content)

				arg_241_1.text_.text = var_244_10

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 14
				local var_244_12 = utf8.len(var_244_10)
				local var_244_13 = var_244_11 <= 0 and var_244_7 or var_244_7 * (var_244_12 / var_244_11)

				if var_244_13 > 0 and var_244_7 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_10
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_14 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_14 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_14

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_14 and arg_241_1.time_ < var_244_6 + var_244_14 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1106702059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1106702059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1106702060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1067ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1067ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(0, 100, 0)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1067ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(0, 100, 0)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = 0
			local var_248_10 = 0.95

			if var_248_9 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_11 = arg_245_1:GetWordFromCfg(1106702059)
				local var_248_12 = arg_245_1:FormatText(var_248_11.content)

				arg_245_1.text_.text = var_248_12

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_13 = 38
				local var_248_14 = utf8.len(var_248_12)
				local var_248_15 = var_248_13 <= 0 and var_248_10 or var_248_10 * (var_248_14 / var_248_13)

				if var_248_15 > 0 and var_248_10 < var_248_15 then
					arg_245_1.talkMaxDuration = var_248_15

					if var_248_15 + var_248_9 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_15 + var_248_9
					end
				end

				arg_245_1.text_.text = var_248_12
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_16 = math.max(var_248_10, arg_245_1.talkMaxDuration)

			if var_248_9 <= arg_245_1.time_ and arg_245_1.time_ < var_248_9 + var_248_16 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_9) / var_248_16

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_9 + var_248_16 and arg_245_1.time_ < var_248_9 + var_248_16 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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

		arg_245_1:InitPlayNodeList()
	end,
	Play1106702060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1106702060
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1106702061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.65

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_2 = arg_249_1:GetWordFromCfg(1106702060)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 26
				local var_252_5 = utf8.len(var_252_3)
				local var_252_6 = var_252_4 <= 0 and var_252_1 or var_252_1 * (var_252_5 / var_252_4)

				if var_252_6 > 0 and var_252_1 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_7 and arg_249_1.time_ < var_252_0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1106702061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1106702061
		arg_253_1.duration_ = 2

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1106702062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1067ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1067ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(0, -1.06, -6.2)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1067ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = arg_253_1.actors_["1067ui_story"]
			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1067ui_story == nil then
				arg_253_1.var_.characterEffect1067ui_story = var_256_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_11 = 0.2

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_11 and not isNil(var_256_9) then
				local var_256_12 = (arg_253_1.time_ - var_256_10) / var_256_11

				if arg_253_1.var_.characterEffect1067ui_story and not isNil(var_256_9) then
					arg_253_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_10 + var_256_11 and arg_253_1.time_ < var_256_10 + var_256_11 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1067ui_story then
				arg_253_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_256_13 = 0

			if var_256_13 < arg_253_1.time_ and arg_253_1.time_ <= var_256_13 + arg_256_0 then
				arg_253_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action7_1")
			end

			local var_256_14 = 0

			if var_256_14 < arg_253_1.time_ and arg_253_1.time_ <= var_256_14 + arg_256_0 then
				arg_253_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_256_15 = 0
			local var_256_16 = 0.1

			if var_256_15 < arg_253_1.time_ and arg_253_1.time_ <= var_256_15 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_17 = arg_253_1:FormatText(StoryNameCfg[206].name)

				arg_253_1.leftNameTxt_.text = var_256_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_18 = arg_253_1:GetWordFromCfg(1106702061)
				local var_256_19 = arg_253_1:FormatText(var_256_18.content)

				arg_253_1.text_.text = var_256_19

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_20 = 4
				local var_256_21 = utf8.len(var_256_19)
				local var_256_22 = var_256_20 <= 0 and var_256_16 or var_256_16 * (var_256_21 / var_256_20)

				if var_256_22 > 0 and var_256_16 < var_256_22 then
					arg_253_1.talkMaxDuration = var_256_22

					if var_256_22 + var_256_15 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_22 + var_256_15
					end
				end

				arg_253_1.text_.text = var_256_19
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702061", "story_v_side_new_1106702.awb") ~= 0 then
					local var_256_23 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702061", "story_v_side_new_1106702.awb") / 1000

					if var_256_23 + var_256_15 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_23 + var_256_15
					end

					if var_256_18.prefab_name ~= "" and arg_253_1.actors_[var_256_18.prefab_name] ~= nil then
						local var_256_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_18.prefab_name].transform, "story_v_side_new_1106702", "1106702061", "story_v_side_new_1106702.awb")

						arg_253_1:RecordAudio("1106702061", var_256_24)
						arg_253_1:RecordAudio("1106702061", var_256_24)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702061", "story_v_side_new_1106702.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702061", "story_v_side_new_1106702.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_25 = math.max(var_256_16, arg_253_1.talkMaxDuration)

			if var_256_15 <= arg_253_1.time_ and arg_253_1.time_ < var_256_15 + var_256_25 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_15) / var_256_25

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_15 + var_256_25 and arg_253_1.time_ < var_256_15 + var_256_25 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play1106702062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1106702062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1106702063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1067ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1067ui_story == nil then
				arg_257_1.var_.characterEffect1067ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1067ui_story and not isNil(var_260_0) then
					local var_260_4 = Mathf.Lerp(0, 0.5, var_260_3)

					arg_257_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1067ui_story.fillRatio = var_260_4
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1067ui_story then
				local var_260_5 = 0.5

				arg_257_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1067ui_story.fillRatio = var_260_5
			end

			local var_260_6 = 0
			local var_260_7 = 0.05

			if var_260_6 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_8 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_9 = arg_257_1:GetWordFromCfg(1106702062)
				local var_260_10 = arg_257_1:FormatText(var_260_9.content)

				arg_257_1.text_.text = var_260_10

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_11 = 2
				local var_260_12 = utf8.len(var_260_10)
				local var_260_13 = var_260_11 <= 0 and var_260_7 or var_260_7 * (var_260_12 / var_260_11)

				if var_260_13 > 0 and var_260_7 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_10
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_14 and arg_257_1.time_ < var_260_6 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1106702063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1106702063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1106702064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.75

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(1106702063)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 30
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_8 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_8

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_8 and arg_261_1.time_ < var_264_0 + var_264_8 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1106702064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1106702064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1106702065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.6

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(1106702064)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 24
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_8 and arg_265_1.time_ < var_268_0 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1106702065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1106702065
		arg_269_1.duration_ = 3.1

		local var_269_0 = {
			zh = 2.2,
			ja = 3.1
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
				arg_269_0:Play1106702066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1067ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1067ui_story == nil then
				arg_269_1.var_.characterEffect1067ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.2

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1067ui_story and not isNil(var_272_0) then
					arg_269_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1067ui_story then
				arg_269_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_272_4 = 0

			if var_272_4 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_272_5 = 0
			local var_272_6 = 0.15

			if var_272_5 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_7 = arg_269_1:FormatText(StoryNameCfg[206].name)

				arg_269_1.leftNameTxt_.text = var_272_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_8 = arg_269_1:GetWordFromCfg(1106702065)
				local var_272_9 = arg_269_1:FormatText(var_272_8.content)

				arg_269_1.text_.text = var_272_9

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 6
				local var_272_11 = utf8.len(var_272_9)
				local var_272_12 = var_272_10 <= 0 and var_272_6 or var_272_6 * (var_272_11 / var_272_10)

				if var_272_12 > 0 and var_272_6 < var_272_12 then
					arg_269_1.talkMaxDuration = var_272_12

					if var_272_12 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_12 + var_272_5
					end
				end

				arg_269_1.text_.text = var_272_9
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702065", "story_v_side_new_1106702.awb") ~= 0 then
					local var_272_13 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702065", "story_v_side_new_1106702.awb") / 1000

					if var_272_13 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_13 + var_272_5
					end

					if var_272_8.prefab_name ~= "" and arg_269_1.actors_[var_272_8.prefab_name] ~= nil then
						local var_272_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_8.prefab_name].transform, "story_v_side_new_1106702", "1106702065", "story_v_side_new_1106702.awb")

						arg_269_1:RecordAudio("1106702065", var_272_14)
						arg_269_1:RecordAudio("1106702065", var_272_14)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702065", "story_v_side_new_1106702.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702065", "story_v_side_new_1106702.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_15 = math.max(var_272_6, arg_269_1.talkMaxDuration)

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_15 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_5) / var_272_15

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_5 + var_272_15 and arg_269_1.time_ < var_272_5 + var_272_15 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1106702066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1106702066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1106702067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1067ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1067ui_story == nil then
				arg_273_1.var_.characterEffect1067ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.2

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1067ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1067ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1067ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1067ui_story.fillRatio = var_276_5
			end

			local var_276_6 = 0
			local var_276_7 = 0.075

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

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_9 = arg_273_1:GetWordFromCfg(1106702066)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 3
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
	Play1106702067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1106702067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1106702068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.5

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

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(1106702067)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 20
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
	Play1106702068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1106702068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1106702069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1067ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1067ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0, 100, 0)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1067ui_story, var_284_4, var_284_3)

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
			local var_284_10 = 0.95

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

				local var_284_11 = arg_281_1:GetWordFromCfg(1106702068)
				local var_284_12 = arg_281_1:FormatText(var_284_11.content)

				arg_281_1.text_.text = var_284_12

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 38
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
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1106702069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1106702069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1106702070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.575

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

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(1106702069)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 23
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
	Play1106702070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1106702070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1106702071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.75

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_2 = arg_289_1:GetWordFromCfg(1106702070)
				local var_292_3 = arg_289_1:FormatText(var_292_2.content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 30
				local var_292_5 = utf8.len(var_292_3)
				local var_292_6 = var_292_4 <= 0 and var_292_1 or var_292_1 * (var_292_5 / var_292_4)

				if var_292_6 > 0 and var_292_1 < var_292_6 then
					arg_289_1.talkMaxDuration = var_292_6

					if var_292_6 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_7 and arg_289_1.time_ < var_292_0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1106702071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1106702071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1106702072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.85

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:GetWordFromCfg(1106702071)
				local var_296_3 = arg_293_1:FormatText(var_296_2.content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 34
				local var_296_5 = utf8.len(var_296_3)
				local var_296_6 = var_296_4 <= 0 and var_296_1 or var_296_1 * (var_296_5 / var_296_4)

				if var_296_6 > 0 and var_296_1 < var_296_6 then
					arg_293_1.talkMaxDuration = var_296_6

					if var_296_6 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_7 and arg_293_1.time_ < var_296_0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1106702072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1106702072
		arg_297_1.duration_ = 2.9

		local var_297_0 = {
			zh = 1.9,
			ja = 2.9
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
				arg_297_0:Play1106702073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.2

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[393].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:GetWordFromCfg(1106702072)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 8
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702072", "story_v_side_new_1106702.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702072", "story_v_side_new_1106702.awb") / 1000

					if var_300_8 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_0
					end

					if var_300_3.prefab_name ~= "" and arg_297_1.actors_[var_300_3.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_3.prefab_name].transform, "story_v_side_new_1106702", "1106702072", "story_v_side_new_1106702.awb")

						arg_297_1:RecordAudio("1106702072", var_300_9)
						arg_297_1:RecordAudio("1106702072", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702072", "story_v_side_new_1106702.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702072", "story_v_side_new_1106702.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_10 and arg_297_1.time_ < var_300_0 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1106702073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1106702073
		arg_301_1.duration_ = 8.53

		local var_301_0 = {
			zh = 3.5,
			ja = 8.533
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
				arg_301_0:Play1106702074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1067ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1067ui_story == nil then
				arg_301_1.var_.characterEffect1067ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.2

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1067ui_story and not isNil(var_304_0) then
					arg_301_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1067ui_story then
				arg_301_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_304_4 = 0

			if var_304_4 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_304_5 = 0

			if var_304_5 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 then
				arg_301_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_304_6 = arg_301_1.actors_["1067ui_story"].transform
			local var_304_7 = 0

			if var_304_7 < arg_301_1.time_ and arg_301_1.time_ <= var_304_7 + arg_304_0 then
				arg_301_1.var_.moveOldPos1067ui_story = var_304_6.localPosition
			end

			local var_304_8 = 0.001

			if var_304_7 <= arg_301_1.time_ and arg_301_1.time_ < var_304_7 + var_304_8 then
				local var_304_9 = (arg_301_1.time_ - var_304_7) / var_304_8
				local var_304_10 = Vector3.New(0, -1.06, -6.2)

				var_304_6.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1067ui_story, var_304_10, var_304_9)

				local var_304_11 = manager.ui.mainCamera.transform.position - var_304_6.position

				var_304_6.forward = Vector3.New(var_304_11.x, var_304_11.y, var_304_11.z)

				local var_304_12 = var_304_6.localEulerAngles

				var_304_12.z = 0
				var_304_12.x = 0
				var_304_6.localEulerAngles = var_304_12
			end

			if arg_301_1.time_ >= var_304_7 + var_304_8 and arg_301_1.time_ < var_304_7 + var_304_8 + arg_304_0 then
				var_304_6.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_304_13 = manager.ui.mainCamera.transform.position - var_304_6.position

				var_304_6.forward = Vector3.New(var_304_13.x, var_304_13.y, var_304_13.z)

				local var_304_14 = var_304_6.localEulerAngles

				var_304_14.z = 0
				var_304_14.x = 0
				var_304_6.localEulerAngles = var_304_14
			end

			local var_304_15 = 0
			local var_304_16 = 0.45

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_17 = arg_301_1:FormatText(StoryNameCfg[206].name)

				arg_301_1.leftNameTxt_.text = var_304_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_18 = arg_301_1:GetWordFromCfg(1106702073)
				local var_304_19 = arg_301_1:FormatText(var_304_18.content)

				arg_301_1.text_.text = var_304_19

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_20 = 18
				local var_304_21 = utf8.len(var_304_19)
				local var_304_22 = var_304_20 <= 0 and var_304_16 or var_304_16 * (var_304_21 / var_304_20)

				if var_304_22 > 0 and var_304_16 < var_304_22 then
					arg_301_1.talkMaxDuration = var_304_22

					if var_304_22 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_22 + var_304_15
					end
				end

				arg_301_1.text_.text = var_304_19
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702073", "story_v_side_new_1106702.awb") ~= 0 then
					local var_304_23 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702073", "story_v_side_new_1106702.awb") / 1000

					if var_304_23 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_23 + var_304_15
					end

					if var_304_18.prefab_name ~= "" and arg_301_1.actors_[var_304_18.prefab_name] ~= nil then
						local var_304_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_18.prefab_name].transform, "story_v_side_new_1106702", "1106702073", "story_v_side_new_1106702.awb")

						arg_301_1:RecordAudio("1106702073", var_304_24)
						arg_301_1:RecordAudio("1106702073", var_304_24)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702073", "story_v_side_new_1106702.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702073", "story_v_side_new_1106702.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_25 = math.max(var_304_16, arg_301_1.talkMaxDuration)

			if var_304_15 <= arg_301_1.time_ and arg_301_1.time_ < var_304_15 + var_304_25 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_15) / var_304_25

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_15 + var_304_25 and arg_301_1.time_ < var_304_15 + var_304_25 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play1106702074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1106702074
		arg_305_1.duration_ = 6.3

		local var_305_0 = {
			zh = 3.6,
			ja = 6.3
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1106702075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1067ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1067ui_story == nil then
				arg_305_1.var_.characterEffect1067ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.2

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1067ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1067ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1067ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1067ui_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 0.4

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[394].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_9 = arg_305_1:GetWordFromCfg(1106702074)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 16
				local var_308_12 = utf8.len(var_308_10)
				local var_308_13 = var_308_11 <= 0 and var_308_7 or var_308_7 * (var_308_12 / var_308_11)

				if var_308_13 > 0 and var_308_7 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_10
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702074", "story_v_side_new_1106702.awb") ~= 0 then
					local var_308_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702074", "story_v_side_new_1106702.awb") / 1000

					if var_308_14 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_14 + var_308_6
					end

					if var_308_9.prefab_name ~= "" and arg_305_1.actors_[var_308_9.prefab_name] ~= nil then
						local var_308_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_9.prefab_name].transform, "story_v_side_new_1106702", "1106702074", "story_v_side_new_1106702.awb")

						arg_305_1:RecordAudio("1106702074", var_308_15)
						arg_305_1:RecordAudio("1106702074", var_308_15)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702074", "story_v_side_new_1106702.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702074", "story_v_side_new_1106702.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_16 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_16 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_16

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_16 and arg_305_1.time_ < var_308_6 + var_308_16 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1106702075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1106702075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1106702076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.6

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_2 = arg_309_1:GetWordFromCfg(1106702075)
				local var_312_3 = arg_309_1:FormatText(var_312_2.content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 24
				local var_312_5 = utf8.len(var_312_3)
				local var_312_6 = var_312_4 <= 0 and var_312_1 or var_312_1 * (var_312_5 / var_312_4)

				if var_312_6 > 0 and var_312_1 < var_312_6 then
					arg_309_1.talkMaxDuration = var_312_6

					if var_312_6 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_7 and arg_309_1.time_ < var_312_0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1106702076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1106702076
		arg_313_1.duration_ = 5.5

		local var_313_0 = {
			zh = 4.2,
			ja = 5.5
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
				arg_313_0:Play1106702077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1067ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1067ui_story == nil then
				arg_313_1.var_.characterEffect1067ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.2

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1067ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1067ui_story then
				arg_313_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_316_4 = 0

			if var_316_4 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action437")
			end

			local var_316_5 = 0

			if var_316_5 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_316_6 = 0
			local var_316_7 = 0.475

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_8 = arg_313_1:FormatText(StoryNameCfg[206].name)

				arg_313_1.leftNameTxt_.text = var_316_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_9 = arg_313_1:GetWordFromCfg(1106702076)
				local var_316_10 = arg_313_1:FormatText(var_316_9.content)

				arg_313_1.text_.text = var_316_10

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 19
				local var_316_12 = utf8.len(var_316_10)
				local var_316_13 = var_316_11 <= 0 and var_316_7 or var_316_7 * (var_316_12 / var_316_11)

				if var_316_13 > 0 and var_316_7 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_10
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702076", "story_v_side_new_1106702.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702076", "story_v_side_new_1106702.awb") / 1000

					if var_316_14 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_6
					end

					if var_316_9.prefab_name ~= "" and arg_313_1.actors_[var_316_9.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_9.prefab_name].transform, "story_v_side_new_1106702", "1106702076", "story_v_side_new_1106702.awb")

						arg_313_1:RecordAudio("1106702076", var_316_15)
						arg_313_1:RecordAudio("1106702076", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702076", "story_v_side_new_1106702.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702076", "story_v_side_new_1106702.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_16 and arg_313_1.time_ < var_316_6 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1106702077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1106702077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1106702078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1067ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1067ui_story == nil then
				arg_317_1.var_.characterEffect1067ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.2

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1067ui_story and not isNil(var_320_0) then
					local var_320_4 = Mathf.Lerp(0, 0.5, var_320_3)

					arg_317_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1067ui_story.fillRatio = var_320_4
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1067ui_story then
				local var_320_5 = 0.5

				arg_317_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1067ui_story.fillRatio = var_320_5
			end

			local var_320_6 = 0
			local var_320_7 = 0.4

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

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_9 = arg_317_1:GetWordFromCfg(1106702077)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 16
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
	Play1106702078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1106702078
		arg_321_1.duration_ = 8

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1106702079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 1.5

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				local var_324_1 = manager.ui.mainCamera.transform.localPosition
				local var_324_2 = Vector3.New(0, 0, 10) + Vector3.New(var_324_1.x, var_324_1.y, 0)
				local var_324_3 = arg_321_1.bgs_.ST24

				var_324_3.transform.localPosition = var_324_2
				var_324_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_324_4 = var_324_3:GetComponent("SpriteRenderer")

				if var_324_4 and var_324_4.sprite then
					local var_324_5 = (var_324_3.transform.localPosition - var_324_1).z
					local var_324_6 = manager.ui.mainCameraCom_
					local var_324_7 = 2 * var_324_5 * Mathf.Tan(var_324_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_324_8 = var_324_7 * var_324_6.aspect
					local var_324_9 = var_324_4.sprite.bounds.size.x
					local var_324_10 = var_324_4.sprite.bounds.size.y
					local var_324_11 = var_324_8 / var_324_9
					local var_324_12 = var_324_7 / var_324_10
					local var_324_13 = var_324_12 < var_324_11 and var_324_11 or var_324_12

					var_324_3.transform.localScale = Vector3.New(var_324_13, var_324_13, 0)
				end

				for iter_324_0, iter_324_1 in pairs(arg_321_1.bgs_) do
					if iter_324_0 ~= "ST24" then
						iter_324_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_15 = 1.5

			if var_324_14 <= arg_321_1.time_ and arg_321_1.time_ < var_324_14 + var_324_15 then
				local var_324_16 = (arg_321_1.time_ - var_324_14) / var_324_15
				local var_324_17 = Color.New(0, 0, 0)

				var_324_17.a = Mathf.Lerp(0, 1, var_324_16)
				arg_321_1.mask_.color = var_324_17
			end

			if arg_321_1.time_ >= var_324_14 + var_324_15 and arg_321_1.time_ < var_324_14 + var_324_15 + arg_324_0 then
				local var_324_18 = Color.New(0, 0, 0)

				var_324_18.a = 1
				arg_321_1.mask_.color = var_324_18
			end

			local var_324_19 = 1.5

			if var_324_19 < arg_321_1.time_ and arg_321_1.time_ <= var_324_19 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_20 = 1.5

			if var_324_19 <= arg_321_1.time_ and arg_321_1.time_ < var_324_19 + var_324_20 then
				local var_324_21 = (arg_321_1.time_ - var_324_19) / var_324_20
				local var_324_22 = Color.New(0, 0, 0)

				var_324_22.a = Mathf.Lerp(1, 0, var_324_21)
				arg_321_1.mask_.color = var_324_22
			end

			if arg_321_1.time_ >= var_324_19 + var_324_20 and arg_321_1.time_ < var_324_19 + var_324_20 + arg_324_0 then
				local var_324_23 = Color.New(0, 0, 0)
				local var_324_24 = 0

				arg_321_1.mask_.enabled = false
				var_324_23.a = var_324_24
				arg_321_1.mask_.color = var_324_23
			end

			local var_324_25 = arg_321_1.actors_["1067ui_story"].transform
			local var_324_26 = 1.5

			if var_324_26 < arg_321_1.time_ and arg_321_1.time_ <= var_324_26 + arg_324_0 then
				arg_321_1.var_.moveOldPos1067ui_story = var_324_25.localPosition
			end

			local var_324_27 = 0.001

			if var_324_26 <= arg_321_1.time_ and arg_321_1.time_ < var_324_26 + var_324_27 then
				local var_324_28 = (arg_321_1.time_ - var_324_26) / var_324_27
				local var_324_29 = Vector3.New(0, 100, 0)

				var_324_25.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1067ui_story, var_324_29, var_324_28)

				local var_324_30 = manager.ui.mainCamera.transform.position - var_324_25.position

				var_324_25.forward = Vector3.New(var_324_30.x, var_324_30.y, var_324_30.z)

				local var_324_31 = var_324_25.localEulerAngles

				var_324_31.z = 0
				var_324_31.x = 0
				var_324_25.localEulerAngles = var_324_31
			end

			if arg_321_1.time_ >= var_324_26 + var_324_27 and arg_321_1.time_ < var_324_26 + var_324_27 + arg_324_0 then
				var_324_25.localPosition = Vector3.New(0, 100, 0)

				local var_324_32 = manager.ui.mainCamera.transform.position - var_324_25.position

				var_324_25.forward = Vector3.New(var_324_32.x, var_324_32.y, var_324_32.z)

				local var_324_33 = var_324_25.localEulerAngles

				var_324_33.z = 0
				var_324_33.x = 0
				var_324_25.localEulerAngles = var_324_33
			end

			if arg_321_1.frameCnt_ <= 1 then
				arg_321_1.dialog_:SetActive(false)
			end

			local var_324_34 = 3
			local var_324_35 = 1.225

			if var_324_34 < arg_321_1.time_ and arg_321_1.time_ <= var_324_34 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				arg_321_1.dialog_:SetActive(true)

				arg_321_1.dialogCg_.alpha = 0

				local var_324_36 = LeanTween.value(arg_321_1.dialog_, 0, 1, 0.3)

				var_324_36:setOnUpdate(LuaHelper.FloatAction(function(arg_325_0)
					arg_321_1.dialogCg_.alpha = arg_325_0
				end))
				var_324_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_321_1.dialog_)
					var_324_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_321_1.duration_ = arg_321_1.duration_ + 0.3

				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_37 = arg_321_1:GetWordFromCfg(1106702078)
				local var_324_38 = arg_321_1:FormatText(var_324_37.content)

				arg_321_1.text_.text = var_324_38

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_39 = 49
				local var_324_40 = utf8.len(var_324_38)
				local var_324_41 = var_324_39 <= 0 and var_324_35 or var_324_35 * (var_324_40 / var_324_39)

				if var_324_41 > 0 and var_324_35 < var_324_41 then
					arg_321_1.talkMaxDuration = var_324_41
					var_324_34 = var_324_34 + 0.3

					if var_324_41 + var_324_34 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_41 + var_324_34
					end
				end

				arg_321_1.text_.text = var_324_38
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_42 = var_324_34 + 0.3
			local var_324_43 = math.max(var_324_35, arg_321_1.talkMaxDuration)

			if var_324_42 <= arg_321_1.time_ and arg_321_1.time_ < var_324_42 + var_324_43 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_42) / var_324_43

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_42 + var_324_43 and arg_321_1.time_ < var_324_42 + var_324_43 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play1106702079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1106702079
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1106702080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 1

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_2 = arg_327_1:GetWordFromCfg(1106702079)
				local var_330_3 = arg_327_1:FormatText(var_330_2.content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 40
				local var_330_5 = utf8.len(var_330_3)
				local var_330_6 = var_330_4 <= 0 and var_330_1 or var_330_1 * (var_330_5 / var_330_4)

				if var_330_6 > 0 and var_330_1 < var_330_6 then
					arg_327_1.talkMaxDuration = var_330_6

					if var_330_6 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_6 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_7 and arg_327_1.time_ < var_330_0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1106702080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1106702080
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1106702081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 0.8

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_2 = arg_331_1:FormatText(StoryNameCfg[7].name)

				arg_331_1.leftNameTxt_.text = var_334_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_3 = arg_331_1:GetWordFromCfg(1106702080)
				local var_334_4 = arg_331_1:FormatText(var_334_3.content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 32
				local var_334_6 = utf8.len(var_334_4)
				local var_334_7 = var_334_5 <= 0 and var_334_1 or var_334_1 * (var_334_6 / var_334_5)

				if var_334_7 > 0 and var_334_1 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_4
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_8 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_8 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_8

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_8 and arg_331_1.time_ < var_334_0 + var_334_8 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1106702081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1106702081
		arg_335_1.duration_ = 6

		local var_335_0 = {
			zh = 4.533,
			ja = 6
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1106702082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = "1042ui_story"

			if arg_335_1.actors_[var_338_0] == nil then
				local var_338_1 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_338_1) then
					local var_338_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_335_1.stage_.transform)

					var_338_2.name = var_338_0
					var_338_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_335_1.actors_[var_338_0] = var_338_2

					local var_338_3 = var_338_2:GetComponentInChildren(typeof(CharacterEffect))

					var_338_3.enabled = true

					local var_338_4 = GameObjectTools.GetOrAddComponent(var_338_2, typeof(DynamicBoneHelper))

					if var_338_4 then
						var_338_4:EnableDynamicBone(false)
					end

					arg_335_1:ShowWeapon(var_338_3.transform, false)

					arg_335_1.var_[var_338_0 .. "Animator"] = var_338_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_335_1.var_[var_338_0 .. "Animator"].applyRootMotion = true
					arg_335_1.var_[var_338_0 .. "LipSync"] = var_338_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_338_5 = arg_335_1.actors_["1042ui_story"].transform
			local var_338_6 = 0

			if var_338_6 < arg_335_1.time_ and arg_335_1.time_ <= var_338_6 + arg_338_0 then
				arg_335_1.var_.moveOldPos1042ui_story = var_338_5.localPosition
			end

			local var_338_7 = 0.001

			if var_338_6 <= arg_335_1.time_ and arg_335_1.time_ < var_338_6 + var_338_7 then
				local var_338_8 = (arg_335_1.time_ - var_338_6) / var_338_7
				local var_338_9 = Vector3.New(0, -1.06, -6.2)

				var_338_5.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1042ui_story, var_338_9, var_338_8)

				local var_338_10 = manager.ui.mainCamera.transform.position - var_338_5.position

				var_338_5.forward = Vector3.New(var_338_10.x, var_338_10.y, var_338_10.z)

				local var_338_11 = var_338_5.localEulerAngles

				var_338_11.z = 0
				var_338_11.x = 0
				var_338_5.localEulerAngles = var_338_11
			end

			if arg_335_1.time_ >= var_338_6 + var_338_7 and arg_335_1.time_ < var_338_6 + var_338_7 + arg_338_0 then
				var_338_5.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_338_12 = manager.ui.mainCamera.transform.position - var_338_5.position

				var_338_5.forward = Vector3.New(var_338_12.x, var_338_12.y, var_338_12.z)

				local var_338_13 = var_338_5.localEulerAngles

				var_338_13.z = 0
				var_338_13.x = 0
				var_338_5.localEulerAngles = var_338_13
			end

			local var_338_14 = arg_335_1.actors_["1042ui_story"]
			local var_338_15 = 0

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 and not isNil(var_338_14) and arg_335_1.var_.characterEffect1042ui_story == nil then
				arg_335_1.var_.characterEffect1042ui_story = var_338_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_16 = 0.2

			if var_338_15 <= arg_335_1.time_ and arg_335_1.time_ < var_338_15 + var_338_16 and not isNil(var_338_14) then
				local var_338_17 = (arg_335_1.time_ - var_338_15) / var_338_16

				if arg_335_1.var_.characterEffect1042ui_story and not isNil(var_338_14) then
					arg_335_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_15 + var_338_16 and arg_335_1.time_ < var_338_15 + var_338_16 + arg_338_0 and not isNil(var_338_14) and arg_335_1.var_.characterEffect1042ui_story then
				arg_335_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_338_18 = 0

			if var_338_18 < arg_335_1.time_ and arg_335_1.time_ <= var_338_18 + arg_338_0 then
				arg_335_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_338_19 = 0

			if var_338_19 < arg_335_1.time_ and arg_335_1.time_ <= var_338_19 + arg_338_0 then
				arg_335_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_338_20 = arg_335_1.actors_["1042ui_story"]
			local var_338_21 = 0

			if var_338_21 < arg_335_1.time_ and arg_335_1.time_ <= var_338_21 + arg_338_0 then
				if arg_335_1.var_.characterEffect1042ui_story == nil then
					arg_335_1.var_.characterEffect1042ui_story = var_338_20:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_338_22 = arg_335_1.var_.characterEffect1042ui_story

				var_338_22.imageEffect:turnOff()

				var_338_22.interferenceEffect.enabled = true
				var_338_22.interferenceEffect.noise = 0.001
				var_338_22.interferenceEffect.simTimeScale = 1
				var_338_22.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_338_23 = arg_335_1.actors_["1042ui_story"]
			local var_338_24 = 0
			local var_338_25 = 2

			if var_338_24 < arg_335_1.time_ and arg_335_1.time_ <= var_338_24 + arg_338_0 then
				if arg_335_1.var_.characterEffect1042ui_story == nil then
					arg_335_1.var_.characterEffect1042ui_story = var_338_23:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_335_1.var_.characterEffect1042ui_story.imageEffect:turnOn(false)
			end

			local var_338_26 = 0
			local var_338_27 = 0.475

			if var_338_26 < arg_335_1.time_ and arg_335_1.time_ <= var_338_26 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_28 = arg_335_1:FormatText(StoryNameCfg[205].name)

				arg_335_1.leftNameTxt_.text = var_338_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_29 = arg_335_1:GetWordFromCfg(1106702081)
				local var_338_30 = arg_335_1:FormatText(var_338_29.content)

				arg_335_1.text_.text = var_338_30

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_31 = 19
				local var_338_32 = utf8.len(var_338_30)
				local var_338_33 = var_338_31 <= 0 and var_338_27 or var_338_27 * (var_338_32 / var_338_31)

				if var_338_33 > 0 and var_338_27 < var_338_33 then
					arg_335_1.talkMaxDuration = var_338_33

					if var_338_33 + var_338_26 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_33 + var_338_26
					end
				end

				arg_335_1.text_.text = var_338_30
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702081", "story_v_side_new_1106702.awb") ~= 0 then
					local var_338_34 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702081", "story_v_side_new_1106702.awb") / 1000

					if var_338_34 + var_338_26 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_34 + var_338_26
					end

					if var_338_29.prefab_name ~= "" and arg_335_1.actors_[var_338_29.prefab_name] ~= nil then
						local var_338_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_29.prefab_name].transform, "story_v_side_new_1106702", "1106702081", "story_v_side_new_1106702.awb")

						arg_335_1:RecordAudio("1106702081", var_338_35)
						arg_335_1:RecordAudio("1106702081", var_338_35)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702081", "story_v_side_new_1106702.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702081", "story_v_side_new_1106702.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_36 = math.max(var_338_27, arg_335_1.talkMaxDuration)

			if var_338_26 <= arg_335_1.time_ and arg_335_1.time_ < var_338_26 + var_338_36 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_26) / var_338_36

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_26 + var_338_36 and arg_335_1.time_ < var_338_26 + var_338_36 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
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

		arg_335_1:InitPlayNodeList()
	end,
	Play1106702082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1106702082
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1106702083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1042ui_story"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1042ui_story == nil then
				arg_339_1.var_.characterEffect1042ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.2

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect1042ui_story and not isNil(var_342_0) then
					local var_342_4 = Mathf.Lerp(0, 0.5, var_342_3)

					arg_339_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1042ui_story.fillRatio = var_342_4
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1042ui_story then
				local var_342_5 = 0.5

				arg_339_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1042ui_story.fillRatio = var_342_5
			end

			local var_342_6 = 0
			local var_342_7 = 0.925

			if var_342_6 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_8 = arg_339_1:FormatText(StoryNameCfg[7].name)

				arg_339_1.leftNameTxt_.text = var_342_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_9 = arg_339_1:GetWordFromCfg(1106702082)
				local var_342_10 = arg_339_1:FormatText(var_342_9.content)

				arg_339_1.text_.text = var_342_10

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_11 = 37
				local var_342_12 = utf8.len(var_342_10)
				local var_342_13 = var_342_11 <= 0 and var_342_7 or var_342_7 * (var_342_12 / var_342_11)

				if var_342_13 > 0 and var_342_7 < var_342_13 then
					arg_339_1.talkMaxDuration = var_342_13

					if var_342_13 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_13 + var_342_6
					end
				end

				arg_339_1.text_.text = var_342_10
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_14 = math.max(var_342_7, arg_339_1.talkMaxDuration)

			if var_342_6 <= arg_339_1.time_ and arg_339_1.time_ < var_342_6 + var_342_14 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_6) / var_342_14

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_6 + var_342_14 and arg_339_1.time_ < var_342_6 + var_342_14 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1106702083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1106702083
		arg_343_1.duration_ = 17.47

		local var_343_0 = {
			zh = 12.4,
			ja = 17.466
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1106702084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1042ui_story"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1042ui_story == nil then
				arg_343_1.var_.characterEffect1042ui_story = var_346_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.2

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.characterEffect1042ui_story and not isNil(var_346_0) then
					arg_343_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1042ui_story then
				arg_343_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_346_4 = 0

			if var_346_4 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_346_5 = 0
			local var_346_6 = 1.525

			if var_346_5 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_7 = arg_343_1:FormatText(StoryNameCfg[205].name)

				arg_343_1.leftNameTxt_.text = var_346_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_8 = arg_343_1:GetWordFromCfg(1106702083)
				local var_346_9 = arg_343_1:FormatText(var_346_8.content)

				arg_343_1.text_.text = var_346_9

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_10 = 61
				local var_346_11 = utf8.len(var_346_9)
				local var_346_12 = var_346_10 <= 0 and var_346_6 or var_346_6 * (var_346_11 / var_346_10)

				if var_346_12 > 0 and var_346_6 < var_346_12 then
					arg_343_1.talkMaxDuration = var_346_12

					if var_346_12 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_12 + var_346_5
					end
				end

				arg_343_1.text_.text = var_346_9
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702083", "story_v_side_new_1106702.awb") ~= 0 then
					local var_346_13 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702083", "story_v_side_new_1106702.awb") / 1000

					if var_346_13 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_5
					end

					if var_346_8.prefab_name ~= "" and arg_343_1.actors_[var_346_8.prefab_name] ~= nil then
						local var_346_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_8.prefab_name].transform, "story_v_side_new_1106702", "1106702083", "story_v_side_new_1106702.awb")

						arg_343_1:RecordAudio("1106702083", var_346_14)
						arg_343_1:RecordAudio("1106702083", var_346_14)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702083", "story_v_side_new_1106702.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702083", "story_v_side_new_1106702.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_15 = math.max(var_346_6, arg_343_1.talkMaxDuration)

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_15 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_5) / var_346_15

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_5 + var_346_15 and arg_343_1.time_ < var_346_5 + var_346_15 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1106702084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1106702084
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1106702085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1042ui_story"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1042ui_story == nil then
				arg_347_1.var_.characterEffect1042ui_story = var_350_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.characterEffect1042ui_story and not isNil(var_350_0) then
					local var_350_4 = Mathf.Lerp(0, 0.5, var_350_3)

					arg_347_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1042ui_story.fillRatio = var_350_4
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1042ui_story then
				local var_350_5 = 0.5

				arg_347_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1042ui_story.fillRatio = var_350_5
			end

			local var_350_6 = 0
			local var_350_7 = 0.875

			if var_350_6 < arg_347_1.time_ and arg_347_1.time_ <= var_350_6 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_8 = arg_347_1:FormatText(StoryNameCfg[7].name)

				arg_347_1.leftNameTxt_.text = var_350_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_9 = arg_347_1:GetWordFromCfg(1106702084)
				local var_350_10 = arg_347_1:FormatText(var_350_9.content)

				arg_347_1.text_.text = var_350_10

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_11 = 35
				local var_350_12 = utf8.len(var_350_10)
				local var_350_13 = var_350_11 <= 0 and var_350_7 or var_350_7 * (var_350_12 / var_350_11)

				if var_350_13 > 0 and var_350_7 < var_350_13 then
					arg_347_1.talkMaxDuration = var_350_13

					if var_350_13 + var_350_6 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_13 + var_350_6
					end
				end

				arg_347_1.text_.text = var_350_10
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_14 = math.max(var_350_7, arg_347_1.talkMaxDuration)

			if var_350_6 <= arg_347_1.time_ and arg_347_1.time_ < var_350_6 + var_350_14 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_6) / var_350_14

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_6 + var_350_14 and arg_347_1.time_ < var_350_6 + var_350_14 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1106702085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1106702085
		arg_351_1.duration_ = 2.3

		local var_351_0 = {
			zh = 2.3,
			ja = 2.033
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1106702086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1042ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1042ui_story == nil then
				arg_351_1.var_.characterEffect1042ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.2

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1042ui_story and not isNil(var_354_0) then
					arg_351_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1042ui_story then
				arg_351_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_354_4 = 0

			if var_354_4 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			local var_354_5 = 0

			if var_354_5 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_354_6 = 0
			local var_354_7 = 0.225

			if var_354_6 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_8 = arg_351_1:FormatText(StoryNameCfg[205].name)

				arg_351_1.leftNameTxt_.text = var_354_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_9 = arg_351_1:GetWordFromCfg(1106702085)
				local var_354_10 = arg_351_1:FormatText(var_354_9.content)

				arg_351_1.text_.text = var_354_10

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 9
				local var_354_12 = utf8.len(var_354_10)
				local var_354_13 = var_354_11 <= 0 and var_354_7 or var_354_7 * (var_354_12 / var_354_11)

				if var_354_13 > 0 and var_354_7 < var_354_13 then
					arg_351_1.talkMaxDuration = var_354_13

					if var_354_13 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_6
					end
				end

				arg_351_1.text_.text = var_354_10
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702085", "story_v_side_new_1106702.awb") ~= 0 then
					local var_354_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702085", "story_v_side_new_1106702.awb") / 1000

					if var_354_14 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_14 + var_354_6
					end

					if var_354_9.prefab_name ~= "" and arg_351_1.actors_[var_354_9.prefab_name] ~= nil then
						local var_354_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_9.prefab_name].transform, "story_v_side_new_1106702", "1106702085", "story_v_side_new_1106702.awb")

						arg_351_1:RecordAudio("1106702085", var_354_15)
						arg_351_1:RecordAudio("1106702085", var_354_15)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702085", "story_v_side_new_1106702.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702085", "story_v_side_new_1106702.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_16 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_16 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_6) / var_354_16

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_6 + var_354_16 and arg_351_1.time_ < var_354_6 + var_354_16 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1106702086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1106702086
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1106702087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1042ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1042ui_story == nil then
				arg_355_1.var_.characterEffect1042ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.2

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect1042ui_story and not isNil(var_358_0) then
					local var_358_4 = Mathf.Lerp(0, 0.5, var_358_3)

					arg_355_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1042ui_story.fillRatio = var_358_4
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1042ui_story then
				local var_358_5 = 0.5

				arg_355_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1042ui_story.fillRatio = var_358_5
			end

			local var_358_6 = 0
			local var_358_7 = 0.65

			if var_358_6 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_8 = arg_355_1:FormatText(StoryNameCfg[7].name)

				arg_355_1.leftNameTxt_.text = var_358_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_9 = arg_355_1:GetWordFromCfg(1106702086)
				local var_358_10 = arg_355_1:FormatText(var_358_9.content)

				arg_355_1.text_.text = var_358_10

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_11 = 27
				local var_358_12 = utf8.len(var_358_10)
				local var_358_13 = var_358_11 <= 0 and var_358_7 or var_358_7 * (var_358_12 / var_358_11)

				if var_358_13 > 0 and var_358_7 < var_358_13 then
					arg_355_1.talkMaxDuration = var_358_13

					if var_358_13 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_13 + var_358_6
					end
				end

				arg_355_1.text_.text = var_358_10
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_14 = math.max(var_358_7, arg_355_1.talkMaxDuration)

			if var_358_6 <= arg_355_1.time_ and arg_355_1.time_ < var_358_6 + var_358_14 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_6) / var_358_14

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_6 + var_358_14 and arg_355_1.time_ < var_358_6 + var_358_14 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1106702087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1106702087
		arg_359_1.duration_ = 6.73

		local var_359_0 = {
			zh = 5.766,
			ja = 6.733
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1106702088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1042ui_story"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1042ui_story == nil then
				arg_359_1.var_.characterEffect1042ui_story = var_362_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.2

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.characterEffect1042ui_story and not isNil(var_362_0) then
					arg_359_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1042ui_story then
				arg_359_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_362_4 = 0

			if var_362_4 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_362_5 = 0

			if var_362_5 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_362_6 = 0
			local var_362_7 = 0.575

			if var_362_6 < arg_359_1.time_ and arg_359_1.time_ <= var_362_6 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_8 = arg_359_1:FormatText(StoryNameCfg[205].name)

				arg_359_1.leftNameTxt_.text = var_362_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_9 = arg_359_1:GetWordFromCfg(1106702087)
				local var_362_10 = arg_359_1:FormatText(var_362_9.content)

				arg_359_1.text_.text = var_362_10

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_11 = 23
				local var_362_12 = utf8.len(var_362_10)
				local var_362_13 = var_362_11 <= 0 and var_362_7 or var_362_7 * (var_362_12 / var_362_11)

				if var_362_13 > 0 and var_362_7 < var_362_13 then
					arg_359_1.talkMaxDuration = var_362_13

					if var_362_13 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_13 + var_362_6
					end
				end

				arg_359_1.text_.text = var_362_10
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702087", "story_v_side_new_1106702.awb") ~= 0 then
					local var_362_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702087", "story_v_side_new_1106702.awb") / 1000

					if var_362_14 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_14 + var_362_6
					end

					if var_362_9.prefab_name ~= "" and arg_359_1.actors_[var_362_9.prefab_name] ~= nil then
						local var_362_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_9.prefab_name].transform, "story_v_side_new_1106702", "1106702087", "story_v_side_new_1106702.awb")

						arg_359_1:RecordAudio("1106702087", var_362_15)
						arg_359_1:RecordAudio("1106702087", var_362_15)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702087", "story_v_side_new_1106702.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702087", "story_v_side_new_1106702.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_16 = math.max(var_362_7, arg_359_1.talkMaxDuration)

			if var_362_6 <= arg_359_1.time_ and arg_359_1.time_ < var_362_6 + var_362_16 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_6) / var_362_16

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_6 + var_362_16 and arg_359_1.time_ < var_362_6 + var_362_16 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1106702088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1106702088
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1106702089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1042ui_story"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1042ui_story == nil then
				arg_363_1.var_.characterEffect1042ui_story = var_366_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.characterEffect1042ui_story and not isNil(var_366_0) then
					local var_366_4 = Mathf.Lerp(0, 0.5, var_366_3)

					arg_363_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1042ui_story.fillRatio = var_366_4
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1042ui_story then
				local var_366_5 = 0.5

				arg_363_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1042ui_story.fillRatio = var_366_5
			end

			local var_366_6 = 0
			local var_366_7 = 0.175

			if var_366_6 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_8 = arg_363_1:FormatText(StoryNameCfg[7].name)

				arg_363_1.leftNameTxt_.text = var_366_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_9 = arg_363_1:GetWordFromCfg(1106702088)
				local var_366_10 = arg_363_1:FormatText(var_366_9.content)

				arg_363_1.text_.text = var_366_10

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_11 = 7
				local var_366_12 = utf8.len(var_366_10)
				local var_366_13 = var_366_11 <= 0 and var_366_7 or var_366_7 * (var_366_12 / var_366_11)

				if var_366_13 > 0 and var_366_7 < var_366_13 then
					arg_363_1.talkMaxDuration = var_366_13

					if var_366_13 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_6
					end
				end

				arg_363_1.text_.text = var_366_10
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_14 = math.max(var_366_7, arg_363_1.talkMaxDuration)

			if var_366_6 <= arg_363_1.time_ and arg_363_1.time_ < var_366_6 + var_366_14 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_6) / var_366_14

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_6 + var_366_14 and arg_363_1.time_ < var_366_6 + var_366_14 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1106702089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1106702089
		arg_367_1.duration_ = 7.37

		local var_367_0 = {
			zh = 7.366,
			ja = 6.566
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1106702090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1042ui_story"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1042ui_story == nil then
				arg_367_1.var_.characterEffect1042ui_story = var_370_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.characterEffect1042ui_story and not isNil(var_370_0) then
					arg_367_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1042ui_story then
				arg_367_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_370_4 = 0

			if var_370_4 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_370_5 = 0
			local var_370_6 = 0.825

			if var_370_5 < arg_367_1.time_ and arg_367_1.time_ <= var_370_5 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_7 = arg_367_1:FormatText(StoryNameCfg[205].name)

				arg_367_1.leftNameTxt_.text = var_370_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_8 = arg_367_1:GetWordFromCfg(1106702089)
				local var_370_9 = arg_367_1:FormatText(var_370_8.content)

				arg_367_1.text_.text = var_370_9

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_10 = 33
				local var_370_11 = utf8.len(var_370_9)
				local var_370_12 = var_370_10 <= 0 and var_370_6 or var_370_6 * (var_370_11 / var_370_10)

				if var_370_12 > 0 and var_370_6 < var_370_12 then
					arg_367_1.talkMaxDuration = var_370_12

					if var_370_12 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_12 + var_370_5
					end
				end

				arg_367_1.text_.text = var_370_9
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702089", "story_v_side_new_1106702.awb") ~= 0 then
					local var_370_13 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702089", "story_v_side_new_1106702.awb") / 1000

					if var_370_13 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_5
					end

					if var_370_8.prefab_name ~= "" and arg_367_1.actors_[var_370_8.prefab_name] ~= nil then
						local var_370_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_8.prefab_name].transform, "story_v_side_new_1106702", "1106702089", "story_v_side_new_1106702.awb")

						arg_367_1:RecordAudio("1106702089", var_370_14)
						arg_367_1:RecordAudio("1106702089", var_370_14)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702089", "story_v_side_new_1106702.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702089", "story_v_side_new_1106702.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_15 = math.max(var_370_6, arg_367_1.talkMaxDuration)

			if var_370_5 <= arg_367_1.time_ and arg_367_1.time_ < var_370_5 + var_370_15 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_5) / var_370_15

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_5 + var_370_15 and arg_367_1.time_ < var_370_5 + var_370_15 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1106702090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1106702090
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1106702091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1042ui_story"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1042ui_story == nil then
				arg_371_1.var_.characterEffect1042ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.2

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.characterEffect1042ui_story and not isNil(var_374_0) then
					local var_374_4 = Mathf.Lerp(0, 0.5, var_374_3)

					arg_371_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1042ui_story.fillRatio = var_374_4
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1042ui_story then
				local var_374_5 = 0.5

				arg_371_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1042ui_story.fillRatio = var_374_5
			end

			local var_374_6 = 0
			local var_374_7 = 1.175

			if var_374_6 < arg_371_1.time_ and arg_371_1.time_ <= var_374_6 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_8 = arg_371_1:GetWordFromCfg(1106702090)
				local var_374_9 = arg_371_1:FormatText(var_374_8.content)

				arg_371_1.text_.text = var_374_9

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_10 = 47
				local var_374_11 = utf8.len(var_374_9)
				local var_374_12 = var_374_10 <= 0 and var_374_7 or var_374_7 * (var_374_11 / var_374_10)

				if var_374_12 > 0 and var_374_7 < var_374_12 then
					arg_371_1.talkMaxDuration = var_374_12

					if var_374_12 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_12 + var_374_6
					end
				end

				arg_371_1.text_.text = var_374_9
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_13 = math.max(var_374_7, arg_371_1.talkMaxDuration)

			if var_374_6 <= arg_371_1.time_ and arg_371_1.time_ < var_374_6 + var_374_13 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_6) / var_374_13

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_6 + var_374_13 and arg_371_1.time_ < var_374_6 + var_374_13 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1106702091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1106702091
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1106702092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0
			local var_378_1 = 0.75

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_2 = arg_375_1:FormatText(StoryNameCfg[7].name)

				arg_375_1.leftNameTxt_.text = var_378_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_3 = arg_375_1:GetWordFromCfg(1106702091)
				local var_378_4 = arg_375_1:FormatText(var_378_3.content)

				arg_375_1.text_.text = var_378_4

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 30
				local var_378_6 = utf8.len(var_378_4)
				local var_378_7 = var_378_5 <= 0 and var_378_1 or var_378_1 * (var_378_6 / var_378_5)

				if var_378_7 > 0 and var_378_1 < var_378_7 then
					arg_375_1.talkMaxDuration = var_378_7

					if var_378_7 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_7 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_4
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_8 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_8 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_8

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_8 and arg_375_1.time_ < var_378_0 + var_378_8 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1106702092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1106702092
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1106702093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.45

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_2 = arg_379_1:FormatText(StoryNameCfg[7].name)

				arg_379_1.leftNameTxt_.text = var_382_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(1106702092)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 18
				local var_382_6 = utf8.len(var_382_4)
				local var_382_7 = var_382_5 <= 0 and var_382_1 or var_382_1 * (var_382_6 / var_382_5)

				if var_382_7 > 0 and var_382_1 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_8 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_8 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_8

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_8 and arg_379_1.time_ < var_382_0 + var_382_8 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1106702093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1106702093
		arg_383_1.duration_ = 5.03

		local var_383_0 = {
			zh = 3.933,
			ja = 5.033
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1106702094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1042ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1042ui_story == nil then
				arg_383_1.var_.characterEffect1042ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.2

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1042ui_story and not isNil(var_386_0) then
					arg_383_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1042ui_story then
				arg_383_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_386_4 = 0

			if var_386_4 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_386_5 = 0

			if var_386_5 < arg_383_1.time_ and arg_383_1.time_ <= var_386_5 + arg_386_0 then
				arg_383_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_386_6 = 0
			local var_386_7 = 0.5

			if var_386_6 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_8 = arg_383_1:FormatText(StoryNameCfg[205].name)

				arg_383_1.leftNameTxt_.text = var_386_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_9 = arg_383_1:GetWordFromCfg(1106702093)
				local var_386_10 = arg_383_1:FormatText(var_386_9.content)

				arg_383_1.text_.text = var_386_10

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_11 = 20
				local var_386_12 = utf8.len(var_386_10)
				local var_386_13 = var_386_11 <= 0 and var_386_7 or var_386_7 * (var_386_12 / var_386_11)

				if var_386_13 > 0 and var_386_7 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_6
					end
				end

				arg_383_1.text_.text = var_386_10
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702093", "story_v_side_new_1106702.awb") ~= 0 then
					local var_386_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702093", "story_v_side_new_1106702.awb") / 1000

					if var_386_14 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_14 + var_386_6
					end

					if var_386_9.prefab_name ~= "" and arg_383_1.actors_[var_386_9.prefab_name] ~= nil then
						local var_386_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_9.prefab_name].transform, "story_v_side_new_1106702", "1106702093", "story_v_side_new_1106702.awb")

						arg_383_1:RecordAudio("1106702093", var_386_15)
						arg_383_1:RecordAudio("1106702093", var_386_15)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702093", "story_v_side_new_1106702.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702093", "story_v_side_new_1106702.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_16 = math.max(var_386_7, arg_383_1.talkMaxDuration)

			if var_386_6 <= arg_383_1.time_ and arg_383_1.time_ < var_386_6 + var_386_16 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_6) / var_386_16

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_6 + var_386_16 and arg_383_1.time_ < var_386_6 + var_386_16 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1106702094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1106702094
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1106702095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1042ui_story"]
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.characterEffect1042ui_story == nil then
				arg_387_1.var_.characterEffect1042ui_story = var_390_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.2

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 and not isNil(var_390_0) then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2

				if arg_387_1.var_.characterEffect1042ui_story and not isNil(var_390_0) then
					local var_390_4 = Mathf.Lerp(0, 0.5, var_390_3)

					arg_387_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1042ui_story.fillRatio = var_390_4
				end
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.characterEffect1042ui_story then
				local var_390_5 = 0.5

				arg_387_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1042ui_story.fillRatio = var_390_5
			end

			local var_390_6 = 0
			local var_390_7 = 0.125

			if var_390_6 < arg_387_1.time_ and arg_387_1.time_ <= var_390_6 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_8 = arg_387_1:FormatText(StoryNameCfg[7].name)

				arg_387_1.leftNameTxt_.text = var_390_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_9 = arg_387_1:GetWordFromCfg(1106702094)
				local var_390_10 = arg_387_1:FormatText(var_390_9.content)

				arg_387_1.text_.text = var_390_10

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_11 = 5
				local var_390_12 = utf8.len(var_390_10)
				local var_390_13 = var_390_11 <= 0 and var_390_7 or var_390_7 * (var_390_12 / var_390_11)

				if var_390_13 > 0 and var_390_7 < var_390_13 then
					arg_387_1.talkMaxDuration = var_390_13

					if var_390_13 + var_390_6 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_13 + var_390_6
					end
				end

				arg_387_1.text_.text = var_390_10
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_14 = math.max(var_390_7, arg_387_1.talkMaxDuration)

			if var_390_6 <= arg_387_1.time_ and arg_387_1.time_ < var_390_6 + var_390_14 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_6) / var_390_14

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_6 + var_390_14 and arg_387_1.time_ < var_390_6 + var_390_14 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1106702095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1106702095
		arg_391_1.duration_ = 8.83

		local var_391_0 = {
			zh = 8.833,
			ja = 8.066
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1106702096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1042ui_story"]
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1042ui_story == nil then
				arg_391_1.var_.characterEffect1042ui_story = var_394_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.2

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 and not isNil(var_394_0) then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2

				if arg_391_1.var_.characterEffect1042ui_story and not isNil(var_394_0) then
					arg_391_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1042ui_story then
				arg_391_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_394_4 = 0

			if var_394_4 < arg_391_1.time_ and arg_391_1.time_ <= var_394_4 + arg_394_0 then
				arg_391_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_394_5 = 0

			if var_394_5 < arg_391_1.time_ and arg_391_1.time_ <= var_394_5 + arg_394_0 then
				arg_391_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_394_6 = 0
			local var_394_7 = 0.975

			if var_394_6 < arg_391_1.time_ and arg_391_1.time_ <= var_394_6 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_8 = arg_391_1:FormatText(StoryNameCfg[205].name)

				arg_391_1.leftNameTxt_.text = var_394_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_9 = arg_391_1:GetWordFromCfg(1106702095)
				local var_394_10 = arg_391_1:FormatText(var_394_9.content)

				arg_391_1.text_.text = var_394_10

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_11 = 39
				local var_394_12 = utf8.len(var_394_10)
				local var_394_13 = var_394_11 <= 0 and var_394_7 or var_394_7 * (var_394_12 / var_394_11)

				if var_394_13 > 0 and var_394_7 < var_394_13 then
					arg_391_1.talkMaxDuration = var_394_13

					if var_394_13 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_13 + var_394_6
					end
				end

				arg_391_1.text_.text = var_394_10
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702095", "story_v_side_new_1106702.awb") ~= 0 then
					local var_394_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702095", "story_v_side_new_1106702.awb") / 1000

					if var_394_14 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_14 + var_394_6
					end

					if var_394_9.prefab_name ~= "" and arg_391_1.actors_[var_394_9.prefab_name] ~= nil then
						local var_394_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_9.prefab_name].transform, "story_v_side_new_1106702", "1106702095", "story_v_side_new_1106702.awb")

						arg_391_1:RecordAudio("1106702095", var_394_15)
						arg_391_1:RecordAudio("1106702095", var_394_15)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702095", "story_v_side_new_1106702.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702095", "story_v_side_new_1106702.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_16 = math.max(var_394_7, arg_391_1.talkMaxDuration)

			if var_394_6 <= arg_391_1.time_ and arg_391_1.time_ < var_394_6 + var_394_16 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_6) / var_394_16

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_6 + var_394_16 and arg_391_1.time_ < var_394_6 + var_394_16 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1106702096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1106702096
		arg_395_1.duration_ = 8

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1106702097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = "ST25"

			if arg_395_1.bgs_[var_398_0] == nil then
				local var_398_1 = Object.Instantiate(arg_395_1.paintGo_)

				var_398_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_398_0)
				var_398_1.name = var_398_0
				var_398_1.transform.parent = arg_395_1.stage_.transform
				var_398_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_395_1.bgs_[var_398_0] = var_398_1
			end

			local var_398_2 = 1.5

			if var_398_2 < arg_395_1.time_ and arg_395_1.time_ <= var_398_2 + arg_398_0 then
				local var_398_3 = manager.ui.mainCamera.transform.localPosition
				local var_398_4 = Vector3.New(0, 0, 10) + Vector3.New(var_398_3.x, var_398_3.y, 0)
				local var_398_5 = arg_395_1.bgs_.ST25

				var_398_5.transform.localPosition = var_398_4
				var_398_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_398_6 = var_398_5:GetComponent("SpriteRenderer")

				if var_398_6 and var_398_6.sprite then
					local var_398_7 = (var_398_5.transform.localPosition - var_398_3).z
					local var_398_8 = manager.ui.mainCameraCom_
					local var_398_9 = 2 * var_398_7 * Mathf.Tan(var_398_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_398_10 = var_398_9 * var_398_8.aspect
					local var_398_11 = var_398_6.sprite.bounds.size.x
					local var_398_12 = var_398_6.sprite.bounds.size.y
					local var_398_13 = var_398_10 / var_398_11
					local var_398_14 = var_398_9 / var_398_12
					local var_398_15 = var_398_14 < var_398_13 and var_398_13 or var_398_14

					var_398_5.transform.localScale = Vector3.New(var_398_15, var_398_15, 0)
				end

				for iter_398_0, iter_398_1 in pairs(arg_395_1.bgs_) do
					if iter_398_0 ~= "ST25" then
						iter_398_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_398_16 = 0

			if var_398_16 < arg_395_1.time_ and arg_395_1.time_ <= var_398_16 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_17 = 1.5

			if var_398_16 <= arg_395_1.time_ and arg_395_1.time_ < var_398_16 + var_398_17 then
				local var_398_18 = (arg_395_1.time_ - var_398_16) / var_398_17
				local var_398_19 = Color.New(0, 0, 0)

				var_398_19.a = Mathf.Lerp(0, 1, var_398_18)
				arg_395_1.mask_.color = var_398_19
			end

			if arg_395_1.time_ >= var_398_16 + var_398_17 and arg_395_1.time_ < var_398_16 + var_398_17 + arg_398_0 then
				local var_398_20 = Color.New(0, 0, 0)

				var_398_20.a = 1
				arg_395_1.mask_.color = var_398_20
			end

			local var_398_21 = 1.5

			if var_398_21 < arg_395_1.time_ and arg_395_1.time_ <= var_398_21 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_22 = 1.5

			if var_398_21 <= arg_395_1.time_ and arg_395_1.time_ < var_398_21 + var_398_22 then
				local var_398_23 = (arg_395_1.time_ - var_398_21) / var_398_22
				local var_398_24 = Color.New(0, 0, 0)

				var_398_24.a = Mathf.Lerp(1, 0, var_398_23)
				arg_395_1.mask_.color = var_398_24
			end

			if arg_395_1.time_ >= var_398_21 + var_398_22 and arg_395_1.time_ < var_398_21 + var_398_22 + arg_398_0 then
				local var_398_25 = Color.New(0, 0, 0)
				local var_398_26 = 0

				arg_395_1.mask_.enabled = false
				var_398_25.a = var_398_26
				arg_395_1.mask_.color = var_398_25
			end

			local var_398_27 = arg_395_1.actors_["1042ui_story"].transform
			local var_398_28 = 1.5

			if var_398_28 < arg_395_1.time_ and arg_395_1.time_ <= var_398_28 + arg_398_0 then
				arg_395_1.var_.moveOldPos1042ui_story = var_398_27.localPosition
			end

			local var_398_29 = 0.001

			if var_398_28 <= arg_395_1.time_ and arg_395_1.time_ < var_398_28 + var_398_29 then
				local var_398_30 = (arg_395_1.time_ - var_398_28) / var_398_29
				local var_398_31 = Vector3.New(0, 100, 0)

				var_398_27.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1042ui_story, var_398_31, var_398_30)

				local var_398_32 = manager.ui.mainCamera.transform.position - var_398_27.position

				var_398_27.forward = Vector3.New(var_398_32.x, var_398_32.y, var_398_32.z)

				local var_398_33 = var_398_27.localEulerAngles

				var_398_33.z = 0
				var_398_33.x = 0
				var_398_27.localEulerAngles = var_398_33
			end

			if arg_395_1.time_ >= var_398_28 + var_398_29 and arg_395_1.time_ < var_398_28 + var_398_29 + arg_398_0 then
				var_398_27.localPosition = Vector3.New(0, 100, 0)

				local var_398_34 = manager.ui.mainCamera.transform.position - var_398_27.position

				var_398_27.forward = Vector3.New(var_398_34.x, var_398_34.y, var_398_34.z)

				local var_398_35 = var_398_27.localEulerAngles

				var_398_35.z = 0
				var_398_35.x = 0
				var_398_27.localEulerAngles = var_398_35
			end

			if arg_395_1.frameCnt_ <= 1 then
				arg_395_1.dialog_:SetActive(false)
			end

			local var_398_36 = 3
			local var_398_37 = 0.875

			if var_398_36 < arg_395_1.time_ and arg_395_1.time_ <= var_398_36 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0

				arg_395_1.dialog_:SetActive(true)

				arg_395_1.dialogCg_.alpha = 0

				local var_398_38 = LeanTween.value(arg_395_1.dialog_, 0, 1, 0.3)

				var_398_38:setOnUpdate(LuaHelper.FloatAction(function(arg_399_0)
					arg_395_1.dialogCg_.alpha = arg_399_0
				end))
				var_398_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_395_1.dialog_)
					var_398_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_395_1.duration_ = arg_395_1.duration_ + 0.3

				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_39 = arg_395_1:GetWordFromCfg(1106702096)
				local var_398_40 = arg_395_1:FormatText(var_398_39.content)

				arg_395_1.text_.text = var_398_40

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_41 = 35
				local var_398_42 = utf8.len(var_398_40)
				local var_398_43 = var_398_41 <= 0 and var_398_37 or var_398_37 * (var_398_42 / var_398_41)

				if var_398_43 > 0 and var_398_37 < var_398_43 then
					arg_395_1.talkMaxDuration = var_398_43
					var_398_36 = var_398_36 + 0.3

					if var_398_43 + var_398_36 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_43 + var_398_36
					end
				end

				arg_395_1.text_.text = var_398_40
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_44 = var_398_36 + 0.3
			local var_398_45 = math.max(var_398_37, arg_395_1.talkMaxDuration)

			if var_398_44 <= arg_395_1.time_ and arg_395_1.time_ < var_398_44 + var_398_45 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_44) / var_398_45

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_44 + var_398_45 and arg_395_1.time_ < var_398_44 + var_398_45 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play1106702097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1106702097
		arg_401_1.duration_ = 7.2

		local var_401_0 = {
			zh = 7.2,
			ja = 6.3
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1106702098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1067ui_story"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos1067ui_story = var_404_0.localPosition
			end

			local var_404_2 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2
				local var_404_4 = Vector3.New(0, -1.06, -6.2)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1067ui_story, var_404_4, var_404_3)

				local var_404_5 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_5.x, var_404_5.y, var_404_5.z)

				local var_404_6 = var_404_0.localEulerAngles

				var_404_6.z = 0
				var_404_6.x = 0
				var_404_0.localEulerAngles = var_404_6
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_404_7 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_7.x, var_404_7.y, var_404_7.z)

				local var_404_8 = var_404_0.localEulerAngles

				var_404_8.z = 0
				var_404_8.x = 0
				var_404_0.localEulerAngles = var_404_8
			end

			local var_404_9 = arg_401_1.actors_["1067ui_story"]
			local var_404_10 = 0

			if var_404_10 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1067ui_story == nil then
				arg_401_1.var_.characterEffect1067ui_story = var_404_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_11 = 0.2

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_11 and not isNil(var_404_9) then
				local var_404_12 = (arg_401_1.time_ - var_404_10) / var_404_11

				if arg_401_1.var_.characterEffect1067ui_story and not isNil(var_404_9) then
					arg_401_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_10 + var_404_11 and arg_401_1.time_ < var_404_10 + var_404_11 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1067ui_story then
				arg_401_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_404_13 = 0

			if var_404_13 < arg_401_1.time_ and arg_401_1.time_ <= var_404_13 + arg_404_0 then
				arg_401_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action2_1")
			end

			local var_404_14 = 0

			if var_404_14 < arg_401_1.time_ and arg_401_1.time_ <= var_404_14 + arg_404_0 then
				arg_401_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_404_15 = 0
			local var_404_16 = 0.9

			if var_404_15 < arg_401_1.time_ and arg_401_1.time_ <= var_404_15 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_17 = arg_401_1:FormatText(StoryNameCfg[206].name)

				arg_401_1.leftNameTxt_.text = var_404_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_18 = arg_401_1:GetWordFromCfg(1106702097)
				local var_404_19 = arg_401_1:FormatText(var_404_18.content)

				arg_401_1.text_.text = var_404_19

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_20 = 36
				local var_404_21 = utf8.len(var_404_19)
				local var_404_22 = var_404_20 <= 0 and var_404_16 or var_404_16 * (var_404_21 / var_404_20)

				if var_404_22 > 0 and var_404_16 < var_404_22 then
					arg_401_1.talkMaxDuration = var_404_22

					if var_404_22 + var_404_15 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_22 + var_404_15
					end
				end

				arg_401_1.text_.text = var_404_19
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702097", "story_v_side_new_1106702.awb") ~= 0 then
					local var_404_23 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702097", "story_v_side_new_1106702.awb") / 1000

					if var_404_23 + var_404_15 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_23 + var_404_15
					end

					if var_404_18.prefab_name ~= "" and arg_401_1.actors_[var_404_18.prefab_name] ~= nil then
						local var_404_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_18.prefab_name].transform, "story_v_side_new_1106702", "1106702097", "story_v_side_new_1106702.awb")

						arg_401_1:RecordAudio("1106702097", var_404_24)
						arg_401_1:RecordAudio("1106702097", var_404_24)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702097", "story_v_side_new_1106702.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702097", "story_v_side_new_1106702.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_25 = math.max(var_404_16, arg_401_1.talkMaxDuration)

			if var_404_15 <= arg_401_1.time_ and arg_401_1.time_ < var_404_15 + var_404_25 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_15) / var_404_25

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_15 + var_404_25 and arg_401_1.time_ < var_404_15 + var_404_25 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
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

		arg_401_1:InitPlayNodeList()
	end,
	Play1106702098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1106702098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1106702099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1067ui_story"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1067ui_story == nil then
				arg_405_1.var_.characterEffect1067ui_story = var_408_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.2

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.characterEffect1067ui_story and not isNil(var_408_0) then
					local var_408_4 = Mathf.Lerp(0, 0.5, var_408_3)

					arg_405_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1067ui_story.fillRatio = var_408_4
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1067ui_story then
				local var_408_5 = 0.5

				arg_405_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1067ui_story.fillRatio = var_408_5
			end

			local var_408_6 = 0
			local var_408_7 = 0.375

			if var_408_6 < arg_405_1.time_ and arg_405_1.time_ <= var_408_6 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_8 = arg_405_1:FormatText(StoryNameCfg[7].name)

				arg_405_1.leftNameTxt_.text = var_408_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_9 = arg_405_1:GetWordFromCfg(1106702098)
				local var_408_10 = arg_405_1:FormatText(var_408_9.content)

				arg_405_1.text_.text = var_408_10

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 15
				local var_408_12 = utf8.len(var_408_10)
				local var_408_13 = var_408_11 <= 0 and var_408_7 or var_408_7 * (var_408_12 / var_408_11)

				if var_408_13 > 0 and var_408_7 < var_408_13 then
					arg_405_1.talkMaxDuration = var_408_13

					if var_408_13 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_13 + var_408_6
					end
				end

				arg_405_1.text_.text = var_408_10
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_14 = math.max(var_408_7, arg_405_1.talkMaxDuration)

			if var_408_6 <= arg_405_1.time_ and arg_405_1.time_ < var_408_6 + var_408_14 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_6) / var_408_14

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_6 + var_408_14 and arg_405_1.time_ < var_408_6 + var_408_14 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1106702099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1106702099
		arg_409_1.duration_ = 3.5

		local var_409_0 = {
			zh = 3.5,
			ja = 3.3
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1106702100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1067ui_story"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect1067ui_story == nil then
				arg_409_1.var_.characterEffect1067ui_story = var_412_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.2

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.characterEffect1067ui_story and not isNil(var_412_0) then
					arg_409_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect1067ui_story then
				arg_409_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_412_4 = 0

			if var_412_4 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_412_5 = 0
			local var_412_6 = 0.45

			if var_412_5 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_7 = arg_409_1:FormatText(StoryNameCfg[206].name)

				arg_409_1.leftNameTxt_.text = var_412_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_8 = arg_409_1:GetWordFromCfg(1106702099)
				local var_412_9 = arg_409_1:FormatText(var_412_8.content)

				arg_409_1.text_.text = var_412_9

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_10 = 18
				local var_412_11 = utf8.len(var_412_9)
				local var_412_12 = var_412_10 <= 0 and var_412_6 or var_412_6 * (var_412_11 / var_412_10)

				if var_412_12 > 0 and var_412_6 < var_412_12 then
					arg_409_1.talkMaxDuration = var_412_12

					if var_412_12 + var_412_5 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_12 + var_412_5
					end
				end

				arg_409_1.text_.text = var_412_9
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702099", "story_v_side_new_1106702.awb") ~= 0 then
					local var_412_13 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702099", "story_v_side_new_1106702.awb") / 1000

					if var_412_13 + var_412_5 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_13 + var_412_5
					end

					if var_412_8.prefab_name ~= "" and arg_409_1.actors_[var_412_8.prefab_name] ~= nil then
						local var_412_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_8.prefab_name].transform, "story_v_side_new_1106702", "1106702099", "story_v_side_new_1106702.awb")

						arg_409_1:RecordAudio("1106702099", var_412_14)
						arg_409_1:RecordAudio("1106702099", var_412_14)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702099", "story_v_side_new_1106702.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702099", "story_v_side_new_1106702.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_15 = math.max(var_412_6, arg_409_1.talkMaxDuration)

			if var_412_5 <= arg_409_1.time_ and arg_409_1.time_ < var_412_5 + var_412_15 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_5) / var_412_15

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_5 + var_412_15 and arg_409_1.time_ < var_412_5 + var_412_15 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1106702100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1106702100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1106702101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1067ui_story"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1067ui_story == nil then
				arg_413_1.var_.characterEffect1067ui_story = var_416_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.2

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.characterEffect1067ui_story and not isNil(var_416_0) then
					local var_416_4 = Mathf.Lerp(0, 0.5, var_416_3)

					arg_413_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1067ui_story.fillRatio = var_416_4
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1067ui_story then
				local var_416_5 = 0.5

				arg_413_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1067ui_story.fillRatio = var_416_5
			end

			local var_416_6 = 0
			local var_416_7 = 1.3

			if var_416_6 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_8 = arg_413_1:FormatText(StoryNameCfg[7].name)

				arg_413_1.leftNameTxt_.text = var_416_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_9 = arg_413_1:GetWordFromCfg(1106702100)
				local var_416_10 = arg_413_1:FormatText(var_416_9.content)

				arg_413_1.text_.text = var_416_10

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_11 = 52
				local var_416_12 = utf8.len(var_416_10)
				local var_416_13 = var_416_11 <= 0 and var_416_7 or var_416_7 * (var_416_12 / var_416_11)

				if var_416_13 > 0 and var_416_7 < var_416_13 then
					arg_413_1.talkMaxDuration = var_416_13

					if var_416_13 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_13 + var_416_6
					end
				end

				arg_413_1.text_.text = var_416_10
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_14 = math.max(var_416_7, arg_413_1.talkMaxDuration)

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_14 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_6) / var_416_14

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_6 + var_416_14 and arg_413_1.time_ < var_416_6 + var_416_14 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1106702101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1106702101
		arg_417_1.duration_ = 7.57

		local var_417_0 = {
			zh = 5.6,
			ja = 7.566
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1106702102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1067ui_story"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1067ui_story == nil then
				arg_417_1.var_.characterEffect1067ui_story = var_420_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.2

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.characterEffect1067ui_story and not isNil(var_420_0) then
					arg_417_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1067ui_story then
				arg_417_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_420_4 = 0

			if var_420_4 < arg_417_1.time_ and arg_417_1.time_ <= var_420_4 + arg_420_0 then
				arg_417_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action2_2")
			end

			local var_420_5 = 0

			if var_420_5 < arg_417_1.time_ and arg_417_1.time_ <= var_420_5 + arg_420_0 then
				arg_417_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_420_6 = 0
			local var_420_7 = 0.6

			if var_420_6 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_8 = arg_417_1:FormatText(StoryNameCfg[206].name)

				arg_417_1.leftNameTxt_.text = var_420_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_9 = arg_417_1:GetWordFromCfg(1106702101)
				local var_420_10 = arg_417_1:FormatText(var_420_9.content)

				arg_417_1.text_.text = var_420_10

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_11 = 24
				local var_420_12 = utf8.len(var_420_10)
				local var_420_13 = var_420_11 <= 0 and var_420_7 or var_420_7 * (var_420_12 / var_420_11)

				if var_420_13 > 0 and var_420_7 < var_420_13 then
					arg_417_1.talkMaxDuration = var_420_13

					if var_420_13 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_13 + var_420_6
					end
				end

				arg_417_1.text_.text = var_420_10
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702101", "story_v_side_new_1106702.awb") ~= 0 then
					local var_420_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702101", "story_v_side_new_1106702.awb") / 1000

					if var_420_14 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_14 + var_420_6
					end

					if var_420_9.prefab_name ~= "" and arg_417_1.actors_[var_420_9.prefab_name] ~= nil then
						local var_420_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_9.prefab_name].transform, "story_v_side_new_1106702", "1106702101", "story_v_side_new_1106702.awb")

						arg_417_1:RecordAudio("1106702101", var_420_15)
						arg_417_1:RecordAudio("1106702101", var_420_15)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702101", "story_v_side_new_1106702.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702101", "story_v_side_new_1106702.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_16 = math.max(var_420_7, arg_417_1.talkMaxDuration)

			if var_420_6 <= arg_417_1.time_ and arg_417_1.time_ < var_420_6 + var_420_16 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_6) / var_420_16

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_6 + var_420_16 and arg_417_1.time_ < var_420_6 + var_420_16 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1106702102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1106702102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1106702103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1067ui_story"]
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1067ui_story == nil then
				arg_421_1.var_.characterEffect1067ui_story = var_424_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.2

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 and not isNil(var_424_0) then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2

				if arg_421_1.var_.characterEffect1067ui_story and not isNil(var_424_0) then
					local var_424_4 = Mathf.Lerp(0, 0.5, var_424_3)

					arg_421_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1067ui_story.fillRatio = var_424_4
				end
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1067ui_story then
				local var_424_5 = 0.5

				arg_421_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1067ui_story.fillRatio = var_424_5
			end

			local var_424_6 = 0
			local var_424_7 = 0.975

			if var_424_6 < arg_421_1.time_ and arg_421_1.time_ <= var_424_6 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_8 = arg_421_1:FormatText(StoryNameCfg[7].name)

				arg_421_1.leftNameTxt_.text = var_424_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_9 = arg_421_1:GetWordFromCfg(1106702102)
				local var_424_10 = arg_421_1:FormatText(var_424_9.content)

				arg_421_1.text_.text = var_424_10

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_11 = 39
				local var_424_12 = utf8.len(var_424_10)
				local var_424_13 = var_424_11 <= 0 and var_424_7 or var_424_7 * (var_424_12 / var_424_11)

				if var_424_13 > 0 and var_424_7 < var_424_13 then
					arg_421_1.talkMaxDuration = var_424_13

					if var_424_13 + var_424_6 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_13 + var_424_6
					end
				end

				arg_421_1.text_.text = var_424_10
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_14 = math.max(var_424_7, arg_421_1.talkMaxDuration)

			if var_424_6 <= arg_421_1.time_ and arg_421_1.time_ < var_424_6 + var_424_14 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_6) / var_424_14

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_6 + var_424_14 and arg_421_1.time_ < var_424_6 + var_424_14 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1106702103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1106702103
		arg_425_1.duration_ = 3.2

		local var_425_0 = {
			zh = 3.1,
			ja = 3.2
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1106702104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1067ui_story"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1067ui_story == nil then
				arg_425_1.var_.characterEffect1067ui_story = var_428_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.2

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.characterEffect1067ui_story and not isNil(var_428_0) then
					arg_425_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1067ui_story then
				arg_425_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_428_4 = 0

			if var_428_4 < arg_425_1.time_ and arg_425_1.time_ <= var_428_4 + arg_428_0 then
				arg_425_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_428_5 = 0
			local var_428_6 = 0.25

			if var_428_5 < arg_425_1.time_ and arg_425_1.time_ <= var_428_5 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_7 = arg_425_1:FormatText(StoryNameCfg[206].name)

				arg_425_1.leftNameTxt_.text = var_428_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_8 = arg_425_1:GetWordFromCfg(1106702103)
				local var_428_9 = arg_425_1:FormatText(var_428_8.content)

				arg_425_1.text_.text = var_428_9

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_10 = 10
				local var_428_11 = utf8.len(var_428_9)
				local var_428_12 = var_428_10 <= 0 and var_428_6 or var_428_6 * (var_428_11 / var_428_10)

				if var_428_12 > 0 and var_428_6 < var_428_12 then
					arg_425_1.talkMaxDuration = var_428_12

					if var_428_12 + var_428_5 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_12 + var_428_5
					end
				end

				arg_425_1.text_.text = var_428_9
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702103", "story_v_side_new_1106702.awb") ~= 0 then
					local var_428_13 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702103", "story_v_side_new_1106702.awb") / 1000

					if var_428_13 + var_428_5 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_13 + var_428_5
					end

					if var_428_8.prefab_name ~= "" and arg_425_1.actors_[var_428_8.prefab_name] ~= nil then
						local var_428_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_8.prefab_name].transform, "story_v_side_new_1106702", "1106702103", "story_v_side_new_1106702.awb")

						arg_425_1:RecordAudio("1106702103", var_428_14)
						arg_425_1:RecordAudio("1106702103", var_428_14)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702103", "story_v_side_new_1106702.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702103", "story_v_side_new_1106702.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_15 = math.max(var_428_6, arg_425_1.talkMaxDuration)

			if var_428_5 <= arg_425_1.time_ and arg_425_1.time_ < var_428_5 + var_428_15 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_5) / var_428_15

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_5 + var_428_15 and arg_425_1.time_ < var_428_5 + var_428_15 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1106702104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1106702104
		arg_429_1.duration_ = 12.13

		local var_429_0 = {
			zh = 9,
			ja = 12.133
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1106702105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0

			if var_432_0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_0 + arg_432_0 then
				arg_429_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_432_1 = 0
			local var_432_2 = 1.05

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_3 = arg_429_1:FormatText(StoryNameCfg[206].name)

				arg_429_1.leftNameTxt_.text = var_432_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_4 = arg_429_1:GetWordFromCfg(1106702104)
				local var_432_5 = arg_429_1:FormatText(var_432_4.content)

				arg_429_1.text_.text = var_432_5

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_6 = 42
				local var_432_7 = utf8.len(var_432_5)
				local var_432_8 = var_432_6 <= 0 and var_432_2 or var_432_2 * (var_432_7 / var_432_6)

				if var_432_8 > 0 and var_432_2 < var_432_8 then
					arg_429_1.talkMaxDuration = var_432_8

					if var_432_8 + var_432_1 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_8 + var_432_1
					end
				end

				arg_429_1.text_.text = var_432_5
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702104", "story_v_side_new_1106702.awb") ~= 0 then
					local var_432_9 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702104", "story_v_side_new_1106702.awb") / 1000

					if var_432_9 + var_432_1 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_9 + var_432_1
					end

					if var_432_4.prefab_name ~= "" and arg_429_1.actors_[var_432_4.prefab_name] ~= nil then
						local var_432_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_4.prefab_name].transform, "story_v_side_new_1106702", "1106702104", "story_v_side_new_1106702.awb")

						arg_429_1:RecordAudio("1106702104", var_432_10)
						arg_429_1:RecordAudio("1106702104", var_432_10)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702104", "story_v_side_new_1106702.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702104", "story_v_side_new_1106702.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_11 = math.max(var_432_2, arg_429_1.talkMaxDuration)

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_11 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_1) / var_432_11

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_1 + var_432_11 and arg_429_1.time_ < var_432_1 + var_432_11 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1106702105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1106702105
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1106702106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1067ui_story"]
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1067ui_story == nil then
				arg_433_1.var_.characterEffect1067ui_story = var_436_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.2

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 and not isNil(var_436_0) then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2

				if arg_433_1.var_.characterEffect1067ui_story and not isNil(var_436_0) then
					local var_436_4 = Mathf.Lerp(0, 0.5, var_436_3)

					arg_433_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1067ui_story.fillRatio = var_436_4
				end
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1067ui_story then
				local var_436_5 = 0.5

				arg_433_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1067ui_story.fillRatio = var_436_5
			end

			local var_436_6 = 0
			local var_436_7 = 1.375

			if var_436_6 < arg_433_1.time_ and arg_433_1.time_ <= var_436_6 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_8 = arg_433_1:GetWordFromCfg(1106702105)
				local var_436_9 = arg_433_1:FormatText(var_436_8.content)

				arg_433_1.text_.text = var_436_9

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_10 = 55
				local var_436_11 = utf8.len(var_436_9)
				local var_436_12 = var_436_10 <= 0 and var_436_7 or var_436_7 * (var_436_11 / var_436_10)

				if var_436_12 > 0 and var_436_7 < var_436_12 then
					arg_433_1.talkMaxDuration = var_436_12

					if var_436_12 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_12 + var_436_6
					end
				end

				arg_433_1.text_.text = var_436_9
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_13 = math.max(var_436_7, arg_433_1.talkMaxDuration)

			if var_436_6 <= arg_433_1.time_ and arg_433_1.time_ < var_436_6 + var_436_13 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_6) / var_436_13

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_6 + var_436_13 and arg_433_1.time_ < var_436_6 + var_436_13 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1106702106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1106702106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1106702107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.575

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_2 = arg_437_1:GetWordFromCfg(1106702106)
				local var_440_3 = arg_437_1:FormatText(var_440_2.content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_4 = 23
				local var_440_5 = utf8.len(var_440_3)
				local var_440_6 = var_440_4 <= 0 and var_440_1 or var_440_1 * (var_440_5 / var_440_4)

				if var_440_6 > 0 and var_440_1 < var_440_6 then
					arg_437_1.talkMaxDuration = var_440_6

					if var_440_6 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_6 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_3
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_7 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_7 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_7

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_7 and arg_437_1.time_ < var_440_0 + var_440_7 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1106702107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1106702107
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1106702108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 0.525

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_2 = arg_441_1:FormatText(StoryNameCfg[7].name)

				arg_441_1.leftNameTxt_.text = var_444_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:GetWordFromCfg(1106702107)
				local var_444_4 = arg_441_1:FormatText(var_444_3.content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 21
				local var_444_6 = utf8.len(var_444_4)
				local var_444_7 = var_444_5 <= 0 and var_444_1 or var_444_1 * (var_444_6 / var_444_5)

				if var_444_7 > 0 and var_444_1 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_8 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_8 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_8

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_8 and arg_441_1.time_ < var_444_0 + var_444_8 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1106702108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1106702108
		arg_445_1.duration_ = 3.57

		local var_445_0 = {
			zh = 1.999999999999,
			ja = 3.566
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1106702109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["1067ui_story"]
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.characterEffect1067ui_story == nil then
				arg_445_1.var_.characterEffect1067ui_story = var_448_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_2 = 0.2

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_2 and not isNil(var_448_0) then
				local var_448_3 = (arg_445_1.time_ - var_448_1) / var_448_2

				if arg_445_1.var_.characterEffect1067ui_story and not isNil(var_448_0) then
					arg_445_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= var_448_1 + var_448_2 and arg_445_1.time_ < var_448_1 + var_448_2 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.characterEffect1067ui_story then
				arg_445_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_448_4 = 0

			if var_448_4 < arg_445_1.time_ and arg_445_1.time_ <= var_448_4 + arg_448_0 then
				arg_445_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_448_5 = 0

			if var_448_5 < arg_445_1.time_ and arg_445_1.time_ <= var_448_5 + arg_448_0 then
				arg_445_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_448_6 = 0
			local var_448_7 = 0.1

			if var_448_6 < arg_445_1.time_ and arg_445_1.time_ <= var_448_6 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_8 = arg_445_1:FormatText(StoryNameCfg[206].name)

				arg_445_1.leftNameTxt_.text = var_448_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_9 = arg_445_1:GetWordFromCfg(1106702108)
				local var_448_10 = arg_445_1:FormatText(var_448_9.content)

				arg_445_1.text_.text = var_448_10

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_11 = 4
				local var_448_12 = utf8.len(var_448_10)
				local var_448_13 = var_448_11 <= 0 and var_448_7 or var_448_7 * (var_448_12 / var_448_11)

				if var_448_13 > 0 and var_448_7 < var_448_13 then
					arg_445_1.talkMaxDuration = var_448_13

					if var_448_13 + var_448_6 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_13 + var_448_6
					end
				end

				arg_445_1.text_.text = var_448_10
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702108", "story_v_side_new_1106702.awb") ~= 0 then
					local var_448_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702108", "story_v_side_new_1106702.awb") / 1000

					if var_448_14 + var_448_6 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_14 + var_448_6
					end

					if var_448_9.prefab_name ~= "" and arg_445_1.actors_[var_448_9.prefab_name] ~= nil then
						local var_448_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_9.prefab_name].transform, "story_v_side_new_1106702", "1106702108", "story_v_side_new_1106702.awb")

						arg_445_1:RecordAudio("1106702108", var_448_15)
						arg_445_1:RecordAudio("1106702108", var_448_15)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702108", "story_v_side_new_1106702.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702108", "story_v_side_new_1106702.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_16 = math.max(var_448_7, arg_445_1.talkMaxDuration)

			if var_448_6 <= arg_445_1.time_ and arg_445_1.time_ < var_448_6 + var_448_16 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_6) / var_448_16

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_6 + var_448_16 and arg_445_1.time_ < var_448_6 + var_448_16 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1106702109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1106702109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1106702110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["1067ui_story"]
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.characterEffect1067ui_story == nil then
				arg_449_1.var_.characterEffect1067ui_story = var_452_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.2

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 and not isNil(var_452_0) then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2

				if arg_449_1.var_.characterEffect1067ui_story and not isNil(var_452_0) then
					local var_452_4 = Mathf.Lerp(0, 0.5, var_452_3)

					arg_449_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1067ui_story.fillRatio = var_452_4
				end
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.characterEffect1067ui_story then
				local var_452_5 = 0.5

				arg_449_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1067ui_story.fillRatio = var_452_5
			end

			local var_452_6 = 0
			local var_452_7 = 0.175

			if var_452_6 < arg_449_1.time_ and arg_449_1.time_ <= var_452_6 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_8 = arg_449_1:FormatText(StoryNameCfg[7].name)

				arg_449_1.leftNameTxt_.text = var_452_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_9 = arg_449_1:GetWordFromCfg(1106702109)
				local var_452_10 = arg_449_1:FormatText(var_452_9.content)

				arg_449_1.text_.text = var_452_10

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_11 = 7
				local var_452_12 = utf8.len(var_452_10)
				local var_452_13 = var_452_11 <= 0 and var_452_7 or var_452_7 * (var_452_12 / var_452_11)

				if var_452_13 > 0 and var_452_7 < var_452_13 then
					arg_449_1.talkMaxDuration = var_452_13

					if var_452_13 + var_452_6 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_13 + var_452_6
					end
				end

				arg_449_1.text_.text = var_452_10
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_14 = math.max(var_452_7, arg_449_1.talkMaxDuration)

			if var_452_6 <= arg_449_1.time_ and arg_449_1.time_ < var_452_6 + var_452_14 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_6) / var_452_14

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_6 + var_452_14 and arg_449_1.time_ < var_452_6 + var_452_14 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1106702110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1106702110
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1106702111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 0.675

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_2 = arg_453_1:GetWordFromCfg(1106702110)
				local var_456_3 = arg_453_1:FormatText(var_456_2.content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 27
				local var_456_5 = utf8.len(var_456_3)
				local var_456_6 = var_456_4 <= 0 and var_456_1 or var_456_1 * (var_456_5 / var_456_4)

				if var_456_6 > 0 and var_456_1 < var_456_6 then
					arg_453_1.talkMaxDuration = var_456_6

					if var_456_6 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_7 and arg_453_1.time_ < var_456_0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1106702111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1106702111
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1106702112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.75

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_2 = arg_457_1:FormatText(StoryNameCfg[7].name)

				arg_457_1.leftNameTxt_.text = var_460_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:GetWordFromCfg(1106702111)
				local var_460_4 = arg_457_1:FormatText(var_460_3.content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 28
				local var_460_6 = utf8.len(var_460_4)
				local var_460_7 = var_460_5 <= 0 and var_460_1 or var_460_1 * (var_460_6 / var_460_5)

				if var_460_7 > 0 and var_460_1 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_4
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_8 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_8 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_8

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_8 and arg_457_1.time_ < var_460_0 + var_460_8 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1106702112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1106702112
		arg_461_1.duration_ = 5.4

		local var_461_0 = {
			zh = 5.4,
			ja = 4.733
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1106702113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["1067ui_story"]
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.characterEffect1067ui_story == nil then
				arg_461_1.var_.characterEffect1067ui_story = var_464_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.2

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 and not isNil(var_464_0) then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2

				if arg_461_1.var_.characterEffect1067ui_story and not isNil(var_464_0) then
					arg_461_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.characterEffect1067ui_story then
				arg_461_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_464_4 = 0

			if var_464_4 < arg_461_1.time_ and arg_461_1.time_ <= var_464_4 + arg_464_0 then
				arg_461_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_464_5 = 0

			if var_464_5 < arg_461_1.time_ and arg_461_1.time_ <= var_464_5 + arg_464_0 then
				arg_461_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_464_6 = 0
			local var_464_7 = 0.625

			if var_464_6 < arg_461_1.time_ and arg_461_1.time_ <= var_464_6 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_8 = arg_461_1:FormatText(StoryNameCfg[206].name)

				arg_461_1.leftNameTxt_.text = var_464_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_9 = arg_461_1:GetWordFromCfg(1106702112)
				local var_464_10 = arg_461_1:FormatText(var_464_9.content)

				arg_461_1.text_.text = var_464_10

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_11 = 25
				local var_464_12 = utf8.len(var_464_10)
				local var_464_13 = var_464_11 <= 0 and var_464_7 or var_464_7 * (var_464_12 / var_464_11)

				if var_464_13 > 0 and var_464_7 < var_464_13 then
					arg_461_1.talkMaxDuration = var_464_13

					if var_464_13 + var_464_6 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_13 + var_464_6
					end
				end

				arg_461_1.text_.text = var_464_10
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702112", "story_v_side_new_1106702.awb") ~= 0 then
					local var_464_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702112", "story_v_side_new_1106702.awb") / 1000

					if var_464_14 + var_464_6 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_14 + var_464_6
					end

					if var_464_9.prefab_name ~= "" and arg_461_1.actors_[var_464_9.prefab_name] ~= nil then
						local var_464_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_9.prefab_name].transform, "story_v_side_new_1106702", "1106702112", "story_v_side_new_1106702.awb")

						arg_461_1:RecordAudio("1106702112", var_464_15)
						arg_461_1:RecordAudio("1106702112", var_464_15)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702112", "story_v_side_new_1106702.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702112", "story_v_side_new_1106702.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_16 = math.max(var_464_7, arg_461_1.talkMaxDuration)

			if var_464_6 <= arg_461_1.time_ and arg_461_1.time_ < var_464_6 + var_464_16 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_6) / var_464_16

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_6 + var_464_16 and arg_461_1.time_ < var_464_6 + var_464_16 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1106702113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1106702113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1106702114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["1067ui_story"]
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect1067ui_story == nil then
				arg_465_1.var_.characterEffect1067ui_story = var_468_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.2

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 and not isNil(var_468_0) then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2

				if arg_465_1.var_.characterEffect1067ui_story and not isNil(var_468_0) then
					local var_468_4 = Mathf.Lerp(0, 0.5, var_468_3)

					arg_465_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1067ui_story.fillRatio = var_468_4
				end
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect1067ui_story then
				local var_468_5 = 0.5

				arg_465_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1067ui_story.fillRatio = var_468_5
			end

			local var_468_6 = 0
			local var_468_7 = 0.8

			if var_468_6 < arg_465_1.time_ and arg_465_1.time_ <= var_468_6 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_8 = arg_465_1:FormatText(StoryNameCfg[7].name)

				arg_465_1.leftNameTxt_.text = var_468_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_9 = arg_465_1:GetWordFromCfg(1106702113)
				local var_468_10 = arg_465_1:FormatText(var_468_9.content)

				arg_465_1.text_.text = var_468_10

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_11 = 32
				local var_468_12 = utf8.len(var_468_10)
				local var_468_13 = var_468_11 <= 0 and var_468_7 or var_468_7 * (var_468_12 / var_468_11)

				if var_468_13 > 0 and var_468_7 < var_468_13 then
					arg_465_1.talkMaxDuration = var_468_13

					if var_468_13 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_13 + var_468_6
					end
				end

				arg_465_1.text_.text = var_468_10
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_14 = math.max(var_468_7, arg_465_1.talkMaxDuration)

			if var_468_6 <= arg_465_1.time_ and arg_465_1.time_ < var_468_6 + var_468_14 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_6) / var_468_14

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_6 + var_468_14 and arg_465_1.time_ < var_468_6 + var_468_14 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1106702114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1106702114
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1106702115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 1.525

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[7].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:GetWordFromCfg(1106702114)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 61
				local var_472_6 = utf8.len(var_472_4)
				local var_472_7 = var_472_5 <= 0 and var_472_1 or var_472_1 * (var_472_6 / var_472_5)

				if var_472_7 > 0 and var_472_1 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_8 and arg_469_1.time_ < var_472_0 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1106702115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1106702115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1106702116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 1.375

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:GetWordFromCfg(1106702115)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 55
				local var_476_6 = utf8.len(var_476_4)
				local var_476_7 = var_476_5 <= 0 and var_476_1 or var_476_1 * (var_476_6 / var_476_5)

				if var_476_7 > 0 and var_476_1 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_8 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_8 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_8

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_8 and arg_473_1.time_ < var_476_0 + var_476_8 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1106702116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1106702116
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1106702117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0
			local var_480_1 = 1.05

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_2 = arg_477_1:FormatText(StoryNameCfg[7].name)

				arg_477_1.leftNameTxt_.text = var_480_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:GetWordFromCfg(1106702116)
				local var_480_4 = arg_477_1:FormatText(var_480_3.content)

				arg_477_1.text_.text = var_480_4

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 42
				local var_480_6 = utf8.len(var_480_4)
				local var_480_7 = var_480_5 <= 0 and var_480_1 or var_480_1 * (var_480_6 / var_480_5)

				if var_480_7 > 0 and var_480_1 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_4
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_8 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_8 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_8

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_8 and arg_477_1.time_ < var_480_0 + var_480_8 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1106702117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1106702117
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1106702118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.3

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_2 = arg_481_1:FormatText(StoryNameCfg[7].name)

				arg_481_1.leftNameTxt_.text = var_484_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_3 = arg_481_1:GetWordFromCfg(1106702117)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 12
				local var_484_6 = utf8.len(var_484_4)
				local var_484_7 = var_484_5 <= 0 and var_484_1 or var_484_1 * (var_484_6 / var_484_5)

				if var_484_7 > 0 and var_484_1 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_8 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_8 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_8

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_8 and arg_481_1.time_ < var_484_0 + var_484_8 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1106702118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1106702118
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1106702119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_488_1 = 0
			local var_488_2 = 0.8

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_3 = arg_485_1:GetWordFromCfg(1106702118)
				local var_488_4 = arg_485_1:FormatText(var_488_3.content)

				arg_485_1.text_.text = var_488_4

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 32
				local var_488_6 = utf8.len(var_488_4)
				local var_488_7 = var_488_5 <= 0 and var_488_2 or var_488_2 * (var_488_6 / var_488_5)

				if var_488_7 > 0 and var_488_2 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_1 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_1
					end
				end

				arg_485_1.text_.text = var_488_4
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_8 = math.max(var_488_2, arg_485_1.talkMaxDuration)

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_8 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_1) / var_488_8

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_1 + var_488_8 and arg_485_1.time_ < var_488_1 + var_488_8 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1106702119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1106702119
		arg_489_1.duration_ = 5.07

		local var_489_0 = {
			zh = 4.033,
			ja = 5.066
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1106702120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["1067ui_story"]
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1067ui_story == nil then
				arg_489_1.var_.characterEffect1067ui_story = var_492_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_2 = 0.2

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 and not isNil(var_492_0) then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2

				if arg_489_1.var_.characterEffect1067ui_story and not isNil(var_492_0) then
					arg_489_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1067ui_story then
				arg_489_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_492_4 = 0

			if var_492_4 < arg_489_1.time_ and arg_489_1.time_ <= var_492_4 + arg_492_0 then
				arg_489_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action437")
			end

			local var_492_5 = 0

			if var_492_5 < arg_489_1.time_ and arg_489_1.time_ <= var_492_5 + arg_492_0 then
				arg_489_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_492_6 = 0
			local var_492_7 = 0.4

			if var_492_6 < arg_489_1.time_ and arg_489_1.time_ <= var_492_6 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_8 = arg_489_1:FormatText(StoryNameCfg[206].name)

				arg_489_1.leftNameTxt_.text = var_492_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_9 = arg_489_1:GetWordFromCfg(1106702119)
				local var_492_10 = arg_489_1:FormatText(var_492_9.content)

				arg_489_1.text_.text = var_492_10

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_11 = 16
				local var_492_12 = utf8.len(var_492_10)
				local var_492_13 = var_492_11 <= 0 and var_492_7 or var_492_7 * (var_492_12 / var_492_11)

				if var_492_13 > 0 and var_492_7 < var_492_13 then
					arg_489_1.talkMaxDuration = var_492_13

					if var_492_13 + var_492_6 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_13 + var_492_6
					end
				end

				arg_489_1.text_.text = var_492_10
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702119", "story_v_side_new_1106702.awb") ~= 0 then
					local var_492_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702119", "story_v_side_new_1106702.awb") / 1000

					if var_492_14 + var_492_6 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_14 + var_492_6
					end

					if var_492_9.prefab_name ~= "" and arg_489_1.actors_[var_492_9.prefab_name] ~= nil then
						local var_492_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_9.prefab_name].transform, "story_v_side_new_1106702", "1106702119", "story_v_side_new_1106702.awb")

						arg_489_1:RecordAudio("1106702119", var_492_15)
						arg_489_1:RecordAudio("1106702119", var_492_15)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702119", "story_v_side_new_1106702.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702119", "story_v_side_new_1106702.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_16 = math.max(var_492_7, arg_489_1.talkMaxDuration)

			if var_492_6 <= arg_489_1.time_ and arg_489_1.time_ < var_492_6 + var_492_16 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_6) / var_492_16

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_6 + var_492_16 and arg_489_1.time_ < var_492_6 + var_492_16 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1106702120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1106702120
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1106702121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1067ui_story"]
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1067ui_story == nil then
				arg_493_1.var_.characterEffect1067ui_story = var_496_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.2

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 and not isNil(var_496_0) then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2

				if arg_493_1.var_.characterEffect1067ui_story and not isNil(var_496_0) then
					local var_496_4 = Mathf.Lerp(0, 0.5, var_496_3)

					arg_493_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1067ui_story.fillRatio = var_496_4
				end
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1067ui_story then
				local var_496_5 = 0.5

				arg_493_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1067ui_story.fillRatio = var_496_5
			end

			local var_496_6 = 0
			local var_496_7 = 0.875

			if var_496_6 < arg_493_1.time_ and arg_493_1.time_ <= var_496_6 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_8 = arg_493_1:FormatText(StoryNameCfg[7].name)

				arg_493_1.leftNameTxt_.text = var_496_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_9 = arg_493_1:GetWordFromCfg(1106702120)
				local var_496_10 = arg_493_1:FormatText(var_496_9.content)

				arg_493_1.text_.text = var_496_10

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_11 = 35
				local var_496_12 = utf8.len(var_496_10)
				local var_496_13 = var_496_11 <= 0 and var_496_7 or var_496_7 * (var_496_12 / var_496_11)

				if var_496_13 > 0 and var_496_7 < var_496_13 then
					arg_493_1.talkMaxDuration = var_496_13

					if var_496_13 + var_496_6 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_13 + var_496_6
					end
				end

				arg_493_1.text_.text = var_496_10
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_14 = math.max(var_496_7, arg_493_1.talkMaxDuration)

			if var_496_6 <= arg_493_1.time_ and arg_493_1.time_ < var_496_6 + var_496_14 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_6) / var_496_14

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_6 + var_496_14 and arg_493_1.time_ < var_496_6 + var_496_14 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play1106702121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1106702121
		arg_497_1.duration_ = 1

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"

			SetActive(arg_497_1.choicesGo_, true)

			for iter_498_0, iter_498_1 in ipairs(arg_497_1.choices_) do
				local var_498_0 = iter_498_0 <= 1

				SetActive(iter_498_1.go, var_498_0)
			end

			arg_497_1.choices_[1].txt.text = arg_497_1:FormatText(StoryChoiceCfg[378].name)
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1106702122(arg_497_1)
			end

			arg_497_1:RecordChoiceLog(1106702121, 378)
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.allBtn_.enabled = false
			end

			local var_500_1 = 0.5

			if arg_497_1.time_ >= var_500_0 + var_500_1 and arg_497_1.time_ < var_500_0 + var_500_1 + arg_500_0 then
				arg_497_1.allBtn_.enabled = true
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1106702122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1106702122
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1106702123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0
			local var_504_1 = 1.15

			if var_504_0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_2 = arg_501_1:GetWordFromCfg(1106702122)
				local var_504_3 = arg_501_1:FormatText(var_504_2.content)

				arg_501_1.text_.text = var_504_3

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_4 = 46
				local var_504_5 = utf8.len(var_504_3)
				local var_504_6 = var_504_4 <= 0 and var_504_1 or var_504_1 * (var_504_5 / var_504_4)

				if var_504_6 > 0 and var_504_1 < var_504_6 then
					arg_501_1.talkMaxDuration = var_504_6

					if var_504_6 + var_504_0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_6 + var_504_0
					end
				end

				arg_501_1.text_.text = var_504_3
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_7 = math.max(var_504_1, arg_501_1.talkMaxDuration)

			if var_504_0 <= arg_501_1.time_ and arg_501_1.time_ < var_504_0 + var_504_7 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_0) / var_504_7

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_0 + var_504_7 and arg_501_1.time_ < var_504_0 + var_504_7 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1106702123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1106702123
		arg_505_1.duration_ = 4.7

		local var_505_0 = {
			zh = 4.266,
			ja = 4.7
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1106702124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["1067ui_story"]
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1067ui_story == nil then
				arg_505_1.var_.characterEffect1067ui_story = var_508_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_2 = 0.2

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 and not isNil(var_508_0) then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2

				if arg_505_1.var_.characterEffect1067ui_story and not isNil(var_508_0) then
					arg_505_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1067ui_story then
				arg_505_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_508_4 = 0

			if var_508_4 < arg_505_1.time_ and arg_505_1.time_ <= var_508_4 + arg_508_0 then
				arg_505_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action472")
			end

			local var_508_5 = 0

			if var_508_5 < arg_505_1.time_ and arg_505_1.time_ <= var_508_5 + arg_508_0 then
				arg_505_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_508_6 = 0
			local var_508_7 = 0.4

			if var_508_6 < arg_505_1.time_ and arg_505_1.time_ <= var_508_6 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_8 = arg_505_1:FormatText(StoryNameCfg[206].name)

				arg_505_1.leftNameTxt_.text = var_508_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_9 = arg_505_1:GetWordFromCfg(1106702123)
				local var_508_10 = arg_505_1:FormatText(var_508_9.content)

				arg_505_1.text_.text = var_508_10

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_11 = 16
				local var_508_12 = utf8.len(var_508_10)
				local var_508_13 = var_508_11 <= 0 and var_508_7 or var_508_7 * (var_508_12 / var_508_11)

				if var_508_13 > 0 and var_508_7 < var_508_13 then
					arg_505_1.talkMaxDuration = var_508_13

					if var_508_13 + var_508_6 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_13 + var_508_6
					end
				end

				arg_505_1.text_.text = var_508_10
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702123", "story_v_side_new_1106702.awb") ~= 0 then
					local var_508_14 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702123", "story_v_side_new_1106702.awb") / 1000

					if var_508_14 + var_508_6 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_14 + var_508_6
					end

					if var_508_9.prefab_name ~= "" and arg_505_1.actors_[var_508_9.prefab_name] ~= nil then
						local var_508_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_9.prefab_name].transform, "story_v_side_new_1106702", "1106702123", "story_v_side_new_1106702.awb")

						arg_505_1:RecordAudio("1106702123", var_508_15)
						arg_505_1:RecordAudio("1106702123", var_508_15)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702123", "story_v_side_new_1106702.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702123", "story_v_side_new_1106702.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_16 = math.max(var_508_7, arg_505_1.talkMaxDuration)

			if var_508_6 <= arg_505_1.time_ and arg_505_1.time_ < var_508_6 + var_508_16 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_6) / var_508_16

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_6 + var_508_16 and arg_505_1.time_ < var_508_6 + var_508_16 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1106702124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1106702124
		arg_509_1.duration_ = 5.67

		local var_509_0 = {
			zh = 4.733,
			ja = 5.666
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1106702125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0

			if var_512_0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_512_1 = 0
			local var_512_2 = 0.6

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_3 = arg_509_1:FormatText(StoryNameCfg[206].name)

				arg_509_1.leftNameTxt_.text = var_512_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_4 = arg_509_1:GetWordFromCfg(1106702124)
				local var_512_5 = arg_509_1:FormatText(var_512_4.content)

				arg_509_1.text_.text = var_512_5

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_6 = 23
				local var_512_7 = utf8.len(var_512_5)
				local var_512_8 = var_512_6 <= 0 and var_512_2 or var_512_2 * (var_512_7 / var_512_6)

				if var_512_8 > 0 and var_512_2 < var_512_8 then
					arg_509_1.talkMaxDuration = var_512_8

					if var_512_8 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_8 + var_512_1
					end
				end

				arg_509_1.text_.text = var_512_5
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702124", "story_v_side_new_1106702.awb") ~= 0 then
					local var_512_9 = manager.audio:GetVoiceLength("story_v_side_new_1106702", "1106702124", "story_v_side_new_1106702.awb") / 1000

					if var_512_9 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_9 + var_512_1
					end

					if var_512_4.prefab_name ~= "" and arg_509_1.actors_[var_512_4.prefab_name] ~= nil then
						local var_512_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_4.prefab_name].transform, "story_v_side_new_1106702", "1106702124", "story_v_side_new_1106702.awb")

						arg_509_1:RecordAudio("1106702124", var_512_10)
						arg_509_1:RecordAudio("1106702124", var_512_10)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1106702", "1106702124", "story_v_side_new_1106702.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1106702", "1106702124", "story_v_side_new_1106702.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_11 = math.max(var_512_2, arg_509_1.talkMaxDuration)

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_11 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_1) / var_512_11

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_1 + var_512_11 and arg_509_1.time_ < var_512_1 + var_512_11 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1106702125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1106702125
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1106702126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = arg_513_1.actors_["1067ui_story"]
			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect1067ui_story == nil then
				arg_513_1.var_.characterEffect1067ui_story = var_516_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_2 = 0.2

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_2 and not isNil(var_516_0) then
				local var_516_3 = (arg_513_1.time_ - var_516_1) / var_516_2

				if arg_513_1.var_.characterEffect1067ui_story and not isNil(var_516_0) then
					local var_516_4 = Mathf.Lerp(0, 0.5, var_516_3)

					arg_513_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1067ui_story.fillRatio = var_516_4
				end
			end

			if arg_513_1.time_ >= var_516_1 + var_516_2 and arg_513_1.time_ < var_516_1 + var_516_2 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect1067ui_story then
				local var_516_5 = 0.5

				arg_513_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1067ui_story.fillRatio = var_516_5
			end

			local var_516_6 = 0
			local var_516_7 = 0.475

			if var_516_6 < arg_513_1.time_ and arg_513_1.time_ <= var_516_6 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_8 = arg_513_1:FormatText(StoryNameCfg[7].name)

				arg_513_1.leftNameTxt_.text = var_516_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_9 = arg_513_1:GetWordFromCfg(1106702125)
				local var_516_10 = arg_513_1:FormatText(var_516_9.content)

				arg_513_1.text_.text = var_516_10

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_11 = 19
				local var_516_12 = utf8.len(var_516_10)
				local var_516_13 = var_516_11 <= 0 and var_516_7 or var_516_7 * (var_516_12 / var_516_11)

				if var_516_13 > 0 and var_516_7 < var_516_13 then
					arg_513_1.talkMaxDuration = var_516_13

					if var_516_13 + var_516_6 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_13 + var_516_6
					end
				end

				arg_513_1.text_.text = var_516_10
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_14 = math.max(var_516_7, arg_513_1.talkMaxDuration)

			if var_516_6 <= arg_513_1.time_ and arg_513_1.time_ < var_516_6 + var_516_14 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_6) / var_516_14

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_6 + var_516_14 and arg_513_1.time_ < var_516_6 + var_516_14 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1106702126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1106702126
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
			arg_517_1.auto_ = false
		end

		function arg_517_1.playNext_(arg_519_0)
			arg_517_1.onStoryFinished_()
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action2_2")
			end

			local var_520_1 = 0
			local var_520_2 = 0.9

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_3 = arg_517_1:GetWordFromCfg(1106702126)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 36
				local var_520_6 = utf8.len(var_520_4)
				local var_520_7 = var_520_5 <= 0 and var_520_2 or var_520_2 * (var_520_6 / var_520_5)

				if var_520_7 > 0 and var_520_2 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_1
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_8 = math.max(var_520_2, arg_517_1.talkMaxDuration)

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_8 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_1) / var_520_8

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_1 + var_520_8 and arg_517_1.time_ < var_520_1 + var_520_8 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST24",
		"TextureConfig/Background/ST28",
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/ST25"
	},
	voices = {
		"story_v_side_new_1106702.awb"
	}
}
