return {
	Play318171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318171001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K16f"

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
				local var_4_5 = arg_1_1.bgs_.K16f

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
					if iter_4_0 ~= "K16f" then
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
			local var_4_23 = 0.533333333333333

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

			local var_4_28 = 0.8
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_10_story_sasanami_photonrail", "bgm_activity_2_10_story_sasanami_photonrail", "bgm_activity_2_10_story_sasanami_photonrail.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_10_story_sasanami_photonrail", "bgm_activity_2_10_story_sasanami_photonrail")

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
			local var_4_35 = 0.2

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(318171001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 8
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_34 + 0.3
			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play318171002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318171002
		arg_9_1.duration_ = 4.57

		local var_9_0 = {
			zh = 4.533,
			ja = 4.566
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
				arg_9_0:Play318171003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1015ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1015ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1015ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1015ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -1.15, -6.2)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1015ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1015ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1015ui_story == nil then
				arg_9_1.var_.characterEffect1015ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1015ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1015ui_story then
				arg_9_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.5

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[479].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(318171002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171002", "story_v_out_318171.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_318171", "318171002", "story_v_out_318171.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_318171", "318171002", "story_v_out_318171.awb")

						arg_9_1:RecordAudio("318171002", var_12_29)
						arg_9_1:RecordAudio("318171002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_318171", "318171002", "story_v_out_318171.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_318171", "318171002", "story_v_out_318171.awb")
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
				actorName = "1015ui_story",
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
	Play318171003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318171003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play318171004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1015ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1015ui_story == nil then
				arg_13_1.var_.characterEffect1015ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1015ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1015ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1015ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1015ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.275

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

				local var_16_9 = arg_13_1:GetWordFromCfg(318171003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 11
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
	Play318171004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318171004
		arg_17_1.duration_ = 8.33

		local var_17_0 = {
			zh = 8.333,
			ja = 8.233
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
				arg_17_0:Play318171005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1019ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["1019ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1019ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1019ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1019ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1019ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1019ui_story then
				arg_17_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_20 = arg_17_1.actors_["1015ui_story"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos1015ui_story = var_20_20.localPosition
			end

			local var_20_22 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22
				local var_20_24 = Vector3.New(0, 100, 0)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1015ui_story, var_20_24, var_20_23)

				local var_20_25 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_25.x, var_20_25.y, var_20_25.z)

				local var_20_26 = var_20_20.localEulerAngles

				var_20_26.z = 0
				var_20_26.x = 0
				var_20_20.localEulerAngles = var_20_26
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(0, 100, 0)

				local var_20_27 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_27.x, var_20_27.y, var_20_27.z)

				local var_20_28 = var_20_20.localEulerAngles

				var_20_28.z = 0
				var_20_28.x = 0
				var_20_20.localEulerAngles = var_20_28
			end

			local var_20_29 = arg_17_1.actors_["1019ui_story"]
			local var_20_30 = 0

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 then
				if arg_17_1.var_.characterEffect1019ui_story == nil then
					arg_17_1.var_.characterEffect1019ui_story = var_20_29:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_20_31 = arg_17_1.var_.characterEffect1019ui_story

				var_20_31.imageEffect:turnOff()

				var_20_31.interferenceEffect.enabled = true
				var_20_31.interferenceEffect.noise = 0.001
				var_20_31.interferenceEffect.simTimeScale = 1
				var_20_31.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_20_32 = arg_17_1.actors_["1019ui_story"]
			local var_20_33 = 0
			local var_20_34 = 2

			if var_20_33 < arg_17_1.time_ and arg_17_1.time_ <= var_20_33 + arg_20_0 then
				if arg_17_1.var_.characterEffect1019ui_story == nil then
					arg_17_1.var_.characterEffect1019ui_story = var_20_32:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_17_1.var_.characterEffect1019ui_story.imageEffect:turnOn(false)
			end

			local var_20_35 = 0
			local var_20_36 = 1

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_37 = arg_17_1:FormatText(StoryNameCfg[13].name)

				arg_17_1.leftNameTxt_.text = var_20_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_38 = arg_17_1:GetWordFromCfg(318171004)
				local var_20_39 = arg_17_1:FormatText(var_20_38.content)

				arg_17_1.text_.text = var_20_39

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_40 = 40
				local var_20_41 = utf8.len(var_20_39)
				local var_20_42 = var_20_40 <= 0 and var_20_36 or var_20_36 * (var_20_41 / var_20_40)

				if var_20_42 > 0 and var_20_36 < var_20_42 then
					arg_17_1.talkMaxDuration = var_20_42

					if var_20_42 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_42 + var_20_35
					end
				end

				arg_17_1.text_.text = var_20_39
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171004", "story_v_out_318171.awb") ~= 0 then
					local var_20_43 = manager.audio:GetVoiceLength("story_v_out_318171", "318171004", "story_v_out_318171.awb") / 1000

					if var_20_43 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_43 + var_20_35
					end

					if var_20_38.prefab_name ~= "" and arg_17_1.actors_[var_20_38.prefab_name] ~= nil then
						local var_20_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_38.prefab_name].transform, "story_v_out_318171", "318171004", "story_v_out_318171.awb")

						arg_17_1:RecordAudio("318171004", var_20_44)
						arg_17_1:RecordAudio("318171004", var_20_44)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_318171", "318171004", "story_v_out_318171.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_318171", "318171004", "story_v_out_318171.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_45 = math.max(var_20_36, arg_17_1.talkMaxDuration)

			if var_20_35 <= arg_17_1.time_ and arg_17_1.time_ < var_20_35 + var_20_45 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_35) / var_20_45

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_35 + var_20_45 and arg_17_1.time_ < var_20_35 + var_20_45 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318171005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318171005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play318171006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1033ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_21_1.stage_.transform)

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

			local var_24_5 = arg_21_1.actors_["1033ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos1033ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0, -1.01, -6.13)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1033ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["1033ui_story"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1033ui_story == nil then
				arg_21_1.var_.characterEffect1033ui_story = var_24_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_16 = 0.200000002980232

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.characterEffect1033ui_story and not isNil(var_24_14) then
					arg_21_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1033ui_story then
				arg_21_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_20 = arg_21_1.actors_["1019ui_story"].transform
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.var_.moveOldPos1019ui_story = var_24_20.localPosition
			end

			local var_24_22 = 0.001

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22
				local var_24_24 = Vector3.New(0, 100, 0)

				var_24_20.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1019ui_story, var_24_24, var_24_23)

				local var_24_25 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_25.x, var_24_25.y, var_24_25.z)

				local var_24_26 = var_24_20.localEulerAngles

				var_24_26.z = 0
				var_24_26.x = 0
				var_24_20.localEulerAngles = var_24_26
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 then
				var_24_20.localPosition = Vector3.New(0, 100, 0)

				local var_24_27 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_27.x, var_24_27.y, var_24_27.z)

				local var_24_28 = var_24_20.localEulerAngles

				var_24_28.z = 0
				var_24_28.x = 0
				var_24_20.localEulerAngles = var_24_28
			end

			local var_24_29 = arg_21_1.actors_["1019ui_story"]
			local var_24_30 = 0

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.characterEffect1019ui_story == nil then
				arg_21_1.var_.characterEffect1019ui_story = var_24_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_31 = 0.200000002980232

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_31 and not isNil(var_24_29) then
				local var_24_32 = (arg_21_1.time_ - var_24_30) / var_24_31

				if arg_21_1.var_.characterEffect1019ui_story and not isNil(var_24_29) then
					local var_24_33 = Mathf.Lerp(0, 0.5, var_24_32)

					arg_21_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1019ui_story.fillRatio = var_24_33
				end
			end

			if arg_21_1.time_ >= var_24_30 + var_24_31 and arg_21_1.time_ < var_24_30 + var_24_31 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.characterEffect1019ui_story then
				local var_24_34 = 0.5

				arg_21_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1019ui_story.fillRatio = var_24_34
			end

			local var_24_35 = arg_21_1.actors_["1033ui_story"]
			local var_24_36 = 0

			if var_24_36 < arg_21_1.time_ and arg_21_1.time_ <= var_24_36 + arg_24_0 then
				if arg_21_1.var_.characterEffect1033ui_story == nil then
					arg_21_1.var_.characterEffect1033ui_story = var_24_35:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_24_37 = arg_21_1.var_.characterEffect1033ui_story

				var_24_37.imageEffect:turnOff()

				var_24_37.interferenceEffect.enabled = true
				var_24_37.interferenceEffect.noise = 0.001
				var_24_37.interferenceEffect.simTimeScale = 1
				var_24_37.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_24_38 = arg_21_1.actors_["1033ui_story"]
			local var_24_39 = 0
			local var_24_40 = 5

			if var_24_39 < arg_21_1.time_ and arg_21_1.time_ <= var_24_39 + arg_24_0 then
				if arg_21_1.var_.characterEffect1033ui_story == nil then
					arg_21_1.var_.characterEffect1033ui_story = var_24_38:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_21_1.var_.characterEffect1033ui_story.imageEffect:turnOn(false)
			end

			local var_24_41 = 0
			local var_24_42 = 0.2

			if var_24_41 < arg_21_1.time_ and arg_21_1.time_ <= var_24_41 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_43 = arg_21_1:FormatText(StoryNameCfg[236].name)

				arg_21_1.leftNameTxt_.text = var_24_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_44 = arg_21_1:GetWordFromCfg(318171005)
				local var_24_45 = arg_21_1:FormatText(var_24_44.content)

				arg_21_1.text_.text = var_24_45

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_46 = 8
				local var_24_47 = utf8.len(var_24_45)
				local var_24_48 = var_24_46 <= 0 and var_24_42 or var_24_42 * (var_24_47 / var_24_46)

				if var_24_48 > 0 and var_24_42 < var_24_48 then
					arg_21_1.talkMaxDuration = var_24_48

					if var_24_48 + var_24_41 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_48 + var_24_41
					end
				end

				arg_21_1.text_.text = var_24_45
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171005", "story_v_out_318171.awb") ~= 0 then
					local var_24_49 = manager.audio:GetVoiceLength("story_v_out_318171", "318171005", "story_v_out_318171.awb") / 1000

					if var_24_49 + var_24_41 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_49 + var_24_41
					end

					if var_24_44.prefab_name ~= "" and arg_21_1.actors_[var_24_44.prefab_name] ~= nil then
						local var_24_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_44.prefab_name].transform, "story_v_out_318171", "318171005", "story_v_out_318171.awb")

						arg_21_1:RecordAudio("318171005", var_24_50)
						arg_21_1:RecordAudio("318171005", var_24_50)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_318171", "318171005", "story_v_out_318171.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_318171", "318171005", "story_v_out_318171.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_51 = math.max(var_24_42, arg_21_1.talkMaxDuration)

			if var_24_41 <= arg_21_1.time_ and arg_21_1.time_ < var_24_41 + var_24_51 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_41) / var_24_51

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_41 + var_24_51 and arg_21_1.time_ < var_24_41 + var_24_51 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
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

		arg_21_1:InitPlayNodeList()
	end,
	Play318171006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318171006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play318171007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1033ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1033ui_story == nil then
				arg_25_1.var_.characterEffect1033ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1033ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1033ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1033ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1033ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.65

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(318171006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 26
				local var_28_11 = utf8.len(var_28_9)
				local var_28_12 = var_28_10 <= 0 and var_28_7 or var_28_7 * (var_28_11 / var_28_10)

				if var_28_12 > 0 and var_28_7 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_13 and arg_25_1.time_ < var_28_6 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play318171007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318171007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play318171008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.8

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(318171007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 32
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
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play318171008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318171008
		arg_33_1.duration_ = 8.13

		local var_33_0 = {
			zh = 7.7,
			ja = 8.133
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
				arg_33_0:Play318171009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1033ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1033ui_story == nil then
				arg_33_1.var_.characterEffect1033ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1033ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1033ui_story then
				arg_33_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_6 = 0
			local var_36_7 = 1.025

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[236].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:GetWordFromCfg(318171008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 41
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171008", "story_v_out_318171.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_318171", "318171008", "story_v_out_318171.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_318171", "318171008", "story_v_out_318171.awb")

						arg_33_1:RecordAudio("318171008", var_36_15)
						arg_33_1:RecordAudio("318171008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_318171", "318171008", "story_v_out_318171.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_318171", "318171008", "story_v_out_318171.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play318171009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 318171009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play318171010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1033ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1033ui_story == nil then
				arg_37_1.var_.characterEffect1033ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1033ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1033ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1033ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1033ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.175

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

				local var_40_9 = arg_37_1:GetWordFromCfg(318171009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 7
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
	Play318171010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 318171010
		arg_41_1.duration_ = 12.03

		local var_41_0 = {
			zh = 6.333,
			ja = 12.033
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
				arg_41_0:Play318171011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1033ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1033ui_story == nil then
				arg_41_1.var_.characterEffect1033ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1033ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1033ui_story then
				arg_41_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_44_4 = 0
			local var_44_5 = 0.8

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_6 = arg_41_1:FormatText(StoryNameCfg[236].name)

				arg_41_1.leftNameTxt_.text = var_44_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(318171010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 32
				local var_44_10 = utf8.len(var_44_8)
				local var_44_11 = var_44_9 <= 0 and var_44_5 or var_44_5 * (var_44_10 / var_44_9)

				if var_44_11 > 0 and var_44_5 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171010", "story_v_out_318171.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_318171", "318171010", "story_v_out_318171.awb") / 1000

					if var_44_12 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_4
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_318171", "318171010", "story_v_out_318171.awb")

						arg_41_1:RecordAudio("318171010", var_44_13)
						arg_41_1:RecordAudio("318171010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_318171", "318171010", "story_v_out_318171.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_318171", "318171010", "story_v_out_318171.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_14 and arg_41_1.time_ < var_44_4 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play318171011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 318171011
		arg_45_1.duration_ = 11.7

		local var_45_0 = {
			zh = 8.266,
			ja = 11.7
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
				arg_45_0:Play318171012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.05

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[236].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(318171011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171011", "story_v_out_318171.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171011", "story_v_out_318171.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_318171", "318171011", "story_v_out_318171.awb")

						arg_45_1:RecordAudio("318171011", var_48_9)
						arg_45_1:RecordAudio("318171011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_318171", "318171011", "story_v_out_318171.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_318171", "318171011", "story_v_out_318171.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play318171012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 318171012
		arg_49_1.duration_ = 18.93

		local var_49_0 = {
			zh = 10.833,
			ja = 18.933
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
				arg_49_0:Play318171013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.275

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[236].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(318171012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 51
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171012", "story_v_out_318171.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171012", "story_v_out_318171.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_318171", "318171012", "story_v_out_318171.awb")

						arg_49_1:RecordAudio("318171012", var_52_9)
						arg_49_1:RecordAudio("318171012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_318171", "318171012", "story_v_out_318171.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_318171", "318171012", "story_v_out_318171.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play318171013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 318171013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play318171014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1033ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1033ui_story == nil then
				arg_53_1.var_.characterEffect1033ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1033ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1033ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1033ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1033ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.425

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(318171013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 17
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play318171014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 318171014
		arg_57_1.duration_ = 11.73

		local var_57_0 = {
			zh = 10.3,
			ja = 11.733
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
				arg_57_0:Play318171015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1033ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1033ui_story == nil then
				arg_57_1.var_.characterEffect1033ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1033ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1033ui_story then
				arg_57_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_60_4 = 0
			local var_60_5 = 1.2

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_6 = arg_57_1:FormatText(StoryNameCfg[236].name)

				arg_57_1.leftNameTxt_.text = var_60_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(318171014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 48
				local var_60_10 = utf8.len(var_60_8)
				local var_60_11 = var_60_9 <= 0 and var_60_5 or var_60_5 * (var_60_10 / var_60_9)

				if var_60_11 > 0 and var_60_5 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171014", "story_v_out_318171.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_318171", "318171014", "story_v_out_318171.awb") / 1000

					if var_60_12 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_4
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_318171", "318171014", "story_v_out_318171.awb")

						arg_57_1:RecordAudio("318171014", var_60_13)
						arg_57_1:RecordAudio("318171014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_318171", "318171014", "story_v_out_318171.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_318171", "318171014", "story_v_out_318171.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_14 and arg_57_1.time_ < var_60_4 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play318171015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 318171015
		arg_61_1.duration_ = 8.1

		local var_61_0 = {
			zh = 5.7,
			ja = 8.1
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
				arg_61_0:Play318171016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_2")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_64_2 = 0
			local var_64_3 = 0.925

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_4 = arg_61_1:FormatText(StoryNameCfg[236].name)

				arg_61_1.leftNameTxt_.text = var_64_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:GetWordFromCfg(318171015)
				local var_64_6 = arg_61_1:FormatText(var_64_5.content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 37
				local var_64_8 = utf8.len(var_64_6)
				local var_64_9 = var_64_7 <= 0 and var_64_3 or var_64_3 * (var_64_8 / var_64_7)

				if var_64_9 > 0 and var_64_3 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_6
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171015", "story_v_out_318171.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_318171", "318171015", "story_v_out_318171.awb") / 1000

					if var_64_10 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_2
					end

					if var_64_5.prefab_name ~= "" and arg_61_1.actors_[var_64_5.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_5.prefab_name].transform, "story_v_out_318171", "318171015", "story_v_out_318171.awb")

						arg_61_1:RecordAudio("318171015", var_64_11)
						arg_61_1:RecordAudio("318171015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_318171", "318171015", "story_v_out_318171.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_318171", "318171015", "story_v_out_318171.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_12 and arg_61_1.time_ < var_64_2 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play318171016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 318171016
		arg_65_1.duration_ = 3.27

		local var_65_0 = {
			zh = 3.266,
			ja = 2.233
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
				arg_65_0:Play318171017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1015ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1015ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, -1.15, -6.2)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1015ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1015ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1015ui_story == nil then
				arg_65_1.var_.characterEffect1015ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1015ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1015ui_story then
				arg_65_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_68_15 = arg_65_1.actors_["1033ui_story"].transform
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.var_.moveOldPos1033ui_story = var_68_15.localPosition
			end

			local var_68_17 = 0.001

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17
				local var_68_19 = Vector3.New(0, 100, 0)

				var_68_15.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1033ui_story, var_68_19, var_68_18)

				local var_68_20 = manager.ui.mainCamera.transform.position - var_68_15.position

				var_68_15.forward = Vector3.New(var_68_20.x, var_68_20.y, var_68_20.z)

				local var_68_21 = var_68_15.localEulerAngles

				var_68_21.z = 0
				var_68_21.x = 0
				var_68_15.localEulerAngles = var_68_21
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 then
				var_68_15.localPosition = Vector3.New(0, 100, 0)

				local var_68_22 = manager.ui.mainCamera.transform.position - var_68_15.position

				var_68_15.forward = Vector3.New(var_68_22.x, var_68_22.y, var_68_22.z)

				local var_68_23 = var_68_15.localEulerAngles

				var_68_23.z = 0
				var_68_23.x = 0
				var_68_15.localEulerAngles = var_68_23
			end

			local var_68_24 = arg_65_1.actors_["1033ui_story"]
			local var_68_25 = 0

			if var_68_25 < arg_65_1.time_ and arg_65_1.time_ <= var_68_25 + arg_68_0 and not isNil(var_68_24) and arg_65_1.var_.characterEffect1033ui_story == nil then
				arg_65_1.var_.characterEffect1033ui_story = var_68_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_26 = 0.200000002980232

			if var_68_25 <= arg_65_1.time_ and arg_65_1.time_ < var_68_25 + var_68_26 and not isNil(var_68_24) then
				local var_68_27 = (arg_65_1.time_ - var_68_25) / var_68_26

				if arg_65_1.var_.characterEffect1033ui_story and not isNil(var_68_24) then
					local var_68_28 = Mathf.Lerp(0, 0.5, var_68_27)

					arg_65_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1033ui_story.fillRatio = var_68_28
				end
			end

			if arg_65_1.time_ >= var_68_25 + var_68_26 and arg_65_1.time_ < var_68_25 + var_68_26 + arg_68_0 and not isNil(var_68_24) and arg_65_1.var_.characterEffect1033ui_story then
				local var_68_29 = 0.5

				arg_65_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1033ui_story.fillRatio = var_68_29
			end

			local var_68_30 = 0
			local var_68_31 = 0.375

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_32 = arg_65_1:FormatText(StoryNameCfg[479].name)

				arg_65_1.leftNameTxt_.text = var_68_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_33 = arg_65_1:GetWordFromCfg(318171016)
				local var_68_34 = arg_65_1:FormatText(var_68_33.content)

				arg_65_1.text_.text = var_68_34

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_35 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171016", "story_v_out_318171.awb") ~= 0 then
					local var_68_38 = manager.audio:GetVoiceLength("story_v_out_318171", "318171016", "story_v_out_318171.awb") / 1000

					if var_68_38 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_38 + var_68_30
					end

					if var_68_33.prefab_name ~= "" and arg_65_1.actors_[var_68_33.prefab_name] ~= nil then
						local var_68_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_33.prefab_name].transform, "story_v_out_318171", "318171016", "story_v_out_318171.awb")

						arg_65_1:RecordAudio("318171016", var_68_39)
						arg_65_1:RecordAudio("318171016", var_68_39)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_318171", "318171016", "story_v_out_318171.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_318171", "318171016", "story_v_out_318171.awb")
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
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
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
	Play318171017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 318171017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play318171018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1015ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1015ui_story == nil then
				arg_69_1.var_.characterEffect1015ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1015ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1015ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1015ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1015ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.325

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(318171017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 13
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
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play318171018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 318171018
		arg_73_1.duration_ = 8.07

		local var_73_0 = {
			zh = 8.066,
			ja = 5.9
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
				arg_73_0:Play318171019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1015ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1015ui_story == nil then
				arg_73_1.var_.characterEffect1015ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1015ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1015ui_story then
				arg_73_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_76_4 = 0

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_5 = 0
			local var_76_6 = 1.075

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_7 = arg_73_1:FormatText(StoryNameCfg[479].name)

				arg_73_1.leftNameTxt_.text = var_76_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(318171018)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 43
				local var_76_11 = utf8.len(var_76_9)
				local var_76_12 = var_76_10 <= 0 and var_76_6 or var_76_6 * (var_76_11 / var_76_10)

				if var_76_12 > 0 and var_76_6 < var_76_12 then
					arg_73_1.talkMaxDuration = var_76_12

					if var_76_12 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171018", "story_v_out_318171.awb") ~= 0 then
					local var_76_13 = manager.audio:GetVoiceLength("story_v_out_318171", "318171018", "story_v_out_318171.awb") / 1000

					if var_76_13 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_5
					end

					if var_76_8.prefab_name ~= "" and arg_73_1.actors_[var_76_8.prefab_name] ~= nil then
						local var_76_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_8.prefab_name].transform, "story_v_out_318171", "318171018", "story_v_out_318171.awb")

						arg_73_1:RecordAudio("318171018", var_76_14)
						arg_73_1:RecordAudio("318171018", var_76_14)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_318171", "318171018", "story_v_out_318171.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_318171", "318171018", "story_v_out_318171.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_15 = math.max(var_76_6, arg_73_1.talkMaxDuration)

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_15 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_5) / var_76_15

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_5 + var_76_15 and arg_73_1.time_ < var_76_5 + var_76_15 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play318171019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 318171019
		arg_77_1.duration_ = 12.87

		local var_77_0 = {
			zh = 9.7,
			ja = 12.866
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
				arg_77_0:Play318171020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1015ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1015ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, -1.15, -6.2)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1015ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["1015ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1015ui_story == nil then
				arg_77_1.var_.characterEffect1015ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect1015ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1015ui_story then
				arg_77_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_1")
			end

			local var_80_14 = 0

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_15 = 0
			local var_80_16 = 1.15

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[479].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(318171019)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 46
				local var_80_21 = utf8.len(var_80_19)
				local var_80_22 = var_80_20 <= 0 and var_80_16 or var_80_16 * (var_80_21 / var_80_20)

				if var_80_22 > 0 and var_80_16 < var_80_22 then
					arg_77_1.talkMaxDuration = var_80_22

					if var_80_22 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_19
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171019", "story_v_out_318171.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_318171", "318171019", "story_v_out_318171.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_318171", "318171019", "story_v_out_318171.awb")

						arg_77_1:RecordAudio("318171019", var_80_24)
						arg_77_1:RecordAudio("318171019", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_318171", "318171019", "story_v_out_318171.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_318171", "318171019", "story_v_out_318171.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_25 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_25

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_25 and arg_77_1.time_ < var_80_15 + var_80_25 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318171020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 318171020
		arg_81_1.duration_ = 8.83

		local var_81_0 = {
			zh = 8.833,
			ja = 8.5
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
				arg_81_0:Play318171021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 1

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[479].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(318171020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171020", "story_v_out_318171.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171020", "story_v_out_318171.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_318171", "318171020", "story_v_out_318171.awb")

						arg_81_1:RecordAudio("318171020", var_84_9)
						arg_81_1:RecordAudio("318171020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_318171", "318171020", "story_v_out_318171.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_318171", "318171020", "story_v_out_318171.awb")
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
	Play318171021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 318171021
		arg_85_1.duration_ = 13.17

		local var_85_0 = {
			zh = 7.066,
			ja = 13.166
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
				arg_85_0:Play318171022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1033ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1033ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, -1.01, -6.13)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1033ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["1033ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1033ui_story == nil then
				arg_85_1.var_.characterEffect1033ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect1033ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1033ui_story then
				arg_85_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_14 = arg_85_1.actors_["1015ui_story"].transform
			local var_88_15 = 0

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.var_.moveOldPos1015ui_story = var_88_14.localPosition
			end

			local var_88_16 = 0.001

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_16 then
				local var_88_17 = (arg_85_1.time_ - var_88_15) / var_88_16
				local var_88_18 = Vector3.New(0, 100, 0)

				var_88_14.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1015ui_story, var_88_18, var_88_17)

				local var_88_19 = manager.ui.mainCamera.transform.position - var_88_14.position

				var_88_14.forward = Vector3.New(var_88_19.x, var_88_19.y, var_88_19.z)

				local var_88_20 = var_88_14.localEulerAngles

				var_88_20.z = 0
				var_88_20.x = 0
				var_88_14.localEulerAngles = var_88_20
			end

			if arg_85_1.time_ >= var_88_15 + var_88_16 and arg_85_1.time_ < var_88_15 + var_88_16 + arg_88_0 then
				var_88_14.localPosition = Vector3.New(0, 100, 0)

				local var_88_21 = manager.ui.mainCamera.transform.position - var_88_14.position

				var_88_14.forward = Vector3.New(var_88_21.x, var_88_21.y, var_88_21.z)

				local var_88_22 = var_88_14.localEulerAngles

				var_88_22.z = 0
				var_88_22.x = 0
				var_88_14.localEulerAngles = var_88_22
			end

			local var_88_23 = arg_85_1.actors_["1015ui_story"]
			local var_88_24 = 0

			if var_88_24 < arg_85_1.time_ and arg_85_1.time_ <= var_88_24 + arg_88_0 and not isNil(var_88_23) and arg_85_1.var_.characterEffect1015ui_story == nil then
				arg_85_1.var_.characterEffect1015ui_story = var_88_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_25 = 0.200000002980232

			if var_88_24 <= arg_85_1.time_ and arg_85_1.time_ < var_88_24 + var_88_25 and not isNil(var_88_23) then
				local var_88_26 = (arg_85_1.time_ - var_88_24) / var_88_25

				if arg_85_1.var_.characterEffect1015ui_story and not isNil(var_88_23) then
					local var_88_27 = Mathf.Lerp(0, 0.5, var_88_26)

					arg_85_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1015ui_story.fillRatio = var_88_27
				end
			end

			if arg_85_1.time_ >= var_88_24 + var_88_25 and arg_85_1.time_ < var_88_24 + var_88_25 + arg_88_0 and not isNil(var_88_23) and arg_85_1.var_.characterEffect1015ui_story then
				local var_88_28 = 0.5

				arg_85_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1015ui_story.fillRatio = var_88_28
			end

			local var_88_29 = 0
			local var_88_30 = 1.025

			if var_88_29 < arg_85_1.time_ and arg_85_1.time_ <= var_88_29 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_31 = arg_85_1:FormatText(StoryNameCfg[236].name)

				arg_85_1.leftNameTxt_.text = var_88_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_32 = arg_85_1:GetWordFromCfg(318171021)
				local var_88_33 = arg_85_1:FormatText(var_88_32.content)

				arg_85_1.text_.text = var_88_33

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_34 = 41
				local var_88_35 = utf8.len(var_88_33)
				local var_88_36 = var_88_34 <= 0 and var_88_30 or var_88_30 * (var_88_35 / var_88_34)

				if var_88_36 > 0 and var_88_30 < var_88_36 then
					arg_85_1.talkMaxDuration = var_88_36

					if var_88_36 + var_88_29 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_36 + var_88_29
					end
				end

				arg_85_1.text_.text = var_88_33
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171021", "story_v_out_318171.awb") ~= 0 then
					local var_88_37 = manager.audio:GetVoiceLength("story_v_out_318171", "318171021", "story_v_out_318171.awb") / 1000

					if var_88_37 + var_88_29 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_37 + var_88_29
					end

					if var_88_32.prefab_name ~= "" and arg_85_1.actors_[var_88_32.prefab_name] ~= nil then
						local var_88_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_32.prefab_name].transform, "story_v_out_318171", "318171021", "story_v_out_318171.awb")

						arg_85_1:RecordAudio("318171021", var_88_38)
						arg_85_1:RecordAudio("318171021", var_88_38)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_318171", "318171021", "story_v_out_318171.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_318171", "318171021", "story_v_out_318171.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_39 = math.max(var_88_30, arg_85_1.talkMaxDuration)

			if var_88_29 <= arg_85_1.time_ and arg_85_1.time_ < var_88_29 + var_88_39 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_29) / var_88_39

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_29 + var_88_39 and arg_85_1.time_ < var_88_29 + var_88_39 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318171022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 318171022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play318171023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1033ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1033ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, 100, 0)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1033ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, 100, 0)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1033ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1033ui_story == nil then
				arg_89_1.var_.characterEffect1033ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1033ui_story and not isNil(var_92_9) then
					local var_92_13 = Mathf.Lerp(0, 0.5, var_92_12)

					arg_89_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1033ui_story.fillRatio = var_92_13
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1033ui_story then
				local var_92_14 = 0.5

				arg_89_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1033ui_story.fillRatio = var_92_14
			end

			local var_92_15 = 0
			local var_92_16 = 0.05

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_17 = arg_89_1:GetWordFromCfg(318171022)
				local var_92_18 = arg_89_1:FormatText(var_92_17.content)

				arg_89_1.text_.text = var_92_18

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_19 = 2
				local var_92_20 = utf8.len(var_92_18)
				local var_92_21 = var_92_19 <= 0 and var_92_16 or var_92_16 * (var_92_20 / var_92_19)

				if var_92_21 > 0 and var_92_16 < var_92_21 then
					arg_89_1.talkMaxDuration = var_92_21

					if var_92_21 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_21 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_18
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_22 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_22 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_22

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_22 and arg_89_1.time_ < var_92_15 + var_92_22 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play318171023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 318171023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play318171024(arg_93_1)
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

				local var_96_2 = arg_93_1:GetWordFromCfg(318171023)
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
	Play318171024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 318171024
		arg_97_1.duration_ = 6.17

		local var_97_0 = {
			zh = 5.666,
			ja = 6.166
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
				arg_97_0:Play318171025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1015ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1015ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, -1.15, -6.2)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1015ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["1015ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1015ui_story == nil then
				arg_97_1.var_.characterEffect1015ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect1015ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1015ui_story then
				arg_97_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_15 = 0
			local var_100_16 = 0.775

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[479].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(318171024)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171024", "story_v_out_318171.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_318171", "318171024", "story_v_out_318171.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_318171", "318171024", "story_v_out_318171.awb")

						arg_97_1:RecordAudio("318171024", var_100_24)
						arg_97_1:RecordAudio("318171024", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_318171", "318171024", "story_v_out_318171.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_318171", "318171024", "story_v_out_318171.awb")
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
				actorName = "1015ui_story",
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
	Play318171025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 318171025
		arg_101_1.duration_ = 5.57

		local var_101_0 = {
			zh = 5.566,
			ja = 2.333
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
				arg_101_0:Play318171026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.75

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[479].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(318171025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171025", "story_v_out_318171.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171025", "story_v_out_318171.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_318171", "318171025", "story_v_out_318171.awb")

						arg_101_1:RecordAudio("318171025", var_104_9)
						arg_101_1:RecordAudio("318171025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_318171", "318171025", "story_v_out_318171.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_318171", "318171025", "story_v_out_318171.awb")
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
	Play318171026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 318171026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play318171027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1015ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1015ui_story == nil then
				arg_105_1.var_.characterEffect1015ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1015ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1015ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1015ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1015ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.875

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_9 = arg_105_1:GetWordFromCfg(318171026)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 35
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play318171027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 318171027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play318171028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1.325

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[7].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(318171027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 53
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_8 and arg_109_1.time_ < var_112_0 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play318171028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 318171028
		arg_113_1.duration_ = 5.67

		local var_113_0 = {
			zh = 5.1,
			ja = 5.666
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
				arg_113_0:Play318171029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1015ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1015ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, -1.15, -6.2)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1015ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1015ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1015ui_story == nil then
				arg_113_1.var_.characterEffect1015ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect1015ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1015ui_story then
				arg_113_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_116_13 = 0

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_15 = 0
			local var_116_16 = 0.6

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_17 = arg_113_1:FormatText(StoryNameCfg[479].name)

				arg_113_1.leftNameTxt_.text = var_116_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_18 = arg_113_1:GetWordFromCfg(318171028)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_20 = 24
				local var_116_21 = utf8.len(var_116_19)
				local var_116_22 = var_116_20 <= 0 and var_116_16 or var_116_16 * (var_116_21 / var_116_20)

				if var_116_22 > 0 and var_116_16 < var_116_22 then
					arg_113_1.talkMaxDuration = var_116_22

					if var_116_22 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_15
					end
				end

				arg_113_1.text_.text = var_116_19
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171028", "story_v_out_318171.awb") ~= 0 then
					local var_116_23 = manager.audio:GetVoiceLength("story_v_out_318171", "318171028", "story_v_out_318171.awb") / 1000

					if var_116_23 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_15
					end

					if var_116_18.prefab_name ~= "" and arg_113_1.actors_[var_116_18.prefab_name] ~= nil then
						local var_116_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_18.prefab_name].transform, "story_v_out_318171", "318171028", "story_v_out_318171.awb")

						arg_113_1:RecordAudio("318171028", var_116_24)
						arg_113_1:RecordAudio("318171028", var_116_24)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_318171", "318171028", "story_v_out_318171.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_318171", "318171028", "story_v_out_318171.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_25 = math.max(var_116_16, arg_113_1.talkMaxDuration)

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_25 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_15) / var_116_25

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_15 + var_116_25 and arg_113_1.time_ < var_116_15 + var_116_25 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318171029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 318171029
		arg_117_1.duration_ = 7.7

		local var_117_0 = {
			zh = 7.7,
			ja = 6.033
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
				arg_117_0:Play318171030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 1

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[479].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(318171029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 40
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171029", "story_v_out_318171.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171029", "story_v_out_318171.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_318171", "318171029", "story_v_out_318171.awb")

						arg_117_1:RecordAudio("318171029", var_120_9)
						arg_117_1:RecordAudio("318171029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_318171", "318171029", "story_v_out_318171.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_318171", "318171029", "story_v_out_318171.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play318171030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 318171030
		arg_121_1.duration_ = 8.57

		local var_121_0 = {
			zh = 8.566,
			ja = 6.2
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
				arg_121_0:Play318171031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 1.075

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[479].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(318171030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 43
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171030", "story_v_out_318171.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171030", "story_v_out_318171.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_318171", "318171030", "story_v_out_318171.awb")

						arg_121_1:RecordAudio("318171030", var_124_9)
						arg_121_1:RecordAudio("318171030", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_318171", "318171030", "story_v_out_318171.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_318171", "318171030", "story_v_out_318171.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_10 and arg_121_1.time_ < var_124_0 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play318171031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 318171031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play318171032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1015ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1015ui_story == nil then
				arg_125_1.var_.characterEffect1015ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1015ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1015ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1015ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1015ui_story.fillRatio = var_128_5
			end

			local var_128_6 = 0
			local var_128_7 = 0.3

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_8 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_9 = arg_125_1:GetWordFromCfg(318171031)
				local var_128_10 = arg_125_1:FormatText(var_128_9.content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 12
				local var_128_12 = utf8.len(var_128_10)
				local var_128_13 = var_128_11 <= 0 and var_128_7 or var_128_7 * (var_128_12 / var_128_11)

				if var_128_13 > 0 and var_128_7 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_14 and arg_125_1.time_ < var_128_6 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play318171032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 318171032
		arg_129_1.duration_ = 4.6

		local var_129_0 = {
			zh = 3.4,
			ja = 4.6
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play318171033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1015ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1015ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, -1.15, -6.2)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1015ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["1015ui_story"]
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1015ui_story == nil then
				arg_129_1.var_.characterEffect1015ui_story = var_132_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_11 = 0.200000002980232

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 and not isNil(var_132_9) then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11

				if arg_129_1.var_.characterEffect1015ui_story and not isNil(var_132_9) then
					arg_129_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1015ui_story then
				arg_129_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_132_13 = 0

			if var_132_13 < arg_129_1.time_ and arg_129_1.time_ <= var_132_13 + arg_132_0 then
				arg_129_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			local var_132_14 = 0

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 then
				arg_129_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_15 = 0
			local var_132_16 = 0.4

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_17 = arg_129_1:FormatText(StoryNameCfg[479].name)

				arg_129_1.leftNameTxt_.text = var_132_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_18 = arg_129_1:GetWordFromCfg(318171032)
				local var_132_19 = arg_129_1:FormatText(var_132_18.content)

				arg_129_1.text_.text = var_132_19

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_20 = 16
				local var_132_21 = utf8.len(var_132_19)
				local var_132_22 = var_132_20 <= 0 and var_132_16 or var_132_16 * (var_132_21 / var_132_20)

				if var_132_22 > 0 and var_132_16 < var_132_22 then
					arg_129_1.talkMaxDuration = var_132_22

					if var_132_22 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_22 + var_132_15
					end
				end

				arg_129_1.text_.text = var_132_19
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171032", "story_v_out_318171.awb") ~= 0 then
					local var_132_23 = manager.audio:GetVoiceLength("story_v_out_318171", "318171032", "story_v_out_318171.awb") / 1000

					if var_132_23 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_15
					end

					if var_132_18.prefab_name ~= "" and arg_129_1.actors_[var_132_18.prefab_name] ~= nil then
						local var_132_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_18.prefab_name].transform, "story_v_out_318171", "318171032", "story_v_out_318171.awb")

						arg_129_1:RecordAudio("318171032", var_132_24)
						arg_129_1:RecordAudio("318171032", var_132_24)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_318171", "318171032", "story_v_out_318171.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_318171", "318171032", "story_v_out_318171.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_25 = math.max(var_132_16, arg_129_1.talkMaxDuration)

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_25 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_15) / var_132_25

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_15 + var_132_25 and arg_129_1.time_ < var_132_15 + var_132_25 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play318171033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 318171033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play318171034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1015ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1015ui_story == nil then
				arg_133_1.var_.characterEffect1015ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1015ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1015ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1015ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1015ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0
			local var_136_7 = 0.85

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[7].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_9 = arg_133_1:GetWordFromCfg(318171033)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 34
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
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play318171034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 318171034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play318171035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.375

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

				local var_140_3 = arg_137_1:GetWordFromCfg(318171034)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 15
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
	Play318171035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 318171035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play318171036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1015ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1015ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, 100, 0)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1015ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, 100, 0)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = 0
			local var_144_10 = 0.6

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_11 = arg_141_1:GetWordFromCfg(318171035)
				local var_144_12 = arg_141_1:FormatText(var_144_11.content)

				arg_141_1.text_.text = var_144_12

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 24
				local var_144_14 = utf8.len(var_144_12)
				local var_144_15 = var_144_13 <= 0 and var_144_10 or var_144_10 * (var_144_14 / var_144_13)

				if var_144_15 > 0 and var_144_10 < var_144_15 then
					arg_141_1.talkMaxDuration = var_144_15

					if var_144_15 + var_144_9 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_9
					end
				end

				arg_141_1.text_.text = var_144_12
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_10, arg_141_1.talkMaxDuration)

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_9) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_9 + var_144_16 and arg_141_1.time_ < var_144_9 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play318171036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 318171036
		arg_145_1.duration_ = 4.33

		local var_145_0 = {
			zh = 2.233,
			ja = 4.333
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play318171037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = "10066ui_story"

			if arg_145_1.actors_[var_148_0] == nil then
				local var_148_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_148_1) then
					local var_148_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_145_1.stage_.transform)

					var_148_2.name = var_148_0
					var_148_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_145_1.actors_[var_148_0] = var_148_2

					local var_148_3 = var_148_2:GetComponentInChildren(typeof(CharacterEffect))

					var_148_3.enabled = true

					local var_148_4 = GameObjectTools.GetOrAddComponent(var_148_2, typeof(DynamicBoneHelper))

					if var_148_4 then
						var_148_4:EnableDynamicBone(false)
					end

					arg_145_1:ShowWeapon(var_148_3.transform, false)

					arg_145_1.var_[var_148_0 .. "Animator"] = var_148_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_145_1.var_[var_148_0 .. "Animator"].applyRootMotion = true
					arg_145_1.var_[var_148_0 .. "LipSync"] = var_148_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_148_5 = arg_145_1.actors_["10066ui_story"].transform
			local var_148_6 = 0

			if var_148_6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.var_.moveOldPos10066ui_story = var_148_5.localPosition
			end

			local var_148_7 = 0.001

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_7 then
				local var_148_8 = (arg_145_1.time_ - var_148_6) / var_148_7
				local var_148_9 = Vector3.New(0, -0.99, -5.83)

				var_148_5.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10066ui_story, var_148_9, var_148_8)

				local var_148_10 = manager.ui.mainCamera.transform.position - var_148_5.position

				var_148_5.forward = Vector3.New(var_148_10.x, var_148_10.y, var_148_10.z)

				local var_148_11 = var_148_5.localEulerAngles

				var_148_11.z = 0
				var_148_11.x = 0
				var_148_5.localEulerAngles = var_148_11
			end

			if arg_145_1.time_ >= var_148_6 + var_148_7 and arg_145_1.time_ < var_148_6 + var_148_7 + arg_148_0 then
				var_148_5.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_148_12 = manager.ui.mainCamera.transform.position - var_148_5.position

				var_148_5.forward = Vector3.New(var_148_12.x, var_148_12.y, var_148_12.z)

				local var_148_13 = var_148_5.localEulerAngles

				var_148_13.z = 0
				var_148_13.x = 0
				var_148_5.localEulerAngles = var_148_13
			end

			local var_148_14 = arg_145_1.actors_["10066ui_story"]
			local var_148_15 = 0

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 and not isNil(var_148_14) and arg_145_1.var_.characterEffect10066ui_story == nil then
				arg_145_1.var_.characterEffect10066ui_story = var_148_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_16 = 0.200000002980232

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_16 and not isNil(var_148_14) then
				local var_148_17 = (arg_145_1.time_ - var_148_15) / var_148_16

				if arg_145_1.var_.characterEffect10066ui_story and not isNil(var_148_14) then
					arg_145_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_15 + var_148_16 and arg_145_1.time_ < var_148_15 + var_148_16 + arg_148_0 and not isNil(var_148_14) and arg_145_1.var_.characterEffect10066ui_story then
				arg_145_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_148_18 = 0

			if var_148_18 < arg_145_1.time_ and arg_145_1.time_ <= var_148_18 + arg_148_0 then
				arg_145_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action2_1")
			end

			local var_148_19 = 0

			if var_148_19 < arg_145_1.time_ and arg_145_1.time_ <= var_148_19 + arg_148_0 then
				arg_145_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_20 = 0
			local var_148_21 = 0.25

			if var_148_20 < arg_145_1.time_ and arg_145_1.time_ <= var_148_20 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_22 = arg_145_1:FormatText(StoryNameCfg[640].name)

				arg_145_1.leftNameTxt_.text = var_148_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_23 = arg_145_1:GetWordFromCfg(318171036)
				local var_148_24 = arg_145_1:FormatText(var_148_23.content)

				arg_145_1.text_.text = var_148_24

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_25 = 10
				local var_148_26 = utf8.len(var_148_24)
				local var_148_27 = var_148_25 <= 0 and var_148_21 or var_148_21 * (var_148_26 / var_148_25)

				if var_148_27 > 0 and var_148_21 < var_148_27 then
					arg_145_1.talkMaxDuration = var_148_27

					if var_148_27 + var_148_20 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_27 + var_148_20
					end
				end

				arg_145_1.text_.text = var_148_24
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171036", "story_v_out_318171.awb") ~= 0 then
					local var_148_28 = manager.audio:GetVoiceLength("story_v_out_318171", "318171036", "story_v_out_318171.awb") / 1000

					if var_148_28 + var_148_20 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_28 + var_148_20
					end

					if var_148_23.prefab_name ~= "" and arg_145_1.actors_[var_148_23.prefab_name] ~= nil then
						local var_148_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_23.prefab_name].transform, "story_v_out_318171", "318171036", "story_v_out_318171.awb")

						arg_145_1:RecordAudio("318171036", var_148_29)
						arg_145_1:RecordAudio("318171036", var_148_29)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_318171", "318171036", "story_v_out_318171.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_318171", "318171036", "story_v_out_318171.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_30 = math.max(var_148_21, arg_145_1.talkMaxDuration)

			if var_148_20 <= arg_145_1.time_ and arg_145_1.time_ < var_148_20 + var_148_30 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_20) / var_148_30

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_20 + var_148_30 and arg_145_1.time_ < var_148_20 + var_148_30 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play318171037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 318171037
		arg_149_1.duration_ = 3.87

		local var_149_0 = {
			zh = 2.433,
			ja = 3.866
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
				arg_149_0:Play318171038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = "1049ui_story"

			if arg_149_1.actors_[var_152_0] == nil then
				local var_152_1 = Asset.Load("Char/" .. "1049ui_story")

				if not isNil(var_152_1) then
					local var_152_2 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_149_1.stage_.transform)

					var_152_2.name = var_152_0
					var_152_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_149_1.actors_[var_152_0] = var_152_2

					local var_152_3 = var_152_2:GetComponentInChildren(typeof(CharacterEffect))

					var_152_3.enabled = true

					local var_152_4 = GameObjectTools.GetOrAddComponent(var_152_2, typeof(DynamicBoneHelper))

					if var_152_4 then
						var_152_4:EnableDynamicBone(false)
					end

					arg_149_1:ShowWeapon(var_152_3.transform, false)

					arg_149_1.var_[var_152_0 .. "Animator"] = var_152_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_149_1.var_[var_152_0 .. "Animator"].applyRootMotion = true
					arg_149_1.var_[var_152_0 .. "LipSync"] = var_152_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_152_5 = arg_149_1.actors_["1049ui_story"].transform
			local var_152_6 = 0

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.var_.moveOldPos1049ui_story = var_152_5.localPosition
			end

			local var_152_7 = 0.001

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_7 then
				local var_152_8 = (arg_149_1.time_ - var_152_6) / var_152_7
				local var_152_9 = Vector3.New(0, -1.2, -6)

				var_152_5.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1049ui_story, var_152_9, var_152_8)

				local var_152_10 = manager.ui.mainCamera.transform.position - var_152_5.position

				var_152_5.forward = Vector3.New(var_152_10.x, var_152_10.y, var_152_10.z)

				local var_152_11 = var_152_5.localEulerAngles

				var_152_11.z = 0
				var_152_11.x = 0
				var_152_5.localEulerAngles = var_152_11
			end

			if arg_149_1.time_ >= var_152_6 + var_152_7 and arg_149_1.time_ < var_152_6 + var_152_7 + arg_152_0 then
				var_152_5.localPosition = Vector3.New(0, -1.2, -6)

				local var_152_12 = manager.ui.mainCamera.transform.position - var_152_5.position

				var_152_5.forward = Vector3.New(var_152_12.x, var_152_12.y, var_152_12.z)

				local var_152_13 = var_152_5.localEulerAngles

				var_152_13.z = 0
				var_152_13.x = 0
				var_152_5.localEulerAngles = var_152_13
			end

			local var_152_14 = arg_149_1.actors_["1049ui_story"]
			local var_152_15 = 0

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 and not isNil(var_152_14) and arg_149_1.var_.characterEffect1049ui_story == nil then
				arg_149_1.var_.characterEffect1049ui_story = var_152_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_16 = 0.200000002980232

			if var_152_15 <= arg_149_1.time_ and arg_149_1.time_ < var_152_15 + var_152_16 and not isNil(var_152_14) then
				local var_152_17 = (arg_149_1.time_ - var_152_15) / var_152_16

				if arg_149_1.var_.characterEffect1049ui_story and not isNil(var_152_14) then
					arg_149_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_15 + var_152_16 and arg_149_1.time_ < var_152_15 + var_152_16 + arg_152_0 and not isNil(var_152_14) and arg_149_1.var_.characterEffect1049ui_story then
				arg_149_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_152_18 = 0

			if var_152_18 < arg_149_1.time_ and arg_149_1.time_ <= var_152_18 + arg_152_0 then
				arg_149_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_152_19 = 0

			if var_152_19 < arg_149_1.time_ and arg_149_1.time_ <= var_152_19 + arg_152_0 then
				arg_149_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_152_20 = arg_149_1.actors_["10066ui_story"].transform
			local var_152_21 = 0

			if var_152_21 < arg_149_1.time_ and arg_149_1.time_ <= var_152_21 + arg_152_0 then
				arg_149_1.var_.moveOldPos10066ui_story = var_152_20.localPosition
			end

			local var_152_22 = 0.001

			if var_152_21 <= arg_149_1.time_ and arg_149_1.time_ < var_152_21 + var_152_22 then
				local var_152_23 = (arg_149_1.time_ - var_152_21) / var_152_22
				local var_152_24 = Vector3.New(0, 100, 0)

				var_152_20.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10066ui_story, var_152_24, var_152_23)

				local var_152_25 = manager.ui.mainCamera.transform.position - var_152_20.position

				var_152_20.forward = Vector3.New(var_152_25.x, var_152_25.y, var_152_25.z)

				local var_152_26 = var_152_20.localEulerAngles

				var_152_26.z = 0
				var_152_26.x = 0
				var_152_20.localEulerAngles = var_152_26
			end

			if arg_149_1.time_ >= var_152_21 + var_152_22 and arg_149_1.time_ < var_152_21 + var_152_22 + arg_152_0 then
				var_152_20.localPosition = Vector3.New(0, 100, 0)

				local var_152_27 = manager.ui.mainCamera.transform.position - var_152_20.position

				var_152_20.forward = Vector3.New(var_152_27.x, var_152_27.y, var_152_27.z)

				local var_152_28 = var_152_20.localEulerAngles

				var_152_28.z = 0
				var_152_28.x = 0
				var_152_20.localEulerAngles = var_152_28
			end

			local var_152_29 = arg_149_1.actors_["10066ui_story"]
			local var_152_30 = 0

			if var_152_30 < arg_149_1.time_ and arg_149_1.time_ <= var_152_30 + arg_152_0 and not isNil(var_152_29) and arg_149_1.var_.characterEffect10066ui_story == nil then
				arg_149_1.var_.characterEffect10066ui_story = var_152_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_31 = 0.200000002980232

			if var_152_30 <= arg_149_1.time_ and arg_149_1.time_ < var_152_30 + var_152_31 and not isNil(var_152_29) then
				local var_152_32 = (arg_149_1.time_ - var_152_30) / var_152_31

				if arg_149_1.var_.characterEffect10066ui_story and not isNil(var_152_29) then
					local var_152_33 = Mathf.Lerp(0, 0.5, var_152_32)

					arg_149_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10066ui_story.fillRatio = var_152_33
				end
			end

			if arg_149_1.time_ >= var_152_30 + var_152_31 and arg_149_1.time_ < var_152_30 + var_152_31 + arg_152_0 and not isNil(var_152_29) and arg_149_1.var_.characterEffect10066ui_story then
				local var_152_34 = 0.5

				arg_149_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10066ui_story.fillRatio = var_152_34
			end

			local var_152_35 = 0
			local var_152_36 = 0.275

			if var_152_35 < arg_149_1.time_ and arg_149_1.time_ <= var_152_35 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_37 = arg_149_1:FormatText(StoryNameCfg[562].name)

				arg_149_1.leftNameTxt_.text = var_152_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_38 = arg_149_1:GetWordFromCfg(318171037)
				local var_152_39 = arg_149_1:FormatText(var_152_38.content)

				arg_149_1.text_.text = var_152_39

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_40 = 11
				local var_152_41 = utf8.len(var_152_39)
				local var_152_42 = var_152_40 <= 0 and var_152_36 or var_152_36 * (var_152_41 / var_152_40)

				if var_152_42 > 0 and var_152_36 < var_152_42 then
					arg_149_1.talkMaxDuration = var_152_42

					if var_152_42 + var_152_35 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_42 + var_152_35
					end
				end

				arg_149_1.text_.text = var_152_39
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171037", "story_v_out_318171.awb") ~= 0 then
					local var_152_43 = manager.audio:GetVoiceLength("story_v_out_318171", "318171037", "story_v_out_318171.awb") / 1000

					if var_152_43 + var_152_35 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_43 + var_152_35
					end

					if var_152_38.prefab_name ~= "" and arg_149_1.actors_[var_152_38.prefab_name] ~= nil then
						local var_152_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_38.prefab_name].transform, "story_v_out_318171", "318171037", "story_v_out_318171.awb")

						arg_149_1:RecordAudio("318171037", var_152_44)
						arg_149_1:RecordAudio("318171037", var_152_44)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_318171", "318171037", "story_v_out_318171.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_318171", "318171037", "story_v_out_318171.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_45 = math.max(var_152_36, arg_149_1.talkMaxDuration)

			if var_152_35 <= arg_149_1.time_ and arg_149_1.time_ < var_152_35 + var_152_45 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_35) / var_152_45

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_35 + var_152_45 and arg_149_1.time_ < var_152_35 + var_152_45 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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

		arg_149_1:InitPlayNodeList()
	end,
	Play318171038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 318171038
		arg_153_1.duration_ = 13.27

		local var_153_0 = {
			zh = 9.733,
			ja = 13.266
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
				arg_153_0:Play318171039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 1.1

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[562].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(318171038)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 44
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171038", "story_v_out_318171.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171038", "story_v_out_318171.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_318171", "318171038", "story_v_out_318171.awb")

						arg_153_1:RecordAudio("318171038", var_156_9)
						arg_153_1:RecordAudio("318171038", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_318171", "318171038", "story_v_out_318171.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_318171", "318171038", "story_v_out_318171.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play318171039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 318171039
		arg_157_1.duration_ = 2.07

		local var_157_0 = {
			zh = 1.999999999999,
			ja = 2.066
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play318171040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1015ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1015ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0.7, -1.15, -6.2)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1015ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1015ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1015ui_story == nil then
				arg_157_1.var_.characterEffect1015ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.200000002980232

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect1015ui_story and not isNil(var_160_9) then
					arg_157_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1015ui_story then
				arg_157_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_160_13 = 0

			if var_160_13 < arg_157_1.time_ and arg_157_1.time_ <= var_160_13 + arg_160_0 then
				arg_157_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_160_14 = 0

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 then
				arg_157_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_15 = arg_157_1.actors_["1049ui_story"].transform
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.var_.moveOldPos1049ui_story = var_160_15.localPosition
			end

			local var_160_17 = 0.001

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 then
				local var_160_18 = (arg_157_1.time_ - var_160_16) / var_160_17
				local var_160_19 = Vector3.New(-0.7, -1.2, -6)

				var_160_15.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1049ui_story, var_160_19, var_160_18)

				local var_160_20 = manager.ui.mainCamera.transform.position - var_160_15.position

				var_160_15.forward = Vector3.New(var_160_20.x, var_160_20.y, var_160_20.z)

				local var_160_21 = var_160_15.localEulerAngles

				var_160_21.z = 0
				var_160_21.x = 0
				var_160_15.localEulerAngles = var_160_21
			end

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 then
				var_160_15.localPosition = Vector3.New(-0.7, -1.2, -6)

				local var_160_22 = manager.ui.mainCamera.transform.position - var_160_15.position

				var_160_15.forward = Vector3.New(var_160_22.x, var_160_22.y, var_160_22.z)

				local var_160_23 = var_160_15.localEulerAngles

				var_160_23.z = 0
				var_160_23.x = 0
				var_160_15.localEulerAngles = var_160_23
			end

			local var_160_24 = arg_157_1.actors_["1049ui_story"]
			local var_160_25 = 0

			if var_160_25 < arg_157_1.time_ and arg_157_1.time_ <= var_160_25 + arg_160_0 and not isNil(var_160_24) and arg_157_1.var_.characterEffect1049ui_story == nil then
				arg_157_1.var_.characterEffect1049ui_story = var_160_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_26 = 0.200000002980232

			if var_160_25 <= arg_157_1.time_ and arg_157_1.time_ < var_160_25 + var_160_26 and not isNil(var_160_24) then
				local var_160_27 = (arg_157_1.time_ - var_160_25) / var_160_26

				if arg_157_1.var_.characterEffect1049ui_story and not isNil(var_160_24) then
					local var_160_28 = Mathf.Lerp(0, 0.5, var_160_27)

					arg_157_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1049ui_story.fillRatio = var_160_28
				end
			end

			if arg_157_1.time_ >= var_160_25 + var_160_26 and arg_157_1.time_ < var_160_25 + var_160_26 + arg_160_0 and not isNil(var_160_24) and arg_157_1.var_.characterEffect1049ui_story then
				local var_160_29 = 0.5

				arg_157_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1049ui_story.fillRatio = var_160_29
			end

			local var_160_30 = 0
			local var_160_31 = 0.075

			if var_160_30 < arg_157_1.time_ and arg_157_1.time_ <= var_160_30 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_32 = arg_157_1:FormatText(StoryNameCfg[479].name)

				arg_157_1.leftNameTxt_.text = var_160_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_33 = arg_157_1:GetWordFromCfg(318171039)
				local var_160_34 = arg_157_1:FormatText(var_160_33.content)

				arg_157_1.text_.text = var_160_34

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_35 = 3
				local var_160_36 = utf8.len(var_160_34)
				local var_160_37 = var_160_35 <= 0 and var_160_31 or var_160_31 * (var_160_36 / var_160_35)

				if var_160_37 > 0 and var_160_31 < var_160_37 then
					arg_157_1.talkMaxDuration = var_160_37

					if var_160_37 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_37 + var_160_30
					end
				end

				arg_157_1.text_.text = var_160_34
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171039", "story_v_out_318171.awb") ~= 0 then
					local var_160_38 = manager.audio:GetVoiceLength("story_v_out_318171", "318171039", "story_v_out_318171.awb") / 1000

					if var_160_38 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_38 + var_160_30
					end

					if var_160_33.prefab_name ~= "" and arg_157_1.actors_[var_160_33.prefab_name] ~= nil then
						local var_160_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_33.prefab_name].transform, "story_v_out_318171", "318171039", "story_v_out_318171.awb")

						arg_157_1:RecordAudio("318171039", var_160_39)
						arg_157_1:RecordAudio("318171039", var_160_39)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_318171", "318171039", "story_v_out_318171.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_318171", "318171039", "story_v_out_318171.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_40 = math.max(var_160_31, arg_157_1.talkMaxDuration)

			if var_160_30 <= arg_157_1.time_ and arg_157_1.time_ < var_160_30 + var_160_40 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_30) / var_160_40

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_30 + var_160_40 and arg_157_1.time_ < var_160_30 + var_160_40 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play318171040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318171040
		arg_161_1.duration_ = 3.73

		local var_161_0 = {
			zh = 3.733,
			ja = 2.8
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play318171041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1049ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1049ui_story == nil then
				arg_161_1.var_.characterEffect1049ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1049ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1049ui_story then
				arg_161_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_164_4 = arg_161_1.actors_["1015ui_story"]
			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1015ui_story == nil then
				arg_161_1.var_.characterEffect1015ui_story = var_164_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_6 and not isNil(var_164_4) then
				local var_164_7 = (arg_161_1.time_ - var_164_5) / var_164_6

				if arg_161_1.var_.characterEffect1015ui_story and not isNil(var_164_4) then
					local var_164_8 = Mathf.Lerp(0, 0.5, var_164_7)

					arg_161_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1015ui_story.fillRatio = var_164_8
				end
			end

			if arg_161_1.time_ >= var_164_5 + var_164_6 and arg_161_1.time_ < var_164_5 + var_164_6 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1015ui_story then
				local var_164_9 = 0.5

				arg_161_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1015ui_story.fillRatio = var_164_9
			end

			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_164_11 = 0
			local var_164_12 = 0.4

			if var_164_11 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_13 = arg_161_1:FormatText(StoryNameCfg[562].name)

				arg_161_1.leftNameTxt_.text = var_164_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_14 = arg_161_1:GetWordFromCfg(318171040)
				local var_164_15 = arg_161_1:FormatText(var_164_14.content)

				arg_161_1.text_.text = var_164_15

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_16 = 16
				local var_164_17 = utf8.len(var_164_15)
				local var_164_18 = var_164_16 <= 0 and var_164_12 or var_164_12 * (var_164_17 / var_164_16)

				if var_164_18 > 0 and var_164_12 < var_164_18 then
					arg_161_1.talkMaxDuration = var_164_18

					if var_164_18 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_18 + var_164_11
					end
				end

				arg_161_1.text_.text = var_164_15
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171040", "story_v_out_318171.awb") ~= 0 then
					local var_164_19 = manager.audio:GetVoiceLength("story_v_out_318171", "318171040", "story_v_out_318171.awb") / 1000

					if var_164_19 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_19 + var_164_11
					end

					if var_164_14.prefab_name ~= "" and arg_161_1.actors_[var_164_14.prefab_name] ~= nil then
						local var_164_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_14.prefab_name].transform, "story_v_out_318171", "318171040", "story_v_out_318171.awb")

						arg_161_1:RecordAudio("318171040", var_164_20)
						arg_161_1:RecordAudio("318171040", var_164_20)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_318171", "318171040", "story_v_out_318171.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_318171", "318171040", "story_v_out_318171.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_21 = math.max(var_164_12, arg_161_1.talkMaxDuration)

			if var_164_11 <= arg_161_1.time_ and arg_161_1.time_ < var_164_11 + var_164_21 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_11) / var_164_21

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_11 + var_164_21 and arg_161_1.time_ < var_164_11 + var_164_21 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play318171041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 318171041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play318171042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1049ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1049ui_story == nil then
				arg_165_1.var_.characterEffect1049ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1049ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1049ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1049ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1049ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 0.7

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(318171041)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 28
				local var_168_11 = utf8.len(var_168_9)
				local var_168_12 = var_168_10 <= 0 and var_168_7 or var_168_7 * (var_168_11 / var_168_10)

				if var_168_12 > 0 and var_168_7 < var_168_12 then
					arg_165_1.talkMaxDuration = var_168_12

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_13 and arg_165_1.time_ < var_168_6 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play318171042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 318171042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play318171043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 1

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(318171042)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 40
				local var_172_5 = utf8.len(var_172_3)
				local var_172_6 = var_172_4 <= 0 and var_172_1 or var_172_1 * (var_172_5 / var_172_4)

				if var_172_6 > 0 and var_172_1 < var_172_6 then
					arg_169_1.talkMaxDuration = var_172_6

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_7 and arg_169_1.time_ < var_172_0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play318171043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 318171043
		arg_173_1.duration_ = 3.1

		local var_173_0 = {
			zh = 3.1,
			ja = 2.066
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play318171044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1015ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1015ui_story == nil then
				arg_173_1.var_.characterEffect1015ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1015ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1015ui_story then
				arg_173_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_176_4 = 0

			if var_176_4 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_6 = 0
			local var_176_7 = 0.4

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_8 = arg_173_1:FormatText(StoryNameCfg[479].name)

				arg_173_1.leftNameTxt_.text = var_176_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_9 = arg_173_1:GetWordFromCfg(318171043)
				local var_176_10 = arg_173_1:FormatText(var_176_9.content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 16
				local var_176_12 = utf8.len(var_176_10)
				local var_176_13 = var_176_11 <= 0 and var_176_7 or var_176_7 * (var_176_12 / var_176_11)

				if var_176_13 > 0 and var_176_7 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171043", "story_v_out_318171.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_318171", "318171043", "story_v_out_318171.awb") / 1000

					if var_176_14 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_6
					end

					if var_176_9.prefab_name ~= "" and arg_173_1.actors_[var_176_9.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_9.prefab_name].transform, "story_v_out_318171", "318171043", "story_v_out_318171.awb")

						arg_173_1:RecordAudio("318171043", var_176_15)
						arg_173_1:RecordAudio("318171043", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_318171", "318171043", "story_v_out_318171.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_318171", "318171043", "story_v_out_318171.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_16 and arg_173_1.time_ < var_176_6 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play318171044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 318171044
		arg_177_1.duration_ = 1

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"

			SetActive(arg_177_1.choicesGo_, true)

			for iter_178_0, iter_178_1 in ipairs(arg_177_1.choices_) do
				local var_178_0 = iter_178_0 <= 2

				SetActive(iter_178_1.go, var_178_0)
			end

			arg_177_1.choices_[1].txt.text = arg_177_1:FormatText(StoryChoiceCfg[676].name)
			arg_177_1.choices_[2].txt.text = arg_177_1:FormatText(StoryChoiceCfg[677].name)
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play318171045(arg_177_1)
			end

			if arg_179_0 == 2 then
				arg_177_0:Play318171046(arg_177_1)
			end

			arg_177_1:RecordChoiceLog(318171044, 676, 677)
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1015ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1015ui_story == nil then
				arg_177_1.var_.characterEffect1015ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1015ui_story and not isNil(var_180_0) then
					local var_180_4 = Mathf.Lerp(0, 0.5, var_180_3)

					arg_177_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1015ui_story.fillRatio = var_180_4
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1015ui_story then
				local var_180_5 = 0.5

				arg_177_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1015ui_story.fillRatio = var_180_5
			end

			local var_180_6 = 0

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			local var_180_7 = 0.5

			if arg_177_1.time_ >= var_180_6 + var_180_7 and arg_177_1.time_ < var_180_6 + var_180_7 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play318171045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 318171045
		arg_181_1.duration_ = 5.87

		local var_181_0 = {
			zh = 5.866,
			ja = 2.033
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play318171047(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_184_1 = arg_181_1.actors_["1015ui_story"]
			local var_184_2 = 0

			if var_184_2 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1015ui_story == nil then
				arg_181_1.var_.characterEffect1015ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_3 = 0.200000002980232

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_3 and not isNil(var_184_1) then
				local var_184_4 = (arg_181_1.time_ - var_184_2) / var_184_3

				if arg_181_1.var_.characterEffect1015ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_2 + var_184_3 and arg_181_1.time_ < var_184_2 + var_184_3 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1015ui_story then
				arg_181_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_184_5 = arg_181_1.actors_["1049ui_story"].transform
			local var_184_6 = 0

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.var_.moveOldPos1049ui_story = var_184_5.localPosition
			end

			local var_184_7 = 0.001

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_7 then
				local var_184_8 = (arg_181_1.time_ - var_184_6) / var_184_7
				local var_184_9 = Vector3.New(0, 100, 0)

				var_184_5.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1049ui_story, var_184_9, var_184_8)

				local var_184_10 = manager.ui.mainCamera.transform.position - var_184_5.position

				var_184_5.forward = Vector3.New(var_184_10.x, var_184_10.y, var_184_10.z)

				local var_184_11 = var_184_5.localEulerAngles

				var_184_11.z = 0
				var_184_11.x = 0
				var_184_5.localEulerAngles = var_184_11
			end

			if arg_181_1.time_ >= var_184_6 + var_184_7 and arg_181_1.time_ < var_184_6 + var_184_7 + arg_184_0 then
				var_184_5.localPosition = Vector3.New(0, 100, 0)

				local var_184_12 = manager.ui.mainCamera.transform.position - var_184_5.position

				var_184_5.forward = Vector3.New(var_184_12.x, var_184_12.y, var_184_12.z)

				local var_184_13 = var_184_5.localEulerAngles

				var_184_13.z = 0
				var_184_13.x = 0
				var_184_5.localEulerAngles = var_184_13
			end

			local var_184_14 = arg_181_1.actors_["1015ui_story"].transform
			local var_184_15 = 0

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 then
				arg_181_1.var_.moveOldPos1015ui_story = var_184_14.localPosition
			end

			local var_184_16 = 0.001

			if var_184_15 <= arg_181_1.time_ and arg_181_1.time_ < var_184_15 + var_184_16 then
				local var_184_17 = (arg_181_1.time_ - var_184_15) / var_184_16
				local var_184_18 = Vector3.New(0, -1.15, -6.2)

				var_184_14.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1015ui_story, var_184_18, var_184_17)

				local var_184_19 = manager.ui.mainCamera.transform.position - var_184_14.position

				var_184_14.forward = Vector3.New(var_184_19.x, var_184_19.y, var_184_19.z)

				local var_184_20 = var_184_14.localEulerAngles

				var_184_20.z = 0
				var_184_20.x = 0
				var_184_14.localEulerAngles = var_184_20
			end

			if arg_181_1.time_ >= var_184_15 + var_184_16 and arg_181_1.time_ < var_184_15 + var_184_16 + arg_184_0 then
				var_184_14.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_184_21 = manager.ui.mainCamera.transform.position - var_184_14.position

				var_184_14.forward = Vector3.New(var_184_21.x, var_184_21.y, var_184_21.z)

				local var_184_22 = var_184_14.localEulerAngles

				var_184_22.z = 0
				var_184_22.x = 0
				var_184_14.localEulerAngles = var_184_22
			end

			local var_184_23 = 0
			local var_184_24 = 0.55

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_25 = arg_181_1:FormatText(StoryNameCfg[479].name)

				arg_181_1.leftNameTxt_.text = var_184_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_26 = arg_181_1:GetWordFromCfg(318171045)
				local var_184_27 = arg_181_1:FormatText(var_184_26.content)

				arg_181_1.text_.text = var_184_27

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_28 = 22
				local var_184_29 = utf8.len(var_184_27)
				local var_184_30 = var_184_28 <= 0 and var_184_24 or var_184_24 * (var_184_29 / var_184_28)

				if var_184_30 > 0 and var_184_24 < var_184_30 then
					arg_181_1.talkMaxDuration = var_184_30

					if var_184_30 + var_184_23 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_30 + var_184_23
					end
				end

				arg_181_1.text_.text = var_184_27
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171045", "story_v_out_318171.awb") ~= 0 then
					local var_184_31 = manager.audio:GetVoiceLength("story_v_out_318171", "318171045", "story_v_out_318171.awb") / 1000

					if var_184_31 + var_184_23 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_31 + var_184_23
					end

					if var_184_26.prefab_name ~= "" and arg_181_1.actors_[var_184_26.prefab_name] ~= nil then
						local var_184_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_26.prefab_name].transform, "story_v_out_318171", "318171045", "story_v_out_318171.awb")

						arg_181_1:RecordAudio("318171045", var_184_32)
						arg_181_1:RecordAudio("318171045", var_184_32)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_318171", "318171045", "story_v_out_318171.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_318171", "318171045", "story_v_out_318171.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_33 = math.max(var_184_24, arg_181_1.talkMaxDuration)

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_33 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_23) / var_184_33

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_23 + var_184_33 and arg_181_1.time_ < var_184_23 + var_184_33 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318171047 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 318171047
		arg_185_1.duration_ = 8.03

		local var_185_0 = {
			zh = 8.033,
			ja = 5.5
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
				arg_185_0:Play318171048(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1015ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1015ui_story == nil then
				arg_185_1.var_.characterEffect1015ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1015ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1015ui_story then
				arg_185_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_188_4 = 0

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_188_5 = 0

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_6 = 0
			local var_188_7 = 1.025

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_8 = arg_185_1:FormatText(StoryNameCfg[479].name)

				arg_185_1.leftNameTxt_.text = var_188_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_9 = arg_185_1:GetWordFromCfg(318171047)
				local var_188_10 = arg_185_1:FormatText(var_188_9.content)

				arg_185_1.text_.text = var_188_10

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171047", "story_v_out_318171.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_318171", "318171047", "story_v_out_318171.awb") / 1000

					if var_188_14 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_6
					end

					if var_188_9.prefab_name ~= "" and arg_185_1.actors_[var_188_9.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_9.prefab_name].transform, "story_v_out_318171", "318171047", "story_v_out_318171.awb")

						arg_185_1:RecordAudio("318171047", var_188_15)
						arg_185_1:RecordAudio("318171047", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_318171", "318171047", "story_v_out_318171.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_318171", "318171047", "story_v_out_318171.awb")
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
	Play318171048 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 318171048
		arg_189_1.duration_ = 9

		local var_189_0 = {
			zh = 9,
			ja = 6
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
				arg_189_0:Play318171049(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 1.075

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[479].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(318171048)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 43
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171048", "story_v_out_318171.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171048", "story_v_out_318171.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_318171", "318171048", "story_v_out_318171.awb")

						arg_189_1:RecordAudio("318171048", var_192_9)
						arg_189_1:RecordAudio("318171048", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_318171", "318171048", "story_v_out_318171.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_318171", "318171048", "story_v_out_318171.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play318171049 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 318171049
		arg_193_1.duration_ = 4.87

		local var_193_0 = {
			zh = 4.4,
			ja = 4.866
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
				arg_193_0:Play318171050(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.45

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[479].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(318171049)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 18
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171049", "story_v_out_318171.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171049", "story_v_out_318171.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_318171", "318171049", "story_v_out_318171.awb")

						arg_193_1:RecordAudio("318171049", var_196_9)
						arg_193_1:RecordAudio("318171049", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_318171", "318171049", "story_v_out_318171.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_318171", "318171049", "story_v_out_318171.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play318171050 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 318171050
		arg_197_1.duration_ = 9

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play318171051(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 2

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				local var_200_1 = manager.ui.mainCamera.transform.localPosition
				local var_200_2 = Vector3.New(0, 0, 10) + Vector3.New(var_200_1.x, var_200_1.y, 0)
				local var_200_3 = arg_197_1.bgs_.K16f

				var_200_3.transform.localPosition = var_200_2
				var_200_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_4 = var_200_3:GetComponent("SpriteRenderer")

				if var_200_4 and var_200_4.sprite then
					local var_200_5 = (var_200_3.transform.localPosition - var_200_1).z
					local var_200_6 = manager.ui.mainCameraCom_
					local var_200_7 = 2 * var_200_5 * Mathf.Tan(var_200_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_200_8 = var_200_7 * var_200_6.aspect
					local var_200_9 = var_200_4.sprite.bounds.size.x
					local var_200_10 = var_200_4.sprite.bounds.size.y
					local var_200_11 = var_200_8 / var_200_9
					local var_200_12 = var_200_7 / var_200_10
					local var_200_13 = var_200_12 < var_200_11 and var_200_11 or var_200_12

					var_200_3.transform.localScale = Vector3.New(var_200_13, var_200_13, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "K16f" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_15 = 2

			if var_200_14 <= arg_197_1.time_ and arg_197_1.time_ < var_200_14 + var_200_15 then
				local var_200_16 = (arg_197_1.time_ - var_200_14) / var_200_15
				local var_200_17 = Color.New(0, 0, 0)

				var_200_17.a = Mathf.Lerp(0, 1, var_200_16)
				arg_197_1.mask_.color = var_200_17
			end

			if arg_197_1.time_ >= var_200_14 + var_200_15 and arg_197_1.time_ < var_200_14 + var_200_15 + arg_200_0 then
				local var_200_18 = Color.New(0, 0, 0)

				var_200_18.a = 1
				arg_197_1.mask_.color = var_200_18
			end

			local var_200_19 = 2

			if var_200_19 < arg_197_1.time_ and arg_197_1.time_ <= var_200_19 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_20 = 2

			if var_200_19 <= arg_197_1.time_ and arg_197_1.time_ < var_200_19 + var_200_20 then
				local var_200_21 = (arg_197_1.time_ - var_200_19) / var_200_20
				local var_200_22 = Color.New(0, 0, 0)

				var_200_22.a = Mathf.Lerp(1, 0, var_200_21)
				arg_197_1.mask_.color = var_200_22
			end

			if arg_197_1.time_ >= var_200_19 + var_200_20 and arg_197_1.time_ < var_200_19 + var_200_20 + arg_200_0 then
				local var_200_23 = Color.New(0, 0, 0)
				local var_200_24 = 0

				arg_197_1.mask_.enabled = false
				var_200_23.a = var_200_24
				arg_197_1.mask_.color = var_200_23
			end

			local var_200_25 = arg_197_1.actors_["1015ui_story"].transform
			local var_200_26 = 2

			if var_200_26 < arg_197_1.time_ and arg_197_1.time_ <= var_200_26 + arg_200_0 then
				arg_197_1.var_.moveOldPos1015ui_story = var_200_25.localPosition
			end

			local var_200_27 = 0.001

			if var_200_26 <= arg_197_1.time_ and arg_197_1.time_ < var_200_26 + var_200_27 then
				local var_200_28 = (arg_197_1.time_ - var_200_26) / var_200_27
				local var_200_29 = Vector3.New(0, 100, 0)

				var_200_25.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1015ui_story, var_200_29, var_200_28)

				local var_200_30 = manager.ui.mainCamera.transform.position - var_200_25.position

				var_200_25.forward = Vector3.New(var_200_30.x, var_200_30.y, var_200_30.z)

				local var_200_31 = var_200_25.localEulerAngles

				var_200_31.z = 0
				var_200_31.x = 0
				var_200_25.localEulerAngles = var_200_31
			end

			if arg_197_1.time_ >= var_200_26 + var_200_27 and arg_197_1.time_ < var_200_26 + var_200_27 + arg_200_0 then
				var_200_25.localPosition = Vector3.New(0, 100, 0)

				local var_200_32 = manager.ui.mainCamera.transform.position - var_200_25.position

				var_200_25.forward = Vector3.New(var_200_32.x, var_200_32.y, var_200_32.z)

				local var_200_33 = var_200_25.localEulerAngles

				var_200_33.z = 0
				var_200_33.x = 0
				var_200_25.localEulerAngles = var_200_33
			end

			local var_200_34 = arg_197_1.actors_["1015ui_story"]
			local var_200_35 = 2

			if var_200_35 < arg_197_1.time_ and arg_197_1.time_ <= var_200_35 + arg_200_0 and not isNil(var_200_34) and arg_197_1.var_.characterEffect1015ui_story == nil then
				arg_197_1.var_.characterEffect1015ui_story = var_200_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_36 = 0.200000002980232

			if var_200_35 <= arg_197_1.time_ and arg_197_1.time_ < var_200_35 + var_200_36 and not isNil(var_200_34) then
				local var_200_37 = (arg_197_1.time_ - var_200_35) / var_200_36

				if arg_197_1.var_.characterEffect1015ui_story and not isNil(var_200_34) then
					local var_200_38 = Mathf.Lerp(0, 0.5, var_200_37)

					arg_197_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1015ui_story.fillRatio = var_200_38
				end
			end

			if arg_197_1.time_ >= var_200_35 + var_200_36 and arg_197_1.time_ < var_200_35 + var_200_36 + arg_200_0 and not isNil(var_200_34) and arg_197_1.var_.characterEffect1015ui_story then
				local var_200_39 = 0.5

				arg_197_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1015ui_story.fillRatio = var_200_39
			end

			local var_200_40 = arg_197_1.actors_["1049ui_story"].transform
			local var_200_41 = 2

			if var_200_41 < arg_197_1.time_ and arg_197_1.time_ <= var_200_41 + arg_200_0 then
				arg_197_1.var_.moveOldPos1049ui_story = var_200_40.localPosition
			end

			local var_200_42 = 0.001

			if var_200_41 <= arg_197_1.time_ and arg_197_1.time_ < var_200_41 + var_200_42 then
				local var_200_43 = (arg_197_1.time_ - var_200_41) / var_200_42
				local var_200_44 = Vector3.New(0, 100, 0)

				var_200_40.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1049ui_story, var_200_44, var_200_43)

				local var_200_45 = manager.ui.mainCamera.transform.position - var_200_40.position

				var_200_40.forward = Vector3.New(var_200_45.x, var_200_45.y, var_200_45.z)

				local var_200_46 = var_200_40.localEulerAngles

				var_200_46.z = 0
				var_200_46.x = 0
				var_200_40.localEulerAngles = var_200_46
			end

			if arg_197_1.time_ >= var_200_41 + var_200_42 and arg_197_1.time_ < var_200_41 + var_200_42 + arg_200_0 then
				var_200_40.localPosition = Vector3.New(0, 100, 0)

				local var_200_47 = manager.ui.mainCamera.transform.position - var_200_40.position

				var_200_40.forward = Vector3.New(var_200_47.x, var_200_47.y, var_200_47.z)

				local var_200_48 = var_200_40.localEulerAngles

				var_200_48.z = 0
				var_200_48.x = 0
				var_200_40.localEulerAngles = var_200_48
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_49 = 4
			local var_200_50 = 1.3

			if var_200_49 < arg_197_1.time_ and arg_197_1.time_ <= var_200_49 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_51 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_51:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_52 = arg_197_1:GetWordFromCfg(318171050)
				local var_200_53 = arg_197_1:FormatText(var_200_52.content)

				arg_197_1.text_.text = var_200_53

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_54 = 52
				local var_200_55 = utf8.len(var_200_53)
				local var_200_56 = var_200_54 <= 0 and var_200_50 or var_200_50 * (var_200_55 / var_200_54)

				if var_200_56 > 0 and var_200_50 < var_200_56 then
					arg_197_1.talkMaxDuration = var_200_56
					var_200_49 = var_200_49 + 0.3

					if var_200_56 + var_200_49 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_56 + var_200_49
					end
				end

				arg_197_1.text_.text = var_200_53
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_57 = var_200_49 + 0.3
			local var_200_58 = math.max(var_200_50, arg_197_1.talkMaxDuration)

			if var_200_57 <= arg_197_1.time_ and arg_197_1.time_ < var_200_57 + var_200_58 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_57) / var_200_58

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_57 + var_200_58 and arg_197_1.time_ < var_200_57 + var_200_58 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play318171051 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 318171051
		arg_203_1.duration_ = 8.27

		local var_203_0 = {
			zh = 5.333,
			ja = 8.266
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
				arg_203_0:Play318171052(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10066ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos10066ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, -0.99, -5.83)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10066ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["10066ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect10066ui_story == nil then
				arg_203_1.var_.characterEffect10066ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect10066ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect10066ui_story then
				arg_203_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_206_15 = 0
			local var_206_16 = 0.6

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[640].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_18 = arg_203_1:GetWordFromCfg(318171051)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171051", "story_v_out_318171.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_out_318171", "318171051", "story_v_out_318171.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_318171", "318171051", "story_v_out_318171.awb")

						arg_203_1:RecordAudio("318171051", var_206_24)
						arg_203_1:RecordAudio("318171051", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_318171", "318171051", "story_v_out_318171.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_318171", "318171051", "story_v_out_318171.awb")
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
				actorName = "10066ui_story",
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
	Play318171052 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 318171052
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play318171053(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10066ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10066ui_story == nil then
				arg_207_1.var_.characterEffect10066ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect10066ui_story and not isNil(var_210_0) then
					local var_210_4 = Mathf.Lerp(0, 0.5, var_210_3)

					arg_207_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10066ui_story.fillRatio = var_210_4
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10066ui_story then
				local var_210_5 = 0.5

				arg_207_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10066ui_story.fillRatio = var_210_5
			end

			local var_210_6 = 0
			local var_210_7 = 0.675

			if var_210_6 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_8 = arg_207_1:FormatText(StoryNameCfg[7].name)

				arg_207_1.leftNameTxt_.text = var_210_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_9 = arg_207_1:GetWordFromCfg(318171052)
				local var_210_10 = arg_207_1:FormatText(var_210_9.content)

				arg_207_1.text_.text = var_210_10

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 27
				local var_210_12 = utf8.len(var_210_10)
				local var_210_13 = var_210_11 <= 0 and var_210_7 or var_210_7 * (var_210_12 / var_210_11)

				if var_210_13 > 0 and var_210_7 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_10
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play318171053 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 318171053
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play318171054(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.95

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[7].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:GetWordFromCfg(318171053)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 38
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_8 and arg_211_1.time_ < var_214_0 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play318171054 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 318171054
		arg_215_1.duration_ = 9.9

		local var_215_0 = {
			zh = 9.9,
			ja = 7.6
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
				arg_215_0:Play318171055(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10066ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect10066ui_story == nil then
				arg_215_1.var_.characterEffect10066ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect10066ui_story and not isNil(var_218_0) then
					arg_215_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect10066ui_story then
				arg_215_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_218_4 = 0

			if var_218_4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_218_5 = 0
			local var_218_6 = 0.725

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_7 = arg_215_1:FormatText(StoryNameCfg[640].name)

				arg_215_1.leftNameTxt_.text = var_218_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_8 = arg_215_1:GetWordFromCfg(318171054)
				local var_218_9 = arg_215_1:FormatText(var_218_8.content)

				arg_215_1.text_.text = var_218_9

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 29
				local var_218_11 = utf8.len(var_218_9)
				local var_218_12 = var_218_10 <= 0 and var_218_6 or var_218_6 * (var_218_11 / var_218_10)

				if var_218_12 > 0 and var_218_6 < var_218_12 then
					arg_215_1.talkMaxDuration = var_218_12

					if var_218_12 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_12 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_9
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171054", "story_v_out_318171.awb") ~= 0 then
					local var_218_13 = manager.audio:GetVoiceLength("story_v_out_318171", "318171054", "story_v_out_318171.awb") / 1000

					if var_218_13 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_5
					end

					if var_218_8.prefab_name ~= "" and arg_215_1.actors_[var_218_8.prefab_name] ~= nil then
						local var_218_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_8.prefab_name].transform, "story_v_out_318171", "318171054", "story_v_out_318171.awb")

						arg_215_1:RecordAudio("318171054", var_218_14)
						arg_215_1:RecordAudio("318171054", var_218_14)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_318171", "318171054", "story_v_out_318171.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_318171", "318171054", "story_v_out_318171.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_15 = math.max(var_218_6, arg_215_1.talkMaxDuration)

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_15 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_5) / var_218_15

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_5 + var_218_15 and arg_215_1.time_ < var_218_5 + var_218_15 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play318171055 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 318171055
		arg_219_1.duration_ = 5.33

		local var_219_0 = {
			zh = 3.933,
			ja = 5.333
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
				arg_219_0:Play318171056(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_222_1 = 0
			local var_222_2 = 0.4

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_3 = arg_219_1:FormatText(StoryNameCfg[640].name)

				arg_219_1.leftNameTxt_.text = var_222_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:GetWordFromCfg(318171055)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_6 = 16
				local var_222_7 = utf8.len(var_222_5)
				local var_222_8 = var_222_6 <= 0 and var_222_2 or var_222_2 * (var_222_7 / var_222_6)

				if var_222_8 > 0 and var_222_2 < var_222_8 then
					arg_219_1.talkMaxDuration = var_222_8

					if var_222_8 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171055", "story_v_out_318171.awb") ~= 0 then
					local var_222_9 = manager.audio:GetVoiceLength("story_v_out_318171", "318171055", "story_v_out_318171.awb") / 1000

					if var_222_9 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_1
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_out_318171", "318171055", "story_v_out_318171.awb")

						arg_219_1:RecordAudio("318171055", var_222_10)
						arg_219_1:RecordAudio("318171055", var_222_10)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_318171", "318171055", "story_v_out_318171.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_318171", "318171055", "story_v_out_318171.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_11 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_11 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_11

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_11 and arg_219_1.time_ < var_222_1 + var_222_11 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play318171056 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 318171056
		arg_223_1.duration_ = 8.23

		local var_223_0 = {
			zh = 7.7,
			ja = 8.233
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play318171057(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1049ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1049ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0.7, -1.2, -6)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1049ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0.7, -1.2, -6)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = arg_223_1.actors_["1049ui_story"]
			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1049ui_story == nil then
				arg_223_1.var_.characterEffect1049ui_story = var_226_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_11 = 0.200000002980232

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_11 and not isNil(var_226_9) then
				local var_226_12 = (arg_223_1.time_ - var_226_10) / var_226_11

				if arg_223_1.var_.characterEffect1049ui_story and not isNil(var_226_9) then
					arg_223_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_10 + var_226_11 and arg_223_1.time_ < var_226_10 + var_226_11 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1049ui_story then
				arg_223_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_226_13 = 0

			if var_226_13 < arg_223_1.time_ and arg_223_1.time_ <= var_226_13 + arg_226_0 then
				arg_223_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_1")
			end

			local var_226_14 = 0

			if var_226_14 < arg_223_1.time_ and arg_223_1.time_ <= var_226_14 + arg_226_0 then
				arg_223_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_15 = arg_223_1.actors_["10066ui_story"].transform
			local var_226_16 = 0

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.var_.moveOldPos10066ui_story = var_226_15.localPosition
			end

			local var_226_17 = 0.001

			if var_226_16 <= arg_223_1.time_ and arg_223_1.time_ < var_226_16 + var_226_17 then
				local var_226_18 = (arg_223_1.time_ - var_226_16) / var_226_17
				local var_226_19 = Vector3.New(-0.7, -0.99, -5.83)

				var_226_15.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10066ui_story, var_226_19, var_226_18)

				local var_226_20 = manager.ui.mainCamera.transform.position - var_226_15.position

				var_226_15.forward = Vector3.New(var_226_20.x, var_226_20.y, var_226_20.z)

				local var_226_21 = var_226_15.localEulerAngles

				var_226_21.z = 0
				var_226_21.x = 0
				var_226_15.localEulerAngles = var_226_21
			end

			if arg_223_1.time_ >= var_226_16 + var_226_17 and arg_223_1.time_ < var_226_16 + var_226_17 + arg_226_0 then
				var_226_15.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_226_22 = manager.ui.mainCamera.transform.position - var_226_15.position

				var_226_15.forward = Vector3.New(var_226_22.x, var_226_22.y, var_226_22.z)

				local var_226_23 = var_226_15.localEulerAngles

				var_226_23.z = 0
				var_226_23.x = 0
				var_226_15.localEulerAngles = var_226_23
			end

			local var_226_24 = arg_223_1.actors_["10066ui_story"]
			local var_226_25 = 0

			if var_226_25 < arg_223_1.time_ and arg_223_1.time_ <= var_226_25 + arg_226_0 and not isNil(var_226_24) and arg_223_1.var_.characterEffect10066ui_story == nil then
				arg_223_1.var_.characterEffect10066ui_story = var_226_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_26 = 0.200000002980232

			if var_226_25 <= arg_223_1.time_ and arg_223_1.time_ < var_226_25 + var_226_26 and not isNil(var_226_24) then
				local var_226_27 = (arg_223_1.time_ - var_226_25) / var_226_26

				if arg_223_1.var_.characterEffect10066ui_story and not isNil(var_226_24) then
					local var_226_28 = Mathf.Lerp(0, 0.5, var_226_27)

					arg_223_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_223_1.var_.characterEffect10066ui_story.fillRatio = var_226_28
				end
			end

			if arg_223_1.time_ >= var_226_25 + var_226_26 and arg_223_1.time_ < var_226_25 + var_226_26 + arg_226_0 and not isNil(var_226_24) and arg_223_1.var_.characterEffect10066ui_story then
				local var_226_29 = 0.5

				arg_223_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_223_1.var_.characterEffect10066ui_story.fillRatio = var_226_29
			end

			local var_226_30 = 0
			local var_226_31 = 0.95

			if var_226_30 < arg_223_1.time_ and arg_223_1.time_ <= var_226_30 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_32 = arg_223_1:FormatText(StoryNameCfg[562].name)

				arg_223_1.leftNameTxt_.text = var_226_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_33 = arg_223_1:GetWordFromCfg(318171056)
				local var_226_34 = arg_223_1:FormatText(var_226_33.content)

				arg_223_1.text_.text = var_226_34

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_35 = 38
				local var_226_36 = utf8.len(var_226_34)
				local var_226_37 = var_226_35 <= 0 and var_226_31 or var_226_31 * (var_226_36 / var_226_35)

				if var_226_37 > 0 and var_226_31 < var_226_37 then
					arg_223_1.talkMaxDuration = var_226_37

					if var_226_37 + var_226_30 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_37 + var_226_30
					end
				end

				arg_223_1.text_.text = var_226_34
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171056", "story_v_out_318171.awb") ~= 0 then
					local var_226_38 = manager.audio:GetVoiceLength("story_v_out_318171", "318171056", "story_v_out_318171.awb") / 1000

					if var_226_38 + var_226_30 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_38 + var_226_30
					end

					if var_226_33.prefab_name ~= "" and arg_223_1.actors_[var_226_33.prefab_name] ~= nil then
						local var_226_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_33.prefab_name].transform, "story_v_out_318171", "318171056", "story_v_out_318171.awb")

						arg_223_1:RecordAudio("318171056", var_226_39)
						arg_223_1:RecordAudio("318171056", var_226_39)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_318171", "318171056", "story_v_out_318171.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_318171", "318171056", "story_v_out_318171.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_40 = math.max(var_226_31, arg_223_1.talkMaxDuration)

			if var_226_30 <= arg_223_1.time_ and arg_223_1.time_ < var_226_30 + var_226_40 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_30) / var_226_40

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_30 + var_226_40 and arg_223_1.time_ < var_226_30 + var_226_40 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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

		arg_223_1:InitPlayNodeList()
	end,
	Play318171057 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 318171057
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play318171058(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1049ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1049ui_story == nil then
				arg_227_1.var_.characterEffect1049ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1049ui_story and not isNil(var_230_0) then
					local var_230_4 = Mathf.Lerp(0, 0.5, var_230_3)

					arg_227_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1049ui_story.fillRatio = var_230_4
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1049ui_story then
				local var_230_5 = 0.5

				arg_227_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1049ui_story.fillRatio = var_230_5
			end

			local var_230_6 = 0
			local var_230_7 = 1.25

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_8 = arg_227_1:FormatText(StoryNameCfg[7].name)

				arg_227_1.leftNameTxt_.text = var_230_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_9 = arg_227_1:GetWordFromCfg(318171057)
				local var_230_10 = arg_227_1:FormatText(var_230_9.content)

				arg_227_1.text_.text = var_230_10

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 50
				local var_230_12 = utf8.len(var_230_10)
				local var_230_13 = var_230_11 <= 0 and var_230_7 or var_230_7 * (var_230_12 / var_230_11)

				if var_230_13 > 0 and var_230_7 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_10
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_14 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_14 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_14

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_14 and arg_227_1.time_ < var_230_6 + var_230_14 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play318171058 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 318171058
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play318171059(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.775

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[7].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(318171058)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 31
				local var_234_6 = utf8.len(var_234_4)
				local var_234_7 = var_234_5 <= 0 and var_234_1 or var_234_1 * (var_234_6 / var_234_5)

				if var_234_7 > 0 and var_234_1 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_8 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_8 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_8

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_8 and arg_231_1.time_ < var_234_0 + var_234_8 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play318171059 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 318171059
		arg_235_1.duration_ = 6.23

		local var_235_0 = {
			zh = 2.366,
			ja = 6.233
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play318171060(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10066ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect10066ui_story == nil then
				arg_235_1.var_.characterEffect10066ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect10066ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect10066ui_story then
				arg_235_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_238_4 = 0
			local var_238_5 = 0.225

			if var_238_4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_6 = arg_235_1:FormatText(StoryNameCfg[640].name)

				arg_235_1.leftNameTxt_.text = var_238_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_7 = arg_235_1:GetWordFromCfg(318171059)
				local var_238_8 = arg_235_1:FormatText(var_238_7.content)

				arg_235_1.text_.text = var_238_8

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 9
				local var_238_10 = utf8.len(var_238_8)
				local var_238_11 = var_238_9 <= 0 and var_238_5 or var_238_5 * (var_238_10 / var_238_9)

				if var_238_11 > 0 and var_238_5 < var_238_11 then
					arg_235_1.talkMaxDuration = var_238_11

					if var_238_11 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_8
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171059", "story_v_out_318171.awb") ~= 0 then
					local var_238_12 = manager.audio:GetVoiceLength("story_v_out_318171", "318171059", "story_v_out_318171.awb") / 1000

					if var_238_12 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_12 + var_238_4
					end

					if var_238_7.prefab_name ~= "" and arg_235_1.actors_[var_238_7.prefab_name] ~= nil then
						local var_238_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_7.prefab_name].transform, "story_v_out_318171", "318171059", "story_v_out_318171.awb")

						arg_235_1:RecordAudio("318171059", var_238_13)
						arg_235_1:RecordAudio("318171059", var_238_13)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_318171", "318171059", "story_v_out_318171.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_318171", "318171059", "story_v_out_318171.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_14 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_14 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_14

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_14 and arg_235_1.time_ < var_238_4 + var_238_14 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play318171060 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 318171060
		arg_239_1.duration_ = 7.83

		local var_239_0 = {
			zh = 5.966,
			ja = 7.833
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
				arg_239_0:Play318171061(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1015ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1015ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, -1.15, -6.2)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1015ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1015ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1015ui_story == nil then
				arg_239_1.var_.characterEffect1015ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect1015ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1015ui_story then
				arg_239_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_242_13 = 0

			if var_242_13 < arg_239_1.time_ and arg_239_1.time_ <= var_242_13 + arg_242_0 then
				arg_239_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_242_14 = 0

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_15 = arg_239_1.actors_["10066ui_story"].transform
			local var_242_16 = 0

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 then
				arg_239_1.var_.moveOldPos10066ui_story = var_242_15.localPosition
			end

			local var_242_17 = 0.001

			if var_242_16 <= arg_239_1.time_ and arg_239_1.time_ < var_242_16 + var_242_17 then
				local var_242_18 = (arg_239_1.time_ - var_242_16) / var_242_17
				local var_242_19 = Vector3.New(0, 100, 0)

				var_242_15.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10066ui_story, var_242_19, var_242_18)

				local var_242_20 = manager.ui.mainCamera.transform.position - var_242_15.position

				var_242_15.forward = Vector3.New(var_242_20.x, var_242_20.y, var_242_20.z)

				local var_242_21 = var_242_15.localEulerAngles

				var_242_21.z = 0
				var_242_21.x = 0
				var_242_15.localEulerAngles = var_242_21
			end

			if arg_239_1.time_ >= var_242_16 + var_242_17 and arg_239_1.time_ < var_242_16 + var_242_17 + arg_242_0 then
				var_242_15.localPosition = Vector3.New(0, 100, 0)

				local var_242_22 = manager.ui.mainCamera.transform.position - var_242_15.position

				var_242_15.forward = Vector3.New(var_242_22.x, var_242_22.y, var_242_22.z)

				local var_242_23 = var_242_15.localEulerAngles

				var_242_23.z = 0
				var_242_23.x = 0
				var_242_15.localEulerAngles = var_242_23
			end

			local var_242_24 = arg_239_1.actors_["10066ui_story"]
			local var_242_25 = 0

			if var_242_25 < arg_239_1.time_ and arg_239_1.time_ <= var_242_25 + arg_242_0 and not isNil(var_242_24) and arg_239_1.var_.characterEffect10066ui_story == nil then
				arg_239_1.var_.characterEffect10066ui_story = var_242_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_26 = 0.200000002980232

			if var_242_25 <= arg_239_1.time_ and arg_239_1.time_ < var_242_25 + var_242_26 and not isNil(var_242_24) then
				local var_242_27 = (arg_239_1.time_ - var_242_25) / var_242_26

				if arg_239_1.var_.characterEffect10066ui_story and not isNil(var_242_24) then
					local var_242_28 = Mathf.Lerp(0, 0.5, var_242_27)

					arg_239_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10066ui_story.fillRatio = var_242_28
				end
			end

			if arg_239_1.time_ >= var_242_25 + var_242_26 and arg_239_1.time_ < var_242_25 + var_242_26 + arg_242_0 and not isNil(var_242_24) and arg_239_1.var_.characterEffect10066ui_story then
				local var_242_29 = 0.5

				arg_239_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10066ui_story.fillRatio = var_242_29
			end

			local var_242_30 = arg_239_1.actors_["1049ui_story"].transform
			local var_242_31 = 0

			if var_242_31 < arg_239_1.time_ and arg_239_1.time_ <= var_242_31 + arg_242_0 then
				arg_239_1.var_.moveOldPos1049ui_story = var_242_30.localPosition
			end

			local var_242_32 = 0.001

			if var_242_31 <= arg_239_1.time_ and arg_239_1.time_ < var_242_31 + var_242_32 then
				local var_242_33 = (arg_239_1.time_ - var_242_31) / var_242_32
				local var_242_34 = Vector3.New(0, 100, 0)

				var_242_30.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1049ui_story, var_242_34, var_242_33)

				local var_242_35 = manager.ui.mainCamera.transform.position - var_242_30.position

				var_242_30.forward = Vector3.New(var_242_35.x, var_242_35.y, var_242_35.z)

				local var_242_36 = var_242_30.localEulerAngles

				var_242_36.z = 0
				var_242_36.x = 0
				var_242_30.localEulerAngles = var_242_36
			end

			if arg_239_1.time_ >= var_242_31 + var_242_32 and arg_239_1.time_ < var_242_31 + var_242_32 + arg_242_0 then
				var_242_30.localPosition = Vector3.New(0, 100, 0)

				local var_242_37 = manager.ui.mainCamera.transform.position - var_242_30.position

				var_242_30.forward = Vector3.New(var_242_37.x, var_242_37.y, var_242_37.z)

				local var_242_38 = var_242_30.localEulerAngles

				var_242_38.z = 0
				var_242_38.x = 0
				var_242_30.localEulerAngles = var_242_38
			end

			local var_242_39 = 0
			local var_242_40 = 0.725

			if var_242_39 < arg_239_1.time_ and arg_239_1.time_ <= var_242_39 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_41 = arg_239_1:FormatText(StoryNameCfg[479].name)

				arg_239_1.leftNameTxt_.text = var_242_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_42 = arg_239_1:GetWordFromCfg(318171060)
				local var_242_43 = arg_239_1:FormatText(var_242_42.content)

				arg_239_1.text_.text = var_242_43

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_44 = 29
				local var_242_45 = utf8.len(var_242_43)
				local var_242_46 = var_242_44 <= 0 and var_242_40 or var_242_40 * (var_242_45 / var_242_44)

				if var_242_46 > 0 and var_242_40 < var_242_46 then
					arg_239_1.talkMaxDuration = var_242_46

					if var_242_46 + var_242_39 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_46 + var_242_39
					end
				end

				arg_239_1.text_.text = var_242_43
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171060", "story_v_out_318171.awb") ~= 0 then
					local var_242_47 = manager.audio:GetVoiceLength("story_v_out_318171", "318171060", "story_v_out_318171.awb") / 1000

					if var_242_47 + var_242_39 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_47 + var_242_39
					end

					if var_242_42.prefab_name ~= "" and arg_239_1.actors_[var_242_42.prefab_name] ~= nil then
						local var_242_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_42.prefab_name].transform, "story_v_out_318171", "318171060", "story_v_out_318171.awb")

						arg_239_1:RecordAudio("318171060", var_242_48)
						arg_239_1:RecordAudio("318171060", var_242_48)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_318171", "318171060", "story_v_out_318171.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_318171", "318171060", "story_v_out_318171.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_49 = math.max(var_242_40, arg_239_1.talkMaxDuration)

			if var_242_39 <= arg_239_1.time_ and arg_239_1.time_ < var_242_39 + var_242_49 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_39) / var_242_49

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_39 + var_242_49 and arg_239_1.time_ < var_242_39 + var_242_49 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_239_1:InitPlayNodeList()
	end,
	Play318171061 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 318171061
		arg_243_1.duration_ = 11.33

		local var_243_0 = {
			zh = 11.333,
			ja = 7.2
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play318171062(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 1.4

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[479].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_3 = arg_243_1:GetWordFromCfg(318171061)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 56
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171061", "story_v_out_318171.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171061", "story_v_out_318171.awb") / 1000

					if var_246_8 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_0
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_318171", "318171061", "story_v_out_318171.awb")

						arg_243_1:RecordAudio("318171061", var_246_9)
						arg_243_1:RecordAudio("318171061", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_318171", "318171061", "story_v_out_318171.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_318171", "318171061", "story_v_out_318171.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_10 and arg_243_1.time_ < var_246_0 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play318171062 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 318171062
		arg_247_1.duration_ = 12.73

		local var_247_0 = {
			zh = 9.8,
			ja = 12.733
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
				arg_247_0:Play318171063(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_2 = 0
			local var_250_3 = 1.15

			if var_250_2 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_4 = arg_247_1:FormatText(StoryNameCfg[479].name)

				arg_247_1.leftNameTxt_.text = var_250_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_5 = arg_247_1:GetWordFromCfg(318171062)
				local var_250_6 = arg_247_1:FormatText(var_250_5.content)

				arg_247_1.text_.text = var_250_6

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 46
				local var_250_8 = utf8.len(var_250_6)
				local var_250_9 = var_250_7 <= 0 and var_250_3 or var_250_3 * (var_250_8 / var_250_7)

				if var_250_9 > 0 and var_250_3 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_6
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171062", "story_v_out_318171.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_out_318171", "318171062", "story_v_out_318171.awb") / 1000

					if var_250_10 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_2
					end

					if var_250_5.prefab_name ~= "" and arg_247_1.actors_[var_250_5.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_5.prefab_name].transform, "story_v_out_318171", "318171062", "story_v_out_318171.awb")

						arg_247_1:RecordAudio("318171062", var_250_11)
						arg_247_1:RecordAudio("318171062", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_318171", "318171062", "story_v_out_318171.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_318171", "318171062", "story_v_out_318171.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_12 and arg_247_1.time_ < var_250_2 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play318171063 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 318171063
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play318171064(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1015ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1015ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(0, 100, 0)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1015ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, 100, 0)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["1015ui_story"]
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1015ui_story == nil then
				arg_251_1.var_.characterEffect1015ui_story = var_254_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_11 = 0.200000002980232

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 and not isNil(var_254_9) then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11

				if arg_251_1.var_.characterEffect1015ui_story and not isNil(var_254_9) then
					local var_254_13 = Mathf.Lerp(0, 0.5, var_254_12)

					arg_251_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1015ui_story.fillRatio = var_254_13
				end
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1015ui_story then
				local var_254_14 = 0.5

				arg_251_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1015ui_story.fillRatio = var_254_14
			end

			local var_254_15 = 0
			local var_254_16 = 0.675

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_17 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_18 = arg_251_1:GetWordFromCfg(318171063)
				local var_254_19 = arg_251_1:FormatText(var_254_18.content)

				arg_251_1.text_.text = var_254_19

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_20 = 27
				local var_254_21 = utf8.len(var_254_19)
				local var_254_22 = var_254_20 <= 0 and var_254_16 or var_254_16 * (var_254_21 / var_254_20)

				if var_254_22 > 0 and var_254_16 < var_254_22 then
					arg_251_1.talkMaxDuration = var_254_22

					if var_254_22 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_22 + var_254_15
					end
				end

				arg_251_1.text_.text = var_254_19
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_23 = math.max(var_254_16, arg_251_1.talkMaxDuration)

			if var_254_15 <= arg_251_1.time_ and arg_251_1.time_ < var_254_15 + var_254_23 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_15) / var_254_23

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_15 + var_254_23 and arg_251_1.time_ < var_254_15 + var_254_23 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318171064 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 318171064
		arg_255_1.duration_ = 2.6

		local var_255_0 = {
			zh = 1.666,
			ja = 2.6
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play318171065(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.15

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[646].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:GetWordFromCfg(318171064)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 6
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171064", "story_v_out_318171.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171064", "story_v_out_318171.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_318171", "318171064", "story_v_out_318171.awb")

						arg_255_1:RecordAudio("318171064", var_258_9)
						arg_255_1:RecordAudio("318171064", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_318171", "318171064", "story_v_out_318171.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_318171", "318171064", "story_v_out_318171.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play318171065 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 318171065
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play318171066(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.6

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_2 = arg_259_1:GetWordFromCfg(318171065)
				local var_262_3 = arg_259_1:FormatText(var_262_2.content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 24
				local var_262_5 = utf8.len(var_262_3)
				local var_262_6 = var_262_4 <= 0 and var_262_1 or var_262_1 * (var_262_5 / var_262_4)

				if var_262_6 > 0 and var_262_1 < var_262_6 then
					arg_259_1.talkMaxDuration = var_262_6

					if var_262_6 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_6 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_7 and arg_259_1.time_ < var_262_0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play318171066 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 318171066
		arg_263_1.duration_ = 3.4

		local var_263_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play318171067(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10066ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos10066ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, -0.99, -5.83)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10066ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["10066ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect10066ui_story == nil then
				arg_263_1.var_.characterEffect10066ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect10066ui_story and not isNil(var_266_9) then
					arg_263_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect10066ui_story then
				arg_263_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_266_13 = 0

			if var_266_13 < arg_263_1.time_ and arg_263_1.time_ <= var_266_13 + arg_266_0 then
				arg_263_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			local var_266_14 = 0

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_266_15 = 0
			local var_266_16 = 0.15

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[640].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(318171066)
				local var_266_19 = arg_263_1:FormatText(var_266_18.content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 6
				local var_266_21 = utf8.len(var_266_19)
				local var_266_22 = var_266_20 <= 0 and var_266_16 or var_266_16 * (var_266_21 / var_266_20)

				if var_266_22 > 0 and var_266_16 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22

					if var_266_22 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171066", "story_v_out_318171.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_out_318171", "318171066", "story_v_out_318171.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_out_318171", "318171066", "story_v_out_318171.awb")

						arg_263_1:RecordAudio("318171066", var_266_24)
						arg_263_1:RecordAudio("318171066", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_318171", "318171066", "story_v_out_318171.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_318171", "318171066", "story_v_out_318171.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_25 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_25 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_25

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_25 and arg_263_1.time_ < var_266_15 + var_266_25 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play318171067 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 318171067
		arg_267_1.duration_ = 8.03

		local var_267_0 = {
			zh = 3.466,
			ja = 8.033
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play318171068(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10066ui_story"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect10066ui_story == nil then
				arg_267_1.var_.characterEffect10066ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.characterEffect10066ui_story and not isNil(var_270_0) then
					local var_270_4 = Mathf.Lerp(0, 0.5, var_270_3)

					arg_267_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_267_1.var_.characterEffect10066ui_story.fillRatio = var_270_4
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect10066ui_story then
				local var_270_5 = 0.5

				arg_267_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_267_1.var_.characterEffect10066ui_story.fillRatio = var_270_5
			end

			local var_270_6 = 0
			local var_270_7 = 0.55

			if var_270_6 < arg_267_1.time_ and arg_267_1.time_ <= var_270_6 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_8 = arg_267_1:FormatText(StoryNameCfg[646].name)

				arg_267_1.leftNameTxt_.text = var_270_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_9 = arg_267_1:GetWordFromCfg(318171067)
				local var_270_10 = arg_267_1:FormatText(var_270_9.content)

				arg_267_1.text_.text = var_270_10

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_11 = 22
				local var_270_12 = utf8.len(var_270_10)
				local var_270_13 = var_270_11 <= 0 and var_270_7 or var_270_7 * (var_270_12 / var_270_11)

				if var_270_13 > 0 and var_270_7 < var_270_13 then
					arg_267_1.talkMaxDuration = var_270_13

					if var_270_13 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_13 + var_270_6
					end
				end

				arg_267_1.text_.text = var_270_10
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171067", "story_v_out_318171.awb") ~= 0 then
					local var_270_14 = manager.audio:GetVoiceLength("story_v_out_318171", "318171067", "story_v_out_318171.awb") / 1000

					if var_270_14 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_14 + var_270_6
					end

					if var_270_9.prefab_name ~= "" and arg_267_1.actors_[var_270_9.prefab_name] ~= nil then
						local var_270_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_9.prefab_name].transform, "story_v_out_318171", "318171067", "story_v_out_318171.awb")

						arg_267_1:RecordAudio("318171067", var_270_15)
						arg_267_1:RecordAudio("318171067", var_270_15)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_318171", "318171067", "story_v_out_318171.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_318171", "318171067", "story_v_out_318171.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_16 = math.max(var_270_7, arg_267_1.talkMaxDuration)

			if var_270_6 <= arg_267_1.time_ and arg_267_1.time_ < var_270_6 + var_270_16 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_6) / var_270_16

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_6 + var_270_16 and arg_267_1.time_ < var_270_6 + var_270_16 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play318171068 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 318171068
		arg_271_1.duration_ = 2.93

		local var_271_0 = {
			zh = 2.933,
			ja = 2.833
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play318171069(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10066ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect10066ui_story == nil then
				arg_271_1.var_.characterEffect10066ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect10066ui_story and not isNil(var_274_0) then
					arg_271_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect10066ui_story then
				arg_271_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_274_4 = 0

			if var_274_4 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			local var_274_5 = 0

			if var_274_5 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_6 = 0
			local var_274_7 = 0.325

			if var_274_6 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_8 = arg_271_1:FormatText(StoryNameCfg[640].name)

				arg_271_1.leftNameTxt_.text = var_274_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_9 = arg_271_1:GetWordFromCfg(318171068)
				local var_274_10 = arg_271_1:FormatText(var_274_9.content)

				arg_271_1.text_.text = var_274_10

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_11 = 13
				local var_274_12 = utf8.len(var_274_10)
				local var_274_13 = var_274_11 <= 0 and var_274_7 or var_274_7 * (var_274_12 / var_274_11)

				if var_274_13 > 0 and var_274_7 < var_274_13 then
					arg_271_1.talkMaxDuration = var_274_13

					if var_274_13 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_10
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171068", "story_v_out_318171.awb") ~= 0 then
					local var_274_14 = manager.audio:GetVoiceLength("story_v_out_318171", "318171068", "story_v_out_318171.awb") / 1000

					if var_274_14 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_14 + var_274_6
					end

					if var_274_9.prefab_name ~= "" and arg_271_1.actors_[var_274_9.prefab_name] ~= nil then
						local var_274_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_9.prefab_name].transform, "story_v_out_318171", "318171068", "story_v_out_318171.awb")

						arg_271_1:RecordAudio("318171068", var_274_15)
						arg_271_1:RecordAudio("318171068", var_274_15)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_318171", "318171068", "story_v_out_318171.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_318171", "318171068", "story_v_out_318171.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_16 and arg_271_1.time_ < var_274_6 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play318171069 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 318171069
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play318171070(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10066ui_story"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos10066ui_story = var_278_0.localPosition
			end

			local var_278_2 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2
				local var_278_4 = Vector3.New(0, 100, 0)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10066ui_story, var_278_4, var_278_3)

				local var_278_5 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_5.x, var_278_5.y, var_278_5.z)

				local var_278_6 = var_278_0.localEulerAngles

				var_278_6.z = 0
				var_278_6.x = 0
				var_278_0.localEulerAngles = var_278_6
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(0, 100, 0)

				local var_278_7 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_7.x, var_278_7.y, var_278_7.z)

				local var_278_8 = var_278_0.localEulerAngles

				var_278_8.z = 0
				var_278_8.x = 0
				var_278_0.localEulerAngles = var_278_8
			end

			local var_278_9 = arg_275_1.actors_["10066ui_story"]
			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect10066ui_story == nil then
				arg_275_1.var_.characterEffect10066ui_story = var_278_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_11 = 0.200000002980232

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_11 and not isNil(var_278_9) then
				local var_278_12 = (arg_275_1.time_ - var_278_10) / var_278_11

				if arg_275_1.var_.characterEffect10066ui_story and not isNil(var_278_9) then
					local var_278_13 = Mathf.Lerp(0, 0.5, var_278_12)

					arg_275_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_275_1.var_.characterEffect10066ui_story.fillRatio = var_278_13
				end
			end

			if arg_275_1.time_ >= var_278_10 + var_278_11 and arg_275_1.time_ < var_278_10 + var_278_11 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect10066ui_story then
				local var_278_14 = 0.5

				arg_275_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_275_1.var_.characterEffect10066ui_story.fillRatio = var_278_14
			end

			local var_278_15 = 0
			local var_278_16 = 0.5

			if var_278_15 < arg_275_1.time_ and arg_275_1.time_ <= var_278_15 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_17 = arg_275_1:GetWordFromCfg(318171069)
				local var_278_18 = arg_275_1:FormatText(var_278_17.content)

				arg_275_1.text_.text = var_278_18

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_19 = 20
				local var_278_20 = utf8.len(var_278_18)
				local var_278_21 = var_278_19 <= 0 and var_278_16 or var_278_16 * (var_278_20 / var_278_19)

				if var_278_21 > 0 and var_278_16 < var_278_21 then
					arg_275_1.talkMaxDuration = var_278_21

					if var_278_21 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_21 + var_278_15
					end
				end

				arg_275_1.text_.text = var_278_18
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_22 = math.max(var_278_16, arg_275_1.talkMaxDuration)

			if var_278_15 <= arg_275_1.time_ and arg_275_1.time_ < var_278_15 + var_278_22 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_15) / var_278_22

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_15 + var_278_22 and arg_275_1.time_ < var_278_15 + var_278_22 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play318171070 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 318171070
		arg_279_1.duration_ = 12.23

		local var_279_0 = {
			zh = 7.133,
			ja = 12.233
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play318171071(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1015ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1015ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, -1.15, -6.2)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1015ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["1015ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1015ui_story == nil then
				arg_279_1.var_.characterEffect1015ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.200000002980232

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect1015ui_story and not isNil(var_282_9) then
					arg_279_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1015ui_story then
				arg_279_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_282_13 = 0

			if var_282_13 < arg_279_1.time_ and arg_279_1.time_ <= var_282_13 + arg_282_0 then
				arg_279_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_282_14 = 0

			if var_282_14 < arg_279_1.time_ and arg_279_1.time_ <= var_282_14 + arg_282_0 then
				arg_279_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_282_15 = 0
			local var_282_16 = 0.825

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_17 = arg_279_1:FormatText(StoryNameCfg[479].name)

				arg_279_1.leftNameTxt_.text = var_282_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_18 = arg_279_1:GetWordFromCfg(318171070)
				local var_282_19 = arg_279_1:FormatText(var_282_18.content)

				arg_279_1.text_.text = var_282_19

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_20 = 33
				local var_282_21 = utf8.len(var_282_19)
				local var_282_22 = var_282_20 <= 0 and var_282_16 or var_282_16 * (var_282_21 / var_282_20)

				if var_282_22 > 0 and var_282_16 < var_282_22 then
					arg_279_1.talkMaxDuration = var_282_22

					if var_282_22 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_22 + var_282_15
					end
				end

				arg_279_1.text_.text = var_282_19
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171070", "story_v_out_318171.awb") ~= 0 then
					local var_282_23 = manager.audio:GetVoiceLength("story_v_out_318171", "318171070", "story_v_out_318171.awb") / 1000

					if var_282_23 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_15
					end

					if var_282_18.prefab_name ~= "" and arg_279_1.actors_[var_282_18.prefab_name] ~= nil then
						local var_282_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_18.prefab_name].transform, "story_v_out_318171", "318171070", "story_v_out_318171.awb")

						arg_279_1:RecordAudio("318171070", var_282_24)
						arg_279_1:RecordAudio("318171070", var_282_24)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_318171", "318171070", "story_v_out_318171.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_318171", "318171070", "story_v_out_318171.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_25 = math.max(var_282_16, arg_279_1.talkMaxDuration)

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_25 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_15) / var_282_25

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_15 + var_282_25 and arg_279_1.time_ < var_282_15 + var_282_25 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play318171071 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 318171071
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play318171072(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1015ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos1015ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(0, 100, 0)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1015ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0, 100, 0)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = arg_283_1.actors_["1015ui_story"]
			local var_286_10 = 0

			if var_286_10 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect1015ui_story == nil then
				arg_283_1.var_.characterEffect1015ui_story = var_286_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_11 = 0.200000002980232

			if var_286_10 <= arg_283_1.time_ and arg_283_1.time_ < var_286_10 + var_286_11 and not isNil(var_286_9) then
				local var_286_12 = (arg_283_1.time_ - var_286_10) / var_286_11

				if arg_283_1.var_.characterEffect1015ui_story and not isNil(var_286_9) then
					local var_286_13 = Mathf.Lerp(0, 0.5, var_286_12)

					arg_283_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1015ui_story.fillRatio = var_286_13
				end
			end

			if arg_283_1.time_ >= var_286_10 + var_286_11 and arg_283_1.time_ < var_286_10 + var_286_11 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect1015ui_story then
				local var_286_14 = 0.5

				arg_283_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1015ui_story.fillRatio = var_286_14
			end

			local var_286_15 = 0
			local var_286_16 = 1.35

			if var_286_15 < arg_283_1.time_ and arg_283_1.time_ <= var_286_15 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_17 = arg_283_1:GetWordFromCfg(318171071)
				local var_286_18 = arg_283_1:FormatText(var_286_17.content)

				arg_283_1.text_.text = var_286_18

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_19 = 54
				local var_286_20 = utf8.len(var_286_18)
				local var_286_21 = var_286_19 <= 0 and var_286_16 or var_286_16 * (var_286_20 / var_286_19)

				if var_286_21 > 0 and var_286_16 < var_286_21 then
					arg_283_1.talkMaxDuration = var_286_21

					if var_286_21 + var_286_15 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_21 + var_286_15
					end
				end

				arg_283_1.text_.text = var_286_18
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_22 = math.max(var_286_16, arg_283_1.talkMaxDuration)

			if var_286_15 <= arg_283_1.time_ and arg_283_1.time_ < var_286_15 + var_286_22 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_15) / var_286_22

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_15 + var_286_22 and arg_283_1.time_ < var_286_15 + var_286_22 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play318171072 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 318171072
		arg_287_1.duration_ = 9

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play318171073(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = "LX0101a"

			if arg_287_1.bgs_[var_290_0] == nil then
				local var_290_1 = Object.Instantiate(arg_287_1.paintGo_)

				var_290_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_290_0)
				var_290_1.name = var_290_0
				var_290_1.transform.parent = arg_287_1.stage_.transform
				var_290_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_287_1.bgs_[var_290_0] = var_290_1
			end

			local var_290_2 = 2

			if var_290_2 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				local var_290_3 = manager.ui.mainCamera.transform.localPosition
				local var_290_4 = Vector3.New(0, 0, 10) + Vector3.New(var_290_3.x, var_290_3.y, 0)
				local var_290_5 = arg_287_1.bgs_.LX0101a

				var_290_5.transform.localPosition = var_290_4
				var_290_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_290_6 = var_290_5:GetComponent("SpriteRenderer")

				if var_290_6 and var_290_6.sprite then
					local var_290_7 = (var_290_5.transform.localPosition - var_290_3).z
					local var_290_8 = manager.ui.mainCameraCom_
					local var_290_9 = 2 * var_290_7 * Mathf.Tan(var_290_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_290_10 = var_290_9 * var_290_8.aspect
					local var_290_11 = var_290_6.sprite.bounds.size.x
					local var_290_12 = var_290_6.sprite.bounds.size.y
					local var_290_13 = var_290_10 / var_290_11
					local var_290_14 = var_290_9 / var_290_12
					local var_290_15 = var_290_14 < var_290_13 and var_290_13 or var_290_14

					var_290_5.transform.localScale = Vector3.New(var_290_15, var_290_15, 0)
				end

				for iter_290_0, iter_290_1 in pairs(arg_287_1.bgs_) do
					if iter_290_0 ~= "LX0101a" then
						iter_290_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_290_16 = 0

			if var_290_16 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_17 = 2

			if var_290_16 <= arg_287_1.time_ and arg_287_1.time_ < var_290_16 + var_290_17 then
				local var_290_18 = (arg_287_1.time_ - var_290_16) / var_290_17
				local var_290_19 = Color.New(0, 0, 0)

				var_290_19.a = Mathf.Lerp(0, 1, var_290_18)
				arg_287_1.mask_.color = var_290_19
			end

			if arg_287_1.time_ >= var_290_16 + var_290_17 and arg_287_1.time_ < var_290_16 + var_290_17 + arg_290_0 then
				local var_290_20 = Color.New(0, 0, 0)

				var_290_20.a = 1
				arg_287_1.mask_.color = var_290_20
			end

			local var_290_21 = 2

			if var_290_21 < arg_287_1.time_ and arg_287_1.time_ <= var_290_21 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_22 = 2

			if var_290_21 <= arg_287_1.time_ and arg_287_1.time_ < var_290_21 + var_290_22 then
				local var_290_23 = (arg_287_1.time_ - var_290_21) / var_290_22
				local var_290_24 = Color.New(0, 0, 0)

				var_290_24.a = Mathf.Lerp(1, 0, var_290_23)
				arg_287_1.mask_.color = var_290_24
			end

			if arg_287_1.time_ >= var_290_21 + var_290_22 and arg_287_1.time_ < var_290_21 + var_290_22 + arg_290_0 then
				local var_290_25 = Color.New(0, 0, 0)
				local var_290_26 = 0

				arg_287_1.mask_.enabled = false
				var_290_25.a = var_290_26
				arg_287_1.mask_.color = var_290_25
			end

			local var_290_27 = 0
			local var_290_28 = 0.533333333333333

			if var_290_27 < arg_287_1.time_ and arg_287_1.time_ <= var_290_27 + arg_290_0 then
				local var_290_29 = "play"
				local var_290_30 = "effect"

				arg_287_1:AudioAction(var_290_29, var_290_30, "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_290_31 = manager.ui.mainCamera.transform
			local var_290_32 = 1

			if var_290_32 < arg_287_1.time_ and arg_287_1.time_ <= var_290_32 + arg_290_0 then
				arg_287_1.var_.shakeOldPos = var_290_31.localPosition
			end

			local var_290_33 = 1

			if var_290_32 <= arg_287_1.time_ and arg_287_1.time_ < var_290_32 + var_290_33 then
				local var_290_34 = (arg_287_1.time_ - var_290_32) / 0.066
				local var_290_35, var_290_36 = math.modf(var_290_34)

				var_290_31.localPosition = Vector3.New(var_290_36 * 0.13, var_290_36 * 0.13, var_290_36 * 0.13) + arg_287_1.var_.shakeOldPos
			end

			if arg_287_1.time_ >= var_290_32 + var_290_33 and arg_287_1.time_ < var_290_32 + var_290_33 + arg_290_0 then
				var_290_31.localPosition = arg_287_1.var_.shakeOldPos
			end

			local var_290_37 = arg_287_1.bgs_.LX0101a.transform
			local var_290_38 = 2

			if var_290_38 < arg_287_1.time_ and arg_287_1.time_ <= var_290_38 + arg_290_0 then
				arg_287_1.var_.moveOldPosLX0101a = var_290_37.localPosition
			end

			local var_290_39 = 0.001

			if var_290_38 <= arg_287_1.time_ and arg_287_1.time_ < var_290_38 + var_290_39 then
				local var_290_40 = (arg_287_1.time_ - var_290_38) / var_290_39
				local var_290_41 = Vector3.New(0, 1, 9)

				var_290_37.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPosLX0101a, var_290_41, var_290_40)
			end

			if arg_287_1.time_ >= var_290_38 + var_290_39 and arg_287_1.time_ < var_290_38 + var_290_39 + arg_290_0 then
				var_290_37.localPosition = Vector3.New(0, 1, 9)
			end

			local var_290_42 = arg_287_1.bgs_.LX0101a.transform
			local var_290_43 = 2.01666666666667

			if var_290_43 < arg_287_1.time_ and arg_287_1.time_ <= var_290_43 + arg_290_0 then
				arg_287_1.var_.moveOldPosLX0101a = var_290_42.localPosition
			end

			local var_290_44 = 0.983333333333333

			if var_290_43 <= arg_287_1.time_ and arg_287_1.time_ < var_290_43 + var_290_44 then
				local var_290_45 = (arg_287_1.time_ - var_290_43) / var_290_44
				local var_290_46 = Vector3.New(0, 1, 9.5)

				var_290_42.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPosLX0101a, var_290_46, var_290_45)
			end

			if arg_287_1.time_ >= var_290_43 + var_290_44 and arg_287_1.time_ < var_290_43 + var_290_44 + arg_290_0 then
				var_290_42.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_290_47 = arg_287_1.bgs_.LX0101a.transform
			local var_290_48 = 3

			if var_290_48 < arg_287_1.time_ and arg_287_1.time_ <= var_290_48 + arg_290_0 then
				arg_287_1.var_.moveOldPosLX0101a = var_290_47.localPosition
			end

			local var_290_49 = 3

			if var_290_48 <= arg_287_1.time_ and arg_287_1.time_ < var_290_48 + var_290_49 then
				local var_290_50 = (arg_287_1.time_ - var_290_48) / var_290_49
				local var_290_51 = Vector3.New(0, 1, 10)

				var_290_47.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPosLX0101a, var_290_51, var_290_50)
			end

			if arg_287_1.time_ >= var_290_48 + var_290_49 and arg_287_1.time_ < var_290_48 + var_290_49 + arg_290_0 then
				var_290_47.localPosition = Vector3.New(0, 1, 10)
			end

			local var_290_52 = manager.ui.mainCamera.transform
			local var_290_53 = 2

			if var_290_53 < arg_287_1.time_ and arg_287_1.time_ <= var_290_53 + arg_290_0 then
				arg_287_1.var_.shakeOldPos = var_290_52.localPosition
			end

			local var_290_54 = 1

			if var_290_53 <= arg_287_1.time_ and arg_287_1.time_ < var_290_53 + var_290_54 then
				local var_290_55 = (arg_287_1.time_ - var_290_53) / 0.066
				local var_290_56, var_290_57 = math.modf(var_290_55)

				var_290_52.localPosition = Vector3.New(var_290_57 * 0.13, var_290_57 * 0.13, var_290_57 * 0.13) + arg_287_1.var_.shakeOldPos
			end

			if arg_287_1.time_ >= var_290_53 + var_290_54 and arg_287_1.time_ < var_290_53 + var_290_54 + arg_290_0 then
				var_290_52.localPosition = arg_287_1.var_.shakeOldPos
			end

			local var_290_58 = 4

			if var_290_58 < arg_287_1.time_ and arg_287_1.time_ <= var_290_58 + arg_290_0 then
				arg_287_1.allBtn_.enabled = false
			end

			local var_290_59 = 2

			if arg_287_1.time_ >= var_290_58 + var_290_59 and arg_287_1.time_ < var_290_58 + var_290_59 + arg_290_0 then
				arg_287_1.allBtn_.enabled = true
			end

			if arg_287_1.frameCnt_ <= 1 then
				arg_287_1.dialog_:SetActive(false)
			end

			local var_290_60 = 4
			local var_290_61 = 0.375

			if var_290_60 < arg_287_1.time_ and arg_287_1.time_ <= var_290_60 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_62 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_62:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_287_1.dialogCg_.alpha = arg_291_0
				end))
				var_290_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_63 = arg_287_1:GetWordFromCfg(318171072)
				local var_290_64 = arg_287_1:FormatText(var_290_63.content)

				arg_287_1.text_.text = var_290_64

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_65 = 15
				local var_290_66 = utf8.len(var_290_64)
				local var_290_67 = var_290_65 <= 0 and var_290_61 or var_290_61 * (var_290_66 / var_290_65)

				if var_290_67 > 0 and var_290_61 < var_290_67 then
					arg_287_1.talkMaxDuration = var_290_67
					var_290_60 = var_290_60 + 0.3

					if var_290_67 + var_290_60 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_67 + var_290_60
					end
				end

				arg_287_1.text_.text = var_290_64
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_68 = var_290_60 + 0.3
			local var_290_69 = math.max(var_290_61, arg_287_1.talkMaxDuration)

			if var_290_68 <= arg_287_1.time_ and arg_287_1.time_ < var_290_68 + var_290_69 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_68) / var_290_69

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_68 + var_290_69 and arg_287_1.time_ < var_290_68 + var_290_69 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "LX0101a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LX0101a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.983333333333333,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LX0101a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play318171073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 318171073
		arg_293_1.duration_ = 3.03

		local var_293_0 = {
			zh = 1.666,
			ja = 3.033
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play318171074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.2

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_2 = arg_293_1:FormatText(StoryNameCfg[562].name)

				arg_293_1.leftNameTxt_.text = var_296_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:GetWordFromCfg(318171073)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 8
				local var_296_6 = utf8.len(var_296_4)
				local var_296_7 = var_296_5 <= 0 and var_296_1 or var_296_1 * (var_296_6 / var_296_5)

				if var_296_7 > 0 and var_296_1 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171073", "story_v_out_318171.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171073", "story_v_out_318171.awb") / 1000

					if var_296_8 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_0
					end

					if var_296_3.prefab_name ~= "" and arg_293_1.actors_[var_296_3.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_3.prefab_name].transform, "story_v_out_318171", "318171073", "story_v_out_318171.awb")

						arg_293_1:RecordAudio("318171073", var_296_9)
						arg_293_1:RecordAudio("318171073", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_318171", "318171073", "story_v_out_318171.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_318171", "318171073", "story_v_out_318171.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_10 and arg_293_1.time_ < var_296_0 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play318171074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 318171074
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play318171075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 1.375

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_2 = arg_297_1:GetWordFromCfg(318171074)
				local var_300_3 = arg_297_1:FormatText(var_300_2.content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 55
				local var_300_5 = utf8.len(var_300_3)
				local var_300_6 = var_300_4 <= 0 and var_300_1 or var_300_1 * (var_300_5 / var_300_4)

				if var_300_6 > 0 and var_300_1 < var_300_6 then
					arg_297_1.talkMaxDuration = var_300_6

					if var_300_6 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_7 and arg_297_1.time_ < var_300_0 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play318171075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 318171075
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play318171076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.225

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[7].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:GetWordFromCfg(318171075)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 9
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_8 and arg_301_1.time_ < var_304_0 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play318171076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 318171076
		arg_305_1.duration_ = 4

		local var_305_0 = {
			zh = 3,
			ja = 4
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
				arg_305_0:Play318171077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.35

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[479].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(318171076)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171076", "story_v_out_318171.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_318171", "318171076", "story_v_out_318171.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_318171", "318171076", "story_v_out_318171.awb")

						arg_305_1:RecordAudio("318171076", var_308_9)
						arg_305_1:RecordAudio("318171076", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_318171", "318171076", "story_v_out_318171.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_318171", "318171076", "story_v_out_318171.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play318171077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 318171077
		arg_309_1.duration_ = 7.23

		local var_309_0 = {
			zh = 6.533,
			ja = 7.233
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
				arg_309_0:Play318171078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 2

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				local var_312_1 = manager.ui.mainCamera.transform.localPosition
				local var_312_2 = Vector3.New(0, 0, 10) + Vector3.New(var_312_1.x, var_312_1.y, 0)
				local var_312_3 = arg_309_1.bgs_.K16f

				var_312_3.transform.localPosition = var_312_2
				var_312_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_312_4 = var_312_3:GetComponent("SpriteRenderer")

				if var_312_4 and var_312_4.sprite then
					local var_312_5 = (var_312_3.transform.localPosition - var_312_1).z
					local var_312_6 = manager.ui.mainCameraCom_
					local var_312_7 = 2 * var_312_5 * Mathf.Tan(var_312_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_312_8 = var_312_7 * var_312_6.aspect
					local var_312_9 = var_312_4.sprite.bounds.size.x
					local var_312_10 = var_312_4.sprite.bounds.size.y
					local var_312_11 = var_312_8 / var_312_9
					local var_312_12 = var_312_7 / var_312_10
					local var_312_13 = var_312_12 < var_312_11 and var_312_11 or var_312_12

					var_312_3.transform.localScale = Vector3.New(var_312_13, var_312_13, 0)
				end

				for iter_312_0, iter_312_1 in pairs(arg_309_1.bgs_) do
					if iter_312_0 ~= "K16f" then
						iter_312_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_312_14 = 0

			if var_312_14 < arg_309_1.time_ and arg_309_1.time_ <= var_312_14 + arg_312_0 then
				arg_309_1.mask_.enabled = true
				arg_309_1.mask_.raycastTarget = true

				arg_309_1:SetGaussion(false)
			end

			local var_312_15 = 2

			if var_312_14 <= arg_309_1.time_ and arg_309_1.time_ < var_312_14 + var_312_15 then
				local var_312_16 = (arg_309_1.time_ - var_312_14) / var_312_15
				local var_312_17 = Color.New(0, 0, 0)

				var_312_17.a = Mathf.Lerp(0, 1, var_312_16)
				arg_309_1.mask_.color = var_312_17
			end

			if arg_309_1.time_ >= var_312_14 + var_312_15 and arg_309_1.time_ < var_312_14 + var_312_15 + arg_312_0 then
				local var_312_18 = Color.New(0, 0, 0)

				var_312_18.a = 1
				arg_309_1.mask_.color = var_312_18
			end

			local var_312_19 = 2

			if var_312_19 < arg_309_1.time_ and arg_309_1.time_ <= var_312_19 + arg_312_0 then
				arg_309_1.mask_.enabled = true
				arg_309_1.mask_.raycastTarget = true

				arg_309_1:SetGaussion(false)
			end

			local var_312_20 = 2

			if var_312_19 <= arg_309_1.time_ and arg_309_1.time_ < var_312_19 + var_312_20 then
				local var_312_21 = (arg_309_1.time_ - var_312_19) / var_312_20
				local var_312_22 = Color.New(0, 0, 0)

				var_312_22.a = Mathf.Lerp(1, 0, var_312_21)
				arg_309_1.mask_.color = var_312_22
			end

			if arg_309_1.time_ >= var_312_19 + var_312_20 and arg_309_1.time_ < var_312_19 + var_312_20 + arg_312_0 then
				local var_312_23 = Color.New(0, 0, 0)
				local var_312_24 = 0

				arg_309_1.mask_.enabled = false
				var_312_23.a = var_312_24
				arg_309_1.mask_.color = var_312_23
			end

			local var_312_25 = arg_309_1.actors_["10066ui_story"].transform
			local var_312_26 = 2

			if var_312_26 < arg_309_1.time_ and arg_309_1.time_ <= var_312_26 + arg_312_0 then
				arg_309_1.var_.moveOldPos10066ui_story = var_312_25.localPosition
			end

			local var_312_27 = 0.001

			if var_312_26 <= arg_309_1.time_ and arg_309_1.time_ < var_312_26 + var_312_27 then
				local var_312_28 = (arg_309_1.time_ - var_312_26) / var_312_27
				local var_312_29 = Vector3.New(0, -0.99, -5.83)

				var_312_25.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10066ui_story, var_312_29, var_312_28)

				local var_312_30 = manager.ui.mainCamera.transform.position - var_312_25.position

				var_312_25.forward = Vector3.New(var_312_30.x, var_312_30.y, var_312_30.z)

				local var_312_31 = var_312_25.localEulerAngles

				var_312_31.z = 0
				var_312_31.x = 0
				var_312_25.localEulerAngles = var_312_31
			end

			if arg_309_1.time_ >= var_312_26 + var_312_27 and arg_309_1.time_ < var_312_26 + var_312_27 + arg_312_0 then
				var_312_25.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_312_32 = manager.ui.mainCamera.transform.position - var_312_25.position

				var_312_25.forward = Vector3.New(var_312_32.x, var_312_32.y, var_312_32.z)

				local var_312_33 = var_312_25.localEulerAngles

				var_312_33.z = 0
				var_312_33.x = 0
				var_312_25.localEulerAngles = var_312_33
			end

			local var_312_34 = arg_309_1.actors_["10066ui_story"]
			local var_312_35 = 2

			if var_312_35 < arg_309_1.time_ and arg_309_1.time_ <= var_312_35 + arg_312_0 and not isNil(var_312_34) and arg_309_1.var_.characterEffect10066ui_story == nil then
				arg_309_1.var_.characterEffect10066ui_story = var_312_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_36 = 0.200000002980232

			if var_312_35 <= arg_309_1.time_ and arg_309_1.time_ < var_312_35 + var_312_36 and not isNil(var_312_34) then
				local var_312_37 = (arg_309_1.time_ - var_312_35) / var_312_36

				if arg_309_1.var_.characterEffect10066ui_story and not isNil(var_312_34) then
					arg_309_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_35 + var_312_36 and arg_309_1.time_ < var_312_35 + var_312_36 + arg_312_0 and not isNil(var_312_34) and arg_309_1.var_.characterEffect10066ui_story then
				arg_309_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_312_38 = 2

			if var_312_38 < arg_309_1.time_ and arg_309_1.time_ <= var_312_38 + arg_312_0 then
				arg_309_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_312_39 = 2

			if var_312_39 < arg_309_1.time_ and arg_309_1.time_ <= var_312_39 + arg_312_0 then
				arg_309_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_309_1.frameCnt_ <= 1 then
				arg_309_1.dialog_:SetActive(false)
			end

			local var_312_40 = 4
			local var_312_41 = 0.225

			if var_312_40 < arg_309_1.time_ and arg_309_1.time_ <= var_312_40 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0

				arg_309_1.dialog_:SetActive(true)

				arg_309_1.dialogCg_.alpha = 0

				local var_312_42 = LeanTween.value(arg_309_1.dialog_, 0, 1, 0.3)

				var_312_42:setOnUpdate(LuaHelper.FloatAction(function(arg_313_0)
					arg_309_1.dialogCg_.alpha = arg_313_0
				end))
				var_312_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_309_1.dialog_)
					var_312_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_309_1.duration_ = arg_309_1.duration_ + 0.3

				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_43 = arg_309_1:FormatText(StoryNameCfg[640].name)

				arg_309_1.leftNameTxt_.text = var_312_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_44 = arg_309_1:GetWordFromCfg(318171077)
				local var_312_45 = arg_309_1:FormatText(var_312_44.content)

				arg_309_1.text_.text = var_312_45

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_46 = 9
				local var_312_47 = utf8.len(var_312_45)
				local var_312_48 = var_312_46 <= 0 and var_312_41 or var_312_41 * (var_312_47 / var_312_46)

				if var_312_48 > 0 and var_312_41 < var_312_48 then
					arg_309_1.talkMaxDuration = var_312_48
					var_312_40 = var_312_40 + 0.3

					if var_312_48 + var_312_40 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_48 + var_312_40
					end
				end

				arg_309_1.text_.text = var_312_45
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171077", "story_v_out_318171.awb") ~= 0 then
					local var_312_49 = manager.audio:GetVoiceLength("story_v_out_318171", "318171077", "story_v_out_318171.awb") / 1000

					if var_312_49 + var_312_40 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_49 + var_312_40
					end

					if var_312_44.prefab_name ~= "" and arg_309_1.actors_[var_312_44.prefab_name] ~= nil then
						local var_312_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_44.prefab_name].transform, "story_v_out_318171", "318171077", "story_v_out_318171.awb")

						arg_309_1:RecordAudio("318171077", var_312_50)
						arg_309_1:RecordAudio("318171077", var_312_50)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_318171", "318171077", "story_v_out_318171.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_318171", "318171077", "story_v_out_318171.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_51 = var_312_40 + 0.3
			local var_312_52 = math.max(var_312_41, arg_309_1.talkMaxDuration)

			if var_312_51 <= arg_309_1.time_ and arg_309_1.time_ < var_312_51 + var_312_52 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_51) / var_312_52

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_51 + var_312_52 and arg_309_1.time_ < var_312_51 + var_312_52 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play318171078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 318171078
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play318171079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["10066ui_story"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect10066ui_story == nil then
				arg_315_1.var_.characterEffect10066ui_story = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.characterEffect10066ui_story and not isNil(var_318_0) then
					local var_318_4 = Mathf.Lerp(0, 0.5, var_318_3)

					arg_315_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_315_1.var_.characterEffect10066ui_story.fillRatio = var_318_4
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect10066ui_story then
				local var_318_5 = 0.5

				arg_315_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_315_1.var_.characterEffect10066ui_story.fillRatio = var_318_5
			end

			local var_318_6 = 0
			local var_318_7 = 0.525

			if var_318_6 < arg_315_1.time_ and arg_315_1.time_ <= var_318_6 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_8 = arg_315_1:GetWordFromCfg(318171078)
				local var_318_9 = arg_315_1:FormatText(var_318_8.content)

				arg_315_1.text_.text = var_318_9

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_10 = 21
				local var_318_11 = utf8.len(var_318_9)
				local var_318_12 = var_318_10 <= 0 and var_318_7 or var_318_7 * (var_318_11 / var_318_10)

				if var_318_12 > 0 and var_318_7 < var_318_12 then
					arg_315_1.talkMaxDuration = var_318_12

					if var_318_12 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_12 + var_318_6
					end
				end

				arg_315_1.text_.text = var_318_9
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_13 = math.max(var_318_7, arg_315_1.talkMaxDuration)

			if var_318_6 <= arg_315_1.time_ and arg_315_1.time_ < var_318_6 + var_318_13 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_6) / var_318_13

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_6 + var_318_13 and arg_315_1.time_ < var_318_6 + var_318_13 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play318171079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 318171079
		arg_319_1.duration_ = 3.67

		local var_319_0 = {
			zh = 3.666,
			ja = 2.666
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play318171080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10066ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect10066ui_story == nil then
				arg_319_1.var_.characterEffect10066ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect10066ui_story and not isNil(var_322_0) then
					arg_319_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect10066ui_story then
				arg_319_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_322_4 = 0

			if var_322_4 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_322_5 = 0

			if var_322_5 < arg_319_1.time_ and arg_319_1.time_ <= var_322_5 + arg_322_0 then
				arg_319_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_322_6 = 0
			local var_322_7 = 0.3

			if var_322_6 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_8 = arg_319_1:FormatText(StoryNameCfg[640].name)

				arg_319_1.leftNameTxt_.text = var_322_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_9 = arg_319_1:GetWordFromCfg(318171079)
				local var_322_10 = arg_319_1:FormatText(var_322_9.content)

				arg_319_1.text_.text = var_322_10

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_11 = 12
				local var_322_12 = utf8.len(var_322_10)
				local var_322_13 = var_322_11 <= 0 and var_322_7 or var_322_7 * (var_322_12 / var_322_11)

				if var_322_13 > 0 and var_322_7 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_6
					end
				end

				arg_319_1.text_.text = var_322_10
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171079", "story_v_out_318171.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_out_318171", "318171079", "story_v_out_318171.awb") / 1000

					if var_322_14 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_6
					end

					if var_322_9.prefab_name ~= "" and arg_319_1.actors_[var_322_9.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_9.prefab_name].transform, "story_v_out_318171", "318171079", "story_v_out_318171.awb")

						arg_319_1:RecordAudio("318171079", var_322_15)
						arg_319_1:RecordAudio("318171079", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_318171", "318171079", "story_v_out_318171.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_318171", "318171079", "story_v_out_318171.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_7, arg_319_1.talkMaxDuration)

			if var_322_6 <= arg_319_1.time_ and arg_319_1.time_ < var_322_6 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_6) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_6 + var_322_16 and arg_319_1.time_ < var_322_6 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play318171080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 318171080
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play318171081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10066ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect10066ui_story == nil then
				arg_323_1.var_.characterEffect10066ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect10066ui_story and not isNil(var_326_0) then
					local var_326_4 = Mathf.Lerp(0, 0.5, var_326_3)

					arg_323_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_323_1.var_.characterEffect10066ui_story.fillRatio = var_326_4
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect10066ui_story then
				local var_326_5 = 0.5

				arg_323_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_323_1.var_.characterEffect10066ui_story.fillRatio = var_326_5
			end

			local var_326_6 = 0
			local var_326_7 = 0.2

			if var_326_6 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_8 = arg_323_1:FormatText(StoryNameCfg[7].name)

				arg_323_1.leftNameTxt_.text = var_326_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_9 = arg_323_1:GetWordFromCfg(318171080)
				local var_326_10 = arg_323_1:FormatText(var_326_9.content)

				arg_323_1.text_.text = var_326_10

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_11 = 8
				local var_326_12 = utf8.len(var_326_10)
				local var_326_13 = var_326_11 <= 0 and var_326_7 or var_326_7 * (var_326_12 / var_326_11)

				if var_326_13 > 0 and var_326_7 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_6
					end
				end

				arg_323_1.text_.text = var_326_10
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_14 = math.max(var_326_7, arg_323_1.talkMaxDuration)

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_14 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_6) / var_326_14

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_6 + var_326_14 and arg_323_1.time_ < var_326_6 + var_326_14 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play318171081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 318171081
		arg_327_1.duration_ = 16.27

		local var_327_0 = {
			zh = 11.733,
			ja = 16.266
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play318171082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10066ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect10066ui_story == nil then
				arg_327_1.var_.characterEffect10066ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect10066ui_story and not isNil(var_330_0) then
					arg_327_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect10066ui_story then
				arg_327_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_330_4 = 0
			local var_330_5 = 1.2

			if var_330_4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_6 = arg_327_1:FormatText(StoryNameCfg[640].name)

				arg_327_1.leftNameTxt_.text = var_330_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_7 = arg_327_1:GetWordFromCfg(318171081)
				local var_330_8 = arg_327_1:FormatText(var_330_7.content)

				arg_327_1.text_.text = var_330_8

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 48
				local var_330_10 = utf8.len(var_330_8)
				local var_330_11 = var_330_9 <= 0 and var_330_5 or var_330_5 * (var_330_10 / var_330_9)

				if var_330_11 > 0 and var_330_5 < var_330_11 then
					arg_327_1.talkMaxDuration = var_330_11

					if var_330_11 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_11 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_8
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171081", "story_v_out_318171.awb") ~= 0 then
					local var_330_12 = manager.audio:GetVoiceLength("story_v_out_318171", "318171081", "story_v_out_318171.awb") / 1000

					if var_330_12 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_12 + var_330_4
					end

					if var_330_7.prefab_name ~= "" and arg_327_1.actors_[var_330_7.prefab_name] ~= nil then
						local var_330_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_7.prefab_name].transform, "story_v_out_318171", "318171081", "story_v_out_318171.awb")

						arg_327_1:RecordAudio("318171081", var_330_13)
						arg_327_1:RecordAudio("318171081", var_330_13)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_318171", "318171081", "story_v_out_318171.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_318171", "318171081", "story_v_out_318171.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_14 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_14 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_14

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_14 and arg_327_1.time_ < var_330_4 + var_330_14 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play318171082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 318171082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play318171083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["10066ui_story"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect10066ui_story == nil then
				arg_331_1.var_.characterEffect10066ui_story = var_334_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.characterEffect10066ui_story and not isNil(var_334_0) then
					local var_334_4 = Mathf.Lerp(0, 0.5, var_334_3)

					arg_331_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_331_1.var_.characterEffect10066ui_story.fillRatio = var_334_4
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect10066ui_story then
				local var_334_5 = 0.5

				arg_331_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_331_1.var_.characterEffect10066ui_story.fillRatio = var_334_5
			end

			local var_334_6 = 0
			local var_334_7 = 0.15

			if var_334_6 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_8 = arg_331_1:FormatText(StoryNameCfg[7].name)

				arg_331_1.leftNameTxt_.text = var_334_8

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

				local var_334_9 = arg_331_1:GetWordFromCfg(318171082)
				local var_334_10 = arg_331_1:FormatText(var_334_9.content)

				arg_331_1.text_.text = var_334_10

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_11 = 6
				local var_334_12 = utf8.len(var_334_10)
				local var_334_13 = var_334_11 <= 0 and var_334_7 or var_334_7 * (var_334_12 / var_334_11)

				if var_334_13 > 0 and var_334_7 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_10
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_14 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_14 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_14

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_14 and arg_331_1.time_ < var_334_6 + var_334_14 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play318171083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 318171083
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play318171084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.9

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_2 = arg_335_1:GetWordFromCfg(318171083)
				local var_338_3 = arg_335_1:FormatText(var_338_2.content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 36
				local var_338_5 = utf8.len(var_338_3)
				local var_338_6 = var_338_4 <= 0 and var_338_1 or var_338_1 * (var_338_5 / var_338_4)

				if var_338_6 > 0 and var_338_1 < var_338_6 then
					arg_335_1.talkMaxDuration = var_338_6

					if var_338_6 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_6 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_7 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_7 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_7

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_7 and arg_335_1.time_ < var_338_0 + var_338_7 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play318171084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 318171084
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play318171085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.7

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_2 = arg_339_1:GetWordFromCfg(318171084)
				local var_342_3 = arg_339_1:FormatText(var_342_2.content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 28
				local var_342_5 = utf8.len(var_342_3)
				local var_342_6 = var_342_4 <= 0 and var_342_1 or var_342_1 * (var_342_5 / var_342_4)

				if var_342_6 > 0 and var_342_1 < var_342_6 then
					arg_339_1.talkMaxDuration = var_342_6

					if var_342_6 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_6 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_7 and arg_339_1.time_ < var_342_0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play318171085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 318171085
		arg_343_1.duration_ = 7.73

		local var_343_0 = {
			zh = 7.733,
			ja = 5.5
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
				arg_343_0:Play318171086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["10066ui_story"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect10066ui_story == nil then
				arg_343_1.var_.characterEffect10066ui_story = var_346_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.characterEffect10066ui_story and not isNil(var_346_0) then
					arg_343_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect10066ui_story then
				arg_343_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_346_4 = 0

			if var_346_4 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_346_5 = 0
			local var_346_6 = 0.85

			if var_346_5 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_7 = arg_343_1:FormatText(StoryNameCfg[640].name)

				arg_343_1.leftNameTxt_.text = var_346_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_8 = arg_343_1:GetWordFromCfg(318171085)
				local var_346_9 = arg_343_1:FormatText(var_346_8.content)

				arg_343_1.text_.text = var_346_9

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_10 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171085", "story_v_out_318171.awb") ~= 0 then
					local var_346_13 = manager.audio:GetVoiceLength("story_v_out_318171", "318171085", "story_v_out_318171.awb") / 1000

					if var_346_13 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_5
					end

					if var_346_8.prefab_name ~= "" and arg_343_1.actors_[var_346_8.prefab_name] ~= nil then
						local var_346_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_8.prefab_name].transform, "story_v_out_318171", "318171085", "story_v_out_318171.awb")

						arg_343_1:RecordAudio("318171085", var_346_14)
						arg_343_1:RecordAudio("318171085", var_346_14)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_318171", "318171085", "story_v_out_318171.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_318171", "318171085", "story_v_out_318171.awb")
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
	Play318171086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 318171086
		arg_347_1.duration_ = 8.13

		local var_347_0 = {
			zh = 7.133,
			ja = 8.133
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play318171087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_350_1 = 0
			local var_350_2 = 0.7

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_3 = arg_347_1:FormatText(StoryNameCfg[640].name)

				arg_347_1.leftNameTxt_.text = var_350_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_4 = arg_347_1:GetWordFromCfg(318171086)
				local var_350_5 = arg_347_1:FormatText(var_350_4.content)

				arg_347_1.text_.text = var_350_5

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_6 = 28
				local var_350_7 = utf8.len(var_350_5)
				local var_350_8 = var_350_6 <= 0 and var_350_2 or var_350_2 * (var_350_7 / var_350_6)

				if var_350_8 > 0 and var_350_2 < var_350_8 then
					arg_347_1.talkMaxDuration = var_350_8

					if var_350_8 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_5
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171086", "story_v_out_318171.awb") ~= 0 then
					local var_350_9 = manager.audio:GetVoiceLength("story_v_out_318171", "318171086", "story_v_out_318171.awb") / 1000

					if var_350_9 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_9 + var_350_1
					end

					if var_350_4.prefab_name ~= "" and arg_347_1.actors_[var_350_4.prefab_name] ~= nil then
						local var_350_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_4.prefab_name].transform, "story_v_out_318171", "318171086", "story_v_out_318171.awb")

						arg_347_1:RecordAudio("318171086", var_350_10)
						arg_347_1:RecordAudio("318171086", var_350_10)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_318171", "318171086", "story_v_out_318171.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_318171", "318171086", "story_v_out_318171.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_11 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_11 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_11

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_11 and arg_347_1.time_ < var_350_1 + var_350_11 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play318171087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 318171087
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play318171088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["10066ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect10066ui_story == nil then
				arg_351_1.var_.characterEffect10066ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect10066ui_story and not isNil(var_354_0) then
					local var_354_4 = Mathf.Lerp(0, 0.5, var_354_3)

					arg_351_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_351_1.var_.characterEffect10066ui_story.fillRatio = var_354_4
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect10066ui_story then
				local var_354_5 = 0.5

				arg_351_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_351_1.var_.characterEffect10066ui_story.fillRatio = var_354_5
			end

			local var_354_6 = 0
			local var_354_7 = 0.875

			if var_354_6 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_8 = arg_351_1:FormatText(StoryNameCfg[7].name)

				arg_351_1.leftNameTxt_.text = var_354_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_9 = arg_351_1:GetWordFromCfg(318171087)
				local var_354_10 = arg_351_1:FormatText(var_354_9.content)

				arg_351_1.text_.text = var_354_10

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 35
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
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_14 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_14 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_6) / var_354_14

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_6 + var_354_14 and arg_351_1.time_ < var_354_6 + var_354_14 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play318171088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 318171088
		arg_355_1.duration_ = 7.43

		local var_355_0 = {
			zh = 5.566,
			ja = 7.433
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play318171089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10066ui_story"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos10066ui_story = var_358_0.localPosition
			end

			local var_358_2 = 0.001

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2
				local var_358_4 = Vector3.New(0, -0.99, -5.83)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10066ui_story, var_358_4, var_358_3)

				local var_358_5 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_5.x, var_358_5.y, var_358_5.z)

				local var_358_6 = var_358_0.localEulerAngles

				var_358_6.z = 0
				var_358_6.x = 0
				var_358_0.localEulerAngles = var_358_6
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_358_7 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_7.x, var_358_7.y, var_358_7.z)

				local var_358_8 = var_358_0.localEulerAngles

				var_358_8.z = 0
				var_358_8.x = 0
				var_358_0.localEulerAngles = var_358_8
			end

			local var_358_9 = arg_355_1.actors_["10066ui_story"]
			local var_358_10 = 0

			if var_358_10 < arg_355_1.time_ and arg_355_1.time_ <= var_358_10 + arg_358_0 and not isNil(var_358_9) and arg_355_1.var_.characterEffect10066ui_story == nil then
				arg_355_1.var_.characterEffect10066ui_story = var_358_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_11 = 0.200000002980232

			if var_358_10 <= arg_355_1.time_ and arg_355_1.time_ < var_358_10 + var_358_11 and not isNil(var_358_9) then
				local var_358_12 = (arg_355_1.time_ - var_358_10) / var_358_11

				if arg_355_1.var_.characterEffect10066ui_story and not isNil(var_358_9) then
					arg_355_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_10 + var_358_11 and arg_355_1.time_ < var_358_10 + var_358_11 + arg_358_0 and not isNil(var_358_9) and arg_355_1.var_.characterEffect10066ui_story then
				arg_355_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_358_13 = 0

			if var_358_13 < arg_355_1.time_ and arg_355_1.time_ <= var_358_13 + arg_358_0 then
				arg_355_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			local var_358_14 = 0
			local var_358_15 = 0.45

			if var_358_14 < arg_355_1.time_ and arg_355_1.time_ <= var_358_14 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_16 = arg_355_1:FormatText(StoryNameCfg[640].name)

				arg_355_1.leftNameTxt_.text = var_358_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_17 = arg_355_1:GetWordFromCfg(318171088)
				local var_358_18 = arg_355_1:FormatText(var_358_17.content)

				arg_355_1.text_.text = var_358_18

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_19 = 18
				local var_358_20 = utf8.len(var_358_18)
				local var_358_21 = var_358_19 <= 0 and var_358_15 or var_358_15 * (var_358_20 / var_358_19)

				if var_358_21 > 0 and var_358_15 < var_358_21 then
					arg_355_1.talkMaxDuration = var_358_21

					if var_358_21 + var_358_14 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_21 + var_358_14
					end
				end

				arg_355_1.text_.text = var_358_18
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171088", "story_v_out_318171.awb") ~= 0 then
					local var_358_22 = manager.audio:GetVoiceLength("story_v_out_318171", "318171088", "story_v_out_318171.awb") / 1000

					if var_358_22 + var_358_14 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_22 + var_358_14
					end

					if var_358_17.prefab_name ~= "" and arg_355_1.actors_[var_358_17.prefab_name] ~= nil then
						local var_358_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_17.prefab_name].transform, "story_v_out_318171", "318171088", "story_v_out_318171.awb")

						arg_355_1:RecordAudio("318171088", var_358_23)
						arg_355_1:RecordAudio("318171088", var_358_23)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_318171", "318171088", "story_v_out_318171.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_318171", "318171088", "story_v_out_318171.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_24 = math.max(var_358_15, arg_355_1.talkMaxDuration)

			if var_358_14 <= arg_355_1.time_ and arg_355_1.time_ < var_358_14 + var_358_24 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_14) / var_358_24

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_14 + var_358_24 and arg_355_1.time_ < var_358_14 + var_358_24 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
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

		arg_355_1:InitPlayNodeList()
	end,
	Play318171089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 318171089
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play318171090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["10066ui_story"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect10066ui_story == nil then
				arg_359_1.var_.characterEffect10066ui_story = var_362_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.characterEffect10066ui_story and not isNil(var_362_0) then
					local var_362_4 = Mathf.Lerp(0, 0.5, var_362_3)

					arg_359_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_359_1.var_.characterEffect10066ui_story.fillRatio = var_362_4
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect10066ui_story then
				local var_362_5 = 0.5

				arg_359_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_359_1.var_.characterEffect10066ui_story.fillRatio = var_362_5
			end

			local var_362_6 = 0
			local var_362_7 = 0.7

			if var_362_6 < arg_359_1.time_ and arg_359_1.time_ <= var_362_6 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_8 = arg_359_1:FormatText(StoryNameCfg[7].name)

				arg_359_1.leftNameTxt_.text = var_362_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_9 = arg_359_1:GetWordFromCfg(318171089)
				local var_362_10 = arg_359_1:FormatText(var_362_9.content)

				arg_359_1.text_.text = var_362_10

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_11 = 28
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
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_14 = math.max(var_362_7, arg_359_1.talkMaxDuration)

			if var_362_6 <= arg_359_1.time_ and arg_359_1.time_ < var_362_6 + var_362_14 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_6) / var_362_14

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_6 + var_362_14 and arg_359_1.time_ < var_362_6 + var_362_14 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play318171090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 318171090
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play318171091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 0.75

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_2 = arg_363_1:GetWordFromCfg(318171090)
				local var_366_3 = arg_363_1:FormatText(var_366_2.content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 30
				local var_366_5 = utf8.len(var_366_3)
				local var_366_6 = var_366_4 <= 0 and var_366_1 or var_366_1 * (var_366_5 / var_366_4)

				if var_366_6 > 0 and var_366_1 < var_366_6 then
					arg_363_1.talkMaxDuration = var_366_6

					if var_366_6 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_6 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_3
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_7 and arg_363_1.time_ < var_366_0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play318171091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 318171091
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play318171092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 1.1

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_2 = arg_367_1:FormatText(StoryNameCfg[7].name)

				arg_367_1.leftNameTxt_.text = var_370_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(318171091)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 44
				local var_370_6 = utf8.len(var_370_4)
				local var_370_7 = var_370_5 <= 0 and var_370_1 or var_370_1 * (var_370_6 / var_370_5)

				if var_370_7 > 0 and var_370_1 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_8 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_8 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_8

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_8 and arg_367_1.time_ < var_370_0 + var_370_8 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play318171092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 318171092
		arg_371_1.duration_ = 2.17

		local var_371_0 = {
			zh = 1.733,
			ja = 2.166
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play318171093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["10066ui_story"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect10066ui_story == nil then
				arg_371_1.var_.characterEffect10066ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.characterEffect10066ui_story and not isNil(var_374_0) then
					arg_371_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect10066ui_story then
				arg_371_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_374_4 = 0
			local var_374_5 = 0.125

			if var_374_4 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_6 = arg_371_1:FormatText(StoryNameCfg[640].name)

				arg_371_1.leftNameTxt_.text = var_374_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_7 = arg_371_1:GetWordFromCfg(318171092)
				local var_374_8 = arg_371_1:FormatText(var_374_7.content)

				arg_371_1.text_.text = var_374_8

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_9 = 5
				local var_374_10 = utf8.len(var_374_8)
				local var_374_11 = var_374_9 <= 0 and var_374_5 or var_374_5 * (var_374_10 / var_374_9)

				if var_374_11 > 0 and var_374_5 < var_374_11 then
					arg_371_1.talkMaxDuration = var_374_11

					if var_374_11 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_11 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_8
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171092", "story_v_out_318171.awb") ~= 0 then
					local var_374_12 = manager.audio:GetVoiceLength("story_v_out_318171", "318171092", "story_v_out_318171.awb") / 1000

					if var_374_12 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_12 + var_374_4
					end

					if var_374_7.prefab_name ~= "" and arg_371_1.actors_[var_374_7.prefab_name] ~= nil then
						local var_374_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_7.prefab_name].transform, "story_v_out_318171", "318171092", "story_v_out_318171.awb")

						arg_371_1:RecordAudio("318171092", var_374_13)
						arg_371_1:RecordAudio("318171092", var_374_13)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_318171", "318171092", "story_v_out_318171.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_318171", "318171092", "story_v_out_318171.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_14 = math.max(var_374_5, arg_371_1.talkMaxDuration)

			if var_374_4 <= arg_371_1.time_ and arg_371_1.time_ < var_374_4 + var_374_14 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_4) / var_374_14

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_4 + var_374_14 and arg_371_1.time_ < var_374_4 + var_374_14 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play318171093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 318171093
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play318171094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["10066ui_story"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos10066ui_story = var_378_0.localPosition
			end

			local var_378_2 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2
				local var_378_4 = Vector3.New(0, 100, 0)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10066ui_story, var_378_4, var_378_3)

				local var_378_5 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_5.x, var_378_5.y, var_378_5.z)

				local var_378_6 = var_378_0.localEulerAngles

				var_378_6.z = 0
				var_378_6.x = 0
				var_378_0.localEulerAngles = var_378_6
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(0, 100, 0)

				local var_378_7 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_7.x, var_378_7.y, var_378_7.z)

				local var_378_8 = var_378_0.localEulerAngles

				var_378_8.z = 0
				var_378_8.x = 0
				var_378_0.localEulerAngles = var_378_8
			end

			local var_378_9 = arg_375_1.actors_["10066ui_story"]
			local var_378_10 = 0

			if var_378_10 < arg_375_1.time_ and arg_375_1.time_ <= var_378_10 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect10066ui_story == nil then
				arg_375_1.var_.characterEffect10066ui_story = var_378_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_11 = 0.200000002980232

			if var_378_10 <= arg_375_1.time_ and arg_375_1.time_ < var_378_10 + var_378_11 and not isNil(var_378_9) then
				local var_378_12 = (arg_375_1.time_ - var_378_10) / var_378_11

				if arg_375_1.var_.characterEffect10066ui_story and not isNil(var_378_9) then
					local var_378_13 = Mathf.Lerp(0, 0.5, var_378_12)

					arg_375_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_375_1.var_.characterEffect10066ui_story.fillRatio = var_378_13
				end
			end

			if arg_375_1.time_ >= var_378_10 + var_378_11 and arg_375_1.time_ < var_378_10 + var_378_11 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect10066ui_story then
				local var_378_14 = 0.5

				arg_375_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_375_1.var_.characterEffect10066ui_story.fillRatio = var_378_14
			end

			local var_378_15 = 0
			local var_378_16 = 0.725

			if var_378_15 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_17 = arg_375_1:FormatText(StoryNameCfg[7].name)

				arg_375_1.leftNameTxt_.text = var_378_17

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

				local var_378_18 = arg_375_1:GetWordFromCfg(318171093)
				local var_378_19 = arg_375_1:FormatText(var_378_18.content)

				arg_375_1.text_.text = var_378_19

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_20 = 29
				local var_378_21 = utf8.len(var_378_19)
				local var_378_22 = var_378_20 <= 0 and var_378_16 or var_378_16 * (var_378_21 / var_378_20)

				if var_378_22 > 0 and var_378_16 < var_378_22 then
					arg_375_1.talkMaxDuration = var_378_22

					if var_378_22 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_22 + var_378_15
					end
				end

				arg_375_1.text_.text = var_378_19
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_23 = math.max(var_378_16, arg_375_1.talkMaxDuration)

			if var_378_15 <= arg_375_1.time_ and arg_375_1.time_ < var_378_15 + var_378_23 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_15) / var_378_23

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_15 + var_378_23 and arg_375_1.time_ < var_378_15 + var_378_23 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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

		arg_375_1:InitPlayNodeList()
	end,
	Play318171094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 318171094
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
			arg_379_1.auto_ = false
		end

		function arg_379_1.playNext_(arg_381_0)
			arg_379_1.onStoryFinished_()
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.225

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

				local var_382_3 = arg_379_1:GetWordFromCfg(318171094)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 9
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
	Play318171046 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 318171046
		arg_383_1.duration_ = 2.7

		local var_383_0 = {
			zh = 2.133,
			ja = 2.7
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
				arg_383_0:Play318171047(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1015ui_story"].transform
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.var_.moveOldPos1015ui_story = var_386_0.localPosition
			end

			local var_386_2 = 0.001

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2
				local var_386_4 = Vector3.New(0, -1.15, -6.2)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1015ui_story, var_386_4, var_386_3)

				local var_386_5 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_5.x, var_386_5.y, var_386_5.z)

				local var_386_6 = var_386_0.localEulerAngles

				var_386_6.z = 0
				var_386_6.x = 0
				var_386_0.localEulerAngles = var_386_6
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_386_7 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_7.x, var_386_7.y, var_386_7.z)

				local var_386_8 = var_386_0.localEulerAngles

				var_386_8.z = 0
				var_386_8.x = 0
				var_386_0.localEulerAngles = var_386_8
			end

			local var_386_9 = arg_383_1.actors_["1015ui_story"]
			local var_386_10 = 0

			if var_386_10 < arg_383_1.time_ and arg_383_1.time_ <= var_386_10 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1015ui_story == nil then
				arg_383_1.var_.characterEffect1015ui_story = var_386_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_11 = 0.200000002980232

			if var_386_10 <= arg_383_1.time_ and arg_383_1.time_ < var_386_10 + var_386_11 and not isNil(var_386_9) then
				local var_386_12 = (arg_383_1.time_ - var_386_10) / var_386_11

				if arg_383_1.var_.characterEffect1015ui_story and not isNil(var_386_9) then
					arg_383_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_10 + var_386_11 and arg_383_1.time_ < var_386_10 + var_386_11 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1015ui_story then
				arg_383_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_386_13 = "1015ui_story"

			if arg_383_1.actors_[var_386_13] == nil then
				local var_386_14 = Asset.Load("Char/" .. "1015ui_story")

				if not isNil(var_386_14) then
					local var_386_15 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_383_1.stage_.transform)

					var_386_15.name = var_386_13
					var_386_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_383_1.actors_[var_386_13] = var_386_15

					local var_386_16 = var_386_15:GetComponentInChildren(typeof(CharacterEffect))

					var_386_16.enabled = true

					local var_386_17 = GameObjectTools.GetOrAddComponent(var_386_15, typeof(DynamicBoneHelper))

					if var_386_17 then
						var_386_17:EnableDynamicBone(false)
					end

					arg_383_1:ShowWeapon(var_386_16.transform, false)

					arg_383_1.var_[var_386_13 .. "Animator"] = var_386_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_383_1.var_[var_386_13 .. "Animator"].applyRootMotion = true
					arg_383_1.var_[var_386_13 .. "LipSync"] = var_386_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_386_18 = 0

			if var_386_18 < arg_383_1.time_ and arg_383_1.time_ <= var_386_18 + arg_386_0 then
				arg_383_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_386_19 = "1015ui_story"

			if arg_383_1.actors_[var_386_19] == nil then
				local var_386_20 = Asset.Load("Char/" .. "1015ui_story")

				if not isNil(var_386_20) then
					local var_386_21 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_383_1.stage_.transform)

					var_386_21.name = var_386_19
					var_386_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_383_1.actors_[var_386_19] = var_386_21

					local var_386_22 = var_386_21:GetComponentInChildren(typeof(CharacterEffect))

					var_386_22.enabled = true

					local var_386_23 = GameObjectTools.GetOrAddComponent(var_386_21, typeof(DynamicBoneHelper))

					if var_386_23 then
						var_386_23:EnableDynamicBone(false)
					end

					arg_383_1:ShowWeapon(var_386_22.transform, false)

					arg_383_1.var_[var_386_19 .. "Animator"] = var_386_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_383_1.var_[var_386_19 .. "Animator"].applyRootMotion = true
					arg_383_1.var_[var_386_19 .. "LipSync"] = var_386_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_386_24 = 0

			if var_386_24 < arg_383_1.time_ and arg_383_1.time_ <= var_386_24 + arg_386_0 then
				arg_383_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_386_25 = arg_383_1.actors_["1049ui_story"].transform
			local var_386_26 = 0

			if var_386_26 < arg_383_1.time_ and arg_383_1.time_ <= var_386_26 + arg_386_0 then
				arg_383_1.var_.moveOldPos1049ui_story = var_386_25.localPosition
			end

			local var_386_27 = 0.001

			if var_386_26 <= arg_383_1.time_ and arg_383_1.time_ < var_386_26 + var_386_27 then
				local var_386_28 = (arg_383_1.time_ - var_386_26) / var_386_27
				local var_386_29 = Vector3.New(0, 100, 0)

				var_386_25.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1049ui_story, var_386_29, var_386_28)

				local var_386_30 = manager.ui.mainCamera.transform.position - var_386_25.position

				var_386_25.forward = Vector3.New(var_386_30.x, var_386_30.y, var_386_30.z)

				local var_386_31 = var_386_25.localEulerAngles

				var_386_31.z = 0
				var_386_31.x = 0
				var_386_25.localEulerAngles = var_386_31
			end

			if arg_383_1.time_ >= var_386_26 + var_386_27 and arg_383_1.time_ < var_386_26 + var_386_27 + arg_386_0 then
				var_386_25.localPosition = Vector3.New(0, 100, 0)

				local var_386_32 = manager.ui.mainCamera.transform.position - var_386_25.position

				var_386_25.forward = Vector3.New(var_386_32.x, var_386_32.y, var_386_32.z)

				local var_386_33 = var_386_25.localEulerAngles

				var_386_33.z = 0
				var_386_33.x = 0
				var_386_25.localEulerAngles = var_386_33
			end

			local var_386_34 = 0
			local var_386_35 = 0.225

			if var_386_34 < arg_383_1.time_ and arg_383_1.time_ <= var_386_34 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_36 = arg_383_1:FormatText(StoryNameCfg[479].name)

				arg_383_1.leftNameTxt_.text = var_386_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_37 = arg_383_1:GetWordFromCfg(318171046)
				local var_386_38 = arg_383_1:FormatText(var_386_37.content)

				arg_383_1.text_.text = var_386_38

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_39 = 9
				local var_386_40 = utf8.len(var_386_38)
				local var_386_41 = var_386_39 <= 0 and var_386_35 or var_386_35 * (var_386_40 / var_386_39)

				if var_386_41 > 0 and var_386_35 < var_386_41 then
					arg_383_1.talkMaxDuration = var_386_41

					if var_386_41 + var_386_34 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_41 + var_386_34
					end
				end

				arg_383_1.text_.text = var_386_38
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318171", "318171046", "story_v_out_318171.awb") ~= 0 then
					local var_386_42 = manager.audio:GetVoiceLength("story_v_out_318171", "318171046", "story_v_out_318171.awb") / 1000

					if var_386_42 + var_386_34 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_42 + var_386_34
					end

					if var_386_37.prefab_name ~= "" and arg_383_1.actors_[var_386_37.prefab_name] ~= nil then
						local var_386_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_37.prefab_name].transform, "story_v_out_318171", "318171046", "story_v_out_318171.awb")

						arg_383_1:RecordAudio("318171046", var_386_43)
						arg_383_1:RecordAudio("318171046", var_386_43)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_318171", "318171046", "story_v_out_318171.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_318171", "318171046", "story_v_out_318171.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_44 = math.max(var_386_35, arg_383_1.talkMaxDuration)

			if var_386_34 <= arg_383_1.time_ and arg_383_1.time_ < var_386_34 + var_386_44 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_34) / var_386_44

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_34 + var_386_44 and arg_383_1.time_ < var_386_34 + var_386_44 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K16f",
		"TextureConfig/Background/LX0101a"
	},
	voices = {
		"story_v_out_318171.awb"
	}
}
