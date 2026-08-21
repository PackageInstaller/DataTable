return {
	Play319801001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319801001
		arg_1_1.duration_ = 6.87

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319801002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST72a"

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
				local var_4_5 = arg_1_1.bgs_.ST72a

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
					if iter_4_0 ~= "ST72a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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
			local var_4_25 = 0.2

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

			local var_4_30 = 0.233333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital")

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

			local var_4_36 = 1.86666666666667
			local var_4_37 = 0.25

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[698].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(319801001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 10
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_36 + 0.3
			local var_4_46 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319801002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319801002
		arg_9_1.duration_ = 3.63

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 3.63266666666667
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
				arg_9_0:Play319801003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10066ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["10066ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos10066ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -0.99, -5.83)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10066ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["10066ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10066ui_story == nil then
				arg_9_1.var_.characterEffect10066ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect10066ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10066ui_story then
				arg_9_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_20 = 0.366666666666667
			local var_12_21 = 0.175

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_22 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_22:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_23 = arg_9_1:FormatText(StoryNameCfg[640].name)

				arg_9_1.leftNameTxt_.text = var_12_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_24 = arg_9_1:GetWordFromCfg(319801002)
				local var_12_25 = arg_9_1:FormatText(var_12_24.content)

				arg_9_1.text_.text = var_12_25

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_26 = 7
				local var_12_27 = utf8.len(var_12_25)
				local var_12_28 = var_12_26 <= 0 and var_12_21 or var_12_21 * (var_12_27 / var_12_26)

				if var_12_28 > 0 and var_12_21 < var_12_28 then
					arg_9_1.talkMaxDuration = var_12_28
					var_12_20 = var_12_20 + 0.3

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end
				end

				arg_9_1.text_.text = var_12_25
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801002", "story_v_out_319801.awb") ~= 0 then
					local var_12_29 = manager.audio:GetVoiceLength("story_v_out_319801", "319801002", "story_v_out_319801.awb") / 1000

					if var_12_29 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_29 + var_12_20
					end

					if var_12_24.prefab_name ~= "" and arg_9_1.actors_[var_12_24.prefab_name] ~= nil then
						local var_12_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_24.prefab_name].transform, "story_v_out_319801", "319801002", "story_v_out_319801.awb")

						arg_9_1:RecordAudio("319801002", var_12_30)
						arg_9_1:RecordAudio("319801002", var_12_30)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319801", "319801002", "story_v_out_319801.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319801", "319801002", "story_v_out_319801.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_31 = var_12_20 + 0.3
			local var_12_32 = math.max(var_12_21, arg_9_1.talkMaxDuration)

			if var_12_31 <= arg_9_1.time_ and arg_9_1.time_ < var_12_31 + var_12_32 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_31) / var_12_32

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_31 + var_12_32 and arg_9_1.time_ < var_12_31 + var_12_32 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319801003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 319801003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play319801004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["10066ui_story"]
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 and not isNil(var_18_0) and arg_15_1.var_.characterEffect10066ui_story == nil then
				arg_15_1.var_.characterEffect10066ui_story = var_18_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.200000002980232

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 and not isNil(var_18_0) then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2

				if arg_15_1.var_.characterEffect10066ui_story and not isNil(var_18_0) then
					local var_18_4 = Mathf.Lerp(0, 0.5, var_18_3)

					arg_15_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_15_1.var_.characterEffect10066ui_story.fillRatio = var_18_4
				end
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 and not isNil(var_18_0) and arg_15_1.var_.characterEffect10066ui_story then
				local var_18_5 = 0.5

				arg_15_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_15_1.var_.characterEffect10066ui_story.fillRatio = var_18_5
			end

			local var_18_6 = 0
			local var_18_7 = 1.275

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_8 = arg_15_1:GetWordFromCfg(319801003)
				local var_18_9 = arg_15_1:FormatText(var_18_8.content)

				arg_15_1.text_.text = var_18_9

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_10 = 51
				local var_18_11 = utf8.len(var_18_9)
				local var_18_12 = var_18_10 <= 0 and var_18_7 or var_18_7 * (var_18_11 / var_18_10)

				if var_18_12 > 0 and var_18_7 < var_18_12 then
					arg_15_1.talkMaxDuration = var_18_12

					if var_18_12 + var_18_6 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_12 + var_18_6
					end
				end

				arg_15_1.text_.text = var_18_9
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_13 = math.max(var_18_7, arg_15_1.talkMaxDuration)

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_13 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_6) / var_18_13

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_6 + var_18_13 and arg_15_1.time_ < var_18_6 + var_18_13 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play319801004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 319801004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play319801005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 0.8

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_2 = arg_19_1:FormatText(StoryNameCfg[698].name)

				arg_19_1.leftNameTxt_.text = var_22_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_3 = arg_19_1:GetWordFromCfg(319801004)
				local var_22_4 = arg_19_1:FormatText(var_22_3.content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 32
				local var_22_6 = utf8.len(var_22_4)
				local var_22_7 = var_22_5 <= 0 and var_22_1 or var_22_1 * (var_22_6 / var_22_5)

				if var_22_7 > 0 and var_22_1 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_8 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_8 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_8

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_8 and arg_19_1.time_ < var_22_0 + var_22_8 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play319801005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 319801005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play319801006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_26_2 = 0
			local var_26_3 = 0.75

			if var_26_2 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_4 = arg_23_1:FormatText(StoryNameCfg[698].name)

				arg_23_1.leftNameTxt_.text = var_26_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_5 = arg_23_1:GetWordFromCfg(319801005)
				local var_26_6 = arg_23_1:FormatText(var_26_5.content)

				arg_23_1.text_.text = var_26_6

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 30
				local var_26_8 = utf8.len(var_26_6)
				local var_26_9 = var_26_7 <= 0 and var_26_3 or var_26_3 * (var_26_8 / var_26_7)

				if var_26_9 > 0 and var_26_3 < var_26_9 then
					arg_23_1.talkMaxDuration = var_26_9

					if var_26_9 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_9 + var_26_2
					end
				end

				arg_23_1.text_.text = var_26_6
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_3, arg_23_1.talkMaxDuration)

			if var_26_2 <= arg_23_1.time_ and arg_23_1.time_ < var_26_2 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_2) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_2 + var_26_10 and arg_23_1.time_ < var_26_2 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play319801006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 319801006
		arg_27_1.duration_ = 2.83

		local var_27_0 = {
			zh = 2.2,
			ja = 2.833
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play319801007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = "1084ui_story"

			if arg_27_1.actors_[var_30_0] == nil then
				local var_30_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_30_1) then
					local var_30_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_27_1.stage_.transform)

					var_30_2.name = var_30_0
					var_30_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_27_1.actors_[var_30_0] = var_30_2

					local var_30_3 = var_30_2:GetComponentInChildren(typeof(CharacterEffect))

					var_30_3.enabled = true

					local var_30_4 = GameObjectTools.GetOrAddComponent(var_30_2, typeof(DynamicBoneHelper))

					if var_30_4 then
						var_30_4:EnableDynamicBone(false)
					end

					arg_27_1:ShowWeapon(var_30_3.transform, false)

					arg_27_1.var_[var_30_0 .. "Animator"] = var_30_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_27_1.var_[var_30_0 .. "Animator"].applyRootMotion = true
					arg_27_1.var_[var_30_0 .. "LipSync"] = var_30_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_30_5 = arg_27_1.actors_["1084ui_story"].transform
			local var_30_6 = 0

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.var_.moveOldPos1084ui_story = var_30_5.localPosition

				local var_30_7 = "1084ui_story"

				arg_27_1:ShowWeapon(arg_27_1.var_[var_30_7 .. "Animator"].transform, false)
			end

			local var_30_8 = 0.001

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_8 then
				local var_30_9 = (arg_27_1.time_ - var_30_6) / var_30_8
				local var_30_10 = Vector3.New(0.7, -0.97, -6)

				var_30_5.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1084ui_story, var_30_10, var_30_9)

				local var_30_11 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_11.x, var_30_11.y, var_30_11.z)

				local var_30_12 = var_30_5.localEulerAngles

				var_30_12.z = 0
				var_30_12.x = 0
				var_30_5.localEulerAngles = var_30_12
			end

			if arg_27_1.time_ >= var_30_6 + var_30_8 and arg_27_1.time_ < var_30_6 + var_30_8 + arg_30_0 then
				var_30_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_30_13 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_13.x, var_30_13.y, var_30_13.z)

				local var_30_14 = var_30_5.localEulerAngles

				var_30_14.z = 0
				var_30_14.x = 0
				var_30_5.localEulerAngles = var_30_14
			end

			local var_30_15 = arg_27_1.actors_["1084ui_story"]
			local var_30_16 = 0

			if var_30_16 < arg_27_1.time_ and arg_27_1.time_ <= var_30_16 + arg_30_0 and not isNil(var_30_15) and arg_27_1.var_.characterEffect1084ui_story == nil then
				arg_27_1.var_.characterEffect1084ui_story = var_30_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_17 = 0.200000002980232

			if var_30_16 <= arg_27_1.time_ and arg_27_1.time_ < var_30_16 + var_30_17 and not isNil(var_30_15) then
				local var_30_18 = (arg_27_1.time_ - var_30_16) / var_30_17

				if arg_27_1.var_.characterEffect1084ui_story and not isNil(var_30_15) then
					arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_16 + var_30_17 and arg_27_1.time_ < var_30_16 + var_30_17 + arg_30_0 and not isNil(var_30_15) and arg_27_1.var_.characterEffect1084ui_story then
				arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_30_19 = 0

			if var_30_19 < arg_27_1.time_ and arg_27_1.time_ <= var_30_19 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_30_20 = 0

			if var_30_20 < arg_27_1.time_ and arg_27_1.time_ <= var_30_20 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_30_21 = arg_27_1.actors_["10066ui_story"].transform
			local var_30_22 = 0

			if var_30_22 < arg_27_1.time_ and arg_27_1.time_ <= var_30_22 + arg_30_0 then
				arg_27_1.var_.moveOldPos10066ui_story = var_30_21.localPosition
			end

			local var_30_23 = 0.001

			if var_30_22 <= arg_27_1.time_ and arg_27_1.time_ < var_30_22 + var_30_23 then
				local var_30_24 = (arg_27_1.time_ - var_30_22) / var_30_23
				local var_30_25 = Vector3.New(-0.7, -0.99, -5.83)

				var_30_21.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10066ui_story, var_30_25, var_30_24)

				local var_30_26 = manager.ui.mainCamera.transform.position - var_30_21.position

				var_30_21.forward = Vector3.New(var_30_26.x, var_30_26.y, var_30_26.z)

				local var_30_27 = var_30_21.localEulerAngles

				var_30_27.z = 0
				var_30_27.x = 0
				var_30_21.localEulerAngles = var_30_27
			end

			if arg_27_1.time_ >= var_30_22 + var_30_23 and arg_27_1.time_ < var_30_22 + var_30_23 + arg_30_0 then
				var_30_21.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_30_28 = manager.ui.mainCamera.transform.position - var_30_21.position

				var_30_21.forward = Vector3.New(var_30_28.x, var_30_28.y, var_30_28.z)

				local var_30_29 = var_30_21.localEulerAngles

				var_30_29.z = 0
				var_30_29.x = 0
				var_30_21.localEulerAngles = var_30_29
			end

			local var_30_30 = 0
			local var_30_31 = 0.3

			if var_30_30 < arg_27_1.time_ and arg_27_1.time_ <= var_30_30 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_32 = arg_27_1:FormatText(StoryNameCfg[6].name)

				arg_27_1.leftNameTxt_.text = var_30_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_33 = arg_27_1:GetWordFromCfg(319801006)
				local var_30_34 = arg_27_1:FormatText(var_30_33.content)

				arg_27_1.text_.text = var_30_34

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_35 = 12
				local var_30_36 = utf8.len(var_30_34)
				local var_30_37 = var_30_35 <= 0 and var_30_31 or var_30_31 * (var_30_36 / var_30_35)

				if var_30_37 > 0 and var_30_31 < var_30_37 then
					arg_27_1.talkMaxDuration = var_30_37

					if var_30_37 + var_30_30 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_37 + var_30_30
					end
				end

				arg_27_1.text_.text = var_30_34
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801006", "story_v_out_319801.awb") ~= 0 then
					local var_30_38 = manager.audio:GetVoiceLength("story_v_out_319801", "319801006", "story_v_out_319801.awb") / 1000

					if var_30_38 + var_30_30 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_38 + var_30_30
					end

					if var_30_33.prefab_name ~= "" and arg_27_1.actors_[var_30_33.prefab_name] ~= nil then
						local var_30_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_33.prefab_name].transform, "story_v_out_319801", "319801006", "story_v_out_319801.awb")

						arg_27_1:RecordAudio("319801006", var_30_39)
						arg_27_1:RecordAudio("319801006", var_30_39)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_319801", "319801006", "story_v_out_319801.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_319801", "319801006", "story_v_out_319801.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_40 = math.max(var_30_31, arg_27_1.talkMaxDuration)

			if var_30_30 <= arg_27_1.time_ and arg_27_1.time_ < var_30_30 + var_30_40 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_30) / var_30_40

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_30 + var_30_40 and arg_27_1.time_ < var_30_30 + var_30_40 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play319801007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 319801007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play319801008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1084ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1084ui_story == nil then
				arg_31_1.var_.characterEffect1084ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect1084ui_story and not isNil(var_34_0) then
					local var_34_4 = Mathf.Lerp(0, 0.5, var_34_3)

					arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1084ui_story.fillRatio = var_34_4
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1084ui_story then
				local var_34_5 = 0.5

				arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1084ui_story.fillRatio = var_34_5
			end

			local var_34_6 = 0
			local var_34_7 = 1.075

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_8 = arg_31_1:FormatText(StoryNameCfg[698].name)

				arg_31_1.leftNameTxt_.text = var_34_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_9 = arg_31_1:GetWordFromCfg(319801007)
				local var_34_10 = arg_31_1:FormatText(var_34_9.content)

				arg_31_1.text_.text = var_34_10

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_11 = 43
				local var_34_12 = utf8.len(var_34_10)
				local var_34_13 = var_34_11 <= 0 and var_34_7 or var_34_7 * (var_34_12 / var_34_11)

				if var_34_13 > 0 and var_34_7 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_10
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_14 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_14 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_14

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_14 and arg_31_1.time_ < var_34_6 + var_34_14 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play319801008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319801008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play319801009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.575

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[698].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(319801008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 23
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_8 and arg_35_1.time_ < var_38_0 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play319801009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319801009
		arg_39_1.duration_ = 9.87

		local var_39_0 = {
			zh = 7.63266666666667,
			ja = 9.86666666666667
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play319801010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = "ST71a"

			if arg_39_1.bgs_[var_42_0] == nil then
				local var_42_1 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_42_0)
				var_42_1.name = var_42_0
				var_42_1.transform.parent = arg_39_1.stage_.transform
				var_42_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_[var_42_0] = var_42_1
			end

			local var_42_2 = 1

			if var_42_2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
				local var_42_3 = manager.ui.mainCamera.transform.localPosition
				local var_42_4 = Vector3.New(0, 0, 10) + Vector3.New(var_42_3.x, var_42_3.y, 0)
				local var_42_5 = arg_39_1.bgs_.ST71a

				var_42_5.transform.localPosition = var_42_4
				var_42_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_6 = var_42_5:GetComponent("SpriteRenderer")

				if var_42_6 and var_42_6.sprite then
					local var_42_7 = (var_42_5.transform.localPosition - var_42_3).z
					local var_42_8 = manager.ui.mainCameraCom_
					local var_42_9 = 2 * var_42_7 * Mathf.Tan(var_42_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_42_10 = var_42_9 * var_42_8.aspect
					local var_42_11 = var_42_6.sprite.bounds.size.x
					local var_42_12 = var_42_6.sprite.bounds.size.y
					local var_42_13 = var_42_10 / var_42_11
					local var_42_14 = var_42_9 / var_42_12
					local var_42_15 = var_42_14 < var_42_13 and var_42_13 or var_42_14

					var_42_5.transform.localScale = Vector3.New(var_42_15, var_42_15, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "ST71a" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_16 = 0

			if var_42_16 < arg_39_1.time_ and arg_39_1.time_ <= var_42_16 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			local var_42_17 = 0.3

			if arg_39_1.time_ >= var_42_16 + var_42_17 and arg_39_1.time_ < var_42_16 + var_42_17 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_18 = 0

			if var_42_18 < arg_39_1.time_ and arg_39_1.time_ <= var_42_18 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_19 = 1

			if var_42_18 <= arg_39_1.time_ and arg_39_1.time_ < var_42_18 + var_42_19 then
				local var_42_20 = (arg_39_1.time_ - var_42_18) / var_42_19
				local var_42_21 = Color.New(0, 0, 0)

				var_42_21.a = Mathf.Lerp(0, 1, var_42_20)
				arg_39_1.mask_.color = var_42_21
			end

			if arg_39_1.time_ >= var_42_18 + var_42_19 and arg_39_1.time_ < var_42_18 + var_42_19 + arg_42_0 then
				local var_42_22 = Color.New(0, 0, 0)

				var_42_22.a = 1
				arg_39_1.mask_.color = var_42_22
			end

			local var_42_23 = 1

			if var_42_23 < arg_39_1.time_ and arg_39_1.time_ <= var_42_23 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_24 = 2

			if var_42_23 <= arg_39_1.time_ and arg_39_1.time_ < var_42_23 + var_42_24 then
				local var_42_25 = (arg_39_1.time_ - var_42_23) / var_42_24
				local var_42_26 = Color.New(0, 0, 0)

				var_42_26.a = Mathf.Lerp(1, 0, var_42_25)
				arg_39_1.mask_.color = var_42_26
			end

			if arg_39_1.time_ >= var_42_23 + var_42_24 and arg_39_1.time_ < var_42_23 + var_42_24 + arg_42_0 then
				local var_42_27 = Color.New(0, 0, 0)
				local var_42_28 = 0

				arg_39_1.mask_.enabled = false
				var_42_27.a = var_42_28
				arg_39_1.mask_.color = var_42_27
			end

			local var_42_29 = arg_39_1.actors_["10066ui_story"].transform
			local var_42_30 = 1

			if var_42_30 < arg_39_1.time_ and arg_39_1.time_ <= var_42_30 + arg_42_0 then
				arg_39_1.var_.moveOldPos10066ui_story = var_42_29.localPosition
			end

			local var_42_31 = 0.001

			if var_42_30 <= arg_39_1.time_ and arg_39_1.time_ < var_42_30 + var_42_31 then
				local var_42_32 = (arg_39_1.time_ - var_42_30) / var_42_31
				local var_42_33 = Vector3.New(0, 100, 0)

				var_42_29.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10066ui_story, var_42_33, var_42_32)

				local var_42_34 = manager.ui.mainCamera.transform.position - var_42_29.position

				var_42_29.forward = Vector3.New(var_42_34.x, var_42_34.y, var_42_34.z)

				local var_42_35 = var_42_29.localEulerAngles

				var_42_35.z = 0
				var_42_35.x = 0
				var_42_29.localEulerAngles = var_42_35
			end

			if arg_39_1.time_ >= var_42_30 + var_42_31 and arg_39_1.time_ < var_42_30 + var_42_31 + arg_42_0 then
				var_42_29.localPosition = Vector3.New(0, 100, 0)

				local var_42_36 = manager.ui.mainCamera.transform.position - var_42_29.position

				var_42_29.forward = Vector3.New(var_42_36.x, var_42_36.y, var_42_36.z)

				local var_42_37 = var_42_29.localEulerAngles

				var_42_37.z = 0
				var_42_37.x = 0
				var_42_29.localEulerAngles = var_42_37
			end

			local var_42_38 = arg_39_1.actors_["1084ui_story"].transform
			local var_42_39 = 1

			if var_42_39 < arg_39_1.time_ and arg_39_1.time_ <= var_42_39 + arg_42_0 then
				arg_39_1.var_.moveOldPos1084ui_story = var_42_38.localPosition
			end

			local var_42_40 = 0.001

			if var_42_39 <= arg_39_1.time_ and arg_39_1.time_ < var_42_39 + var_42_40 then
				local var_42_41 = (arg_39_1.time_ - var_42_39) / var_42_40
				local var_42_42 = Vector3.New(0, 100, 0)

				var_42_38.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1084ui_story, var_42_42, var_42_41)

				local var_42_43 = manager.ui.mainCamera.transform.position - var_42_38.position

				var_42_38.forward = Vector3.New(var_42_43.x, var_42_43.y, var_42_43.z)

				local var_42_44 = var_42_38.localEulerAngles

				var_42_44.z = 0
				var_42_44.x = 0
				var_42_38.localEulerAngles = var_42_44
			end

			if arg_39_1.time_ >= var_42_39 + var_42_40 and arg_39_1.time_ < var_42_39 + var_42_40 + arg_42_0 then
				var_42_38.localPosition = Vector3.New(0, 100, 0)

				local var_42_45 = manager.ui.mainCamera.transform.position - var_42_38.position

				var_42_38.forward = Vector3.New(var_42_45.x, var_42_45.y, var_42_45.z)

				local var_42_46 = var_42_38.localEulerAngles

				var_42_46.z = 0
				var_42_46.x = 0
				var_42_38.localEulerAngles = var_42_46
			end

			local var_42_47 = 0
			local var_42_48 = 0.2

			if var_42_47 < arg_39_1.time_ and arg_39_1.time_ <= var_42_47 + arg_42_0 then
				local var_42_49 = "play"
				local var_42_50 = "music"

				arg_39_1:AudioAction(var_42_49, var_42_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_42_51 = ""
				local var_42_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_42_52 ~= "" then
					if arg_39_1.bgmTxt_.text ~= var_42_52 and arg_39_1.bgmTxt_.text ~= "" then
						if arg_39_1.bgmTxt2_.text ~= "" then
							arg_39_1.bgmTxt_.text = arg_39_1.bgmTxt2_.text
						end

						arg_39_1.bgmTxt2_.text = var_42_52

						arg_39_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_39_1.bgmTxt_.text = var_42_52
						arg_39_1.bgmTxt2_.text = var_42_52
					end

					if arg_39_1.bgmTimer then
						arg_39_1.bgmTimer:Stop()

						arg_39_1.bgmTimer = nil
					end

					if arg_39_1.settingData.show_music_name == 1 then
						arg_39_1.musicController:SetSelectedState("show")
						arg_39_1.musicAnimator_:Play("open", 0, 0)

						if arg_39_1.settingData.music_time ~= 0 then
							arg_39_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_39_1.settingData.music_time), function()
								if arg_39_1 == nil or isNil(arg_39_1.bgmTxt_) then
									return
								end

								arg_39_1.musicController:SetSelectedState("hide")
								arg_39_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_42_53 = 0.233333333333333
			local var_42_54 = 1

			if var_42_53 < arg_39_1.time_ and arg_39_1.time_ <= var_42_53 + arg_42_0 then
				local var_42_55 = "play"
				local var_42_56 = "music"

				arg_39_1:AudioAction(var_42_55, var_42_56, "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room.awb")

				local var_42_57 = ""
				local var_42_58 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room")

				if var_42_58 ~= "" then
					if arg_39_1.bgmTxt_.text ~= var_42_58 and arg_39_1.bgmTxt_.text ~= "" then
						if arg_39_1.bgmTxt2_.text ~= "" then
							arg_39_1.bgmTxt_.text = arg_39_1.bgmTxt2_.text
						end

						arg_39_1.bgmTxt2_.text = var_42_58

						arg_39_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_39_1.bgmTxt_.text = var_42_58
						arg_39_1.bgmTxt2_.text = var_42_58
					end

					if arg_39_1.bgmTimer then
						arg_39_1.bgmTimer:Stop()

						arg_39_1.bgmTimer = nil
					end

					if arg_39_1.settingData.show_music_name == 1 then
						arg_39_1.musicController:SetSelectedState("show")
						arg_39_1.musicAnimator_:Play("open", 0, 0)

						if arg_39_1.settingData.music_time ~= 0 then
							arg_39_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_39_1.settingData.music_time), function()
								if arg_39_1 == nil or isNil(arg_39_1.bgmTxt_) then
									return
								end

								arg_39_1.musicController:SetSelectedState("hide")
								arg_39_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_59 = 2.86666666666667
			local var_42_60 = 0.325

			if var_42_59 < arg_39_1.time_ and arg_39_1.time_ <= var_42_59 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_61 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_61:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_39_1.dialogCg_.alpha = arg_45_0
				end))
				var_42_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_62 = arg_39_1:FormatText(StoryNameCfg[640].name)

				arg_39_1.leftNameTxt_.text = var_42_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_63 = arg_39_1:GetWordFromCfg(319801009)
				local var_42_64 = arg_39_1:FormatText(var_42_63.content)

				arg_39_1.text_.text = var_42_64

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_65 = 13
				local var_42_66 = utf8.len(var_42_64)
				local var_42_67 = var_42_65 <= 0 and var_42_60 or var_42_60 * (var_42_66 / var_42_65)

				if var_42_67 > 0 and var_42_60 < var_42_67 then
					arg_39_1.talkMaxDuration = var_42_67
					var_42_59 = var_42_59 + 0.3

					if var_42_67 + var_42_59 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_67 + var_42_59
					end
				end

				arg_39_1.text_.text = var_42_64
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801009", "story_v_out_319801.awb") ~= 0 then
					local var_42_68 = manager.audio:GetVoiceLength("story_v_out_319801", "319801009", "story_v_out_319801.awb") / 1000

					if var_42_68 + var_42_59 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_68 + var_42_59
					end

					if var_42_63.prefab_name ~= "" and arg_39_1.actors_[var_42_63.prefab_name] ~= nil then
						local var_42_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_63.prefab_name].transform, "story_v_out_319801", "319801009", "story_v_out_319801.awb")

						arg_39_1:RecordAudio("319801009", var_42_69)
						arg_39_1:RecordAudio("319801009", var_42_69)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319801", "319801009", "story_v_out_319801.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319801", "319801009", "story_v_out_319801.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_70 = var_42_59 + 0.3
			local var_42_71 = math.max(var_42_60, arg_39_1.talkMaxDuration)

			if var_42_70 <= arg_39_1.time_ and arg_39_1.time_ < var_42_70 + var_42_71 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_70) / var_42_71

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_70 + var_42_71 and arg_39_1.time_ < var_42_70 + var_42_71 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play319801010 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319801010
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319801011(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10066ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10066ui_story == nil then
				arg_47_1.var_.characterEffect10066ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect10066ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10066ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10066ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10066ui_story.fillRatio = var_50_5
			end

			local var_50_6 = 0
			local var_50_7 = 1.3

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_8 = arg_47_1:GetWordFromCfg(319801010)
				local var_50_9 = arg_47_1:FormatText(var_50_8.content)

				arg_47_1.text_.text = var_50_9

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_10 = 52
				local var_50_11 = utf8.len(var_50_9)
				local var_50_12 = var_50_10 <= 0 and var_50_7 or var_50_7 * (var_50_11 / var_50_10)

				if var_50_12 > 0 and var_50_7 < var_50_12 then
					arg_47_1.talkMaxDuration = var_50_12

					if var_50_12 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_9
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_13 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_13 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_13

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_13 and arg_47_1.time_ < var_50_6 + var_50_13 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play319801011 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319801011
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319801012(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.725

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(319801011)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 29
				local var_54_5 = utf8.len(var_54_3)
				local var_54_6 = var_54_4 <= 0 and var_54_1 or var_54_1 * (var_54_5 / var_54_4)

				if var_54_6 > 0 and var_54_1 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_7 and arg_51_1.time_ < var_54_0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play319801012 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319801012
		arg_55_1.duration_ = 4.1

		local var_55_0 = {
			zh = 1.999999999999,
			ja = 4.1
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play319801013(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = "10050ui_story"

			if arg_55_1.actors_[var_58_0] == nil then
				local var_58_1 = Asset.Load("Char/" .. "10050ui_story")

				if not isNil(var_58_1) then
					local var_58_2 = Object.Instantiate(Asset.Load("Char/" .. "10050ui_story"), arg_55_1.stage_.transform)

					var_58_2.name = var_58_0
					var_58_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_55_1.actors_[var_58_0] = var_58_2

					local var_58_3 = var_58_2:GetComponentInChildren(typeof(CharacterEffect))

					var_58_3.enabled = true

					local var_58_4 = GameObjectTools.GetOrAddComponent(var_58_2, typeof(DynamicBoneHelper))

					if var_58_4 then
						var_58_4:EnableDynamicBone(false)
					end

					arg_55_1:ShowWeapon(var_58_3.transform, false)

					arg_55_1.var_[var_58_0 .. "Animator"] = var_58_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_55_1.var_[var_58_0 .. "Animator"].applyRootMotion = true
					arg_55_1.var_[var_58_0 .. "LipSync"] = var_58_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_58_5 = arg_55_1.actors_["10050ui_story"].transform
			local var_58_6 = 0

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.var_.moveOldPos10050ui_story = var_58_5.localPosition
			end

			local var_58_7 = 0.001

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_7 then
				local var_58_8 = (arg_55_1.time_ - var_58_6) / var_58_7
				local var_58_9 = Vector3.New(0, -0.715, -6.15)

				var_58_5.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10050ui_story, var_58_9, var_58_8)

				local var_58_10 = manager.ui.mainCamera.transform.position - var_58_5.position

				var_58_5.forward = Vector3.New(var_58_10.x, var_58_10.y, var_58_10.z)

				local var_58_11 = var_58_5.localEulerAngles

				var_58_11.z = 0
				var_58_11.x = 0
				var_58_5.localEulerAngles = var_58_11
			end

			if arg_55_1.time_ >= var_58_6 + var_58_7 and arg_55_1.time_ < var_58_6 + var_58_7 + arg_58_0 then
				var_58_5.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_58_12 = manager.ui.mainCamera.transform.position - var_58_5.position

				var_58_5.forward = Vector3.New(var_58_12.x, var_58_12.y, var_58_12.z)

				local var_58_13 = var_58_5.localEulerAngles

				var_58_13.z = 0
				var_58_13.x = 0
				var_58_5.localEulerAngles = var_58_13
			end

			local var_58_14 = arg_55_1.actors_["10050ui_story"]
			local var_58_15 = 0

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 and not isNil(var_58_14) and arg_55_1.var_.characterEffect10050ui_story == nil then
				arg_55_1.var_.characterEffect10050ui_story = var_58_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_16 = 0.200000002980232

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_16 and not isNil(var_58_14) then
				local var_58_17 = (arg_55_1.time_ - var_58_15) / var_58_16

				if arg_55_1.var_.characterEffect10050ui_story and not isNil(var_58_14) then
					arg_55_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_15 + var_58_16 and arg_55_1.time_ < var_58_15 + var_58_16 + arg_58_0 and not isNil(var_58_14) and arg_55_1.var_.characterEffect10050ui_story then
				arg_55_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_58_18 = 0

			if var_58_18 < arg_55_1.time_ and arg_55_1.time_ <= var_58_18 + arg_58_0 then
				arg_55_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			local var_58_19 = 0

			if var_58_19 < arg_55_1.time_ and arg_55_1.time_ <= var_58_19 + arg_58_0 then
				arg_55_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_58_20 = 0
			local var_58_21 = 0.2

			if var_58_20 < arg_55_1.time_ and arg_55_1.time_ <= var_58_20 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_22 = arg_55_1:FormatText(StoryNameCfg[692].name)

				arg_55_1.leftNameTxt_.text = var_58_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_23 = arg_55_1:GetWordFromCfg(319801012)
				local var_58_24 = arg_55_1:FormatText(var_58_23.content)

				arg_55_1.text_.text = var_58_24

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_25 = 8
				local var_58_26 = utf8.len(var_58_24)
				local var_58_27 = var_58_25 <= 0 and var_58_21 or var_58_21 * (var_58_26 / var_58_25)

				if var_58_27 > 0 and var_58_21 < var_58_27 then
					arg_55_1.talkMaxDuration = var_58_27

					if var_58_27 + var_58_20 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_27 + var_58_20
					end
				end

				arg_55_1.text_.text = var_58_24
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801012", "story_v_out_319801.awb") ~= 0 then
					local var_58_28 = manager.audio:GetVoiceLength("story_v_out_319801", "319801012", "story_v_out_319801.awb") / 1000

					if var_58_28 + var_58_20 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_28 + var_58_20
					end

					if var_58_23.prefab_name ~= "" and arg_55_1.actors_[var_58_23.prefab_name] ~= nil then
						local var_58_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_23.prefab_name].transform, "story_v_out_319801", "319801012", "story_v_out_319801.awb")

						arg_55_1:RecordAudio("319801012", var_58_29)
						arg_55_1:RecordAudio("319801012", var_58_29)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319801", "319801012", "story_v_out_319801.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319801", "319801012", "story_v_out_319801.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_30 = math.max(var_58_21, arg_55_1.talkMaxDuration)

			if var_58_20 <= arg_55_1.time_ and arg_55_1.time_ < var_58_20 + var_58_30 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_20) / var_58_30

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_20 + var_58_30 and arg_55_1.time_ < var_58_20 + var_58_30 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play319801013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319801013
		arg_59_1.duration_ = 7.1

		local var_59_0 = {
			zh = 3.433,
			ja = 7.1
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play319801014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = "10058ui_story"

			if arg_59_1.actors_[var_62_0] == nil then
				local var_62_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_62_1) then
					local var_62_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_59_1.stage_.transform)

					var_62_2.name = var_62_0
					var_62_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_59_1.actors_[var_62_0] = var_62_2

					local var_62_3 = var_62_2:GetComponentInChildren(typeof(CharacterEffect))

					var_62_3.enabled = true

					local var_62_4 = GameObjectTools.GetOrAddComponent(var_62_2, typeof(DynamicBoneHelper))

					if var_62_4 then
						var_62_4:EnableDynamicBone(false)
					end

					arg_59_1:ShowWeapon(var_62_3.transform, false)

					arg_59_1.var_[var_62_0 .. "Animator"] = var_62_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_59_1.var_[var_62_0 .. "Animator"].applyRootMotion = true
					arg_59_1.var_[var_62_0 .. "LipSync"] = var_62_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_62_5 = arg_59_1.actors_["10058ui_story"].transform
			local var_62_6 = 0

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.var_.moveOldPos10058ui_story = var_62_5.localPosition
			end

			local var_62_7 = 0.001

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_7 then
				local var_62_8 = (arg_59_1.time_ - var_62_6) / var_62_7
				local var_62_9 = Vector3.New(0.7, -0.98, -6.1)

				var_62_5.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10058ui_story, var_62_9, var_62_8)

				local var_62_10 = manager.ui.mainCamera.transform.position - var_62_5.position

				var_62_5.forward = Vector3.New(var_62_10.x, var_62_10.y, var_62_10.z)

				local var_62_11 = var_62_5.localEulerAngles

				var_62_11.z = 0
				var_62_11.x = 0
				var_62_5.localEulerAngles = var_62_11
			end

			if arg_59_1.time_ >= var_62_6 + var_62_7 and arg_59_1.time_ < var_62_6 + var_62_7 + arg_62_0 then
				var_62_5.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_62_12 = manager.ui.mainCamera.transform.position - var_62_5.position

				var_62_5.forward = Vector3.New(var_62_12.x, var_62_12.y, var_62_12.z)

				local var_62_13 = var_62_5.localEulerAngles

				var_62_13.z = 0
				var_62_13.x = 0
				var_62_5.localEulerAngles = var_62_13
			end

			local var_62_14 = arg_59_1.actors_["10058ui_story"]
			local var_62_15 = 0

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 and not isNil(var_62_14) and arg_59_1.var_.characterEffect10058ui_story == nil then
				arg_59_1.var_.characterEffect10058ui_story = var_62_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_16 = 0.200000002980232

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_16 and not isNil(var_62_14) then
				local var_62_17 = (arg_59_1.time_ - var_62_15) / var_62_16

				if arg_59_1.var_.characterEffect10058ui_story and not isNil(var_62_14) then
					arg_59_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_15 + var_62_16 and arg_59_1.time_ < var_62_15 + var_62_16 + arg_62_0 and not isNil(var_62_14) and arg_59_1.var_.characterEffect10058ui_story then
				arg_59_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_62_18 = 0

			if var_62_18 < arg_59_1.time_ and arg_59_1.time_ <= var_62_18 + arg_62_0 then
				arg_59_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_62_19 = 0

			if var_62_19 < arg_59_1.time_ and arg_59_1.time_ <= var_62_19 + arg_62_0 then
				arg_59_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_62_20 = arg_59_1.actors_["10050ui_story"].transform
			local var_62_21 = 0

			if var_62_21 < arg_59_1.time_ and arg_59_1.time_ <= var_62_21 + arg_62_0 then
				arg_59_1.var_.moveOldPos10050ui_story = var_62_20.localPosition
			end

			local var_62_22 = 0.001

			if var_62_21 <= arg_59_1.time_ and arg_59_1.time_ < var_62_21 + var_62_22 then
				local var_62_23 = (arg_59_1.time_ - var_62_21) / var_62_22
				local var_62_24 = Vector3.New(-0.7, -0.715, -6.15)

				var_62_20.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10050ui_story, var_62_24, var_62_23)

				local var_62_25 = manager.ui.mainCamera.transform.position - var_62_20.position

				var_62_20.forward = Vector3.New(var_62_25.x, var_62_25.y, var_62_25.z)

				local var_62_26 = var_62_20.localEulerAngles

				var_62_26.z = 0
				var_62_26.x = 0
				var_62_20.localEulerAngles = var_62_26
			end

			if arg_59_1.time_ >= var_62_21 + var_62_22 and arg_59_1.time_ < var_62_21 + var_62_22 + arg_62_0 then
				var_62_20.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_62_27 = manager.ui.mainCamera.transform.position - var_62_20.position

				var_62_20.forward = Vector3.New(var_62_27.x, var_62_27.y, var_62_27.z)

				local var_62_28 = var_62_20.localEulerAngles

				var_62_28.z = 0
				var_62_28.x = 0
				var_62_20.localEulerAngles = var_62_28
			end

			local var_62_29 = arg_59_1.actors_["10050ui_story"]
			local var_62_30 = 0

			if var_62_30 < arg_59_1.time_ and arg_59_1.time_ <= var_62_30 + arg_62_0 and not isNil(var_62_29) and arg_59_1.var_.characterEffect10050ui_story == nil then
				arg_59_1.var_.characterEffect10050ui_story = var_62_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_31 = 0.200000002980232

			if var_62_30 <= arg_59_1.time_ and arg_59_1.time_ < var_62_30 + var_62_31 and not isNil(var_62_29) then
				local var_62_32 = (arg_59_1.time_ - var_62_30) / var_62_31

				if arg_59_1.var_.characterEffect10050ui_story and not isNil(var_62_29) then
					local var_62_33 = Mathf.Lerp(0, 0.5, var_62_32)

					arg_59_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10050ui_story.fillRatio = var_62_33
				end
			end

			if arg_59_1.time_ >= var_62_30 + var_62_31 and arg_59_1.time_ < var_62_30 + var_62_31 + arg_62_0 and not isNil(var_62_29) and arg_59_1.var_.characterEffect10050ui_story then
				local var_62_34 = 0.5

				arg_59_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10050ui_story.fillRatio = var_62_34
			end

			local var_62_35 = 0
			local var_62_36 = 0.35

			if var_62_35 < arg_59_1.time_ and arg_59_1.time_ <= var_62_35 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_37 = arg_59_1:FormatText(StoryNameCfg[471].name)

				arg_59_1.leftNameTxt_.text = var_62_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_38 = arg_59_1:GetWordFromCfg(319801013)
				local var_62_39 = arg_59_1:FormatText(var_62_38.content)

				arg_59_1.text_.text = var_62_39

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_40 = 14
				local var_62_41 = utf8.len(var_62_39)
				local var_62_42 = var_62_40 <= 0 and var_62_36 or var_62_36 * (var_62_41 / var_62_40)

				if var_62_42 > 0 and var_62_36 < var_62_42 then
					arg_59_1.talkMaxDuration = var_62_42

					if var_62_42 + var_62_35 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_42 + var_62_35
					end
				end

				arg_59_1.text_.text = var_62_39
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801013", "story_v_out_319801.awb") ~= 0 then
					local var_62_43 = manager.audio:GetVoiceLength("story_v_out_319801", "319801013", "story_v_out_319801.awb") / 1000

					if var_62_43 + var_62_35 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_43 + var_62_35
					end

					if var_62_38.prefab_name ~= "" and arg_59_1.actors_[var_62_38.prefab_name] ~= nil then
						local var_62_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_38.prefab_name].transform, "story_v_out_319801", "319801013", "story_v_out_319801.awb")

						arg_59_1:RecordAudio("319801013", var_62_44)
						arg_59_1:RecordAudio("319801013", var_62_44)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319801", "319801013", "story_v_out_319801.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319801", "319801013", "story_v_out_319801.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_45 = math.max(var_62_36, arg_59_1.talkMaxDuration)

			if var_62_35 <= arg_59_1.time_ and arg_59_1.time_ < var_62_35 + var_62_45 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_35) / var_62_45

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_35 + var_62_45 and arg_59_1.time_ < var_62_35 + var_62_45 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play319801014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319801014
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play319801015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10058ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10058ui_story == nil then
				arg_63_1.var_.characterEffect10058ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect10058ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10058ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10058ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10058ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.575

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[698].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_9 = arg_63_1:GetWordFromCfg(319801014)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 23
				local var_66_12 = utf8.len(var_66_10)
				local var_66_13 = var_66_11 <= 0 and var_66_7 or var_66_7 * (var_66_12 / var_66_11)

				if var_66_13 > 0 and var_66_7 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_14 and arg_63_1.time_ < var_66_6 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play319801015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319801015
		arg_67_1.duration_ = 5.5

		local var_67_0 = {
			zh = 4.666,
			ja = 5.5
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
				arg_67_0:Play319801016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["10050ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect10050ui_story == nil then
				arg_67_1.var_.characterEffect10050ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect10050ui_story and not isNil(var_70_0) then
					arg_67_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect10050ui_story then
				arg_67_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_70_4 = 0

			if var_70_4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050actionlink/10050action424")
			end

			local var_70_5 = 0

			if var_70_5 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_70_6 = 0
			local var_70_7 = 0.425

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_8 = arg_67_1:FormatText(StoryNameCfg[692].name)

				arg_67_1.leftNameTxt_.text = var_70_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_9 = arg_67_1:GetWordFromCfg(319801015)
				local var_70_10 = arg_67_1:FormatText(var_70_9.content)

				arg_67_1.text_.text = var_70_10

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801015", "story_v_out_319801.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_319801", "319801015", "story_v_out_319801.awb") / 1000

					if var_70_14 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_6
					end

					if var_70_9.prefab_name ~= "" and arg_67_1.actors_[var_70_9.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_9.prefab_name].transform, "story_v_out_319801", "319801015", "story_v_out_319801.awb")

						arg_67_1:RecordAudio("319801015", var_70_15)
						arg_67_1:RecordAudio("319801015", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_319801", "319801015", "story_v_out_319801.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_319801", "319801015", "story_v_out_319801.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_16 and arg_67_1.time_ < var_70_6 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319801016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319801016
		arg_71_1.duration_ = 4.8

		local var_71_0 = {
			zh = 3.633,
			ja = 4.8
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
				arg_71_0:Play319801017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10058ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10058ui_story == nil then
				arg_71_1.var_.characterEffect10058ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect10058ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10058ui_story then
				arg_71_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_74_4 = 0

			if var_74_4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_74_5 = 0

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_74_6 = arg_71_1.actors_["10050ui_story"]
			local var_74_7 = 0

			if var_74_7 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect10050ui_story == nil then
				arg_71_1.var_.characterEffect10050ui_story = var_74_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_8 = 0.200000002980232

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_8 and not isNil(var_74_6) then
				local var_74_9 = (arg_71_1.time_ - var_74_7) / var_74_8

				if arg_71_1.var_.characterEffect10050ui_story and not isNil(var_74_6) then
					local var_74_10 = Mathf.Lerp(0, 0.5, var_74_9)

					arg_71_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10050ui_story.fillRatio = var_74_10
				end
			end

			if arg_71_1.time_ >= var_74_7 + var_74_8 and arg_71_1.time_ < var_74_7 + var_74_8 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect10050ui_story then
				local var_74_11 = 0.5

				arg_71_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10050ui_story.fillRatio = var_74_11
			end

			local var_74_12 = 0
			local var_74_13 = 0.425

			if var_74_12 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_14 = arg_71_1:FormatText(StoryNameCfg[471].name)

				arg_71_1.leftNameTxt_.text = var_74_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_15 = arg_71_1:GetWordFromCfg(319801016)
				local var_74_16 = arg_71_1:FormatText(var_74_15.content)

				arg_71_1.text_.text = var_74_16

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_17 = 17
				local var_74_18 = utf8.len(var_74_16)
				local var_74_19 = var_74_17 <= 0 and var_74_13 or var_74_13 * (var_74_18 / var_74_17)

				if var_74_19 > 0 and var_74_13 < var_74_19 then
					arg_71_1.talkMaxDuration = var_74_19

					if var_74_19 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_19 + var_74_12
					end
				end

				arg_71_1.text_.text = var_74_16
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801016", "story_v_out_319801.awb") ~= 0 then
					local var_74_20 = manager.audio:GetVoiceLength("story_v_out_319801", "319801016", "story_v_out_319801.awb") / 1000

					if var_74_20 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_20 + var_74_12
					end

					if var_74_15.prefab_name ~= "" and arg_71_1.actors_[var_74_15.prefab_name] ~= nil then
						local var_74_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_15.prefab_name].transform, "story_v_out_319801", "319801016", "story_v_out_319801.awb")

						arg_71_1:RecordAudio("319801016", var_74_21)
						arg_71_1:RecordAudio("319801016", var_74_21)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_319801", "319801016", "story_v_out_319801.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_319801", "319801016", "story_v_out_319801.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_22 = math.max(var_74_13, arg_71_1.talkMaxDuration)

			if var_74_12 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_22 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_12) / var_74_22

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_12 + var_74_22 and arg_71_1.time_ < var_74_12 + var_74_22 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319801017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319801017
		arg_75_1.duration_ = 6.27

		local var_75_0 = {
			zh = 4.7,
			ja = 6.266
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
				arg_75_0:Play319801018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1084ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1084ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0, -0.97, -6)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1084ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = arg_75_1.actors_["1084ui_story"]
			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1084ui_story == nil then
				arg_75_1.var_.characterEffect1084ui_story = var_78_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.200000002980232

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_11 and not isNil(var_78_9) then
				local var_78_12 = (arg_75_1.time_ - var_78_10) / var_78_11

				if arg_75_1.var_.characterEffect1084ui_story and not isNil(var_78_9) then
					arg_75_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_10 + var_78_11 and arg_75_1.time_ < var_78_10 + var_78_11 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1084ui_story then
				arg_75_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_78_13 = 0

			if var_78_13 < arg_75_1.time_ and arg_75_1.time_ <= var_78_13 + arg_78_0 then
				arg_75_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_78_14 = arg_75_1.actors_["10058ui_story"].transform
			local var_78_15 = 0

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.var_.moveOldPos10058ui_story = var_78_14.localPosition
			end

			local var_78_16 = 0.001

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_16 then
				local var_78_17 = (arg_75_1.time_ - var_78_15) / var_78_16
				local var_78_18 = Vector3.New(0, 100, 0)

				var_78_14.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10058ui_story, var_78_18, var_78_17)

				local var_78_19 = manager.ui.mainCamera.transform.position - var_78_14.position

				var_78_14.forward = Vector3.New(var_78_19.x, var_78_19.y, var_78_19.z)

				local var_78_20 = var_78_14.localEulerAngles

				var_78_20.z = 0
				var_78_20.x = 0
				var_78_14.localEulerAngles = var_78_20
			end

			if arg_75_1.time_ >= var_78_15 + var_78_16 and arg_75_1.time_ < var_78_15 + var_78_16 + arg_78_0 then
				var_78_14.localPosition = Vector3.New(0, 100, 0)

				local var_78_21 = manager.ui.mainCamera.transform.position - var_78_14.position

				var_78_14.forward = Vector3.New(var_78_21.x, var_78_21.y, var_78_21.z)

				local var_78_22 = var_78_14.localEulerAngles

				var_78_22.z = 0
				var_78_22.x = 0
				var_78_14.localEulerAngles = var_78_22
			end

			local var_78_23 = arg_75_1.actors_["10058ui_story"]
			local var_78_24 = 0

			if var_78_24 < arg_75_1.time_ and arg_75_1.time_ <= var_78_24 + arg_78_0 and not isNil(var_78_23) and arg_75_1.var_.characterEffect10058ui_story == nil then
				arg_75_1.var_.characterEffect10058ui_story = var_78_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_25 = 0.200000002980232

			if var_78_24 <= arg_75_1.time_ and arg_75_1.time_ < var_78_24 + var_78_25 and not isNil(var_78_23) then
				local var_78_26 = (arg_75_1.time_ - var_78_24) / var_78_25

				if arg_75_1.var_.characterEffect10058ui_story and not isNil(var_78_23) then
					local var_78_27 = Mathf.Lerp(0, 0.5, var_78_26)

					arg_75_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10058ui_story.fillRatio = var_78_27
				end
			end

			if arg_75_1.time_ >= var_78_24 + var_78_25 and arg_75_1.time_ < var_78_24 + var_78_25 + arg_78_0 and not isNil(var_78_23) and arg_75_1.var_.characterEffect10058ui_story then
				local var_78_28 = 0.5

				arg_75_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10058ui_story.fillRatio = var_78_28
			end

			local var_78_29 = arg_75_1.actors_["10050ui_story"].transform
			local var_78_30 = 0

			if var_78_30 < arg_75_1.time_ and arg_75_1.time_ <= var_78_30 + arg_78_0 then
				arg_75_1.var_.moveOldPos10050ui_story = var_78_29.localPosition
			end

			local var_78_31 = 0.001

			if var_78_30 <= arg_75_1.time_ and arg_75_1.time_ < var_78_30 + var_78_31 then
				local var_78_32 = (arg_75_1.time_ - var_78_30) / var_78_31
				local var_78_33 = Vector3.New(0, 100, 0)

				var_78_29.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10050ui_story, var_78_33, var_78_32)

				local var_78_34 = manager.ui.mainCamera.transform.position - var_78_29.position

				var_78_29.forward = Vector3.New(var_78_34.x, var_78_34.y, var_78_34.z)

				local var_78_35 = var_78_29.localEulerAngles

				var_78_35.z = 0
				var_78_35.x = 0
				var_78_29.localEulerAngles = var_78_35
			end

			if arg_75_1.time_ >= var_78_30 + var_78_31 and arg_75_1.time_ < var_78_30 + var_78_31 + arg_78_0 then
				var_78_29.localPosition = Vector3.New(0, 100, 0)

				local var_78_36 = manager.ui.mainCamera.transform.position - var_78_29.position

				var_78_29.forward = Vector3.New(var_78_36.x, var_78_36.y, var_78_36.z)

				local var_78_37 = var_78_29.localEulerAngles

				var_78_37.z = 0
				var_78_37.x = 0
				var_78_29.localEulerAngles = var_78_37
			end

			local var_78_38 = arg_75_1.actors_["10050ui_story"]
			local var_78_39 = 0

			if var_78_39 < arg_75_1.time_ and arg_75_1.time_ <= var_78_39 + arg_78_0 and not isNil(var_78_38) and arg_75_1.var_.characterEffect10050ui_story == nil then
				arg_75_1.var_.characterEffect10050ui_story = var_78_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_40 = 0.200000002980232

			if var_78_39 <= arg_75_1.time_ and arg_75_1.time_ < var_78_39 + var_78_40 and not isNil(var_78_38) then
				local var_78_41 = (arg_75_1.time_ - var_78_39) / var_78_40

				if arg_75_1.var_.characterEffect10050ui_story and not isNil(var_78_38) then
					local var_78_42 = Mathf.Lerp(0, 0.5, var_78_41)

					arg_75_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10050ui_story.fillRatio = var_78_42
				end
			end

			if arg_75_1.time_ >= var_78_39 + var_78_40 and arg_75_1.time_ < var_78_39 + var_78_40 + arg_78_0 and not isNil(var_78_38) and arg_75_1.var_.characterEffect10050ui_story then
				local var_78_43 = 0.5

				arg_75_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10050ui_story.fillRatio = var_78_43
			end

			local var_78_44 = 0
			local var_78_45 = 0.625

			if var_78_44 < arg_75_1.time_ and arg_75_1.time_ <= var_78_44 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_46 = arg_75_1:FormatText(StoryNameCfg[6].name)

				arg_75_1.leftNameTxt_.text = var_78_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_47 = arg_75_1:GetWordFromCfg(319801017)
				local var_78_48 = arg_75_1:FormatText(var_78_47.content)

				arg_75_1.text_.text = var_78_48

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_49 = 25
				local var_78_50 = utf8.len(var_78_48)
				local var_78_51 = var_78_49 <= 0 and var_78_45 or var_78_45 * (var_78_50 / var_78_49)

				if var_78_51 > 0 and var_78_45 < var_78_51 then
					arg_75_1.talkMaxDuration = var_78_51

					if var_78_51 + var_78_44 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_51 + var_78_44
					end
				end

				arg_75_1.text_.text = var_78_48
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801017", "story_v_out_319801.awb") ~= 0 then
					local var_78_52 = manager.audio:GetVoiceLength("story_v_out_319801", "319801017", "story_v_out_319801.awb") / 1000

					if var_78_52 + var_78_44 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_52 + var_78_44
					end

					if var_78_47.prefab_name ~= "" and arg_75_1.actors_[var_78_47.prefab_name] ~= nil then
						local var_78_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_47.prefab_name].transform, "story_v_out_319801", "319801017", "story_v_out_319801.awb")

						arg_75_1:RecordAudio("319801017", var_78_53)
						arg_75_1:RecordAudio("319801017", var_78_53)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_319801", "319801017", "story_v_out_319801.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_319801", "319801017", "story_v_out_319801.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_54 = math.max(var_78_45, arg_75_1.talkMaxDuration)

			if var_78_44 <= arg_75_1.time_ and arg_75_1.time_ < var_78_44 + var_78_54 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_44) / var_78_54

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_44 + var_78_54 and arg_75_1.time_ < var_78_44 + var_78_54 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
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
	Play319801018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319801018
		arg_79_1.duration_ = 6.27

		local var_79_0 = {
			zh = 4.933,
			ja = 6.266
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
				arg_79_0:Play319801019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10050ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos10050ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0, -0.715, -6.15)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10050ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = arg_79_1.actors_["10050ui_story"]
			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect10050ui_story == nil then
				arg_79_1.var_.characterEffect10050ui_story = var_82_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_11 = 0.200000002980232

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 and not isNil(var_82_9) then
				local var_82_12 = (arg_79_1.time_ - var_82_10) / var_82_11

				if arg_79_1.var_.characterEffect10050ui_story and not isNil(var_82_9) then
					arg_79_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect10050ui_story then
				arg_79_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_82_13 = 0

			if var_82_13 < arg_79_1.time_ and arg_79_1.time_ <= var_82_13 + arg_82_0 then
				arg_79_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_82_14 = arg_79_1.actors_["1084ui_story"].transform
			local var_82_15 = 0

			if var_82_15 < arg_79_1.time_ and arg_79_1.time_ <= var_82_15 + arg_82_0 then
				arg_79_1.var_.moveOldPos1084ui_story = var_82_14.localPosition
			end

			local var_82_16 = 0.001

			if var_82_15 <= arg_79_1.time_ and arg_79_1.time_ < var_82_15 + var_82_16 then
				local var_82_17 = (arg_79_1.time_ - var_82_15) / var_82_16
				local var_82_18 = Vector3.New(0, 100, 0)

				var_82_14.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1084ui_story, var_82_18, var_82_17)

				local var_82_19 = manager.ui.mainCamera.transform.position - var_82_14.position

				var_82_14.forward = Vector3.New(var_82_19.x, var_82_19.y, var_82_19.z)

				local var_82_20 = var_82_14.localEulerAngles

				var_82_20.z = 0
				var_82_20.x = 0
				var_82_14.localEulerAngles = var_82_20
			end

			if arg_79_1.time_ >= var_82_15 + var_82_16 and arg_79_1.time_ < var_82_15 + var_82_16 + arg_82_0 then
				var_82_14.localPosition = Vector3.New(0, 100, 0)

				local var_82_21 = manager.ui.mainCamera.transform.position - var_82_14.position

				var_82_14.forward = Vector3.New(var_82_21.x, var_82_21.y, var_82_21.z)

				local var_82_22 = var_82_14.localEulerAngles

				var_82_22.z = 0
				var_82_22.x = 0
				var_82_14.localEulerAngles = var_82_22
			end

			local var_82_23 = arg_79_1.actors_["1084ui_story"]
			local var_82_24 = 0

			if var_82_24 < arg_79_1.time_ and arg_79_1.time_ <= var_82_24 + arg_82_0 and not isNil(var_82_23) and arg_79_1.var_.characterEffect1084ui_story == nil then
				arg_79_1.var_.characterEffect1084ui_story = var_82_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_25 = 0.200000002980232

			if var_82_24 <= arg_79_1.time_ and arg_79_1.time_ < var_82_24 + var_82_25 and not isNil(var_82_23) then
				local var_82_26 = (arg_79_1.time_ - var_82_24) / var_82_25

				if arg_79_1.var_.characterEffect1084ui_story and not isNil(var_82_23) then
					local var_82_27 = Mathf.Lerp(0, 0.5, var_82_26)

					arg_79_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1084ui_story.fillRatio = var_82_27
				end
			end

			if arg_79_1.time_ >= var_82_24 + var_82_25 and arg_79_1.time_ < var_82_24 + var_82_25 + arg_82_0 and not isNil(var_82_23) and arg_79_1.var_.characterEffect1084ui_story then
				local var_82_28 = 0.5

				arg_79_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1084ui_story.fillRatio = var_82_28
			end

			local var_82_29 = 0
			local var_82_30 = 0.55

			if var_82_29 < arg_79_1.time_ and arg_79_1.time_ <= var_82_29 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_31 = arg_79_1:FormatText(StoryNameCfg[692].name)

				arg_79_1.leftNameTxt_.text = var_82_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_32 = arg_79_1:GetWordFromCfg(319801018)
				local var_82_33 = arg_79_1:FormatText(var_82_32.content)

				arg_79_1.text_.text = var_82_33

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_34 = 22
				local var_82_35 = utf8.len(var_82_33)
				local var_82_36 = var_82_34 <= 0 and var_82_30 or var_82_30 * (var_82_35 / var_82_34)

				if var_82_36 > 0 and var_82_30 < var_82_36 then
					arg_79_1.talkMaxDuration = var_82_36

					if var_82_36 + var_82_29 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_36 + var_82_29
					end
				end

				arg_79_1.text_.text = var_82_33
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801018", "story_v_out_319801.awb") ~= 0 then
					local var_82_37 = manager.audio:GetVoiceLength("story_v_out_319801", "319801018", "story_v_out_319801.awb") / 1000

					if var_82_37 + var_82_29 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_37 + var_82_29
					end

					if var_82_32.prefab_name ~= "" and arg_79_1.actors_[var_82_32.prefab_name] ~= nil then
						local var_82_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_32.prefab_name].transform, "story_v_out_319801", "319801018", "story_v_out_319801.awb")

						arg_79_1:RecordAudio("319801018", var_82_38)
						arg_79_1:RecordAudio("319801018", var_82_38)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_319801", "319801018", "story_v_out_319801.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_319801", "319801018", "story_v_out_319801.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_39 = math.max(var_82_30, arg_79_1.talkMaxDuration)

			if var_82_29 <= arg_79_1.time_ and arg_79_1.time_ < var_82_29 + var_82_39 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_29) / var_82_39

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_29 + var_82_39 and arg_79_1.time_ < var_82_29 + var_82_39 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
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

		arg_79_1:InitPlayNodeList()
	end,
	Play319801019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319801019
		arg_83_1.duration_ = 8.33

		local var_83_0 = {
			zh = 4.4,
			ja = 8.333
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play319801020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_86_1 = 0
			local var_86_2 = 0.475

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_3 = arg_83_1:FormatText(StoryNameCfg[692].name)

				arg_83_1.leftNameTxt_.text = var_86_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_4 = arg_83_1:GetWordFromCfg(319801019)
				local var_86_5 = arg_83_1:FormatText(var_86_4.content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 19
				local var_86_7 = utf8.len(var_86_5)
				local var_86_8 = var_86_6 <= 0 and var_86_2 or var_86_2 * (var_86_7 / var_86_6)

				if var_86_8 > 0 and var_86_2 < var_86_8 then
					arg_83_1.talkMaxDuration = var_86_8

					if var_86_8 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801019", "story_v_out_319801.awb") ~= 0 then
					local var_86_9 = manager.audio:GetVoiceLength("story_v_out_319801", "319801019", "story_v_out_319801.awb") / 1000

					if var_86_9 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_1
					end

					if var_86_4.prefab_name ~= "" and arg_83_1.actors_[var_86_4.prefab_name] ~= nil then
						local var_86_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_4.prefab_name].transform, "story_v_out_319801", "319801019", "story_v_out_319801.awb")

						arg_83_1:RecordAudio("319801019", var_86_10)
						arg_83_1:RecordAudio("319801019", var_86_10)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319801", "319801019", "story_v_out_319801.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319801", "319801019", "story_v_out_319801.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_11 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_11 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_11

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_11 and arg_83_1.time_ < var_86_1 + var_86_11 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play319801020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319801020
		arg_87_1.duration_ = 2.93

		local var_87_0 = {
			zh = 2.4,
			ja = 2.933
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
				arg_87_0:Play319801021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10066ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos10066ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, -0.99, -5.83)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10066ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = arg_87_1.actors_["10066ui_story"]
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect10066ui_story == nil then
				arg_87_1.var_.characterEffect10066ui_story = var_90_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_11 = 0.200000002980232

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 and not isNil(var_90_9) then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11

				if arg_87_1.var_.characterEffect10066ui_story and not isNil(var_90_9) then
					arg_87_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect10066ui_story then
				arg_87_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_90_13 = 0

			if var_90_13 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_90_14 = 0

			if var_90_14 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 then
				arg_87_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_90_15 = arg_87_1.actors_["10050ui_story"].transform
			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.var_.moveOldPos10050ui_story = var_90_15.localPosition
			end

			local var_90_17 = 0.001

			if var_90_16 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_17 then
				local var_90_18 = (arg_87_1.time_ - var_90_16) / var_90_17
				local var_90_19 = Vector3.New(0, 100, 0)

				var_90_15.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10050ui_story, var_90_19, var_90_18)

				local var_90_20 = manager.ui.mainCamera.transform.position - var_90_15.position

				var_90_15.forward = Vector3.New(var_90_20.x, var_90_20.y, var_90_20.z)

				local var_90_21 = var_90_15.localEulerAngles

				var_90_21.z = 0
				var_90_21.x = 0
				var_90_15.localEulerAngles = var_90_21
			end

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 then
				var_90_15.localPosition = Vector3.New(0, 100, 0)

				local var_90_22 = manager.ui.mainCamera.transform.position - var_90_15.position

				var_90_15.forward = Vector3.New(var_90_22.x, var_90_22.y, var_90_22.z)

				local var_90_23 = var_90_15.localEulerAngles

				var_90_23.z = 0
				var_90_23.x = 0
				var_90_15.localEulerAngles = var_90_23
			end

			local var_90_24 = arg_87_1.actors_["10050ui_story"]
			local var_90_25 = 0

			if var_90_25 < arg_87_1.time_ and arg_87_1.time_ <= var_90_25 + arg_90_0 and not isNil(var_90_24) and arg_87_1.var_.characterEffect10050ui_story == nil then
				arg_87_1.var_.characterEffect10050ui_story = var_90_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_26 = 0.200000002980232

			if var_90_25 <= arg_87_1.time_ and arg_87_1.time_ < var_90_25 + var_90_26 and not isNil(var_90_24) then
				local var_90_27 = (arg_87_1.time_ - var_90_25) / var_90_26

				if arg_87_1.var_.characterEffect10050ui_story and not isNil(var_90_24) then
					local var_90_28 = Mathf.Lerp(0, 0.5, var_90_27)

					arg_87_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10050ui_story.fillRatio = var_90_28
				end
			end

			if arg_87_1.time_ >= var_90_25 + var_90_26 and arg_87_1.time_ < var_90_25 + var_90_26 + arg_90_0 and not isNil(var_90_24) and arg_87_1.var_.characterEffect10050ui_story then
				local var_90_29 = 0.5

				arg_87_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10050ui_story.fillRatio = var_90_29
			end

			local var_90_30 = arg_87_1.actors_["1084ui_story"].transform
			local var_90_31 = 0

			if var_90_31 < arg_87_1.time_ and arg_87_1.time_ <= var_90_31 + arg_90_0 then
				arg_87_1.var_.moveOldPos1084ui_story = var_90_30.localPosition
			end

			local var_90_32 = 0.001

			if var_90_31 <= arg_87_1.time_ and arg_87_1.time_ < var_90_31 + var_90_32 then
				local var_90_33 = (arg_87_1.time_ - var_90_31) / var_90_32
				local var_90_34 = Vector3.New(0, 100, 0)

				var_90_30.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1084ui_story, var_90_34, var_90_33)

				local var_90_35 = manager.ui.mainCamera.transform.position - var_90_30.position

				var_90_30.forward = Vector3.New(var_90_35.x, var_90_35.y, var_90_35.z)

				local var_90_36 = var_90_30.localEulerAngles

				var_90_36.z = 0
				var_90_36.x = 0
				var_90_30.localEulerAngles = var_90_36
			end

			if arg_87_1.time_ >= var_90_31 + var_90_32 and arg_87_1.time_ < var_90_31 + var_90_32 + arg_90_0 then
				var_90_30.localPosition = Vector3.New(0, 100, 0)

				local var_90_37 = manager.ui.mainCamera.transform.position - var_90_30.position

				var_90_30.forward = Vector3.New(var_90_37.x, var_90_37.y, var_90_37.z)

				local var_90_38 = var_90_30.localEulerAngles

				var_90_38.z = 0
				var_90_38.x = 0
				var_90_30.localEulerAngles = var_90_38
			end

			local var_90_39 = arg_87_1.actors_["1084ui_story"]
			local var_90_40 = 0

			if var_90_40 < arg_87_1.time_ and arg_87_1.time_ <= var_90_40 + arg_90_0 and not isNil(var_90_39) and arg_87_1.var_.characterEffect1084ui_story == nil then
				arg_87_1.var_.characterEffect1084ui_story = var_90_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_41 = 0.200000002980232

			if var_90_40 <= arg_87_1.time_ and arg_87_1.time_ < var_90_40 + var_90_41 and not isNil(var_90_39) then
				local var_90_42 = (arg_87_1.time_ - var_90_40) / var_90_41

				if arg_87_1.var_.characterEffect1084ui_story and not isNil(var_90_39) then
					local var_90_43 = Mathf.Lerp(0, 0.5, var_90_42)

					arg_87_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1084ui_story.fillRatio = var_90_43
				end
			end

			if arg_87_1.time_ >= var_90_40 + var_90_41 and arg_87_1.time_ < var_90_40 + var_90_41 + arg_90_0 and not isNil(var_90_39) and arg_87_1.var_.characterEffect1084ui_story then
				local var_90_44 = 0.5

				arg_87_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1084ui_story.fillRatio = var_90_44
			end

			local var_90_45 = 0
			local var_90_46 = 0.225

			if var_90_45 < arg_87_1.time_ and arg_87_1.time_ <= var_90_45 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_47 = arg_87_1:FormatText(StoryNameCfg[640].name)

				arg_87_1.leftNameTxt_.text = var_90_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_48 = arg_87_1:GetWordFromCfg(319801020)
				local var_90_49 = arg_87_1:FormatText(var_90_48.content)

				arg_87_1.text_.text = var_90_49

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_50 = 9
				local var_90_51 = utf8.len(var_90_49)
				local var_90_52 = var_90_50 <= 0 and var_90_46 or var_90_46 * (var_90_51 / var_90_50)

				if var_90_52 > 0 and var_90_46 < var_90_52 then
					arg_87_1.talkMaxDuration = var_90_52

					if var_90_52 + var_90_45 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_52 + var_90_45
					end
				end

				arg_87_1.text_.text = var_90_49
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801020", "story_v_out_319801.awb") ~= 0 then
					local var_90_53 = manager.audio:GetVoiceLength("story_v_out_319801", "319801020", "story_v_out_319801.awb") / 1000

					if var_90_53 + var_90_45 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_53 + var_90_45
					end

					if var_90_48.prefab_name ~= "" and arg_87_1.actors_[var_90_48.prefab_name] ~= nil then
						local var_90_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_48.prefab_name].transform, "story_v_out_319801", "319801020", "story_v_out_319801.awb")

						arg_87_1:RecordAudio("319801020", var_90_54)
						arg_87_1:RecordAudio("319801020", var_90_54)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_319801", "319801020", "story_v_out_319801.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_319801", "319801020", "story_v_out_319801.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_55 = math.max(var_90_46, arg_87_1.talkMaxDuration)

			if var_90_45 <= arg_87_1.time_ and arg_87_1.time_ < var_90_45 + var_90_55 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_45) / var_90_55

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_45 + var_90_55 and arg_87_1.time_ < var_90_45 + var_90_55 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
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

		arg_87_1:InitPlayNodeList()
	end,
	Play319801021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319801021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play319801022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10066ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos10066ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10066ui_story, var_94_4, var_94_3)

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

			local var_94_9 = arg_91_1.actors_["10066ui_story"]
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect10066ui_story == nil then
				arg_91_1.var_.characterEffect10066ui_story = var_94_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_11 = 0.200000002980232

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 and not isNil(var_94_9) then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11

				if arg_91_1.var_.characterEffect10066ui_story and not isNil(var_94_9) then
					local var_94_13 = Mathf.Lerp(0, 0.5, var_94_12)

					arg_91_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_91_1.var_.characterEffect10066ui_story.fillRatio = var_94_13
				end
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect10066ui_story then
				local var_94_14 = 0.5

				arg_91_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_91_1.var_.characterEffect10066ui_story.fillRatio = var_94_14
			end

			local var_94_15 = 0
			local var_94_16 = 0.75

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_17 = arg_91_1:GetWordFromCfg(319801021)
				local var_94_18 = arg_91_1:FormatText(var_94_17.content)

				arg_91_1.text_.text = var_94_18

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_19 = 30
				local var_94_20 = utf8.len(var_94_18)
				local var_94_21 = var_94_19 <= 0 and var_94_16 or var_94_16 * (var_94_20 / var_94_19)

				if var_94_21 > 0 and var_94_16 < var_94_21 then
					arg_91_1.talkMaxDuration = var_94_21

					if var_94_21 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_21 + var_94_15
					end
				end

				arg_91_1.text_.text = var_94_18
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_22 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_22 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_15) / var_94_22

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_15 + var_94_22 and arg_91_1.time_ < var_94_15 + var_94_22 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319801022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319801022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play319801023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.325

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[698].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:GetWordFromCfg(319801022)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 13
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_8 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_8 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_8

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_8 and arg_95_1.time_ < var_98_0 + var_98_8 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play319801023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319801023
		arg_99_1.duration_ = 3.97

		local var_99_0 = {
			zh = 1.999999999999,
			ja = 3.966
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play319801024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1084ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1084ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, -0.97, -6)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1084ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = arg_99_1.actors_["1084ui_story"]
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1084ui_story == nil then
				arg_99_1.var_.characterEffect1084ui_story = var_102_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_11 = 0.200000002980232

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 and not isNil(var_102_9) then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11

				if arg_99_1.var_.characterEffect1084ui_story and not isNil(var_102_9) then
					arg_99_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1084ui_story then
				arg_99_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_102_13 = 0

			if var_102_13 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_102_14 = 0

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_15 = 0
			local var_102_16 = 0.175

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_17 = arg_99_1:FormatText(StoryNameCfg[6].name)

				arg_99_1.leftNameTxt_.text = var_102_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_18 = arg_99_1:GetWordFromCfg(319801023)
				local var_102_19 = arg_99_1:FormatText(var_102_18.content)

				arg_99_1.text_.text = var_102_19

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_20 = 7
				local var_102_21 = utf8.len(var_102_19)
				local var_102_22 = var_102_20 <= 0 and var_102_16 or var_102_16 * (var_102_21 / var_102_20)

				if var_102_22 > 0 and var_102_16 < var_102_22 then
					arg_99_1.talkMaxDuration = var_102_22

					if var_102_22 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_22 + var_102_15
					end
				end

				arg_99_1.text_.text = var_102_19
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801023", "story_v_out_319801.awb") ~= 0 then
					local var_102_23 = manager.audio:GetVoiceLength("story_v_out_319801", "319801023", "story_v_out_319801.awb") / 1000

					if var_102_23 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_23 + var_102_15
					end

					if var_102_18.prefab_name ~= "" and arg_99_1.actors_[var_102_18.prefab_name] ~= nil then
						local var_102_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_18.prefab_name].transform, "story_v_out_319801", "319801023", "story_v_out_319801.awb")

						arg_99_1:RecordAudio("319801023", var_102_24)
						arg_99_1:RecordAudio("319801023", var_102_24)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_319801", "319801023", "story_v_out_319801.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_319801", "319801023", "story_v_out_319801.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_25 = math.max(var_102_16, arg_99_1.talkMaxDuration)

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_25 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_15) / var_102_25

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_15 + var_102_25 and arg_99_1.time_ < var_102_15 + var_102_25 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play319801024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319801024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play319801025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1084ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1084ui_story == nil then
				arg_103_1.var_.characterEffect1084ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1084ui_story and not isNil(var_106_0) then
					local var_106_4 = Mathf.Lerp(0, 0.5, var_106_3)

					arg_103_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1084ui_story.fillRatio = var_106_4
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1084ui_story then
				local var_106_5 = 0.5

				arg_103_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1084ui_story.fillRatio = var_106_5
			end

			local var_106_6 = 0
			local var_106_7 = 0.9

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_8 = arg_103_1:FormatText(StoryNameCfg[698].name)

				arg_103_1.leftNameTxt_.text = var_106_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_9 = arg_103_1:GetWordFromCfg(319801024)
				local var_106_10 = arg_103_1:FormatText(var_106_9.content)

				arg_103_1.text_.text = var_106_10

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_11 = 36
				local var_106_12 = utf8.len(var_106_10)
				local var_106_13 = var_106_11 <= 0 and var_106_7 or var_106_7 * (var_106_12 / var_106_11)

				if var_106_13 > 0 and var_106_7 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_10
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_14 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_14 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_14

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_14 and arg_103_1.time_ < var_106_6 + var_106_14 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play319801025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319801025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319801026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.975

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

				local var_110_2 = arg_107_1:GetWordFromCfg(319801025)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 39
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
	Play319801026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319801026
		arg_111_1.duration_ = 2.2

		local var_111_0 = {
			zh = 1.466,
			ja = 2.2
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
				arg_111_0:Play319801027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1084ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1084ui_story == nil then
				arg_111_1.var_.characterEffect1084ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1084ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1084ui_story then
				arg_111_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_114_4 = 0
			local var_114_5 = 0.175

			if var_114_4 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_6 = arg_111_1:FormatText(StoryNameCfg[6].name)

				arg_111_1.leftNameTxt_.text = var_114_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(319801026)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 7
				local var_114_10 = utf8.len(var_114_8)
				local var_114_11 = var_114_9 <= 0 and var_114_5 or var_114_5 * (var_114_10 / var_114_9)

				if var_114_11 > 0 and var_114_5 < var_114_11 then
					arg_111_1.talkMaxDuration = var_114_11

					if var_114_11 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_8
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801026", "story_v_out_319801.awb") ~= 0 then
					local var_114_12 = manager.audio:GetVoiceLength("story_v_out_319801", "319801026", "story_v_out_319801.awb") / 1000

					if var_114_12 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_4
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_319801", "319801026", "story_v_out_319801.awb")

						arg_111_1:RecordAudio("319801026", var_114_13)
						arg_111_1:RecordAudio("319801026", var_114_13)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_319801", "319801026", "story_v_out_319801.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_319801", "319801026", "story_v_out_319801.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_14 and arg_111_1.time_ < var_114_4 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319801027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319801027
		arg_115_1.duration_ = 10.43

		local var_115_0 = {
			zh = 9.866,
			ja = 10.433
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
				arg_115_0:Play319801028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10058ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos10058ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0.7, -0.98, -6.1)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10058ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["10058ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect10058ui_story == nil then
				arg_115_1.var_.characterEffect10058ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 and not isNil(var_118_9) then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect10058ui_story and not isNil(var_118_9) then
					arg_115_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect10058ui_story then
				arg_115_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_118_13 = 0

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_118_14 = 0

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_15 = arg_115_1.actors_["1084ui_story"].transform
			local var_118_16 = 0

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 then
				arg_115_1.var_.moveOldPos1084ui_story = var_118_15.localPosition
			end

			local var_118_17 = 0.001

			if var_118_16 <= arg_115_1.time_ and arg_115_1.time_ < var_118_16 + var_118_17 then
				local var_118_18 = (arg_115_1.time_ - var_118_16) / var_118_17
				local var_118_19 = Vector3.New(-0.7, -0.97, -6)

				var_118_15.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1084ui_story, var_118_19, var_118_18)

				local var_118_20 = manager.ui.mainCamera.transform.position - var_118_15.position

				var_118_15.forward = Vector3.New(var_118_20.x, var_118_20.y, var_118_20.z)

				local var_118_21 = var_118_15.localEulerAngles

				var_118_21.z = 0
				var_118_21.x = 0
				var_118_15.localEulerAngles = var_118_21
			end

			if arg_115_1.time_ >= var_118_16 + var_118_17 and arg_115_1.time_ < var_118_16 + var_118_17 + arg_118_0 then
				var_118_15.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_118_22 = manager.ui.mainCamera.transform.position - var_118_15.position

				var_118_15.forward = Vector3.New(var_118_22.x, var_118_22.y, var_118_22.z)

				local var_118_23 = var_118_15.localEulerAngles

				var_118_23.z = 0
				var_118_23.x = 0
				var_118_15.localEulerAngles = var_118_23
			end

			local var_118_24 = arg_115_1.actors_["1084ui_story"]
			local var_118_25 = 0

			if var_118_25 < arg_115_1.time_ and arg_115_1.time_ <= var_118_25 + arg_118_0 and not isNil(var_118_24) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_26 = 0.200000002980232

			if var_118_25 <= arg_115_1.time_ and arg_115_1.time_ < var_118_25 + var_118_26 and not isNil(var_118_24) then
				local var_118_27 = (arg_115_1.time_ - var_118_25) / var_118_26

				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_24) then
					local var_118_28 = Mathf.Lerp(0, 0.5, var_118_27)

					arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1084ui_story.fillRatio = var_118_28
				end
			end

			if arg_115_1.time_ >= var_118_25 + var_118_26 and arg_115_1.time_ < var_118_25 + var_118_26 + arg_118_0 and not isNil(var_118_24) and arg_115_1.var_.characterEffect1084ui_story then
				local var_118_29 = 0.5

				arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1084ui_story.fillRatio = var_118_29
			end

			local var_118_30 = 0
			local var_118_31 = 1.175

			if var_118_30 < arg_115_1.time_ and arg_115_1.time_ <= var_118_30 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_32 = arg_115_1:FormatText(StoryNameCfg[471].name)

				arg_115_1.leftNameTxt_.text = var_118_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_33 = arg_115_1:GetWordFromCfg(319801027)
				local var_118_34 = arg_115_1:FormatText(var_118_33.content)

				arg_115_1.text_.text = var_118_34

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_35 = 47
				local var_118_36 = utf8.len(var_118_34)
				local var_118_37 = var_118_35 <= 0 and var_118_31 or var_118_31 * (var_118_36 / var_118_35)

				if var_118_37 > 0 and var_118_31 < var_118_37 then
					arg_115_1.talkMaxDuration = var_118_37

					if var_118_37 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_37 + var_118_30
					end
				end

				arg_115_1.text_.text = var_118_34
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801027", "story_v_out_319801.awb") ~= 0 then
					local var_118_38 = manager.audio:GetVoiceLength("story_v_out_319801", "319801027", "story_v_out_319801.awb") / 1000

					if var_118_38 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_38 + var_118_30
					end

					if var_118_33.prefab_name ~= "" and arg_115_1.actors_[var_118_33.prefab_name] ~= nil then
						local var_118_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_33.prefab_name].transform, "story_v_out_319801", "319801027", "story_v_out_319801.awb")

						arg_115_1:RecordAudio("319801027", var_118_39)
						arg_115_1:RecordAudio("319801027", var_118_39)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319801", "319801027", "story_v_out_319801.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319801", "319801027", "story_v_out_319801.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_40 = math.max(var_118_31, arg_115_1.talkMaxDuration)

			if var_118_30 <= arg_115_1.time_ and arg_115_1.time_ < var_118_30 + var_118_40 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_30) / var_118_40

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_30 + var_118_40 and arg_115_1.time_ < var_118_30 + var_118_40 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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

		arg_115_1:InitPlayNodeList()
	end,
	Play319801028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319801028
		arg_119_1.duration_ = 2.73

		local var_119_0 = {
			zh = 1.999999999999,
			ja = 2.733
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
				arg_119_0:Play319801029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10058ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10058ui_story == nil then
				arg_119_1.var_.characterEffect10058ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect10058ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10058ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10058ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10058ui_story.fillRatio = var_122_5
			end

			local var_122_6 = arg_119_1.actors_["1084ui_story"]
			local var_122_7 = 0

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1084ui_story == nil then
				arg_119_1.var_.characterEffect1084ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_8 = 0.200000002980232

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 and not isNil(var_122_6) then
				local var_122_9 = (arg_119_1.time_ - var_122_7) / var_122_8

				if arg_119_1.var_.characterEffect1084ui_story and not isNil(var_122_6) then
					arg_119_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1084ui_story then
				arg_119_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_122_11 = 0

			if var_122_11 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_12 = 0
			local var_122_13 = 0.2

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_14 = arg_119_1:FormatText(StoryNameCfg[6].name)

				arg_119_1.leftNameTxt_.text = var_122_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_15 = arg_119_1:GetWordFromCfg(319801028)
				local var_122_16 = arg_119_1:FormatText(var_122_15.content)

				arg_119_1.text_.text = var_122_16

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_17 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801028", "story_v_out_319801.awb") ~= 0 then
					local var_122_20 = manager.audio:GetVoiceLength("story_v_out_319801", "319801028", "story_v_out_319801.awb") / 1000

					if var_122_20 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_20 + var_122_12
					end

					if var_122_15.prefab_name ~= "" and arg_119_1.actors_[var_122_15.prefab_name] ~= nil then
						local var_122_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_15.prefab_name].transform, "story_v_out_319801", "319801028", "story_v_out_319801.awb")

						arg_119_1:RecordAudio("319801028", var_122_21)
						arg_119_1:RecordAudio("319801028", var_122_21)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319801", "319801028", "story_v_out_319801.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319801", "319801028", "story_v_out_319801.awb")
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
	Play319801029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319801029
		arg_123_1.duration_ = 15.5

		local var_123_0 = {
			zh = 11.333,
			ja = 15.5
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play319801030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10058ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10058ui_story == nil then
				arg_123_1.var_.characterEffect10058ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect10058ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10058ui_story then
				arg_123_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_126_4 = arg_123_1.actors_["1084ui_story"]
			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = var_126_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_6 = 0.200000002980232

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_6 and not isNil(var_126_4) then
				local var_126_7 = (arg_123_1.time_ - var_126_5) / var_126_6

				if arg_123_1.var_.characterEffect1084ui_story and not isNil(var_126_4) then
					local var_126_8 = Mathf.Lerp(0, 0.5, var_126_7)

					arg_123_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1084ui_story.fillRatio = var_126_8
				end
			end

			if arg_123_1.time_ >= var_126_5 + var_126_6 and arg_123_1.time_ < var_126_5 + var_126_6 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect1084ui_story then
				local var_126_9 = 0.5

				arg_123_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1084ui_story.fillRatio = var_126_9
			end

			local var_126_10 = 0
			local var_126_11 = 1.05

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_12 = arg_123_1:FormatText(StoryNameCfg[471].name)

				arg_123_1.leftNameTxt_.text = var_126_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_13 = arg_123_1:GetWordFromCfg(319801029)
				local var_126_14 = arg_123_1:FormatText(var_126_13.content)

				arg_123_1.text_.text = var_126_14

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_15 = 42
				local var_126_16 = utf8.len(var_126_14)
				local var_126_17 = var_126_15 <= 0 and var_126_11 or var_126_11 * (var_126_16 / var_126_15)

				if var_126_17 > 0 and var_126_11 < var_126_17 then
					arg_123_1.talkMaxDuration = var_126_17

					if var_126_17 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_17 + var_126_10
					end
				end

				arg_123_1.text_.text = var_126_14
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801029", "story_v_out_319801.awb") ~= 0 then
					local var_126_18 = manager.audio:GetVoiceLength("story_v_out_319801", "319801029", "story_v_out_319801.awb") / 1000

					if var_126_18 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_18 + var_126_10
					end

					if var_126_13.prefab_name ~= "" and arg_123_1.actors_[var_126_13.prefab_name] ~= nil then
						local var_126_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_13.prefab_name].transform, "story_v_out_319801", "319801029", "story_v_out_319801.awb")

						arg_123_1:RecordAudio("319801029", var_126_19)
						arg_123_1:RecordAudio("319801029", var_126_19)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319801", "319801029", "story_v_out_319801.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319801", "319801029", "story_v_out_319801.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_20 = math.max(var_126_11, arg_123_1.talkMaxDuration)

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_20 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_10) / var_126_20

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_10 + var_126_20 and arg_123_1.time_ < var_126_10 + var_126_20 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play319801030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319801030
		arg_127_1.duration_ = 6.1

		local var_127_0 = {
			zh = 6.1,
			ja = 5.9
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
				arg_127_0:Play319801031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10058ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10058ui_story == nil then
				arg_127_1.var_.characterEffect10058ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect10058ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10058ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10058ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10058ui_story.fillRatio = var_130_5
			end

			local var_130_6 = arg_127_1.actors_["1084ui_story"]
			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_8 = 0.200000002980232

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_8 and not isNil(var_130_6) then
				local var_130_9 = (arg_127_1.time_ - var_130_7) / var_130_8

				if arg_127_1.var_.characterEffect1084ui_story and not isNil(var_130_6) then
					arg_127_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1084ui_story then
				arg_127_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_130_10 = 0
			local var_130_11 = 0.85

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_12 = arg_127_1:FormatText(StoryNameCfg[6].name)

				arg_127_1.leftNameTxt_.text = var_130_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_13 = arg_127_1:GetWordFromCfg(319801030)
				local var_130_14 = arg_127_1:FormatText(var_130_13.content)

				arg_127_1.text_.text = var_130_14

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_15 = 34
				local var_130_16 = utf8.len(var_130_14)
				local var_130_17 = var_130_15 <= 0 and var_130_11 or var_130_11 * (var_130_16 / var_130_15)

				if var_130_17 > 0 and var_130_11 < var_130_17 then
					arg_127_1.talkMaxDuration = var_130_17

					if var_130_17 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_17 + var_130_10
					end
				end

				arg_127_1.text_.text = var_130_14
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801030", "story_v_out_319801.awb") ~= 0 then
					local var_130_18 = manager.audio:GetVoiceLength("story_v_out_319801", "319801030", "story_v_out_319801.awb") / 1000

					if var_130_18 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_18 + var_130_10
					end

					if var_130_13.prefab_name ~= "" and arg_127_1.actors_[var_130_13.prefab_name] ~= nil then
						local var_130_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_13.prefab_name].transform, "story_v_out_319801", "319801030", "story_v_out_319801.awb")

						arg_127_1:RecordAudio("319801030", var_130_19)
						arg_127_1:RecordAudio("319801030", var_130_19)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319801", "319801030", "story_v_out_319801.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319801", "319801030", "story_v_out_319801.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_20 = math.max(var_130_11, arg_127_1.talkMaxDuration)

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_20 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_10) / var_130_20

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_10 + var_130_20 and arg_127_1.time_ < var_130_10 + var_130_20 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319801031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319801031
		arg_131_1.duration_ = 2.6

		local var_131_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_131_0:Play319801032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10058ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10058ui_story == nil then
				arg_131_1.var_.characterEffect10058ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect10058ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10058ui_story then
				arg_131_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_134_4 = arg_131_1.actors_["1084ui_story"]
			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1084ui_story == nil then
				arg_131_1.var_.characterEffect1084ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_6 = 0.200000002980232

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_6 and not isNil(var_134_4) then
				local var_134_7 = (arg_131_1.time_ - var_134_5) / var_134_6

				if arg_131_1.var_.characterEffect1084ui_story and not isNil(var_134_4) then
					local var_134_8 = Mathf.Lerp(0, 0.5, var_134_7)

					arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1084ui_story.fillRatio = var_134_8
				end
			end

			if arg_131_1.time_ >= var_134_5 + var_134_6 and arg_131_1.time_ < var_134_5 + var_134_6 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1084ui_story then
				local var_134_9 = 0.5

				arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1084ui_story.fillRatio = var_134_9
			end

			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 then
				arg_131_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_134_11 = 0

			if var_134_11 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 then
				arg_131_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_12 = 0
			local var_134_13 = 0.375

			if var_134_12 < arg_131_1.time_ and arg_131_1.time_ <= var_134_12 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_14 = arg_131_1:FormatText(StoryNameCfg[471].name)

				arg_131_1.leftNameTxt_.text = var_134_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_15 = arg_131_1:GetWordFromCfg(319801031)
				local var_134_16 = arg_131_1:FormatText(var_134_15.content)

				arg_131_1.text_.text = var_134_16

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_17 = 15
				local var_134_18 = utf8.len(var_134_16)
				local var_134_19 = var_134_17 <= 0 and var_134_13 or var_134_13 * (var_134_18 / var_134_17)

				if var_134_19 > 0 and var_134_13 < var_134_19 then
					arg_131_1.talkMaxDuration = var_134_19

					if var_134_19 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_19 + var_134_12
					end
				end

				arg_131_1.text_.text = var_134_16
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801031", "story_v_out_319801.awb") ~= 0 then
					local var_134_20 = manager.audio:GetVoiceLength("story_v_out_319801", "319801031", "story_v_out_319801.awb") / 1000

					if var_134_20 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_20 + var_134_12
					end

					if var_134_15.prefab_name ~= "" and arg_131_1.actors_[var_134_15.prefab_name] ~= nil then
						local var_134_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_15.prefab_name].transform, "story_v_out_319801", "319801031", "story_v_out_319801.awb")

						arg_131_1:RecordAudio("319801031", var_134_21)
						arg_131_1:RecordAudio("319801031", var_134_21)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319801", "319801031", "story_v_out_319801.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319801", "319801031", "story_v_out_319801.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_22 = math.max(var_134_13, arg_131_1.talkMaxDuration)

			if var_134_12 <= arg_131_1.time_ and arg_131_1.time_ < var_134_12 + var_134_22 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_12) / var_134_22

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_12 + var_134_22 and arg_131_1.time_ < var_134_12 + var_134_22 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play319801032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319801032
		arg_135_1.duration_ = 5.17

		local var_135_0 = {
			zh = 3.833,
			ja = 5.166
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
				arg_135_0:Play319801033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1084ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1084ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(-0.7, -0.97, -6)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1084ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = arg_135_1.actors_["1084ui_story"]
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect1084ui_story == nil then
				arg_135_1.var_.characterEffect1084ui_story = var_138_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_11 = 0.200000002980232

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 and not isNil(var_138_9) then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11

				if arg_135_1.var_.characterEffect1084ui_story and not isNil(var_138_9) then
					arg_135_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect1084ui_story then
				arg_135_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_138_13 = 0

			if var_138_13 < arg_135_1.time_ and arg_135_1.time_ <= var_138_13 + arg_138_0 then
				arg_135_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_138_14 = 0

			if var_138_14 < arg_135_1.time_ and arg_135_1.time_ <= var_138_14 + arg_138_0 then
				arg_135_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_15 = arg_135_1.actors_["10058ui_story"]
			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.characterEffect10058ui_story == nil then
				arg_135_1.var_.characterEffect10058ui_story = var_138_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_17 = 0.200000002980232

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 and not isNil(var_138_15) then
				local var_138_18 = (arg_135_1.time_ - var_138_16) / var_138_17

				if arg_135_1.var_.characterEffect10058ui_story and not isNil(var_138_15) then
					local var_138_19 = Mathf.Lerp(0, 0.5, var_138_18)

					arg_135_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10058ui_story.fillRatio = var_138_19
				end
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.characterEffect10058ui_story then
				local var_138_20 = 0.5

				arg_135_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10058ui_story.fillRatio = var_138_20
			end

			local var_138_21 = 0
			local var_138_22 = 0.725

			if var_138_21 < arg_135_1.time_ and arg_135_1.time_ <= var_138_21 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_23 = arg_135_1:FormatText(StoryNameCfg[6].name)

				arg_135_1.leftNameTxt_.text = var_138_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_24 = arg_135_1:GetWordFromCfg(319801032)
				local var_138_25 = arg_135_1:FormatText(var_138_24.content)

				arg_135_1.text_.text = var_138_25

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_26 = 29
				local var_138_27 = utf8.len(var_138_25)
				local var_138_28 = var_138_26 <= 0 and var_138_22 or var_138_22 * (var_138_27 / var_138_26)

				if var_138_28 > 0 and var_138_22 < var_138_28 then
					arg_135_1.talkMaxDuration = var_138_28

					if var_138_28 + var_138_21 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_28 + var_138_21
					end
				end

				arg_135_1.text_.text = var_138_25
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801032", "story_v_out_319801.awb") ~= 0 then
					local var_138_29 = manager.audio:GetVoiceLength("story_v_out_319801", "319801032", "story_v_out_319801.awb") / 1000

					if var_138_29 + var_138_21 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_29 + var_138_21
					end

					if var_138_24.prefab_name ~= "" and arg_135_1.actors_[var_138_24.prefab_name] ~= nil then
						local var_138_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_24.prefab_name].transform, "story_v_out_319801", "319801032", "story_v_out_319801.awb")

						arg_135_1:RecordAudio("319801032", var_138_30)
						arg_135_1:RecordAudio("319801032", var_138_30)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319801", "319801032", "story_v_out_319801.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319801", "319801032", "story_v_out_319801.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_31 = math.max(var_138_22, arg_135_1.talkMaxDuration)

			if var_138_21 <= arg_135_1.time_ and arg_135_1.time_ < var_138_21 + var_138_31 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_21) / var_138_31

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_21 + var_138_31 and arg_135_1.time_ < var_138_21 + var_138_31 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play319801033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319801033
		arg_139_1.duration_ = 7.83

		local var_139_0 = {
			zh = 6.566,
			ja = 7.833
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
				arg_139_0:Play319801034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10058ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10058ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0.7, -0.98, -6.1)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10058ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["10058ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10058ui_story == nil then
				arg_139_1.var_.characterEffect10058ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect10058ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10058ui_story then
				arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_142_13 = arg_139_1.actors_["1084ui_story"]
			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 and not isNil(var_142_13) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_15 = 0.200000002980232

			if var_142_14 <= arg_139_1.time_ and arg_139_1.time_ < var_142_14 + var_142_15 and not isNil(var_142_13) then
				local var_142_16 = (arg_139_1.time_ - var_142_14) / var_142_15

				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_13) then
					local var_142_17 = Mathf.Lerp(0, 0.5, var_142_16)

					arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1084ui_story.fillRatio = var_142_17
				end
			end

			if arg_139_1.time_ >= var_142_14 + var_142_15 and arg_139_1.time_ < var_142_14 + var_142_15 + arg_142_0 and not isNil(var_142_13) and arg_139_1.var_.characterEffect1084ui_story then
				local var_142_18 = 0.5

				arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1084ui_story.fillRatio = var_142_18
			end

			local var_142_19 = 0
			local var_142_20 = 0.7

			if var_142_19 < arg_139_1.time_ and arg_139_1.time_ <= var_142_19 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_21 = arg_139_1:FormatText(StoryNameCfg[471].name)

				arg_139_1.leftNameTxt_.text = var_142_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_22 = arg_139_1:GetWordFromCfg(319801033)
				local var_142_23 = arg_139_1:FormatText(var_142_22.content)

				arg_139_1.text_.text = var_142_23

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_24 = 28
				local var_142_25 = utf8.len(var_142_23)
				local var_142_26 = var_142_24 <= 0 and var_142_20 or var_142_20 * (var_142_25 / var_142_24)

				if var_142_26 > 0 and var_142_20 < var_142_26 then
					arg_139_1.talkMaxDuration = var_142_26

					if var_142_26 + var_142_19 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_26 + var_142_19
					end
				end

				arg_139_1.text_.text = var_142_23
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801033", "story_v_out_319801.awb") ~= 0 then
					local var_142_27 = manager.audio:GetVoiceLength("story_v_out_319801", "319801033", "story_v_out_319801.awb") / 1000

					if var_142_27 + var_142_19 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_27 + var_142_19
					end

					if var_142_22.prefab_name ~= "" and arg_139_1.actors_[var_142_22.prefab_name] ~= nil then
						local var_142_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_22.prefab_name].transform, "story_v_out_319801", "319801033", "story_v_out_319801.awb")

						arg_139_1:RecordAudio("319801033", var_142_28)
						arg_139_1:RecordAudio("319801033", var_142_28)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319801", "319801033", "story_v_out_319801.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319801", "319801033", "story_v_out_319801.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_29 = math.max(var_142_20, arg_139_1.talkMaxDuration)

			if var_142_19 <= arg_139_1.time_ and arg_139_1.time_ < var_142_19 + var_142_29 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_19) / var_142_29

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_19 + var_142_29 and arg_139_1.time_ < var_142_19 + var_142_29 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play319801034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319801034
		arg_143_1.duration_ = 9.07

		local var_143_0 = {
			zh = 5.166,
			ja = 9.066
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
				arg_143_0:Play319801035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_146_2 = 0
			local var_146_3 = 0.575

			if var_146_2 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_4 = arg_143_1:FormatText(StoryNameCfg[471].name)

				arg_143_1.leftNameTxt_.text = var_146_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_5 = arg_143_1:GetWordFromCfg(319801034)
				local var_146_6 = arg_143_1:FormatText(var_146_5.content)

				arg_143_1.text_.text = var_146_6

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 23
				local var_146_8 = utf8.len(var_146_6)
				local var_146_9 = var_146_7 <= 0 and var_146_3 or var_146_3 * (var_146_8 / var_146_7)

				if var_146_9 > 0 and var_146_3 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_6
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801034", "story_v_out_319801.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801034", "story_v_out_319801.awb") / 1000

					if var_146_10 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_2
					end

					if var_146_5.prefab_name ~= "" and arg_143_1.actors_[var_146_5.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_5.prefab_name].transform, "story_v_out_319801", "319801034", "story_v_out_319801.awb")

						arg_143_1:RecordAudio("319801034", var_146_11)
						arg_143_1:RecordAudio("319801034", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319801", "319801034", "story_v_out_319801.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319801", "319801034", "story_v_out_319801.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_12 and arg_143_1.time_ < var_146_2 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play319801035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319801035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play319801036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10058ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10058ui_story == nil then
				arg_147_1.var_.characterEffect10058ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect10058ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10058ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10058ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10058ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0
			local var_150_7 = 1.1

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_8 = arg_147_1:GetWordFromCfg(319801035)
				local var_150_9 = arg_147_1:FormatText(var_150_8.content)

				arg_147_1.text_.text = var_150_9

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 44
				local var_150_11 = utf8.len(var_150_9)
				local var_150_12 = var_150_10 <= 0 and var_150_7 or var_150_7 * (var_150_11 / var_150_10)

				if var_150_12 > 0 and var_150_7 < var_150_12 then
					arg_147_1.talkMaxDuration = var_150_12

					if var_150_12 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_9
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_13 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_13 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_13

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_13 and arg_147_1.time_ < var_150_6 + var_150_13 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319801036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319801036
		arg_151_1.duration_ = 8.17

		local var_151_0 = {
			zh = 3.733,
			ja = 8.166
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
				arg_151_0:Play319801037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = "10068ui_story"

			if arg_151_1.actors_[var_154_0] == nil then
				local var_154_1 = Asset.Load("Char/" .. "10068ui_story")

				if not isNil(var_154_1) then
					local var_154_2 = Object.Instantiate(Asset.Load("Char/" .. "10068ui_story"), arg_151_1.stage_.transform)

					var_154_2.name = var_154_0
					var_154_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_151_1.actors_[var_154_0] = var_154_2

					local var_154_3 = var_154_2:GetComponentInChildren(typeof(CharacterEffect))

					var_154_3.enabled = true

					local var_154_4 = GameObjectTools.GetOrAddComponent(var_154_2, typeof(DynamicBoneHelper))

					if var_154_4 then
						var_154_4:EnableDynamicBone(false)
					end

					arg_151_1:ShowWeapon(var_154_3.transform, false)

					arg_151_1.var_[var_154_0 .. "Animator"] = var_154_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_151_1.var_[var_154_0 .. "Animator"].applyRootMotion = true
					arg_151_1.var_[var_154_0 .. "LipSync"] = var_154_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_154_5 = arg_151_1.actors_["10068ui_story"].transform
			local var_154_6 = 0

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.var_.moveOldPos10068ui_story = var_154_5.localPosition
			end

			local var_154_7 = 0.001

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_7 then
				local var_154_8 = (arg_151_1.time_ - var_154_6) / var_154_7
				local var_154_9 = Vector3.New(0, -0.75, -6.18)

				var_154_5.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10068ui_story, var_154_9, var_154_8)

				local var_154_10 = manager.ui.mainCamera.transform.position - var_154_5.position

				var_154_5.forward = Vector3.New(var_154_10.x, var_154_10.y, var_154_10.z)

				local var_154_11 = var_154_5.localEulerAngles

				var_154_11.z = 0
				var_154_11.x = 0
				var_154_5.localEulerAngles = var_154_11
			end

			if arg_151_1.time_ >= var_154_6 + var_154_7 and arg_151_1.time_ < var_154_6 + var_154_7 + arg_154_0 then
				var_154_5.localPosition = Vector3.New(0, -0.75, -6.18)

				local var_154_12 = manager.ui.mainCamera.transform.position - var_154_5.position

				var_154_5.forward = Vector3.New(var_154_12.x, var_154_12.y, var_154_12.z)

				local var_154_13 = var_154_5.localEulerAngles

				var_154_13.z = 0
				var_154_13.x = 0
				var_154_5.localEulerAngles = var_154_13
			end

			local var_154_14 = arg_151_1.actors_["10068ui_story"]
			local var_154_15 = 0

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 and not isNil(var_154_14) and arg_151_1.var_.characterEffect10068ui_story == nil then
				arg_151_1.var_.characterEffect10068ui_story = var_154_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_16 = 0.200000002980232

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_16 and not isNil(var_154_14) then
				local var_154_17 = (arg_151_1.time_ - var_154_15) / var_154_16

				if arg_151_1.var_.characterEffect10068ui_story and not isNil(var_154_14) then
					arg_151_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_15 + var_154_16 and arg_151_1.time_ < var_154_15 + var_154_16 + arg_154_0 and not isNil(var_154_14) and arg_151_1.var_.characterEffect10068ui_story then
				arg_151_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_154_18 = 0

			if var_154_18 < arg_151_1.time_ and arg_151_1.time_ <= var_154_18 + arg_154_0 then
				arg_151_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action5_1")
			end

			local var_154_19 = 0

			if var_154_19 < arg_151_1.time_ and arg_151_1.time_ <= var_154_19 + arg_154_0 then
				arg_151_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_154_20 = arg_151_1.actors_["10058ui_story"].transform
			local var_154_21 = 0

			if var_154_21 < arg_151_1.time_ and arg_151_1.time_ <= var_154_21 + arg_154_0 then
				arg_151_1.var_.moveOldPos10058ui_story = var_154_20.localPosition
			end

			local var_154_22 = 0.001

			if var_154_21 <= arg_151_1.time_ and arg_151_1.time_ < var_154_21 + var_154_22 then
				local var_154_23 = (arg_151_1.time_ - var_154_21) / var_154_22
				local var_154_24 = Vector3.New(0, 100, 0)

				var_154_20.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10058ui_story, var_154_24, var_154_23)

				local var_154_25 = manager.ui.mainCamera.transform.position - var_154_20.position

				var_154_20.forward = Vector3.New(var_154_25.x, var_154_25.y, var_154_25.z)

				local var_154_26 = var_154_20.localEulerAngles

				var_154_26.z = 0
				var_154_26.x = 0
				var_154_20.localEulerAngles = var_154_26
			end

			if arg_151_1.time_ >= var_154_21 + var_154_22 and arg_151_1.time_ < var_154_21 + var_154_22 + arg_154_0 then
				var_154_20.localPosition = Vector3.New(0, 100, 0)

				local var_154_27 = manager.ui.mainCamera.transform.position - var_154_20.position

				var_154_20.forward = Vector3.New(var_154_27.x, var_154_27.y, var_154_27.z)

				local var_154_28 = var_154_20.localEulerAngles

				var_154_28.z = 0
				var_154_28.x = 0
				var_154_20.localEulerAngles = var_154_28
			end

			local var_154_29 = arg_151_1.actors_["1084ui_story"].transform
			local var_154_30 = 0

			if var_154_30 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 then
				arg_151_1.var_.moveOldPos1084ui_story = var_154_29.localPosition
			end

			local var_154_31 = 0.001

			if var_154_30 <= arg_151_1.time_ and arg_151_1.time_ < var_154_30 + var_154_31 then
				local var_154_32 = (arg_151_1.time_ - var_154_30) / var_154_31
				local var_154_33 = Vector3.New(0, 100, 0)

				var_154_29.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1084ui_story, var_154_33, var_154_32)

				local var_154_34 = manager.ui.mainCamera.transform.position - var_154_29.position

				var_154_29.forward = Vector3.New(var_154_34.x, var_154_34.y, var_154_34.z)

				local var_154_35 = var_154_29.localEulerAngles

				var_154_35.z = 0
				var_154_35.x = 0
				var_154_29.localEulerAngles = var_154_35
			end

			if arg_151_1.time_ >= var_154_30 + var_154_31 and arg_151_1.time_ < var_154_30 + var_154_31 + arg_154_0 then
				var_154_29.localPosition = Vector3.New(0, 100, 0)

				local var_154_36 = manager.ui.mainCamera.transform.position - var_154_29.position

				var_154_29.forward = Vector3.New(var_154_36.x, var_154_36.y, var_154_36.z)

				local var_154_37 = var_154_29.localEulerAngles

				var_154_37.z = 0
				var_154_37.x = 0
				var_154_29.localEulerAngles = var_154_37
			end

			local var_154_38 = 0
			local var_154_39 = 0.35

			if var_154_38 < arg_151_1.time_ and arg_151_1.time_ <= var_154_38 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_40 = arg_151_1:FormatText(StoryNameCfg[697].name)

				arg_151_1.leftNameTxt_.text = var_154_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_41 = arg_151_1:GetWordFromCfg(319801036)
				local var_154_42 = arg_151_1:FormatText(var_154_41.content)

				arg_151_1.text_.text = var_154_42

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_43 = 14
				local var_154_44 = utf8.len(var_154_42)
				local var_154_45 = var_154_43 <= 0 and var_154_39 or var_154_39 * (var_154_44 / var_154_43)

				if var_154_45 > 0 and var_154_39 < var_154_45 then
					arg_151_1.talkMaxDuration = var_154_45

					if var_154_45 + var_154_38 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_45 + var_154_38
					end
				end

				arg_151_1.text_.text = var_154_42
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801036", "story_v_out_319801.awb") ~= 0 then
					local var_154_46 = manager.audio:GetVoiceLength("story_v_out_319801", "319801036", "story_v_out_319801.awb") / 1000

					if var_154_46 + var_154_38 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_46 + var_154_38
					end

					if var_154_41.prefab_name ~= "" and arg_151_1.actors_[var_154_41.prefab_name] ~= nil then
						local var_154_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_41.prefab_name].transform, "story_v_out_319801", "319801036", "story_v_out_319801.awb")

						arg_151_1:RecordAudio("319801036", var_154_47)
						arg_151_1:RecordAudio("319801036", var_154_47)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319801", "319801036", "story_v_out_319801.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319801", "319801036", "story_v_out_319801.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_48 = math.max(var_154_39, arg_151_1.talkMaxDuration)

			if var_154_38 <= arg_151_1.time_ and arg_151_1.time_ < var_154_38 + var_154_48 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_38) / var_154_48

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_38 + var_154_48 and arg_151_1.time_ < var_154_38 + var_154_48 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
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

		arg_151_1:InitPlayNodeList()
	end,
	Play319801037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319801037
		arg_155_1.duration_ = 2.6

		local var_155_0 = {
			zh = 2.6,
			ja = 2.233
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
				arg_155_0:Play319801038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10058ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10058ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0.7, -0.98, -6.1)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10058ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = arg_155_1.actors_["10058ui_story"]
			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect10058ui_story == nil then
				arg_155_1.var_.characterEffect10058ui_story = var_158_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_11 = 0.200000002980232

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_11 and not isNil(var_158_9) then
				local var_158_12 = (arg_155_1.time_ - var_158_10) / var_158_11

				if arg_155_1.var_.characterEffect10058ui_story and not isNil(var_158_9) then
					arg_155_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_10 + var_158_11 and arg_155_1.time_ < var_158_10 + var_158_11 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect10058ui_story then
				arg_155_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_158_13 = 0

			if var_158_13 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 then
				arg_155_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_158_14 = 0

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				arg_155_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_158_15 = arg_155_1.actors_["10068ui_story"].transform
			local var_158_16 = 0

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 then
				arg_155_1.var_.moveOldPos10068ui_story = var_158_15.localPosition
			end

			local var_158_17 = 0.001

			if var_158_16 <= arg_155_1.time_ and arg_155_1.time_ < var_158_16 + var_158_17 then
				local var_158_18 = (arg_155_1.time_ - var_158_16) / var_158_17
				local var_158_19 = Vector3.New(0, 100, 0)

				var_158_15.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10068ui_story, var_158_19, var_158_18)

				local var_158_20 = manager.ui.mainCamera.transform.position - var_158_15.position

				var_158_15.forward = Vector3.New(var_158_20.x, var_158_20.y, var_158_20.z)

				local var_158_21 = var_158_15.localEulerAngles

				var_158_21.z = 0
				var_158_21.x = 0
				var_158_15.localEulerAngles = var_158_21
			end

			if arg_155_1.time_ >= var_158_16 + var_158_17 and arg_155_1.time_ < var_158_16 + var_158_17 + arg_158_0 then
				var_158_15.localPosition = Vector3.New(0, 100, 0)

				local var_158_22 = manager.ui.mainCamera.transform.position - var_158_15.position

				var_158_15.forward = Vector3.New(var_158_22.x, var_158_22.y, var_158_22.z)

				local var_158_23 = var_158_15.localEulerAngles

				var_158_23.z = 0
				var_158_23.x = 0
				var_158_15.localEulerAngles = var_158_23
			end

			local var_158_24 = 0
			local var_158_25 = 0.2

			if var_158_24 < arg_155_1.time_ and arg_155_1.time_ <= var_158_24 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_26 = arg_155_1:FormatText(StoryNameCfg[471].name)

				arg_155_1.leftNameTxt_.text = var_158_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_27 = arg_155_1:GetWordFromCfg(319801037)
				local var_158_28 = arg_155_1:FormatText(var_158_27.content)

				arg_155_1.text_.text = var_158_28

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_29 = 8
				local var_158_30 = utf8.len(var_158_28)
				local var_158_31 = var_158_29 <= 0 and var_158_25 or var_158_25 * (var_158_30 / var_158_29)

				if var_158_31 > 0 and var_158_25 < var_158_31 then
					arg_155_1.talkMaxDuration = var_158_31

					if var_158_31 + var_158_24 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_31 + var_158_24
					end
				end

				arg_155_1.text_.text = var_158_28
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801037", "story_v_out_319801.awb") ~= 0 then
					local var_158_32 = manager.audio:GetVoiceLength("story_v_out_319801", "319801037", "story_v_out_319801.awb") / 1000

					if var_158_32 + var_158_24 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_32 + var_158_24
					end

					if var_158_27.prefab_name ~= "" and arg_155_1.actors_[var_158_27.prefab_name] ~= nil then
						local var_158_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_27.prefab_name].transform, "story_v_out_319801", "319801037", "story_v_out_319801.awb")

						arg_155_1:RecordAudio("319801037", var_158_33)
						arg_155_1:RecordAudio("319801037", var_158_33)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319801", "319801037", "story_v_out_319801.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319801", "319801037", "story_v_out_319801.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_34 = math.max(var_158_25, arg_155_1.talkMaxDuration)

			if var_158_24 <= arg_155_1.time_ and arg_155_1.time_ < var_158_24 + var_158_34 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_24) / var_158_34

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_24 + var_158_34 and arg_155_1.time_ < var_158_24 + var_158_34 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play319801038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319801038
		arg_159_1.duration_ = 2.17

		local var_159_0 = {
			zh = 2.166,
			ja = 1.999999999999
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
				arg_159_0:Play319801039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10058ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos10058ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0.7, -0.98, -6.1)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10058ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1084ui_story"].transform
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1.var_.moveOldPos1084ui_story = var_162_9.localPosition
			end

			local var_162_11 = 0.001

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11
				local var_162_13 = Vector3.New(-0.7, -0.97, -6)

				var_162_9.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1084ui_story, var_162_13, var_162_12)

				local var_162_14 = manager.ui.mainCamera.transform.position - var_162_9.position

				var_162_9.forward = Vector3.New(var_162_14.x, var_162_14.y, var_162_14.z)

				local var_162_15 = var_162_9.localEulerAngles

				var_162_15.z = 0
				var_162_15.x = 0
				var_162_9.localEulerAngles = var_162_15
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 then
				var_162_9.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_162_16 = manager.ui.mainCamera.transform.position - var_162_9.position

				var_162_9.forward = Vector3.New(var_162_16.x, var_162_16.y, var_162_16.z)

				local var_162_17 = var_162_9.localEulerAngles

				var_162_17.z = 0
				var_162_17.x = 0
				var_162_9.localEulerAngles = var_162_17
			end

			local var_162_18 = 0

			if var_162_18 < arg_159_1.time_ and arg_159_1.time_ <= var_162_18 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_162_19 = arg_159_1.actors_["10058ui_story"]
			local var_162_20 = 0

			if var_162_20 < arg_159_1.time_ and arg_159_1.time_ <= var_162_20 + arg_162_0 and not isNil(var_162_19) and arg_159_1.var_.characterEffect10058ui_story == nil then
				arg_159_1.var_.characterEffect10058ui_story = var_162_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_21 = 0.200000002980232

			if var_162_20 <= arg_159_1.time_ and arg_159_1.time_ < var_162_20 + var_162_21 and not isNil(var_162_19) then
				local var_162_22 = (arg_159_1.time_ - var_162_20) / var_162_21

				if arg_159_1.var_.characterEffect10058ui_story and not isNil(var_162_19) then
					local var_162_23 = Mathf.Lerp(0, 0.5, var_162_22)

					arg_159_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10058ui_story.fillRatio = var_162_23
				end
			end

			if arg_159_1.time_ >= var_162_20 + var_162_21 and arg_159_1.time_ < var_162_20 + var_162_21 + arg_162_0 and not isNil(var_162_19) and arg_159_1.var_.characterEffect10058ui_story then
				local var_162_24 = 0.5

				arg_159_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10058ui_story.fillRatio = var_162_24
			end

			local var_162_25 = arg_159_1.actors_["1084ui_story"]
			local var_162_26 = 0

			if var_162_26 < arg_159_1.time_ and arg_159_1.time_ <= var_162_26 + arg_162_0 and not isNil(var_162_25) and arg_159_1.var_.characterEffect1084ui_story == nil then
				arg_159_1.var_.characterEffect1084ui_story = var_162_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_27 = 0.200000002980232

			if var_162_26 <= arg_159_1.time_ and arg_159_1.time_ < var_162_26 + var_162_27 and not isNil(var_162_25) then
				local var_162_28 = (arg_159_1.time_ - var_162_26) / var_162_27

				if arg_159_1.var_.characterEffect1084ui_story and not isNil(var_162_25) then
					arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_26 + var_162_27 and arg_159_1.time_ < var_162_26 + var_162_27 + arg_162_0 and not isNil(var_162_25) and arg_159_1.var_.characterEffect1084ui_story then
				arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_162_29 = 0

			if var_162_29 < arg_159_1.time_ and arg_159_1.time_ <= var_162_29 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_162_30 = 0
			local var_162_31 = 0.175

			if var_162_30 < arg_159_1.time_ and arg_159_1.time_ <= var_162_30 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_32 = arg_159_1:FormatText(StoryNameCfg[6].name)

				arg_159_1.leftNameTxt_.text = var_162_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_33 = arg_159_1:GetWordFromCfg(319801038)
				local var_162_34 = arg_159_1:FormatText(var_162_33.content)

				arg_159_1.text_.text = var_162_34

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_35 = 7
				local var_162_36 = utf8.len(var_162_34)
				local var_162_37 = var_162_35 <= 0 and var_162_31 or var_162_31 * (var_162_36 / var_162_35)

				if var_162_37 > 0 and var_162_31 < var_162_37 then
					arg_159_1.talkMaxDuration = var_162_37

					if var_162_37 + var_162_30 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_37 + var_162_30
					end
				end

				arg_159_1.text_.text = var_162_34
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801038", "story_v_out_319801.awb") ~= 0 then
					local var_162_38 = manager.audio:GetVoiceLength("story_v_out_319801", "319801038", "story_v_out_319801.awb") / 1000

					if var_162_38 + var_162_30 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_38 + var_162_30
					end

					if var_162_33.prefab_name ~= "" and arg_159_1.actors_[var_162_33.prefab_name] ~= nil then
						local var_162_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_33.prefab_name].transform, "story_v_out_319801", "319801038", "story_v_out_319801.awb")

						arg_159_1:RecordAudio("319801038", var_162_39)
						arg_159_1:RecordAudio("319801038", var_162_39)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319801", "319801038", "story_v_out_319801.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319801", "319801038", "story_v_out_319801.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_40 = math.max(var_162_31, arg_159_1.talkMaxDuration)

			if var_162_30 <= arg_159_1.time_ and arg_159_1.time_ < var_162_30 + var_162_40 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_30) / var_162_40

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_30 + var_162_40 and arg_159_1.time_ < var_162_30 + var_162_40 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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

		arg_159_1:InitPlayNodeList()
	end,
	Play319801039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319801039
		arg_163_1.duration_ = 16.43

		local var_163_0 = {
			zh = 5.066,
			ja = 16.433
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
				arg_163_0:Play319801040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10058ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10058ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, 100, 0)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10058ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, 100, 0)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = arg_163_1.actors_["1084ui_story"].transform
			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1.var_.moveOldPos1084ui_story = var_166_9.localPosition
			end

			local var_166_11 = 0.001

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11
				local var_166_13 = Vector3.New(0, 100, 0)

				var_166_9.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1084ui_story, var_166_13, var_166_12)

				local var_166_14 = manager.ui.mainCamera.transform.position - var_166_9.position

				var_166_9.forward = Vector3.New(var_166_14.x, var_166_14.y, var_166_14.z)

				local var_166_15 = var_166_9.localEulerAngles

				var_166_15.z = 0
				var_166_15.x = 0
				var_166_9.localEulerAngles = var_166_15
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 then
				var_166_9.localPosition = Vector3.New(0, 100, 0)

				local var_166_16 = manager.ui.mainCamera.transform.position - var_166_9.position

				var_166_9.forward = Vector3.New(var_166_16.x, var_166_16.y, var_166_16.z)

				local var_166_17 = var_166_9.localEulerAngles

				var_166_17.z = 0
				var_166_17.x = 0
				var_166_9.localEulerAngles = var_166_17
			end

			local var_166_18 = arg_163_1.actors_["10068ui_story"].transform
			local var_166_19 = 0

			if var_166_19 < arg_163_1.time_ and arg_163_1.time_ <= var_166_19 + arg_166_0 then
				arg_163_1.var_.moveOldPos10068ui_story = var_166_18.localPosition
			end

			local var_166_20 = 0.001

			if var_166_19 <= arg_163_1.time_ and arg_163_1.time_ < var_166_19 + var_166_20 then
				local var_166_21 = (arg_163_1.time_ - var_166_19) / var_166_20
				local var_166_22 = Vector3.New(0, -0.75, -6.18)

				var_166_18.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10068ui_story, var_166_22, var_166_21)

				local var_166_23 = manager.ui.mainCamera.transform.position - var_166_18.position

				var_166_18.forward = Vector3.New(var_166_23.x, var_166_23.y, var_166_23.z)

				local var_166_24 = var_166_18.localEulerAngles

				var_166_24.z = 0
				var_166_24.x = 0
				var_166_18.localEulerAngles = var_166_24
			end

			if arg_163_1.time_ >= var_166_19 + var_166_20 and arg_163_1.time_ < var_166_19 + var_166_20 + arg_166_0 then
				var_166_18.localPosition = Vector3.New(0, -0.75, -6.18)

				local var_166_25 = manager.ui.mainCamera.transform.position - var_166_18.position

				var_166_18.forward = Vector3.New(var_166_25.x, var_166_25.y, var_166_25.z)

				local var_166_26 = var_166_18.localEulerAngles

				var_166_26.z = 0
				var_166_26.x = 0
				var_166_18.localEulerAngles = var_166_26
			end

			local var_166_27 = arg_163_1.actors_["10068ui_story"]
			local var_166_28 = 0

			if var_166_28 < arg_163_1.time_ and arg_163_1.time_ <= var_166_28 + arg_166_0 and not isNil(var_166_27) and arg_163_1.var_.characterEffect10068ui_story == nil then
				arg_163_1.var_.characterEffect10068ui_story = var_166_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_29 = 0.200000002980232

			if var_166_28 <= arg_163_1.time_ and arg_163_1.time_ < var_166_28 + var_166_29 and not isNil(var_166_27) then
				local var_166_30 = (arg_163_1.time_ - var_166_28) / var_166_29

				if arg_163_1.var_.characterEffect10068ui_story and not isNil(var_166_27) then
					arg_163_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_28 + var_166_29 and arg_163_1.time_ < var_166_28 + var_166_29 + arg_166_0 and not isNil(var_166_27) and arg_163_1.var_.characterEffect10068ui_story then
				arg_163_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_166_31 = 0

			if var_166_31 < arg_163_1.time_ and arg_163_1.time_ <= var_166_31 + arg_166_0 then
				arg_163_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action5_2")
			end

			local var_166_32 = 0

			if var_166_32 < arg_163_1.time_ and arg_163_1.time_ <= var_166_32 + arg_166_0 then
				arg_163_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_166_33 = 0
			local var_166_34 = 0.475

			if var_166_33 < arg_163_1.time_ and arg_163_1.time_ <= var_166_33 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_35 = arg_163_1:FormatText(StoryNameCfg[697].name)

				arg_163_1.leftNameTxt_.text = var_166_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_36 = arg_163_1:GetWordFromCfg(319801039)
				local var_166_37 = arg_163_1:FormatText(var_166_36.content)

				arg_163_1.text_.text = var_166_37

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_38 = 19
				local var_166_39 = utf8.len(var_166_37)
				local var_166_40 = var_166_38 <= 0 and var_166_34 or var_166_34 * (var_166_39 / var_166_38)

				if var_166_40 > 0 and var_166_34 < var_166_40 then
					arg_163_1.talkMaxDuration = var_166_40

					if var_166_40 + var_166_33 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_40 + var_166_33
					end
				end

				arg_163_1.text_.text = var_166_37
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801039", "story_v_out_319801.awb") ~= 0 then
					local var_166_41 = manager.audio:GetVoiceLength("story_v_out_319801", "319801039", "story_v_out_319801.awb") / 1000

					if var_166_41 + var_166_33 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_41 + var_166_33
					end

					if var_166_36.prefab_name ~= "" and arg_163_1.actors_[var_166_36.prefab_name] ~= nil then
						local var_166_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_36.prefab_name].transform, "story_v_out_319801", "319801039", "story_v_out_319801.awb")

						arg_163_1:RecordAudio("319801039", var_166_42)
						arg_163_1:RecordAudio("319801039", var_166_42)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319801", "319801039", "story_v_out_319801.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319801", "319801039", "story_v_out_319801.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_43 = math.max(var_166_34, arg_163_1.talkMaxDuration)

			if var_166_33 <= arg_163_1.time_ and arg_163_1.time_ < var_166_33 + var_166_43 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_33) / var_166_43

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_33 + var_166_43 and arg_163_1.time_ < var_166_33 + var_166_43 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
			},
			{
				assetPath = "",
				actorName = "10068ui_story",
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
	Play319801040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319801040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play319801041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10058ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10058ui_story == nil then
				arg_167_1.var_.characterEffect10058ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect10058ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10058ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10058ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10058ui_story.fillRatio = var_170_5
			end

			local var_170_6 = arg_167_1.actors_["10068ui_story"]
			local var_170_7 = 0

			if var_170_7 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect10068ui_story == nil then
				arg_167_1.var_.characterEffect10068ui_story = var_170_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_8 = 0.200000002980232

			if var_170_7 <= arg_167_1.time_ and arg_167_1.time_ < var_170_7 + var_170_8 and not isNil(var_170_6) then
				local var_170_9 = (arg_167_1.time_ - var_170_7) / var_170_8

				if arg_167_1.var_.characterEffect10068ui_story and not isNil(var_170_6) then
					local var_170_10 = Mathf.Lerp(0, 0.5, var_170_9)

					arg_167_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10068ui_story.fillRatio = var_170_10
				end
			end

			if arg_167_1.time_ >= var_170_7 + var_170_8 and arg_167_1.time_ < var_170_7 + var_170_8 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect10068ui_story then
				local var_170_11 = 0.5

				arg_167_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10068ui_story.fillRatio = var_170_11
			end

			local var_170_12 = arg_167_1.actors_["10068ui_story"].transform
			local var_170_13 = 0

			if var_170_13 < arg_167_1.time_ and arg_167_1.time_ <= var_170_13 + arg_170_0 then
				arg_167_1.var_.moveOldPos10068ui_story = var_170_12.localPosition
			end

			local var_170_14 = 0.001

			if var_170_13 <= arg_167_1.time_ and arg_167_1.time_ < var_170_13 + var_170_14 then
				local var_170_15 = (arg_167_1.time_ - var_170_13) / var_170_14
				local var_170_16 = Vector3.New(0, 100, 0)

				var_170_12.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10068ui_story, var_170_16, var_170_15)

				local var_170_17 = manager.ui.mainCamera.transform.position - var_170_12.position

				var_170_12.forward = Vector3.New(var_170_17.x, var_170_17.y, var_170_17.z)

				local var_170_18 = var_170_12.localEulerAngles

				var_170_18.z = 0
				var_170_18.x = 0
				var_170_12.localEulerAngles = var_170_18
			end

			if arg_167_1.time_ >= var_170_13 + var_170_14 and arg_167_1.time_ < var_170_13 + var_170_14 + arg_170_0 then
				var_170_12.localPosition = Vector3.New(0, 100, 0)

				local var_170_19 = manager.ui.mainCamera.transform.position - var_170_12.position

				var_170_12.forward = Vector3.New(var_170_19.x, var_170_19.y, var_170_19.z)

				local var_170_20 = var_170_12.localEulerAngles

				var_170_20.z = 0
				var_170_20.x = 0
				var_170_12.localEulerAngles = var_170_20
			end

			local var_170_21 = 0
			local var_170_22 = 0.7

			if var_170_21 < arg_167_1.time_ and arg_167_1.time_ <= var_170_21 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_23 = arg_167_1:GetWordFromCfg(319801040)
				local var_170_24 = arg_167_1:FormatText(var_170_23.content)

				arg_167_1.text_.text = var_170_24

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_25 = 28
				local var_170_26 = utf8.len(var_170_24)
				local var_170_27 = var_170_25 <= 0 and var_170_22 or var_170_22 * (var_170_26 / var_170_25)

				if var_170_27 > 0 and var_170_22 < var_170_27 then
					arg_167_1.talkMaxDuration = var_170_27

					if var_170_27 + var_170_21 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_27 + var_170_21
					end
				end

				arg_167_1.text_.text = var_170_24
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_28 = math.max(var_170_22, arg_167_1.talkMaxDuration)

			if var_170_21 <= arg_167_1.time_ and arg_167_1.time_ < var_170_21 + var_170_28 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_21) / var_170_28

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_21 + var_170_28 and arg_167_1.time_ < var_170_21 + var_170_28 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
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
	Play319801041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319801041
		arg_171_1.duration_ = 4.37

		local var_171_0 = {
			zh = 2.033,
			ja = 4.366
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
				arg_171_0:Play319801042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10058ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10058ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, -0.98, -6.1)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10058ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["10058ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10058ui_story == nil then
				arg_171_1.var_.characterEffect10058ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect10058ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10058ui_story then
				arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_174_13 = 0

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_174_15 = 0
			local var_174_16 = 0.275

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[471].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(319801041)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 11
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801041", "story_v_out_319801.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_out_319801", "319801041", "story_v_out_319801.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_out_319801", "319801041", "story_v_out_319801.awb")

						arg_171_1:RecordAudio("319801041", var_174_24)
						arg_171_1:RecordAudio("319801041", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_319801", "319801041", "story_v_out_319801.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_319801", "319801041", "story_v_out_319801.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play319801042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319801042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play319801043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10058ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10058ui_story == nil then
				arg_175_1.var_.characterEffect10058ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect10058ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10058ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10058ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10058ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.4

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_8 = arg_175_1:FormatText(StoryNameCfg[698].name)

				arg_175_1.leftNameTxt_.text = var_178_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_9 = arg_175_1:GetWordFromCfg(319801042)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 16
				local var_178_12 = utf8.len(var_178_10)
				local var_178_13 = var_178_11 <= 0 and var_178_7 or var_178_7 * (var_178_12 / var_178_11)

				if var_178_13 > 0 and var_178_7 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_10
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play319801043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319801043
		arg_179_1.duration_ = 2

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play319801044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10058ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10058ui_story == nil then
				arg_179_1.var_.characterEffect10058ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect10058ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10058ui_story then
				arg_179_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_182_4 = 0

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_182_6 = 0
			local var_182_7 = 0.075

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_8 = arg_179_1:FormatText(StoryNameCfg[471].name)

				arg_179_1.leftNameTxt_.text = var_182_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_9 = arg_179_1:GetWordFromCfg(319801043)
				local var_182_10 = arg_179_1:FormatText(var_182_9.content)

				arg_179_1.text_.text = var_182_10

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 3
				local var_182_12 = utf8.len(var_182_10)
				local var_182_13 = var_182_11 <= 0 and var_182_7 or var_182_7 * (var_182_12 / var_182_11)

				if var_182_13 > 0 and var_182_7 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_10
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801043", "story_v_out_319801.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_319801", "319801043", "story_v_out_319801.awb") / 1000

					if var_182_14 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_6
					end

					if var_182_9.prefab_name ~= "" and arg_179_1.actors_[var_182_9.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_9.prefab_name].transform, "story_v_out_319801", "319801043", "story_v_out_319801.awb")

						arg_179_1:RecordAudio("319801043", var_182_15)
						arg_179_1:RecordAudio("319801043", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_319801", "319801043", "story_v_out_319801.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_319801", "319801043", "story_v_out_319801.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_16 and arg_179_1.time_ < var_182_6 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play319801044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319801044
		arg_183_1.duration_ = 4.47

		local var_183_0 = {
			zh = 4.2,
			ja = 4.466
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play319801045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10068ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos10068ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, -0.75, -6.18)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10068ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -0.75, -6.18)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["10068ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect10068ui_story == nil then
				arg_183_1.var_.characterEffect10068ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect10068ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect10068ui_story then
				arg_183_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action3_1")
			end

			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_186_15 = arg_183_1.actors_["10058ui_story"].transform
			local var_186_16 = 0

			if var_186_16 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 then
				arg_183_1.var_.moveOldPos10058ui_story = var_186_15.localPosition
			end

			local var_186_17 = 0.001

			if var_186_16 <= arg_183_1.time_ and arg_183_1.time_ < var_186_16 + var_186_17 then
				local var_186_18 = (arg_183_1.time_ - var_186_16) / var_186_17
				local var_186_19 = Vector3.New(0, 100, 0)

				var_186_15.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10058ui_story, var_186_19, var_186_18)

				local var_186_20 = manager.ui.mainCamera.transform.position - var_186_15.position

				var_186_15.forward = Vector3.New(var_186_20.x, var_186_20.y, var_186_20.z)

				local var_186_21 = var_186_15.localEulerAngles

				var_186_21.z = 0
				var_186_21.x = 0
				var_186_15.localEulerAngles = var_186_21
			end

			if arg_183_1.time_ >= var_186_16 + var_186_17 and arg_183_1.time_ < var_186_16 + var_186_17 + arg_186_0 then
				var_186_15.localPosition = Vector3.New(0, 100, 0)

				local var_186_22 = manager.ui.mainCamera.transform.position - var_186_15.position

				var_186_15.forward = Vector3.New(var_186_22.x, var_186_22.y, var_186_22.z)

				local var_186_23 = var_186_15.localEulerAngles

				var_186_23.z = 0
				var_186_23.x = 0
				var_186_15.localEulerAngles = var_186_23
			end

			local var_186_24 = 0
			local var_186_25 = 0.45

			if var_186_24 < arg_183_1.time_ and arg_183_1.time_ <= var_186_24 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_26 = arg_183_1:FormatText(StoryNameCfg[697].name)

				arg_183_1.leftNameTxt_.text = var_186_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_27 = arg_183_1:GetWordFromCfg(319801044)
				local var_186_28 = arg_183_1:FormatText(var_186_27.content)

				arg_183_1.text_.text = var_186_28

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_29 = 18
				local var_186_30 = utf8.len(var_186_28)
				local var_186_31 = var_186_29 <= 0 and var_186_25 or var_186_25 * (var_186_30 / var_186_29)

				if var_186_31 > 0 and var_186_25 < var_186_31 then
					arg_183_1.talkMaxDuration = var_186_31

					if var_186_31 + var_186_24 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_31 + var_186_24
					end
				end

				arg_183_1.text_.text = var_186_28
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801044", "story_v_out_319801.awb") ~= 0 then
					local var_186_32 = manager.audio:GetVoiceLength("story_v_out_319801", "319801044", "story_v_out_319801.awb") / 1000

					if var_186_32 + var_186_24 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_32 + var_186_24
					end

					if var_186_27.prefab_name ~= "" and arg_183_1.actors_[var_186_27.prefab_name] ~= nil then
						local var_186_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_27.prefab_name].transform, "story_v_out_319801", "319801044", "story_v_out_319801.awb")

						arg_183_1:RecordAudio("319801044", var_186_33)
						arg_183_1:RecordAudio("319801044", var_186_33)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_319801", "319801044", "story_v_out_319801.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_319801", "319801044", "story_v_out_319801.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_34 = math.max(var_186_25, arg_183_1.talkMaxDuration)

			if var_186_24 <= arg_183_1.time_ and arg_183_1.time_ < var_186_24 + var_186_34 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_24) / var_186_34

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_24 + var_186_34 and arg_183_1.time_ < var_186_24 + var_186_34 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play319801045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319801045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play319801046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10068ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10068ui_story == nil then
				arg_187_1.var_.characterEffect10068ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect10068ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10068ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10068ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10068ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.275

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[698].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(319801045)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 11
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_14 and arg_187_1.time_ < var_190_6 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319801046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319801046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play319801047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.475

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(319801046)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 19
				local var_194_5 = utf8.len(var_194_3)
				local var_194_6 = var_194_4 <= 0 and var_194_1 or var_194_1 * (var_194_5 / var_194_4)

				if var_194_6 > 0 and var_194_1 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_7 and arg_191_1.time_ < var_194_0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play319801047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319801047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play319801048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.375

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[698].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(319801047)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 15
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_8 and arg_195_1.time_ < var_198_0 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play319801048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319801048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play319801049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 1

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				local var_202_2 = "play"
				local var_202_3 = "effect"

				arg_199_1:AudioAction(var_202_2, var_202_3, "se_story_130", "se_story_130_bowl", "")
			end

			local var_202_4 = arg_199_1.actors_["10068ui_story"].transform
			local var_202_5 = 0

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.var_.moveOldPos10068ui_story = var_202_4.localPosition
			end

			local var_202_6 = 0.001

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_6 then
				local var_202_7 = (arg_199_1.time_ - var_202_5) / var_202_6
				local var_202_8 = Vector3.New(0, 100, 0)

				var_202_4.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10068ui_story, var_202_8, var_202_7)

				local var_202_9 = manager.ui.mainCamera.transform.position - var_202_4.position

				var_202_4.forward = Vector3.New(var_202_9.x, var_202_9.y, var_202_9.z)

				local var_202_10 = var_202_4.localEulerAngles

				var_202_10.z = 0
				var_202_10.x = 0
				var_202_4.localEulerAngles = var_202_10
			end

			if arg_199_1.time_ >= var_202_5 + var_202_6 and arg_199_1.time_ < var_202_5 + var_202_6 + arg_202_0 then
				var_202_4.localPosition = Vector3.New(0, 100, 0)

				local var_202_11 = manager.ui.mainCamera.transform.position - var_202_4.position

				var_202_4.forward = Vector3.New(var_202_11.x, var_202_11.y, var_202_11.z)

				local var_202_12 = var_202_4.localEulerAngles

				var_202_12.z = 0
				var_202_12.x = 0
				var_202_4.localEulerAngles = var_202_12
			end

			local var_202_13 = 0
			local var_202_14 = 0.2

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				local var_202_15 = "play"
				local var_202_16 = "music"

				arg_199_1:AudioAction(var_202_15, var_202_16, "ui_battle", "ui_battle_stopbgm", "")

				local var_202_17 = ""
				local var_202_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_202_18 ~= "" then
					if arg_199_1.bgmTxt_.text ~= var_202_18 and arg_199_1.bgmTxt_.text ~= "" then
						if arg_199_1.bgmTxt2_.text ~= "" then
							arg_199_1.bgmTxt_.text = arg_199_1.bgmTxt2_.text
						end

						arg_199_1.bgmTxt2_.text = var_202_18

						arg_199_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_199_1.bgmTxt_.text = var_202_18
						arg_199_1.bgmTxt2_.text = var_202_18
					end

					if arg_199_1.bgmTimer then
						arg_199_1.bgmTimer:Stop()

						arg_199_1.bgmTimer = nil
					end

					if arg_199_1.settingData.show_music_name == 1 then
						arg_199_1.musicController:SetSelectedState("show")
						arg_199_1.musicAnimator_:Play("open", 0, 0)

						if arg_199_1.settingData.music_time ~= 0 then
							arg_199_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_199_1.settingData.music_time), function()
								if arg_199_1 == nil or isNil(arg_199_1.bgmTxt_) then
									return
								end

								arg_199_1.musicController:SetSelectedState("hide")
								arg_199_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_202_19 = 0
			local var_202_20 = 1.1

			if var_202_19 < arg_199_1.time_ and arg_199_1.time_ <= var_202_19 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_21 = arg_199_1:GetWordFromCfg(319801048)
				local var_202_22 = arg_199_1:FormatText(var_202_21.content)

				arg_199_1.text_.text = var_202_22

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_23 = 44
				local var_202_24 = utf8.len(var_202_22)
				local var_202_25 = var_202_23 <= 0 and var_202_20 or var_202_20 * (var_202_24 / var_202_23)

				if var_202_25 > 0 and var_202_20 < var_202_25 then
					arg_199_1.talkMaxDuration = var_202_25

					if var_202_25 + var_202_19 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_25 + var_202_19
					end
				end

				arg_199_1.text_.text = var_202_22
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_26 = math.max(var_202_20, arg_199_1.talkMaxDuration)

			if var_202_19 <= arg_199_1.time_ and arg_199_1.time_ < var_202_19 + var_202_26 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_19) / var_202_26

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_19 + var_202_26 and arg_199_1.time_ < var_202_19 + var_202_26 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play319801049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 319801049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play319801050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.55

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_2 = arg_204_1:GetWordFromCfg(319801049)
				local var_207_3 = arg_204_1:FormatText(var_207_2.content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 22
				local var_207_5 = utf8.len(var_207_3)
				local var_207_6 = var_207_4 <= 0 and var_207_1 or var_207_1 * (var_207_5 / var_207_4)

				if var_207_6 > 0 and var_207_1 < var_207_6 then
					arg_204_1.talkMaxDuration = var_207_6

					if var_207_6 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_6 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_3
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_7 and arg_204_1.time_ < var_207_0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play319801050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 319801050
		arg_208_1.duration_ = 7.47

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play319801051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 1

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				local var_211_1 = manager.ui.mainCamera.transform.localPosition
				local var_211_2 = Vector3.New(0, 0, 10) + Vector3.New(var_211_1.x, var_211_1.y, 0)
				local var_211_3 = arg_208_1.bgs_.ST72a

				var_211_3.transform.localPosition = var_211_2
				var_211_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_211_4 = var_211_3:GetComponent("SpriteRenderer")

				if var_211_4 and var_211_4.sprite then
					local var_211_5 = (var_211_3.transform.localPosition - var_211_1).z
					local var_211_6 = manager.ui.mainCameraCom_
					local var_211_7 = 2 * var_211_5 * Mathf.Tan(var_211_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_211_8 = var_211_7 * var_211_6.aspect
					local var_211_9 = var_211_4.sprite.bounds.size.x
					local var_211_10 = var_211_4.sprite.bounds.size.y
					local var_211_11 = var_211_8 / var_211_9
					local var_211_12 = var_211_7 / var_211_10
					local var_211_13 = var_211_12 < var_211_11 and var_211_11 or var_211_12

					var_211_3.transform.localScale = Vector3.New(var_211_13, var_211_13, 0)
				end

				for iter_211_0, iter_211_1 in pairs(arg_208_1.bgs_) do
					if iter_211_0 ~= "ST72a" then
						iter_211_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_211_14 = 0

			if var_211_14 < arg_208_1.time_ and arg_208_1.time_ <= var_211_14 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			local var_211_15 = 0.3

			if arg_208_1.time_ >= var_211_14 + var_211_15 and arg_208_1.time_ < var_211_14 + var_211_15 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			local var_211_16 = 0

			if var_211_16 < arg_208_1.time_ and arg_208_1.time_ <= var_211_16 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_17 = 1

			if var_211_16 <= arg_208_1.time_ and arg_208_1.time_ < var_211_16 + var_211_17 then
				local var_211_18 = (arg_208_1.time_ - var_211_16) / var_211_17
				local var_211_19 = Color.New(0, 0, 0)

				var_211_19.a = Mathf.Lerp(0, 1, var_211_18)
				arg_208_1.mask_.color = var_211_19
			end

			if arg_208_1.time_ >= var_211_16 + var_211_17 and arg_208_1.time_ < var_211_16 + var_211_17 + arg_211_0 then
				local var_211_20 = Color.New(0, 0, 0)

				var_211_20.a = 1
				arg_208_1.mask_.color = var_211_20
			end

			local var_211_21 = 1

			if var_211_21 < arg_208_1.time_ and arg_208_1.time_ <= var_211_21 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_22 = 2

			if var_211_21 <= arg_208_1.time_ and arg_208_1.time_ < var_211_21 + var_211_22 then
				local var_211_23 = (arg_208_1.time_ - var_211_21) / var_211_22
				local var_211_24 = Color.New(0, 0, 0)

				var_211_24.a = Mathf.Lerp(1, 0, var_211_23)
				arg_208_1.mask_.color = var_211_24
			end

			if arg_208_1.time_ >= var_211_21 + var_211_22 and arg_208_1.time_ < var_211_21 + var_211_22 + arg_211_0 then
				local var_211_25 = Color.New(0, 0, 0)
				local var_211_26 = 0

				arg_208_1.mask_.enabled = false
				var_211_25.a = var_211_26
				arg_208_1.mask_.color = var_211_25
			end

			local var_211_27 = arg_208_1.actors_["10058ui_story"].transform
			local var_211_28 = 0

			if var_211_28 < arg_208_1.time_ and arg_208_1.time_ <= var_211_28 + arg_211_0 then
				arg_208_1.var_.moveOldPos10058ui_story = var_211_27.localPosition
			end

			local var_211_29 = 0.001

			if var_211_28 <= arg_208_1.time_ and arg_208_1.time_ < var_211_28 + var_211_29 then
				local var_211_30 = (arg_208_1.time_ - var_211_28) / var_211_29
				local var_211_31 = Vector3.New(0, 100, 0)

				var_211_27.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10058ui_story, var_211_31, var_211_30)

				local var_211_32 = manager.ui.mainCamera.transform.position - var_211_27.position

				var_211_27.forward = Vector3.New(var_211_32.x, var_211_32.y, var_211_32.z)

				local var_211_33 = var_211_27.localEulerAngles

				var_211_33.z = 0
				var_211_33.x = 0
				var_211_27.localEulerAngles = var_211_33
			end

			if arg_208_1.time_ >= var_211_28 + var_211_29 and arg_208_1.time_ < var_211_28 + var_211_29 + arg_211_0 then
				var_211_27.localPosition = Vector3.New(0, 100, 0)

				local var_211_34 = manager.ui.mainCamera.transform.position - var_211_27.position

				var_211_27.forward = Vector3.New(var_211_34.x, var_211_34.y, var_211_34.z)

				local var_211_35 = var_211_27.localEulerAngles

				var_211_35.z = 0
				var_211_35.x = 0
				var_211_27.localEulerAngles = var_211_35
			end

			local var_211_36 = arg_208_1.actors_["10058ui_story"]
			local var_211_37 = 0

			if var_211_37 < arg_208_1.time_ and arg_208_1.time_ <= var_211_37 + arg_211_0 and not isNil(var_211_36) and arg_208_1.var_.characterEffect10058ui_story == nil then
				arg_208_1.var_.characterEffect10058ui_story = var_211_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_38 = 0.200000002980232

			if var_211_37 <= arg_208_1.time_ and arg_208_1.time_ < var_211_37 + var_211_38 and not isNil(var_211_36) then
				local var_211_39 = (arg_208_1.time_ - var_211_37) / var_211_38

				if arg_208_1.var_.characterEffect10058ui_story and not isNil(var_211_36) then
					local var_211_40 = Mathf.Lerp(0, 0.5, var_211_39)

					arg_208_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10058ui_story.fillRatio = var_211_40
				end
			end

			if arg_208_1.time_ >= var_211_37 + var_211_38 and arg_208_1.time_ < var_211_37 + var_211_38 + arg_211_0 and not isNil(var_211_36) and arg_208_1.var_.characterEffect10058ui_story then
				local var_211_41 = 0.5

				arg_208_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10058ui_story.fillRatio = var_211_41
			end

			local var_211_42 = arg_208_1.actors_["1084ui_story"].transform
			local var_211_43 = 0

			if var_211_43 < arg_208_1.time_ and arg_208_1.time_ <= var_211_43 + arg_211_0 then
				arg_208_1.var_.moveOldPos1084ui_story = var_211_42.localPosition
			end

			local var_211_44 = 0.001

			if var_211_43 <= arg_208_1.time_ and arg_208_1.time_ < var_211_43 + var_211_44 then
				local var_211_45 = (arg_208_1.time_ - var_211_43) / var_211_44
				local var_211_46 = Vector3.New(0, 100, 0)

				var_211_42.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1084ui_story, var_211_46, var_211_45)

				local var_211_47 = manager.ui.mainCamera.transform.position - var_211_42.position

				var_211_42.forward = Vector3.New(var_211_47.x, var_211_47.y, var_211_47.z)

				local var_211_48 = var_211_42.localEulerAngles

				var_211_48.z = 0
				var_211_48.x = 0
				var_211_42.localEulerAngles = var_211_48
			end

			if arg_208_1.time_ >= var_211_43 + var_211_44 and arg_208_1.time_ < var_211_43 + var_211_44 + arg_211_0 then
				var_211_42.localPosition = Vector3.New(0, 100, 0)

				local var_211_49 = manager.ui.mainCamera.transform.position - var_211_42.position

				var_211_42.forward = Vector3.New(var_211_49.x, var_211_49.y, var_211_49.z)

				local var_211_50 = var_211_42.localEulerAngles

				var_211_50.z = 0
				var_211_50.x = 0
				var_211_42.localEulerAngles = var_211_50
			end

			local var_211_51 = arg_208_1.actors_["1084ui_story"]
			local var_211_52 = 0

			if var_211_52 < arg_208_1.time_ and arg_208_1.time_ <= var_211_52 + arg_211_0 and not isNil(var_211_51) and arg_208_1.var_.characterEffect1084ui_story == nil then
				arg_208_1.var_.characterEffect1084ui_story = var_211_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_53 = 0.200000002980232

			if var_211_52 <= arg_208_1.time_ and arg_208_1.time_ < var_211_52 + var_211_53 and not isNil(var_211_51) then
				local var_211_54 = (arg_208_1.time_ - var_211_52) / var_211_53

				if arg_208_1.var_.characterEffect1084ui_story and not isNil(var_211_51) then
					local var_211_55 = Mathf.Lerp(0, 0.5, var_211_54)

					arg_208_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1084ui_story.fillRatio = var_211_55
				end
			end

			if arg_208_1.time_ >= var_211_52 + var_211_53 and arg_208_1.time_ < var_211_52 + var_211_53 + arg_211_0 and not isNil(var_211_51) and arg_208_1.var_.characterEffect1084ui_story then
				local var_211_56 = 0.5

				arg_208_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1084ui_story.fillRatio = var_211_56
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_57 = 2.46666666666667
			local var_211_58 = 1.425

			if var_211_57 < arg_208_1.time_ and arg_208_1.time_ <= var_211_57 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_59 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_59:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_60 = arg_208_1:GetWordFromCfg(319801050)
				local var_211_61 = arg_208_1:FormatText(var_211_60.content)

				arg_208_1.text_.text = var_211_61

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_62 = 57
				local var_211_63 = utf8.len(var_211_61)
				local var_211_64 = var_211_62 <= 0 and var_211_58 or var_211_58 * (var_211_63 / var_211_62)

				if var_211_64 > 0 and var_211_58 < var_211_64 then
					arg_208_1.talkMaxDuration = var_211_64
					var_211_57 = var_211_57 + 0.3

					if var_211_64 + var_211_57 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_64 + var_211_57
					end
				end

				arg_208_1.text_.text = var_211_61
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_65 = var_211_57 + 0.3
			local var_211_66 = math.max(var_211_58, arg_208_1.talkMaxDuration)

			if var_211_65 <= arg_208_1.time_ and arg_208_1.time_ < var_211_65 + var_211_66 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_65) / var_211_66

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_65 + var_211_66 and arg_208_1.time_ < var_211_65 + var_211_66 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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

		arg_208_1:InitPlayNodeList()
	end,
	Play319801051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 319801051
		arg_214_1.duration_ = 3

		local var_214_0 = {
			zh = 2.166,
			ja = 3
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play319801052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10058ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos10058ui_story = var_217_0.localPosition
			end

			local var_217_2 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2
				local var_217_4 = Vector3.New(0, -0.98, -6.1)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10058ui_story, var_217_4, var_217_3)

				local var_217_5 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_5.x, var_217_5.y, var_217_5.z)

				local var_217_6 = var_217_0.localEulerAngles

				var_217_6.z = 0
				var_217_6.x = 0
				var_217_0.localEulerAngles = var_217_6
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_217_7 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_7.x, var_217_7.y, var_217_7.z)

				local var_217_8 = var_217_0.localEulerAngles

				var_217_8.z = 0
				var_217_8.x = 0
				var_217_0.localEulerAngles = var_217_8
			end

			local var_217_9 = arg_214_1.actors_["10058ui_story"]
			local var_217_10 = 0

			if var_217_10 < arg_214_1.time_ and arg_214_1.time_ <= var_217_10 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect10058ui_story == nil then
				arg_214_1.var_.characterEffect10058ui_story = var_217_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_11 = 0.200000002980232

			if var_217_10 <= arg_214_1.time_ and arg_214_1.time_ < var_217_10 + var_217_11 and not isNil(var_217_9) then
				local var_217_12 = (arg_214_1.time_ - var_217_10) / var_217_11

				if arg_214_1.var_.characterEffect10058ui_story and not isNil(var_217_9) then
					arg_214_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_10 + var_217_11 and arg_214_1.time_ < var_217_10 + var_217_11 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect10058ui_story then
				arg_214_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_217_13 = 0

			if var_217_13 < arg_214_1.time_ and arg_214_1.time_ <= var_217_13 + arg_217_0 then
				arg_214_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_217_14 = 0

			if var_217_14 < arg_214_1.time_ and arg_214_1.time_ <= var_217_14 + arg_217_0 then
				arg_214_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_217_15 = 0
			local var_217_16 = 0.225

			if var_217_15 < arg_214_1.time_ and arg_214_1.time_ <= var_217_15 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_17 = arg_214_1:FormatText(StoryNameCfg[471].name)

				arg_214_1.leftNameTxt_.text = var_217_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_18 = arg_214_1:GetWordFromCfg(319801051)
				local var_217_19 = arg_214_1:FormatText(var_217_18.content)

				arg_214_1.text_.text = var_217_19

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_20 = 9
				local var_217_21 = utf8.len(var_217_19)
				local var_217_22 = var_217_20 <= 0 and var_217_16 or var_217_16 * (var_217_21 / var_217_20)

				if var_217_22 > 0 and var_217_16 < var_217_22 then
					arg_214_1.talkMaxDuration = var_217_22

					if var_217_22 + var_217_15 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_22 + var_217_15
					end
				end

				arg_214_1.text_.text = var_217_19
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801051", "story_v_out_319801.awb") ~= 0 then
					local var_217_23 = manager.audio:GetVoiceLength("story_v_out_319801", "319801051", "story_v_out_319801.awb") / 1000

					if var_217_23 + var_217_15 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_23 + var_217_15
					end

					if var_217_18.prefab_name ~= "" and arg_214_1.actors_[var_217_18.prefab_name] ~= nil then
						local var_217_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_18.prefab_name].transform, "story_v_out_319801", "319801051", "story_v_out_319801.awb")

						arg_214_1:RecordAudio("319801051", var_217_24)
						arg_214_1:RecordAudio("319801051", var_217_24)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_319801", "319801051", "story_v_out_319801.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_319801", "319801051", "story_v_out_319801.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_25 = math.max(var_217_16, arg_214_1.talkMaxDuration)

			if var_217_15 <= arg_214_1.time_ and arg_214_1.time_ < var_217_15 + var_217_25 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_15) / var_217_25

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_15 + var_217_25 and arg_214_1.time_ < var_217_15 + var_217_25 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play319801052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 319801052
		arg_218_1.duration_ = 3.93

		local var_218_0 = {
			zh = 1.999999999999,
			ja = 3.933
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play319801053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["10066ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos10066ui_story = var_221_0.localPosition
			end

			local var_221_2 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2
				local var_221_4 = Vector3.New(0, -0.99, -5.83)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10066ui_story, var_221_4, var_221_3)

				local var_221_5 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_5.x, var_221_5.y, var_221_5.z)

				local var_221_6 = var_221_0.localEulerAngles

				var_221_6.z = 0
				var_221_6.x = 0
				var_221_0.localEulerAngles = var_221_6
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_221_7 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_7.x, var_221_7.y, var_221_7.z)

				local var_221_8 = var_221_0.localEulerAngles

				var_221_8.z = 0
				var_221_8.x = 0
				var_221_0.localEulerAngles = var_221_8
			end

			local var_221_9 = arg_218_1.actors_["10066ui_story"]
			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 and not isNil(var_221_9) and arg_218_1.var_.characterEffect10066ui_story == nil then
				arg_218_1.var_.characterEffect10066ui_story = var_221_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_11 = 0.200000002980232

			if var_221_10 <= arg_218_1.time_ and arg_218_1.time_ < var_221_10 + var_221_11 and not isNil(var_221_9) then
				local var_221_12 = (arg_218_1.time_ - var_221_10) / var_221_11

				if arg_218_1.var_.characterEffect10066ui_story and not isNil(var_221_9) then
					arg_218_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_10 + var_221_11 and arg_218_1.time_ < var_221_10 + var_221_11 + arg_221_0 and not isNil(var_221_9) and arg_218_1.var_.characterEffect10066ui_story then
				arg_218_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_221_13 = 0

			if var_221_13 < arg_218_1.time_ and arg_218_1.time_ <= var_221_13 + arg_221_0 then
				arg_218_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_221_14 = 0

			if var_221_14 < arg_218_1.time_ and arg_218_1.time_ <= var_221_14 + arg_221_0 then
				arg_218_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_221_15 = arg_218_1.actors_["10058ui_story"].transform
			local var_221_16 = 0

			if var_221_16 < arg_218_1.time_ and arg_218_1.time_ <= var_221_16 + arg_221_0 then
				arg_218_1.var_.moveOldPos10058ui_story = var_221_15.localPosition
			end

			local var_221_17 = 0.001

			if var_221_16 <= arg_218_1.time_ and arg_218_1.time_ < var_221_16 + var_221_17 then
				local var_221_18 = (arg_218_1.time_ - var_221_16) / var_221_17
				local var_221_19 = Vector3.New(0, 100, 0)

				var_221_15.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10058ui_story, var_221_19, var_221_18)

				local var_221_20 = manager.ui.mainCamera.transform.position - var_221_15.position

				var_221_15.forward = Vector3.New(var_221_20.x, var_221_20.y, var_221_20.z)

				local var_221_21 = var_221_15.localEulerAngles

				var_221_21.z = 0
				var_221_21.x = 0
				var_221_15.localEulerAngles = var_221_21
			end

			if arg_218_1.time_ >= var_221_16 + var_221_17 and arg_218_1.time_ < var_221_16 + var_221_17 + arg_221_0 then
				var_221_15.localPosition = Vector3.New(0, 100, 0)

				local var_221_22 = manager.ui.mainCamera.transform.position - var_221_15.position

				var_221_15.forward = Vector3.New(var_221_22.x, var_221_22.y, var_221_22.z)

				local var_221_23 = var_221_15.localEulerAngles

				var_221_23.z = 0
				var_221_23.x = 0
				var_221_15.localEulerAngles = var_221_23
			end

			local var_221_24 = arg_218_1.actors_["10058ui_story"]
			local var_221_25 = 0

			if var_221_25 < arg_218_1.time_ and arg_218_1.time_ <= var_221_25 + arg_221_0 and not isNil(var_221_24) and arg_218_1.var_.characterEffect10058ui_story == nil then
				arg_218_1.var_.characterEffect10058ui_story = var_221_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_26 = 0.200000002980232

			if var_221_25 <= arg_218_1.time_ and arg_218_1.time_ < var_221_25 + var_221_26 and not isNil(var_221_24) then
				local var_221_27 = (arg_218_1.time_ - var_221_25) / var_221_26

				if arg_218_1.var_.characterEffect10058ui_story and not isNil(var_221_24) then
					local var_221_28 = Mathf.Lerp(0, 0.5, var_221_27)

					arg_218_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10058ui_story.fillRatio = var_221_28
				end
			end

			if arg_218_1.time_ >= var_221_25 + var_221_26 and arg_218_1.time_ < var_221_25 + var_221_26 + arg_221_0 and not isNil(var_221_24) and arg_218_1.var_.characterEffect10058ui_story then
				local var_221_29 = 0.5

				arg_218_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10058ui_story.fillRatio = var_221_29
			end

			local var_221_30 = 0
			local var_221_31 = 0.15

			if var_221_30 < arg_218_1.time_ and arg_218_1.time_ <= var_221_30 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_32 = arg_218_1:FormatText(StoryNameCfg[640].name)

				arg_218_1.leftNameTxt_.text = var_221_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_33 = arg_218_1:GetWordFromCfg(319801052)
				local var_221_34 = arg_218_1:FormatText(var_221_33.content)

				arg_218_1.text_.text = var_221_34

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_35 = 6
				local var_221_36 = utf8.len(var_221_34)
				local var_221_37 = var_221_35 <= 0 and var_221_31 or var_221_31 * (var_221_36 / var_221_35)

				if var_221_37 > 0 and var_221_31 < var_221_37 then
					arg_218_1.talkMaxDuration = var_221_37

					if var_221_37 + var_221_30 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_37 + var_221_30
					end
				end

				arg_218_1.text_.text = var_221_34
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801052", "story_v_out_319801.awb") ~= 0 then
					local var_221_38 = manager.audio:GetVoiceLength("story_v_out_319801", "319801052", "story_v_out_319801.awb") / 1000

					if var_221_38 + var_221_30 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_38 + var_221_30
					end

					if var_221_33.prefab_name ~= "" and arg_218_1.actors_[var_221_33.prefab_name] ~= nil then
						local var_221_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_33.prefab_name].transform, "story_v_out_319801", "319801052", "story_v_out_319801.awb")

						arg_218_1:RecordAudio("319801052", var_221_39)
						arg_218_1:RecordAudio("319801052", var_221_39)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_319801", "319801052", "story_v_out_319801.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_319801", "319801052", "story_v_out_319801.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_40 = math.max(var_221_31, arg_218_1.talkMaxDuration)

			if var_221_30 <= arg_218_1.time_ and arg_218_1.time_ < var_221_30 + var_221_40 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_30) / var_221_40

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_30 + var_221_40 and arg_218_1.time_ < var_221_30 + var_221_40 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play319801053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 319801053
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play319801054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10066ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect10066ui_story == nil then
				arg_222_1.var_.characterEffect10066ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect10066ui_story and not isNil(var_225_0) then
					local var_225_4 = Mathf.Lerp(0, 0.5, var_225_3)

					arg_222_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_222_1.var_.characterEffect10066ui_story.fillRatio = var_225_4
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect10066ui_story then
				local var_225_5 = 0.5

				arg_222_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_222_1.var_.characterEffect10066ui_story.fillRatio = var_225_5
			end

			local var_225_6 = arg_222_1.actors_["10066ui_story"].transform
			local var_225_7 = 0

			if var_225_7 < arg_222_1.time_ and arg_222_1.time_ <= var_225_7 + arg_225_0 then
				arg_222_1.var_.moveOldPos10066ui_story = var_225_6.localPosition
			end

			local var_225_8 = 0.001

			if var_225_7 <= arg_222_1.time_ and arg_222_1.time_ < var_225_7 + var_225_8 then
				local var_225_9 = (arg_222_1.time_ - var_225_7) / var_225_8
				local var_225_10 = Vector3.New(0, 100, 0)

				var_225_6.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10066ui_story, var_225_10, var_225_9)

				local var_225_11 = manager.ui.mainCamera.transform.position - var_225_6.position

				var_225_6.forward = Vector3.New(var_225_11.x, var_225_11.y, var_225_11.z)

				local var_225_12 = var_225_6.localEulerAngles

				var_225_12.z = 0
				var_225_12.x = 0
				var_225_6.localEulerAngles = var_225_12
			end

			if arg_222_1.time_ >= var_225_7 + var_225_8 and arg_222_1.time_ < var_225_7 + var_225_8 + arg_225_0 then
				var_225_6.localPosition = Vector3.New(0, 100, 0)

				local var_225_13 = manager.ui.mainCamera.transform.position - var_225_6.position

				var_225_6.forward = Vector3.New(var_225_13.x, var_225_13.y, var_225_13.z)

				local var_225_14 = var_225_6.localEulerAngles

				var_225_14.z = 0
				var_225_14.x = 0
				var_225_6.localEulerAngles = var_225_14
			end

			local var_225_15 = 0
			local var_225_16 = 0.95

			if var_225_15 < arg_222_1.time_ and arg_222_1.time_ <= var_225_15 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_17 = arg_222_1:GetWordFromCfg(319801053)
				local var_225_18 = arg_222_1:FormatText(var_225_17.content)

				arg_222_1.text_.text = var_225_18

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_19 = 38
				local var_225_20 = utf8.len(var_225_18)
				local var_225_21 = var_225_19 <= 0 and var_225_16 or var_225_16 * (var_225_20 / var_225_19)

				if var_225_21 > 0 and var_225_16 < var_225_21 then
					arg_222_1.talkMaxDuration = var_225_21

					if var_225_21 + var_225_15 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_21 + var_225_15
					end
				end

				arg_222_1.text_.text = var_225_18
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_22 = math.max(var_225_16, arg_222_1.talkMaxDuration)

			if var_225_15 <= arg_222_1.time_ and arg_222_1.time_ < var_225_15 + var_225_22 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_15) / var_225_22

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_15 + var_225_22 and arg_222_1.time_ < var_225_15 + var_225_22 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play319801054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 319801054
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play319801055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.475

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_2 = arg_226_1:FormatText(StoryNameCfg[698].name)

				arg_226_1.leftNameTxt_.text = var_229_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:GetWordFromCfg(319801054)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 19
				local var_229_6 = utf8.len(var_229_4)
				local var_229_7 = var_229_5 <= 0 and var_229_1 or var_229_1 * (var_229_6 / var_229_5)

				if var_229_7 > 0 and var_229_1 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_8 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_8 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_8

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_8 and arg_226_1.time_ < var_229_0 + var_229_8 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play319801055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 319801055
		arg_230_1.duration_ = 1.8

		local var_230_0 = {
			zh = 1.8,
			ja = 1.433
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
				arg_230_0:Play319801056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10066ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos10066ui_story = var_233_0.localPosition
			end

			local var_233_2 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2
				local var_233_4 = Vector3.New(0, -0.99, -5.83)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10066ui_story, var_233_4, var_233_3)

				local var_233_5 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_5.x, var_233_5.y, var_233_5.z)

				local var_233_6 = var_233_0.localEulerAngles

				var_233_6.z = 0
				var_233_6.x = 0
				var_233_0.localEulerAngles = var_233_6
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_233_7 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_7.x, var_233_7.y, var_233_7.z)

				local var_233_8 = var_233_0.localEulerAngles

				var_233_8.z = 0
				var_233_8.x = 0
				var_233_0.localEulerAngles = var_233_8
			end

			local var_233_9 = arg_230_1.actors_["10066ui_story"]
			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 and not isNil(var_233_9) and arg_230_1.var_.characterEffect10066ui_story == nil then
				arg_230_1.var_.characterEffect10066ui_story = var_233_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_11 = 0.200000002980232

			if var_233_10 <= arg_230_1.time_ and arg_230_1.time_ < var_233_10 + var_233_11 and not isNil(var_233_9) then
				local var_233_12 = (arg_230_1.time_ - var_233_10) / var_233_11

				if arg_230_1.var_.characterEffect10066ui_story and not isNil(var_233_9) then
					arg_230_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_10 + var_233_11 and arg_230_1.time_ < var_233_10 + var_233_11 + arg_233_0 and not isNil(var_233_9) and arg_230_1.var_.characterEffect10066ui_story then
				arg_230_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_233_13 = 0
			local var_233_14 = 0.1

			if var_233_13 < arg_230_1.time_ and arg_230_1.time_ <= var_233_13 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_15 = arg_230_1:FormatText(StoryNameCfg[640].name)

				arg_230_1.leftNameTxt_.text = var_233_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_16 = arg_230_1:GetWordFromCfg(319801055)
				local var_233_17 = arg_230_1:FormatText(var_233_16.content)

				arg_230_1.text_.text = var_233_17

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_18 = 4
				local var_233_19 = utf8.len(var_233_17)
				local var_233_20 = var_233_18 <= 0 and var_233_14 or var_233_14 * (var_233_19 / var_233_18)

				if var_233_20 > 0 and var_233_14 < var_233_20 then
					arg_230_1.talkMaxDuration = var_233_20

					if var_233_20 + var_233_13 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_20 + var_233_13
					end
				end

				arg_230_1.text_.text = var_233_17
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801055", "story_v_out_319801.awb") ~= 0 then
					local var_233_21 = manager.audio:GetVoiceLength("story_v_out_319801", "319801055", "story_v_out_319801.awb") / 1000

					if var_233_21 + var_233_13 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_21 + var_233_13
					end

					if var_233_16.prefab_name ~= "" and arg_230_1.actors_[var_233_16.prefab_name] ~= nil then
						local var_233_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_16.prefab_name].transform, "story_v_out_319801", "319801055", "story_v_out_319801.awb")

						arg_230_1:RecordAudio("319801055", var_233_22)
						arg_230_1:RecordAudio("319801055", var_233_22)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_319801", "319801055", "story_v_out_319801.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_319801", "319801055", "story_v_out_319801.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_23 = math.max(var_233_14, arg_230_1.talkMaxDuration)

			if var_233_13 <= arg_230_1.time_ and arg_230_1.time_ < var_233_13 + var_233_23 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_13) / var_233_23

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_13 + var_233_23 and arg_230_1.time_ < var_233_13 + var_233_23 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play319801056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 319801056
		arg_234_1.duration_ = 6

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play319801057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0
			local var_237_1 = 1

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				local var_237_2 = "play"
				local var_237_3 = "effect"

				arg_234_1:AudioAction(var_237_2, var_237_3, "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			local var_237_4 = arg_234_1.actors_["10066ui_story"].transform
			local var_237_5 = 0

			if var_237_5 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 then
				arg_234_1.var_.moveOldPos10066ui_story = var_237_4.localPosition
			end

			local var_237_6 = 0.001

			if var_237_5 <= arg_234_1.time_ and arg_234_1.time_ < var_237_5 + var_237_6 then
				local var_237_7 = (arg_234_1.time_ - var_237_5) / var_237_6
				local var_237_8 = Vector3.New(0, 100, 0)

				var_237_4.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10066ui_story, var_237_8, var_237_7)

				local var_237_9 = manager.ui.mainCamera.transform.position - var_237_4.position

				var_237_4.forward = Vector3.New(var_237_9.x, var_237_9.y, var_237_9.z)

				local var_237_10 = var_237_4.localEulerAngles

				var_237_10.z = 0
				var_237_10.x = 0
				var_237_4.localEulerAngles = var_237_10
			end

			if arg_234_1.time_ >= var_237_5 + var_237_6 and arg_234_1.time_ < var_237_5 + var_237_6 + arg_237_0 then
				var_237_4.localPosition = Vector3.New(0, 100, 0)

				local var_237_11 = manager.ui.mainCamera.transform.position - var_237_4.position

				var_237_4.forward = Vector3.New(var_237_11.x, var_237_11.y, var_237_11.z)

				local var_237_12 = var_237_4.localEulerAngles

				var_237_12.z = 0
				var_237_12.x = 0
				var_237_4.localEulerAngles = var_237_12
			end

			local var_237_13 = 0

			if var_237_13 < arg_234_1.time_ and arg_234_1.time_ <= var_237_13 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = false

				arg_234_1:SetGaussion(false)
			end

			local var_237_14 = 0.333333333333333

			if var_237_13 <= arg_234_1.time_ and arg_234_1.time_ < var_237_13 + var_237_14 then
				local var_237_15 = (arg_234_1.time_ - var_237_13) / var_237_14
				local var_237_16 = Color.New(1, 1, 1)

				var_237_16.a = Mathf.Lerp(1, 0, var_237_15)
				arg_234_1.mask_.color = var_237_16
			end

			if arg_234_1.time_ >= var_237_13 + var_237_14 and arg_234_1.time_ < var_237_13 + var_237_14 + arg_237_0 then
				local var_237_17 = Color.New(1, 1, 1)
				local var_237_18 = 0

				arg_234_1.mask_.enabled = false
				var_237_17.a = var_237_18
				arg_234_1.mask_.color = var_237_17
			end

			local var_237_19 = manager.ui.mainCamera.transform
			local var_237_20 = 0.333333333333333

			if var_237_20 < arg_234_1.time_ and arg_234_1.time_ <= var_237_20 + arg_237_0 then
				arg_234_1.var_.shakeOldPos = var_237_19.localPosition
			end

			local var_237_21 = 0.5

			if var_237_20 <= arg_234_1.time_ and arg_234_1.time_ < var_237_20 + var_237_21 then
				local var_237_22 = (arg_234_1.time_ - var_237_20) / 0.066
				local var_237_23, var_237_24 = math.modf(var_237_22)

				var_237_19.localPosition = Vector3.New(var_237_24 * 0.13, var_237_24 * 0.13, var_237_24 * 0.13) + arg_234_1.var_.shakeOldPos
			end

			if arg_234_1.time_ >= var_237_20 + var_237_21 and arg_234_1.time_ < var_237_20 + var_237_21 + arg_237_0 then
				var_237_19.localPosition = arg_234_1.var_.shakeOldPos
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_25 = 1
			local var_237_26 = 1.2

			if var_237_25 < arg_234_1.time_ and arg_234_1.time_ <= var_237_25 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_27 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_27:setOnUpdate(LuaHelper.FloatAction(function(arg_238_0)
					arg_234_1.dialogCg_.alpha = arg_238_0
				end))
				var_237_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_28 = arg_234_1:GetWordFromCfg(319801056)
				local var_237_29 = arg_234_1:FormatText(var_237_28.content)

				arg_234_1.text_.text = var_237_29

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_30 = 48
				local var_237_31 = utf8.len(var_237_29)
				local var_237_32 = var_237_30 <= 0 and var_237_26 or var_237_26 * (var_237_31 / var_237_30)

				if var_237_32 > 0 and var_237_26 < var_237_32 then
					arg_234_1.talkMaxDuration = var_237_32
					var_237_25 = var_237_25 + 0.3

					if var_237_32 + var_237_25 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_32 + var_237_25
					end
				end

				arg_234_1.text_.text = var_237_29
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_33 = var_237_25 + 0.3
			local var_237_34 = math.max(var_237_26, arg_234_1.talkMaxDuration)

			if var_237_33 <= arg_234_1.time_ and arg_234_1.time_ < var_237_33 + var_237_34 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_33) / var_237_34

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_33 + var_237_34 and arg_234_1.time_ < var_237_33 + var_237_34 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play319801057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 319801057
		arg_240_1.duration_ = 3.73

		local var_240_0 = {
			zh = 2.133,
			ja = 3.733
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play319801058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["10066ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos10066ui_story = var_243_0.localPosition
			end

			local var_243_2 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2
				local var_243_4 = Vector3.New(0, -0.99, -5.83)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10066ui_story, var_243_4, var_243_3)

				local var_243_5 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_5.x, var_243_5.y, var_243_5.z)

				local var_243_6 = var_243_0.localEulerAngles

				var_243_6.z = 0
				var_243_6.x = 0
				var_243_0.localEulerAngles = var_243_6
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_243_7 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_7.x, var_243_7.y, var_243_7.z)

				local var_243_8 = var_243_0.localEulerAngles

				var_243_8.z = 0
				var_243_8.x = 0
				var_243_0.localEulerAngles = var_243_8
			end

			local var_243_9 = arg_240_1.actors_["10066ui_story"]
			local var_243_10 = 0

			if var_243_10 < arg_240_1.time_ and arg_240_1.time_ <= var_243_10 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect10066ui_story == nil then
				arg_240_1.var_.characterEffect10066ui_story = var_243_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_11 = 0.200000002980232

			if var_243_10 <= arg_240_1.time_ and arg_240_1.time_ < var_243_10 + var_243_11 and not isNil(var_243_9) then
				local var_243_12 = (arg_240_1.time_ - var_243_10) / var_243_11

				if arg_240_1.var_.characterEffect10066ui_story and not isNil(var_243_9) then
					arg_240_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_10 + var_243_11 and arg_240_1.time_ < var_243_10 + var_243_11 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect10066ui_story then
				arg_240_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_243_13 = 0

			if var_243_13 < arg_240_1.time_ and arg_240_1.time_ <= var_243_13 + arg_243_0 then
				arg_240_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			local var_243_14 = 0

			if var_243_14 < arg_240_1.time_ and arg_240_1.time_ <= var_243_14 + arg_243_0 then
				arg_240_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_243_15 = 0
			local var_243_16 = 0.175

			if var_243_15 < arg_240_1.time_ and arg_240_1.time_ <= var_243_15 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_17 = arg_240_1:FormatText(StoryNameCfg[640].name)

				arg_240_1.leftNameTxt_.text = var_243_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_18 = arg_240_1:GetWordFromCfg(319801057)
				local var_243_19 = arg_240_1:FormatText(var_243_18.content)

				arg_240_1.text_.text = var_243_19

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_20 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801057", "story_v_out_319801.awb") ~= 0 then
					local var_243_23 = manager.audio:GetVoiceLength("story_v_out_319801", "319801057", "story_v_out_319801.awb") / 1000

					if var_243_23 + var_243_15 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_23 + var_243_15
					end

					if var_243_18.prefab_name ~= "" and arg_240_1.actors_[var_243_18.prefab_name] ~= nil then
						local var_243_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_18.prefab_name].transform, "story_v_out_319801", "319801057", "story_v_out_319801.awb")

						arg_240_1:RecordAudio("319801057", var_243_24)
						arg_240_1:RecordAudio("319801057", var_243_24)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_319801", "319801057", "story_v_out_319801.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_319801", "319801057", "story_v_out_319801.awb")
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
				actorName = "10066ui_story",
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
	Play319801058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 319801058
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play319801059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10066ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10066ui_story == nil then
				arg_244_1.var_.characterEffect10066ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect10066ui_story and not isNil(var_247_0) then
					local var_247_4 = Mathf.Lerp(0, 0.5, var_247_3)

					arg_244_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_244_1.var_.characterEffect10066ui_story.fillRatio = var_247_4
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10066ui_story then
				local var_247_5 = 0.5

				arg_244_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_244_1.var_.characterEffect10066ui_story.fillRatio = var_247_5
			end

			local var_247_6 = 0
			local var_247_7 = 0.25

			if var_247_6 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_8 = arg_244_1:FormatText(StoryNameCfg[698].name)

				arg_244_1.leftNameTxt_.text = var_247_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_9 = arg_244_1:GetWordFromCfg(319801058)
				local var_247_10 = arg_244_1:FormatText(var_247_9.content)

				arg_244_1.text_.text = var_247_10

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 10
				local var_247_12 = utf8.len(var_247_10)
				local var_247_13 = var_247_11 <= 0 and var_247_7 or var_247_7 * (var_247_12 / var_247_11)

				if var_247_13 > 0 and var_247_7 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_6
					end
				end

				arg_244_1.text_.text = var_247_10
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_14 = math.max(var_247_7, arg_244_1.talkMaxDuration)

			if var_247_6 <= arg_244_1.time_ and arg_244_1.time_ < var_247_6 + var_247_14 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_6) / var_247_14

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_6 + var_247_14 and arg_244_1.time_ < var_247_6 + var_247_14 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play319801059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 319801059
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play319801060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10066ui_story"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos10066ui_story = var_251_0.localPosition
			end

			local var_251_2 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2
				local var_251_4 = Vector3.New(0, 100, 0)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10066ui_story, var_251_4, var_251_3)

				local var_251_5 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_5.x, var_251_5.y, var_251_5.z)

				local var_251_6 = var_251_0.localEulerAngles

				var_251_6.z = 0
				var_251_6.x = 0
				var_251_0.localEulerAngles = var_251_6
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(0, 100, 0)

				local var_251_7 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_7.x, var_251_7.y, var_251_7.z)

				local var_251_8 = var_251_0.localEulerAngles

				var_251_8.z = 0
				var_251_8.x = 0
				var_251_0.localEulerAngles = var_251_8
			end

			local var_251_9 = 0
			local var_251_10 = 1

			if var_251_9 < arg_248_1.time_ and arg_248_1.time_ <= var_251_9 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_11 = arg_248_1:GetWordFromCfg(319801059)
				local var_251_12 = arg_248_1:FormatText(var_251_11.content)

				arg_248_1.text_.text = var_251_12

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_13 = 40
				local var_251_14 = utf8.len(var_251_12)
				local var_251_15 = var_251_13 <= 0 and var_251_10 or var_251_10 * (var_251_14 / var_251_13)

				if var_251_15 > 0 and var_251_10 < var_251_15 then
					arg_248_1.talkMaxDuration = var_251_15

					if var_251_15 + var_251_9 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_15 + var_251_9
					end
				end

				arg_248_1.text_.text = var_251_12
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_16 = math.max(var_251_10, arg_248_1.talkMaxDuration)

			if var_251_9 <= arg_248_1.time_ and arg_248_1.time_ < var_251_9 + var_251_16 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_9) / var_251_16

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_9 + var_251_16 and arg_248_1.time_ < var_251_9 + var_251_16 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319801060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 319801060
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play319801061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0
			local var_255_1 = 0.225

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_2 = arg_252_1:FormatText(StoryNameCfg[698].name)

				arg_252_1.leftNameTxt_.text = var_255_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:GetWordFromCfg(319801060)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 9
				local var_255_6 = utf8.len(var_255_4)
				local var_255_7 = var_255_5 <= 0 and var_255_1 or var_255_1 * (var_255_6 / var_255_5)

				if var_255_7 > 0 and var_255_1 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_0
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_8 = math.max(var_255_1, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_8 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_0) / var_255_8

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_8 and arg_252_1.time_ < var_255_0 + var_255_8 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play319801061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 319801061
		arg_256_1.duration_ = 5.9

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play319801062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = manager.ui.mainCamera.transform
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.var_.shakeOldPos = var_259_0.localPosition
			end

			local var_259_2 = 1

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / 0.066
				local var_259_4, var_259_5 = math.modf(var_259_3)

				var_259_0.localPosition = Vector3.New(var_259_5 * 0.13, var_259_5 * 0.13, var_259_5 * 0.13) + arg_256_1.var_.shakeOldPos
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 then
				var_259_0.localPosition = arg_256_1.var_.shakeOldPos
			end

			if arg_256_1.frameCnt_ <= 1 then
				arg_256_1.dialog_:SetActive(false)
			end

			local var_259_6 = 0.9
			local var_259_7 = 0.825

			if var_259_6 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				arg_256_1.dialog_:SetActive(true)

				arg_256_1.dialogCg_.alpha = 0

				local var_259_8 = LeanTween.value(arg_256_1.dialog_, 0, 1, 0.3)

				var_259_8:setOnUpdate(LuaHelper.FloatAction(function(arg_260_0)
					arg_256_1.dialogCg_.alpha = arg_260_0
				end))
				var_259_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_256_1.dialog_)
					var_259_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_256_1.duration_ = arg_256_1.duration_ + 0.3

				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_9 = arg_256_1:GetWordFromCfg(319801061)
				local var_259_10 = arg_256_1:FormatText(var_259_9.content)

				arg_256_1.text_.text = var_259_10

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_11 = 33
				local var_259_12 = utf8.len(var_259_10)
				local var_259_13 = var_259_11 <= 0 and var_259_7 or var_259_7 * (var_259_12 / var_259_11)

				if var_259_13 > 0 and var_259_7 < var_259_13 then
					arg_256_1.talkMaxDuration = var_259_13
					var_259_6 = var_259_6 + 0.3

					if var_259_13 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_10
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_14 = var_259_6 + 0.3
			local var_259_15 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_14 <= arg_256_1.time_ and arg_256_1.time_ < var_259_14 + var_259_15 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_14) / var_259_15

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_14 + var_259_15 and arg_256_1.time_ < var_259_14 + var_259_15 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play319801062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 319801062
		arg_262_1.duration_ = 5.73

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play319801063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = manager.ui.mainCamera.transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				local var_265_2 = arg_262_1.var_.effect111
				local var_265_3
				local var_265_4 = var_265_0

				if not var_265_2 then
					var_265_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_265_4)
					var_265_2.name = "111"
					arg_262_1.var_.effect111 = var_265_2
				else
					var_265_2.transform:SetParent(var_265_4)
				end

				var_265_2.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_265_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_262_1.frameCnt_ <= 1 then
				arg_262_1.dialog_:SetActive(false)
			end

			local var_265_5 = 0.733333333333333
			local var_265_6 = 1.125

			if var_265_5 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0

				arg_262_1.dialog_:SetActive(true)

				arg_262_1.dialogCg_.alpha = 0

				local var_265_7 = LeanTween.value(arg_262_1.dialog_, 0, 1, 0.3)

				var_265_7:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_262_1.dialogCg_.alpha = arg_266_0
				end))
				var_265_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_262_1.dialog_)
					var_265_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_262_1.duration_ = arg_262_1.duration_ + 0.3

				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_8 = arg_262_1:GetWordFromCfg(319801062)
				local var_265_9 = arg_262_1:FormatText(var_265_8.content)

				arg_262_1.text_.text = var_265_9

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_10 = 45
				local var_265_11 = utf8.len(var_265_9)
				local var_265_12 = var_265_10 <= 0 and var_265_6 or var_265_6 * (var_265_11 / var_265_10)

				if var_265_12 > 0 and var_265_6 < var_265_12 then
					arg_262_1.talkMaxDuration = var_265_12
					var_265_5 = var_265_5 + 0.3

					if var_265_12 + var_265_5 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_12 + var_265_5
					end
				end

				arg_262_1.text_.text = var_265_9
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_13 = var_265_5 + 0.3
			local var_265_14 = math.max(var_265_6, arg_262_1.talkMaxDuration)

			if var_265_13 <= arg_262_1.time_ and arg_262_1.time_ < var_265_13 + var_265_14 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_13) / var_265_14

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_13 + var_265_14 and arg_262_1.time_ < var_265_13 + var_265_14 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play319801063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 319801063
		arg_268_1.duration_ = 2.6

		local var_268_0 = {
			zh = 2.433,
			ja = 2.6
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play319801064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = manager.ui.mainCamera.transform
			local var_271_1 = 0.2

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				local var_271_2 = arg_268_1.var_.effect111

				if var_271_2 then
					Object.Destroy(var_271_2)

					arg_268_1.var_.effect111 = nil
				end
			end

			local var_271_3 = 0

			if var_271_3 < arg_268_1.time_ and arg_268_1.time_ <= var_271_3 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_4 = 0.333333333333333

			if var_271_3 <= arg_268_1.time_ and arg_268_1.time_ < var_271_3 + var_271_4 then
				local var_271_5 = (arg_268_1.time_ - var_271_3) / var_271_4
				local var_271_6 = Color.New(1, 1, 1)

				var_271_6.a = Mathf.Lerp(0, 1, var_271_5)
				arg_268_1.mask_.color = var_271_6
			end

			if arg_268_1.time_ >= var_271_3 + var_271_4 and arg_268_1.time_ < var_271_3 + var_271_4 + arg_271_0 then
				local var_271_7 = Color.New(1, 1, 1)

				var_271_7.a = 1
				arg_268_1.mask_.color = var_271_7
			end

			local var_271_8 = 0.333333333333333

			if var_271_8 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_9 = 0.666666666666667

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_9 then
				local var_271_10 = (arg_268_1.time_ - var_271_8) / var_271_9
				local var_271_11 = Color.New(1, 1, 1)

				var_271_11.a = Mathf.Lerp(1, 0, var_271_10)
				arg_268_1.mask_.color = var_271_11
			end

			if arg_268_1.time_ >= var_271_8 + var_271_9 and arg_268_1.time_ < var_271_8 + var_271_9 + arg_271_0 then
				local var_271_12 = Color.New(1, 1, 1)
				local var_271_13 = 0

				arg_268_1.mask_.enabled = false
				var_271_12.a = var_271_13
				arg_268_1.mask_.color = var_271_12
			end

			local var_271_14 = 0.333333333333333

			if var_271_14 < arg_268_1.time_ and arg_268_1.time_ <= var_271_14 + arg_271_0 then
				local var_271_15 = manager.ui.mainCamera.transform.localPosition
				local var_271_16 = Vector3.New(0, 0, 10) + Vector3.New(var_271_15.x, var_271_15.y, 0)
				local var_271_17 = arg_268_1.bgs_.ST72a

				var_271_17.transform.localPosition = var_271_16
				var_271_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_271_18 = var_271_17:GetComponent("SpriteRenderer")

				if var_271_18 and var_271_18.sprite then
					local var_271_19 = (var_271_17.transform.localPosition - var_271_15).z
					local var_271_20 = manager.ui.mainCameraCom_
					local var_271_21 = 2 * var_271_19 * Mathf.Tan(var_271_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_271_22 = var_271_21 * var_271_20.aspect
					local var_271_23 = var_271_18.sprite.bounds.size.x
					local var_271_24 = var_271_18.sprite.bounds.size.y
					local var_271_25 = var_271_22 / var_271_23
					local var_271_26 = var_271_21 / var_271_24
					local var_271_27 = var_271_26 < var_271_25 and var_271_25 or var_271_26

					var_271_17.transform.localScale = Vector3.New(var_271_27, var_271_27, 0)
				end

				for iter_271_0, iter_271_1 in pairs(arg_268_1.bgs_) do
					if iter_271_0 ~= "ST72a" then
						iter_271_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_268_1.frameCnt_ <= 1 then
				arg_268_1.dialog_:SetActive(false)
			end

			local var_271_28 = 1
			local var_271_29 = 0.125

			if var_271_28 < arg_268_1.time_ and arg_268_1.time_ <= var_271_28 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0

				arg_268_1.dialog_:SetActive(true)

				arg_268_1.dialogCg_.alpha = 0

				local var_271_30 = LeanTween.value(arg_268_1.dialog_, 0, 1, 0.3)

				var_271_30:setOnUpdate(LuaHelper.FloatAction(function(arg_272_0)
					arg_268_1.dialogCg_.alpha = arg_272_0
				end))
				var_271_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_268_1.dialog_)
					var_271_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_268_1.duration_ = arg_268_1.duration_ + 0.3

				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_31 = arg_268_1:FormatText(StoryNameCfg[6].name)

				arg_268_1.leftNameTxt_.text = var_271_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_32 = arg_268_1:GetWordFromCfg(319801063)
				local var_271_33 = arg_268_1:FormatText(var_271_32.content)

				arg_268_1.text_.text = var_271_33

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_34 = 5
				local var_271_35 = utf8.len(var_271_33)
				local var_271_36 = var_271_34 <= 0 and var_271_29 or var_271_29 * (var_271_35 / var_271_34)

				if var_271_36 > 0 and var_271_29 < var_271_36 then
					arg_268_1.talkMaxDuration = var_271_36
					var_271_28 = var_271_28 + 0.3

					if var_271_36 + var_271_28 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_36 + var_271_28
					end
				end

				arg_268_1.text_.text = var_271_33
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801063", "story_v_out_319801.awb") ~= 0 then
					local var_271_37 = manager.audio:GetVoiceLength("story_v_out_319801", "319801063", "story_v_out_319801.awb") / 1000

					if var_271_37 + var_271_28 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_37 + var_271_28
					end

					if var_271_32.prefab_name ~= "" and arg_268_1.actors_[var_271_32.prefab_name] ~= nil then
						local var_271_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_32.prefab_name].transform, "story_v_out_319801", "319801063", "story_v_out_319801.awb")

						arg_268_1:RecordAudio("319801063", var_271_38)
						arg_268_1:RecordAudio("319801063", var_271_38)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_319801", "319801063", "story_v_out_319801.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_319801", "319801063", "story_v_out_319801.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_39 = var_271_28 + 0.3
			local var_271_40 = math.max(var_271_29, arg_268_1.talkMaxDuration)

			if var_271_39 <= arg_268_1.time_ and arg_268_1.time_ < var_271_39 + var_271_40 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_39) / var_271_40

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_39 + var_271_40 and arg_268_1.time_ < var_271_39 + var_271_40 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play319801064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319801064
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play319801065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 1

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				local var_277_2 = "play"
				local var_277_3 = "effect"

				arg_274_1:AudioAction(var_277_2, var_277_3, "se_story_130", "se_story_130_shot", "")
			end

			local var_277_4 = 0
			local var_277_5 = 1.4

			if var_277_4 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_6 = arg_274_1:GetWordFromCfg(319801064)
				local var_277_7 = arg_274_1:FormatText(var_277_6.content)

				arg_274_1.text_.text = var_277_7

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_8 = 56
				local var_277_9 = utf8.len(var_277_7)
				local var_277_10 = var_277_8 <= 0 and var_277_5 or var_277_5 * (var_277_9 / var_277_8)

				if var_277_10 > 0 and var_277_5 < var_277_10 then
					arg_274_1.talkMaxDuration = var_277_10

					if var_277_10 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_10 + var_277_4
					end
				end

				arg_274_1.text_.text = var_277_7
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_11 = math.max(var_277_5, arg_274_1.talkMaxDuration)

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_11 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_4) / var_277_11

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_4 + var_277_11 and arg_274_1.time_ < var_277_4 + var_277_11 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play319801065 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319801065
		arg_278_1.duration_ = 5.67

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play319801066(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = manager.ui.mainCamera.transform
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				local var_281_2 = arg_278_1.var_.effect555
				local var_281_3
				local var_281_4 = var_281_0

				if not var_281_2 then
					var_281_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_281_4)
					var_281_2.name = "555"
					arg_278_1.var_.effect555 = var_281_2
				else
					var_281_2.transform:SetParent(var_281_4)
				end

				var_281_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_281_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_5 = 0.666666666666667
			local var_281_6 = 0.775

			if var_281_5 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_7 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_7:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_8 = arg_278_1:GetWordFromCfg(319801065)
				local var_281_9 = arg_278_1:FormatText(var_281_8.content)

				arg_278_1.text_.text = var_281_9

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_10 = 31
				local var_281_11 = utf8.len(var_281_9)
				local var_281_12 = var_281_10 <= 0 and var_281_6 or var_281_6 * (var_281_11 / var_281_10)

				if var_281_12 > 0 and var_281_6 < var_281_12 then
					arg_278_1.talkMaxDuration = var_281_12
					var_281_5 = var_281_5 + 0.3

					if var_281_12 + var_281_5 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_12 + var_281_5
					end
				end

				arg_278_1.text_.text = var_281_9
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_13 = var_281_5 + 0.3
			local var_281_14 = math.max(var_281_6, arg_278_1.talkMaxDuration)

			if var_281_13 <= arg_278_1.time_ and arg_278_1.time_ < var_281_13 + var_281_14 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_13) / var_281_14

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_13 + var_281_14 and arg_278_1.time_ < var_281_13 + var_281_14 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play319801066 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 319801066
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play319801067(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = manager.ui.mainCamera.transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				local var_287_2 = arg_284_1.var_.effect555

				if var_287_2 then
					Object.Destroy(var_287_2)

					arg_284_1.var_.effect555 = nil
				end
			end

			local var_287_3 = 0
			local var_287_4 = 1.2

			if var_287_3 < arg_284_1.time_ and arg_284_1.time_ <= var_287_3 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_5 = arg_284_1:GetWordFromCfg(319801066)
				local var_287_6 = arg_284_1:FormatText(var_287_5.content)

				arg_284_1.text_.text = var_287_6

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_7 = 48
				local var_287_8 = utf8.len(var_287_6)
				local var_287_9 = var_287_7 <= 0 and var_287_4 or var_287_4 * (var_287_8 / var_287_7)

				if var_287_9 > 0 and var_287_4 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9

					if var_287_9 + var_287_3 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_3
					end
				end

				arg_284_1.text_.text = var_287_6
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_4, arg_284_1.talkMaxDuration)

			if var_287_3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_3 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_3) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_3 + var_287_10 and arg_284_1.time_ < var_287_3 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play319801067 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 319801067
		arg_288_1.duration_ = 6

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play319801068(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1.mask_.enabled = true
				arg_288_1.mask_.raycastTarget = false

				arg_288_1:SetGaussion(false)
			end

			local var_291_1 = 0.866666666666667

			if var_291_0 <= arg_288_1.time_ and arg_288_1.time_ < var_291_0 + var_291_1 then
				local var_291_2 = (arg_288_1.time_ - var_291_0) / var_291_1
				local var_291_3 = Color.New(1, 1, 1)

				var_291_3.a = Mathf.Lerp(1, 0, var_291_2)
				arg_288_1.mask_.color = var_291_3
			end

			if arg_288_1.time_ >= var_291_0 + var_291_1 and arg_288_1.time_ < var_291_0 + var_291_1 + arg_291_0 then
				local var_291_4 = Color.New(1, 1, 1)
				local var_291_5 = 0

				arg_288_1.mask_.enabled = false
				var_291_4.a = var_291_5
				arg_288_1.mask_.color = var_291_4
			end

			if arg_288_1.frameCnt_ <= 1 then
				arg_288_1.dialog_:SetActive(false)
			end

			local var_291_6 = 1
			local var_291_7 = 1.025

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0

				arg_288_1.dialog_:SetActive(true)

				arg_288_1.dialogCg_.alpha = 0

				local var_291_8 = LeanTween.value(arg_288_1.dialog_, 0, 1, 0.3)

				var_291_8:setOnUpdate(LuaHelper.FloatAction(function(arg_292_0)
					arg_288_1.dialogCg_.alpha = arg_292_0
				end))
				var_291_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_288_1.dialog_)
					var_291_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_288_1.duration_ = arg_288_1.duration_ + 0.3

				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_9 = arg_288_1:GetWordFromCfg(319801067)
				local var_291_10 = arg_288_1:FormatText(var_291_9.content)

				arg_288_1.text_.text = var_291_10

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_11 = 41
				local var_291_12 = utf8.len(var_291_10)
				local var_291_13 = var_291_11 <= 0 and var_291_7 or var_291_7 * (var_291_12 / var_291_11)

				if var_291_13 > 0 and var_291_7 < var_291_13 then
					arg_288_1.talkMaxDuration = var_291_13
					var_291_6 = var_291_6 + 0.3

					if var_291_13 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_10
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_14 = var_291_6 + 0.3
			local var_291_15 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_14 <= arg_288_1.time_ and arg_288_1.time_ < var_291_14 + var_291_15 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_14) / var_291_15

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_14 + var_291_15 and arg_288_1.time_ < var_291_14 + var_291_15 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play319801068 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 319801068
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play319801069(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 1.1

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_2 = arg_294_1:GetWordFromCfg(319801068)
				local var_297_3 = arg_294_1:FormatText(var_297_2.content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 44
				local var_297_5 = utf8.len(var_297_3)
				local var_297_6 = var_297_4 <= 0 and var_297_1 or var_297_1 * (var_297_5 / var_297_4)

				if var_297_6 > 0 and var_297_1 < var_297_6 then
					arg_294_1.talkMaxDuration = var_297_6

					if var_297_6 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_6 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_7 and arg_294_1.time_ < var_297_0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play319801069 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 319801069
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play319801070(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.925

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

				local var_301_2 = arg_298_1:GetWordFromCfg(319801069)
				local var_301_3 = arg_298_1:FormatText(var_301_2.content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 37
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
	Play319801070 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 319801070
		arg_302_1.duration_ = 3.37

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play319801071(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = "STblack"

			if arg_302_1.bgs_[var_305_0] == nil then
				local var_305_1 = Object.Instantiate(arg_302_1.paintGo_)

				var_305_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_305_0)
				var_305_1.name = var_305_0
				var_305_1.transform.parent = arg_302_1.stage_.transform
				var_305_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_302_1.bgs_[var_305_0] = var_305_1
			end

			local var_305_2 = 0

			if var_305_2 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				local var_305_3 = manager.ui.mainCamera.transform.localPosition
				local var_305_4 = Vector3.New(0, 0, 10) + Vector3.New(var_305_3.x, var_305_3.y, 0)
				local var_305_5 = arg_302_1.bgs_.STblack

				var_305_5.transform.localPosition = var_305_4
				var_305_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_305_6 = var_305_5:GetComponent("SpriteRenderer")

				if var_305_6 and var_305_6.sprite then
					local var_305_7 = (var_305_5.transform.localPosition - var_305_3).z
					local var_305_8 = manager.ui.mainCameraCom_
					local var_305_9 = 2 * var_305_7 * Mathf.Tan(var_305_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_305_10 = var_305_9 * var_305_8.aspect
					local var_305_11 = var_305_6.sprite.bounds.size.x
					local var_305_12 = var_305_6.sprite.bounds.size.y
					local var_305_13 = var_305_10 / var_305_11
					local var_305_14 = var_305_9 / var_305_12
					local var_305_15 = var_305_14 < var_305_13 and var_305_13 or var_305_14

					var_305_5.transform.localScale = Vector3.New(var_305_15, var_305_15, 0)
				end

				for iter_305_0, iter_305_1 in pairs(arg_302_1.bgs_) do
					if iter_305_0 ~= "STblack" then
						iter_305_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_305_16 = 0

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				local var_305_17 = arg_302_1.fswbg_.transform:Find("textbox/adapt/content") or arg_302_1.fswbg_.transform:Find("textbox/content")
				local var_305_18 = arg_302_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_305_19 = var_305_17:GetComponent("Text")
				local var_305_20 = var_305_17:GetComponent("RectTransform")

				var_305_19.alignment = UnityEngine.TextAnchor.LowerCenter
				var_305_20.offsetMin = Vector2.New(0, 0)
				var_305_20.offsetMax = Vector2.New(0, 0)
			end

			local var_305_21 = 0

			if var_305_21 < arg_302_1.time_ and arg_302_1.time_ <= var_305_21 + arg_305_0 then
				arg_302_1.fswbg_:SetActive(true)
				arg_302_1.dialog_:SetActive(false)

				arg_302_1.fswtw_.percent = 0

				local var_305_22 = arg_302_1:GetWordFromCfg(319801070)
				local var_305_23 = arg_302_1:FormatText(var_305_22.content)

				arg_302_1.fswt_.text = var_305_23

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.fswt_)

				arg_302_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_302_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_302_1.fswtw_:SetDirty()

				arg_302_1.typewritterCharCountI18N = 0

				SetActive(arg_302_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_302_1:ShowNextGo(false)
			end

			local var_305_24 = 0.433333333333333

			if var_305_24 < arg_302_1.time_ and arg_302_1.time_ <= var_305_24 + arg_305_0 then
				arg_302_1.var_.oldValueTypewriter = arg_302_1.fswtw_.percent

				SetActive(arg_302_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_302_1:ShowNextGo(false)
			end

			local var_305_25 = 0
			local var_305_26 = 0
			local var_305_27 = arg_302_1:GetWordFromCfg(319801070)
			local var_305_28 = arg_302_1:FormatText(var_305_27.content)
			local var_305_29, var_305_30 = arg_302_1:GetPercentByPara(var_305_28, 1)

			if var_305_24 < arg_302_1.time_ and arg_302_1.time_ <= var_305_24 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				local var_305_31 = var_305_25 <= 0 and var_305_26 or var_305_26 * ((var_305_30 - arg_302_1.typewritterCharCountI18N) / var_305_25)

				if var_305_31 > 0 and var_305_26 < var_305_31 then
					arg_302_1.talkMaxDuration = var_305_31

					if var_305_31 + var_305_24 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_31 + var_305_24
					end
				end
			end

			local var_305_32 = 0
			local var_305_33 = math.max(var_305_32, arg_302_1.talkMaxDuration)

			if var_305_24 <= arg_302_1.time_ and arg_302_1.time_ < var_305_24 + var_305_33 then
				local var_305_34 = (arg_302_1.time_ - var_305_24) / var_305_33

				arg_302_1.fswtw_.percent = Mathf.Lerp(arg_302_1.var_.oldValueTypewriter, var_305_29, var_305_34)
				arg_302_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_302_1.fswtw_:SetDirty()
			end

			if arg_302_1.time_ >= var_305_24 + var_305_33 and arg_302_1.time_ < var_305_24 + var_305_33 + arg_305_0 then
				arg_302_1.fswtw_.percent = var_305_29

				arg_302_1.fswtw_:SetDirty()
				arg_302_1:ShowNextGo(true)

				arg_302_1.typewritterCharCountI18N = var_305_30
			end

			local var_305_35 = 0.433333333333333

			if var_305_35 < arg_302_1.time_ and arg_302_1.time_ <= var_305_35 + arg_305_0 then
				arg_302_1.fswbg_:SetActive(true)
				arg_302_1.dialog_:SetActive(false)

				arg_302_1.fswtw_.percent = 0

				local var_305_36 = arg_302_1:GetWordFromCfg(319801070)
				local var_305_37 = arg_302_1:FormatText(var_305_36.content)

				arg_302_1.fswt_.text = var_305_37

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.fswt_)

				arg_302_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_302_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_302_1.fswtw_:SetDirty()

				arg_302_1.typewritterCharCountI18N = 0

				SetActive(arg_302_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_302_1:ShowNextGo(false)
			end

			local var_305_38 = 0.566666666666667

			if var_305_38 < arg_302_1.time_ and arg_302_1.time_ <= var_305_38 + arg_305_0 then
				arg_302_1.var_.oldValueTypewriter = arg_302_1.fswtw_.percent

				SetActive(arg_302_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_302_1:ShowNextGo(false)
			end

			local var_305_39 = 10
			local var_305_40 = 0.666666666666667
			local var_305_41 = arg_302_1:GetWordFromCfg(319801070)
			local var_305_42 = arg_302_1:FormatText(var_305_41.content)
			local var_305_43, var_305_44 = arg_302_1:GetPercentByPara(var_305_42, 1)

			if var_305_38 < arg_302_1.time_ and arg_302_1.time_ <= var_305_38 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				local var_305_45 = var_305_39 <= 0 and var_305_40 or var_305_40 * ((var_305_44 - arg_302_1.typewritterCharCountI18N) / var_305_39)

				if var_305_45 > 0 and var_305_40 < var_305_45 then
					arg_302_1.talkMaxDuration = var_305_45

					if var_305_45 + var_305_38 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_45 + var_305_38
					end
				end
			end

			local var_305_46 = 0.666666666666667
			local var_305_47 = math.max(var_305_46, arg_302_1.talkMaxDuration)

			if var_305_38 <= arg_302_1.time_ and arg_302_1.time_ < var_305_38 + var_305_47 then
				local var_305_48 = (arg_302_1.time_ - var_305_38) / var_305_47

				arg_302_1.fswtw_.percent = Mathf.Lerp(arg_302_1.var_.oldValueTypewriter, var_305_43, var_305_48)
				arg_302_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_302_1.fswtw_:SetDirty()
			end

			if arg_302_1.time_ >= var_305_38 + var_305_47 and arg_302_1.time_ < var_305_38 + var_305_47 + arg_305_0 then
				arg_302_1.fswtw_.percent = var_305_43

				arg_302_1.fswtw_:SetDirty()
				arg_302_1:ShowNextGo(true)

				arg_302_1.typewritterCharCountI18N = var_305_44
			end

			local var_305_49 = 0.433333333333333
			local var_305_50 = 2.933
			local var_305_51 = manager.audio:GetVoiceLength("story_v_out_319801", "319801070", "story_v_out_319801.awb") / 1000

			if var_305_51 > 0 and var_305_50 < var_305_51 and var_305_51 + var_305_49 > arg_302_1.duration_ then
				local var_305_52 = var_305_51

				arg_302_1.duration_ = var_305_51 + var_305_49
			end

			if var_305_49 < arg_302_1.time_ and arg_302_1.time_ <= var_305_49 + arg_305_0 then
				local var_305_53 = "play"
				local var_305_54 = "voice"

				arg_302_1:AudioAction(var_305_53, var_305_54, "story_v_out_319801", "319801070", "story_v_out_319801.awb")
			end

			local var_305_55 = 0

			if var_305_55 < arg_302_1.time_ and arg_302_1.time_ <= var_305_55 + arg_305_0 then
				arg_302_1.cswbg_:SetActive(true)

				local var_305_56 = arg_302_1.cswt_:GetComponent("RectTransform")

				arg_302_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_305_56.offsetMin = Vector2.New(410, 330)
				var_305_56.offsetMax = Vector2.New(-400, -175)

				local var_305_57 = arg_302_1:GetWordFromCfg(419055)
				local var_305_58 = arg_302_1:FormatText(var_305_57.content)

				arg_302_1.cswt_.text = var_305_58

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.cswt_)

				arg_302_1.cswt_.fontSize = 180
				arg_302_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_302_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_302_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play319801071 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 319801071
		arg_306_1.duration_ = 6.17

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play319801072(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.2

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				local var_309_2 = "play"
				local var_309_3 = "music"

				arg_306_1:AudioAction(var_309_2, var_309_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_309_4 = ""
				local var_309_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_309_5 ~= "" then
					if arg_306_1.bgmTxt_.text ~= var_309_5 and arg_306_1.bgmTxt_.text ~= "" then
						if arg_306_1.bgmTxt2_.text ~= "" then
							arg_306_1.bgmTxt_.text = arg_306_1.bgmTxt2_.text
						end

						arg_306_1.bgmTxt2_.text = var_309_5

						arg_306_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_306_1.bgmTxt_.text = var_309_5
						arg_306_1.bgmTxt2_.text = var_309_5
					end

					if arg_306_1.bgmTimer then
						arg_306_1.bgmTimer:Stop()

						arg_306_1.bgmTimer = nil
					end

					if arg_306_1.settingData.show_music_name == 1 then
						arg_306_1.musicController:SetSelectedState("show")
						arg_306_1.musicAnimator_:Play("open", 0, 0)

						if arg_306_1.settingData.music_time ~= 0 then
							arg_306_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_306_1.settingData.music_time), function()
								if arg_306_1 == nil or isNil(arg_306_1.bgmTxt_) then
									return
								end

								arg_306_1.musicController:SetSelectedState("hide")
								arg_306_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_309_6 = 0.233333333333333
			local var_309_7 = 1

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				local var_309_8 = "play"
				local var_309_9 = "music"

				arg_306_1:AudioAction(var_309_8, var_309_9, "bgm_activity_3_0_story_special_death", "bgm_activity_3_0_story_special_death", "bgm_activity_3_0_story_special_death.awb")

				local var_309_10 = ""
				local var_309_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_special_death", "bgm_activity_3_0_story_special_death")

				if var_309_11 ~= "" then
					if arg_306_1.bgmTxt_.text ~= var_309_11 and arg_306_1.bgmTxt_.text ~= "" then
						if arg_306_1.bgmTxt2_.text ~= "" then
							arg_306_1.bgmTxt_.text = arg_306_1.bgmTxt2_.text
						end

						arg_306_1.bgmTxt2_.text = var_309_11

						arg_306_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_306_1.bgmTxt_.text = var_309_11
						arg_306_1.bgmTxt2_.text = var_309_11
					end

					if arg_306_1.bgmTimer then
						arg_306_1.bgmTimer:Stop()

						arg_306_1.bgmTimer = nil
					end

					if arg_306_1.settingData.show_music_name == 1 then
						arg_306_1.musicController:SetSelectedState("show")
						arg_306_1.musicAnimator_:Play("open", 0, 0)

						if arg_306_1.settingData.music_time ~= 0 then
							arg_306_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_306_1.settingData.music_time), function()
								if arg_306_1 == nil or isNil(arg_306_1.bgmTxt_) then
									return
								end

								arg_306_1.musicController:SetSelectedState("hide")
								arg_306_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_309_12 = 0

			if var_309_12 < arg_306_1.time_ and arg_306_1.time_ <= var_309_12 + arg_309_0 then
				arg_306_1.fswbg_:SetActive(true)
				arg_306_1.dialog_:SetActive(false)

				arg_306_1.fswtw_.percent = 0

				local var_309_13 = arg_306_1:GetWordFromCfg(319801071)
				local var_309_14 = arg_306_1:FormatText(var_309_13.content)

				arg_306_1.fswt_.text = var_309_14

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.fswt_)

				arg_306_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_306_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_306_1.fswtw_:SetDirty()

				arg_306_1.typewritterCharCountI18N = 0

				SetActive(arg_306_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_306_1:ShowNextGo(false)
			end

			local var_309_15 = 0.333333333332

			if var_309_15 < arg_306_1.time_ and arg_306_1.time_ <= var_309_15 + arg_309_0 then
				arg_306_1.var_.oldValueTypewriter = arg_306_1.fswtw_.percent

				SetActive(arg_306_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_306_1:ShowNextGo(false)
			end

			local var_309_16 = 18
			local var_309_17 = 1.2
			local var_309_18 = arg_306_1:GetWordFromCfg(319801071)
			local var_309_19 = arg_306_1:FormatText(var_309_18.content)
			local var_309_20, var_309_21 = arg_306_1:GetPercentByPara(var_309_19, 1)

			if var_309_15 < arg_306_1.time_ and arg_306_1.time_ <= var_309_15 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0

				local var_309_22 = var_309_16 <= 0 and var_309_17 or var_309_17 * ((var_309_21 - arg_306_1.typewritterCharCountI18N) / var_309_16)

				if var_309_22 > 0 and var_309_17 < var_309_22 then
					arg_306_1.talkMaxDuration = var_309_22

					if var_309_22 + var_309_15 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_22 + var_309_15
					end
				end
			end

			local var_309_23 = 1.2
			local var_309_24 = math.max(var_309_23, arg_306_1.talkMaxDuration)

			if var_309_15 <= arg_306_1.time_ and arg_306_1.time_ < var_309_15 + var_309_24 then
				local var_309_25 = (arg_306_1.time_ - var_309_15) / var_309_24

				arg_306_1.fswtw_.percent = Mathf.Lerp(arg_306_1.var_.oldValueTypewriter, var_309_20, var_309_25)
				arg_306_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_306_1.fswtw_:SetDirty()
			end

			if arg_306_1.time_ >= var_309_15 + var_309_24 and arg_306_1.time_ < var_309_15 + var_309_24 + arg_309_0 then
				arg_306_1.fswtw_.percent = var_309_20

				arg_306_1.fswtw_:SetDirty()
				arg_306_1:ShowNextGo(true)

				arg_306_1.typewritterCharCountI18N = var_309_21
			end

			local var_309_26 = 0.233333333333333
			local var_309_27 = 5.933
			local var_309_28 = manager.audio:GetVoiceLength("story_v_out_319801", "319801071", "story_v_out_319801.awb") / 1000

			if var_309_28 > 0 and var_309_27 < var_309_28 and var_309_28 + var_309_26 > arg_306_1.duration_ then
				local var_309_29 = var_309_28

				arg_306_1.duration_ = var_309_28 + var_309_26
			end

			if var_309_26 < arg_306_1.time_ and arg_306_1.time_ <= var_309_26 + arg_309_0 then
				local var_309_30 = "play"
				local var_309_31 = "voice"

				arg_306_1:AudioAction(var_309_30, var_309_31, "story_v_out_319801", "319801071", "story_v_out_319801.awb")
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play319801072 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 319801072
		arg_312_1.duration_ = 6.7

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play319801073(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = "ML0204"

			if arg_312_1.bgs_[var_315_0] == nil then
				local var_315_1 = Object.Instantiate(arg_312_1.paintGo_)

				var_315_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_315_0)
				var_315_1.name = var_315_0
				var_315_1.transform.parent = arg_312_1.stage_.transform
				var_315_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_312_1.bgs_[var_315_0] = var_315_1
			end

			local var_315_2 = 0.416666666666667

			if var_315_2 < arg_312_1.time_ and arg_312_1.time_ <= var_315_2 + arg_315_0 then
				local var_315_3 = manager.ui.mainCamera.transform.localPosition
				local var_315_4 = Vector3.New(0, 0, 10) + Vector3.New(var_315_3.x, var_315_3.y, 0)
				local var_315_5 = arg_312_1.bgs_.ML0204

				var_315_5.transform.localPosition = var_315_4
				var_315_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_315_6 = var_315_5:GetComponent("SpriteRenderer")

				if var_315_6 and var_315_6.sprite then
					local var_315_7 = (var_315_5.transform.localPosition - var_315_3).z
					local var_315_8 = manager.ui.mainCameraCom_
					local var_315_9 = 2 * var_315_7 * Mathf.Tan(var_315_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_315_10 = var_315_9 * var_315_8.aspect
					local var_315_11 = var_315_6.sprite.bounds.size.x
					local var_315_12 = var_315_6.sprite.bounds.size.y
					local var_315_13 = var_315_10 / var_315_11
					local var_315_14 = var_315_9 / var_315_12
					local var_315_15 = var_315_14 < var_315_13 and var_315_13 or var_315_14

					var_315_5.transform.localScale = Vector3.New(var_315_15, var_315_15, 0)
				end

				for iter_315_0, iter_315_1 in pairs(arg_312_1.bgs_) do
					if iter_315_0 ~= "ML0204" then
						iter_315_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_315_16 = 0

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_17 = 0.433333333333333

			if var_315_16 <= arg_312_1.time_ and arg_312_1.time_ < var_315_16 + var_315_17 then
				local var_315_18 = (arg_312_1.time_ - var_315_16) / var_315_17
				local var_315_19 = Color.New(0, 0, 0)

				var_315_19.a = Mathf.Lerp(0, 1, var_315_18)
				arg_312_1.mask_.color = var_315_19
			end

			if arg_312_1.time_ >= var_315_16 + var_315_17 and arg_312_1.time_ < var_315_16 + var_315_17 + arg_315_0 then
				local var_315_20 = Color.New(0, 0, 0)

				var_315_20.a = 1
				arg_312_1.mask_.color = var_315_20
			end

			local var_315_21 = 0.433333333333333

			if var_315_21 < arg_312_1.time_ and arg_312_1.time_ <= var_315_21 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_22 = 2

			if var_315_21 <= arg_312_1.time_ and arg_312_1.time_ < var_315_21 + var_315_22 then
				local var_315_23 = (arg_312_1.time_ - var_315_21) / var_315_22
				local var_315_24 = Color.New(0, 0, 0)

				var_315_24.a = Mathf.Lerp(1, 0, var_315_23)
				arg_312_1.mask_.color = var_315_24
			end

			if arg_312_1.time_ >= var_315_21 + var_315_22 and arg_312_1.time_ < var_315_21 + var_315_22 + arg_315_0 then
				local var_315_25 = Color.New(0, 0, 0)
				local var_315_26 = 0

				arg_312_1.mask_.enabled = false
				var_315_25.a = var_315_26
				arg_312_1.mask_.color = var_315_25
			end

			local var_315_27 = arg_312_1.actors_["10066ui_story"].transform
			local var_315_28 = 0

			if var_315_28 < arg_312_1.time_ and arg_312_1.time_ <= var_315_28 + arg_315_0 then
				arg_312_1.var_.moveOldPos10066ui_story = var_315_27.localPosition
			end

			local var_315_29 = 0.001

			if var_315_28 <= arg_312_1.time_ and arg_312_1.time_ < var_315_28 + var_315_29 then
				local var_315_30 = (arg_312_1.time_ - var_315_28) / var_315_29
				local var_315_31 = Vector3.New(0, 100, 0)

				var_315_27.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10066ui_story, var_315_31, var_315_30)

				local var_315_32 = manager.ui.mainCamera.transform.position - var_315_27.position

				var_315_27.forward = Vector3.New(var_315_32.x, var_315_32.y, var_315_32.z)

				local var_315_33 = var_315_27.localEulerAngles

				var_315_33.z = 0
				var_315_33.x = 0
				var_315_27.localEulerAngles = var_315_33
			end

			if arg_312_1.time_ >= var_315_28 + var_315_29 and arg_312_1.time_ < var_315_28 + var_315_29 + arg_315_0 then
				var_315_27.localPosition = Vector3.New(0, 100, 0)

				local var_315_34 = manager.ui.mainCamera.transform.position - var_315_27.position

				var_315_27.forward = Vector3.New(var_315_34.x, var_315_34.y, var_315_34.z)

				local var_315_35 = var_315_27.localEulerAngles

				var_315_35.z = 0
				var_315_35.x = 0
				var_315_27.localEulerAngles = var_315_35
			end

			local var_315_36 = arg_312_1.actors_["10066ui_story"]
			local var_315_37 = 0

			if var_315_37 < arg_312_1.time_ and arg_312_1.time_ <= var_315_37 + arg_315_0 and not isNil(var_315_36) and arg_312_1.var_.characterEffect10066ui_story == nil then
				arg_312_1.var_.characterEffect10066ui_story = var_315_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_38 = 0.200000002980232

			if var_315_37 <= arg_312_1.time_ and arg_312_1.time_ < var_315_37 + var_315_38 and not isNil(var_315_36) then
				local var_315_39 = (arg_312_1.time_ - var_315_37) / var_315_38

				if arg_312_1.var_.characterEffect10066ui_story and not isNil(var_315_36) then
					local var_315_40 = Mathf.Lerp(0, 0.5, var_315_39)

					arg_312_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_312_1.var_.characterEffect10066ui_story.fillRatio = var_315_40
				end
			end

			if arg_312_1.time_ >= var_315_37 + var_315_38 and arg_312_1.time_ < var_315_37 + var_315_38 + arg_315_0 and not isNil(var_315_36) and arg_312_1.var_.characterEffect10066ui_story then
				local var_315_41 = 0.5

				arg_312_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_312_1.var_.characterEffect10066ui_story.fillRatio = var_315_41
			end

			local var_315_42 = 0

			if var_315_42 < arg_312_1.time_ and arg_312_1.time_ <= var_315_42 + arg_315_0 then
				arg_312_1.fswbg_:SetActive(false)
				arg_312_1.dialog_:SetActive(false)
				SetActive(arg_312_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_312_1:ShowNextGo(false)
			end

			local var_315_43 = 0.1

			if var_315_43 < arg_312_1.time_ and arg_312_1.time_ <= var_315_43 + arg_315_0 then
				arg_312_1.fswbg_:SetActive(false)
				arg_312_1.dialog_:SetActive(false)
				SetActive(arg_312_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_312_1:ShowNextGo(false)
			end

			local var_315_44 = 0.433333333333333

			if var_315_44 < arg_312_1.time_ and arg_312_1.time_ <= var_315_44 + arg_315_0 then
				arg_312_1.var_.oldValueTypewriter = arg_312_1.fswtw_.percent

				SetActive(arg_312_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_312_1:ShowNextGo(false)
			end

			local var_315_45 = 0
			local var_315_46 = 0
			local var_315_47 = arg_312_1:GetWordFromCfg(319801071)
			local var_315_48 = arg_312_1:FormatText(var_315_47.content)
			local var_315_49, var_315_50 = arg_312_1:GetPercentByPara(var_315_48, 1)

			if var_315_44 < arg_312_1.time_ and arg_312_1.time_ <= var_315_44 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				local var_315_51 = var_315_45 <= 0 and var_315_46 or var_315_46 * ((var_315_50 - arg_312_1.typewritterCharCountI18N) / var_315_45)

				if var_315_51 > 0 and var_315_46 < var_315_51 then
					arg_312_1.talkMaxDuration = var_315_51

					if var_315_51 + var_315_44 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_51 + var_315_44
					end
				end
			end

			local var_315_52 = 0
			local var_315_53 = math.max(var_315_52, arg_312_1.talkMaxDuration)

			if var_315_44 <= arg_312_1.time_ and arg_312_1.time_ < var_315_44 + var_315_53 then
				local var_315_54 = (arg_312_1.time_ - var_315_44) / var_315_53

				arg_312_1.fswtw_.percent = Mathf.Lerp(arg_312_1.var_.oldValueTypewriter, var_315_49, var_315_54)
				arg_312_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_312_1.fswtw_:SetDirty()
			end

			if arg_312_1.time_ >= var_315_44 + var_315_53 and arg_312_1.time_ < var_315_44 + var_315_53 + arg_315_0 then
				arg_312_1.fswtw_.percent = var_315_49

				arg_312_1.fswtw_:SetDirty()
				arg_312_1:ShowNextGo(true)

				arg_312_1.typewritterCharCountI18N = var_315_50
			end

			local var_315_55 = 0

			if var_315_55 < arg_312_1.time_ and arg_312_1.time_ <= var_315_55 + arg_315_0 then
				arg_312_1.cswbg_:SetActive(false)
			end

			local var_315_56 = arg_312_1.bgs_.ML0204.transform
			local var_315_57 = 0.433333333333333

			if var_315_57 < arg_312_1.time_ and arg_312_1.time_ <= var_315_57 + arg_315_0 then
				arg_312_1.var_.moveOldPosML0204 = var_315_56.localPosition
			end

			local var_315_58 = 0.001

			if var_315_57 <= arg_312_1.time_ and arg_312_1.time_ < var_315_57 + var_315_58 then
				local var_315_59 = (arg_312_1.time_ - var_315_57) / var_315_58
				local var_315_60 = Vector3.New(0, 1, 7.64)

				var_315_56.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPosML0204, var_315_60, var_315_59)
			end

			if arg_312_1.time_ >= var_315_57 + var_315_58 and arg_312_1.time_ < var_315_57 + var_315_58 + arg_315_0 then
				var_315_56.localPosition = Vector3.New(0, 1, 7.64)
			end

			local var_315_61 = arg_312_1.bgs_.ML0204.transform
			local var_315_62 = 0.45

			if var_315_62 < arg_312_1.time_ and arg_312_1.time_ <= var_315_62 + arg_315_0 then
				arg_312_1.var_.moveOldPosML0204 = var_315_61.localPosition
			end

			local var_315_63 = 2.1

			if var_315_62 <= arg_312_1.time_ and arg_312_1.time_ < var_315_62 + var_315_63 then
				local var_315_64 = (arg_312_1.time_ - var_315_62) / var_315_63
				local var_315_65 = Vector3.New(0, 1, 10)

				var_315_61.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPosML0204, var_315_65, var_315_64)
			end

			if arg_312_1.time_ >= var_315_62 + var_315_63 and arg_312_1.time_ < var_315_62 + var_315_63 + arg_315_0 then
				var_315_61.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_66 = 1.7
			local var_315_67 = 0.975

			if var_315_66 < arg_312_1.time_ and arg_312_1.time_ <= var_315_66 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_68 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_68:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_312_1.dialogCg_.alpha = arg_316_0
				end))
				var_315_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_69 = arg_312_1:GetWordFromCfg(319801072)
				local var_315_70 = arg_312_1:FormatText(var_315_69.content)

				arg_312_1.text_.text = var_315_70

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_71 = 39
				local var_315_72 = utf8.len(var_315_70)
				local var_315_73 = var_315_71 <= 0 and var_315_67 or var_315_67 * (var_315_72 / var_315_71)

				if var_315_73 > 0 and var_315_67 < var_315_73 then
					arg_312_1.talkMaxDuration = var_315_73
					var_315_66 = var_315_66 + 0.3

					if var_315_73 + var_315_66 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_73 + var_315_66
					end
				end

				arg_312_1.text_.text = var_315_70
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_74 = var_315_66 + 0.3
			local var_315_75 = math.max(var_315_67, arg_312_1.talkMaxDuration)

			if var_315_74 <= arg_312_1.time_ and arg_312_1.time_ < var_315_74 + var_315_75 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_74) / var_315_75

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_74 + var_315_75 and arg_312_1.time_ < var_315_74 + var_315_75 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.433333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.1,
				className = "StoryMoveNode",
				startTime = 0.45,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play319801073 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 319801073
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play319801074(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 0.975

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_2 = arg_318_1:GetWordFromCfg(319801073)
				local var_321_3 = arg_318_1:FormatText(var_321_2.content)

				arg_318_1.text_.text = var_321_3

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 39
				local var_321_5 = utf8.len(var_321_3)
				local var_321_6 = var_321_4 <= 0 and var_321_1 or var_321_1 * (var_321_5 / var_321_4)

				if var_321_6 > 0 and var_321_1 < var_321_6 then
					arg_318_1.talkMaxDuration = var_321_6

					if var_321_6 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_6 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_3
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_7 and arg_318_1.time_ < var_321_0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play319801074 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 319801074
		arg_322_1.duration_ = 3.07

		local var_322_0 = {
			zh = 2.933,
			ja = 3.066
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play319801075(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.3

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[6].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_3 = arg_322_1:GetWordFromCfg(319801074)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801074", "story_v_out_319801.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801074", "story_v_out_319801.awb") / 1000

					if var_325_8 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_0
					end

					if var_325_3.prefab_name ~= "" and arg_322_1.actors_[var_325_3.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_3.prefab_name].transform, "story_v_out_319801", "319801074", "story_v_out_319801.awb")

						arg_322_1:RecordAudio("319801074", var_325_9)
						arg_322_1:RecordAudio("319801074", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_319801", "319801074", "story_v_out_319801.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_319801", "319801074", "story_v_out_319801.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_10 and arg_322_1.time_ < var_325_0 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play319801075 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 319801075
		arg_326_1.duration_ = 9.5

		local var_326_0 = {
			zh = 4.433,
			ja = 9.5
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play319801076(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.275

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[640].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_3 = arg_326_1:GetWordFromCfg(319801075)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 11
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801075", "story_v_out_319801.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801075", "story_v_out_319801.awb") / 1000

					if var_329_8 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_0
					end

					if var_329_3.prefab_name ~= "" and arg_326_1.actors_[var_329_3.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_3.prefab_name].transform, "story_v_out_319801", "319801075", "story_v_out_319801.awb")

						arg_326_1:RecordAudio("319801075", var_329_9)
						arg_326_1:RecordAudio("319801075", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_319801", "319801075", "story_v_out_319801.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_319801", "319801075", "story_v_out_319801.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_10 and arg_326_1.time_ < var_329_0 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play319801076 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 319801076
		arg_330_1.duration_ = 2.8

		local var_330_0 = {
			zh = 1.733,
			ja = 2.8
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play319801077(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.175

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[6].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:GetWordFromCfg(319801076)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 7
				local var_333_6 = utf8.len(var_333_4)
				local var_333_7 = var_333_5 <= 0 and var_333_1 or var_333_1 * (var_333_6 / var_333_5)

				if var_333_7 > 0 and var_333_1 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801076", "story_v_out_319801.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801076", "story_v_out_319801.awb") / 1000

					if var_333_8 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_0
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_out_319801", "319801076", "story_v_out_319801.awb")

						arg_330_1:RecordAudio("319801076", var_333_9)
						arg_330_1:RecordAudio("319801076", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_319801", "319801076", "story_v_out_319801.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_319801", "319801076", "story_v_out_319801.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_10 and arg_330_1.time_ < var_333_0 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play319801077 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 319801077
		arg_334_1.duration_ = 5.57

		local var_334_0 = {
			zh = 3.8,
			ja = 5.566
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play319801078(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.425

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_2 = arg_334_1:FormatText(StoryNameCfg[6].name)

				arg_334_1.leftNameTxt_.text = var_337_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_3 = arg_334_1:GetWordFromCfg(319801077)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 17
				local var_337_6 = utf8.len(var_337_4)
				local var_337_7 = var_337_5 <= 0 and var_337_1 or var_337_1 * (var_337_6 / var_337_5)

				if var_337_7 > 0 and var_337_1 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801077", "story_v_out_319801.awb") ~= 0 then
					local var_337_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801077", "story_v_out_319801.awb") / 1000

					if var_337_8 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_0
					end

					if var_337_3.prefab_name ~= "" and arg_334_1.actors_[var_337_3.prefab_name] ~= nil then
						local var_337_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_3.prefab_name].transform, "story_v_out_319801", "319801077", "story_v_out_319801.awb")

						arg_334_1:RecordAudio("319801077", var_337_9)
						arg_334_1:RecordAudio("319801077", var_337_9)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_319801", "319801077", "story_v_out_319801.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_319801", "319801077", "story_v_out_319801.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_10 and arg_334_1.time_ < var_337_0 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play319801078 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 319801078
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play319801079(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 0.05

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_2 = arg_338_1:FormatText(StoryNameCfg[698].name)

				arg_338_1.leftNameTxt_.text = var_341_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_3 = arg_338_1:GetWordFromCfg(319801078)
				local var_341_4 = arg_338_1:FormatText(var_341_3.content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 2
				local var_341_6 = utf8.len(var_341_4)
				local var_341_7 = var_341_5 <= 0 and var_341_1 or var_341_1 * (var_341_6 / var_341_5)

				if var_341_7 > 0 and var_341_1 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_4
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_8 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_8 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_8

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_8 and arg_338_1.time_ < var_341_0 + var_341_8 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play319801079 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 319801079
		arg_342_1.duration_ = 4.37

		local var_342_0 = {
			zh = 4.366,
			ja = 3.3
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play319801080(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 0.325

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_2 = arg_342_1:FormatText(StoryNameCfg[640].name)

				arg_342_1.leftNameTxt_.text = var_345_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_3 = arg_342_1:GetWordFromCfg(319801079)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 13
				local var_345_6 = utf8.len(var_345_4)
				local var_345_7 = var_345_5 <= 0 and var_345_1 or var_345_1 * (var_345_6 / var_345_5)

				if var_345_7 > 0 and var_345_1 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801079", "story_v_out_319801.awb") ~= 0 then
					local var_345_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801079", "story_v_out_319801.awb") / 1000

					if var_345_8 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_0
					end

					if var_345_3.prefab_name ~= "" and arg_342_1.actors_[var_345_3.prefab_name] ~= nil then
						local var_345_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_3.prefab_name].transform, "story_v_out_319801", "319801079", "story_v_out_319801.awb")

						arg_342_1:RecordAudio("319801079", var_345_9)
						arg_342_1:RecordAudio("319801079", var_345_9)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_319801", "319801079", "story_v_out_319801.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_319801", "319801079", "story_v_out_319801.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_10 and arg_342_1.time_ < var_345_0 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play319801080 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 319801080
		arg_346_1.duration_ = 6.37

		local var_346_0 = {
			zh = 5.53333333333333,
			ja = 6.36633333333333
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play319801081(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.bgs_.ML0204.transform
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.var_.moveOldPosML0204 = var_349_0.localPosition
			end

			local var_349_2 = 0.001

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2
				local var_349_4 = Vector3.New(0, 1, 10)

				var_349_0.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPosML0204, var_349_4, var_349_3)
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 then
				var_349_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_349_5 = arg_346_1.bgs_.ML0204.transform
			local var_349_6 = 0.034

			if var_349_6 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.var_.moveOldPosML0204 = var_349_5.localPosition
			end

			local var_349_7 = 3.266

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_7 then
				local var_349_8 = (arg_346_1.time_ - var_349_6) / var_349_7
				local var_349_9 = Vector3.New(0, 0.41, 7.27)

				var_349_5.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPosML0204, var_349_9, var_349_8)
			end

			if arg_346_1.time_ >= var_349_6 + var_349_7 and arg_346_1.time_ < var_349_6 + var_349_7 + arg_349_0 then
				var_349_5.localPosition = Vector3.New(0, 0.41, 7.27)
			end

			local var_349_10 = 0

			if var_349_10 < arg_346_1.time_ and arg_346_1.time_ <= var_349_10 + arg_349_0 then
				arg_346_1.allBtn_.enabled = false
			end

			local var_349_11 = 3.3

			if arg_346_1.time_ >= var_349_10 + var_349_11 and arg_346_1.time_ < var_349_10 + var_349_11 + arg_349_0 then
				arg_346_1.allBtn_.enabled = true
			end

			if arg_346_1.frameCnt_ <= 1 then
				arg_346_1.dialog_:SetActive(false)
			end

			local var_349_12 = 1.13333333333333
			local var_349_13 = 0.275

			if var_349_12 < arg_346_1.time_ and arg_346_1.time_ <= var_349_12 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0

				arg_346_1.dialog_:SetActive(true)

				arg_346_1.dialogCg_.alpha = 0

				local var_349_14 = LeanTween.value(arg_346_1.dialog_, 0, 1, 0.3)

				var_349_14:setOnUpdate(LuaHelper.FloatAction(function(arg_350_0)
					arg_346_1.dialogCg_.alpha = arg_350_0
				end))
				var_349_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_346_1.dialog_)
					var_349_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_346_1.duration_ = arg_346_1.duration_ + 0.3

				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_15 = arg_346_1:FormatText(StoryNameCfg[640].name)

				arg_346_1.leftNameTxt_.text = var_349_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_16 = arg_346_1:GetWordFromCfg(319801080)
				local var_349_17 = arg_346_1:FormatText(var_349_16.content)

				arg_346_1.text_.text = var_349_17

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_18 = 11
				local var_349_19 = utf8.len(var_349_17)
				local var_349_20 = var_349_18 <= 0 and var_349_13 or var_349_13 * (var_349_19 / var_349_18)

				if var_349_20 > 0 and var_349_13 < var_349_20 then
					arg_346_1.talkMaxDuration = var_349_20
					var_349_12 = var_349_12 + 0.3

					if var_349_20 + var_349_12 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_20 + var_349_12
					end
				end

				arg_346_1.text_.text = var_349_17
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801080", "story_v_out_319801.awb") ~= 0 then
					local var_349_21 = manager.audio:GetVoiceLength("story_v_out_319801", "319801080", "story_v_out_319801.awb") / 1000

					if var_349_21 + var_349_12 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_21 + var_349_12
					end

					if var_349_16.prefab_name ~= "" and arg_346_1.actors_[var_349_16.prefab_name] ~= nil then
						local var_349_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_16.prefab_name].transform, "story_v_out_319801", "319801080", "story_v_out_319801.awb")

						arg_346_1:RecordAudio("319801080", var_349_22)
						arg_346_1:RecordAudio("319801080", var_349_22)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_319801", "319801080", "story_v_out_319801.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_319801", "319801080", "story_v_out_319801.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_23 = var_349_12 + 0.3
			local var_349_24 = math.max(var_349_13, arg_346_1.talkMaxDuration)

			if var_349_23 <= arg_346_1.time_ and arg_346_1.time_ < var_349_23 + var_349_24 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_23) / var_349_24

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_23 + var_349_24 and arg_346_1.time_ < var_349_23 + var_349_24 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.266,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play319801081 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 319801081
		arg_352_1.duration_ = 2

		local var_352_0 = {
			zh = 2,
			ja = 1.3
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play319801082(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0
			local var_355_1 = 0.05

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_2 = arg_352_1:FormatText(StoryNameCfg[6].name)

				arg_352_1.leftNameTxt_.text = var_355_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_3 = arg_352_1:GetWordFromCfg(319801081)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 2
				local var_355_6 = utf8.len(var_355_4)
				local var_355_7 = var_355_5 <= 0 and var_355_1 or var_355_1 * (var_355_6 / var_355_5)

				if var_355_7 > 0 and var_355_1 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_0
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801081", "story_v_out_319801.awb") ~= 0 then
					local var_355_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801081", "story_v_out_319801.awb") / 1000

					if var_355_8 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_8 + var_355_0
					end

					if var_355_3.prefab_name ~= "" and arg_352_1.actors_[var_355_3.prefab_name] ~= nil then
						local var_355_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_3.prefab_name].transform, "story_v_out_319801", "319801081", "story_v_out_319801.awb")

						arg_352_1:RecordAudio("319801081", var_355_9)
						arg_352_1:RecordAudio("319801081", var_355_9)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_319801", "319801081", "story_v_out_319801.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_319801", "319801081", "story_v_out_319801.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_10 = math.max(var_355_1, arg_352_1.talkMaxDuration)

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_10 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_0) / var_355_10

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_0 + var_355_10 and arg_352_1.time_ < var_355_0 + var_355_10 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play319801082 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 319801082
		arg_356_1.duration_ = 6.53

		local var_356_0 = {
			zh = 3.533,
			ja = 6.533
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play319801083(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.225

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[640].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:GetWordFromCfg(319801082)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 9
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801082", "story_v_out_319801.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801082", "story_v_out_319801.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_319801", "319801082", "story_v_out_319801.awb")

						arg_356_1:RecordAudio("319801082", var_359_9)
						arg_356_1:RecordAudio("319801082", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_319801", "319801082", "story_v_out_319801.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_319801", "319801082", "story_v_out_319801.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play319801083 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 319801083
		arg_360_1.duration_ = 7.33

		local var_360_0 = {
			zh = 5.366,
			ja = 7.333
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play319801084(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.4

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[640].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_3 = arg_360_1:GetWordFromCfg(319801083)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 16
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801083", "story_v_out_319801.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801083", "story_v_out_319801.awb") / 1000

					if var_363_8 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_0
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_319801", "319801083", "story_v_out_319801.awb")

						arg_360_1:RecordAudio("319801083", var_363_9)
						arg_360_1:RecordAudio("319801083", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_319801", "319801083", "story_v_out_319801.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_319801", "319801083", "story_v_out_319801.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_10 and arg_360_1.time_ < var_363_0 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play319801084 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 319801084
		arg_364_1.duration_ = 4.07

		local var_364_0 = {
			zh = 3.033,
			ja = 4.066
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
				arg_364_0:Play319801085(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.275

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[6].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_3 = arg_364_1:GetWordFromCfg(319801084)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801084", "story_v_out_319801.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801084", "story_v_out_319801.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_319801", "319801084", "story_v_out_319801.awb")

						arg_364_1:RecordAudio("319801084", var_367_9)
						arg_364_1:RecordAudio("319801084", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_319801", "319801084", "story_v_out_319801.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_319801", "319801084", "story_v_out_319801.awb")
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
	Play319801085 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 319801085
		arg_368_1.duration_ = 7.73

		local var_368_0 = {
			zh = 4.9,
			ja = 7.733
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play319801086(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.375

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[640].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_3 = arg_368_1:GetWordFromCfg(319801085)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 15
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801085", "story_v_out_319801.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801085", "story_v_out_319801.awb") / 1000

					if var_371_8 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_0
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_319801", "319801085", "story_v_out_319801.awb")

						arg_368_1:RecordAudio("319801085", var_371_9)
						arg_368_1:RecordAudio("319801085", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_319801", "319801085", "story_v_out_319801.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_319801", "319801085", "story_v_out_319801.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_10 and arg_368_1.time_ < var_371_0 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play319801086 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 319801086
		arg_372_1.duration_ = 8.5

		local var_372_0 = {
			zh = 5.43333333333333,
			ja = 8.49933333333333
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play319801087(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.allBtn_.enabled = false
			end

			local var_375_1 = 3.067333333332

			if arg_372_1.time_ >= var_375_0 + var_375_1 and arg_372_1.time_ < var_375_0 + var_375_1 + arg_375_0 then
				arg_372_1.allBtn_.enabled = true
			end

			local var_375_2 = arg_372_1.bgs_.ML0204.transform
			local var_375_3 = 0

			if var_375_3 < arg_372_1.time_ and arg_372_1.time_ <= var_375_3 + arg_375_0 then
				arg_372_1.var_.moveOldPosML0204 = var_375_2.localPosition
			end

			local var_375_4 = 0.001

			if var_375_3 <= arg_372_1.time_ and arg_372_1.time_ < var_375_3 + var_375_4 then
				local var_375_5 = (arg_372_1.time_ - var_375_3) / var_375_4
				local var_375_6 = Vector3.New(0, 0.41, 7.27)

				var_375_2.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPosML0204, var_375_6, var_375_5)
			end

			if arg_372_1.time_ >= var_375_3 + var_375_4 and arg_372_1.time_ < var_375_3 + var_375_4 + arg_375_0 then
				var_375_2.localPosition = Vector3.New(0, 0.41, 7.27)
			end

			local var_375_7 = arg_372_1.bgs_.ML0204.transform
			local var_375_8 = 0.034

			if var_375_8 < arg_372_1.time_ and arg_372_1.time_ <= var_375_8 + arg_375_0 then
				arg_372_1.var_.moveOldPosML0204 = var_375_7.localPosition
			end

			local var_375_9 = 2.79933333333333

			if var_375_8 <= arg_372_1.time_ and arg_372_1.time_ < var_375_8 + var_375_9 then
				local var_375_10 = (arg_372_1.time_ - var_375_8) / var_375_9
				local var_375_11 = Vector3.New(0, 0.41, 5.53)

				var_375_7.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPosML0204, var_375_11, var_375_10)
			end

			if arg_372_1.time_ >= var_375_8 + var_375_9 and arg_372_1.time_ < var_375_8 + var_375_9 + arg_375_0 then
				var_375_7.localPosition = Vector3.New(0, 0.41, 5.53)
			end

			if arg_372_1.frameCnt_ <= 1 then
				arg_372_1.dialog_:SetActive(false)
			end

			local var_375_12 = 1.23333333333333
			local var_375_13 = 0.3

			if var_375_12 < arg_372_1.time_ and arg_372_1.time_ <= var_375_12 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0

				arg_372_1.dialog_:SetActive(true)

				arg_372_1.dialogCg_.alpha = 0

				local var_375_14 = LeanTween.value(arg_372_1.dialog_, 0, 1, 0.3)

				var_375_14:setOnUpdate(LuaHelper.FloatAction(function(arg_376_0)
					arg_372_1.dialogCg_.alpha = arg_376_0
				end))
				var_375_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_372_1.dialog_)
					var_375_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_372_1.duration_ = arg_372_1.duration_ + 0.3

				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_15 = arg_372_1:FormatText(StoryNameCfg[640].name)

				arg_372_1.leftNameTxt_.text = var_375_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_16 = arg_372_1:GetWordFromCfg(319801086)
				local var_375_17 = arg_372_1:FormatText(var_375_16.content)

				arg_372_1.text_.text = var_375_17

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_18 = 12
				local var_375_19 = utf8.len(var_375_17)
				local var_375_20 = var_375_18 <= 0 and var_375_13 or var_375_13 * (var_375_19 / var_375_18)

				if var_375_20 > 0 and var_375_13 < var_375_20 then
					arg_372_1.talkMaxDuration = var_375_20
					var_375_12 = var_375_12 + 0.3

					if var_375_20 + var_375_12 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_20 + var_375_12
					end
				end

				arg_372_1.text_.text = var_375_17
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801086", "story_v_out_319801.awb") ~= 0 then
					local var_375_21 = manager.audio:GetVoiceLength("story_v_out_319801", "319801086", "story_v_out_319801.awb") / 1000

					if var_375_21 + var_375_12 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_21 + var_375_12
					end

					if var_375_16.prefab_name ~= "" and arg_372_1.actors_[var_375_16.prefab_name] ~= nil then
						local var_375_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_16.prefab_name].transform, "story_v_out_319801", "319801086", "story_v_out_319801.awb")

						arg_372_1:RecordAudio("319801086", var_375_22)
						arg_372_1:RecordAudio("319801086", var_375_22)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_319801", "319801086", "story_v_out_319801.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_319801", "319801086", "story_v_out_319801.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_23 = var_375_12 + 0.3
			local var_375_24 = math.max(var_375_13, arg_372_1.talkMaxDuration)

			if var_375_23 <= arg_372_1.time_ and arg_372_1.time_ < var_375_23 + var_375_24 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_23) / var_375_24

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_23 + var_375_24 and arg_372_1.time_ < var_375_23 + var_375_24 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.79933333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play319801087 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 319801087
		arg_378_1.duration_ = 6.03

		local var_378_0 = {
			zh = 2.666,
			ja = 6.033
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play319801088(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 0.2

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_2 = arg_378_1:FormatText(StoryNameCfg[640].name)

				arg_378_1.leftNameTxt_.text = var_381_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_3 = arg_378_1:GetWordFromCfg(319801087)
				local var_381_4 = arg_378_1:FormatText(var_381_3.content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 8
				local var_381_6 = utf8.len(var_381_4)
				local var_381_7 = var_381_5 <= 0 and var_381_1 or var_381_1 * (var_381_6 / var_381_5)

				if var_381_7 > 0 and var_381_1 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_4
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801087", "story_v_out_319801.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801087", "story_v_out_319801.awb") / 1000

					if var_381_8 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_0
					end

					if var_381_3.prefab_name ~= "" and arg_378_1.actors_[var_381_3.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_3.prefab_name].transform, "story_v_out_319801", "319801087", "story_v_out_319801.awb")

						arg_378_1:RecordAudio("319801087", var_381_9)
						arg_378_1:RecordAudio("319801087", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_319801", "319801087", "story_v_out_319801.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_319801", "319801087", "story_v_out_319801.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_10 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_10 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_10

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_10 and arg_378_1.time_ < var_381_0 + var_381_10 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play319801088 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 319801088
		arg_382_1.duration_ = 8.63

		local var_382_0 = {
			zh = 2.466,
			ja = 8.633
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play319801089(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_.ML0204
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				local var_385_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_385_2 then
					var_385_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_385_2.radialBlurScale = 1
					var_385_2.radialBlurGradient = 1
					var_385_2.radialBlurIntensity = 1

					if var_385_0 then
						var_385_2.radialBlurTarget = var_385_0.transform
					end
				end
			end

			local var_385_3 = 2.16666666666667

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_3 then
				local var_385_4 = (arg_382_1.time_ - var_385_1) / var_385_3
				local var_385_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_385_5 then
					var_385_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_385_5.radialBlurScale = Mathf.Lerp(1, 0.143, var_385_4)
					var_385_5.radialBlurGradient = Mathf.Lerp(1, 1, var_385_4)
					var_385_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_385_4)
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_3 and arg_382_1.time_ < var_385_1 + var_385_3 + arg_385_0 then
				local var_385_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_385_6 then
					var_385_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_385_6.radialBlurScale = 0.143
					var_385_6.radialBlurGradient = 1
					var_385_6.radialBlurIntensity = 1
				end
			end

			if arg_382_1.frameCnt_ <= 1 then
				arg_382_1.dialog_:SetActive(false)
			end

			local var_385_7 = 0.7
			local var_385_8 = 0.125

			if var_385_7 < arg_382_1.time_ and arg_382_1.time_ <= var_385_7 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0

				arg_382_1.dialog_:SetActive(true)

				arg_382_1.dialogCg_.alpha = 0

				local var_385_9 = LeanTween.value(arg_382_1.dialog_, 0, 1, 0.3)

				var_385_9:setOnUpdate(LuaHelper.FloatAction(function(arg_386_0)
					arg_382_1.dialogCg_.alpha = arg_386_0
				end))
				var_385_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_382_1.dialog_)
					var_385_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_382_1.duration_ = arg_382_1.duration_ + 0.3

				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_10 = arg_382_1:FormatText(StoryNameCfg[640].name)

				arg_382_1.leftNameTxt_.text = var_385_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_11 = arg_382_1:GetWordFromCfg(319801088)
				local var_385_12 = arg_382_1:FormatText(var_385_11.content)

				arg_382_1.text_.text = var_385_12

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_13 = 5
				local var_385_14 = utf8.len(var_385_12)
				local var_385_15 = var_385_13 <= 0 and var_385_8 or var_385_8 * (var_385_14 / var_385_13)

				if var_385_15 > 0 and var_385_8 < var_385_15 then
					arg_382_1.talkMaxDuration = var_385_15
					var_385_7 = var_385_7 + 0.3

					if var_385_15 + var_385_7 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_15 + var_385_7
					end
				end

				arg_382_1.text_.text = var_385_12
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801088", "story_v_out_319801.awb") ~= 0 then
					local var_385_16 = manager.audio:GetVoiceLength("story_v_out_319801", "319801088", "story_v_out_319801.awb") / 1000

					if var_385_16 + var_385_7 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_16 + var_385_7
					end

					if var_385_11.prefab_name ~= "" and arg_382_1.actors_[var_385_11.prefab_name] ~= nil then
						local var_385_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_11.prefab_name].transform, "story_v_out_319801", "319801088", "story_v_out_319801.awb")

						arg_382_1:RecordAudio("319801088", var_385_17)
						arg_382_1:RecordAudio("319801088", var_385_17)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_319801", "319801088", "story_v_out_319801.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_319801", "319801088", "story_v_out_319801.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_18 = var_385_7 + 0.3
			local var_385_19 = math.max(var_385_8, arg_382_1.talkMaxDuration)

			if var_385_18 <= arg_382_1.time_ and arg_382_1.time_ < var_385_18 + var_385_19 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_18) / var_385_19

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_18 + var_385_19 and arg_382_1.time_ < var_385_18 + var_385_19 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play319801089 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 319801089
		arg_388_1.duration_ = 4.9

		local var_388_0 = {
			zh = 4.9,
			ja = 4.166
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play319801090(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_.ML0204
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				local var_391_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_391_2 then
					var_391_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_391_2.radialBlurScale = 0
					var_391_2.radialBlurGradient = 1
					var_391_2.radialBlurIntensity = 0.991

					if var_391_0 then
						var_391_2.radialBlurTarget = var_391_0.transform
					end
				end
			end

			local var_391_3 = 2.16666666666667

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_3 then
				local var_391_4 = (arg_388_1.time_ - var_391_1) / var_391_3
				local var_391_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_391_5 then
					var_391_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_391_5.radialBlurScale = Mathf.Lerp(0, 0.138, var_391_4)
					var_391_5.radialBlurGradient = Mathf.Lerp(1, 1, var_391_4)
					var_391_5.radialBlurIntensity = Mathf.Lerp(0.991, 1, var_391_4)
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_3 and arg_388_1.time_ < var_391_1 + var_391_3 + arg_391_0 then
				local var_391_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_391_6 then
					var_391_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_391_6.radialBlurScale = 0.138
					var_391_6.radialBlurGradient = 1
					var_391_6.radialBlurIntensity = 1
				end
			end

			local var_391_7 = 0
			local var_391_8 = 0.275

			if var_391_7 < arg_388_1.time_ and arg_388_1.time_ <= var_391_7 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_9 = arg_388_1:FormatText(StoryNameCfg[640].name)

				arg_388_1.leftNameTxt_.text = var_391_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_10 = arg_388_1:GetWordFromCfg(319801089)
				local var_391_11 = arg_388_1:FormatText(var_391_10.content)

				arg_388_1.text_.text = var_391_11

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_12 = 11
				local var_391_13 = utf8.len(var_391_11)
				local var_391_14 = var_391_12 <= 0 and var_391_8 or var_391_8 * (var_391_13 / var_391_12)

				if var_391_14 > 0 and var_391_8 < var_391_14 then
					arg_388_1.talkMaxDuration = var_391_14

					if var_391_14 + var_391_7 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_14 + var_391_7
					end
				end

				arg_388_1.text_.text = var_391_11
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801089", "story_v_out_319801.awb") ~= 0 then
					local var_391_15 = manager.audio:GetVoiceLength("story_v_out_319801", "319801089", "story_v_out_319801.awb") / 1000

					if var_391_15 + var_391_7 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_15 + var_391_7
					end

					if var_391_10.prefab_name ~= "" and arg_388_1.actors_[var_391_10.prefab_name] ~= nil then
						local var_391_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_10.prefab_name].transform, "story_v_out_319801", "319801089", "story_v_out_319801.awb")

						arg_388_1:RecordAudio("319801089", var_391_16)
						arg_388_1:RecordAudio("319801089", var_391_16)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_319801", "319801089", "story_v_out_319801.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_319801", "319801089", "story_v_out_319801.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_17 = math.max(var_391_8, arg_388_1.talkMaxDuration)

			if var_391_7 <= arg_388_1.time_ and arg_388_1.time_ < var_391_7 + var_391_17 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_7) / var_391_17

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_7 + var_391_17 and arg_388_1.time_ < var_391_7 + var_391_17 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play319801090 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 319801090
		arg_392_1.duration_ = 7.58

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play319801091(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = "STwhite"

			if arg_392_1.bgs_[var_395_0] == nil then
				local var_395_1 = Object.Instantiate(arg_392_1.paintGo_)

				var_395_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_395_0)
				var_395_1.name = var_395_0
				var_395_1.transform.parent = arg_392_1.stage_.transform
				var_395_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_392_1.bgs_[var_395_0] = var_395_1
			end

			local var_395_2 = 1.33333333333333

			if var_395_2 < arg_392_1.time_ and arg_392_1.time_ <= var_395_2 + arg_395_0 then
				local var_395_3 = manager.ui.mainCamera.transform.localPosition
				local var_395_4 = Vector3.New(0, 0, 10) + Vector3.New(var_395_3.x, var_395_3.y, 0)
				local var_395_5 = arg_392_1.bgs_.STwhite

				var_395_5.transform.localPosition = var_395_4
				var_395_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_395_6 = var_395_5:GetComponent("SpriteRenderer")

				if var_395_6 and var_395_6.sprite then
					local var_395_7 = (var_395_5.transform.localPosition - var_395_3).z
					local var_395_8 = manager.ui.mainCameraCom_
					local var_395_9 = 2 * var_395_7 * Mathf.Tan(var_395_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_395_10 = var_395_9 * var_395_8.aspect
					local var_395_11 = var_395_6.sprite.bounds.size.x
					local var_395_12 = var_395_6.sprite.bounds.size.y
					local var_395_13 = var_395_10 / var_395_11
					local var_395_14 = var_395_9 / var_395_12
					local var_395_15 = var_395_14 < var_395_13 and var_395_13 or var_395_14

					var_395_5.transform.localScale = Vector3.New(var_395_15, var_395_15, 0)
				end

				for iter_395_0, iter_395_1 in pairs(arg_392_1.bgs_) do
					if iter_395_0 ~= "STwhite" then
						iter_395_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_395_16 = 0

			if var_395_16 < arg_392_1.time_ and arg_392_1.time_ <= var_395_16 + arg_395_0 then
				arg_392_1.allBtn_.enabled = false
			end

			local var_395_17 = 0.3

			if arg_392_1.time_ >= var_395_16 + var_395_17 and arg_392_1.time_ < var_395_16 + var_395_17 + arg_395_0 then
				arg_392_1.allBtn_.enabled = true
			end

			local var_395_18 = 0

			if var_395_18 < arg_392_1.time_ and arg_392_1.time_ <= var_395_18 + arg_395_0 then
				arg_392_1.mask_.enabled = true
				arg_392_1.mask_.raycastTarget = true

				arg_392_1:SetGaussion(false)
			end

			local var_395_19 = 1.33333333333333

			if var_395_18 <= arg_392_1.time_ and arg_392_1.time_ < var_395_18 + var_395_19 then
				local var_395_20 = (arg_392_1.time_ - var_395_18) / var_395_19
				local var_395_21 = Color.New(1, 1, 1)

				var_395_21.a = Mathf.Lerp(0, 1, var_395_20)
				arg_392_1.mask_.color = var_395_21
			end

			if arg_392_1.time_ >= var_395_18 + var_395_19 and arg_392_1.time_ < var_395_18 + var_395_19 + arg_395_0 then
				local var_395_22 = Color.New(1, 1, 1)

				var_395_22.a = 1
				arg_392_1.mask_.color = var_395_22
			end

			local var_395_23 = 1.33333333333333

			if var_395_23 < arg_392_1.time_ and arg_392_1.time_ <= var_395_23 + arg_395_0 then
				arg_392_1.mask_.enabled = true
				arg_392_1.mask_.raycastTarget = true

				arg_392_1:SetGaussion(false)
			end

			local var_395_24 = 1.36666666666667

			if var_395_23 <= arg_392_1.time_ and arg_392_1.time_ < var_395_23 + var_395_24 then
				local var_395_25 = (arg_392_1.time_ - var_395_23) / var_395_24
				local var_395_26 = Color.New(1, 1, 1)

				var_395_26.a = Mathf.Lerp(1, 0, var_395_25)
				arg_392_1.mask_.color = var_395_26
			end

			if arg_392_1.time_ >= var_395_23 + var_395_24 and arg_392_1.time_ < var_395_23 + var_395_24 + arg_395_0 then
				local var_395_27 = Color.New(1, 1, 1)
				local var_395_28 = 0

				arg_392_1.mask_.enabled = false
				var_395_27.a = var_395_28
				arg_392_1.mask_.color = var_395_27
			end

			local var_395_29 = 0
			local var_395_30 = 1

			if var_395_29 < arg_392_1.time_ and arg_392_1.time_ <= var_395_29 + arg_395_0 then
				local var_395_31 = "stop"
				local var_395_32 = "effect"

				arg_392_1:AudioAction(var_395_31, var_395_32, "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			local var_395_33 = arg_392_1.actors_.ML0204
			local var_395_34 = 1.33333333333333

			if var_395_34 < arg_392_1.time_ and arg_392_1.time_ <= var_395_34 + arg_395_0 then
				local var_395_35 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_395_35 then
					var_395_35.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_395_35.radialBlurScale = 1
					var_395_35.radialBlurGradient = 1
					var_395_35.radialBlurIntensity = 1

					if var_395_33 then
						var_395_35.radialBlurTarget = var_395_33.transform
					end
				end
			end

			local var_395_36 = 0.933333333333333

			if var_395_34 <= arg_392_1.time_ and arg_392_1.time_ < var_395_34 + var_395_36 then
				local var_395_37 = (arg_392_1.time_ - var_395_34) / var_395_36
				local var_395_38 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_395_38 then
					var_395_38.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_395_38.radialBlurScale = Mathf.Lerp(1, 0.143, var_395_37)
					var_395_38.radialBlurGradient = Mathf.Lerp(1, 1, var_395_37)
					var_395_38.radialBlurIntensity = Mathf.Lerp(1, 1, var_395_37)
				end
			end

			if arg_392_1.time_ >= var_395_34 + var_395_36 and arg_392_1.time_ < var_395_34 + var_395_36 + arg_395_0 then
				local var_395_39 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_395_39 then
					var_395_39.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_395_39.radialBlurScale = 0.143
					var_395_39.radialBlurGradient = 1
					var_395_39.radialBlurIntensity = 1
				end
			end

			if arg_392_1.frameCnt_ <= 1 then
				arg_392_1.dialog_:SetActive(false)
			end

			local var_395_40 = 2.5760286316586
			local var_395_41 = 0.05

			if var_395_40 < arg_392_1.time_ and arg_392_1.time_ <= var_395_40 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0

				arg_392_1.dialog_:SetActive(true)

				arg_392_1.dialogCg_.alpha = 0

				local var_395_42 = LeanTween.value(arg_392_1.dialog_, 0, 1, 0.3)

				var_395_42:setOnUpdate(LuaHelper.FloatAction(function(arg_396_0)
					arg_392_1.dialogCg_.alpha = arg_396_0
				end))
				var_395_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_392_1.dialog_)
					var_395_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_392_1.duration_ = arg_392_1.duration_ + 0.3

				SetActive(arg_392_1.leftNameGo_, false)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_43 = arg_392_1:GetWordFromCfg(319801090)
				local var_395_44 = arg_392_1:FormatText(var_395_43.content)

				arg_392_1.text_.text = var_395_44

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_45 = 2
				local var_395_46 = utf8.len(var_395_44)
				local var_395_47 = var_395_45 <= 0 and var_395_41 or var_395_41 * (var_395_46 / var_395_45)

				if var_395_47 > 0 and var_395_41 < var_395_47 then
					arg_392_1.talkMaxDuration = var_395_47
					var_395_40 = var_395_40 + 0.3

					if var_395_47 + var_395_40 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_47 + var_395_40
					end
				end

				arg_392_1.text_.text = var_395_44
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_48 = var_395_40 + 0.3
			local var_395_49 = math.max(var_395_41, arg_392_1.talkMaxDuration)

			if var_395_48 <= arg_392_1.time_ and arg_392_1.time_ < var_395_48 + var_395_49 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_48) / var_395_49

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_48 + var_395_49 and arg_392_1.time_ < var_395_48 + var_395_49 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play319801091 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 319801091
		arg_398_1.duration_ = 1.73

		local var_398_0 = {
			zh = 1.733,
			ja = 1.466
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
			arg_398_1.auto_ = false
		end

		function arg_398_1.playNext_(arg_400_0)
			arg_398_1.onStoryFinished_()
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.1

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[640].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_3 = arg_398_1:GetWordFromCfg(319801091)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 4
				local var_401_6 = utf8.len(var_401_4)
				local var_401_7 = var_401_5 <= 0 and var_401_1 or var_401_1 * (var_401_6 / var_401_5)

				if var_401_7 > 0 and var_401_1 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801091", "story_v_out_319801.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801091", "story_v_out_319801.awb") / 1000

					if var_401_8 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_0
					end

					if var_401_3.prefab_name ~= "" and arg_398_1.actors_[var_401_3.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_3.prefab_name].transform, "story_v_out_319801", "319801091", "story_v_out_319801.awb")

						arg_398_1:RecordAudio("319801091", var_401_9)
						arg_398_1:RecordAudio("319801091", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_319801", "319801091", "story_v_out_319801.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_319801", "319801091", "story_v_out_319801.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_10 and arg_398_1.time_ < var_401_0 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST72a",
		"TextureConfig/Background/ST71a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ML0204",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_319801.awb"
	}
}
