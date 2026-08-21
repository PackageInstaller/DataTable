return {
	Play1105006001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1105006001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1105006002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST16"

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
				local var_4_5 = arg_1_1.bgs_.ST16

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
					if iter_4_0 ~= "ST16" then
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

			local var_4_24 = 0
			local var_4_25 = 0.200000002980232

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

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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

			local var_4_36 = 2
			local var_4_37 = 1.225

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

				local var_4_39 = arg_1_1:GetWordFromCfg(1105006001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 49
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
	Play1105006002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1105006002
		arg_9_1.duration_ = 2.23

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1105006003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "115001ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "115001ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "115001ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["115001ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos115001ui_story = var_12_5.localPosition

				local var_12_7 = "115001ui_story"

				arg_9_1:ShowWeapon(arg_9_1.var_[var_12_7 .. "Animator"].transform, false)
			end

			local var_12_8 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_6) / var_12_8
				local var_12_10 = Vector3.New(0, -1.033, -6.3)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos115001ui_story, var_12_10, var_12_9)

				local var_12_11 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_11.x, var_12_11.y, var_12_11.z)

				local var_12_12 = var_12_5.localEulerAngles

				var_12_12.z = 0
				var_12_12.x = 0
				var_12_5.localEulerAngles = var_12_12
			end

			if arg_9_1.time_ >= var_12_6 + var_12_8 and arg_9_1.time_ < var_12_6 + var_12_8 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_12_13 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_13.x, var_12_13.y, var_12_13.z)

				local var_12_14 = var_12_5.localEulerAngles

				var_12_14.z = 0
				var_12_14.x = 0
				var_12_5.localEulerAngles = var_12_14
			end

			local var_12_15 = arg_9_1.actors_["115001ui_story"]
			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect115001ui_story == nil then
				arg_9_1.var_.characterEffect115001ui_story = var_12_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_17 = 0.200000002980232

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 and not isNil(var_12_15) then
				local var_12_18 = (arg_9_1.time_ - var_12_16) / var_12_17

				if arg_9_1.var_.characterEffect115001ui_story and not isNil(var_12_15) then
					arg_9_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect115001ui_story then
				arg_9_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_21 = 0
			local var_12_22 = 0.3

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_23 = arg_9_1:FormatText(StoryNameCfg[74].name)

				arg_9_1.leftNameTxt_.text = var_12_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_24 = arg_9_1:GetWordFromCfg(1105006002)
				local var_12_25 = arg_9_1:FormatText(var_12_24.content)

				arg_9_1.text_.text = var_12_25

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_26 = 12
				local var_12_27 = utf8.len(var_12_25)
				local var_12_28 = var_12_26 <= 0 and var_12_22 or var_12_22 * (var_12_27 / var_12_26)

				if var_12_28 > 0 and var_12_22 < var_12_28 then
					arg_9_1.talkMaxDuration = var_12_28

					if var_12_28 + var_12_21 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_21
					end
				end

				arg_9_1.text_.text = var_12_25
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006002", "story_v_side_new_1105006.awb") ~= 0 then
					local var_12_29 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006002", "story_v_side_new_1105006.awb") / 1000

					if var_12_29 + var_12_21 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_29 + var_12_21
					end

					if var_12_24.prefab_name ~= "" and arg_9_1.actors_[var_12_24.prefab_name] ~= nil then
						local var_12_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_24.prefab_name].transform, "story_v_side_new_1105006", "1105006002", "story_v_side_new_1105006.awb")

						arg_9_1:RecordAudio("1105006002", var_12_30)
						arg_9_1:RecordAudio("1105006002", var_12_30)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006002", "story_v_side_new_1105006.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006002", "story_v_side_new_1105006.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_31 = math.max(var_12_22, arg_9_1.talkMaxDuration)

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_31 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_21) / var_12_31

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_21 + var_12_31 and arg_9_1.time_ < var_12_21 + var_12_31 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
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
	Play1105006003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1105006003
		arg_13_1.duration_ = 9.03

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1105006004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.95

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[74].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(1105006003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 38
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006003", "story_v_side_new_1105006.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006003", "story_v_side_new_1105006.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_side_new_1105006", "1105006003", "story_v_side_new_1105006.awb")

						arg_13_1:RecordAudio("1105006003", var_16_9)
						arg_13_1:RecordAudio("1105006003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006003", "story_v_side_new_1105006.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006003", "story_v_side_new_1105006.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1105006004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1105006004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1105006005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["115001ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect115001ui_story == nil then
				arg_17_1.var_.characterEffect115001ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect115001ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_17_1.var_.characterEffect115001ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect115001ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_17_1.var_.characterEffect115001ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.6

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(1105006004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 24
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1105006005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1105006005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1105006006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.35

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(1105006005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 14
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_8 and arg_21_1.time_ < var_24_0 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1105006006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1105006006
		arg_25_1.duration_ = 2.57

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1105006007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["115001ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect115001ui_story == nil then
				arg_25_1.var_.characterEffect115001ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect115001ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect115001ui_story then
				arg_25_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_2")
			end

			local var_28_5 = 0
			local var_28_6 = 0.175

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_7 = arg_25_1:FormatText(StoryNameCfg[74].name)

				arg_25_1.leftNameTxt_.text = var_28_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(1105006006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 7
				local var_28_11 = utf8.len(var_28_9)
				local var_28_12 = var_28_10 <= 0 and var_28_6 or var_28_6 * (var_28_11 / var_28_10)

				if var_28_12 > 0 and var_28_6 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006006", "story_v_side_new_1105006.awb") ~= 0 then
					local var_28_13 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006006", "story_v_side_new_1105006.awb") / 1000

					if var_28_13 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_5
					end

					if var_28_8.prefab_name ~= "" and arg_25_1.actors_[var_28_8.prefab_name] ~= nil then
						local var_28_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_8.prefab_name].transform, "story_v_side_new_1105006", "1105006006", "story_v_side_new_1105006.awb")

						arg_25_1:RecordAudio("1105006006", var_28_14)
						arg_25_1:RecordAudio("1105006006", var_28_14)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006006", "story_v_side_new_1105006.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006006", "story_v_side_new_1105006.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_15 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_15 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_15

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_15 and arg_25_1.time_ < var_28_5 + var_28_15 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1105006007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1105006007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1105006008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["115001ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos115001ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, 100, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos115001ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, 100, 0)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = 0
			local var_32_10 = 0.8

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_11 = arg_29_1:GetWordFromCfg(1105006007)
				local var_32_12 = arg_29_1:FormatText(var_32_11.content)

				arg_29_1.text_.text = var_32_12

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 32
				local var_32_14 = utf8.len(var_32_12)
				local var_32_15 = var_32_13 <= 0 and var_32_10 or var_32_10 * (var_32_14 / var_32_13)

				if var_32_15 > 0 and var_32_10 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_9 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_9
					end
				end

				arg_29_1.text_.text = var_32_12
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_10, arg_29_1.talkMaxDuration)

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_9) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_9 + var_32_16 and arg_29_1.time_ < var_32_9 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play1105006008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1105006008
		arg_33_1.duration_ = 5.07

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1105006009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["115001ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect115001ui_story == nil then
				arg_33_1.var_.characterEffect115001ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect115001ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect115001ui_story then
				arg_33_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["115001ui_story"].transform
			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.var_.moveOldPos115001ui_story = var_36_4.localPosition
			end

			local var_36_6 = 0.001

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6
				local var_36_8 = Vector3.New(0, -1.033, -6.3)

				var_36_4.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos115001ui_story, var_36_8, var_36_7)

				local var_36_9 = manager.ui.mainCamera.transform.position - var_36_4.position

				var_36_4.forward = Vector3.New(var_36_9.x, var_36_9.y, var_36_9.z)

				local var_36_10 = var_36_4.localEulerAngles

				var_36_10.z = 0
				var_36_10.x = 0
				var_36_4.localEulerAngles = var_36_10
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 then
				var_36_4.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_36_11 = manager.ui.mainCamera.transform.position - var_36_4.position

				var_36_4.forward = Vector3.New(var_36_11.x, var_36_11.y, var_36_11.z)

				local var_36_12 = var_36_4.localEulerAngles

				var_36_12.z = 0
				var_36_12.x = 0
				var_36_4.localEulerAngles = var_36_12
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_36_14 = 0
			local var_36_15 = 0.625

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_16 = arg_33_1:FormatText(StoryNameCfg[74].name)

				arg_33_1.leftNameTxt_.text = var_36_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_17 = arg_33_1:GetWordFromCfg(1105006008)
				local var_36_18 = arg_33_1:FormatText(var_36_17.content)

				arg_33_1.text_.text = var_36_18

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_19 = 25
				local var_36_20 = utf8.len(var_36_18)
				local var_36_21 = var_36_19 <= 0 and var_36_15 or var_36_15 * (var_36_20 / var_36_19)

				if var_36_21 > 0 and var_36_15 < var_36_21 then
					arg_33_1.talkMaxDuration = var_36_21

					if var_36_21 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_21 + var_36_14
					end
				end

				arg_33_1.text_.text = var_36_18
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006008", "story_v_side_new_1105006.awb") ~= 0 then
					local var_36_22 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006008", "story_v_side_new_1105006.awb") / 1000

					if var_36_22 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_14
					end

					if var_36_17.prefab_name ~= "" and arg_33_1.actors_[var_36_17.prefab_name] ~= nil then
						local var_36_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_17.prefab_name].transform, "story_v_side_new_1105006", "1105006008", "story_v_side_new_1105006.awb")

						arg_33_1:RecordAudio("1105006008", var_36_23)
						arg_33_1:RecordAudio("1105006008", var_36_23)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006008", "story_v_side_new_1105006.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006008", "story_v_side_new_1105006.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_24 = math.max(var_36_15, arg_33_1.talkMaxDuration)

			if var_36_14 <= arg_33_1.time_ and arg_33_1.time_ < var_36_14 + var_36_24 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_14) / var_36_24

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_14 + var_36_24 and arg_33_1.time_ < var_36_14 + var_36_24 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
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
	Play1105006009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1105006009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1105006010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["115001ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos115001ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, 100, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos115001ui_story, var_40_4, var_40_3)

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

			local var_40_9 = 0
			local var_40_10 = 0.175

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_11 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_12 = arg_37_1:GetWordFromCfg(1105006009)
				local var_40_13 = arg_37_1:FormatText(var_40_12.content)

				arg_37_1.text_.text = var_40_13

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_14 = 7
				local var_40_15 = utf8.len(var_40_13)
				local var_40_16 = var_40_14 <= 0 and var_40_10 or var_40_10 * (var_40_15 / var_40_14)

				if var_40_16 > 0 and var_40_10 < var_40_16 then
					arg_37_1.talkMaxDuration = var_40_16

					if var_40_16 + var_40_9 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_9
					end
				end

				arg_37_1.text_.text = var_40_13
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_17 = math.max(var_40_10, arg_37_1.talkMaxDuration)

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_17 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_9) / var_40_17

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_9 + var_40_17 and arg_37_1.time_ < var_40_9 + var_40_17 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
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
	Play1105006010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1105006010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1105006011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.275

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(1105006010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 51
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1105006011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1105006011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1105006012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.275

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(1105006011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 51
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1105006012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1105006012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1105006013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.3

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(1105006012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 52
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1105006013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1105006013
		arg_53_1.duration_ = 5.97

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1105006014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = manager.ui.mainCamera.transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				local var_56_2 = arg_53_1.var_.effect11
				local var_56_3
				local var_56_4 = var_56_0

				if not var_56_2 then
					var_56_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), var_56_4)
					var_56_2.name = "1"
					arg_53_1.var_.effect11 = var_56_2
				else
					var_56_2.transform:SetParent(var_56_4)
				end

				var_56_2.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_56_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_56_5 = manager.ui.mainCamera.transform
			local var_56_6 = 0

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_5.localPosition
			end

			local var_56_7 = 0.833333333333333

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_7 then
				local var_56_8 = (arg_53_1.time_ - var_56_6) / 0.066
				local var_56_9, var_56_10 = math.modf(var_56_8)

				var_56_5.localPosition = Vector3.New(var_56_10 * 0.13, var_56_10 * 0.13, var_56_10 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= var_56_6 + var_56_7 and arg_53_1.time_ < var_56_6 + var_56_7 + arg_56_0 then
				var_56_5.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_11 = 0.266666666666667
			local var_56_12 = 1

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				local var_56_13 = "play"
				local var_56_14 = "effect"

				arg_53_1:AudioAction(var_56_13, var_56_14, "se_story_side_1050", "se_story_side_1050_bamboo1", "")
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_15 = 0.966666666666667
			local var_56_16 = 0.95

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_17 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_17:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(1105006013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 38
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_16 or var_56_16 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_16 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22
					var_56_15 = var_56_15 + 0.3

					if var_56_22 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_23 = var_56_15 + 0.3
			local var_56_24 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_24 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_23) / var_56_24

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_23 + var_56_24 and arg_53_1.time_ < var_56_23 + var_56_24 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1105006014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1105006014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1105006015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.325

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[7].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(1105006014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 13
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_8 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_8 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_8

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_8 and arg_59_1.time_ < var_62_0 + var_62_8 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1105006015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1105006015
		arg_63_1.duration_ = 2

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1105006016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["115001ui_story"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos115001ui_story = var_66_0.localPosition
			end

			local var_66_2 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2
				local var_66_4 = Vector3.New(0, -1.033, -6.3)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos115001ui_story, var_66_4, var_66_3)

				local var_66_5 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_5.x, var_66_5.y, var_66_5.z)

				local var_66_6 = var_66_0.localEulerAngles

				var_66_6.z = 0
				var_66_6.x = 0
				var_66_0.localEulerAngles = var_66_6
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_66_7 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_7.x, var_66_7.y, var_66_7.z)

				local var_66_8 = var_66_0.localEulerAngles

				var_66_8.z = 0
				var_66_8.x = 0
				var_66_0.localEulerAngles = var_66_8
			end

			local var_66_9 = arg_63_1.actors_["115001ui_story"]
			local var_66_10 = 0

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 and not isNil(var_66_9) and arg_63_1.var_.characterEffect115001ui_story == nil then
				arg_63_1.var_.characterEffect115001ui_story = var_66_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_11 = 0.200000002980232

			if var_66_10 <= arg_63_1.time_ and arg_63_1.time_ < var_66_10 + var_66_11 and not isNil(var_66_9) then
				local var_66_12 = (arg_63_1.time_ - var_66_10) / var_66_11

				if arg_63_1.var_.characterEffect115001ui_story and not isNil(var_66_9) then
					arg_63_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_10 + var_66_11 and arg_63_1.time_ < var_66_10 + var_66_11 + arg_66_0 and not isNil(var_66_9) and arg_63_1.var_.characterEffect115001ui_story then
				arg_63_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_66_13 = 0

			if var_66_13 < arg_63_1.time_ and arg_63_1.time_ <= var_66_13 + arg_66_0 then
				arg_63_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			local var_66_14 = 0

			if var_66_14 < arg_63_1.time_ and arg_63_1.time_ <= var_66_14 + arg_66_0 then
				arg_63_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_66_15 = 0
			local var_66_16 = 0.275

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_17 = arg_63_1:FormatText(StoryNameCfg[74].name)

				arg_63_1.leftNameTxt_.text = var_66_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_18 = arg_63_1:GetWordFromCfg(1105006015)
				local var_66_19 = arg_63_1:FormatText(var_66_18.content)

				arg_63_1.text_.text = var_66_19

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_20 = 11
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

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006015", "story_v_side_new_1105006.awb") ~= 0 then
					local var_66_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006015", "story_v_side_new_1105006.awb") / 1000

					if var_66_23 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_15
					end

					if var_66_18.prefab_name ~= "" and arg_63_1.actors_[var_66_18.prefab_name] ~= nil then
						local var_66_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_18.prefab_name].transform, "story_v_side_new_1105006", "1105006015", "story_v_side_new_1105006.awb")

						arg_63_1:RecordAudio("1105006015", var_66_24)
						arg_63_1:RecordAudio("1105006015", var_66_24)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006015", "story_v_side_new_1105006.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006015", "story_v_side_new_1105006.awb")
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
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play1105006016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1105006016
		arg_67_1.duration_ = 4.43

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1105006017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.675

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[74].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(1105006016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 27
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006016", "story_v_side_new_1105006.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006016", "story_v_side_new_1105006.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_side_new_1105006", "1105006016", "story_v_side_new_1105006.awb")

						arg_67_1:RecordAudio("1105006016", var_70_9)
						arg_67_1:RecordAudio("1105006016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006016", "story_v_side_new_1105006.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006016", "story_v_side_new_1105006.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1105006017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1105006017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1105006018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["115001ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos115001ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, 100, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos115001ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, 100, 0)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = 0
			local var_74_10 = 0.975

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_11 = arg_71_1:GetWordFromCfg(1105006017)
				local var_74_12 = arg_71_1:FormatText(var_74_11.content)

				arg_71_1.text_.text = var_74_12

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 39
				local var_74_14 = utf8.len(var_74_12)
				local var_74_15 = var_74_13 <= 0 and var_74_10 or var_74_10 * (var_74_14 / var_74_13)

				if var_74_15 > 0 and var_74_10 < var_74_15 then
					arg_71_1.talkMaxDuration = var_74_15

					if var_74_15 + var_74_9 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_15 + var_74_9
					end
				end

				arg_71_1.text_.text = var_74_12
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_10, arg_71_1.talkMaxDuration)

			if var_74_9 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_9) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_9 + var_74_16 and arg_71_1.time_ < var_74_9 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
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
	Play1105006018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1105006018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1105006019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.8
			local var_78_1 = 1

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				local var_78_2 = "play"
				local var_78_3 = "effect"

				arg_75_1:AudioAction(var_78_2, var_78_3, "se_story_side_1050", "se_story_side_1050_bamboo2", "")
			end

			local var_78_4 = 0
			local var_78_5 = 1.825

			if var_78_4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_6 = arg_75_1:GetWordFromCfg(1105006018)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_8 = 73
				local var_78_9 = utf8.len(var_78_7)
				local var_78_10 = var_78_8 <= 0 and var_78_5 or var_78_5 * (var_78_9 / var_78_8)

				if var_78_10 > 0 and var_78_5 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_11 = math.max(var_78_5, arg_75_1.talkMaxDuration)

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_11 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_4) / var_78_11

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_4 + var_78_11 and arg_75_1.time_ < var_78_4 + var_78_11 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1105006019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1105006019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1105006020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.625

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[7].name)

				arg_79_1.leftNameTxt_.text = var_82_2

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

				local var_82_3 = arg_79_1:GetWordFromCfg(1105006019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 25
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_8 and arg_79_1.time_ < var_82_0 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1105006020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1105006020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1105006021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.275

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[7].name)

				arg_83_1.leftNameTxt_.text = var_86_2

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

				local var_86_3 = arg_83_1:GetWordFromCfg(1105006020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 11
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_8 and arg_83_1.time_ < var_86_0 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1105006021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1105006021
		arg_87_1.duration_ = 2.8

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1105006022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["115001ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos115001ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, -1.033, -6.3)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos115001ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = arg_87_1.actors_["115001ui_story"]
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect115001ui_story == nil then
				arg_87_1.var_.characterEffect115001ui_story = var_90_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_11 = 0.200000002980232

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 and not isNil(var_90_9) then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11

				if arg_87_1.var_.characterEffect115001ui_story and not isNil(var_90_9) then
					arg_87_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect115001ui_story then
				arg_87_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_90_13 = 0

			if var_90_13 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action6_1")
			end

			local var_90_14 = 0

			if var_90_14 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 then
				arg_87_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_90_15 = 0
			local var_90_16 = 0.25

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_17 = arg_87_1:FormatText(StoryNameCfg[74].name)

				arg_87_1.leftNameTxt_.text = var_90_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_18 = arg_87_1:GetWordFromCfg(1105006021)
				local var_90_19 = arg_87_1:FormatText(var_90_18.content)

				arg_87_1.text_.text = var_90_19

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_20 = 10
				local var_90_21 = utf8.len(var_90_19)
				local var_90_22 = var_90_20 <= 0 and var_90_16 or var_90_16 * (var_90_21 / var_90_20)

				if var_90_22 > 0 and var_90_16 < var_90_22 then
					arg_87_1.talkMaxDuration = var_90_22

					if var_90_22 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_22 + var_90_15
					end
				end

				arg_87_1.text_.text = var_90_19
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006021", "story_v_side_new_1105006.awb") ~= 0 then
					local var_90_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006021", "story_v_side_new_1105006.awb") / 1000

					if var_90_23 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_23 + var_90_15
					end

					if var_90_18.prefab_name ~= "" and arg_87_1.actors_[var_90_18.prefab_name] ~= nil then
						local var_90_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_18.prefab_name].transform, "story_v_side_new_1105006", "1105006021", "story_v_side_new_1105006.awb")

						arg_87_1:RecordAudio("1105006021", var_90_24)
						arg_87_1:RecordAudio("1105006021", var_90_24)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006021", "story_v_side_new_1105006.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006021", "story_v_side_new_1105006.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_25 = math.max(var_90_16, arg_87_1.talkMaxDuration)

			if var_90_15 <= arg_87_1.time_ and arg_87_1.time_ < var_90_15 + var_90_25 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_15) / var_90_25

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_15 + var_90_25 and arg_87_1.time_ < var_90_15 + var_90_25 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play1105006022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1105006022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1105006023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["115001ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos115001ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos115001ui_story, var_94_4, var_94_3)

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

			local var_94_9 = 0
			local var_94_10 = 0.625

			if var_94_9 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_11 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_11

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

				local var_94_12 = arg_91_1:GetWordFromCfg(1105006022)
				local var_94_13 = arg_91_1:FormatText(var_94_12.content)

				arg_91_1.text_.text = var_94_13

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_14 = 25
				local var_94_15 = utf8.len(var_94_13)
				local var_94_16 = var_94_14 <= 0 and var_94_10 or var_94_10 * (var_94_15 / var_94_14)

				if var_94_16 > 0 and var_94_10 < var_94_16 then
					arg_91_1.talkMaxDuration = var_94_16

					if var_94_16 + var_94_9 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_16 + var_94_9
					end
				end

				arg_91_1.text_.text = var_94_13
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_17 = math.max(var_94_10, arg_91_1.talkMaxDuration)

			if var_94_9 <= arg_91_1.time_ and arg_91_1.time_ < var_94_9 + var_94_17 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_9) / var_94_17

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_9 + var_94_17 and arg_91_1.time_ < var_94_9 + var_94_17 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play1105006023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1105006023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1105006024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 1.025

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_2 = arg_95_1:GetWordFromCfg(1105006023)
				local var_98_3 = arg_95_1:FormatText(var_98_2.content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 41
				local var_98_5 = utf8.len(var_98_3)
				local var_98_6 = var_98_4 <= 0 and var_98_1 or var_98_1 * (var_98_5 / var_98_4)

				if var_98_6 > 0 and var_98_1 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_7 and arg_95_1.time_ < var_98_0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1105006024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1105006024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1105006025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.4

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

				local var_102_2 = arg_99_1:GetWordFromCfg(1105006024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 56
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
	Play1105006025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1105006025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1105006026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.95

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

				local var_106_2 = arg_103_1:GetWordFromCfg(1105006025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 38
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
	Play1105006026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1105006026
		arg_107_1.duration_ = 6.67

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1105006027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["115001ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos115001ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(0, -1.033, -6.3)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos115001ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["115001ui_story"]
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect115001ui_story == nil then
				arg_107_1.var_.characterEffect115001ui_story = var_110_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_11 = 0.200000002980232

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 and not isNil(var_110_9) then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11

				if arg_107_1.var_.characterEffect115001ui_story and not isNil(var_110_9) then
					arg_107_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect115001ui_story then
				arg_107_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_110_13 = 0

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_110_14 = 0

			if var_110_14 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_110_15 = 0
			local var_110_16 = 0.6

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_17 = arg_107_1:FormatText(StoryNameCfg[74].name)

				arg_107_1.leftNameTxt_.text = var_110_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_18 = arg_107_1:GetWordFromCfg(1105006026)
				local var_110_19 = arg_107_1:FormatText(var_110_18.content)

				arg_107_1.text_.text = var_110_19

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_20 = 25
				local var_110_21 = utf8.len(var_110_19)
				local var_110_22 = var_110_20 <= 0 and var_110_16 or var_110_16 * (var_110_21 / var_110_20)

				if var_110_22 > 0 and var_110_16 < var_110_22 then
					arg_107_1.talkMaxDuration = var_110_22

					if var_110_22 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_22 + var_110_15
					end
				end

				arg_107_1.text_.text = var_110_19
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006026", "story_v_side_new_1105006.awb") ~= 0 then
					local var_110_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006026", "story_v_side_new_1105006.awb") / 1000

					if var_110_23 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_23 + var_110_15
					end

					if var_110_18.prefab_name ~= "" and arg_107_1.actors_[var_110_18.prefab_name] ~= nil then
						local var_110_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_18.prefab_name].transform, "story_v_side_new_1105006", "1105006026", "story_v_side_new_1105006.awb")

						arg_107_1:RecordAudio("1105006026", var_110_24)
						arg_107_1:RecordAudio("1105006026", var_110_24)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006026", "story_v_side_new_1105006.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006026", "story_v_side_new_1105006.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_25 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_25 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_15) / var_110_25

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_15 + var_110_25 and arg_107_1.time_ < var_110_15 + var_110_25 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play1105006027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1105006027
		arg_111_1.duration_ = 5.67

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1105006028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = manager.ui.mainCamera.transform
			local var_114_1 = 0.034000001847744

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				local var_114_2 = arg_111_1.var_.effect2
				local var_114_3
				local var_114_4 = var_114_0

				if not var_114_2 then
					var_114_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_114_4)
					var_114_2.name = "2"
					arg_111_1.var_.effect2 = var_114_2
				else
					var_114_2.transform:SetParent(var_114_4)
				end

				var_114_2.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_114_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_114_5 = manager.ui.mainCamera.transform
			local var_114_6 = 0.034000001847744

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.var_.shakeOldPos = var_114_5.localPosition
			end

			local var_114_7 = 0.466666666666667

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_7 then
				local var_114_8 = (arg_111_1.time_ - var_114_6) / 0.066
				local var_114_9, var_114_10 = math.modf(var_114_8)

				var_114_5.localPosition = Vector3.New(var_114_10 * 0.13, var_114_10 * 0.13, var_114_10 * 0.13) + arg_111_1.var_.shakeOldPos
			end

			if arg_111_1.time_ >= var_114_6 + var_114_7 and arg_111_1.time_ < var_114_6 + var_114_7 + arg_114_0 then
				var_114_5.localPosition = arg_111_1.var_.shakeOldPos
			end

			local var_114_11 = 0.266666666666667
			local var_114_12 = 1

			if var_114_11 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				local var_114_13 = "play"
				local var_114_14 = "music"

				arg_111_1:AudioAction(var_114_13, var_114_14, "se_story_side_1050", "se_story_side_1050_bamboo3", "")

				local var_114_15 = ""
				local var_114_16 = manager.audio:GetAudioName("se_story_side_1050", "se_story_side_1050_bamboo3")

				if var_114_16 ~= "" then
					if arg_111_1.bgmTxt_.text ~= var_114_16 and arg_111_1.bgmTxt_.text ~= "" then
						if arg_111_1.bgmTxt2_.text ~= "" then
							arg_111_1.bgmTxt_.text = arg_111_1.bgmTxt2_.text
						end

						arg_111_1.bgmTxt2_.text = var_114_16

						arg_111_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_111_1.bgmTxt_.text = var_114_16
						arg_111_1.bgmTxt2_.text = var_114_16
					end

					if arg_111_1.bgmTimer then
						arg_111_1.bgmTimer:Stop()

						arg_111_1.bgmTimer = nil
					end

					if arg_111_1.settingData.show_music_name == 1 then
						arg_111_1.musicController:SetSelectedState("show")
						arg_111_1.musicAnimator_:Play("open", 0, 0)

						if arg_111_1.settingData.music_time ~= 0 then
							arg_111_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_111_1.settingData.music_time), function()
								if arg_111_1 == nil or isNil(arg_111_1.bgmTxt_) then
									return
								end

								arg_111_1.musicController:SetSelectedState("hide")
								arg_111_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_114_17 = 0

			if var_114_17 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			local var_114_18 = 0.666666666666667

			if arg_111_1.time_ >= var_114_17 + var_114_18 and arg_111_1.time_ < var_114_17 + var_114_18 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_19 = arg_111_1.actors_["115001ui_story"].transform
			local var_114_20 = 0

			if var_114_20 < arg_111_1.time_ and arg_111_1.time_ <= var_114_20 + arg_114_0 then
				arg_111_1.var_.moveOldPos115001ui_story = var_114_19.localPosition
			end

			local var_114_21 = 0.001

			if var_114_20 <= arg_111_1.time_ and arg_111_1.time_ < var_114_20 + var_114_21 then
				local var_114_22 = (arg_111_1.time_ - var_114_20) / var_114_21
				local var_114_23 = Vector3.New(0, 100, 0)

				var_114_19.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos115001ui_story, var_114_23, var_114_22)

				local var_114_24 = manager.ui.mainCamera.transform.position - var_114_19.position

				var_114_19.forward = Vector3.New(var_114_24.x, var_114_24.y, var_114_24.z)

				local var_114_25 = var_114_19.localEulerAngles

				var_114_25.z = 0
				var_114_25.x = 0
				var_114_19.localEulerAngles = var_114_25
			end

			if arg_111_1.time_ >= var_114_20 + var_114_21 and arg_111_1.time_ < var_114_20 + var_114_21 + arg_114_0 then
				var_114_19.localPosition = Vector3.New(0, 100, 0)

				local var_114_26 = manager.ui.mainCamera.transform.position - var_114_19.position

				var_114_19.forward = Vector3.New(var_114_26.x, var_114_26.y, var_114_26.z)

				local var_114_27 = var_114_19.localEulerAngles

				var_114_27.z = 0
				var_114_27.x = 0
				var_114_19.localEulerAngles = var_114_27
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_28 = 0.666666666666667
			local var_114_29 = 1.5

			if var_114_28 < arg_111_1.time_ and arg_111_1.time_ <= var_114_28 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_30 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_30:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_111_1.dialogCg_.alpha = arg_116_0
				end))
				var_114_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_31 = arg_111_1:GetWordFromCfg(1105006027)
				local var_114_32 = arg_111_1:FormatText(var_114_31.content)

				arg_111_1.text_.text = var_114_32

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_33 = 60
				local var_114_34 = utf8.len(var_114_32)
				local var_114_35 = var_114_33 <= 0 and var_114_29 or var_114_29 * (var_114_34 / var_114_33)

				if var_114_35 > 0 and var_114_29 < var_114_35 then
					arg_111_1.talkMaxDuration = var_114_35
					var_114_28 = var_114_28 + 0.3

					if var_114_35 + var_114_28 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_35 + var_114_28
					end
				end

				arg_111_1.text_.text = var_114_32
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_36 = var_114_28 + 0.3
			local var_114_37 = math.max(var_114_29, arg_111_1.talkMaxDuration)

			if var_114_36 <= arg_111_1.time_ and arg_111_1.time_ < var_114_36 + var_114_37 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_36) / var_114_37

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_36 + var_114_37 and arg_111_1.time_ < var_114_36 + var_114_37 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
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
	Play1105006028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1105006028
		arg_118_1.duration_ = 2

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1105006029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["115001ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos115001ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(0, -1.033, -6.3)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos115001ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = arg_118_1.actors_["115001ui_story"]
			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect115001ui_story == nil then
				arg_118_1.var_.characterEffect115001ui_story = var_121_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_11 = 0.200000002980232

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_11 and not isNil(var_121_9) then
				local var_121_12 = (arg_118_1.time_ - var_121_10) / var_121_11

				if arg_118_1.var_.characterEffect115001ui_story and not isNil(var_121_9) then
					arg_118_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_10 + var_121_11 and arg_118_1.time_ < var_121_10 + var_121_11 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect115001ui_story then
				arg_118_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_121_13 = 0

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 then
				arg_118_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_121_14 = 0

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				arg_118_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_121_15 = 0
			local var_121_16 = 0.125

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_17 = arg_118_1:FormatText(StoryNameCfg[74].name)

				arg_118_1.leftNameTxt_.text = var_121_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:GetWordFromCfg(1105006028)
				local var_121_19 = arg_118_1:FormatText(var_121_18.content)

				arg_118_1.text_.text = var_121_19

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 5
				local var_121_21 = utf8.len(var_121_19)
				local var_121_22 = var_121_20 <= 0 and var_121_16 or var_121_16 * (var_121_21 / var_121_20)

				if var_121_22 > 0 and var_121_16 < var_121_22 then
					arg_118_1.talkMaxDuration = var_121_22

					if var_121_22 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_22 + var_121_15
					end
				end

				arg_118_1.text_.text = var_121_19
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006028", "story_v_side_new_1105006.awb") ~= 0 then
					local var_121_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006028", "story_v_side_new_1105006.awb") / 1000

					if var_121_23 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_15
					end

					if var_121_18.prefab_name ~= "" and arg_118_1.actors_[var_121_18.prefab_name] ~= nil then
						local var_121_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_18.prefab_name].transform, "story_v_side_new_1105006", "1105006028", "story_v_side_new_1105006.awb")

						arg_118_1:RecordAudio("1105006028", var_121_24)
						arg_118_1:RecordAudio("1105006028", var_121_24)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006028", "story_v_side_new_1105006.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006028", "story_v_side_new_1105006.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_25 = math.max(var_121_16, arg_118_1.talkMaxDuration)

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_25 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_15) / var_121_25

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_15 + var_121_25 and arg_118_1.time_ < var_121_15 + var_121_25 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play1105006029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1105006029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1105006030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["115001ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos115001ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(0, 100, 0)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos115001ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, 100, 0)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = 0
			local var_125_10 = 1.025

			if var_125_9 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_11 = arg_122_1:GetWordFromCfg(1105006029)
				local var_125_12 = arg_122_1:FormatText(var_125_11.content)

				arg_122_1.text_.text = var_125_12

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 41
				local var_125_14 = utf8.len(var_125_12)
				local var_125_15 = var_125_13 <= 0 and var_125_10 or var_125_10 * (var_125_14 / var_125_13)

				if var_125_15 > 0 and var_125_10 < var_125_15 then
					arg_122_1.talkMaxDuration = var_125_15

					if var_125_15 + var_125_9 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_15 + var_125_9
					end
				end

				arg_122_1.text_.text = var_125_12
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_10, arg_122_1.talkMaxDuration)

			if var_125_9 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_9) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_9 + var_125_16 and arg_122_1.time_ < var_125_9 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play1105006030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1105006030
		arg_126_1.duration_ = 5.47

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1105006031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = false

				arg_126_1:SetGaussion(false)
			end

			local var_129_1 = 0.333333333333333

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_1 then
				local var_129_2 = (arg_126_1.time_ - var_129_0) / var_129_1
				local var_129_3 = Color.New(1, 1, 1)

				var_129_3.a = Mathf.Lerp(1, 0, var_129_2)
				arg_126_1.mask_.color = var_129_3
			end

			if arg_126_1.time_ >= var_129_0 + var_129_1 and arg_126_1.time_ < var_129_0 + var_129_1 + arg_129_0 then
				local var_129_4 = Color.New(1, 1, 1)
				local var_129_5 = 0

				arg_126_1.mask_.enabled = false
				var_129_4.a = var_129_5
				arg_126_1.mask_.color = var_129_4
			end

			local var_129_6 = 3.4
			local var_129_7 = 1

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				local var_129_8 = "play"
				local var_129_9 = "effect"

				arg_126_1:AudioAction(var_129_8, var_129_9, "se_story_side_1050", "se_story_side_1050_fall", "")
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_10 = 0.466666666666667
			local var_129_11 = 1.2

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_12 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_12:setOnUpdate(LuaHelper.FloatAction(function(arg_130_0)
					arg_126_1.dialogCg_.alpha = arg_130_0
				end))
				var_129_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_13 = arg_126_1:GetWordFromCfg(1105006030)
				local var_129_14 = arg_126_1:FormatText(var_129_13.content)

				arg_126_1.text_.text = var_129_14

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_15 = 48
				local var_129_16 = utf8.len(var_129_14)
				local var_129_17 = var_129_15 <= 0 and var_129_11 or var_129_11 * (var_129_16 / var_129_15)

				if var_129_17 > 0 and var_129_11 < var_129_17 then
					arg_126_1.talkMaxDuration = var_129_17
					var_129_10 = var_129_10 + 0.3

					if var_129_17 + var_129_10 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_17 + var_129_10
					end
				end

				arg_126_1.text_.text = var_129_14
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_18 = var_129_10 + 0.3
			local var_129_19 = math.max(var_129_11, arg_126_1.talkMaxDuration)

			if var_129_18 <= arg_126_1.time_ and arg_126_1.time_ < var_129_18 + var_129_19 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_18) / var_129_19

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_18 + var_129_19 and arg_126_1.time_ < var_129_18 + var_129_19 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play1105006031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1105006031
		arg_132_1.duration_ = 3.67

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1105006032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["115001ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect115001ui_story == nil then
				arg_132_1.var_.characterEffect115001ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect115001ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect115001ui_story then
				arg_132_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_135_4 = 0

			if var_135_4 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_1")
			end

			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_135_6 = arg_132_1.actors_["115001ui_story"].transform
			local var_135_7 = 0

			if var_135_7 < arg_132_1.time_ and arg_132_1.time_ <= var_135_7 + arg_135_0 then
				arg_132_1.var_.moveOldPos115001ui_story = var_135_6.localPosition
			end

			local var_135_8 = 0.001

			if var_135_7 <= arg_132_1.time_ and arg_132_1.time_ < var_135_7 + var_135_8 then
				local var_135_9 = (arg_132_1.time_ - var_135_7) / var_135_8
				local var_135_10 = Vector3.New(0, -1.033, -6.3)

				var_135_6.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos115001ui_story, var_135_10, var_135_9)

				local var_135_11 = manager.ui.mainCamera.transform.position - var_135_6.position

				var_135_6.forward = Vector3.New(var_135_11.x, var_135_11.y, var_135_11.z)

				local var_135_12 = var_135_6.localEulerAngles

				var_135_12.z = 0
				var_135_12.x = 0
				var_135_6.localEulerAngles = var_135_12
			end

			if arg_132_1.time_ >= var_135_7 + var_135_8 and arg_132_1.time_ < var_135_7 + var_135_8 + arg_135_0 then
				var_135_6.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_135_13 = manager.ui.mainCamera.transform.position - var_135_6.position

				var_135_6.forward = Vector3.New(var_135_13.x, var_135_13.y, var_135_13.z)

				local var_135_14 = var_135_6.localEulerAngles

				var_135_14.z = 0
				var_135_14.x = 0
				var_135_6.localEulerAngles = var_135_14
			end

			local var_135_15 = 0
			local var_135_16 = 0.4

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_17 = arg_132_1:FormatText(StoryNameCfg[74].name)

				arg_132_1.leftNameTxt_.text = var_135_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_18 = arg_132_1:GetWordFromCfg(1105006031)
				local var_135_19 = arg_132_1:FormatText(var_135_18.content)

				arg_132_1.text_.text = var_135_19

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_20 = 16
				local var_135_21 = utf8.len(var_135_19)
				local var_135_22 = var_135_20 <= 0 and var_135_16 or var_135_16 * (var_135_21 / var_135_20)

				if var_135_22 > 0 and var_135_16 < var_135_22 then
					arg_132_1.talkMaxDuration = var_135_22

					if var_135_22 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_22 + var_135_15
					end
				end

				arg_132_1.text_.text = var_135_19
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006031", "story_v_side_new_1105006.awb") ~= 0 then
					local var_135_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006031", "story_v_side_new_1105006.awb") / 1000

					if var_135_23 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_23 + var_135_15
					end

					if var_135_18.prefab_name ~= "" and arg_132_1.actors_[var_135_18.prefab_name] ~= nil then
						local var_135_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_18.prefab_name].transform, "story_v_side_new_1105006", "1105006031", "story_v_side_new_1105006.awb")

						arg_132_1:RecordAudio("1105006031", var_135_24)
						arg_132_1:RecordAudio("1105006031", var_135_24)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006031", "story_v_side_new_1105006.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006031", "story_v_side_new_1105006.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_25 = math.max(var_135_16, arg_132_1.talkMaxDuration)

			if var_135_15 <= arg_132_1.time_ and arg_132_1.time_ < var_135_15 + var_135_25 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_15) / var_135_25

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_15 + var_135_25 and arg_132_1.time_ < var_135_15 + var_135_25 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
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
	Play1105006032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1105006032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1105006033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["115001ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos115001ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0, 100, 0)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos115001ui_story, var_139_4, var_139_3)

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

			local var_139_9 = 0
			local var_139_10 = 1.35

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_11 = arg_136_1:GetWordFromCfg(1105006032)
				local var_139_12 = arg_136_1:FormatText(var_139_11.content)

				arg_136_1.text_.text = var_139_12

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 54
				local var_139_14 = utf8.len(var_139_12)
				local var_139_15 = var_139_13 <= 0 and var_139_10 or var_139_10 * (var_139_14 / var_139_13)

				if var_139_15 > 0 and var_139_10 < var_139_15 then
					arg_136_1.talkMaxDuration = var_139_15

					if var_139_15 + var_139_9 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_15 + var_139_9
					end
				end

				arg_136_1.text_.text = var_139_12
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_10, arg_136_1.talkMaxDuration)

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_9) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_9 + var_139_16 and arg_136_1.time_ < var_139_9 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
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
	Play1105006033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1105006033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1105006034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.125

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(1105006033)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 5
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_8 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_8 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_8

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_8 and arg_140_1.time_ < var_143_0 + var_143_8 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1105006034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1105006034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1105006035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 1

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(1105006034)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 40
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
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_8 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_8 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_8

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_8 and arg_144_1.time_ < var_147_0 + var_147_8 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1105006035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1105006035
		arg_148_1.duration_ = 2

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1105006036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["115001ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos115001ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, -1.033, -6.3)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos115001ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = arg_148_1.actors_["115001ui_story"]
			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect115001ui_story == nil then
				arg_148_1.var_.characterEffect115001ui_story = var_151_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_11 = 0.200000002980232

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_11 and not isNil(var_151_9) then
				local var_151_12 = (arg_148_1.time_ - var_151_10) / var_151_11

				if arg_148_1.var_.characterEffect115001ui_story and not isNil(var_151_9) then
					arg_148_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_10 + var_151_11 and arg_148_1.time_ < var_151_10 + var_151_11 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect115001ui_story then
				arg_148_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_151_13 = 0

			if var_151_13 < arg_148_1.time_ and arg_148_1.time_ <= var_151_13 + arg_151_0 then
				arg_148_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_2")
			end

			local var_151_14 = 0

			if var_151_14 < arg_148_1.time_ and arg_148_1.time_ <= var_151_14 + arg_151_0 then
				arg_148_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_15 = 0
			local var_151_16 = 0.15

			if var_151_15 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_17 = arg_148_1:FormatText(StoryNameCfg[74].name)

				arg_148_1.leftNameTxt_.text = var_151_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_18 = arg_148_1:GetWordFromCfg(1105006035)
				local var_151_19 = arg_148_1:FormatText(var_151_18.content)

				arg_148_1.text_.text = var_151_19

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_20 = 6
				local var_151_21 = utf8.len(var_151_19)
				local var_151_22 = var_151_20 <= 0 and var_151_16 or var_151_16 * (var_151_21 / var_151_20)

				if var_151_22 > 0 and var_151_16 < var_151_22 then
					arg_148_1.talkMaxDuration = var_151_22

					if var_151_22 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_22 + var_151_15
					end
				end

				arg_148_1.text_.text = var_151_19
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006035", "story_v_side_new_1105006.awb") ~= 0 then
					local var_151_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006035", "story_v_side_new_1105006.awb") / 1000

					if var_151_23 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_15
					end

					if var_151_18.prefab_name ~= "" and arg_148_1.actors_[var_151_18.prefab_name] ~= nil then
						local var_151_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_18.prefab_name].transform, "story_v_side_new_1105006", "1105006035", "story_v_side_new_1105006.awb")

						arg_148_1:RecordAudio("1105006035", var_151_24)
						arg_148_1:RecordAudio("1105006035", var_151_24)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006035", "story_v_side_new_1105006.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006035", "story_v_side_new_1105006.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_25 = math.max(var_151_16, arg_148_1.talkMaxDuration)

			if var_151_15 <= arg_148_1.time_ and arg_148_1.time_ < var_151_15 + var_151_25 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_15) / var_151_25

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_15 + var_151_25 and arg_148_1.time_ < var_151_15 + var_151_25 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
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
	Play1105006036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1105006036
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1105006037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["115001ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect115001ui_story == nil then
				arg_152_1.var_.characterEffect115001ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect115001ui_story and not isNil(var_155_0) then
					local var_155_4 = Mathf.Lerp(0, 0.5, var_155_3)

					arg_152_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_152_1.var_.characterEffect115001ui_story.fillRatio = var_155_4
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect115001ui_story then
				local var_155_5 = 0.5

				arg_152_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_152_1.var_.characterEffect115001ui_story.fillRatio = var_155_5
			end

			local var_155_6 = 0
			local var_155_7 = 0.4

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_8 = arg_152_1:FormatText(StoryNameCfg[7].name)

				arg_152_1.leftNameTxt_.text = var_155_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_9 = arg_152_1:GetWordFromCfg(1105006036)
				local var_155_10 = arg_152_1:FormatText(var_155_9.content)

				arg_152_1.text_.text = var_155_10

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 16
				local var_155_12 = utf8.len(var_155_10)
				local var_155_13 = var_155_11 <= 0 and var_155_7 or var_155_7 * (var_155_12 / var_155_11)

				if var_155_13 > 0 and var_155_7 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_10
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_14 and arg_152_1.time_ < var_155_6 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1105006037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1105006037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1105006038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.275

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[7].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:GetWordFromCfg(1105006037)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 11
				local var_159_6 = utf8.len(var_159_4)
				local var_159_7 = var_159_5 <= 0 and var_159_1 or var_159_1 * (var_159_6 / var_159_5)

				if var_159_7 > 0 and var_159_1 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_8 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_8 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_8

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_8 and arg_156_1.time_ < var_159_0 + var_159_8 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play1105006038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1105006038
		arg_160_1.duration_ = 2.5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1105006039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["115001ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect115001ui_story == nil then
				arg_160_1.var_.characterEffect115001ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect115001ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect115001ui_story then
				arg_160_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_163_4 = 0

			if var_163_4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_163_5 = 0

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_163_6 = 0
			local var_163_7 = 0.25

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[74].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_9 = arg_160_1:GetWordFromCfg(1105006038)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 10
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006038", "story_v_side_new_1105006.awb") ~= 0 then
					local var_163_14 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006038", "story_v_side_new_1105006.awb") / 1000

					if var_163_14 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_14 + var_163_6
					end

					if var_163_9.prefab_name ~= "" and arg_160_1.actors_[var_163_9.prefab_name] ~= nil then
						local var_163_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_9.prefab_name].transform, "story_v_side_new_1105006", "1105006038", "story_v_side_new_1105006.awb")

						arg_160_1:RecordAudio("1105006038", var_163_15)
						arg_160_1:RecordAudio("1105006038", var_163_15)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006038", "story_v_side_new_1105006.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006038", "story_v_side_new_1105006.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_16 and arg_160_1.time_ < var_163_6 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play1105006039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1105006039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1105006040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["115001ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect115001ui_story == nil then
				arg_164_1.var_.characterEffect115001ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect115001ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_164_1.var_.characterEffect115001ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect115001ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_164_1.var_.characterEffect115001ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 1.3

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_8 = arg_164_1:GetWordFromCfg(1105006039)
				local var_167_9 = arg_164_1:FormatText(var_167_8.content)

				arg_164_1.text_.text = var_167_9

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_10 = 52
				local var_167_11 = utf8.len(var_167_9)
				local var_167_12 = var_167_10 <= 0 and var_167_7 or var_167_7 * (var_167_11 / var_167_10)

				if var_167_12 > 0 and var_167_7 < var_167_12 then
					arg_164_1.talkMaxDuration = var_167_12

					if var_167_12 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_12 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_9
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_13 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_13 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_13

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_13 and arg_164_1.time_ < var_167_6 + var_167_13 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play1105006040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1105006040
		arg_168_1.duration_ = 6.7

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1105006041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["115001ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect115001ui_story == nil then
				arg_168_1.var_.characterEffect115001ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect115001ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect115001ui_story then
				arg_168_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_171_4 = 0

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_171_5 = 0

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_171_6 = 0
			local var_171_7 = 0.9

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_8 = arg_168_1:FormatText(StoryNameCfg[74].name)

				arg_168_1.leftNameTxt_.text = var_171_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_9 = arg_168_1:GetWordFromCfg(1105006040)
				local var_171_10 = arg_168_1:FormatText(var_171_9.content)

				arg_168_1.text_.text = var_171_10

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 36
				local var_171_12 = utf8.len(var_171_10)
				local var_171_13 = var_171_11 <= 0 and var_171_7 or var_171_7 * (var_171_12 / var_171_11)

				if var_171_13 > 0 and var_171_7 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_10
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006040", "story_v_side_new_1105006.awb") ~= 0 then
					local var_171_14 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006040", "story_v_side_new_1105006.awb") / 1000

					if var_171_14 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_14 + var_171_6
					end

					if var_171_9.prefab_name ~= "" and arg_168_1.actors_[var_171_9.prefab_name] ~= nil then
						local var_171_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_9.prefab_name].transform, "story_v_side_new_1105006", "1105006040", "story_v_side_new_1105006.awb")

						arg_168_1:RecordAudio("1105006040", var_171_15)
						arg_168_1:RecordAudio("1105006040", var_171_15)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006040", "story_v_side_new_1105006.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006040", "story_v_side_new_1105006.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_16 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_16 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_16

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_16 and arg_168_1.time_ < var_171_6 + var_171_16 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1105006041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1105006041
		arg_172_1.duration_ = 6.7

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1105006042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.9

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[74].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:GetWordFromCfg(1105006041)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 36
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006041", "story_v_side_new_1105006.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006041", "story_v_side_new_1105006.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_side_new_1105006", "1105006041", "story_v_side_new_1105006.awb")

						arg_172_1:RecordAudio("1105006041", var_175_9)
						arg_172_1:RecordAudio("1105006041", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006041", "story_v_side_new_1105006.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006041", "story_v_side_new_1105006.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_10 and arg_172_1.time_ < var_175_0 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play1105006042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1105006042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1105006043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["115001ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect115001ui_story == nil then
				arg_176_1.var_.characterEffect115001ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect115001ui_story and not isNil(var_179_0) then
					local var_179_4 = Mathf.Lerp(0, 0.5, var_179_3)

					arg_176_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_176_1.var_.characterEffect115001ui_story.fillRatio = var_179_4
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect115001ui_story then
				local var_179_5 = 0.5

				arg_176_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_176_1.var_.characterEffect115001ui_story.fillRatio = var_179_5
			end

			local var_179_6 = 0
			local var_179_7 = 0.975

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_8 = arg_176_1:FormatText(StoryNameCfg[7].name)

				arg_176_1.leftNameTxt_.text = var_179_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_9 = arg_176_1:GetWordFromCfg(1105006042)
				local var_179_10 = arg_176_1:FormatText(var_179_9.content)

				arg_176_1.text_.text = var_179_10

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_11 = 39
				local var_179_12 = utf8.len(var_179_10)
				local var_179_13 = var_179_11 <= 0 and var_179_7 or var_179_7 * (var_179_12 / var_179_11)

				if var_179_13 > 0 and var_179_7 < var_179_13 then
					arg_176_1.talkMaxDuration = var_179_13

					if var_179_13 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_6
					end
				end

				arg_176_1.text_.text = var_179_10
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_14 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_14 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_14

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_14 and arg_176_1.time_ < var_179_6 + var_179_14 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1105006043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1105006043
		arg_180_1.duration_ = 2.63

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1105006044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["115001ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect115001ui_story == nil then
				arg_180_1.var_.characterEffect115001ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect115001ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect115001ui_story then
				arg_180_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_183_4 = 0

			if var_183_4 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_183_5 = 0
			local var_183_6 = 0.325

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_7 = arg_180_1:FormatText(StoryNameCfg[74].name)

				arg_180_1.leftNameTxt_.text = var_183_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_8 = arg_180_1:GetWordFromCfg(1105006043)
				local var_183_9 = arg_180_1:FormatText(var_183_8.content)

				arg_180_1.text_.text = var_183_9

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_10 = 13
				local var_183_11 = utf8.len(var_183_9)
				local var_183_12 = var_183_10 <= 0 and var_183_6 or var_183_6 * (var_183_11 / var_183_10)

				if var_183_12 > 0 and var_183_6 < var_183_12 then
					arg_180_1.talkMaxDuration = var_183_12

					if var_183_12 + var_183_5 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_12 + var_183_5
					end
				end

				arg_180_1.text_.text = var_183_9
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006043", "story_v_side_new_1105006.awb") ~= 0 then
					local var_183_13 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006043", "story_v_side_new_1105006.awb") / 1000

					if var_183_13 + var_183_5 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_5
					end

					if var_183_8.prefab_name ~= "" and arg_180_1.actors_[var_183_8.prefab_name] ~= nil then
						local var_183_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_8.prefab_name].transform, "story_v_side_new_1105006", "1105006043", "story_v_side_new_1105006.awb")

						arg_180_1:RecordAudio("1105006043", var_183_14)
						arg_180_1:RecordAudio("1105006043", var_183_14)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006043", "story_v_side_new_1105006.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006043", "story_v_side_new_1105006.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_15 = math.max(var_183_6, arg_180_1.talkMaxDuration)

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_15 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_5) / var_183_15

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_5 + var_183_15 and arg_180_1.time_ < var_183_5 + var_183_15 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play1105006044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1105006044
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1105006045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["115001ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect115001ui_story == nil then
				arg_184_1.var_.characterEffect115001ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect115001ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_184_1.var_.characterEffect115001ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect115001ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_184_1.var_.characterEffect115001ui_story.fillRatio = var_187_5
			end

			local var_187_6 = 0
			local var_187_7 = 0.65

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_8 = arg_184_1:FormatText(StoryNameCfg[7].name)

				arg_184_1.leftNameTxt_.text = var_187_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_9 = arg_184_1:GetWordFromCfg(1105006044)
				local var_187_10 = arg_184_1:FormatText(var_187_9.content)

				arg_184_1.text_.text = var_187_10

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 26
				local var_187_12 = utf8.len(var_187_10)
				local var_187_13 = var_187_11 <= 0 and var_187_7 or var_187_7 * (var_187_12 / var_187_11)

				if var_187_13 > 0 and var_187_7 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_6
					end
				end

				arg_184_1.text_.text = var_187_10
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_14 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_14 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_14

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_14 and arg_184_1.time_ < var_187_6 + var_187_14 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1105006045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1105006045
		arg_188_1.duration_ = 2

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1105006046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["115001ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect115001ui_story == nil then
				arg_188_1.var_.characterEffect115001ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect115001ui_story and not isNil(var_191_0) then
					arg_188_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect115001ui_story then
				arg_188_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_191_4 = 0

			if var_191_4 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				arg_188_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_191_5 = 0
			local var_191_6 = 0.1

			if var_191_5 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_7 = arg_188_1:FormatText(StoryNameCfg[74].name)

				arg_188_1.leftNameTxt_.text = var_191_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_8 = arg_188_1:GetWordFromCfg(1105006045)
				local var_191_9 = arg_188_1:FormatText(var_191_8.content)

				arg_188_1.text_.text = var_191_9

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_10 = 4
				local var_191_11 = utf8.len(var_191_9)
				local var_191_12 = var_191_10 <= 0 and var_191_6 or var_191_6 * (var_191_11 / var_191_10)

				if var_191_12 > 0 and var_191_6 < var_191_12 then
					arg_188_1.talkMaxDuration = var_191_12

					if var_191_12 + var_191_5 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_12 + var_191_5
					end
				end

				arg_188_1.text_.text = var_191_9
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006045", "story_v_side_new_1105006.awb") ~= 0 then
					local var_191_13 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006045", "story_v_side_new_1105006.awb") / 1000

					if var_191_13 + var_191_5 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_5
					end

					if var_191_8.prefab_name ~= "" and arg_188_1.actors_[var_191_8.prefab_name] ~= nil then
						local var_191_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_8.prefab_name].transform, "story_v_side_new_1105006", "1105006045", "story_v_side_new_1105006.awb")

						arg_188_1:RecordAudio("1105006045", var_191_14)
						arg_188_1:RecordAudio("1105006045", var_191_14)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006045", "story_v_side_new_1105006.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006045", "story_v_side_new_1105006.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_15 = math.max(var_191_6, arg_188_1.talkMaxDuration)

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_15 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_5) / var_191_15

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_5 + var_191_15 and arg_188_1.time_ < var_191_5 + var_191_15 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1105006046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1105006046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1105006047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["115001ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos115001ui_story = var_195_0.localPosition
			end

			local var_195_2 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2
				local var_195_4 = Vector3.New(0, 100, 0)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos115001ui_story, var_195_4, var_195_3)

				local var_195_5 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_5.x, var_195_5.y, var_195_5.z)

				local var_195_6 = var_195_0.localEulerAngles

				var_195_6.z = 0
				var_195_6.x = 0
				var_195_0.localEulerAngles = var_195_6
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0, 100, 0)

				local var_195_7 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_7.x, var_195_7.y, var_195_7.z)

				local var_195_8 = var_195_0.localEulerAngles

				var_195_8.z = 0
				var_195_8.x = 0
				var_195_0.localEulerAngles = var_195_8
			end

			local var_195_9 = 0
			local var_195_10 = 0.8

			if var_195_9 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_11 = arg_192_1:GetWordFromCfg(1105006046)
				local var_195_12 = arg_192_1:FormatText(var_195_11.content)

				arg_192_1.text_.text = var_195_12

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_13 = 32
				local var_195_14 = utf8.len(var_195_12)
				local var_195_15 = var_195_13 <= 0 and var_195_10 or var_195_10 * (var_195_14 / var_195_13)

				if var_195_15 > 0 and var_195_10 < var_195_15 then
					arg_192_1.talkMaxDuration = var_195_15

					if var_195_15 + var_195_9 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_15 + var_195_9
					end
				end

				arg_192_1.text_.text = var_195_12
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_16 = math.max(var_195_10, arg_192_1.talkMaxDuration)

			if var_195_9 <= arg_192_1.time_ and arg_192_1.time_ < var_195_9 + var_195_16 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_9) / var_195_16

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_9 + var_195_16 and arg_192_1.time_ < var_195_9 + var_195_16 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play1105006047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1105006047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1105006048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.925

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_2 = arg_196_1:GetWordFromCfg(1105006047)
				local var_199_3 = arg_196_1:FormatText(var_199_2.content)

				arg_196_1.text_.text = var_199_3

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 37
				local var_199_5 = utf8.len(var_199_3)
				local var_199_6 = var_199_4 <= 0 and var_199_1 or var_199_1 * (var_199_5 / var_199_4)

				if var_199_6 > 0 and var_199_1 < var_199_6 then
					arg_196_1.talkMaxDuration = var_199_6

					if var_199_6 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_6 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_3
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_7 and arg_196_1.time_ < var_199_0 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play1105006048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1105006048
		arg_200_1.duration_ = 5.13

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1105006049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["115001ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect115001ui_story == nil then
				arg_200_1.var_.characterEffect115001ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect115001ui_story and not isNil(var_203_0) then
					arg_200_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect115001ui_story then
				arg_200_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_203_4 = 0

			if var_203_4 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_203_5 = arg_200_1.actors_["115001ui_story"].transform
			local var_203_6 = 0

			if var_203_6 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.var_.moveOldPos115001ui_story = var_203_5.localPosition
			end

			local var_203_7 = 0.001

			if var_203_6 <= arg_200_1.time_ and arg_200_1.time_ < var_203_6 + var_203_7 then
				local var_203_8 = (arg_200_1.time_ - var_203_6) / var_203_7
				local var_203_9 = Vector3.New(0, -1.033, -6.3)

				var_203_5.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos115001ui_story, var_203_9, var_203_8)

				local var_203_10 = manager.ui.mainCamera.transform.position - var_203_5.position

				var_203_5.forward = Vector3.New(var_203_10.x, var_203_10.y, var_203_10.z)

				local var_203_11 = var_203_5.localEulerAngles

				var_203_11.z = 0
				var_203_11.x = 0
				var_203_5.localEulerAngles = var_203_11
			end

			if arg_200_1.time_ >= var_203_6 + var_203_7 and arg_200_1.time_ < var_203_6 + var_203_7 + arg_203_0 then
				var_203_5.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_203_12 = manager.ui.mainCamera.transform.position - var_203_5.position

				var_203_5.forward = Vector3.New(var_203_12.x, var_203_12.y, var_203_12.z)

				local var_203_13 = var_203_5.localEulerAngles

				var_203_13.z = 0
				var_203_13.x = 0
				var_203_5.localEulerAngles = var_203_13
			end

			local var_203_14 = 0
			local var_203_15 = 0.475

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_16 = arg_200_1:FormatText(StoryNameCfg[74].name)

				arg_200_1.leftNameTxt_.text = var_203_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_17 = arg_200_1:GetWordFromCfg(1105006048)
				local var_203_18 = arg_200_1:FormatText(var_203_17.content)

				arg_200_1.text_.text = var_203_18

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_19 = 19
				local var_203_20 = utf8.len(var_203_18)
				local var_203_21 = var_203_19 <= 0 and var_203_15 or var_203_15 * (var_203_20 / var_203_19)

				if var_203_21 > 0 and var_203_15 < var_203_21 then
					arg_200_1.talkMaxDuration = var_203_21

					if var_203_21 + var_203_14 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_21 + var_203_14
					end
				end

				arg_200_1.text_.text = var_203_18
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006048", "story_v_side_new_1105006.awb") ~= 0 then
					local var_203_22 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006048", "story_v_side_new_1105006.awb") / 1000

					if var_203_22 + var_203_14 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_22 + var_203_14
					end

					if var_203_17.prefab_name ~= "" and arg_200_1.actors_[var_203_17.prefab_name] ~= nil then
						local var_203_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_17.prefab_name].transform, "story_v_side_new_1105006", "1105006048", "story_v_side_new_1105006.awb")

						arg_200_1:RecordAudio("1105006048", var_203_23)
						arg_200_1:RecordAudio("1105006048", var_203_23)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006048", "story_v_side_new_1105006.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006048", "story_v_side_new_1105006.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_24 = math.max(var_203_15, arg_200_1.talkMaxDuration)

			if var_203_14 <= arg_200_1.time_ and arg_200_1.time_ < var_203_14 + var_203_24 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_14) / var_203_24

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_14 + var_203_24 and arg_200_1.time_ < var_203_14 + var_203_24 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play1105006049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1105006049
		arg_204_1.duration_ = 8.73

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1105006050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.9

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[74].name)

				arg_204_1.leftNameTxt_.text = var_207_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_3 = arg_204_1:GetWordFromCfg(1105006049)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 36
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006049", "story_v_side_new_1105006.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006049", "story_v_side_new_1105006.awb") / 1000

					if var_207_8 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_0
					end

					if var_207_3.prefab_name ~= "" and arg_204_1.actors_[var_207_3.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_3.prefab_name].transform, "story_v_side_new_1105006", "1105006049", "story_v_side_new_1105006.awb")

						arg_204_1:RecordAudio("1105006049", var_207_9)
						arg_204_1:RecordAudio("1105006049", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006049", "story_v_side_new_1105006.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006049", "story_v_side_new_1105006.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_10 and arg_204_1.time_ < var_207_0 + var_207_10 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play1105006050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1105006050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1105006051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["115001ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect115001ui_story == nil then
				arg_208_1.var_.characterEffect115001ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect115001ui_story and not isNil(var_211_0) then
					local var_211_4 = Mathf.Lerp(0, 0.5, var_211_3)

					arg_208_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_208_1.var_.characterEffect115001ui_story.fillRatio = var_211_4
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect115001ui_story then
				local var_211_5 = 0.5

				arg_208_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_208_1.var_.characterEffect115001ui_story.fillRatio = var_211_5
			end

			local var_211_6 = 0
			local var_211_7 = 1.225

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_8 = arg_208_1:FormatText(StoryNameCfg[7].name)

				arg_208_1.leftNameTxt_.text = var_211_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_9 = arg_208_1:GetWordFromCfg(1105006050)
				local var_211_10 = arg_208_1:FormatText(var_211_9.content)

				arg_208_1.text_.text = var_211_10

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_11 = 49
				local var_211_12 = utf8.len(var_211_10)
				local var_211_13 = var_211_11 <= 0 and var_211_7 or var_211_7 * (var_211_12 / var_211_11)

				if var_211_13 > 0 and var_211_7 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13

					if var_211_13 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_10
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_14 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_14 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_14

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_14 and arg_208_1.time_ < var_211_6 + var_211_14 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play1105006051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1105006051
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1105006052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 1.05

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[7].name)

				arg_212_1.leftNameTxt_.text = var_215_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_3 = arg_212_1:GetWordFromCfg(1105006051)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 42
				local var_215_6 = utf8.len(var_215_4)
				local var_215_7 = var_215_5 <= 0 and var_215_1 or var_215_1 * (var_215_6 / var_215_5)

				if var_215_7 > 0 and var_215_1 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_4
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_8 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_8 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_8

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_8 and arg_212_1.time_ < var_215_0 + var_215_8 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play1105006052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1105006052
		arg_216_1.duration_ = 3.17

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1105006053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["115001ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect115001ui_story == nil then
				arg_216_1.var_.characterEffect115001ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect115001ui_story and not isNil(var_219_0) then
					arg_216_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect115001ui_story then
				arg_216_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_219_4 = 0

			if var_219_4 < arg_216_1.time_ and arg_216_1.time_ <= var_219_4 + arg_219_0 then
				arg_216_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_219_5 = 0
			local var_219_6 = 0.325

			if var_219_5 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_7 = arg_216_1:FormatText(StoryNameCfg[74].name)

				arg_216_1.leftNameTxt_.text = var_219_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_8 = arg_216_1:GetWordFromCfg(1105006052)
				local var_219_9 = arg_216_1:FormatText(var_219_8.content)

				arg_216_1.text_.text = var_219_9

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_10 = 13
				local var_219_11 = utf8.len(var_219_9)
				local var_219_12 = var_219_10 <= 0 and var_219_6 or var_219_6 * (var_219_11 / var_219_10)

				if var_219_12 > 0 and var_219_6 < var_219_12 then
					arg_216_1.talkMaxDuration = var_219_12

					if var_219_12 + var_219_5 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_12 + var_219_5
					end
				end

				arg_216_1.text_.text = var_219_9
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006052", "story_v_side_new_1105006.awb") ~= 0 then
					local var_219_13 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006052", "story_v_side_new_1105006.awb") / 1000

					if var_219_13 + var_219_5 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_5
					end

					if var_219_8.prefab_name ~= "" and arg_216_1.actors_[var_219_8.prefab_name] ~= nil then
						local var_219_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_8.prefab_name].transform, "story_v_side_new_1105006", "1105006052", "story_v_side_new_1105006.awb")

						arg_216_1:RecordAudio("1105006052", var_219_14)
						arg_216_1:RecordAudio("1105006052", var_219_14)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006052", "story_v_side_new_1105006.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006052", "story_v_side_new_1105006.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_15 = math.max(var_219_6, arg_216_1.talkMaxDuration)

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_15 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_5) / var_219_15

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_5 + var_219_15 and arg_216_1.time_ < var_219_5 + var_219_15 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play1105006053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 1105006053
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play1105006054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["115001ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect115001ui_story == nil then
				arg_220_1.var_.characterEffect115001ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect115001ui_story and not isNil(var_223_0) then
					local var_223_4 = Mathf.Lerp(0, 0.5, var_223_3)

					arg_220_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_220_1.var_.characterEffect115001ui_story.fillRatio = var_223_4
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect115001ui_story then
				local var_223_5 = 0.5

				arg_220_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_220_1.var_.characterEffect115001ui_story.fillRatio = var_223_5
			end

			local var_223_6 = 0
			local var_223_7 = 0.25

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_8 = arg_220_1:FormatText(StoryNameCfg[7].name)

				arg_220_1.leftNameTxt_.text = var_223_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_9 = arg_220_1:GetWordFromCfg(1105006053)
				local var_223_10 = arg_220_1:FormatText(var_223_9.content)

				arg_220_1.text_.text = var_223_10

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 10
				local var_223_12 = utf8.len(var_223_10)
				local var_223_13 = var_223_11 <= 0 and var_223_7 or var_223_7 * (var_223_12 / var_223_11)

				if var_223_13 > 0 and var_223_7 < var_223_13 then
					arg_220_1.talkMaxDuration = var_223_13

					if var_223_13 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_13 + var_223_6
					end
				end

				arg_220_1.text_.text = var_223_10
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_14 = math.max(var_223_7, arg_220_1.talkMaxDuration)

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_14 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_6) / var_223_14

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_6 + var_223_14 and arg_220_1.time_ < var_223_6 + var_223_14 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play1105006054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 1105006054
		arg_224_1.duration_ = 1

		SetActive(arg_224_1.tipsGo_, true)

		arg_224_1.tipsText_.text = StoryTipsCfg[105001].name

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"

			SetActive(arg_224_1.choicesGo_, true)

			for iter_225_0, iter_225_1 in ipairs(arg_224_1.choices_) do
				local var_225_0 = iter_225_0 <= 2

				SetActive(iter_225_1.go, var_225_0)
			end

			arg_224_1.choices_[1].txt.text = arg_224_1:FormatText(StoryChoiceCfg[1064].name)
			arg_224_1.choices_[2].txt.text = arg_224_1:FormatText(StoryChoiceCfg[1065].name)
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				PlayerAction.UseStoryTrigger(1050012, 210500106, 1105006054, 1)
				arg_224_0:Play1105006055(arg_224_1)
			end

			if arg_226_0 == 2 then
				arg_224_0:Play1105006057(arg_224_1)
			end

			arg_224_1:RecordChoiceLog(1105006054, 1064, 1065)
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			return
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play1105006055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1105006055
		arg_228_1.duration_ = 5.5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1105006056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["115001ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect115001ui_story == nil then
				arg_228_1.var_.characterEffect115001ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect115001ui_story and not isNil(var_231_0) then
					arg_228_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect115001ui_story then
				arg_228_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_231_4 = 0

			if var_231_4 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_231_5 = 0

			if var_231_5 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 then
				arg_228_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_231_6 = 0
			local var_231_7 = 0.35

			if var_231_6 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_8 = arg_228_1:FormatText(StoryNameCfg[74].name)

				arg_228_1.leftNameTxt_.text = var_231_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_9 = arg_228_1:GetWordFromCfg(1105006055)
				local var_231_10 = arg_228_1:FormatText(var_231_9.content)

				arg_228_1.text_.text = var_231_10

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 14
				local var_231_12 = utf8.len(var_231_10)
				local var_231_13 = var_231_11 <= 0 and var_231_7 or var_231_7 * (var_231_12 / var_231_11)

				if var_231_13 > 0 and var_231_7 < var_231_13 then
					arg_228_1.talkMaxDuration = var_231_13

					if var_231_13 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_13 + var_231_6
					end
				end

				arg_228_1.text_.text = var_231_10
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006055", "story_v_side_new_1105006.awb") ~= 0 then
					local var_231_14 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006055", "story_v_side_new_1105006.awb") / 1000

					if var_231_14 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_14 + var_231_6
					end

					if var_231_9.prefab_name ~= "" and arg_228_1.actors_[var_231_9.prefab_name] ~= nil then
						local var_231_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_9.prefab_name].transform, "story_v_side_new_1105006", "1105006055", "story_v_side_new_1105006.awb")

						arg_228_1:RecordAudio("1105006055", var_231_15)
						arg_228_1:RecordAudio("1105006055", var_231_15)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006055", "story_v_side_new_1105006.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006055", "story_v_side_new_1105006.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_16 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_16 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_16

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_16 and arg_228_1.time_ < var_231_6 + var_231_16 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play1105006056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1105006056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1105006057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["115001ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos115001ui_story = var_235_0.localPosition
			end

			local var_235_2 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2
				local var_235_4 = Vector3.New(0, 100, 0)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos115001ui_story, var_235_4, var_235_3)

				local var_235_5 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_5.x, var_235_5.y, var_235_5.z)

				local var_235_6 = var_235_0.localEulerAngles

				var_235_6.z = 0
				var_235_6.x = 0
				var_235_0.localEulerAngles = var_235_6
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, 100, 0)

				local var_235_7 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_7.x, var_235_7.y, var_235_7.z)

				local var_235_8 = var_235_0.localEulerAngles

				var_235_8.z = 0
				var_235_8.x = 0
				var_235_0.localEulerAngles = var_235_8
			end

			local var_235_9 = 0
			local var_235_10 = 0.225

			if var_235_9 < arg_232_1.time_ and arg_232_1.time_ <= var_235_9 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_11 = arg_232_1:FormatText(StoryNameCfg[7].name)

				arg_232_1.leftNameTxt_.text = var_235_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_12 = arg_232_1:GetWordFromCfg(1105006056)
				local var_235_13 = arg_232_1:FormatText(var_235_12.content)

				arg_232_1.text_.text = var_235_13

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_14 = 9
				local var_235_15 = utf8.len(var_235_13)
				local var_235_16 = var_235_14 <= 0 and var_235_10 or var_235_10 * (var_235_15 / var_235_14)

				if var_235_16 > 0 and var_235_10 < var_235_16 then
					arg_232_1.talkMaxDuration = var_235_16

					if var_235_16 + var_235_9 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_16 + var_235_9
					end
				end

				arg_232_1.text_.text = var_235_13
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_17 = math.max(var_235_10, arg_232_1.talkMaxDuration)

			if var_235_9 <= arg_232_1.time_ and arg_232_1.time_ < var_235_9 + var_235_17 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_9) / var_235_17

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_9 + var_235_17 and arg_232_1.time_ < var_235_9 + var_235_17 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play1105006057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1105006057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1105006058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["115001ui_story"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos115001ui_story = var_239_0.localPosition
			end

			local var_239_2 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2
				local var_239_4 = Vector3.New(0, 100, 0)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos115001ui_story, var_239_4, var_239_3)

				local var_239_5 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_5.x, var_239_5.y, var_239_5.z)

				local var_239_6 = var_239_0.localEulerAngles

				var_239_6.z = 0
				var_239_6.x = 0
				var_239_0.localEulerAngles = var_239_6
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(0, 100, 0)

				local var_239_7 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_7.x, var_239_7.y, var_239_7.z)

				local var_239_8 = var_239_0.localEulerAngles

				var_239_8.z = 0
				var_239_8.x = 0
				var_239_0.localEulerAngles = var_239_8
			end

			local var_239_9 = 0
			local var_239_10 = 0.45

			if var_239_9 < arg_236_1.time_ and arg_236_1.time_ <= var_239_9 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_11 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_12 = arg_236_1:GetWordFromCfg(1105006057)
				local var_239_13 = arg_236_1:FormatText(var_239_12.content)

				arg_236_1.text_.text = var_239_13

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_14 = 18
				local var_239_15 = utf8.len(var_239_13)
				local var_239_16 = var_239_14 <= 0 and var_239_10 or var_239_10 * (var_239_15 / var_239_14)

				if var_239_16 > 0 and var_239_10 < var_239_16 then
					arg_236_1.talkMaxDuration = var_239_16

					if var_239_16 + var_239_9 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_16 + var_239_9
					end
				end

				arg_236_1.text_.text = var_239_13
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_17 = math.max(var_239_10, arg_236_1.talkMaxDuration)

			if var_239_9 <= arg_236_1.time_ and arg_236_1.time_ < var_239_9 + var_239_17 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_9) / var_239_17

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_9 + var_239_17 and arg_236_1.time_ < var_239_9 + var_239_17 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play1105006058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1105006058
		arg_240_1.duration_ = 2.67

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1105006059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["115001ui_story"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect115001ui_story == nil then
				arg_240_1.var_.characterEffect115001ui_story = var_243_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.characterEffect115001ui_story and not isNil(var_243_0) then
					arg_240_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect115001ui_story then
				arg_240_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_243_4 = 0

			if var_243_4 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_243_5 = arg_240_1.actors_["115001ui_story"].transform
			local var_243_6 = 0

			if var_243_6 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.var_.moveOldPos115001ui_story = var_243_5.localPosition
			end

			local var_243_7 = 0.001

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_7 then
				local var_243_8 = (arg_240_1.time_ - var_243_6) / var_243_7
				local var_243_9 = Vector3.New(0, -1.033, -6.3)

				var_243_5.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos115001ui_story, var_243_9, var_243_8)

				local var_243_10 = manager.ui.mainCamera.transform.position - var_243_5.position

				var_243_5.forward = Vector3.New(var_243_10.x, var_243_10.y, var_243_10.z)

				local var_243_11 = var_243_5.localEulerAngles

				var_243_11.z = 0
				var_243_11.x = 0
				var_243_5.localEulerAngles = var_243_11
			end

			if arg_240_1.time_ >= var_243_6 + var_243_7 and arg_240_1.time_ < var_243_6 + var_243_7 + arg_243_0 then
				var_243_5.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_243_12 = manager.ui.mainCamera.transform.position - var_243_5.position

				var_243_5.forward = Vector3.New(var_243_12.x, var_243_12.y, var_243_12.z)

				local var_243_13 = var_243_5.localEulerAngles

				var_243_13.z = 0
				var_243_13.x = 0
				var_243_5.localEulerAngles = var_243_13
			end

			local var_243_14 = 0

			if var_243_14 < arg_240_1.time_ and arg_240_1.time_ <= var_243_14 + arg_243_0 then
				arg_240_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_243_15 = 0
			local var_243_16 = 0.375

			if var_243_15 < arg_240_1.time_ and arg_240_1.time_ <= var_243_15 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_17 = arg_240_1:FormatText(StoryNameCfg[74].name)

				arg_240_1.leftNameTxt_.text = var_243_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_18 = arg_240_1:GetWordFromCfg(1105006058)
				local var_243_19 = arg_240_1:FormatText(var_243_18.content)

				arg_240_1.text_.text = var_243_19

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_20 = 15
				local var_243_21 = utf8.len(var_243_19)
				local var_243_22 = var_243_20 <= 0 and var_243_16 or var_243_16 * (var_243_21 / var_243_20)

				if var_243_22 > 0 and var_243_16 < var_243_22 then
					arg_240_1.talkMaxDuration = var_243_22

					if var_243_22 + var_243_15 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_22 + var_243_15
					end
				end

				arg_240_1.text_.text = var_243_19
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006058", "story_v_side_new_1105006.awb") ~= 0 then
					local var_243_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006058", "story_v_side_new_1105006.awb") / 1000

					if var_243_23 + var_243_15 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_23 + var_243_15
					end

					if var_243_18.prefab_name ~= "" and arg_240_1.actors_[var_243_18.prefab_name] ~= nil then
						local var_243_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_18.prefab_name].transform, "story_v_side_new_1105006", "1105006058", "story_v_side_new_1105006.awb")

						arg_240_1:RecordAudio("1105006058", var_243_24)
						arg_240_1:RecordAudio("1105006058", var_243_24)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006058", "story_v_side_new_1105006.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006058", "story_v_side_new_1105006.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_25 = math.max(var_243_16, arg_240_1.talkMaxDuration)

			if var_243_15 <= arg_240_1.time_ and arg_240_1.time_ < var_243_15 + var_243_25 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_15) / var_243_25

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_15 + var_243_25 and arg_240_1.time_ < var_243_15 + var_243_25 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play1105006059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1105006059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1105006060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["115001ui_story"].transform
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.var_.moveOldPos115001ui_story = var_247_0.localPosition
			end

			local var_247_2 = 0.001

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2
				local var_247_4 = Vector3.New(0, 100, 0)

				var_247_0.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos115001ui_story, var_247_4, var_247_3)

				local var_247_5 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_5.x, var_247_5.y, var_247_5.z)

				local var_247_6 = var_247_0.localEulerAngles

				var_247_6.z = 0
				var_247_6.x = 0
				var_247_0.localEulerAngles = var_247_6
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 then
				var_247_0.localPosition = Vector3.New(0, 100, 0)

				local var_247_7 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_7.x, var_247_7.y, var_247_7.z)

				local var_247_8 = var_247_0.localEulerAngles

				var_247_8.z = 0
				var_247_8.x = 0
				var_247_0.localEulerAngles = var_247_8
			end

			local var_247_9 = 0
			local var_247_10 = 0.975

			if var_247_9 < arg_244_1.time_ and arg_244_1.time_ <= var_247_9 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_11 = arg_244_1:FormatText(StoryNameCfg[7].name)

				arg_244_1.leftNameTxt_.text = var_247_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_12 = arg_244_1:GetWordFromCfg(1105006059)
				local var_247_13 = arg_244_1:FormatText(var_247_12.content)

				arg_244_1.text_.text = var_247_13

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_14 = 39
				local var_247_15 = utf8.len(var_247_13)
				local var_247_16 = var_247_14 <= 0 and var_247_10 or var_247_10 * (var_247_15 / var_247_14)

				if var_247_16 > 0 and var_247_10 < var_247_16 then
					arg_244_1.talkMaxDuration = var_247_16

					if var_247_16 + var_247_9 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_16 + var_247_9
					end
				end

				arg_244_1.text_.text = var_247_13
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_17 = math.max(var_247_10, arg_244_1.talkMaxDuration)

			if var_247_9 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_17 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_9) / var_247_17

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_9 + var_247_17 and arg_244_1.time_ < var_247_9 + var_247_17 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play1105006060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1105006060
		arg_248_1.duration_ = 2

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play1105006061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["115001ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect115001ui_story == nil then
				arg_248_1.var_.characterEffect115001ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect115001ui_story and not isNil(var_251_0) then
					arg_248_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect115001ui_story then
				arg_248_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_251_4 = 0

			if var_251_4 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_251_5 = arg_248_1.actors_["115001ui_story"].transform
			local var_251_6 = 0

			if var_251_6 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1.var_.moveOldPos115001ui_story = var_251_5.localPosition
			end

			local var_251_7 = 0.001

			if var_251_6 <= arg_248_1.time_ and arg_248_1.time_ < var_251_6 + var_251_7 then
				local var_251_8 = (arg_248_1.time_ - var_251_6) / var_251_7
				local var_251_9 = Vector3.New(0, -1.033, -6.3)

				var_251_5.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos115001ui_story, var_251_9, var_251_8)

				local var_251_10 = manager.ui.mainCamera.transform.position - var_251_5.position

				var_251_5.forward = Vector3.New(var_251_10.x, var_251_10.y, var_251_10.z)

				local var_251_11 = var_251_5.localEulerAngles

				var_251_11.z = 0
				var_251_11.x = 0
				var_251_5.localEulerAngles = var_251_11
			end

			if arg_248_1.time_ >= var_251_6 + var_251_7 and arg_248_1.time_ < var_251_6 + var_251_7 + arg_251_0 then
				var_251_5.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_251_12 = manager.ui.mainCamera.transform.position - var_251_5.position

				var_251_5.forward = Vector3.New(var_251_12.x, var_251_12.y, var_251_12.z)

				local var_251_13 = var_251_5.localEulerAngles

				var_251_13.z = 0
				var_251_13.x = 0
				var_251_5.localEulerAngles = var_251_13
			end

			local var_251_14 = 0
			local var_251_15 = 0.125

			if var_251_14 < arg_248_1.time_ and arg_248_1.time_ <= var_251_14 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_16 = arg_248_1:FormatText(StoryNameCfg[74].name)

				arg_248_1.leftNameTxt_.text = var_251_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_17 = arg_248_1:GetWordFromCfg(1105006060)
				local var_251_18 = arg_248_1:FormatText(var_251_17.content)

				arg_248_1.text_.text = var_251_18

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_19 = 5
				local var_251_20 = utf8.len(var_251_18)
				local var_251_21 = var_251_19 <= 0 and var_251_15 or var_251_15 * (var_251_20 / var_251_19)

				if var_251_21 > 0 and var_251_15 < var_251_21 then
					arg_248_1.talkMaxDuration = var_251_21

					if var_251_21 + var_251_14 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_21 + var_251_14
					end
				end

				arg_248_1.text_.text = var_251_18
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006060", "story_v_side_new_1105006.awb") ~= 0 then
					local var_251_22 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006060", "story_v_side_new_1105006.awb") / 1000

					if var_251_22 + var_251_14 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_22 + var_251_14
					end

					if var_251_17.prefab_name ~= "" and arg_248_1.actors_[var_251_17.prefab_name] ~= nil then
						local var_251_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_17.prefab_name].transform, "story_v_side_new_1105006", "1105006060", "story_v_side_new_1105006.awb")

						arg_248_1:RecordAudio("1105006060", var_251_23)
						arg_248_1:RecordAudio("1105006060", var_251_23)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006060", "story_v_side_new_1105006.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006060", "story_v_side_new_1105006.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_24 = math.max(var_251_15, arg_248_1.talkMaxDuration)

			if var_251_14 <= arg_248_1.time_ and arg_248_1.time_ < var_251_14 + var_251_24 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_14) / var_251_24

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_14 + var_251_24 and arg_248_1.time_ < var_251_14 + var_251_24 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play1105006061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1105006061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play1105006062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["115001ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect115001ui_story == nil then
				arg_252_1.var_.characterEffect115001ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect115001ui_story and not isNil(var_255_0) then
					local var_255_4 = Mathf.Lerp(0, 0.5, var_255_3)

					arg_252_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_252_1.var_.characterEffect115001ui_story.fillRatio = var_255_4
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect115001ui_story then
				local var_255_5 = 0.5

				arg_252_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_252_1.var_.characterEffect115001ui_story.fillRatio = var_255_5
			end

			local var_255_6 = 0
			local var_255_7 = 0.25

			if var_255_6 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_8 = arg_252_1:FormatText(StoryNameCfg[7].name)

				arg_252_1.leftNameTxt_.text = var_255_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_9 = arg_252_1:GetWordFromCfg(1105006061)
				local var_255_10 = arg_252_1:FormatText(var_255_9.content)

				arg_252_1.text_.text = var_255_10

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 10
				local var_255_12 = utf8.len(var_255_10)
				local var_255_13 = var_255_11 <= 0 and var_255_7 or var_255_7 * (var_255_12 / var_255_11)

				if var_255_13 > 0 and var_255_7 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_10
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_14 and arg_252_1.time_ < var_255_6 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play1105006062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1105006062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1105006063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 1.3

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[7].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_3 = arg_256_1:GetWordFromCfg(1105006062)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 52
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_8 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_8 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_8

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_8 and arg_256_1.time_ < var_259_0 + var_259_8 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1105006063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1105006063
		arg_260_1.duration_ = 4.93

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1105006064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["115001ui_story"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect115001ui_story == nil then
				arg_260_1.var_.characterEffect115001ui_story = var_263_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.characterEffect115001ui_story and not isNil(var_263_0) then
					arg_260_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect115001ui_story then
				arg_260_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_263_4 = 0

			if var_263_4 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			local var_263_5 = 0

			if var_263_5 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
				arg_260_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_263_6 = 0
			local var_263_7 = 0.675

			if var_263_6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_8 = arg_260_1:FormatText(StoryNameCfg[74].name)

				arg_260_1.leftNameTxt_.text = var_263_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_9 = arg_260_1:GetWordFromCfg(1105006063)
				local var_263_10 = arg_260_1:FormatText(var_263_9.content)

				arg_260_1.text_.text = var_263_10

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_11 = 27
				local var_263_12 = utf8.len(var_263_10)
				local var_263_13 = var_263_11 <= 0 and var_263_7 or var_263_7 * (var_263_12 / var_263_11)

				if var_263_13 > 0 and var_263_7 < var_263_13 then
					arg_260_1.talkMaxDuration = var_263_13

					if var_263_13 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_13 + var_263_6
					end
				end

				arg_260_1.text_.text = var_263_10
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006063", "story_v_side_new_1105006.awb") ~= 0 then
					local var_263_14 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006063", "story_v_side_new_1105006.awb") / 1000

					if var_263_14 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_14 + var_263_6
					end

					if var_263_9.prefab_name ~= "" and arg_260_1.actors_[var_263_9.prefab_name] ~= nil then
						local var_263_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_9.prefab_name].transform, "story_v_side_new_1105006", "1105006063", "story_v_side_new_1105006.awb")

						arg_260_1:RecordAudio("1105006063", var_263_15)
						arg_260_1:RecordAudio("1105006063", var_263_15)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006063", "story_v_side_new_1105006.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006063", "story_v_side_new_1105006.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_16 = math.max(var_263_7, arg_260_1.talkMaxDuration)

			if var_263_6 <= arg_260_1.time_ and arg_260_1.time_ < var_263_6 + var_263_16 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_6) / var_263_16

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_6 + var_263_16 and arg_260_1.time_ < var_263_6 + var_263_16 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1105006064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 1105006064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play1105006065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["115001ui_story"].transform
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.moveOldPos115001ui_story = var_267_0.localPosition
			end

			local var_267_2 = 0.001

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2
				local var_267_4 = Vector3.New(0, 100, 0)

				var_267_0.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos115001ui_story, var_267_4, var_267_3)

				local var_267_5 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_5.x, var_267_5.y, var_267_5.z)

				local var_267_6 = var_267_0.localEulerAngles

				var_267_6.z = 0
				var_267_6.x = 0
				var_267_0.localEulerAngles = var_267_6
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 then
				var_267_0.localPosition = Vector3.New(0, 100, 0)

				local var_267_7 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_7.x, var_267_7.y, var_267_7.z)

				local var_267_8 = var_267_0.localEulerAngles

				var_267_8.z = 0
				var_267_8.x = 0
				var_267_0.localEulerAngles = var_267_8
			end

			local var_267_9 = 0
			local var_267_10 = 0.35

			if var_267_9 < arg_264_1.time_ and arg_264_1.time_ <= var_267_9 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_11 = arg_264_1:FormatText(StoryNameCfg[7].name)

				arg_264_1.leftNameTxt_.text = var_267_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_12 = arg_264_1:GetWordFromCfg(1105006064)
				local var_267_13 = arg_264_1:FormatText(var_267_12.content)

				arg_264_1.text_.text = var_267_13

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_14 = 14
				local var_267_15 = utf8.len(var_267_13)
				local var_267_16 = var_267_14 <= 0 and var_267_10 or var_267_10 * (var_267_15 / var_267_14)

				if var_267_16 > 0 and var_267_10 < var_267_16 then
					arg_264_1.talkMaxDuration = var_267_16

					if var_267_16 + var_267_9 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_16 + var_267_9
					end
				end

				arg_264_1.text_.text = var_267_13
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_17 = math.max(var_267_10, arg_264_1.talkMaxDuration)

			if var_267_9 <= arg_264_1.time_ and arg_264_1.time_ < var_267_9 + var_267_17 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_9) / var_267_17

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_9 + var_267_17 and arg_264_1.time_ < var_267_9 + var_267_17 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play1105006065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1105006065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1105006066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 0.4

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_2 = arg_268_1:GetWordFromCfg(1105006065)
				local var_271_3 = arg_268_1:FormatText(var_271_2.content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 16
				local var_271_5 = utf8.len(var_271_3)
				local var_271_6 = var_271_4 <= 0 and var_271_1 or var_271_1 * (var_271_5 / var_271_4)

				if var_271_6 > 0 and var_271_1 < var_271_6 then
					arg_268_1.talkMaxDuration = var_271_6

					if var_271_6 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_6 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_7 and arg_268_1.time_ < var_271_0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play1105006066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1105006066
		arg_272_1.duration_ = 7.33

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1105006067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["115001ui_story"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect115001ui_story == nil then
				arg_272_1.var_.characterEffect115001ui_story = var_275_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 and not isNil(var_275_0) then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2

				if arg_272_1.var_.characterEffect115001ui_story and not isNil(var_275_0) then
					arg_272_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect115001ui_story then
				arg_272_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_275_4 = 0

			if var_275_4 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_2")
			end

			local var_275_5 = 0

			if var_275_5 < arg_272_1.time_ and arg_272_1.time_ <= var_275_5 + arg_275_0 then
				arg_272_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_275_6 = arg_272_1.actors_["115001ui_story"].transform
			local var_275_7 = 0

			if var_275_7 < arg_272_1.time_ and arg_272_1.time_ <= var_275_7 + arg_275_0 then
				arg_272_1.var_.moveOldPos115001ui_story = var_275_6.localPosition
			end

			local var_275_8 = 0.001

			if var_275_7 <= arg_272_1.time_ and arg_272_1.time_ < var_275_7 + var_275_8 then
				local var_275_9 = (arg_272_1.time_ - var_275_7) / var_275_8
				local var_275_10 = Vector3.New(0, -1.033, -6.3)

				var_275_6.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos115001ui_story, var_275_10, var_275_9)

				local var_275_11 = manager.ui.mainCamera.transform.position - var_275_6.position

				var_275_6.forward = Vector3.New(var_275_11.x, var_275_11.y, var_275_11.z)

				local var_275_12 = var_275_6.localEulerAngles

				var_275_12.z = 0
				var_275_12.x = 0
				var_275_6.localEulerAngles = var_275_12
			end

			if arg_272_1.time_ >= var_275_7 + var_275_8 and arg_272_1.time_ < var_275_7 + var_275_8 + arg_275_0 then
				var_275_6.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_275_13 = manager.ui.mainCamera.transform.position - var_275_6.position

				var_275_6.forward = Vector3.New(var_275_13.x, var_275_13.y, var_275_13.z)

				local var_275_14 = var_275_6.localEulerAngles

				var_275_14.z = 0
				var_275_14.x = 0
				var_275_6.localEulerAngles = var_275_14
			end

			local var_275_15 = 0
			local var_275_16 = 0.625

			if var_275_15 < arg_272_1.time_ and arg_272_1.time_ <= var_275_15 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_17 = arg_272_1:FormatText(StoryNameCfg[74].name)

				arg_272_1.leftNameTxt_.text = var_275_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_18 = arg_272_1:GetWordFromCfg(1105006066)
				local var_275_19 = arg_272_1:FormatText(var_275_18.content)

				arg_272_1.text_.text = var_275_19

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_20 = 25
				local var_275_21 = utf8.len(var_275_19)
				local var_275_22 = var_275_20 <= 0 and var_275_16 or var_275_16 * (var_275_21 / var_275_20)

				if var_275_22 > 0 and var_275_16 < var_275_22 then
					arg_272_1.talkMaxDuration = var_275_22

					if var_275_22 + var_275_15 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_22 + var_275_15
					end
				end

				arg_272_1.text_.text = var_275_19
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006066", "story_v_side_new_1105006.awb") ~= 0 then
					local var_275_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006066", "story_v_side_new_1105006.awb") / 1000

					if var_275_23 + var_275_15 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_23 + var_275_15
					end

					if var_275_18.prefab_name ~= "" and arg_272_1.actors_[var_275_18.prefab_name] ~= nil then
						local var_275_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_18.prefab_name].transform, "story_v_side_new_1105006", "1105006066", "story_v_side_new_1105006.awb")

						arg_272_1:RecordAudio("1105006066", var_275_24)
						arg_272_1:RecordAudio("1105006066", var_275_24)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006066", "story_v_side_new_1105006.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006066", "story_v_side_new_1105006.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_25 = math.max(var_275_16, arg_272_1.talkMaxDuration)

			if var_275_15 <= arg_272_1.time_ and arg_272_1.time_ < var_275_15 + var_275_25 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_15) / var_275_25

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_15 + var_275_25 and arg_272_1.time_ < var_275_15 + var_275_25 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play1105006067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1105006067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1105006068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["115001ui_story"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect115001ui_story == nil then
				arg_276_1.var_.characterEffect115001ui_story = var_279_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.characterEffect115001ui_story and not isNil(var_279_0) then
					local var_279_4 = Mathf.Lerp(0, 0.5, var_279_3)

					arg_276_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_276_1.var_.characterEffect115001ui_story.fillRatio = var_279_4
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect115001ui_story then
				local var_279_5 = 0.5

				arg_276_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_276_1.var_.characterEffect115001ui_story.fillRatio = var_279_5
			end

			local var_279_6 = 0
			local var_279_7 = 0.2

			if var_279_6 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_8 = arg_276_1:FormatText(StoryNameCfg[7].name)

				arg_276_1.leftNameTxt_.text = var_279_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_9 = arg_276_1:GetWordFromCfg(1105006067)
				local var_279_10 = arg_276_1:FormatText(var_279_9.content)

				arg_276_1.text_.text = var_279_10

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_11 = 8
				local var_279_12 = utf8.len(var_279_10)
				local var_279_13 = var_279_11 <= 0 and var_279_7 or var_279_7 * (var_279_12 / var_279_11)

				if var_279_13 > 0 and var_279_7 < var_279_13 then
					arg_276_1.talkMaxDuration = var_279_13

					if var_279_13 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_6
					end
				end

				arg_276_1.text_.text = var_279_10
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_14 = math.max(var_279_7, arg_276_1.talkMaxDuration)

			if var_279_6 <= arg_276_1.time_ and arg_276_1.time_ < var_279_6 + var_279_14 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_6) / var_279_14

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_6 + var_279_14 and arg_276_1.time_ < var_279_6 + var_279_14 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1105006068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1105006068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1105006069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["115001ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect115001ui_story == nil then
				arg_280_1.var_.characterEffect115001ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.095033198595047

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect115001ui_story and not isNil(var_283_0) then
					local var_283_4 = Mathf.Lerp(0, 0.5, var_283_3)

					arg_280_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_280_1.var_.characterEffect115001ui_story.fillRatio = var_283_4
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect115001ui_story then
				local var_283_5 = 0.5

				arg_280_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_280_1.var_.characterEffect115001ui_story.fillRatio = var_283_5
			end

			local var_283_6 = 0
			local var_283_7 = 1

			if var_283_6 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_8 = arg_280_1:GetWordFromCfg(1105006068)
				local var_283_9 = arg_280_1:FormatText(var_283_8.content)

				arg_280_1.text_.text = var_283_9

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_10 = 40
				local var_283_11 = utf8.len(var_283_9)
				local var_283_12 = var_283_10 <= 0 and var_283_7 or var_283_7 * (var_283_11 / var_283_10)

				if var_283_12 > 0 and var_283_7 < var_283_12 then
					arg_280_1.talkMaxDuration = var_283_12

					if var_283_12 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_12 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_9
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_13 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_13 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_13

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_13 and arg_280_1.time_ < var_283_6 + var_283_13 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1105006069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1105006069
		arg_284_1.duration_ = 5.87

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1105006070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["115001ui_story"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect115001ui_story == nil then
				arg_284_1.var_.characterEffect115001ui_story = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect115001ui_story and not isNil(var_287_0) then
					arg_284_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect115001ui_story then
				arg_284_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_287_4 = 0

			if var_287_4 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_287_5 = 0
			local var_287_6 = 0.45

			if var_287_5 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_7 = arg_284_1:FormatText(StoryNameCfg[74].name)

				arg_284_1.leftNameTxt_.text = var_287_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_8 = arg_284_1:GetWordFromCfg(1105006069)
				local var_287_9 = arg_284_1:FormatText(var_287_8.content)

				arg_284_1.text_.text = var_287_9

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_10 = 18
				local var_287_11 = utf8.len(var_287_9)
				local var_287_12 = var_287_10 <= 0 and var_287_6 or var_287_6 * (var_287_11 / var_287_10)

				if var_287_12 > 0 and var_287_6 < var_287_12 then
					arg_284_1.talkMaxDuration = var_287_12

					if var_287_12 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_12 + var_287_5
					end
				end

				arg_284_1.text_.text = var_287_9
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006069", "story_v_side_new_1105006.awb") ~= 0 then
					local var_287_13 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006069", "story_v_side_new_1105006.awb") / 1000

					if var_287_13 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_5
					end

					if var_287_8.prefab_name ~= "" and arg_284_1.actors_[var_287_8.prefab_name] ~= nil then
						local var_287_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_8.prefab_name].transform, "story_v_side_new_1105006", "1105006069", "story_v_side_new_1105006.awb")

						arg_284_1:RecordAudio("1105006069", var_287_14)
						arg_284_1:RecordAudio("1105006069", var_287_14)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006069", "story_v_side_new_1105006.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006069", "story_v_side_new_1105006.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_15 = math.max(var_287_6, arg_284_1.talkMaxDuration)

			if var_287_5 <= arg_284_1.time_ and arg_284_1.time_ < var_287_5 + var_287_15 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_5) / var_287_15

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_5 + var_287_15 and arg_284_1.time_ < var_287_5 + var_287_15 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1105006070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1105006070
		arg_288_1.duration_ = 7.17

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1105006071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["115001ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect115001ui_story == nil then
				arg_288_1.var_.characterEffect115001ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect115001ui_story and not isNil(var_291_0) then
					arg_288_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect115001ui_story then
				arg_288_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_291_4 = 0
			local var_291_5 = 1.05

			if var_291_4 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_6 = arg_288_1:FormatText(StoryNameCfg[74].name)

				arg_288_1.leftNameTxt_.text = var_291_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_7 = arg_288_1:GetWordFromCfg(1105006070)
				local var_291_8 = arg_288_1:FormatText(var_291_7.content)

				arg_288_1.text_.text = var_291_8

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_9 = 42
				local var_291_10 = utf8.len(var_291_8)
				local var_291_11 = var_291_9 <= 0 and var_291_5 or var_291_5 * (var_291_10 / var_291_9)

				if var_291_11 > 0 and var_291_5 < var_291_11 then
					arg_288_1.talkMaxDuration = var_291_11

					if var_291_11 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_11 + var_291_4
					end
				end

				arg_288_1.text_.text = var_291_8
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006070", "story_v_side_new_1105006.awb") ~= 0 then
					local var_291_12 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006070", "story_v_side_new_1105006.awb") / 1000

					if var_291_12 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_12 + var_291_4
					end

					if var_291_7.prefab_name ~= "" and arg_288_1.actors_[var_291_7.prefab_name] ~= nil then
						local var_291_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_7.prefab_name].transform, "story_v_side_new_1105006", "1105006070", "story_v_side_new_1105006.awb")

						arg_288_1:RecordAudio("1105006070", var_291_13)
						arg_288_1:RecordAudio("1105006070", var_291_13)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006070", "story_v_side_new_1105006.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006070", "story_v_side_new_1105006.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_14 = math.max(var_291_5, arg_288_1.talkMaxDuration)

			if var_291_4 <= arg_288_1.time_ and arg_288_1.time_ < var_291_4 + var_291_14 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_4) / var_291_14

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_4 + var_291_14 and arg_288_1.time_ < var_291_4 + var_291_14 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1105006071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1105006071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1105006072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["115001ui_story"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect115001ui_story == nil then
				arg_292_1.var_.characterEffect115001ui_story = var_295_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.characterEffect115001ui_story and not isNil(var_295_0) then
					local var_295_4 = Mathf.Lerp(0, 0.5, var_295_3)

					arg_292_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_292_1.var_.characterEffect115001ui_story.fillRatio = var_295_4
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect115001ui_story then
				local var_295_5 = 0.5

				arg_292_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_292_1.var_.characterEffect115001ui_story.fillRatio = var_295_5
			end

			local var_295_6 = 0
			local var_295_7 = 0.075

			if var_295_6 < arg_292_1.time_ and arg_292_1.time_ <= var_295_6 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_8 = arg_292_1:FormatText(StoryNameCfg[7].name)

				arg_292_1.leftNameTxt_.text = var_295_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_9 = arg_292_1:GetWordFromCfg(1105006071)
				local var_295_10 = arg_292_1:FormatText(var_295_9.content)

				arg_292_1.text_.text = var_295_10

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_11 = 3
				local var_295_12 = utf8.len(var_295_10)
				local var_295_13 = var_295_11 <= 0 and var_295_7 or var_295_7 * (var_295_12 / var_295_11)

				if var_295_13 > 0 and var_295_7 < var_295_13 then
					arg_292_1.talkMaxDuration = var_295_13

					if var_295_13 + var_295_6 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_13 + var_295_6
					end
				end

				arg_292_1.text_.text = var_295_10
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_14 = math.max(var_295_7, arg_292_1.talkMaxDuration)

			if var_295_6 <= arg_292_1.time_ and arg_292_1.time_ < var_295_6 + var_295_14 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_6) / var_295_14

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_6 + var_295_14 and arg_292_1.time_ < var_295_6 + var_295_14 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1105006072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1105006072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1105006073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["115001ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos115001ui_story = var_299_0.localPosition
			end

			local var_299_2 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2
				local var_299_4 = Vector3.New(0, 100, 0)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos115001ui_story, var_299_4, var_299_3)

				local var_299_5 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_5.x, var_299_5.y, var_299_5.z)

				local var_299_6 = var_299_0.localEulerAngles

				var_299_6.z = 0
				var_299_6.x = 0
				var_299_0.localEulerAngles = var_299_6
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(0, 100, 0)

				local var_299_7 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_7.x, var_299_7.y, var_299_7.z)

				local var_299_8 = var_299_0.localEulerAngles

				var_299_8.z = 0
				var_299_8.x = 0
				var_299_0.localEulerAngles = var_299_8
			end

			local var_299_9 = 0
			local var_299_10 = 0.35

			if var_299_9 < arg_296_1.time_ and arg_296_1.time_ <= var_299_9 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_11 = arg_296_1:GetWordFromCfg(1105006072)
				local var_299_12 = arg_296_1:FormatText(var_299_11.content)

				arg_296_1.text_.text = var_299_12

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_13 = 14
				local var_299_14 = utf8.len(var_299_12)
				local var_299_15 = var_299_13 <= 0 and var_299_10 or var_299_10 * (var_299_14 / var_299_13)

				if var_299_15 > 0 and var_299_10 < var_299_15 then
					arg_296_1.talkMaxDuration = var_299_15

					if var_299_15 + var_299_9 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_15 + var_299_9
					end
				end

				arg_296_1.text_.text = var_299_12
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_16 = math.max(var_299_10, arg_296_1.talkMaxDuration)

			if var_299_9 <= arg_296_1.time_ and arg_296_1.time_ < var_299_9 + var_299_16 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_9) / var_299_16

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_9 + var_299_16 and arg_296_1.time_ < var_299_9 + var_299_16 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play1105006073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1105006073
		arg_300_1.duration_ = 3.4

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1105006074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["115001ui_story"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect115001ui_story == nil then
				arg_300_1.var_.characterEffect115001ui_story = var_303_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.200000002980232

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.characterEffect115001ui_story and not isNil(var_303_0) then
					arg_300_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect115001ui_story then
				arg_300_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_303_4 = 0

			if var_303_4 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_303_5 = arg_300_1.actors_["115001ui_story"].transform
			local var_303_6 = 0

			if var_303_6 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.var_.moveOldPos115001ui_story = var_303_5.localPosition
			end

			local var_303_7 = 0.001

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_7 then
				local var_303_8 = (arg_300_1.time_ - var_303_6) / var_303_7
				local var_303_9 = Vector3.New(0, -1.033, -6.3)

				var_303_5.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos115001ui_story, var_303_9, var_303_8)

				local var_303_10 = manager.ui.mainCamera.transform.position - var_303_5.position

				var_303_5.forward = Vector3.New(var_303_10.x, var_303_10.y, var_303_10.z)

				local var_303_11 = var_303_5.localEulerAngles

				var_303_11.z = 0
				var_303_11.x = 0
				var_303_5.localEulerAngles = var_303_11
			end

			if arg_300_1.time_ >= var_303_6 + var_303_7 and arg_300_1.time_ < var_303_6 + var_303_7 + arg_303_0 then
				var_303_5.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_303_12 = manager.ui.mainCamera.transform.position - var_303_5.position

				var_303_5.forward = Vector3.New(var_303_12.x, var_303_12.y, var_303_12.z)

				local var_303_13 = var_303_5.localEulerAngles

				var_303_13.z = 0
				var_303_13.x = 0
				var_303_5.localEulerAngles = var_303_13
			end

			local var_303_14 = 0
			local var_303_15 = 0.4

			if var_303_14 < arg_300_1.time_ and arg_300_1.time_ <= var_303_14 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_16 = arg_300_1:FormatText(StoryNameCfg[74].name)

				arg_300_1.leftNameTxt_.text = var_303_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_17 = arg_300_1:GetWordFromCfg(1105006073)
				local var_303_18 = arg_300_1:FormatText(var_303_17.content)

				arg_300_1.text_.text = var_303_18

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_19 = 16
				local var_303_20 = utf8.len(var_303_18)
				local var_303_21 = var_303_19 <= 0 and var_303_15 or var_303_15 * (var_303_20 / var_303_19)

				if var_303_21 > 0 and var_303_15 < var_303_21 then
					arg_300_1.talkMaxDuration = var_303_21

					if var_303_21 + var_303_14 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_21 + var_303_14
					end
				end

				arg_300_1.text_.text = var_303_18
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006073", "story_v_side_new_1105006.awb") ~= 0 then
					local var_303_22 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006073", "story_v_side_new_1105006.awb") / 1000

					if var_303_22 + var_303_14 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_22 + var_303_14
					end

					if var_303_17.prefab_name ~= "" and arg_300_1.actors_[var_303_17.prefab_name] ~= nil then
						local var_303_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_17.prefab_name].transform, "story_v_side_new_1105006", "1105006073", "story_v_side_new_1105006.awb")

						arg_300_1:RecordAudio("1105006073", var_303_23)
						arg_300_1:RecordAudio("1105006073", var_303_23)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006073", "story_v_side_new_1105006.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006073", "story_v_side_new_1105006.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_24 = math.max(var_303_15, arg_300_1.talkMaxDuration)

			if var_303_14 <= arg_300_1.time_ and arg_300_1.time_ < var_303_14 + var_303_24 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_14) / var_303_24

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_14 + var_303_24 and arg_300_1.time_ < var_303_14 + var_303_24 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play1105006074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1105006074
		arg_304_1.duration_ = 9

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1105006075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = "ST11"

			if arg_304_1.bgs_[var_307_0] == nil then
				local var_307_1 = Object.Instantiate(arg_304_1.paintGo_)

				var_307_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_307_0)
				var_307_1.name = var_307_0
				var_307_1.transform.parent = arg_304_1.stage_.transform
				var_307_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_304_1.bgs_[var_307_0] = var_307_1
			end

			local var_307_2 = 2

			if var_307_2 < arg_304_1.time_ and arg_304_1.time_ <= var_307_2 + arg_307_0 then
				local var_307_3 = manager.ui.mainCamera.transform.localPosition
				local var_307_4 = Vector3.New(0, 0, 10) + Vector3.New(var_307_3.x, var_307_3.y, 0)
				local var_307_5 = arg_304_1.bgs_.ST11

				var_307_5.transform.localPosition = var_307_4
				var_307_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_307_6 = var_307_5:GetComponent("SpriteRenderer")

				if var_307_6 and var_307_6.sprite then
					local var_307_7 = (var_307_5.transform.localPosition - var_307_3).z
					local var_307_8 = manager.ui.mainCameraCom_
					local var_307_9 = 2 * var_307_7 * Mathf.Tan(var_307_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_307_10 = var_307_9 * var_307_8.aspect
					local var_307_11 = var_307_6.sprite.bounds.size.x
					local var_307_12 = var_307_6.sprite.bounds.size.y
					local var_307_13 = var_307_10 / var_307_11
					local var_307_14 = var_307_9 / var_307_12
					local var_307_15 = var_307_14 < var_307_13 and var_307_13 or var_307_14

					var_307_5.transform.localScale = Vector3.New(var_307_15, var_307_15, 0)
				end

				for iter_307_0, iter_307_1 in pairs(arg_304_1.bgs_) do
					if iter_307_0 ~= "ST11" then
						iter_307_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_307_16 = 3.999999999999

			if var_307_16 < arg_304_1.time_ and arg_304_1.time_ <= var_307_16 + arg_307_0 then
				arg_304_1.allBtn_.enabled = false
			end

			local var_307_17 = 0.3

			if arg_304_1.time_ >= var_307_16 + var_307_17 and arg_304_1.time_ < var_307_16 + var_307_17 + arg_307_0 then
				arg_304_1.allBtn_.enabled = true
			end

			local var_307_18 = 0

			if var_307_18 < arg_304_1.time_ and arg_304_1.time_ <= var_307_18 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_19 = 2

			if var_307_18 <= arg_304_1.time_ and arg_304_1.time_ < var_307_18 + var_307_19 then
				local var_307_20 = (arg_304_1.time_ - var_307_18) / var_307_19
				local var_307_21 = Color.New(0, 0, 0)

				var_307_21.a = Mathf.Lerp(0, 1, var_307_20)
				arg_304_1.mask_.color = var_307_21
			end

			if arg_304_1.time_ >= var_307_18 + var_307_19 and arg_304_1.time_ < var_307_18 + var_307_19 + arg_307_0 then
				local var_307_22 = Color.New(0, 0, 0)

				var_307_22.a = 1
				arg_304_1.mask_.color = var_307_22
			end

			local var_307_23 = 1.999999999999

			if var_307_23 < arg_304_1.time_ and arg_304_1.time_ <= var_307_23 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_24 = 2

			if var_307_23 <= arg_304_1.time_ and arg_304_1.time_ < var_307_23 + var_307_24 then
				local var_307_25 = (arg_304_1.time_ - var_307_23) / var_307_24
				local var_307_26 = Color.New(0, 0, 0)

				var_307_26.a = Mathf.Lerp(1, 0, var_307_25)
				arg_304_1.mask_.color = var_307_26
			end

			if arg_304_1.time_ >= var_307_23 + var_307_24 and arg_304_1.time_ < var_307_23 + var_307_24 + arg_307_0 then
				local var_307_27 = Color.New(0, 0, 0)
				local var_307_28 = 0

				arg_304_1.mask_.enabled = false
				var_307_27.a = var_307_28
				arg_304_1.mask_.color = var_307_27
			end

			local var_307_29 = arg_304_1.actors_["115001ui_story"].transform
			local var_307_30 = 1.96599999815126

			if var_307_30 < arg_304_1.time_ and arg_304_1.time_ <= var_307_30 + arg_307_0 then
				arg_304_1.var_.moveOldPos115001ui_story = var_307_29.localPosition
			end

			local var_307_31 = 0.001

			if var_307_30 <= arg_304_1.time_ and arg_304_1.time_ < var_307_30 + var_307_31 then
				local var_307_32 = (arg_304_1.time_ - var_307_30) / var_307_31
				local var_307_33 = Vector3.New(0, 100, 0)

				var_307_29.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos115001ui_story, var_307_33, var_307_32)

				local var_307_34 = manager.ui.mainCamera.transform.position - var_307_29.position

				var_307_29.forward = Vector3.New(var_307_34.x, var_307_34.y, var_307_34.z)

				local var_307_35 = var_307_29.localEulerAngles

				var_307_35.z = 0
				var_307_35.x = 0
				var_307_29.localEulerAngles = var_307_35
			end

			if arg_304_1.time_ >= var_307_30 + var_307_31 and arg_304_1.time_ < var_307_30 + var_307_31 + arg_307_0 then
				var_307_29.localPosition = Vector3.New(0, 100, 0)

				local var_307_36 = manager.ui.mainCamera.transform.position - var_307_29.position

				var_307_29.forward = Vector3.New(var_307_36.x, var_307_36.y, var_307_36.z)

				local var_307_37 = var_307_29.localEulerAngles

				var_307_37.z = 0
				var_307_37.x = 0
				var_307_29.localEulerAngles = var_307_37
			end

			if arg_304_1.frameCnt_ <= 1 then
				arg_304_1.dialog_:SetActive(false)
			end

			local var_307_38 = 3.999999999999
			local var_307_39 = 0.65

			if var_307_38 < arg_304_1.time_ and arg_304_1.time_ <= var_307_38 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0

				arg_304_1.dialog_:SetActive(true)

				arg_304_1.dialogCg_.alpha = 0

				local var_307_40 = LeanTween.value(arg_304_1.dialog_, 0, 1, 0.3)

				var_307_40:setOnUpdate(LuaHelper.FloatAction(function(arg_308_0)
					arg_304_1.dialogCg_.alpha = arg_308_0
				end))
				var_307_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_304_1.dialog_)
					var_307_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_304_1.duration_ = arg_304_1.duration_ + 0.3

				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_41 = arg_304_1:GetWordFromCfg(1105006074)
				local var_307_42 = arg_304_1:FormatText(var_307_41.content)

				arg_304_1.text_.text = var_307_42

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_43 = 26
				local var_307_44 = utf8.len(var_307_42)
				local var_307_45 = var_307_43 <= 0 and var_307_39 or var_307_39 * (var_307_44 / var_307_43)

				if var_307_45 > 0 and var_307_39 < var_307_45 then
					arg_304_1.talkMaxDuration = var_307_45
					var_307_38 = var_307_38 + 0.3

					if var_307_45 + var_307_38 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_45 + var_307_38
					end
				end

				arg_304_1.text_.text = var_307_42
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_46 = var_307_38 + 0.3
			local var_307_47 = math.max(var_307_39, arg_304_1.talkMaxDuration)

			if var_307_46 <= arg_304_1.time_ and arg_304_1.time_ < var_307_46 + var_307_47 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_46) / var_307_47

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_46 + var_307_47 and arg_304_1.time_ < var_307_46 + var_307_47 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815126,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play1105006075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1105006075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1105006076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 0.7

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_2 = arg_310_1:GetWordFromCfg(1105006075)
				local var_313_3 = arg_310_1:FormatText(var_313_2.content)

				arg_310_1.text_.text = var_313_3

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_4 = 28
				local var_313_5 = utf8.len(var_313_3)
				local var_313_6 = var_313_4 <= 0 and var_313_1 or var_313_1 * (var_313_5 / var_313_4)

				if var_313_6 > 0 and var_313_1 < var_313_6 then
					arg_310_1.talkMaxDuration = var_313_6

					if var_313_6 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_3
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_7 and arg_310_1.time_ < var_313_0 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1105006076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1105006076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1105006077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 1.325

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_2 = arg_314_1:FormatText(StoryNameCfg[7].name)

				arg_314_1.leftNameTxt_.text = var_317_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_3 = arg_314_1:GetWordFromCfg(1105006076)
				local var_317_4 = arg_314_1:FormatText(var_317_3.content)

				arg_314_1.text_.text = var_317_4

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 53
				local var_317_6 = utf8.len(var_317_4)
				local var_317_7 = var_317_5 <= 0 and var_317_1 or var_317_1 * (var_317_6 / var_317_5)

				if var_317_7 > 0 and var_317_1 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_4
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_8 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_8 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_8

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_8 and arg_314_1.time_ < var_317_0 + var_317_8 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play1105006077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1105006077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1105006078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 0.525

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[7].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:GetWordFromCfg(1105006077)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 21
				local var_321_6 = utf8.len(var_321_4)
				local var_321_7 = var_321_5 <= 0 and var_321_1 or var_321_1 * (var_321_6 / var_321_5)

				if var_321_7 > 0 and var_321_1 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_8 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_8 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_8

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_8 and arg_318_1.time_ < var_321_0 + var_321_8 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play1105006078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1105006078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1105006079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.95

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[7].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_3 = arg_322_1:GetWordFromCfg(1105006078)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 38
				local var_325_6 = utf8.len(var_325_4)
				local var_325_7 = var_325_5 <= 0 and var_325_1 or var_325_1 * (var_325_6 / var_325_5)

				if var_325_7 > 0 and var_325_1 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_8 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_8 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_8

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_8 and arg_322_1.time_ < var_325_0 + var_325_8 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1105006079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1105006079
		arg_326_1.duration_ = 9

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1105006080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 4

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.allBtn_.enabled = false
			end

			local var_329_1 = 0.3

			if arg_326_1.time_ >= var_329_0 + var_329_1 and arg_326_1.time_ < var_329_0 + var_329_1 + arg_329_0 then
				arg_326_1.allBtn_.enabled = true
			end

			local var_329_2 = "ST01a"

			if arg_326_1.bgs_[var_329_2] == nil then
				local var_329_3 = Object.Instantiate(arg_326_1.paintGo_)

				var_329_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_329_2)
				var_329_3.name = var_329_2
				var_329_3.transform.parent = arg_326_1.stage_.transform
				var_329_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.bgs_[var_329_2] = var_329_3
			end

			local var_329_4 = 2

			if var_329_4 < arg_326_1.time_ and arg_326_1.time_ <= var_329_4 + arg_329_0 then
				local var_329_5 = manager.ui.mainCamera.transform.localPosition
				local var_329_6 = Vector3.New(0, 0, 10) + Vector3.New(var_329_5.x, var_329_5.y, 0)
				local var_329_7 = arg_326_1.bgs_.ST01a

				var_329_7.transform.localPosition = var_329_6
				var_329_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_329_8 = var_329_7:GetComponent("SpriteRenderer")

				if var_329_8 and var_329_8.sprite then
					local var_329_9 = (var_329_7.transform.localPosition - var_329_5).z
					local var_329_10 = manager.ui.mainCameraCom_
					local var_329_11 = 2 * var_329_9 * Mathf.Tan(var_329_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_329_12 = var_329_11 * var_329_10.aspect
					local var_329_13 = var_329_8.sprite.bounds.size.x
					local var_329_14 = var_329_8.sprite.bounds.size.y
					local var_329_15 = var_329_12 / var_329_13
					local var_329_16 = var_329_11 / var_329_14
					local var_329_17 = var_329_16 < var_329_15 and var_329_15 or var_329_16

					var_329_7.transform.localScale = Vector3.New(var_329_17, var_329_17, 0)
				end

				for iter_329_0, iter_329_1 in pairs(arg_326_1.bgs_) do
					if iter_329_0 ~= "ST01a" then
						iter_329_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_329_18 = 0

			if var_329_18 < arg_326_1.time_ and arg_326_1.time_ <= var_329_18 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_19 = 2

			if var_329_18 <= arg_326_1.time_ and arg_326_1.time_ < var_329_18 + var_329_19 then
				local var_329_20 = (arg_326_1.time_ - var_329_18) / var_329_19
				local var_329_21 = Color.New(0, 0, 0)

				var_329_21.a = Mathf.Lerp(0, 1, var_329_20)
				arg_326_1.mask_.color = var_329_21
			end

			if arg_326_1.time_ >= var_329_18 + var_329_19 and arg_326_1.time_ < var_329_18 + var_329_19 + arg_329_0 then
				local var_329_22 = Color.New(0, 0, 0)

				var_329_22.a = 1
				arg_326_1.mask_.color = var_329_22
			end

			local var_329_23 = 2

			if var_329_23 < arg_326_1.time_ and arg_326_1.time_ <= var_329_23 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_24 = 2

			if var_329_23 <= arg_326_1.time_ and arg_326_1.time_ < var_329_23 + var_329_24 then
				local var_329_25 = (arg_326_1.time_ - var_329_23) / var_329_24
				local var_329_26 = Color.New(0, 0, 0)

				var_329_26.a = Mathf.Lerp(1, 0, var_329_25)
				arg_326_1.mask_.color = var_329_26
			end

			if arg_326_1.time_ >= var_329_23 + var_329_24 and arg_326_1.time_ < var_329_23 + var_329_24 + arg_329_0 then
				local var_329_27 = Color.New(0, 0, 0)
				local var_329_28 = 0

				arg_326_1.mask_.enabled = false
				var_329_27.a = var_329_28
				arg_326_1.mask_.color = var_329_27
			end

			if arg_326_1.frameCnt_ <= 1 then
				arg_326_1.dialog_:SetActive(false)
			end

			local var_329_29 = 4
			local var_329_30 = 0.75

			if var_329_29 < arg_326_1.time_ and arg_326_1.time_ <= var_329_29 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				arg_326_1.dialog_:SetActive(true)

				arg_326_1.dialogCg_.alpha = 0

				local var_329_31 = LeanTween.value(arg_326_1.dialog_, 0, 1, 0.3)

				var_329_31:setOnUpdate(LuaHelper.FloatAction(function(arg_330_0)
					arg_326_1.dialogCg_.alpha = arg_330_0
				end))
				var_329_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_326_1.dialog_)
					var_329_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_326_1.duration_ = arg_326_1.duration_ + 0.3

				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_32 = arg_326_1:GetWordFromCfg(1105006079)
				local var_329_33 = arg_326_1:FormatText(var_329_32.content)

				arg_326_1.text_.text = var_329_33

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_34 = 30
				local var_329_35 = utf8.len(var_329_33)
				local var_329_36 = var_329_34 <= 0 and var_329_30 or var_329_30 * (var_329_35 / var_329_34)

				if var_329_36 > 0 and var_329_30 < var_329_36 then
					arg_326_1.talkMaxDuration = var_329_36
					var_329_29 = var_329_29 + 0.3

					if var_329_36 + var_329_29 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_36 + var_329_29
					end
				end

				arg_326_1.text_.text = var_329_33
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_37 = var_329_29 + 0.3
			local var_329_38 = math.max(var_329_30, arg_326_1.talkMaxDuration)

			if var_329_37 <= arg_326_1.time_ and arg_326_1.time_ < var_329_37 + var_329_38 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_37) / var_329_38

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_37 + var_329_38 and arg_326_1.time_ < var_329_37 + var_329_38 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1105006080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1105006080
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1105006081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["115001ui_story"].transform
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.var_.moveOldPos115001ui_story = var_335_0.localPosition
			end

			local var_335_2 = 0.001

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2
				local var_335_4 = Vector3.New(0, -1.033, -6.3)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos115001ui_story, var_335_4, var_335_3)

				local var_335_5 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_5.x, var_335_5.y, var_335_5.z)

				local var_335_6 = var_335_0.localEulerAngles

				var_335_6.z = 0
				var_335_6.x = 0
				var_335_0.localEulerAngles = var_335_6
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_335_7 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_7.x, var_335_7.y, var_335_7.z)

				local var_335_8 = var_335_0.localEulerAngles

				var_335_8.z = 0
				var_335_8.x = 0
				var_335_0.localEulerAngles = var_335_8
			end

			local var_335_9 = arg_332_1.actors_["115001ui_story"]
			local var_335_10 = 0

			if var_335_10 < arg_332_1.time_ and arg_332_1.time_ <= var_335_10 + arg_335_0 and not isNil(var_335_9) and arg_332_1.var_.characterEffect115001ui_story == nil then
				arg_332_1.var_.characterEffect115001ui_story = var_335_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_11 = 0.200000002980232

			if var_335_10 <= arg_332_1.time_ and arg_332_1.time_ < var_335_10 + var_335_11 and not isNil(var_335_9) then
				local var_335_12 = (arg_332_1.time_ - var_335_10) / var_335_11

				if arg_332_1.var_.characterEffect115001ui_story and not isNil(var_335_9) then
					arg_332_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_10 + var_335_11 and arg_332_1.time_ < var_335_10 + var_335_11 + arg_335_0 and not isNil(var_335_9) and arg_332_1.var_.characterEffect115001ui_story then
				arg_332_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_335_13 = 0

			if var_335_13 < arg_332_1.time_ and arg_332_1.time_ <= var_335_13 + arg_335_0 then
				arg_332_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			local var_335_14 = 0

			if var_335_14 < arg_332_1.time_ and arg_332_1.time_ <= var_335_14 + arg_335_0 then
				arg_332_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_335_15 = 0
			local var_335_16 = 0.575

			if var_335_15 < arg_332_1.time_ and arg_332_1.time_ <= var_335_15 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_17 = arg_332_1:FormatText(StoryNameCfg[74].name)

				arg_332_1.leftNameTxt_.text = var_335_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_18 = arg_332_1:GetWordFromCfg(1105006080)
				local var_335_19 = arg_332_1:FormatText(var_335_18.content)

				arg_332_1.text_.text = var_335_19

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_20 = 23
				local var_335_21 = utf8.len(var_335_19)
				local var_335_22 = var_335_20 <= 0 and var_335_16 or var_335_16 * (var_335_21 / var_335_20)

				if var_335_22 > 0 and var_335_16 < var_335_22 then
					arg_332_1.talkMaxDuration = var_335_22

					if var_335_22 + var_335_15 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_22 + var_335_15
					end
				end

				arg_332_1.text_.text = var_335_19
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006080", "story_v_side_new_1105006.awb") ~= 0 then
					local var_335_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006080", "story_v_side_new_1105006.awb") / 1000

					if var_335_23 + var_335_15 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_23 + var_335_15
					end

					if var_335_18.prefab_name ~= "" and arg_332_1.actors_[var_335_18.prefab_name] ~= nil then
						local var_335_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_18.prefab_name].transform, "story_v_side_new_1105006", "1105006080", "story_v_side_new_1105006.awb")

						arg_332_1:RecordAudio("1105006080", var_335_24)
						arg_332_1:RecordAudio("1105006080", var_335_24)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006080", "story_v_side_new_1105006.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006080", "story_v_side_new_1105006.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_25 = math.max(var_335_16, arg_332_1.talkMaxDuration)

			if var_335_15 <= arg_332_1.time_ and arg_332_1.time_ < var_335_15 + var_335_25 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_15) / var_335_25

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_15 + var_335_25 and arg_332_1.time_ < var_335_15 + var_335_25 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play1105006081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1105006081
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1105006082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["115001ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect115001ui_story == nil then
				arg_336_1.var_.characterEffect115001ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect115001ui_story and not isNil(var_339_0) then
					local var_339_4 = Mathf.Lerp(0, 0.5, var_339_3)

					arg_336_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_336_1.var_.characterEffect115001ui_story.fillRatio = var_339_4
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect115001ui_story then
				local var_339_5 = 0.5

				arg_336_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_336_1.var_.characterEffect115001ui_story.fillRatio = var_339_5
			end

			local var_339_6 = 0
			local var_339_7 = 1.1

			if var_339_6 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_8 = arg_336_1:FormatText(StoryNameCfg[7].name)

				arg_336_1.leftNameTxt_.text = var_339_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_9 = arg_336_1:GetWordFromCfg(1105006081)
				local var_339_10 = arg_336_1:FormatText(var_339_9.content)

				arg_336_1.text_.text = var_339_10

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_11 = 44
				local var_339_12 = utf8.len(var_339_10)
				local var_339_13 = var_339_11 <= 0 and var_339_7 or var_339_7 * (var_339_12 / var_339_11)

				if var_339_13 > 0 and var_339_7 < var_339_13 then
					arg_336_1.talkMaxDuration = var_339_13

					if var_339_13 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_13 + var_339_6
					end
				end

				arg_336_1.text_.text = var_339_10
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_14 = math.max(var_339_7, arg_336_1.talkMaxDuration)

			if var_339_6 <= arg_336_1.time_ and arg_336_1.time_ < var_339_6 + var_339_14 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_6) / var_339_14

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_6 + var_339_14 and arg_336_1.time_ < var_339_6 + var_339_14 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1105006082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1105006082
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1105006083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 0.5

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_2 = arg_340_1:FormatText(StoryNameCfg[7].name)

				arg_340_1.leftNameTxt_.text = var_343_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_3 = arg_340_1:GetWordFromCfg(1105006082)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 20
				local var_343_6 = utf8.len(var_343_4)
				local var_343_7 = var_343_5 <= 0 and var_343_1 or var_343_1 * (var_343_6 / var_343_5)

				if var_343_7 > 0 and var_343_1 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_4
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_8 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_8 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_8

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_8 and arg_340_1.time_ < var_343_0 + var_343_8 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1105006083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1105006083
		arg_344_1.duration_ = 2

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1105006084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["115001ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect115001ui_story == nil then
				arg_344_1.var_.characterEffect115001ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect115001ui_story and not isNil(var_347_0) then
					arg_344_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect115001ui_story then
				arg_344_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_347_4 = 0

			if var_347_4 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_2")
			end

			local var_347_5 = 0

			if var_347_5 < arg_344_1.time_ and arg_344_1.time_ <= var_347_5 + arg_347_0 then
				arg_344_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_347_6 = 0
			local var_347_7 = 0.15

			if var_347_6 < arg_344_1.time_ and arg_344_1.time_ <= var_347_6 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_8 = arg_344_1:FormatText(StoryNameCfg[74].name)

				arg_344_1.leftNameTxt_.text = var_347_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_9 = arg_344_1:GetWordFromCfg(1105006083)
				local var_347_10 = arg_344_1:FormatText(var_347_9.content)

				arg_344_1.text_.text = var_347_10

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_11 = 6
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

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006083", "story_v_side_new_1105006.awb") ~= 0 then
					local var_347_14 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006083", "story_v_side_new_1105006.awb") / 1000

					if var_347_14 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_14 + var_347_6
					end

					if var_347_9.prefab_name ~= "" and arg_344_1.actors_[var_347_9.prefab_name] ~= nil then
						local var_347_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_9.prefab_name].transform, "story_v_side_new_1105006", "1105006083", "story_v_side_new_1105006.awb")

						arg_344_1:RecordAudio("1105006083", var_347_15)
						arg_344_1:RecordAudio("1105006083", var_347_15)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006083", "story_v_side_new_1105006.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006083", "story_v_side_new_1105006.awb")
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
	Play1105006084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1105006084
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1105006085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["115001ui_story"]
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect115001ui_story == nil then
				arg_348_1.var_.characterEffect115001ui_story = var_351_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.200000002980232

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 and not isNil(var_351_0) then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2

				if arg_348_1.var_.characterEffect115001ui_story and not isNil(var_351_0) then
					local var_351_4 = Mathf.Lerp(0, 0.5, var_351_3)

					arg_348_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_348_1.var_.characterEffect115001ui_story.fillRatio = var_351_4
				end
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect115001ui_story then
				local var_351_5 = 0.5

				arg_348_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_348_1.var_.characterEffect115001ui_story.fillRatio = var_351_5
			end

			local var_351_6 = 0
			local var_351_7 = 0.85

			if var_351_6 < arg_348_1.time_ and arg_348_1.time_ <= var_351_6 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_8 = arg_348_1:GetWordFromCfg(1105006084)
				local var_351_9 = arg_348_1:FormatText(var_351_8.content)

				arg_348_1.text_.text = var_351_9

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_10 = 34
				local var_351_11 = utf8.len(var_351_9)
				local var_351_12 = var_351_10 <= 0 and var_351_7 or var_351_7 * (var_351_11 / var_351_10)

				if var_351_12 > 0 and var_351_7 < var_351_12 then
					arg_348_1.talkMaxDuration = var_351_12

					if var_351_12 + var_351_6 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_12 + var_351_6
					end
				end

				arg_348_1.text_.text = var_351_9
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_13 = math.max(var_351_7, arg_348_1.talkMaxDuration)

			if var_351_6 <= arg_348_1.time_ and arg_348_1.time_ < var_351_6 + var_351_13 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_6) / var_351_13

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_6 + var_351_13 and arg_348_1.time_ < var_351_6 + var_351_13 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1105006085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1105006085
		arg_352_1.duration_ = 3.67

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1105006086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["115001ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect115001ui_story == nil then
				arg_352_1.var_.characterEffect115001ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect115001ui_story and not isNil(var_355_0) then
					arg_352_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect115001ui_story then
				arg_352_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_355_4 = 0

			if var_355_4 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_355_5 = 0
			local var_355_6 = 0.375

			if var_355_5 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_7 = arg_352_1:FormatText(StoryNameCfg[74].name)

				arg_352_1.leftNameTxt_.text = var_355_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_8 = arg_352_1:GetWordFromCfg(1105006085)
				local var_355_9 = arg_352_1:FormatText(var_355_8.content)

				arg_352_1.text_.text = var_355_9

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_10 = 15
				local var_355_11 = utf8.len(var_355_9)
				local var_355_12 = var_355_10 <= 0 and var_355_6 or var_355_6 * (var_355_11 / var_355_10)

				if var_355_12 > 0 and var_355_6 < var_355_12 then
					arg_352_1.talkMaxDuration = var_355_12

					if var_355_12 + var_355_5 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_12 + var_355_5
					end
				end

				arg_352_1.text_.text = var_355_9
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006085", "story_v_side_new_1105006.awb") ~= 0 then
					local var_355_13 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006085", "story_v_side_new_1105006.awb") / 1000

					if var_355_13 + var_355_5 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_13 + var_355_5
					end

					if var_355_8.prefab_name ~= "" and arg_352_1.actors_[var_355_8.prefab_name] ~= nil then
						local var_355_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_8.prefab_name].transform, "story_v_side_new_1105006", "1105006085", "story_v_side_new_1105006.awb")

						arg_352_1:RecordAudio("1105006085", var_355_14)
						arg_352_1:RecordAudio("1105006085", var_355_14)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006085", "story_v_side_new_1105006.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006085", "story_v_side_new_1105006.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_15 = math.max(var_355_6, arg_352_1.talkMaxDuration)

			if var_355_5 <= arg_352_1.time_ and arg_352_1.time_ < var_355_5 + var_355_15 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_5) / var_355_15

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_5 + var_355_15 and arg_352_1.time_ < var_355_5 + var_355_15 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1105006086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1105006086
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1105006087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["115001ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect115001ui_story == nil then
				arg_356_1.var_.characterEffect115001ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect115001ui_story and not isNil(var_359_0) then
					local var_359_4 = Mathf.Lerp(0, 0.5, var_359_3)

					arg_356_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_356_1.var_.characterEffect115001ui_story.fillRatio = var_359_4
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect115001ui_story then
				local var_359_5 = 0.5

				arg_356_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_356_1.var_.characterEffect115001ui_story.fillRatio = var_359_5
			end

			local var_359_6 = 0
			local var_359_7 = 0.525

			if var_359_6 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_8 = arg_356_1:FormatText(StoryNameCfg[7].name)

				arg_356_1.leftNameTxt_.text = var_359_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_9 = arg_356_1:GetWordFromCfg(1105006086)
				local var_359_10 = arg_356_1:FormatText(var_359_9.content)

				arg_356_1.text_.text = var_359_10

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_11 = 21
				local var_359_12 = utf8.len(var_359_10)
				local var_359_13 = var_359_11 <= 0 and var_359_7 or var_359_7 * (var_359_12 / var_359_11)

				if var_359_13 > 0 and var_359_7 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_10
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_14 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_14 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_14

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_14 and arg_356_1.time_ < var_359_6 + var_359_14 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1105006087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1105006087
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1105006088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["115001ui_story"].transform
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.var_.moveOldPos115001ui_story = var_363_0.localPosition
			end

			local var_363_2 = 0.001

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2
				local var_363_4 = Vector3.New(0, 100, 0)

				var_363_0.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos115001ui_story, var_363_4, var_363_3)

				local var_363_5 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_5.x, var_363_5.y, var_363_5.z)

				local var_363_6 = var_363_0.localEulerAngles

				var_363_6.z = 0
				var_363_6.x = 0
				var_363_0.localEulerAngles = var_363_6
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 then
				var_363_0.localPosition = Vector3.New(0, 100, 0)

				local var_363_7 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_7.x, var_363_7.y, var_363_7.z)

				local var_363_8 = var_363_0.localEulerAngles

				var_363_8.z = 0
				var_363_8.x = 0
				var_363_0.localEulerAngles = var_363_8
			end

			local var_363_9 = 0
			local var_363_10 = 0.825

			if var_363_9 < arg_360_1.time_ and arg_360_1.time_ <= var_363_9 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_11 = arg_360_1:GetWordFromCfg(1105006087)
				local var_363_12 = arg_360_1:FormatText(var_363_11.content)

				arg_360_1.text_.text = var_363_12

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_13 = 33
				local var_363_14 = utf8.len(var_363_12)
				local var_363_15 = var_363_13 <= 0 and var_363_10 or var_363_10 * (var_363_14 / var_363_13)

				if var_363_15 > 0 and var_363_10 < var_363_15 then
					arg_360_1.talkMaxDuration = var_363_15

					if var_363_15 + var_363_9 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_15 + var_363_9
					end
				end

				arg_360_1.text_.text = var_363_12
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_16 = math.max(var_363_10, arg_360_1.talkMaxDuration)

			if var_363_9 <= arg_360_1.time_ and arg_360_1.time_ < var_363_9 + var_363_16 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_9) / var_363_16

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_9 + var_363_16 and arg_360_1.time_ < var_363_9 + var_363_16 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play1105006088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1105006088
		arg_364_1.duration_ = 6.83

		local var_364_0 = {
			zh = 5.333,
			CriLanguages = 6.833
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
				arg_364_0:Play1105006089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.35

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[29].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(1105006088)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 14
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006088", "story_v_side_new_1105006.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006088", "story_v_side_new_1105006.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_side_new_1105006", "1105006088", "story_v_side_new_1105006.awb")

						arg_364_1:RecordAudio("1105006088", var_367_9)
						arg_364_1:RecordAudio("1105006088", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006088", "story_v_side_new_1105006.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006088", "story_v_side_new_1105006.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_10 and arg_364_1.time_ < var_367_0 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1105006089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1105006089
		arg_368_1.duration_ = 2

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1105006090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["115001ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect115001ui_story == nil then
				arg_368_1.var_.characterEffect115001ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect115001ui_story and not isNil(var_371_0) then
					arg_368_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect115001ui_story then
				arg_368_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_371_4 = 0

			if var_371_4 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_371_5 = arg_368_1.actors_["115001ui_story"].transform
			local var_371_6 = 0

			if var_371_6 < arg_368_1.time_ and arg_368_1.time_ <= var_371_6 + arg_371_0 then
				arg_368_1.var_.moveOldPos115001ui_story = var_371_5.localPosition
			end

			local var_371_7 = 0.001

			if var_371_6 <= arg_368_1.time_ and arg_368_1.time_ < var_371_6 + var_371_7 then
				local var_371_8 = (arg_368_1.time_ - var_371_6) / var_371_7
				local var_371_9 = Vector3.New(0, -1.033, -6.3)

				var_371_5.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos115001ui_story, var_371_9, var_371_8)

				local var_371_10 = manager.ui.mainCamera.transform.position - var_371_5.position

				var_371_5.forward = Vector3.New(var_371_10.x, var_371_10.y, var_371_10.z)

				local var_371_11 = var_371_5.localEulerAngles

				var_371_11.z = 0
				var_371_11.x = 0
				var_371_5.localEulerAngles = var_371_11
			end

			if arg_368_1.time_ >= var_371_6 + var_371_7 and arg_368_1.time_ < var_371_6 + var_371_7 + arg_371_0 then
				var_371_5.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_371_12 = manager.ui.mainCamera.transform.position - var_371_5.position

				var_371_5.forward = Vector3.New(var_371_12.x, var_371_12.y, var_371_12.z)

				local var_371_13 = var_371_5.localEulerAngles

				var_371_13.z = 0
				var_371_13.x = 0
				var_371_5.localEulerAngles = var_371_13
			end

			local var_371_14 = 0

			if var_371_14 < arg_368_1.time_ and arg_368_1.time_ <= var_371_14 + arg_371_0 then
				arg_368_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_1")
			end

			local var_371_15 = 0
			local var_371_16 = 0.075

			if var_371_15 < arg_368_1.time_ and arg_368_1.time_ <= var_371_15 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_17 = arg_368_1:FormatText(StoryNameCfg[74].name)

				arg_368_1.leftNameTxt_.text = var_371_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_18 = arg_368_1:GetWordFromCfg(1105006089)
				local var_371_19 = arg_368_1:FormatText(var_371_18.content)

				arg_368_1.text_.text = var_371_19

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_20 = 3
				local var_371_21 = utf8.len(var_371_19)
				local var_371_22 = var_371_20 <= 0 and var_371_16 or var_371_16 * (var_371_21 / var_371_20)

				if var_371_22 > 0 and var_371_16 < var_371_22 then
					arg_368_1.talkMaxDuration = var_371_22

					if var_371_22 + var_371_15 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_22 + var_371_15
					end
				end

				arg_368_1.text_.text = var_371_19
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006089", "story_v_side_new_1105006.awb") ~= 0 then
					local var_371_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006089", "story_v_side_new_1105006.awb") / 1000

					if var_371_23 + var_371_15 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_23 + var_371_15
					end

					if var_371_18.prefab_name ~= "" and arg_368_1.actors_[var_371_18.prefab_name] ~= nil then
						local var_371_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_18.prefab_name].transform, "story_v_side_new_1105006", "1105006089", "story_v_side_new_1105006.awb")

						arg_368_1:RecordAudio("1105006089", var_371_24)
						arg_368_1:RecordAudio("1105006089", var_371_24)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006089", "story_v_side_new_1105006.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006089", "story_v_side_new_1105006.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_25 = math.max(var_371_16, arg_368_1.talkMaxDuration)

			if var_371_15 <= arg_368_1.time_ and arg_368_1.time_ < var_371_15 + var_371_25 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_15) / var_371_25

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_15 + var_371_25 and arg_368_1.time_ < var_371_15 + var_371_25 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play1105006090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1105006090
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1105006091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["115001ui_story"].transform
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.var_.moveOldPos115001ui_story = var_375_0.localPosition
			end

			local var_375_2 = 0.001

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2
				local var_375_4 = Vector3.New(0, 100, 0)

				var_375_0.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos115001ui_story, var_375_4, var_375_3)

				local var_375_5 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_5.x, var_375_5.y, var_375_5.z)

				local var_375_6 = var_375_0.localEulerAngles

				var_375_6.z = 0
				var_375_6.x = 0
				var_375_0.localEulerAngles = var_375_6
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 then
				var_375_0.localPosition = Vector3.New(0, 100, 0)

				local var_375_7 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_7.x, var_375_7.y, var_375_7.z)

				local var_375_8 = var_375_0.localEulerAngles

				var_375_8.z = 0
				var_375_8.x = 0
				var_375_0.localEulerAngles = var_375_8
			end

			local var_375_9 = 1.9
			local var_375_10 = 1

			if var_375_9 < arg_372_1.time_ and arg_372_1.time_ <= var_375_9 + arg_375_0 then
				local var_375_11 = "play"
				local var_375_12 = "effect"

				arg_372_1:AudioAction(var_375_11, var_375_12, "se_story_side_1050", "se_story_side_1050_handtouch1", "")
			end

			local var_375_13 = 0
			local var_375_14 = 1.025

			if var_375_13 < arg_372_1.time_ and arg_372_1.time_ <= var_375_13 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_15 = arg_372_1:GetWordFromCfg(1105006090)
				local var_375_16 = arg_372_1:FormatText(var_375_15.content)

				arg_372_1.text_.text = var_375_16

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_17 = 41
				local var_375_18 = utf8.len(var_375_16)
				local var_375_19 = var_375_17 <= 0 and var_375_14 or var_375_14 * (var_375_18 / var_375_17)

				if var_375_19 > 0 and var_375_14 < var_375_19 then
					arg_372_1.talkMaxDuration = var_375_19

					if var_375_19 + var_375_13 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_19 + var_375_13
					end
				end

				arg_372_1.text_.text = var_375_16
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_20 = math.max(var_375_14, arg_372_1.talkMaxDuration)

			if var_375_13 <= arg_372_1.time_ and arg_372_1.time_ < var_375_13 + var_375_20 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_13) / var_375_20

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_13 + var_375_20 and arg_372_1.time_ < var_375_13 + var_375_20 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play1105006091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1105006091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1105006092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.475

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_2 = arg_376_1:FormatText(StoryNameCfg[7].name)

				arg_376_1.leftNameTxt_.text = var_379_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_3 = arg_376_1:GetWordFromCfg(1105006091)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 19
				local var_379_6 = utf8.len(var_379_4)
				local var_379_7 = var_379_5 <= 0 and var_379_1 or var_379_1 * (var_379_6 / var_379_5)

				if var_379_7 > 0 and var_379_1 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_4
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_8 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_8 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_8

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_8 and arg_376_1.time_ < var_379_0 + var_379_8 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1105006092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1105006092
		arg_380_1.duration_ = 2

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1105006093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["115001ui_story"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect115001ui_story == nil then
				arg_380_1.var_.characterEffect115001ui_story = var_383_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.200000002980232

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.characterEffect115001ui_story and not isNil(var_383_0) then
					arg_380_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect115001ui_story then
				arg_380_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_383_4 = 0

			if var_383_4 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_383_5 = 0

			if var_383_5 < arg_380_1.time_ and arg_380_1.time_ <= var_383_5 + arg_383_0 then
				arg_380_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_383_6 = arg_380_1.actors_["115001ui_story"].transform
			local var_383_7 = 0

			if var_383_7 < arg_380_1.time_ and arg_380_1.time_ <= var_383_7 + arg_383_0 then
				arg_380_1.var_.moveOldPos115001ui_story = var_383_6.localPosition
			end

			local var_383_8 = 0.001

			if var_383_7 <= arg_380_1.time_ and arg_380_1.time_ < var_383_7 + var_383_8 then
				local var_383_9 = (arg_380_1.time_ - var_383_7) / var_383_8
				local var_383_10 = Vector3.New(0, -1.033, -6.3)

				var_383_6.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos115001ui_story, var_383_10, var_383_9)

				local var_383_11 = manager.ui.mainCamera.transform.position - var_383_6.position

				var_383_6.forward = Vector3.New(var_383_11.x, var_383_11.y, var_383_11.z)

				local var_383_12 = var_383_6.localEulerAngles

				var_383_12.z = 0
				var_383_12.x = 0
				var_383_6.localEulerAngles = var_383_12
			end

			if arg_380_1.time_ >= var_383_7 + var_383_8 and arg_380_1.time_ < var_383_7 + var_383_8 + arg_383_0 then
				var_383_6.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_383_13 = manager.ui.mainCamera.transform.position - var_383_6.position

				var_383_6.forward = Vector3.New(var_383_13.x, var_383_13.y, var_383_13.z)

				local var_383_14 = var_383_6.localEulerAngles

				var_383_14.z = 0
				var_383_14.x = 0
				var_383_6.localEulerAngles = var_383_14
			end

			local var_383_15 = 0
			local var_383_16 = 0.275

			if var_383_15 < arg_380_1.time_ and arg_380_1.time_ <= var_383_15 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_17 = arg_380_1:FormatText(StoryNameCfg[74].name)

				arg_380_1.leftNameTxt_.text = var_383_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_18 = arg_380_1:GetWordFromCfg(1105006092)
				local var_383_19 = arg_380_1:FormatText(var_383_18.content)

				arg_380_1.text_.text = var_383_19

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_20 = 11
				local var_383_21 = utf8.len(var_383_19)
				local var_383_22 = var_383_20 <= 0 and var_383_16 or var_383_16 * (var_383_21 / var_383_20)

				if var_383_22 > 0 and var_383_16 < var_383_22 then
					arg_380_1.talkMaxDuration = var_383_22

					if var_383_22 + var_383_15 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_22 + var_383_15
					end
				end

				arg_380_1.text_.text = var_383_19
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006092", "story_v_side_new_1105006.awb") ~= 0 then
					local var_383_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006092", "story_v_side_new_1105006.awb") / 1000

					if var_383_23 + var_383_15 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_23 + var_383_15
					end

					if var_383_18.prefab_name ~= "" and arg_380_1.actors_[var_383_18.prefab_name] ~= nil then
						local var_383_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_18.prefab_name].transform, "story_v_side_new_1105006", "1105006092", "story_v_side_new_1105006.awb")

						arg_380_1:RecordAudio("1105006092", var_383_24)
						arg_380_1:RecordAudio("1105006092", var_383_24)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006092", "story_v_side_new_1105006.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006092", "story_v_side_new_1105006.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_25 = math.max(var_383_16, arg_380_1.talkMaxDuration)

			if var_383_15 <= arg_380_1.time_ and arg_380_1.time_ < var_383_15 + var_383_25 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_15) / var_383_25

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_15 + var_383_25 and arg_380_1.time_ < var_383_15 + var_383_25 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play1105006093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1105006093
		arg_384_1.duration_ = 7.7

		local var_384_0 = {
			zh = 7.7,
			CriLanguages = 6.633
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1105006094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["115001ui_story"].transform
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.var_.moveOldPos115001ui_story = var_387_0.localPosition
			end

			local var_387_2 = 0.001

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2
				local var_387_4 = Vector3.New(0, 100, 0)

				var_387_0.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos115001ui_story, var_387_4, var_387_3)

				local var_387_5 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_5.x, var_387_5.y, var_387_5.z)

				local var_387_6 = var_387_0.localEulerAngles

				var_387_6.z = 0
				var_387_6.x = 0
				var_387_0.localEulerAngles = var_387_6
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 then
				var_387_0.localPosition = Vector3.New(0, 100, 0)

				local var_387_7 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_7.x, var_387_7.y, var_387_7.z)

				local var_387_8 = var_387_0.localEulerAngles

				var_387_8.z = 0
				var_387_8.x = 0
				var_387_0.localEulerAngles = var_387_8
			end

			local var_387_9 = 0
			local var_387_10 = 0.35

			if var_387_9 < arg_384_1.time_ and arg_384_1.time_ <= var_387_9 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_11 = arg_384_1:FormatText(StoryNameCfg[29].name)

				arg_384_1.leftNameTxt_.text = var_387_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_12 = arg_384_1:GetWordFromCfg(1105006093)
				local var_387_13 = arg_384_1:FormatText(var_387_12.content)

				arg_384_1.text_.text = var_387_13

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_14 = 14
				local var_387_15 = utf8.len(var_387_13)
				local var_387_16 = var_387_14 <= 0 and var_387_10 or var_387_10 * (var_387_15 / var_387_14)

				if var_387_16 > 0 and var_387_10 < var_387_16 then
					arg_384_1.talkMaxDuration = var_387_16

					if var_387_16 + var_387_9 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_16 + var_387_9
					end
				end

				arg_384_1.text_.text = var_387_13
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006093", "story_v_side_new_1105006.awb") ~= 0 then
					local var_387_17 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006093", "story_v_side_new_1105006.awb") / 1000

					if var_387_17 + var_387_9 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_17 + var_387_9
					end

					if var_387_12.prefab_name ~= "" and arg_384_1.actors_[var_387_12.prefab_name] ~= nil then
						local var_387_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_12.prefab_name].transform, "story_v_side_new_1105006", "1105006093", "story_v_side_new_1105006.awb")

						arg_384_1:RecordAudio("1105006093", var_387_18)
						arg_384_1:RecordAudio("1105006093", var_387_18)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006093", "story_v_side_new_1105006.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006093", "story_v_side_new_1105006.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_19 = math.max(var_387_10, arg_384_1.talkMaxDuration)

			if var_387_9 <= arg_384_1.time_ and arg_384_1.time_ < var_387_9 + var_387_19 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_9) / var_387_19

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_9 + var_387_19 and arg_384_1.time_ < var_387_9 + var_387_19 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play1105006094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1105006094
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1105006095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 1.5
			local var_391_1 = 1

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				local var_391_2 = "play"
				local var_391_3 = "effect"

				arg_388_1:AudioAction(var_391_2, var_391_3, "se_story_side_1050", "se_story_side_1050_handtouch2", "")
			end

			local var_391_4 = 0
			local var_391_5 = 1.75

			if var_391_4 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_6 = arg_388_1:GetWordFromCfg(1105006094)
				local var_391_7 = arg_388_1:FormatText(var_391_6.content)

				arg_388_1.text_.text = var_391_7

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_8 = 70
				local var_391_9 = utf8.len(var_391_7)
				local var_391_10 = var_391_8 <= 0 and var_391_5 or var_391_5 * (var_391_9 / var_391_8)

				if var_391_10 > 0 and var_391_5 < var_391_10 then
					arg_388_1.talkMaxDuration = var_391_10

					if var_391_10 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_4
					end
				end

				arg_388_1.text_.text = var_391_7
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_11 = math.max(var_391_5, arg_388_1.talkMaxDuration)

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_11 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_4) / var_391_11

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_4 + var_391_11 and arg_388_1.time_ < var_391_4 + var_391_11 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play1105006095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1105006095
		arg_392_1.duration_ = 2

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1105006096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["115001ui_story"].transform
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.var_.moveOldPos115001ui_story = var_395_0.localPosition
			end

			local var_395_2 = 0.001

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2
				local var_395_4 = Vector3.New(0, -1.033, -6.3)

				var_395_0.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos115001ui_story, var_395_4, var_395_3)

				local var_395_5 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_5.x, var_395_5.y, var_395_5.z)

				local var_395_6 = var_395_0.localEulerAngles

				var_395_6.z = 0
				var_395_6.x = 0
				var_395_0.localEulerAngles = var_395_6
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 then
				var_395_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_395_7 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_7.x, var_395_7.y, var_395_7.z)

				local var_395_8 = var_395_0.localEulerAngles

				var_395_8.z = 0
				var_395_8.x = 0
				var_395_0.localEulerAngles = var_395_8
			end

			local var_395_9 = arg_392_1.actors_["115001ui_story"]
			local var_395_10 = 0

			if var_395_10 < arg_392_1.time_ and arg_392_1.time_ <= var_395_10 + arg_395_0 and not isNil(var_395_9) and arg_392_1.var_.characterEffect115001ui_story == nil then
				arg_392_1.var_.characterEffect115001ui_story = var_395_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_11 = 0.200000002980232

			if var_395_10 <= arg_392_1.time_ and arg_392_1.time_ < var_395_10 + var_395_11 and not isNil(var_395_9) then
				local var_395_12 = (arg_392_1.time_ - var_395_10) / var_395_11

				if arg_392_1.var_.characterEffect115001ui_story and not isNil(var_395_9) then
					arg_392_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_10 + var_395_11 and arg_392_1.time_ < var_395_10 + var_395_11 + arg_395_0 and not isNil(var_395_9) and arg_392_1.var_.characterEffect115001ui_story then
				arg_392_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_395_13 = 0

			if var_395_13 < arg_392_1.time_ and arg_392_1.time_ <= var_395_13 + arg_395_0 then
				arg_392_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_395_14 = 0

			if var_395_14 < arg_392_1.time_ and arg_392_1.time_ <= var_395_14 + arg_395_0 then
				arg_392_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			local var_395_15 = 0
			local var_395_16 = 0.1

			if var_395_15 < arg_392_1.time_ and arg_392_1.time_ <= var_395_15 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_17 = arg_392_1:FormatText(StoryNameCfg[74].name)

				arg_392_1.leftNameTxt_.text = var_395_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_18 = arg_392_1:GetWordFromCfg(1105006095)
				local var_395_19 = arg_392_1:FormatText(var_395_18.content)

				arg_392_1.text_.text = var_395_19

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_20 = 4
				local var_395_21 = utf8.len(var_395_19)
				local var_395_22 = var_395_20 <= 0 and var_395_16 or var_395_16 * (var_395_21 / var_395_20)

				if var_395_22 > 0 and var_395_16 < var_395_22 then
					arg_392_1.talkMaxDuration = var_395_22

					if var_395_22 + var_395_15 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_22 + var_395_15
					end
				end

				arg_392_1.text_.text = var_395_19
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006095", "story_v_side_new_1105006.awb") ~= 0 then
					local var_395_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006095", "story_v_side_new_1105006.awb") / 1000

					if var_395_23 + var_395_15 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_23 + var_395_15
					end

					if var_395_18.prefab_name ~= "" and arg_392_1.actors_[var_395_18.prefab_name] ~= nil then
						local var_395_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_18.prefab_name].transform, "story_v_side_new_1105006", "1105006095", "story_v_side_new_1105006.awb")

						arg_392_1:RecordAudio("1105006095", var_395_24)
						arg_392_1:RecordAudio("1105006095", var_395_24)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006095", "story_v_side_new_1105006.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006095", "story_v_side_new_1105006.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_25 = math.max(var_395_16, arg_392_1.talkMaxDuration)

			if var_395_15 <= arg_392_1.time_ and arg_392_1.time_ < var_395_15 + var_395_25 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_15) / var_395_25

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_15 + var_395_25 and arg_392_1.time_ < var_395_15 + var_395_25 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play1105006096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1105006096
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1105006097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["115001ui_story"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos115001ui_story = var_399_0.localPosition
			end

			local var_399_2 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2
				local var_399_4 = Vector3.New(0, 100, 0)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos115001ui_story, var_399_4, var_399_3)

				local var_399_5 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_5.x, var_399_5.y, var_399_5.z)

				local var_399_6 = var_399_0.localEulerAngles

				var_399_6.z = 0
				var_399_6.x = 0
				var_399_0.localEulerAngles = var_399_6
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(0, 100, 0)

				local var_399_7 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_7.x, var_399_7.y, var_399_7.z)

				local var_399_8 = var_399_0.localEulerAngles

				var_399_8.z = 0
				var_399_8.x = 0
				var_399_0.localEulerAngles = var_399_8
			end

			local var_399_9 = 0
			local var_399_10 = 0.55

			if var_399_9 < arg_396_1.time_ and arg_396_1.time_ <= var_399_9 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_11 = arg_396_1:FormatText(StoryNameCfg[7].name)

				arg_396_1.leftNameTxt_.text = var_399_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_12 = arg_396_1:GetWordFromCfg(1105006096)
				local var_399_13 = arg_396_1:FormatText(var_399_12.content)

				arg_396_1.text_.text = var_399_13

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_14 = 22
				local var_399_15 = utf8.len(var_399_13)
				local var_399_16 = var_399_14 <= 0 and var_399_10 or var_399_10 * (var_399_15 / var_399_14)

				if var_399_16 > 0 and var_399_10 < var_399_16 then
					arg_396_1.talkMaxDuration = var_399_16

					if var_399_16 + var_399_9 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_16 + var_399_9
					end
				end

				arg_396_1.text_.text = var_399_13
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_17 = math.max(var_399_10, arg_396_1.talkMaxDuration)

			if var_399_9 <= arg_396_1.time_ and arg_396_1.time_ < var_399_9 + var_399_17 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_9) / var_399_17

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_9 + var_399_17 and arg_396_1.time_ < var_399_9 + var_399_17 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play1105006097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1105006097
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1105006098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 1.175

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_2 = arg_400_1:GetWordFromCfg(1105006097)
				local var_403_3 = arg_400_1:FormatText(var_403_2.content)

				arg_400_1.text_.text = var_403_3

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_4 = 47
				local var_403_5 = utf8.len(var_403_3)
				local var_403_6 = var_403_4 <= 0 and var_403_1 or var_403_1 * (var_403_5 / var_403_4)

				if var_403_6 > 0 and var_403_1 < var_403_6 then
					arg_400_1.talkMaxDuration = var_403_6

					if var_403_6 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_6 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_3
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_7 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_7 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_7

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_7 and arg_400_1.time_ < var_403_0 + var_403_7 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play1105006098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1105006098
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1105006099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 0.55

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_2 = arg_404_1:GetWordFromCfg(1105006098)
				local var_407_3 = arg_404_1:FormatText(var_407_2.content)

				arg_404_1.text_.text = var_407_3

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 22
				local var_407_5 = utf8.len(var_407_3)
				local var_407_6 = var_407_4 <= 0 and var_407_1 or var_407_1 * (var_407_5 / var_407_4)

				if var_407_6 > 0 and var_407_1 < var_407_6 then
					arg_404_1.talkMaxDuration = var_407_6

					if var_407_6 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_6 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_3
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_7 and arg_404_1.time_ < var_407_0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play1105006099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1105006099
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1105006100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 1.2

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_2 = arg_408_1:GetWordFromCfg(1105006099)
				local var_411_3 = arg_408_1:FormatText(var_411_2.content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 48
				local var_411_5 = utf8.len(var_411_3)
				local var_411_6 = var_411_4 <= 0 and var_411_1 or var_411_1 * (var_411_5 / var_411_4)

				if var_411_6 > 0 and var_411_1 < var_411_6 then
					arg_408_1.talkMaxDuration = var_411_6

					if var_411_6 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_6 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_7 and arg_408_1.time_ < var_411_0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1105006100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1105006100
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1105006101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.35

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_2 = arg_412_1:GetWordFromCfg(1105006100)
				local var_415_3 = arg_412_1:FormatText(var_415_2.content)

				arg_412_1.text_.text = var_415_3

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 14
				local var_415_5 = utf8.len(var_415_3)
				local var_415_6 = var_415_4 <= 0 and var_415_1 or var_415_1 * (var_415_5 / var_415_4)

				if var_415_6 > 0 and var_415_1 < var_415_6 then
					arg_412_1.talkMaxDuration = var_415_6

					if var_415_6 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_6 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_3
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_7 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_7 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_7

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_7 and arg_412_1.time_ < var_415_0 + var_415_7 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1105006101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1105006101
		arg_416_1.duration_ = 7.6

		local var_416_0 = {
			zh = 6.766,
			CriLanguages = 7.6
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1105006102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.35

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[29].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_3 = arg_416_1:GetWordFromCfg(1105006101)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 14
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006101", "story_v_side_new_1105006.awb") ~= 0 then
					local var_419_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006101", "story_v_side_new_1105006.awb") / 1000

					if var_419_8 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_0
					end

					if var_419_3.prefab_name ~= "" and arg_416_1.actors_[var_419_3.prefab_name] ~= nil then
						local var_419_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_3.prefab_name].transform, "story_v_side_new_1105006", "1105006101", "story_v_side_new_1105006.awb")

						arg_416_1:RecordAudio("1105006101", var_419_9)
						arg_416_1:RecordAudio("1105006101", var_419_9)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006101", "story_v_side_new_1105006.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006101", "story_v_side_new_1105006.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_10 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_10 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_10

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_10 and arg_416_1.time_ < var_419_0 + var_419_10 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1105006102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1105006102
		arg_420_1.duration_ = 2

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1105006103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_423_1 = arg_420_1.actors_["115001ui_story"].transform
			local var_423_2 = 0

			if var_423_2 < arg_420_1.time_ and arg_420_1.time_ <= var_423_2 + arg_423_0 then
				arg_420_1.var_.moveOldPos115001ui_story = var_423_1.localPosition
			end

			local var_423_3 = 0.001

			if var_423_2 <= arg_420_1.time_ and arg_420_1.time_ < var_423_2 + var_423_3 then
				local var_423_4 = (arg_420_1.time_ - var_423_2) / var_423_3
				local var_423_5 = Vector3.New(0, -1.033, -6.3)

				var_423_1.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos115001ui_story, var_423_5, var_423_4)

				local var_423_6 = manager.ui.mainCamera.transform.position - var_423_1.position

				var_423_1.forward = Vector3.New(var_423_6.x, var_423_6.y, var_423_6.z)

				local var_423_7 = var_423_1.localEulerAngles

				var_423_7.z = 0
				var_423_7.x = 0
				var_423_1.localEulerAngles = var_423_7
			end

			if arg_420_1.time_ >= var_423_2 + var_423_3 and arg_420_1.time_ < var_423_2 + var_423_3 + arg_423_0 then
				var_423_1.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_423_8 = manager.ui.mainCamera.transform.position - var_423_1.position

				var_423_1.forward = Vector3.New(var_423_8.x, var_423_8.y, var_423_8.z)

				local var_423_9 = var_423_1.localEulerAngles

				var_423_9.z = 0
				var_423_9.x = 0
				var_423_1.localEulerAngles = var_423_9
			end

			local var_423_10 = 0

			if var_423_10 < arg_420_1.time_ and arg_420_1.time_ <= var_423_10 + arg_423_0 then
				arg_420_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_423_11 = arg_420_1.actors_["115001ui_story"]
			local var_423_12 = 0

			if var_423_12 < arg_420_1.time_ and arg_420_1.time_ <= var_423_12 + arg_423_0 and not isNil(var_423_11) and arg_420_1.var_.characterEffect115001ui_story == nil then
				arg_420_1.var_.characterEffect115001ui_story = var_423_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_13 = 0.200000002980232

			if var_423_12 <= arg_420_1.time_ and arg_420_1.time_ < var_423_12 + var_423_13 and not isNil(var_423_11) then
				local var_423_14 = (arg_420_1.time_ - var_423_12) / var_423_13

				if arg_420_1.var_.characterEffect115001ui_story and not isNil(var_423_11) then
					arg_420_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_12 + var_423_13 and arg_420_1.time_ < var_423_12 + var_423_13 + arg_423_0 and not isNil(var_423_11) and arg_420_1.var_.characterEffect115001ui_story then
				arg_420_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_423_15 = 0
			local var_423_16 = 0.125

			if var_423_15 < arg_420_1.time_ and arg_420_1.time_ <= var_423_15 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_17 = arg_420_1:FormatText(StoryNameCfg[374].name)

				arg_420_1.leftNameTxt_.text = var_423_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_18 = arg_420_1:GetWordFromCfg(1105006102)
				local var_423_19 = arg_420_1:FormatText(var_423_18.content)

				arg_420_1.text_.text = var_423_19

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_20 = 5
				local var_423_21 = utf8.len(var_423_19)
				local var_423_22 = var_423_20 <= 0 and var_423_16 or var_423_16 * (var_423_21 / var_423_20)

				if var_423_22 > 0 and var_423_16 < var_423_22 then
					arg_420_1.talkMaxDuration = var_423_22

					if var_423_22 + var_423_15 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_22 + var_423_15
					end
				end

				arg_420_1.text_.text = var_423_19
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006102", "story_v_side_new_1105006.awb") ~= 0 then
					local var_423_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006102", "story_v_side_new_1105006.awb") / 1000

					if var_423_23 + var_423_15 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_23 + var_423_15
					end

					if var_423_18.prefab_name ~= "" and arg_420_1.actors_[var_423_18.prefab_name] ~= nil then
						local var_423_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_18.prefab_name].transform, "story_v_side_new_1105006", "1105006102", "story_v_side_new_1105006.awb")

						arg_420_1:RecordAudio("1105006102", var_423_24)
						arg_420_1:RecordAudio("1105006102", var_423_24)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006102", "story_v_side_new_1105006.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006102", "story_v_side_new_1105006.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_25 = math.max(var_423_16, arg_420_1.talkMaxDuration)

			if var_423_15 <= arg_420_1.time_ and arg_420_1.time_ < var_423_15 + var_423_25 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_15) / var_423_25

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_15 + var_423_25 and arg_420_1.time_ < var_423_15 + var_423_25 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play1105006103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1105006103
		arg_424_1.duration_ = 6

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1105006104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = manager.ui.mainCamera.transform
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.var_.shakeOldPos = var_427_0.localPosition
			end

			local var_427_2 = 0.833333333333333

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / 0.066
				local var_427_4, var_427_5 = math.modf(var_427_3)

				var_427_0.localPosition = Vector3.New(var_427_5 * 0.13, var_427_5 * 0.13, var_427_5 * 0.13) + arg_424_1.var_.shakeOldPos
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 then
				var_427_0.localPosition = arg_424_1.var_.shakeOldPos
			end

			local var_427_6 = 0
			local var_427_7 = 0.200000002980232

			if var_427_6 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				local var_427_8 = "play"
				local var_427_9 = "music"

				arg_424_1:AudioAction(var_427_8, var_427_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_427_10 = ""
				local var_427_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_427_11 ~= "" then
					if arg_424_1.bgmTxt_.text ~= var_427_11 and arg_424_1.bgmTxt_.text ~= "" then
						if arg_424_1.bgmTxt2_.text ~= "" then
							arg_424_1.bgmTxt_.text = arg_424_1.bgmTxt2_.text
						end

						arg_424_1.bgmTxt2_.text = var_427_11

						arg_424_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_424_1.bgmTxt_.text = var_427_11
						arg_424_1.bgmTxt2_.text = var_427_11
					end

					if arg_424_1.bgmTimer then
						arg_424_1.bgmTimer:Stop()

						arg_424_1.bgmTimer = nil
					end

					if arg_424_1.settingData.show_music_name == 1 then
						arg_424_1.musicController:SetSelectedState("show")
						arg_424_1.musicAnimator_:Play("open", 0, 0)

						if arg_424_1.settingData.music_time ~= 0 then
							arg_424_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_424_1.settingData.music_time), function()
								if arg_424_1 == nil or isNil(arg_424_1.bgmTxt_) then
									return
								end

								arg_424_1.musicController:SetSelectedState("hide")
								arg_424_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_427_12 = 0

			if var_427_12 < arg_424_1.time_ and arg_424_1.time_ <= var_427_12 + arg_427_0 then
				arg_424_1.allBtn_.enabled = false
			end

			local var_427_13 = 1

			if arg_424_1.time_ >= var_427_12 + var_427_13 and arg_424_1.time_ < var_427_12 + var_427_13 + arg_427_0 then
				arg_424_1.allBtn_.enabled = true
			end

			local var_427_14 = arg_424_1.actors_["115001ui_story"].transform
			local var_427_15 = 0

			if var_427_15 < arg_424_1.time_ and arg_424_1.time_ <= var_427_15 + arg_427_0 then
				arg_424_1.var_.moveOldPos115001ui_story = var_427_14.localPosition
			end

			local var_427_16 = 0.001

			if var_427_15 <= arg_424_1.time_ and arg_424_1.time_ < var_427_15 + var_427_16 then
				local var_427_17 = (arg_424_1.time_ - var_427_15) / var_427_16
				local var_427_18 = Vector3.New(0, 100, 0)

				var_427_14.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos115001ui_story, var_427_18, var_427_17)

				local var_427_19 = manager.ui.mainCamera.transform.position - var_427_14.position

				var_427_14.forward = Vector3.New(var_427_19.x, var_427_19.y, var_427_19.z)

				local var_427_20 = var_427_14.localEulerAngles

				var_427_20.z = 0
				var_427_20.x = 0
				var_427_14.localEulerAngles = var_427_20
			end

			if arg_424_1.time_ >= var_427_15 + var_427_16 and arg_424_1.time_ < var_427_15 + var_427_16 + arg_427_0 then
				var_427_14.localPosition = Vector3.New(0, 100, 0)

				local var_427_21 = manager.ui.mainCamera.transform.position - var_427_14.position

				var_427_14.forward = Vector3.New(var_427_21.x, var_427_21.y, var_427_21.z)

				local var_427_22 = var_427_14.localEulerAngles

				var_427_22.z = 0
				var_427_22.x = 0
				var_427_14.localEulerAngles = var_427_22
			end

			if arg_424_1.frameCnt_ <= 1 then
				arg_424_1.dialog_:SetActive(false)
			end

			local var_427_23 = 1
			local var_427_24 = 0.775

			if var_427_23 < arg_424_1.time_ and arg_424_1.time_ <= var_427_23 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0

				arg_424_1.dialog_:SetActive(true)

				arg_424_1.dialogCg_.alpha = 0

				local var_427_25 = LeanTween.value(arg_424_1.dialog_, 0, 1, 0.3)

				var_427_25:setOnUpdate(LuaHelper.FloatAction(function(arg_429_0)
					arg_424_1.dialogCg_.alpha = arg_429_0
				end))
				var_427_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_424_1.dialog_)
					var_427_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_424_1.duration_ = arg_424_1.duration_ + 0.3

				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_26 = arg_424_1:GetWordFromCfg(1105006103)
				local var_427_27 = arg_424_1:FormatText(var_427_26.content)

				arg_424_1.text_.text = var_427_27

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_28 = 31
				local var_427_29 = utf8.len(var_427_27)
				local var_427_30 = var_427_28 <= 0 and var_427_24 or var_427_24 * (var_427_29 / var_427_28)

				if var_427_30 > 0 and var_427_24 < var_427_30 then
					arg_424_1.talkMaxDuration = var_427_30
					var_427_23 = var_427_23 + 0.3

					if var_427_30 + var_427_23 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_30 + var_427_23
					end
				end

				arg_424_1.text_.text = var_427_27
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_31 = var_427_23 + 0.3
			local var_427_32 = math.max(var_427_24, arg_424_1.talkMaxDuration)

			if var_427_31 <= arg_424_1.time_ and arg_424_1.time_ < var_427_31 + var_427_32 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_31) / var_427_32

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_31 + var_427_32 and arg_424_1.time_ < var_427_31 + var_427_32 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play1105006104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1105006104
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1105006105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 1.15

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_2 = arg_431_1:GetWordFromCfg(1105006104)
				local var_434_3 = arg_431_1:FormatText(var_434_2.content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_4 = 46
				local var_434_5 = utf8.len(var_434_3)
				local var_434_6 = var_434_4 <= 0 and var_434_1 or var_434_1 * (var_434_5 / var_434_4)

				if var_434_6 > 0 and var_434_1 < var_434_6 then
					arg_431_1.talkMaxDuration = var_434_6

					if var_434_6 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_6 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_7 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_7 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_7

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_7 and arg_431_1.time_ < var_434_0 + var_434_7 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1105006105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1105006105
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1105006106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 1.225

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_2 = arg_435_1:GetWordFromCfg(1105006105)
				local var_438_3 = arg_435_1:FormatText(var_438_2.content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_4 = 49
				local var_438_5 = utf8.len(var_438_3)
				local var_438_6 = var_438_4 <= 0 and var_438_1 or var_438_1 * (var_438_5 / var_438_4)

				if var_438_6 > 0 and var_438_1 < var_438_6 then
					arg_435_1.talkMaxDuration = var_438_6

					if var_438_6 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_6 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_7 and arg_435_1.time_ < var_438_0 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1105006106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1105006106
		arg_439_1.duration_ = 6

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1105006107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = "ST01a_blur"

			if arg_439_1.bgs_[var_442_0] == nil then
				local var_442_1 = Object.Instantiate(arg_439_1.blurPaintGo_)
				local var_442_2 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_442_0)

				var_442_1:GetComponent("SpriteRenderer").sprite = var_442_2
				var_442_1.name = var_442_0
				var_442_1.transform.parent = arg_439_1.stage_.transform
				var_442_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_439_1.bgs_[var_442_0] = var_442_1
			end

			local var_442_3 = 0
			local var_442_4 = arg_439_1.bgs_[var_442_0]

			if var_442_3 < arg_439_1.time_ and arg_439_1.time_ <= var_442_3 + arg_442_0 then
				local var_442_5 = manager.ui.mainCamera.transform.localPosition
				local var_442_6 = Vector3.New(0, 0, 10) + Vector3.New(var_442_5.x, var_442_5.y, 0)

				var_442_4.transform.localPosition = var_442_6
				var_442_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_442_7 = var_442_4:GetComponent("SpriteRenderer")

				if var_442_7 and var_442_7.sprite then
					local var_442_8 = (var_442_4.transform.localPosition - var_442_5).z
					local var_442_9 = manager.ui.mainCameraCom_
					local var_442_10 = 2 * var_442_8 * Mathf.Tan(var_442_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_442_11 = var_442_10 * var_442_9.aspect
					local var_442_12 = var_442_7.sprite.bounds.size.x
					local var_442_13 = var_442_7.sprite.bounds.size.y
					local var_442_14 = var_442_11 / var_442_12
					local var_442_15 = var_442_10 / var_442_13
					local var_442_16 = var_442_15 < var_442_14 and var_442_14 or var_442_15

					var_442_4.transform.localScale = Vector3.New(var_442_16, var_442_16, 0)
				end
			end

			local var_442_17 = 1

			if var_442_3 <= arg_439_1.time_ and arg_439_1.time_ < var_442_3 + var_442_17 then
				local var_442_18 = (arg_439_1.time_ - var_442_3) / var_442_17
				local var_442_19 = Color.New(1, 1, 1)

				var_442_19.a = Mathf.Lerp(0, 1, var_442_18)

				var_442_4:GetComponent("SpriteRenderer").material:SetColor("_Color", var_442_19)
			end

			local var_442_20 = 0

			if var_442_20 < arg_439_1.time_ and arg_439_1.time_ <= var_442_20 + arg_442_0 then
				arg_439_1.allBtn_.enabled = false
			end

			local var_442_21 = 1

			if arg_439_1.time_ >= var_442_20 + var_442_21 and arg_439_1.time_ < var_442_20 + var_442_21 + arg_442_0 then
				arg_439_1.allBtn_.enabled = true
			end

			if arg_439_1.frameCnt_ <= 1 then
				arg_439_1.dialog_:SetActive(false)
			end

			local var_442_22 = 1
			local var_442_23 = 0.525

			if var_442_22 < arg_439_1.time_ and arg_439_1.time_ <= var_442_22 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0

				arg_439_1.dialog_:SetActive(true)

				arg_439_1.dialogCg_.alpha = 0

				local var_442_24 = LeanTween.value(arg_439_1.dialog_, 0, 1, 0.3)

				var_442_24:setOnUpdate(LuaHelper.FloatAction(function(arg_443_0)
					arg_439_1.dialogCg_.alpha = arg_443_0
				end))
				var_442_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_439_1.dialog_)
					var_442_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_439_1.duration_ = arg_439_1.duration_ + 0.3

				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_25 = arg_439_1:GetWordFromCfg(1105006106)
				local var_442_26 = arg_439_1:FormatText(var_442_25.content)

				arg_439_1.text_.text = var_442_26

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_27 = 21
				local var_442_28 = utf8.len(var_442_26)
				local var_442_29 = var_442_27 <= 0 and var_442_23 or var_442_23 * (var_442_28 / var_442_27)

				if var_442_29 > 0 and var_442_23 < var_442_29 then
					arg_439_1.talkMaxDuration = var_442_29
					var_442_22 = var_442_22 + 0.3

					if var_442_29 + var_442_22 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_29 + var_442_22
					end
				end

				arg_439_1.text_.text = var_442_26
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_30 = var_442_22 + 0.3
			local var_442_31 = math.max(var_442_23, arg_439_1.talkMaxDuration)

			if var_442_30 <= arg_439_1.time_ and arg_439_1.time_ < var_442_30 + var_442_31 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_30) / var_442_31

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_30 + var_442_31 and arg_439_1.time_ < var_442_30 + var_442_31 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1105006107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1105006107
		arg_445_1.duration_ = 5.57

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1105006108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.mask_.enabled = true
				arg_445_1.mask_.raycastTarget = false

				arg_445_1:SetGaussion(false)
			end

			local var_448_1 = 0.366666666666667

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_1 then
				local var_448_2 = (arg_445_1.time_ - var_448_0) / var_448_1
				local var_448_3 = Color.New(1, 1, 1)

				var_448_3.a = Mathf.Lerp(1, 0, var_448_2)
				arg_445_1.mask_.color = var_448_3
			end

			if arg_445_1.time_ >= var_448_0 + var_448_1 and arg_445_1.time_ < var_448_0 + var_448_1 + arg_448_0 then
				local var_448_4 = Color.New(1, 1, 1)
				local var_448_5 = 0

				arg_445_1.mask_.enabled = false
				var_448_4.a = var_448_5
				arg_445_1.mask_.color = var_448_4
			end

			local var_448_6 = manager.ui.mainCamera.transform
			local var_448_7 = 0.233333333333333

			if var_448_7 < arg_445_1.time_ and arg_445_1.time_ <= var_448_7 + arg_448_0 then
				arg_445_1.var_.shakeOldPos = var_448_6.localPosition
			end

			local var_448_8 = 0.333333333333333

			if var_448_7 <= arg_445_1.time_ and arg_445_1.time_ < var_448_7 + var_448_8 then
				local var_448_9 = (arg_445_1.time_ - var_448_7) / 0.066
				local var_448_10, var_448_11 = math.modf(var_448_9)

				var_448_6.localPosition = Vector3.New(var_448_11 * 0.13, var_448_11 * 0.13, var_448_11 * 0.13) + arg_445_1.var_.shakeOldPos
			end

			if arg_445_1.time_ >= var_448_7 + var_448_8 and arg_445_1.time_ < var_448_7 + var_448_8 + arg_448_0 then
				var_448_6.localPosition = arg_445_1.var_.shakeOldPos
			end

			local var_448_12 = 0

			if var_448_12 < arg_445_1.time_ and arg_445_1.time_ <= var_448_12 + arg_448_0 then
				arg_445_1.allBtn_.enabled = false
			end

			local var_448_13 = 0.566666666666667

			if arg_445_1.time_ >= var_448_12 + var_448_13 and arg_445_1.time_ < var_448_12 + var_448_13 + arg_448_0 then
				arg_445_1.allBtn_.enabled = true
			end

			if arg_445_1.frameCnt_ <= 1 then
				arg_445_1.dialog_:SetActive(false)
			end

			local var_448_14 = 0.566666666666667
			local var_448_15 = 0.075

			if var_448_14 < arg_445_1.time_ and arg_445_1.time_ <= var_448_14 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0

				arg_445_1.dialog_:SetActive(true)

				arg_445_1.dialogCg_.alpha = 0

				local var_448_16 = LeanTween.value(arg_445_1.dialog_, 0, 1, 0.3)

				var_448_16:setOnUpdate(LuaHelper.FloatAction(function(arg_449_0)
					arg_445_1.dialogCg_.alpha = arg_449_0
				end))
				var_448_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_445_1.dialog_)
					var_448_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_445_1.duration_ = arg_445_1.duration_ + 0.3

				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_17 = arg_445_1:FormatText(StoryNameCfg[7].name)

				arg_445_1.leftNameTxt_.text = var_448_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_18 = arg_445_1:GetWordFromCfg(1105006107)
				local var_448_19 = arg_445_1:FormatText(var_448_18.content)

				arg_445_1.text_.text = var_448_19

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_20 = 3
				local var_448_21 = utf8.len(var_448_19)
				local var_448_22 = var_448_20 <= 0 and var_448_15 or var_448_15 * (var_448_21 / var_448_20)

				if var_448_22 > 0 and var_448_15 < var_448_22 then
					arg_445_1.talkMaxDuration = var_448_22
					var_448_14 = var_448_14 + 0.3

					if var_448_22 + var_448_14 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_22 + var_448_14
					end
				end

				arg_445_1.text_.text = var_448_19
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_23 = var_448_14 + 0.3
			local var_448_24 = math.max(var_448_15, arg_445_1.talkMaxDuration)

			if var_448_23 <= arg_445_1.time_ and arg_445_1.time_ < var_448_23 + var_448_24 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_23) / var_448_24

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_23 + var_448_24 and arg_445_1.time_ < var_448_23 + var_448_24 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1105006108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1105006108
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1105006109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0
			local var_454_1 = 1.375

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_2 = arg_451_1:GetWordFromCfg(1105006108)
				local var_454_3 = arg_451_1:FormatText(var_454_2.content)

				arg_451_1.text_.text = var_454_3

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_4 = 55
				local var_454_5 = utf8.len(var_454_3)
				local var_454_6 = var_454_4 <= 0 and var_454_1 or var_454_1 * (var_454_5 / var_454_4)

				if var_454_6 > 0 and var_454_1 < var_454_6 then
					arg_451_1.talkMaxDuration = var_454_6

					if var_454_6 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_6 + var_454_0
					end
				end

				arg_451_1.text_.text = var_454_3
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_7 = math.max(var_454_1, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_7 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_0) / var_454_7

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_7 and arg_451_1.time_ < var_454_0 + var_454_7 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1105006109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1105006109
		arg_455_1.duration_ = 2.27

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1105006110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["115001ui_story"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect115001ui_story == nil then
				arg_455_1.var_.characterEffect115001ui_story = var_458_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.200000002980232

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 and not isNil(var_458_0) then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.characterEffect115001ui_story and not isNil(var_458_0) then
					arg_455_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect115001ui_story then
				arg_455_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_458_4 = arg_455_1.actors_["115001ui_story"].transform
			local var_458_5 = 0

			if var_458_5 < arg_455_1.time_ and arg_455_1.time_ <= var_458_5 + arg_458_0 then
				arg_455_1.var_.moveOldPos115001ui_story = var_458_4.localPosition
			end

			local var_458_6 = 0.001

			if var_458_5 <= arg_455_1.time_ and arg_455_1.time_ < var_458_5 + var_458_6 then
				local var_458_7 = (arg_455_1.time_ - var_458_5) / var_458_6
				local var_458_8 = Vector3.New(0, -1.033, -6.3)

				var_458_4.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos115001ui_story, var_458_8, var_458_7)

				local var_458_9 = manager.ui.mainCamera.transform.position - var_458_4.position

				var_458_4.forward = Vector3.New(var_458_9.x, var_458_9.y, var_458_9.z)

				local var_458_10 = var_458_4.localEulerAngles

				var_458_10.z = 0
				var_458_10.x = 0
				var_458_4.localEulerAngles = var_458_10
			end

			if arg_455_1.time_ >= var_458_5 + var_458_6 and arg_455_1.time_ < var_458_5 + var_458_6 + arg_458_0 then
				var_458_4.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_458_11 = manager.ui.mainCamera.transform.position - var_458_4.position

				var_458_4.forward = Vector3.New(var_458_11.x, var_458_11.y, var_458_11.z)

				local var_458_12 = var_458_4.localEulerAngles

				var_458_12.z = 0
				var_458_12.x = 0
				var_458_4.localEulerAngles = var_458_12
			end

			local var_458_13 = 0

			if var_458_13 < arg_455_1.time_ and arg_455_1.time_ <= var_458_13 + arg_458_0 then
				arg_455_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_458_14 = 0

			if var_458_14 < arg_455_1.time_ and arg_455_1.time_ <= var_458_14 + arg_458_0 then
				arg_455_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_458_15 = 0
			local var_458_16 = 0.25

			if var_458_15 < arg_455_1.time_ and arg_455_1.time_ <= var_458_15 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_17 = arg_455_1:FormatText(StoryNameCfg[74].name)

				arg_455_1.leftNameTxt_.text = var_458_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_18 = arg_455_1:GetWordFromCfg(1105006109)
				local var_458_19 = arg_455_1:FormatText(var_458_18.content)

				arg_455_1.text_.text = var_458_19

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_20 = 10
				local var_458_21 = utf8.len(var_458_19)
				local var_458_22 = var_458_20 <= 0 and var_458_16 or var_458_16 * (var_458_21 / var_458_20)

				if var_458_22 > 0 and var_458_16 < var_458_22 then
					arg_455_1.talkMaxDuration = var_458_22

					if var_458_22 + var_458_15 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_22 + var_458_15
					end
				end

				arg_455_1.text_.text = var_458_19
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006109", "story_v_side_new_1105006.awb") ~= 0 then
					local var_458_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006109", "story_v_side_new_1105006.awb") / 1000

					if var_458_23 + var_458_15 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_23 + var_458_15
					end

					if var_458_18.prefab_name ~= "" and arg_455_1.actors_[var_458_18.prefab_name] ~= nil then
						local var_458_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_18.prefab_name].transform, "story_v_side_new_1105006", "1105006109", "story_v_side_new_1105006.awb")

						arg_455_1:RecordAudio("1105006109", var_458_24)
						arg_455_1:RecordAudio("1105006109", var_458_24)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006109", "story_v_side_new_1105006.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006109", "story_v_side_new_1105006.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_25 = math.max(var_458_16, arg_455_1.talkMaxDuration)

			if var_458_15 <= arg_455_1.time_ and arg_455_1.time_ < var_458_15 + var_458_25 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_15) / var_458_25

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_15 + var_458_25 and arg_455_1.time_ < var_458_15 + var_458_25 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play1105006110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1105006110
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1105006111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["115001ui_story"].transform
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				arg_459_1.var_.moveOldPos115001ui_story = var_462_0.localPosition
			end

			local var_462_2 = 0.001

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2
				local var_462_4 = Vector3.New(0, 100, 0)

				var_462_0.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos115001ui_story, var_462_4, var_462_3)

				local var_462_5 = manager.ui.mainCamera.transform.position - var_462_0.position

				var_462_0.forward = Vector3.New(var_462_5.x, var_462_5.y, var_462_5.z)

				local var_462_6 = var_462_0.localEulerAngles

				var_462_6.z = 0
				var_462_6.x = 0
				var_462_0.localEulerAngles = var_462_6
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 then
				var_462_0.localPosition = Vector3.New(0, 100, 0)

				local var_462_7 = manager.ui.mainCamera.transform.position - var_462_0.position

				var_462_0.forward = Vector3.New(var_462_7.x, var_462_7.y, var_462_7.z)

				local var_462_8 = var_462_0.localEulerAngles

				var_462_8.z = 0
				var_462_8.x = 0
				var_462_0.localEulerAngles = var_462_8
			end

			local var_462_9 = 0
			local var_462_10 = 0.35

			if var_462_9 < arg_459_1.time_ and arg_459_1.time_ <= var_462_9 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_11 = arg_459_1:GetWordFromCfg(1105006110)
				local var_462_12 = arg_459_1:FormatText(var_462_11.content)

				arg_459_1.text_.text = var_462_12

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_13 = 14
				local var_462_14 = utf8.len(var_462_12)
				local var_462_15 = var_462_13 <= 0 and var_462_10 or var_462_10 * (var_462_14 / var_462_13)

				if var_462_15 > 0 and var_462_10 < var_462_15 then
					arg_459_1.talkMaxDuration = var_462_15

					if var_462_15 + var_462_9 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_15 + var_462_9
					end
				end

				arg_459_1.text_.text = var_462_12
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_16 = math.max(var_462_10, arg_459_1.talkMaxDuration)

			if var_462_9 <= arg_459_1.time_ and arg_459_1.time_ < var_462_9 + var_462_16 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_9) / var_462_16

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_9 + var_462_16 and arg_459_1.time_ < var_462_9 + var_462_16 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play1105006111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1105006111
		arg_463_1.duration_ = 7

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1105006112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 2

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.allBtn_.enabled = false
			end

			local var_466_1 = 0.3

			if arg_463_1.time_ >= var_466_0 + var_466_1 and arg_463_1.time_ < var_466_0 + var_466_1 + arg_466_0 then
				arg_463_1.allBtn_.enabled = true
			end

			local var_466_2 = "R5002"

			if arg_463_1.bgs_[var_466_2] == nil then
				local var_466_3 = Object.Instantiate(arg_463_1.paintGo_)

				var_466_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_466_2)
				var_466_3.name = var_466_2
				var_466_3.transform.parent = arg_463_1.stage_.transform
				var_466_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_463_1.bgs_[var_466_2] = var_466_3
			end

			local var_466_4 = 1

			if var_466_4 < arg_463_1.time_ and arg_463_1.time_ <= var_466_4 + arg_466_0 then
				local var_466_5 = manager.ui.mainCamera.transform.localPosition
				local var_466_6 = Vector3.New(0, 0, 10) + Vector3.New(var_466_5.x, var_466_5.y, 0)
				local var_466_7 = arg_463_1.bgs_.R5002

				var_466_7.transform.localPosition = var_466_6
				var_466_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_466_8 = var_466_7:GetComponent("SpriteRenderer")

				if var_466_8 and var_466_8.sprite then
					local var_466_9 = (var_466_7.transform.localPosition - var_466_5).z
					local var_466_10 = manager.ui.mainCameraCom_
					local var_466_11 = 2 * var_466_9 * Mathf.Tan(var_466_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_466_12 = var_466_11 * var_466_10.aspect
					local var_466_13 = var_466_8.sprite.bounds.size.x
					local var_466_14 = var_466_8.sprite.bounds.size.y
					local var_466_15 = var_466_12 / var_466_13
					local var_466_16 = var_466_11 / var_466_14
					local var_466_17 = var_466_16 < var_466_15 and var_466_15 or var_466_16

					var_466_7.transform.localScale = Vector3.New(var_466_17, var_466_17, 0)
				end

				for iter_466_0, iter_466_1 in pairs(arg_463_1.bgs_) do
					if iter_466_0 ~= "R5002" then
						iter_466_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_466_18 = 0

			if var_466_18 < arg_463_1.time_ and arg_463_1.time_ <= var_466_18 + arg_466_0 then
				arg_463_1.mask_.enabled = true
				arg_463_1.mask_.raycastTarget = true

				arg_463_1:SetGaussion(false)
			end

			local var_466_19 = 1

			if var_466_18 <= arg_463_1.time_ and arg_463_1.time_ < var_466_18 + var_466_19 then
				local var_466_20 = (arg_463_1.time_ - var_466_18) / var_466_19
				local var_466_21 = Color.New(0, 0, 0)

				var_466_21.a = Mathf.Lerp(0, 1, var_466_20)
				arg_463_1.mask_.color = var_466_21
			end

			if arg_463_1.time_ >= var_466_18 + var_466_19 and arg_463_1.time_ < var_466_18 + var_466_19 + arg_466_0 then
				local var_466_22 = Color.New(0, 0, 0)

				var_466_22.a = 1
				arg_463_1.mask_.color = var_466_22
			end

			local var_466_23 = 1

			if var_466_23 < arg_463_1.time_ and arg_463_1.time_ <= var_466_23 + arg_466_0 then
				arg_463_1.mask_.enabled = true
				arg_463_1.mask_.raycastTarget = true

				arg_463_1:SetGaussion(false)
			end

			local var_466_24 = 1

			if var_466_23 <= arg_463_1.time_ and arg_463_1.time_ < var_466_23 + var_466_24 then
				local var_466_25 = (arg_463_1.time_ - var_466_23) / var_466_24
				local var_466_26 = Color.New(0, 0, 0)

				var_466_26.a = Mathf.Lerp(1, 0, var_466_25)
				arg_463_1.mask_.color = var_466_26
			end

			if arg_463_1.time_ >= var_466_23 + var_466_24 and arg_463_1.time_ < var_466_23 + var_466_24 + arg_466_0 then
				local var_466_27 = Color.New(0, 0, 0)
				local var_466_28 = 0

				arg_463_1.mask_.enabled = false
				var_466_27.a = var_466_28
				arg_463_1.mask_.color = var_466_27
			end

			local var_466_29 = 0
			local var_466_30 = 0.200000002980232

			if var_466_29 < arg_463_1.time_ and arg_463_1.time_ <= var_466_29 + arg_466_0 then
				local var_466_31 = "play"
				local var_466_32 = "music"

				arg_463_1:AudioAction(var_466_31, var_466_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_466_33 = ""
				local var_466_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_466_34 ~= "" then
					if arg_463_1.bgmTxt_.text ~= var_466_34 and arg_463_1.bgmTxt_.text ~= "" then
						if arg_463_1.bgmTxt2_.text ~= "" then
							arg_463_1.bgmTxt_.text = arg_463_1.bgmTxt2_.text
						end

						arg_463_1.bgmTxt2_.text = var_466_34

						arg_463_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_463_1.bgmTxt_.text = var_466_34
						arg_463_1.bgmTxt2_.text = var_466_34
					end

					if arg_463_1.bgmTimer then
						arg_463_1.bgmTimer:Stop()

						arg_463_1.bgmTimer = nil
					end

					if arg_463_1.settingData.show_music_name == 1 then
						arg_463_1.musicController:SetSelectedState("show")
						arg_463_1.musicAnimator_:Play("open", 0, 0)

						if arg_463_1.settingData.music_time ~= 0 then
							arg_463_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_463_1.settingData.music_time), function()
								if arg_463_1 == nil or isNil(arg_463_1.bgmTxt_) then
									return
								end

								arg_463_1.musicController:SetSelectedState("hide")
								arg_463_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_466_35 = 0.266666666666667
			local var_466_36 = 1

			if var_466_35 < arg_463_1.time_ and arg_463_1.time_ <= var_466_35 + arg_466_0 then
				local var_466_37 = "play"
				local var_466_38 = "music"

				arg_463_1:AudioAction(var_466_37, var_466_38, "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_466_39 = ""
				local var_466_40 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if var_466_40 ~= "" then
					if arg_463_1.bgmTxt_.text ~= var_466_40 and arg_463_1.bgmTxt_.text ~= "" then
						if arg_463_1.bgmTxt2_.text ~= "" then
							arg_463_1.bgmTxt_.text = arg_463_1.bgmTxt2_.text
						end

						arg_463_1.bgmTxt2_.text = var_466_40

						arg_463_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_463_1.bgmTxt_.text = var_466_40
						arg_463_1.bgmTxt2_.text = var_466_40
					end

					if arg_463_1.bgmTimer then
						arg_463_1.bgmTimer:Stop()

						arg_463_1.bgmTimer = nil
					end

					if arg_463_1.settingData.show_music_name == 1 then
						arg_463_1.musicController:SetSelectedState("show")
						arg_463_1.musicAnimator_:Play("open", 0, 0)

						if arg_463_1.settingData.music_time ~= 0 then
							arg_463_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_463_1.settingData.music_time), function()
								if arg_463_1 == nil or isNil(arg_463_1.bgmTxt_) then
									return
								end

								arg_463_1.musicController:SetSelectedState("hide")
								arg_463_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_466_41 = "R5002_blur"

			if arg_463_1.bgs_[var_466_41] == nil then
				local var_466_42 = Object.Instantiate(arg_463_1.blurPaintGo_)
				local var_466_43 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_466_41)

				var_466_42:GetComponent("SpriteRenderer").sprite = var_466_43
				var_466_42.name = var_466_41
				var_466_42.transform.parent = arg_463_1.stage_.transform
				var_466_42.transform.localPosition = Vector3.New(0, 100, 0)
				arg_463_1.bgs_[var_466_41] = var_466_42
			end

			local var_466_44 = 1
			local var_466_45 = arg_463_1.bgs_[var_466_41]

			if var_466_44 < arg_463_1.time_ and arg_463_1.time_ <= var_466_44 + arg_466_0 then
				local var_466_46 = manager.ui.mainCamera.transform.localPosition
				local var_466_47 = Vector3.New(0, 0, 10) + Vector3.New(var_466_46.x, var_466_46.y, 0)

				var_466_45.transform.localPosition = var_466_47
				var_466_45.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_466_48 = var_466_45:GetComponent("SpriteRenderer")

				if var_466_48 and var_466_48.sprite then
					local var_466_49 = (var_466_45.transform.localPosition - var_466_46).z
					local var_466_50 = manager.ui.mainCameraCom_
					local var_466_51 = 2 * var_466_49 * Mathf.Tan(var_466_50.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_466_52 = var_466_51 * var_466_50.aspect
					local var_466_53 = var_466_48.sprite.bounds.size.x
					local var_466_54 = var_466_48.sprite.bounds.size.y
					local var_466_55 = var_466_52 / var_466_53
					local var_466_56 = var_466_51 / var_466_54
					local var_466_57 = var_466_56 < var_466_55 and var_466_55 or var_466_56

					var_466_45.transform.localScale = Vector3.New(var_466_57, var_466_57, 0)
				end
			end

			local var_466_58 = 1

			if var_466_44 <= arg_463_1.time_ and arg_463_1.time_ < var_466_44 + var_466_58 then
				local var_466_59 = (arg_463_1.time_ - var_466_44) / var_466_58
				local var_466_60 = Color.New(1, 1, 1)

				var_466_60.a = Mathf.Lerp(1, 0, var_466_59)

				var_466_45:GetComponent("SpriteRenderer").material:SetColor("_Color", var_466_60)
			end

			if arg_463_1.frameCnt_ <= 1 then
				arg_463_1.dialog_:SetActive(false)
			end

			local var_466_61 = 2
			local var_466_62 = 0.6

			if var_466_61 < arg_463_1.time_ and arg_463_1.time_ <= var_466_61 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0

				arg_463_1.dialog_:SetActive(true)

				arg_463_1.dialogCg_.alpha = 0

				local var_466_63 = LeanTween.value(arg_463_1.dialog_, 0, 1, 0.3)

				var_466_63:setOnUpdate(LuaHelper.FloatAction(function(arg_469_0)
					arg_463_1.dialogCg_.alpha = arg_469_0
				end))
				var_466_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_463_1.dialog_)
					var_466_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_463_1.duration_ = arg_463_1.duration_ + 0.3

				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_64 = arg_463_1:GetWordFromCfg(1105006111)
				local var_466_65 = arg_463_1:FormatText(var_466_64.content)

				arg_463_1.text_.text = var_466_65

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_66 = 24
				local var_466_67 = utf8.len(var_466_65)
				local var_466_68 = var_466_66 <= 0 and var_466_62 or var_466_62 * (var_466_67 / var_466_66)

				if var_466_68 > 0 and var_466_62 < var_466_68 then
					arg_463_1.talkMaxDuration = var_466_68
					var_466_61 = var_466_61 + 0.3

					if var_466_68 + var_466_61 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_68 + var_466_61
					end
				end

				arg_463_1.text_.text = var_466_65
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_69 = var_466_61 + 0.3
			local var_466_70 = math.max(var_466_62, arg_463_1.talkMaxDuration)

			if var_466_69 <= arg_463_1.time_ and arg_463_1.time_ < var_466_69 + var_466_70 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_69) / var_466_70

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_69 + var_466_70 and arg_463_1.time_ < var_466_69 + var_466_70 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1105006112 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1105006112
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1105006113(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0
			local var_474_1 = 1.325

			if var_474_0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_2 = arg_471_1:GetWordFromCfg(1105006112)
				local var_474_3 = arg_471_1:FormatText(var_474_2.content)

				arg_471_1.text_.text = var_474_3

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 53
				local var_474_5 = utf8.len(var_474_3)
				local var_474_6 = var_474_4 <= 0 and var_474_1 or var_474_1 * (var_474_5 / var_474_4)

				if var_474_6 > 0 and var_474_1 < var_474_6 then
					arg_471_1.talkMaxDuration = var_474_6

					if var_474_6 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_6 + var_474_0
					end
				end

				arg_471_1.text_.text = var_474_3
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_7 = math.max(var_474_1, arg_471_1.talkMaxDuration)

			if var_474_0 <= arg_471_1.time_ and arg_471_1.time_ < var_474_0 + var_474_7 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_0) / var_474_7

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_0 + var_474_7 and arg_471_1.time_ < var_474_0 + var_474_7 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play1105006113 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1105006113
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1105006114(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0
			local var_478_1 = 0.275

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_2 = arg_475_1:FormatText(StoryNameCfg[7].name)

				arg_475_1.leftNameTxt_.text = var_478_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_3 = arg_475_1:GetWordFromCfg(1105006113)
				local var_478_4 = arg_475_1:FormatText(var_478_3.content)

				arg_475_1.text_.text = var_478_4

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_5 = 11
				local var_478_6 = utf8.len(var_478_4)
				local var_478_7 = var_478_5 <= 0 and var_478_1 or var_478_1 * (var_478_6 / var_478_5)

				if var_478_7 > 0 and var_478_1 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_0
					end
				end

				arg_475_1.text_.text = var_478_4
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_8 = math.max(var_478_1, arg_475_1.talkMaxDuration)

			if var_478_0 <= arg_475_1.time_ and arg_475_1.time_ < var_478_0 + var_478_8 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_0) / var_478_8

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_0 + var_478_8 and arg_475_1.time_ < var_478_0 + var_478_8 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play1105006114 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1105006114
		arg_479_1.duration_ = 4.8

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1105006115(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0
			local var_482_1 = 0.375

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_2 = arg_479_1:FormatText(StoryNameCfg[74].name)

				arg_479_1.leftNameTxt_.text = var_482_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_3 = arg_479_1:GetWordFromCfg(1105006114)
				local var_482_4 = arg_479_1:FormatText(var_482_3.content)

				arg_479_1.text_.text = var_482_4

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 15
				local var_482_6 = utf8.len(var_482_4)
				local var_482_7 = var_482_5 <= 0 and var_482_1 or var_482_1 * (var_482_6 / var_482_5)

				if var_482_7 > 0 and var_482_1 < var_482_7 then
					arg_479_1.talkMaxDuration = var_482_7

					if var_482_7 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_0
					end
				end

				arg_479_1.text_.text = var_482_4
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006114", "story_v_side_new_1105006.awb") ~= 0 then
					local var_482_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006114", "story_v_side_new_1105006.awb") / 1000

					if var_482_8 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_8 + var_482_0
					end

					if var_482_3.prefab_name ~= "" and arg_479_1.actors_[var_482_3.prefab_name] ~= nil then
						local var_482_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_3.prefab_name].transform, "story_v_side_new_1105006", "1105006114", "story_v_side_new_1105006.awb")

						arg_479_1:RecordAudio("1105006114", var_482_9)
						arg_479_1:RecordAudio("1105006114", var_482_9)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006114", "story_v_side_new_1105006.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006114", "story_v_side_new_1105006.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_10 = math.max(var_482_1, arg_479_1.talkMaxDuration)

			if var_482_0 <= arg_479_1.time_ and arg_479_1.time_ < var_482_0 + var_482_10 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_0) / var_482_10

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_0 + var_482_10 and arg_479_1.time_ < var_482_0 + var_482_10 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play1105006115 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1105006115
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1105006116(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 1.025

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_2 = arg_483_1:GetWordFromCfg(1105006115)
				local var_486_3 = arg_483_1:FormatText(var_486_2.content)

				arg_483_1.text_.text = var_486_3

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 41
				local var_486_5 = utf8.len(var_486_3)
				local var_486_6 = var_486_4 <= 0 and var_486_1 or var_486_1 * (var_486_5 / var_486_4)

				if var_486_6 > 0 and var_486_1 < var_486_6 then
					arg_483_1.talkMaxDuration = var_486_6

					if var_486_6 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_6 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_3
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_7 and arg_483_1.time_ < var_486_0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play1105006116 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1105006116
		arg_487_1.duration_ = 5.67

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1105006117(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 0.625

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_2 = arg_487_1:FormatText(StoryNameCfg[74].name)

				arg_487_1.leftNameTxt_.text = var_490_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_3 = arg_487_1:GetWordFromCfg(1105006116)
				local var_490_4 = arg_487_1:FormatText(var_490_3.content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 25
				local var_490_6 = utf8.len(var_490_4)
				local var_490_7 = var_490_5 <= 0 and var_490_1 or var_490_1 * (var_490_6 / var_490_5)

				if var_490_7 > 0 and var_490_1 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_4
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006116", "story_v_side_new_1105006.awb") ~= 0 then
					local var_490_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006116", "story_v_side_new_1105006.awb") / 1000

					if var_490_8 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_8 + var_490_0
					end

					if var_490_3.prefab_name ~= "" and arg_487_1.actors_[var_490_3.prefab_name] ~= nil then
						local var_490_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_3.prefab_name].transform, "story_v_side_new_1105006", "1105006116", "story_v_side_new_1105006.awb")

						arg_487_1:RecordAudio("1105006116", var_490_9)
						arg_487_1:RecordAudio("1105006116", var_490_9)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006116", "story_v_side_new_1105006.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006116", "story_v_side_new_1105006.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_10 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_10 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_10

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_10 and arg_487_1.time_ < var_490_0 + var_490_10 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play1105006117 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1105006117
		arg_491_1.duration_ = 7.57

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1105006118(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0
			local var_494_1 = 1.125

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_2 = arg_491_1:FormatText(StoryNameCfg[74].name)

				arg_491_1.leftNameTxt_.text = var_494_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_3 = arg_491_1:GetWordFromCfg(1105006117)
				local var_494_4 = arg_491_1:FormatText(var_494_3.content)

				arg_491_1.text_.text = var_494_4

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 45
				local var_494_6 = utf8.len(var_494_4)
				local var_494_7 = var_494_5 <= 0 and var_494_1 or var_494_1 * (var_494_6 / var_494_5)

				if var_494_7 > 0 and var_494_1 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_0
					end
				end

				arg_491_1.text_.text = var_494_4
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006117", "story_v_side_new_1105006.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006117", "story_v_side_new_1105006.awb") / 1000

					if var_494_8 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_0
					end

					if var_494_3.prefab_name ~= "" and arg_491_1.actors_[var_494_3.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_3.prefab_name].transform, "story_v_side_new_1105006", "1105006117", "story_v_side_new_1105006.awb")

						arg_491_1:RecordAudio("1105006117", var_494_9)
						arg_491_1:RecordAudio("1105006117", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006117", "story_v_side_new_1105006.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006117", "story_v_side_new_1105006.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_10 = math.max(var_494_1, arg_491_1.talkMaxDuration)

			if var_494_0 <= arg_491_1.time_ and arg_491_1.time_ < var_494_0 + var_494_10 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_0) / var_494_10

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_0 + var_494_10 and arg_491_1.time_ < var_494_0 + var_494_10 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play1105006118 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1105006118
		arg_495_1.duration_ = 6.87

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1105006119(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 0.7

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_2 = arg_495_1:FormatText(StoryNameCfg[74].name)

				arg_495_1.leftNameTxt_.text = var_498_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_3 = arg_495_1:GetWordFromCfg(1105006118)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 28
				local var_498_6 = utf8.len(var_498_4)
				local var_498_7 = var_498_5 <= 0 and var_498_1 or var_498_1 * (var_498_6 / var_498_5)

				if var_498_7 > 0 and var_498_1 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006118", "story_v_side_new_1105006.awb") ~= 0 then
					local var_498_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006118", "story_v_side_new_1105006.awb") / 1000

					if var_498_8 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_8 + var_498_0
					end

					if var_498_3.prefab_name ~= "" and arg_495_1.actors_[var_498_3.prefab_name] ~= nil then
						local var_498_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_3.prefab_name].transform, "story_v_side_new_1105006", "1105006118", "story_v_side_new_1105006.awb")

						arg_495_1:RecordAudio("1105006118", var_498_9)
						arg_495_1:RecordAudio("1105006118", var_498_9)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006118", "story_v_side_new_1105006.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006118", "story_v_side_new_1105006.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_10 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_10 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_10

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_10 and arg_495_1.time_ < var_498_0 + var_498_10 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1105006119 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1105006119
		arg_499_1.duration_ = 5.1

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1105006120(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 0.5

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_2 = arg_499_1:FormatText(StoryNameCfg[74].name)

				arg_499_1.leftNameTxt_.text = var_502_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_3 = arg_499_1:GetWordFromCfg(1105006119)
				local var_502_4 = arg_499_1:FormatText(var_502_3.content)

				arg_499_1.text_.text = var_502_4

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_5 = 20
				local var_502_6 = utf8.len(var_502_4)
				local var_502_7 = var_502_5 <= 0 and var_502_1 or var_502_1 * (var_502_6 / var_502_5)

				if var_502_7 > 0 and var_502_1 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_0
					end
				end

				arg_499_1.text_.text = var_502_4
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006119", "story_v_side_new_1105006.awb") ~= 0 then
					local var_502_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006119", "story_v_side_new_1105006.awb") / 1000

					if var_502_8 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_8 + var_502_0
					end

					if var_502_3.prefab_name ~= "" and arg_499_1.actors_[var_502_3.prefab_name] ~= nil then
						local var_502_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_3.prefab_name].transform, "story_v_side_new_1105006", "1105006119", "story_v_side_new_1105006.awb")

						arg_499_1:RecordAudio("1105006119", var_502_9)
						arg_499_1:RecordAudio("1105006119", var_502_9)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006119", "story_v_side_new_1105006.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006119", "story_v_side_new_1105006.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_10 = math.max(var_502_1, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_10 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_0) / var_502_10

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_10 and arg_499_1.time_ < var_502_0 + var_502_10 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play1105006120 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1105006120
		arg_503_1.duration_ = 6.83

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1105006121(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 0.7

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_2 = arg_503_1:FormatText(StoryNameCfg[74].name)

				arg_503_1.leftNameTxt_.text = var_506_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_3 = arg_503_1:GetWordFromCfg(1105006120)
				local var_506_4 = arg_503_1:FormatText(var_506_3.content)

				arg_503_1.text_.text = var_506_4

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 28
				local var_506_6 = utf8.len(var_506_4)
				local var_506_7 = var_506_5 <= 0 and var_506_1 or var_506_1 * (var_506_6 / var_506_5)

				if var_506_7 > 0 and var_506_1 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_4
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006120", "story_v_side_new_1105006.awb") ~= 0 then
					local var_506_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006120", "story_v_side_new_1105006.awb") / 1000

					if var_506_8 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_8 + var_506_0
					end

					if var_506_3.prefab_name ~= "" and arg_503_1.actors_[var_506_3.prefab_name] ~= nil then
						local var_506_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_3.prefab_name].transform, "story_v_side_new_1105006", "1105006120", "story_v_side_new_1105006.awb")

						arg_503_1:RecordAudio("1105006120", var_506_9)
						arg_503_1:RecordAudio("1105006120", var_506_9)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006120", "story_v_side_new_1105006.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006120", "story_v_side_new_1105006.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_10 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_10 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_10

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_10 and arg_503_1.time_ < var_506_0 + var_506_10 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1105006121 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1105006121
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1105006122(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 0.35

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_2 = arg_507_1:FormatText(StoryNameCfg[7].name)

				arg_507_1.leftNameTxt_.text = var_510_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_3 = arg_507_1:GetWordFromCfg(1105006121)
				local var_510_4 = arg_507_1:FormatText(var_510_3.content)

				arg_507_1.text_.text = var_510_4

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 14
				local var_510_6 = utf8.len(var_510_4)
				local var_510_7 = var_510_5 <= 0 and var_510_1 or var_510_1 * (var_510_6 / var_510_5)

				if var_510_7 > 0 and var_510_1 < var_510_7 then
					arg_507_1.talkMaxDuration = var_510_7

					if var_510_7 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_7 + var_510_0
					end
				end

				arg_507_1.text_.text = var_510_4
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_8 = math.max(var_510_1, arg_507_1.talkMaxDuration)

			if var_510_0 <= arg_507_1.time_ and arg_507_1.time_ < var_510_0 + var_510_8 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_0) / var_510_8

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_0 + var_510_8 and arg_507_1.time_ < var_510_0 + var_510_8 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play1105006122 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1105006122
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1105006123(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0
			local var_514_1 = 0.625

			if var_514_0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_2 = arg_511_1:FormatText(StoryNameCfg[7].name)

				arg_511_1.leftNameTxt_.text = var_514_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_3 = arg_511_1:GetWordFromCfg(1105006122)
				local var_514_4 = arg_511_1:FormatText(var_514_3.content)

				arg_511_1.text_.text = var_514_4

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 25
				local var_514_6 = utf8.len(var_514_4)
				local var_514_7 = var_514_5 <= 0 and var_514_1 or var_514_1 * (var_514_6 / var_514_5)

				if var_514_7 > 0 and var_514_1 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_0
					end
				end

				arg_511_1.text_.text = var_514_4
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_8 = math.max(var_514_1, arg_511_1.talkMaxDuration)

			if var_514_0 <= arg_511_1.time_ and arg_511_1.time_ < var_514_0 + var_514_8 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_0) / var_514_8

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_0 + var_514_8 and arg_511_1.time_ < var_514_0 + var_514_8 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1105006123 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1105006123
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1105006124(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0
			local var_518_1 = 0.525

			if var_518_0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_2 = arg_515_1:FormatText(StoryNameCfg[7].name)

				arg_515_1.leftNameTxt_.text = var_518_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_3 = arg_515_1:GetWordFromCfg(1105006123)
				local var_518_4 = arg_515_1:FormatText(var_518_3.content)

				arg_515_1.text_.text = var_518_4

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 21
				local var_518_6 = utf8.len(var_518_4)
				local var_518_7 = var_518_5 <= 0 and var_518_1 or var_518_1 * (var_518_6 / var_518_5)

				if var_518_7 > 0 and var_518_1 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_0
					end
				end

				arg_515_1.text_.text = var_518_4
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_8 = math.max(var_518_1, arg_515_1.talkMaxDuration)

			if var_518_0 <= arg_515_1.time_ and arg_515_1.time_ < var_518_0 + var_518_8 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_0) / var_518_8

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_0 + var_518_8 and arg_515_1.time_ < var_518_0 + var_518_8 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1105006124 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1105006124
		arg_519_1.duration_ = 1.33

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1105006125(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0
			local var_522_1 = 0.125

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_2 = arg_519_1:FormatText(StoryNameCfg[74].name)

				arg_519_1.leftNameTxt_.text = var_522_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_3 = arg_519_1:GetWordFromCfg(1105006124)
				local var_522_4 = arg_519_1:FormatText(var_522_3.content)

				arg_519_1.text_.text = var_522_4

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 5
				local var_522_6 = utf8.len(var_522_4)
				local var_522_7 = var_522_5 <= 0 and var_522_1 or var_522_1 * (var_522_6 / var_522_5)

				if var_522_7 > 0 and var_522_1 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_4
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006124", "story_v_side_new_1105006.awb") ~= 0 then
					local var_522_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006124", "story_v_side_new_1105006.awb") / 1000

					if var_522_8 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_8 + var_522_0
					end

					if var_522_3.prefab_name ~= "" and arg_519_1.actors_[var_522_3.prefab_name] ~= nil then
						local var_522_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_3.prefab_name].transform, "story_v_side_new_1105006", "1105006124", "story_v_side_new_1105006.awb")

						arg_519_1:RecordAudio("1105006124", var_522_9)
						arg_519_1:RecordAudio("1105006124", var_522_9)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006124", "story_v_side_new_1105006.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006124", "story_v_side_new_1105006.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_10 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_10 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_10

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_10 and arg_519_1.time_ < var_522_0 + var_522_10 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1105006125 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1105006125
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1105006126(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 1.075

			if var_526_0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_2 = arg_523_1:FormatText(StoryNameCfg[7].name)

				arg_523_1.leftNameTxt_.text = var_526_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_3 = arg_523_1:GetWordFromCfg(1105006125)
				local var_526_4 = arg_523_1:FormatText(var_526_3.content)

				arg_523_1.text_.text = var_526_4

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 43
				local var_526_6 = utf8.len(var_526_4)
				local var_526_7 = var_526_5 <= 0 and var_526_1 or var_526_1 * (var_526_6 / var_526_5)

				if var_526_7 > 0 and var_526_1 < var_526_7 then
					arg_523_1.talkMaxDuration = var_526_7

					if var_526_7 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_4
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_8 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_8 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_8

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_8 and arg_523_1.time_ < var_526_0 + var_526_8 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1105006126 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1105006126
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1105006127(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 1.05

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_2 = arg_527_1:FormatText(StoryNameCfg[7].name)

				arg_527_1.leftNameTxt_.text = var_530_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_3 = arg_527_1:GetWordFromCfg(1105006126)
				local var_530_4 = arg_527_1:FormatText(var_530_3.content)

				arg_527_1.text_.text = var_530_4

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 42
				local var_530_6 = utf8.len(var_530_4)
				local var_530_7 = var_530_5 <= 0 and var_530_1 or var_530_1 * (var_530_6 / var_530_5)

				if var_530_7 > 0 and var_530_1 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_4
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_8 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_8 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_8

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_8 and arg_527_1.time_ < var_530_0 + var_530_8 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1105006127 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1105006127
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1105006128(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0
			local var_534_1 = 0.275

			if var_534_0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_2 = arg_531_1:FormatText(StoryNameCfg[7].name)

				arg_531_1.leftNameTxt_.text = var_534_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_3 = arg_531_1:GetWordFromCfg(1105006127)
				local var_534_4 = arg_531_1:FormatText(var_534_3.content)

				arg_531_1.text_.text = var_534_4

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_5 = 11
				local var_534_6 = utf8.len(var_534_4)
				local var_534_7 = var_534_5 <= 0 and var_534_1 or var_534_1 * (var_534_6 / var_534_5)

				if var_534_7 > 0 and var_534_1 < var_534_7 then
					arg_531_1.talkMaxDuration = var_534_7

					if var_534_7 + var_534_0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_0
					end
				end

				arg_531_1.text_.text = var_534_4
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_8 = math.max(var_534_1, arg_531_1.talkMaxDuration)

			if var_534_0 <= arg_531_1.time_ and arg_531_1.time_ < var_534_0 + var_534_8 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_0) / var_534_8

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_0 + var_534_8 and arg_531_1.time_ < var_534_0 + var_534_8 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1105006128 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1105006128
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1105006129(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0
			local var_538_1 = 0.775

			if var_538_0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_2 = arg_535_1:GetWordFromCfg(1105006128)
				local var_538_3 = arg_535_1:FormatText(var_538_2.content)

				arg_535_1.text_.text = var_538_3

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_4 = 31
				local var_538_5 = utf8.len(var_538_3)
				local var_538_6 = var_538_4 <= 0 and var_538_1 or var_538_1 * (var_538_5 / var_538_4)

				if var_538_6 > 0 and var_538_1 < var_538_6 then
					arg_535_1.talkMaxDuration = var_538_6

					if var_538_6 + var_538_0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_6 + var_538_0
					end
				end

				arg_535_1.text_.text = var_538_3
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_7 = math.max(var_538_1, arg_535_1.talkMaxDuration)

			if var_538_0 <= arg_535_1.time_ and arg_535_1.time_ < var_538_0 + var_538_7 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_0) / var_538_7

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_0 + var_538_7 and arg_535_1.time_ < var_538_0 + var_538_7 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1105006129 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1105006129
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1105006130(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0
			local var_542_1 = 0.225

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_2 = arg_539_1:GetWordFromCfg(1105006129)
				local var_542_3 = arg_539_1:FormatText(var_542_2.content)

				arg_539_1.text_.text = var_542_3

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_4 = 9
				local var_542_5 = utf8.len(var_542_3)
				local var_542_6 = var_542_4 <= 0 and var_542_1 or var_542_1 * (var_542_5 / var_542_4)

				if var_542_6 > 0 and var_542_1 < var_542_6 then
					arg_539_1.talkMaxDuration = var_542_6

					if var_542_6 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_6 + var_542_0
					end
				end

				arg_539_1.text_.text = var_542_3
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_7 = math.max(var_542_1, arg_539_1.talkMaxDuration)

			if var_542_0 <= arg_539_1.time_ and arg_539_1.time_ < var_542_0 + var_542_7 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_0) / var_542_7

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_0 + var_542_7 and arg_539_1.time_ < var_542_0 + var_542_7 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1105006130 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1105006130
		arg_543_1.duration_ = 1

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"

			SetActive(arg_543_1.choicesGo_, true)

			for iter_544_0, iter_544_1 in ipairs(arg_543_1.choices_) do
				local var_544_0 = iter_544_0 <= 2

				SetActive(iter_544_1.go, var_544_0)
			end

			arg_543_1.choices_[1].txt.text = arg_543_1:FormatText(StoryChoiceCfg[1066].name)
			arg_543_1.choices_[2].txt.text = arg_543_1:FormatText(StoryChoiceCfg[1067].name)
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1105006131(arg_543_1)
			end

			if arg_545_0 == 2 then
				arg_543_0:Play1105006131(arg_543_1)
			end

			arg_543_1:RecordChoiceLog(1105006130, 1066, 1067)
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0

			if var_546_0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				arg_543_1.allBtn_.enabled = false
			end

			local var_546_1 = 0.6

			if arg_543_1.time_ >= var_546_0 + var_546_1 and arg_543_1.time_ < var_546_0 + var_546_1 + arg_546_0 then
				arg_543_1.allBtn_.enabled = true
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1105006131 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1105006131
		arg_547_1.duration_ = 8.99

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1105006132(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = "R5002a"

			if arg_547_1.bgs_[var_550_0] == nil then
				local var_550_1 = Object.Instantiate(arg_547_1.paintGo_)

				var_550_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_550_0)
				var_550_1.name = var_550_0
				var_550_1.transform.parent = arg_547_1.stage_.transform
				var_550_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_547_1.bgs_[var_550_0] = var_550_1
			end

			local var_550_2 = 1.93333333333333

			if var_550_2 < arg_547_1.time_ and arg_547_1.time_ <= var_550_2 + arg_550_0 then
				local var_550_3 = manager.ui.mainCamera.transform.localPosition
				local var_550_4 = Vector3.New(0, 0, 10) + Vector3.New(var_550_3.x, var_550_3.y, 0)
				local var_550_5 = arg_547_1.bgs_.R5002a

				var_550_5.transform.localPosition = var_550_4
				var_550_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_550_6 = var_550_5:GetComponent("SpriteRenderer")

				if var_550_6 and var_550_6.sprite then
					local var_550_7 = (var_550_5.transform.localPosition - var_550_3).z
					local var_550_8 = manager.ui.mainCameraCom_
					local var_550_9 = 2 * var_550_7 * Mathf.Tan(var_550_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_550_10 = var_550_9 * var_550_8.aspect
					local var_550_11 = var_550_6.sprite.bounds.size.x
					local var_550_12 = var_550_6.sprite.bounds.size.y
					local var_550_13 = var_550_10 / var_550_11
					local var_550_14 = var_550_9 / var_550_12
					local var_550_15 = var_550_14 < var_550_13 and var_550_13 or var_550_14

					var_550_5.transform.localScale = Vector3.New(var_550_15, var_550_15, 0)
				end

				for iter_550_0, iter_550_1 in pairs(arg_547_1.bgs_) do
					if iter_550_0 ~= "R5002a" then
						iter_550_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_550_16 = 3.9884612034075

			if var_550_16 < arg_547_1.time_ and arg_547_1.time_ <= var_550_16 + arg_550_0 then
				arg_547_1.allBtn_.enabled = false
			end

			local var_550_17 = 0.3

			if arg_547_1.time_ >= var_550_16 + var_550_17 and arg_547_1.time_ < var_550_16 + var_550_17 + arg_550_0 then
				arg_547_1.allBtn_.enabled = true
			end

			local var_550_18 = 0

			if var_550_18 < arg_547_1.time_ and arg_547_1.time_ <= var_550_18 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_19 = 2

			if var_550_18 <= arg_547_1.time_ and arg_547_1.time_ < var_550_18 + var_550_19 then
				local var_550_20 = (arg_547_1.time_ - var_550_18) / var_550_19
				local var_550_21 = Color.New(0, 0, 0)

				var_550_21.a = Mathf.Lerp(0, 1, var_550_20)
				arg_547_1.mask_.color = var_550_21
			end

			if arg_547_1.time_ >= var_550_18 + var_550_19 and arg_547_1.time_ < var_550_18 + var_550_19 + arg_550_0 then
				local var_550_22 = Color.New(0, 0, 0)

				var_550_22.a = 1
				arg_547_1.mask_.color = var_550_22
			end

			local var_550_23 = 2

			if var_550_23 < arg_547_1.time_ and arg_547_1.time_ <= var_550_23 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_24 = 2

			if var_550_23 <= arg_547_1.time_ and arg_547_1.time_ < var_550_23 + var_550_24 then
				local var_550_25 = (arg_547_1.time_ - var_550_23) / var_550_24
				local var_550_26 = Color.New(0, 0, 0)

				var_550_26.a = Mathf.Lerp(1, 0, var_550_25)
				arg_547_1.mask_.color = var_550_26
			end

			if arg_547_1.time_ >= var_550_23 + var_550_24 and arg_547_1.time_ < var_550_23 + var_550_24 + arg_550_0 then
				local var_550_27 = Color.New(0, 0, 0)
				local var_550_28 = 0

				arg_547_1.mask_.enabled = false
				var_550_27.a = var_550_28
				arg_547_1.mask_.color = var_550_27
			end

			local var_550_29 = arg_547_1.bgs_.R5002a.transform
			local var_550_30 = 2

			if var_550_30 < arg_547_1.time_ and arg_547_1.time_ <= var_550_30 + arg_550_0 then
				arg_547_1.var_.moveOldPosR5002a = var_550_29.localPosition
			end

			local var_550_31 = 0.001

			if var_550_30 <= arg_547_1.time_ and arg_547_1.time_ < var_550_30 + var_550_31 then
				local var_550_32 = (arg_547_1.time_ - var_550_30) / var_550_31
				local var_550_33 = Vector3.New(3, -0.25, 3)

				var_550_29.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPosR5002a, var_550_33, var_550_32)
			end

			if arg_547_1.time_ >= var_550_30 + var_550_31 and arg_547_1.time_ < var_550_30 + var_550_31 + arg_550_0 then
				var_550_29.localPosition = Vector3.New(3, -0.25, 3)
			end

			local var_550_34 = arg_547_1.bgs_.R5002a.transform
			local var_550_35 = 2.01666666666667

			if var_550_35 < arg_547_1.time_ and arg_547_1.time_ <= var_550_35 + arg_550_0 then
				arg_547_1.var_.moveOldPosR5002a = var_550_34.localPosition
			end

			local var_550_36 = 5

			if var_550_35 <= arg_547_1.time_ and arg_547_1.time_ < var_550_35 + var_550_36 then
				local var_550_37 = (arg_547_1.time_ - var_550_35) / var_550_36
				local var_550_38 = Vector3.New(3, 0.25, 3)

				var_550_34.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPosR5002a, var_550_38, var_550_37)
			end

			if arg_547_1.time_ >= var_550_35 + var_550_36 and arg_547_1.time_ < var_550_35 + var_550_36 + arg_550_0 then
				var_550_34.localPosition = Vector3.New(3, 0.25, 3)
			end

			local var_550_39 = 3.9884612034075

			if var_550_39 < arg_547_1.time_ and arg_547_1.time_ <= var_550_39 + arg_550_0 then
				arg_547_1.allBtn_.enabled = false
			end

			local var_550_40 = 3.02820546325917

			if arg_547_1.time_ >= var_550_39 + var_550_40 and arg_547_1.time_ < var_550_39 + var_550_40 + arg_550_0 then
				arg_547_1.allBtn_.enabled = true
			end

			if arg_547_1.frameCnt_ <= 1 then
				arg_547_1.dialog_:SetActive(false)
			end

			local var_550_41 = 3.9884612034075
			local var_550_42 = 1.025

			if var_550_41 < arg_547_1.time_ and arg_547_1.time_ <= var_550_41 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0

				arg_547_1.dialog_:SetActive(true)

				arg_547_1.dialogCg_.alpha = 0

				local var_550_43 = LeanTween.value(arg_547_1.dialog_, 0, 1, 0.3)

				var_550_43:setOnUpdate(LuaHelper.FloatAction(function(arg_551_0)
					arg_547_1.dialogCg_.alpha = arg_551_0
				end))
				var_550_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_547_1.dialog_)
					var_550_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_547_1.duration_ = arg_547_1.duration_ + 0.3

				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_44 = arg_547_1:GetWordFromCfg(1105006131)
				local var_550_45 = arg_547_1:FormatText(var_550_44.content)

				arg_547_1.text_.text = var_550_45

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_46 = 41
				local var_550_47 = utf8.len(var_550_45)
				local var_550_48 = var_550_46 <= 0 and var_550_42 or var_550_42 * (var_550_47 / var_550_46)

				if var_550_48 > 0 and var_550_42 < var_550_48 then
					arg_547_1.talkMaxDuration = var_550_48
					var_550_41 = var_550_41 + 0.3

					if var_550_48 + var_550_41 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_48 + var_550_41
					end
				end

				arg_547_1.text_.text = var_550_45
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_49 = var_550_41 + 0.3
			local var_550_50 = math.max(var_550_42, arg_547_1.talkMaxDuration)

			if var_550_49 <= arg_547_1.time_ and arg_547_1.time_ < var_550_49 + var_550_50 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_49) / var_550_50

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_49 + var_550_50 and arg_547_1.time_ < var_550_49 + var_550_50 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R5002a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R5002a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play1105006132 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1105006132
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1105006133(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0
			local var_556_1 = 1.175

			if var_556_0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_2 = arg_553_1:GetWordFromCfg(1105006132)
				local var_556_3 = arg_553_1:FormatText(var_556_2.content)

				arg_553_1.text_.text = var_556_3

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_4 = 47
				local var_556_5 = utf8.len(var_556_3)
				local var_556_6 = var_556_4 <= 0 and var_556_1 or var_556_1 * (var_556_5 / var_556_4)

				if var_556_6 > 0 and var_556_1 < var_556_6 then
					arg_553_1.talkMaxDuration = var_556_6

					if var_556_6 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_6 + var_556_0
					end
				end

				arg_553_1.text_.text = var_556_3
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_7 = math.max(var_556_1, arg_553_1.talkMaxDuration)

			if var_556_0 <= arg_553_1.time_ and arg_553_1.time_ < var_556_0 + var_556_7 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_0) / var_556_7

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_0 + var_556_7 and arg_553_1.time_ < var_556_0 + var_556_7 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1105006133 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1105006133
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1105006134(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0
			local var_560_1 = 0.45

			if var_560_0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_2 = arg_557_1:GetWordFromCfg(1105006133)
				local var_560_3 = arg_557_1:FormatText(var_560_2.content)

				arg_557_1.text_.text = var_560_3

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_4 = 18
				local var_560_5 = utf8.len(var_560_3)
				local var_560_6 = var_560_4 <= 0 and var_560_1 or var_560_1 * (var_560_5 / var_560_4)

				if var_560_6 > 0 and var_560_1 < var_560_6 then
					arg_557_1.talkMaxDuration = var_560_6

					if var_560_6 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_6 + var_560_0
					end
				end

				arg_557_1.text_.text = var_560_3
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_7 = math.max(var_560_1, arg_557_1.talkMaxDuration)

			if var_560_0 <= arg_557_1.time_ and arg_557_1.time_ < var_560_0 + var_560_7 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_0) / var_560_7

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_0 + var_560_7 and arg_557_1.time_ < var_560_0 + var_560_7 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1105006134 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1105006134
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1105006135(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0
			local var_564_1 = 0.475

			if var_564_0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_2 = arg_561_1:GetWordFromCfg(1105006134)
				local var_564_3 = arg_561_1:FormatText(var_564_2.content)

				arg_561_1.text_.text = var_564_3

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_4 = 19
				local var_564_5 = utf8.len(var_564_3)
				local var_564_6 = var_564_4 <= 0 and var_564_1 or var_564_1 * (var_564_5 / var_564_4)

				if var_564_6 > 0 and var_564_1 < var_564_6 then
					arg_561_1.talkMaxDuration = var_564_6

					if var_564_6 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_6 + var_564_0
					end
				end

				arg_561_1.text_.text = var_564_3
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_7 = math.max(var_564_1, arg_561_1.talkMaxDuration)

			if var_564_0 <= arg_561_1.time_ and arg_561_1.time_ < var_564_0 + var_564_7 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_0) / var_564_7

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_0 + var_564_7 and arg_561_1.time_ < var_564_0 + var_564_7 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1105006135 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1105006135
		arg_565_1.duration_ = 1.4

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1105006136(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0
			local var_568_1 = 0.15

			if var_568_0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_2 = arg_565_1:FormatText(StoryNameCfg[74].name)

				arg_565_1.leftNameTxt_.text = var_568_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_3 = arg_565_1:GetWordFromCfg(1105006135)
				local var_568_4 = arg_565_1:FormatText(var_568_3.content)

				arg_565_1.text_.text = var_568_4

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 6
				local var_568_6 = utf8.len(var_568_4)
				local var_568_7 = var_568_5 <= 0 and var_568_1 or var_568_1 * (var_568_6 / var_568_5)

				if var_568_7 > 0 and var_568_1 < var_568_7 then
					arg_565_1.talkMaxDuration = var_568_7

					if var_568_7 + var_568_0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_7 + var_568_0
					end
				end

				arg_565_1.text_.text = var_568_4
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006135", "story_v_side_new_1105006.awb") ~= 0 then
					local var_568_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006135", "story_v_side_new_1105006.awb") / 1000

					if var_568_8 + var_568_0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_8 + var_568_0
					end

					if var_568_3.prefab_name ~= "" and arg_565_1.actors_[var_568_3.prefab_name] ~= nil then
						local var_568_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_3.prefab_name].transform, "story_v_side_new_1105006", "1105006135", "story_v_side_new_1105006.awb")

						arg_565_1:RecordAudio("1105006135", var_568_9)
						arg_565_1:RecordAudio("1105006135", var_568_9)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006135", "story_v_side_new_1105006.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006135", "story_v_side_new_1105006.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_10 = math.max(var_568_1, arg_565_1.talkMaxDuration)

			if var_568_0 <= arg_565_1.time_ and arg_565_1.time_ < var_568_0 + var_568_10 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_0) / var_568_10

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_0 + var_568_10 and arg_565_1.time_ < var_568_0 + var_568_10 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1105006136 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1105006136
		arg_569_1.duration_ = 3.43

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1105006137(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0
			local var_572_1 = 0.425

			if var_572_0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_2 = arg_569_1:FormatText(StoryNameCfg[74].name)

				arg_569_1.leftNameTxt_.text = var_572_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_3 = arg_569_1:GetWordFromCfg(1105006136)
				local var_572_4 = arg_569_1:FormatText(var_572_3.content)

				arg_569_1.text_.text = var_572_4

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_5 = 17
				local var_572_6 = utf8.len(var_572_4)
				local var_572_7 = var_572_5 <= 0 and var_572_1 or var_572_1 * (var_572_6 / var_572_5)

				if var_572_7 > 0 and var_572_1 < var_572_7 then
					arg_569_1.talkMaxDuration = var_572_7

					if var_572_7 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_7 + var_572_0
					end
				end

				arg_569_1.text_.text = var_572_4
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006136", "story_v_side_new_1105006.awb") ~= 0 then
					local var_572_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006136", "story_v_side_new_1105006.awb") / 1000

					if var_572_8 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_8 + var_572_0
					end

					if var_572_3.prefab_name ~= "" and arg_569_1.actors_[var_572_3.prefab_name] ~= nil then
						local var_572_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_3.prefab_name].transform, "story_v_side_new_1105006", "1105006136", "story_v_side_new_1105006.awb")

						arg_569_1:RecordAudio("1105006136", var_572_9)
						arg_569_1:RecordAudio("1105006136", var_572_9)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006136", "story_v_side_new_1105006.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006136", "story_v_side_new_1105006.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_10 = math.max(var_572_1, arg_569_1.talkMaxDuration)

			if var_572_0 <= arg_569_1.time_ and arg_569_1.time_ < var_572_0 + var_572_10 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_0) / var_572_10

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_0 + var_572_10 and arg_569_1.time_ < var_572_0 + var_572_10 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1105006137 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1105006137
		arg_573_1.duration_ = 1.2

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1105006138(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0
			local var_576_1 = 0.125

			if var_576_0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_2 = arg_573_1:FormatText(StoryNameCfg[74].name)

				arg_573_1.leftNameTxt_.text = var_576_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_3 = arg_573_1:GetWordFromCfg(1105006137)
				local var_576_4 = arg_573_1:FormatText(var_576_3.content)

				arg_573_1.text_.text = var_576_4

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 5
				local var_576_6 = utf8.len(var_576_4)
				local var_576_7 = var_576_5 <= 0 and var_576_1 or var_576_1 * (var_576_6 / var_576_5)

				if var_576_7 > 0 and var_576_1 < var_576_7 then
					arg_573_1.talkMaxDuration = var_576_7

					if var_576_7 + var_576_0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_7 + var_576_0
					end
				end

				arg_573_1.text_.text = var_576_4
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006137", "story_v_side_new_1105006.awb") ~= 0 then
					local var_576_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006137", "story_v_side_new_1105006.awb") / 1000

					if var_576_8 + var_576_0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_8 + var_576_0
					end

					if var_576_3.prefab_name ~= "" and arg_573_1.actors_[var_576_3.prefab_name] ~= nil then
						local var_576_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_3.prefab_name].transform, "story_v_side_new_1105006", "1105006137", "story_v_side_new_1105006.awb")

						arg_573_1:RecordAudio("1105006137", var_576_9)
						arg_573_1:RecordAudio("1105006137", var_576_9)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006137", "story_v_side_new_1105006.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006137", "story_v_side_new_1105006.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_10 = math.max(var_576_1, arg_573_1.talkMaxDuration)

			if var_576_0 <= arg_573_1.time_ and arg_573_1.time_ < var_576_0 + var_576_10 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_0) / var_576_10

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_0 + var_576_10 and arg_573_1.time_ < var_576_0 + var_576_10 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1105006138 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1105006138
		arg_577_1.duration_ = 6.87

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1105006139(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = "STblack"

			if arg_577_1.bgs_[var_580_0] == nil then
				local var_580_1 = Object.Instantiate(arg_577_1.paintGo_)

				var_580_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_580_0)
				var_580_1.name = var_580_0
				var_580_1.transform.parent = arg_577_1.stage_.transform
				var_580_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_577_1.bgs_[var_580_0] = var_580_1
			end

			local var_580_2 = 1

			if var_580_2 < arg_577_1.time_ and arg_577_1.time_ <= var_580_2 + arg_580_0 then
				local var_580_3 = manager.ui.mainCamera.transform.localPosition
				local var_580_4 = Vector3.New(0, 0, 10) + Vector3.New(var_580_3.x, var_580_3.y, 0)
				local var_580_5 = arg_577_1.bgs_.STblack

				var_580_5.transform.localPosition = var_580_4
				var_580_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_580_6 = var_580_5:GetComponent("SpriteRenderer")

				if var_580_6 and var_580_6.sprite then
					local var_580_7 = (var_580_5.transform.localPosition - var_580_3).z
					local var_580_8 = manager.ui.mainCameraCom_
					local var_580_9 = 2 * var_580_7 * Mathf.Tan(var_580_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_580_10 = var_580_9 * var_580_8.aspect
					local var_580_11 = var_580_6.sprite.bounds.size.x
					local var_580_12 = var_580_6.sprite.bounds.size.y
					local var_580_13 = var_580_10 / var_580_11
					local var_580_14 = var_580_9 / var_580_12
					local var_580_15 = var_580_14 < var_580_13 and var_580_13 or var_580_14

					var_580_5.transform.localScale = Vector3.New(var_580_15, var_580_15, 0)
				end

				for iter_580_0, iter_580_1 in pairs(arg_577_1.bgs_) do
					if iter_580_0 ~= "STblack" then
						iter_580_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_580_16 = 0

			if var_580_16 < arg_577_1.time_ and arg_577_1.time_ <= var_580_16 + arg_580_0 then
				arg_577_1.mask_.enabled = true
				arg_577_1.mask_.raycastTarget = true

				arg_577_1:SetGaussion(false)
			end

			local var_580_17 = 1

			if var_580_16 <= arg_577_1.time_ and arg_577_1.time_ < var_580_16 + var_580_17 then
				local var_580_18 = (arg_577_1.time_ - var_580_16) / var_580_17
				local var_580_19 = Color.New(0, 0, 0)

				var_580_19.a = Mathf.Lerp(0, 1, var_580_18)
				arg_577_1.mask_.color = var_580_19
			end

			if arg_577_1.time_ >= var_580_16 + var_580_17 and arg_577_1.time_ < var_580_16 + var_580_17 + arg_580_0 then
				local var_580_20 = Color.New(0, 0, 0)

				var_580_20.a = 1
				arg_577_1.mask_.color = var_580_20
			end

			local var_580_21 = 1

			if var_580_21 < arg_577_1.time_ and arg_577_1.time_ <= var_580_21 + arg_580_0 then
				arg_577_1.mask_.enabled = true
				arg_577_1.mask_.raycastTarget = true

				arg_577_1:SetGaussion(false)
			end

			local var_580_22 = 1

			if var_580_21 <= arg_577_1.time_ and arg_577_1.time_ < var_580_21 + var_580_22 then
				local var_580_23 = (arg_577_1.time_ - var_580_21) / var_580_22
				local var_580_24 = Color.New(0, 0, 0)

				var_580_24.a = Mathf.Lerp(1, 0, var_580_23)
				arg_577_1.mask_.color = var_580_24
			end

			if arg_577_1.time_ >= var_580_21 + var_580_22 and arg_577_1.time_ < var_580_21 + var_580_22 + arg_580_0 then
				local var_580_25 = Color.New(0, 0, 0)
				local var_580_26 = 0

				arg_577_1.mask_.enabled = false
				var_580_25.a = var_580_26
				arg_577_1.mask_.color = var_580_25
			end

			if arg_577_1.frameCnt_ <= 1 then
				arg_577_1.dialog_:SetActive(false)
			end

			local var_580_27 = 1.86666666666667
			local var_580_28 = 0.625

			if var_580_27 < arg_577_1.time_ and arg_577_1.time_ <= var_580_27 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0

				arg_577_1.dialog_:SetActive(true)

				arg_577_1.dialogCg_.alpha = 0

				local var_580_29 = LeanTween.value(arg_577_1.dialog_, 0, 1, 0.3)

				var_580_29:setOnUpdate(LuaHelper.FloatAction(function(arg_581_0)
					arg_577_1.dialogCg_.alpha = arg_581_0
				end))
				var_580_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_577_1.dialog_)
					var_580_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_577_1.duration_ = arg_577_1.duration_ + 0.3

				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_30 = arg_577_1:GetWordFromCfg(1105006138)
				local var_580_31 = arg_577_1:FormatText(var_580_30.content)

				arg_577_1.text_.text = var_580_31

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_32 = 25
				local var_580_33 = utf8.len(var_580_31)
				local var_580_34 = var_580_32 <= 0 and var_580_28 or var_580_28 * (var_580_33 / var_580_32)

				if var_580_34 > 0 and var_580_28 < var_580_34 then
					arg_577_1.talkMaxDuration = var_580_34
					var_580_27 = var_580_27 + 0.3

					if var_580_34 + var_580_27 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_34 + var_580_27
					end
				end

				arg_577_1.text_.text = var_580_31
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_35 = var_580_27 + 0.3
			local var_580_36 = math.max(var_580_28, arg_577_1.talkMaxDuration)

			if var_580_35 <= arg_577_1.time_ and arg_577_1.time_ < var_580_35 + var_580_36 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_35) / var_580_36

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_35 + var_580_36 and arg_577_1.time_ < var_580_35 + var_580_36 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play1105006139 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1105006139
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1105006140(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0
			local var_586_1 = 0.9

			if var_586_0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, false)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_2 = arg_583_1:GetWordFromCfg(1105006139)
				local var_586_3 = arg_583_1:FormatText(var_586_2.content)

				arg_583_1.text_.text = var_586_3

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_4 = 36
				local var_586_5 = utf8.len(var_586_3)
				local var_586_6 = var_586_4 <= 0 and var_586_1 or var_586_1 * (var_586_5 / var_586_4)

				if var_586_6 > 0 and var_586_1 < var_586_6 then
					arg_583_1.talkMaxDuration = var_586_6

					if var_586_6 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_6 + var_586_0
					end
				end

				arg_583_1.text_.text = var_586_3
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_7 = math.max(var_586_1, arg_583_1.talkMaxDuration)

			if var_586_0 <= arg_583_1.time_ and arg_583_1.time_ < var_586_0 + var_586_7 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_0) / var_586_7

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_0 + var_586_7 and arg_583_1.time_ < var_586_0 + var_586_7 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1105006140 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1105006140
		arg_587_1.duration_ = 7

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1105006141(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0

			if var_590_0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_0 + arg_590_0 then
				arg_587_1.mask_.enabled = true
				arg_587_1.mask_.raycastTarget = true

				arg_587_1:SetGaussion(false)
			end

			local var_590_1 = 2

			if var_590_0 <= arg_587_1.time_ and arg_587_1.time_ < var_590_0 + var_590_1 then
				local var_590_2 = (arg_587_1.time_ - var_590_0) / var_590_1
				local var_590_3 = Color.New(0, 0, 0)

				var_590_3.a = Mathf.Lerp(1, 0, var_590_2)
				arg_587_1.mask_.color = var_590_3
			end

			if arg_587_1.time_ >= var_590_0 + var_590_1 and arg_587_1.time_ < var_590_0 + var_590_1 + arg_590_0 then
				local var_590_4 = Color.New(0, 0, 0)
				local var_590_5 = 0

				arg_587_1.mask_.enabled = false
				var_590_4.a = var_590_5
				arg_587_1.mask_.color = var_590_4
			end

			local var_590_6 = 0

			if var_590_6 < arg_587_1.time_ and arg_587_1.time_ <= var_590_6 + arg_590_0 then
				local var_590_7 = manager.ui.mainCamera.transform.localPosition
				local var_590_8 = Vector3.New(0, 0, 10) + Vector3.New(var_590_7.x, var_590_7.y, 0)
				local var_590_9 = arg_587_1.bgs_.R5002a

				var_590_9.transform.localPosition = var_590_8
				var_590_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_590_10 = var_590_9:GetComponent("SpriteRenderer")

				if var_590_10 and var_590_10.sprite then
					local var_590_11 = (var_590_9.transform.localPosition - var_590_7).z
					local var_590_12 = manager.ui.mainCameraCom_
					local var_590_13 = 2 * var_590_11 * Mathf.Tan(var_590_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_590_14 = var_590_13 * var_590_12.aspect
					local var_590_15 = var_590_10.sprite.bounds.size.x
					local var_590_16 = var_590_10.sprite.bounds.size.y
					local var_590_17 = var_590_14 / var_590_15
					local var_590_18 = var_590_13 / var_590_16
					local var_590_19 = var_590_18 < var_590_17 and var_590_17 or var_590_18

					var_590_9.transform.localScale = Vector3.New(var_590_19, var_590_19, 0)
				end

				for iter_590_0, iter_590_1 in pairs(arg_587_1.bgs_) do
					if iter_590_0 ~= "R5002a" then
						iter_590_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_590_20 = arg_587_1.bgs_.R5002a.transform
			local var_590_21 = 0

			if var_590_21 < arg_587_1.time_ and arg_587_1.time_ <= var_590_21 + arg_590_0 then
				arg_587_1.var_.moveOldPosR5002a = var_590_20.localPosition
			end

			local var_590_22 = 0.0666666666666667

			if var_590_21 <= arg_587_1.time_ and arg_587_1.time_ < var_590_21 + var_590_22 then
				local var_590_23 = (arg_587_1.time_ - var_590_21) / var_590_22
				local var_590_24 = Vector3.New(0, 1, 9.5)

				var_590_20.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPosR5002a, var_590_24, var_590_23)
			end

			if arg_587_1.time_ >= var_590_21 + var_590_22 and arg_587_1.time_ < var_590_21 + var_590_22 + arg_590_0 then
				var_590_20.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_590_25 = arg_587_1.bgs_.R5002a.transform
			local var_590_26 = 0.0666666666666667

			if var_590_26 < arg_587_1.time_ and arg_587_1.time_ <= var_590_26 + arg_590_0 then
				arg_587_1.var_.moveOldPosR5002a = var_590_25.localPosition
			end

			local var_590_27 = 1.93333333333333

			if var_590_26 <= arg_587_1.time_ and arg_587_1.time_ < var_590_26 + var_590_27 then
				local var_590_28 = (arg_587_1.time_ - var_590_26) / var_590_27
				local var_590_29 = Vector3.New(0, 1, 10)

				var_590_25.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPosR5002a, var_590_29, var_590_28)
			end

			if arg_587_1.time_ >= var_590_26 + var_590_27 and arg_587_1.time_ < var_590_26 + var_590_27 + arg_590_0 then
				var_590_25.localPosition = Vector3.New(0, 1, 10)
			end

			local var_590_30 = 2
			local var_590_31 = 0.675

			if var_590_30 < arg_587_1.time_ and arg_587_1.time_ <= var_590_30 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_32 = arg_587_1:GetWordFromCfg(1105006140)
				local var_590_33 = arg_587_1:FormatText(var_590_32.content)

				arg_587_1.text_.text = var_590_33

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_34 = 27
				local var_590_35 = utf8.len(var_590_33)
				local var_590_36 = var_590_34 <= 0 and var_590_31 or var_590_31 * (var_590_35 / var_590_34)

				if var_590_36 > 0 and var_590_31 < var_590_36 then
					arg_587_1.talkMaxDuration = var_590_36

					if var_590_36 + var_590_30 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_36 + var_590_30
					end
				end

				arg_587_1.text_.text = var_590_33
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_37 = math.max(var_590_31, arg_587_1.talkMaxDuration)

			if var_590_30 <= arg_587_1.time_ and arg_587_1.time_ < var_590_30 + var_590_37 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_30) / var_590_37

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_30 + var_590_37 and arg_587_1.time_ < var_590_30 + var_590_37 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R5002a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R5002a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.93333333333333,
				className = "StoryMoveNode",
				startTime = 0.0666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_587_1:InitPlayNodeList()
	end,
	Play1105006141 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1105006141
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1105006142(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0
			local var_594_1 = 0.3

			if var_594_0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_2 = arg_591_1:FormatText(StoryNameCfg[7].name)

				arg_591_1.leftNameTxt_.text = var_594_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_3 = arg_591_1:GetWordFromCfg(1105006141)
				local var_594_4 = arg_591_1:FormatText(var_594_3.content)

				arg_591_1.text_.text = var_594_4

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_5 = 12
				local var_594_6 = utf8.len(var_594_4)
				local var_594_7 = var_594_5 <= 0 and var_594_1 or var_594_1 * (var_594_6 / var_594_5)

				if var_594_7 > 0 and var_594_1 < var_594_7 then
					arg_591_1.talkMaxDuration = var_594_7

					if var_594_7 + var_594_0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_7 + var_594_0
					end
				end

				arg_591_1.text_.text = var_594_4
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_8 = math.max(var_594_1, arg_591_1.talkMaxDuration)

			if var_594_0 <= arg_591_1.time_ and arg_591_1.time_ < var_594_0 + var_594_8 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_0) / var_594_8

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_0 + var_594_8 and arg_591_1.time_ < var_594_0 + var_594_8 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1105006142 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1105006142
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1105006143(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 0.85

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, false)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_2 = arg_595_1:GetWordFromCfg(1105006142)
				local var_598_3 = arg_595_1:FormatText(var_598_2.content)

				arg_595_1.text_.text = var_598_3

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_4 = 34
				local var_598_5 = utf8.len(var_598_3)
				local var_598_6 = var_598_4 <= 0 and var_598_1 or var_598_1 * (var_598_5 / var_598_4)

				if var_598_6 > 0 and var_598_1 < var_598_6 then
					arg_595_1.talkMaxDuration = var_598_6

					if var_598_6 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_6 + var_598_0
					end
				end

				arg_595_1.text_.text = var_598_3
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_7 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_7 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_7

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_7 and arg_595_1.time_ < var_598_0 + var_598_7 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1105006143 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1105006143
		arg_599_1.duration_ = 1.43

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1105006144(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0
			local var_602_1 = 0.15

			if var_602_0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_2 = arg_599_1:FormatText(StoryNameCfg[74].name)

				arg_599_1.leftNameTxt_.text = var_602_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_3 = arg_599_1:GetWordFromCfg(1105006143)
				local var_602_4 = arg_599_1:FormatText(var_602_3.content)

				arg_599_1.text_.text = var_602_4

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_5 = 6
				local var_602_6 = utf8.len(var_602_4)
				local var_602_7 = var_602_5 <= 0 and var_602_1 or var_602_1 * (var_602_6 / var_602_5)

				if var_602_7 > 0 and var_602_1 < var_602_7 then
					arg_599_1.talkMaxDuration = var_602_7

					if var_602_7 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_0
					end
				end

				arg_599_1.text_.text = var_602_4
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006143", "story_v_side_new_1105006.awb") ~= 0 then
					local var_602_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006143", "story_v_side_new_1105006.awb") / 1000

					if var_602_8 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_8 + var_602_0
					end

					if var_602_3.prefab_name ~= "" and arg_599_1.actors_[var_602_3.prefab_name] ~= nil then
						local var_602_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_3.prefab_name].transform, "story_v_side_new_1105006", "1105006143", "story_v_side_new_1105006.awb")

						arg_599_1:RecordAudio("1105006143", var_602_9)
						arg_599_1:RecordAudio("1105006143", var_602_9)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006143", "story_v_side_new_1105006.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006143", "story_v_side_new_1105006.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_10 = math.max(var_602_1, arg_599_1.talkMaxDuration)

			if var_602_0 <= arg_599_1.time_ and arg_599_1.time_ < var_602_0 + var_602_10 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_0) / var_602_10

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_0 + var_602_10 and arg_599_1.time_ < var_602_0 + var_602_10 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1105006144 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1105006144
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1105006145(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0
			local var_606_1 = 0.725

			if var_606_0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_2 = arg_603_1:GetWordFromCfg(1105006144)
				local var_606_3 = arg_603_1:FormatText(var_606_2.content)

				arg_603_1.text_.text = var_606_3

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_4 = 29
				local var_606_5 = utf8.len(var_606_3)
				local var_606_6 = var_606_4 <= 0 and var_606_1 or var_606_1 * (var_606_5 / var_606_4)

				if var_606_6 > 0 and var_606_1 < var_606_6 then
					arg_603_1.talkMaxDuration = var_606_6

					if var_606_6 + var_606_0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_6 + var_606_0
					end
				end

				arg_603_1.text_.text = var_606_3
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_7 = math.max(var_606_1, arg_603_1.talkMaxDuration)

			if var_606_0 <= arg_603_1.time_ and arg_603_1.time_ < var_606_0 + var_606_7 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_0) / var_606_7

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_0 + var_606_7 and arg_603_1.time_ < var_606_0 + var_606_7 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1105006145 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1105006145
		arg_607_1.duration_ = 7.7

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1105006146(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 2

			if var_610_0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_0 + arg_610_0 then
				local var_610_1 = manager.ui.mainCamera.transform.localPosition
				local var_610_2 = Vector3.New(0, 0, 10) + Vector3.New(var_610_1.x, var_610_1.y, 0)
				local var_610_3 = arg_607_1.bgs_.STblack

				var_610_3.transform.localPosition = var_610_2
				var_610_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_610_4 = var_610_3:GetComponent("SpriteRenderer")

				if var_610_4 and var_610_4.sprite then
					local var_610_5 = (var_610_3.transform.localPosition - var_610_1).z
					local var_610_6 = manager.ui.mainCameraCom_
					local var_610_7 = 2 * var_610_5 * Mathf.Tan(var_610_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_610_8 = var_610_7 * var_610_6.aspect
					local var_610_9 = var_610_4.sprite.bounds.size.x
					local var_610_10 = var_610_4.sprite.bounds.size.y
					local var_610_11 = var_610_8 / var_610_9
					local var_610_12 = var_610_7 / var_610_10
					local var_610_13 = var_610_12 < var_610_11 and var_610_11 or var_610_12

					var_610_3.transform.localScale = Vector3.New(var_610_13, var_610_13, 0)
				end

				for iter_610_0, iter_610_1 in pairs(arg_607_1.bgs_) do
					if iter_610_0 ~= "STblack" then
						iter_610_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_610_14 = 0

			if var_610_14 < arg_607_1.time_ and arg_607_1.time_ <= var_610_14 + arg_610_0 then
				arg_607_1.mask_.enabled = true
				arg_607_1.mask_.raycastTarget = true

				arg_607_1:SetGaussion(false)
			end

			local var_610_15 = 2

			if var_610_14 <= arg_607_1.time_ and arg_607_1.time_ < var_610_14 + var_610_15 then
				local var_610_16 = (arg_607_1.time_ - var_610_14) / var_610_15
				local var_610_17 = Color.New(0, 0, 0)

				var_610_17.a = Mathf.Lerp(0, 1, var_610_16)
				arg_607_1.mask_.color = var_610_17
			end

			if arg_607_1.time_ >= var_610_14 + var_610_15 and arg_607_1.time_ < var_610_14 + var_610_15 + arg_610_0 then
				local var_610_18 = Color.New(0, 0, 0)

				var_610_18.a = 1
				arg_607_1.mask_.color = var_610_18
			end

			local var_610_19 = 2

			if var_610_19 < arg_607_1.time_ and arg_607_1.time_ <= var_610_19 + arg_610_0 then
				arg_607_1.mask_.enabled = true
				arg_607_1.mask_.raycastTarget = true

				arg_607_1:SetGaussion(false)
			end

			local var_610_20 = 2

			if var_610_19 <= arg_607_1.time_ and arg_607_1.time_ < var_610_19 + var_610_20 then
				local var_610_21 = (arg_607_1.time_ - var_610_19) / var_610_20
				local var_610_22 = Color.New(0, 0, 0)

				var_610_22.a = Mathf.Lerp(1, 0, var_610_21)
				arg_607_1.mask_.color = var_610_22
			end

			if arg_607_1.time_ >= var_610_19 + var_610_20 and arg_607_1.time_ < var_610_19 + var_610_20 + arg_610_0 then
				local var_610_23 = Color.New(0, 0, 0)
				local var_610_24 = 0

				arg_607_1.mask_.enabled = false
				var_610_23.a = var_610_24
				arg_607_1.mask_.color = var_610_23
			end

			if arg_607_1.frameCnt_ <= 1 then
				arg_607_1.dialog_:SetActive(false)
			end

			local var_610_25 = 2.7
			local var_610_26 = 1.3

			if var_610_25 < arg_607_1.time_ and arg_607_1.time_ <= var_610_25 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0

				arg_607_1.dialog_:SetActive(true)

				arg_607_1.dialogCg_.alpha = 0

				local var_610_27 = LeanTween.value(arg_607_1.dialog_, 0, 1, 0.3)

				var_610_27:setOnUpdate(LuaHelper.FloatAction(function(arg_611_0)
					arg_607_1.dialogCg_.alpha = arg_611_0
				end))
				var_610_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_607_1.dialog_)
					var_610_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_607_1.duration_ = arg_607_1.duration_ + 0.3

				SetActive(arg_607_1.leftNameGo_, false)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_28 = arg_607_1:GetWordFromCfg(1105006145)
				local var_610_29 = arg_607_1:FormatText(var_610_28.content)

				arg_607_1.text_.text = var_610_29

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_30 = 52
				local var_610_31 = utf8.len(var_610_29)
				local var_610_32 = var_610_30 <= 0 and var_610_26 or var_610_26 * (var_610_31 / var_610_30)

				if var_610_32 > 0 and var_610_26 < var_610_32 then
					arg_607_1.talkMaxDuration = var_610_32
					var_610_25 = var_610_25 + 0.3

					if var_610_32 + var_610_25 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_32 + var_610_25
					end
				end

				arg_607_1.text_.text = var_610_29
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_33 = var_610_25 + 0.3
			local var_610_34 = math.max(var_610_26, arg_607_1.talkMaxDuration)

			if var_610_33 <= arg_607_1.time_ and arg_607_1.time_ < var_610_33 + var_610_34 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_33) / var_610_34

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_33 + var_610_34 and arg_607_1.time_ < var_610_33 + var_610_34 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1105006146 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1105006146
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1105006147(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0
			local var_616_1 = 0.15

			if var_616_0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_2 = arg_613_1:FormatText(StoryNameCfg[7].name)

				arg_613_1.leftNameTxt_.text = var_616_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_3 = arg_613_1:GetWordFromCfg(1105006146)
				local var_616_4 = arg_613_1:FormatText(var_616_3.content)

				arg_613_1.text_.text = var_616_4

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 6
				local var_616_6 = utf8.len(var_616_4)
				local var_616_7 = var_616_5 <= 0 and var_616_1 or var_616_1 * (var_616_6 / var_616_5)

				if var_616_7 > 0 and var_616_1 < var_616_7 then
					arg_613_1.talkMaxDuration = var_616_7

					if var_616_7 + var_616_0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_7 + var_616_0
					end
				end

				arg_613_1.text_.text = var_616_4
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_8 = math.max(var_616_1, arg_613_1.talkMaxDuration)

			if var_616_0 <= arg_613_1.time_ and arg_613_1.time_ < var_616_0 + var_616_8 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_0) / var_616_8

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_0 + var_616_8 and arg_613_1.time_ < var_616_0 + var_616_8 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1105006147 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1105006147
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1105006148(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0
			local var_620_1 = 1.575

			if var_620_0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, false)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_2 = arg_617_1:GetWordFromCfg(1105006147)
				local var_620_3 = arg_617_1:FormatText(var_620_2.content)

				arg_617_1.text_.text = var_620_3

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_4 = 63
				local var_620_5 = utf8.len(var_620_3)
				local var_620_6 = var_620_4 <= 0 and var_620_1 or var_620_1 * (var_620_5 / var_620_4)

				if var_620_6 > 0 and var_620_1 < var_620_6 then
					arg_617_1.talkMaxDuration = var_620_6

					if var_620_6 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_6 + var_620_0
					end
				end

				arg_617_1.text_.text = var_620_3
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_7 = math.max(var_620_1, arg_617_1.talkMaxDuration)

			if var_620_0 <= arg_617_1.time_ and arg_617_1.time_ < var_620_0 + var_620_7 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_0) / var_620_7

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_0 + var_620_7 and arg_617_1.time_ < var_620_0 + var_620_7 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play1105006148 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1105006148
		arg_621_1.duration_ = 5.1

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1105006149(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0
			local var_624_1 = 0.35

			if var_624_0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				local var_624_2 = arg_621_1:FormatText(StoryNameCfg[74].name)

				arg_621_1.leftNameTxt_.text = var_624_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_3 = arg_621_1:GetWordFromCfg(1105006148)
				local var_624_4 = arg_621_1:FormatText(var_624_3.content)

				arg_621_1.text_.text = var_624_4

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_5 = 14
				local var_624_6 = utf8.len(var_624_4)
				local var_624_7 = var_624_5 <= 0 and var_624_1 or var_624_1 * (var_624_6 / var_624_5)

				if var_624_7 > 0 and var_624_1 < var_624_7 then
					arg_621_1.talkMaxDuration = var_624_7

					if var_624_7 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_7 + var_624_0
					end
				end

				arg_621_1.text_.text = var_624_4
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006148", "story_v_side_new_1105006.awb") ~= 0 then
					local var_624_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006148", "story_v_side_new_1105006.awb") / 1000

					if var_624_8 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_8 + var_624_0
					end

					if var_624_3.prefab_name ~= "" and arg_621_1.actors_[var_624_3.prefab_name] ~= nil then
						local var_624_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_3.prefab_name].transform, "story_v_side_new_1105006", "1105006148", "story_v_side_new_1105006.awb")

						arg_621_1:RecordAudio("1105006148", var_624_9)
						arg_621_1:RecordAudio("1105006148", var_624_9)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006148", "story_v_side_new_1105006.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006148", "story_v_side_new_1105006.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_10 = math.max(var_624_1, arg_621_1.talkMaxDuration)

			if var_624_0 <= arg_621_1.time_ and arg_621_1.time_ < var_624_0 + var_624_10 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_0) / var_624_10

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_0 + var_624_10 and arg_621_1.time_ < var_624_0 + var_624_10 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play1105006149 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1105006149
		arg_625_1.duration_ = 6.8

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1105006150(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0
			local var_628_1 = 0.7

			if var_628_0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				local var_628_2 = arg_625_1:FormatText(StoryNameCfg[74].name)

				arg_625_1.leftNameTxt_.text = var_628_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_3 = arg_625_1:GetWordFromCfg(1105006149)
				local var_628_4 = arg_625_1:FormatText(var_628_3.content)

				arg_625_1.text_.text = var_628_4

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_5 = 28
				local var_628_6 = utf8.len(var_628_4)
				local var_628_7 = var_628_5 <= 0 and var_628_1 or var_628_1 * (var_628_6 / var_628_5)

				if var_628_7 > 0 and var_628_1 < var_628_7 then
					arg_625_1.talkMaxDuration = var_628_7

					if var_628_7 + var_628_0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_7 + var_628_0
					end
				end

				arg_625_1.text_.text = var_628_4
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006149", "story_v_side_new_1105006.awb") ~= 0 then
					local var_628_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006149", "story_v_side_new_1105006.awb") / 1000

					if var_628_8 + var_628_0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_8 + var_628_0
					end

					if var_628_3.prefab_name ~= "" and arg_625_1.actors_[var_628_3.prefab_name] ~= nil then
						local var_628_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_3.prefab_name].transform, "story_v_side_new_1105006", "1105006149", "story_v_side_new_1105006.awb")

						arg_625_1:RecordAudio("1105006149", var_628_9)
						arg_625_1:RecordAudio("1105006149", var_628_9)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006149", "story_v_side_new_1105006.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006149", "story_v_side_new_1105006.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_10 = math.max(var_628_1, arg_625_1.talkMaxDuration)

			if var_628_0 <= arg_625_1.time_ and arg_625_1.time_ < var_628_0 + var_628_10 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_0) / var_628_10

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_0 + var_628_10 and arg_625_1.time_ < var_628_0 + var_628_10 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play1105006150 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1105006150
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1105006151(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 0
			local var_632_1 = 0.3

			if var_632_0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_0 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				local var_632_2 = arg_629_1:FormatText(StoryNameCfg[7].name)

				arg_629_1.leftNameTxt_.text = var_632_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, true)
				arg_629_1.iconController_:SetSelectedState("hero")

				arg_629_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_629_1.callingController_:SetSelectedState("normal")

				arg_629_1.keyicon_.color = Color.New(1, 1, 1)
				arg_629_1.icon_.color = Color.New(1, 1, 1)

				local var_632_3 = arg_629_1:GetWordFromCfg(1105006150)
				local var_632_4 = arg_629_1:FormatText(var_632_3.content)

				arg_629_1.text_.text = var_632_4

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_5 = 12
				local var_632_6 = utf8.len(var_632_4)
				local var_632_7 = var_632_5 <= 0 and var_632_1 or var_632_1 * (var_632_6 / var_632_5)

				if var_632_7 > 0 and var_632_1 < var_632_7 then
					arg_629_1.talkMaxDuration = var_632_7

					if var_632_7 + var_632_0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_7 + var_632_0
					end
				end

				arg_629_1.text_.text = var_632_4
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_8 = math.max(var_632_1, arg_629_1.talkMaxDuration)

			if var_632_0 <= arg_629_1.time_ and arg_629_1.time_ < var_632_0 + var_632_8 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_0) / var_632_8

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_0 + var_632_8 and arg_629_1.time_ < var_632_0 + var_632_8 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play1105006151 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1105006151
		arg_633_1.duration_ = 11.8

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play1105006152(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = 0
			local var_636_1 = 1

			if var_636_0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_0 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				local var_636_2 = arg_633_1:FormatText(StoryNameCfg[74].name)

				arg_633_1.leftNameTxt_.text = var_636_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_3 = arg_633_1:GetWordFromCfg(1105006151)
				local var_636_4 = arg_633_1:FormatText(var_636_3.content)

				arg_633_1.text_.text = var_636_4

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_5 = 40
				local var_636_6 = utf8.len(var_636_4)
				local var_636_7 = var_636_5 <= 0 and var_636_1 or var_636_1 * (var_636_6 / var_636_5)

				if var_636_7 > 0 and var_636_1 < var_636_7 then
					arg_633_1.talkMaxDuration = var_636_7

					if var_636_7 + var_636_0 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_7 + var_636_0
					end
				end

				arg_633_1.text_.text = var_636_4
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006151", "story_v_side_new_1105006.awb") ~= 0 then
					local var_636_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006151", "story_v_side_new_1105006.awb") / 1000

					if var_636_8 + var_636_0 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_8 + var_636_0
					end

					if var_636_3.prefab_name ~= "" and arg_633_1.actors_[var_636_3.prefab_name] ~= nil then
						local var_636_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_3.prefab_name].transform, "story_v_side_new_1105006", "1105006151", "story_v_side_new_1105006.awb")

						arg_633_1:RecordAudio("1105006151", var_636_9)
						arg_633_1:RecordAudio("1105006151", var_636_9)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006151", "story_v_side_new_1105006.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006151", "story_v_side_new_1105006.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_10 = math.max(var_636_1, arg_633_1.talkMaxDuration)

			if var_636_0 <= arg_633_1.time_ and arg_633_1.time_ < var_636_0 + var_636_10 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_0) / var_636_10

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_0 + var_636_10 and arg_633_1.time_ < var_636_0 + var_636_10 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play1105006152 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1105006152
		arg_637_1.duration_ = 7.23

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1105006153(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0
			local var_640_1 = 0.55

			if var_640_0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				local var_640_2 = arg_637_1:FormatText(StoryNameCfg[74].name)

				arg_637_1.leftNameTxt_.text = var_640_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_3 = arg_637_1:GetWordFromCfg(1105006152)
				local var_640_4 = arg_637_1:FormatText(var_640_3.content)

				arg_637_1.text_.text = var_640_4

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_5 = 22
				local var_640_6 = utf8.len(var_640_4)
				local var_640_7 = var_640_5 <= 0 and var_640_1 or var_640_1 * (var_640_6 / var_640_5)

				if var_640_7 > 0 and var_640_1 < var_640_7 then
					arg_637_1.talkMaxDuration = var_640_7

					if var_640_7 + var_640_0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_7 + var_640_0
					end
				end

				arg_637_1.text_.text = var_640_4
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006152", "story_v_side_new_1105006.awb") ~= 0 then
					local var_640_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006152", "story_v_side_new_1105006.awb") / 1000

					if var_640_8 + var_640_0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_8 + var_640_0
					end

					if var_640_3.prefab_name ~= "" and arg_637_1.actors_[var_640_3.prefab_name] ~= nil then
						local var_640_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_637_1.actors_[var_640_3.prefab_name].transform, "story_v_side_new_1105006", "1105006152", "story_v_side_new_1105006.awb")

						arg_637_1:RecordAudio("1105006152", var_640_9)
						arg_637_1:RecordAudio("1105006152", var_640_9)
					else
						arg_637_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006152", "story_v_side_new_1105006.awb")
					end

					arg_637_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006152", "story_v_side_new_1105006.awb")
				end

				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_10 = math.max(var_640_1, arg_637_1.talkMaxDuration)

			if var_640_0 <= arg_637_1.time_ and arg_637_1.time_ < var_640_0 + var_640_10 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_0) / var_640_10

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_0 + var_640_10 and arg_637_1.time_ < var_640_0 + var_640_10 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play1105006153 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1105006153
		arg_641_1.duration_ = 4.37

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play1105006154(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0
			local var_644_1 = 0.625

			if var_644_0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_2 = arg_641_1:FormatText(StoryNameCfg[74].name)

				arg_641_1.leftNameTxt_.text = var_644_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_3 = arg_641_1:GetWordFromCfg(1105006153)
				local var_644_4 = arg_641_1:FormatText(var_644_3.content)

				arg_641_1.text_.text = var_644_4

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_5 = 25
				local var_644_6 = utf8.len(var_644_4)
				local var_644_7 = var_644_5 <= 0 and var_644_1 or var_644_1 * (var_644_6 / var_644_5)

				if var_644_7 > 0 and var_644_1 < var_644_7 then
					arg_641_1.talkMaxDuration = var_644_7

					if var_644_7 + var_644_0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_7 + var_644_0
					end
				end

				arg_641_1.text_.text = var_644_4
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006153", "story_v_side_new_1105006.awb") ~= 0 then
					local var_644_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006153", "story_v_side_new_1105006.awb") / 1000

					if var_644_8 + var_644_0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_8 + var_644_0
					end

					if var_644_3.prefab_name ~= "" and arg_641_1.actors_[var_644_3.prefab_name] ~= nil then
						local var_644_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_3.prefab_name].transform, "story_v_side_new_1105006", "1105006153", "story_v_side_new_1105006.awb")

						arg_641_1:RecordAudio("1105006153", var_644_9)
						arg_641_1:RecordAudio("1105006153", var_644_9)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006153", "story_v_side_new_1105006.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006153", "story_v_side_new_1105006.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_10 = math.max(var_644_1, arg_641_1.talkMaxDuration)

			if var_644_0 <= arg_641_1.time_ and arg_641_1.time_ < var_644_0 + var_644_10 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_0) / var_644_10

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_0 + var_644_10 and arg_641_1.time_ < var_644_0 + var_644_10 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play1105006154 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1105006154
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play1105006155(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0
			local var_648_1 = 0.175

			if var_648_0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				local var_648_2 = arg_645_1:FormatText(StoryNameCfg[7].name)

				arg_645_1.leftNameTxt_.text = var_648_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, true)
				arg_645_1.iconController_:SetSelectedState("hero")

				arg_645_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_645_1.callingController_:SetSelectedState("normal")

				arg_645_1.keyicon_.color = Color.New(1, 1, 1)
				arg_645_1.icon_.color = Color.New(1, 1, 1)

				local var_648_3 = arg_645_1:GetWordFromCfg(1105006154)
				local var_648_4 = arg_645_1:FormatText(var_648_3.content)

				arg_645_1.text_.text = var_648_4

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_5 = 7
				local var_648_6 = utf8.len(var_648_4)
				local var_648_7 = var_648_5 <= 0 and var_648_1 or var_648_1 * (var_648_6 / var_648_5)

				if var_648_7 > 0 and var_648_1 < var_648_7 then
					arg_645_1.talkMaxDuration = var_648_7

					if var_648_7 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_7 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_4
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_8 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_8 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_8

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_8 and arg_645_1.time_ < var_648_0 + var_648_8 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play1105006155 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1105006155
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1105006156(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0
			local var_652_1 = 0.45

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_2 = arg_649_1:FormatText(StoryNameCfg[7].name)

				arg_649_1.leftNameTxt_.text = var_652_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, true)
				arg_649_1.iconController_:SetSelectedState("hero")

				arg_649_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_649_1.callingController_:SetSelectedState("normal")

				arg_649_1.keyicon_.color = Color.New(1, 1, 1)
				arg_649_1.icon_.color = Color.New(1, 1, 1)

				local var_652_3 = arg_649_1:GetWordFromCfg(1105006155)
				local var_652_4 = arg_649_1:FormatText(var_652_3.content)

				arg_649_1.text_.text = var_652_4

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_5 = 18
				local var_652_6 = utf8.len(var_652_4)
				local var_652_7 = var_652_5 <= 0 and var_652_1 or var_652_1 * (var_652_6 / var_652_5)

				if var_652_7 > 0 and var_652_1 < var_652_7 then
					arg_649_1.talkMaxDuration = var_652_7

					if var_652_7 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_7 + var_652_0
					end
				end

				arg_649_1.text_.text = var_652_4
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_8 = math.max(var_652_1, arg_649_1.talkMaxDuration)

			if var_652_0 <= arg_649_1.time_ and arg_649_1.time_ < var_652_0 + var_652_8 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_0) / var_652_8

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_0 + var_652_8 and arg_649_1.time_ < var_652_0 + var_652_8 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1105006156 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1105006156
		arg_653_1.duration_ = 7

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1105006157(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0

			if var_656_0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_0 + arg_656_0 then
				local var_656_1 = manager.ui.mainCamera.transform.localPosition
				local var_656_2 = Vector3.New(0, 0, 10) + Vector3.New(var_656_1.x, var_656_1.y, 0)
				local var_656_3 = arg_653_1.bgs_.R5002a

				var_656_3.transform.localPosition = var_656_2
				var_656_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_656_4 = var_656_3:GetComponent("SpriteRenderer")

				if var_656_4 and var_656_4.sprite then
					local var_656_5 = (var_656_3.transform.localPosition - var_656_1).z
					local var_656_6 = manager.ui.mainCameraCom_
					local var_656_7 = 2 * var_656_5 * Mathf.Tan(var_656_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_656_8 = var_656_7 * var_656_6.aspect
					local var_656_9 = var_656_4.sprite.bounds.size.x
					local var_656_10 = var_656_4.sprite.bounds.size.y
					local var_656_11 = var_656_8 / var_656_9
					local var_656_12 = var_656_7 / var_656_10
					local var_656_13 = var_656_12 < var_656_11 and var_656_11 or var_656_12

					var_656_3.transform.localScale = Vector3.New(var_656_13, var_656_13, 0)
				end

				for iter_656_0, iter_656_1 in pairs(arg_653_1.bgs_) do
					if iter_656_0 ~= "R5002a" then
						iter_656_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_656_14 = 0

			if var_656_14 < arg_653_1.time_ and arg_653_1.time_ <= var_656_14 + arg_656_0 then
				arg_653_1.mask_.enabled = true
				arg_653_1.mask_.raycastTarget = true

				arg_653_1:SetGaussion(false)
			end

			local var_656_15 = 2

			if var_656_14 <= arg_653_1.time_ and arg_653_1.time_ < var_656_14 + var_656_15 then
				local var_656_16 = (arg_653_1.time_ - var_656_14) / var_656_15
				local var_656_17 = Color.New(0, 0, 0)

				var_656_17.a = Mathf.Lerp(1, 0, var_656_16)
				arg_653_1.mask_.color = var_656_17
			end

			if arg_653_1.time_ >= var_656_14 + var_656_15 and arg_653_1.time_ < var_656_14 + var_656_15 + arg_656_0 then
				local var_656_18 = Color.New(0, 0, 0)
				local var_656_19 = 0

				arg_653_1.mask_.enabled = false
				var_656_18.a = var_656_19
				arg_653_1.mask_.color = var_656_18
			end

			if arg_653_1.frameCnt_ <= 1 then
				arg_653_1.dialog_:SetActive(false)
			end

			local var_656_20 = 2
			local var_656_21 = 0.95

			if var_656_20 < arg_653_1.time_ and arg_653_1.time_ <= var_656_20 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0

				arg_653_1.dialog_:SetActive(true)

				arg_653_1.dialogCg_.alpha = 0

				local var_656_22 = LeanTween.value(arg_653_1.dialog_, 0, 1, 0.3)

				var_656_22:setOnUpdate(LuaHelper.FloatAction(function(arg_657_0)
					arg_653_1.dialogCg_.alpha = arg_657_0
				end))
				var_656_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_653_1.dialog_)
					var_656_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_653_1.duration_ = arg_653_1.duration_ + 0.3

				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_23 = arg_653_1:GetWordFromCfg(1105006156)
				local var_656_24 = arg_653_1:FormatText(var_656_23.content)

				arg_653_1.text_.text = var_656_24

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_25 = 38
				local var_656_26 = utf8.len(var_656_24)
				local var_656_27 = var_656_25 <= 0 and var_656_21 or var_656_21 * (var_656_26 / var_656_25)

				if var_656_27 > 0 and var_656_21 < var_656_27 then
					arg_653_1.talkMaxDuration = var_656_27
					var_656_20 = var_656_20 + 0.3

					if var_656_27 + var_656_20 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_27 + var_656_20
					end
				end

				arg_653_1.text_.text = var_656_24
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_28 = var_656_20 + 0.3
			local var_656_29 = math.max(var_656_21, arg_653_1.talkMaxDuration)

			if var_656_28 <= arg_653_1.time_ and arg_653_1.time_ < var_656_28 + var_656_29 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_28) / var_656_29

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_28 + var_656_29 and arg_653_1.time_ < var_656_28 + var_656_29 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1105006157 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1105006157
		arg_659_1.duration_ = 3.8

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1105006158(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = 0
			local var_662_1 = 0.3

			if var_662_0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_0 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				local var_662_2 = arg_659_1:FormatText(StoryNameCfg[74].name)

				arg_659_1.leftNameTxt_.text = var_662_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_3 = arg_659_1:GetWordFromCfg(1105006157)
				local var_662_4 = arg_659_1:FormatText(var_662_3.content)

				arg_659_1.text_.text = var_662_4

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_5 = 12
				local var_662_6 = utf8.len(var_662_4)
				local var_662_7 = var_662_5 <= 0 and var_662_1 or var_662_1 * (var_662_6 / var_662_5)

				if var_662_7 > 0 and var_662_1 < var_662_7 then
					arg_659_1.talkMaxDuration = var_662_7

					if var_662_7 + var_662_0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_7 + var_662_0
					end
				end

				arg_659_1.text_.text = var_662_4
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006157", "story_v_side_new_1105006.awb") ~= 0 then
					local var_662_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006157", "story_v_side_new_1105006.awb") / 1000

					if var_662_8 + var_662_0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_8 + var_662_0
					end

					if var_662_3.prefab_name ~= "" and arg_659_1.actors_[var_662_3.prefab_name] ~= nil then
						local var_662_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_3.prefab_name].transform, "story_v_side_new_1105006", "1105006157", "story_v_side_new_1105006.awb")

						arg_659_1:RecordAudio("1105006157", var_662_9)
						arg_659_1:RecordAudio("1105006157", var_662_9)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006157", "story_v_side_new_1105006.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006157", "story_v_side_new_1105006.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_10 = math.max(var_662_1, arg_659_1.talkMaxDuration)

			if var_662_0 <= arg_659_1.time_ and arg_659_1.time_ < var_662_0 + var_662_10 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_0) / var_662_10

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_0 + var_662_10 and arg_659_1.time_ < var_662_0 + var_662_10 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play1105006158 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1105006158
		arg_663_1.duration_ = 7

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1105006159(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = 2

			if var_666_0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_0 + arg_666_0 then
				arg_663_1.allBtn_.enabled = false
			end

			local var_666_1 = 0.3

			if arg_663_1.time_ >= var_666_0 + var_666_1 and arg_663_1.time_ < var_666_0 + var_666_1 + arg_666_0 then
				arg_663_1.allBtn_.enabled = true
			end

			local var_666_2 = 1

			if var_666_2 < arg_663_1.time_ and arg_663_1.time_ <= var_666_2 + arg_666_0 then
				local var_666_3 = manager.ui.mainCamera.transform.localPosition
				local var_666_4 = Vector3.New(0, 0, 10) + Vector3.New(var_666_3.x, var_666_3.y, 0)
				local var_666_5 = arg_663_1.bgs_.STblack

				var_666_5.transform.localPosition = var_666_4
				var_666_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_666_6 = var_666_5:GetComponent("SpriteRenderer")

				if var_666_6 and var_666_6.sprite then
					local var_666_7 = (var_666_5.transform.localPosition - var_666_3).z
					local var_666_8 = manager.ui.mainCameraCom_
					local var_666_9 = 2 * var_666_7 * Mathf.Tan(var_666_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_666_10 = var_666_9 * var_666_8.aspect
					local var_666_11 = var_666_6.sprite.bounds.size.x
					local var_666_12 = var_666_6.sprite.bounds.size.y
					local var_666_13 = var_666_10 / var_666_11
					local var_666_14 = var_666_9 / var_666_12
					local var_666_15 = var_666_14 < var_666_13 and var_666_13 or var_666_14

					var_666_5.transform.localScale = Vector3.New(var_666_15, var_666_15, 0)
				end

				for iter_666_0, iter_666_1 in pairs(arg_663_1.bgs_) do
					if iter_666_0 ~= "STblack" then
						iter_666_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_666_16 = 0

			if var_666_16 < arg_663_1.time_ and arg_663_1.time_ <= var_666_16 + arg_666_0 then
				arg_663_1.mask_.enabled = true
				arg_663_1.mask_.raycastTarget = true

				arg_663_1:SetGaussion(false)
			end

			local var_666_17 = 1

			if var_666_16 <= arg_663_1.time_ and arg_663_1.time_ < var_666_16 + var_666_17 then
				local var_666_18 = (arg_663_1.time_ - var_666_16) / var_666_17
				local var_666_19 = Color.New(0, 0, 0)

				var_666_19.a = Mathf.Lerp(0, 1, var_666_18)
				arg_663_1.mask_.color = var_666_19
			end

			if arg_663_1.time_ >= var_666_16 + var_666_17 and arg_663_1.time_ < var_666_16 + var_666_17 + arg_666_0 then
				local var_666_20 = Color.New(0, 0, 0)

				var_666_20.a = 1
				arg_663_1.mask_.color = var_666_20
			end

			local var_666_21 = 1

			if var_666_21 < arg_663_1.time_ and arg_663_1.time_ <= var_666_21 + arg_666_0 then
				arg_663_1.mask_.enabled = true
				arg_663_1.mask_.raycastTarget = true

				arg_663_1:SetGaussion(false)
			end

			local var_666_22 = 1

			if var_666_21 <= arg_663_1.time_ and arg_663_1.time_ < var_666_21 + var_666_22 then
				local var_666_23 = (arg_663_1.time_ - var_666_21) / var_666_22
				local var_666_24 = Color.New(0, 0, 0)

				var_666_24.a = Mathf.Lerp(1, 0, var_666_23)
				arg_663_1.mask_.color = var_666_24
			end

			if arg_663_1.time_ >= var_666_21 + var_666_22 and arg_663_1.time_ < var_666_21 + var_666_22 + arg_666_0 then
				local var_666_25 = Color.New(0, 0, 0)
				local var_666_26 = 0

				arg_663_1.mask_.enabled = false
				var_666_25.a = var_666_26
				arg_663_1.mask_.color = var_666_25
			end

			if arg_663_1.frameCnt_ <= 1 then
				arg_663_1.dialog_:SetActive(false)
			end

			local var_666_27 = 2
			local var_666_28 = 0.775

			if var_666_27 < arg_663_1.time_ and arg_663_1.time_ <= var_666_27 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0

				arg_663_1.dialog_:SetActive(true)

				arg_663_1.dialogCg_.alpha = 0

				local var_666_29 = LeanTween.value(arg_663_1.dialog_, 0, 1, 0.3)

				var_666_29:setOnUpdate(LuaHelper.FloatAction(function(arg_667_0)
					arg_663_1.dialogCg_.alpha = arg_667_0
				end))
				var_666_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_663_1.dialog_)
					var_666_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_663_1.duration_ = arg_663_1.duration_ + 0.3

				SetActive(arg_663_1.leftNameGo_, false)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_30 = arg_663_1:GetWordFromCfg(1105006158)
				local var_666_31 = arg_663_1:FormatText(var_666_30.content)

				arg_663_1.text_.text = var_666_31

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_32 = 31
				local var_666_33 = utf8.len(var_666_31)
				local var_666_34 = var_666_32 <= 0 and var_666_28 or var_666_28 * (var_666_33 / var_666_32)

				if var_666_34 > 0 and var_666_28 < var_666_34 then
					arg_663_1.talkMaxDuration = var_666_34
					var_666_27 = var_666_27 + 0.3

					if var_666_34 + var_666_27 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_34 + var_666_27
					end
				end

				arg_663_1.text_.text = var_666_31
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_35 = var_666_27 + 0.3
			local var_666_36 = math.max(var_666_28, arg_663_1.talkMaxDuration)

			if var_666_35 <= arg_663_1.time_ and arg_663_1.time_ < var_666_35 + var_666_36 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_35) / var_666_36

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_35 + var_666_36 and arg_663_1.time_ < var_666_35 + var_666_36 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play1105006159 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1105006159
		arg_669_1.duration_ = 10.07

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1105006160(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = 1.03333333333333

			if var_672_0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_0 + arg_672_0 then
				local var_672_1 = manager.ui.mainCamera.transform.localPosition
				local var_672_2 = Vector3.New(0, 0, 10) + Vector3.New(var_672_1.x, var_672_1.y, 0)
				local var_672_3 = arg_669_1.bgs_.ST16

				var_672_3.transform.localPosition = var_672_2
				var_672_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_672_4 = var_672_3:GetComponent("SpriteRenderer")

				if var_672_4 and var_672_4.sprite then
					local var_672_5 = (var_672_3.transform.localPosition - var_672_1).z
					local var_672_6 = manager.ui.mainCameraCom_
					local var_672_7 = 2 * var_672_5 * Mathf.Tan(var_672_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_672_8 = var_672_7 * var_672_6.aspect
					local var_672_9 = var_672_4.sprite.bounds.size.x
					local var_672_10 = var_672_4.sprite.bounds.size.y
					local var_672_11 = var_672_8 / var_672_9
					local var_672_12 = var_672_7 / var_672_10
					local var_672_13 = var_672_12 < var_672_11 and var_672_11 or var_672_12

					var_672_3.transform.localScale = Vector3.New(var_672_13, var_672_13, 0)
				end

				for iter_672_0, iter_672_1 in pairs(arg_669_1.bgs_) do
					if iter_672_0 ~= "ST16" then
						iter_672_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_672_14 = 2.06666666666667

			if var_672_14 < arg_669_1.time_ and arg_669_1.time_ <= var_672_14 + arg_672_0 then
				arg_669_1.allBtn_.enabled = false
			end

			local var_672_15 = 0.3

			if arg_669_1.time_ >= var_672_14 + var_672_15 and arg_669_1.time_ < var_672_14 + var_672_15 + arg_672_0 then
				arg_669_1.allBtn_.enabled = true
			end

			local var_672_16 = 0

			if var_672_16 < arg_669_1.time_ and arg_669_1.time_ <= var_672_16 + arg_672_0 then
				arg_669_1.mask_.enabled = true
				arg_669_1.mask_.raycastTarget = true

				arg_669_1:SetGaussion(false)
			end

			local var_672_17 = 1.03333333333333

			if var_672_16 <= arg_669_1.time_ and arg_669_1.time_ < var_672_16 + var_672_17 then
				local var_672_18 = (arg_669_1.time_ - var_672_16) / var_672_17
				local var_672_19 = Color.New(0, 0, 0)

				var_672_19.a = Mathf.Lerp(0, 1, var_672_18)
				arg_669_1.mask_.color = var_672_19
			end

			if arg_669_1.time_ >= var_672_16 + var_672_17 and arg_669_1.time_ < var_672_16 + var_672_17 + arg_672_0 then
				local var_672_20 = Color.New(0, 0, 0)

				var_672_20.a = 1
				arg_669_1.mask_.color = var_672_20
			end

			local var_672_21 = 1.03333333333333

			if var_672_21 < arg_669_1.time_ and arg_669_1.time_ <= var_672_21 + arg_672_0 then
				arg_669_1.mask_.enabled = true
				arg_669_1.mask_.raycastTarget = true

				arg_669_1:SetGaussion(false)
			end

			local var_672_22 = 1.03333333333333

			if var_672_21 <= arg_669_1.time_ and arg_669_1.time_ < var_672_21 + var_672_22 then
				local var_672_23 = (arg_669_1.time_ - var_672_21) / var_672_22
				local var_672_24 = Color.New(0, 0, 0)

				var_672_24.a = Mathf.Lerp(1, 0, var_672_23)
				arg_669_1.mask_.color = var_672_24
			end

			if arg_669_1.time_ >= var_672_21 + var_672_22 and arg_669_1.time_ < var_672_21 + var_672_22 + arg_672_0 then
				local var_672_25 = Color.New(0, 0, 0)
				local var_672_26 = 0

				arg_669_1.mask_.enabled = false
				var_672_25.a = var_672_26
				arg_669_1.mask_.color = var_672_25
			end

			if arg_669_1.frameCnt_ <= 1 then
				arg_669_1.dialog_:SetActive(false)
			end

			local var_672_27 = 2.06666666666667
			local var_672_28 = 1.075

			if var_672_27 < arg_669_1.time_ and arg_669_1.time_ <= var_672_27 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0

				arg_669_1.dialog_:SetActive(true)

				arg_669_1.dialogCg_.alpha = 0

				local var_672_29 = LeanTween.value(arg_669_1.dialog_, 0, 1, 0.3)

				var_672_29:setOnUpdate(LuaHelper.FloatAction(function(arg_673_0)
					arg_669_1.dialogCg_.alpha = arg_673_0
				end))
				var_672_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_669_1.dialog_)
					var_672_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_669_1.duration_ = arg_669_1.duration_ + 0.3

				SetActive(arg_669_1.leftNameGo_, true)

				local var_672_30 = arg_669_1:FormatText(StoryNameCfg[224].name)

				arg_669_1.leftNameTxt_.text = var_672_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_31 = arg_669_1:GetWordFromCfg(1105006159)
				local var_672_32 = arg_669_1:FormatText(var_672_31.content)

				arg_669_1.text_.text = var_672_32

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_33 = 43
				local var_672_34 = utf8.len(var_672_32)
				local var_672_35 = var_672_33 <= 0 and var_672_28 or var_672_28 * (var_672_34 / var_672_33)

				if var_672_35 > 0 and var_672_28 < var_672_35 then
					arg_669_1.talkMaxDuration = var_672_35
					var_672_27 = var_672_27 + 0.3

					if var_672_35 + var_672_27 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_35 + var_672_27
					end
				end

				arg_669_1.text_.text = var_672_32
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006159", "story_v_side_new_1105006.awb") ~= 0 then
					local var_672_36 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006159", "story_v_side_new_1105006.awb") / 1000

					if var_672_36 + var_672_27 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_36 + var_672_27
					end

					if var_672_31.prefab_name ~= "" and arg_669_1.actors_[var_672_31.prefab_name] ~= nil then
						local var_672_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_31.prefab_name].transform, "story_v_side_new_1105006", "1105006159", "story_v_side_new_1105006.awb")

						arg_669_1:RecordAudio("1105006159", var_672_37)
						arg_669_1:RecordAudio("1105006159", var_672_37)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006159", "story_v_side_new_1105006.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006159", "story_v_side_new_1105006.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_38 = var_672_27 + 0.3
			local var_672_39 = math.max(var_672_28, arg_669_1.talkMaxDuration)

			if var_672_38 <= arg_669_1.time_ and arg_669_1.time_ < var_672_38 + var_672_39 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_38) / var_672_39

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_38 + var_672_39 and arg_669_1.time_ < var_672_38 + var_672_39 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1105006160 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 1105006160
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play1105006161(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 0
			local var_678_1 = 0.85

			if var_678_0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_0 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, false)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_2 = arg_675_1:GetWordFromCfg(1105006160)
				local var_678_3 = arg_675_1:FormatText(var_678_2.content)

				arg_675_1.text_.text = var_678_3

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_4 = 34
				local var_678_5 = utf8.len(var_678_3)
				local var_678_6 = var_678_4 <= 0 and var_678_1 or var_678_1 * (var_678_5 / var_678_4)

				if var_678_6 > 0 and var_678_1 < var_678_6 then
					arg_675_1.talkMaxDuration = var_678_6

					if var_678_6 + var_678_0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_6 + var_678_0
					end
				end

				arg_675_1.text_.text = var_678_3
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_7 = math.max(var_678_1, arg_675_1.talkMaxDuration)

			if var_678_0 <= arg_675_1.time_ and arg_675_1.time_ < var_678_0 + var_678_7 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_0) / var_678_7

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_0 + var_678_7 and arg_675_1.time_ < var_678_0 + var_678_7 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play1105006161 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1105006161
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1105006162(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = 0
			local var_682_1 = 1.2

			if var_682_0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_0 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, false)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_2 = arg_679_1:GetWordFromCfg(1105006161)
				local var_682_3 = arg_679_1:FormatText(var_682_2.content)

				arg_679_1.text_.text = var_682_3

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_4 = 48
				local var_682_5 = utf8.len(var_682_3)
				local var_682_6 = var_682_4 <= 0 and var_682_1 or var_682_1 * (var_682_5 / var_682_4)

				if var_682_6 > 0 and var_682_1 < var_682_6 then
					arg_679_1.talkMaxDuration = var_682_6

					if var_682_6 + var_682_0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_6 + var_682_0
					end
				end

				arg_679_1.text_.text = var_682_3
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_7 = math.max(var_682_1, arg_679_1.talkMaxDuration)

			if var_682_0 <= arg_679_1.time_ and arg_679_1.time_ < var_682_0 + var_682_7 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_0) / var_682_7

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_0 + var_682_7 and arg_679_1.time_ < var_682_0 + var_682_7 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play1105006162 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1105006162
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1105006163(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0
			local var_686_1 = 0.9

			if var_686_0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, false)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_2 = arg_683_1:GetWordFromCfg(1105006162)
				local var_686_3 = arg_683_1:FormatText(var_686_2.content)

				arg_683_1.text_.text = var_686_3

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_4 = 36
				local var_686_5 = utf8.len(var_686_3)
				local var_686_6 = var_686_4 <= 0 and var_686_1 or var_686_1 * (var_686_5 / var_686_4)

				if var_686_6 > 0 and var_686_1 < var_686_6 then
					arg_683_1.talkMaxDuration = var_686_6

					if var_686_6 + var_686_0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_6 + var_686_0
					end
				end

				arg_683_1.text_.text = var_686_3
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_7 = math.max(var_686_1, arg_683_1.talkMaxDuration)

			if var_686_0 <= arg_683_1.time_ and arg_683_1.time_ < var_686_0 + var_686_7 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_0) / var_686_7

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_0 + var_686_7 and arg_683_1.time_ < var_686_0 + var_686_7 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1105006163 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1105006163
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1105006164(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 0
			local var_690_1 = 1.35

			if var_690_0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, false)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_2 = arg_687_1:GetWordFromCfg(1105006163)
				local var_690_3 = arg_687_1:FormatText(var_690_2.content)

				arg_687_1.text_.text = var_690_3

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_4 = 54
				local var_690_5 = utf8.len(var_690_3)
				local var_690_6 = var_690_4 <= 0 and var_690_1 or var_690_1 * (var_690_5 / var_690_4)

				if var_690_6 > 0 and var_690_1 < var_690_6 then
					arg_687_1.talkMaxDuration = var_690_6

					if var_690_6 + var_690_0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_6 + var_690_0
					end
				end

				arg_687_1.text_.text = var_690_3
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_7 = math.max(var_690_1, arg_687_1.talkMaxDuration)

			if var_690_0 <= arg_687_1.time_ and arg_687_1.time_ < var_690_0 + var_690_7 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_0) / var_690_7

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_0 + var_690_7 and arg_687_1.time_ < var_690_0 + var_690_7 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1105006164 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1105006164
		arg_691_1.duration_ = 5.6

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1105006165(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = "1150ui_story"

			if arg_691_1.actors_[var_694_0] == nil then
				local var_694_1 = Asset.Load("Char/" .. "1150ui_story")

				if not isNil(var_694_1) then
					local var_694_2 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_691_1.stage_.transform)

					var_694_2.name = var_694_0
					var_694_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_691_1.actors_[var_694_0] = var_694_2

					local var_694_3 = var_694_2:GetComponentInChildren(typeof(CharacterEffect))

					var_694_3.enabled = true

					local var_694_4 = GameObjectTools.GetOrAddComponent(var_694_2, typeof(DynamicBoneHelper))

					if var_694_4 then
						var_694_4:EnableDynamicBone(false)
					end

					arg_691_1:ShowWeapon(var_694_3.transform, false)

					arg_691_1.var_[var_694_0 .. "Animator"] = var_694_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_691_1.var_[var_694_0 .. "Animator"].applyRootMotion = true
					arg_691_1.var_[var_694_0 .. "LipSync"] = var_694_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_694_5 = arg_691_1.actors_["1150ui_story"].transform
			local var_694_6 = 0

			if var_694_6 < arg_691_1.time_ and arg_691_1.time_ <= var_694_6 + arg_694_0 then
				arg_691_1.var_.moveOldPos1150ui_story = var_694_5.localPosition
			end

			local var_694_7 = 0.001

			if var_694_6 <= arg_691_1.time_ and arg_691_1.time_ < var_694_6 + var_694_7 then
				local var_694_8 = (arg_691_1.time_ - var_694_6) / var_694_7
				local var_694_9 = Vector3.New(0, -1.01, -6.2)

				var_694_5.localPosition = Vector3.Lerp(arg_691_1.var_.moveOldPos1150ui_story, var_694_9, var_694_8)

				local var_694_10 = manager.ui.mainCamera.transform.position - var_694_5.position

				var_694_5.forward = Vector3.New(var_694_10.x, var_694_10.y, var_694_10.z)

				local var_694_11 = var_694_5.localEulerAngles

				var_694_11.z = 0
				var_694_11.x = 0
				var_694_5.localEulerAngles = var_694_11
			end

			if arg_691_1.time_ >= var_694_6 + var_694_7 and arg_691_1.time_ < var_694_6 + var_694_7 + arg_694_0 then
				var_694_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_694_12 = manager.ui.mainCamera.transform.position - var_694_5.position

				var_694_5.forward = Vector3.New(var_694_12.x, var_694_12.y, var_694_12.z)

				local var_694_13 = var_694_5.localEulerAngles

				var_694_13.z = 0
				var_694_13.x = 0
				var_694_5.localEulerAngles = var_694_13
			end

			local var_694_14 = arg_691_1.actors_["1150ui_story"]
			local var_694_15 = 0

			if var_694_15 < arg_691_1.time_ and arg_691_1.time_ <= var_694_15 + arg_694_0 and not isNil(var_694_14) and arg_691_1.var_.characterEffect1150ui_story == nil then
				arg_691_1.var_.characterEffect1150ui_story = var_694_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_16 = 0.200000002980232

			if var_694_15 <= arg_691_1.time_ and arg_691_1.time_ < var_694_15 + var_694_16 and not isNil(var_694_14) then
				local var_694_17 = (arg_691_1.time_ - var_694_15) / var_694_16

				if arg_691_1.var_.characterEffect1150ui_story and not isNil(var_694_14) then
					arg_691_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_691_1.time_ >= var_694_15 + var_694_16 and arg_691_1.time_ < var_694_15 + var_694_16 + arg_694_0 and not isNil(var_694_14) and arg_691_1.var_.characterEffect1150ui_story then
				arg_691_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_694_18 = 0

			if var_694_18 < arg_691_1.time_ and arg_691_1.time_ <= var_694_18 + arg_694_0 then
				arg_691_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_694_19 = 0

			if var_694_19 < arg_691_1.time_ and arg_691_1.time_ <= var_694_19 + arg_694_0 then
				arg_691_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_694_20 = 0
			local var_694_21 = 0.525

			if var_694_20 < arg_691_1.time_ and arg_691_1.time_ <= var_694_20 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_22 = arg_691_1:FormatText(StoryNameCfg[74].name)

				arg_691_1.leftNameTxt_.text = var_694_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_23 = arg_691_1:GetWordFromCfg(1105006164)
				local var_694_24 = arg_691_1:FormatText(var_694_23.content)

				arg_691_1.text_.text = var_694_24

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_25 = 21
				local var_694_26 = utf8.len(var_694_24)
				local var_694_27 = var_694_25 <= 0 and var_694_21 or var_694_21 * (var_694_26 / var_694_25)

				if var_694_27 > 0 and var_694_21 < var_694_27 then
					arg_691_1.talkMaxDuration = var_694_27

					if var_694_27 + var_694_20 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_27 + var_694_20
					end
				end

				arg_691_1.text_.text = var_694_24
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006164", "story_v_side_new_1105006.awb") ~= 0 then
					local var_694_28 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006164", "story_v_side_new_1105006.awb") / 1000

					if var_694_28 + var_694_20 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_28 + var_694_20
					end

					if var_694_23.prefab_name ~= "" and arg_691_1.actors_[var_694_23.prefab_name] ~= nil then
						local var_694_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_23.prefab_name].transform, "story_v_side_new_1105006", "1105006164", "story_v_side_new_1105006.awb")

						arg_691_1:RecordAudio("1105006164", var_694_29)
						arg_691_1:RecordAudio("1105006164", var_694_29)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006164", "story_v_side_new_1105006.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006164", "story_v_side_new_1105006.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_30 = math.max(var_694_21, arg_691_1.talkMaxDuration)

			if var_694_20 <= arg_691_1.time_ and arg_691_1.time_ < var_694_20 + var_694_30 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_20) / var_694_30

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_20 + var_694_30 and arg_691_1.time_ < var_694_20 + var_694_30 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_691_1:InitPlayNodeList()
	end,
	Play1105006165 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1105006165
		arg_695_1.duration_ = 4.37

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1105006166(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 0
			local var_698_1 = 0.4

			if var_698_0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_2 = arg_695_1:FormatText(StoryNameCfg[74].name)

				arg_695_1.leftNameTxt_.text = var_698_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_3 = arg_695_1:GetWordFromCfg(1105006165)
				local var_698_4 = arg_695_1:FormatText(var_698_3.content)

				arg_695_1.text_.text = var_698_4

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_5 = 16
				local var_698_6 = utf8.len(var_698_4)
				local var_698_7 = var_698_5 <= 0 and var_698_1 or var_698_1 * (var_698_6 / var_698_5)

				if var_698_7 > 0 and var_698_1 < var_698_7 then
					arg_695_1.talkMaxDuration = var_698_7

					if var_698_7 + var_698_0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_7 + var_698_0
					end
				end

				arg_695_1.text_.text = var_698_4
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006165", "story_v_side_new_1105006.awb") ~= 0 then
					local var_698_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006165", "story_v_side_new_1105006.awb") / 1000

					if var_698_8 + var_698_0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_8 + var_698_0
					end

					if var_698_3.prefab_name ~= "" and arg_695_1.actors_[var_698_3.prefab_name] ~= nil then
						local var_698_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_3.prefab_name].transform, "story_v_side_new_1105006", "1105006165", "story_v_side_new_1105006.awb")

						arg_695_1:RecordAudio("1105006165", var_698_9)
						arg_695_1:RecordAudio("1105006165", var_698_9)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006165", "story_v_side_new_1105006.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006165", "story_v_side_new_1105006.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_10 = math.max(var_698_1, arg_695_1.talkMaxDuration)

			if var_698_0 <= arg_695_1.time_ and arg_695_1.time_ < var_698_0 + var_698_10 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_0) / var_698_10

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_0 + var_698_10 and arg_695_1.time_ < var_698_0 + var_698_10 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1105006166 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1105006166
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1105006167(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["1150ui_story"].transform
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 then
				arg_699_1.var_.moveOldPos1150ui_story = var_702_0.localPosition
			end

			local var_702_2 = 0.001

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_2 then
				local var_702_3 = (arg_699_1.time_ - var_702_1) / var_702_2
				local var_702_4 = Vector3.New(0, 100, 0)

				var_702_0.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos1150ui_story, var_702_4, var_702_3)

				local var_702_5 = manager.ui.mainCamera.transform.position - var_702_0.position

				var_702_0.forward = Vector3.New(var_702_5.x, var_702_5.y, var_702_5.z)

				local var_702_6 = var_702_0.localEulerAngles

				var_702_6.z = 0
				var_702_6.x = 0
				var_702_0.localEulerAngles = var_702_6
			end

			if arg_699_1.time_ >= var_702_1 + var_702_2 and arg_699_1.time_ < var_702_1 + var_702_2 + arg_702_0 then
				var_702_0.localPosition = Vector3.New(0, 100, 0)

				local var_702_7 = manager.ui.mainCamera.transform.position - var_702_0.position

				var_702_0.forward = Vector3.New(var_702_7.x, var_702_7.y, var_702_7.z)

				local var_702_8 = var_702_0.localEulerAngles

				var_702_8.z = 0
				var_702_8.x = 0
				var_702_0.localEulerAngles = var_702_8
			end

			local var_702_9 = 0
			local var_702_10 = 1.1

			if var_702_9 < arg_699_1.time_ and arg_699_1.time_ <= var_702_9 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, false)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_11 = arg_699_1:GetWordFromCfg(1105006166)
				local var_702_12 = arg_699_1:FormatText(var_702_11.content)

				arg_699_1.text_.text = var_702_12

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_13 = 44
				local var_702_14 = utf8.len(var_702_12)
				local var_702_15 = var_702_13 <= 0 and var_702_10 or var_702_10 * (var_702_14 / var_702_13)

				if var_702_15 > 0 and var_702_10 < var_702_15 then
					arg_699_1.talkMaxDuration = var_702_15

					if var_702_15 + var_702_9 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_15 + var_702_9
					end
				end

				arg_699_1.text_.text = var_702_12
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_16 = math.max(var_702_10, arg_699_1.talkMaxDuration)

			if var_702_9 <= arg_699_1.time_ and arg_699_1.time_ < var_702_9 + var_702_16 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_9) / var_702_16

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_9 + var_702_16 and arg_699_1.time_ < var_702_9 + var_702_16 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_699_1:InitPlayNodeList()
	end,
	Play1105006167 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1105006167
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1105006168(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = 0
			local var_706_1 = 1.475

			if var_706_0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_0 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, false)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_2 = arg_703_1:GetWordFromCfg(1105006167)
				local var_706_3 = arg_703_1:FormatText(var_706_2.content)

				arg_703_1.text_.text = var_706_3

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_4 = 59
				local var_706_5 = utf8.len(var_706_3)
				local var_706_6 = var_706_4 <= 0 and var_706_1 or var_706_1 * (var_706_5 / var_706_4)

				if var_706_6 > 0 and var_706_1 < var_706_6 then
					arg_703_1.talkMaxDuration = var_706_6

					if var_706_6 + var_706_0 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_6 + var_706_0
					end
				end

				arg_703_1.text_.text = var_706_3
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_7 = math.max(var_706_1, arg_703_1.talkMaxDuration)

			if var_706_0 <= arg_703_1.time_ and arg_703_1.time_ < var_706_0 + var_706_7 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_0) / var_706_7

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_0 + var_706_7 and arg_703_1.time_ < var_706_0 + var_706_7 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play1105006168 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1105006168
		arg_707_1.duration_ = 3.6

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play1105006169(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = arg_707_1.actors_["1150ui_story"].transform
			local var_710_1 = 0

			if var_710_1 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 then
				arg_707_1.var_.moveOldPos1150ui_story = var_710_0.localPosition
			end

			local var_710_2 = 0.001

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_2 then
				local var_710_3 = (arg_707_1.time_ - var_710_1) / var_710_2
				local var_710_4 = Vector3.New(0, -1.01, -6.2)

				var_710_0.localPosition = Vector3.Lerp(arg_707_1.var_.moveOldPos1150ui_story, var_710_4, var_710_3)

				local var_710_5 = manager.ui.mainCamera.transform.position - var_710_0.position

				var_710_0.forward = Vector3.New(var_710_5.x, var_710_5.y, var_710_5.z)

				local var_710_6 = var_710_0.localEulerAngles

				var_710_6.z = 0
				var_710_6.x = 0
				var_710_0.localEulerAngles = var_710_6
			end

			if arg_707_1.time_ >= var_710_1 + var_710_2 and arg_707_1.time_ < var_710_1 + var_710_2 + arg_710_0 then
				var_710_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_710_7 = manager.ui.mainCamera.transform.position - var_710_0.position

				var_710_0.forward = Vector3.New(var_710_7.x, var_710_7.y, var_710_7.z)

				local var_710_8 = var_710_0.localEulerAngles

				var_710_8.z = 0
				var_710_8.x = 0
				var_710_0.localEulerAngles = var_710_8
			end

			local var_710_9 = arg_707_1.actors_["1150ui_story"]
			local var_710_10 = 0

			if var_710_10 < arg_707_1.time_ and arg_707_1.time_ <= var_710_10 + arg_710_0 and not isNil(var_710_9) and arg_707_1.var_.characterEffect1150ui_story == nil then
				arg_707_1.var_.characterEffect1150ui_story = var_710_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_710_11 = 0.200000002980232

			if var_710_10 <= arg_707_1.time_ and arg_707_1.time_ < var_710_10 + var_710_11 and not isNil(var_710_9) then
				local var_710_12 = (arg_707_1.time_ - var_710_10) / var_710_11

				if arg_707_1.var_.characterEffect1150ui_story and not isNil(var_710_9) then
					arg_707_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_707_1.time_ >= var_710_10 + var_710_11 and arg_707_1.time_ < var_710_10 + var_710_11 + arg_710_0 and not isNil(var_710_9) and arg_707_1.var_.characterEffect1150ui_story then
				arg_707_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_710_13 = 0

			if var_710_13 < arg_707_1.time_ and arg_707_1.time_ <= var_710_13 + arg_710_0 then
				arg_707_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_710_14 = 0

			if var_710_14 < arg_707_1.time_ and arg_707_1.time_ <= var_710_14 + arg_710_0 then
				arg_707_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_710_15 = 0
			local var_710_16 = 0.3

			if var_710_15 < arg_707_1.time_ and arg_707_1.time_ <= var_710_15 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				local var_710_17 = arg_707_1:FormatText(StoryNameCfg[74].name)

				arg_707_1.leftNameTxt_.text = var_710_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_18 = arg_707_1:GetWordFromCfg(1105006168)
				local var_710_19 = arg_707_1:FormatText(var_710_18.content)

				arg_707_1.text_.text = var_710_19

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_20 = 12
				local var_710_21 = utf8.len(var_710_19)
				local var_710_22 = var_710_20 <= 0 and var_710_16 or var_710_16 * (var_710_21 / var_710_20)

				if var_710_22 > 0 and var_710_16 < var_710_22 then
					arg_707_1.talkMaxDuration = var_710_22

					if var_710_22 + var_710_15 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_22 + var_710_15
					end
				end

				arg_707_1.text_.text = var_710_19
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006168", "story_v_side_new_1105006.awb") ~= 0 then
					local var_710_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006168", "story_v_side_new_1105006.awb") / 1000

					if var_710_23 + var_710_15 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_23 + var_710_15
					end

					if var_710_18.prefab_name ~= "" and arg_707_1.actors_[var_710_18.prefab_name] ~= nil then
						local var_710_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_707_1.actors_[var_710_18.prefab_name].transform, "story_v_side_new_1105006", "1105006168", "story_v_side_new_1105006.awb")

						arg_707_1:RecordAudio("1105006168", var_710_24)
						arg_707_1:RecordAudio("1105006168", var_710_24)
					else
						arg_707_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006168", "story_v_side_new_1105006.awb")
					end

					arg_707_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006168", "story_v_side_new_1105006.awb")
				end

				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_25 = math.max(var_710_16, arg_707_1.talkMaxDuration)

			if var_710_15 <= arg_707_1.time_ and arg_707_1.time_ < var_710_15 + var_710_25 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_15) / var_710_25

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_15 + var_710_25 and arg_707_1.time_ < var_710_15 + var_710_25 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_707_1:InitPlayNodeList()
	end,
	Play1105006169 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1105006169
		arg_711_1.duration_ = 5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play1105006170(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = arg_711_1.actors_["1150ui_story"]
			local var_714_1 = 0

			if var_714_1 < arg_711_1.time_ and arg_711_1.time_ <= var_714_1 + arg_714_0 and not isNil(var_714_0) and arg_711_1.var_.characterEffect1150ui_story == nil then
				arg_711_1.var_.characterEffect1150ui_story = var_714_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_2 = 0.200000002980232

			if var_714_1 <= arg_711_1.time_ and arg_711_1.time_ < var_714_1 + var_714_2 and not isNil(var_714_0) then
				local var_714_3 = (arg_711_1.time_ - var_714_1) / var_714_2

				if arg_711_1.var_.characterEffect1150ui_story and not isNil(var_714_0) then
					local var_714_4 = Mathf.Lerp(0, 0.5, var_714_3)

					arg_711_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_711_1.var_.characterEffect1150ui_story.fillRatio = var_714_4
				end
			end

			if arg_711_1.time_ >= var_714_1 + var_714_2 and arg_711_1.time_ < var_714_1 + var_714_2 + arg_714_0 and not isNil(var_714_0) and arg_711_1.var_.characterEffect1150ui_story then
				local var_714_5 = 0.5

				arg_711_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_711_1.var_.characterEffect1150ui_story.fillRatio = var_714_5
			end

			local var_714_6 = 0
			local var_714_7 = 0.875

			if var_714_6 < arg_711_1.time_ and arg_711_1.time_ <= var_714_6 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, false)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_8 = arg_711_1:GetWordFromCfg(1105006169)
				local var_714_9 = arg_711_1:FormatText(var_714_8.content)

				arg_711_1.text_.text = var_714_9

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_10 = 35
				local var_714_11 = utf8.len(var_714_9)
				local var_714_12 = var_714_10 <= 0 and var_714_7 or var_714_7 * (var_714_11 / var_714_10)

				if var_714_12 > 0 and var_714_7 < var_714_12 then
					arg_711_1.talkMaxDuration = var_714_12

					if var_714_12 + var_714_6 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_12 + var_714_6
					end
				end

				arg_711_1.text_.text = var_714_9
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_13 = math.max(var_714_7, arg_711_1.talkMaxDuration)

			if var_714_6 <= arg_711_1.time_ and arg_711_1.time_ < var_714_6 + var_714_13 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_6) / var_714_13

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_6 + var_714_13 and arg_711_1.time_ < var_714_6 + var_714_13 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play1105006170 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 1105006170
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play1105006171(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = 0
			local var_718_1 = 1.025

			if var_718_0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_0 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, false)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_2 = arg_715_1:GetWordFromCfg(1105006170)
				local var_718_3 = arg_715_1:FormatText(var_718_2.content)

				arg_715_1.text_.text = var_718_3

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_4 = 41
				local var_718_5 = utf8.len(var_718_3)
				local var_718_6 = var_718_4 <= 0 and var_718_1 or var_718_1 * (var_718_5 / var_718_4)

				if var_718_6 > 0 and var_718_1 < var_718_6 then
					arg_715_1.talkMaxDuration = var_718_6

					if var_718_6 + var_718_0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_6 + var_718_0
					end
				end

				arg_715_1.text_.text = var_718_3
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_7 = math.max(var_718_1, arg_715_1.talkMaxDuration)

			if var_718_0 <= arg_715_1.time_ and arg_715_1.time_ < var_718_0 + var_718_7 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_0) / var_718_7

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_0 + var_718_7 and arg_715_1.time_ < var_718_0 + var_718_7 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play1105006171 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 1105006171
		arg_719_1.duration_ = 12.27

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play1105006172(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = arg_719_1.actors_["1150ui_story"]
			local var_722_1 = 0

			if var_722_1 < arg_719_1.time_ and arg_719_1.time_ <= var_722_1 + arg_722_0 and not isNil(var_722_0) and arg_719_1.var_.characterEffect1150ui_story == nil then
				arg_719_1.var_.characterEffect1150ui_story = var_722_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_722_2 = 0.200000002980232

			if var_722_1 <= arg_719_1.time_ and arg_719_1.time_ < var_722_1 + var_722_2 and not isNil(var_722_0) then
				local var_722_3 = (arg_719_1.time_ - var_722_1) / var_722_2

				if arg_719_1.var_.characterEffect1150ui_story and not isNil(var_722_0) then
					arg_719_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_719_1.time_ >= var_722_1 + var_722_2 and arg_719_1.time_ < var_722_1 + var_722_2 + arg_722_0 and not isNil(var_722_0) and arg_719_1.var_.characterEffect1150ui_story then
				arg_719_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_722_4 = 0

			if var_722_4 < arg_719_1.time_ and arg_719_1.time_ <= var_722_4 + arg_722_0 then
				arg_719_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_722_5 = 0
			local var_722_6 = 1.175

			if var_722_5 < arg_719_1.time_ and arg_719_1.time_ <= var_722_5 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				local var_722_7 = arg_719_1:FormatText(StoryNameCfg[74].name)

				arg_719_1.leftNameTxt_.text = var_722_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_8 = arg_719_1:GetWordFromCfg(1105006171)
				local var_722_9 = arg_719_1:FormatText(var_722_8.content)

				arg_719_1.text_.text = var_722_9

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_10 = 48
				local var_722_11 = utf8.len(var_722_9)
				local var_722_12 = var_722_10 <= 0 and var_722_6 or var_722_6 * (var_722_11 / var_722_10)

				if var_722_12 > 0 and var_722_6 < var_722_12 then
					arg_719_1.talkMaxDuration = var_722_12

					if var_722_12 + var_722_5 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_12 + var_722_5
					end
				end

				arg_719_1.text_.text = var_722_9
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006171", "story_v_side_new_1105006.awb") ~= 0 then
					local var_722_13 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006171", "story_v_side_new_1105006.awb") / 1000

					if var_722_13 + var_722_5 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_13 + var_722_5
					end

					if var_722_8.prefab_name ~= "" and arg_719_1.actors_[var_722_8.prefab_name] ~= nil then
						local var_722_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_719_1.actors_[var_722_8.prefab_name].transform, "story_v_side_new_1105006", "1105006171", "story_v_side_new_1105006.awb")

						arg_719_1:RecordAudio("1105006171", var_722_14)
						arg_719_1:RecordAudio("1105006171", var_722_14)
					else
						arg_719_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006171", "story_v_side_new_1105006.awb")
					end

					arg_719_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006171", "story_v_side_new_1105006.awb")
				end

				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_15 = math.max(var_722_6, arg_719_1.talkMaxDuration)

			if var_722_5 <= arg_719_1.time_ and arg_719_1.time_ < var_722_5 + var_722_15 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_5) / var_722_15

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_5 + var_722_15 and arg_719_1.time_ < var_722_5 + var_722_15 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play1105006172 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 1105006172
		arg_723_1.duration_ = 5

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play1105006173(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = arg_723_1.actors_["1150ui_story"].transform
			local var_726_1 = 0

			if var_726_1 < arg_723_1.time_ and arg_723_1.time_ <= var_726_1 + arg_726_0 then
				arg_723_1.var_.moveOldPos1150ui_story = var_726_0.localPosition
			end

			local var_726_2 = 0.001

			if var_726_1 <= arg_723_1.time_ and arg_723_1.time_ < var_726_1 + var_726_2 then
				local var_726_3 = (arg_723_1.time_ - var_726_1) / var_726_2
				local var_726_4 = Vector3.New(0, 100, 0)

				var_726_0.localPosition = Vector3.Lerp(arg_723_1.var_.moveOldPos1150ui_story, var_726_4, var_726_3)

				local var_726_5 = manager.ui.mainCamera.transform.position - var_726_0.position

				var_726_0.forward = Vector3.New(var_726_5.x, var_726_5.y, var_726_5.z)

				local var_726_6 = var_726_0.localEulerAngles

				var_726_6.z = 0
				var_726_6.x = 0
				var_726_0.localEulerAngles = var_726_6
			end

			if arg_723_1.time_ >= var_726_1 + var_726_2 and arg_723_1.time_ < var_726_1 + var_726_2 + arg_726_0 then
				var_726_0.localPosition = Vector3.New(0, 100, 0)

				local var_726_7 = manager.ui.mainCamera.transform.position - var_726_0.position

				var_726_0.forward = Vector3.New(var_726_7.x, var_726_7.y, var_726_7.z)

				local var_726_8 = var_726_0.localEulerAngles

				var_726_8.z = 0
				var_726_8.x = 0
				var_726_0.localEulerAngles = var_726_8
			end

			local var_726_9 = 0
			local var_726_10 = 0.725

			if var_726_9 < arg_723_1.time_ and arg_723_1.time_ <= var_726_9 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, false)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_11 = arg_723_1:GetWordFromCfg(1105006172)
				local var_726_12 = arg_723_1:FormatText(var_726_11.content)

				arg_723_1.text_.text = var_726_12

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_13 = 29
				local var_726_14 = utf8.len(var_726_12)
				local var_726_15 = var_726_13 <= 0 and var_726_10 or var_726_10 * (var_726_14 / var_726_13)

				if var_726_15 > 0 and var_726_10 < var_726_15 then
					arg_723_1.talkMaxDuration = var_726_15

					if var_726_15 + var_726_9 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_15 + var_726_9
					end
				end

				arg_723_1.text_.text = var_726_12
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)
				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_16 = math.max(var_726_10, arg_723_1.talkMaxDuration)

			if var_726_9 <= arg_723_1.time_ and arg_723_1.time_ < var_726_9 + var_726_16 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_9) / var_726_16

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_9 + var_726_16 and arg_723_1.time_ < var_726_9 + var_726_16 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_723_1:InitPlayNodeList()
	end,
	Play1105006173 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 1105006173
		arg_727_1.duration_ = 4

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play1105006174(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = arg_727_1.actors_["1150ui_story"]
			local var_730_1 = 0

			if var_730_1 < arg_727_1.time_ and arg_727_1.time_ <= var_730_1 + arg_730_0 and not isNil(var_730_0) and arg_727_1.var_.characterEffect1150ui_story == nil then
				arg_727_1.var_.characterEffect1150ui_story = var_730_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_2 = 0.200000002980232

			if var_730_1 <= arg_727_1.time_ and arg_727_1.time_ < var_730_1 + var_730_2 and not isNil(var_730_0) then
				local var_730_3 = (arg_727_1.time_ - var_730_1) / var_730_2

				if arg_727_1.var_.characterEffect1150ui_story and not isNil(var_730_0) then
					arg_727_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_727_1.time_ >= var_730_1 + var_730_2 and arg_727_1.time_ < var_730_1 + var_730_2 + arg_730_0 and not isNil(var_730_0) and arg_727_1.var_.characterEffect1150ui_story then
				arg_727_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_730_4 = 0

			if var_730_4 < arg_727_1.time_ and arg_727_1.time_ <= var_730_4 + arg_730_0 then
				arg_727_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_1")
			end

			local var_730_5 = 0

			if var_730_5 < arg_727_1.time_ and arg_727_1.time_ <= var_730_5 + arg_730_0 then
				arg_727_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_730_6 = arg_727_1.actors_["1150ui_story"].transform
			local var_730_7 = 0

			if var_730_7 < arg_727_1.time_ and arg_727_1.time_ <= var_730_7 + arg_730_0 then
				arg_727_1.var_.moveOldPos1150ui_story = var_730_6.localPosition
			end

			local var_730_8 = 0.001

			if var_730_7 <= arg_727_1.time_ and arg_727_1.time_ < var_730_7 + var_730_8 then
				local var_730_9 = (arg_727_1.time_ - var_730_7) / var_730_8
				local var_730_10 = Vector3.New(0, -1.01, -6.2)

				var_730_6.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos1150ui_story, var_730_10, var_730_9)

				local var_730_11 = manager.ui.mainCamera.transform.position - var_730_6.position

				var_730_6.forward = Vector3.New(var_730_11.x, var_730_11.y, var_730_11.z)

				local var_730_12 = var_730_6.localEulerAngles

				var_730_12.z = 0
				var_730_12.x = 0
				var_730_6.localEulerAngles = var_730_12
			end

			if arg_727_1.time_ >= var_730_7 + var_730_8 and arg_727_1.time_ < var_730_7 + var_730_8 + arg_730_0 then
				var_730_6.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_730_13 = manager.ui.mainCamera.transform.position - var_730_6.position

				var_730_6.forward = Vector3.New(var_730_13.x, var_730_13.y, var_730_13.z)

				local var_730_14 = var_730_6.localEulerAngles

				var_730_14.z = 0
				var_730_14.x = 0
				var_730_6.localEulerAngles = var_730_14
			end

			local var_730_15 = 0
			local var_730_16 = 0.4

			if var_730_15 < arg_727_1.time_ and arg_727_1.time_ <= var_730_15 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, true)

				local var_730_17 = arg_727_1:FormatText(StoryNameCfg[74].name)

				arg_727_1.leftNameTxt_.text = var_730_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_727_1.leftNameTxt_.transform)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1.leftNameTxt_.text)
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_18 = arg_727_1:GetWordFromCfg(1105006173)
				local var_730_19 = arg_727_1:FormatText(var_730_18.content)

				arg_727_1.text_.text = var_730_19

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_20 = 16
				local var_730_21 = utf8.len(var_730_19)
				local var_730_22 = var_730_20 <= 0 and var_730_16 or var_730_16 * (var_730_21 / var_730_20)

				if var_730_22 > 0 and var_730_16 < var_730_22 then
					arg_727_1.talkMaxDuration = var_730_22

					if var_730_22 + var_730_15 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_22 + var_730_15
					end
				end

				arg_727_1.text_.text = var_730_19
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006173", "story_v_side_new_1105006.awb") ~= 0 then
					local var_730_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006173", "story_v_side_new_1105006.awb") / 1000

					if var_730_23 + var_730_15 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_23 + var_730_15
					end

					if var_730_18.prefab_name ~= "" and arg_727_1.actors_[var_730_18.prefab_name] ~= nil then
						local var_730_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_727_1.actors_[var_730_18.prefab_name].transform, "story_v_side_new_1105006", "1105006173", "story_v_side_new_1105006.awb")

						arg_727_1:RecordAudio("1105006173", var_730_24)
						arg_727_1:RecordAudio("1105006173", var_730_24)
					else
						arg_727_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006173", "story_v_side_new_1105006.awb")
					end

					arg_727_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006173", "story_v_side_new_1105006.awb")
				end

				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_25 = math.max(var_730_16, arg_727_1.talkMaxDuration)

			if var_730_15 <= arg_727_1.time_ and arg_727_1.time_ < var_730_15 + var_730_25 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_15) / var_730_25

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_15 + var_730_25 and arg_727_1.time_ < var_730_15 + var_730_25 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_727_1:InitPlayNodeList()
	end,
	Play1105006174 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 1105006174
		arg_731_1.duration_ = 5.63

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play1105006175(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = 3.03333333333334

			if var_734_0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_0 + arg_734_0 then
				arg_731_1.allBtn_.enabled = false
			end

			local var_734_1 = 0.0999999999999996

			if arg_731_1.time_ >= var_734_0 + var_734_1 and arg_731_1.time_ < var_734_0 + var_734_1 + arg_734_0 then
				arg_731_1.allBtn_.enabled = true
			end

			local var_734_2 = 1.03333333333333

			if var_734_2 < arg_731_1.time_ and arg_731_1.time_ <= var_734_2 + arg_734_0 then
				local var_734_3 = manager.ui.mainCamera.transform.localPosition
				local var_734_4 = Vector3.New(0, 0, 10) + Vector3.New(var_734_3.x, var_734_3.y, 0)
				local var_734_5 = arg_731_1.bgs_.ST11

				var_734_5.transform.localPosition = var_734_4
				var_734_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_734_6 = var_734_5:GetComponent("SpriteRenderer")

				if var_734_6 and var_734_6.sprite then
					local var_734_7 = (var_734_5.transform.localPosition - var_734_3).z
					local var_734_8 = manager.ui.mainCameraCom_
					local var_734_9 = 2 * var_734_7 * Mathf.Tan(var_734_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_734_10 = var_734_9 * var_734_8.aspect
					local var_734_11 = var_734_6.sprite.bounds.size.x
					local var_734_12 = var_734_6.sprite.bounds.size.y
					local var_734_13 = var_734_10 / var_734_11
					local var_734_14 = var_734_9 / var_734_12
					local var_734_15 = var_734_14 < var_734_13 and var_734_13 or var_734_14

					var_734_5.transform.localScale = Vector3.New(var_734_15, var_734_15, 0)
				end

				for iter_734_0, iter_734_1 in pairs(arg_731_1.bgs_) do
					if iter_734_0 ~= "ST11" then
						iter_734_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_734_16 = 0

			if var_734_16 < arg_731_1.time_ and arg_731_1.time_ <= var_734_16 + arg_734_0 then
				arg_731_1.mask_.enabled = true
				arg_731_1.mask_.raycastTarget = true

				arg_731_1:SetGaussion(false)
			end

			local var_734_17 = 1.03333333333333

			if var_734_16 <= arg_731_1.time_ and arg_731_1.time_ < var_734_16 + var_734_17 then
				local var_734_18 = (arg_731_1.time_ - var_734_16) / var_734_17
				local var_734_19 = Color.New(0, 0, 0)

				var_734_19.a = Mathf.Lerp(0, 1, var_734_18)
				arg_731_1.mask_.color = var_734_19
			end

			if arg_731_1.time_ >= var_734_16 + var_734_17 and arg_731_1.time_ < var_734_16 + var_734_17 + arg_734_0 then
				local var_734_20 = Color.New(0, 0, 0)

				var_734_20.a = 1
				arg_731_1.mask_.color = var_734_20
			end

			local var_734_21 = 1.03333333333333

			if var_734_21 < arg_731_1.time_ and arg_731_1.time_ <= var_734_21 + arg_734_0 then
				arg_731_1.mask_.enabled = true
				arg_731_1.mask_.raycastTarget = true

				arg_731_1:SetGaussion(false)
			end

			local var_734_22 = 2

			if var_734_21 <= arg_731_1.time_ and arg_731_1.time_ < var_734_21 + var_734_22 then
				local var_734_23 = (arg_731_1.time_ - var_734_21) / var_734_22
				local var_734_24 = Color.New(0, 0, 0)

				var_734_24.a = Mathf.Lerp(1, 0, var_734_23)
				arg_731_1.mask_.color = var_734_24
			end

			if arg_731_1.time_ >= var_734_21 + var_734_22 and arg_731_1.time_ < var_734_21 + var_734_22 + arg_734_0 then
				local var_734_25 = Color.New(0, 0, 0)
				local var_734_26 = 0

				arg_731_1.mask_.enabled = false
				var_734_25.a = var_734_26
				arg_731_1.mask_.color = var_734_25
			end

			local var_734_27 = arg_731_1.actors_["1150ui_story"].transform
			local var_734_28 = 1.00360023312581

			if var_734_28 < arg_731_1.time_ and arg_731_1.time_ <= var_734_28 + arg_734_0 then
				arg_731_1.var_.moveOldPos1150ui_story = var_734_27.localPosition
			end

			local var_734_29 = 0.001

			if var_734_28 <= arg_731_1.time_ and arg_731_1.time_ < var_734_28 + var_734_29 then
				local var_734_30 = (arg_731_1.time_ - var_734_28) / var_734_29
				local var_734_31 = Vector3.New(0, 100, 0)

				var_734_27.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos1150ui_story, var_734_31, var_734_30)

				local var_734_32 = manager.ui.mainCamera.transform.position - var_734_27.position

				var_734_27.forward = Vector3.New(var_734_32.x, var_734_32.y, var_734_32.z)

				local var_734_33 = var_734_27.localEulerAngles

				var_734_33.z = 0
				var_734_33.x = 0
				var_734_27.localEulerAngles = var_734_33
			end

			if arg_731_1.time_ >= var_734_28 + var_734_29 and arg_731_1.time_ < var_734_28 + var_734_29 + arg_734_0 then
				var_734_27.localPosition = Vector3.New(0, 100, 0)

				local var_734_34 = manager.ui.mainCamera.transform.position - var_734_27.position

				var_734_27.forward = Vector3.New(var_734_34.x, var_734_34.y, var_734_34.z)

				local var_734_35 = var_734_27.localEulerAngles

				var_734_35.z = 0
				var_734_35.x = 0
				var_734_27.localEulerAngles = var_734_35
			end

			local var_734_36 = arg_731_1.actors_["1150ui_story"].transform
			local var_734_37 = 3

			if var_734_37 < arg_731_1.time_ and arg_731_1.time_ <= var_734_37 + arg_734_0 then
				arg_731_1.var_.moveOldPos1150ui_story = var_734_36.localPosition
			end

			local var_734_38 = 0.001

			if var_734_37 <= arg_731_1.time_ and arg_731_1.time_ < var_734_37 + var_734_38 then
				local var_734_39 = (arg_731_1.time_ - var_734_37) / var_734_38
				local var_734_40 = Vector3.New(0, -1.01, -6.2)

				var_734_36.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos1150ui_story, var_734_40, var_734_39)

				local var_734_41 = manager.ui.mainCamera.transform.position - var_734_36.position

				var_734_36.forward = Vector3.New(var_734_41.x, var_734_41.y, var_734_41.z)

				local var_734_42 = var_734_36.localEulerAngles

				var_734_42.z = 0
				var_734_42.x = 0
				var_734_36.localEulerAngles = var_734_42
			end

			if arg_731_1.time_ >= var_734_37 + var_734_38 and arg_731_1.time_ < var_734_37 + var_734_38 + arg_734_0 then
				var_734_36.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_734_43 = manager.ui.mainCamera.transform.position - var_734_36.position

				var_734_36.forward = Vector3.New(var_734_43.x, var_734_43.y, var_734_43.z)

				local var_734_44 = var_734_36.localEulerAngles

				var_734_44.z = 0
				var_734_44.x = 0
				var_734_36.localEulerAngles = var_734_44
			end

			local var_734_45 = arg_731_1.actors_["1150ui_story"]
			local var_734_46 = 3

			if var_734_46 < arg_731_1.time_ and arg_731_1.time_ <= var_734_46 + arg_734_0 and not isNil(var_734_45) and arg_731_1.var_.characterEffect1150ui_story == nil then
				arg_731_1.var_.characterEffect1150ui_story = var_734_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_47 = 0.200000002980232

			if var_734_46 <= arg_731_1.time_ and arg_731_1.time_ < var_734_46 + var_734_47 and not isNil(var_734_45) then
				local var_734_48 = (arg_731_1.time_ - var_734_46) / var_734_47

				if arg_731_1.var_.characterEffect1150ui_story and not isNil(var_734_45) then
					arg_731_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_731_1.time_ >= var_734_46 + var_734_47 and arg_731_1.time_ < var_734_46 + var_734_47 + arg_734_0 and not isNil(var_734_45) and arg_731_1.var_.characterEffect1150ui_story then
				arg_731_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_734_49 = 3

			if var_734_49 < arg_731_1.time_ and arg_731_1.time_ <= var_734_49 + arg_734_0 then
				arg_731_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			local var_734_50 = 3

			if var_734_50 < arg_731_1.time_ and arg_731_1.time_ <= var_734_50 + arg_734_0 then
				arg_731_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_731_1.frameCnt_ <= 1 then
				arg_731_1.dialog_:SetActive(false)
			end

			local var_734_51 = 3.03333333333334
			local var_734_52 = 0.225

			if var_734_51 < arg_731_1.time_ and arg_731_1.time_ <= var_734_51 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0

				arg_731_1.dialog_:SetActive(true)

				arg_731_1.dialogCg_.alpha = 0

				local var_734_53 = LeanTween.value(arg_731_1.dialog_, 0, 1, 0.3)

				var_734_53:setOnUpdate(LuaHelper.FloatAction(function(arg_735_0)
					arg_731_1.dialogCg_.alpha = arg_735_0
				end))
				var_734_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_731_1.dialog_)
					var_734_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_731_1.duration_ = arg_731_1.duration_ + 0.3

				SetActive(arg_731_1.leftNameGo_, true)

				local var_734_54 = arg_731_1:FormatText(StoryNameCfg[74].name)

				arg_731_1.leftNameTxt_.text = var_734_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_55 = arg_731_1:GetWordFromCfg(1105006174)
				local var_734_56 = arg_731_1:FormatText(var_734_55.content)

				arg_731_1.text_.text = var_734_56

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_57 = 9
				local var_734_58 = utf8.len(var_734_56)
				local var_734_59 = var_734_57 <= 0 and var_734_52 or var_734_52 * (var_734_58 / var_734_57)

				if var_734_59 > 0 and var_734_52 < var_734_59 then
					arg_731_1.talkMaxDuration = var_734_59
					var_734_51 = var_734_51 + 0.3

					if var_734_59 + var_734_51 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_59 + var_734_51
					end
				end

				arg_731_1.text_.text = var_734_56
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006174", "story_v_side_new_1105006.awb") ~= 0 then
					local var_734_60 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006174", "story_v_side_new_1105006.awb") / 1000

					if var_734_60 + var_734_51 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_60 + var_734_51
					end

					if var_734_55.prefab_name ~= "" and arg_731_1.actors_[var_734_55.prefab_name] ~= nil then
						local var_734_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_731_1.actors_[var_734_55.prefab_name].transform, "story_v_side_new_1105006", "1105006174", "story_v_side_new_1105006.awb")

						arg_731_1:RecordAudio("1105006174", var_734_61)
						arg_731_1:RecordAudio("1105006174", var_734_61)
					else
						arg_731_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006174", "story_v_side_new_1105006.awb")
					end

					arg_731_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006174", "story_v_side_new_1105006.awb")
				end

				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_62 = var_734_51 + 0.3
			local var_734_63 = math.max(var_734_52, arg_731_1.talkMaxDuration)

			if var_734_62 <= arg_731_1.time_ and arg_731_1.time_ < var_734_62 + var_734_63 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_62) / var_734_63

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_62 + var_734_63 and arg_731_1.time_ < var_734_62 + var_734_63 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0297331002075225,
				className = "StoryMoveNode",
				startTime = 1.00360023312581,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_731_1:InitPlayNodeList()
	end,
	Play1105006175 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 1105006175
		arg_737_1.duration_ = 5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play1105006176(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			local var_740_0 = arg_737_1.actors_["1150ui_story"]
			local var_740_1 = 0

			if var_740_1 < arg_737_1.time_ and arg_737_1.time_ <= var_740_1 + arg_740_0 and not isNil(var_740_0) and arg_737_1.var_.characterEffect1150ui_story == nil then
				arg_737_1.var_.characterEffect1150ui_story = var_740_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_740_2 = 0.200000002980232

			if var_740_1 <= arg_737_1.time_ and arg_737_1.time_ < var_740_1 + var_740_2 and not isNil(var_740_0) then
				local var_740_3 = (arg_737_1.time_ - var_740_1) / var_740_2

				if arg_737_1.var_.characterEffect1150ui_story and not isNil(var_740_0) then
					local var_740_4 = Mathf.Lerp(0, 0.5, var_740_3)

					arg_737_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_737_1.var_.characterEffect1150ui_story.fillRatio = var_740_4
				end
			end

			if arg_737_1.time_ >= var_740_1 + var_740_2 and arg_737_1.time_ < var_740_1 + var_740_2 + arg_740_0 and not isNil(var_740_0) and arg_737_1.var_.characterEffect1150ui_story then
				local var_740_5 = 0.5

				arg_737_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_737_1.var_.characterEffect1150ui_story.fillRatio = var_740_5
			end

			local var_740_6 = 0
			local var_740_7 = 1.1

			if var_740_6 < arg_737_1.time_ and arg_737_1.time_ <= var_740_6 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				local var_740_8 = arg_737_1:FormatText(StoryNameCfg[7].name)

				arg_737_1.leftNameTxt_.text = var_740_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, true)
				arg_737_1.iconController_:SetSelectedState("hero")

				arg_737_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_737_1.callingController_:SetSelectedState("normal")

				arg_737_1.keyicon_.color = Color.New(1, 1, 1)
				arg_737_1.icon_.color = Color.New(1, 1, 1)

				local var_740_9 = arg_737_1:GetWordFromCfg(1105006175)
				local var_740_10 = arg_737_1:FormatText(var_740_9.content)

				arg_737_1.text_.text = var_740_10

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_11 = 44
				local var_740_12 = utf8.len(var_740_10)
				local var_740_13 = var_740_11 <= 0 and var_740_7 or var_740_7 * (var_740_12 / var_740_11)

				if var_740_13 > 0 and var_740_7 < var_740_13 then
					arg_737_1.talkMaxDuration = var_740_13

					if var_740_13 + var_740_6 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_13 + var_740_6
					end
				end

				arg_737_1.text_.text = var_740_10
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)
				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_14 = math.max(var_740_7, arg_737_1.talkMaxDuration)

			if var_740_6 <= arg_737_1.time_ and arg_737_1.time_ < var_740_6 + var_740_14 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_6) / var_740_14

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_6 + var_740_14 and arg_737_1.time_ < var_740_6 + var_740_14 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play1105006176 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 1105006176
		arg_741_1.duration_ = 2.87

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play1105006177(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			local var_744_0 = arg_741_1.actors_["1150ui_story"]
			local var_744_1 = 0

			if var_744_1 < arg_741_1.time_ and arg_741_1.time_ <= var_744_1 + arg_744_0 and not isNil(var_744_0) and arg_741_1.var_.characterEffect1150ui_story == nil then
				arg_741_1.var_.characterEffect1150ui_story = var_744_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_744_2 = 0.200000002980232

			if var_744_1 <= arg_741_1.time_ and arg_741_1.time_ < var_744_1 + var_744_2 and not isNil(var_744_0) then
				local var_744_3 = (arg_741_1.time_ - var_744_1) / var_744_2

				if arg_741_1.var_.characterEffect1150ui_story and not isNil(var_744_0) then
					arg_741_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_741_1.time_ >= var_744_1 + var_744_2 and arg_741_1.time_ < var_744_1 + var_744_2 + arg_744_0 and not isNil(var_744_0) and arg_741_1.var_.characterEffect1150ui_story then
				arg_741_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_744_4 = 0
			local var_744_5 = 0.375

			if var_744_4 < arg_741_1.time_ and arg_741_1.time_ <= var_744_4 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				local var_744_6 = arg_741_1:FormatText(StoryNameCfg[74].name)

				arg_741_1.leftNameTxt_.text = var_744_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_7 = arg_741_1:GetWordFromCfg(1105006176)
				local var_744_8 = arg_741_1:FormatText(var_744_7.content)

				arg_741_1.text_.text = var_744_8

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_9 = 15
				local var_744_10 = utf8.len(var_744_8)
				local var_744_11 = var_744_9 <= 0 and var_744_5 or var_744_5 * (var_744_10 / var_744_9)

				if var_744_11 > 0 and var_744_5 < var_744_11 then
					arg_741_1.talkMaxDuration = var_744_11

					if var_744_11 + var_744_4 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_11 + var_744_4
					end
				end

				arg_741_1.text_.text = var_744_8
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006176", "story_v_side_new_1105006.awb") ~= 0 then
					local var_744_12 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006176", "story_v_side_new_1105006.awb") / 1000

					if var_744_12 + var_744_4 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_12 + var_744_4
					end

					if var_744_7.prefab_name ~= "" and arg_741_1.actors_[var_744_7.prefab_name] ~= nil then
						local var_744_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_741_1.actors_[var_744_7.prefab_name].transform, "story_v_side_new_1105006", "1105006176", "story_v_side_new_1105006.awb")

						arg_741_1:RecordAudio("1105006176", var_744_13)
						arg_741_1:RecordAudio("1105006176", var_744_13)
					else
						arg_741_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006176", "story_v_side_new_1105006.awb")
					end

					arg_741_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006176", "story_v_side_new_1105006.awb")
				end

				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_14 = math.max(var_744_5, arg_741_1.talkMaxDuration)

			if var_744_4 <= arg_741_1.time_ and arg_741_1.time_ < var_744_4 + var_744_14 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_4) / var_744_14

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_4 + var_744_14 and arg_741_1.time_ < var_744_4 + var_744_14 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play1105006177 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 1105006177
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play1105006178(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = arg_745_1.actors_["1150ui_story"].transform
			local var_748_1 = 0

			if var_748_1 < arg_745_1.time_ and arg_745_1.time_ <= var_748_1 + arg_748_0 then
				arg_745_1.var_.moveOldPos1150ui_story = var_748_0.localPosition
			end

			local var_748_2 = 0.001

			if var_748_1 <= arg_745_1.time_ and arg_745_1.time_ < var_748_1 + var_748_2 then
				local var_748_3 = (arg_745_1.time_ - var_748_1) / var_748_2
				local var_748_4 = Vector3.New(0, 100, 0)

				var_748_0.localPosition = Vector3.Lerp(arg_745_1.var_.moveOldPos1150ui_story, var_748_4, var_748_3)

				local var_748_5 = manager.ui.mainCamera.transform.position - var_748_0.position

				var_748_0.forward = Vector3.New(var_748_5.x, var_748_5.y, var_748_5.z)

				local var_748_6 = var_748_0.localEulerAngles

				var_748_6.z = 0
				var_748_6.x = 0
				var_748_0.localEulerAngles = var_748_6
			end

			if arg_745_1.time_ >= var_748_1 + var_748_2 and arg_745_1.time_ < var_748_1 + var_748_2 + arg_748_0 then
				var_748_0.localPosition = Vector3.New(0, 100, 0)

				local var_748_7 = manager.ui.mainCamera.transform.position - var_748_0.position

				var_748_0.forward = Vector3.New(var_748_7.x, var_748_7.y, var_748_7.z)

				local var_748_8 = var_748_0.localEulerAngles

				var_748_8.z = 0
				var_748_8.x = 0
				var_748_0.localEulerAngles = var_748_8
			end

			local var_748_9 = 0
			local var_748_10 = 1.4

			if var_748_9 < arg_745_1.time_ and arg_745_1.time_ <= var_748_9 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, false)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_11 = arg_745_1:GetWordFromCfg(1105006177)
				local var_748_12 = arg_745_1:FormatText(var_748_11.content)

				arg_745_1.text_.text = var_748_12

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_13 = 56
				local var_748_14 = utf8.len(var_748_12)
				local var_748_15 = var_748_13 <= 0 and var_748_10 or var_748_10 * (var_748_14 / var_748_13)

				if var_748_15 > 0 and var_748_10 < var_748_15 then
					arg_745_1.talkMaxDuration = var_748_15

					if var_748_15 + var_748_9 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_15 + var_748_9
					end
				end

				arg_745_1.text_.text = var_748_12
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_16 = math.max(var_748_10, arg_745_1.talkMaxDuration)

			if var_748_9 <= arg_745_1.time_ and arg_745_1.time_ < var_748_9 + var_748_16 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_9) / var_748_16

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_9 + var_748_16 and arg_745_1.time_ < var_748_9 + var_748_16 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_745_1:InitPlayNodeList()
	end,
	Play1105006178 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 1105006178
		arg_749_1.duration_ = 2.13

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play1105006179(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			local var_752_0 = arg_749_1.actors_["1150ui_story"]
			local var_752_1 = 0

			if var_752_1 < arg_749_1.time_ and arg_749_1.time_ <= var_752_1 + arg_752_0 and not isNil(var_752_0) and arg_749_1.var_.characterEffect1150ui_story == nil then
				arg_749_1.var_.characterEffect1150ui_story = var_752_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_752_2 = 0.200000002980232

			if var_752_1 <= arg_749_1.time_ and arg_749_1.time_ < var_752_1 + var_752_2 and not isNil(var_752_0) then
				local var_752_3 = (arg_749_1.time_ - var_752_1) / var_752_2

				if arg_749_1.var_.characterEffect1150ui_story and not isNil(var_752_0) then
					arg_749_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_749_1.time_ >= var_752_1 + var_752_2 and arg_749_1.time_ < var_752_1 + var_752_2 + arg_752_0 and not isNil(var_752_0) and arg_749_1.var_.characterEffect1150ui_story then
				arg_749_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_752_4 = 0

			if var_752_4 < arg_749_1.time_ and arg_749_1.time_ <= var_752_4 + arg_752_0 then
				arg_749_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_752_5 = arg_749_1.actors_["1150ui_story"].transform
			local var_752_6 = 0

			if var_752_6 < arg_749_1.time_ and arg_749_1.time_ <= var_752_6 + arg_752_0 then
				arg_749_1.var_.moveOldPos1150ui_story = var_752_5.localPosition
			end

			local var_752_7 = 0.001

			if var_752_6 <= arg_749_1.time_ and arg_749_1.time_ < var_752_6 + var_752_7 then
				local var_752_8 = (arg_749_1.time_ - var_752_6) / var_752_7
				local var_752_9 = Vector3.New(0, -1.01, -6.2)

				var_752_5.localPosition = Vector3.Lerp(arg_749_1.var_.moveOldPos1150ui_story, var_752_9, var_752_8)

				local var_752_10 = manager.ui.mainCamera.transform.position - var_752_5.position

				var_752_5.forward = Vector3.New(var_752_10.x, var_752_10.y, var_752_10.z)

				local var_752_11 = var_752_5.localEulerAngles

				var_752_11.z = 0
				var_752_11.x = 0
				var_752_5.localEulerAngles = var_752_11
			end

			if arg_749_1.time_ >= var_752_6 + var_752_7 and arg_749_1.time_ < var_752_6 + var_752_7 + arg_752_0 then
				var_752_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_752_12 = manager.ui.mainCamera.transform.position - var_752_5.position

				var_752_5.forward = Vector3.New(var_752_12.x, var_752_12.y, var_752_12.z)

				local var_752_13 = var_752_5.localEulerAngles

				var_752_13.z = 0
				var_752_13.x = 0
				var_752_5.localEulerAngles = var_752_13
			end

			local var_752_14 = 0

			if var_752_14 < arg_749_1.time_ and arg_749_1.time_ <= var_752_14 + arg_752_0 then
				arg_749_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_2")
			end

			local var_752_15 = 0
			local var_752_16 = 0.3

			if var_752_15 < arg_749_1.time_ and arg_749_1.time_ <= var_752_15 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, true)

				local var_752_17 = arg_749_1:FormatText(StoryNameCfg[74].name)

				arg_749_1.leftNameTxt_.text = var_752_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_749_1.leftNameTxt_.transform)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1.leftNameTxt_.text)
				SetActive(arg_749_1.iconTrs_.gameObject, false)
				arg_749_1.callingController_:SetSelectedState("normal")

				local var_752_18 = arg_749_1:GetWordFromCfg(1105006178)
				local var_752_19 = arg_749_1:FormatText(var_752_18.content)

				arg_749_1.text_.text = var_752_19

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_20 = 12
				local var_752_21 = utf8.len(var_752_19)
				local var_752_22 = var_752_20 <= 0 and var_752_16 or var_752_16 * (var_752_21 / var_752_20)

				if var_752_22 > 0 and var_752_16 < var_752_22 then
					arg_749_1.talkMaxDuration = var_752_22

					if var_752_22 + var_752_15 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_22 + var_752_15
					end
				end

				arg_749_1.text_.text = var_752_19
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006178", "story_v_side_new_1105006.awb") ~= 0 then
					local var_752_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006178", "story_v_side_new_1105006.awb") / 1000

					if var_752_23 + var_752_15 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_23 + var_752_15
					end

					if var_752_18.prefab_name ~= "" and arg_749_1.actors_[var_752_18.prefab_name] ~= nil then
						local var_752_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_749_1.actors_[var_752_18.prefab_name].transform, "story_v_side_new_1105006", "1105006178", "story_v_side_new_1105006.awb")

						arg_749_1:RecordAudio("1105006178", var_752_24)
						arg_749_1:RecordAudio("1105006178", var_752_24)
					else
						arg_749_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006178", "story_v_side_new_1105006.awb")
					end

					arg_749_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006178", "story_v_side_new_1105006.awb")
				end

				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_25 = math.max(var_752_16, arg_749_1.talkMaxDuration)

			if var_752_15 <= arg_749_1.time_ and arg_749_1.time_ < var_752_15 + var_752_25 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - var_752_15) / var_752_25

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= var_752_15 + var_752_25 and arg_749_1.time_ < var_752_15 + var_752_25 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_749_1:InitPlayNodeList()
	end,
	Play1105006179 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 1105006179
		arg_753_1.duration_ = 5

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play1105006180(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			local var_756_0 = arg_753_1.actors_["1150ui_story"]
			local var_756_1 = 0

			if var_756_1 < arg_753_1.time_ and arg_753_1.time_ <= var_756_1 + arg_756_0 and not isNil(var_756_0) and arg_753_1.var_.characterEffect1150ui_story == nil then
				arg_753_1.var_.characterEffect1150ui_story = var_756_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_756_2 = 0.200000002980232

			if var_756_1 <= arg_753_1.time_ and arg_753_1.time_ < var_756_1 + var_756_2 and not isNil(var_756_0) then
				local var_756_3 = (arg_753_1.time_ - var_756_1) / var_756_2

				if arg_753_1.var_.characterEffect1150ui_story and not isNil(var_756_0) then
					local var_756_4 = Mathf.Lerp(0, 0.5, var_756_3)

					arg_753_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_753_1.var_.characterEffect1150ui_story.fillRatio = var_756_4
				end
			end

			if arg_753_1.time_ >= var_756_1 + var_756_2 and arg_753_1.time_ < var_756_1 + var_756_2 + arg_756_0 and not isNil(var_756_0) and arg_753_1.var_.characterEffect1150ui_story then
				local var_756_5 = 0.5

				arg_753_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_753_1.var_.characterEffect1150ui_story.fillRatio = var_756_5
			end

			local var_756_6 = 0
			local var_756_7 = 0.9

			if var_756_6 < arg_753_1.time_ and arg_753_1.time_ <= var_756_6 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, true)

				local var_756_8 = arg_753_1:FormatText(StoryNameCfg[7].name)

				arg_753_1.leftNameTxt_.text = var_756_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_753_1.leftNameTxt_.transform)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1.leftNameTxt_.text)
				SetActive(arg_753_1.iconTrs_.gameObject, true)
				arg_753_1.iconController_:SetSelectedState("hero")

				arg_753_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_753_1.callingController_:SetSelectedState("normal")

				arg_753_1.keyicon_.color = Color.New(1, 1, 1)
				arg_753_1.icon_.color = Color.New(1, 1, 1)

				local var_756_9 = arg_753_1:GetWordFromCfg(1105006179)
				local var_756_10 = arg_753_1:FormatText(var_756_9.content)

				arg_753_1.text_.text = var_756_10

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_11 = 36
				local var_756_12 = utf8.len(var_756_10)
				local var_756_13 = var_756_11 <= 0 and var_756_7 or var_756_7 * (var_756_12 / var_756_11)

				if var_756_13 > 0 and var_756_7 < var_756_13 then
					arg_753_1.talkMaxDuration = var_756_13

					if var_756_13 + var_756_6 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_13 + var_756_6
					end
				end

				arg_753_1.text_.text = var_756_10
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)
				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_14 = math.max(var_756_7, arg_753_1.talkMaxDuration)

			if var_756_6 <= arg_753_1.time_ and arg_753_1.time_ < var_756_6 + var_756_14 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - var_756_6) / var_756_14

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= var_756_6 + var_756_14 and arg_753_1.time_ < var_756_6 + var_756_14 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play1105006180 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 1105006180
		arg_757_1.duration_ = 3.27

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play1105006181(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			local var_760_0 = arg_757_1.actors_["1150ui_story"]
			local var_760_1 = 0

			if var_760_1 < arg_757_1.time_ and arg_757_1.time_ <= var_760_1 + arg_760_0 and not isNil(var_760_0) and arg_757_1.var_.characterEffect1150ui_story == nil then
				arg_757_1.var_.characterEffect1150ui_story = var_760_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_760_2 = 0.200000002980232

			if var_760_1 <= arg_757_1.time_ and arg_757_1.time_ < var_760_1 + var_760_2 and not isNil(var_760_0) then
				local var_760_3 = (arg_757_1.time_ - var_760_1) / var_760_2

				if arg_757_1.var_.characterEffect1150ui_story and not isNil(var_760_0) then
					arg_757_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_757_1.time_ >= var_760_1 + var_760_2 and arg_757_1.time_ < var_760_1 + var_760_2 + arg_760_0 and not isNil(var_760_0) and arg_757_1.var_.characterEffect1150ui_story then
				arg_757_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_760_4 = 0

			if var_760_4 < arg_757_1.time_ and arg_757_1.time_ <= var_760_4 + arg_760_0 then
				arg_757_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_760_5 = 0
			local var_760_6 = 0.375

			if var_760_5 < arg_757_1.time_ and arg_757_1.time_ <= var_760_5 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0
				arg_757_1.dialogCg_.alpha = 1

				arg_757_1.dialog_:SetActive(true)
				SetActive(arg_757_1.leftNameGo_, true)

				local var_760_7 = arg_757_1:FormatText(StoryNameCfg[74].name)

				arg_757_1.leftNameTxt_.text = var_760_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_757_1.leftNameTxt_.transform)

				arg_757_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_757_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_757_1:RecordName(arg_757_1.leftNameTxt_.text)
				SetActive(arg_757_1.iconTrs_.gameObject, false)
				arg_757_1.callingController_:SetSelectedState("normal")

				local var_760_8 = arg_757_1:GetWordFromCfg(1105006180)
				local var_760_9 = arg_757_1:FormatText(var_760_8.content)

				arg_757_1.text_.text = var_760_9

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_10 = 15
				local var_760_11 = utf8.len(var_760_9)
				local var_760_12 = var_760_10 <= 0 and var_760_6 or var_760_6 * (var_760_11 / var_760_10)

				if var_760_12 > 0 and var_760_6 < var_760_12 then
					arg_757_1.talkMaxDuration = var_760_12

					if var_760_12 + var_760_5 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_12 + var_760_5
					end
				end

				arg_757_1.text_.text = var_760_9
				arg_757_1.typewritter.percent = 0

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006180", "story_v_side_new_1105006.awb") ~= 0 then
					local var_760_13 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006180", "story_v_side_new_1105006.awb") / 1000

					if var_760_13 + var_760_5 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_13 + var_760_5
					end

					if var_760_8.prefab_name ~= "" and arg_757_1.actors_[var_760_8.prefab_name] ~= nil then
						local var_760_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_757_1.actors_[var_760_8.prefab_name].transform, "story_v_side_new_1105006", "1105006180", "story_v_side_new_1105006.awb")

						arg_757_1:RecordAudio("1105006180", var_760_14)
						arg_757_1:RecordAudio("1105006180", var_760_14)
					else
						arg_757_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006180", "story_v_side_new_1105006.awb")
					end

					arg_757_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006180", "story_v_side_new_1105006.awb")
				end

				arg_757_1:RecordContent(arg_757_1.text_.text)
			end

			local var_760_15 = math.max(var_760_6, arg_757_1.talkMaxDuration)

			if var_760_5 <= arg_757_1.time_ and arg_757_1.time_ < var_760_5 + var_760_15 then
				arg_757_1.typewritter.percent = (arg_757_1.time_ - var_760_5) / var_760_15

				arg_757_1.typewritter:SetDirty()
			end

			if arg_757_1.time_ >= var_760_5 + var_760_15 and arg_757_1.time_ < var_760_5 + var_760_15 + arg_760_0 then
				arg_757_1.typewritter.percent = 1

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(true)
			end
		end

		arg_757_1.nodeConfigList_ = {}

		arg_757_1:InitPlayNodeList()
	end,
	Play1105006181 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 1105006181
		arg_761_1.duration_ = 5

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play1105006182(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			local var_764_0 = arg_761_1.actors_["1150ui_story"]
			local var_764_1 = 0

			if var_764_1 < arg_761_1.time_ and arg_761_1.time_ <= var_764_1 + arg_764_0 and not isNil(var_764_0) and arg_761_1.var_.characterEffect1150ui_story == nil then
				arg_761_1.var_.characterEffect1150ui_story = var_764_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_764_2 = 0.200000002980232

			if var_764_1 <= arg_761_1.time_ and arg_761_1.time_ < var_764_1 + var_764_2 and not isNil(var_764_0) then
				local var_764_3 = (arg_761_1.time_ - var_764_1) / var_764_2

				if arg_761_1.var_.characterEffect1150ui_story and not isNil(var_764_0) then
					local var_764_4 = Mathf.Lerp(0, 0.5, var_764_3)

					arg_761_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_761_1.var_.characterEffect1150ui_story.fillRatio = var_764_4
				end
			end

			if arg_761_1.time_ >= var_764_1 + var_764_2 and arg_761_1.time_ < var_764_1 + var_764_2 + arg_764_0 and not isNil(var_764_0) and arg_761_1.var_.characterEffect1150ui_story then
				local var_764_5 = 0.5

				arg_761_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_761_1.var_.characterEffect1150ui_story.fillRatio = var_764_5
			end

			local var_764_6 = 0
			local var_764_7 = 0.25

			if var_764_6 < arg_761_1.time_ and arg_761_1.time_ <= var_764_6 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, true)

				local var_764_8 = arg_761_1:FormatText(StoryNameCfg[7].name)

				arg_761_1.leftNameTxt_.text = var_764_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_761_1.leftNameTxt_.transform)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1.leftNameTxt_.text)
				SetActive(arg_761_1.iconTrs_.gameObject, true)
				arg_761_1.iconController_:SetSelectedState("hero")

				arg_761_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_761_1.callingController_:SetSelectedState("normal")

				arg_761_1.keyicon_.color = Color.New(1, 1, 1)
				arg_761_1.icon_.color = Color.New(1, 1, 1)

				local var_764_9 = arg_761_1:GetWordFromCfg(1105006181)
				local var_764_10 = arg_761_1:FormatText(var_764_9.content)

				arg_761_1.text_.text = var_764_10

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_11 = 10
				local var_764_12 = utf8.len(var_764_10)
				local var_764_13 = var_764_11 <= 0 and var_764_7 or var_764_7 * (var_764_12 / var_764_11)

				if var_764_13 > 0 and var_764_7 < var_764_13 then
					arg_761_1.talkMaxDuration = var_764_13

					if var_764_13 + var_764_6 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_13 + var_764_6
					end
				end

				arg_761_1.text_.text = var_764_10
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)
				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_14 = math.max(var_764_7, arg_761_1.talkMaxDuration)

			if var_764_6 <= arg_761_1.time_ and arg_761_1.time_ < var_764_6 + var_764_14 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - var_764_6) / var_764_14

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= var_764_6 + var_764_14 and arg_761_1.time_ < var_764_6 + var_764_14 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	Play1105006182 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 1105006182
		arg_765_1.duration_ = 7.1

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play1105006183(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			local var_768_0 = arg_765_1.actors_["1150ui_story"]
			local var_768_1 = 0

			if var_768_1 < arg_765_1.time_ and arg_765_1.time_ <= var_768_1 + arg_768_0 and not isNil(var_768_0) and arg_765_1.var_.characterEffect1150ui_story == nil then
				arg_765_1.var_.characterEffect1150ui_story = var_768_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_768_2 = 0.200000002980232

			if var_768_1 <= arg_765_1.time_ and arg_765_1.time_ < var_768_1 + var_768_2 and not isNil(var_768_0) then
				local var_768_3 = (arg_765_1.time_ - var_768_1) / var_768_2

				if arg_765_1.var_.characterEffect1150ui_story and not isNil(var_768_0) then
					arg_765_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_765_1.time_ >= var_768_1 + var_768_2 and arg_765_1.time_ < var_768_1 + var_768_2 + arg_768_0 and not isNil(var_768_0) and arg_765_1.var_.characterEffect1150ui_story then
				arg_765_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_768_4 = 0

			if var_768_4 < arg_765_1.time_ and arg_765_1.time_ <= var_768_4 + arg_768_0 then
				arg_765_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_768_5 = 0
			local var_768_6 = 0.725

			if var_768_5 < arg_765_1.time_ and arg_765_1.time_ <= var_768_5 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, true)

				local var_768_7 = arg_765_1:FormatText(StoryNameCfg[74].name)

				arg_765_1.leftNameTxt_.text = var_768_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_765_1.leftNameTxt_.transform)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1.leftNameTxt_.text)
				SetActive(arg_765_1.iconTrs_.gameObject, false)
				arg_765_1.callingController_:SetSelectedState("normal")

				local var_768_8 = arg_765_1:GetWordFromCfg(1105006182)
				local var_768_9 = arg_765_1:FormatText(var_768_8.content)

				arg_765_1.text_.text = var_768_9

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_10 = 29
				local var_768_11 = utf8.len(var_768_9)
				local var_768_12 = var_768_10 <= 0 and var_768_6 or var_768_6 * (var_768_11 / var_768_10)

				if var_768_12 > 0 and var_768_6 < var_768_12 then
					arg_765_1.talkMaxDuration = var_768_12

					if var_768_12 + var_768_5 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_12 + var_768_5
					end
				end

				arg_765_1.text_.text = var_768_9
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006182", "story_v_side_new_1105006.awb") ~= 0 then
					local var_768_13 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006182", "story_v_side_new_1105006.awb") / 1000

					if var_768_13 + var_768_5 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_13 + var_768_5
					end

					if var_768_8.prefab_name ~= "" and arg_765_1.actors_[var_768_8.prefab_name] ~= nil then
						local var_768_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_765_1.actors_[var_768_8.prefab_name].transform, "story_v_side_new_1105006", "1105006182", "story_v_side_new_1105006.awb")

						arg_765_1:RecordAudio("1105006182", var_768_14)
						arg_765_1:RecordAudio("1105006182", var_768_14)
					else
						arg_765_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006182", "story_v_side_new_1105006.awb")
					end

					arg_765_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006182", "story_v_side_new_1105006.awb")
				end

				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_15 = math.max(var_768_6, arg_765_1.talkMaxDuration)

			if var_768_5 <= arg_765_1.time_ and arg_765_1.time_ < var_768_5 + var_768_15 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - var_768_5) / var_768_15

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= var_768_5 + var_768_15 and arg_765_1.time_ < var_768_5 + var_768_15 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {}

		arg_765_1:InitPlayNodeList()
	end,
	Play1105006183 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 1105006183
		arg_769_1.duration_ = 5

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play1105006184(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			local var_772_0 = arg_769_1.actors_["1150ui_story"].transform
			local var_772_1 = 0

			if var_772_1 < arg_769_1.time_ and arg_769_1.time_ <= var_772_1 + arg_772_0 then
				arg_769_1.var_.moveOldPos1150ui_story = var_772_0.localPosition
			end

			local var_772_2 = 0.001

			if var_772_1 <= arg_769_1.time_ and arg_769_1.time_ < var_772_1 + var_772_2 then
				local var_772_3 = (arg_769_1.time_ - var_772_1) / var_772_2
				local var_772_4 = Vector3.New(0, 100, 0)

				var_772_0.localPosition = Vector3.Lerp(arg_769_1.var_.moveOldPos1150ui_story, var_772_4, var_772_3)

				local var_772_5 = manager.ui.mainCamera.transform.position - var_772_0.position

				var_772_0.forward = Vector3.New(var_772_5.x, var_772_5.y, var_772_5.z)

				local var_772_6 = var_772_0.localEulerAngles

				var_772_6.z = 0
				var_772_6.x = 0
				var_772_0.localEulerAngles = var_772_6
			end

			if arg_769_1.time_ >= var_772_1 + var_772_2 and arg_769_1.time_ < var_772_1 + var_772_2 + arg_772_0 then
				var_772_0.localPosition = Vector3.New(0, 100, 0)

				local var_772_7 = manager.ui.mainCamera.transform.position - var_772_0.position

				var_772_0.forward = Vector3.New(var_772_7.x, var_772_7.y, var_772_7.z)

				local var_772_8 = var_772_0.localEulerAngles

				var_772_8.z = 0
				var_772_8.x = 0
				var_772_0.localEulerAngles = var_772_8
			end

			local var_772_9 = 0
			local var_772_10 = 0.925

			if var_772_9 < arg_769_1.time_ and arg_769_1.time_ <= var_772_9 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, false)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_769_1.iconTrs_.gameObject, false)
				arg_769_1.callingController_:SetSelectedState("normal")

				local var_772_11 = arg_769_1:GetWordFromCfg(1105006183)
				local var_772_12 = arg_769_1:FormatText(var_772_11.content)

				arg_769_1.text_.text = var_772_12

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_13 = 37
				local var_772_14 = utf8.len(var_772_12)
				local var_772_15 = var_772_13 <= 0 and var_772_10 or var_772_10 * (var_772_14 / var_772_13)

				if var_772_15 > 0 and var_772_10 < var_772_15 then
					arg_769_1.talkMaxDuration = var_772_15

					if var_772_15 + var_772_9 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_15 + var_772_9
					end
				end

				arg_769_1.text_.text = var_772_12
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)
				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_16 = math.max(var_772_10, arg_769_1.talkMaxDuration)

			if var_772_9 <= arg_769_1.time_ and arg_769_1.time_ < var_772_9 + var_772_16 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - var_772_9) / var_772_16

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= var_772_9 + var_772_16 and arg_769_1.time_ < var_772_9 + var_772_16 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_769_1:InitPlayNodeList()
	end,
	Play1105006184 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 1105006184
		arg_773_1.duration_ = 11.53

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play1105006185(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			local var_776_0 = arg_773_1.actors_["1150ui_story"]
			local var_776_1 = 0

			if var_776_1 < arg_773_1.time_ and arg_773_1.time_ <= var_776_1 + arg_776_0 and not isNil(var_776_0) and arg_773_1.var_.characterEffect1150ui_story == nil then
				arg_773_1.var_.characterEffect1150ui_story = var_776_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_776_2 = 0.200000002980232

			if var_776_1 <= arg_773_1.time_ and arg_773_1.time_ < var_776_1 + var_776_2 and not isNil(var_776_0) then
				local var_776_3 = (arg_773_1.time_ - var_776_1) / var_776_2

				if arg_773_1.var_.characterEffect1150ui_story and not isNil(var_776_0) then
					arg_773_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_773_1.time_ >= var_776_1 + var_776_2 and arg_773_1.time_ < var_776_1 + var_776_2 + arg_776_0 and not isNil(var_776_0) and arg_773_1.var_.characterEffect1150ui_story then
				arg_773_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_776_4 = 0

			if var_776_4 < arg_773_1.time_ and arg_773_1.time_ <= var_776_4 + arg_776_0 then
				arg_773_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_776_5 = 0

			if var_776_5 < arg_773_1.time_ and arg_773_1.time_ <= var_776_5 + arg_776_0 then
				arg_773_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_776_6 = arg_773_1.actors_["1150ui_story"].transform
			local var_776_7 = 0

			if var_776_7 < arg_773_1.time_ and arg_773_1.time_ <= var_776_7 + arg_776_0 then
				arg_773_1.var_.moveOldPos1150ui_story = var_776_6.localPosition
			end

			local var_776_8 = 0.001

			if var_776_7 <= arg_773_1.time_ and arg_773_1.time_ < var_776_7 + var_776_8 then
				local var_776_9 = (arg_773_1.time_ - var_776_7) / var_776_8
				local var_776_10 = Vector3.New(0, -1.01, -6.2)

				var_776_6.localPosition = Vector3.Lerp(arg_773_1.var_.moveOldPos1150ui_story, var_776_10, var_776_9)

				local var_776_11 = manager.ui.mainCamera.transform.position - var_776_6.position

				var_776_6.forward = Vector3.New(var_776_11.x, var_776_11.y, var_776_11.z)

				local var_776_12 = var_776_6.localEulerAngles

				var_776_12.z = 0
				var_776_12.x = 0
				var_776_6.localEulerAngles = var_776_12
			end

			if arg_773_1.time_ >= var_776_7 + var_776_8 and arg_773_1.time_ < var_776_7 + var_776_8 + arg_776_0 then
				var_776_6.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_776_13 = manager.ui.mainCamera.transform.position - var_776_6.position

				var_776_6.forward = Vector3.New(var_776_13.x, var_776_13.y, var_776_13.z)

				local var_776_14 = var_776_6.localEulerAngles

				var_776_14.z = 0
				var_776_14.x = 0
				var_776_6.localEulerAngles = var_776_14
			end

			local var_776_15 = 0
			local var_776_16 = 0.975

			if var_776_15 < arg_773_1.time_ and arg_773_1.time_ <= var_776_15 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, true)

				local var_776_17 = arg_773_1:FormatText(StoryNameCfg[74].name)

				arg_773_1.leftNameTxt_.text = var_776_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_773_1.leftNameTxt_.transform)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1.leftNameTxt_.text)
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_18 = arg_773_1:GetWordFromCfg(1105006184)
				local var_776_19 = arg_773_1:FormatText(var_776_18.content)

				arg_773_1.text_.text = var_776_19

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_20 = 39
				local var_776_21 = utf8.len(var_776_19)
				local var_776_22 = var_776_20 <= 0 and var_776_16 or var_776_16 * (var_776_21 / var_776_20)

				if var_776_22 > 0 and var_776_16 < var_776_22 then
					arg_773_1.talkMaxDuration = var_776_22

					if var_776_22 + var_776_15 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_22 + var_776_15
					end
				end

				arg_773_1.text_.text = var_776_19
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006184", "story_v_side_new_1105006.awb") ~= 0 then
					local var_776_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006184", "story_v_side_new_1105006.awb") / 1000

					if var_776_23 + var_776_15 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_23 + var_776_15
					end

					if var_776_18.prefab_name ~= "" and arg_773_1.actors_[var_776_18.prefab_name] ~= nil then
						local var_776_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_773_1.actors_[var_776_18.prefab_name].transform, "story_v_side_new_1105006", "1105006184", "story_v_side_new_1105006.awb")

						arg_773_1:RecordAudio("1105006184", var_776_24)
						arg_773_1:RecordAudio("1105006184", var_776_24)
					else
						arg_773_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006184", "story_v_side_new_1105006.awb")
					end

					arg_773_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006184", "story_v_side_new_1105006.awb")
				end

				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_25 = math.max(var_776_16, arg_773_1.talkMaxDuration)

			if var_776_15 <= arg_773_1.time_ and arg_773_1.time_ < var_776_15 + var_776_25 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - var_776_15) / var_776_25

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= var_776_15 + var_776_25 and arg_773_1.time_ < var_776_15 + var_776_25 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_773_1:InitPlayNodeList()
	end,
	Play1105006185 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 1105006185
		arg_777_1.duration_ = 5

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play1105006186(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			local var_780_0 = arg_777_1.actors_["1150ui_story"]
			local var_780_1 = 0

			if var_780_1 < arg_777_1.time_ and arg_777_1.time_ <= var_780_1 + arg_780_0 and not isNil(var_780_0) and arg_777_1.var_.characterEffect1150ui_story == nil then
				arg_777_1.var_.characterEffect1150ui_story = var_780_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_780_2 = 0.200000002980232

			if var_780_1 <= arg_777_1.time_ and arg_777_1.time_ < var_780_1 + var_780_2 and not isNil(var_780_0) then
				local var_780_3 = (arg_777_1.time_ - var_780_1) / var_780_2

				if arg_777_1.var_.characterEffect1150ui_story and not isNil(var_780_0) then
					local var_780_4 = Mathf.Lerp(0, 0.5, var_780_3)

					arg_777_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_777_1.var_.characterEffect1150ui_story.fillRatio = var_780_4
				end
			end

			if arg_777_1.time_ >= var_780_1 + var_780_2 and arg_777_1.time_ < var_780_1 + var_780_2 + arg_780_0 and not isNil(var_780_0) and arg_777_1.var_.characterEffect1150ui_story then
				local var_780_5 = 0.5

				arg_777_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_777_1.var_.characterEffect1150ui_story.fillRatio = var_780_5
			end

			local var_780_6 = 0
			local var_780_7 = 0.925

			if var_780_6 < arg_777_1.time_ and arg_777_1.time_ <= var_780_6 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				local var_780_8 = arg_777_1:FormatText(StoryNameCfg[7].name)

				arg_777_1.leftNameTxt_.text = var_780_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, true)
				arg_777_1.iconController_:SetSelectedState("hero")

				arg_777_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_777_1.callingController_:SetSelectedState("normal")

				arg_777_1.keyicon_.color = Color.New(1, 1, 1)
				arg_777_1.icon_.color = Color.New(1, 1, 1)

				local var_780_9 = arg_777_1:GetWordFromCfg(1105006185)
				local var_780_10 = arg_777_1:FormatText(var_780_9.content)

				arg_777_1.text_.text = var_780_10

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_11 = 37
				local var_780_12 = utf8.len(var_780_10)
				local var_780_13 = var_780_11 <= 0 and var_780_7 or var_780_7 * (var_780_12 / var_780_11)

				if var_780_13 > 0 and var_780_7 < var_780_13 then
					arg_777_1.talkMaxDuration = var_780_13

					if var_780_13 + var_780_6 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_13 + var_780_6
					end
				end

				arg_777_1.text_.text = var_780_10
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)
				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_14 = math.max(var_780_7, arg_777_1.talkMaxDuration)

			if var_780_6 <= arg_777_1.time_ and arg_777_1.time_ < var_780_6 + var_780_14 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - var_780_6) / var_780_14

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= var_780_6 + var_780_14 and arg_777_1.time_ < var_780_6 + var_780_14 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play1105006186 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 1105006186
		arg_781_1.duration_ = 5

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play1105006187(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			local var_784_0 = 0
			local var_784_1 = 0.525

			if var_784_0 < arg_781_1.time_ and arg_781_1.time_ <= var_784_0 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, true)

				local var_784_2 = arg_781_1:FormatText(StoryNameCfg[7].name)

				arg_781_1.leftNameTxt_.text = var_784_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_781_1.leftNameTxt_.transform)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1.leftNameTxt_.text)
				SetActive(arg_781_1.iconTrs_.gameObject, true)
				arg_781_1.iconController_:SetSelectedState("hero")

				arg_781_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_781_1.callingController_:SetSelectedState("normal")

				arg_781_1.keyicon_.color = Color.New(1, 1, 1)
				arg_781_1.icon_.color = Color.New(1, 1, 1)

				local var_784_3 = arg_781_1:GetWordFromCfg(1105006186)
				local var_784_4 = arg_781_1:FormatText(var_784_3.content)

				arg_781_1.text_.text = var_784_4

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_5 = 21
				local var_784_6 = utf8.len(var_784_4)
				local var_784_7 = var_784_5 <= 0 and var_784_1 or var_784_1 * (var_784_6 / var_784_5)

				if var_784_7 > 0 and var_784_1 < var_784_7 then
					arg_781_1.talkMaxDuration = var_784_7

					if var_784_7 + var_784_0 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_7 + var_784_0
					end
				end

				arg_781_1.text_.text = var_784_4
				arg_781_1.typewritter.percent = 0

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(false)
				arg_781_1:RecordContent(arg_781_1.text_.text)
			end

			local var_784_8 = math.max(var_784_1, arg_781_1.talkMaxDuration)

			if var_784_0 <= arg_781_1.time_ and arg_781_1.time_ < var_784_0 + var_784_8 then
				arg_781_1.typewritter.percent = (arg_781_1.time_ - var_784_0) / var_784_8

				arg_781_1.typewritter:SetDirty()
			end

			if arg_781_1.time_ >= var_784_0 + var_784_8 and arg_781_1.time_ < var_784_0 + var_784_8 + arg_784_0 then
				arg_781_1.typewritter.percent = 1

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(true)
			end
		end

		arg_781_1.nodeConfigList_ = {}

		arg_781_1:InitPlayNodeList()
	end,
	Play1105006187 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 1105006187
		arg_785_1.duration_ = 4.97

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play1105006188(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			local var_788_0 = arg_785_1.actors_["1150ui_story"]
			local var_788_1 = 0

			if var_788_1 < arg_785_1.time_ and arg_785_1.time_ <= var_788_1 + arg_788_0 and not isNil(var_788_0) and arg_785_1.var_.characterEffect1150ui_story == nil then
				arg_785_1.var_.characterEffect1150ui_story = var_788_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_788_2 = 0.200000002980232

			if var_788_1 <= arg_785_1.time_ and arg_785_1.time_ < var_788_1 + var_788_2 and not isNil(var_788_0) then
				local var_788_3 = (arg_785_1.time_ - var_788_1) / var_788_2

				if arg_785_1.var_.characterEffect1150ui_story and not isNil(var_788_0) then
					arg_785_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_785_1.time_ >= var_788_1 + var_788_2 and arg_785_1.time_ < var_788_1 + var_788_2 + arg_788_0 and not isNil(var_788_0) and arg_785_1.var_.characterEffect1150ui_story then
				arg_785_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_788_4 = 0

			if var_788_4 < arg_785_1.time_ and arg_785_1.time_ <= var_788_4 + arg_788_0 then
				arg_785_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_788_5 = 0
			local var_788_6 = 0.3

			if var_788_5 < arg_785_1.time_ and arg_785_1.time_ <= var_788_5 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0
				arg_785_1.dialogCg_.alpha = 1

				arg_785_1.dialog_:SetActive(true)
				SetActive(arg_785_1.leftNameGo_, true)

				local var_788_7 = arg_785_1:FormatText(StoryNameCfg[74].name)

				arg_785_1.leftNameTxt_.text = var_788_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_785_1.leftNameTxt_.transform)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1.leftNameTxt_.text)
				SetActive(arg_785_1.iconTrs_.gameObject, false)
				arg_785_1.callingController_:SetSelectedState("normal")

				local var_788_8 = arg_785_1:GetWordFromCfg(1105006187)
				local var_788_9 = arg_785_1:FormatText(var_788_8.content)

				arg_785_1.text_.text = var_788_9

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_10 = 12
				local var_788_11 = utf8.len(var_788_9)
				local var_788_12 = var_788_10 <= 0 and var_788_6 or var_788_6 * (var_788_11 / var_788_10)

				if var_788_12 > 0 and var_788_6 < var_788_12 then
					arg_785_1.talkMaxDuration = var_788_12

					if var_788_12 + var_788_5 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_12 + var_788_5
					end
				end

				arg_785_1.text_.text = var_788_9
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006187", "story_v_side_new_1105006.awb") ~= 0 then
					local var_788_13 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006187", "story_v_side_new_1105006.awb") / 1000

					if var_788_13 + var_788_5 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_13 + var_788_5
					end

					if var_788_8.prefab_name ~= "" and arg_785_1.actors_[var_788_8.prefab_name] ~= nil then
						local var_788_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_785_1.actors_[var_788_8.prefab_name].transform, "story_v_side_new_1105006", "1105006187", "story_v_side_new_1105006.awb")

						arg_785_1:RecordAudio("1105006187", var_788_14)
						arg_785_1:RecordAudio("1105006187", var_788_14)
					else
						arg_785_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006187", "story_v_side_new_1105006.awb")
					end

					arg_785_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006187", "story_v_side_new_1105006.awb")
				end

				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_15 = math.max(var_788_6, arg_785_1.talkMaxDuration)

			if var_788_5 <= arg_785_1.time_ and arg_785_1.time_ < var_788_5 + var_788_15 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - var_788_5) / var_788_15

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= var_788_5 + var_788_15 and arg_785_1.time_ < var_788_5 + var_788_15 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {}

		arg_785_1:InitPlayNodeList()
	end,
	Play1105006188 = function(arg_789_0, arg_789_1)
		arg_789_1.time_ = 0
		arg_789_1.frameCnt_ = 0
		arg_789_1.state_ = "playing"
		arg_789_1.curTalkId_ = 1105006188
		arg_789_1.duration_ = 5

		SetActive(arg_789_1.tipsGo_, false)

		function arg_789_1.onSingleLineFinish_()
			arg_789_1.onSingleLineUpdate_ = nil
			arg_789_1.onSingleLineFinish_ = nil
			arg_789_1.state_ = "waiting"
		end

		function arg_789_1.playNext_(arg_791_0)
			if arg_791_0 == 1 then
				arg_789_0:Play1105006189(arg_789_1)
			end
		end

		function arg_789_1.onSingleLineUpdate_(arg_792_0)
			local var_792_0 = arg_789_1.actors_["1150ui_story"].transform
			local var_792_1 = 0

			if var_792_1 < arg_789_1.time_ and arg_789_1.time_ <= var_792_1 + arg_792_0 then
				arg_789_1.var_.moveOldPos1150ui_story = var_792_0.localPosition
			end

			local var_792_2 = 0.001

			if var_792_1 <= arg_789_1.time_ and arg_789_1.time_ < var_792_1 + var_792_2 then
				local var_792_3 = (arg_789_1.time_ - var_792_1) / var_792_2
				local var_792_4 = Vector3.New(0, 100, 0)

				var_792_0.localPosition = Vector3.Lerp(arg_789_1.var_.moveOldPos1150ui_story, var_792_4, var_792_3)

				local var_792_5 = manager.ui.mainCamera.transform.position - var_792_0.position

				var_792_0.forward = Vector3.New(var_792_5.x, var_792_5.y, var_792_5.z)

				local var_792_6 = var_792_0.localEulerAngles

				var_792_6.z = 0
				var_792_6.x = 0
				var_792_0.localEulerAngles = var_792_6
			end

			if arg_789_1.time_ >= var_792_1 + var_792_2 and arg_789_1.time_ < var_792_1 + var_792_2 + arg_792_0 then
				var_792_0.localPosition = Vector3.New(0, 100, 0)

				local var_792_7 = manager.ui.mainCamera.transform.position - var_792_0.position

				var_792_0.forward = Vector3.New(var_792_7.x, var_792_7.y, var_792_7.z)

				local var_792_8 = var_792_0.localEulerAngles

				var_792_8.z = 0
				var_792_8.x = 0
				var_792_0.localEulerAngles = var_792_8
			end

			local var_792_9 = 0
			local var_792_10 = 1.025

			if var_792_9 < arg_789_1.time_ and arg_789_1.time_ <= var_792_9 + arg_792_0 then
				arg_789_1.talkMaxDuration = 0
				arg_789_1.dialogCg_.alpha = 1

				arg_789_1.dialog_:SetActive(true)
				SetActive(arg_789_1.leftNameGo_, false)

				arg_789_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_789_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_789_1:RecordName(arg_789_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_789_1.iconTrs_.gameObject, false)
				arg_789_1.callingController_:SetSelectedState("normal")

				local var_792_11 = arg_789_1:GetWordFromCfg(1105006188)
				local var_792_12 = arg_789_1:FormatText(var_792_11.content)

				arg_789_1.text_.text = var_792_12

				LuaForUtil.ClearLinePrefixSymbol(arg_789_1.text_)

				local var_792_13 = 41
				local var_792_14 = utf8.len(var_792_12)
				local var_792_15 = var_792_13 <= 0 and var_792_10 or var_792_10 * (var_792_14 / var_792_13)

				if var_792_15 > 0 and var_792_10 < var_792_15 then
					arg_789_1.talkMaxDuration = var_792_15

					if var_792_15 + var_792_9 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_15 + var_792_9
					end
				end

				arg_789_1.text_.text = var_792_12
				arg_789_1.typewritter.percent = 0

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(false)
				arg_789_1:RecordContent(arg_789_1.text_.text)
			end

			local var_792_16 = math.max(var_792_10, arg_789_1.talkMaxDuration)

			if var_792_9 <= arg_789_1.time_ and arg_789_1.time_ < var_792_9 + var_792_16 then
				arg_789_1.typewritter.percent = (arg_789_1.time_ - var_792_9) / var_792_16

				arg_789_1.typewritter:SetDirty()
			end

			if arg_789_1.time_ >= var_792_9 + var_792_16 and arg_789_1.time_ < var_792_9 + var_792_16 + arg_792_0 then
				arg_789_1.typewritter.percent = 1

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(true)
			end
		end

		arg_789_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_789_1:InitPlayNodeList()
	end,
	Play1105006189 = function(arg_793_0, arg_793_1)
		arg_793_1.time_ = 0
		arg_793_1.frameCnt_ = 0
		arg_793_1.state_ = "playing"
		arg_793_1.curTalkId_ = 1105006189
		arg_793_1.duration_ = 1

		SetActive(arg_793_1.tipsGo_, true)

		arg_793_1.tipsText_.text = StoryTipsCfg[105001].name

		function arg_793_1.onSingleLineFinish_()
			arg_793_1.onSingleLineUpdate_ = nil
			arg_793_1.onSingleLineFinish_ = nil
			arg_793_1.state_ = "waiting"

			SetActive(arg_793_1.choicesGo_, true)

			for iter_794_0, iter_794_1 in ipairs(arg_793_1.choices_) do
				local var_794_0 = iter_794_0 <= 2

				SetActive(iter_794_1.go, var_794_0)
			end

			arg_793_1.choices_[1].txt.text = arg_793_1:FormatText(StoryChoiceCfg[1068].name)
			arg_793_1.choices_[2].txt.text = arg_793_1:FormatText(StoryChoiceCfg[1069].name)
		end

		function arg_793_1.playNext_(arg_795_0)
			if arg_795_0 == 1 then
				PlayerAction.UseStoryTrigger(1050013, 210500106, 1105006189, 1)
				arg_793_0:Play1105006190(arg_793_1)
			end

			if arg_795_0 == 2 then
				PlayerAction.UseStoryTrigger(1050013, 210500106, 1105006189, 2)
				arg_793_0:Play1105006190(arg_793_1)
			end

			arg_793_1:RecordChoiceLog(1105006189, 1068, 1069)
		end

		function arg_793_1.onSingleLineUpdate_(arg_796_0)
			return
		end

		arg_793_1.nodeConfigList_ = {}

		arg_793_1:InitPlayNodeList()
	end,
	Play1105006190 = function(arg_797_0, arg_797_1)
		arg_797_1.time_ = 0
		arg_797_1.frameCnt_ = 0
		arg_797_1.state_ = "playing"
		arg_797_1.curTalkId_ = 1105006190
		arg_797_1.duration_ = 5

		SetActive(arg_797_1.tipsGo_, false)

		function arg_797_1.onSingleLineFinish_()
			arg_797_1.onSingleLineUpdate_ = nil
			arg_797_1.onSingleLineFinish_ = nil
			arg_797_1.state_ = "waiting"
		end

		function arg_797_1.playNext_(arg_799_0)
			if arg_799_0 == 1 then
				arg_797_0:Play1105006191(arg_797_1)
			end
		end

		function arg_797_1.onSingleLineUpdate_(arg_800_0)
			local var_800_0 = 0
			local var_800_1 = 1.1

			if var_800_0 < arg_797_1.time_ and arg_797_1.time_ <= var_800_0 + arg_800_0 then
				arg_797_1.talkMaxDuration = 0
				arg_797_1.dialogCg_.alpha = 1

				arg_797_1.dialog_:SetActive(true)
				SetActive(arg_797_1.leftNameGo_, false)

				arg_797_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_797_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_797_1:RecordName(arg_797_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_797_1.iconTrs_.gameObject, false)
				arg_797_1.callingController_:SetSelectedState("normal")

				local var_800_2 = arg_797_1:GetWordFromCfg(1105006190)
				local var_800_3 = arg_797_1:FormatText(var_800_2.content)

				arg_797_1.text_.text = var_800_3

				LuaForUtil.ClearLinePrefixSymbol(arg_797_1.text_)

				local var_800_4 = 44
				local var_800_5 = utf8.len(var_800_3)
				local var_800_6 = var_800_4 <= 0 and var_800_1 or var_800_1 * (var_800_5 / var_800_4)

				if var_800_6 > 0 and var_800_1 < var_800_6 then
					arg_797_1.talkMaxDuration = var_800_6

					if var_800_6 + var_800_0 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_6 + var_800_0
					end
				end

				arg_797_1.text_.text = var_800_3
				arg_797_1.typewritter.percent = 0

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(false)
				arg_797_1:RecordContent(arg_797_1.text_.text)
			end

			local var_800_7 = math.max(var_800_1, arg_797_1.talkMaxDuration)

			if var_800_0 <= arg_797_1.time_ and arg_797_1.time_ < var_800_0 + var_800_7 then
				arg_797_1.typewritter.percent = (arg_797_1.time_ - var_800_0) / var_800_7

				arg_797_1.typewritter:SetDirty()
			end

			if arg_797_1.time_ >= var_800_0 + var_800_7 and arg_797_1.time_ < var_800_0 + var_800_7 + arg_800_0 then
				arg_797_1.typewritter.percent = 1

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(true)
			end
		end

		arg_797_1.nodeConfigList_ = {}

		arg_797_1:InitPlayNodeList()
	end,
	Play1105006191 = function(arg_801_0, arg_801_1)
		arg_801_1.time_ = 0
		arg_801_1.frameCnt_ = 0
		arg_801_1.state_ = "playing"
		arg_801_1.curTalkId_ = 1105006191
		arg_801_1.duration_ = 2.47

		SetActive(arg_801_1.tipsGo_, false)

		function arg_801_1.onSingleLineFinish_()
			arg_801_1.onSingleLineUpdate_ = nil
			arg_801_1.onSingleLineFinish_ = nil
			arg_801_1.state_ = "waiting"
		end

		function arg_801_1.playNext_(arg_803_0)
			if arg_803_0 == 1 then
				arg_801_0:Play1105006192(arg_801_1)
			end
		end

		function arg_801_1.onSingleLineUpdate_(arg_804_0)
			local var_804_0 = arg_801_1.actors_["1150ui_story"].transform
			local var_804_1 = 0

			if var_804_1 < arg_801_1.time_ and arg_801_1.time_ <= var_804_1 + arg_804_0 then
				arg_801_1.var_.moveOldPos1150ui_story = var_804_0.localPosition
			end

			local var_804_2 = 0.001

			if var_804_1 <= arg_801_1.time_ and arg_801_1.time_ < var_804_1 + var_804_2 then
				local var_804_3 = (arg_801_1.time_ - var_804_1) / var_804_2
				local var_804_4 = Vector3.New(0, -1.01, -6.2)

				var_804_0.localPosition = Vector3.Lerp(arg_801_1.var_.moveOldPos1150ui_story, var_804_4, var_804_3)

				local var_804_5 = manager.ui.mainCamera.transform.position - var_804_0.position

				var_804_0.forward = Vector3.New(var_804_5.x, var_804_5.y, var_804_5.z)

				local var_804_6 = var_804_0.localEulerAngles

				var_804_6.z = 0
				var_804_6.x = 0
				var_804_0.localEulerAngles = var_804_6
			end

			if arg_801_1.time_ >= var_804_1 + var_804_2 and arg_801_1.time_ < var_804_1 + var_804_2 + arg_804_0 then
				var_804_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_804_7 = manager.ui.mainCamera.transform.position - var_804_0.position

				var_804_0.forward = Vector3.New(var_804_7.x, var_804_7.y, var_804_7.z)

				local var_804_8 = var_804_0.localEulerAngles

				var_804_8.z = 0
				var_804_8.x = 0
				var_804_0.localEulerAngles = var_804_8
			end

			local var_804_9 = arg_801_1.actors_["1150ui_story"]
			local var_804_10 = 0

			if var_804_10 < arg_801_1.time_ and arg_801_1.time_ <= var_804_10 + arg_804_0 and not isNil(var_804_9) and arg_801_1.var_.characterEffect1150ui_story == nil then
				arg_801_1.var_.characterEffect1150ui_story = var_804_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_804_11 = 0.200000002980232

			if var_804_10 <= arg_801_1.time_ and arg_801_1.time_ < var_804_10 + var_804_11 and not isNil(var_804_9) then
				local var_804_12 = (arg_801_1.time_ - var_804_10) / var_804_11

				if arg_801_1.var_.characterEffect1150ui_story and not isNil(var_804_9) then
					arg_801_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_801_1.time_ >= var_804_10 + var_804_11 and arg_801_1.time_ < var_804_10 + var_804_11 + arg_804_0 and not isNil(var_804_9) and arg_801_1.var_.characterEffect1150ui_story then
				arg_801_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_804_13 = 0

			if var_804_13 < arg_801_1.time_ and arg_801_1.time_ <= var_804_13 + arg_804_0 then
				arg_801_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_804_14 = 0
			local var_804_15 = 0.375

			if var_804_14 < arg_801_1.time_ and arg_801_1.time_ <= var_804_14 + arg_804_0 then
				arg_801_1.talkMaxDuration = 0
				arg_801_1.dialogCg_.alpha = 1

				arg_801_1.dialog_:SetActive(true)
				SetActive(arg_801_1.leftNameGo_, true)

				local var_804_16 = arg_801_1:FormatText(StoryNameCfg[74].name)

				arg_801_1.leftNameTxt_.text = var_804_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_801_1.leftNameTxt_.transform)

				arg_801_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_801_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_801_1:RecordName(arg_801_1.leftNameTxt_.text)
				SetActive(arg_801_1.iconTrs_.gameObject, false)
				arg_801_1.callingController_:SetSelectedState("normal")

				local var_804_17 = arg_801_1:GetWordFromCfg(1105006191)
				local var_804_18 = arg_801_1:FormatText(var_804_17.content)

				arg_801_1.text_.text = var_804_18

				LuaForUtil.ClearLinePrefixSymbol(arg_801_1.text_)

				local var_804_19 = 15
				local var_804_20 = utf8.len(var_804_18)
				local var_804_21 = var_804_19 <= 0 and var_804_15 or var_804_15 * (var_804_20 / var_804_19)

				if var_804_21 > 0 and var_804_15 < var_804_21 then
					arg_801_1.talkMaxDuration = var_804_21

					if var_804_21 + var_804_14 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_21 + var_804_14
					end
				end

				arg_801_1.text_.text = var_804_18
				arg_801_1.typewritter.percent = 0

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006191", "story_v_side_new_1105006.awb") ~= 0 then
					local var_804_22 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006191", "story_v_side_new_1105006.awb") / 1000

					if var_804_22 + var_804_14 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_22 + var_804_14
					end

					if var_804_17.prefab_name ~= "" and arg_801_1.actors_[var_804_17.prefab_name] ~= nil then
						local var_804_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_801_1.actors_[var_804_17.prefab_name].transform, "story_v_side_new_1105006", "1105006191", "story_v_side_new_1105006.awb")

						arg_801_1:RecordAudio("1105006191", var_804_23)
						arg_801_1:RecordAudio("1105006191", var_804_23)
					else
						arg_801_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006191", "story_v_side_new_1105006.awb")
					end

					arg_801_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006191", "story_v_side_new_1105006.awb")
				end

				arg_801_1:RecordContent(arg_801_1.text_.text)
			end

			local var_804_24 = math.max(var_804_15, arg_801_1.talkMaxDuration)

			if var_804_14 <= arg_801_1.time_ and arg_801_1.time_ < var_804_14 + var_804_24 then
				arg_801_1.typewritter.percent = (arg_801_1.time_ - var_804_14) / var_804_24

				arg_801_1.typewritter:SetDirty()
			end

			if arg_801_1.time_ >= var_804_14 + var_804_24 and arg_801_1.time_ < var_804_14 + var_804_24 + arg_804_0 then
				arg_801_1.typewritter.percent = 1

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(true)
			end
		end

		arg_801_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_801_1:InitPlayNodeList()
	end,
	Play1105006192 = function(arg_805_0, arg_805_1)
		arg_805_1.time_ = 0
		arg_805_1.frameCnt_ = 0
		arg_805_1.state_ = "playing"
		arg_805_1.curTalkId_ = 1105006192
		arg_805_1.duration_ = 5

		SetActive(arg_805_1.tipsGo_, false)

		function arg_805_1.onSingleLineFinish_()
			arg_805_1.onSingleLineUpdate_ = nil
			arg_805_1.onSingleLineFinish_ = nil
			arg_805_1.state_ = "waiting"
		end

		function arg_805_1.playNext_(arg_807_0)
			if arg_807_0 == 1 then
				arg_805_0:Play1105006193(arg_805_1)
			end
		end

		function arg_805_1.onSingleLineUpdate_(arg_808_0)
			local var_808_0 = arg_805_1.actors_["1150ui_story"].transform
			local var_808_1 = 0

			if var_808_1 < arg_805_1.time_ and arg_805_1.time_ <= var_808_1 + arg_808_0 then
				arg_805_1.var_.moveOldPos1150ui_story = var_808_0.localPosition
			end

			local var_808_2 = 0.001

			if var_808_1 <= arg_805_1.time_ and arg_805_1.time_ < var_808_1 + var_808_2 then
				local var_808_3 = (arg_805_1.time_ - var_808_1) / var_808_2
				local var_808_4 = Vector3.New(0, 100, 0)

				var_808_0.localPosition = Vector3.Lerp(arg_805_1.var_.moveOldPos1150ui_story, var_808_4, var_808_3)

				local var_808_5 = manager.ui.mainCamera.transform.position - var_808_0.position

				var_808_0.forward = Vector3.New(var_808_5.x, var_808_5.y, var_808_5.z)

				local var_808_6 = var_808_0.localEulerAngles

				var_808_6.z = 0
				var_808_6.x = 0
				var_808_0.localEulerAngles = var_808_6
			end

			if arg_805_1.time_ >= var_808_1 + var_808_2 and arg_805_1.time_ < var_808_1 + var_808_2 + arg_808_0 then
				var_808_0.localPosition = Vector3.New(0, 100, 0)

				local var_808_7 = manager.ui.mainCamera.transform.position - var_808_0.position

				var_808_0.forward = Vector3.New(var_808_7.x, var_808_7.y, var_808_7.z)

				local var_808_8 = var_808_0.localEulerAngles

				var_808_8.z = 0
				var_808_8.x = 0
				var_808_0.localEulerAngles = var_808_8
			end

			local var_808_9 = 0
			local var_808_10 = 0.85

			if var_808_9 < arg_805_1.time_ and arg_805_1.time_ <= var_808_9 + arg_808_0 then
				arg_805_1.talkMaxDuration = 0
				arg_805_1.dialogCg_.alpha = 1

				arg_805_1.dialog_:SetActive(true)
				SetActive(arg_805_1.leftNameGo_, true)

				local var_808_11 = arg_805_1:FormatText(StoryNameCfg[7].name)

				arg_805_1.leftNameTxt_.text = var_808_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_805_1.leftNameTxt_.transform)

				arg_805_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_805_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_805_1:RecordName(arg_805_1.leftNameTxt_.text)
				SetActive(arg_805_1.iconTrs_.gameObject, true)
				arg_805_1.iconController_:SetSelectedState("hero")

				arg_805_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_805_1.callingController_:SetSelectedState("normal")

				arg_805_1.keyicon_.color = Color.New(1, 1, 1)
				arg_805_1.icon_.color = Color.New(1, 1, 1)

				local var_808_12 = arg_805_1:GetWordFromCfg(1105006192)
				local var_808_13 = arg_805_1:FormatText(var_808_12.content)

				arg_805_1.text_.text = var_808_13

				LuaForUtil.ClearLinePrefixSymbol(arg_805_1.text_)

				local var_808_14 = 34
				local var_808_15 = utf8.len(var_808_13)
				local var_808_16 = var_808_14 <= 0 and var_808_10 or var_808_10 * (var_808_15 / var_808_14)

				if var_808_16 > 0 and var_808_10 < var_808_16 then
					arg_805_1.talkMaxDuration = var_808_16

					if var_808_16 + var_808_9 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_16 + var_808_9
					end
				end

				arg_805_1.text_.text = var_808_13
				arg_805_1.typewritter.percent = 0

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(false)
				arg_805_1:RecordContent(arg_805_1.text_.text)
			end

			local var_808_17 = math.max(var_808_10, arg_805_1.talkMaxDuration)

			if var_808_9 <= arg_805_1.time_ and arg_805_1.time_ < var_808_9 + var_808_17 then
				arg_805_1.typewritter.percent = (arg_805_1.time_ - var_808_9) / var_808_17

				arg_805_1.typewritter:SetDirty()
			end

			if arg_805_1.time_ >= var_808_9 + var_808_17 and arg_805_1.time_ < var_808_9 + var_808_17 + arg_808_0 then
				arg_805_1.typewritter.percent = 1

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(true)
			end
		end

		arg_805_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_805_1:InitPlayNodeList()
	end,
	Play1105006193 = function(arg_809_0, arg_809_1)
		arg_809_1.time_ = 0
		arg_809_1.frameCnt_ = 0
		arg_809_1.state_ = "playing"
		arg_809_1.curTalkId_ = 1105006193
		arg_809_1.duration_ = 5

		SetActive(arg_809_1.tipsGo_, false)

		function arg_809_1.onSingleLineFinish_()
			arg_809_1.onSingleLineUpdate_ = nil
			arg_809_1.onSingleLineFinish_ = nil
			arg_809_1.state_ = "waiting"
		end

		function arg_809_1.playNext_(arg_811_0)
			if arg_811_0 == 1 then
				arg_809_0:Play1105006194(arg_809_1)
			end
		end

		function arg_809_1.onSingleLineUpdate_(arg_812_0)
			local var_812_0 = 0
			local var_812_1 = 0.95

			if var_812_0 < arg_809_1.time_ and arg_809_1.time_ <= var_812_0 + arg_812_0 then
				arg_809_1.talkMaxDuration = 0
				arg_809_1.dialogCg_.alpha = 1

				arg_809_1.dialog_:SetActive(true)
				SetActive(arg_809_1.leftNameGo_, true)

				local var_812_2 = arg_809_1:FormatText(StoryNameCfg[7].name)

				arg_809_1.leftNameTxt_.text = var_812_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_809_1.leftNameTxt_.transform)

				arg_809_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_809_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_809_1:RecordName(arg_809_1.leftNameTxt_.text)
				SetActive(arg_809_1.iconTrs_.gameObject, true)
				arg_809_1.iconController_:SetSelectedState("hero")

				arg_809_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_809_1.callingController_:SetSelectedState("normal")

				arg_809_1.keyicon_.color = Color.New(1, 1, 1)
				arg_809_1.icon_.color = Color.New(1, 1, 1)

				local var_812_3 = arg_809_1:GetWordFromCfg(1105006193)
				local var_812_4 = arg_809_1:FormatText(var_812_3.content)

				arg_809_1.text_.text = var_812_4

				LuaForUtil.ClearLinePrefixSymbol(arg_809_1.text_)

				local var_812_5 = 38
				local var_812_6 = utf8.len(var_812_4)
				local var_812_7 = var_812_5 <= 0 and var_812_1 or var_812_1 * (var_812_6 / var_812_5)

				if var_812_7 > 0 and var_812_1 < var_812_7 then
					arg_809_1.talkMaxDuration = var_812_7

					if var_812_7 + var_812_0 > arg_809_1.duration_ then
						arg_809_1.duration_ = var_812_7 + var_812_0
					end
				end

				arg_809_1.text_.text = var_812_4
				arg_809_1.typewritter.percent = 0

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(false)
				arg_809_1:RecordContent(arg_809_1.text_.text)
			end

			local var_812_8 = math.max(var_812_1, arg_809_1.talkMaxDuration)

			if var_812_0 <= arg_809_1.time_ and arg_809_1.time_ < var_812_0 + var_812_8 then
				arg_809_1.typewritter.percent = (arg_809_1.time_ - var_812_0) / var_812_8

				arg_809_1.typewritter:SetDirty()
			end

			if arg_809_1.time_ >= var_812_0 + var_812_8 and arg_809_1.time_ < var_812_0 + var_812_8 + arg_812_0 then
				arg_809_1.typewritter.percent = 1

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(true)
			end
		end

		arg_809_1.nodeConfigList_ = {}

		arg_809_1:InitPlayNodeList()
	end,
	Play1105006194 = function(arg_813_0, arg_813_1)
		arg_813_1.time_ = 0
		arg_813_1.frameCnt_ = 0
		arg_813_1.state_ = "playing"
		arg_813_1.curTalkId_ = 1105006194
		arg_813_1.duration_ = 5

		SetActive(arg_813_1.tipsGo_, false)

		function arg_813_1.onSingleLineFinish_()
			arg_813_1.onSingleLineUpdate_ = nil
			arg_813_1.onSingleLineFinish_ = nil
			arg_813_1.state_ = "waiting"
		end

		function arg_813_1.playNext_(arg_815_0)
			if arg_815_0 == 1 then
				arg_813_0:Play1105006195(arg_813_1)
			end
		end

		function arg_813_1.onSingleLineUpdate_(arg_816_0)
			local var_816_0 = 0
			local var_816_1 = 0.95

			if var_816_0 < arg_813_1.time_ and arg_813_1.time_ <= var_816_0 + arg_816_0 then
				arg_813_1.talkMaxDuration = 0
				arg_813_1.dialogCg_.alpha = 1

				arg_813_1.dialog_:SetActive(true)
				SetActive(arg_813_1.leftNameGo_, true)

				local var_816_2 = arg_813_1:FormatText(StoryNameCfg[7].name)

				arg_813_1.leftNameTxt_.text = var_816_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_813_1.leftNameTxt_.transform)

				arg_813_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_813_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_813_1:RecordName(arg_813_1.leftNameTxt_.text)
				SetActive(arg_813_1.iconTrs_.gameObject, true)
				arg_813_1.iconController_:SetSelectedState("hero")

				arg_813_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_813_1.callingController_:SetSelectedState("normal")

				arg_813_1.keyicon_.color = Color.New(1, 1, 1)
				arg_813_1.icon_.color = Color.New(1, 1, 1)

				local var_816_3 = arg_813_1:GetWordFromCfg(1105006194)
				local var_816_4 = arg_813_1:FormatText(var_816_3.content)

				arg_813_1.text_.text = var_816_4

				LuaForUtil.ClearLinePrefixSymbol(arg_813_1.text_)

				local var_816_5 = 38
				local var_816_6 = utf8.len(var_816_4)
				local var_816_7 = var_816_5 <= 0 and var_816_1 or var_816_1 * (var_816_6 / var_816_5)

				if var_816_7 > 0 and var_816_1 < var_816_7 then
					arg_813_1.talkMaxDuration = var_816_7

					if var_816_7 + var_816_0 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_7 + var_816_0
					end
				end

				arg_813_1.text_.text = var_816_4
				arg_813_1.typewritter.percent = 0

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(false)
				arg_813_1:RecordContent(arg_813_1.text_.text)
			end

			local var_816_8 = math.max(var_816_1, arg_813_1.talkMaxDuration)

			if var_816_0 <= arg_813_1.time_ and arg_813_1.time_ < var_816_0 + var_816_8 then
				arg_813_1.typewritter.percent = (arg_813_1.time_ - var_816_0) / var_816_8

				arg_813_1.typewritter:SetDirty()
			end

			if arg_813_1.time_ >= var_816_0 + var_816_8 and arg_813_1.time_ < var_816_0 + var_816_8 + arg_816_0 then
				arg_813_1.typewritter.percent = 1

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(true)
			end
		end

		arg_813_1.nodeConfigList_ = {}

		arg_813_1:InitPlayNodeList()
	end,
	Play1105006195 = function(arg_817_0, arg_817_1)
		arg_817_1.time_ = 0
		arg_817_1.frameCnt_ = 0
		arg_817_1.state_ = "playing"
		arg_817_1.curTalkId_ = 1105006195
		arg_817_1.duration_ = 5

		SetActive(arg_817_1.tipsGo_, false)

		function arg_817_1.onSingleLineFinish_()
			arg_817_1.onSingleLineUpdate_ = nil
			arg_817_1.onSingleLineFinish_ = nil
			arg_817_1.state_ = "waiting"
		end

		function arg_817_1.playNext_(arg_819_0)
			if arg_819_0 == 1 then
				arg_817_0:Play1105006196(arg_817_1)
			end
		end

		function arg_817_1.onSingleLineUpdate_(arg_820_0)
			local var_820_0 = 0
			local var_820_1 = 1.275

			if var_820_0 < arg_817_1.time_ and arg_817_1.time_ <= var_820_0 + arg_820_0 then
				arg_817_1.talkMaxDuration = 0
				arg_817_1.dialogCg_.alpha = 1

				arg_817_1.dialog_:SetActive(true)
				SetActive(arg_817_1.leftNameGo_, false)

				arg_817_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_817_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_817_1:RecordName(arg_817_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_817_1.iconTrs_.gameObject, false)
				arg_817_1.callingController_:SetSelectedState("normal")

				local var_820_2 = arg_817_1:GetWordFromCfg(1105006195)
				local var_820_3 = arg_817_1:FormatText(var_820_2.content)

				arg_817_1.text_.text = var_820_3

				LuaForUtil.ClearLinePrefixSymbol(arg_817_1.text_)

				local var_820_4 = 51
				local var_820_5 = utf8.len(var_820_3)
				local var_820_6 = var_820_4 <= 0 and var_820_1 or var_820_1 * (var_820_5 / var_820_4)

				if var_820_6 > 0 and var_820_1 < var_820_6 then
					arg_817_1.talkMaxDuration = var_820_6

					if var_820_6 + var_820_0 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_6 + var_820_0
					end
				end

				arg_817_1.text_.text = var_820_3
				arg_817_1.typewritter.percent = 0

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(false)
				arg_817_1:RecordContent(arg_817_1.text_.text)
			end

			local var_820_7 = math.max(var_820_1, arg_817_1.talkMaxDuration)

			if var_820_0 <= arg_817_1.time_ and arg_817_1.time_ < var_820_0 + var_820_7 then
				arg_817_1.typewritter.percent = (arg_817_1.time_ - var_820_0) / var_820_7

				arg_817_1.typewritter:SetDirty()
			end

			if arg_817_1.time_ >= var_820_0 + var_820_7 and arg_817_1.time_ < var_820_0 + var_820_7 + arg_820_0 then
				arg_817_1.typewritter.percent = 1

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(true)
			end
		end

		arg_817_1.nodeConfigList_ = {}

		arg_817_1:InitPlayNodeList()
	end,
	Play1105006196 = function(arg_821_0, arg_821_1)
		arg_821_1.time_ = 0
		arg_821_1.frameCnt_ = 0
		arg_821_1.state_ = "playing"
		arg_821_1.curTalkId_ = 1105006196
		arg_821_1.duration_ = 5

		SetActive(arg_821_1.tipsGo_, false)

		function arg_821_1.onSingleLineFinish_()
			arg_821_1.onSingleLineUpdate_ = nil
			arg_821_1.onSingleLineFinish_ = nil
			arg_821_1.state_ = "waiting"
		end

		function arg_821_1.playNext_(arg_823_0)
			if arg_823_0 == 1 then
				arg_821_0:Play1105006197(arg_821_1)
			end
		end

		function arg_821_1.onSingleLineUpdate_(arg_824_0)
			local var_824_0 = 0
			local var_824_1 = 0.15

			if var_824_0 < arg_821_1.time_ and arg_821_1.time_ <= var_824_0 + arg_824_0 then
				arg_821_1.talkMaxDuration = 0
				arg_821_1.dialogCg_.alpha = 1

				arg_821_1.dialog_:SetActive(true)
				SetActive(arg_821_1.leftNameGo_, true)

				local var_824_2 = arg_821_1:FormatText(StoryNameCfg[7].name)

				arg_821_1.leftNameTxt_.text = var_824_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_821_1.leftNameTxt_.transform)

				arg_821_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_821_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_821_1:RecordName(arg_821_1.leftNameTxt_.text)
				SetActive(arg_821_1.iconTrs_.gameObject, true)
				arg_821_1.iconController_:SetSelectedState("hero")

				arg_821_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_821_1.callingController_:SetSelectedState("normal")

				arg_821_1.keyicon_.color = Color.New(1, 1, 1)
				arg_821_1.icon_.color = Color.New(1, 1, 1)

				local var_824_3 = arg_821_1:GetWordFromCfg(1105006196)
				local var_824_4 = arg_821_1:FormatText(var_824_3.content)

				arg_821_1.text_.text = var_824_4

				LuaForUtil.ClearLinePrefixSymbol(arg_821_1.text_)

				local var_824_5 = 6
				local var_824_6 = utf8.len(var_824_4)
				local var_824_7 = var_824_5 <= 0 and var_824_1 or var_824_1 * (var_824_6 / var_824_5)

				if var_824_7 > 0 and var_824_1 < var_824_7 then
					arg_821_1.talkMaxDuration = var_824_7

					if var_824_7 + var_824_0 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_7 + var_824_0
					end
				end

				arg_821_1.text_.text = var_824_4
				arg_821_1.typewritter.percent = 0

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(false)
				arg_821_1:RecordContent(arg_821_1.text_.text)
			end

			local var_824_8 = math.max(var_824_1, arg_821_1.talkMaxDuration)

			if var_824_0 <= arg_821_1.time_ and arg_821_1.time_ < var_824_0 + var_824_8 then
				arg_821_1.typewritter.percent = (arg_821_1.time_ - var_824_0) / var_824_8

				arg_821_1.typewritter:SetDirty()
			end

			if arg_821_1.time_ >= var_824_0 + var_824_8 and arg_821_1.time_ < var_824_0 + var_824_8 + arg_824_0 then
				arg_821_1.typewritter.percent = 1

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(true)
			end
		end

		arg_821_1.nodeConfigList_ = {}

		arg_821_1:InitPlayNodeList()
	end,
	Play1105006197 = function(arg_825_0, arg_825_1)
		arg_825_1.time_ = 0
		arg_825_1.frameCnt_ = 0
		arg_825_1.state_ = "playing"
		arg_825_1.curTalkId_ = 1105006197
		arg_825_1.duration_ = 10.37

		SetActive(arg_825_1.tipsGo_, false)

		function arg_825_1.onSingleLineFinish_()
			arg_825_1.onSingleLineUpdate_ = nil
			arg_825_1.onSingleLineFinish_ = nil
			arg_825_1.state_ = "waiting"
		end

		function arg_825_1.playNext_(arg_827_0)
			if arg_827_0 == 1 then
				arg_825_0:Play1105006198(arg_825_1)
			end
		end

		function arg_825_1.onSingleLineUpdate_(arg_828_0)
			local var_828_0 = arg_825_1.actors_["1150ui_story"].transform
			local var_828_1 = 0

			if var_828_1 < arg_825_1.time_ and arg_825_1.time_ <= var_828_1 + arg_828_0 then
				arg_825_1.var_.moveOldPos1150ui_story = var_828_0.localPosition
			end

			local var_828_2 = 0.001

			if var_828_1 <= arg_825_1.time_ and arg_825_1.time_ < var_828_1 + var_828_2 then
				local var_828_3 = (arg_825_1.time_ - var_828_1) / var_828_2
				local var_828_4 = Vector3.New(0, -1.01, -6.2)

				var_828_0.localPosition = Vector3.Lerp(arg_825_1.var_.moveOldPos1150ui_story, var_828_4, var_828_3)

				local var_828_5 = manager.ui.mainCamera.transform.position - var_828_0.position

				var_828_0.forward = Vector3.New(var_828_5.x, var_828_5.y, var_828_5.z)

				local var_828_6 = var_828_0.localEulerAngles

				var_828_6.z = 0
				var_828_6.x = 0
				var_828_0.localEulerAngles = var_828_6
			end

			if arg_825_1.time_ >= var_828_1 + var_828_2 and arg_825_1.time_ < var_828_1 + var_828_2 + arg_828_0 then
				var_828_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_828_7 = manager.ui.mainCamera.transform.position - var_828_0.position

				var_828_0.forward = Vector3.New(var_828_7.x, var_828_7.y, var_828_7.z)

				local var_828_8 = var_828_0.localEulerAngles

				var_828_8.z = 0
				var_828_8.x = 0
				var_828_0.localEulerAngles = var_828_8
			end

			local var_828_9 = arg_825_1.actors_["1150ui_story"]
			local var_828_10 = 0

			if var_828_10 < arg_825_1.time_ and arg_825_1.time_ <= var_828_10 + arg_828_0 and not isNil(var_828_9) and arg_825_1.var_.characterEffect1150ui_story == nil then
				arg_825_1.var_.characterEffect1150ui_story = var_828_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_828_11 = 0.200000002980232

			if var_828_10 <= arg_825_1.time_ and arg_825_1.time_ < var_828_10 + var_828_11 and not isNil(var_828_9) then
				local var_828_12 = (arg_825_1.time_ - var_828_10) / var_828_11

				if arg_825_1.var_.characterEffect1150ui_story and not isNil(var_828_9) then
					arg_825_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_825_1.time_ >= var_828_10 + var_828_11 and arg_825_1.time_ < var_828_10 + var_828_11 + arg_828_0 and not isNil(var_828_9) and arg_825_1.var_.characterEffect1150ui_story then
				arg_825_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_828_13 = 0

			if var_828_13 < arg_825_1.time_ and arg_825_1.time_ <= var_828_13 + arg_828_0 then
				arg_825_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			local var_828_14 = 0

			if var_828_14 < arg_825_1.time_ and arg_825_1.time_ <= var_828_14 + arg_828_0 then
				arg_825_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_828_15 = 0
			local var_828_16 = 0.825

			if var_828_15 < arg_825_1.time_ and arg_825_1.time_ <= var_828_15 + arg_828_0 then
				arg_825_1.talkMaxDuration = 0
				arg_825_1.dialogCg_.alpha = 1

				arg_825_1.dialog_:SetActive(true)
				SetActive(arg_825_1.leftNameGo_, true)

				local var_828_17 = arg_825_1:FormatText(StoryNameCfg[74].name)

				arg_825_1.leftNameTxt_.text = var_828_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_825_1.leftNameTxt_.transform)

				arg_825_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_825_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_825_1:RecordName(arg_825_1.leftNameTxt_.text)
				SetActive(arg_825_1.iconTrs_.gameObject, false)
				arg_825_1.callingController_:SetSelectedState("normal")

				local var_828_18 = arg_825_1:GetWordFromCfg(1105006197)
				local var_828_19 = arg_825_1:FormatText(var_828_18.content)

				arg_825_1.text_.text = var_828_19

				LuaForUtil.ClearLinePrefixSymbol(arg_825_1.text_)

				local var_828_20 = 33
				local var_828_21 = utf8.len(var_828_19)
				local var_828_22 = var_828_20 <= 0 and var_828_16 or var_828_16 * (var_828_21 / var_828_20)

				if var_828_22 > 0 and var_828_16 < var_828_22 then
					arg_825_1.talkMaxDuration = var_828_22

					if var_828_22 + var_828_15 > arg_825_1.duration_ then
						arg_825_1.duration_ = var_828_22 + var_828_15
					end
				end

				arg_825_1.text_.text = var_828_19
				arg_825_1.typewritter.percent = 0

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006197", "story_v_side_new_1105006.awb") ~= 0 then
					local var_828_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006197", "story_v_side_new_1105006.awb") / 1000

					if var_828_23 + var_828_15 > arg_825_1.duration_ then
						arg_825_1.duration_ = var_828_23 + var_828_15
					end

					if var_828_18.prefab_name ~= "" and arg_825_1.actors_[var_828_18.prefab_name] ~= nil then
						local var_828_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_825_1.actors_[var_828_18.prefab_name].transform, "story_v_side_new_1105006", "1105006197", "story_v_side_new_1105006.awb")

						arg_825_1:RecordAudio("1105006197", var_828_24)
						arg_825_1:RecordAudio("1105006197", var_828_24)
					else
						arg_825_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006197", "story_v_side_new_1105006.awb")
					end

					arg_825_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006197", "story_v_side_new_1105006.awb")
				end

				arg_825_1:RecordContent(arg_825_1.text_.text)
			end

			local var_828_25 = math.max(var_828_16, arg_825_1.talkMaxDuration)

			if var_828_15 <= arg_825_1.time_ and arg_825_1.time_ < var_828_15 + var_828_25 then
				arg_825_1.typewritter.percent = (arg_825_1.time_ - var_828_15) / var_828_25

				arg_825_1.typewritter:SetDirty()
			end

			if arg_825_1.time_ >= var_828_15 + var_828_25 and arg_825_1.time_ < var_828_15 + var_828_25 + arg_828_0 then
				arg_825_1.typewritter.percent = 1

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(true)
			end
		end

		arg_825_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_825_1:InitPlayNodeList()
	end,
	Play1105006198 = function(arg_829_0, arg_829_1)
		arg_829_1.time_ = 0
		arg_829_1.frameCnt_ = 0
		arg_829_1.state_ = "playing"
		arg_829_1.curTalkId_ = 1105006198
		arg_829_1.duration_ = 5

		SetActive(arg_829_1.tipsGo_, false)

		function arg_829_1.onSingleLineFinish_()
			arg_829_1.onSingleLineUpdate_ = nil
			arg_829_1.onSingleLineFinish_ = nil
			arg_829_1.state_ = "waiting"
		end

		function arg_829_1.playNext_(arg_831_0)
			if arg_831_0 == 1 then
				arg_829_0:Play1105006199(arg_829_1)
			end
		end

		function arg_829_1.onSingleLineUpdate_(arg_832_0)
			local var_832_0 = arg_829_1.actors_["1150ui_story"]
			local var_832_1 = 0

			if var_832_1 < arg_829_1.time_ and arg_829_1.time_ <= var_832_1 + arg_832_0 and not isNil(var_832_0) and arg_829_1.var_.characterEffect1150ui_story == nil then
				arg_829_1.var_.characterEffect1150ui_story = var_832_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_832_2 = 0.200000002980232

			if var_832_1 <= arg_829_1.time_ and arg_829_1.time_ < var_832_1 + var_832_2 and not isNil(var_832_0) then
				local var_832_3 = (arg_829_1.time_ - var_832_1) / var_832_2

				if arg_829_1.var_.characterEffect1150ui_story and not isNil(var_832_0) then
					local var_832_4 = Mathf.Lerp(0, 0.5, var_832_3)

					arg_829_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_829_1.var_.characterEffect1150ui_story.fillRatio = var_832_4
				end
			end

			if arg_829_1.time_ >= var_832_1 + var_832_2 and arg_829_1.time_ < var_832_1 + var_832_2 + arg_832_0 and not isNil(var_832_0) and arg_829_1.var_.characterEffect1150ui_story then
				local var_832_5 = 0.5

				arg_829_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_829_1.var_.characterEffect1150ui_story.fillRatio = var_832_5
			end

			local var_832_6 = 0
			local var_832_7 = 0.05

			if var_832_6 < arg_829_1.time_ and arg_829_1.time_ <= var_832_6 + arg_832_0 then
				arg_829_1.talkMaxDuration = 0
				arg_829_1.dialogCg_.alpha = 1

				arg_829_1.dialog_:SetActive(true)
				SetActive(arg_829_1.leftNameGo_, true)

				local var_832_8 = arg_829_1:FormatText(StoryNameCfg[7].name)

				arg_829_1.leftNameTxt_.text = var_832_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_829_1.leftNameTxt_.transform)

				arg_829_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_829_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_829_1:RecordName(arg_829_1.leftNameTxt_.text)
				SetActive(arg_829_1.iconTrs_.gameObject, true)
				arg_829_1.iconController_:SetSelectedState("hero")

				arg_829_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_829_1.callingController_:SetSelectedState("normal")

				arg_829_1.keyicon_.color = Color.New(1, 1, 1)
				arg_829_1.icon_.color = Color.New(1, 1, 1)

				local var_832_9 = arg_829_1:GetWordFromCfg(1105006198)
				local var_832_10 = arg_829_1:FormatText(var_832_9.content)

				arg_829_1.text_.text = var_832_10

				LuaForUtil.ClearLinePrefixSymbol(arg_829_1.text_)

				local var_832_11 = 2
				local var_832_12 = utf8.len(var_832_10)
				local var_832_13 = var_832_11 <= 0 and var_832_7 or var_832_7 * (var_832_12 / var_832_11)

				if var_832_13 > 0 and var_832_7 < var_832_13 then
					arg_829_1.talkMaxDuration = var_832_13

					if var_832_13 + var_832_6 > arg_829_1.duration_ then
						arg_829_1.duration_ = var_832_13 + var_832_6
					end
				end

				arg_829_1.text_.text = var_832_10
				arg_829_1.typewritter.percent = 0

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(false)
				arg_829_1:RecordContent(arg_829_1.text_.text)
			end

			local var_832_14 = math.max(var_832_7, arg_829_1.talkMaxDuration)

			if var_832_6 <= arg_829_1.time_ and arg_829_1.time_ < var_832_6 + var_832_14 then
				arg_829_1.typewritter.percent = (arg_829_1.time_ - var_832_6) / var_832_14

				arg_829_1.typewritter:SetDirty()
			end

			if arg_829_1.time_ >= var_832_6 + var_832_14 and arg_829_1.time_ < var_832_6 + var_832_14 + arg_832_0 then
				arg_829_1.typewritter.percent = 1

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(true)
			end
		end

		arg_829_1.nodeConfigList_ = {}

		arg_829_1:InitPlayNodeList()
	end,
	Play1105006199 = function(arg_833_0, arg_833_1)
		arg_833_1.time_ = 0
		arg_833_1.frameCnt_ = 0
		arg_833_1.state_ = "playing"
		arg_833_1.curTalkId_ = 1105006199
		arg_833_1.duration_ = 5

		SetActive(arg_833_1.tipsGo_, false)

		function arg_833_1.onSingleLineFinish_()
			arg_833_1.onSingleLineUpdate_ = nil
			arg_833_1.onSingleLineFinish_ = nil
			arg_833_1.state_ = "waiting"
		end

		function arg_833_1.playNext_(arg_835_0)
			if arg_835_0 == 1 then
				arg_833_0:Play1105006200(arg_833_1)
			end
		end

		function arg_833_1.onSingleLineUpdate_(arg_836_0)
			local var_836_0 = arg_833_1.actors_["1150ui_story"].transform
			local var_836_1 = 0

			if var_836_1 < arg_833_1.time_ and arg_833_1.time_ <= var_836_1 + arg_836_0 then
				arg_833_1.var_.moveOldPos1150ui_story = var_836_0.localPosition
			end

			local var_836_2 = 0.001

			if var_836_1 <= arg_833_1.time_ and arg_833_1.time_ < var_836_1 + var_836_2 then
				local var_836_3 = (arg_833_1.time_ - var_836_1) / var_836_2
				local var_836_4 = Vector3.New(0, 100, 0)

				var_836_0.localPosition = Vector3.Lerp(arg_833_1.var_.moveOldPos1150ui_story, var_836_4, var_836_3)

				local var_836_5 = manager.ui.mainCamera.transform.position - var_836_0.position

				var_836_0.forward = Vector3.New(var_836_5.x, var_836_5.y, var_836_5.z)

				local var_836_6 = var_836_0.localEulerAngles

				var_836_6.z = 0
				var_836_6.x = 0
				var_836_0.localEulerAngles = var_836_6
			end

			if arg_833_1.time_ >= var_836_1 + var_836_2 and arg_833_1.time_ < var_836_1 + var_836_2 + arg_836_0 then
				var_836_0.localPosition = Vector3.New(0, 100, 0)

				local var_836_7 = manager.ui.mainCamera.transform.position - var_836_0.position

				var_836_0.forward = Vector3.New(var_836_7.x, var_836_7.y, var_836_7.z)

				local var_836_8 = var_836_0.localEulerAngles

				var_836_8.z = 0
				var_836_8.x = 0
				var_836_0.localEulerAngles = var_836_8
			end

			local var_836_9 = 0
			local var_836_10 = 0.925

			if var_836_9 < arg_833_1.time_ and arg_833_1.time_ <= var_836_9 + arg_836_0 then
				arg_833_1.talkMaxDuration = 0
				arg_833_1.dialogCg_.alpha = 1

				arg_833_1.dialog_:SetActive(true)
				SetActive(arg_833_1.leftNameGo_, false)

				arg_833_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_833_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_833_1:RecordName(arg_833_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_833_1.iconTrs_.gameObject, false)
				arg_833_1.callingController_:SetSelectedState("normal")

				local var_836_11 = arg_833_1:GetWordFromCfg(1105006199)
				local var_836_12 = arg_833_1:FormatText(var_836_11.content)

				arg_833_1.text_.text = var_836_12

				LuaForUtil.ClearLinePrefixSymbol(arg_833_1.text_)

				local var_836_13 = 37
				local var_836_14 = utf8.len(var_836_12)
				local var_836_15 = var_836_13 <= 0 and var_836_10 or var_836_10 * (var_836_14 / var_836_13)

				if var_836_15 > 0 and var_836_10 < var_836_15 then
					arg_833_1.talkMaxDuration = var_836_15

					if var_836_15 + var_836_9 > arg_833_1.duration_ then
						arg_833_1.duration_ = var_836_15 + var_836_9
					end
				end

				arg_833_1.text_.text = var_836_12
				arg_833_1.typewritter.percent = 0

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(false)
				arg_833_1:RecordContent(arg_833_1.text_.text)
			end

			local var_836_16 = math.max(var_836_10, arg_833_1.talkMaxDuration)

			if var_836_9 <= arg_833_1.time_ and arg_833_1.time_ < var_836_9 + var_836_16 then
				arg_833_1.typewritter.percent = (arg_833_1.time_ - var_836_9) / var_836_16

				arg_833_1.typewritter:SetDirty()
			end

			if arg_833_1.time_ >= var_836_9 + var_836_16 and arg_833_1.time_ < var_836_9 + var_836_16 + arg_836_0 then
				arg_833_1.typewritter.percent = 1

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(true)
			end
		end

		arg_833_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_833_1:InitPlayNodeList()
	end,
	Play1105006200 = function(arg_837_0, arg_837_1)
		arg_837_1.time_ = 0
		arg_837_1.frameCnt_ = 0
		arg_837_1.state_ = "playing"
		arg_837_1.curTalkId_ = 1105006200
		arg_837_1.duration_ = 5

		SetActive(arg_837_1.tipsGo_, false)

		function arg_837_1.onSingleLineFinish_()
			arg_837_1.onSingleLineUpdate_ = nil
			arg_837_1.onSingleLineFinish_ = nil
			arg_837_1.state_ = "waiting"
		end

		function arg_837_1.playNext_(arg_839_0)
			if arg_839_0 == 1 then
				arg_837_0:Play1105006201(arg_837_1)
			end
		end

		function arg_837_1.onSingleLineUpdate_(arg_840_0)
			local var_840_0 = 0
			local var_840_1 = 0.625

			if var_840_0 < arg_837_1.time_ and arg_837_1.time_ <= var_840_0 + arg_840_0 then
				arg_837_1.talkMaxDuration = 0
				arg_837_1.dialogCg_.alpha = 1

				arg_837_1.dialog_:SetActive(true)
				SetActive(arg_837_1.leftNameGo_, false)

				arg_837_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_837_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_837_1:RecordName(arg_837_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_837_1.iconTrs_.gameObject, false)
				arg_837_1.callingController_:SetSelectedState("normal")

				local var_840_2 = arg_837_1:GetWordFromCfg(1105006200)
				local var_840_3 = arg_837_1:FormatText(var_840_2.content)

				arg_837_1.text_.text = var_840_3

				LuaForUtil.ClearLinePrefixSymbol(arg_837_1.text_)

				local var_840_4 = 25
				local var_840_5 = utf8.len(var_840_3)
				local var_840_6 = var_840_4 <= 0 and var_840_1 or var_840_1 * (var_840_5 / var_840_4)

				if var_840_6 > 0 and var_840_1 < var_840_6 then
					arg_837_1.talkMaxDuration = var_840_6

					if var_840_6 + var_840_0 > arg_837_1.duration_ then
						arg_837_1.duration_ = var_840_6 + var_840_0
					end
				end

				arg_837_1.text_.text = var_840_3
				arg_837_1.typewritter.percent = 0

				arg_837_1.typewritter:SetDirty()
				arg_837_1:ShowNextGo(false)
				arg_837_1:RecordContent(arg_837_1.text_.text)
			end

			local var_840_7 = math.max(var_840_1, arg_837_1.talkMaxDuration)

			if var_840_0 <= arg_837_1.time_ and arg_837_1.time_ < var_840_0 + var_840_7 then
				arg_837_1.typewritter.percent = (arg_837_1.time_ - var_840_0) / var_840_7

				arg_837_1.typewritter:SetDirty()
			end

			if arg_837_1.time_ >= var_840_0 + var_840_7 and arg_837_1.time_ < var_840_0 + var_840_7 + arg_840_0 then
				arg_837_1.typewritter.percent = 1

				arg_837_1.typewritter:SetDirty()
				arg_837_1:ShowNextGo(true)
			end
		end

		arg_837_1.nodeConfigList_ = {}

		arg_837_1:InitPlayNodeList()
	end,
	Play1105006201 = function(arg_841_0, arg_841_1)
		arg_841_1.time_ = 0
		arg_841_1.frameCnt_ = 0
		arg_841_1.state_ = "playing"
		arg_841_1.curTalkId_ = 1105006201
		arg_841_1.duration_ = 6.33

		SetActive(arg_841_1.tipsGo_, false)

		function arg_841_1.onSingleLineFinish_()
			arg_841_1.onSingleLineUpdate_ = nil
			arg_841_1.onSingleLineFinish_ = nil
			arg_841_1.state_ = "waiting"
		end

		function arg_841_1.playNext_(arg_843_0)
			if arg_843_0 == 1 then
				arg_841_0:Play1105006202(arg_841_1)
			end
		end

		function arg_841_1.onSingleLineUpdate_(arg_844_0)
			local var_844_0 = arg_841_1.actors_["1150ui_story"].transform
			local var_844_1 = 0

			if var_844_1 < arg_841_1.time_ and arg_841_1.time_ <= var_844_1 + arg_844_0 then
				arg_841_1.var_.moveOldPos1150ui_story = var_844_0.localPosition
			end

			local var_844_2 = 0.001

			if var_844_1 <= arg_841_1.time_ and arg_841_1.time_ < var_844_1 + var_844_2 then
				local var_844_3 = (arg_841_1.time_ - var_844_1) / var_844_2
				local var_844_4 = Vector3.New(0, -1.01, -6.2)

				var_844_0.localPosition = Vector3.Lerp(arg_841_1.var_.moveOldPos1150ui_story, var_844_4, var_844_3)

				local var_844_5 = manager.ui.mainCamera.transform.position - var_844_0.position

				var_844_0.forward = Vector3.New(var_844_5.x, var_844_5.y, var_844_5.z)

				local var_844_6 = var_844_0.localEulerAngles

				var_844_6.z = 0
				var_844_6.x = 0
				var_844_0.localEulerAngles = var_844_6
			end

			if arg_841_1.time_ >= var_844_1 + var_844_2 and arg_841_1.time_ < var_844_1 + var_844_2 + arg_844_0 then
				var_844_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_844_7 = manager.ui.mainCamera.transform.position - var_844_0.position

				var_844_0.forward = Vector3.New(var_844_7.x, var_844_7.y, var_844_7.z)

				local var_844_8 = var_844_0.localEulerAngles

				var_844_8.z = 0
				var_844_8.x = 0
				var_844_0.localEulerAngles = var_844_8
			end

			local var_844_9 = arg_841_1.actors_["1150ui_story"]
			local var_844_10 = 0

			if var_844_10 < arg_841_1.time_ and arg_841_1.time_ <= var_844_10 + arg_844_0 and not isNil(var_844_9) and arg_841_1.var_.characterEffect1150ui_story == nil then
				arg_841_1.var_.characterEffect1150ui_story = var_844_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_844_11 = 0.200000002980232

			if var_844_10 <= arg_841_1.time_ and arg_841_1.time_ < var_844_10 + var_844_11 and not isNil(var_844_9) then
				local var_844_12 = (arg_841_1.time_ - var_844_10) / var_844_11

				if arg_841_1.var_.characterEffect1150ui_story and not isNil(var_844_9) then
					arg_841_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_841_1.time_ >= var_844_10 + var_844_11 and arg_841_1.time_ < var_844_10 + var_844_11 + arg_844_0 and not isNil(var_844_9) and arg_841_1.var_.characterEffect1150ui_story then
				arg_841_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_844_13 = 0

			if var_844_13 < arg_841_1.time_ and arg_841_1.time_ <= var_844_13 + arg_844_0 then
				arg_841_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_2")
			end

			local var_844_14 = 0

			if var_844_14 < arg_841_1.time_ and arg_841_1.time_ <= var_844_14 + arg_844_0 then
				arg_841_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_844_15 = 0
			local var_844_16 = 0.65

			if var_844_15 < arg_841_1.time_ and arg_841_1.time_ <= var_844_15 + arg_844_0 then
				arg_841_1.talkMaxDuration = 0
				arg_841_1.dialogCg_.alpha = 1

				arg_841_1.dialog_:SetActive(true)
				SetActive(arg_841_1.leftNameGo_, true)

				local var_844_17 = arg_841_1:FormatText(StoryNameCfg[74].name)

				arg_841_1.leftNameTxt_.text = var_844_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_841_1.leftNameTxt_.transform)

				arg_841_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_841_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_841_1:RecordName(arg_841_1.leftNameTxt_.text)
				SetActive(arg_841_1.iconTrs_.gameObject, false)
				arg_841_1.callingController_:SetSelectedState("normal")

				local var_844_18 = arg_841_1:GetWordFromCfg(1105006201)
				local var_844_19 = arg_841_1:FormatText(var_844_18.content)

				arg_841_1.text_.text = var_844_19

				LuaForUtil.ClearLinePrefixSymbol(arg_841_1.text_)

				local var_844_20 = 26
				local var_844_21 = utf8.len(var_844_19)
				local var_844_22 = var_844_20 <= 0 and var_844_16 or var_844_16 * (var_844_21 / var_844_20)

				if var_844_22 > 0 and var_844_16 < var_844_22 then
					arg_841_1.talkMaxDuration = var_844_22

					if var_844_22 + var_844_15 > arg_841_1.duration_ then
						arg_841_1.duration_ = var_844_22 + var_844_15
					end
				end

				arg_841_1.text_.text = var_844_19
				arg_841_1.typewritter.percent = 0

				arg_841_1.typewritter:SetDirty()
				arg_841_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006201", "story_v_side_new_1105006.awb") ~= 0 then
					local var_844_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006201", "story_v_side_new_1105006.awb") / 1000

					if var_844_23 + var_844_15 > arg_841_1.duration_ then
						arg_841_1.duration_ = var_844_23 + var_844_15
					end

					if var_844_18.prefab_name ~= "" and arg_841_1.actors_[var_844_18.prefab_name] ~= nil then
						local var_844_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_841_1.actors_[var_844_18.prefab_name].transform, "story_v_side_new_1105006", "1105006201", "story_v_side_new_1105006.awb")

						arg_841_1:RecordAudio("1105006201", var_844_24)
						arg_841_1:RecordAudio("1105006201", var_844_24)
					else
						arg_841_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006201", "story_v_side_new_1105006.awb")
					end

					arg_841_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006201", "story_v_side_new_1105006.awb")
				end

				arg_841_1:RecordContent(arg_841_1.text_.text)
			end

			local var_844_25 = math.max(var_844_16, arg_841_1.talkMaxDuration)

			if var_844_15 <= arg_841_1.time_ and arg_841_1.time_ < var_844_15 + var_844_25 then
				arg_841_1.typewritter.percent = (arg_841_1.time_ - var_844_15) / var_844_25

				arg_841_1.typewritter:SetDirty()
			end

			if arg_841_1.time_ >= var_844_15 + var_844_25 and arg_841_1.time_ < var_844_15 + var_844_25 + arg_844_0 then
				arg_841_1.typewritter.percent = 1

				arg_841_1.typewritter:SetDirty()
				arg_841_1:ShowNextGo(true)
			end
		end

		arg_841_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_841_1:InitPlayNodeList()
	end,
	Play1105006202 = function(arg_845_0, arg_845_1)
		arg_845_1.time_ = 0
		arg_845_1.frameCnt_ = 0
		arg_845_1.state_ = "playing"
		arg_845_1.curTalkId_ = 1105006202
		arg_845_1.duration_ = 5.4

		SetActive(arg_845_1.tipsGo_, false)

		function arg_845_1.onSingleLineFinish_()
			arg_845_1.onSingleLineUpdate_ = nil
			arg_845_1.onSingleLineFinish_ = nil
			arg_845_1.state_ = "waiting"
		end

		function arg_845_1.playNext_(arg_847_0)
			if arg_847_0 == 1 then
				arg_845_0:Play1105006203(arg_845_1)
			end
		end

		function arg_845_1.onSingleLineUpdate_(arg_848_0)
			local var_848_0 = 0
			local var_848_1 = 0.6

			if var_848_0 < arg_845_1.time_ and arg_845_1.time_ <= var_848_0 + arg_848_0 then
				arg_845_1.talkMaxDuration = 0
				arg_845_1.dialogCg_.alpha = 1

				arg_845_1.dialog_:SetActive(true)
				SetActive(arg_845_1.leftNameGo_, true)

				local var_848_2 = arg_845_1:FormatText(StoryNameCfg[74].name)

				arg_845_1.leftNameTxt_.text = var_848_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_845_1.leftNameTxt_.transform)

				arg_845_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_845_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_845_1:RecordName(arg_845_1.leftNameTxt_.text)
				SetActive(arg_845_1.iconTrs_.gameObject, false)
				arg_845_1.callingController_:SetSelectedState("normal")

				local var_848_3 = arg_845_1:GetWordFromCfg(1105006202)
				local var_848_4 = arg_845_1:FormatText(var_848_3.content)

				arg_845_1.text_.text = var_848_4

				LuaForUtil.ClearLinePrefixSymbol(arg_845_1.text_)

				local var_848_5 = 24
				local var_848_6 = utf8.len(var_848_4)
				local var_848_7 = var_848_5 <= 0 and var_848_1 or var_848_1 * (var_848_6 / var_848_5)

				if var_848_7 > 0 and var_848_1 < var_848_7 then
					arg_845_1.talkMaxDuration = var_848_7

					if var_848_7 + var_848_0 > arg_845_1.duration_ then
						arg_845_1.duration_ = var_848_7 + var_848_0
					end
				end

				arg_845_1.text_.text = var_848_4
				arg_845_1.typewritter.percent = 0

				arg_845_1.typewritter:SetDirty()
				arg_845_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006202", "story_v_side_new_1105006.awb") ~= 0 then
					local var_848_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006202", "story_v_side_new_1105006.awb") / 1000

					if var_848_8 + var_848_0 > arg_845_1.duration_ then
						arg_845_1.duration_ = var_848_8 + var_848_0
					end

					if var_848_3.prefab_name ~= "" and arg_845_1.actors_[var_848_3.prefab_name] ~= nil then
						local var_848_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_845_1.actors_[var_848_3.prefab_name].transform, "story_v_side_new_1105006", "1105006202", "story_v_side_new_1105006.awb")

						arg_845_1:RecordAudio("1105006202", var_848_9)
						arg_845_1:RecordAudio("1105006202", var_848_9)
					else
						arg_845_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006202", "story_v_side_new_1105006.awb")
					end

					arg_845_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006202", "story_v_side_new_1105006.awb")
				end

				arg_845_1:RecordContent(arg_845_1.text_.text)
			end

			local var_848_10 = math.max(var_848_1, arg_845_1.talkMaxDuration)

			if var_848_0 <= arg_845_1.time_ and arg_845_1.time_ < var_848_0 + var_848_10 then
				arg_845_1.typewritter.percent = (arg_845_1.time_ - var_848_0) / var_848_10

				arg_845_1.typewritter:SetDirty()
			end

			if arg_845_1.time_ >= var_848_0 + var_848_10 and arg_845_1.time_ < var_848_0 + var_848_10 + arg_848_0 then
				arg_845_1.typewritter.percent = 1

				arg_845_1.typewritter:SetDirty()
				arg_845_1:ShowNextGo(true)
			end
		end

		arg_845_1.nodeConfigList_ = {}

		arg_845_1:InitPlayNodeList()
	end,
	Play1105006203 = function(arg_849_0, arg_849_1)
		arg_849_1.time_ = 0
		arg_849_1.frameCnt_ = 0
		arg_849_1.state_ = "playing"
		arg_849_1.curTalkId_ = 1105006203
		arg_849_1.duration_ = 3

		SetActive(arg_849_1.tipsGo_, false)

		function arg_849_1.onSingleLineFinish_()
			arg_849_1.onSingleLineUpdate_ = nil
			arg_849_1.onSingleLineFinish_ = nil
			arg_849_1.state_ = "waiting"
		end

		function arg_849_1.playNext_(arg_851_0)
			if arg_851_0 == 1 then
				arg_849_0:Play1105006204(arg_849_1)
			end
		end

		function arg_849_1.onSingleLineUpdate_(arg_852_0)
			local var_852_0 = 0
			local var_852_1 = 0.3

			if var_852_0 < arg_849_1.time_ and arg_849_1.time_ <= var_852_0 + arg_852_0 then
				arg_849_1.talkMaxDuration = 0
				arg_849_1.dialogCg_.alpha = 1

				arg_849_1.dialog_:SetActive(true)
				SetActive(arg_849_1.leftNameGo_, true)

				local var_852_2 = arg_849_1:FormatText(StoryNameCfg[74].name)

				arg_849_1.leftNameTxt_.text = var_852_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_849_1.leftNameTxt_.transform)

				arg_849_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_849_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_849_1:RecordName(arg_849_1.leftNameTxt_.text)
				SetActive(arg_849_1.iconTrs_.gameObject, false)
				arg_849_1.callingController_:SetSelectedState("normal")

				local var_852_3 = arg_849_1:GetWordFromCfg(1105006203)
				local var_852_4 = arg_849_1:FormatText(var_852_3.content)

				arg_849_1.text_.text = var_852_4

				LuaForUtil.ClearLinePrefixSymbol(arg_849_1.text_)

				local var_852_5 = 12
				local var_852_6 = utf8.len(var_852_4)
				local var_852_7 = var_852_5 <= 0 and var_852_1 or var_852_1 * (var_852_6 / var_852_5)

				if var_852_7 > 0 and var_852_1 < var_852_7 then
					arg_849_1.talkMaxDuration = var_852_7

					if var_852_7 + var_852_0 > arg_849_1.duration_ then
						arg_849_1.duration_ = var_852_7 + var_852_0
					end
				end

				arg_849_1.text_.text = var_852_4
				arg_849_1.typewritter.percent = 0

				arg_849_1.typewritter:SetDirty()
				arg_849_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006203", "story_v_side_new_1105006.awb") ~= 0 then
					local var_852_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006203", "story_v_side_new_1105006.awb") / 1000

					if var_852_8 + var_852_0 > arg_849_1.duration_ then
						arg_849_1.duration_ = var_852_8 + var_852_0
					end

					if var_852_3.prefab_name ~= "" and arg_849_1.actors_[var_852_3.prefab_name] ~= nil then
						local var_852_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_849_1.actors_[var_852_3.prefab_name].transform, "story_v_side_new_1105006", "1105006203", "story_v_side_new_1105006.awb")

						arg_849_1:RecordAudio("1105006203", var_852_9)
						arg_849_1:RecordAudio("1105006203", var_852_9)
					else
						arg_849_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006203", "story_v_side_new_1105006.awb")
					end

					arg_849_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006203", "story_v_side_new_1105006.awb")
				end

				arg_849_1:RecordContent(arg_849_1.text_.text)
			end

			local var_852_10 = math.max(var_852_1, arg_849_1.talkMaxDuration)

			if var_852_0 <= arg_849_1.time_ and arg_849_1.time_ < var_852_0 + var_852_10 then
				arg_849_1.typewritter.percent = (arg_849_1.time_ - var_852_0) / var_852_10

				arg_849_1.typewritter:SetDirty()
			end

			if arg_849_1.time_ >= var_852_0 + var_852_10 and arg_849_1.time_ < var_852_0 + var_852_10 + arg_852_0 then
				arg_849_1.typewritter.percent = 1

				arg_849_1.typewritter:SetDirty()
				arg_849_1:ShowNextGo(true)
			end
		end

		arg_849_1.nodeConfigList_ = {}

		arg_849_1:InitPlayNodeList()
	end,
	Play1105006204 = function(arg_853_0, arg_853_1)
		arg_853_1.time_ = 0
		arg_853_1.frameCnt_ = 0
		arg_853_1.state_ = "playing"
		arg_853_1.curTalkId_ = 1105006204
		arg_853_1.duration_ = 5

		SetActive(arg_853_1.tipsGo_, false)

		function arg_853_1.onSingleLineFinish_()
			arg_853_1.onSingleLineUpdate_ = nil
			arg_853_1.onSingleLineFinish_ = nil
			arg_853_1.state_ = "waiting"
		end

		function arg_853_1.playNext_(arg_855_0)
			if arg_855_0 == 1 then
				arg_853_0:Play1105006205(arg_853_1)
			end
		end

		function arg_853_1.onSingleLineUpdate_(arg_856_0)
			local var_856_0 = arg_853_1.actors_["1150ui_story"]
			local var_856_1 = 0

			if var_856_1 < arg_853_1.time_ and arg_853_1.time_ <= var_856_1 + arg_856_0 and not isNil(var_856_0) and arg_853_1.var_.characterEffect1150ui_story == nil then
				arg_853_1.var_.characterEffect1150ui_story = var_856_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_856_2 = 0.200000002980232

			if var_856_1 <= arg_853_1.time_ and arg_853_1.time_ < var_856_1 + var_856_2 and not isNil(var_856_0) then
				local var_856_3 = (arg_853_1.time_ - var_856_1) / var_856_2

				if arg_853_1.var_.characterEffect1150ui_story and not isNil(var_856_0) then
					local var_856_4 = Mathf.Lerp(0, 0.5, var_856_3)

					arg_853_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_853_1.var_.characterEffect1150ui_story.fillRatio = var_856_4
				end
			end

			if arg_853_1.time_ >= var_856_1 + var_856_2 and arg_853_1.time_ < var_856_1 + var_856_2 + arg_856_0 and not isNil(var_856_0) and arg_853_1.var_.characterEffect1150ui_story then
				local var_856_5 = 0.5

				arg_853_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_853_1.var_.characterEffect1150ui_story.fillRatio = var_856_5
			end

			local var_856_6 = 0
			local var_856_7 = 1.15

			if var_856_6 < arg_853_1.time_ and arg_853_1.time_ <= var_856_6 + arg_856_0 then
				arg_853_1.talkMaxDuration = 0
				arg_853_1.dialogCg_.alpha = 1

				arg_853_1.dialog_:SetActive(true)
				SetActive(arg_853_1.leftNameGo_, false)

				arg_853_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_853_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_853_1:RecordName(arg_853_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_853_1.iconTrs_.gameObject, false)
				arg_853_1.callingController_:SetSelectedState("normal")

				local var_856_8 = arg_853_1:GetWordFromCfg(1105006204)
				local var_856_9 = arg_853_1:FormatText(var_856_8.content)

				arg_853_1.text_.text = var_856_9

				LuaForUtil.ClearLinePrefixSymbol(arg_853_1.text_)

				local var_856_10 = 46
				local var_856_11 = utf8.len(var_856_9)
				local var_856_12 = var_856_10 <= 0 and var_856_7 or var_856_7 * (var_856_11 / var_856_10)

				if var_856_12 > 0 and var_856_7 < var_856_12 then
					arg_853_1.talkMaxDuration = var_856_12

					if var_856_12 + var_856_6 > arg_853_1.duration_ then
						arg_853_1.duration_ = var_856_12 + var_856_6
					end
				end

				arg_853_1.text_.text = var_856_9
				arg_853_1.typewritter.percent = 0

				arg_853_1.typewritter:SetDirty()
				arg_853_1:ShowNextGo(false)
				arg_853_1:RecordContent(arg_853_1.text_.text)
			end

			local var_856_13 = math.max(var_856_7, arg_853_1.talkMaxDuration)

			if var_856_6 <= arg_853_1.time_ and arg_853_1.time_ < var_856_6 + var_856_13 then
				arg_853_1.typewritter.percent = (arg_853_1.time_ - var_856_6) / var_856_13

				arg_853_1.typewritter:SetDirty()
			end

			if arg_853_1.time_ >= var_856_6 + var_856_13 and arg_853_1.time_ < var_856_6 + var_856_13 + arg_856_0 then
				arg_853_1.typewritter.percent = 1

				arg_853_1.typewritter:SetDirty()
				arg_853_1:ShowNextGo(true)
			end
		end

		arg_853_1.nodeConfigList_ = {}

		arg_853_1:InitPlayNodeList()
	end,
	Play1105006205 = function(arg_857_0, arg_857_1)
		arg_857_1.time_ = 0
		arg_857_1.frameCnt_ = 0
		arg_857_1.state_ = "playing"
		arg_857_1.curTalkId_ = 1105006205
		arg_857_1.duration_ = 12.37

		SetActive(arg_857_1.tipsGo_, false)

		function arg_857_1.onSingleLineFinish_()
			arg_857_1.onSingleLineUpdate_ = nil
			arg_857_1.onSingleLineFinish_ = nil
			arg_857_1.state_ = "waiting"
		end

		function arg_857_1.playNext_(arg_859_0)
			if arg_859_0 == 1 then
				arg_857_0:Play1105006206(arg_857_1)
			end
		end

		function arg_857_1.onSingleLineUpdate_(arg_860_0)
			local var_860_0 = arg_857_1.actors_["1150ui_story"]
			local var_860_1 = 0

			if var_860_1 < arg_857_1.time_ and arg_857_1.time_ <= var_860_1 + arg_860_0 and not isNil(var_860_0) and arg_857_1.var_.characterEffect1150ui_story == nil then
				arg_857_1.var_.characterEffect1150ui_story = var_860_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_860_2 = 0.200000002980232

			if var_860_1 <= arg_857_1.time_ and arg_857_1.time_ < var_860_1 + var_860_2 and not isNil(var_860_0) then
				local var_860_3 = (arg_857_1.time_ - var_860_1) / var_860_2

				if arg_857_1.var_.characterEffect1150ui_story and not isNil(var_860_0) then
					arg_857_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_857_1.time_ >= var_860_1 + var_860_2 and arg_857_1.time_ < var_860_1 + var_860_2 + arg_860_0 and not isNil(var_860_0) and arg_857_1.var_.characterEffect1150ui_story then
				arg_857_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_860_4 = 0

			if var_860_4 < arg_857_1.time_ and arg_857_1.time_ <= var_860_4 + arg_860_0 then
				arg_857_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_860_5 = 0

			if var_860_5 < arg_857_1.time_ and arg_857_1.time_ <= var_860_5 + arg_860_0 then
				arg_857_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_860_6 = 0
			local var_860_7 = 1.175

			if var_860_6 < arg_857_1.time_ and arg_857_1.time_ <= var_860_6 + arg_860_0 then
				arg_857_1.talkMaxDuration = 0
				arg_857_1.dialogCg_.alpha = 1

				arg_857_1.dialog_:SetActive(true)
				SetActive(arg_857_1.leftNameGo_, true)

				local var_860_8 = arg_857_1:FormatText(StoryNameCfg[74].name)

				arg_857_1.leftNameTxt_.text = var_860_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_857_1.leftNameTxt_.transform)

				arg_857_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_857_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_857_1:RecordName(arg_857_1.leftNameTxt_.text)
				SetActive(arg_857_1.iconTrs_.gameObject, false)
				arg_857_1.callingController_:SetSelectedState("normal")

				local var_860_9 = arg_857_1:GetWordFromCfg(1105006205)
				local var_860_10 = arg_857_1:FormatText(var_860_9.content)

				arg_857_1.text_.text = var_860_10

				LuaForUtil.ClearLinePrefixSymbol(arg_857_1.text_)

				local var_860_11 = 47
				local var_860_12 = utf8.len(var_860_10)
				local var_860_13 = var_860_11 <= 0 and var_860_7 or var_860_7 * (var_860_12 / var_860_11)

				if var_860_13 > 0 and var_860_7 < var_860_13 then
					arg_857_1.talkMaxDuration = var_860_13

					if var_860_13 + var_860_6 > arg_857_1.duration_ then
						arg_857_1.duration_ = var_860_13 + var_860_6
					end
				end

				arg_857_1.text_.text = var_860_10
				arg_857_1.typewritter.percent = 0

				arg_857_1.typewritter:SetDirty()
				arg_857_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006205", "story_v_side_new_1105006.awb") ~= 0 then
					local var_860_14 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006205", "story_v_side_new_1105006.awb") / 1000

					if var_860_14 + var_860_6 > arg_857_1.duration_ then
						arg_857_1.duration_ = var_860_14 + var_860_6
					end

					if var_860_9.prefab_name ~= "" and arg_857_1.actors_[var_860_9.prefab_name] ~= nil then
						local var_860_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_857_1.actors_[var_860_9.prefab_name].transform, "story_v_side_new_1105006", "1105006205", "story_v_side_new_1105006.awb")

						arg_857_1:RecordAudio("1105006205", var_860_15)
						arg_857_1:RecordAudio("1105006205", var_860_15)
					else
						arg_857_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006205", "story_v_side_new_1105006.awb")
					end

					arg_857_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006205", "story_v_side_new_1105006.awb")
				end

				arg_857_1:RecordContent(arg_857_1.text_.text)
			end

			local var_860_16 = math.max(var_860_7, arg_857_1.talkMaxDuration)

			if var_860_6 <= arg_857_1.time_ and arg_857_1.time_ < var_860_6 + var_860_16 then
				arg_857_1.typewritter.percent = (arg_857_1.time_ - var_860_6) / var_860_16

				arg_857_1.typewritter:SetDirty()
			end

			if arg_857_1.time_ >= var_860_6 + var_860_16 and arg_857_1.time_ < var_860_6 + var_860_16 + arg_860_0 then
				arg_857_1.typewritter.percent = 1

				arg_857_1.typewritter:SetDirty()
				arg_857_1:ShowNextGo(true)
			end
		end

		arg_857_1.nodeConfigList_ = {}

		arg_857_1:InitPlayNodeList()
	end,
	Play1105006206 = function(arg_861_0, arg_861_1)
		arg_861_1.time_ = 0
		arg_861_1.frameCnt_ = 0
		arg_861_1.state_ = "playing"
		arg_861_1.curTalkId_ = 1105006206
		arg_861_1.duration_ = 1

		SetActive(arg_861_1.tipsGo_, false)

		function arg_861_1.onSingleLineFinish_()
			arg_861_1.onSingleLineUpdate_ = nil
			arg_861_1.onSingleLineFinish_ = nil
			arg_861_1.state_ = "waiting"

			SetActive(arg_861_1.choicesGo_, true)

			for iter_862_0, iter_862_1 in ipairs(arg_861_1.choices_) do
				local var_862_0 = iter_862_0 <= 1

				SetActive(iter_862_1.go, var_862_0)
			end

			arg_861_1.choices_[1].txt.text = arg_861_1:FormatText(StoryChoiceCfg[1070].name)
		end

		function arg_861_1.playNext_(arg_863_0)
			if arg_863_0 == 1 then
				arg_861_0:Play1105006207(arg_861_1)
			end

			arg_861_1:RecordChoiceLog(1105006206, 1070)
		end

		function arg_861_1.onSingleLineUpdate_(arg_864_0)
			local var_864_0 = 0

			if var_864_0 < arg_861_1.time_ and arg_861_1.time_ <= var_864_0 + arg_864_0 then
				arg_861_1.allBtn_.enabled = false
			end

			local var_864_1 = 0.6

			if arg_861_1.time_ >= var_864_0 + var_864_1 and arg_861_1.time_ < var_864_0 + var_864_1 + arg_864_0 then
				arg_861_1.allBtn_.enabled = true
			end
		end

		arg_861_1.nodeConfigList_ = {}

		arg_861_1:InitPlayNodeList()
	end,
	Play1105006207 = function(arg_865_0, arg_865_1)
		arg_865_1.time_ = 0
		arg_865_1.frameCnt_ = 0
		arg_865_1.state_ = "playing"
		arg_865_1.curTalkId_ = 1105006207
		arg_865_1.duration_ = 5

		SetActive(arg_865_1.tipsGo_, false)

		function arg_865_1.onSingleLineFinish_()
			arg_865_1.onSingleLineUpdate_ = nil
			arg_865_1.onSingleLineFinish_ = nil
			arg_865_1.state_ = "waiting"
		end

		function arg_865_1.playNext_(arg_867_0)
			if arg_867_0 == 1 then
				arg_865_0:Play1105006208(arg_865_1)
			end
		end

		function arg_865_1.onSingleLineUpdate_(arg_868_0)
			local var_868_0 = arg_865_1.actors_["1150ui_story"].transform
			local var_868_1 = 0

			if var_868_1 < arg_865_1.time_ and arg_865_1.time_ <= var_868_1 + arg_868_0 then
				arg_865_1.var_.moveOldPos1150ui_story = var_868_0.localPosition
			end

			local var_868_2 = 0.001

			if var_868_1 <= arg_865_1.time_ and arg_865_1.time_ < var_868_1 + var_868_2 then
				local var_868_3 = (arg_865_1.time_ - var_868_1) / var_868_2
				local var_868_4 = Vector3.New(0, 100, 0)

				var_868_0.localPosition = Vector3.Lerp(arg_865_1.var_.moveOldPos1150ui_story, var_868_4, var_868_3)

				local var_868_5 = manager.ui.mainCamera.transform.position - var_868_0.position

				var_868_0.forward = Vector3.New(var_868_5.x, var_868_5.y, var_868_5.z)

				local var_868_6 = var_868_0.localEulerAngles

				var_868_6.z = 0
				var_868_6.x = 0
				var_868_0.localEulerAngles = var_868_6
			end

			if arg_865_1.time_ >= var_868_1 + var_868_2 and arg_865_1.time_ < var_868_1 + var_868_2 + arg_868_0 then
				var_868_0.localPosition = Vector3.New(0, 100, 0)

				local var_868_7 = manager.ui.mainCamera.transform.position - var_868_0.position

				var_868_0.forward = Vector3.New(var_868_7.x, var_868_7.y, var_868_7.z)

				local var_868_8 = var_868_0.localEulerAngles

				var_868_8.z = 0
				var_868_8.x = 0
				var_868_0.localEulerAngles = var_868_8
			end

			local var_868_9 = 0
			local var_868_10 = 0.675

			if var_868_9 < arg_865_1.time_ and arg_865_1.time_ <= var_868_9 + arg_868_0 then
				arg_865_1.talkMaxDuration = 0
				arg_865_1.dialogCg_.alpha = 1

				arg_865_1.dialog_:SetActive(true)
				SetActive(arg_865_1.leftNameGo_, false)

				arg_865_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_865_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_865_1:RecordName(arg_865_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_865_1.iconTrs_.gameObject, false)
				arg_865_1.callingController_:SetSelectedState("normal")

				local var_868_11 = arg_865_1:GetWordFromCfg(1105006207)
				local var_868_12 = arg_865_1:FormatText(var_868_11.content)

				arg_865_1.text_.text = var_868_12

				LuaForUtil.ClearLinePrefixSymbol(arg_865_1.text_)

				local var_868_13 = 27
				local var_868_14 = utf8.len(var_868_12)
				local var_868_15 = var_868_13 <= 0 and var_868_10 or var_868_10 * (var_868_14 / var_868_13)

				if var_868_15 > 0 and var_868_10 < var_868_15 then
					arg_865_1.talkMaxDuration = var_868_15

					if var_868_15 + var_868_9 > arg_865_1.duration_ then
						arg_865_1.duration_ = var_868_15 + var_868_9
					end
				end

				arg_865_1.text_.text = var_868_12
				arg_865_1.typewritter.percent = 0

				arg_865_1.typewritter:SetDirty()
				arg_865_1:ShowNextGo(false)
				arg_865_1:RecordContent(arg_865_1.text_.text)
			end

			local var_868_16 = math.max(var_868_10, arg_865_1.talkMaxDuration)

			if var_868_9 <= arg_865_1.time_ and arg_865_1.time_ < var_868_9 + var_868_16 then
				arg_865_1.typewritter.percent = (arg_865_1.time_ - var_868_9) / var_868_16

				arg_865_1.typewritter:SetDirty()
			end

			if arg_865_1.time_ >= var_868_9 + var_868_16 and arg_865_1.time_ < var_868_9 + var_868_16 + arg_868_0 then
				arg_865_1.typewritter.percent = 1

				arg_865_1.typewritter:SetDirty()
				arg_865_1:ShowNextGo(true)
			end
		end

		arg_865_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_865_1:InitPlayNodeList()
	end,
	Play1105006208 = function(arg_869_0, arg_869_1)
		arg_869_1.time_ = 0
		arg_869_1.frameCnt_ = 0
		arg_869_1.state_ = "playing"
		arg_869_1.curTalkId_ = 1105006208
		arg_869_1.duration_ = 5.13

		SetActive(arg_869_1.tipsGo_, false)

		function arg_869_1.onSingleLineFinish_()
			arg_869_1.onSingleLineUpdate_ = nil
			arg_869_1.onSingleLineFinish_ = nil
			arg_869_1.state_ = "waiting"
			arg_869_1.auto_ = false
		end

		function arg_869_1.playNext_(arg_871_0)
			arg_869_1.onStoryFinished_()
		end

		function arg_869_1.onSingleLineUpdate_(arg_872_0)
			local var_872_0 = arg_869_1.actors_["1150ui_story"].transform
			local var_872_1 = 0

			if var_872_1 < arg_869_1.time_ and arg_869_1.time_ <= var_872_1 + arg_872_0 then
				arg_869_1.var_.moveOldPos1150ui_story = var_872_0.localPosition
			end

			local var_872_2 = 0.001

			if var_872_1 <= arg_869_1.time_ and arg_869_1.time_ < var_872_1 + var_872_2 then
				local var_872_3 = (arg_869_1.time_ - var_872_1) / var_872_2
				local var_872_4 = Vector3.New(0, -1.01, -6.2)

				var_872_0.localPosition = Vector3.Lerp(arg_869_1.var_.moveOldPos1150ui_story, var_872_4, var_872_3)

				local var_872_5 = manager.ui.mainCamera.transform.position - var_872_0.position

				var_872_0.forward = Vector3.New(var_872_5.x, var_872_5.y, var_872_5.z)

				local var_872_6 = var_872_0.localEulerAngles

				var_872_6.z = 0
				var_872_6.x = 0
				var_872_0.localEulerAngles = var_872_6
			end

			if arg_869_1.time_ >= var_872_1 + var_872_2 and arg_869_1.time_ < var_872_1 + var_872_2 + arg_872_0 then
				var_872_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_872_7 = manager.ui.mainCamera.transform.position - var_872_0.position

				var_872_0.forward = Vector3.New(var_872_7.x, var_872_7.y, var_872_7.z)

				local var_872_8 = var_872_0.localEulerAngles

				var_872_8.z = 0
				var_872_8.x = 0
				var_872_0.localEulerAngles = var_872_8
			end

			local var_872_9 = arg_869_1.actors_["1150ui_story"]
			local var_872_10 = 0

			if var_872_10 < arg_869_1.time_ and arg_869_1.time_ <= var_872_10 + arg_872_0 and not isNil(var_872_9) and arg_869_1.var_.characterEffect1150ui_story == nil then
				arg_869_1.var_.characterEffect1150ui_story = var_872_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_872_11 = 0.200000002980232

			if var_872_10 <= arg_869_1.time_ and arg_869_1.time_ < var_872_10 + var_872_11 and not isNil(var_872_9) then
				local var_872_12 = (arg_869_1.time_ - var_872_10) / var_872_11

				if arg_869_1.var_.characterEffect1150ui_story and not isNil(var_872_9) then
					arg_869_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_869_1.time_ >= var_872_10 + var_872_11 and arg_869_1.time_ < var_872_10 + var_872_11 + arg_872_0 and not isNil(var_872_9) and arg_869_1.var_.characterEffect1150ui_story then
				arg_869_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_872_13 = 0

			if var_872_13 < arg_869_1.time_ and arg_869_1.time_ <= var_872_13 + arg_872_0 then
				arg_869_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_872_14 = 0

			if var_872_14 < arg_869_1.time_ and arg_869_1.time_ <= var_872_14 + arg_872_0 then
				arg_869_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_872_15 = 0
			local var_872_16 = 0.45

			if var_872_15 < arg_869_1.time_ and arg_869_1.time_ <= var_872_15 + arg_872_0 then
				arg_869_1.talkMaxDuration = 0
				arg_869_1.dialogCg_.alpha = 1

				arg_869_1.dialog_:SetActive(true)
				SetActive(arg_869_1.leftNameGo_, true)

				local var_872_17 = arg_869_1:FormatText(StoryNameCfg[74].name)

				arg_869_1.leftNameTxt_.text = var_872_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_869_1.leftNameTxt_.transform)

				arg_869_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_869_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_869_1:RecordName(arg_869_1.leftNameTxt_.text)
				SetActive(arg_869_1.iconTrs_.gameObject, false)
				arg_869_1.callingController_:SetSelectedState("normal")

				local var_872_18 = arg_869_1:GetWordFromCfg(1105006208)
				local var_872_19 = arg_869_1:FormatText(var_872_18.content)

				arg_869_1.text_.text = var_872_19

				LuaForUtil.ClearLinePrefixSymbol(arg_869_1.text_)

				local var_872_20 = 18
				local var_872_21 = utf8.len(var_872_19)
				local var_872_22 = var_872_20 <= 0 and var_872_16 or var_872_16 * (var_872_21 / var_872_20)

				if var_872_22 > 0 and var_872_16 < var_872_22 then
					arg_869_1.talkMaxDuration = var_872_22

					if var_872_22 + var_872_15 > arg_869_1.duration_ then
						arg_869_1.duration_ = var_872_22 + var_872_15
					end
				end

				arg_869_1.text_.text = var_872_19
				arg_869_1.typewritter.percent = 0

				arg_869_1.typewritter:SetDirty()
				arg_869_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006208", "story_v_side_new_1105006.awb") ~= 0 then
					local var_872_23 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006208", "story_v_side_new_1105006.awb") / 1000

					if var_872_23 + var_872_15 > arg_869_1.duration_ then
						arg_869_1.duration_ = var_872_23 + var_872_15
					end

					if var_872_18.prefab_name ~= "" and arg_869_1.actors_[var_872_18.prefab_name] ~= nil then
						local var_872_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_869_1.actors_[var_872_18.prefab_name].transform, "story_v_side_new_1105006", "1105006208", "story_v_side_new_1105006.awb")

						arg_869_1:RecordAudio("1105006208", var_872_24)
						arg_869_1:RecordAudio("1105006208", var_872_24)
					else
						arg_869_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006208", "story_v_side_new_1105006.awb")
					end

					arg_869_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006208", "story_v_side_new_1105006.awb")
				end

				arg_869_1:RecordContent(arg_869_1.text_.text)
			end

			local var_872_25 = math.max(var_872_16, arg_869_1.talkMaxDuration)

			if var_872_15 <= arg_869_1.time_ and arg_869_1.time_ < var_872_15 + var_872_25 then
				arg_869_1.typewritter.percent = (arg_869_1.time_ - var_872_15) / var_872_25

				arg_869_1.typewritter:SetDirty()
			end

			if arg_869_1.time_ >= var_872_15 + var_872_25 and arg_869_1.time_ < var_872_15 + var_872_25 + arg_872_0 then
				arg_869_1.typewritter.percent = 1

				arg_869_1.typewritter:SetDirty()
				arg_869_1:ShowNextGo(true)
			end
		end

		arg_869_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_869_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST16",
		"TextureConfig/Background/ST11",
		"TextureConfig/Background/ST01a",
		"TextureConfig/Background/R5002",
		"TextureConfig/Background/R5002a",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_side_new_1105006.awb"
	}
}
