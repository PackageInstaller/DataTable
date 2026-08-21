return {
	Play112211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112211001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "H02a"

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
				local var_4_5 = arg_1_1.bgs_.H02a

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
					if iter_4_0 ~= "H02a" then
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
				local var_4_19 = Color.New(0.0471698, 0.04650231, 0.04650231)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0.0471698, 0.04650231, 0.04650231)
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

				arg_1_1:AudioAction(var_4_28, var_4_29, "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

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

			local var_4_32 = 2
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "effect"

				arg_1_1:AudioAction(var_4_34, var_4_35, "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 2
			local var_4_37 = 0.925

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_39 = arg_1_1:GetWordFromCfg(112211001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 37
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
	Play112211002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 112211002
		arg_8_1.duration_ = 5.5

		local var_8_0 = {
			ja = 4.5,
			ko = 4.466,
			zh = 4.866,
			en = 5.5
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
				arg_8_0:Play112211003(arg_8_1)
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

				local var_11_7 = "1039ui_story"

				arg_8_1:ShowWeapon(arg_8_1.var_[var_11_7 .. "Animator"].transform, false)
			end

			local var_11_8 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_8 then
				local var_11_9 = (arg_8_1.time_ - var_11_6) / var_11_8
				local var_11_10 = Vector3.New(0, -1.01, -5.9)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1039ui_story, var_11_10, var_11_9)

				local var_11_11 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_11.x, var_11_11.y, var_11_11.z)

				local var_11_12 = var_11_5.localEulerAngles

				var_11_12.z = 0
				var_11_12.x = 0
				var_11_5.localEulerAngles = var_11_12
			end

			if arg_8_1.time_ >= var_11_6 + var_11_8 and arg_8_1.time_ < var_11_6 + var_11_8 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_11_13 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_13.x, var_11_13.y, var_11_13.z)

				local var_11_14 = var_11_5.localEulerAngles

				var_11_14.z = 0
				var_11_14.x = 0
				var_11_5.localEulerAngles = var_11_14
			end

			local var_11_15 = arg_8_1.actors_["1039ui_story"]
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 and not isNil(var_11_15) and arg_8_1.var_.characterEffect1039ui_story == nil then
				arg_8_1.var_.characterEffect1039ui_story = var_11_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_17 = 0.2

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 and not isNil(var_11_15) then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17

				if arg_8_1.var_.characterEffect1039ui_story and not isNil(var_11_15) then
					arg_8_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 and not isNil(var_11_15) and arg_8_1.var_.characterEffect1039ui_story then
				arg_8_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			local var_11_20 = 0

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_11_21 = 0
			local var_11_22 = 0.475

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_23 = arg_8_1:FormatText(StoryNameCfg[9].name)

				arg_8_1.leftNameTxt_.text = var_11_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_24 = arg_8_1:GetWordFromCfg(112211002)
				local var_11_25 = arg_8_1:FormatText(var_11_24.content)

				arg_8_1.text_.text = var_11_25

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_26 = 19
				local var_11_27 = utf8.len(var_11_25)
				local var_11_28 = var_11_26 <= 0 and var_11_22 or var_11_22 * (var_11_27 / var_11_26)

				if var_11_28 > 0 and var_11_22 < var_11_28 then
					arg_8_1.talkMaxDuration = var_11_28

					if var_11_28 + var_11_21 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_21
					end
				end

				arg_8_1.text_.text = var_11_25
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211002", "story_v_out_112211.awb") ~= 0 then
					local var_11_29 = manager.audio:GetVoiceLength("story_v_out_112211", "112211002", "story_v_out_112211.awb") / 1000

					if var_11_29 + var_11_21 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_29 + var_11_21
					end

					if var_11_24.prefab_name ~= "" and arg_8_1.actors_[var_11_24.prefab_name] ~= nil then
						local var_11_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_24.prefab_name].transform, "story_v_out_112211", "112211002", "story_v_out_112211.awb")

						arg_8_1:RecordAudio("112211002", var_11_30)
						arg_8_1:RecordAudio("112211002", var_11_30)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_112211", "112211002", "story_v_out_112211.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_112211", "112211002", "story_v_out_112211.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_31 = math.max(var_11_22, arg_8_1.talkMaxDuration)

			if var_11_21 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_31 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_21) / var_11_31

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_21 + var_11_31 and arg_8_1.time_ < var_11_21 + var_11_31 + arg_11_0 then
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
	Play112211003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 112211003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play112211004(arg_12_1)
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

			local var_15_6 = 0
			local var_15_7 = 0.55

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(112211003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 22
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play112211004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 112211004
		arg_16_1.duration_ = 4.23

		local var_16_0 = {
			ja = 3.433,
			ko = 4.233,
			zh = 2.766,
			en = 3.3
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
				arg_16_0:Play112211005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1039ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos1039ui_story = var_19_0.localPosition
			end

			local var_19_2 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2
				local var_19_4 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1039ui_story, var_19_4, var_19_3)

				local var_19_5 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_5.x, var_19_5.y, var_19_5.z)

				local var_19_6 = var_19_0.localEulerAngles

				var_19_6.z = 0
				var_19_6.x = 0
				var_19_0.localEulerAngles = var_19_6
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

				local var_19_7 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_7.x, var_19_7.y, var_19_7.z)

				local var_19_8 = var_19_0.localEulerAngles

				var_19_8.z = 0
				var_19_8.x = 0
				var_19_0.localEulerAngles = var_19_8
			end

			local var_19_9 = "1027ui_story"

			if arg_16_1.actors_[var_19_9] == nil then
				local var_19_10 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_19_10) then
					local var_19_11 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_16_1.stage_.transform)

					var_19_11.name = var_19_9
					var_19_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_9] = var_19_11

					local var_19_12 = var_19_11:GetComponentInChildren(typeof(CharacterEffect))

					var_19_12.enabled = true

					local var_19_13 = GameObjectTools.GetOrAddComponent(var_19_11, typeof(DynamicBoneHelper))

					if var_19_13 then
						var_19_13:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_12.transform, false)

					arg_16_1.var_[var_19_9 .. "Animator"] = var_19_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_9 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_9 .. "LipSync"] = var_19_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_14 = arg_16_1.actors_["1027ui_story"].transform
			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.var_.moveOldPos1027ui_story = var_19_14.localPosition

				local var_19_16 = "1027ui_story"

				arg_16_1:ShowWeapon(arg_16_1.var_[var_19_16 .. "Animator"].transform, false)
			end

			local var_19_17 = 0.001

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_17 then
				local var_19_18 = (arg_16_1.time_ - var_19_15) / var_19_17
				local var_19_19 = Vector3.New(0, -0.81, -5.8)

				var_19_14.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1027ui_story, var_19_19, var_19_18)

				local var_19_20 = manager.ui.mainCamera.transform.position - var_19_14.position

				var_19_14.forward = Vector3.New(var_19_20.x, var_19_20.y, var_19_20.z)

				local var_19_21 = var_19_14.localEulerAngles

				var_19_21.z = 0
				var_19_21.x = 0
				var_19_14.localEulerAngles = var_19_21
			end

			if arg_16_1.time_ >= var_19_15 + var_19_17 and arg_16_1.time_ < var_19_15 + var_19_17 + arg_19_0 then
				var_19_14.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_19_22 = manager.ui.mainCamera.transform.position - var_19_14.position

				var_19_14.forward = Vector3.New(var_19_22.x, var_19_22.y, var_19_22.z)

				local var_19_23 = var_19_14.localEulerAngles

				var_19_23.z = 0
				var_19_23.x = 0
				var_19_14.localEulerAngles = var_19_23
			end

			local var_19_24 = arg_16_1.actors_["1027ui_story"]
			local var_19_25 = 0

			if var_19_25 < arg_16_1.time_ and arg_16_1.time_ <= var_19_25 + arg_19_0 and not isNil(var_19_24) and arg_16_1.var_.characterEffect1027ui_story == nil then
				arg_16_1.var_.characterEffect1027ui_story = var_19_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_26 = 0.2

			if var_19_25 <= arg_16_1.time_ and arg_16_1.time_ < var_19_25 + var_19_26 and not isNil(var_19_24) then
				local var_19_27 = (arg_16_1.time_ - var_19_25) / var_19_26

				if arg_16_1.var_.characterEffect1027ui_story and not isNil(var_19_24) then
					arg_16_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_25 + var_19_26 and arg_16_1.time_ < var_19_25 + var_19_26 + arg_19_0 and not isNil(var_19_24) and arg_16_1.var_.characterEffect1027ui_story then
				arg_16_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_19_28 = 0

			if var_19_28 < arg_16_1.time_ and arg_16_1.time_ <= var_19_28 + arg_19_0 then
				arg_16_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_1")
			end

			local var_19_29 = 0

			if var_19_29 < arg_16_1.time_ and arg_16_1.time_ <= var_19_29 + arg_19_0 then
				arg_16_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_19_30 = 0
			local var_19_31 = 0.35

			if var_19_30 < arg_16_1.time_ and arg_16_1.time_ <= var_19_30 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_32 = arg_16_1:FormatText(StoryNameCfg[56].name)

				arg_16_1.leftNameTxt_.text = var_19_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_33 = arg_16_1:GetWordFromCfg(112211004)
				local var_19_34 = arg_16_1:FormatText(var_19_33.content)

				arg_16_1.text_.text = var_19_34

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_35 = 14
				local var_19_36 = utf8.len(var_19_34)
				local var_19_37 = var_19_35 <= 0 and var_19_31 or var_19_31 * (var_19_36 / var_19_35)

				if var_19_37 > 0 and var_19_31 < var_19_37 then
					arg_16_1.talkMaxDuration = var_19_37

					if var_19_37 + var_19_30 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_37 + var_19_30
					end
				end

				arg_16_1.text_.text = var_19_34
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211004", "story_v_out_112211.awb") ~= 0 then
					local var_19_38 = manager.audio:GetVoiceLength("story_v_out_112211", "112211004", "story_v_out_112211.awb") / 1000

					if var_19_38 + var_19_30 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_38 + var_19_30
					end

					if var_19_33.prefab_name ~= "" and arg_16_1.actors_[var_19_33.prefab_name] ~= nil then
						local var_19_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_33.prefab_name].transform, "story_v_out_112211", "112211004", "story_v_out_112211.awb")

						arg_16_1:RecordAudio("112211004", var_19_39)
						arg_16_1:RecordAudio("112211004", var_19_39)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_112211", "112211004", "story_v_out_112211.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_112211", "112211004", "story_v_out_112211.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_40 = math.max(var_19_31, arg_16_1.talkMaxDuration)

			if var_19_30 <= arg_16_1.time_ and arg_16_1.time_ < var_19_30 + var_19_40 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_30) / var_19_40

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_30 + var_19_40 and arg_16_1.time_ < var_19_30 + var_19_40 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play112211005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 112211005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play112211006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1027ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1027ui_story == nil then
				arg_20_1.var_.characterEffect1027ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1027ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1027ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1027ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1027ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.175

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(112211005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 7
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
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play112211006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 112211006
		arg_24_1.duration_ = 14.2

		local var_24_0 = {
			ja = 11.4,
			ko = 8.6,
			zh = 11.333,
			en = 14.2
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
				arg_24_0:Play112211007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1027ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1027ui_story == nil then
				arg_24_1.var_.characterEffect1027ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1027ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1027ui_story then
				arg_24_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_27_4 = 0

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action474")
			end

			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_27_6 = 0
			local var_27_7 = 1

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[56].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_9 = arg_24_1:GetWordFromCfg(112211006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211006", "story_v_out_112211.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211006", "story_v_out_112211.awb") / 1000

					if var_27_14 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_6
					end

					if var_27_9.prefab_name ~= "" and arg_24_1.actors_[var_27_9.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_9.prefab_name].transform, "story_v_out_112211", "112211006", "story_v_out_112211.awb")

						arg_24_1:RecordAudio("112211006", var_27_15)
						arg_24_1:RecordAudio("112211006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_112211", "112211006", "story_v_out_112211.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_112211", "112211006", "story_v_out_112211.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_16 and arg_24_1.time_ < var_27_6 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play112211007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 112211007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play112211008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1027ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1027ui_story == nil then
				arg_28_1.var_.characterEffect1027ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1027ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1027ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1027ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1027ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.075

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_9 = arg_28_1:GetWordFromCfg(112211007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 3
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
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_14 and arg_28_1.time_ < var_31_6 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play112211008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 112211008
		arg_32_1.duration_ = 4.6

		local var_32_0 = {
			ja = 4.333,
			ko = 4.233,
			zh = 3.366,
			en = 4.6
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
				arg_32_0:Play112211009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1027ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1027ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1027ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, 100, 0)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = "1148ui_story"

			if arg_32_1.actors_[var_35_9] == nil then
				local var_35_10 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_35_10) then
					local var_35_11 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_32_1.stage_.transform)

					var_35_11.name = var_35_9
					var_35_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_9] = var_35_11

					local var_35_12 = var_35_11:GetComponentInChildren(typeof(CharacterEffect))

					var_35_12.enabled = true

					local var_35_13 = GameObjectTools.GetOrAddComponent(var_35_11, typeof(DynamicBoneHelper))

					if var_35_13 then
						var_35_13:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_12.transform, false)

					arg_32_1.var_[var_35_9 .. "Animator"] = var_35_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_9 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_9 .. "LipSync"] = var_35_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_14 = arg_32_1.actors_["1148ui_story"].transform
			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.var_.moveOldPos1148ui_story = var_35_14.localPosition

				local var_35_16 = "1148ui_story"

				arg_32_1:ShowWeapon(arg_32_1.var_[var_35_16 .. "Animator"].transform, false)
			end

			local var_35_17 = 0.001

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_17 then
				local var_35_18 = (arg_32_1.time_ - var_35_15) / var_35_17
				local var_35_19 = Vector3.New(0, -0.8, -6.2)

				var_35_14.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1148ui_story, var_35_19, var_35_18)

				local var_35_20 = manager.ui.mainCamera.transform.position - var_35_14.position

				var_35_14.forward = Vector3.New(var_35_20.x, var_35_20.y, var_35_20.z)

				local var_35_21 = var_35_14.localEulerAngles

				var_35_21.z = 0
				var_35_21.x = 0
				var_35_14.localEulerAngles = var_35_21
			end

			if arg_32_1.time_ >= var_35_15 + var_35_17 and arg_32_1.time_ < var_35_15 + var_35_17 + arg_35_0 then
				var_35_14.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_35_22 = manager.ui.mainCamera.transform.position - var_35_14.position

				var_35_14.forward = Vector3.New(var_35_22.x, var_35_22.y, var_35_22.z)

				local var_35_23 = var_35_14.localEulerAngles

				var_35_23.z = 0
				var_35_23.x = 0
				var_35_14.localEulerAngles = var_35_23
			end

			local var_35_24 = arg_32_1.actors_["1148ui_story"]
			local var_35_25 = 0

			if var_35_25 < arg_32_1.time_ and arg_32_1.time_ <= var_35_25 + arg_35_0 and not isNil(var_35_24) and arg_32_1.var_.characterEffect1148ui_story == nil then
				arg_32_1.var_.characterEffect1148ui_story = var_35_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_26 = 0.2

			if var_35_25 <= arg_32_1.time_ and arg_32_1.time_ < var_35_25 + var_35_26 and not isNil(var_35_24) then
				local var_35_27 = (arg_32_1.time_ - var_35_25) / var_35_26

				if arg_32_1.var_.characterEffect1148ui_story and not isNil(var_35_24) then
					arg_32_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_25 + var_35_26 and arg_32_1.time_ < var_35_25 + var_35_26 + arg_35_0 and not isNil(var_35_24) and arg_32_1.var_.characterEffect1148ui_story then
				arg_32_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_35_28 = 0

			if var_35_28 < arg_32_1.time_ and arg_32_1.time_ <= var_35_28 + arg_35_0 then
				arg_32_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_35_29 = 0

			if var_35_29 < arg_32_1.time_ and arg_32_1.time_ <= var_35_29 + arg_35_0 then
				arg_32_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_35_30 = 0
			local var_35_31 = 0.35

			if var_35_30 < arg_32_1.time_ and arg_32_1.time_ <= var_35_30 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_32 = arg_32_1:FormatText(StoryNameCfg[8].name)

				arg_32_1.leftNameTxt_.text = var_35_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_33 = arg_32_1:GetWordFromCfg(112211008)
				local var_35_34 = arg_32_1:FormatText(var_35_33.content)

				arg_32_1.text_.text = var_35_34

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_35 = 14
				local var_35_36 = utf8.len(var_35_34)
				local var_35_37 = var_35_35 <= 0 and var_35_31 or var_35_31 * (var_35_36 / var_35_35)

				if var_35_37 > 0 and var_35_31 < var_35_37 then
					arg_32_1.talkMaxDuration = var_35_37

					if var_35_37 + var_35_30 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_37 + var_35_30
					end
				end

				arg_32_1.text_.text = var_35_34
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211008", "story_v_out_112211.awb") ~= 0 then
					local var_35_38 = manager.audio:GetVoiceLength("story_v_out_112211", "112211008", "story_v_out_112211.awb") / 1000

					if var_35_38 + var_35_30 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_38 + var_35_30
					end

					if var_35_33.prefab_name ~= "" and arg_32_1.actors_[var_35_33.prefab_name] ~= nil then
						local var_35_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_33.prefab_name].transform, "story_v_out_112211", "112211008", "story_v_out_112211.awb")

						arg_32_1:RecordAudio("112211008", var_35_39)
						arg_32_1:RecordAudio("112211008", var_35_39)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_112211", "112211008", "story_v_out_112211.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_112211", "112211008", "story_v_out_112211.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_40 = math.max(var_35_31, arg_32_1.talkMaxDuration)

			if var_35_30 <= arg_32_1.time_ and arg_32_1.time_ < var_35_30 + var_35_40 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_30) / var_35_40

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_30 + var_35_40 and arg_32_1.time_ < var_35_30 + var_35_40 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play112211009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 112211009
		arg_36_1.duration_ = 5.67

		local var_36_0 = {
			ja = 5.666,
			ko = 2.6,
			zh = 2.666,
			en = 2.866
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
				arg_36_0:Play112211010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1148ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1148ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1148ui_story, var_39_4, var_39_3)

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

			local var_39_9 = arg_36_1.actors_["1039ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos1039ui_story = var_39_9.localPosition
			end

			local var_39_11 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11
				local var_39_13 = Vector3.New(0, -1.01, -5.9)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1039ui_story, var_39_13, var_39_12)

				local var_39_14 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_14.x, var_39_14.y, var_39_14.z)

				local var_39_15 = var_39_9.localEulerAngles

				var_39_15.z = 0
				var_39_15.x = 0
				var_39_9.localEulerAngles = var_39_15
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 then
				var_39_9.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_9.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_9.localEulerAngles = var_39_17
			end

			local var_39_18 = arg_36_1.actors_["1039ui_story"]
			local var_39_19 = 0

			if var_39_19 < arg_36_1.time_ and arg_36_1.time_ <= var_39_19 + arg_39_0 and not isNil(var_39_18) and arg_36_1.var_.characterEffect1039ui_story == nil then
				arg_36_1.var_.characterEffect1039ui_story = var_39_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_20 = 0.2

			if var_39_19 <= arg_36_1.time_ and arg_36_1.time_ < var_39_19 + var_39_20 and not isNil(var_39_18) then
				local var_39_21 = (arg_36_1.time_ - var_39_19) / var_39_20

				if arg_36_1.var_.characterEffect1039ui_story and not isNil(var_39_18) then
					arg_36_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_19 + var_39_20 and arg_36_1.time_ < var_39_19 + var_39_20 + arg_39_0 and not isNil(var_39_18) and arg_36_1.var_.characterEffect1039ui_story then
				arg_36_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_39_22 = 0

			if var_39_22 < arg_36_1.time_ and arg_36_1.time_ <= var_39_22 + arg_39_0 then
				arg_36_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action3_1")
			end

			local var_39_23 = 0

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_39_24 = 0
			local var_39_25 = 0.275

			if var_39_24 < arg_36_1.time_ and arg_36_1.time_ <= var_39_24 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_26 = arg_36_1:FormatText(StoryNameCfg[9].name)

				arg_36_1.leftNameTxt_.text = var_39_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_27 = arg_36_1:GetWordFromCfg(112211009)
				local var_39_28 = arg_36_1:FormatText(var_39_27.content)

				arg_36_1.text_.text = var_39_28

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_29 = 11
				local var_39_30 = utf8.len(var_39_28)
				local var_39_31 = var_39_29 <= 0 and var_39_25 or var_39_25 * (var_39_30 / var_39_29)

				if var_39_31 > 0 and var_39_25 < var_39_31 then
					arg_36_1.talkMaxDuration = var_39_31

					if var_39_31 + var_39_24 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_31 + var_39_24
					end
				end

				arg_36_1.text_.text = var_39_28
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211009", "story_v_out_112211.awb") ~= 0 then
					local var_39_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211009", "story_v_out_112211.awb") / 1000

					if var_39_32 + var_39_24 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_32 + var_39_24
					end

					if var_39_27.prefab_name ~= "" and arg_36_1.actors_[var_39_27.prefab_name] ~= nil then
						local var_39_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_27.prefab_name].transform, "story_v_out_112211", "112211009", "story_v_out_112211.awb")

						arg_36_1:RecordAudio("112211009", var_39_33)
						arg_36_1:RecordAudio("112211009", var_39_33)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_112211", "112211009", "story_v_out_112211.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_112211", "112211009", "story_v_out_112211.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_34 = math.max(var_39_25, arg_36_1.talkMaxDuration)

			if var_39_24 <= arg_36_1.time_ and arg_36_1.time_ < var_39_24 + var_39_34 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_24) / var_39_34

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_24 + var_39_34 and arg_36_1.time_ < var_39_24 + var_39_34 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_36_1:InitPlayNodeList()
	end,
	Play112211010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 112211010
		arg_40_1.duration_ = 6.47

		local var_40_0 = {
			ja = 6.466,
			ko = 4.6,
			zh = 3.766,
			en = 4.1
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
				arg_40_0:Play112211011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1039ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1039ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1039ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, 100, 0)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = "1081ui_story"

			if arg_40_1.actors_[var_43_9] == nil then
				local var_43_10 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_43_10) then
					local var_43_11 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_40_1.stage_.transform)

					var_43_11.name = var_43_9
					var_43_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_9] = var_43_11

					local var_43_12 = var_43_11:GetComponentInChildren(typeof(CharacterEffect))

					var_43_12.enabled = true

					local var_43_13 = GameObjectTools.GetOrAddComponent(var_43_11, typeof(DynamicBoneHelper))

					if var_43_13 then
						var_43_13:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_12.transform, false)

					arg_40_1.var_[var_43_9 .. "Animator"] = var_43_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_9 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_9 .. "LipSync"] = var_43_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_14 = arg_40_1.actors_["1081ui_story"].transform
			local var_43_15 = 0

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.var_.moveOldPos1081ui_story = var_43_14.localPosition

				local var_43_16 = "1081ui_story"

				arg_40_1:ShowWeapon(arg_40_1.var_[var_43_16 .. "Animator"].transform, false)
			end

			local var_43_17 = 0.001

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_17 then
				local var_43_18 = (arg_40_1.time_ - var_43_15) / var_43_17
				local var_43_19 = Vector3.New(0, -0.92, -5.8)

				var_43_14.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1081ui_story, var_43_19, var_43_18)

				local var_43_20 = manager.ui.mainCamera.transform.position - var_43_14.position

				var_43_14.forward = Vector3.New(var_43_20.x, var_43_20.y, var_43_20.z)

				local var_43_21 = var_43_14.localEulerAngles

				var_43_21.z = 0
				var_43_21.x = 0
				var_43_14.localEulerAngles = var_43_21
			end

			if arg_40_1.time_ >= var_43_15 + var_43_17 and arg_40_1.time_ < var_43_15 + var_43_17 + arg_43_0 then
				var_43_14.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_43_22 = manager.ui.mainCamera.transform.position - var_43_14.position

				var_43_14.forward = Vector3.New(var_43_22.x, var_43_22.y, var_43_22.z)

				local var_43_23 = var_43_14.localEulerAngles

				var_43_23.z = 0
				var_43_23.x = 0
				var_43_14.localEulerAngles = var_43_23
			end

			local var_43_24 = arg_40_1.actors_["1081ui_story"]
			local var_43_25 = 0

			if var_43_25 < arg_40_1.time_ and arg_40_1.time_ <= var_43_25 + arg_43_0 and not isNil(var_43_24) and arg_40_1.var_.characterEffect1081ui_story == nil then
				arg_40_1.var_.characterEffect1081ui_story = var_43_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_26 = 0.2

			if var_43_25 <= arg_40_1.time_ and arg_40_1.time_ < var_43_25 + var_43_26 and not isNil(var_43_24) then
				local var_43_27 = (arg_40_1.time_ - var_43_25) / var_43_26

				if arg_40_1.var_.characterEffect1081ui_story and not isNil(var_43_24) then
					arg_40_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_25 + var_43_26 and arg_40_1.time_ < var_43_25 + var_43_26 + arg_43_0 and not isNil(var_43_24) and arg_40_1.var_.characterEffect1081ui_story then
				arg_40_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_43_28 = 0

			if var_43_28 < arg_40_1.time_ and arg_40_1.time_ <= var_43_28 + arg_43_0 then
				arg_40_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_43_29 = 0

			if var_43_29 < arg_40_1.time_ and arg_40_1.time_ <= var_43_29 + arg_43_0 then
				arg_40_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_43_30 = 0
			local var_43_31 = 0.425

			if var_43_30 < arg_40_1.time_ and arg_40_1.time_ <= var_43_30 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_32 = arg_40_1:FormatText(StoryNameCfg[202].name)

				arg_40_1.leftNameTxt_.text = var_43_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_33 = arg_40_1:GetWordFromCfg(112211010)
				local var_43_34 = arg_40_1:FormatText(var_43_33.content)

				arg_40_1.text_.text = var_43_34

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_35 = 17
				local var_43_36 = utf8.len(var_43_34)
				local var_43_37 = var_43_35 <= 0 and var_43_31 or var_43_31 * (var_43_36 / var_43_35)

				if var_43_37 > 0 and var_43_31 < var_43_37 then
					arg_40_1.talkMaxDuration = var_43_37

					if var_43_37 + var_43_30 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_37 + var_43_30
					end
				end

				arg_40_1.text_.text = var_43_34
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211010", "story_v_out_112211.awb") ~= 0 then
					local var_43_38 = manager.audio:GetVoiceLength("story_v_out_112211", "112211010", "story_v_out_112211.awb") / 1000

					if var_43_38 + var_43_30 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_38 + var_43_30
					end

					if var_43_33.prefab_name ~= "" and arg_40_1.actors_[var_43_33.prefab_name] ~= nil then
						local var_43_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_33.prefab_name].transform, "story_v_out_112211", "112211010", "story_v_out_112211.awb")

						arg_40_1:RecordAudio("112211010", var_43_39)
						arg_40_1:RecordAudio("112211010", var_43_39)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_112211", "112211010", "story_v_out_112211.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_112211", "112211010", "story_v_out_112211.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_40 = math.max(var_43_31, arg_40_1.talkMaxDuration)

			if var_43_30 <= arg_40_1.time_ and arg_40_1.time_ < var_43_30 + var_43_40 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_30) / var_43_40

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_30 + var_43_40 and arg_40_1.time_ < var_43_30 + var_43_40 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play112211011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 112211011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play112211012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1081ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1081ui_story == nil then
				arg_44_1.var_.characterEffect1081ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1081ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1081ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1081ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1081ui_story.fillRatio = var_47_5
			end

			local var_47_6 = 0
			local var_47_7 = 0.85

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_8 = arg_44_1:GetWordFromCfg(112211011)
				local var_47_9 = arg_44_1:FormatText(var_47_8.content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 34
				local var_47_11 = utf8.len(var_47_9)
				local var_47_12 = var_47_10 <= 0 and var_47_7 or var_47_7 * (var_47_11 / var_47_10)

				if var_47_12 > 0 and var_47_7 < var_47_12 then
					arg_44_1.talkMaxDuration = var_47_12

					if var_47_12 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_13 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_13 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_13

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_13 and arg_44_1.time_ < var_47_6 + var_47_13 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play112211012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 112211012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play112211013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			local var_51_1 = 0
			local var_51_2 = 0.475

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(112211012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 19
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_2 or var_51_2 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_2 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_8 and arg_48_1.time_ < var_51_1 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play112211013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 112211013
		arg_52_1.duration_ = 5.87

		local var_52_0 = {
			ja = 5.866,
			ko = 4.066,
			zh = 3.466,
			en = 3.366
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
				arg_52_0:Play112211014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1081ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1081ui_story == nil then
				arg_52_1.var_.characterEffect1081ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1081ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1081ui_story then
				arg_52_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_55_4 = 0

			if var_55_4 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_1")
			end

			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_55_6 = 0
			local var_55_7 = 0.3

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[202].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_9 = arg_52_1:GetWordFromCfg(112211013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 12
				local var_55_12 = utf8.len(var_55_10)
				local var_55_13 = var_55_11 <= 0 and var_55_7 or var_55_7 * (var_55_12 / var_55_11)

				if var_55_13 > 0 and var_55_7 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211013", "story_v_out_112211.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211013", "story_v_out_112211.awb") / 1000

					if var_55_14 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_6
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_out_112211", "112211013", "story_v_out_112211.awb")

						arg_52_1:RecordAudio("112211013", var_55_15)
						arg_52_1:RecordAudio("112211013", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_112211", "112211013", "story_v_out_112211.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_112211", "112211013", "story_v_out_112211.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_16 and arg_52_1.time_ < var_55_6 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play112211014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 112211014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play112211015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1081ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1081ui_story == nil then
				arg_56_1.var_.characterEffect1081ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1081ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1081ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1081ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1081ui_story.fillRatio = var_59_5
			end

			local var_59_6 = arg_56_1.actors_["1081ui_story"].transform
			local var_59_7 = 0

			if var_59_7 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				arg_56_1.var_.moveOldPos1081ui_story = var_59_6.localPosition

				local var_59_8 = "1081ui_story"

				arg_56_1:ShowWeapon(arg_56_1.var_[var_59_8 .. "Animator"].transform, false)
			end

			local var_59_9 = 0.001

			if var_59_7 <= arg_56_1.time_ and arg_56_1.time_ < var_59_7 + var_59_9 then
				local var_59_10 = (arg_56_1.time_ - var_59_7) / var_59_9
				local var_59_11 = Vector3.New(0, 100, 0)

				var_59_6.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1081ui_story, var_59_11, var_59_10)

				local var_59_12 = manager.ui.mainCamera.transform.position - var_59_6.position

				var_59_6.forward = Vector3.New(var_59_12.x, var_59_12.y, var_59_12.z)

				local var_59_13 = var_59_6.localEulerAngles

				var_59_13.z = 0
				var_59_13.x = 0
				var_59_6.localEulerAngles = var_59_13
			end

			if arg_56_1.time_ >= var_59_7 + var_59_9 and arg_56_1.time_ < var_59_7 + var_59_9 + arg_59_0 then
				var_59_6.localPosition = Vector3.New(0, 100, 0)

				local var_59_14 = manager.ui.mainCamera.transform.position - var_59_6.position

				var_59_6.forward = Vector3.New(var_59_14.x, var_59_14.y, var_59_14.z)

				local var_59_15 = var_59_6.localEulerAngles

				var_59_15.z = 0
				var_59_15.x = 0
				var_59_6.localEulerAngles = var_59_15
			end

			local var_59_16 = 0
			local var_59_17 = 0.425

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(112211014)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 17
				local var_59_21 = utf8.len(var_59_19)
				local var_59_22 = var_59_20 <= 0 and var_59_17 or var_59_17 * (var_59_21 / var_59_20)

				if var_59_22 > 0 and var_59_17 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22

					if var_59_22 + var_59_16 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_16
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_23 = math.max(var_59_17, arg_56_1.talkMaxDuration)

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_23 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_16) / var_59_23

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_16 + var_59_23 and arg_56_1.time_ < var_59_16 + var_59_23 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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

		arg_56_1:InitPlayNodeList()
	end,
	Play112211015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 112211015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play112211016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.45

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(112211015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 18
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play112211016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 112211016
		arg_64_1.duration_ = 10.47

		local var_64_0 = {
			ja = 7.7,
			ko = 7.3,
			zh = 8.3,
			en = 10.466
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
				arg_64_0:Play112211017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1081ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1081ui_story == nil then
				arg_64_1.var_.characterEffect1081ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1081ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1081ui_story then
				arg_64_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_67_4 = 0

			if var_67_4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_67_6 = arg_64_1.actors_["1081ui_story"].transform
			local var_67_7 = 0

			if var_67_7 < arg_64_1.time_ and arg_64_1.time_ <= var_67_7 + arg_67_0 then
				arg_64_1.var_.moveOldPos1081ui_story = var_67_6.localPosition

				local var_67_8 = "1081ui_story"

				arg_64_1:ShowWeapon(arg_64_1.var_[var_67_8 .. "Animator"].transform, false)
			end

			local var_67_9 = 0.001

			if var_67_7 <= arg_64_1.time_ and arg_64_1.time_ < var_67_7 + var_67_9 then
				local var_67_10 = (arg_64_1.time_ - var_67_7) / var_67_9
				local var_67_11 = Vector3.New(0, -0.92, -5.8)

				var_67_6.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1081ui_story, var_67_11, var_67_10)

				local var_67_12 = manager.ui.mainCamera.transform.position - var_67_6.position

				var_67_6.forward = Vector3.New(var_67_12.x, var_67_12.y, var_67_12.z)

				local var_67_13 = var_67_6.localEulerAngles

				var_67_13.z = 0
				var_67_13.x = 0
				var_67_6.localEulerAngles = var_67_13
			end

			if arg_64_1.time_ >= var_67_7 + var_67_9 and arg_64_1.time_ < var_67_7 + var_67_9 + arg_67_0 then
				var_67_6.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_67_14 = manager.ui.mainCamera.transform.position - var_67_6.position

				var_67_6.forward = Vector3.New(var_67_14.x, var_67_14.y, var_67_14.z)

				local var_67_15 = var_67_6.localEulerAngles

				var_67_15.z = 0
				var_67_15.x = 0
				var_67_6.localEulerAngles = var_67_15
			end

			local var_67_16 = 0
			local var_67_17 = 0.9

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_18 = arg_64_1:FormatText(StoryNameCfg[202].name)

				arg_64_1.leftNameTxt_.text = var_67_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_19 = arg_64_1:GetWordFromCfg(112211016)
				local var_67_20 = arg_64_1:FormatText(var_67_19.content)

				arg_64_1.text_.text = var_67_20

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_21 = 36
				local var_67_22 = utf8.len(var_67_20)
				local var_67_23 = var_67_21 <= 0 and var_67_17 or var_67_17 * (var_67_22 / var_67_21)

				if var_67_23 > 0 and var_67_17 < var_67_23 then
					arg_64_1.talkMaxDuration = var_67_23

					if var_67_23 + var_67_16 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_16
					end
				end

				arg_64_1.text_.text = var_67_20
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211016", "story_v_out_112211.awb") ~= 0 then
					local var_67_24 = manager.audio:GetVoiceLength("story_v_out_112211", "112211016", "story_v_out_112211.awb") / 1000

					if var_67_24 + var_67_16 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_24 + var_67_16
					end

					if var_67_19.prefab_name ~= "" and arg_64_1.actors_[var_67_19.prefab_name] ~= nil then
						local var_67_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_19.prefab_name].transform, "story_v_out_112211", "112211016", "story_v_out_112211.awb")

						arg_64_1:RecordAudio("112211016", var_67_25)
						arg_64_1:RecordAudio("112211016", var_67_25)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_112211", "112211016", "story_v_out_112211.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_112211", "112211016", "story_v_out_112211.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_26 = math.max(var_67_17, arg_64_1.talkMaxDuration)

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_26 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_16) / var_67_26

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_16 + var_67_26 and arg_64_1.time_ < var_67_16 + var_67_26 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play112211017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 112211017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play112211018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1081ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1081ui_story == nil then
				arg_68_1.var_.characterEffect1081ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1081ui_story and not isNil(var_71_0) then
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1081ui_story.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1081ui_story then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1081ui_story.fillRatio = var_71_5
			end

			local var_71_6 = 0
			local var_71_7 = 0.175

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_8 = arg_68_1:FormatText(StoryNameCfg[7].name)

				arg_68_1.leftNameTxt_.text = var_71_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_9 = arg_68_1:GetWordFromCfg(112211017)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 7
				local var_71_12 = utf8.len(var_71_10)
				local var_71_13 = var_71_11 <= 0 and var_71_7 or var_71_7 * (var_71_12 / var_71_11)

				if var_71_13 > 0 and var_71_7 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_10
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_14 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_14 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_14

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_14 and arg_68_1.time_ < var_71_6 + var_71_14 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play112211018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 112211018
		arg_72_1.duration_ = 2

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play112211019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1081ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1081ui_story == nil then
				arg_72_1.var_.characterEffect1081ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1081ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1081ui_story then
				arg_72_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_75_4 = 0

			if var_75_4 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action474")
			end

			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 then
				arg_72_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_75_6 = 0
			local var_75_7 = 0.1

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[202].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_9 = arg_72_1:GetWordFromCfg(112211018)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 4
				local var_75_12 = utf8.len(var_75_10)
				local var_75_13 = var_75_11 <= 0 and var_75_7 or var_75_7 * (var_75_12 / var_75_11)

				if var_75_13 > 0 and var_75_7 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211018", "story_v_out_112211.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211018", "story_v_out_112211.awb") / 1000

					if var_75_14 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_6
					end

					if var_75_9.prefab_name ~= "" and arg_72_1.actors_[var_75_9.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_9.prefab_name].transform, "story_v_out_112211", "112211018", "story_v_out_112211.awb")

						arg_72_1:RecordAudio("112211018", var_75_15)
						arg_72_1:RecordAudio("112211018", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_112211", "112211018", "story_v_out_112211.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_112211", "112211018", "story_v_out_112211.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_16 and arg_72_1.time_ < var_75_6 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play112211019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 112211019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play112211020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1081ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos1081ui_story = var_79_0.localPosition

				local var_79_2 = "1081ui_story"

				arg_76_1:ShowWeapon(arg_76_1.var_[var_79_2 .. "Animator"].transform, false)
			end

			local var_79_3 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_3 then
				local var_79_4 = (arg_76_1.time_ - var_79_1) / var_79_3
				local var_79_5 = Vector3.New(0, 100, 0)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1081ui_story, var_79_5, var_79_4)

				local var_79_6 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_6.x, var_79_6.y, var_79_6.z)

				local var_79_7 = var_79_0.localEulerAngles

				var_79_7.z = 0
				var_79_7.x = 0
				var_79_0.localEulerAngles = var_79_7
			end

			if arg_76_1.time_ >= var_79_1 + var_79_3 and arg_76_1.time_ < var_79_1 + var_79_3 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0, 100, 0)

				local var_79_8 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_8.x, var_79_8.y, var_79_8.z)

				local var_79_9 = var_79_0.localEulerAngles

				var_79_9.z = 0
				var_79_9.x = 0
				var_79_0.localEulerAngles = var_79_9
			end

			local var_79_10 = 0
			local var_79_11 = 0.7

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_12 = arg_76_1:GetWordFromCfg(112211019)
				local var_79_13 = arg_76_1:FormatText(var_79_12.content)

				arg_76_1.text_.text = var_79_13

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_14 = 28
				local var_79_15 = utf8.len(var_79_13)
				local var_79_16 = var_79_14 <= 0 and var_79_11 or var_79_11 * (var_79_15 / var_79_14)

				if var_79_16 > 0 and var_79_11 < var_79_16 then
					arg_76_1.talkMaxDuration = var_79_16

					if var_79_16 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_16 + var_79_10
					end
				end

				arg_76_1.text_.text = var_79_13
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_17 = math.max(var_79_11, arg_76_1.talkMaxDuration)

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_17 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_10) / var_79_17

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_10 + var_79_17 and arg_76_1.time_ < var_79_10 + var_79_17 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play112211020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 112211020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play112211021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.375

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

				local var_83_2 = arg_80_1:GetWordFromCfg(112211020)
				local var_83_3 = arg_80_1:FormatText(var_83_2.content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 15
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
	Play112211021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 112211021
		arg_84_1.duration_ = 2.83

		local var_84_0 = {
			ja = 2.666,
			ko = 2.833,
			zh = 2.2,
			en = 2.7
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
				arg_84_0:Play112211022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.175

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[6].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(112211021)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211021", "story_v_out_112211.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211021", "story_v_out_112211.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_112211", "112211021", "story_v_out_112211.awb")

						arg_84_1:RecordAudio("112211021", var_87_9)
						arg_84_1:RecordAudio("112211021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_112211", "112211021", "story_v_out_112211.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_112211", "112211021", "story_v_out_112211.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play112211022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 112211022
		arg_88_1.duration_ = 5.83

		local var_88_0 = {
			ja = 4.566,
			ko = 3.766,
			zh = 3.066,
			en = 5.833
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
				arg_88_0:Play112211023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1081ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1081ui_story == nil then
				arg_88_1.var_.characterEffect1081ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1081ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1081ui_story then
				arg_88_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_91_4 = 0

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_91_6 = arg_88_1.actors_["1081ui_story"].transform
			local var_91_7 = 0

			if var_91_7 < arg_88_1.time_ and arg_88_1.time_ <= var_91_7 + arg_91_0 then
				arg_88_1.var_.moveOldPos1081ui_story = var_91_6.localPosition

				local var_91_8 = "1081ui_story"

				arg_88_1:ShowWeapon(arg_88_1.var_[var_91_8 .. "Animator"].transform, false)
			end

			local var_91_9 = 0.001

			if var_91_7 <= arg_88_1.time_ and arg_88_1.time_ < var_91_7 + var_91_9 then
				local var_91_10 = (arg_88_1.time_ - var_91_7) / var_91_9
				local var_91_11 = Vector3.New(0, -0.92, -5.8)

				var_91_6.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1081ui_story, var_91_11, var_91_10)

				local var_91_12 = manager.ui.mainCamera.transform.position - var_91_6.position

				var_91_6.forward = Vector3.New(var_91_12.x, var_91_12.y, var_91_12.z)

				local var_91_13 = var_91_6.localEulerAngles

				var_91_13.z = 0
				var_91_13.x = 0
				var_91_6.localEulerAngles = var_91_13
			end

			if arg_88_1.time_ >= var_91_7 + var_91_9 and arg_88_1.time_ < var_91_7 + var_91_9 + arg_91_0 then
				var_91_6.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_91_14 = manager.ui.mainCamera.transform.position - var_91_6.position

				var_91_6.forward = Vector3.New(var_91_14.x, var_91_14.y, var_91_14.z)

				local var_91_15 = var_91_6.localEulerAngles

				var_91_15.z = 0
				var_91_15.x = 0
				var_91_6.localEulerAngles = var_91_15
			end

			local var_91_16 = 0
			local var_91_17 = 0.325

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_18 = arg_88_1:FormatText(StoryNameCfg[202].name)

				arg_88_1.leftNameTxt_.text = var_91_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_19 = arg_88_1:GetWordFromCfg(112211022)
				local var_91_20 = arg_88_1:FormatText(var_91_19.content)

				arg_88_1.text_.text = var_91_20

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_21 = 13
				local var_91_22 = utf8.len(var_91_20)
				local var_91_23 = var_91_21 <= 0 and var_91_17 or var_91_17 * (var_91_22 / var_91_21)

				if var_91_23 > 0 and var_91_17 < var_91_23 then
					arg_88_1.talkMaxDuration = var_91_23

					if var_91_23 + var_91_16 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_16
					end
				end

				arg_88_1.text_.text = var_91_20
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211022", "story_v_out_112211.awb") ~= 0 then
					local var_91_24 = manager.audio:GetVoiceLength("story_v_out_112211", "112211022", "story_v_out_112211.awb") / 1000

					if var_91_24 + var_91_16 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_24 + var_91_16
					end

					if var_91_19.prefab_name ~= "" and arg_88_1.actors_[var_91_19.prefab_name] ~= nil then
						local var_91_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_19.prefab_name].transform, "story_v_out_112211", "112211022", "story_v_out_112211.awb")

						arg_88_1:RecordAudio("112211022", var_91_25)
						arg_88_1:RecordAudio("112211022", var_91_25)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_112211", "112211022", "story_v_out_112211.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_112211", "112211022", "story_v_out_112211.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_26 = math.max(var_91_17, arg_88_1.talkMaxDuration)

			if var_91_16 <= arg_88_1.time_ and arg_88_1.time_ < var_91_16 + var_91_26 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_16) / var_91_26

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_16 + var_91_26 and arg_88_1.time_ < var_91_16 + var_91_26 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play112211023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 112211023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play112211024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1081ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1081ui_story == nil then
				arg_92_1.var_.characterEffect1081ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1081ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1081ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1081ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1081ui_story.fillRatio = var_95_5
			end

			local var_95_6 = 0

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			local var_95_7 = 0
			local var_95_8 = 0.8

			if var_95_7 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_9 = arg_92_1:GetWordFromCfg(112211023)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 32
				local var_95_12 = utf8.len(var_95_10)
				local var_95_13 = var_95_11 <= 0 and var_95_8 or var_95_8 * (var_95_12 / var_95_11)

				if var_95_13 > 0 and var_95_8 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_7 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_7
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_8, arg_92_1.talkMaxDuration)

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_7) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_7 + var_95_14 and arg_92_1.time_ < var_95_7 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play112211024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 112211024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play112211025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.525

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_2 = arg_96_1:GetWordFromCfg(112211024)
				local var_99_3 = arg_96_1:FormatText(var_99_2.content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 21
				local var_99_5 = utf8.len(var_99_3)
				local var_99_6 = var_99_4 <= 0 and var_99_1 or var_99_1 * (var_99_5 / var_99_4)

				if var_99_6 > 0 and var_99_1 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_7 and arg_96_1.time_ < var_99_0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play112211025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 112211025
		arg_100_1.duration_ = 3.17

		local var_100_0 = {
			ja = 2.033,
			ko = 1.999999999999,
			zh = 2.066,
			en = 3.166
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
				arg_100_0:Play112211026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1081ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1081ui_story == nil then
				arg_100_1.var_.characterEffect1081ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1081ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1081ui_story then
				arg_100_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_103_4 = 0

			if var_103_4 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_1")
			end

			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_103_6 = 0
			local var_103_7 = 0.075

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[202].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_9 = arg_100_1:GetWordFromCfg(112211025)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211025", "story_v_out_112211.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211025", "story_v_out_112211.awb") / 1000

					if var_103_14 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_6
					end

					if var_103_9.prefab_name ~= "" and arg_100_1.actors_[var_103_9.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_9.prefab_name].transform, "story_v_out_112211", "112211025", "story_v_out_112211.awb")

						arg_100_1:RecordAudio("112211025", var_103_15)
						arg_100_1:RecordAudio("112211025", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_112211", "112211025", "story_v_out_112211.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_112211", "112211025", "story_v_out_112211.awb")
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
	Play112211026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 112211026
		arg_104_1.duration_ = 4.7

		local var_104_0 = {
			ja = 3.3,
			ko = 4.7,
			zh = 4.1,
			en = 4.7
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
				arg_104_0:Play112211027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1081ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1081ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(-0.7, -0.92, -5.8)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1081ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(-0.7, -0.92, -5.8)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = 0

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 then
				arg_104_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_2")
			end

			local var_107_10 = arg_104_1.actors_["1148ui_story"].transform
			local var_107_11 = 0

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1.var_.moveOldPos1148ui_story = var_107_10.localPosition
			end

			local var_107_12 = 0.001

			if var_107_11 <= arg_104_1.time_ and arg_104_1.time_ < var_107_11 + var_107_12 then
				local var_107_13 = (arg_104_1.time_ - var_107_11) / var_107_12
				local var_107_14 = Vector3.New(0.7, -0.8, -6.2)

				var_107_10.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1148ui_story, var_107_14, var_107_13)

				local var_107_15 = manager.ui.mainCamera.transform.position - var_107_10.position

				var_107_10.forward = Vector3.New(var_107_15.x, var_107_15.y, var_107_15.z)

				local var_107_16 = var_107_10.localEulerAngles

				var_107_16.z = 0
				var_107_16.x = 0
				var_107_10.localEulerAngles = var_107_16
			end

			if arg_104_1.time_ >= var_107_11 + var_107_12 and arg_104_1.time_ < var_107_11 + var_107_12 + arg_107_0 then
				var_107_10.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_107_17 = manager.ui.mainCamera.transform.position - var_107_10.position

				var_107_10.forward = Vector3.New(var_107_17.x, var_107_17.y, var_107_17.z)

				local var_107_18 = var_107_10.localEulerAngles

				var_107_18.z = 0
				var_107_18.x = 0
				var_107_10.localEulerAngles = var_107_18
			end

			local var_107_19 = arg_104_1.actors_["1148ui_story"]
			local var_107_20 = 0

			if var_107_20 < arg_104_1.time_ and arg_104_1.time_ <= var_107_20 + arg_107_0 and not isNil(var_107_19) and arg_104_1.var_.characterEffect1148ui_story == nil then
				arg_104_1.var_.characterEffect1148ui_story = var_107_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_21 = 0.2

			if var_107_20 <= arg_104_1.time_ and arg_104_1.time_ < var_107_20 + var_107_21 and not isNil(var_107_19) then
				local var_107_22 = (arg_104_1.time_ - var_107_20) / var_107_21

				if arg_104_1.var_.characterEffect1148ui_story and not isNil(var_107_19) then
					arg_104_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_20 + var_107_21 and arg_104_1.time_ < var_107_20 + var_107_21 + arg_107_0 and not isNil(var_107_19) and arg_104_1.var_.characterEffect1148ui_story then
				arg_104_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_107_23 = 0

			if var_107_23 < arg_104_1.time_ and arg_104_1.time_ <= var_107_23 + arg_107_0 then
				arg_104_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_107_24 = arg_104_1.actors_["1081ui_story"]
			local var_107_25 = 0

			if var_107_25 < arg_104_1.time_ and arg_104_1.time_ <= var_107_25 + arg_107_0 and not isNil(var_107_24) and arg_104_1.var_.characterEffect1081ui_story == nil then
				arg_104_1.var_.characterEffect1081ui_story = var_107_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_26 = 0.2

			if var_107_25 <= arg_104_1.time_ and arg_104_1.time_ < var_107_25 + var_107_26 and not isNil(var_107_24) then
				local var_107_27 = (arg_104_1.time_ - var_107_25) / var_107_26

				if arg_104_1.var_.characterEffect1081ui_story and not isNil(var_107_24) then
					local var_107_28 = Mathf.Lerp(0, 0.5, var_107_27)

					arg_104_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1081ui_story.fillRatio = var_107_28
				end
			end

			if arg_104_1.time_ >= var_107_25 + var_107_26 and arg_104_1.time_ < var_107_25 + var_107_26 + arg_107_0 and not isNil(var_107_24) and arg_104_1.var_.characterEffect1081ui_story then
				local var_107_29 = 0.5

				arg_104_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1081ui_story.fillRatio = var_107_29
			end

			local var_107_30 = 0

			if var_107_30 < arg_104_1.time_ and arg_104_1.time_ <= var_107_30 + arg_107_0 then
				arg_104_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_107_31 = 0

			if var_107_31 < arg_104_1.time_ and arg_104_1.time_ <= var_107_31 + arg_107_0 then
				arg_104_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_107_32 = 0
			local var_107_33 = 0.475

			if var_107_32 < arg_104_1.time_ and arg_104_1.time_ <= var_107_32 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_34 = arg_104_1:FormatText(StoryNameCfg[8].name)

				arg_104_1.leftNameTxt_.text = var_107_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_35 = arg_104_1:GetWordFromCfg(112211026)
				local var_107_36 = arg_104_1:FormatText(var_107_35.content)

				arg_104_1.text_.text = var_107_36

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_37 = 19
				local var_107_38 = utf8.len(var_107_36)
				local var_107_39 = var_107_37 <= 0 and var_107_33 or var_107_33 * (var_107_38 / var_107_37)

				if var_107_39 > 0 and var_107_33 < var_107_39 then
					arg_104_1.talkMaxDuration = var_107_39

					if var_107_39 + var_107_32 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_39 + var_107_32
					end
				end

				arg_104_1.text_.text = var_107_36
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211026", "story_v_out_112211.awb") ~= 0 then
					local var_107_40 = manager.audio:GetVoiceLength("story_v_out_112211", "112211026", "story_v_out_112211.awb") / 1000

					if var_107_40 + var_107_32 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_40 + var_107_32
					end

					if var_107_35.prefab_name ~= "" and arg_104_1.actors_[var_107_35.prefab_name] ~= nil then
						local var_107_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_35.prefab_name].transform, "story_v_out_112211", "112211026", "story_v_out_112211.awb")

						arg_104_1:RecordAudio("112211026", var_107_41)
						arg_104_1:RecordAudio("112211026", var_107_41)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_112211", "112211026", "story_v_out_112211.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_112211", "112211026", "story_v_out_112211.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_42 = math.max(var_107_33, arg_104_1.talkMaxDuration)

			if var_107_32 <= arg_104_1.time_ and arg_104_1.time_ < var_107_32 + var_107_42 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_32) / var_107_42

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_32 + var_107_42 and arg_104_1.time_ < var_107_32 + var_107_42 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play112211027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 112211027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play112211028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1148ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1148ui_story == nil then
				arg_108_1.var_.characterEffect1148ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1148ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1148ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1148ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1148ui_story.fillRatio = var_111_5
			end

			local var_111_6 = 0
			local var_111_7 = 0.2

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

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_9 = arg_108_1:GetWordFromCfg(112211027)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 8
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
	Play112211028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 112211028
		arg_112_1.duration_ = 7.6

		local var_112_0 = {
			ja = 7.6,
			ko = 6.533,
			zh = 7.433,
			en = 6.533
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
				arg_112_0:Play112211029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1081ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1081ui_story == nil then
				arg_112_1.var_.characterEffect1081ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1081ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1081ui_story then
				arg_112_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_115_4 = 0

			if var_115_4 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_115_6 = 0
			local var_115_7 = 0.8

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_8 = arg_112_1:FormatText(StoryNameCfg[202].name)

				arg_112_1.leftNameTxt_.text = var_115_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_9 = arg_112_1:GetWordFromCfg(112211028)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211028", "story_v_out_112211.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211028", "story_v_out_112211.awb") / 1000

					if var_115_14 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_6
					end

					if var_115_9.prefab_name ~= "" and arg_112_1.actors_[var_115_9.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_9.prefab_name].transform, "story_v_out_112211", "112211028", "story_v_out_112211.awb")

						arg_112_1:RecordAudio("112211028", var_115_15)
						arg_112_1:RecordAudio("112211028", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_112211", "112211028", "story_v_out_112211.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_112211", "112211028", "story_v_out_112211.awb")
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
	Play112211029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 112211029
		arg_116_1.duration_ = 4.97

		local var_116_0 = {
			ja = 4.666,
			ko = 4.6,
			zh = 4.466,
			en = 4.966
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
				arg_116_0:Play112211030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1081ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1081ui_story == nil then
				arg_116_1.var_.characterEffect1081ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1081ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1081ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1081ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1081ui_story.fillRatio = var_119_5
			end

			local var_119_6 = arg_116_1.actors_["1148ui_story"]
			local var_119_7 = 0

			if var_119_7 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect1148ui_story == nil then
				arg_116_1.var_.characterEffect1148ui_story = var_119_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_8 = 0.2

			if var_119_7 <= arg_116_1.time_ and arg_116_1.time_ < var_119_7 + var_119_8 and not isNil(var_119_6) then
				local var_119_9 = (arg_116_1.time_ - var_119_7) / var_119_8

				if arg_116_1.var_.characterEffect1148ui_story and not isNil(var_119_6) then
					arg_116_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_7 + var_119_8 and arg_116_1.time_ < var_119_7 + var_119_8 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect1148ui_story then
				arg_116_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			local var_119_11 = 0

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_119_12 = 0
			local var_119_13 = 0.475

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_14 = arg_116_1:FormatText(StoryNameCfg[8].name)

				arg_116_1.leftNameTxt_.text = var_119_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_15 = arg_116_1:GetWordFromCfg(112211029)
				local var_119_16 = arg_116_1:FormatText(var_119_15.content)

				arg_116_1.text_.text = var_119_16

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_17 = 19
				local var_119_18 = utf8.len(var_119_16)
				local var_119_19 = var_119_17 <= 0 and var_119_13 or var_119_13 * (var_119_18 / var_119_17)

				if var_119_19 > 0 and var_119_13 < var_119_19 then
					arg_116_1.talkMaxDuration = var_119_19

					if var_119_19 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_19 + var_119_12
					end
				end

				arg_116_1.text_.text = var_119_16
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211029", "story_v_out_112211.awb") ~= 0 then
					local var_119_20 = manager.audio:GetVoiceLength("story_v_out_112211", "112211029", "story_v_out_112211.awb") / 1000

					if var_119_20 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_20 + var_119_12
					end

					if var_119_15.prefab_name ~= "" and arg_116_1.actors_[var_119_15.prefab_name] ~= nil then
						local var_119_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_15.prefab_name].transform, "story_v_out_112211", "112211029", "story_v_out_112211.awb")

						arg_116_1:RecordAudio("112211029", var_119_21)
						arg_116_1:RecordAudio("112211029", var_119_21)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_112211", "112211029", "story_v_out_112211.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_112211", "112211029", "story_v_out_112211.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_22 = math.max(var_119_13, arg_116_1.talkMaxDuration)

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_22 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_12) / var_119_22

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_12 + var_119_22 and arg_116_1.time_ < var_119_12 + var_119_22 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play112211030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 112211030
		arg_120_1.duration_ = 7.4

		local var_120_0 = {
			ja = 7.4,
			ko = 5.6,
			zh = 3.866,
			en = 3.8
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
				arg_120_0:Play112211031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1148ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1148ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0, 100, 0)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1148ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, 100, 0)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["1081ui_story"].transform
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1.var_.moveOldPos1081ui_story = var_123_9.localPosition
			end

			local var_123_11 = 0.166666666666667

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11
				local var_123_13 = Vector3.New(0, -0.92, -5.8)

				var_123_9.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1081ui_story, var_123_13, var_123_12)

				local var_123_14 = manager.ui.mainCamera.transform.position - var_123_9.position

				var_123_9.forward = Vector3.New(var_123_14.x, var_123_14.y, var_123_14.z)

				local var_123_15 = var_123_9.localEulerAngles

				var_123_15.z = 0
				var_123_15.x = 0
				var_123_9.localEulerAngles = var_123_15
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 then
				var_123_9.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_123_16 = manager.ui.mainCamera.transform.position - var_123_9.position

				var_123_9.forward = Vector3.New(var_123_16.x, var_123_16.y, var_123_16.z)

				local var_123_17 = var_123_9.localEulerAngles

				var_123_17.z = 0
				var_123_17.x = 0
				var_123_9.localEulerAngles = var_123_17
			end

			local var_123_18 = 0

			if var_123_18 < arg_120_1.time_ and arg_120_1.time_ <= var_123_18 + arg_123_0 then
				arg_120_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action457")
			end

			local var_123_19 = arg_120_1.actors_["1081ui_story"]
			local var_123_20 = 0

			if var_123_20 < arg_120_1.time_ and arg_120_1.time_ <= var_123_20 + arg_123_0 and not isNil(var_123_19) and arg_120_1.var_.characterEffect1081ui_story == nil then
				arg_120_1.var_.characterEffect1081ui_story = var_123_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_21 = 0.2

			if var_123_20 <= arg_120_1.time_ and arg_120_1.time_ < var_123_20 + var_123_21 and not isNil(var_123_19) then
				local var_123_22 = (arg_120_1.time_ - var_123_20) / var_123_21

				if arg_120_1.var_.characterEffect1081ui_story and not isNil(var_123_19) then
					arg_120_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_20 + var_123_21 and arg_120_1.time_ < var_123_20 + var_123_21 + arg_123_0 and not isNil(var_123_19) and arg_120_1.var_.characterEffect1081ui_story then
				arg_120_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_123_23 = 0

			if var_123_23 < arg_120_1.time_ and arg_120_1.time_ <= var_123_23 + arg_123_0 then
				arg_120_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_123_24 = 0
			local var_123_25 = 0.375

			if var_123_24 < arg_120_1.time_ and arg_120_1.time_ <= var_123_24 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_26 = arg_120_1:FormatText(StoryNameCfg[202].name)

				arg_120_1.leftNameTxt_.text = var_123_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_27 = arg_120_1:GetWordFromCfg(112211030)
				local var_123_28 = arg_120_1:FormatText(var_123_27.content)

				arg_120_1.text_.text = var_123_28

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_29 = 15
				local var_123_30 = utf8.len(var_123_28)
				local var_123_31 = var_123_29 <= 0 and var_123_25 or var_123_25 * (var_123_30 / var_123_29)

				if var_123_31 > 0 and var_123_25 < var_123_31 then
					arg_120_1.talkMaxDuration = var_123_31

					if var_123_31 + var_123_24 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_31 + var_123_24
					end
				end

				arg_120_1.text_.text = var_123_28
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211030", "story_v_out_112211.awb") ~= 0 then
					local var_123_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211030", "story_v_out_112211.awb") / 1000

					if var_123_32 + var_123_24 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_32 + var_123_24
					end

					if var_123_27.prefab_name ~= "" and arg_120_1.actors_[var_123_27.prefab_name] ~= nil then
						local var_123_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_27.prefab_name].transform, "story_v_out_112211", "112211030", "story_v_out_112211.awb")

						arg_120_1:RecordAudio("112211030", var_123_33)
						arg_120_1:RecordAudio("112211030", var_123_33)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_112211", "112211030", "story_v_out_112211.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_112211", "112211030", "story_v_out_112211.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_34 = math.max(var_123_25, arg_120_1.talkMaxDuration)

			if var_123_24 <= arg_120_1.time_ and arg_120_1.time_ < var_123_24 + var_123_34 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_24) / var_123_34

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_24 + var_123_34 and arg_120_1.time_ < var_123_24 + var_123_34 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play112211031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 112211031
		arg_124_1.duration_ = 16.17

		local var_124_0 = {
			ja = 12.133,
			ko = 8.266,
			zh = 9.1,
			en = 16.166
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
				arg_124_0:Play112211032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1081ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1081ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1081ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, 100, 0)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = arg_124_1.actors_["1039ui_story"].transform
			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1.var_.moveOldPos1039ui_story = var_127_9.localPosition
			end

			local var_127_11 = 0.001

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_11 then
				local var_127_12 = (arg_124_1.time_ - var_127_10) / var_127_11
				local var_127_13 = Vector3.New(0, -1.01, -5.9)

				var_127_9.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1039ui_story, var_127_13, var_127_12)

				local var_127_14 = manager.ui.mainCamera.transform.position - var_127_9.position

				var_127_9.forward = Vector3.New(var_127_14.x, var_127_14.y, var_127_14.z)

				local var_127_15 = var_127_9.localEulerAngles

				var_127_15.z = 0
				var_127_15.x = 0
				var_127_9.localEulerAngles = var_127_15
			end

			if arg_124_1.time_ >= var_127_10 + var_127_11 and arg_124_1.time_ < var_127_10 + var_127_11 + arg_127_0 then
				var_127_9.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_127_16 = manager.ui.mainCamera.transform.position - var_127_9.position

				var_127_9.forward = Vector3.New(var_127_16.x, var_127_16.y, var_127_16.z)

				local var_127_17 = var_127_9.localEulerAngles

				var_127_17.z = 0
				var_127_17.x = 0
				var_127_9.localEulerAngles = var_127_17
			end

			local var_127_18 = arg_124_1.actors_["1039ui_story"]
			local var_127_19 = 0

			if var_127_19 < arg_124_1.time_ and arg_124_1.time_ <= var_127_19 + arg_127_0 and not isNil(var_127_18) and arg_124_1.var_.characterEffect1039ui_story == nil then
				arg_124_1.var_.characterEffect1039ui_story = var_127_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_20 = 0.2

			if var_127_19 <= arg_124_1.time_ and arg_124_1.time_ < var_127_19 + var_127_20 and not isNil(var_127_18) then
				local var_127_21 = (arg_124_1.time_ - var_127_19) / var_127_20

				if arg_124_1.var_.characterEffect1039ui_story and not isNil(var_127_18) then
					arg_124_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_19 + var_127_20 and arg_124_1.time_ < var_127_19 + var_127_20 + arg_127_0 and not isNil(var_127_18) and arg_124_1.var_.characterEffect1039ui_story then
				arg_124_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_127_22 = 0

			if var_127_22 < arg_124_1.time_ and arg_124_1.time_ <= var_127_22 + arg_127_0 then
				arg_124_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			local var_127_23 = 0

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_127_24 = 0
			local var_127_25 = 1.15

			if var_127_24 < arg_124_1.time_ and arg_124_1.time_ <= var_127_24 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_26 = arg_124_1:FormatText(StoryNameCfg[9].name)

				arg_124_1.leftNameTxt_.text = var_127_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_27 = arg_124_1:GetWordFromCfg(112211031)
				local var_127_28 = arg_124_1:FormatText(var_127_27.content)

				arg_124_1.text_.text = var_127_28

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_29 = 46
				local var_127_30 = utf8.len(var_127_28)
				local var_127_31 = var_127_29 <= 0 and var_127_25 or var_127_25 * (var_127_30 / var_127_29)

				if var_127_31 > 0 and var_127_25 < var_127_31 then
					arg_124_1.talkMaxDuration = var_127_31

					if var_127_31 + var_127_24 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_31 + var_127_24
					end
				end

				arg_124_1.text_.text = var_127_28
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211031", "story_v_out_112211.awb") ~= 0 then
					local var_127_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211031", "story_v_out_112211.awb") / 1000

					if var_127_32 + var_127_24 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_32 + var_127_24
					end

					if var_127_27.prefab_name ~= "" and arg_124_1.actors_[var_127_27.prefab_name] ~= nil then
						local var_127_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_27.prefab_name].transform, "story_v_out_112211", "112211031", "story_v_out_112211.awb")

						arg_124_1:RecordAudio("112211031", var_127_33)
						arg_124_1:RecordAudio("112211031", var_127_33)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_112211", "112211031", "story_v_out_112211.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_112211", "112211031", "story_v_out_112211.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_34 = math.max(var_127_25, arg_124_1.talkMaxDuration)

			if var_127_24 <= arg_124_1.time_ and arg_124_1.time_ < var_127_24 + var_127_34 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_24) / var_127_34

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_24 + var_127_34 and arg_124_1.time_ < var_127_24 + var_127_34 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play112211032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 112211032
		arg_128_1.duration_ = 4.03

		local var_128_0 = {
			ja = 3.433,
			ko = 3.066,
			zh = 2.333,
			en = 4.033
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
				arg_128_0:Play112211033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1039ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1039ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(0, 100, 0)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1039ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, 100, 0)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = arg_128_1.actors_["1148ui_story"].transform
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1.var_.moveOldPos1148ui_story = var_131_9.localPosition
			end

			local var_131_11 = 0.001

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11
				local var_131_13 = Vector3.New(0, -0.8, -6.2)

				var_131_9.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1148ui_story, var_131_13, var_131_12)

				local var_131_14 = manager.ui.mainCamera.transform.position - var_131_9.position

				var_131_9.forward = Vector3.New(var_131_14.x, var_131_14.y, var_131_14.z)

				local var_131_15 = var_131_9.localEulerAngles

				var_131_15.z = 0
				var_131_15.x = 0
				var_131_9.localEulerAngles = var_131_15
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 then
				var_131_9.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_131_16 = manager.ui.mainCamera.transform.position - var_131_9.position

				var_131_9.forward = Vector3.New(var_131_16.x, var_131_16.y, var_131_16.z)

				local var_131_17 = var_131_9.localEulerAngles

				var_131_17.z = 0
				var_131_17.x = 0
				var_131_9.localEulerAngles = var_131_17
			end

			local var_131_18 = arg_128_1.actors_["1148ui_story"]
			local var_131_19 = 0

			if var_131_19 < arg_128_1.time_ and arg_128_1.time_ <= var_131_19 + arg_131_0 and not isNil(var_131_18) and arg_128_1.var_.characterEffect1148ui_story == nil then
				arg_128_1.var_.characterEffect1148ui_story = var_131_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_20 = 0.2

			if var_131_19 <= arg_128_1.time_ and arg_128_1.time_ < var_131_19 + var_131_20 and not isNil(var_131_18) then
				local var_131_21 = (arg_128_1.time_ - var_131_19) / var_131_20

				if arg_128_1.var_.characterEffect1148ui_story and not isNil(var_131_18) then
					arg_128_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_19 + var_131_20 and arg_128_1.time_ < var_131_19 + var_131_20 + arg_131_0 and not isNil(var_131_18) and arg_128_1.var_.characterEffect1148ui_story then
				arg_128_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_131_22 = 0

			if var_131_22 < arg_128_1.time_ and arg_128_1.time_ <= var_131_22 + arg_131_0 then
				arg_128_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_131_23 = 0

			if var_131_23 < arg_128_1.time_ and arg_128_1.time_ <= var_131_23 + arg_131_0 then
				arg_128_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_131_24 = 0
			local var_131_25 = 0.25

			if var_131_24 < arg_128_1.time_ and arg_128_1.time_ <= var_131_24 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_26 = arg_128_1:FormatText(StoryNameCfg[8].name)

				arg_128_1.leftNameTxt_.text = var_131_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_27 = arg_128_1:GetWordFromCfg(112211032)
				local var_131_28 = arg_128_1:FormatText(var_131_27.content)

				arg_128_1.text_.text = var_131_28

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_29 = 10
				local var_131_30 = utf8.len(var_131_28)
				local var_131_31 = var_131_29 <= 0 and var_131_25 or var_131_25 * (var_131_30 / var_131_29)

				if var_131_31 > 0 and var_131_25 < var_131_31 then
					arg_128_1.talkMaxDuration = var_131_31

					if var_131_31 + var_131_24 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_31 + var_131_24
					end
				end

				arg_128_1.text_.text = var_131_28
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211032", "story_v_out_112211.awb") ~= 0 then
					local var_131_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211032", "story_v_out_112211.awb") / 1000

					if var_131_32 + var_131_24 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_32 + var_131_24
					end

					if var_131_27.prefab_name ~= "" and arg_128_1.actors_[var_131_27.prefab_name] ~= nil then
						local var_131_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_27.prefab_name].transform, "story_v_out_112211", "112211032", "story_v_out_112211.awb")

						arg_128_1:RecordAudio("112211032", var_131_33)
						arg_128_1:RecordAudio("112211032", var_131_33)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_112211", "112211032", "story_v_out_112211.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_112211", "112211032", "story_v_out_112211.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_34 = math.max(var_131_25, arg_128_1.talkMaxDuration)

			if var_131_24 <= arg_128_1.time_ and arg_128_1.time_ < var_131_24 + var_131_34 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_24) / var_131_34

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_24 + var_131_34 and arg_128_1.time_ < var_131_24 + var_131_34 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play112211033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 112211033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play112211034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1148ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1148ui_story == nil then
				arg_132_1.var_.characterEffect1148ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1148ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1148ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1148ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1148ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_2")
			end

			local var_135_7 = 0
			local var_135_8 = 1.425

			if var_135_7 < arg_132_1.time_ and arg_132_1.time_ <= var_135_7 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_9 = arg_132_1:GetWordFromCfg(112211033)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 57
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_8 or var_135_8 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_8 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_7 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_7
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_8, arg_132_1.talkMaxDuration)

			if var_135_7 <= arg_132_1.time_ and arg_132_1.time_ < var_135_7 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_7) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_7 + var_135_14 and arg_132_1.time_ < var_135_7 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play112211034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 112211034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play112211035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.2

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[7].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(112211034)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 8
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_8 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_8 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_8

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_8 and arg_136_1.time_ < var_139_0 + var_139_8 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play112211035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 112211035
		arg_140_1.duration_ = 5.67

		local var_140_0 = {
			ja = 5.666,
			ko = 2.933,
			zh = 3.766,
			en = 5.4
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
				arg_140_0:Play112211036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1148ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1148ui_story == nil then
				arg_140_1.var_.characterEffect1148ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1148ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1148ui_story then
				arg_140_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_143_4 = 0

			if var_143_4 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_143_6 = 0
			local var_143_7 = 0.475

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[8].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_9 = arg_140_1:GetWordFromCfg(112211035)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 19
				local var_143_12 = utf8.len(var_143_10)
				local var_143_13 = var_143_11 <= 0 and var_143_7 or var_143_7 * (var_143_12 / var_143_11)

				if var_143_13 > 0 and var_143_7 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211035", "story_v_out_112211.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211035", "story_v_out_112211.awb") / 1000

					if var_143_14 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_6
					end

					if var_143_9.prefab_name ~= "" and arg_140_1.actors_[var_143_9.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_9.prefab_name].transform, "story_v_out_112211", "112211035", "story_v_out_112211.awb")

						arg_140_1:RecordAudio("112211035", var_143_15)
						arg_140_1:RecordAudio("112211035", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_112211", "112211035", "story_v_out_112211.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_112211", "112211035", "story_v_out_112211.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_16 and arg_140_1.time_ < var_143_6 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play112211036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 112211036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play112211037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1148ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1148ui_story == nil then
				arg_144_1.var_.characterEffect1148ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1148ui_story and not isNil(var_147_0) then
					local var_147_4 = Mathf.Lerp(0, 0.5, var_147_3)

					arg_144_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1148ui_story.fillRatio = var_147_4
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1148ui_story then
				local var_147_5 = 0.5

				arg_144_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1148ui_story.fillRatio = var_147_5
			end

			local var_147_6 = 0
			local var_147_7 = 0.45

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_8 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_8

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

				local var_147_9 = arg_144_1:GetWordFromCfg(112211036)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 18
				local var_147_12 = utf8.len(var_147_10)
				local var_147_13 = var_147_11 <= 0 and var_147_7 or var_147_7 * (var_147_12 / var_147_11)

				if var_147_13 > 0 and var_147_7 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_14 and arg_144_1.time_ < var_147_6 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play112211037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 112211037
		arg_148_1.duration_ = 6.8

		local var_148_0 = {
			ja = 6.8,
			ko = 4.733,
			zh = 4.1,
			en = 5.866
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play112211038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1148ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1148ui_story == nil then
				arg_148_1.var_.characterEffect1148ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1148ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1148ui_story then
				arg_148_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_151_4 = 0

			if var_151_4 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_151_6 = 0
			local var_151_7 = 0.5

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_8 = arg_148_1:FormatText(StoryNameCfg[8].name)

				arg_148_1.leftNameTxt_.text = var_151_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_9 = arg_148_1:GetWordFromCfg(112211037)
				local var_151_10 = arg_148_1:FormatText(var_151_9.content)

				arg_148_1.text_.text = var_151_10

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 20
				local var_151_12 = utf8.len(var_151_10)
				local var_151_13 = var_151_11 <= 0 and var_151_7 or var_151_7 * (var_151_12 / var_151_11)

				if var_151_13 > 0 and var_151_7 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_10
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211037", "story_v_out_112211.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211037", "story_v_out_112211.awb") / 1000

					if var_151_14 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_6
					end

					if var_151_9.prefab_name ~= "" and arg_148_1.actors_[var_151_9.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_9.prefab_name].transform, "story_v_out_112211", "112211037", "story_v_out_112211.awb")

						arg_148_1:RecordAudio("112211037", var_151_15)
						arg_148_1:RecordAudio("112211037", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_112211", "112211037", "story_v_out_112211.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_112211", "112211037", "story_v_out_112211.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_16 and arg_148_1.time_ < var_151_6 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play112211038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 112211038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play112211039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1148ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1148ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0, 100, 0)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1148ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, 100, 0)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = 0
			local var_155_10 = 0.05

			if var_155_9 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_11 = arg_152_1:FormatText(StoryNameCfg[7].name)

				arg_152_1.leftNameTxt_.text = var_155_11

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

				local var_155_12 = arg_152_1:GetWordFromCfg(112211038)
				local var_155_13 = arg_152_1:FormatText(var_155_12.content)

				arg_152_1.text_.text = var_155_13

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_14 = 2
				local var_155_15 = utf8.len(var_155_13)
				local var_155_16 = var_155_14 <= 0 and var_155_10 or var_155_10 * (var_155_15 / var_155_14)

				if var_155_16 > 0 and var_155_10 < var_155_16 then
					arg_152_1.talkMaxDuration = var_155_16

					if var_155_16 + var_155_9 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_16 + var_155_9
					end
				end

				arg_152_1.text_.text = var_155_13
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_17 = math.max(var_155_10, arg_152_1.talkMaxDuration)

			if var_155_9 <= arg_152_1.time_ and arg_152_1.time_ < var_155_9 + var_155_17 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_9) / var_155_17

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_9 + var_155_17 and arg_152_1.time_ < var_155_9 + var_155_17 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play112211039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 112211039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play112211040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 1.05

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

				local var_159_3 = arg_156_1:GetWordFromCfg(112211039)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 42
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
	Play112211040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 112211040
		arg_160_1.duration_ = 8.3

		local var_160_0 = {
			ja = 7.566,
			ko = 8.3,
			zh = 7.2,
			en = 6.6
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play112211041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = "1084ui_story"

			if arg_160_1.actors_[var_163_0] == nil then
				local var_163_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_163_1) then
					local var_163_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_160_1.stage_.transform)

					var_163_2.name = var_163_0
					var_163_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_160_1.actors_[var_163_0] = var_163_2

					local var_163_3 = var_163_2:GetComponentInChildren(typeof(CharacterEffect))

					var_163_3.enabled = true

					local var_163_4 = GameObjectTools.GetOrAddComponent(var_163_2, typeof(DynamicBoneHelper))

					if var_163_4 then
						var_163_4:EnableDynamicBone(false)
					end

					arg_160_1:ShowWeapon(var_163_3.transform, false)

					arg_160_1.var_[var_163_0 .. "Animator"] = var_163_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_160_1.var_[var_163_0 .. "Animator"].applyRootMotion = true
					arg_160_1.var_[var_163_0 .. "LipSync"] = var_163_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_163_5 = arg_160_1.actors_["1084ui_story"].transform
			local var_163_6 = 0

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.var_.moveOldPos1084ui_story = var_163_5.localPosition

				local var_163_7 = "1084ui_story"

				arg_160_1:ShowWeapon(arg_160_1.var_[var_163_7 .. "Animator"].transform, false)
			end

			local var_163_8 = 0.001

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_8 then
				local var_163_9 = (arg_160_1.time_ - var_163_6) / var_163_8
				local var_163_10 = Vector3.New(0, -0.97, -6)

				var_163_5.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1084ui_story, var_163_10, var_163_9)

				local var_163_11 = manager.ui.mainCamera.transform.position - var_163_5.position

				var_163_5.forward = Vector3.New(var_163_11.x, var_163_11.y, var_163_11.z)

				local var_163_12 = var_163_5.localEulerAngles

				var_163_12.z = 0
				var_163_12.x = 0
				var_163_5.localEulerAngles = var_163_12
			end

			if arg_160_1.time_ >= var_163_6 + var_163_8 and arg_160_1.time_ < var_163_6 + var_163_8 + arg_163_0 then
				var_163_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_163_13 = manager.ui.mainCamera.transform.position - var_163_5.position

				var_163_5.forward = Vector3.New(var_163_13.x, var_163_13.y, var_163_13.z)

				local var_163_14 = var_163_5.localEulerAngles

				var_163_14.z = 0
				var_163_14.x = 0
				var_163_5.localEulerAngles = var_163_14
			end

			local var_163_15 = arg_160_1.actors_["1084ui_story"]
			local var_163_16 = 0

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 and not isNil(var_163_15) and arg_160_1.var_.characterEffect1084ui_story == nil then
				arg_160_1.var_.characterEffect1084ui_story = var_163_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_17 = 0.2

			if var_163_16 <= arg_160_1.time_ and arg_160_1.time_ < var_163_16 + var_163_17 and not isNil(var_163_15) then
				local var_163_18 = (arg_160_1.time_ - var_163_16) / var_163_17

				if arg_160_1.var_.characterEffect1084ui_story and not isNil(var_163_15) then
					arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 and not isNil(var_163_15) and arg_160_1.var_.characterEffect1084ui_story then
				arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_163_19 = 0

			if var_163_19 < arg_160_1.time_ and arg_160_1.time_ <= var_163_19 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_163_20 = 0

			if var_163_20 < arg_160_1.time_ and arg_160_1.time_ <= var_163_20 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_163_21 = 0
			local var_163_22 = 0.9

			if var_163_21 < arg_160_1.time_ and arg_160_1.time_ <= var_163_21 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_23 = arg_160_1:FormatText(StoryNameCfg[6].name)

				arg_160_1.leftNameTxt_.text = var_163_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_24 = arg_160_1:GetWordFromCfg(112211040)
				local var_163_25 = arg_160_1:FormatText(var_163_24.content)

				arg_160_1.text_.text = var_163_25

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_26 = 36
				local var_163_27 = utf8.len(var_163_25)
				local var_163_28 = var_163_26 <= 0 and var_163_22 or var_163_22 * (var_163_27 / var_163_26)

				if var_163_28 > 0 and var_163_22 < var_163_28 then
					arg_160_1.talkMaxDuration = var_163_28

					if var_163_28 + var_163_21 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_28 + var_163_21
					end
				end

				arg_160_1.text_.text = var_163_25
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211040", "story_v_out_112211.awb") ~= 0 then
					local var_163_29 = manager.audio:GetVoiceLength("story_v_out_112211", "112211040", "story_v_out_112211.awb") / 1000

					if var_163_29 + var_163_21 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_29 + var_163_21
					end

					if var_163_24.prefab_name ~= "" and arg_160_1.actors_[var_163_24.prefab_name] ~= nil then
						local var_163_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_24.prefab_name].transform, "story_v_out_112211", "112211040", "story_v_out_112211.awb")

						arg_160_1:RecordAudio("112211040", var_163_30)
						arg_160_1:RecordAudio("112211040", var_163_30)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_112211", "112211040", "story_v_out_112211.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_112211", "112211040", "story_v_out_112211.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_31 = math.max(var_163_22, arg_160_1.talkMaxDuration)

			if var_163_21 <= arg_160_1.time_ and arg_160_1.time_ < var_163_21 + var_163_31 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_21) / var_163_31

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_21 + var_163_31 and arg_160_1.time_ < var_163_21 + var_163_31 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
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

		arg_160_1:InitPlayNodeList()
	end,
	Play112211041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 112211041
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play112211042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1084ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1084ui_story == nil then
				arg_164_1.var_.characterEffect1084ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.2

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1084ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1084ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1084ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1084ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 0.3

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_8 = arg_164_1:FormatText(StoryNameCfg[7].name)

				arg_164_1.leftNameTxt_.text = var_167_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_9 = arg_164_1:GetWordFromCfg(112211041)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 12
				local var_167_12 = utf8.len(var_167_10)
				local var_167_13 = var_167_11 <= 0 and var_167_7 or var_167_7 * (var_167_12 / var_167_11)

				if var_167_13 > 0 and var_167_7 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_10
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_14 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_14

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_14 and arg_164_1.time_ < var_167_6 + var_167_14 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play112211042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 112211042
		arg_168_1.duration_ = 10.77

		local var_168_0 = {
			ja = 8.566,
			ko = 10.333,
			zh = 8.333,
			en = 10.766
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play112211043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1084ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1084ui_story == nil then
				arg_168_1.var_.characterEffect1084ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1084ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1084ui_story then
				arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_171_4 = 0

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			local var_171_5 = 0

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_171_6 = 0
			local var_171_7 = 1.05

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_8 = arg_168_1:FormatText(StoryNameCfg[6].name)

				arg_168_1.leftNameTxt_.text = var_171_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_9 = arg_168_1:GetWordFromCfg(112211042)
				local var_171_10 = arg_168_1:FormatText(var_171_9.content)

				arg_168_1.text_.text = var_171_10

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211042", "story_v_out_112211.awb") ~= 0 then
					local var_171_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211042", "story_v_out_112211.awb") / 1000

					if var_171_14 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_14 + var_171_6
					end

					if var_171_9.prefab_name ~= "" and arg_168_1.actors_[var_171_9.prefab_name] ~= nil then
						local var_171_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_9.prefab_name].transform, "story_v_out_112211", "112211042", "story_v_out_112211.awb")

						arg_168_1:RecordAudio("112211042", var_171_15)
						arg_168_1:RecordAudio("112211042", var_171_15)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_112211", "112211042", "story_v_out_112211.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_112211", "112211042", "story_v_out_112211.awb")
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
	Play112211043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 112211043
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play112211044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1084ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1084ui_story == nil then
				arg_172_1.var_.characterEffect1084ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1084ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1084ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1084ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1084ui_story.fillRatio = var_175_5
			end

			local var_175_6 = 0
			local var_175_7 = 0.125

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_8 = arg_172_1:FormatText(StoryNameCfg[7].name)

				arg_172_1.leftNameTxt_.text = var_175_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_9 = arg_172_1:GetWordFromCfg(112211043)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 5
				local var_175_12 = utf8.len(var_175_10)
				local var_175_13 = var_175_11 <= 0 and var_175_7 or var_175_7 * (var_175_12 / var_175_11)

				if var_175_13 > 0 and var_175_7 < var_175_13 then
					arg_172_1.talkMaxDuration = var_175_13

					if var_175_13 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_14 and arg_172_1.time_ < var_175_6 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play112211044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 112211044
		arg_176_1.duration_ = 13.5

		local var_176_0 = {
			ja = 13.1,
			ko = 11.3,
			zh = 13.5,
			en = 11.033
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play112211045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1084ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1084ui_story == nil then
				arg_176_1.var_.characterEffect1084ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1084ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1084ui_story then
				arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_179_4 = 0

			if var_179_4 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action487")
			end

			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_179_6 = 0
			local var_179_7 = 1.05

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_8 = arg_176_1:FormatText(StoryNameCfg[6].name)

				arg_176_1.leftNameTxt_.text = var_179_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_9 = arg_176_1:GetWordFromCfg(112211044)
				local var_179_10 = arg_176_1:FormatText(var_179_9.content)

				arg_176_1.text_.text = var_179_10

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_11 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211044", "story_v_out_112211.awb") ~= 0 then
					local var_179_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211044", "story_v_out_112211.awb") / 1000

					if var_179_14 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_14 + var_179_6
					end

					if var_179_9.prefab_name ~= "" and arg_176_1.actors_[var_179_9.prefab_name] ~= nil then
						local var_179_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_9.prefab_name].transform, "story_v_out_112211", "112211044", "story_v_out_112211.awb")

						arg_176_1:RecordAudio("112211044", var_179_15)
						arg_176_1:RecordAudio("112211044", var_179_15)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_112211", "112211044", "story_v_out_112211.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_112211", "112211044", "story_v_out_112211.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_16 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_16 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_16

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_16 and arg_176_1.time_ < var_179_6 + var_179_16 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play112211045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 112211045
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play112211046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1084ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1084ui_story == nil then
				arg_180_1.var_.characterEffect1084ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1084ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1084ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1084ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1084ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 1.225

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_8 = arg_180_1:GetWordFromCfg(112211045)
				local var_183_9 = arg_180_1:FormatText(var_183_8.content)

				arg_180_1.text_.text = var_183_9

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_10 = 49
				local var_183_11 = utf8.len(var_183_9)
				local var_183_12 = var_183_10 <= 0 and var_183_7 or var_183_7 * (var_183_11 / var_183_10)

				if var_183_12 > 0 and var_183_7 < var_183_12 then
					arg_180_1.talkMaxDuration = var_183_12

					if var_183_12 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_12 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_9
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_13 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_13 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_13

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_13 and arg_180_1.time_ < var_183_6 + var_183_13 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play112211046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 112211046
		arg_184_1.duration_ = 6.07

		local var_184_0 = {
			ja = 4.4,
			ko = 6.066,
			zh = 4.6,
			en = 4.8
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play112211047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1084ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1084ui_story == nil then
				arg_184_1.var_.characterEffect1084ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1084ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1084ui_story then
				arg_184_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_187_4 = 0

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_187_6 = 0
			local var_187_7 = 0.45

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_8 = arg_184_1:FormatText(StoryNameCfg[6].name)

				arg_184_1.leftNameTxt_.text = var_187_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_9 = arg_184_1:GetWordFromCfg(112211046)
				local var_187_10 = arg_184_1:FormatText(var_187_9.content)

				arg_184_1.text_.text = var_187_10

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211046", "story_v_out_112211.awb") ~= 0 then
					local var_187_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211046", "story_v_out_112211.awb") / 1000

					if var_187_14 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_6
					end

					if var_187_9.prefab_name ~= "" and arg_184_1.actors_[var_187_9.prefab_name] ~= nil then
						local var_187_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_9.prefab_name].transform, "story_v_out_112211", "112211046", "story_v_out_112211.awb")

						arg_184_1:RecordAudio("112211046", var_187_15)
						arg_184_1:RecordAudio("112211046", var_187_15)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_112211", "112211046", "story_v_out_112211.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_112211", "112211046", "story_v_out_112211.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_16 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_16 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_16

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_16 and arg_184_1.time_ < var_187_6 + var_187_16 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play112211047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 112211047
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play112211048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1084ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1084ui_story == nil then
				arg_188_1.var_.characterEffect1084ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1084ui_story and not isNil(var_191_0) then
					local var_191_4 = Mathf.Lerp(0, 0.5, var_191_3)

					arg_188_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1084ui_story.fillRatio = var_191_4
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1084ui_story then
				local var_191_5 = 0.5

				arg_188_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1084ui_story.fillRatio = var_191_5
			end

			local var_191_6 = 0
			local var_191_7 = 0.95

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_8 = arg_188_1:GetWordFromCfg(112211047)
				local var_191_9 = arg_188_1:FormatText(var_191_8.content)

				arg_188_1.text_.text = var_191_9

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_10 = 38
				local var_191_11 = utf8.len(var_191_9)
				local var_191_12 = var_191_10 <= 0 and var_191_7 or var_191_7 * (var_191_11 / var_191_10)

				if var_191_12 > 0 and var_191_7 < var_191_12 then
					arg_188_1.talkMaxDuration = var_191_12

					if var_191_12 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_12 + var_191_6
					end
				end

				arg_188_1.text_.text = var_191_9
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_13 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_13 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_13

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_13 and arg_188_1.time_ < var_191_6 + var_191_13 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play112211048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 112211048
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play112211049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.1

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[7].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:GetWordFromCfg(112211048)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 4
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_8 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_8 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_8

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_8 and arg_192_1.time_ < var_195_0 + var_195_8 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play112211049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 112211049
		arg_196_1.duration_ = 9.9

		local var_196_0 = {
			ja = 7.333,
			ko = 7.333,
			zh = 5.466,
			en = 9.9
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play112211050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1084ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1084ui_story = var_199_0.localPosition
			end

			local var_199_2 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2
				local var_199_4 = Vector3.New(-0.7, -0.97, -6)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1084ui_story, var_199_4, var_199_3)

				local var_199_5 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_5.x, var_199_5.y, var_199_5.z)

				local var_199_6 = var_199_0.localEulerAngles

				var_199_6.z = 0
				var_199_6.x = 0
				var_199_0.localEulerAngles = var_199_6
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_199_7 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_7.x, var_199_7.y, var_199_7.z)

				local var_199_8 = var_199_0.localEulerAngles

				var_199_8.z = 0
				var_199_8.x = 0
				var_199_0.localEulerAngles = var_199_8
			end

			local var_199_9 = arg_196_1.actors_["1148ui_story"].transform
			local var_199_10 = 0

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 then
				arg_196_1.var_.moveOldPos1148ui_story = var_199_9.localPosition
			end

			local var_199_11 = 0.001

			if var_199_10 <= arg_196_1.time_ and arg_196_1.time_ < var_199_10 + var_199_11 then
				local var_199_12 = (arg_196_1.time_ - var_199_10) / var_199_11
				local var_199_13 = Vector3.New(0.7, -0.8, -6.2)

				var_199_9.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1148ui_story, var_199_13, var_199_12)

				local var_199_14 = manager.ui.mainCamera.transform.position - var_199_9.position

				var_199_9.forward = Vector3.New(var_199_14.x, var_199_14.y, var_199_14.z)

				local var_199_15 = var_199_9.localEulerAngles

				var_199_15.z = 0
				var_199_15.x = 0
				var_199_9.localEulerAngles = var_199_15
			end

			if arg_196_1.time_ >= var_199_10 + var_199_11 and arg_196_1.time_ < var_199_10 + var_199_11 + arg_199_0 then
				var_199_9.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_199_16 = manager.ui.mainCamera.transform.position - var_199_9.position

				var_199_9.forward = Vector3.New(var_199_16.x, var_199_16.y, var_199_16.z)

				local var_199_17 = var_199_9.localEulerAngles

				var_199_17.z = 0
				var_199_17.x = 0
				var_199_9.localEulerAngles = var_199_17
			end

			local var_199_18 = arg_196_1.actors_["1148ui_story"]
			local var_199_19 = 0

			if var_199_19 < arg_196_1.time_ and arg_196_1.time_ <= var_199_19 + arg_199_0 and not isNil(var_199_18) and arg_196_1.var_.characterEffect1148ui_story == nil then
				arg_196_1.var_.characterEffect1148ui_story = var_199_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_20 = 0.2

			if var_199_19 <= arg_196_1.time_ and arg_196_1.time_ < var_199_19 + var_199_20 and not isNil(var_199_18) then
				local var_199_21 = (arg_196_1.time_ - var_199_19) / var_199_20

				if arg_196_1.var_.characterEffect1148ui_story and not isNil(var_199_18) then
					arg_196_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_19 + var_199_20 and arg_196_1.time_ < var_199_19 + var_199_20 + arg_199_0 and not isNil(var_199_18) and arg_196_1.var_.characterEffect1148ui_story then
				arg_196_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_199_22 = 0

			if var_199_22 < arg_196_1.time_ and arg_196_1.time_ <= var_199_22 + arg_199_0 then
				arg_196_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_199_23 = 0

			if var_199_23 < arg_196_1.time_ and arg_196_1.time_ <= var_199_23 + arg_199_0 then
				arg_196_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_199_24 = 0
			local var_199_25 = 0.625

			if var_199_24 < arg_196_1.time_ and arg_196_1.time_ <= var_199_24 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_26 = arg_196_1:FormatText(StoryNameCfg[8].name)

				arg_196_1.leftNameTxt_.text = var_199_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_27 = arg_196_1:GetWordFromCfg(112211049)
				local var_199_28 = arg_196_1:FormatText(var_199_27.content)

				arg_196_1.text_.text = var_199_28

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_29 = 25
				local var_199_30 = utf8.len(var_199_28)
				local var_199_31 = var_199_29 <= 0 and var_199_25 or var_199_25 * (var_199_30 / var_199_29)

				if var_199_31 > 0 and var_199_25 < var_199_31 then
					arg_196_1.talkMaxDuration = var_199_31

					if var_199_31 + var_199_24 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_31 + var_199_24
					end
				end

				arg_196_1.text_.text = var_199_28
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211049", "story_v_out_112211.awb") ~= 0 then
					local var_199_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211049", "story_v_out_112211.awb") / 1000

					if var_199_32 + var_199_24 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_32 + var_199_24
					end

					if var_199_27.prefab_name ~= "" and arg_196_1.actors_[var_199_27.prefab_name] ~= nil then
						local var_199_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_27.prefab_name].transform, "story_v_out_112211", "112211049", "story_v_out_112211.awb")

						arg_196_1:RecordAudio("112211049", var_199_33)
						arg_196_1:RecordAudio("112211049", var_199_33)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_112211", "112211049", "story_v_out_112211.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_112211", "112211049", "story_v_out_112211.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_34 = math.max(var_199_25, arg_196_1.talkMaxDuration)

			if var_199_24 <= arg_196_1.time_ and arg_196_1.time_ < var_199_24 + var_199_34 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_24) / var_199_34

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_24 + var_199_34 and arg_196_1.time_ < var_199_24 + var_199_34 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play112211050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 112211050
		arg_200_1.duration_ = 3.43

		local var_200_0 = {
			ja = 3.433,
			ko = 3.033,
			zh = 3.166,
			en = 2.6
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play112211051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1148ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1148ui_story == nil then
				arg_200_1.var_.characterEffect1148ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.2

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect1148ui_story and not isNil(var_203_0) then
					local var_203_4 = Mathf.Lerp(0, 0.5, var_203_3)

					arg_200_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1148ui_story.fillRatio = var_203_4
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1148ui_story then
				local var_203_5 = 0.5

				arg_200_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1148ui_story.fillRatio = var_203_5
			end

			local var_203_6 = arg_200_1.actors_["1084ui_story"]
			local var_203_7 = 0

			if var_203_7 < arg_200_1.time_ and arg_200_1.time_ <= var_203_7 + arg_203_0 and not isNil(var_203_6) and arg_200_1.var_.characterEffect1084ui_story == nil then
				arg_200_1.var_.characterEffect1084ui_story = var_203_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_8 = 0.2

			if var_203_7 <= arg_200_1.time_ and arg_200_1.time_ < var_203_7 + var_203_8 and not isNil(var_203_6) then
				local var_203_9 = (arg_200_1.time_ - var_203_7) / var_203_8

				if arg_200_1.var_.characterEffect1084ui_story and not isNil(var_203_6) then
					arg_200_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_7 + var_203_8 and arg_200_1.time_ < var_203_7 + var_203_8 + arg_203_0 and not isNil(var_203_6) and arg_200_1.var_.characterEffect1084ui_story then
				arg_200_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_203_10 = 0

			if var_203_10 < arg_200_1.time_ and arg_200_1.time_ <= var_203_10 + arg_203_0 then
				arg_200_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action484")
			end

			local var_203_11 = 0

			if var_203_11 < arg_200_1.time_ and arg_200_1.time_ <= var_203_11 + arg_203_0 then
				arg_200_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_203_12 = 0
			local var_203_13 = 0.15

			if var_203_12 < arg_200_1.time_ and arg_200_1.time_ <= var_203_12 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_14 = arg_200_1:FormatText(StoryNameCfg[6].name)

				arg_200_1.leftNameTxt_.text = var_203_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_15 = arg_200_1:GetWordFromCfg(112211050)
				local var_203_16 = arg_200_1:FormatText(var_203_15.content)

				arg_200_1.text_.text = var_203_16

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_17 = 6
				local var_203_18 = utf8.len(var_203_16)
				local var_203_19 = var_203_17 <= 0 and var_203_13 or var_203_13 * (var_203_18 / var_203_17)

				if var_203_19 > 0 and var_203_13 < var_203_19 then
					arg_200_1.talkMaxDuration = var_203_19

					if var_203_19 + var_203_12 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_19 + var_203_12
					end
				end

				arg_200_1.text_.text = var_203_16
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211050", "story_v_out_112211.awb") ~= 0 then
					local var_203_20 = manager.audio:GetVoiceLength("story_v_out_112211", "112211050", "story_v_out_112211.awb") / 1000

					if var_203_20 + var_203_12 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_20 + var_203_12
					end

					if var_203_15.prefab_name ~= "" and arg_200_1.actors_[var_203_15.prefab_name] ~= nil then
						local var_203_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_15.prefab_name].transform, "story_v_out_112211", "112211050", "story_v_out_112211.awb")

						arg_200_1:RecordAudio("112211050", var_203_21)
						arg_200_1:RecordAudio("112211050", var_203_21)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_112211", "112211050", "story_v_out_112211.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_112211", "112211050", "story_v_out_112211.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_22 = math.max(var_203_13, arg_200_1.talkMaxDuration)

			if var_203_12 <= arg_200_1.time_ and arg_200_1.time_ < var_203_12 + var_203_22 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_12) / var_203_22

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_12 + var_203_22 and arg_200_1.time_ < var_203_12 + var_203_22 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play112211051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 112211051
		arg_204_1.duration_ = 12.37

		local var_204_0 = {
			ja = 12.366,
			ko = 8.466,
			zh = 8,
			en = 9.7
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play112211052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1148ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1148ui_story == nil then
				arg_204_1.var_.characterEffect1148ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.2

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1148ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1148ui_story then
				arg_204_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_207_4 = arg_204_1.actors_["1084ui_story"]
			local var_207_5 = 0

			if var_207_5 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1084ui_story == nil then
				arg_204_1.var_.characterEffect1084ui_story = var_207_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_6 = 0.2

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_6 and not isNil(var_207_4) then
				local var_207_7 = (arg_204_1.time_ - var_207_5) / var_207_6

				if arg_204_1.var_.characterEffect1084ui_story and not isNil(var_207_4) then
					local var_207_8 = Mathf.Lerp(0, 0.5, var_207_7)

					arg_204_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1084ui_story.fillRatio = var_207_8
				end
			end

			if arg_204_1.time_ >= var_207_5 + var_207_6 and arg_204_1.time_ < var_207_5 + var_207_6 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1084ui_story then
				local var_207_9 = 0.5

				arg_204_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1084ui_story.fillRatio = var_207_9
			end

			local var_207_10 = 0

			if var_207_10 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 then
				arg_204_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action476")
			end

			local var_207_11 = 0

			if var_207_11 < arg_204_1.time_ and arg_204_1.time_ <= var_207_11 + arg_207_0 then
				arg_204_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_207_12 = 0
			local var_207_13 = 0.825

			if var_207_12 < arg_204_1.time_ and arg_204_1.time_ <= var_207_12 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_14 = arg_204_1:FormatText(StoryNameCfg[8].name)

				arg_204_1.leftNameTxt_.text = var_207_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_15 = arg_204_1:GetWordFromCfg(112211051)
				local var_207_16 = arg_204_1:FormatText(var_207_15.content)

				arg_204_1.text_.text = var_207_16

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_17 = 33
				local var_207_18 = utf8.len(var_207_16)
				local var_207_19 = var_207_17 <= 0 and var_207_13 or var_207_13 * (var_207_18 / var_207_17)

				if var_207_19 > 0 and var_207_13 < var_207_19 then
					arg_204_1.talkMaxDuration = var_207_19

					if var_207_19 + var_207_12 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_19 + var_207_12
					end
				end

				arg_204_1.text_.text = var_207_16
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211051", "story_v_out_112211.awb") ~= 0 then
					local var_207_20 = manager.audio:GetVoiceLength("story_v_out_112211", "112211051", "story_v_out_112211.awb") / 1000

					if var_207_20 + var_207_12 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_20 + var_207_12
					end

					if var_207_15.prefab_name ~= "" and arg_204_1.actors_[var_207_15.prefab_name] ~= nil then
						local var_207_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_15.prefab_name].transform, "story_v_out_112211", "112211051", "story_v_out_112211.awb")

						arg_204_1:RecordAudio("112211051", var_207_21)
						arg_204_1:RecordAudio("112211051", var_207_21)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_112211", "112211051", "story_v_out_112211.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_112211", "112211051", "story_v_out_112211.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_22 = math.max(var_207_13, arg_204_1.talkMaxDuration)

			if var_207_12 <= arg_204_1.time_ and arg_204_1.time_ < var_207_12 + var_207_22 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_12) / var_207_22

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_12 + var_207_22 and arg_204_1.time_ < var_207_12 + var_207_22 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play112211052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 112211052
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play112211053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1148ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1148ui_story == nil then
				arg_208_1.var_.characterEffect1148ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.2

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect1148ui_story and not isNil(var_211_0) then
					local var_211_4 = Mathf.Lerp(0, 0.5, var_211_3)

					arg_208_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1148ui_story.fillRatio = var_211_4
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1148ui_story then
				local var_211_5 = 0.5

				arg_208_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1148ui_story.fillRatio = var_211_5
			end

			local var_211_6 = 0
			local var_211_7 = 0.75

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_8 = arg_208_1:GetWordFromCfg(112211052)
				local var_211_9 = arg_208_1:FormatText(var_211_8.content)

				arg_208_1.text_.text = var_211_9

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_10 = 30
				local var_211_11 = utf8.len(var_211_9)
				local var_211_12 = var_211_10 <= 0 and var_211_7 or var_211_7 * (var_211_11 / var_211_10)

				if var_211_12 > 0 and var_211_7 < var_211_12 then
					arg_208_1.talkMaxDuration = var_211_12

					if var_211_12 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_12 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_9
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_13 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_13 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_13

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_13 and arg_208_1.time_ < var_211_6 + var_211_13 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play112211053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 112211053
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play112211054(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.bgs_.H02a
			local var_215_1 = 2

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				local var_215_2 = var_215_0:GetComponent("SpriteRenderer")

				if var_215_2 then
					arg_212_1.var_.alphaOldValueH02a = var_215_2.color.a
					arg_212_1.var_.alphaMatValueH02a = var_215_2
				end

				arg_212_1.var_.alphaOldValueH02a = 1
			end

			local var_215_3 = 2

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_3 then
				local var_215_4 = (arg_212_1.time_ - var_215_1) / var_215_3
				local var_215_5 = Mathf.Lerp(arg_212_1.var_.alphaOldValueH02a, 0, var_215_4)

				if arg_212_1.var_.alphaMatValueH02a then
					local var_215_6 = arg_212_1.var_.alphaMatValueH02a.color

					var_215_6.a = var_215_5
					arg_212_1.var_.alphaMatValueH02a.color = var_215_6
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_3 and arg_212_1.time_ < var_215_1 + var_215_3 + arg_215_0 and arg_212_1.var_.alphaMatValueH02a then
				local var_215_7 = arg_212_1.var_.alphaMatValueH02a
				local var_215_8 = var_215_7.color

				var_215_8.a = 0
				var_215_7.color = var_215_8
			end

			local var_215_9 = 0

			if var_215_9 < arg_212_1.time_ and arg_212_1.time_ <= var_215_9 + arg_215_0 then
				arg_212_1.allBtn_.enabled = false
			end

			local var_215_10 = 4

			if arg_212_1.time_ >= var_215_9 + var_215_10 and arg_212_1.time_ < var_215_9 + var_215_10 + arg_215_0 then
				arg_212_1.allBtn_.enabled = true
			end

			local var_215_11 = arg_212_1.actors_["1148ui_story"].transform
			local var_215_12 = 0

			if var_215_12 < arg_212_1.time_ and arg_212_1.time_ <= var_215_12 + arg_215_0 then
				arg_212_1.var_.moveOldPos1148ui_story = var_215_11.localPosition
			end

			local var_215_13 = 0.001

			if var_215_12 <= arg_212_1.time_ and arg_212_1.time_ < var_215_12 + var_215_13 then
				local var_215_14 = (arg_212_1.time_ - var_215_12) / var_215_13
				local var_215_15 = Vector3.New(0, 100, 0)

				var_215_11.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1148ui_story, var_215_15, var_215_14)

				local var_215_16 = manager.ui.mainCamera.transform.position - var_215_11.position

				var_215_11.forward = Vector3.New(var_215_16.x, var_215_16.y, var_215_16.z)

				local var_215_17 = var_215_11.localEulerAngles

				var_215_17.z = 0
				var_215_17.x = 0
				var_215_11.localEulerAngles = var_215_17
			end

			if arg_212_1.time_ >= var_215_12 + var_215_13 and arg_212_1.time_ < var_215_12 + var_215_13 + arg_215_0 then
				var_215_11.localPosition = Vector3.New(0, 100, 0)

				local var_215_18 = manager.ui.mainCamera.transform.position - var_215_11.position

				var_215_11.forward = Vector3.New(var_215_18.x, var_215_18.y, var_215_18.z)

				local var_215_19 = var_215_11.localEulerAngles

				var_215_19.z = 0
				var_215_19.x = 0
				var_215_11.localEulerAngles = var_215_19
			end

			local var_215_20 = arg_212_1.actors_["1084ui_story"].transform
			local var_215_21 = 0

			if var_215_21 < arg_212_1.time_ and arg_212_1.time_ <= var_215_21 + arg_215_0 then
				arg_212_1.var_.moveOldPos1084ui_story = var_215_20.localPosition
			end

			local var_215_22 = 0.001

			if var_215_21 <= arg_212_1.time_ and arg_212_1.time_ < var_215_21 + var_215_22 then
				local var_215_23 = (arg_212_1.time_ - var_215_21) / var_215_22
				local var_215_24 = Vector3.New(0, 100, 0)

				var_215_20.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1084ui_story, var_215_24, var_215_23)

				local var_215_25 = manager.ui.mainCamera.transform.position - var_215_20.position

				var_215_20.forward = Vector3.New(var_215_25.x, var_215_25.y, var_215_25.z)

				local var_215_26 = var_215_20.localEulerAngles

				var_215_26.z = 0
				var_215_26.x = 0
				var_215_20.localEulerAngles = var_215_26
			end

			if arg_212_1.time_ >= var_215_21 + var_215_22 and arg_212_1.time_ < var_215_21 + var_215_22 + arg_215_0 then
				var_215_20.localPosition = Vector3.New(0, 100, 0)

				local var_215_27 = manager.ui.mainCamera.transform.position - var_215_20.position

				var_215_20.forward = Vector3.New(var_215_27.x, var_215_27.y, var_215_27.z)

				local var_215_28 = var_215_20.localEulerAngles

				var_215_28.z = 0
				var_215_28.x = 0
				var_215_20.localEulerAngles = var_215_28
			end

			local var_215_29 = 0
			local var_215_30 = 1.175

			if var_215_29 < arg_212_1.time_ and arg_212_1.time_ <= var_215_29 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_31 = arg_212_1:GetWordFromCfg(112211053)
				local var_215_32 = arg_212_1:FormatText(var_215_31.content)

				arg_212_1.text_.text = var_215_32

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_33 = 47
				local var_215_34 = utf8.len(var_215_32)
				local var_215_35 = var_215_33 <= 0 and var_215_30 or var_215_30 * (var_215_34 / var_215_33)

				if var_215_35 > 0 and var_215_30 < var_215_35 then
					arg_212_1.talkMaxDuration = var_215_35

					if var_215_35 + var_215_29 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_35 + var_215_29
					end
				end

				arg_212_1.text_.text = var_215_32
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_36 = math.max(var_215_30, arg_212_1.talkMaxDuration)

			if var_215_29 <= arg_212_1.time_ and arg_212_1.time_ < var_215_29 + var_215_36 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_29) / var_215_36

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_29 + var_215_36 and arg_212_1.time_ < var_215_29 + var_215_36 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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

		arg_212_1:InitPlayNodeList()
	end,
	Play112211054 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 112211054
		arg_216_1.duration_ = 8.02

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play112211055(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_1 = 2

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_1 then
				local var_219_2 = (arg_216_1.time_ - var_219_0) / var_219_1
				local var_219_3 = Color.New(0.0471698, 0.04650231, 0.04650231)

				var_219_3.a = Mathf.Lerp(1, 0, var_219_2)
				arg_216_1.mask_.color = var_219_3
			end

			if arg_216_1.time_ >= var_219_0 + var_219_1 and arg_216_1.time_ < var_219_0 + var_219_1 + arg_219_0 then
				local var_219_4 = Color.New(0.0471698, 0.04650231, 0.04650231)
				local var_219_5 = 0

				arg_216_1.mask_.enabled = false
				var_219_4.a = var_219_5
				arg_216_1.mask_.color = var_219_4
			end

			local var_219_6 = arg_216_1.bgs_.H02a
			local var_219_7 = 0

			if var_219_7 < arg_216_1.time_ and arg_216_1.time_ <= var_219_7 + arg_219_0 then
				local var_219_8 = var_219_6:GetComponent("SpriteRenderer")

				if var_219_8 then
					arg_216_1.var_.alphaOldValueH02a = var_219_8.color.a
					arg_216_1.var_.alphaMatValueH02a = var_219_8
				end

				arg_216_1.var_.alphaOldValueH02a = 0
			end

			local var_219_9 = 0.0166666666666667

			if var_219_7 <= arg_216_1.time_ and arg_216_1.time_ < var_219_7 + var_219_9 then
				local var_219_10 = (arg_216_1.time_ - var_219_7) / var_219_9
				local var_219_11 = Mathf.Lerp(arg_216_1.var_.alphaOldValueH02a, 1, var_219_10)

				if arg_216_1.var_.alphaMatValueH02a then
					local var_219_12 = arg_216_1.var_.alphaMatValueH02a.color

					var_219_12.a = var_219_11
					arg_216_1.var_.alphaMatValueH02a.color = var_219_12
				end
			end

			if arg_216_1.time_ >= var_219_7 + var_219_9 and arg_216_1.time_ < var_219_7 + var_219_9 + arg_219_0 and arg_216_1.var_.alphaMatValueH02a then
				local var_219_13 = arg_216_1.var_.alphaMatValueH02a
				local var_219_14 = var_219_13.color

				var_219_14.a = 1
				var_219_13.color = var_219_14
			end

			local var_219_15 = "H02a_blur"

			if arg_216_1.bgs_[var_219_15] == nil then
				local var_219_16 = Object.Instantiate(arg_216_1.blurPaintGo_)
				local var_219_17 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_219_15)

				var_219_16:GetComponent("SpriteRenderer").sprite = var_219_17
				var_219_16.name = var_219_15
				var_219_16.transform.parent = arg_216_1.stage_.transform
				var_219_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.bgs_[var_219_15] = var_219_16
			end

			local var_219_18 = 0.0166666666666667
			local var_219_19 = arg_216_1.bgs_[var_219_15]

			if var_219_18 < arg_216_1.time_ and arg_216_1.time_ <= var_219_18 + arg_219_0 then
				local var_219_20 = manager.ui.mainCamera.transform.localPosition
				local var_219_21 = Vector3.New(0, 0, 10) + Vector3.New(var_219_20.x, var_219_20.y, 0)

				var_219_19.transform.localPosition = var_219_21
				var_219_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_219_22 = var_219_19:GetComponent("SpriteRenderer")

				if var_219_22 and var_219_22.sprite then
					local var_219_23 = (var_219_19.transform.localPosition - var_219_20).z
					local var_219_24 = manager.ui.mainCameraCom_
					local var_219_25 = 2 * var_219_23 * Mathf.Tan(var_219_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_219_26 = var_219_25 * var_219_24.aspect
					local var_219_27 = var_219_22.sprite.bounds.size.x
					local var_219_28 = var_219_22.sprite.bounds.size.y
					local var_219_29 = var_219_26 / var_219_27
					local var_219_30 = var_219_25 / var_219_28
					local var_219_31 = var_219_30 < var_219_29 and var_219_29 or var_219_30

					var_219_19.transform.localScale = Vector3.New(var_219_31, var_219_31, 0)
				end
			end

			local var_219_32 = 3

			if var_219_18 <= arg_216_1.time_ and arg_216_1.time_ < var_219_18 + var_219_32 then
				local var_219_33 = (arg_216_1.time_ - var_219_18) / var_219_32
				local var_219_34 = Color.New(1, 1, 1)

				var_219_34.a = Mathf.Lerp(1, 0, var_219_33)

				var_219_19:GetComponent("SpriteRenderer").material:SetColor("_Color", var_219_34)
			end

			local var_219_35 = 0

			if var_219_35 < arg_216_1.time_ and arg_216_1.time_ <= var_219_35 + arg_219_0 then
				arg_216_1.allBtn_.enabled = false
			end

			local var_219_36 = 3.01666666666667

			if arg_216_1.time_ >= var_219_35 + var_219_36 and arg_216_1.time_ < var_219_35 + var_219_36 + arg_219_0 then
				arg_216_1.allBtn_.enabled = true
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_37 = 3.01666666666667
			local var_219_38 = 0.875

			if var_219_37 < arg_216_1.time_ and arg_216_1.time_ <= var_219_37 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_39 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_39:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_216_1.dialogCg_.alpha = arg_220_0
				end))
				var_219_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_40 = arg_216_1:GetWordFromCfg(112211054)
				local var_219_41 = arg_216_1:FormatText(var_219_40.content)

				arg_216_1.text_.text = var_219_41

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_42 = 35
				local var_219_43 = utf8.len(var_219_41)
				local var_219_44 = var_219_42 <= 0 and var_219_38 or var_219_38 * (var_219_43 / var_219_42)

				if var_219_44 > 0 and var_219_38 < var_219_44 then
					arg_216_1.talkMaxDuration = var_219_44
					var_219_37 = var_219_37 + 0.3

					if var_219_44 + var_219_37 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_44 + var_219_37
					end
				end

				arg_216_1.text_.text = var_219_41
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_45 = var_219_37 + 0.3
			local var_219_46 = math.max(var_219_38, arg_216_1.talkMaxDuration)

			if var_219_45 <= arg_216_1.time_ and arg_216_1.time_ < var_219_45 + var_219_46 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_45) / var_219_46

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_45 + var_219_46 and arg_216_1.time_ < var_219_45 + var_219_46 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play112211055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 112211055
		arg_222_1.duration_ = 3.5

		local var_222_0 = {
			ja = 3.5,
			ko = 2.533,
			zh = 2.933,
			en = 2.833
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play112211056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1084ui_story"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos1084ui_story = var_225_0.localPosition
			end

			local var_225_2 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2
				local var_225_4 = Vector3.New(0, -0.97, -6)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1084ui_story, var_225_4, var_225_3)

				local var_225_5 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_5.x, var_225_5.y, var_225_5.z)

				local var_225_6 = var_225_0.localEulerAngles

				var_225_6.z = 0
				var_225_6.x = 0
				var_225_0.localEulerAngles = var_225_6
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_225_7 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_7.x, var_225_7.y, var_225_7.z)

				local var_225_8 = var_225_0.localEulerAngles

				var_225_8.z = 0
				var_225_8.x = 0
				var_225_0.localEulerAngles = var_225_8
			end

			local var_225_9 = arg_222_1.actors_["1084ui_story"]
			local var_225_10 = 0

			if var_225_10 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect1084ui_story == nil then
				arg_222_1.var_.characterEffect1084ui_story = var_225_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_11 = 0.2

			if var_225_10 <= arg_222_1.time_ and arg_222_1.time_ < var_225_10 + var_225_11 and not isNil(var_225_9) then
				local var_225_12 = (arg_222_1.time_ - var_225_10) / var_225_11

				if arg_222_1.var_.characterEffect1084ui_story and not isNil(var_225_9) then
					arg_222_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_10 + var_225_11 and arg_222_1.time_ < var_225_10 + var_225_11 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect1084ui_story then
				arg_222_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_225_13 = 0

			if var_225_13 < arg_222_1.time_ and arg_222_1.time_ <= var_225_13 + arg_225_0 then
				arg_222_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_225_14 = 0

			if var_225_14 < arg_222_1.time_ and arg_222_1.time_ <= var_225_14 + arg_225_0 then
				arg_222_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_225_15 = 0
			local var_225_16 = 0.25

			if var_225_15 < arg_222_1.time_ and arg_222_1.time_ <= var_225_15 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_17 = arg_222_1:FormatText(StoryNameCfg[6].name)

				arg_222_1.leftNameTxt_.text = var_225_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_18 = arg_222_1:GetWordFromCfg(112211055)
				local var_225_19 = arg_222_1:FormatText(var_225_18.content)

				arg_222_1.text_.text = var_225_19

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_20 = 10
				local var_225_21 = utf8.len(var_225_19)
				local var_225_22 = var_225_20 <= 0 and var_225_16 or var_225_16 * (var_225_21 / var_225_20)

				if var_225_22 > 0 and var_225_16 < var_225_22 then
					arg_222_1.talkMaxDuration = var_225_22

					if var_225_22 + var_225_15 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_22 + var_225_15
					end
				end

				arg_222_1.text_.text = var_225_19
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211055", "story_v_out_112211.awb") ~= 0 then
					local var_225_23 = manager.audio:GetVoiceLength("story_v_out_112211", "112211055", "story_v_out_112211.awb") / 1000

					if var_225_23 + var_225_15 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_23 + var_225_15
					end

					if var_225_18.prefab_name ~= "" and arg_222_1.actors_[var_225_18.prefab_name] ~= nil then
						local var_225_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_18.prefab_name].transform, "story_v_out_112211", "112211055", "story_v_out_112211.awb")

						arg_222_1:RecordAudio("112211055", var_225_24)
						arg_222_1:RecordAudio("112211055", var_225_24)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_112211", "112211055", "story_v_out_112211.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_112211", "112211055", "story_v_out_112211.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_25 = math.max(var_225_16, arg_222_1.talkMaxDuration)

			if var_225_15 <= arg_222_1.time_ and arg_222_1.time_ < var_225_15 + var_225_25 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_15) / var_225_25

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_15 + var_225_25 and arg_222_1.time_ < var_225_15 + var_225_25 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play112211056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 112211056
		arg_226_1.duration_ = 8.87

		local var_226_0 = {
			ja = 8.866,
			ko = 8.333,
			zh = 6.066,
			en = 8.066
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play112211057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1084ui_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos1084ui_story = var_229_0.localPosition
			end

			local var_229_2 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2
				local var_229_4 = Vector3.New(0, 100, 0)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1084ui_story, var_229_4, var_229_3)

				local var_229_5 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_5.x, var_229_5.y, var_229_5.z)

				local var_229_6 = var_229_0.localEulerAngles

				var_229_6.z = 0
				var_229_6.x = 0
				var_229_0.localEulerAngles = var_229_6
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(0, 100, 0)

				local var_229_7 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_7.x, var_229_7.y, var_229_7.z)

				local var_229_8 = var_229_0.localEulerAngles

				var_229_8.z = 0
				var_229_8.x = 0
				var_229_0.localEulerAngles = var_229_8
			end

			local var_229_9 = arg_226_1.actors_["1027ui_story"].transform
			local var_229_10 = 0

			if var_229_10 < arg_226_1.time_ and arg_226_1.time_ <= var_229_10 + arg_229_0 then
				arg_226_1.var_.moveOldPos1027ui_story = var_229_9.localPosition
			end

			local var_229_11 = 0.001

			if var_229_10 <= arg_226_1.time_ and arg_226_1.time_ < var_229_10 + var_229_11 then
				local var_229_12 = (arg_226_1.time_ - var_229_10) / var_229_11
				local var_229_13 = Vector3.New(0, -0.81, -5.8)

				var_229_9.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1027ui_story, var_229_13, var_229_12)

				local var_229_14 = manager.ui.mainCamera.transform.position - var_229_9.position

				var_229_9.forward = Vector3.New(var_229_14.x, var_229_14.y, var_229_14.z)

				local var_229_15 = var_229_9.localEulerAngles

				var_229_15.z = 0
				var_229_15.x = 0
				var_229_9.localEulerAngles = var_229_15
			end

			if arg_226_1.time_ >= var_229_10 + var_229_11 and arg_226_1.time_ < var_229_10 + var_229_11 + arg_229_0 then
				var_229_9.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_229_16 = manager.ui.mainCamera.transform.position - var_229_9.position

				var_229_9.forward = Vector3.New(var_229_16.x, var_229_16.y, var_229_16.z)

				local var_229_17 = var_229_9.localEulerAngles

				var_229_17.z = 0
				var_229_17.x = 0
				var_229_9.localEulerAngles = var_229_17
			end

			local var_229_18 = arg_226_1.actors_["1027ui_story"]
			local var_229_19 = 0

			if var_229_19 < arg_226_1.time_ and arg_226_1.time_ <= var_229_19 + arg_229_0 and not isNil(var_229_18) and arg_226_1.var_.characterEffect1027ui_story == nil then
				arg_226_1.var_.characterEffect1027ui_story = var_229_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_20 = 0.2

			if var_229_19 <= arg_226_1.time_ and arg_226_1.time_ < var_229_19 + var_229_20 and not isNil(var_229_18) then
				local var_229_21 = (arg_226_1.time_ - var_229_19) / var_229_20

				if arg_226_1.var_.characterEffect1027ui_story and not isNil(var_229_18) then
					arg_226_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_19 + var_229_20 and arg_226_1.time_ < var_229_19 + var_229_20 + arg_229_0 and not isNil(var_229_18) and arg_226_1.var_.characterEffect1027ui_story then
				arg_226_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_229_22 = 0

			if var_229_22 < arg_226_1.time_ and arg_226_1.time_ <= var_229_22 + arg_229_0 then
				arg_226_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			local var_229_23 = 0

			if var_229_23 < arg_226_1.time_ and arg_226_1.time_ <= var_229_23 + arg_229_0 then
				arg_226_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_229_24 = 0
			local var_229_25 = 0.75

			if var_229_24 < arg_226_1.time_ and arg_226_1.time_ <= var_229_24 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_26 = arg_226_1:FormatText(StoryNameCfg[56].name)

				arg_226_1.leftNameTxt_.text = var_229_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_27 = arg_226_1:GetWordFromCfg(112211056)
				local var_229_28 = arg_226_1:FormatText(var_229_27.content)

				arg_226_1.text_.text = var_229_28

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_29 = 29
				local var_229_30 = utf8.len(var_229_28)
				local var_229_31 = var_229_29 <= 0 and var_229_25 or var_229_25 * (var_229_30 / var_229_29)

				if var_229_31 > 0 and var_229_25 < var_229_31 then
					arg_226_1.talkMaxDuration = var_229_31

					if var_229_31 + var_229_24 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_31 + var_229_24
					end
				end

				arg_226_1.text_.text = var_229_28
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211056", "story_v_out_112211.awb") ~= 0 then
					local var_229_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211056", "story_v_out_112211.awb") / 1000

					if var_229_32 + var_229_24 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_32 + var_229_24
					end

					if var_229_27.prefab_name ~= "" and arg_226_1.actors_[var_229_27.prefab_name] ~= nil then
						local var_229_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_27.prefab_name].transform, "story_v_out_112211", "112211056", "story_v_out_112211.awb")

						arg_226_1:RecordAudio("112211056", var_229_33)
						arg_226_1:RecordAudio("112211056", var_229_33)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_112211", "112211056", "story_v_out_112211.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_112211", "112211056", "story_v_out_112211.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_34 = math.max(var_229_25, arg_226_1.talkMaxDuration)

			if var_229_24 <= arg_226_1.time_ and arg_226_1.time_ < var_229_24 + var_229_34 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_24) / var_229_34

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_24 + var_229_34 and arg_226_1.time_ < var_229_24 + var_229_34 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play112211057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 112211057
		arg_230_1.duration_ = 15.47

		local var_230_0 = {
			ja = 9.433,
			ko = 8.333,
			zh = 10.033,
			en = 15.466
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play112211058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1027ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos1027ui_story = var_233_0.localPosition
			end

			local var_233_2 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2
				local var_233_4 = Vector3.New(0, 100, 0)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1027ui_story, var_233_4, var_233_3)

				local var_233_5 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_5.x, var_233_5.y, var_233_5.z)

				local var_233_6 = var_233_0.localEulerAngles

				var_233_6.z = 0
				var_233_6.x = 0
				var_233_0.localEulerAngles = var_233_6
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, 100, 0)

				local var_233_7 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_7.x, var_233_7.y, var_233_7.z)

				local var_233_8 = var_233_0.localEulerAngles

				var_233_8.z = 0
				var_233_8.x = 0
				var_233_0.localEulerAngles = var_233_8
			end

			local var_233_9 = arg_230_1.actors_["1148ui_story"].transform
			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 then
				arg_230_1.var_.moveOldPos1148ui_story = var_233_9.localPosition
			end

			local var_233_11 = 0.001

			if var_233_10 <= arg_230_1.time_ and arg_230_1.time_ < var_233_10 + var_233_11 then
				local var_233_12 = (arg_230_1.time_ - var_233_10) / var_233_11
				local var_233_13 = Vector3.New(0, -0.8, -6.2)

				var_233_9.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1148ui_story, var_233_13, var_233_12)

				local var_233_14 = manager.ui.mainCamera.transform.position - var_233_9.position

				var_233_9.forward = Vector3.New(var_233_14.x, var_233_14.y, var_233_14.z)

				local var_233_15 = var_233_9.localEulerAngles

				var_233_15.z = 0
				var_233_15.x = 0
				var_233_9.localEulerAngles = var_233_15
			end

			if arg_230_1.time_ >= var_233_10 + var_233_11 and arg_230_1.time_ < var_233_10 + var_233_11 + arg_233_0 then
				var_233_9.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_233_16 = manager.ui.mainCamera.transform.position - var_233_9.position

				var_233_9.forward = Vector3.New(var_233_16.x, var_233_16.y, var_233_16.z)

				local var_233_17 = var_233_9.localEulerAngles

				var_233_17.z = 0
				var_233_17.x = 0
				var_233_9.localEulerAngles = var_233_17
			end

			local var_233_18 = arg_230_1.actors_["1148ui_story"]
			local var_233_19 = 0

			if var_233_19 < arg_230_1.time_ and arg_230_1.time_ <= var_233_19 + arg_233_0 and not isNil(var_233_18) and arg_230_1.var_.characterEffect1148ui_story == nil then
				arg_230_1.var_.characterEffect1148ui_story = var_233_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_20 = 0.2

			if var_233_19 <= arg_230_1.time_ and arg_230_1.time_ < var_233_19 + var_233_20 and not isNil(var_233_18) then
				local var_233_21 = (arg_230_1.time_ - var_233_19) / var_233_20

				if arg_230_1.var_.characterEffect1148ui_story and not isNil(var_233_18) then
					arg_230_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_19 + var_233_20 and arg_230_1.time_ < var_233_19 + var_233_20 + arg_233_0 and not isNil(var_233_18) and arg_230_1.var_.characterEffect1148ui_story then
				arg_230_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_233_22 = 0

			if var_233_22 < arg_230_1.time_ and arg_230_1.time_ <= var_233_22 + arg_233_0 then
				arg_230_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_233_23 = 0

			if var_233_23 < arg_230_1.time_ and arg_230_1.time_ <= var_233_23 + arg_233_0 then
				arg_230_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_233_24 = 0
			local var_233_25 = 1.25

			if var_233_24 < arg_230_1.time_ and arg_230_1.time_ <= var_233_24 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_26 = arg_230_1:FormatText(StoryNameCfg[8].name)

				arg_230_1.leftNameTxt_.text = var_233_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_27 = arg_230_1:GetWordFromCfg(112211057)
				local var_233_28 = arg_230_1:FormatText(var_233_27.content)

				arg_230_1.text_.text = var_233_28

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_29 = 50
				local var_233_30 = utf8.len(var_233_28)
				local var_233_31 = var_233_29 <= 0 and var_233_25 or var_233_25 * (var_233_30 / var_233_29)

				if var_233_31 > 0 and var_233_25 < var_233_31 then
					arg_230_1.talkMaxDuration = var_233_31

					if var_233_31 + var_233_24 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_31 + var_233_24
					end
				end

				arg_230_1.text_.text = var_233_28
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211057", "story_v_out_112211.awb") ~= 0 then
					local var_233_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211057", "story_v_out_112211.awb") / 1000

					if var_233_32 + var_233_24 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_32 + var_233_24
					end

					if var_233_27.prefab_name ~= "" and arg_230_1.actors_[var_233_27.prefab_name] ~= nil then
						local var_233_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_27.prefab_name].transform, "story_v_out_112211", "112211057", "story_v_out_112211.awb")

						arg_230_1:RecordAudio("112211057", var_233_33)
						arg_230_1:RecordAudio("112211057", var_233_33)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_112211", "112211057", "story_v_out_112211.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_112211", "112211057", "story_v_out_112211.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_34 = math.max(var_233_25, arg_230_1.talkMaxDuration)

			if var_233_24 <= arg_230_1.time_ and arg_230_1.time_ < var_233_24 + var_233_34 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_24) / var_233_34

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_24 + var_233_34 and arg_230_1.time_ < var_233_24 + var_233_34 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play112211058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 112211058
		arg_234_1.duration_ = 7.17

		local var_234_0 = {
			ja = 7.166,
			ko = 4.533,
			zh = 4,
			en = 4.1
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play112211059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1148ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos1148ui_story = var_237_0.localPosition
			end

			local var_237_2 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2
				local var_237_4 = Vector3.New(0, 100, 0)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1148ui_story, var_237_4, var_237_3)

				local var_237_5 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_5.x, var_237_5.y, var_237_5.z)

				local var_237_6 = var_237_0.localEulerAngles

				var_237_6.z = 0
				var_237_6.x = 0
				var_237_0.localEulerAngles = var_237_6
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0, 100, 0)

				local var_237_7 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_7.x, var_237_7.y, var_237_7.z)

				local var_237_8 = var_237_0.localEulerAngles

				var_237_8.z = 0
				var_237_8.x = 0
				var_237_0.localEulerAngles = var_237_8
			end

			local var_237_9 = arg_234_1.actors_["1081ui_story"].transform
			local var_237_10 = 0

			if var_237_10 < arg_234_1.time_ and arg_234_1.time_ <= var_237_10 + arg_237_0 then
				arg_234_1.var_.moveOldPos1081ui_story = var_237_9.localPosition
			end

			local var_237_11 = 0.001

			if var_237_10 <= arg_234_1.time_ and arg_234_1.time_ < var_237_10 + var_237_11 then
				local var_237_12 = (arg_234_1.time_ - var_237_10) / var_237_11
				local var_237_13 = Vector3.New(0, -0.92, -5.8)

				var_237_9.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1081ui_story, var_237_13, var_237_12)

				local var_237_14 = manager.ui.mainCamera.transform.position - var_237_9.position

				var_237_9.forward = Vector3.New(var_237_14.x, var_237_14.y, var_237_14.z)

				local var_237_15 = var_237_9.localEulerAngles

				var_237_15.z = 0
				var_237_15.x = 0
				var_237_9.localEulerAngles = var_237_15
			end

			if arg_234_1.time_ >= var_237_10 + var_237_11 and arg_234_1.time_ < var_237_10 + var_237_11 + arg_237_0 then
				var_237_9.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_237_16 = manager.ui.mainCamera.transform.position - var_237_9.position

				var_237_9.forward = Vector3.New(var_237_16.x, var_237_16.y, var_237_16.z)

				local var_237_17 = var_237_9.localEulerAngles

				var_237_17.z = 0
				var_237_17.x = 0
				var_237_9.localEulerAngles = var_237_17
			end

			local var_237_18 = arg_234_1.actors_["1081ui_story"]
			local var_237_19 = 0

			if var_237_19 < arg_234_1.time_ and arg_234_1.time_ <= var_237_19 + arg_237_0 and not isNil(var_237_18) and arg_234_1.var_.characterEffect1081ui_story == nil then
				arg_234_1.var_.characterEffect1081ui_story = var_237_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_20 = 0.2

			if var_237_19 <= arg_234_1.time_ and arg_234_1.time_ < var_237_19 + var_237_20 and not isNil(var_237_18) then
				local var_237_21 = (arg_234_1.time_ - var_237_19) / var_237_20

				if arg_234_1.var_.characterEffect1081ui_story and not isNil(var_237_18) then
					arg_234_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_19 + var_237_20 and arg_234_1.time_ < var_237_19 + var_237_20 + arg_237_0 and not isNil(var_237_18) and arg_234_1.var_.characterEffect1081ui_story then
				arg_234_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_237_22 = 0

			if var_237_22 < arg_234_1.time_ and arg_234_1.time_ <= var_237_22 + arg_237_0 then
				arg_234_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_237_23 = 0

			if var_237_23 < arg_234_1.time_ and arg_234_1.time_ <= var_237_23 + arg_237_0 then
				arg_234_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_237_24 = 0
			local var_237_25 = 0.4

			if var_237_24 < arg_234_1.time_ and arg_234_1.time_ <= var_237_24 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_26 = arg_234_1:FormatText(StoryNameCfg[202].name)

				arg_234_1.leftNameTxt_.text = var_237_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_27 = arg_234_1:GetWordFromCfg(112211058)
				local var_237_28 = arg_234_1:FormatText(var_237_27.content)

				arg_234_1.text_.text = var_237_28

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_29 = 16
				local var_237_30 = utf8.len(var_237_28)
				local var_237_31 = var_237_29 <= 0 and var_237_25 or var_237_25 * (var_237_30 / var_237_29)

				if var_237_31 > 0 and var_237_25 < var_237_31 then
					arg_234_1.talkMaxDuration = var_237_31

					if var_237_31 + var_237_24 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_31 + var_237_24
					end
				end

				arg_234_1.text_.text = var_237_28
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211058", "story_v_out_112211.awb") ~= 0 then
					local var_237_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211058", "story_v_out_112211.awb") / 1000

					if var_237_32 + var_237_24 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_32 + var_237_24
					end

					if var_237_27.prefab_name ~= "" and arg_234_1.actors_[var_237_27.prefab_name] ~= nil then
						local var_237_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_27.prefab_name].transform, "story_v_out_112211", "112211058", "story_v_out_112211.awb")

						arg_234_1:RecordAudio("112211058", var_237_33)
						arg_234_1:RecordAudio("112211058", var_237_33)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_112211", "112211058", "story_v_out_112211.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_112211", "112211058", "story_v_out_112211.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_34 = math.max(var_237_25, arg_234_1.talkMaxDuration)

			if var_237_24 <= arg_234_1.time_ and arg_234_1.time_ < var_237_24 + var_237_34 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_24) / var_237_34

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_24 + var_237_34 and arg_234_1.time_ < var_237_24 + var_237_34 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_234_1:InitPlayNodeList()
	end,
	Play112211059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 112211059
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play112211060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1081ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos1081ui_story = var_241_0.localPosition
			end

			local var_241_2 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2
				local var_241_4 = Vector3.New(0, 100, 0)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1081ui_story, var_241_4, var_241_3)

				local var_241_5 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_5.x, var_241_5.y, var_241_5.z)

				local var_241_6 = var_241_0.localEulerAngles

				var_241_6.z = 0
				var_241_6.x = 0
				var_241_0.localEulerAngles = var_241_6
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, 100, 0)

				local var_241_7 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_7.x, var_241_7.y, var_241_7.z)

				local var_241_8 = var_241_0.localEulerAngles

				var_241_8.z = 0
				var_241_8.x = 0
				var_241_0.localEulerAngles = var_241_8
			end

			local var_241_9 = 0
			local var_241_10 = 0.625

			if var_241_9 < arg_238_1.time_ and arg_238_1.time_ <= var_241_9 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_11 = arg_238_1:GetWordFromCfg(112211059)
				local var_241_12 = arg_238_1:FormatText(var_241_11.content)

				arg_238_1.text_.text = var_241_12

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_13 = 25
				local var_241_14 = utf8.len(var_241_12)
				local var_241_15 = var_241_13 <= 0 and var_241_10 or var_241_10 * (var_241_14 / var_241_13)

				if var_241_15 > 0 and var_241_10 < var_241_15 then
					arg_238_1.talkMaxDuration = var_241_15

					if var_241_15 + var_241_9 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_15 + var_241_9
					end
				end

				arg_238_1.text_.text = var_241_12
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_16 = math.max(var_241_10, arg_238_1.talkMaxDuration)

			if var_241_9 <= arg_238_1.time_ and arg_238_1.time_ < var_241_9 + var_241_16 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_9) / var_241_16

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_9 + var_241_16 and arg_238_1.time_ < var_241_9 + var_241_16 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
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

		arg_238_1:InitPlayNodeList()
	end,
	Play112211060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 112211060
		arg_242_1.duration_ = 4.73

		local var_242_0 = {
			ja = 4.733,
			ko = 3.1,
			zh = 3.433,
			en = 2.9
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play112211061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1039ui_story"].transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos1039ui_story = var_245_0.localPosition
			end

			local var_245_2 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2
				local var_245_4 = Vector3.New(0, -1.01, -5.9)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1039ui_story, var_245_4, var_245_3)

				local var_245_5 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_5.x, var_245_5.y, var_245_5.z)

				local var_245_6 = var_245_0.localEulerAngles

				var_245_6.z = 0
				var_245_6.x = 0
				var_245_0.localEulerAngles = var_245_6
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_245_7 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_7.x, var_245_7.y, var_245_7.z)

				local var_245_8 = var_245_0.localEulerAngles

				var_245_8.z = 0
				var_245_8.x = 0
				var_245_0.localEulerAngles = var_245_8
			end

			local var_245_9 = arg_242_1.actors_["1039ui_story"]
			local var_245_10 = 0

			if var_245_10 < arg_242_1.time_ and arg_242_1.time_ <= var_245_10 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect1039ui_story == nil then
				arg_242_1.var_.characterEffect1039ui_story = var_245_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_11 = 0.2

			if var_245_10 <= arg_242_1.time_ and arg_242_1.time_ < var_245_10 + var_245_11 and not isNil(var_245_9) then
				local var_245_12 = (arg_242_1.time_ - var_245_10) / var_245_11

				if arg_242_1.var_.characterEffect1039ui_story and not isNil(var_245_9) then
					arg_242_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_10 + var_245_11 and arg_242_1.time_ < var_245_10 + var_245_11 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect1039ui_story then
				arg_242_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_245_13 = 0

			if var_245_13 < arg_242_1.time_ and arg_242_1.time_ <= var_245_13 + arg_245_0 then
				arg_242_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_245_14 = 0

			if var_245_14 < arg_242_1.time_ and arg_242_1.time_ <= var_245_14 + arg_245_0 then
				arg_242_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_245_15 = 0
			local var_245_16 = 0.25

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_17 = arg_242_1:FormatText(StoryNameCfg[9].name)

				arg_242_1.leftNameTxt_.text = var_245_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_18 = arg_242_1:GetWordFromCfg(112211060)
				local var_245_19 = arg_242_1:FormatText(var_245_18.content)

				arg_242_1.text_.text = var_245_19

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_20 = 10
				local var_245_21 = utf8.len(var_245_19)
				local var_245_22 = var_245_20 <= 0 and var_245_16 or var_245_16 * (var_245_21 / var_245_20)

				if var_245_22 > 0 and var_245_16 < var_245_22 then
					arg_242_1.talkMaxDuration = var_245_22

					if var_245_22 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_22 + var_245_15
					end
				end

				arg_242_1.text_.text = var_245_19
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211060", "story_v_out_112211.awb") ~= 0 then
					local var_245_23 = manager.audio:GetVoiceLength("story_v_out_112211", "112211060", "story_v_out_112211.awb") / 1000

					if var_245_23 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_23 + var_245_15
					end

					if var_245_18.prefab_name ~= "" and arg_242_1.actors_[var_245_18.prefab_name] ~= nil then
						local var_245_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_18.prefab_name].transform, "story_v_out_112211", "112211060", "story_v_out_112211.awb")

						arg_242_1:RecordAudio("112211060", var_245_24)
						arg_242_1:RecordAudio("112211060", var_245_24)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_112211", "112211060", "story_v_out_112211.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_112211", "112211060", "story_v_out_112211.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_25 = math.max(var_245_16, arg_242_1.talkMaxDuration)

			if var_245_15 <= arg_242_1.time_ and arg_242_1.time_ < var_245_15 + var_245_25 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_15) / var_245_25

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_15 + var_245_25 and arg_242_1.time_ < var_245_15 + var_245_25 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
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

		arg_242_1:InitPlayNodeList()
	end,
	Play112211061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 112211061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play112211062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1039ui_story"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1039ui_story == nil then
				arg_246_1.var_.characterEffect1039ui_story = var_249_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.2

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.characterEffect1039ui_story and not isNil(var_249_0) then
					local var_249_4 = Mathf.Lerp(0, 0.5, var_249_3)

					arg_246_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1039ui_story.fillRatio = var_249_4
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1039ui_story then
				local var_249_5 = 0.5

				arg_246_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1039ui_story.fillRatio = var_249_5
			end

			local var_249_6 = 0
			local var_249_7 = 0.1

			if var_249_6 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_8 = arg_246_1:FormatText(StoryNameCfg[7].name)

				arg_246_1.leftNameTxt_.text = var_249_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_9 = arg_246_1:GetWordFromCfg(112211061)
				local var_249_10 = arg_246_1:FormatText(var_249_9.content)

				arg_246_1.text_.text = var_249_10

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_11 = 4
				local var_249_12 = utf8.len(var_249_10)
				local var_249_13 = var_249_11 <= 0 and var_249_7 or var_249_7 * (var_249_12 / var_249_11)

				if var_249_13 > 0 and var_249_7 < var_249_13 then
					arg_246_1.talkMaxDuration = var_249_13

					if var_249_13 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_13 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_10
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_14 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_14 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_6) / var_249_14

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_6 + var_249_14 and arg_246_1.time_ < var_249_6 + var_249_14 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play112211062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 112211062
		arg_250_1.duration_ = 5.57

		local var_250_0 = {
			ja = 5.566,
			ko = 3.833,
			zh = 4.8,
			en = 5.233
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play112211063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1039ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1039ui_story == nil then
				arg_250_1.var_.characterEffect1039ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.2

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect1039ui_story and not isNil(var_253_0) then
					arg_250_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1039ui_story then
				arg_250_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_253_4 = 0

			if var_253_4 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			local var_253_5 = 0

			if var_253_5 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_253_6 = 0
			local var_253_7 = 0.55

			if var_253_6 < arg_250_1.time_ and arg_250_1.time_ <= var_253_6 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_8 = arg_250_1:FormatText(StoryNameCfg[9].name)

				arg_250_1.leftNameTxt_.text = var_253_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_9 = arg_250_1:GetWordFromCfg(112211062)
				local var_253_10 = arg_250_1:FormatText(var_253_9.content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 22
				local var_253_12 = utf8.len(var_253_10)
				local var_253_13 = var_253_11 <= 0 and var_253_7 or var_253_7 * (var_253_12 / var_253_11)

				if var_253_13 > 0 and var_253_7 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13

					if var_253_13 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_6
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211062", "story_v_out_112211.awb") ~= 0 then
					local var_253_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211062", "story_v_out_112211.awb") / 1000

					if var_253_14 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_14 + var_253_6
					end

					if var_253_9.prefab_name ~= "" and arg_250_1.actors_[var_253_9.prefab_name] ~= nil then
						local var_253_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_9.prefab_name].transform, "story_v_out_112211", "112211062", "story_v_out_112211.awb")

						arg_250_1:RecordAudio("112211062", var_253_15)
						arg_250_1:RecordAudio("112211062", var_253_15)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_112211", "112211062", "story_v_out_112211.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_112211", "112211062", "story_v_out_112211.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_16 = math.max(var_253_7, arg_250_1.talkMaxDuration)

			if var_253_6 <= arg_250_1.time_ and arg_250_1.time_ < var_253_6 + var_253_16 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_6) / var_253_16

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_6 + var_253_16 and arg_250_1.time_ < var_253_6 + var_253_16 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play112211063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 112211063
		arg_254_1.duration_ = 4.33

		local var_254_0 = {
			ja = 3.633,
			ko = 4.333,
			zh = 4.233,
			en = 3.533
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play112211064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1039ui_story"].transform
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.var_.moveOldPos1039ui_story = var_257_0.localPosition
			end

			local var_257_2 = 0.001

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2
				local var_257_4 = Vector3.New(0, 100, 0)

				var_257_0.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1039ui_story, var_257_4, var_257_3)

				local var_257_5 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_5.x, var_257_5.y, var_257_5.z)

				local var_257_6 = var_257_0.localEulerAngles

				var_257_6.z = 0
				var_257_6.x = 0
				var_257_0.localEulerAngles = var_257_6
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 then
				var_257_0.localPosition = Vector3.New(0, 100, 0)

				local var_257_7 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_7.x, var_257_7.y, var_257_7.z)

				local var_257_8 = var_257_0.localEulerAngles

				var_257_8.z = 0
				var_257_8.x = 0
				var_257_0.localEulerAngles = var_257_8
			end

			local var_257_9 = arg_254_1.actors_["1084ui_story"].transform
			local var_257_10 = 0

			if var_257_10 < arg_254_1.time_ and arg_254_1.time_ <= var_257_10 + arg_257_0 then
				arg_254_1.var_.moveOldPos1084ui_story = var_257_9.localPosition
			end

			local var_257_11 = 0.001

			if var_257_10 <= arg_254_1.time_ and arg_254_1.time_ < var_257_10 + var_257_11 then
				local var_257_12 = (arg_254_1.time_ - var_257_10) / var_257_11
				local var_257_13 = Vector3.New(0, -0.97, -6)

				var_257_9.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1084ui_story, var_257_13, var_257_12)

				local var_257_14 = manager.ui.mainCamera.transform.position - var_257_9.position

				var_257_9.forward = Vector3.New(var_257_14.x, var_257_14.y, var_257_14.z)

				local var_257_15 = var_257_9.localEulerAngles

				var_257_15.z = 0
				var_257_15.x = 0
				var_257_9.localEulerAngles = var_257_15
			end

			if arg_254_1.time_ >= var_257_10 + var_257_11 and arg_254_1.time_ < var_257_10 + var_257_11 + arg_257_0 then
				var_257_9.localPosition = Vector3.New(0, -0.97, -6)

				local var_257_16 = manager.ui.mainCamera.transform.position - var_257_9.position

				var_257_9.forward = Vector3.New(var_257_16.x, var_257_16.y, var_257_16.z)

				local var_257_17 = var_257_9.localEulerAngles

				var_257_17.z = 0
				var_257_17.x = 0
				var_257_9.localEulerAngles = var_257_17
			end

			local var_257_18 = arg_254_1.actors_["1084ui_story"]
			local var_257_19 = 0

			if var_257_19 < arg_254_1.time_ and arg_254_1.time_ <= var_257_19 + arg_257_0 and not isNil(var_257_18) and arg_254_1.var_.characterEffect1084ui_story == nil then
				arg_254_1.var_.characterEffect1084ui_story = var_257_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_20 = 0.2

			if var_257_19 <= arg_254_1.time_ and arg_254_1.time_ < var_257_19 + var_257_20 and not isNil(var_257_18) then
				local var_257_21 = (arg_254_1.time_ - var_257_19) / var_257_20

				if arg_254_1.var_.characterEffect1084ui_story and not isNil(var_257_18) then
					arg_254_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_19 + var_257_20 and arg_254_1.time_ < var_257_19 + var_257_20 + arg_257_0 and not isNil(var_257_18) and arg_254_1.var_.characterEffect1084ui_story then
				arg_254_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_257_22 = 0

			if var_257_22 < arg_254_1.time_ and arg_254_1.time_ <= var_257_22 + arg_257_0 then
				arg_254_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_257_23 = 0

			if var_257_23 < arg_254_1.time_ and arg_254_1.time_ <= var_257_23 + arg_257_0 then
				arg_254_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_257_24 = 0
			local var_257_25 = 0.525

			if var_257_24 < arg_254_1.time_ and arg_254_1.time_ <= var_257_24 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_26 = arg_254_1:FormatText(StoryNameCfg[6].name)

				arg_254_1.leftNameTxt_.text = var_257_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_27 = arg_254_1:GetWordFromCfg(112211063)
				local var_257_28 = arg_254_1:FormatText(var_257_27.content)

				arg_254_1.text_.text = var_257_28

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_29 = 21
				local var_257_30 = utf8.len(var_257_28)
				local var_257_31 = var_257_29 <= 0 and var_257_25 or var_257_25 * (var_257_30 / var_257_29)

				if var_257_31 > 0 and var_257_25 < var_257_31 then
					arg_254_1.talkMaxDuration = var_257_31

					if var_257_31 + var_257_24 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_31 + var_257_24
					end
				end

				arg_254_1.text_.text = var_257_28
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211063", "story_v_out_112211.awb") ~= 0 then
					local var_257_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211063", "story_v_out_112211.awb") / 1000

					if var_257_32 + var_257_24 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_32 + var_257_24
					end

					if var_257_27.prefab_name ~= "" and arg_254_1.actors_[var_257_27.prefab_name] ~= nil then
						local var_257_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_27.prefab_name].transform, "story_v_out_112211", "112211063", "story_v_out_112211.awb")

						arg_254_1:RecordAudio("112211063", var_257_33)
						arg_254_1:RecordAudio("112211063", var_257_33)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_112211", "112211063", "story_v_out_112211.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_112211", "112211063", "story_v_out_112211.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_34 = math.max(var_257_25, arg_254_1.talkMaxDuration)

			if var_257_24 <= arg_254_1.time_ and arg_254_1.time_ < var_257_24 + var_257_34 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_24) / var_257_34

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_24 + var_257_34 and arg_254_1.time_ < var_257_24 + var_257_34 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
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

		arg_254_1:InitPlayNodeList()
	end,
	Play112211064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 112211064
		arg_258_1.duration_ = 5.4

		local var_258_0 = {
			ja = 4.566,
			ko = 3.333,
			zh = 5.4,
			en = 4.2
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play112211065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1084ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1084ui_story = var_261_0.localPosition
			end

			local var_261_2 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2
				local var_261_4 = Vector3.New(0, 100, 0)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1084ui_story, var_261_4, var_261_3)

				local var_261_5 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_5.x, var_261_5.y, var_261_5.z)

				local var_261_6 = var_261_0.localEulerAngles

				var_261_6.z = 0
				var_261_6.x = 0
				var_261_0.localEulerAngles = var_261_6
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, 100, 0)

				local var_261_7 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_7.x, var_261_7.y, var_261_7.z)

				local var_261_8 = var_261_0.localEulerAngles

				var_261_8.z = 0
				var_261_8.x = 0
				var_261_0.localEulerAngles = var_261_8
			end

			local var_261_9 = arg_258_1.actors_["1027ui_story"].transform
			local var_261_10 = 0

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 then
				arg_258_1.var_.moveOldPos1027ui_story = var_261_9.localPosition
			end

			local var_261_11 = 0.001

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_11 then
				local var_261_12 = (arg_258_1.time_ - var_261_10) / var_261_11
				local var_261_13 = Vector3.New(0, -0.81, -5.8)

				var_261_9.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1027ui_story, var_261_13, var_261_12)

				local var_261_14 = manager.ui.mainCamera.transform.position - var_261_9.position

				var_261_9.forward = Vector3.New(var_261_14.x, var_261_14.y, var_261_14.z)

				local var_261_15 = var_261_9.localEulerAngles

				var_261_15.z = 0
				var_261_15.x = 0
				var_261_9.localEulerAngles = var_261_15
			end

			if arg_258_1.time_ >= var_261_10 + var_261_11 and arg_258_1.time_ < var_261_10 + var_261_11 + arg_261_0 then
				var_261_9.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_261_16 = manager.ui.mainCamera.transform.position - var_261_9.position

				var_261_9.forward = Vector3.New(var_261_16.x, var_261_16.y, var_261_16.z)

				local var_261_17 = var_261_9.localEulerAngles

				var_261_17.z = 0
				var_261_17.x = 0
				var_261_9.localEulerAngles = var_261_17
			end

			local var_261_18 = arg_258_1.actors_["1027ui_story"]
			local var_261_19 = 0

			if var_261_19 < arg_258_1.time_ and arg_258_1.time_ <= var_261_19 + arg_261_0 and not isNil(var_261_18) and arg_258_1.var_.characterEffect1027ui_story == nil then
				arg_258_1.var_.characterEffect1027ui_story = var_261_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_20 = 0.2

			if var_261_19 <= arg_258_1.time_ and arg_258_1.time_ < var_261_19 + var_261_20 and not isNil(var_261_18) then
				local var_261_21 = (arg_258_1.time_ - var_261_19) / var_261_20

				if arg_258_1.var_.characterEffect1027ui_story and not isNil(var_261_18) then
					arg_258_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_19 + var_261_20 and arg_258_1.time_ < var_261_19 + var_261_20 + arg_261_0 and not isNil(var_261_18) and arg_258_1.var_.characterEffect1027ui_story then
				arg_258_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_261_22 = 0

			if var_261_22 < arg_258_1.time_ and arg_258_1.time_ <= var_261_22 + arg_261_0 then
				arg_258_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			local var_261_23 = 0

			if var_261_23 < arg_258_1.time_ and arg_258_1.time_ <= var_261_23 + arg_261_0 then
				arg_258_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_261_24 = 0
			local var_261_25 = 0.225

			if var_261_24 < arg_258_1.time_ and arg_258_1.time_ <= var_261_24 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_26 = arg_258_1:FormatText(StoryNameCfg[56].name)

				arg_258_1.leftNameTxt_.text = var_261_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_27 = arg_258_1:GetWordFromCfg(112211064)
				local var_261_28 = arg_258_1:FormatText(var_261_27.content)

				arg_258_1.text_.text = var_261_28

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_29 = 9
				local var_261_30 = utf8.len(var_261_28)
				local var_261_31 = var_261_29 <= 0 and var_261_25 or var_261_25 * (var_261_30 / var_261_29)

				if var_261_31 > 0 and var_261_25 < var_261_31 then
					arg_258_1.talkMaxDuration = var_261_31

					if var_261_31 + var_261_24 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_31 + var_261_24
					end
				end

				arg_258_1.text_.text = var_261_28
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211064", "story_v_out_112211.awb") ~= 0 then
					local var_261_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211064", "story_v_out_112211.awb") / 1000

					if var_261_32 + var_261_24 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_32 + var_261_24
					end

					if var_261_27.prefab_name ~= "" and arg_258_1.actors_[var_261_27.prefab_name] ~= nil then
						local var_261_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_27.prefab_name].transform, "story_v_out_112211", "112211064", "story_v_out_112211.awb")

						arg_258_1:RecordAudio("112211064", var_261_33)
						arg_258_1:RecordAudio("112211064", var_261_33)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_112211", "112211064", "story_v_out_112211.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_112211", "112211064", "story_v_out_112211.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_34 = math.max(var_261_25, arg_258_1.talkMaxDuration)

			if var_261_24 <= arg_258_1.time_ and arg_258_1.time_ < var_261_24 + var_261_34 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_24) / var_261_34

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_24 + var_261_34 and arg_258_1.time_ < var_261_24 + var_261_34 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play112211065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 112211065
		arg_262_1.duration_ = 3.2

		local var_262_0 = {
			ja = 3.2,
			ko = 2.7,
			zh = 2.733,
			en = 2.266
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play112211066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1027ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos1027ui_story = var_265_0.localPosition
			end

			local var_265_2 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2
				local var_265_4 = Vector3.New(0, 100, 0)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1027ui_story, var_265_4, var_265_3)

				local var_265_5 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_5.x, var_265_5.y, var_265_5.z)

				local var_265_6 = var_265_0.localEulerAngles

				var_265_6.z = 0
				var_265_6.x = 0
				var_265_0.localEulerAngles = var_265_6
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, 100, 0)

				local var_265_7 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_7.x, var_265_7.y, var_265_7.z)

				local var_265_8 = var_265_0.localEulerAngles

				var_265_8.z = 0
				var_265_8.x = 0
				var_265_0.localEulerAngles = var_265_8
			end

			local var_265_9 = arg_262_1.actors_["1148ui_story"].transform
			local var_265_10 = 0

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1.var_.moveOldPos1148ui_story = var_265_9.localPosition
			end

			local var_265_11 = 0.001

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_11 then
				local var_265_12 = (arg_262_1.time_ - var_265_10) / var_265_11
				local var_265_13 = Vector3.New(0, -0.8, -6.2)

				var_265_9.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1148ui_story, var_265_13, var_265_12)

				local var_265_14 = manager.ui.mainCamera.transform.position - var_265_9.position

				var_265_9.forward = Vector3.New(var_265_14.x, var_265_14.y, var_265_14.z)

				local var_265_15 = var_265_9.localEulerAngles

				var_265_15.z = 0
				var_265_15.x = 0
				var_265_9.localEulerAngles = var_265_15
			end

			if arg_262_1.time_ >= var_265_10 + var_265_11 and arg_262_1.time_ < var_265_10 + var_265_11 + arg_265_0 then
				var_265_9.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_265_16 = manager.ui.mainCamera.transform.position - var_265_9.position

				var_265_9.forward = Vector3.New(var_265_16.x, var_265_16.y, var_265_16.z)

				local var_265_17 = var_265_9.localEulerAngles

				var_265_17.z = 0
				var_265_17.x = 0
				var_265_9.localEulerAngles = var_265_17
			end

			local var_265_18 = arg_262_1.actors_["1148ui_story"]
			local var_265_19 = 0

			if var_265_19 < arg_262_1.time_ and arg_262_1.time_ <= var_265_19 + arg_265_0 and not isNil(var_265_18) and arg_262_1.var_.characterEffect1148ui_story == nil then
				arg_262_1.var_.characterEffect1148ui_story = var_265_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_20 = 0.2

			if var_265_19 <= arg_262_1.time_ and arg_262_1.time_ < var_265_19 + var_265_20 and not isNil(var_265_18) then
				local var_265_21 = (arg_262_1.time_ - var_265_19) / var_265_20

				if arg_262_1.var_.characterEffect1148ui_story and not isNil(var_265_18) then
					arg_262_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_19 + var_265_20 and arg_262_1.time_ < var_265_19 + var_265_20 + arg_265_0 and not isNil(var_265_18) and arg_262_1.var_.characterEffect1148ui_story then
				arg_262_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_265_22 = 0

			if var_265_22 < arg_262_1.time_ and arg_262_1.time_ <= var_265_22 + arg_265_0 then
				arg_262_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_265_23 = 0

			if var_265_23 < arg_262_1.time_ and arg_262_1.time_ <= var_265_23 + arg_265_0 then
				arg_262_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_265_24 = 0
			local var_265_25 = 0.2

			if var_265_24 < arg_262_1.time_ and arg_262_1.time_ <= var_265_24 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_26 = arg_262_1:FormatText(StoryNameCfg[8].name)

				arg_262_1.leftNameTxt_.text = var_265_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_27 = arg_262_1:GetWordFromCfg(112211065)
				local var_265_28 = arg_262_1:FormatText(var_265_27.content)

				arg_262_1.text_.text = var_265_28

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_29 = 8
				local var_265_30 = utf8.len(var_265_28)
				local var_265_31 = var_265_29 <= 0 and var_265_25 or var_265_25 * (var_265_30 / var_265_29)

				if var_265_31 > 0 and var_265_25 < var_265_31 then
					arg_262_1.talkMaxDuration = var_265_31

					if var_265_31 + var_265_24 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_31 + var_265_24
					end
				end

				arg_262_1.text_.text = var_265_28
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211065", "story_v_out_112211.awb") ~= 0 then
					local var_265_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211065", "story_v_out_112211.awb") / 1000

					if var_265_32 + var_265_24 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_32 + var_265_24
					end

					if var_265_27.prefab_name ~= "" and arg_262_1.actors_[var_265_27.prefab_name] ~= nil then
						local var_265_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_27.prefab_name].transform, "story_v_out_112211", "112211065", "story_v_out_112211.awb")

						arg_262_1:RecordAudio("112211065", var_265_33)
						arg_262_1:RecordAudio("112211065", var_265_33)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_112211", "112211065", "story_v_out_112211.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_112211", "112211065", "story_v_out_112211.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_34 = math.max(var_265_25, arg_262_1.talkMaxDuration)

			if var_265_24 <= arg_262_1.time_ and arg_262_1.time_ < var_265_24 + var_265_34 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_24) / var_265_34

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_24 + var_265_34 and arg_262_1.time_ < var_265_24 + var_265_34 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play112211066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 112211066
		arg_266_1.duration_ = 3.2

		local var_266_0 = {
			ja = 2.7,
			ko = 2.166,
			zh = 3.033,
			en = 3.2
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play112211067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1148ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos1148ui_story = var_269_0.localPosition
			end

			local var_269_2 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2
				local var_269_4 = Vector3.New(0, 100, 0)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1148ui_story, var_269_4, var_269_3)

				local var_269_5 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_5.x, var_269_5.y, var_269_5.z)

				local var_269_6 = var_269_0.localEulerAngles

				var_269_6.z = 0
				var_269_6.x = 0
				var_269_0.localEulerAngles = var_269_6
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, 100, 0)

				local var_269_7 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_7.x, var_269_7.y, var_269_7.z)

				local var_269_8 = var_269_0.localEulerAngles

				var_269_8.z = 0
				var_269_8.x = 0
				var_269_0.localEulerAngles = var_269_8
			end

			local var_269_9 = arg_266_1.actors_["1081ui_story"].transform
			local var_269_10 = 0

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 then
				arg_266_1.var_.moveOldPos1081ui_story = var_269_9.localPosition
			end

			local var_269_11 = 0.001

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_11 then
				local var_269_12 = (arg_266_1.time_ - var_269_10) / var_269_11
				local var_269_13 = Vector3.New(0, -0.92, -5.8)

				var_269_9.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1081ui_story, var_269_13, var_269_12)

				local var_269_14 = manager.ui.mainCamera.transform.position - var_269_9.position

				var_269_9.forward = Vector3.New(var_269_14.x, var_269_14.y, var_269_14.z)

				local var_269_15 = var_269_9.localEulerAngles

				var_269_15.z = 0
				var_269_15.x = 0
				var_269_9.localEulerAngles = var_269_15
			end

			if arg_266_1.time_ >= var_269_10 + var_269_11 and arg_266_1.time_ < var_269_10 + var_269_11 + arg_269_0 then
				var_269_9.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_269_16 = manager.ui.mainCamera.transform.position - var_269_9.position

				var_269_9.forward = Vector3.New(var_269_16.x, var_269_16.y, var_269_16.z)

				local var_269_17 = var_269_9.localEulerAngles

				var_269_17.z = 0
				var_269_17.x = 0
				var_269_9.localEulerAngles = var_269_17
			end

			local var_269_18 = arg_266_1.actors_["1081ui_story"]
			local var_269_19 = 0

			if var_269_19 < arg_266_1.time_ and arg_266_1.time_ <= var_269_19 + arg_269_0 and not isNil(var_269_18) and arg_266_1.var_.characterEffect1081ui_story == nil then
				arg_266_1.var_.characterEffect1081ui_story = var_269_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_20 = 0.2

			if var_269_19 <= arg_266_1.time_ and arg_266_1.time_ < var_269_19 + var_269_20 and not isNil(var_269_18) then
				local var_269_21 = (arg_266_1.time_ - var_269_19) / var_269_20

				if arg_266_1.var_.characterEffect1081ui_story and not isNil(var_269_18) then
					arg_266_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_19 + var_269_20 and arg_266_1.time_ < var_269_19 + var_269_20 + arg_269_0 and not isNil(var_269_18) and arg_266_1.var_.characterEffect1081ui_story then
				arg_266_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_269_22 = 0

			if var_269_22 < arg_266_1.time_ and arg_266_1.time_ <= var_269_22 + arg_269_0 then
				arg_266_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			local var_269_23 = 0

			if var_269_23 < arg_266_1.time_ and arg_266_1.time_ <= var_269_23 + arg_269_0 then
				arg_266_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_269_24 = 0
			local var_269_25 = 0.25

			if var_269_24 < arg_266_1.time_ and arg_266_1.time_ <= var_269_24 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_26 = arg_266_1:FormatText(StoryNameCfg[202].name)

				arg_266_1.leftNameTxt_.text = var_269_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_27 = arg_266_1:GetWordFromCfg(112211066)
				local var_269_28 = arg_266_1:FormatText(var_269_27.content)

				arg_266_1.text_.text = var_269_28

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_29 = 10
				local var_269_30 = utf8.len(var_269_28)
				local var_269_31 = var_269_29 <= 0 and var_269_25 or var_269_25 * (var_269_30 / var_269_29)

				if var_269_31 > 0 and var_269_25 < var_269_31 then
					arg_266_1.talkMaxDuration = var_269_31

					if var_269_31 + var_269_24 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_31 + var_269_24
					end
				end

				arg_266_1.text_.text = var_269_28
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211066", "story_v_out_112211.awb") ~= 0 then
					local var_269_32 = manager.audio:GetVoiceLength("story_v_out_112211", "112211066", "story_v_out_112211.awb") / 1000

					if var_269_32 + var_269_24 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_32 + var_269_24
					end

					if var_269_27.prefab_name ~= "" and arg_266_1.actors_[var_269_27.prefab_name] ~= nil then
						local var_269_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_27.prefab_name].transform, "story_v_out_112211", "112211066", "story_v_out_112211.awb")

						arg_266_1:RecordAudio("112211066", var_269_33)
						arg_266_1:RecordAudio("112211066", var_269_33)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_112211", "112211066", "story_v_out_112211.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_112211", "112211066", "story_v_out_112211.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_34 = math.max(var_269_25, arg_266_1.talkMaxDuration)

			if var_269_24 <= arg_266_1.time_ and arg_266_1.time_ < var_269_24 + var_269_34 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_24) / var_269_34

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_24 + var_269_34 and arg_266_1.time_ < var_269_24 + var_269_34 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_266_1:InitPlayNodeList()
	end,
	Play112211067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 112211067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play112211068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1081ui_story"].transform
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.var_.moveOldPos1081ui_story = var_273_0.localPosition
			end

			local var_273_2 = 0.001

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2
				local var_273_4 = Vector3.New(0, 100, 0)

				var_273_0.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1081ui_story, var_273_4, var_273_3)

				local var_273_5 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_5.x, var_273_5.y, var_273_5.z)

				local var_273_6 = var_273_0.localEulerAngles

				var_273_6.z = 0
				var_273_6.x = 0
				var_273_0.localEulerAngles = var_273_6
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 then
				var_273_0.localPosition = Vector3.New(0, 100, 0)

				local var_273_7 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_7.x, var_273_7.y, var_273_7.z)

				local var_273_8 = var_273_0.localEulerAngles

				var_273_8.z = 0
				var_273_8.x = 0
				var_273_0.localEulerAngles = var_273_8
			end

			local var_273_9 = 0
			local var_273_10 = 0.825

			if var_273_9 < arg_270_1.time_ and arg_270_1.time_ <= var_273_9 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_11 = arg_270_1:GetWordFromCfg(112211067)
				local var_273_12 = arg_270_1:FormatText(var_273_11.content)

				arg_270_1.text_.text = var_273_12

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_13 = 33
				local var_273_14 = utf8.len(var_273_12)
				local var_273_15 = var_273_13 <= 0 and var_273_10 or var_273_10 * (var_273_14 / var_273_13)

				if var_273_15 > 0 and var_273_10 < var_273_15 then
					arg_270_1.talkMaxDuration = var_273_15

					if var_273_15 + var_273_9 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_15 + var_273_9
					end
				end

				arg_270_1.text_.text = var_273_12
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_10, arg_270_1.talkMaxDuration)

			if var_273_9 <= arg_270_1.time_ and arg_270_1.time_ < var_273_9 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_9) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_9 + var_273_16 and arg_270_1.time_ < var_273_9 + var_273_16 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
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

		arg_270_1:InitPlayNodeList()
	end,
	Play112211068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 112211068
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play112211069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.65

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[7].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:GetWordFromCfg(112211068)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 26
				local var_277_6 = utf8.len(var_277_4)
				local var_277_7 = var_277_5 <= 0 and var_277_1 or var_277_1 * (var_277_6 / var_277_5)

				if var_277_7 > 0 and var_277_1 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_8 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_8 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_8

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_8 and arg_274_1.time_ < var_277_0 + var_277_8 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play112211069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 112211069
		arg_278_1.duration_ = 5.5

		local var_278_0 = {
			ja = 3.433,
			ko = 4.366,
			zh = 4.466,
			en = 5.5
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play112211070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1039ui_story"].transform
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.var_.moveOldPos1039ui_story = var_281_0.localPosition
			end

			local var_281_2 = 0.001

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2
				local var_281_4 = Vector3.New(0, -1.01, -5.9)

				var_281_0.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1039ui_story, var_281_4, var_281_3)

				local var_281_5 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_5.x, var_281_5.y, var_281_5.z)

				local var_281_6 = var_281_0.localEulerAngles

				var_281_6.z = 0
				var_281_6.x = 0
				var_281_0.localEulerAngles = var_281_6
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 then
				var_281_0.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_281_7 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_7.x, var_281_7.y, var_281_7.z)

				local var_281_8 = var_281_0.localEulerAngles

				var_281_8.z = 0
				var_281_8.x = 0
				var_281_0.localEulerAngles = var_281_8
			end

			local var_281_9 = arg_278_1.actors_["1039ui_story"]
			local var_281_10 = 0

			if var_281_10 < arg_278_1.time_ and arg_278_1.time_ <= var_281_10 + arg_281_0 and not isNil(var_281_9) and arg_278_1.var_.characterEffect1039ui_story == nil then
				arg_278_1.var_.characterEffect1039ui_story = var_281_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_11 = 0.2

			if var_281_10 <= arg_278_1.time_ and arg_278_1.time_ < var_281_10 + var_281_11 and not isNil(var_281_9) then
				local var_281_12 = (arg_278_1.time_ - var_281_10) / var_281_11

				if arg_278_1.var_.characterEffect1039ui_story and not isNil(var_281_9) then
					arg_278_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= var_281_10 + var_281_11 and arg_278_1.time_ < var_281_10 + var_281_11 + arg_281_0 and not isNil(var_281_9) and arg_278_1.var_.characterEffect1039ui_story then
				arg_278_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_281_13 = 0

			if var_281_13 < arg_278_1.time_ and arg_278_1.time_ <= var_281_13 + arg_281_0 then
				arg_278_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			local var_281_14 = 0

			if var_281_14 < arg_278_1.time_ and arg_278_1.time_ <= var_281_14 + arg_281_0 then
				arg_278_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_281_15 = 0
			local var_281_16 = 0.275

			if var_281_15 < arg_278_1.time_ and arg_278_1.time_ <= var_281_15 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_17 = arg_278_1:FormatText(StoryNameCfg[9].name)

				arg_278_1.leftNameTxt_.text = var_281_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_18 = arg_278_1:GetWordFromCfg(112211069)
				local var_281_19 = arg_278_1:FormatText(var_281_18.content)

				arg_278_1.text_.text = var_281_19

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_20 = 11
				local var_281_21 = utf8.len(var_281_19)
				local var_281_22 = var_281_20 <= 0 and var_281_16 or var_281_16 * (var_281_21 / var_281_20)

				if var_281_22 > 0 and var_281_16 < var_281_22 then
					arg_278_1.talkMaxDuration = var_281_22

					if var_281_22 + var_281_15 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_22 + var_281_15
					end
				end

				arg_278_1.text_.text = var_281_19
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211069", "story_v_out_112211.awb") ~= 0 then
					local var_281_23 = manager.audio:GetVoiceLength("story_v_out_112211", "112211069", "story_v_out_112211.awb") / 1000

					if var_281_23 + var_281_15 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_23 + var_281_15
					end

					if var_281_18.prefab_name ~= "" and arg_278_1.actors_[var_281_18.prefab_name] ~= nil then
						local var_281_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_18.prefab_name].transform, "story_v_out_112211", "112211069", "story_v_out_112211.awb")

						arg_278_1:RecordAudio("112211069", var_281_24)
						arg_278_1:RecordAudio("112211069", var_281_24)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_112211", "112211069", "story_v_out_112211.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_112211", "112211069", "story_v_out_112211.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_25 = math.max(var_281_16, arg_278_1.talkMaxDuration)

			if var_281_15 <= arg_278_1.time_ and arg_278_1.time_ < var_281_15 + var_281_25 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_15) / var_281_25

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_15 + var_281_25 and arg_278_1.time_ < var_281_15 + var_281_25 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
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

		arg_278_1:InitPlayNodeList()
	end,
	Play112211070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 112211070
		arg_282_1.duration_ = 15.67

		local var_282_0 = {
			ja = 15.666,
			ko = 9.933,
			zh = 11.133,
			en = 13.9
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play112211071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_285_1 = 0
			local var_285_2 = 1.225

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_3 = arg_282_1:FormatText(StoryNameCfg[9].name)

				arg_282_1.leftNameTxt_.text = var_285_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_4 = arg_282_1:GetWordFromCfg(112211070)
				local var_285_5 = arg_282_1:FormatText(var_285_4.content)

				arg_282_1.text_.text = var_285_5

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_6 = 49
				local var_285_7 = utf8.len(var_285_5)
				local var_285_8 = var_285_6 <= 0 and var_285_2 or var_285_2 * (var_285_7 / var_285_6)

				if var_285_8 > 0 and var_285_2 < var_285_8 then
					arg_282_1.talkMaxDuration = var_285_8

					if var_285_8 + var_285_1 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_8 + var_285_1
					end
				end

				arg_282_1.text_.text = var_285_5
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211070", "story_v_out_112211.awb") ~= 0 then
					local var_285_9 = manager.audio:GetVoiceLength("story_v_out_112211", "112211070", "story_v_out_112211.awb") / 1000

					if var_285_9 + var_285_1 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_9 + var_285_1
					end

					if var_285_4.prefab_name ~= "" and arg_282_1.actors_[var_285_4.prefab_name] ~= nil then
						local var_285_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_4.prefab_name].transform, "story_v_out_112211", "112211070", "story_v_out_112211.awb")

						arg_282_1:RecordAudio("112211070", var_285_10)
						arg_282_1:RecordAudio("112211070", var_285_10)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_112211", "112211070", "story_v_out_112211.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_112211", "112211070", "story_v_out_112211.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_11 = math.max(var_285_2, arg_282_1.talkMaxDuration)

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_11 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_1) / var_285_11

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_1 + var_285_11 and arg_282_1.time_ < var_285_1 + var_285_11 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play112211071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 112211071
		arg_286_1.duration_ = 15.43

		local var_286_0 = {
			ja = 15.433,
			ko = 7.766,
			zh = 7.3,
			en = 8.3
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play112211072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action465")
			end

			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_289_2 = 0
			local var_289_3 = 0.925

			if var_289_2 < arg_286_1.time_ and arg_286_1.time_ <= var_289_2 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_4 = arg_286_1:FormatText(StoryNameCfg[9].name)

				arg_286_1.leftNameTxt_.text = var_289_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_5 = arg_286_1:GetWordFromCfg(112211071)
				local var_289_6 = arg_286_1:FormatText(var_289_5.content)

				arg_286_1.text_.text = var_289_6

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_7 = 37
				local var_289_8 = utf8.len(var_289_6)
				local var_289_9 = var_289_7 <= 0 and var_289_3 or var_289_3 * (var_289_8 / var_289_7)

				if var_289_9 > 0 and var_289_3 < var_289_9 then
					arg_286_1.talkMaxDuration = var_289_9

					if var_289_9 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_2
					end
				end

				arg_286_1.text_.text = var_289_6
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211071", "story_v_out_112211.awb") ~= 0 then
					local var_289_10 = manager.audio:GetVoiceLength("story_v_out_112211", "112211071", "story_v_out_112211.awb") / 1000

					if var_289_10 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_2
					end

					if var_289_5.prefab_name ~= "" and arg_286_1.actors_[var_289_5.prefab_name] ~= nil then
						local var_289_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_5.prefab_name].transform, "story_v_out_112211", "112211071", "story_v_out_112211.awb")

						arg_286_1:RecordAudio("112211071", var_289_11)
						arg_286_1:RecordAudio("112211071", var_289_11)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_112211", "112211071", "story_v_out_112211.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_112211", "112211071", "story_v_out_112211.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_12 = math.max(var_289_3, arg_286_1.talkMaxDuration)

			if var_289_2 <= arg_286_1.time_ and arg_286_1.time_ < var_289_2 + var_289_12 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_2) / var_289_12

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_2 + var_289_12 and arg_286_1.time_ < var_289_2 + var_289_12 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play112211072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 112211072
		arg_290_1.duration_ = 4.1

		local var_290_0 = {
			ja = 4.1,
			ko = 3.1,
			zh = 2.3,
			en = 2.9
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play112211073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_293_2 = 0
			local var_293_3 = 0.225

			if var_293_2 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_4 = arg_290_1:FormatText(StoryNameCfg[9].name)

				arg_290_1.leftNameTxt_.text = var_293_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_5 = arg_290_1:GetWordFromCfg(112211072)
				local var_293_6 = arg_290_1:FormatText(var_293_5.content)

				arg_290_1.text_.text = var_293_6

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_7 = 9
				local var_293_8 = utf8.len(var_293_6)
				local var_293_9 = var_293_7 <= 0 and var_293_3 or var_293_3 * (var_293_8 / var_293_7)

				if var_293_9 > 0 and var_293_3 < var_293_9 then
					arg_290_1.talkMaxDuration = var_293_9

					if var_293_9 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_9 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_6
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211072", "story_v_out_112211.awb") ~= 0 then
					local var_293_10 = manager.audio:GetVoiceLength("story_v_out_112211", "112211072", "story_v_out_112211.awb") / 1000

					if var_293_10 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_2
					end

					if var_293_5.prefab_name ~= "" and arg_290_1.actors_[var_293_5.prefab_name] ~= nil then
						local var_293_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_5.prefab_name].transform, "story_v_out_112211", "112211072", "story_v_out_112211.awb")

						arg_290_1:RecordAudio("112211072", var_293_11)
						arg_290_1:RecordAudio("112211072", var_293_11)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_112211", "112211072", "story_v_out_112211.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_112211", "112211072", "story_v_out_112211.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_12 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 <= arg_290_1.time_ and arg_290_1.time_ < var_293_2 + var_293_12 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_2) / var_293_12

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_2 + var_293_12 and arg_290_1.time_ < var_293_2 + var_293_12 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play112211073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 112211073
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play112211074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1039ui_story"].transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPos1039ui_story = var_297_0.localPosition
			end

			local var_297_2 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2
				local var_297_4 = Vector3.New(0, 100, 0)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1039ui_story, var_297_4, var_297_3)

				local var_297_5 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_5.x, var_297_5.y, var_297_5.z)

				local var_297_6 = var_297_0.localEulerAngles

				var_297_6.z = 0
				var_297_6.x = 0
				var_297_0.localEulerAngles = var_297_6
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(0, 100, 0)

				local var_297_7 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_7.x, var_297_7.y, var_297_7.z)

				local var_297_8 = var_297_0.localEulerAngles

				var_297_8.z = 0
				var_297_8.x = 0
				var_297_0.localEulerAngles = var_297_8
			end

			local var_297_9 = 0
			local var_297_10 = 0.8

			if var_297_9 < arg_294_1.time_ and arg_294_1.time_ <= var_297_9 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_11 = arg_294_1:GetWordFromCfg(112211073)
				local var_297_12 = arg_294_1:FormatText(var_297_11.content)

				arg_294_1.text_.text = var_297_12

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_13 = 32
				local var_297_14 = utf8.len(var_297_12)
				local var_297_15 = var_297_13 <= 0 and var_297_10 or var_297_10 * (var_297_14 / var_297_13)

				if var_297_15 > 0 and var_297_10 < var_297_15 then
					arg_294_1.talkMaxDuration = var_297_15

					if var_297_15 + var_297_9 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_15 + var_297_9
					end
				end

				arg_294_1.text_.text = var_297_12
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_16 = math.max(var_297_10, arg_294_1.talkMaxDuration)

			if var_297_9 <= arg_294_1.time_ and arg_294_1.time_ < var_297_9 + var_297_16 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_9) / var_297_16

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_9 + var_297_16 and arg_294_1.time_ < var_297_9 + var_297_16 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
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

		arg_294_1:InitPlayNodeList()
	end,
	Play112211074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 112211074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
			arg_298_1.auto_ = false
		end

		function arg_298_1.playNext_(arg_300_0)
			arg_298_1.onStoryFinished_()
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.475

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_2 = arg_298_1:GetWordFromCfg(112211074)
				local var_301_3 = arg_298_1:FormatText(var_301_2.content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 19
				local var_301_5 = utf8.len(var_301_3)
				local var_301_6 = var_301_4 <= 0 and var_301_1 or var_301_1 * (var_301_5 / var_301_4)

				if var_301_6 > 0 and var_301_1 < var_301_6 then
					arg_298_1.talkMaxDuration = var_301_6

					if var_301_6 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_6 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_7 and arg_298_1.time_ < var_301_0 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02a"
	},
	voices = {
		"story_v_out_112211.awb"
	}
}
