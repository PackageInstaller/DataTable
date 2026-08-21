return {
	Play123122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123122001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play123122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K07g"

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
				local var_4_5 = arg_1_1.bgs_.K07g

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
					if iter_4_0 ~= "K07g" then
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
			local var_4_23 = 0.866666666666667

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

			local var_4_28 = 2
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu")

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
			local var_4_35 = 1.35

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

				local var_4_37 = arg_1_1:GetWordFromCfg(123122001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 54
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
	Play123122002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 123122002
		arg_9_1.duration_ = 5.3

		local var_9_0 = {
			zh = 4.6,
			ja = 5.3
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
				arg_9_0:Play123122003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "3044ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "3044ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "3044ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["3044ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos3044ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -2.22, -2.4)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos3044ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -2.22, -2.4)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["3044ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect3044ui_story == nil then
				arg_9_1.var_.characterEffect3044ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect3044ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect3044ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect3044ui_story then
				arg_9_1.var_.characterEffect3044ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("3044ui_story", "StoryTimeline/CharAction/story3044/story3044action/3044action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("3044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.475

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[501].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(123122002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122002", "story_v_out_123122.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_123122", "123122002", "story_v_out_123122.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_123122", "123122002", "story_v_out_123122.awb")

						arg_9_1:RecordAudio("123122002", var_12_29)
						arg_9_1:RecordAudio("123122002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_123122", "123122002", "story_v_out_123122.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_123122", "123122002", "story_v_out_123122.awb")
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
				actorName = "3044ui_story",
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
	Play123122003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 123122003
		arg_13_1.duration_ = 1.27

		local var_13_0 = {
			zh = 1.233,
			ja = 1.266
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
				arg_13_0:Play123122004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["3044ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos3044ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos3044ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, 100, 0)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = manager.ui.mainCamera.transform
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = var_16_9.localPosition
			end

			local var_16_11 = 0.6

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / 0.066
				local var_16_13, var_16_14 = math.modf(var_16_12)

				var_16_9.localPosition = Vector3.New(var_16_14 * 0.13, var_16_14 * 0.13, var_16_14 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 then
				var_16_9.localPosition = arg_13_1.var_.shakeOldPos
			end

			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			local var_16_16 = 0.6

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_17 = 0
			local var_16_18 = 0.125

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_19 = arg_13_1:FormatText(StoryNameCfg[494].name)

				arg_13_1.leftNameTxt_.text = var_16_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2089")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_20 = arg_13_1:GetWordFromCfg(123122003)
				local var_16_21 = arg_13_1:FormatText(var_16_20.content)

				arg_13_1.text_.text = var_16_21

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_22 = 5
				local var_16_23 = utf8.len(var_16_21)
				local var_16_24 = var_16_22 <= 0 and var_16_18 or var_16_18 * (var_16_23 / var_16_22)

				if var_16_24 > 0 and var_16_18 < var_16_24 then
					arg_13_1.talkMaxDuration = var_16_24

					if var_16_24 + var_16_17 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_24 + var_16_17
					end
				end

				arg_13_1.text_.text = var_16_21
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122003", "story_v_out_123122.awb") ~= 0 then
					local var_16_25 = manager.audio:GetVoiceLength("story_v_out_123122", "123122003", "story_v_out_123122.awb") / 1000

					if var_16_25 + var_16_17 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_25 + var_16_17
					end

					if var_16_20.prefab_name ~= "" and arg_13_1.actors_[var_16_20.prefab_name] ~= nil then
						local var_16_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_20.prefab_name].transform, "story_v_out_123122", "123122003", "story_v_out_123122.awb")

						arg_13_1:RecordAudio("123122003", var_16_26)
						arg_13_1:RecordAudio("123122003", var_16_26)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_123122", "123122003", "story_v_out_123122.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_123122", "123122003", "story_v_out_123122.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_27 = math.max(var_16_18, arg_13_1.talkMaxDuration)

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_27 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_17) / var_16_27

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_17 + var_16_27 and arg_13_1.time_ < var_16_17 + var_16_27 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3044ui_story",
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
	Play123122004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 123122004
		arg_17_1.duration_ = 4.8

		local var_17_0 = {
			zh = 2.5,
			ja = 4.8
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
				arg_17_0:Play123122005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1093ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["1093ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1093ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0, -1.11, -5.88)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1093ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1093ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1093ui_story == nil then
				arg_17_1.var_.characterEffect1093ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1093ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1093ui_story then
				arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_20_20 = 0
			local var_20_21 = 0.3

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[73].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(123122004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 12
				local var_20_26 = utf8.len(var_20_24)
				local var_20_27 = var_20_25 <= 0 and var_20_21 or var_20_21 * (var_20_26 / var_20_25)

				if var_20_27 > 0 and var_20_21 < var_20_27 then
					arg_17_1.talkMaxDuration = var_20_27

					if var_20_27 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_24
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122004", "story_v_out_123122.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_out_123122", "123122004", "story_v_out_123122.awb") / 1000

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end

					if var_20_23.prefab_name ~= "" and arg_17_1.actors_[var_20_23.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_23.prefab_name].transform, "story_v_out_123122", "123122004", "story_v_out_123122.awb")

						arg_17_1:RecordAudio("123122004", var_20_29)
						arg_17_1:RecordAudio("123122004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_123122", "123122004", "story_v_out_123122.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_123122", "123122004", "story_v_out_123122.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_30 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_30 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_30

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_30 and arg_17_1.time_ < var_20_20 + var_20_30 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play123122005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 123122005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play123122006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1093ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1093ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1093ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1093ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1093ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 1

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				local var_24_8 = "play"
				local var_24_9 = "effect"

				arg_21_1:AudioAction(var_24_8, var_24_9, "se_story_123_01", "se_story_123_01_flame1", "")
			end

			local var_24_10 = 0
			local var_24_11 = 1.125

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_12 = arg_21_1:GetWordFromCfg(123122005)
				local var_24_13 = arg_21_1:FormatText(var_24_12.content)

				arg_21_1.text_.text = var_24_13

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_14 = 45
				local var_24_15 = utf8.len(var_24_13)
				local var_24_16 = var_24_14 <= 0 and var_24_11 or var_24_11 * (var_24_15 / var_24_14)

				if var_24_16 > 0 and var_24_11 < var_24_16 then
					arg_21_1.talkMaxDuration = var_24_16

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_13
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_17 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_17 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_17

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_17 and arg_21_1.time_ < var_24_10 + var_24_17 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play123122006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 123122006
		arg_25_1.duration_ = 6.57

		local var_25_0 = {
			zh = 6.266,
			ja = 6.566
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
				arg_25_0:Play123122007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1093ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1093ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1093ui_story then
				arg_25_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_28_6 = 0
			local var_28_7 = 0.75

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[73].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(123122006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122006", "story_v_out_123122.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_123122", "123122006", "story_v_out_123122.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_123122", "123122006", "story_v_out_123122.awb")

						arg_25_1:RecordAudio("123122006", var_28_15)
						arg_25_1:RecordAudio("123122006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_123122", "123122006", "story_v_out_123122.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_123122", "123122006", "story_v_out_123122.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_16 and arg_25_1.time_ < var_28_6 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play123122007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 123122007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play123122008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1093ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1093ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, 100, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1093ui_story, var_32_4, var_32_3)

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

			local var_32_9 = arg_29_1.actors_["1093ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1093ui_story == nil then
				arg_29_1.var_.characterEffect1093ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1093ui_story and not isNil(var_32_9) then
					local var_32_13 = Mathf.Lerp(0, 0.5, var_32_12)

					arg_29_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1093ui_story.fillRatio = var_32_13
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1093ui_story then
				local var_32_14 = 0.5

				arg_29_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1093ui_story.fillRatio = var_32_14
			end

			local var_32_15 = 0
			local var_32_16 = 0.725

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_17 = arg_29_1:GetWordFromCfg(123122007)
				local var_32_18 = arg_29_1:FormatText(var_32_17.content)

				arg_29_1.text_.text = var_32_18

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_19 = 29
				local var_32_20 = utf8.len(var_32_18)
				local var_32_21 = var_32_19 <= 0 and var_32_16 or var_32_16 * (var_32_20 / var_32_19)

				if var_32_21 > 0 and var_32_16 < var_32_21 then
					arg_29_1.talkMaxDuration = var_32_21

					if var_32_21 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_21 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_18
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_22 and arg_29_1.time_ < var_32_15 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play123122008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 123122008
		arg_33_1.duration_ = 2.27

		local var_33_0 = {
			zh = 1.999999999999,
			ja = 2.266
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
				arg_33_0:Play123122009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["3044ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos3044ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, -2.22, -2.4)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos3044ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -2.22, -2.4)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["3044ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect3044ui_story == nil then
				arg_33_1.var_.characterEffect3044ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect3044ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect3044ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect3044ui_story then
				arg_33_1.var_.characterEffect3044ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("3044ui_story", "StoryTimeline/CharAction/story3044/story3044action/3044action1_1")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("3044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_15 = 0
			local var_36_16 = 1

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				local var_36_17 = "stop"
				local var_36_18 = "effect"

				arg_33_1:AudioAction(var_36_17, var_36_18, "se_story_123_01", "se_story_123_01_flame1", "")
			end

			local var_36_19 = 0
			local var_36_20 = 0.2

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_21 = arg_33_1:FormatText(StoryNameCfg[501].name)

				arg_33_1.leftNameTxt_.text = var_36_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_22 = arg_33_1:GetWordFromCfg(123122008)
				local var_36_23 = arg_33_1:FormatText(var_36_22.content)

				arg_33_1.text_.text = var_36_23

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_24 = 8
				local var_36_25 = utf8.len(var_36_23)
				local var_36_26 = var_36_24 <= 0 and var_36_20 or var_36_20 * (var_36_25 / var_36_24)

				if var_36_26 > 0 and var_36_20 < var_36_26 then
					arg_33_1.talkMaxDuration = var_36_26

					if var_36_26 + var_36_19 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_26 + var_36_19
					end
				end

				arg_33_1.text_.text = var_36_23
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122008", "story_v_out_123122.awb") ~= 0 then
					local var_36_27 = manager.audio:GetVoiceLength("story_v_out_123122", "123122008", "story_v_out_123122.awb") / 1000

					if var_36_27 + var_36_19 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_27 + var_36_19
					end

					if var_36_22.prefab_name ~= "" and arg_33_1.actors_[var_36_22.prefab_name] ~= nil then
						local var_36_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_22.prefab_name].transform, "story_v_out_123122", "123122008", "story_v_out_123122.awb")

						arg_33_1:RecordAudio("123122008", var_36_28)
						arg_33_1:RecordAudio("123122008", var_36_28)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_123122", "123122008", "story_v_out_123122.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_123122", "123122008", "story_v_out_123122.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_29 = math.max(var_36_20, arg_33_1.talkMaxDuration)

			if var_36_19 <= arg_33_1.time_ and arg_33_1.time_ < var_36_19 + var_36_29 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_19) / var_36_29

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_19 + var_36_29 and arg_33_1.time_ < var_36_19 + var_36_29 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3044ui_story",
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
	Play123122009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 123122009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play123122010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["3044ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect3044ui_story == nil then
				arg_37_1.var_.characterEffect3044ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect3044ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect3044ui_story.fillFlat = true
					arg_37_1.var_.characterEffect3044ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect3044ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect3044ui_story.fillFlat = true
				arg_37_1.var_.characterEffect3044ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.3

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_8

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

				local var_40_9 = arg_37_1:GetWordFromCfg(123122009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 12
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_7 or var_40_7 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_7 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play123122010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 123122010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play123122011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.575

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(123122010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 63
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play123122011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 123122011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play123122012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.925

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(123122011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 37
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
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play123122012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 123122012
		arg_49_1.duration_ = 6.57

		local var_49_0 = {
			zh = 3.233,
			ja = 6.566
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
				arg_49_0:Play123122013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["3044ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect3044ui_story == nil then
				arg_49_1.var_.characterEffect3044ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect3044ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect3044ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect3044ui_story then
				arg_49_1.var_.characterEffect3044ui_story.fillFlat = false
			end

			local var_52_4 = 0
			local var_52_5 = 0.275

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_6 = arg_49_1:FormatText(StoryNameCfg[501].name)

				arg_49_1.leftNameTxt_.text = var_52_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(123122012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 11
				local var_52_10 = utf8.len(var_52_8)
				local var_52_11 = var_52_9 <= 0 and var_52_5 or var_52_5 * (var_52_10 / var_52_9)

				if var_52_11 > 0 and var_52_5 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122012", "story_v_out_123122.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_123122", "123122012", "story_v_out_123122.awb") / 1000

					if var_52_12 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_4
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_123122", "123122012", "story_v_out_123122.awb")

						arg_49_1:RecordAudio("123122012", var_52_13)
						arg_49_1:RecordAudio("123122012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_123122", "123122012", "story_v_out_123122.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_123122", "123122012", "story_v_out_123122.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_14 and arg_49_1.time_ < var_52_4 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play123122013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 123122013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play123122014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["3044ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect3044ui_story == nil then
				arg_53_1.var_.characterEffect3044ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect3044ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect3044ui_story.fillFlat = true
					arg_53_1.var_.characterEffect3044ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect3044ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect3044ui_story.fillFlat = true
				arg_53_1.var_.characterEffect3044ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 1.025

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(123122013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 41
				local var_56_11 = utf8.len(var_56_9)
				local var_56_12 = var_56_10 <= 0 and var_56_7 or var_56_7 * (var_56_11 / var_56_10)

				if var_56_12 > 0 and var_56_7 < var_56_12 then
					arg_53_1.talkMaxDuration = var_56_12

					if var_56_12 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_13 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_13

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_13 and arg_53_1.time_ < var_56_6 + var_56_13 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play123122014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 123122014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play123122015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.225

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_2

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

				local var_60_3 = arg_57_1:GetWordFromCfg(123122014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 9
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play123122015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 123122015
		arg_61_1.duration_ = 17.23

		local var_61_0 = {
			zh = 15.733,
			ja = 17.233
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
				arg_61_0:Play123122016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["3044ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect3044ui_story == nil then
				arg_61_1.var_.characterEffect3044ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect3044ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect3044ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect3044ui_story then
				arg_61_1.var_.characterEffect3044ui_story.fillFlat = false
			end

			local var_64_4 = 0
			local var_64_5 = 1.475

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_6 = arg_61_1:FormatText(StoryNameCfg[501].name)

				arg_61_1.leftNameTxt_.text = var_64_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(123122015)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 59
				local var_64_10 = utf8.len(var_64_8)
				local var_64_11 = var_64_9 <= 0 and var_64_5 or var_64_5 * (var_64_10 / var_64_9)

				if var_64_11 > 0 and var_64_5 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122015", "story_v_out_123122.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_123122", "123122015", "story_v_out_123122.awb") / 1000

					if var_64_12 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_4
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_123122", "123122015", "story_v_out_123122.awb")

						arg_61_1:RecordAudio("123122015", var_64_13)
						arg_61_1:RecordAudio("123122015", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_123122", "123122015", "story_v_out_123122.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_123122", "123122015", "story_v_out_123122.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_14 and arg_61_1.time_ < var_64_4 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play123122016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 123122016
		arg_65_1.duration_ = 9.67

		local var_65_0 = {
			zh = 8.1,
			ja = 9.666
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
				arg_65_0:Play123122017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.75

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[501].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(123122016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 30
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122016", "story_v_out_123122.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_123122", "123122016", "story_v_out_123122.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_123122", "123122016", "story_v_out_123122.awb")

						arg_65_1:RecordAudio("123122016", var_68_9)
						arg_65_1:RecordAudio("123122016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_123122", "123122016", "story_v_out_123122.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_123122", "123122016", "story_v_out_123122.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play123122017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 123122017
		arg_69_1.duration_ = 7.47

		local var_69_0 = {
			zh = 3.966,
			ja = 7.466
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
				arg_69_0:Play123122018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.3

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[501].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(123122017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 12
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122017", "story_v_out_123122.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_123122", "123122017", "story_v_out_123122.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_123122", "123122017", "story_v_out_123122.awb")

						arg_69_1:RecordAudio("123122017", var_72_9)
						arg_69_1:RecordAudio("123122017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_123122", "123122017", "story_v_out_123122.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_123122", "123122017", "story_v_out_123122.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play123122018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 123122018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play123122019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["3044ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect3044ui_story == nil then
				arg_73_1.var_.characterEffect3044ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect3044ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect3044ui_story.fillFlat = true
					arg_73_1.var_.characterEffect3044ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect3044ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect3044ui_story.fillFlat = true
				arg_73_1.var_.characterEffect3044ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 1.4

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(123122018)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 56
				local var_76_11 = utf8.len(var_76_9)
				local var_76_12 = var_76_10 <= 0 and var_76_7 or var_76_7 * (var_76_11 / var_76_10)

				if var_76_12 > 0 and var_76_7 < var_76_12 then
					arg_73_1.talkMaxDuration = var_76_12

					if var_76_12 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_13 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_13 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_13

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_13 and arg_73_1.time_ < var_76_6 + var_76_13 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play123122019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 123122019
		arg_77_1.duration_ = 3.3

		local var_77_0 = {
			zh = 1.999999999999,
			ja = 3.3
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
				arg_77_0:Play123122020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "1055ui_story"

			if arg_77_1.actors_[var_80_0] == nil then
				local var_80_1 = Asset.Load("Char/" .. "1055ui_story")

				if not isNil(var_80_1) then
					local var_80_2 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_77_1.stage_.transform)

					var_80_2.name = var_80_0
					var_80_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_77_1.actors_[var_80_0] = var_80_2

					local var_80_3 = var_80_2:GetComponentInChildren(typeof(CharacterEffect))

					var_80_3.enabled = true

					local var_80_4 = GameObjectTools.GetOrAddComponent(var_80_2, typeof(DynamicBoneHelper))

					if var_80_4 then
						var_80_4:EnableDynamicBone(false)
					end

					arg_77_1:ShowWeapon(var_80_3.transform, false)

					arg_77_1.var_[var_80_0 .. "Animator"] = var_80_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_77_1.var_[var_80_0 .. "Animator"].applyRootMotion = true
					arg_77_1.var_[var_80_0 .. "LipSync"] = var_80_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_80_5 = arg_77_1.actors_["1055ui_story"].transform
			local var_80_6 = 0

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.var_.moveOldPos1055ui_story = var_80_5.localPosition
			end

			local var_80_7 = 0.001

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_7 then
				local var_80_8 = (arg_77_1.time_ - var_80_6) / var_80_7
				local var_80_9 = Vector3.New(0, -0.965, -6.2)

				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1055ui_story, var_80_9, var_80_8)

				local var_80_10 = manager.ui.mainCamera.transform.position - var_80_5.position

				var_80_5.forward = Vector3.New(var_80_10.x, var_80_10.y, var_80_10.z)

				local var_80_11 = var_80_5.localEulerAngles

				var_80_11.z = 0
				var_80_11.x = 0
				var_80_5.localEulerAngles = var_80_11
			end

			if arg_77_1.time_ >= var_80_6 + var_80_7 and arg_77_1.time_ < var_80_6 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_80_12 = manager.ui.mainCamera.transform.position - var_80_5.position

				var_80_5.forward = Vector3.New(var_80_12.x, var_80_12.y, var_80_12.z)

				local var_80_13 = var_80_5.localEulerAngles

				var_80_13.z = 0
				var_80_13.x = 0
				var_80_5.localEulerAngles = var_80_13
			end

			local var_80_14 = arg_77_1.actors_["1055ui_story"]
			local var_80_15 = 0

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect1055ui_story == nil then
				arg_77_1.var_.characterEffect1055ui_story = var_80_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_16 = 0.200000002980232

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_16 and not isNil(var_80_14) then
				local var_80_17 = (arg_77_1.time_ - var_80_15) / var_80_16

				if arg_77_1.var_.characterEffect1055ui_story and not isNil(var_80_14) then
					arg_77_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_15 + var_80_16 and arg_77_1.time_ < var_80_15 + var_80_16 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect1055ui_story then
				arg_77_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_80_18 = 0

			if var_80_18 < arg_77_1.time_ and arg_77_1.time_ <= var_80_18 + arg_80_0 then
				arg_77_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_80_19 = 0

			if var_80_19 < arg_77_1.time_ and arg_77_1.time_ <= var_80_19 + arg_80_0 then
				arg_77_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_80_20 = arg_77_1.actors_["3044ui_story"].transform
			local var_80_21 = 0

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.var_.moveOldPos3044ui_story = var_80_20.localPosition
			end

			local var_80_22 = 0.001

			if var_80_21 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_22 then
				local var_80_23 = (arg_77_1.time_ - var_80_21) / var_80_22
				local var_80_24 = Vector3.New(0, 100, 0)

				var_80_20.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos3044ui_story, var_80_24, var_80_23)

				local var_80_25 = manager.ui.mainCamera.transform.position - var_80_20.position

				var_80_20.forward = Vector3.New(var_80_25.x, var_80_25.y, var_80_25.z)

				local var_80_26 = var_80_20.localEulerAngles

				var_80_26.z = 0
				var_80_26.x = 0
				var_80_20.localEulerAngles = var_80_26
			end

			if arg_77_1.time_ >= var_80_21 + var_80_22 and arg_77_1.time_ < var_80_21 + var_80_22 + arg_80_0 then
				var_80_20.localPosition = Vector3.New(0, 100, 0)

				local var_80_27 = manager.ui.mainCamera.transform.position - var_80_20.position

				var_80_20.forward = Vector3.New(var_80_27.x, var_80_27.y, var_80_27.z)

				local var_80_28 = var_80_20.localEulerAngles

				var_80_28.z = 0
				var_80_28.x = 0
				var_80_20.localEulerAngles = var_80_28
			end

			local var_80_29 = 0
			local var_80_30 = 0.2

			if var_80_29 < arg_77_1.time_ and arg_77_1.time_ <= var_80_29 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_31 = arg_77_1:FormatText(StoryNameCfg[481].name)

				arg_77_1.leftNameTxt_.text = var_80_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_32 = arg_77_1:GetWordFromCfg(123122019)
				local var_80_33 = arg_77_1:FormatText(var_80_32.content)

				arg_77_1.text_.text = var_80_33

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_34 = 8
				local var_80_35 = utf8.len(var_80_33)
				local var_80_36 = var_80_34 <= 0 and var_80_30 or var_80_30 * (var_80_35 / var_80_34)

				if var_80_36 > 0 and var_80_30 < var_80_36 then
					arg_77_1.talkMaxDuration = var_80_36

					if var_80_36 + var_80_29 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_36 + var_80_29
					end
				end

				arg_77_1.text_.text = var_80_33
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122019", "story_v_out_123122.awb") ~= 0 then
					local var_80_37 = manager.audio:GetVoiceLength("story_v_out_123122", "123122019", "story_v_out_123122.awb") / 1000

					if var_80_37 + var_80_29 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_37 + var_80_29
					end

					if var_80_32.prefab_name ~= "" and arg_77_1.actors_[var_80_32.prefab_name] ~= nil then
						local var_80_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_32.prefab_name].transform, "story_v_out_123122", "123122019", "story_v_out_123122.awb")

						arg_77_1:RecordAudio("123122019", var_80_38)
						arg_77_1:RecordAudio("123122019", var_80_38)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_123122", "123122019", "story_v_out_123122.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_123122", "123122019", "story_v_out_123122.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_39 = math.max(var_80_30, arg_77_1.talkMaxDuration)

			if var_80_29 <= arg_77_1.time_ and arg_77_1.time_ < var_80_29 + var_80_39 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_29) / var_80_39

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_29 + var_80_39 and arg_77_1.time_ < var_80_29 + var_80_39 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3044ui_story",
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
	Play123122020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 123122020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play123122021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1055ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1055ui_story == nil then
				arg_81_1.var_.characterEffect1055ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1055ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1055ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1055ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1055ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.1

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_9 = arg_81_1:GetWordFromCfg(123122020)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 4
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play123122021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 123122021
		arg_85_1.duration_ = 2.93

		local var_85_0 = {
			zh = 2.5,
			ja = 2.933
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
				arg_85_0:Play123122022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1055ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1055ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, 100, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1055ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, 100, 0)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = manager.ui.mainCamera.transform
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.var_.shakeOldPos = var_88_9.localPosition
			end

			local var_88_11 = 0.6

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / 0.066
				local var_88_13, var_88_14 = math.modf(var_88_12)

				var_88_9.localPosition = Vector3.New(var_88_14 * 0.13, var_88_14 * 0.13, var_88_14 * 0.13) + arg_85_1.var_.shakeOldPos
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 then
				var_88_9.localPosition = arg_85_1.var_.shakeOldPos
			end

			local var_88_15 = 0

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			local var_88_16 = 0.6

			if arg_85_1.time_ >= var_88_15 + var_88_16 and arg_85_1.time_ < var_88_15 + var_88_16 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			local var_88_17 = 0
			local var_88_18 = 0.2

			if var_88_17 < arg_85_1.time_ and arg_85_1.time_ <= var_88_17 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_19 = arg_85_1:FormatText(StoryNameCfg[501].name)

				arg_85_1.leftNameTxt_.text = var_88_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3044")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_20 = arg_85_1:GetWordFromCfg(123122021)
				local var_88_21 = arg_85_1:FormatText(var_88_20.content)

				arg_85_1.text_.text = var_88_21

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_22 = 8
				local var_88_23 = utf8.len(var_88_21)
				local var_88_24 = var_88_22 <= 0 and var_88_18 or var_88_18 * (var_88_23 / var_88_22)

				if var_88_24 > 0 and var_88_18 < var_88_24 then
					arg_85_1.talkMaxDuration = var_88_24

					if var_88_24 + var_88_17 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_17
					end
				end

				arg_85_1.text_.text = var_88_21
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122021", "story_v_out_123122.awb") ~= 0 then
					local var_88_25 = manager.audio:GetVoiceLength("story_v_out_123122", "123122021", "story_v_out_123122.awb") / 1000

					if var_88_25 + var_88_17 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_25 + var_88_17
					end

					if var_88_20.prefab_name ~= "" and arg_85_1.actors_[var_88_20.prefab_name] ~= nil then
						local var_88_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_20.prefab_name].transform, "story_v_out_123122", "123122021", "story_v_out_123122.awb")

						arg_85_1:RecordAudio("123122021", var_88_26)
						arg_85_1:RecordAudio("123122021", var_88_26)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_123122", "123122021", "story_v_out_123122.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_123122", "123122021", "story_v_out_123122.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_27 = math.max(var_88_18, arg_85_1.talkMaxDuration)

			if var_88_17 <= arg_85_1.time_ and arg_85_1.time_ < var_88_17 + var_88_27 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_17) / var_88_27

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_17 + var_88_27 and arg_85_1.time_ < var_88_17 + var_88_27 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123122022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 123122022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play123122023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.025

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

				local var_92_2 = arg_89_1:GetWordFromCfg(123122022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 41
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
	Play123122023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 123122023
		arg_93_1.duration_ = 5.57

		local var_93_0 = {
			zh = 3.2,
			ja = 5.566
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
				arg_93_0:Play123122024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1093ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1093ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, -1.11, -5.88)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1093ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1093ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1093ui_story == nil then
				arg_93_1.var_.characterEffect1093ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1093ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1093ui_story then
				arg_93_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_96_13 = 0

			if var_96_13 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_96_15 = 0
			local var_96_16 = 0.375

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[73].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(123122023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 15
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122023", "story_v_out_123122.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_123122", "123122023", "story_v_out_123122.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_123122", "123122023", "story_v_out_123122.awb")

						arg_93_1:RecordAudio("123122023", var_96_24)
						arg_93_1:RecordAudio("123122023", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_123122", "123122023", "story_v_out_123122.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_123122", "123122023", "story_v_out_123122.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play123122024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 123122024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play123122025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1093ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1093ui_story == nil then
				arg_97_1.var_.characterEffect1093ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1093ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1093ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1093ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1093ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.5

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(123122024)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 20
				local var_100_11 = utf8.len(var_100_9)
				local var_100_12 = var_100_10 <= 0 and var_100_7 or var_100_7 * (var_100_11 / var_100_10)

				if var_100_12 > 0 and var_100_7 < var_100_12 then
					arg_97_1.talkMaxDuration = var_100_12

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_13 and arg_97_1.time_ < var_100_6 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play123122025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 123122025
		arg_101_1.duration_ = 6.53

		local var_101_0 = {
			zh = 3.4,
			ja = 6.533
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
				arg_101_0:Play123122026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1093ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1093ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(-0.7, -1.11, -5.88)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1093ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1093ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1093ui_story == nil then
				arg_101_1.var_.characterEffect1093ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1093ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1093ui_story then
				arg_101_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_104_14 = arg_101_1.actors_["1055ui_story"].transform
			local var_104_15 = 0

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.var_.moveOldPos1055ui_story = var_104_14.localPosition
			end

			local var_104_16 = 0.001

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_16 then
				local var_104_17 = (arg_101_1.time_ - var_104_15) / var_104_16
				local var_104_18 = Vector3.New(0.7, -0.965, -6.2)

				var_104_14.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1055ui_story, var_104_18, var_104_17)

				local var_104_19 = manager.ui.mainCamera.transform.position - var_104_14.position

				var_104_14.forward = Vector3.New(var_104_19.x, var_104_19.y, var_104_19.z)

				local var_104_20 = var_104_14.localEulerAngles

				var_104_20.z = 0
				var_104_20.x = 0
				var_104_14.localEulerAngles = var_104_20
			end

			if arg_101_1.time_ >= var_104_15 + var_104_16 and arg_101_1.time_ < var_104_15 + var_104_16 + arg_104_0 then
				var_104_14.localPosition = Vector3.New(0.7, -0.965, -6.2)

				local var_104_21 = manager.ui.mainCamera.transform.position - var_104_14.position

				var_104_14.forward = Vector3.New(var_104_21.x, var_104_21.y, var_104_21.z)

				local var_104_22 = var_104_14.localEulerAngles

				var_104_22.z = 0
				var_104_22.x = 0
				var_104_14.localEulerAngles = var_104_22
			end

			local var_104_23 = 0

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_104_24 = 0

			if var_104_24 < arg_101_1.time_ and arg_101_1.time_ <= var_104_24 + arg_104_0 then
				arg_101_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_104_25 = 0
			local var_104_26 = 0.55

			if var_104_25 < arg_101_1.time_ and arg_101_1.time_ <= var_104_25 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_27 = arg_101_1:FormatText(StoryNameCfg[73].name)

				arg_101_1.leftNameTxt_.text = var_104_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_28 = arg_101_1:GetWordFromCfg(123122025)
				local var_104_29 = arg_101_1:FormatText(var_104_28.content)

				arg_101_1.text_.text = var_104_29

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_30 = 22
				local var_104_31 = utf8.len(var_104_29)
				local var_104_32 = var_104_30 <= 0 and var_104_26 or var_104_26 * (var_104_31 / var_104_30)

				if var_104_32 > 0 and var_104_26 < var_104_32 then
					arg_101_1.talkMaxDuration = var_104_32

					if var_104_32 + var_104_25 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_32 + var_104_25
					end
				end

				arg_101_1.text_.text = var_104_29
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122025", "story_v_out_123122.awb") ~= 0 then
					local var_104_33 = manager.audio:GetVoiceLength("story_v_out_123122", "123122025", "story_v_out_123122.awb") / 1000

					if var_104_33 + var_104_25 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_33 + var_104_25
					end

					if var_104_28.prefab_name ~= "" and arg_101_1.actors_[var_104_28.prefab_name] ~= nil then
						local var_104_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_28.prefab_name].transform, "story_v_out_123122", "123122025", "story_v_out_123122.awb")

						arg_101_1:RecordAudio("123122025", var_104_34)
						arg_101_1:RecordAudio("123122025", var_104_34)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_123122", "123122025", "story_v_out_123122.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_123122", "123122025", "story_v_out_123122.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_35 = math.max(var_104_26, arg_101_1.talkMaxDuration)

			if var_104_25 <= arg_101_1.time_ and arg_101_1.time_ < var_104_25 + var_104_35 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_25) / var_104_35

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_25 + var_104_35 and arg_101_1.time_ < var_104_25 + var_104_35 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play123122026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 123122026
		arg_105_1.duration_ = 12.13

		local var_105_0 = {
			zh = 9.966,
			ja = 12.133
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
				arg_105_0:Play123122027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1055ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1055ui_story == nil then
				arg_105_1.var_.characterEffect1055ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1055ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1055ui_story then
				arg_105_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_108_4 = 0

			if var_108_4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			local var_108_5 = 0

			if var_108_5 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_108_6 = arg_105_1.actors_["1093ui_story"]
			local var_108_7 = 0

			if var_108_7 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1093ui_story == nil then
				arg_105_1.var_.characterEffect1093ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_8 = 0.200000002980232

			if var_108_7 <= arg_105_1.time_ and arg_105_1.time_ < var_108_7 + var_108_8 and not isNil(var_108_6) then
				local var_108_9 = (arg_105_1.time_ - var_108_7) / var_108_8

				if arg_105_1.var_.characterEffect1093ui_story and not isNil(var_108_6) then
					local var_108_10 = Mathf.Lerp(0, 0.5, var_108_9)

					arg_105_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1093ui_story.fillRatio = var_108_10
				end
			end

			if arg_105_1.time_ >= var_108_7 + var_108_8 and arg_105_1.time_ < var_108_7 + var_108_8 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1093ui_story then
				local var_108_11 = 0.5

				arg_105_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1093ui_story.fillRatio = var_108_11
			end

			local var_108_12 = 0
			local var_108_13 = 1.1

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_14 = arg_105_1:FormatText(StoryNameCfg[481].name)

				arg_105_1.leftNameTxt_.text = var_108_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_15 = arg_105_1:GetWordFromCfg(123122026)
				local var_108_16 = arg_105_1:FormatText(var_108_15.content)

				arg_105_1.text_.text = var_108_16

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 44
				local var_108_18 = utf8.len(var_108_16)
				local var_108_19 = var_108_17 <= 0 and var_108_13 or var_108_13 * (var_108_18 / var_108_17)

				if var_108_19 > 0 and var_108_13 < var_108_19 then
					arg_105_1.talkMaxDuration = var_108_19

					if var_108_19 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_19 + var_108_12
					end
				end

				arg_105_1.text_.text = var_108_16
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122026", "story_v_out_123122.awb") ~= 0 then
					local var_108_20 = manager.audio:GetVoiceLength("story_v_out_123122", "123122026", "story_v_out_123122.awb") / 1000

					if var_108_20 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_20 + var_108_12
					end

					if var_108_15.prefab_name ~= "" and arg_105_1.actors_[var_108_15.prefab_name] ~= nil then
						local var_108_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_15.prefab_name].transform, "story_v_out_123122", "123122026", "story_v_out_123122.awb")

						arg_105_1:RecordAudio("123122026", var_108_21)
						arg_105_1:RecordAudio("123122026", var_108_21)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_123122", "123122026", "story_v_out_123122.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_123122", "123122026", "story_v_out_123122.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_22 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_22 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_12) / var_108_22

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_22 and arg_105_1.time_ < var_108_12 + var_108_22 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play123122027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 123122027
		arg_109_1.duration_ = 2.1

		local var_109_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_109_0:Play123122028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1093ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1093ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(-0.7, -1.11, -5.88)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1093ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1093ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1093ui_story == nil then
				arg_109_1.var_.characterEffect1093ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1093ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1093ui_story then
				arg_109_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_2")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_112_15 = arg_109_1.actors_["1055ui_story"]
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.characterEffect1055ui_story == nil then
				arg_109_1.var_.characterEffect1055ui_story = var_112_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_17 = 0.200000002980232

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 and not isNil(var_112_15) then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17

				if arg_109_1.var_.characterEffect1055ui_story and not isNil(var_112_15) then
					local var_112_19 = Mathf.Lerp(0, 0.5, var_112_18)

					arg_109_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1055ui_story.fillRatio = var_112_19
				end
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.characterEffect1055ui_story then
				local var_112_20 = 0.5

				arg_109_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1055ui_story.fillRatio = var_112_20
			end

			local var_112_21 = 0
			local var_112_22 = 0.125

			if var_112_21 < arg_109_1.time_ and arg_109_1.time_ <= var_112_21 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_23 = arg_109_1:FormatText(StoryNameCfg[73].name)

				arg_109_1.leftNameTxt_.text = var_112_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_24 = arg_109_1:GetWordFromCfg(123122027)
				local var_112_25 = arg_109_1:FormatText(var_112_24.content)

				arg_109_1.text_.text = var_112_25

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_26 = 5
				local var_112_27 = utf8.len(var_112_25)
				local var_112_28 = var_112_26 <= 0 and var_112_22 or var_112_22 * (var_112_27 / var_112_26)

				if var_112_28 > 0 and var_112_22 < var_112_28 then
					arg_109_1.talkMaxDuration = var_112_28

					if var_112_28 + var_112_21 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_28 + var_112_21
					end
				end

				arg_109_1.text_.text = var_112_25
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122027", "story_v_out_123122.awb") ~= 0 then
					local var_112_29 = manager.audio:GetVoiceLength("story_v_out_123122", "123122027", "story_v_out_123122.awb") / 1000

					if var_112_29 + var_112_21 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_29 + var_112_21
					end

					if var_112_24.prefab_name ~= "" and arg_109_1.actors_[var_112_24.prefab_name] ~= nil then
						local var_112_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_24.prefab_name].transform, "story_v_out_123122", "123122027", "story_v_out_123122.awb")

						arg_109_1:RecordAudio("123122027", var_112_30)
						arg_109_1:RecordAudio("123122027", var_112_30)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_123122", "123122027", "story_v_out_123122.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_123122", "123122027", "story_v_out_123122.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_31 = math.max(var_112_22, arg_109_1.talkMaxDuration)

			if var_112_21 <= arg_109_1.time_ and arg_109_1.time_ < var_112_21 + var_112_31 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_21) / var_112_31

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_21 + var_112_31 and arg_109_1.time_ < var_112_21 + var_112_31 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play123122028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 123122028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play123122029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1093ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1093ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1093ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1093ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1093ui_story == nil then
				arg_113_1.var_.characterEffect1093ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect1093ui_story and not isNil(var_116_9) then
					local var_116_13 = Mathf.Lerp(0, 0.5, var_116_12)

					arg_113_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1093ui_story.fillRatio = var_116_13
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1093ui_story then
				local var_116_14 = 0.5

				arg_113_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1093ui_story.fillRatio = var_116_14
			end

			local var_116_15 = arg_113_1.actors_["1055ui_story"].transform
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.var_.moveOldPos1055ui_story = var_116_15.localPosition
			end

			local var_116_17 = 0.001

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17
				local var_116_19 = Vector3.New(0, 100, 0)

				var_116_15.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1055ui_story, var_116_19, var_116_18)

				local var_116_20 = manager.ui.mainCamera.transform.position - var_116_15.position

				var_116_15.forward = Vector3.New(var_116_20.x, var_116_20.y, var_116_20.z)

				local var_116_21 = var_116_15.localEulerAngles

				var_116_21.z = 0
				var_116_21.x = 0
				var_116_15.localEulerAngles = var_116_21
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 then
				var_116_15.localPosition = Vector3.New(0, 100, 0)

				local var_116_22 = manager.ui.mainCamera.transform.position - var_116_15.position

				var_116_15.forward = Vector3.New(var_116_22.x, var_116_22.y, var_116_22.z)

				local var_116_23 = var_116_15.localEulerAngles

				var_116_23.z = 0
				var_116_23.x = 0
				var_116_15.localEulerAngles = var_116_23
			end

			local var_116_24 = arg_113_1.actors_["1055ui_story"]
			local var_116_25 = 0

			if var_116_25 < arg_113_1.time_ and arg_113_1.time_ <= var_116_25 + arg_116_0 and not isNil(var_116_24) and arg_113_1.var_.characterEffect1055ui_story == nil then
				arg_113_1.var_.characterEffect1055ui_story = var_116_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_26 = 0.200000002980232

			if var_116_25 <= arg_113_1.time_ and arg_113_1.time_ < var_116_25 + var_116_26 and not isNil(var_116_24) then
				local var_116_27 = (arg_113_1.time_ - var_116_25) / var_116_26

				if arg_113_1.var_.characterEffect1055ui_story and not isNil(var_116_24) then
					local var_116_28 = Mathf.Lerp(0, 0.5, var_116_27)

					arg_113_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1055ui_story.fillRatio = var_116_28
				end
			end

			if arg_113_1.time_ >= var_116_25 + var_116_26 and arg_113_1.time_ < var_116_25 + var_116_26 + arg_116_0 and not isNil(var_116_24) and arg_113_1.var_.characterEffect1055ui_story then
				local var_116_29 = 0.5

				arg_113_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1055ui_story.fillRatio = var_116_29
			end

			local var_116_30 = 0
			local var_116_31 = 1

			if var_116_30 < arg_113_1.time_ and arg_113_1.time_ <= var_116_30 + arg_116_0 then
				local var_116_32 = "play"
				local var_116_33 = "effect"

				arg_113_1:AudioAction(var_116_32, var_116_33, "se_story_123_01", "se_story_123_01_iceshoot", "")
			end

			local var_116_34 = 0
			local var_116_35 = 0.625

			if var_116_34 < arg_113_1.time_ and arg_113_1.time_ <= var_116_34 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_36 = arg_113_1:GetWordFromCfg(123122028)
				local var_116_37 = arg_113_1:FormatText(var_116_36.content)

				arg_113_1.text_.text = var_116_37

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_38 = 25
				local var_116_39 = utf8.len(var_116_37)
				local var_116_40 = var_116_38 <= 0 and var_116_35 or var_116_35 * (var_116_39 / var_116_38)

				if var_116_40 > 0 and var_116_35 < var_116_40 then
					arg_113_1.talkMaxDuration = var_116_40

					if var_116_40 + var_116_34 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_40 + var_116_34
					end
				end

				arg_113_1.text_.text = var_116_37
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_41 = math.max(var_116_35, arg_113_1.talkMaxDuration)

			if var_116_34 <= arg_113_1.time_ and arg_113_1.time_ < var_116_34 + var_116_41 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_34) / var_116_41

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_34 + var_116_41 and arg_113_1.time_ < var_116_34 + var_116_41 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play123122029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 123122029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play123122030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_1 = 1

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_1 then
				local var_120_2 = (arg_117_1.time_ - var_120_0) / var_120_1
				local var_120_3 = Color.New(1, 1, 1)

				var_120_3.a = Mathf.Lerp(1, 0, var_120_2)
				arg_117_1.mask_.color = var_120_3
			end

			if arg_117_1.time_ >= var_120_0 + var_120_1 and arg_117_1.time_ < var_120_0 + var_120_1 + arg_120_0 then
				local var_120_4 = Color.New(1, 1, 1)
				local var_120_5 = 0

				arg_117_1.mask_.enabled = false
				var_120_4.a = var_120_5
				arg_117_1.mask_.color = var_120_4
			end

			local var_120_6 = manager.ui.mainCamera.transform
			local var_120_7 = 0.666666666666667

			if var_120_7 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1.var_.shakeOldPos = var_120_6.localPosition
			end

			local var_120_8 = 0.6

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_8 then
				local var_120_9 = (arg_117_1.time_ - var_120_7) / 0.066
				local var_120_10, var_120_11 = math.modf(var_120_9)

				var_120_6.localPosition = Vector3.New(var_120_11 * 0.13, var_120_11 * 0.13, var_120_11 * 0.13) + arg_117_1.var_.shakeOldPos
			end

			if arg_117_1.time_ >= var_120_7 + var_120_8 and arg_117_1.time_ < var_120_7 + var_120_8 + arg_120_0 then
				var_120_6.localPosition = arg_117_1.var_.shakeOldPos
			end

			local var_120_12 = 1

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			local var_120_13 = 0.266666666666667

			if arg_117_1.time_ >= var_120_12 + var_120_13 and arg_117_1.time_ < var_120_12 + var_120_13 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_14 = 0.7
			local var_120_15 = 1

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				local var_120_16 = "play"
				local var_120_17 = "effect"

				arg_117_1:AudioAction(var_120_16, var_120_17, "se_story_123_01", "se_story_123_01_vine", "")
			end

			local var_120_18 = 0
			local var_120_19 = 0.975

			if var_120_18 < arg_117_1.time_ and arg_117_1.time_ <= var_120_18 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_20 = arg_117_1:GetWordFromCfg(123122029)
				local var_120_21 = arg_117_1:FormatText(var_120_20.content)

				arg_117_1.text_.text = var_120_21

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_22 = 39
				local var_120_23 = utf8.len(var_120_21)
				local var_120_24 = var_120_22 <= 0 and var_120_19 or var_120_19 * (var_120_23 / var_120_22)

				if var_120_24 > 0 and var_120_19 < var_120_24 then
					arg_117_1.talkMaxDuration = var_120_24

					if var_120_24 + var_120_18 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_24 + var_120_18
					end
				end

				arg_117_1.text_.text = var_120_21
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_19, arg_117_1.talkMaxDuration)

			if var_120_18 <= arg_117_1.time_ and arg_117_1.time_ < var_120_18 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_18) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_18 + var_120_25 and arg_117_1.time_ < var_120_18 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play123122030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 123122030
		arg_121_1.duration_ = 2.4

		local var_121_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play123122031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1055ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1055ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, -0.965, -6.2)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1055ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_124_11 = arg_121_1.actors_["1055ui_story"]
			local var_124_12 = 0

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.characterEffect1055ui_story == nil then
				arg_121_1.var_.characterEffect1055ui_story = var_124_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_13 = 0.2

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_13 and not isNil(var_124_11) then
				local var_124_14 = (arg_121_1.time_ - var_124_12) / var_124_13

				if arg_121_1.var_.characterEffect1055ui_story and not isNil(var_124_11) then
					arg_121_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_12 + var_124_13 and arg_121_1.time_ < var_124_12 + var_124_13 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.characterEffect1055ui_story then
				arg_121_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_124_15 = 0
			local var_124_16 = 0.1

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[481].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(123122030)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 4
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122030", "story_v_out_123122.awb") ~= 0 then
					local var_124_23 = manager.audio:GetVoiceLength("story_v_out_123122", "123122030", "story_v_out_123122.awb") / 1000

					if var_124_23 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_15
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_123122", "123122030", "story_v_out_123122.awb")

						arg_121_1:RecordAudio("123122030", var_124_24)
						arg_121_1:RecordAudio("123122030", var_124_24)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_123122", "123122030", "story_v_out_123122.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_123122", "123122030", "story_v_out_123122.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_25 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_25 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_25

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_25 and arg_121_1.time_ < var_124_15 + var_124_25 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123122031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 123122031
		arg_125_1.duration_ = 4.4

		local var_125_0 = {
			zh = 4.4,
			ja = 4.2
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
				arg_125_0:Play123122032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["3044ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos3044ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, -2.22, -2.4)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos3044ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -2.22, -2.4)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["3044ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect3044ui_story == nil then
				arg_125_1.var_.characterEffect3044ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect3044ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect3044ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect3044ui_story then
				arg_125_1.var_.characterEffect3044ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("3044ui_story", "StoryTimeline/CharAction/story3044/story3044action/3044action1_1")
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("3044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_15 = arg_125_1.actors_["1055ui_story"].transform
			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.var_.moveOldPos1055ui_story = var_128_15.localPosition
			end

			local var_128_17 = 0.001

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17
				local var_128_19 = Vector3.New(0, 100, 0)

				var_128_15.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1055ui_story, var_128_19, var_128_18)

				local var_128_20 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_20.x, var_128_20.y, var_128_20.z)

				local var_128_21 = var_128_15.localEulerAngles

				var_128_21.z = 0
				var_128_21.x = 0
				var_128_15.localEulerAngles = var_128_21
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 then
				var_128_15.localPosition = Vector3.New(0, 100, 0)

				local var_128_22 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_22.x, var_128_22.y, var_128_22.z)

				local var_128_23 = var_128_15.localEulerAngles

				var_128_23.z = 0
				var_128_23.x = 0
				var_128_15.localEulerAngles = var_128_23
			end

			local var_128_24 = 0
			local var_128_25 = 0.325

			if var_128_24 < arg_125_1.time_ and arg_125_1.time_ <= var_128_24 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_26 = arg_125_1:FormatText(StoryNameCfg[501].name)

				arg_125_1.leftNameTxt_.text = var_128_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_27 = arg_125_1:GetWordFromCfg(123122031)
				local var_128_28 = arg_125_1:FormatText(var_128_27.content)

				arg_125_1.text_.text = var_128_28

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_29 = 13
				local var_128_30 = utf8.len(var_128_28)
				local var_128_31 = var_128_29 <= 0 and var_128_25 or var_128_25 * (var_128_30 / var_128_29)

				if var_128_31 > 0 and var_128_25 < var_128_31 then
					arg_125_1.talkMaxDuration = var_128_31

					if var_128_31 + var_128_24 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_31 + var_128_24
					end
				end

				arg_125_1.text_.text = var_128_28
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122031", "story_v_out_123122.awb") ~= 0 then
					local var_128_32 = manager.audio:GetVoiceLength("story_v_out_123122", "123122031", "story_v_out_123122.awb") / 1000

					if var_128_32 + var_128_24 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_32 + var_128_24
					end

					if var_128_27.prefab_name ~= "" and arg_125_1.actors_[var_128_27.prefab_name] ~= nil then
						local var_128_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_27.prefab_name].transform, "story_v_out_123122", "123122031", "story_v_out_123122.awb")

						arg_125_1:RecordAudio("123122031", var_128_33)
						arg_125_1:RecordAudio("123122031", var_128_33)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_123122", "123122031", "story_v_out_123122.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_123122", "123122031", "story_v_out_123122.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_34 = math.max(var_128_25, arg_125_1.talkMaxDuration)

			if var_128_24 <= arg_125_1.time_ and arg_125_1.time_ < var_128_24 + var_128_34 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_24) / var_128_34

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_24 + var_128_34 and arg_125_1.time_ < var_128_24 + var_128_34 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123122032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 123122032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play123122033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["3044ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect3044ui_story == nil then
				arg_129_1.var_.characterEffect3044ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect3044ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect3044ui_story.fillFlat = true
					arg_129_1.var_.characterEffect3044ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect3044ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect3044ui_story.fillFlat = true
				arg_129_1.var_.characterEffect3044ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 1.275

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

				local var_132_8 = arg_129_1:GetWordFromCfg(123122032)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 51
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
	Play123122033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 123122033
		arg_133_1.duration_ = 6.73

		local var_133_0 = {
			zh = 6.733,
			ja = 5.766
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
				arg_133_0:Play123122034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["3044ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect3044ui_story == nil then
				arg_133_1.var_.characterEffect3044ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect3044ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect3044ui_story.fillFlat = true
					arg_133_1.var_.characterEffect3044ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect3044ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect3044ui_story.fillFlat = true
				arg_133_1.var_.characterEffect3044ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0
			local var_136_7 = 0.2

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[36].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4030")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_9 = arg_133_1:GetWordFromCfg(123122033)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 8
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_7 or var_136_7 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_7 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122033", "story_v_out_123122.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_123122", "123122033", "story_v_out_123122.awb") / 1000

					if var_136_14 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_6
					end

					if var_136_9.prefab_name ~= "" and arg_133_1.actors_[var_136_9.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_9.prefab_name].transform, "story_v_out_123122", "123122033", "story_v_out_123122.awb")

						arg_133_1:RecordAudio("123122033", var_136_15)
						arg_133_1:RecordAudio("123122033", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_123122", "123122033", "story_v_out_123122.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_123122", "123122033", "story_v_out_123122.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_16 and arg_133_1.time_ < var_136_6 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play123122034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 123122034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play123122035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["3044ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect3044ui_story == nil then
				arg_137_1.var_.characterEffect3044ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect3044ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect3044ui_story.fillFlat = true
					arg_137_1.var_.characterEffect3044ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect3044ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect3044ui_story.fillFlat = true
				arg_137_1.var_.characterEffect3044ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 0.075

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_8

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

				local var_140_9 = arg_137_1:GetWordFromCfg(123122034)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 3
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play123122035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 123122035
		arg_141_1.duration_ = 3.07

		local var_141_0 = {
			zh = 2.233,
			ja = 3.066
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
				arg_141_0:Play123122036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["3044ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect3044ui_story == nil then
				arg_141_1.var_.characterEffect3044ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect3044ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect3044ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect3044ui_story then
				arg_141_1.var_.characterEffect3044ui_story.fillFlat = false
			end

			local var_144_4 = 0
			local var_144_5 = 0.2

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_6 = arg_141_1:FormatText(StoryNameCfg[501].name)

				arg_141_1.leftNameTxt_.text = var_144_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(123122035)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 8
				local var_144_10 = utf8.len(var_144_8)
				local var_144_11 = var_144_9 <= 0 and var_144_5 or var_144_5 * (var_144_10 / var_144_9)

				if var_144_11 > 0 and var_144_5 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11

					if var_144_11 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122035", "story_v_out_123122.awb") ~= 0 then
					local var_144_12 = manager.audio:GetVoiceLength("story_v_out_123122", "123122035", "story_v_out_123122.awb") / 1000

					if var_144_12 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_4
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_123122", "123122035", "story_v_out_123122.awb")

						arg_141_1:RecordAudio("123122035", var_144_13)
						arg_141_1:RecordAudio("123122035", var_144_13)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_123122", "123122035", "story_v_out_123122.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_123122", "123122035", "story_v_out_123122.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_14 and arg_141_1.time_ < var_144_4 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play123122036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 123122036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play123122037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["3044ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos3044ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos3044ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, 100, 0)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = 0
			local var_148_10 = 2.025

			if var_148_9 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_11 = arg_145_1:GetWordFromCfg(123122036)
				local var_148_12 = arg_145_1:FormatText(var_148_11.content)

				arg_145_1.text_.text = var_148_12

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 81
				local var_148_14 = utf8.len(var_148_12)
				local var_148_15 = var_148_13 <= 0 and var_148_10 or var_148_10 * (var_148_14 / var_148_13)

				if var_148_15 > 0 and var_148_10 < var_148_15 then
					arg_145_1.talkMaxDuration = var_148_15

					if var_148_15 + var_148_9 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_15 + var_148_9
					end
				end

				arg_145_1.text_.text = var_148_12
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_10, arg_145_1.talkMaxDuration)

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_9) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_9 + var_148_16 and arg_145_1.time_ < var_148_9 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3044ui_story",
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
	Play123122037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 123122037
		arg_149_1.duration_ = 2.67

		local var_149_0 = {
			zh = 2.666,
			ja = 2.6
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
				arg_149_0:Play123122038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1093ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1093ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(-0.7, -1.11, -5.88)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1093ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1093ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1093ui_story == nil then
				arg_149_1.var_.characterEffect1093ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect1093ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1093ui_story then
				arg_149_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_152_13 = 0

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_152_15 = 0
			local var_152_16 = 0.275

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_17 = arg_149_1:FormatText(StoryNameCfg[73].name)

				arg_149_1.leftNameTxt_.text = var_152_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_18 = arg_149_1:GetWordFromCfg(123122037)
				local var_152_19 = arg_149_1:FormatText(var_152_18.content)

				arg_149_1.text_.text = var_152_19

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_20 = 11
				local var_152_21 = utf8.len(var_152_19)
				local var_152_22 = var_152_20 <= 0 and var_152_16 or var_152_16 * (var_152_21 / var_152_20)

				if var_152_22 > 0 and var_152_16 < var_152_22 then
					arg_149_1.talkMaxDuration = var_152_22

					if var_152_22 + var_152_15 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_22 + var_152_15
					end
				end

				arg_149_1.text_.text = var_152_19
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122037", "story_v_out_123122.awb") ~= 0 then
					local var_152_23 = manager.audio:GetVoiceLength("story_v_out_123122", "123122037", "story_v_out_123122.awb") / 1000

					if var_152_23 + var_152_15 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_23 + var_152_15
					end

					if var_152_18.prefab_name ~= "" and arg_149_1.actors_[var_152_18.prefab_name] ~= nil then
						local var_152_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_18.prefab_name].transform, "story_v_out_123122", "123122037", "story_v_out_123122.awb")

						arg_149_1:RecordAudio("123122037", var_152_24)
						arg_149_1:RecordAudio("123122037", var_152_24)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_123122", "123122037", "story_v_out_123122.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_123122", "123122037", "story_v_out_123122.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_25 = math.max(var_152_16, arg_149_1.talkMaxDuration)

			if var_152_15 <= arg_149_1.time_ and arg_149_1.time_ < var_152_15 + var_152_25 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_15) / var_152_25

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_15 + var_152_25 and arg_149_1.time_ < var_152_15 + var_152_25 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play123122038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 123122038
		arg_153_1.duration_ = 2.63

		local var_153_0 = {
			zh = 2.633,
			ja = 1.999999999999
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
				arg_153_0:Play123122039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1055ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1055ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(0.7, -0.965, -6.2)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1055ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0.7, -0.965, -6.2)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["1055ui_story"]
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1055ui_story == nil then
				arg_153_1.var_.characterEffect1055ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_11 = 0.200000002980232

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 and not isNil(var_156_9) then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11

				if arg_153_1.var_.characterEffect1055ui_story and not isNil(var_156_9) then
					arg_153_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1055ui_story then
				arg_153_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action3_1")
			end

			local var_156_14 = 0

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_156_15 = arg_153_1.actors_["1093ui_story"]
			local var_156_16 = 0

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.characterEffect1093ui_story == nil then
				arg_153_1.var_.characterEffect1093ui_story = var_156_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_17 = 0.200000002980232

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_17 and not isNil(var_156_15) then
				local var_156_18 = (arg_153_1.time_ - var_156_16) / var_156_17

				if arg_153_1.var_.characterEffect1093ui_story and not isNil(var_156_15) then
					local var_156_19 = Mathf.Lerp(0, 0.5, var_156_18)

					arg_153_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1093ui_story.fillRatio = var_156_19
				end
			end

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.characterEffect1093ui_story then
				local var_156_20 = 0.5

				arg_153_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1093ui_story.fillRatio = var_156_20
			end

			local var_156_21 = 0
			local var_156_22 = 0.175

			if var_156_21 < arg_153_1.time_ and arg_153_1.time_ <= var_156_21 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_23 = arg_153_1:FormatText(StoryNameCfg[481].name)

				arg_153_1.leftNameTxt_.text = var_156_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_24 = arg_153_1:GetWordFromCfg(123122038)
				local var_156_25 = arg_153_1:FormatText(var_156_24.content)

				arg_153_1.text_.text = var_156_25

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_26 = 7
				local var_156_27 = utf8.len(var_156_25)
				local var_156_28 = var_156_26 <= 0 and var_156_22 or var_156_22 * (var_156_27 / var_156_26)

				if var_156_28 > 0 and var_156_22 < var_156_28 then
					arg_153_1.talkMaxDuration = var_156_28

					if var_156_28 + var_156_21 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_28 + var_156_21
					end
				end

				arg_153_1.text_.text = var_156_25
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122038", "story_v_out_123122.awb") ~= 0 then
					local var_156_29 = manager.audio:GetVoiceLength("story_v_out_123122", "123122038", "story_v_out_123122.awb") / 1000

					if var_156_29 + var_156_21 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_29 + var_156_21
					end

					if var_156_24.prefab_name ~= "" and arg_153_1.actors_[var_156_24.prefab_name] ~= nil then
						local var_156_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_24.prefab_name].transform, "story_v_out_123122", "123122038", "story_v_out_123122.awb")

						arg_153_1:RecordAudio("123122038", var_156_30)
						arg_153_1:RecordAudio("123122038", var_156_30)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_123122", "123122038", "story_v_out_123122.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_123122", "123122038", "story_v_out_123122.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_31 = math.max(var_156_22, arg_153_1.talkMaxDuration)

			if var_156_21 <= arg_153_1.time_ and arg_153_1.time_ < var_156_21 + var_156_31 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_21) / var_156_31

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_21 + var_156_31 and arg_153_1.time_ < var_156_21 + var_156_31 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123122039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 123122039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play123122040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1093ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1093ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0, 100, 0)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1093ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, 100, 0)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1093ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1093ui_story == nil then
				arg_157_1.var_.characterEffect1093ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.200000002980232

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect1093ui_story and not isNil(var_160_9) then
					local var_160_13 = Mathf.Lerp(0, 0.5, var_160_12)

					arg_157_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1093ui_story.fillRatio = var_160_13
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1093ui_story then
				local var_160_14 = 0.5

				arg_157_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1093ui_story.fillRatio = var_160_14
			end

			local var_160_15 = arg_157_1.actors_["1055ui_story"].transform
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.var_.moveOldPos1055ui_story = var_160_15.localPosition
			end

			local var_160_17 = 0.001

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 then
				local var_160_18 = (arg_157_1.time_ - var_160_16) / var_160_17
				local var_160_19 = Vector3.New(0, 100, 0)

				var_160_15.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1055ui_story, var_160_19, var_160_18)

				local var_160_20 = manager.ui.mainCamera.transform.position - var_160_15.position

				var_160_15.forward = Vector3.New(var_160_20.x, var_160_20.y, var_160_20.z)

				local var_160_21 = var_160_15.localEulerAngles

				var_160_21.z = 0
				var_160_21.x = 0
				var_160_15.localEulerAngles = var_160_21
			end

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 then
				var_160_15.localPosition = Vector3.New(0, 100, 0)

				local var_160_22 = manager.ui.mainCamera.transform.position - var_160_15.position

				var_160_15.forward = Vector3.New(var_160_22.x, var_160_22.y, var_160_22.z)

				local var_160_23 = var_160_15.localEulerAngles

				var_160_23.z = 0
				var_160_23.x = 0
				var_160_15.localEulerAngles = var_160_23
			end

			local var_160_24 = arg_157_1.actors_["1055ui_story"]
			local var_160_25 = 0

			if var_160_25 < arg_157_1.time_ and arg_157_1.time_ <= var_160_25 + arg_160_0 and not isNil(var_160_24) and arg_157_1.var_.characterEffect1055ui_story == nil then
				arg_157_1.var_.characterEffect1055ui_story = var_160_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_26 = 0.200000002980232

			if var_160_25 <= arg_157_1.time_ and arg_157_1.time_ < var_160_25 + var_160_26 and not isNil(var_160_24) then
				local var_160_27 = (arg_157_1.time_ - var_160_25) / var_160_26

				if arg_157_1.var_.characterEffect1055ui_story and not isNil(var_160_24) then
					local var_160_28 = Mathf.Lerp(0, 0.5, var_160_27)

					arg_157_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1055ui_story.fillRatio = var_160_28
				end
			end

			if arg_157_1.time_ >= var_160_25 + var_160_26 and arg_157_1.time_ < var_160_25 + var_160_26 + arg_160_0 and not isNil(var_160_24) and arg_157_1.var_.characterEffect1055ui_story then
				local var_160_29 = 0.5

				arg_157_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1055ui_story.fillRatio = var_160_29
			end

			local var_160_30 = 0
			local var_160_31 = 1.175

			if var_160_30 < arg_157_1.time_ and arg_157_1.time_ <= var_160_30 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_32 = arg_157_1:GetWordFromCfg(123122039)
				local var_160_33 = arg_157_1:FormatText(var_160_32.content)

				arg_157_1.text_.text = var_160_33

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_34 = 47
				local var_160_35 = utf8.len(var_160_33)
				local var_160_36 = var_160_34 <= 0 and var_160_31 or var_160_31 * (var_160_35 / var_160_34)

				if var_160_36 > 0 and var_160_31 < var_160_36 then
					arg_157_1.talkMaxDuration = var_160_36

					if var_160_36 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_36 + var_160_30
					end
				end

				arg_157_1.text_.text = var_160_33
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_37 = math.max(var_160_31, arg_157_1.talkMaxDuration)

			if var_160_30 <= arg_157_1.time_ and arg_157_1.time_ < var_160_30 + var_160_37 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_30) / var_160_37

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_30 + var_160_37 and arg_157_1.time_ < var_160_30 + var_160_37 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
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
	Play123122040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 123122040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play123122041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 1.125

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:GetWordFromCfg(123122040)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 45
				local var_164_5 = utf8.len(var_164_3)
				local var_164_6 = var_164_4 <= 0 and var_164_1 or var_164_1 * (var_164_5 / var_164_4)

				if var_164_6 > 0 and var_164_1 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_7 and arg_161_1.time_ < var_164_0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play123122041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 123122041
		arg_165_1.duration_ = 3.9

		local var_165_0 = {
			zh = 3.233,
			ja = 3.9
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play123122042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action3_1")
			end

			local var_168_2 = arg_165_1.actors_["1055ui_story"]
			local var_168_3 = 0

			if var_168_3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect1055ui_story == nil then
				arg_165_1.var_.characterEffect1055ui_story = var_168_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_4 = 0.2

			if var_168_3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_3 + var_168_4 and not isNil(var_168_2) then
				local var_168_5 = (arg_165_1.time_ - var_168_3) / var_168_4

				if arg_165_1.var_.characterEffect1055ui_story and not isNil(var_168_2) then
					arg_165_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_3 + var_168_4 and arg_165_1.time_ < var_168_3 + var_168_4 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect1055ui_story then
				arg_165_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_168_6 = arg_165_1.actors_["1055ui_story"].transform
			local var_168_7 = 0

			if var_168_7 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 then
				arg_165_1.var_.moveOldPos1055ui_story = var_168_6.localPosition
			end

			local var_168_8 = 0.001

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_8 then
				local var_168_9 = (arg_165_1.time_ - var_168_7) / var_168_8
				local var_168_10 = Vector3.New(0, -0.965, -6.2)

				var_168_6.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1055ui_story, var_168_10, var_168_9)

				local var_168_11 = manager.ui.mainCamera.transform.position - var_168_6.position

				var_168_6.forward = Vector3.New(var_168_11.x, var_168_11.y, var_168_11.z)

				local var_168_12 = var_168_6.localEulerAngles

				var_168_12.z = 0
				var_168_12.x = 0
				var_168_6.localEulerAngles = var_168_12
			end

			if arg_165_1.time_ >= var_168_7 + var_168_8 and arg_165_1.time_ < var_168_7 + var_168_8 + arg_168_0 then
				var_168_6.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_168_13 = manager.ui.mainCamera.transform.position - var_168_6.position

				var_168_6.forward = Vector3.New(var_168_13.x, var_168_13.y, var_168_13.z)

				local var_168_14 = var_168_6.localEulerAngles

				var_168_14.z = 0
				var_168_14.x = 0
				var_168_6.localEulerAngles = var_168_14
			end

			local var_168_15 = 0
			local var_168_16 = 0.175

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[481].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(123122041)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 7
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122041", "story_v_out_123122.awb") ~= 0 then
					local var_168_23 = manager.audio:GetVoiceLength("story_v_out_123122", "123122041", "story_v_out_123122.awb") / 1000

					if var_168_23 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_15
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_out_123122", "123122041", "story_v_out_123122.awb")

						arg_165_1:RecordAudio("123122041", var_168_24)
						arg_165_1:RecordAudio("123122041", var_168_24)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_123122", "123122041", "story_v_out_123122.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_123122", "123122041", "story_v_out_123122.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_25 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_25 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_25

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_25 and arg_165_1.time_ < var_168_15 + var_168_25 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play123122042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 123122042
		arg_169_1.duration_ = 7.22

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play123122043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = "STblack"

			if arg_169_1.bgs_[var_172_0] == nil then
				local var_172_1 = Object.Instantiate(arg_169_1.paintGo_)

				var_172_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_172_0)
				var_172_1.name = var_172_0
				var_172_1.transform.parent = arg_169_1.stage_.transform
				var_172_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.bgs_[var_172_0] = var_172_1
			end

			local var_172_2 = 1

			if var_172_2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				local var_172_3 = manager.ui.mainCamera.transform.localPosition
				local var_172_4 = Vector3.New(0, 0, 10) + Vector3.New(var_172_3.x, var_172_3.y, 0)
				local var_172_5 = arg_169_1.bgs_.STblack

				var_172_5.transform.localPosition = var_172_4
				var_172_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_172_6 = var_172_5:GetComponent("SpriteRenderer")

				if var_172_6 and var_172_6.sprite then
					local var_172_7 = (var_172_5.transform.localPosition - var_172_3).z
					local var_172_8 = manager.ui.mainCameraCom_
					local var_172_9 = 2 * var_172_7 * Mathf.Tan(var_172_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_172_10 = var_172_9 * var_172_8.aspect
					local var_172_11 = var_172_6.sprite.bounds.size.x
					local var_172_12 = var_172_6.sprite.bounds.size.y
					local var_172_13 = var_172_10 / var_172_11
					local var_172_14 = var_172_9 / var_172_12
					local var_172_15 = var_172_14 < var_172_13 and var_172_13 or var_172_14

					var_172_5.transform.localScale = Vector3.New(var_172_15, var_172_15, 0)
				end

				for iter_172_0, iter_172_1 in pairs(arg_169_1.bgs_) do
					if iter_172_0 ~= "STblack" then
						iter_172_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_17 = 1

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17
				local var_172_19 = Color.New(0, 0, 0)

				var_172_19.a = Mathf.Lerp(0, 1, var_172_18)
				arg_169_1.mask_.color = var_172_19
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 then
				local var_172_20 = Color.New(0, 0, 0)

				var_172_20.a = 1
				arg_169_1.mask_.color = var_172_20
			end

			local var_172_21 = 1

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_22 = 2

			if var_172_21 <= arg_169_1.time_ and arg_169_1.time_ < var_172_21 + var_172_22 then
				local var_172_23 = (arg_169_1.time_ - var_172_21) / var_172_22
				local var_172_24 = Color.New(0, 0, 0)

				var_172_24.a = Mathf.Lerp(1, 0, var_172_23)
				arg_169_1.mask_.color = var_172_24
			end

			if arg_169_1.time_ >= var_172_21 + var_172_22 and arg_169_1.time_ < var_172_21 + var_172_22 + arg_172_0 then
				local var_172_25 = Color.New(0, 0, 0)
				local var_172_26 = 0

				arg_169_1.mask_.enabled = false
				var_172_25.a = var_172_26
				arg_169_1.mask_.color = var_172_25
			end

			local var_172_27 = arg_169_1.actors_["1055ui_story"].transform
			local var_172_28 = 0.965999998152256

			if var_172_28 < arg_169_1.time_ and arg_169_1.time_ <= var_172_28 + arg_172_0 then
				arg_169_1.var_.moveOldPos1055ui_story = var_172_27.localPosition
			end

			local var_172_29 = 0.001

			if var_172_28 <= arg_169_1.time_ and arg_169_1.time_ < var_172_28 + var_172_29 then
				local var_172_30 = (arg_169_1.time_ - var_172_28) / var_172_29
				local var_172_31 = Vector3.New(0, 100, 0)

				var_172_27.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1055ui_story, var_172_31, var_172_30)

				local var_172_32 = manager.ui.mainCamera.transform.position - var_172_27.position

				var_172_27.forward = Vector3.New(var_172_32.x, var_172_32.y, var_172_32.z)

				local var_172_33 = var_172_27.localEulerAngles

				var_172_33.z = 0
				var_172_33.x = 0
				var_172_27.localEulerAngles = var_172_33
			end

			if arg_169_1.time_ >= var_172_28 + var_172_29 and arg_169_1.time_ < var_172_28 + var_172_29 + arg_172_0 then
				var_172_27.localPosition = Vector3.New(0, 100, 0)

				local var_172_34 = manager.ui.mainCamera.transform.position - var_172_27.position

				var_172_27.forward = Vector3.New(var_172_34.x, var_172_34.y, var_172_34.z)

				local var_172_35 = var_172_27.localEulerAngles

				var_172_35.z = 0
				var_172_35.x = 0
				var_172_27.localEulerAngles = var_172_35
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_36 = 2.225
			local var_172_37 = 0.775

			if var_172_36 < arg_169_1.time_ and arg_169_1.time_ <= var_172_36 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_38 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_38:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_39 = arg_169_1:GetWordFromCfg(123122042)
				local var_172_40 = arg_169_1:FormatText(var_172_39.content)

				arg_169_1.text_.text = var_172_40

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_41 = 31
				local var_172_42 = utf8.len(var_172_40)
				local var_172_43 = var_172_41 <= 0 and var_172_37 or var_172_37 * (var_172_42 / var_172_41)

				if var_172_43 > 0 and var_172_37 < var_172_43 then
					arg_169_1.talkMaxDuration = var_172_43
					var_172_36 = var_172_36 + 0.3

					if var_172_43 + var_172_36 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_43 + var_172_36
					end
				end

				arg_169_1.text_.text = var_172_40
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_44 = var_172_36 + 0.3
			local var_172_45 = math.max(var_172_37, arg_169_1.talkMaxDuration)

			if var_172_44 <= arg_169_1.time_ and arg_169_1.time_ < var_172_44 + var_172_45 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_44) / var_172_45

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_44 + var_172_45 and arg_169_1.time_ < var_172_44 + var_172_45 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play123122043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 123122043
		arg_175_1.duration_ = 9

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play123122044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = "K04g"

			if arg_175_1.bgs_[var_178_0] == nil then
				local var_178_1 = Object.Instantiate(arg_175_1.paintGo_)

				var_178_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_178_0)
				var_178_1.name = var_178_0
				var_178_1.transform.parent = arg_175_1.stage_.transform
				var_178_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.bgs_[var_178_0] = var_178_1
			end

			local var_178_2 = 2

			if var_178_2 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				local var_178_3 = manager.ui.mainCamera.transform.localPosition
				local var_178_4 = Vector3.New(0, 0, 10) + Vector3.New(var_178_3.x, var_178_3.y, 0)
				local var_178_5 = arg_175_1.bgs_.K04g

				var_178_5.transform.localPosition = var_178_4
				var_178_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_6 = var_178_5:GetComponent("SpriteRenderer")

				if var_178_6 and var_178_6.sprite then
					local var_178_7 = (var_178_5.transform.localPosition - var_178_3).z
					local var_178_8 = manager.ui.mainCameraCom_
					local var_178_9 = 2 * var_178_7 * Mathf.Tan(var_178_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_178_10 = var_178_9 * var_178_8.aspect
					local var_178_11 = var_178_6.sprite.bounds.size.x
					local var_178_12 = var_178_6.sprite.bounds.size.y
					local var_178_13 = var_178_10 / var_178_11
					local var_178_14 = var_178_9 / var_178_12
					local var_178_15 = var_178_14 < var_178_13 and var_178_13 or var_178_14

					var_178_5.transform.localScale = Vector3.New(var_178_15, var_178_15, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "K04g" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_17 = 2

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 then
				local var_178_18 = (arg_175_1.time_ - var_178_16) / var_178_17
				local var_178_19 = Color.New(0, 0, 0)

				var_178_19.a = Mathf.Lerp(0, 1, var_178_18)
				arg_175_1.mask_.color = var_178_19
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 then
				local var_178_20 = Color.New(0, 0, 0)

				var_178_20.a = 1
				arg_175_1.mask_.color = var_178_20
			end

			local var_178_21 = 2

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_22 = 2

			if var_178_21 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_22 then
				local var_178_23 = (arg_175_1.time_ - var_178_21) / var_178_22
				local var_178_24 = Color.New(0, 0, 0)

				var_178_24.a = Mathf.Lerp(1, 0, var_178_23)
				arg_175_1.mask_.color = var_178_24
			end

			if arg_175_1.time_ >= var_178_21 + var_178_22 and arg_175_1.time_ < var_178_21 + var_178_22 + arg_178_0 then
				local var_178_25 = Color.New(0, 0, 0)
				local var_178_26 = 0

				arg_175_1.mask_.enabled = false
				var_178_25.a = var_178_26
				arg_175_1.mask_.color = var_178_25
			end

			local var_178_27 = 0
			local var_178_28 = 0.866666666666667

			if var_178_27 < arg_175_1.time_ and arg_175_1.time_ <= var_178_27 + arg_178_0 then
				local var_178_29 = "play"
				local var_178_30 = "music"

				arg_175_1:AudioAction(var_178_29, var_178_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_178_31 = ""
				local var_178_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_178_32 ~= "" then
					if arg_175_1.bgmTxt_.text ~= var_178_32 and arg_175_1.bgmTxt_.text ~= "" then
						if arg_175_1.bgmTxt2_.text ~= "" then
							arg_175_1.bgmTxt_.text = arg_175_1.bgmTxt2_.text
						end

						arg_175_1.bgmTxt2_.text = var_178_32

						arg_175_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_175_1.bgmTxt_.text = var_178_32
						arg_175_1.bgmTxt2_.text = var_178_32
					end

					if arg_175_1.bgmTimer then
						arg_175_1.bgmTimer:Stop()

						arg_175_1.bgmTimer = nil
					end

					if arg_175_1.settingData.show_music_name == 1 then
						arg_175_1.musicController:SetSelectedState("show")
						arg_175_1.musicAnimator_:Play("open", 0, 0)

						if arg_175_1.settingData.music_time ~= 0 then
							arg_175_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_175_1.settingData.music_time), function()
								if arg_175_1 == nil or isNil(arg_175_1.bgmTxt_) then
									return
								end

								arg_175_1.musicController:SetSelectedState("hide")
								arg_175_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_178_33 = 2
			local var_178_34 = 1

			if var_178_33 < arg_175_1.time_ and arg_175_1.time_ <= var_178_33 + arg_178_0 then
				local var_178_35 = "play"
				local var_178_36 = "music"

				arg_175_1:AudioAction(var_178_35, var_178_36, "bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall.awb")

				local var_178_37 = ""
				local var_178_38 = manager.audio:GetAudioName("bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall")

				if var_178_38 ~= "" then
					if arg_175_1.bgmTxt_.text ~= var_178_38 and arg_175_1.bgmTxt_.text ~= "" then
						if arg_175_1.bgmTxt2_.text ~= "" then
							arg_175_1.bgmTxt_.text = arg_175_1.bgmTxt2_.text
						end

						arg_175_1.bgmTxt2_.text = var_178_38

						arg_175_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_175_1.bgmTxt_.text = var_178_38
						arg_175_1.bgmTxt2_.text = var_178_38
					end

					if arg_175_1.bgmTimer then
						arg_175_1.bgmTimer:Stop()

						arg_175_1.bgmTimer = nil
					end

					if arg_175_1.settingData.show_music_name == 1 then
						arg_175_1.musicController:SetSelectedState("show")
						arg_175_1.musicAnimator_:Play("open", 0, 0)

						if arg_175_1.settingData.music_time ~= 0 then
							arg_175_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_175_1.settingData.music_time), function()
								if arg_175_1 == nil or isNil(arg_175_1.bgmTxt_) then
									return
								end

								arg_175_1.musicController:SetSelectedState("hide")
								arg_175_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_39 = 4
			local var_178_40 = 1.3

			if var_178_39 < arg_175_1.time_ and arg_175_1.time_ <= var_178_39 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_41 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_41:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_175_1.dialogCg_.alpha = arg_181_0
				end))
				var_178_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_42 = arg_175_1:GetWordFromCfg(123122043)
				local var_178_43 = arg_175_1:FormatText(var_178_42.content)

				arg_175_1.text_.text = var_178_43

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_44 = 52
				local var_178_45 = utf8.len(var_178_43)
				local var_178_46 = var_178_44 <= 0 and var_178_40 or var_178_40 * (var_178_45 / var_178_44)

				if var_178_46 > 0 and var_178_40 < var_178_46 then
					arg_175_1.talkMaxDuration = var_178_46
					var_178_39 = var_178_39 + 0.3

					if var_178_46 + var_178_39 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_46 + var_178_39
					end
				end

				arg_175_1.text_.text = var_178_43
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_47 = var_178_39 + 0.3
			local var_178_48 = math.max(var_178_40, arg_175_1.talkMaxDuration)

			if var_178_47 <= arg_175_1.time_ and arg_175_1.time_ < var_178_47 + var_178_48 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_47) / var_178_48

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_47 + var_178_48 and arg_175_1.time_ < var_178_47 + var_178_48 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play123122044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 123122044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play123122045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 1.525

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_2 = arg_183_1:GetWordFromCfg(123122044)
				local var_186_3 = arg_183_1:FormatText(var_186_2.content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 61
				local var_186_5 = utf8.len(var_186_3)
				local var_186_6 = var_186_4 <= 0 and var_186_1 or var_186_1 * (var_186_5 / var_186_4)

				if var_186_6 > 0 and var_186_1 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_7 and arg_183_1.time_ < var_186_0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play123122045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 123122045
		arg_187_1.duration_ = 2.97

		local var_187_0 = {
			zh = 2.966,
			ja = 2.433
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
				arg_187_0:Play123122046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.425

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[489].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(123122045)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 17
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122045", "story_v_out_123122.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_123122", "123122045", "story_v_out_123122.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_123122", "123122045", "story_v_out_123122.awb")

						arg_187_1:RecordAudio("123122045", var_190_9)
						arg_187_1:RecordAudio("123122045", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_123122", "123122045", "story_v_out_123122.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_123122", "123122045", "story_v_out_123122.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_10 and arg_187_1.time_ < var_190_0 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play123122046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 123122046
		arg_191_1.duration_ = 2.2

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play123122047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = "10048ui_story"

			if arg_191_1.actors_[var_194_0] == nil then
				local var_194_1 = Asset.Load("Char/" .. "10048ui_story")

				if not isNil(var_194_1) then
					local var_194_2 = Object.Instantiate(Asset.Load("Char/" .. "10048ui_story"), arg_191_1.stage_.transform)

					var_194_2.name = var_194_0
					var_194_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_191_1.actors_[var_194_0] = var_194_2

					local var_194_3 = var_194_2:GetComponentInChildren(typeof(CharacterEffect))

					var_194_3.enabled = true

					local var_194_4 = GameObjectTools.GetOrAddComponent(var_194_2, typeof(DynamicBoneHelper))

					if var_194_4 then
						var_194_4:EnableDynamicBone(false)
					end

					arg_191_1:ShowWeapon(var_194_3.transform, false)

					arg_191_1.var_[var_194_0 .. "Animator"] = var_194_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_191_1.var_[var_194_0 .. "Animator"].applyRootMotion = true
					arg_191_1.var_[var_194_0 .. "LipSync"] = var_194_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_194_5 = arg_191_1.actors_["10048ui_story"].transform
			local var_194_6 = 0

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.var_.moveOldPos10048ui_story = var_194_5.localPosition
			end

			local var_194_7 = 0.001

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_7 then
				local var_194_8 = (arg_191_1.time_ - var_194_6) / var_194_7
				local var_194_9 = Vector3.New(0, -1.155, -6.13)

				var_194_5.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10048ui_story, var_194_9, var_194_8)

				local var_194_10 = manager.ui.mainCamera.transform.position - var_194_5.position

				var_194_5.forward = Vector3.New(var_194_10.x, var_194_10.y, var_194_10.z)

				local var_194_11 = var_194_5.localEulerAngles

				var_194_11.z = 0
				var_194_11.x = 0
				var_194_5.localEulerAngles = var_194_11
			end

			if arg_191_1.time_ >= var_194_6 + var_194_7 and arg_191_1.time_ < var_194_6 + var_194_7 + arg_194_0 then
				var_194_5.localPosition = Vector3.New(0, -1.155, -6.13)

				local var_194_12 = manager.ui.mainCamera.transform.position - var_194_5.position

				var_194_5.forward = Vector3.New(var_194_12.x, var_194_12.y, var_194_12.z)

				local var_194_13 = var_194_5.localEulerAngles

				var_194_13.z = 0
				var_194_13.x = 0
				var_194_5.localEulerAngles = var_194_13
			end

			local var_194_14 = arg_191_1.actors_["10048ui_story"]
			local var_194_15 = 0

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 and not isNil(var_194_14) and arg_191_1.var_.characterEffect10048ui_story == nil then
				arg_191_1.var_.characterEffect10048ui_story = var_194_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_16 = 0.200000002980232

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_16 and not isNil(var_194_14) then
				local var_194_17 = (arg_191_1.time_ - var_194_15) / var_194_16

				if arg_191_1.var_.characterEffect10048ui_story and not isNil(var_194_14) then
					arg_191_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_15 + var_194_16 and arg_191_1.time_ < var_194_15 + var_194_16 + arg_194_0 and not isNil(var_194_14) and arg_191_1.var_.characterEffect10048ui_story then
				arg_191_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_194_18 = 0

			if var_194_18 < arg_191_1.time_ and arg_191_1.time_ <= var_194_18 + arg_194_0 then
				arg_191_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action1_1")
			end

			local var_194_19 = 0

			if var_194_19 < arg_191_1.time_ and arg_191_1.time_ <= var_194_19 + arg_194_0 then
				arg_191_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_194_20 = 0
			local var_194_21 = 0.125

			if var_194_20 < arg_191_1.time_ and arg_191_1.time_ <= var_194_20 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_22 = arg_191_1:FormatText(StoryNameCfg[486].name)

				arg_191_1.leftNameTxt_.text = var_194_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_23 = arg_191_1:GetWordFromCfg(123122046)
				local var_194_24 = arg_191_1:FormatText(var_194_23.content)

				arg_191_1.text_.text = var_194_24

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_25 = 5
				local var_194_26 = utf8.len(var_194_24)
				local var_194_27 = var_194_25 <= 0 and var_194_21 or var_194_21 * (var_194_26 / var_194_25)

				if var_194_27 > 0 and var_194_21 < var_194_27 then
					arg_191_1.talkMaxDuration = var_194_27

					if var_194_27 + var_194_20 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_27 + var_194_20
					end
				end

				arg_191_1.text_.text = var_194_24
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122046", "story_v_out_123122.awb") ~= 0 then
					local var_194_28 = manager.audio:GetVoiceLength("story_v_out_123122", "123122046", "story_v_out_123122.awb") / 1000

					if var_194_28 + var_194_20 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_28 + var_194_20
					end

					if var_194_23.prefab_name ~= "" and arg_191_1.actors_[var_194_23.prefab_name] ~= nil then
						local var_194_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_23.prefab_name].transform, "story_v_out_123122", "123122046", "story_v_out_123122.awb")

						arg_191_1:RecordAudio("123122046", var_194_29)
						arg_191_1:RecordAudio("123122046", var_194_29)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_123122", "123122046", "story_v_out_123122.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_123122", "123122046", "story_v_out_123122.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_30 = math.max(var_194_21, arg_191_1.talkMaxDuration)

			if var_194_20 <= arg_191_1.time_ and arg_191_1.time_ < var_194_20 + var_194_30 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_20) / var_194_30

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_20 + var_194_30 and arg_191_1.time_ < var_194_20 + var_194_30 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
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
	Play123122047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 123122047
		arg_195_1.duration_ = 10.27

		local var_195_0 = {
			zh = 10.266,
			ja = 9.233
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play123122048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10048ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect10048ui_story == nil then
				arg_195_1.var_.characterEffect10048ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect10048ui_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10048ui_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect10048ui_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10048ui_story.fillRatio = var_198_5
			end

			local var_198_6 = 0
			local var_198_7 = 1.325

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_8 = arg_195_1:FormatText(StoryNameCfg[489].name)

				arg_195_1.leftNameTxt_.text = var_198_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_9 = arg_195_1:GetWordFromCfg(123122047)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 53
				local var_198_12 = utf8.len(var_198_10)
				local var_198_13 = var_198_11 <= 0 and var_198_7 or var_198_7 * (var_198_12 / var_198_11)

				if var_198_13 > 0 and var_198_7 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122047", "story_v_out_123122.awb") ~= 0 then
					local var_198_14 = manager.audio:GetVoiceLength("story_v_out_123122", "123122047", "story_v_out_123122.awb") / 1000

					if var_198_14 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_14 + var_198_6
					end

					if var_198_9.prefab_name ~= "" and arg_195_1.actors_[var_198_9.prefab_name] ~= nil then
						local var_198_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_9.prefab_name].transform, "story_v_out_123122", "123122047", "story_v_out_123122.awb")

						arg_195_1:RecordAudio("123122047", var_198_15)
						arg_195_1:RecordAudio("123122047", var_198_15)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_123122", "123122047", "story_v_out_123122.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_123122", "123122047", "story_v_out_123122.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_16 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_16 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_16

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_16 and arg_195_1.time_ < var_198_6 + var_198_16 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play123122048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 123122048
		arg_199_1.duration_ = 9.6

		local var_199_0 = {
			zh = 9.4,
			ja = 9.6
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play123122049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 1.25

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[489].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(123122048)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122048", "story_v_out_123122.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_123122", "123122048", "story_v_out_123122.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_123122", "123122048", "story_v_out_123122.awb")

						arg_199_1:RecordAudio("123122048", var_202_9)
						arg_199_1:RecordAudio("123122048", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_123122", "123122048", "story_v_out_123122.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_123122", "123122048", "story_v_out_123122.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_10 and arg_199_1.time_ < var_202_0 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play123122049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 123122049
		arg_203_1.duration_ = 6.63

		local var_203_0 = {
			zh = 6.633,
			ja = 4.966
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
				arg_203_0:Play123122050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10048ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos10048ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, -1.155, -6.13)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10048ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -1.155, -6.13)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["10048ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect10048ui_story == nil then
				arg_203_1.var_.characterEffect10048ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect10048ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect10048ui_story then
				arg_203_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action2_1")
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_206_15 = 0
			local var_206_16 = 0.525

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[486].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_18 = arg_203_1:GetWordFromCfg(123122049)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 21
				local var_206_21 = utf8.len(var_206_19)
				local var_206_22 = var_206_20 <= 0 and var_206_16 or var_206_16 * (var_206_21 / var_206_20)

				if var_206_22 > 0 and var_206_16 < var_206_22 then
					arg_203_1.talkMaxDuration = var_206_22

					if var_206_22 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_15
					end
				end

				arg_203_1.text_.text = var_206_19
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122049", "story_v_out_123122.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_out_123122", "123122049", "story_v_out_123122.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_123122", "123122049", "story_v_out_123122.awb")

						arg_203_1:RecordAudio("123122049", var_206_24)
						arg_203_1:RecordAudio("123122049", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_123122", "123122049", "story_v_out_123122.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_123122", "123122049", "story_v_out_123122.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_25 = math.max(var_206_16, arg_203_1.talkMaxDuration)

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_25 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_15) / var_206_25

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_15 + var_206_25 and arg_203_1.time_ < var_206_15 + var_206_25 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
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
	Play123122050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 123122050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play123122051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10048ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10048ui_story == nil then
				arg_207_1.var_.characterEffect10048ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect10048ui_story and not isNil(var_210_0) then
					local var_210_4 = Mathf.Lerp(0, 0.5, var_210_3)

					arg_207_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10048ui_story.fillRatio = var_210_4
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10048ui_story then
				local var_210_5 = 0.5

				arg_207_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10048ui_story.fillRatio = var_210_5
			end

			local var_210_6 = 0

			if var_210_6 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_210_7 = 0
			local var_210_8 = 0.75

			if var_210_7 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_9 = arg_207_1:GetWordFromCfg(123122050)
				local var_210_10 = arg_207_1:FormatText(var_210_9.content)

				arg_207_1.text_.text = var_210_10

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 30
				local var_210_12 = utf8.len(var_210_10)
				local var_210_13 = var_210_11 <= 0 and var_210_8 or var_210_8 * (var_210_12 / var_210_11)

				if var_210_13 > 0 and var_210_8 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_7 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_7
					end
				end

				arg_207_1.text_.text = var_210_10
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_8, arg_207_1.talkMaxDuration)

			if var_210_7 <= arg_207_1.time_ and arg_207_1.time_ < var_210_7 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_7) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_7 + var_210_14 and arg_207_1.time_ < var_210_7 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play123122051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 123122051
		arg_211_1.duration_ = 5.5

		local var_211_0 = {
			zh = 4.733,
			ja = 5.5
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
				arg_211_0:Play123122052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10048ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10048ui_story == nil then
				arg_211_1.var_.characterEffect10048ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect10048ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10048ui_story then
				arg_211_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_214_4 = 0
			local var_214_5 = 0.45

			if var_214_4 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_6 = arg_211_1:FormatText(StoryNameCfg[486].name)

				arg_211_1.leftNameTxt_.text = var_214_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_7 = arg_211_1:GetWordFromCfg(123122051)
				local var_214_8 = arg_211_1:FormatText(var_214_7.content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 18
				local var_214_10 = utf8.len(var_214_8)
				local var_214_11 = var_214_9 <= 0 and var_214_5 or var_214_5 * (var_214_10 / var_214_9)

				if var_214_11 > 0 and var_214_5 < var_214_11 then
					arg_211_1.talkMaxDuration = var_214_11

					if var_214_11 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122051", "story_v_out_123122.awb") ~= 0 then
					local var_214_12 = manager.audio:GetVoiceLength("story_v_out_123122", "123122051", "story_v_out_123122.awb") / 1000

					if var_214_12 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_12 + var_214_4
					end

					if var_214_7.prefab_name ~= "" and arg_211_1.actors_[var_214_7.prefab_name] ~= nil then
						local var_214_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_7.prefab_name].transform, "story_v_out_123122", "123122051", "story_v_out_123122.awb")

						arg_211_1:RecordAudio("123122051", var_214_13)
						arg_211_1:RecordAudio("123122051", var_214_13)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_123122", "123122051", "story_v_out_123122.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_123122", "123122051", "story_v_out_123122.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_14 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_14 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_14

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_14 and arg_211_1.time_ < var_214_4 + var_214_14 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play123122052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 123122052
		arg_215_1.duration_ = 1.3

		local var_215_0 = {
			zh = 1.066,
			ja = 1.3
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play123122053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10048ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect10048ui_story == nil then
				arg_215_1.var_.characterEffect10048ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect10048ui_story and not isNil(var_218_0) then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10048ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect10048ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10048ui_story.fillRatio = var_218_5
			end

			local var_218_6 = 0
			local var_218_7 = 0.075

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_8 = arg_215_1:FormatText(StoryNameCfg[489].name)

				arg_215_1.leftNameTxt_.text = var_218_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_9 = arg_215_1:GetWordFromCfg(123122052)
				local var_218_10 = arg_215_1:FormatText(var_218_9.content)

				arg_215_1.text_.text = var_218_10

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122052", "story_v_out_123122.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_out_123122", "123122052", "story_v_out_123122.awb") / 1000

					if var_218_14 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_6
					end

					if var_218_9.prefab_name ~= "" and arg_215_1.actors_[var_218_9.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_9.prefab_name].transform, "story_v_out_123122", "123122052", "story_v_out_123122.awb")

						arg_215_1:RecordAudio("123122052", var_218_15)
						arg_215_1:RecordAudio("123122052", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_123122", "123122052", "story_v_out_123122.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_123122", "123122052", "story_v_out_123122.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_16 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_16 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_16

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_16 and arg_215_1.time_ < var_218_6 + var_218_16 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play123122053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 123122053
		arg_219_1.duration_ = 9.7

		local var_219_0 = {
			zh = 8.733,
			ja = 9.7
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play123122054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10048ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect10048ui_story == nil then
				arg_219_1.var_.characterEffect10048ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect10048ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect10048ui_story then
				arg_219_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_222_4 = 0

			if var_222_4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action2_2")
			end

			local var_222_5 = 0

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_222_6 = 0
			local var_222_7 = 0.825

			if var_222_6 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_8 = arg_219_1:FormatText(StoryNameCfg[486].name)

				arg_219_1.leftNameTxt_.text = var_222_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_9 = arg_219_1:GetWordFromCfg(123122053)
				local var_222_10 = arg_219_1:FormatText(var_222_9.content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 33
				local var_222_12 = utf8.len(var_222_10)
				local var_222_13 = var_222_11 <= 0 and var_222_7 or var_222_7 * (var_222_12 / var_222_11)

				if var_222_13 > 0 and var_222_7 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122053", "story_v_out_123122.awb") ~= 0 then
					local var_222_14 = manager.audio:GetVoiceLength("story_v_out_123122", "123122053", "story_v_out_123122.awb") / 1000

					if var_222_14 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_6
					end

					if var_222_9.prefab_name ~= "" and arg_219_1.actors_[var_222_9.prefab_name] ~= nil then
						local var_222_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_9.prefab_name].transform, "story_v_out_123122", "123122053", "story_v_out_123122.awb")

						arg_219_1:RecordAudio("123122053", var_222_15)
						arg_219_1:RecordAudio("123122053", var_222_15)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_123122", "123122053", "story_v_out_123122.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_123122", "123122053", "story_v_out_123122.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_16 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_16 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_16

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_16 and arg_219_1.time_ < var_222_6 + var_222_16 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play123122054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 123122054
		arg_223_1.duration_ = 1

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play123122055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10048ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect10048ui_story == nil then
				arg_223_1.var_.characterEffect10048ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect10048ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_223_1.var_.characterEffect10048ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect10048ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_223_1.var_.characterEffect10048ui_story.fillRatio = var_226_5
			end

			local var_226_6 = 0
			local var_226_7 = 0.075

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_8 = arg_223_1:FormatText(StoryNameCfg[489].name)

				arg_223_1.leftNameTxt_.text = var_226_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_9 = arg_223_1:GetWordFromCfg(123122054)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 3
				local var_226_12 = utf8.len(var_226_10)
				local var_226_13 = var_226_11 <= 0 and var_226_7 or var_226_7 * (var_226_12 / var_226_11)

				if var_226_13 > 0 and var_226_7 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_10
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122054", "story_v_out_123122.awb") ~= 0 then
					local var_226_14 = manager.audio:GetVoiceLength("story_v_out_123122", "123122054", "story_v_out_123122.awb") / 1000

					if var_226_14 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_6
					end

					if var_226_9.prefab_name ~= "" and arg_223_1.actors_[var_226_9.prefab_name] ~= nil then
						local var_226_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_9.prefab_name].transform, "story_v_out_123122", "123122054", "story_v_out_123122.awb")

						arg_223_1:RecordAudio("123122054", var_226_15)
						arg_223_1:RecordAudio("123122054", var_226_15)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_123122", "123122054", "story_v_out_123122.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_123122", "123122054", "story_v_out_123122.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_16 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_16 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_16

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_16 and arg_223_1.time_ < var_226_6 + var_226_16 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play123122055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 123122055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play123122056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10048ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect10048ui_story == nil then
				arg_227_1.var_.characterEffect10048ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect10048ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect10048ui_story then
				arg_227_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_230_4 = arg_227_1.actors_["10048ui_story"].transform
			local var_230_5 = 0

			if var_230_5 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1.var_.moveOldPos10048ui_story = var_230_4.localPosition
			end

			local var_230_6 = 0.001

			if var_230_5 <= arg_227_1.time_ and arg_227_1.time_ < var_230_5 + var_230_6 then
				local var_230_7 = (arg_227_1.time_ - var_230_5) / var_230_6
				local var_230_8 = Vector3.New(0, 100, 0)

				var_230_4.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10048ui_story, var_230_8, var_230_7)

				local var_230_9 = manager.ui.mainCamera.transform.position - var_230_4.position

				var_230_4.forward = Vector3.New(var_230_9.x, var_230_9.y, var_230_9.z)

				local var_230_10 = var_230_4.localEulerAngles

				var_230_10.z = 0
				var_230_10.x = 0
				var_230_4.localEulerAngles = var_230_10
			end

			if arg_227_1.time_ >= var_230_5 + var_230_6 and arg_227_1.time_ < var_230_5 + var_230_6 + arg_230_0 then
				var_230_4.localPosition = Vector3.New(0, 100, 0)

				local var_230_11 = manager.ui.mainCamera.transform.position - var_230_4.position

				var_230_4.forward = Vector3.New(var_230_11.x, var_230_11.y, var_230_11.z)

				local var_230_12 = var_230_4.localEulerAngles

				var_230_12.z = 0
				var_230_12.x = 0
				var_230_4.localEulerAngles = var_230_12
			end

			local var_230_13 = 0
			local var_230_14 = 1.45

			if var_230_13 < arg_227_1.time_ and arg_227_1.time_ <= var_230_13 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_15 = arg_227_1:GetWordFromCfg(123122055)
				local var_230_16 = arg_227_1:FormatText(var_230_15.content)

				arg_227_1.text_.text = var_230_16

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_17 = 58
				local var_230_18 = utf8.len(var_230_16)
				local var_230_19 = var_230_17 <= 0 and var_230_14 or var_230_14 * (var_230_18 / var_230_17)

				if var_230_19 > 0 and var_230_14 < var_230_19 then
					arg_227_1.talkMaxDuration = var_230_19

					if var_230_19 + var_230_13 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_19 + var_230_13
					end
				end

				arg_227_1.text_.text = var_230_16
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_20 = math.max(var_230_14, arg_227_1.talkMaxDuration)

			if var_230_13 <= arg_227_1.time_ and arg_227_1.time_ < var_230_13 + var_230_20 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_13) / var_230_20

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_13 + var_230_20 and arg_227_1.time_ < var_230_13 + var_230_20 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play123122056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 123122056
		arg_231_1.duration_ = 4.73

		local var_231_0 = {
			zh = 4.733,
			ja = 3.5
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play123122057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10048ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect10048ui_story == nil then
				arg_231_1.var_.characterEffect10048ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect10048ui_story and not isNil(var_234_0) then
					local var_234_4 = Mathf.Lerp(0, 0.5, var_234_3)

					arg_231_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10048ui_story.fillRatio = var_234_4
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect10048ui_story then
				local var_234_5 = 0.5

				arg_231_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10048ui_story.fillRatio = var_234_5
			end

			local var_234_6 = 0
			local var_234_7 = 0.125

			if var_234_6 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_8 = arg_231_1:FormatText(StoryNameCfg[36].name)

				arg_231_1.leftNameTxt_.text = var_234_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4030")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_9 = arg_231_1:GetWordFromCfg(123122056)
				local var_234_10 = arg_231_1:FormatText(var_234_9.content)

				arg_231_1.text_.text = var_234_10

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 5
				local var_234_12 = utf8.len(var_234_10)
				local var_234_13 = var_234_11 <= 0 and var_234_7 or var_234_7 * (var_234_12 / var_234_11)

				if var_234_13 > 0 and var_234_7 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_10
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122056", "story_v_out_123122.awb") ~= 0 then
					local var_234_14 = manager.audio:GetVoiceLength("story_v_out_123122", "123122056", "story_v_out_123122.awb") / 1000

					if var_234_14 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_6
					end

					if var_234_9.prefab_name ~= "" and arg_231_1.actors_[var_234_9.prefab_name] ~= nil then
						local var_234_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_9.prefab_name].transform, "story_v_out_123122", "123122056", "story_v_out_123122.awb")

						arg_231_1:RecordAudio("123122056", var_234_15)
						arg_231_1:RecordAudio("123122056", var_234_15)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_123122", "123122056", "story_v_out_123122.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_123122", "123122056", "story_v_out_123122.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_16 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_16 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_6) / var_234_16

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_6 + var_234_16 and arg_231_1.time_ < var_234_6 + var_234_16 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play123122057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 123122057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play123122058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10048ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect10048ui_story == nil then
				arg_235_1.var_.characterEffect10048ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect10048ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect10048ui_story then
				arg_235_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_238_4 = 0
			local var_238_5 = 0.775

			if var_238_4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(123122057)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_8 = 31
				local var_238_9 = utf8.len(var_238_7)
				local var_238_10 = var_238_8 <= 0 and var_238_5 or var_238_5 * (var_238_9 / var_238_8)

				if var_238_10 > 0 and var_238_5 < var_238_10 then
					arg_235_1.talkMaxDuration = var_238_10

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_11 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_11 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_11

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_11 and arg_235_1.time_ < var_238_4 + var_238_11 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play123122058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 123122058
		arg_239_1.duration_ = 9.6

		local var_239_0 = {
			zh = 8.066,
			ja = 9.6
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play123122059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["10048ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos10048ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, -1.155, -6.13)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10048ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -1.155, -6.13)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["10048ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect10048ui_story == nil then
				arg_239_1.var_.characterEffect10048ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect10048ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect10048ui_story then
				arg_239_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_242_13 = 0

			if var_242_13 < arg_239_1.time_ and arg_239_1.time_ <= var_242_13 + arg_242_0 then
				arg_239_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action3_1")
			end

			local var_242_14 = 0

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_242_15 = 0
			local var_242_16 = 0.525

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_17 = arg_239_1:FormatText(StoryNameCfg[486].name)

				arg_239_1.leftNameTxt_.text = var_242_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_18 = arg_239_1:GetWordFromCfg(123122058)
				local var_242_19 = arg_239_1:FormatText(var_242_18.content)

				arg_239_1.text_.text = var_242_19

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_20 = 21
				local var_242_21 = utf8.len(var_242_19)
				local var_242_22 = var_242_20 <= 0 and var_242_16 or var_242_16 * (var_242_21 / var_242_20)

				if var_242_22 > 0 and var_242_16 < var_242_22 then
					arg_239_1.talkMaxDuration = var_242_22

					if var_242_22 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_15
					end
				end

				arg_239_1.text_.text = var_242_19
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122058", "story_v_out_123122.awb") ~= 0 then
					local var_242_23 = manager.audio:GetVoiceLength("story_v_out_123122", "123122058", "story_v_out_123122.awb") / 1000

					if var_242_23 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_15
					end

					if var_242_18.prefab_name ~= "" and arg_239_1.actors_[var_242_18.prefab_name] ~= nil then
						local var_242_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_18.prefab_name].transform, "story_v_out_123122", "123122058", "story_v_out_123122.awb")

						arg_239_1:RecordAudio("123122058", var_242_24)
						arg_239_1:RecordAudio("123122058", var_242_24)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_123122", "123122058", "story_v_out_123122.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_123122", "123122058", "story_v_out_123122.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = math.max(var_242_16, arg_239_1.talkMaxDuration)

			if var_242_15 <= arg_239_1.time_ and arg_239_1.time_ < var_242_15 + var_242_25 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_15) / var_242_25

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_15 + var_242_25 and arg_239_1.time_ < var_242_15 + var_242_25 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play123122059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 123122059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play123122060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10048ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect10048ui_story == nil then
				arg_243_1.var_.characterEffect10048ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect10048ui_story and not isNil(var_246_0) then
					local var_246_4 = Mathf.Lerp(0, 0.5, var_246_3)

					arg_243_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_243_1.var_.characterEffect10048ui_story.fillRatio = var_246_4
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect10048ui_story then
				local var_246_5 = 0.5

				arg_243_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_243_1.var_.characterEffect10048ui_story.fillRatio = var_246_5
			end

			local var_246_6 = arg_243_1.actors_["10048ui_story"].transform
			local var_246_7 = 0

			if var_246_7 < arg_243_1.time_ and arg_243_1.time_ <= var_246_7 + arg_246_0 then
				arg_243_1.var_.moveOldPos10048ui_story = var_246_6.localPosition
			end

			local var_246_8 = 0.001

			if var_246_7 <= arg_243_1.time_ and arg_243_1.time_ < var_246_7 + var_246_8 then
				local var_246_9 = (arg_243_1.time_ - var_246_7) / var_246_8
				local var_246_10 = Vector3.New(0, 100, 0)

				var_246_6.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10048ui_story, var_246_10, var_246_9)

				local var_246_11 = manager.ui.mainCamera.transform.position - var_246_6.position

				var_246_6.forward = Vector3.New(var_246_11.x, var_246_11.y, var_246_11.z)

				local var_246_12 = var_246_6.localEulerAngles

				var_246_12.z = 0
				var_246_12.x = 0
				var_246_6.localEulerAngles = var_246_12
			end

			if arg_243_1.time_ >= var_246_7 + var_246_8 and arg_243_1.time_ < var_246_7 + var_246_8 + arg_246_0 then
				var_246_6.localPosition = Vector3.New(0, 100, 0)

				local var_246_13 = manager.ui.mainCamera.transform.position - var_246_6.position

				var_246_6.forward = Vector3.New(var_246_13.x, var_246_13.y, var_246_13.z)

				local var_246_14 = var_246_6.localEulerAngles

				var_246_14.z = 0
				var_246_14.x = 0
				var_246_6.localEulerAngles = var_246_14
			end

			local var_246_15 = 0
			local var_246_16 = 0.825

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_17 = arg_243_1:GetWordFromCfg(123122059)
				local var_246_18 = arg_243_1:FormatText(var_246_17.content)

				arg_243_1.text_.text = var_246_18

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_19 = 33
				local var_246_20 = utf8.len(var_246_18)
				local var_246_21 = var_246_19 <= 0 and var_246_16 or var_246_16 * (var_246_20 / var_246_19)

				if var_246_21 > 0 and var_246_16 < var_246_21 then
					arg_243_1.talkMaxDuration = var_246_21

					if var_246_21 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_21 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_18
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_22 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_22 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_22

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_22 and arg_243_1.time_ < var_246_15 + var_246_22 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play123122060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 123122060
		arg_247_1.duration_ = 7.4

		local var_247_0 = {
			zh = 4.5,
			ja = 7.4
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play123122061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10048ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos10048ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0, -1.155, -6.13)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10048ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, -1.155, -6.13)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["10048ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10048ui_story == nil then
				arg_247_1.var_.characterEffect10048ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect10048ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10048ui_story then
				arg_247_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_250_13 = 0

			if var_250_13 < arg_247_1.time_ and arg_247_1.time_ <= var_250_13 + arg_250_0 then
				arg_247_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action3_2")
			end

			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_250_15 = 0
			local var_250_16 = 0.35

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_17 = arg_247_1:FormatText(StoryNameCfg[486].name)

				arg_247_1.leftNameTxt_.text = var_250_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_18 = arg_247_1:GetWordFromCfg(123122060)
				local var_250_19 = arg_247_1:FormatText(var_250_18.content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_20 = 14
				local var_250_21 = utf8.len(var_250_19)
				local var_250_22 = var_250_20 <= 0 and var_250_16 or var_250_16 * (var_250_21 / var_250_20)

				if var_250_22 > 0 and var_250_16 < var_250_22 then
					arg_247_1.talkMaxDuration = var_250_22

					if var_250_22 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_22 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_19
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123122", "123122060", "story_v_out_123122.awb") ~= 0 then
					local var_250_23 = manager.audio:GetVoiceLength("story_v_out_123122", "123122060", "story_v_out_123122.awb") / 1000

					if var_250_23 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_15
					end

					if var_250_18.prefab_name ~= "" and arg_247_1.actors_[var_250_18.prefab_name] ~= nil then
						local var_250_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_18.prefab_name].transform, "story_v_out_123122", "123122060", "story_v_out_123122.awb")

						arg_247_1:RecordAudio("123122060", var_250_24)
						arg_247_1:RecordAudio("123122060", var_250_24)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_123122", "123122060", "story_v_out_123122.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_123122", "123122060", "story_v_out_123122.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_25 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_25 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_25

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_25 and arg_247_1.time_ < var_250_15 + var_250_25 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play123122061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 123122061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
			arg_251_1.auto_ = false
		end

		function arg_251_1.playNext_(arg_253_0)
			arg_251_1.onStoryFinished_()
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10048ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect10048ui_story == nil then
				arg_251_1.var_.characterEffect10048ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect10048ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10048ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect10048ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10048ui_story.fillRatio = var_254_5
			end

			local var_254_6 = arg_251_1.actors_["10048ui_story"].transform
			local var_254_7 = 0

			if var_254_7 < arg_251_1.time_ and arg_251_1.time_ <= var_254_7 + arg_254_0 then
				arg_251_1.var_.moveOldPos10048ui_story = var_254_6.localPosition
			end

			local var_254_8 = 0.001

			if var_254_7 <= arg_251_1.time_ and arg_251_1.time_ < var_254_7 + var_254_8 then
				local var_254_9 = (arg_251_1.time_ - var_254_7) / var_254_8
				local var_254_10 = Vector3.New(0, 100, 0)

				var_254_6.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10048ui_story, var_254_10, var_254_9)

				local var_254_11 = manager.ui.mainCamera.transform.position - var_254_6.position

				var_254_6.forward = Vector3.New(var_254_11.x, var_254_11.y, var_254_11.z)

				local var_254_12 = var_254_6.localEulerAngles

				var_254_12.z = 0
				var_254_12.x = 0
				var_254_6.localEulerAngles = var_254_12
			end

			if arg_251_1.time_ >= var_254_7 + var_254_8 and arg_251_1.time_ < var_254_7 + var_254_8 + arg_254_0 then
				var_254_6.localPosition = Vector3.New(0, 100, 0)

				local var_254_13 = manager.ui.mainCamera.transform.position - var_254_6.position

				var_254_6.forward = Vector3.New(var_254_13.x, var_254_13.y, var_254_13.z)

				local var_254_14 = var_254_6.localEulerAngles

				var_254_14.z = 0
				var_254_14.x = 0
				var_254_6.localEulerAngles = var_254_14
			end

			local var_254_15 = 0
			local var_254_16 = 1

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				local var_254_17 = "play"
				local var_254_18 = "effect"

				arg_251_1:AudioAction(var_254_17, var_254_18, "se_story_123_01", "se_story_123_01_bird", "")
			end

			local var_254_19 = 0
			local var_254_20 = 0.725

			if var_254_19 < arg_251_1.time_ and arg_251_1.time_ <= var_254_19 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_21 = arg_251_1:GetWordFromCfg(123122061)
				local var_254_22 = arg_251_1:FormatText(var_254_21.content)

				arg_251_1.text_.text = var_254_22

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_23 = 29
				local var_254_24 = utf8.len(var_254_22)
				local var_254_25 = var_254_23 <= 0 and var_254_20 or var_254_20 * (var_254_24 / var_254_23)

				if var_254_25 > 0 and var_254_20 < var_254_25 then
					arg_251_1.talkMaxDuration = var_254_25

					if var_254_25 + var_254_19 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_25 + var_254_19
					end
				end

				arg_251_1.text_.text = var_254_22
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_26 = math.max(var_254_20, arg_251_1.talkMaxDuration)

			if var_254_19 <= arg_251_1.time_ and arg_251_1.time_ < var_254_19 + var_254_26 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_19) / var_254_26

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_19 + var_254_26 and arg_251_1.time_ < var_254_19 + var_254_26 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K07g",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/K04g"
	},
	voices = {
		"story_v_out_123122.awb"
	}
}
