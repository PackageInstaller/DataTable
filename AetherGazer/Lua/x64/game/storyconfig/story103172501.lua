return {
	Play317251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317251001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K11f"

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
				local var_4_5 = arg_1_1.bgs_.K11f

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
					if iter_4_0 ~= "K11f" then
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
			local var_4_23 = 0.6

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

			local var_4_28 = 0.733333333333333
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
			local var_4_35 = 0.825

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

				local var_4_37 = arg_1_1:GetWordFromCfg(317251001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 32
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
	Play317251002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317251002
		arg_9_1.duration_ = 5.83

		local var_9_0 = {
			zh = 5.833,
			ja = 5.1
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
				arg_9_0:Play317251003(arg_9_1)
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
			local var_12_20 = 0.65

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_21 = arg_9_1:FormatText(StoryNameCfg[530].name)

				arg_9_1.leftNameTxt_.text = var_12_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_22 = arg_9_1:GetWordFromCfg(317251002)
				local var_12_23 = arg_9_1:FormatText(var_12_22.content)

				arg_9_1.text_.text = var_12_23

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_24 = 26
				local var_12_25 = utf8.len(var_12_23)
				local var_12_26 = var_12_24 <= 0 and var_12_20 or var_12_20 * (var_12_25 / var_12_24)

				if var_12_26 > 0 and var_12_20 < var_12_26 then
					arg_9_1.talkMaxDuration = var_12_26

					if var_12_26 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_26 + var_12_19
					end
				end

				arg_9_1.text_.text = var_12_23
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251002", "story_v_out_317251.awb") ~= 0 then
					local var_12_27 = manager.audio:GetVoiceLength("story_v_out_317251", "317251002", "story_v_out_317251.awb") / 1000

					if var_12_27 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_19
					end

					if var_12_22.prefab_name ~= "" and arg_9_1.actors_[var_12_22.prefab_name] ~= nil then
						local var_12_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_22.prefab_name].transform, "story_v_out_317251", "317251002", "story_v_out_317251.awb")

						arg_9_1:RecordAudio("317251002", var_12_28)
						arg_9_1:RecordAudio("317251002", var_12_28)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_317251", "317251002", "story_v_out_317251.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_317251", "317251002", "story_v_out_317251.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_29 = math.max(var_12_20, arg_9_1.talkMaxDuration)

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_29 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_19) / var_12_29

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_19 + var_12_29 and arg_9_1.time_ < var_12_19 + var_12_29 + arg_12_0 then
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
	Play317251003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317251003
		arg_13_1.duration_ = 3.43

		local var_13_0 = {
			zh = 3.433,
			ja = 3.133
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
				arg_13_0:Play317251004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "2078ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "2078ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["2078ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos2078ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -1.28, -5.6)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos2078ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["2078ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect2078ui_story == nil then
				arg_13_1.var_.characterEffect2078ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect2078ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect2078ui_story then
				arg_13_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_20 = arg_13_1.actors_["2079ui_story"].transform
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.var_.moveOldPos2079ui_story = var_16_20.localPosition
			end

			local var_16_22 = 0.001

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_21) / var_16_22
				local var_16_24 = Vector3.New(0, 100, 0)

				var_16_20.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos2079ui_story, var_16_24, var_16_23)

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

			local var_16_29 = 0
			local var_16_30 = 0.375

			if var_16_29 < arg_13_1.time_ and arg_13_1.time_ <= var_16_29 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_31 = arg_13_1:FormatText(StoryNameCfg[528].name)

				arg_13_1.leftNameTxt_.text = var_16_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_32 = arg_13_1:GetWordFromCfg(317251003)
				local var_16_33 = arg_13_1:FormatText(var_16_32.content)

				arg_13_1.text_.text = var_16_33

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_34 = 15
				local var_16_35 = utf8.len(var_16_33)
				local var_16_36 = var_16_34 <= 0 and var_16_30 or var_16_30 * (var_16_35 / var_16_34)

				if var_16_36 > 0 and var_16_30 < var_16_36 then
					arg_13_1.talkMaxDuration = var_16_36

					if var_16_36 + var_16_29 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_36 + var_16_29
					end
				end

				arg_13_1.text_.text = var_16_33
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251003", "story_v_out_317251.awb") ~= 0 then
					local var_16_37 = manager.audio:GetVoiceLength("story_v_out_317251", "317251003", "story_v_out_317251.awb") / 1000

					if var_16_37 + var_16_29 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_37 + var_16_29
					end

					if var_16_32.prefab_name ~= "" and arg_13_1.actors_[var_16_32.prefab_name] ~= nil then
						local var_16_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_32.prefab_name].transform, "story_v_out_317251", "317251003", "story_v_out_317251.awb")

						arg_13_1:RecordAudio("317251003", var_16_38)
						arg_13_1:RecordAudio("317251003", var_16_38)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317251", "317251003", "story_v_out_317251.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317251", "317251003", "story_v_out_317251.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_39 = math.max(var_16_30, arg_13_1.talkMaxDuration)

			if var_16_29 <= arg_13_1.time_ and arg_13_1.time_ < var_16_29 + var_16_39 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_29) / var_16_39

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_29 + var_16_39 and arg_13_1.time_ < var_16_29 + var_16_39 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_13_1:InitPlayNodeList()
	end,
	Play317251004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317251004
		arg_17_1.duration_ = 5.2

		local var_17_0 = {
			zh = 5.2,
			ja = 4.833
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
				arg_17_0:Play317251005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["2079ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos2079ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -1.28, -5.6)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos2079ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["2079ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect2079ui_story == nil then
				arg_17_1.var_.characterEffect2079ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect2079ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect2079ui_story then
				arg_17_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_20_14 = arg_17_1.actors_["2078ui_story"].transform
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.var_.moveOldPos2078ui_story = var_20_14.localPosition
			end

			local var_20_16 = 0.001

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16
				local var_20_18 = Vector3.New(0, 100, 0)

				var_20_14.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos2078ui_story, var_20_18, var_20_17)

				local var_20_19 = manager.ui.mainCamera.transform.position - var_20_14.position

				var_20_14.forward = Vector3.New(var_20_19.x, var_20_19.y, var_20_19.z)

				local var_20_20 = var_20_14.localEulerAngles

				var_20_20.z = 0
				var_20_20.x = 0
				var_20_14.localEulerAngles = var_20_20
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 then
				var_20_14.localPosition = Vector3.New(0, 100, 0)

				local var_20_21 = manager.ui.mainCamera.transform.position - var_20_14.position

				var_20_14.forward = Vector3.New(var_20_21.x, var_20_21.y, var_20_21.z)

				local var_20_22 = var_20_14.localEulerAngles

				var_20_22.z = 0
				var_20_22.x = 0
				var_20_14.localEulerAngles = var_20_22
			end

			local var_20_23 = 0
			local var_20_24 = 0.475

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_25 = arg_17_1:FormatText(StoryNameCfg[530].name)

				arg_17_1.leftNameTxt_.text = var_20_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_26 = arg_17_1:GetWordFromCfg(317251004)
				local var_20_27 = arg_17_1:FormatText(var_20_26.content)

				arg_17_1.text_.text = var_20_27

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_28 = 19
				local var_20_29 = utf8.len(var_20_27)
				local var_20_30 = var_20_28 <= 0 and var_20_24 or var_20_24 * (var_20_29 / var_20_28)

				if var_20_30 > 0 and var_20_24 < var_20_30 then
					arg_17_1.talkMaxDuration = var_20_30

					if var_20_30 + var_20_23 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_30 + var_20_23
					end
				end

				arg_17_1.text_.text = var_20_27
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251004", "story_v_out_317251.awb") ~= 0 then
					local var_20_31 = manager.audio:GetVoiceLength("story_v_out_317251", "317251004", "story_v_out_317251.awb") / 1000

					if var_20_31 + var_20_23 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_31 + var_20_23
					end

					if var_20_26.prefab_name ~= "" and arg_17_1.actors_[var_20_26.prefab_name] ~= nil then
						local var_20_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_26.prefab_name].transform, "story_v_out_317251", "317251004", "story_v_out_317251.awb")

						arg_17_1:RecordAudio("317251004", var_20_32)
						arg_17_1:RecordAudio("317251004", var_20_32)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317251", "317251004", "story_v_out_317251.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317251", "317251004", "story_v_out_317251.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_33 = math.max(var_20_24, arg_17_1.talkMaxDuration)

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_33 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_23) / var_20_33

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_23 + var_20_33 and arg_17_1.time_ < var_20_23 + var_20_33 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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
				actorName = "2078ui_story",
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
	Play317251005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317251005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play317251006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["2079ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos2079ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos2079ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, 100, 0)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = 0
			local var_24_10 = 0.75

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_11 = arg_21_1:GetWordFromCfg(317251005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 30
				local var_24_14 = utf8.len(var_24_12)
				local var_24_15 = var_24_13 <= 0 and var_24_10 or var_24_10 * (var_24_14 / var_24_13)

				if var_24_15 > 0 and var_24_10 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_9 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_9
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_10, arg_21_1.talkMaxDuration)

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_9) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_9 + var_24_16 and arg_21_1.time_ < var_24_9 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play317251006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317251006
		arg_25_1.duration_ = 3.07

		local var_25_0 = {
			zh = 2.733,
			ja = 3.066
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
				arg_25_0:Play317251007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["2078ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos2078ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos2078ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["2078ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect2078ui_story == nil then
				arg_25_1.var_.characterEffect2078ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect2078ui_story and not isNil(var_28_9) then
					local var_28_13 = Mathf.Lerp(0, 0.5, var_28_12)

					arg_25_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_25_1.var_.characterEffect2078ui_story.fillRatio = var_28_13
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect2078ui_story then
				local var_28_14 = 0.5

				arg_25_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_25_1.var_.characterEffect2078ui_story.fillRatio = var_28_14
			end

			local var_28_15 = arg_25_1.actors_["2079ui_story"].transform
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.var_.moveOldPos2079ui_story = var_28_15.localPosition
			end

			local var_28_17 = 0.001

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17
				local var_28_19 = Vector3.New(0, -1.28, -5.6)

				var_28_15.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos2079ui_story, var_28_19, var_28_18)

				local var_28_20 = manager.ui.mainCamera.transform.position - var_28_15.position

				var_28_15.forward = Vector3.New(var_28_20.x, var_28_20.y, var_28_20.z)

				local var_28_21 = var_28_15.localEulerAngles

				var_28_21.z = 0
				var_28_21.x = 0
				var_28_15.localEulerAngles = var_28_21
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 then
				var_28_15.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_28_22 = manager.ui.mainCamera.transform.position - var_28_15.position

				var_28_15.forward = Vector3.New(var_28_22.x, var_28_22.y, var_28_22.z)

				local var_28_23 = var_28_15.localEulerAngles

				var_28_23.z = 0
				var_28_23.x = 0
				var_28_15.localEulerAngles = var_28_23
			end

			local var_28_24 = arg_25_1.actors_["2079ui_story"]
			local var_28_25 = 0

			if var_28_25 < arg_25_1.time_ and arg_25_1.time_ <= var_28_25 + arg_28_0 and not isNil(var_28_24) and arg_25_1.var_.characterEffect2079ui_story == nil then
				arg_25_1.var_.characterEffect2079ui_story = var_28_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_26 = 0.200000002980232

			if var_28_25 <= arg_25_1.time_ and arg_25_1.time_ < var_28_25 + var_28_26 and not isNil(var_28_24) then
				local var_28_27 = (arg_25_1.time_ - var_28_25) / var_28_26

				if arg_25_1.var_.characterEffect2079ui_story and not isNil(var_28_24) then
					arg_25_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_25 + var_28_26 and arg_25_1.time_ < var_28_25 + var_28_26 + arg_28_0 and not isNil(var_28_24) and arg_25_1.var_.characterEffect2079ui_story then
				arg_25_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_28_28 = 0

			if var_28_28 < arg_25_1.time_ and arg_25_1.time_ <= var_28_28 + arg_28_0 then
				arg_25_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_28_29 = 0

			if var_28_29 < arg_25_1.time_ and arg_25_1.time_ <= var_28_29 + arg_28_0 then
				arg_25_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_30 = 0
			local var_28_31 = 0.3

			if var_28_30 < arg_25_1.time_ and arg_25_1.time_ <= var_28_30 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_32 = arg_25_1:FormatText(StoryNameCfg[529].name)

				arg_25_1.leftNameTxt_.text = var_28_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_33 = arg_25_1:GetWordFromCfg(317251006)
				local var_28_34 = arg_25_1:FormatText(var_28_33.content)

				arg_25_1.text_.text = var_28_34

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_35 = 12
				local var_28_36 = utf8.len(var_28_34)
				local var_28_37 = var_28_35 <= 0 and var_28_31 or var_28_31 * (var_28_36 / var_28_35)

				if var_28_37 > 0 and var_28_31 < var_28_37 then
					arg_25_1.talkMaxDuration = var_28_37

					if var_28_37 + var_28_30 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_37 + var_28_30
					end
				end

				arg_25_1.text_.text = var_28_34
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251006", "story_v_out_317251.awb") ~= 0 then
					local var_28_38 = manager.audio:GetVoiceLength("story_v_out_317251", "317251006", "story_v_out_317251.awb") / 1000

					if var_28_38 + var_28_30 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_38 + var_28_30
					end

					if var_28_33.prefab_name ~= "" and arg_25_1.actors_[var_28_33.prefab_name] ~= nil then
						local var_28_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_33.prefab_name].transform, "story_v_out_317251", "317251006", "story_v_out_317251.awb")

						arg_25_1:RecordAudio("317251006", var_28_39)
						arg_25_1:RecordAudio("317251006", var_28_39)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317251", "317251006", "story_v_out_317251.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317251", "317251006", "story_v_out_317251.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_40 = math.max(var_28_31, arg_25_1.talkMaxDuration)

			if var_28_30 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_40 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_30) / var_28_40

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_30 + var_28_40 and arg_25_1.time_ < var_28_30 + var_28_40 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
	Play317251007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317251007
		arg_29_1.duration_ = 7.57

		local var_29_0 = {
			zh = 5.466,
			ja = 7.566
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
				arg_29_0:Play317251008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.725

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[529].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(317251007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 29
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251007", "story_v_out_317251.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_317251", "317251007", "story_v_out_317251.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_317251", "317251007", "story_v_out_317251.awb")

						arg_29_1:RecordAudio("317251007", var_32_9)
						arg_29_1:RecordAudio("317251007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317251", "317251007", "story_v_out_317251.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317251", "317251007", "story_v_out_317251.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play317251008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317251008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play317251009(arg_33_1)
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

			local var_36_9 = 0
			local var_36_10 = 0.6

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				local var_36_11 = "play"
				local var_36_12 = "music"

				arg_33_1:AudioAction(var_36_11, var_36_12, "ui_battle", "ui_battle_stopbgm", "")

				local var_36_13 = ""
				local var_36_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_36_14 ~= "" then
					if arg_33_1.bgmTxt_.text ~= var_36_14 and arg_33_1.bgmTxt_.text ~= "" then
						if arg_33_1.bgmTxt2_.text ~= "" then
							arg_33_1.bgmTxt_.text = arg_33_1.bgmTxt2_.text
						end

						arg_33_1.bgmTxt2_.text = var_36_14

						arg_33_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_33_1.bgmTxt_.text = var_36_14
						arg_33_1.bgmTxt2_.text = var_36_14
					end

					if arg_33_1.bgmTimer then
						arg_33_1.bgmTimer:Stop()

						arg_33_1.bgmTimer = nil
					end

					if arg_33_1.settingData.show_music_name == 1 then
						arg_33_1.musicController:SetSelectedState("show")
						arg_33_1.musicAnimator_:Play("open", 0, 0)

						if arg_33_1.settingData.music_time ~= 0 then
							arg_33_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_33_1.settingData.music_time), function()
								if arg_33_1 == nil or isNil(arg_33_1.bgmTxt_) then
									return
								end

								arg_33_1.musicController:SetSelectedState("hide")
								arg_33_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_36_15 = 0
			local var_36_16 = 0.775

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_17 = arg_33_1:GetWordFromCfg(317251008)
				local var_36_18 = arg_33_1:FormatText(var_36_17.content)

				arg_33_1.text_.text = var_36_18

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_19 = 31
				local var_36_20 = utf8.len(var_36_18)
				local var_36_21 = var_36_19 <= 0 and var_36_16 or var_36_16 * (var_36_20 / var_36_19)

				if var_36_21 > 0 and var_36_16 < var_36_21 then
					arg_33_1.talkMaxDuration = var_36_21

					if var_36_21 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_21 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_18
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_22 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_22 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_22

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_22 and arg_33_1.time_ < var_36_15 + var_36_22 + arg_36_0 then
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
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play317251009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 317251009
		arg_38_1.duration_ = 9

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play317251010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = "K12f"

			if arg_38_1.bgs_[var_41_0] == nil then
				local var_41_1 = Object.Instantiate(arg_38_1.paintGo_)

				var_41_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_41_0)
				var_41_1.name = var_41_0
				var_41_1.transform.parent = arg_38_1.stage_.transform
				var_41_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.bgs_[var_41_0] = var_41_1
			end

			local var_41_2 = 2

			if var_41_2 < arg_38_1.time_ and arg_38_1.time_ <= var_41_2 + arg_41_0 then
				local var_41_3 = manager.ui.mainCamera.transform.localPosition
				local var_41_4 = Vector3.New(0, 0, 10) + Vector3.New(var_41_3.x, var_41_3.y, 0)
				local var_41_5 = arg_38_1.bgs_.K12f

				var_41_5.transform.localPosition = var_41_4
				var_41_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_41_6 = var_41_5:GetComponent("SpriteRenderer")

				if var_41_6 and var_41_6.sprite then
					local var_41_7 = (var_41_5.transform.localPosition - var_41_3).z
					local var_41_8 = manager.ui.mainCameraCom_
					local var_41_9 = 2 * var_41_7 * Mathf.Tan(var_41_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_41_10 = var_41_9 * var_41_8.aspect
					local var_41_11 = var_41_6.sprite.bounds.size.x
					local var_41_12 = var_41_6.sprite.bounds.size.y
					local var_41_13 = var_41_10 / var_41_11
					local var_41_14 = var_41_9 / var_41_12
					local var_41_15 = var_41_14 < var_41_13 and var_41_13 or var_41_14

					var_41_5.transform.localScale = Vector3.New(var_41_15, var_41_15, 0)
				end

				for iter_41_0, iter_41_1 in pairs(arg_38_1.bgs_) do
					if iter_41_0 ~= "K12f" then
						iter_41_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_41_16 = 0

			if var_41_16 < arg_38_1.time_ and arg_38_1.time_ <= var_41_16 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_17 = 2

			if var_41_16 <= arg_38_1.time_ and arg_38_1.time_ < var_41_16 + var_41_17 then
				local var_41_18 = (arg_38_1.time_ - var_41_16) / var_41_17
				local var_41_19 = Color.New(0, 0, 0)

				var_41_19.a = Mathf.Lerp(0, 1, var_41_18)
				arg_38_1.mask_.color = var_41_19
			end

			if arg_38_1.time_ >= var_41_16 + var_41_17 and arg_38_1.time_ < var_41_16 + var_41_17 + arg_41_0 then
				local var_41_20 = Color.New(0, 0, 0)

				var_41_20.a = 1
				arg_38_1.mask_.color = var_41_20
			end

			local var_41_21 = 2

			if var_41_21 < arg_38_1.time_ and arg_38_1.time_ <= var_41_21 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_22 = 2

			if var_41_21 <= arg_38_1.time_ and arg_38_1.time_ < var_41_21 + var_41_22 then
				local var_41_23 = (arg_38_1.time_ - var_41_21) / var_41_22
				local var_41_24 = Color.New(0, 0, 0)

				var_41_24.a = Mathf.Lerp(1, 0, var_41_23)
				arg_38_1.mask_.color = var_41_24
			end

			if arg_38_1.time_ >= var_41_21 + var_41_22 and arg_38_1.time_ < var_41_21 + var_41_22 + arg_41_0 then
				local var_41_25 = Color.New(0, 0, 0)
				local var_41_26 = 0

				arg_38_1.mask_.enabled = false
				var_41_25.a = var_41_26
				arg_38_1.mask_.color = var_41_25
			end

			local var_41_27 = 0
			local var_41_28 = 1

			if var_41_27 < arg_38_1.time_ and arg_38_1.time_ <= var_41_27 + arg_41_0 then
				local var_41_29 = "play"
				local var_41_30 = "music"

				arg_38_1:AudioAction(var_41_29, var_41_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_41_31 = ""
				local var_41_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_41_32 ~= "" then
					if arg_38_1.bgmTxt_.text ~= var_41_32 and arg_38_1.bgmTxt_.text ~= "" then
						if arg_38_1.bgmTxt2_.text ~= "" then
							arg_38_1.bgmTxt_.text = arg_38_1.bgmTxt2_.text
						end

						arg_38_1.bgmTxt2_.text = var_41_32

						arg_38_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_38_1.bgmTxt_.text = var_41_32
						arg_38_1.bgmTxt2_.text = var_41_32
					end

					if arg_38_1.bgmTimer then
						arg_38_1.bgmTimer:Stop()

						arg_38_1.bgmTimer = nil
					end

					if arg_38_1.settingData.show_music_name == 1 then
						arg_38_1.musicController:SetSelectedState("show")
						arg_38_1.musicAnimator_:Play("open", 0, 0)

						if arg_38_1.settingData.music_time ~= 0 then
							arg_38_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_38_1.settingData.music_time), function()
								if arg_38_1 == nil or isNil(arg_38_1.bgmTxt_) then
									return
								end

								arg_38_1.musicController:SetSelectedState("hide")
								arg_38_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_41_33 = 3.55
			local var_41_34 = 1

			if var_41_33 < arg_38_1.time_ and arg_38_1.time_ <= var_41_33 + arg_41_0 then
				local var_41_35 = "play"
				local var_41_36 = "music"

				arg_38_1:AudioAction(var_41_35, var_41_36, "bgm_activity_2_6_story_biwuchang", "bgm_activity_2_6_story_biwuchang", "bgm_activity_2_6_story_biwuchang.awb")

				local var_41_37 = ""
				local var_41_38 = manager.audio:GetAudioName("bgm_activity_2_6_story_biwuchang", "bgm_activity_2_6_story_biwuchang")

				if var_41_38 ~= "" then
					if arg_38_1.bgmTxt_.text ~= var_41_38 and arg_38_1.bgmTxt_.text ~= "" then
						if arg_38_1.bgmTxt2_.text ~= "" then
							arg_38_1.bgmTxt_.text = arg_38_1.bgmTxt2_.text
						end

						arg_38_1.bgmTxt2_.text = var_41_38

						arg_38_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_38_1.bgmTxt_.text = var_41_38
						arg_38_1.bgmTxt2_.text = var_41_38
					end

					if arg_38_1.bgmTimer then
						arg_38_1.bgmTimer:Stop()

						arg_38_1.bgmTimer = nil
					end

					if arg_38_1.settingData.show_music_name == 1 then
						arg_38_1.musicController:SetSelectedState("show")
						arg_38_1.musicAnimator_:Play("open", 0, 0)

						if arg_38_1.settingData.music_time ~= 0 then
							arg_38_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_38_1.settingData.music_time), function()
								if arg_38_1 == nil or isNil(arg_38_1.bgmTxt_) then
									return
								end

								arg_38_1.musicController:SetSelectedState("hide")
								arg_38_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_38_1.frameCnt_ <= 1 then
				arg_38_1.dialog_:SetActive(false)
			end

			local var_41_39 = 4
			local var_41_40 = 0.55

			if var_41_39 < arg_38_1.time_ and arg_38_1.time_ <= var_41_39 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				arg_38_1.dialog_:SetActive(true)

				arg_38_1.dialogCg_.alpha = 0

				local var_41_41 = LeanTween.value(arg_38_1.dialog_, 0, 1, 0.3)

				var_41_41:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_38_1.dialogCg_.alpha = arg_44_0
				end))
				var_41_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_38_1.dialog_)
					var_41_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_38_1.duration_ = arg_38_1.duration_ + 0.3

				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_42 = arg_38_1:GetWordFromCfg(317251009)
				local var_41_43 = arg_38_1:FormatText(var_41_42.content)

				arg_38_1.text_.text = var_41_43

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_44 = 22
				local var_41_45 = utf8.len(var_41_43)
				local var_41_46 = var_41_44 <= 0 and var_41_40 or var_41_40 * (var_41_45 / var_41_44)

				if var_41_46 > 0 and var_41_40 < var_41_46 then
					arg_38_1.talkMaxDuration = var_41_46
					var_41_39 = var_41_39 + 0.3

					if var_41_46 + var_41_39 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_46 + var_41_39
					end
				end

				arg_38_1.text_.text = var_41_43
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_47 = var_41_39 + 0.3
			local var_41_48 = math.max(var_41_40, arg_38_1.talkMaxDuration)

			if var_41_47 <= arg_38_1.time_ and arg_38_1.time_ < var_41_47 + var_41_48 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_47) / var_41_48

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_47 + var_41_48 and arg_38_1.time_ < var_41_47 + var_41_48 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play317251010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 317251010
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play317251011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 1.325

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_2 = arg_46_1:GetWordFromCfg(317251010)
				local var_49_3 = arg_46_1:FormatText(var_49_2.content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 53
				local var_49_5 = utf8.len(var_49_3)
				local var_49_6 = var_49_4 <= 0 and var_49_1 or var_49_1 * (var_49_5 / var_49_4)

				if var_49_6 > 0 and var_49_1 < var_49_6 then
					arg_46_1.talkMaxDuration = var_49_6

					if var_49_6 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_7 and arg_46_1.time_ < var_49_0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play317251011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 317251011
		arg_50_1.duration_ = 2

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play317251012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = "1158ui_story"

			if arg_50_1.actors_[var_53_0] == nil then
				local var_53_1 = Asset.Load("Char/" .. "1158ui_story")

				if not isNil(var_53_1) then
					local var_53_2 = Object.Instantiate(Asset.Load("Char/" .. "1158ui_story"), arg_50_1.stage_.transform)

					var_53_2.name = var_53_0
					var_53_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_50_1.actors_[var_53_0] = var_53_2

					local var_53_3 = var_53_2:GetComponentInChildren(typeof(CharacterEffect))

					var_53_3.enabled = true

					local var_53_4 = GameObjectTools.GetOrAddComponent(var_53_2, typeof(DynamicBoneHelper))

					if var_53_4 then
						var_53_4:EnableDynamicBone(false)
					end

					arg_50_1:ShowWeapon(var_53_3.transform, false)

					arg_50_1.var_[var_53_0 .. "Animator"] = var_53_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_50_1.var_[var_53_0 .. "Animator"].applyRootMotion = true
					arg_50_1.var_[var_53_0 .. "LipSync"] = var_53_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_53_5 = arg_50_1.actors_["1158ui_story"].transform
			local var_53_6 = 0

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.var_.moveOldPos1158ui_story = var_53_5.localPosition
			end

			local var_53_7 = 0.001

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_7 then
				local var_53_8 = (arg_50_1.time_ - var_53_6) / var_53_7
				local var_53_9 = Vector3.New(0, -0.95, -6)

				var_53_5.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1158ui_story, var_53_9, var_53_8)

				local var_53_10 = manager.ui.mainCamera.transform.position - var_53_5.position

				var_53_5.forward = Vector3.New(var_53_10.x, var_53_10.y, var_53_10.z)

				local var_53_11 = var_53_5.localEulerAngles

				var_53_11.z = 0
				var_53_11.x = 0
				var_53_5.localEulerAngles = var_53_11
			end

			if arg_50_1.time_ >= var_53_6 + var_53_7 and arg_50_1.time_ < var_53_6 + var_53_7 + arg_53_0 then
				var_53_5.localPosition = Vector3.New(0, -0.95, -6)

				local var_53_12 = manager.ui.mainCamera.transform.position - var_53_5.position

				var_53_5.forward = Vector3.New(var_53_12.x, var_53_12.y, var_53_12.z)

				local var_53_13 = var_53_5.localEulerAngles

				var_53_13.z = 0
				var_53_13.x = 0
				var_53_5.localEulerAngles = var_53_13
			end

			local var_53_14 = arg_50_1.actors_["1158ui_story"]
			local var_53_15 = 0

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 and not isNil(var_53_14) and arg_50_1.var_.characterEffect1158ui_story == nil then
				arg_50_1.var_.characterEffect1158ui_story = var_53_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_16 = 0.200000002980232

			if var_53_15 <= arg_50_1.time_ and arg_50_1.time_ < var_53_15 + var_53_16 and not isNil(var_53_14) then
				local var_53_17 = (arg_50_1.time_ - var_53_15) / var_53_16

				if arg_50_1.var_.characterEffect1158ui_story and not isNil(var_53_14) then
					arg_50_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_15 + var_53_16 and arg_50_1.time_ < var_53_15 + var_53_16 + arg_53_0 and not isNil(var_53_14) and arg_50_1.var_.characterEffect1158ui_story then
				arg_50_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			local var_53_18 = 0

			if var_53_18 < arg_50_1.time_ and arg_50_1.time_ <= var_53_18 + arg_53_0 then
				arg_50_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action1_1")
			end

			local var_53_19 = 0

			if var_53_19 < arg_50_1.time_ and arg_50_1.time_ <= var_53_19 + arg_53_0 then
				arg_50_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_53_20 = 0
			local var_53_21 = 0.175

			if var_53_20 < arg_50_1.time_ and arg_50_1.time_ <= var_53_20 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_22 = arg_50_1:FormatText(StoryNameCfg[92].name)

				arg_50_1.leftNameTxt_.text = var_53_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_23 = arg_50_1:GetWordFromCfg(317251011)
				local var_53_24 = arg_50_1:FormatText(var_53_23.content)

				arg_50_1.text_.text = var_53_24

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_25 = 7
				local var_53_26 = utf8.len(var_53_24)
				local var_53_27 = var_53_25 <= 0 and var_53_21 or var_53_21 * (var_53_26 / var_53_25)

				if var_53_27 > 0 and var_53_21 < var_53_27 then
					arg_50_1.talkMaxDuration = var_53_27

					if var_53_27 + var_53_20 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_27 + var_53_20
					end
				end

				arg_50_1.text_.text = var_53_24
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251011", "story_v_out_317251.awb") ~= 0 then
					local var_53_28 = manager.audio:GetVoiceLength("story_v_out_317251", "317251011", "story_v_out_317251.awb") / 1000

					if var_53_28 + var_53_20 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_28 + var_53_20
					end

					if var_53_23.prefab_name ~= "" and arg_50_1.actors_[var_53_23.prefab_name] ~= nil then
						local var_53_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_23.prefab_name].transform, "story_v_out_317251", "317251011", "story_v_out_317251.awb")

						arg_50_1:RecordAudio("317251011", var_53_29)
						arg_50_1:RecordAudio("317251011", var_53_29)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_317251", "317251011", "story_v_out_317251.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_317251", "317251011", "story_v_out_317251.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_30 = math.max(var_53_21, arg_50_1.talkMaxDuration)

			if var_53_20 <= arg_50_1.time_ and arg_50_1.time_ < var_53_20 + var_53_30 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_20) / var_53_30

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_20 + var_53_30 and arg_50_1.time_ < var_53_20 + var_53_30 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play317251012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 317251012
		arg_54_1.duration_ = 2.87

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play317251013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = "ST58"

			if arg_54_1.bgs_[var_57_0] == nil then
				local var_57_1 = Object.Instantiate(arg_54_1.paintGo_)

				var_57_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_57_0)
				var_57_1.name = var_57_0
				var_57_1.transform.parent = arg_54_1.stage_.transform
				var_57_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.bgs_[var_57_0] = var_57_1
			end

			local var_57_2 = 0

			if var_57_2 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				local var_57_3 = manager.ui.mainCamera.transform.localPosition
				local var_57_4 = Vector3.New(0, 0, 10) + Vector3.New(var_57_3.x, var_57_3.y, 0)
				local var_57_5 = arg_54_1.bgs_.ST58

				var_57_5.transform.localPosition = var_57_4
				var_57_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_57_6 = var_57_5:GetComponent("SpriteRenderer")

				if var_57_6 and var_57_6.sprite then
					local var_57_7 = (var_57_5.transform.localPosition - var_57_3).z
					local var_57_8 = manager.ui.mainCameraCom_
					local var_57_9 = 2 * var_57_7 * Mathf.Tan(var_57_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_57_10 = var_57_9 * var_57_8.aspect
					local var_57_11 = var_57_6.sprite.bounds.size.x
					local var_57_12 = var_57_6.sprite.bounds.size.y
					local var_57_13 = var_57_10 / var_57_11
					local var_57_14 = var_57_9 / var_57_12
					local var_57_15 = var_57_14 < var_57_13 and var_57_13 or var_57_14

					var_57_5.transform.localScale = Vector3.New(var_57_15, var_57_15, 0)
				end

				for iter_57_0, iter_57_1 in pairs(arg_54_1.bgs_) do
					if iter_57_0 ~= "ST58" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_16 = arg_54_1.actors_["1158ui_story"].transform
			local var_57_17 = 0

			if var_57_17 < arg_54_1.time_ and arg_54_1.time_ <= var_57_17 + arg_57_0 then
				arg_54_1.var_.moveOldPos1158ui_story = var_57_16.localPosition
			end

			local var_57_18 = 0.001

			if var_57_17 <= arg_54_1.time_ and arg_54_1.time_ < var_57_17 + var_57_18 then
				local var_57_19 = (arg_54_1.time_ - var_57_17) / var_57_18
				local var_57_20 = Vector3.New(0, 100, 0)

				var_57_16.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1158ui_story, var_57_20, var_57_19)

				local var_57_21 = manager.ui.mainCamera.transform.position - var_57_16.position

				var_57_16.forward = Vector3.New(var_57_21.x, var_57_21.y, var_57_21.z)

				local var_57_22 = var_57_16.localEulerAngles

				var_57_22.z = 0
				var_57_22.x = 0
				var_57_16.localEulerAngles = var_57_22
			end

			if arg_54_1.time_ >= var_57_17 + var_57_18 and arg_54_1.time_ < var_57_17 + var_57_18 + arg_57_0 then
				var_57_16.localPosition = Vector3.New(0, 100, 0)

				local var_57_23 = manager.ui.mainCamera.transform.position - var_57_16.position

				var_57_16.forward = Vector3.New(var_57_23.x, var_57_23.y, var_57_23.z)

				local var_57_24 = var_57_16.localEulerAngles

				var_57_24.z = 0
				var_57_24.x = 0
				var_57_16.localEulerAngles = var_57_24
			end

			local var_57_25 = arg_54_1.actors_["1158ui_story"]
			local var_57_26 = 0

			if var_57_26 < arg_54_1.time_ and arg_54_1.time_ <= var_57_26 + arg_57_0 and not isNil(var_57_25) and arg_54_1.var_.characterEffect1158ui_story == nil then
				arg_54_1.var_.characterEffect1158ui_story = var_57_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_27 = 0.200000002980232

			if var_57_26 <= arg_54_1.time_ and arg_54_1.time_ < var_57_26 + var_57_27 and not isNil(var_57_25) then
				local var_57_28 = (arg_54_1.time_ - var_57_26) / var_57_27

				if arg_54_1.var_.characterEffect1158ui_story and not isNil(var_57_25) then
					local var_57_29 = Mathf.Lerp(0, 0.5, var_57_28)

					arg_54_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1158ui_story.fillRatio = var_57_29
				end
			end

			if arg_54_1.time_ >= var_57_26 + var_57_27 and arg_54_1.time_ < var_57_26 + var_57_27 + arg_57_0 and not isNil(var_57_25) and arg_54_1.var_.characterEffect1158ui_story then
				local var_57_30 = 0.5

				arg_54_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1158ui_story.fillRatio = var_57_30
			end

			local var_57_31 = "1049ui_story"

			if arg_54_1.actors_[var_57_31] == nil then
				local var_57_32 = Asset.Load("Char/" .. "1049ui_story")

				if not isNil(var_57_32) then
					local var_57_33 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_54_1.stage_.transform)

					var_57_33.name = var_57_31
					var_57_33.transform.localPosition = Vector3.New(0, 100, 0)
					arg_54_1.actors_[var_57_31] = var_57_33

					local var_57_34 = var_57_33:GetComponentInChildren(typeof(CharacterEffect))

					var_57_34.enabled = true

					local var_57_35 = GameObjectTools.GetOrAddComponent(var_57_33, typeof(DynamicBoneHelper))

					if var_57_35 then
						var_57_35:EnableDynamicBone(false)
					end

					arg_54_1:ShowWeapon(var_57_34.transform, false)

					arg_54_1.var_[var_57_31 .. "Animator"] = var_57_34.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_54_1.var_[var_57_31 .. "Animator"].applyRootMotion = true
					arg_54_1.var_[var_57_31 .. "LipSync"] = var_57_34.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_57_36 = arg_54_1.actors_["1049ui_story"].transform
			local var_57_37 = 0

			if var_57_37 < arg_54_1.time_ and arg_54_1.time_ <= var_57_37 + arg_57_0 then
				arg_54_1.var_.moveOldPos1049ui_story = var_57_36.localPosition
			end

			local var_57_38 = 0.001

			if var_57_37 <= arg_54_1.time_ and arg_54_1.time_ < var_57_37 + var_57_38 then
				local var_57_39 = (arg_54_1.time_ - var_57_37) / var_57_38
				local var_57_40 = Vector3.New(0, -1.2, -6)

				var_57_36.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1049ui_story, var_57_40, var_57_39)

				local var_57_41 = manager.ui.mainCamera.transform.position - var_57_36.position

				var_57_36.forward = Vector3.New(var_57_41.x, var_57_41.y, var_57_41.z)

				local var_57_42 = var_57_36.localEulerAngles

				var_57_42.z = 0
				var_57_42.x = 0
				var_57_36.localEulerAngles = var_57_42
			end

			if arg_54_1.time_ >= var_57_37 + var_57_38 and arg_54_1.time_ < var_57_37 + var_57_38 + arg_57_0 then
				var_57_36.localPosition = Vector3.New(0, -1.2, -6)

				local var_57_43 = manager.ui.mainCamera.transform.position - var_57_36.position

				var_57_36.forward = Vector3.New(var_57_43.x, var_57_43.y, var_57_43.z)

				local var_57_44 = var_57_36.localEulerAngles

				var_57_44.z = 0
				var_57_44.x = 0
				var_57_36.localEulerAngles = var_57_44
			end

			local var_57_45 = arg_54_1.actors_["1049ui_story"]
			local var_57_46 = 0

			if var_57_46 < arg_54_1.time_ and arg_54_1.time_ <= var_57_46 + arg_57_0 and not isNil(var_57_45) and arg_54_1.var_.characterEffect1049ui_story == nil then
				arg_54_1.var_.characterEffect1049ui_story = var_57_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_47 = 0.200000002980232

			if var_57_46 <= arg_54_1.time_ and arg_54_1.time_ < var_57_46 + var_57_47 and not isNil(var_57_45) then
				local var_57_48 = (arg_54_1.time_ - var_57_46) / var_57_47

				if arg_54_1.var_.characterEffect1049ui_story and not isNil(var_57_45) then
					arg_54_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_46 + var_57_47 and arg_54_1.time_ < var_57_46 + var_57_47 + arg_57_0 and not isNil(var_57_45) and arg_54_1.var_.characterEffect1049ui_story then
				arg_54_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_57_49 = 0

			if var_57_49 < arg_54_1.time_ and arg_54_1.time_ <= var_57_49 + arg_57_0 then
				arg_54_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_57_50 = 0

			if var_57_50 < arg_54_1.time_ and arg_54_1.time_ <= var_57_50 + arg_57_0 then
				arg_54_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_57_51 = 0

			if var_57_51 < arg_54_1.time_ and arg_54_1.time_ <= var_57_51 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_52 = 1

			if var_57_51 <= arg_54_1.time_ and arg_54_1.time_ < var_57_51 + var_57_52 then
				local var_57_53 = (arg_54_1.time_ - var_57_51) / var_57_52
				local var_57_54 = Color.New(1, 1, 1)

				var_57_54.a = Mathf.Lerp(1, 0, var_57_53)
				arg_54_1.mask_.color = var_57_54
			end

			if arg_54_1.time_ >= var_57_51 + var_57_52 and arg_54_1.time_ < var_57_51 + var_57_52 + arg_57_0 then
				local var_57_55 = Color.New(1, 1, 1)
				local var_57_56 = 0

				arg_54_1.mask_.enabled = false
				var_57_55.a = var_57_56
				arg_54_1.mask_.color = var_57_55
			end

			local var_57_57 = 0

			arg_54_1.isInRecall_ = false

			if var_57_57 < arg_54_1.time_ and arg_54_1.time_ <= var_57_57 + arg_57_0 then
				arg_54_1.screenFilterGo_:SetActive(true)

				arg_54_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_57_2, iter_57_3 in pairs(arg_54_1.actors_) do
					local var_57_58 = iter_57_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_57_4, iter_57_5 in ipairs(var_57_58) do
						if iter_57_5.color.r > 0.51 then
							iter_57_5.color = Color.New(1, 1, 1)
						else
							iter_57_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_57_59 = 0.0166666666666667

			if var_57_57 <= arg_54_1.time_ and arg_54_1.time_ < var_57_57 + var_57_59 then
				local var_57_60 = (arg_54_1.time_ - var_57_57) / var_57_59

				arg_54_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_57_60)
			end

			if arg_54_1.time_ >= var_57_57 + var_57_59 and arg_54_1.time_ < var_57_57 + var_57_59 + arg_57_0 then
				arg_54_1.screenFilterEffect_.weight = 1
			end

			if arg_54_1.frameCnt_ <= 1 then
				arg_54_1.dialog_:SetActive(false)
			end

			local var_57_61 = 1
			local var_57_62 = 0.175

			if var_57_61 < arg_54_1.time_ and arg_54_1.time_ <= var_57_61 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				arg_54_1.dialog_:SetActive(true)

				arg_54_1.dialogCg_.alpha = 0

				local var_57_63 = LeanTween.value(arg_54_1.dialog_, 0, 1, 0.3)

				var_57_63:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_54_1.dialogCg_.alpha = arg_58_0
				end))
				var_57_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_54_1.dialog_)
					var_57_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_54_1.duration_ = arg_54_1.duration_ + 0.3

				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_64 = arg_54_1:FormatText(StoryNameCfg[562].name)

				arg_54_1.leftNameTxt_.text = var_57_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_65 = arg_54_1:GetWordFromCfg(317251012)
				local var_57_66 = arg_54_1:FormatText(var_57_65.content)

				arg_54_1.text_.text = var_57_66

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_67 = 7
				local var_57_68 = utf8.len(var_57_66)
				local var_57_69 = var_57_67 <= 0 and var_57_62 or var_57_62 * (var_57_68 / var_57_67)

				if var_57_69 > 0 and var_57_62 < var_57_69 then
					arg_54_1.talkMaxDuration = var_57_69
					var_57_61 = var_57_61 + 0.3

					if var_57_69 + var_57_61 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_69 + var_57_61
					end
				end

				arg_54_1.text_.text = var_57_66
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251012", "story_v_out_317251.awb") ~= 0 then
					local var_57_70 = manager.audio:GetVoiceLength("story_v_out_317251", "317251012", "story_v_out_317251.awb") / 1000

					if var_57_70 + var_57_61 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_70 + var_57_61
					end

					if var_57_65.prefab_name ~= "" and arg_54_1.actors_[var_57_65.prefab_name] ~= nil then
						local var_57_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_65.prefab_name].transform, "story_v_out_317251", "317251012", "story_v_out_317251.awb")

						arg_54_1:RecordAudio("317251012", var_57_71)
						arg_54_1:RecordAudio("317251012", var_57_71)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_317251", "317251012", "story_v_out_317251.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_317251", "317251012", "story_v_out_317251.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_72 = var_57_61 + 0.3
			local var_57_73 = math.max(var_57_62, arg_54_1.talkMaxDuration)

			if var_57_72 <= arg_54_1.time_ and arg_54_1.time_ < var_57_72 + var_57_73 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_72) / var_57_73

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_72 + var_57_73 and arg_54_1.time_ < var_57_72 + var_57_73 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
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

		arg_54_1:InitPlayNodeList()
	end,
	Play317251013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 317251013
		arg_60_1.duration_ = 2.07

		local var_60_0 = {
			zh = 2.066,
			ja = 1.999999999999
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play317251014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1158ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1158ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0, -0.95, -6)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1158ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, -0.95, -6)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = arg_60_1.actors_["1158ui_story"]
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1158ui_story == nil then
				arg_60_1.var_.characterEffect1158ui_story = var_63_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 and not isNil(var_63_9) then
				local var_63_12 = (arg_60_1.time_ - var_63_10) / var_63_11

				if arg_60_1.var_.characterEffect1158ui_story and not isNil(var_63_9) then
					arg_60_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1158ui_story then
				arg_60_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			local var_63_13 = 0

			if var_63_13 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action1_1")
			end

			local var_63_14 = 0

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_63_15 = arg_60_1.actors_["1049ui_story"].transform
			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.var_.moveOldPos1049ui_story = var_63_15.localPosition
			end

			local var_63_17 = 0.001

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_17 then
				local var_63_18 = (arg_60_1.time_ - var_63_16) / var_63_17
				local var_63_19 = Vector3.New(0, 100, 0)

				var_63_15.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1049ui_story, var_63_19, var_63_18)

				local var_63_20 = manager.ui.mainCamera.transform.position - var_63_15.position

				var_63_15.forward = Vector3.New(var_63_20.x, var_63_20.y, var_63_20.z)

				local var_63_21 = var_63_15.localEulerAngles

				var_63_21.z = 0
				var_63_21.x = 0
				var_63_15.localEulerAngles = var_63_21
			end

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 then
				var_63_15.localPosition = Vector3.New(0, 100, 0)

				local var_63_22 = manager.ui.mainCamera.transform.position - var_63_15.position

				var_63_15.forward = Vector3.New(var_63_22.x, var_63_22.y, var_63_22.z)

				local var_63_23 = var_63_15.localEulerAngles

				var_63_23.z = 0
				var_63_23.x = 0
				var_63_15.localEulerAngles = var_63_23
			end

			local var_63_24 = arg_60_1.actors_["1049ui_story"]
			local var_63_25 = 0

			if var_63_25 < arg_60_1.time_ and arg_60_1.time_ <= var_63_25 + arg_63_0 and not isNil(var_63_24) and arg_60_1.var_.characterEffect1049ui_story == nil then
				arg_60_1.var_.characterEffect1049ui_story = var_63_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_26 = 0.200000002980232

			if var_63_25 <= arg_60_1.time_ and arg_60_1.time_ < var_63_25 + var_63_26 and not isNil(var_63_24) then
				local var_63_27 = (arg_60_1.time_ - var_63_25) / var_63_26

				if arg_60_1.var_.characterEffect1049ui_story and not isNil(var_63_24) then
					local var_63_28 = Mathf.Lerp(0, 0.5, var_63_27)

					arg_60_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1049ui_story.fillRatio = var_63_28
				end
			end

			if arg_60_1.time_ >= var_63_25 + var_63_26 and arg_60_1.time_ < var_63_25 + var_63_26 + arg_63_0 and not isNil(var_63_24) and arg_60_1.var_.characterEffect1049ui_story then
				local var_63_29 = 0.5

				arg_60_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1049ui_story.fillRatio = var_63_29
			end

			local var_63_30 = 0

			if var_63_30 < arg_60_1.time_ and arg_60_1.time_ <= var_63_30 + arg_63_0 then
				local var_63_31 = manager.ui.mainCamera.transform.localPosition
				local var_63_32 = Vector3.New(0, 0, 10) + Vector3.New(var_63_31.x, var_63_31.y, 0)
				local var_63_33 = arg_60_1.bgs_.K12f

				var_63_33.transform.localPosition = var_63_32
				var_63_33.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_34 = var_63_33:GetComponent("SpriteRenderer")

				if var_63_34 and var_63_34.sprite then
					local var_63_35 = (var_63_33.transform.localPosition - var_63_31).z
					local var_63_36 = manager.ui.mainCameraCom_
					local var_63_37 = 2 * var_63_35 * Mathf.Tan(var_63_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_63_38 = var_63_37 * var_63_36.aspect
					local var_63_39 = var_63_34.sprite.bounds.size.x
					local var_63_40 = var_63_34.sprite.bounds.size.y
					local var_63_41 = var_63_38 / var_63_39
					local var_63_42 = var_63_37 / var_63_40
					local var_63_43 = var_63_42 < var_63_41 and var_63_41 or var_63_42

					var_63_33.transform.localScale = Vector3.New(var_63_43, var_63_43, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "K12f" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_44 = 0

			if var_63_44 < arg_60_1.time_ and arg_60_1.time_ <= var_63_44 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_45 = 1

			if var_63_44 <= arg_60_1.time_ and arg_60_1.time_ < var_63_44 + var_63_45 then
				local var_63_46 = (arg_60_1.time_ - var_63_44) / var_63_45
				local var_63_47 = Color.New(1, 1, 1)

				var_63_47.a = Mathf.Lerp(1, 0, var_63_46)
				arg_60_1.mask_.color = var_63_47
			end

			if arg_60_1.time_ >= var_63_44 + var_63_45 and arg_60_1.time_ < var_63_44 + var_63_45 + arg_63_0 then
				local var_63_48 = Color.New(1, 1, 1)
				local var_63_49 = 0

				arg_60_1.mask_.enabled = false
				var_63_48.a = var_63_49
				arg_60_1.mask_.color = var_63_48
			end

			local var_63_50 = 0

			arg_60_1.isInRecall_ = false

			if var_63_50 < arg_60_1.time_ and arg_60_1.time_ <= var_63_50 + arg_63_0 then
				arg_60_1.screenFilterGo_:SetActive(false)

				for iter_63_2, iter_63_3 in pairs(arg_60_1.actors_) do
					local var_63_51 = iter_63_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_63_4, iter_63_5 in ipairs(var_63_51) do
						if iter_63_5.color.r > 0.51 then
							iter_63_5.color = Color.New(1, 1, 1)
						else
							iter_63_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_63_52 = 0.0166666666666667

			if var_63_50 <= arg_60_1.time_ and arg_60_1.time_ < var_63_50 + var_63_52 then
				local var_63_53 = (arg_60_1.time_ - var_63_50) / var_63_52

				arg_60_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_63_53)
			end

			if arg_60_1.time_ >= var_63_50 + var_63_52 and arg_60_1.time_ < var_63_50 + var_63_52 + arg_63_0 then
				arg_60_1.screenFilterEffect_.weight = 0
			end

			local var_63_54 = 0
			local var_63_55 = 0.175

			if var_63_54 < arg_60_1.time_ and arg_60_1.time_ <= var_63_54 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_56 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_56:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_57 = arg_60_1:FormatText(StoryNameCfg[92].name)

				arg_60_1.leftNameTxt_.text = var_63_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_58 = arg_60_1:GetWordFromCfg(317251013)
				local var_63_59 = arg_60_1:FormatText(var_63_58.content)

				arg_60_1.text_.text = var_63_59

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_60 = 7
				local var_63_61 = utf8.len(var_63_59)
				local var_63_62 = var_63_60 <= 0 and var_63_55 or var_63_55 * (var_63_61 / var_63_60)

				if var_63_62 > 0 and var_63_55 < var_63_62 then
					arg_60_1.talkMaxDuration = var_63_62
					var_63_54 = var_63_54 + 0.3

					if var_63_62 + var_63_54 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_62 + var_63_54
					end
				end

				arg_60_1.text_.text = var_63_59
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251013", "story_v_out_317251.awb") ~= 0 then
					local var_63_63 = manager.audio:GetVoiceLength("story_v_out_317251", "317251013", "story_v_out_317251.awb") / 1000

					if var_63_63 + var_63_54 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_63 + var_63_54
					end

					if var_63_58.prefab_name ~= "" and arg_60_1.actors_[var_63_58.prefab_name] ~= nil then
						local var_63_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_58.prefab_name].transform, "story_v_out_317251", "317251013", "story_v_out_317251.awb")

						arg_60_1:RecordAudio("317251013", var_63_64)
						arg_60_1:RecordAudio("317251013", var_63_64)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_317251", "317251013", "story_v_out_317251.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_317251", "317251013", "story_v_out_317251.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_65 = var_63_54 + 0.3
			local var_63_66 = math.max(var_63_55, arg_60_1.talkMaxDuration)

			if var_63_65 <= arg_60_1.time_ and arg_60_1.time_ < var_63_65 + var_63_66 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_65) / var_63_66

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_65 + var_63_66 and arg_60_1.time_ < var_63_65 + var_63_66 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
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

		arg_60_1:InitPlayNodeList()
	end,
	Play317251014 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 317251014
		arg_66_1.duration_ = 3.43

		local var_66_0 = {
			zh = 2.866,
			ja = 3.433
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play317251015(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1158ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos1158ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(0, 100, 0)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1158ui_story, var_69_4, var_69_3)

				local var_69_5 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_5.x, var_69_5.y, var_69_5.z)

				local var_69_6 = var_69_0.localEulerAngles

				var_69_6.z = 0
				var_69_6.x = 0
				var_69_0.localEulerAngles = var_69_6
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0, 100, 0)

				local var_69_7 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_7.x, var_69_7.y, var_69_7.z)

				local var_69_8 = var_69_0.localEulerAngles

				var_69_8.z = 0
				var_69_8.x = 0
				var_69_0.localEulerAngles = var_69_8
			end

			local var_69_9 = arg_66_1.actors_["1158ui_story"]
			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect1158ui_story == nil then
				arg_66_1.var_.characterEffect1158ui_story = var_69_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_11 = 0.200000002980232

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_11 and not isNil(var_69_9) then
				local var_69_12 = (arg_66_1.time_ - var_69_10) / var_69_11

				if arg_66_1.var_.characterEffect1158ui_story and not isNil(var_69_9) then
					local var_69_13 = Mathf.Lerp(0, 0.5, var_69_12)

					arg_66_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1158ui_story.fillRatio = var_69_13
				end
			end

			if arg_66_1.time_ >= var_69_10 + var_69_11 and arg_66_1.time_ < var_69_10 + var_69_11 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect1158ui_story then
				local var_69_14 = 0.5

				arg_66_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1158ui_story.fillRatio = var_69_14
			end

			local var_69_15 = arg_66_1.actors_["1049ui_story"].transform
			local var_69_16 = 0

			if var_69_16 < arg_66_1.time_ and arg_66_1.time_ <= var_69_16 + arg_69_0 then
				arg_66_1.var_.moveOldPos1049ui_story = var_69_15.localPosition
			end

			local var_69_17 = 0.001

			if var_69_16 <= arg_66_1.time_ and arg_66_1.time_ < var_69_16 + var_69_17 then
				local var_69_18 = (arg_66_1.time_ - var_69_16) / var_69_17
				local var_69_19 = Vector3.New(0, -1.2, -6)

				var_69_15.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1049ui_story, var_69_19, var_69_18)

				local var_69_20 = manager.ui.mainCamera.transform.position - var_69_15.position

				var_69_15.forward = Vector3.New(var_69_20.x, var_69_20.y, var_69_20.z)

				local var_69_21 = var_69_15.localEulerAngles

				var_69_21.z = 0
				var_69_21.x = 0
				var_69_15.localEulerAngles = var_69_21
			end

			if arg_66_1.time_ >= var_69_16 + var_69_17 and arg_66_1.time_ < var_69_16 + var_69_17 + arg_69_0 then
				var_69_15.localPosition = Vector3.New(0, -1.2, -6)

				local var_69_22 = manager.ui.mainCamera.transform.position - var_69_15.position

				var_69_15.forward = Vector3.New(var_69_22.x, var_69_22.y, var_69_22.z)

				local var_69_23 = var_69_15.localEulerAngles

				var_69_23.z = 0
				var_69_23.x = 0
				var_69_15.localEulerAngles = var_69_23
			end

			local var_69_24 = arg_66_1.actors_["1049ui_story"]
			local var_69_25 = 0

			if var_69_25 < arg_66_1.time_ and arg_66_1.time_ <= var_69_25 + arg_69_0 and not isNil(var_69_24) and arg_66_1.var_.characterEffect1049ui_story == nil then
				arg_66_1.var_.characterEffect1049ui_story = var_69_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_26 = 0.200000002980232

			if var_69_25 <= arg_66_1.time_ and arg_66_1.time_ < var_69_25 + var_69_26 and not isNil(var_69_24) then
				local var_69_27 = (arg_66_1.time_ - var_69_25) / var_69_26

				if arg_66_1.var_.characterEffect1049ui_story and not isNil(var_69_24) then
					arg_66_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_25 + var_69_26 and arg_66_1.time_ < var_69_25 + var_69_26 + arg_69_0 and not isNil(var_69_24) and arg_66_1.var_.characterEffect1049ui_story then
				arg_66_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_69_28 = 0

			if var_69_28 < arg_66_1.time_ and arg_66_1.time_ <= var_69_28 + arg_69_0 then
				arg_66_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_69_29 = 0

			if var_69_29 < arg_66_1.time_ and arg_66_1.time_ <= var_69_29 + arg_69_0 then
				arg_66_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_69_30 = 0

			if var_69_30 < arg_66_1.time_ and arg_66_1.time_ <= var_69_30 + arg_69_0 then
				local var_69_31 = manager.ui.mainCamera.transform.localPosition
				local var_69_32 = Vector3.New(0, 0, 10) + Vector3.New(var_69_31.x, var_69_31.y, 0)
				local var_69_33 = arg_66_1.bgs_.ST58

				var_69_33.transform.localPosition = var_69_32
				var_69_33.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_34 = var_69_33:GetComponent("SpriteRenderer")

				if var_69_34 and var_69_34.sprite then
					local var_69_35 = (var_69_33.transform.localPosition - var_69_31).z
					local var_69_36 = manager.ui.mainCameraCom_
					local var_69_37 = 2 * var_69_35 * Mathf.Tan(var_69_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_69_38 = var_69_37 * var_69_36.aspect
					local var_69_39 = var_69_34.sprite.bounds.size.x
					local var_69_40 = var_69_34.sprite.bounds.size.y
					local var_69_41 = var_69_38 / var_69_39
					local var_69_42 = var_69_37 / var_69_40
					local var_69_43 = var_69_42 < var_69_41 and var_69_41 or var_69_42

					var_69_33.transform.localScale = Vector3.New(var_69_43, var_69_43, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "ST58" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_44 = 0

			if var_69_44 < arg_66_1.time_ and arg_66_1.time_ <= var_69_44 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_45 = 1

			if var_69_44 <= arg_66_1.time_ and arg_66_1.time_ < var_69_44 + var_69_45 then
				local var_69_46 = (arg_66_1.time_ - var_69_44) / var_69_45
				local var_69_47 = Color.New(1, 1, 1)

				var_69_47.a = Mathf.Lerp(1, 0, var_69_46)
				arg_66_1.mask_.color = var_69_47
			end

			if arg_66_1.time_ >= var_69_44 + var_69_45 and arg_66_1.time_ < var_69_44 + var_69_45 + arg_69_0 then
				local var_69_48 = Color.New(1, 1, 1)
				local var_69_49 = 0

				arg_66_1.mask_.enabled = false
				var_69_48.a = var_69_49
				arg_66_1.mask_.color = var_69_48
			end

			local var_69_50 = 0

			arg_66_1.isInRecall_ = false

			if var_69_50 < arg_66_1.time_ and arg_66_1.time_ <= var_69_50 + arg_69_0 then
				arg_66_1.screenFilterGo_:SetActive(true)

				arg_66_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_69_2, iter_69_3 in pairs(arg_66_1.actors_) do
					local var_69_51 = iter_69_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_69_4, iter_69_5 in ipairs(var_69_51) do
						if iter_69_5.color.r > 0.51 then
							iter_69_5.color = Color.New(1, 1, 1)
						else
							iter_69_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_69_52 = 0.0166666666666667

			if var_69_50 <= arg_66_1.time_ and arg_66_1.time_ < var_69_50 + var_69_52 then
				local var_69_53 = (arg_66_1.time_ - var_69_50) / var_69_52

				arg_66_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_69_53)
			end

			if arg_66_1.time_ >= var_69_50 + var_69_52 and arg_66_1.time_ < var_69_50 + var_69_52 + arg_69_0 then
				arg_66_1.screenFilterEffect_.weight = 1
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_54 = 1
			local var_69_55 = 0.125

			if var_69_54 < arg_66_1.time_ and arg_66_1.time_ <= var_69_54 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_56 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_56:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_57 = arg_66_1:FormatText(StoryNameCfg[562].name)

				arg_66_1.leftNameTxt_.text = var_69_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_58 = arg_66_1:GetWordFromCfg(317251014)
				local var_69_59 = arg_66_1:FormatText(var_69_58.content)

				arg_66_1.text_.text = var_69_59

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_60 = 5
				local var_69_61 = utf8.len(var_69_59)
				local var_69_62 = var_69_60 <= 0 and var_69_55 or var_69_55 * (var_69_61 / var_69_60)

				if var_69_62 > 0 and var_69_55 < var_69_62 then
					arg_66_1.talkMaxDuration = var_69_62
					var_69_54 = var_69_54 + 0.3

					if var_69_62 + var_69_54 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_62 + var_69_54
					end
				end

				arg_66_1.text_.text = var_69_59
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251014", "story_v_out_317251.awb") ~= 0 then
					local var_69_63 = manager.audio:GetVoiceLength("story_v_out_317251", "317251014", "story_v_out_317251.awb") / 1000

					if var_69_63 + var_69_54 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_63 + var_69_54
					end

					if var_69_58.prefab_name ~= "" and arg_66_1.actors_[var_69_58.prefab_name] ~= nil then
						local var_69_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_58.prefab_name].transform, "story_v_out_317251", "317251014", "story_v_out_317251.awb")

						arg_66_1:RecordAudio("317251014", var_69_64)
						arg_66_1:RecordAudio("317251014", var_69_64)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_317251", "317251014", "story_v_out_317251.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_317251", "317251014", "story_v_out_317251.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_65 = var_69_54 + 0.3
			local var_69_66 = math.max(var_69_55, arg_66_1.talkMaxDuration)

			if var_69_65 <= arg_66_1.time_ and arg_66_1.time_ < var_69_65 + var_69_66 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_65) / var_69_66

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_65 + var_69_66 and arg_66_1.time_ < var_69_65 + var_69_66 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
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

		arg_66_1:InitPlayNodeList()
	end,
	Play317251015 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 317251015
		arg_72_1.duration_ = 3.28

		local var_72_0 = {
			zh = 3.28266666666667,
			ja = 2.74966666666667
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
				arg_72_0:Play317251016(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1158ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1158ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(0, -0.95, -6)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1158ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, -0.95, -6)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = arg_72_1.actors_["1158ui_story"]
			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1158ui_story == nil then
				arg_72_1.var_.characterEffect1158ui_story = var_75_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_11 = 0.200000002980232

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_11 and not isNil(var_75_9) then
				local var_75_12 = (arg_72_1.time_ - var_75_10) / var_75_11

				if arg_72_1.var_.characterEffect1158ui_story and not isNil(var_75_9) then
					arg_72_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_10 + var_75_11 and arg_72_1.time_ < var_75_10 + var_75_11 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1158ui_story then
				arg_72_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			local var_75_13 = 0

			if var_75_13 < arg_72_1.time_ and arg_72_1.time_ <= var_75_13 + arg_75_0 then
				arg_72_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action1_1")
			end

			local var_75_14 = 0

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_75_15 = arg_72_1.actors_["1049ui_story"].transform
			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1.var_.moveOldPos1049ui_story = var_75_15.localPosition
			end

			local var_75_17 = 0.001

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_17 then
				local var_75_18 = (arg_72_1.time_ - var_75_16) / var_75_17
				local var_75_19 = Vector3.New(0, 100, 0)

				var_75_15.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1049ui_story, var_75_19, var_75_18)

				local var_75_20 = manager.ui.mainCamera.transform.position - var_75_15.position

				var_75_15.forward = Vector3.New(var_75_20.x, var_75_20.y, var_75_20.z)

				local var_75_21 = var_75_15.localEulerAngles

				var_75_21.z = 0
				var_75_21.x = 0
				var_75_15.localEulerAngles = var_75_21
			end

			if arg_72_1.time_ >= var_75_16 + var_75_17 and arg_72_1.time_ < var_75_16 + var_75_17 + arg_75_0 then
				var_75_15.localPosition = Vector3.New(0, 100, 0)

				local var_75_22 = manager.ui.mainCamera.transform.position - var_75_15.position

				var_75_15.forward = Vector3.New(var_75_22.x, var_75_22.y, var_75_22.z)

				local var_75_23 = var_75_15.localEulerAngles

				var_75_23.z = 0
				var_75_23.x = 0
				var_75_15.localEulerAngles = var_75_23
			end

			local var_75_24 = 0

			if var_75_24 < arg_72_1.time_ and arg_72_1.time_ <= var_75_24 + arg_75_0 then
				local var_75_25 = manager.ui.mainCamera.transform.localPosition
				local var_75_26 = Vector3.New(0, 0, 10) + Vector3.New(var_75_25.x, var_75_25.y, 0)
				local var_75_27 = arg_72_1.bgs_.K12f

				var_75_27.transform.localPosition = var_75_26
				var_75_27.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_28 = var_75_27:GetComponent("SpriteRenderer")

				if var_75_28 and var_75_28.sprite then
					local var_75_29 = (var_75_27.transform.localPosition - var_75_25).z
					local var_75_30 = manager.ui.mainCameraCom_
					local var_75_31 = 2 * var_75_29 * Mathf.Tan(var_75_30.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_75_32 = var_75_31 * var_75_30.aspect
					local var_75_33 = var_75_28.sprite.bounds.size.x
					local var_75_34 = var_75_28.sprite.bounds.size.y
					local var_75_35 = var_75_32 / var_75_33
					local var_75_36 = var_75_31 / var_75_34
					local var_75_37 = var_75_36 < var_75_35 and var_75_35 or var_75_36

					var_75_27.transform.localScale = Vector3.New(var_75_37, var_75_37, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "K12f" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_38 = 0

			if var_75_38 < arg_72_1.time_ and arg_72_1.time_ <= var_75_38 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_39 = 1

			if var_75_38 <= arg_72_1.time_ and arg_72_1.time_ < var_75_38 + var_75_39 then
				local var_75_40 = (arg_72_1.time_ - var_75_38) / var_75_39
				local var_75_41 = Color.New(1, 1, 1)

				var_75_41.a = Mathf.Lerp(1, 0, var_75_40)
				arg_72_1.mask_.color = var_75_41
			end

			if arg_72_1.time_ >= var_75_38 + var_75_39 and arg_72_1.time_ < var_75_38 + var_75_39 + arg_75_0 then
				local var_75_42 = Color.New(1, 1, 1)
				local var_75_43 = 0

				arg_72_1.mask_.enabled = false
				var_75_42.a = var_75_43
				arg_72_1.mask_.color = var_75_42
			end

			local var_75_44 = 0

			arg_72_1.isInRecall_ = false

			if var_75_44 < arg_72_1.time_ and arg_72_1.time_ <= var_75_44 + arg_75_0 then
				arg_72_1.screenFilterGo_:SetActive(false)

				for iter_75_2, iter_75_3 in pairs(arg_72_1.actors_) do
					local var_75_45 = iter_75_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_75_4, iter_75_5 in ipairs(var_75_45) do
						if iter_75_5.color.r > 0.51 then
							iter_75_5.color = Color.New(1, 1, 1)
						else
							iter_75_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_75_46 = 0.0166666666666667

			if var_75_44 <= arg_72_1.time_ and arg_72_1.time_ < var_75_44 + var_75_46 then
				local var_75_47 = (arg_72_1.time_ - var_75_44) / var_75_46

				arg_72_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_75_47)
			end

			if arg_72_1.time_ >= var_75_44 + var_75_46 and arg_72_1.time_ < var_75_44 + var_75_46 + arg_75_0 then
				arg_72_1.screenFilterEffect_.weight = 0
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_48 = 1.01666666666667
			local var_75_49 = 0.175

			if var_75_48 < arg_72_1.time_ and arg_72_1.time_ <= var_75_48 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_50 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_50:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_51 = arg_72_1:FormatText(StoryNameCfg[92].name)

				arg_72_1.leftNameTxt_.text = var_75_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_52 = arg_72_1:GetWordFromCfg(317251015)
				local var_75_53 = arg_72_1:FormatText(var_75_52.content)

				arg_72_1.text_.text = var_75_53

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_54 = 7
				local var_75_55 = utf8.len(var_75_53)
				local var_75_56 = var_75_54 <= 0 and var_75_49 or var_75_49 * (var_75_55 / var_75_54)

				if var_75_56 > 0 and var_75_49 < var_75_56 then
					arg_72_1.talkMaxDuration = var_75_56
					var_75_48 = var_75_48 + 0.3

					if var_75_56 + var_75_48 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_56 + var_75_48
					end
				end

				arg_72_1.text_.text = var_75_53
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251015", "story_v_out_317251.awb") ~= 0 then
					local var_75_57 = manager.audio:GetVoiceLength("story_v_out_317251", "317251015", "story_v_out_317251.awb") / 1000

					if var_75_57 + var_75_48 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_57 + var_75_48
					end

					if var_75_52.prefab_name ~= "" and arg_72_1.actors_[var_75_52.prefab_name] ~= nil then
						local var_75_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_52.prefab_name].transform, "story_v_out_317251", "317251015", "story_v_out_317251.awb")

						arg_72_1:RecordAudio("317251015", var_75_58)
						arg_72_1:RecordAudio("317251015", var_75_58)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_317251", "317251015", "story_v_out_317251.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_317251", "317251015", "story_v_out_317251.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_59 = var_75_48 + 0.3
			local var_75_60 = math.max(var_75_49, arg_72_1.talkMaxDuration)

			if var_75_59 <= arg_72_1.time_ and arg_72_1.time_ < var_75_59 + var_75_60 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_59) / var_75_60

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_59 + var_75_60 and arg_72_1.time_ < var_75_59 + var_75_60 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
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

		arg_72_1:InitPlayNodeList()
	end,
	Play317251016 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 317251016
		arg_78_1.duration_ = 3.37

		local var_78_0 = {
			zh = 1.999999999999,
			ja = 3.366
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play317251017(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1158ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1158ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1158ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = arg_78_1.actors_["1049ui_story"].transform
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.var_.moveOldPos1049ui_story = var_81_9.localPosition
			end

			local var_81_11 = 0.001

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11
				local var_81_13 = Vector3.New(0, -1.2, -6)

				var_81_9.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1049ui_story, var_81_13, var_81_12)

				local var_81_14 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_14.x, var_81_14.y, var_81_14.z)

				local var_81_15 = var_81_9.localEulerAngles

				var_81_15.z = 0
				var_81_15.x = 0
				var_81_9.localEulerAngles = var_81_15
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 then
				var_81_9.localPosition = Vector3.New(0, -1.2, -6)

				local var_81_16 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_16.x, var_81_16.y, var_81_16.z)

				local var_81_17 = var_81_9.localEulerAngles

				var_81_17.z = 0
				var_81_17.x = 0
				var_81_9.localEulerAngles = var_81_17
			end

			local var_81_18 = arg_78_1.actors_["1049ui_story"]
			local var_81_19 = 0

			if var_81_19 < arg_78_1.time_ and arg_78_1.time_ <= var_81_19 + arg_81_0 and not isNil(var_81_18) and arg_78_1.var_.characterEffect1049ui_story == nil then
				arg_78_1.var_.characterEffect1049ui_story = var_81_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_20 = 0.200000002980232

			if var_81_19 <= arg_78_1.time_ and arg_78_1.time_ < var_81_19 + var_81_20 and not isNil(var_81_18) then
				local var_81_21 = (arg_78_1.time_ - var_81_19) / var_81_20

				if arg_78_1.var_.characterEffect1049ui_story and not isNil(var_81_18) then
					arg_78_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_19 + var_81_20 and arg_78_1.time_ < var_81_19 + var_81_20 + arg_81_0 and not isNil(var_81_18) and arg_78_1.var_.characterEffect1049ui_story then
				arg_78_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_81_22 = 0

			if var_81_22 < arg_78_1.time_ and arg_78_1.time_ <= var_81_22 + arg_81_0 then
				arg_78_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_81_23 = 0

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 then
				arg_78_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_81_24 = 0

			if var_81_24 < arg_78_1.time_ and arg_78_1.time_ <= var_81_24 + arg_81_0 then
				local var_81_25 = manager.ui.mainCamera.transform.localPosition
				local var_81_26 = Vector3.New(0, 0, 10) + Vector3.New(var_81_25.x, var_81_25.y, 0)
				local var_81_27 = arg_78_1.bgs_.ST58

				var_81_27.transform.localPosition = var_81_26
				var_81_27.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_28 = var_81_27:GetComponent("SpriteRenderer")

				if var_81_28 and var_81_28.sprite then
					local var_81_29 = (var_81_27.transform.localPosition - var_81_25).z
					local var_81_30 = manager.ui.mainCameraCom_
					local var_81_31 = 2 * var_81_29 * Mathf.Tan(var_81_30.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_81_32 = var_81_31 * var_81_30.aspect
					local var_81_33 = var_81_28.sprite.bounds.size.x
					local var_81_34 = var_81_28.sprite.bounds.size.y
					local var_81_35 = var_81_32 / var_81_33
					local var_81_36 = var_81_31 / var_81_34
					local var_81_37 = var_81_36 < var_81_35 and var_81_35 or var_81_36

					var_81_27.transform.localScale = Vector3.New(var_81_37, var_81_37, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "ST58" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_38 = 0

			if var_81_38 < arg_78_1.time_ and arg_78_1.time_ <= var_81_38 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_39 = 1

			if var_81_38 <= arg_78_1.time_ and arg_78_1.time_ < var_81_38 + var_81_39 then
				local var_81_40 = (arg_78_1.time_ - var_81_38) / var_81_39
				local var_81_41 = Color.New(1, 1, 1)

				var_81_41.a = Mathf.Lerp(1, 0, var_81_40)
				arg_78_1.mask_.color = var_81_41
			end

			if arg_78_1.time_ >= var_81_38 + var_81_39 and arg_78_1.time_ < var_81_38 + var_81_39 + arg_81_0 then
				local var_81_42 = Color.New(1, 1, 1)
				local var_81_43 = 0

				arg_78_1.mask_.enabled = false
				var_81_42.a = var_81_43
				arg_78_1.mask_.color = var_81_42
			end

			local var_81_44 = 0

			arg_78_1.isInRecall_ = false

			if var_81_44 < arg_78_1.time_ and arg_78_1.time_ <= var_81_44 + arg_81_0 then
				arg_78_1.screenFilterGo_:SetActive(true)

				arg_78_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_81_2, iter_81_3 in pairs(arg_78_1.actors_) do
					local var_81_45 = iter_81_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_81_4, iter_81_5 in ipairs(var_81_45) do
						if iter_81_5.color.r > 0.51 then
							iter_81_5.color = Color.New(1, 1, 1)
						else
							iter_81_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_81_46 = 0.0166666666666667

			if var_81_44 <= arg_78_1.time_ and arg_78_1.time_ < var_81_44 + var_81_46 then
				local var_81_47 = (arg_78_1.time_ - var_81_44) / var_81_46

				arg_78_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_81_47)
			end

			if arg_78_1.time_ >= var_81_44 + var_81_46 and arg_78_1.time_ < var_81_44 + var_81_46 + arg_81_0 then
				arg_78_1.screenFilterEffect_.weight = 1
			end

			local var_81_48 = 0
			local var_81_49 = 0.1

			if var_81_48 < arg_78_1.time_ and arg_78_1.time_ <= var_81_48 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_50 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_50:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_51 = arg_78_1:FormatText(StoryNameCfg[562].name)

				arg_78_1.leftNameTxt_.text = var_81_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_52 = arg_78_1:GetWordFromCfg(317251016)
				local var_81_53 = arg_78_1:FormatText(var_81_52.content)

				arg_78_1.text_.text = var_81_53

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_54 = 4
				local var_81_55 = utf8.len(var_81_53)
				local var_81_56 = var_81_54 <= 0 and var_81_49 or var_81_49 * (var_81_55 / var_81_54)

				if var_81_56 > 0 and var_81_49 < var_81_56 then
					arg_78_1.talkMaxDuration = var_81_56
					var_81_48 = var_81_48 + 0.3

					if var_81_56 + var_81_48 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_56 + var_81_48
					end
				end

				arg_78_1.text_.text = var_81_53
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251016", "story_v_out_317251.awb") ~= 0 then
					local var_81_57 = manager.audio:GetVoiceLength("story_v_out_317251", "317251016", "story_v_out_317251.awb") / 1000

					if var_81_57 + var_81_48 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_57 + var_81_48
					end

					if var_81_52.prefab_name ~= "" and arg_78_1.actors_[var_81_52.prefab_name] ~= nil then
						local var_81_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_52.prefab_name].transform, "story_v_out_317251", "317251016", "story_v_out_317251.awb")

						arg_78_1:RecordAudio("317251016", var_81_58)
						arg_78_1:RecordAudio("317251016", var_81_58)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_317251", "317251016", "story_v_out_317251.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_317251", "317251016", "story_v_out_317251.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_59 = var_81_48 + 0.3
			local var_81_60 = math.max(var_81_49, arg_78_1.talkMaxDuration)

			if var_81_59 <= arg_78_1.time_ and arg_78_1.time_ < var_81_59 + var_81_60 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_59) / var_81_60

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_59 + var_81_60 and arg_78_1.time_ < var_81_59 + var_81_60 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
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

		arg_78_1:InitPlayNodeList()
	end,
	Play317251017 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 317251017
		arg_84_1.duration_ = 9

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play317251018(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1049ui_story"].transform
			local var_87_1 = 2

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1049ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0, 100, 0)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1049ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, 100, 0)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = 2.00066666851441

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				local var_87_10 = manager.ui.mainCamera.transform.localPosition
				local var_87_11 = Vector3.New(0, 0, 10) + Vector3.New(var_87_10.x, var_87_10.y, 0)
				local var_87_12 = arg_84_1.bgs_.K12f

				var_87_12.transform.localPosition = var_87_11
				var_87_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_13 = var_87_12:GetComponent("SpriteRenderer")

				if var_87_13 and var_87_13.sprite then
					local var_87_14 = (var_87_12.transform.localPosition - var_87_10).z
					local var_87_15 = manager.ui.mainCameraCom_
					local var_87_16 = 2 * var_87_14 * Mathf.Tan(var_87_15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_87_17 = var_87_16 * var_87_15.aspect
					local var_87_18 = var_87_13.sprite.bounds.size.x
					local var_87_19 = var_87_13.sprite.bounds.size.y
					local var_87_20 = var_87_17 / var_87_18
					local var_87_21 = var_87_16 / var_87_19
					local var_87_22 = var_87_21 < var_87_20 and var_87_20 or var_87_21

					var_87_12.transform.localScale = Vector3.New(var_87_22, var_87_22, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "K12f" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_87_23 = 0

			if var_87_23 < arg_84_1.time_ and arg_84_1.time_ <= var_87_23 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_24 = 2

			if var_87_23 <= arg_84_1.time_ and arg_84_1.time_ < var_87_23 + var_87_24 then
				local var_87_25 = (arg_84_1.time_ - var_87_23) / var_87_24
				local var_87_26 = Color.New(0, 0, 0)

				var_87_26.a = Mathf.Lerp(0, 1, var_87_25)
				arg_84_1.mask_.color = var_87_26
			end

			if arg_84_1.time_ >= var_87_23 + var_87_24 and arg_84_1.time_ < var_87_23 + var_87_24 + arg_87_0 then
				local var_87_27 = Color.New(0, 0, 0)

				var_87_27.a = 1
				arg_84_1.mask_.color = var_87_27
			end

			local var_87_28 = 2

			if var_87_28 < arg_84_1.time_ and arg_84_1.time_ <= var_87_28 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_29 = 2

			if var_87_28 <= arg_84_1.time_ and arg_84_1.time_ < var_87_28 + var_87_29 then
				local var_87_30 = (arg_84_1.time_ - var_87_28) / var_87_29
				local var_87_31 = Color.New(0, 0, 0)

				var_87_31.a = Mathf.Lerp(1, 0, var_87_30)
				arg_84_1.mask_.color = var_87_31
			end

			if arg_84_1.time_ >= var_87_28 + var_87_29 and arg_84_1.time_ < var_87_28 + var_87_29 + arg_87_0 then
				local var_87_32 = Color.New(0, 0, 0)
				local var_87_33 = 0

				arg_84_1.mask_.enabled = false
				var_87_32.a = var_87_33
				arg_84_1.mask_.color = var_87_32
			end

			local var_87_34 = 2

			arg_84_1.isInRecall_ = false

			if var_87_34 < arg_84_1.time_ and arg_84_1.time_ <= var_87_34 + arg_87_0 then
				arg_84_1.screenFilterGo_:SetActive(false)

				for iter_87_2, iter_87_3 in pairs(arg_84_1.actors_) do
					local var_87_35 = iter_87_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_87_4, iter_87_5 in ipairs(var_87_35) do
						if iter_87_5.color.r > 0.51 then
							iter_87_5.color = Color.New(1, 1, 1)
						else
							iter_87_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_87_36 = 0.0166666666666667

			if var_87_34 <= arg_84_1.time_ and arg_84_1.time_ < var_87_34 + var_87_36 then
				local var_87_37 = (arg_84_1.time_ - var_87_34) / var_87_36

				arg_84_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_87_37)
			end

			if arg_84_1.time_ >= var_87_34 + var_87_36 and arg_84_1.time_ < var_87_34 + var_87_36 + arg_87_0 then
				arg_84_1.screenFilterEffect_.weight = 0
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_38 = 4
			local var_87_39 = 0.75

			if var_87_38 < arg_84_1.time_ and arg_84_1.time_ <= var_87_38 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_40 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_40:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_41 = arg_84_1:GetWordFromCfg(317251017)
				local var_87_42 = arg_84_1:FormatText(var_87_41.content)

				arg_84_1.text_.text = var_87_42

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_43 = 30
				local var_87_44 = utf8.len(var_87_42)
				local var_87_45 = var_87_43 <= 0 and var_87_39 or var_87_39 * (var_87_44 / var_87_43)

				if var_87_45 > 0 and var_87_39 < var_87_45 then
					arg_84_1.talkMaxDuration = var_87_45
					var_87_38 = var_87_38 + 0.3

					if var_87_45 + var_87_38 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_45 + var_87_38
					end
				end

				arg_84_1.text_.text = var_87_42
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_46 = var_87_38 + 0.3
			local var_87_47 = math.max(var_87_39, arg_84_1.talkMaxDuration)

			if var_87_46 <= arg_84_1.time_ and arg_84_1.time_ < var_87_46 + var_87_47 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_46) / var_87_47

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_46 + var_87_47 and arg_84_1.time_ < var_87_46 + var_87_47 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play317251018 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 317251018
		arg_90_1.duration_ = 13.77

		local var_90_0 = {
			zh = 12.133,
			ja = 13.766
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play317251019(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 1.1

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[563].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:GetWordFromCfg(317251018)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 44
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251018", "story_v_out_317251.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_317251", "317251018", "story_v_out_317251.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_317251", "317251018", "story_v_out_317251.awb")

						arg_90_1:RecordAudio("317251018", var_93_9)
						arg_90_1:RecordAudio("317251018", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_317251", "317251018", "story_v_out_317251.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_317251", "317251018", "story_v_out_317251.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play317251019 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 317251019
		arg_94_1.duration_ = 8.2

		local var_94_0 = {
			zh = 8.2,
			ja = 5.866
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play317251020(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.775

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[563].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(317251019)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 31
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251019", "story_v_out_317251.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_317251", "317251019", "story_v_out_317251.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_317251", "317251019", "story_v_out_317251.awb")

						arg_94_1:RecordAudio("317251019", var_97_9)
						arg_94_1:RecordAudio("317251019", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_317251", "317251019", "story_v_out_317251.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_317251", "317251019", "story_v_out_317251.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play317251020 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 317251020
		arg_98_1.duration_ = 5.43

		local var_98_0 = {
			zh = 5.433,
			ja = 4.666
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play317251021(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.6

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[563].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(317251020)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 24
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251020", "story_v_out_317251.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_317251", "317251020", "story_v_out_317251.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_317251", "317251020", "story_v_out_317251.awb")

						arg_98_1:RecordAudio("317251020", var_101_9)
						arg_98_1:RecordAudio("317251020", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_317251", "317251020", "story_v_out_317251.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_317251", "317251020", "story_v_out_317251.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play317251021 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 317251021
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play317251022(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.875

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(317251021)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 35
				local var_105_5 = utf8.len(var_105_3)
				local var_105_6 = var_105_4 <= 0 and var_105_1 or var_105_1 * (var_105_5 / var_105_4)

				if var_105_6 > 0 and var_105_1 < var_105_6 then
					arg_102_1.talkMaxDuration = var_105_6

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_7 and arg_102_1.time_ < var_105_0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play317251022 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 317251022
		arg_106_1.duration_ = 1.33

		local var_106_0 = {
			zh = 1.3,
			ja = 1.333
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play317251023(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.1

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[93].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(317251022)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 4
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251022", "story_v_out_317251.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_317251", "317251022", "story_v_out_317251.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_317251", "317251022", "story_v_out_317251.awb")

						arg_106_1:RecordAudio("317251022", var_109_9)
						arg_106_1:RecordAudio("317251022", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_317251", "317251022", "story_v_out_317251.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_317251", "317251022", "story_v_out_317251.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play317251023 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 317251023
		arg_110_1.duration_ = 1.8

		local var_110_0 = {
			zh = 1.8,
			ja = 1.666
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play317251024(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.125

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[563].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(317251023)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 5
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251023", "story_v_out_317251.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_317251", "317251023", "story_v_out_317251.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_317251", "317251023", "story_v_out_317251.awb")

						arg_110_1:RecordAudio("317251023", var_113_9)
						arg_110_1:RecordAudio("317251023", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_317251", "317251023", "story_v_out_317251.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_317251", "317251023", "story_v_out_317251.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play317251024 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 317251024
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play317251025(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.55

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_2 = arg_114_1:GetWordFromCfg(317251024)
				local var_117_3 = arg_114_1:FormatText(var_117_2.content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 22
				local var_117_5 = utf8.len(var_117_3)
				local var_117_6 = var_117_4 <= 0 and var_117_1 or var_117_1 * (var_117_5 / var_117_4)

				if var_117_6 > 0 and var_117_1 < var_117_6 then
					arg_114_1.talkMaxDuration = var_117_6

					if var_117_6 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_7 and arg_114_1.time_ < var_117_0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play317251025 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 317251025
		arg_118_1.duration_ = 11.83

		local var_118_0 = {
			zh = 8.066,
			ja = 11.833
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play317251026(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.95

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[93].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:GetWordFromCfg(317251025)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 38
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251025", "story_v_out_317251.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_317251", "317251025", "story_v_out_317251.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_317251", "317251025", "story_v_out_317251.awb")

						arg_118_1:RecordAudio("317251025", var_121_9)
						arg_118_1:RecordAudio("317251025", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_317251", "317251025", "story_v_out_317251.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_317251", "317251025", "story_v_out_317251.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_10 and arg_118_1.time_ < var_121_0 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play317251026 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 317251026
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play317251027(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 2.025

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_2 = arg_122_1:GetWordFromCfg(317251026)
				local var_125_3 = arg_122_1:FormatText(var_125_2.content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 81
				local var_125_5 = utf8.len(var_125_3)
				local var_125_6 = var_125_4 <= 0 and var_125_1 or var_125_1 * (var_125_5 / var_125_4)

				if var_125_6 > 0 and var_125_1 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_7 and arg_122_1.time_ < var_125_0 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play317251027 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 317251027
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play317251028(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 0.9

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_2 = arg_126_1:GetWordFromCfg(317251027)
				local var_129_3 = arg_126_1:FormatText(var_129_2.content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 36
				local var_129_5 = utf8.len(var_129_3)
				local var_129_6 = var_129_4 <= 0 and var_129_1 or var_129_1 * (var_129_5 / var_129_4)

				if var_129_6 > 0 and var_129_1 < var_129_6 then
					arg_126_1.talkMaxDuration = var_129_6

					if var_129_6 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_6 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_7 and arg_126_1.time_ < var_129_0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play317251028 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 317251028
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play317251029(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 1.075

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(317251028)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 43
				local var_133_5 = utf8.len(var_133_3)
				local var_133_6 = var_133_4 <= 0 and var_133_1 or var_133_1 * (var_133_5 / var_133_4)

				if var_133_6 > 0 and var_133_1 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_7 and arg_130_1.time_ < var_133_0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play317251029 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 317251029
		arg_134_1.duration_ = 4.87

		local var_134_0 = {
			zh = 3,
			ja = 4.866
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play317251030(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1158ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos1158ui_story = var_137_0.localPosition
			end

			local var_137_2 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2
				local var_137_4 = Vector3.New(0, -0.95, -6)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1158ui_story, var_137_4, var_137_3)

				local var_137_5 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_5.x, var_137_5.y, var_137_5.z)

				local var_137_6 = var_137_0.localEulerAngles

				var_137_6.z = 0
				var_137_6.x = 0
				var_137_0.localEulerAngles = var_137_6
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(0, -0.95, -6)

				local var_137_7 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_7.x, var_137_7.y, var_137_7.z)

				local var_137_8 = var_137_0.localEulerAngles

				var_137_8.z = 0
				var_137_8.x = 0
				var_137_0.localEulerAngles = var_137_8
			end

			local var_137_9 = arg_134_1.actors_["1158ui_story"]
			local var_137_10 = 0

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 and not isNil(var_137_9) and arg_134_1.var_.characterEffect1158ui_story == nil then
				arg_134_1.var_.characterEffect1158ui_story = var_137_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_11 = 0.200000002980232

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_11 and not isNil(var_137_9) then
				local var_137_12 = (arg_134_1.time_ - var_137_10) / var_137_11

				if arg_134_1.var_.characterEffect1158ui_story and not isNil(var_137_9) then
					arg_134_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_10 + var_137_11 and arg_134_1.time_ < var_137_10 + var_137_11 + arg_137_0 and not isNil(var_137_9) and arg_134_1.var_.characterEffect1158ui_story then
				arg_134_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			local var_137_13 = 0

			if var_137_13 < arg_134_1.time_ and arg_134_1.time_ <= var_137_13 + arg_137_0 then
				arg_134_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action1_1")
			end

			local var_137_14 = 0

			if var_137_14 < arg_134_1.time_ and arg_134_1.time_ <= var_137_14 + arg_137_0 then
				arg_134_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_137_15 = 0
			local var_137_16 = 0.275

			if var_137_15 < arg_134_1.time_ and arg_134_1.time_ <= var_137_15 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_17 = arg_134_1:FormatText(StoryNameCfg[92].name)

				arg_134_1.leftNameTxt_.text = var_137_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_18 = arg_134_1:GetWordFromCfg(317251029)
				local var_137_19 = arg_134_1:FormatText(var_137_18.content)

				arg_134_1.text_.text = var_137_19

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_20 = 11
				local var_137_21 = utf8.len(var_137_19)
				local var_137_22 = var_137_20 <= 0 and var_137_16 or var_137_16 * (var_137_21 / var_137_20)

				if var_137_22 > 0 and var_137_16 < var_137_22 then
					arg_134_1.talkMaxDuration = var_137_22

					if var_137_22 + var_137_15 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_22 + var_137_15
					end
				end

				arg_134_1.text_.text = var_137_19
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251029", "story_v_out_317251.awb") ~= 0 then
					local var_137_23 = manager.audio:GetVoiceLength("story_v_out_317251", "317251029", "story_v_out_317251.awb") / 1000

					if var_137_23 + var_137_15 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_23 + var_137_15
					end

					if var_137_18.prefab_name ~= "" and arg_134_1.actors_[var_137_18.prefab_name] ~= nil then
						local var_137_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_18.prefab_name].transform, "story_v_out_317251", "317251029", "story_v_out_317251.awb")

						arg_134_1:RecordAudio("317251029", var_137_24)
						arg_134_1:RecordAudio("317251029", var_137_24)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_317251", "317251029", "story_v_out_317251.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_317251", "317251029", "story_v_out_317251.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_25 = math.max(var_137_16, arg_134_1.talkMaxDuration)

			if var_137_15 <= arg_134_1.time_ and arg_134_1.time_ < var_137_15 + var_137_25 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_15) / var_137_25

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_15 + var_137_25 and arg_134_1.time_ < var_137_15 + var_137_25 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play317251030 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 317251030
		arg_138_1.duration_ = 8.9

		local var_138_0 = {
			zh = 8.7,
			ja = 8.9
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play317251031(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1158ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1158ui_story == nil then
				arg_138_1.var_.characterEffect1158ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1158ui_story and not isNil(var_141_0) then
					local var_141_4 = Mathf.Lerp(0, 0.5, var_141_3)

					arg_138_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1158ui_story.fillRatio = var_141_4
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1158ui_story then
				local var_141_5 = 0.5

				arg_138_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1158ui_story.fillRatio = var_141_5
			end

			local var_141_6 = arg_138_1.actors_["1158ui_story"].transform
			local var_141_7 = 0

			if var_141_7 < arg_138_1.time_ and arg_138_1.time_ <= var_141_7 + arg_141_0 then
				arg_138_1.var_.moveOldPos1158ui_story = var_141_6.localPosition
			end

			local var_141_8 = 0.001

			if var_141_7 <= arg_138_1.time_ and arg_138_1.time_ < var_141_7 + var_141_8 then
				local var_141_9 = (arg_138_1.time_ - var_141_7) / var_141_8
				local var_141_10 = Vector3.New(0, 100, 0)

				var_141_6.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1158ui_story, var_141_10, var_141_9)

				local var_141_11 = manager.ui.mainCamera.transform.position - var_141_6.position

				var_141_6.forward = Vector3.New(var_141_11.x, var_141_11.y, var_141_11.z)

				local var_141_12 = var_141_6.localEulerAngles

				var_141_12.z = 0
				var_141_12.x = 0
				var_141_6.localEulerAngles = var_141_12
			end

			if arg_138_1.time_ >= var_141_7 + var_141_8 and arg_138_1.time_ < var_141_7 + var_141_8 + arg_141_0 then
				var_141_6.localPosition = Vector3.New(0, 100, 0)

				local var_141_13 = manager.ui.mainCamera.transform.position - var_141_6.position

				var_141_6.forward = Vector3.New(var_141_13.x, var_141_13.y, var_141_13.z)

				local var_141_14 = var_141_6.localEulerAngles

				var_141_14.z = 0
				var_141_14.x = 0
				var_141_6.localEulerAngles = var_141_14
			end

			local var_141_15 = 0
			local var_141_16 = 0.9

			if var_141_15 < arg_138_1.time_ and arg_138_1.time_ <= var_141_15 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_17 = arg_138_1:FormatText(StoryNameCfg[93].name)

				arg_138_1.leftNameTxt_.text = var_141_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_18 = arg_138_1:GetWordFromCfg(317251030)
				local var_141_19 = arg_138_1:FormatText(var_141_18.content)

				arg_138_1.text_.text = var_141_19

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_20 = 36
				local var_141_21 = utf8.len(var_141_19)
				local var_141_22 = var_141_20 <= 0 and var_141_16 or var_141_16 * (var_141_21 / var_141_20)

				if var_141_22 > 0 and var_141_16 < var_141_22 then
					arg_138_1.talkMaxDuration = var_141_22

					if var_141_22 + var_141_15 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_22 + var_141_15
					end
				end

				arg_138_1.text_.text = var_141_19
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251030", "story_v_out_317251.awb") ~= 0 then
					local var_141_23 = manager.audio:GetVoiceLength("story_v_out_317251", "317251030", "story_v_out_317251.awb") / 1000

					if var_141_23 + var_141_15 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_23 + var_141_15
					end

					if var_141_18.prefab_name ~= "" and arg_138_1.actors_[var_141_18.prefab_name] ~= nil then
						local var_141_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_18.prefab_name].transform, "story_v_out_317251", "317251030", "story_v_out_317251.awb")

						arg_138_1:RecordAudio("317251030", var_141_24)
						arg_138_1:RecordAudio("317251030", var_141_24)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_317251", "317251030", "story_v_out_317251.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_317251", "317251030", "story_v_out_317251.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_25 = math.max(var_141_16, arg_138_1.talkMaxDuration)

			if var_141_15 <= arg_138_1.time_ and arg_138_1.time_ < var_141_15 + var_141_25 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_15) / var_141_25

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_15 + var_141_25 and arg_138_1.time_ < var_141_15 + var_141_25 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play317251031 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 317251031
		arg_142_1.duration_ = 8.73

		local var_142_0 = {
			zh = 8.1,
			ja = 8.733
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play317251032(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.9

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[93].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(317251031)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 36
				local var_145_6 = utf8.len(var_145_4)
				local var_145_7 = var_145_5 <= 0 and var_145_1 or var_145_1 * (var_145_6 / var_145_5)

				if var_145_7 > 0 and var_145_1 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251031", "story_v_out_317251.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_317251", "317251031", "story_v_out_317251.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_317251", "317251031", "story_v_out_317251.awb")

						arg_142_1:RecordAudio("317251031", var_145_9)
						arg_142_1:RecordAudio("317251031", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_317251", "317251031", "story_v_out_317251.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_317251", "317251031", "story_v_out_317251.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_10 and arg_142_1.time_ < var_145_0 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play317251032 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 317251032
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play317251033(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.65

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_2 = arg_146_1:GetWordFromCfg(317251032)
				local var_149_3 = arg_146_1:FormatText(var_149_2.content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 26
				local var_149_5 = utf8.len(var_149_3)
				local var_149_6 = var_149_4 <= 0 and var_149_1 or var_149_1 * (var_149_5 / var_149_4)

				if var_149_6 > 0 and var_149_1 < var_149_6 then
					arg_146_1.talkMaxDuration = var_149_6

					if var_149_6 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_6 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_7 and arg_146_1.time_ < var_149_0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play317251033 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 317251033
		arg_150_1.duration_ = 8.63

		local var_150_0 = {
			zh = 8.633,
			ja = 6.2
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play317251034(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.975

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[93].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:GetWordFromCfg(317251033)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 39
				local var_153_6 = utf8.len(var_153_4)
				local var_153_7 = var_153_5 <= 0 and var_153_1 or var_153_1 * (var_153_6 / var_153_5)

				if var_153_7 > 0 and var_153_1 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251033", "story_v_out_317251.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_317251", "317251033", "story_v_out_317251.awb") / 1000

					if var_153_8 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_0
					end

					if var_153_3.prefab_name ~= "" and arg_150_1.actors_[var_153_3.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_3.prefab_name].transform, "story_v_out_317251", "317251033", "story_v_out_317251.awb")

						arg_150_1:RecordAudio("317251033", var_153_9)
						arg_150_1:RecordAudio("317251033", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_317251", "317251033", "story_v_out_317251.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_317251", "317251033", "story_v_out_317251.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_10 and arg_150_1.time_ < var_153_0 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play317251034 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 317251034
		arg_154_1.duration_ = 9.5

		local var_154_0 = {
			zh = 5.9,
			ja = 9.5
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play317251035(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 0.575

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_2 = arg_154_1:FormatText(StoryNameCfg[93].name)

				arg_154_1.leftNameTxt_.text = var_157_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_3 = arg_154_1:GetWordFromCfg(317251034)
				local var_157_4 = arg_154_1:FormatText(var_157_3.content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 23
				local var_157_6 = utf8.len(var_157_4)
				local var_157_7 = var_157_5 <= 0 and var_157_1 or var_157_1 * (var_157_6 / var_157_5)

				if var_157_7 > 0 and var_157_1 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251034", "story_v_out_317251.awb") ~= 0 then
					local var_157_8 = manager.audio:GetVoiceLength("story_v_out_317251", "317251034", "story_v_out_317251.awb") / 1000

					if var_157_8 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_8 + var_157_0
					end

					if var_157_3.prefab_name ~= "" and arg_154_1.actors_[var_157_3.prefab_name] ~= nil then
						local var_157_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_3.prefab_name].transform, "story_v_out_317251", "317251034", "story_v_out_317251.awb")

						arg_154_1:RecordAudio("317251034", var_157_9)
						arg_154_1:RecordAudio("317251034", var_157_9)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_317251", "317251034", "story_v_out_317251.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_317251", "317251034", "story_v_out_317251.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_10 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_10 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_10

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_10 and arg_154_1.time_ < var_157_0 + var_157_10 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play317251035 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 317251035
		arg_158_1.duration_ = 7.27

		local var_158_0 = {
			zh = 1.666,
			ja = 7.266
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play317251036(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.125

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[93].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:GetWordFromCfg(317251035)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 5
				local var_161_6 = utf8.len(var_161_4)
				local var_161_7 = var_161_5 <= 0 and var_161_1 or var_161_1 * (var_161_6 / var_161_5)

				if var_161_7 > 0 and var_161_1 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251035", "story_v_out_317251.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_317251", "317251035", "story_v_out_317251.awb") / 1000

					if var_161_8 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_0
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_out_317251", "317251035", "story_v_out_317251.awb")

						arg_158_1:RecordAudio("317251035", var_161_9)
						arg_158_1:RecordAudio("317251035", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_317251", "317251035", "story_v_out_317251.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_317251", "317251035", "story_v_out_317251.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_10 and arg_158_1.time_ < var_161_0 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play317251036 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 317251036
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
			arg_162_1.auto_ = false
		end

		function arg_162_1.playNext_(arg_164_0)
			arg_162_1.onStoryFinished_()
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1.275

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_2 = arg_162_1:GetWordFromCfg(317251036)
				local var_165_3 = arg_162_1:FormatText(var_165_2.content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 51
				local var_165_5 = utf8.len(var_165_3)
				local var_165_6 = var_165_4 <= 0 and var_165_1 or var_165_1 * (var_165_5 / var_165_4)

				if var_165_6 > 0 and var_165_1 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_7 and arg_162_1.time_ < var_165_0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K11f",
		"TextureConfig/Background/K12f",
		"TextureConfig/Background/ST58"
	},
	voices = {
		"story_v_out_317251.awb"
	}
}
