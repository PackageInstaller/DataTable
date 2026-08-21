return {
	Play305041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 305041001
		arg_1_1.duration_ = 6.53

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play305041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B14"

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
				local var_4_5 = arg_1_1.bgs_.B14

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
					if iter_4_0 ~= "B14" then
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

			local var_4_24 = 0.2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_4_28 = 0.2
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_152", "se_story_152_amb_gun_battle", "")
			end

			local var_4_32 = 1
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 0
			local var_4_39 = 1

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_40 = "play"
				local var_4_41 = "effect"

				arg_1_1:AudioAction(var_4_40, var_4_41, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_42 = 1.53333333333333
			local var_4_43 = 0.675

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_44 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_44:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_45 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_46 = arg_1_1:GetWordFromCfg(305041001)
				local var_4_47 = arg_1_1:FormatText(var_4_46.content)

				arg_1_1.text_.text = var_4_47

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_48 = 27
				local var_4_49 = utf8.len(var_4_47)
				local var_4_50 = var_4_48 <= 0 and var_4_43 or var_4_43 * (var_4_49 / var_4_48)

				if var_4_50 > 0 and var_4_43 < var_4_50 then
					arg_1_1.talkMaxDuration = var_4_50
					var_4_42 = var_4_42 + 0.3

					if var_4_50 + var_4_42 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_50 + var_4_42
					end
				end

				arg_1_1.text_.text = var_4_47
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_51 = var_4_42 + 0.3
			local var_4_52 = math.max(var_4_43, arg_1_1.talkMaxDuration)

			if var_4_51 <= arg_1_1.time_ and arg_1_1.time_ < var_4_51 + var_4_52 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_51) / var_4_52

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_51 + var_4_52 and arg_1_1.time_ < var_4_51 + var_4_52 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play305041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 305041002
		arg_8_1.duration_ = 5.57

		local var_8_0 = {
			zh = 5.566,
			ja = 1.999999999999
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
				arg_8_0:Play305041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1066ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1066ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1066ui_story = var_11_5.localPosition
			end

			local var_11_7 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7
				local var_11_9 = Vector3.New(0, -0.77, -6.1)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1066ui_story, var_11_9, var_11_8)

				local var_11_10 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_10.x, var_11_10.y, var_11_10.z)

				local var_11_11 = var_11_5.localEulerAngles

				var_11_11.z = 0
				var_11_11.x = 0
				var_11_5.localEulerAngles = var_11_11
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_11_12 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_12.x, var_11_12.y, var_11_12.z)

				local var_11_13 = var_11_5.localEulerAngles

				var_11_13.z = 0
				var_11_13.x = 0
				var_11_5.localEulerAngles = var_11_13
			end

			local var_11_14 = arg_8_1.actors_["1066ui_story"]
			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1066ui_story == nil then
				arg_8_1.var_.characterEffect1066ui_story = var_11_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_16 = 0.200000002980232

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_16 and not isNil(var_11_14) then
				local var_11_17 = (arg_8_1.time_ - var_11_15) / var_11_16

				if arg_8_1.var_.characterEffect1066ui_story and not isNil(var_11_14) then
					arg_8_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_15 + var_11_16 and arg_8_1.time_ < var_11_15 + var_11_16 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1066ui_story then
				arg_8_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_20 = 0
			local var_11_21 = 0.725

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[32].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(305041002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041002", "story_v_out_305041.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_305041", "305041002", "story_v_out_305041.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_305041", "305041002", "story_v_out_305041.awb")

						arg_8_1:RecordAudio("305041002", var_11_29)
						arg_8_1:RecordAudio("305041002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_305041", "305041002", "story_v_out_305041.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_305041", "305041002", "story_v_out_305041.awb")
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
				actorName = "1066ui_story",
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
	Play305041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 305041003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play305041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1066ui_story"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos1066ui_story = var_15_0.localPosition
			end

			local var_15_2 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2
				local var_15_4 = Vector3.New(0, 100, 0)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1066ui_story, var_15_4, var_15_3)

				local var_15_5 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_5.x, var_15_5.y, var_15_5.z)

				local var_15_6 = var_15_0.localEulerAngles

				var_15_6.z = 0
				var_15_6.x = 0
				var_15_0.localEulerAngles = var_15_6
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, 100, 0)

				local var_15_7 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_7.x, var_15_7.y, var_15_7.z)

				local var_15_8 = var_15_0.localEulerAngles

				var_15_8.z = 0
				var_15_8.x = 0
				var_15_0.localEulerAngles = var_15_8
			end

			local var_15_9 = arg_12_1.actors_["1066ui_story"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1066ui_story == nil then
				arg_12_1.var_.characterEffect1066ui_story = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.200000002980232

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect1066ui_story and not isNil(var_15_9) then
					local var_15_13 = Mathf.Lerp(0, 0.5, var_15_12)

					arg_12_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1066ui_story.fillRatio = var_15_13
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1066ui_story then
				local var_15_14 = 0.5

				arg_12_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1066ui_story.fillRatio = var_15_14
			end

			local var_15_15 = 0
			local var_15_16 = 1.075

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_17 = arg_12_1:GetWordFromCfg(305041003)
				local var_15_18 = arg_12_1:FormatText(var_15_17.content)

				arg_12_1.text_.text = var_15_18

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_19 = 43
				local var_15_20 = utf8.len(var_15_18)
				local var_15_21 = var_15_19 <= 0 and var_15_16 or var_15_16 * (var_15_20 / var_15_19)

				if var_15_21 > 0 and var_15_16 < var_15_21 then
					arg_12_1.talkMaxDuration = var_15_21

					if var_15_21 + var_15_15 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_21 + var_15_15
					end
				end

				arg_12_1.text_.text = var_15_18
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_22 = math.max(var_15_16, arg_12_1.talkMaxDuration)

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_22 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_15) / var_15_22

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_15 + var_15_22 and arg_12_1.time_ < var_15_15 + var_15_22 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play305041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 305041004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play305041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.45

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

				local var_19_2 = arg_16_1:GetWordFromCfg(305041004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 58
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
	Play305041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 305041005
		arg_20_1.duration_ = 4.8

		local var_20_0 = {
			zh = 4.8,
			ja = 1.999999999999
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
				arg_20_0:Play305041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1066ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1066ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(0, -0.77, -6.1)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1066ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = arg_20_1.actors_["1066ui_story"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1066ui_story == nil then
				arg_20_1.var_.characterEffect1066ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect1066ui_story and not isNil(var_23_9) then
					arg_20_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1066ui_story then
				arg_20_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_23_13 = 0

			if var_23_13 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 then
				arg_20_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action438")
			end

			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_15 = 0
			local var_23_16 = 0.425

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_17 = arg_20_1:FormatText(StoryNameCfg[32].name)

				arg_20_1.leftNameTxt_.text = var_23_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(305041005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_20 = 17
				local var_23_21 = utf8.len(var_23_19)
				local var_23_22 = var_23_20 <= 0 and var_23_16 or var_23_16 * (var_23_21 / var_23_20)

				if var_23_22 > 0 and var_23_16 < var_23_22 then
					arg_20_1.talkMaxDuration = var_23_22

					if var_23_22 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041005", "story_v_out_305041.awb") ~= 0 then
					local var_23_23 = manager.audio:GetVoiceLength("story_v_out_305041", "305041005", "story_v_out_305041.awb") / 1000

					if var_23_23 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_15
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_305041", "305041005", "story_v_out_305041.awb")

						arg_20_1:RecordAudio("305041005", var_23_24)
						arg_20_1:RecordAudio("305041005", var_23_24)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_305041", "305041005", "story_v_out_305041.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_305041", "305041005", "story_v_out_305041.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_25 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_25 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_15) / var_23_25

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_15 + var_23_25 and arg_20_1.time_ < var_23_15 + var_23_25 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play305041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 305041006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play305041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1066ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1066ui_story == nil then
				arg_24_1.var_.characterEffect1066ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1066ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1066ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1066ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1066ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 1

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

				local var_27_9 = arg_24_1:GetWordFromCfg(305041006)
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
	Play305041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 305041007
		arg_28_1.duration_ = 4.93

		local var_28_0 = {
			zh = 4.933,
			ja = 1.333
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
				arg_28_0:Play305041008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1066ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1066ui_story == nil then
				arg_28_1.var_.characterEffect1066ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1066ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1066ui_story then
				arg_28_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_31_4 = 0
			local var_31_5 = 0.625

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_6 = arg_28_1:FormatText(StoryNameCfg[32].name)

				arg_28_1.leftNameTxt_.text = var_31_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_7 = arg_28_1:GetWordFromCfg(305041007)
				local var_31_8 = arg_28_1:FormatText(var_31_7.content)

				arg_28_1.text_.text = var_31_8

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 25
				local var_31_10 = utf8.len(var_31_8)
				local var_31_11 = var_31_9 <= 0 and var_31_5 or var_31_5 * (var_31_10 / var_31_9)

				if var_31_11 > 0 and var_31_5 < var_31_11 then
					arg_28_1.talkMaxDuration = var_31_11

					if var_31_11 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_11 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_8
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041007", "story_v_out_305041.awb") ~= 0 then
					local var_31_12 = manager.audio:GetVoiceLength("story_v_out_305041", "305041007", "story_v_out_305041.awb") / 1000

					if var_31_12 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_4
					end

					if var_31_7.prefab_name ~= "" and arg_28_1.actors_[var_31_7.prefab_name] ~= nil then
						local var_31_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_7.prefab_name].transform, "story_v_out_305041", "305041007", "story_v_out_305041.awb")

						arg_28_1:RecordAudio("305041007", var_31_13)
						arg_28_1:RecordAudio("305041007", var_31_13)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_305041", "305041007", "story_v_out_305041.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_305041", "305041007", "story_v_out_305041.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_14 and arg_28_1.time_ < var_31_4 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play305041008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 305041008
		arg_32_1.duration_ = 6.7

		local var_32_0 = {
			zh = 6.7,
			ja = 1.999999999999
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
				arg_32_0:Play305041009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action8_2")
			end

			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_2 = 0
			local var_35_3 = 0.775

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_4 = arg_32_1:FormatText(StoryNameCfg[32].name)

				arg_32_1.leftNameTxt_.text = var_35_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:GetWordFromCfg(305041008)
				local var_35_6 = arg_32_1:FormatText(var_35_5.content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041008", "story_v_out_305041.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_305041", "305041008", "story_v_out_305041.awb") / 1000

					if var_35_10 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_2
					end

					if var_35_5.prefab_name ~= "" and arg_32_1.actors_[var_35_5.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_5.prefab_name].transform, "story_v_out_305041", "305041008", "story_v_out_305041.awb")

						arg_32_1:RecordAudio("305041008", var_35_11)
						arg_32_1:RecordAudio("305041008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_305041", "305041008", "story_v_out_305041.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_305041", "305041008", "story_v_out_305041.awb")
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
	Play305041009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 305041009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play305041010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1066ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1066ui_story == nil then
				arg_36_1.var_.characterEffect1066ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1066ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1066ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1066ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1066ui_story.fillRatio = var_39_5
			end

			local var_39_6 = arg_36_1.actors_["1066ui_story"].transform
			local var_39_7 = 0

			if var_39_7 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 then
				arg_36_1.var_.moveOldPos1066ui_story = var_39_6.localPosition
			end

			local var_39_8 = 0.001

			if var_39_7 <= arg_36_1.time_ and arg_36_1.time_ < var_39_7 + var_39_8 then
				local var_39_9 = (arg_36_1.time_ - var_39_7) / var_39_8
				local var_39_10 = Vector3.New(0, 100, 0)

				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1066ui_story, var_39_10, var_39_9)

				local var_39_11 = manager.ui.mainCamera.transform.position - var_39_6.position

				var_39_6.forward = Vector3.New(var_39_11.x, var_39_11.y, var_39_11.z)

				local var_39_12 = var_39_6.localEulerAngles

				var_39_12.z = 0
				var_39_12.x = 0
				var_39_6.localEulerAngles = var_39_12
			end

			if arg_36_1.time_ >= var_39_7 + var_39_8 and arg_36_1.time_ < var_39_7 + var_39_8 + arg_39_0 then
				var_39_6.localPosition = Vector3.New(0, 100, 0)

				local var_39_13 = manager.ui.mainCamera.transform.position - var_39_6.position

				var_39_6.forward = Vector3.New(var_39_13.x, var_39_13.y, var_39_13.z)

				local var_39_14 = var_39_6.localEulerAngles

				var_39_14.z = 0
				var_39_14.x = 0
				var_39_6.localEulerAngles = var_39_14
			end

			local var_39_15 = 0
			local var_39_16 = 0.925

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_17 = arg_36_1:GetWordFromCfg(305041009)
				local var_39_18 = arg_36_1:FormatText(var_39_17.content)

				arg_36_1.text_.text = var_39_18

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_19 = 37
				local var_39_20 = utf8.len(var_39_18)
				local var_39_21 = var_39_19 <= 0 and var_39_16 or var_39_16 * (var_39_20 / var_39_19)

				if var_39_21 > 0 and var_39_16 < var_39_21 then
					arg_36_1.talkMaxDuration = var_39_21

					if var_39_21 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_21 + var_39_15
					end
				end

				arg_36_1.text_.text = var_39_18
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = math.max(var_39_16, arg_36_1.talkMaxDuration)

			if var_39_15 <= arg_36_1.time_ and arg_36_1.time_ < var_39_15 + var_39_22 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_15) / var_39_22

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_15 + var_39_22 and arg_36_1.time_ < var_39_15 + var_39_22 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play305041010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 305041010
		arg_40_1.duration_ = 2.27

		local var_40_0 = {
			zh = 2.266,
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
				arg_40_0:Play305041011(arg_40_1)
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

			local var_43_5 = arg_40_1.actors_["1166ui_story"]
			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1166ui_story == nil then
				arg_40_1.var_.characterEffect1166ui_story = var_43_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_7 = 0.200000002980232

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_7 and not isNil(var_43_5) then
				local var_43_8 = (arg_40_1.time_ - var_43_6) / var_43_7

				if arg_40_1.var_.characterEffect1166ui_story and not isNil(var_43_5) then
					arg_40_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_6 + var_43_7 and arg_40_1.time_ < var_43_6 + var_43_7 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1166ui_story then
				arg_40_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_43_11 = arg_40_1.actors_["1166ui_story"].transform
			local var_43_12 = 0

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.var_.moveOldPos1166ui_story = var_43_11.localPosition

				local var_43_13 = GameObjectTools.GetOrAddComponent(var_43_11.gameObject, typeof(DynamicBoneHelper))

				if var_43_13 then
					var_43_13:EnableDynamicBone(false)
				end
			end

			local var_43_14 = 0.001

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_14 then
				local var_43_15 = (arg_40_1.time_ - var_43_12) / var_43_14
				local var_43_16 = Vector3.New(0, -0.75, -6.25)

				var_43_11.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1166ui_story, var_43_16, var_43_15)

				local var_43_17 = manager.ui.mainCamera.transform.position - var_43_11.position

				var_43_11.forward = Vector3.New(var_43_17.x, var_43_17.y, var_43_17.z)

				local var_43_18 = var_43_11.localEulerAngles

				var_43_18.z = 0
				var_43_18.x = 0
				var_43_11.localEulerAngles = var_43_18
			end

			if arg_40_1.time_ >= var_43_12 + var_43_14 and arg_40_1.time_ < var_43_12 + var_43_14 + arg_43_0 then
				var_43_11.localPosition = Vector3.New(0, -0.75, -6.25)

				local var_43_19 = manager.ui.mainCamera.transform.position - var_43_11.position

				var_43_11.forward = Vector3.New(var_43_19.x, var_43_19.y, var_43_19.z)

				local var_43_20 = var_43_11.localEulerAngles

				var_43_20.z = 0
				var_43_20.x = 0
				var_43_11.localEulerAngles = var_43_20

				local var_43_21 = GameObjectTools.GetOrAddComponent(var_43_11.gameObject, typeof(DynamicBoneHelper))

				if var_43_21 then
					var_43_21:EnableDynamicBone(true)
				end
			end

			local var_43_22 = 0
			local var_43_23 = 0.2

			if var_43_22 < arg_40_1.time_ and arg_40_1.time_ <= var_43_22 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_24 = arg_40_1:FormatText(StoryNameCfg[32].name)

				arg_40_1.leftNameTxt_.text = var_43_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_25 = arg_40_1:GetWordFromCfg(305041010)
				local var_43_26 = arg_40_1:FormatText(var_43_25.content)

				arg_40_1.text_.text = var_43_26

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_27 = 8
				local var_43_28 = utf8.len(var_43_26)
				local var_43_29 = var_43_27 <= 0 and var_43_23 or var_43_23 * (var_43_28 / var_43_27)

				if var_43_29 > 0 and var_43_23 < var_43_29 then
					arg_40_1.talkMaxDuration = var_43_29

					if var_43_29 + var_43_22 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_29 + var_43_22
					end
				end

				arg_40_1.text_.text = var_43_26
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041010", "story_v_out_305041.awb") ~= 0 then
					local var_43_30 = manager.audio:GetVoiceLength("story_v_out_305041", "305041010", "story_v_out_305041.awb") / 1000

					if var_43_30 + var_43_22 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_30 + var_43_22
					end

					if var_43_25.prefab_name ~= "" and arg_40_1.actors_[var_43_25.prefab_name] ~= nil then
						local var_43_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_25.prefab_name].transform, "story_v_out_305041", "305041010", "story_v_out_305041.awb")

						arg_40_1:RecordAudio("305041010", var_43_31)
						arg_40_1:RecordAudio("305041010", var_43_31)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_305041", "305041010", "story_v_out_305041.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_305041", "305041010", "story_v_out_305041.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_32 = math.max(var_43_23, arg_40_1.talkMaxDuration)

			if var_43_22 <= arg_40_1.time_ and arg_40_1.time_ < var_43_22 + var_43_32 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_22) / var_43_32

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_22 + var_43_32 and arg_40_1.time_ < var_43_22 + var_43_32 + arg_43_0 then
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
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play305041011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 305041011
		arg_44_1.duration_ = 8.4

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play305041012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 2

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				local var_47_1 = manager.ui.mainCamera.transform.localPosition
				local var_47_2 = Vector3.New(0, 0, 10) + Vector3.New(var_47_1.x, var_47_1.y, 0)
				local var_47_3 = arg_44_1.bgs_.B14

				var_47_3.transform.localPosition = var_47_2
				var_47_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_4 = var_47_3:GetComponent("SpriteRenderer")

				if var_47_4 and var_47_4.sprite then
					local var_47_5 = (var_47_3.transform.localPosition - var_47_1).z
					local var_47_6 = manager.ui.mainCameraCom_
					local var_47_7 = 2 * var_47_5 * Mathf.Tan(var_47_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_8 = var_47_7 * var_47_6.aspect
					local var_47_9 = var_47_4.sprite.bounds.size.x
					local var_47_10 = var_47_4.sprite.bounds.size.y
					local var_47_11 = var_47_8 / var_47_9
					local var_47_12 = var_47_7 / var_47_10
					local var_47_13 = var_47_12 < var_47_11 and var_47_11 or var_47_12

					var_47_3.transform.localScale = Vector3.New(var_47_13, var_47_13, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "B14" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_14 = 2

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			local var_47_15 = 0.3

			if arg_44_1.time_ >= var_47_14 + var_47_15 and arg_44_1.time_ < var_47_14 + var_47_15 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_17 = 2

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_17 then
				local var_47_18 = (arg_44_1.time_ - var_47_16) / var_47_17
				local var_47_19 = Color.New(0, 0, 0)

				var_47_19.a = Mathf.Lerp(0, 1, var_47_18)
				arg_44_1.mask_.color = var_47_19
			end

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				local var_47_20 = Color.New(0, 0, 0)

				var_47_20.a = 1
				arg_44_1.mask_.color = var_47_20
			end

			local var_47_21 = 2

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_22 = 2

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_22 then
				local var_47_23 = (arg_44_1.time_ - var_47_21) / var_47_22
				local var_47_24 = Color.New(0, 0, 0)

				var_47_24.a = Mathf.Lerp(1, 0, var_47_23)
				arg_44_1.mask_.color = var_47_24
			end

			if arg_44_1.time_ >= var_47_21 + var_47_22 and arg_44_1.time_ < var_47_21 + var_47_22 + arg_47_0 then
				local var_47_25 = Color.New(0, 0, 0)
				local var_47_26 = 0

				arg_44_1.mask_.enabled = false
				var_47_25.a = var_47_26
				arg_44_1.mask_.color = var_47_25
			end

			local var_47_27 = arg_44_1.actors_["1166ui_story"].transform
			local var_47_28 = 2

			if var_47_28 < arg_44_1.time_ and arg_44_1.time_ <= var_47_28 + arg_47_0 then
				arg_44_1.var_.moveOldPos1166ui_story = var_47_27.localPosition

				local var_47_29 = GameObjectTools.GetOrAddComponent(var_47_27.gameObject, typeof(DynamicBoneHelper))

				if var_47_29 then
					var_47_29:EnableDynamicBone(false)
				end
			end

			local var_47_30 = 0.001

			if var_47_28 <= arg_44_1.time_ and arg_44_1.time_ < var_47_28 + var_47_30 then
				local var_47_31 = (arg_44_1.time_ - var_47_28) / var_47_30
				local var_47_32 = Vector3.New(0, 100, 0)

				var_47_27.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1166ui_story, var_47_32, var_47_31)

				local var_47_33 = manager.ui.mainCamera.transform.position - var_47_27.position

				var_47_27.forward = Vector3.New(var_47_33.x, var_47_33.y, var_47_33.z)

				local var_47_34 = var_47_27.localEulerAngles

				var_47_34.z = 0
				var_47_34.x = 0
				var_47_27.localEulerAngles = var_47_34
			end

			if arg_44_1.time_ >= var_47_28 + var_47_30 and arg_44_1.time_ < var_47_28 + var_47_30 + arg_47_0 then
				var_47_27.localPosition = Vector3.New(0, 100, 0)

				local var_47_35 = manager.ui.mainCamera.transform.position - var_47_27.position

				var_47_27.forward = Vector3.New(var_47_35.x, var_47_35.y, var_47_35.z)

				local var_47_36 = var_47_27.localEulerAngles

				var_47_36.z = 0
				var_47_36.x = 0
				var_47_27.localEulerAngles = var_47_36

				local var_47_37 = GameObjectTools.GetOrAddComponent(var_47_27.gameObject, typeof(DynamicBoneHelper))

				if var_47_37 then
					var_47_37:EnableDynamicBone(true)
				end
			end

			local var_47_38 = arg_44_1.actors_["1066ui_story"]
			local var_47_39 = 0

			if var_47_39 < arg_44_1.time_ and arg_44_1.time_ <= var_47_39 + arg_47_0 and not isNil(var_47_38) and arg_44_1.var_.characterEffect1066ui_story == nil then
				arg_44_1.var_.characterEffect1066ui_story = var_47_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_40 = 0.200000002980232

			if var_47_39 <= arg_44_1.time_ and arg_44_1.time_ < var_47_39 + var_47_40 and not isNil(var_47_38) then
				local var_47_41 = (arg_44_1.time_ - var_47_39) / var_47_40

				if arg_44_1.var_.characterEffect1066ui_story and not isNil(var_47_38) then
					local var_47_42 = Mathf.Lerp(0, 0.5, var_47_41)

					arg_44_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1066ui_story.fillRatio = var_47_42
				end
			end

			if arg_44_1.time_ >= var_47_39 + var_47_40 and arg_44_1.time_ < var_47_39 + var_47_40 + arg_47_0 and not isNil(var_47_38) and arg_44_1.var_.characterEffect1066ui_story then
				local var_47_43 = 0.5

				arg_44_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1066ui_story.fillRatio = var_47_43
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_44 = 3.4
			local var_47_45 = 1.275

			if var_47_44 < arg_44_1.time_ and arg_44_1.time_ <= var_47_44 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_46 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_46:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_47 = arg_44_1:GetWordFromCfg(305041011)
				local var_47_48 = arg_44_1:FormatText(var_47_47.content)

				arg_44_1.text_.text = var_47_48

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_49 = 51
				local var_47_50 = utf8.len(var_47_48)
				local var_47_51 = var_47_49 <= 0 and var_47_45 or var_47_45 * (var_47_50 / var_47_49)

				if var_47_51 > 0 and var_47_45 < var_47_51 then
					arg_44_1.talkMaxDuration = var_47_51
					var_47_44 = var_47_44 + 0.3

					if var_47_51 + var_47_44 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_51 + var_47_44
					end
				end

				arg_44_1.text_.text = var_47_48
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_52 = var_47_44 + 0.3
			local var_47_53 = math.max(var_47_45, arg_44_1.talkMaxDuration)

			if var_47_52 <= arg_44_1.time_ and arg_44_1.time_ < var_47_52 + var_47_53 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_52) / var_47_53

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_52 + var_47_53 and arg_44_1.time_ < var_47_52 + var_47_53 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play305041012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 305041012
		arg_50_1.duration_ = 7.97

		local var_50_0 = {
			zh = 3.233,
			ja = 7.966
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play305041013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = "2079ui_story"

			if arg_50_1.actors_[var_53_0] == nil then
				local var_53_1 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_53_1) then
					local var_53_2 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_50_1.stage_.transform)

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

			local var_53_5 = arg_50_1.actors_["2079ui_story"].transform
			local var_53_6 = 0

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.var_.moveOldPos2079ui_story = var_53_5.localPosition
			end

			local var_53_7 = 0.001

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_7 then
				local var_53_8 = (arg_50_1.time_ - var_53_6) / var_53_7
				local var_53_9 = Vector3.New(0, -1.28, -5.6)

				var_53_5.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos2079ui_story, var_53_9, var_53_8)

				local var_53_10 = manager.ui.mainCamera.transform.position - var_53_5.position

				var_53_5.forward = Vector3.New(var_53_10.x, var_53_10.y, var_53_10.z)

				local var_53_11 = var_53_5.localEulerAngles

				var_53_11.z = 0
				var_53_11.x = 0
				var_53_5.localEulerAngles = var_53_11
			end

			if arg_50_1.time_ >= var_53_6 + var_53_7 and arg_50_1.time_ < var_53_6 + var_53_7 + arg_53_0 then
				var_53_5.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_53_12 = manager.ui.mainCamera.transform.position - var_53_5.position

				var_53_5.forward = Vector3.New(var_53_12.x, var_53_12.y, var_53_12.z)

				local var_53_13 = var_53_5.localEulerAngles

				var_53_13.z = 0
				var_53_13.x = 0
				var_53_5.localEulerAngles = var_53_13
			end

			local var_53_14 = arg_50_1.actors_["2079ui_story"]
			local var_53_15 = 0

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 and not isNil(var_53_14) and arg_50_1.var_.characterEffect2079ui_story == nil then
				arg_50_1.var_.characterEffect2079ui_story = var_53_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_16 = 0.200000002980232

			if var_53_15 <= arg_50_1.time_ and arg_50_1.time_ < var_53_15 + var_53_16 and not isNil(var_53_14) then
				local var_53_17 = (arg_50_1.time_ - var_53_15) / var_53_16

				if arg_50_1.var_.characterEffect2079ui_story and not isNil(var_53_14) then
					arg_50_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_15 + var_53_16 and arg_50_1.time_ < var_53_15 + var_53_16 + arg_53_0 and not isNil(var_53_14) and arg_50_1.var_.characterEffect2079ui_story then
				arg_50_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_53_18 = 0

			if var_53_18 < arg_50_1.time_ and arg_50_1.time_ <= var_53_18 + arg_53_0 then
				arg_50_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_53_19 = 0

			if var_53_19 < arg_50_1.time_ and arg_50_1.time_ <= var_53_19 + arg_53_0 then
				arg_50_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_53_20 = 0
			local var_53_21 = 0.375

			if var_53_20 < arg_50_1.time_ and arg_50_1.time_ <= var_53_20 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_22 = arg_50_1:FormatText(StoryNameCfg[646].name)

				arg_50_1.leftNameTxt_.text = var_53_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_23 = arg_50_1:GetWordFromCfg(305041012)
				local var_53_24 = arg_50_1:FormatText(var_53_23.content)

				arg_50_1.text_.text = var_53_24

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_25 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041012", "story_v_out_305041.awb") ~= 0 then
					local var_53_28 = manager.audio:GetVoiceLength("story_v_out_305041", "305041012", "story_v_out_305041.awb") / 1000

					if var_53_28 + var_53_20 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_28 + var_53_20
					end

					if var_53_23.prefab_name ~= "" and arg_50_1.actors_[var_53_23.prefab_name] ~= nil then
						local var_53_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_23.prefab_name].transform, "story_v_out_305041", "305041012", "story_v_out_305041.awb")

						arg_50_1:RecordAudio("305041012", var_53_29)
						arg_50_1:RecordAudio("305041012", var_53_29)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_305041", "305041012", "story_v_out_305041.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_305041", "305041012", "story_v_out_305041.awb")
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
				actorName = "2079ui_story",
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
	Play305041013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 305041013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play305041014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["2079ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect2079ui_story == nil then
				arg_54_1.var_.characterEffect2079ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect2079ui_story and not isNil(var_57_0) then
					local var_57_4 = Mathf.Lerp(0, 0.5, var_57_3)

					arg_54_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_54_1.var_.characterEffect2079ui_story.fillRatio = var_57_4
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect2079ui_story then
				local var_57_5 = 0.5

				arg_54_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_54_1.var_.characterEffect2079ui_story.fillRatio = var_57_5
			end

			local var_57_6 = 0
			local var_57_7 = 0.675

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_8 = arg_54_1:FormatText(StoryNameCfg[7].name)

				arg_54_1.leftNameTxt_.text = var_57_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_9 = arg_54_1:GetWordFromCfg(305041013)
				local var_57_10 = arg_54_1:FormatText(var_57_9.content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 27
				local var_57_12 = utf8.len(var_57_10)
				local var_57_13 = var_57_11 <= 0 and var_57_7 or var_57_7 * (var_57_12 / var_57_11)

				if var_57_13 > 0 and var_57_7 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_14 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_14 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_14

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_14 and arg_54_1.time_ < var_57_6 + var_57_14 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play305041014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 305041014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play305041015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.3

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[7].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:GetWordFromCfg(305041014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 12
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_8 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_8 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_8

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_8 and arg_58_1.time_ < var_61_0 + var_61_8 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play305041015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 305041015
		arg_62_1.duration_ = 7.7

		local var_62_0 = {
			zh = 6.2,
			ja = 7.7
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
				arg_62_0:Play305041016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["2079ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect2079ui_story == nil then
				arg_62_1.var_.characterEffect2079ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect2079ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect2079ui_story then
				arg_62_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_65_4 = 0

			if var_65_4 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_65_6 = 0
			local var_65_7 = 0.825

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[646].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_9 = arg_62_1:GetWordFromCfg(305041015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 33
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041015", "story_v_out_305041.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_305041", "305041015", "story_v_out_305041.awb") / 1000

					if var_65_14 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_6
					end

					if var_65_9.prefab_name ~= "" and arg_62_1.actors_[var_65_9.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_9.prefab_name].transform, "story_v_out_305041", "305041015", "story_v_out_305041.awb")

						arg_62_1:RecordAudio("305041015", var_65_15)
						arg_62_1:RecordAudio("305041015", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_305041", "305041015", "story_v_out_305041.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_305041", "305041015", "story_v_out_305041.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_16 and arg_62_1.time_ < var_65_6 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play305041016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 305041016
		arg_66_1.duration_ = 7.3

		local var_66_0 = {
			zh = 4.5,
			ja = 7.3
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
				arg_66_0:Play305041017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.525

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[646].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:GetWordFromCfg(305041016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 21
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041016", "story_v_out_305041.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_305041", "305041016", "story_v_out_305041.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_305041", "305041016", "story_v_out_305041.awb")

						arg_66_1:RecordAudio("305041016", var_69_9)
						arg_66_1:RecordAudio("305041016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_305041", "305041016", "story_v_out_305041.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_305041", "305041016", "story_v_out_305041.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_10 and arg_66_1.time_ < var_69_0 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play305041017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 305041017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play305041018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["2079ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect2079ui_story == nil then
				arg_70_1.var_.characterEffect2079ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect2079ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_70_1.var_.characterEffect2079ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect2079ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_70_1.var_.characterEffect2079ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.325

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[7].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_9 = arg_70_1:GetWordFromCfg(305041017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 13
				local var_73_12 = utf8.len(var_73_10)
				local var_73_13 = var_73_11 <= 0 and var_73_7 or var_73_7 * (var_73_12 / var_73_11)

				if var_73_13 > 0 and var_73_7 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play305041018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 305041018
		arg_74_1.duration_ = 6.87

		local var_74_0 = {
			zh = 5.966,
			ja = 6.866
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play305041019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["2079ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect2079ui_story == nil then
				arg_74_1.var_.characterEffect2079ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect2079ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect2079ui_story then
				arg_74_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_77_4 = 0
			local var_77_5 = 0.825

			if var_77_4 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_6 = arg_74_1:FormatText(StoryNameCfg[646].name)

				arg_74_1.leftNameTxt_.text = var_77_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_7 = arg_74_1:GetWordFromCfg(305041018)
				local var_77_8 = arg_74_1:FormatText(var_77_7.content)

				arg_74_1.text_.text = var_77_8

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 33
				local var_77_10 = utf8.len(var_77_8)
				local var_77_11 = var_77_9 <= 0 and var_77_5 or var_77_5 * (var_77_10 / var_77_9)

				if var_77_11 > 0 and var_77_5 < var_77_11 then
					arg_74_1.talkMaxDuration = var_77_11

					if var_77_11 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_11 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_8
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041018", "story_v_out_305041.awb") ~= 0 then
					local var_77_12 = manager.audio:GetVoiceLength("story_v_out_305041", "305041018", "story_v_out_305041.awb") / 1000

					if var_77_12 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_12 + var_77_4
					end

					if var_77_7.prefab_name ~= "" and arg_74_1.actors_[var_77_7.prefab_name] ~= nil then
						local var_77_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_7.prefab_name].transform, "story_v_out_305041", "305041018", "story_v_out_305041.awb")

						arg_74_1:RecordAudio("305041018", var_77_13)
						arg_74_1:RecordAudio("305041018", var_77_13)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_305041", "305041018", "story_v_out_305041.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_305041", "305041018", "story_v_out_305041.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_14 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_14 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_14

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_14 and arg_74_1.time_ < var_77_4 + var_77_14 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play305041019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 305041019
		arg_78_1.duration_ = 7.97

		local var_78_0 = {
			zh = 6.266,
			ja = 7.966
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
				arg_78_0:Play305041020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.85

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[646].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(305041019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 34
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041019", "story_v_out_305041.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_305041", "305041019", "story_v_out_305041.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_305041", "305041019", "story_v_out_305041.awb")

						arg_78_1:RecordAudio("305041019", var_81_9)
						arg_78_1:RecordAudio("305041019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_305041", "305041019", "story_v_out_305041.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_305041", "305041019", "story_v_out_305041.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play305041020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 305041020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play305041021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["2079ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect2079ui_story == nil then
				arg_82_1.var_.characterEffect2079ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect2079ui_story and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_82_1.var_.characterEffect2079ui_story.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect2079ui_story then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_82_1.var_.characterEffect2079ui_story.fillRatio = var_85_5
			end

			local var_85_6 = 0
			local var_85_7 = 0.3

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_8 = arg_82_1:FormatText(StoryNameCfg[7].name)

				arg_82_1.leftNameTxt_.text = var_85_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_9 = arg_82_1:GetWordFromCfg(305041020)
				local var_85_10 = arg_82_1:FormatText(var_85_9.content)

				arg_82_1.text_.text = var_85_10

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 12
				local var_85_12 = utf8.len(var_85_10)
				local var_85_13 = var_85_11 <= 0 and var_85_7 or var_85_7 * (var_85_12 / var_85_11)

				if var_85_13 > 0 and var_85_7 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_10
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_14 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_14 and arg_82_1.time_ < var_85_6 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play305041021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 305041021
		arg_86_1.duration_ = 8.5

		local var_86_0 = {
			zh = 4.966,
			ja = 8.5
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play305041022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["2079ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect2079ui_story == nil then
				arg_86_1.var_.characterEffect2079ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect2079ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect2079ui_story then
				arg_86_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_89_4 = 0
			local var_89_5 = 0.5

			if var_89_4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_6 = arg_86_1:FormatText(StoryNameCfg[646].name)

				arg_86_1.leftNameTxt_.text = var_89_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_7 = arg_86_1:GetWordFromCfg(305041021)
				local var_89_8 = arg_86_1:FormatText(var_89_7.content)

				arg_86_1.text_.text = var_89_8

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 20
				local var_89_10 = utf8.len(var_89_8)
				local var_89_11 = var_89_9 <= 0 and var_89_5 or var_89_5 * (var_89_10 / var_89_9)

				if var_89_11 > 0 and var_89_5 < var_89_11 then
					arg_86_1.talkMaxDuration = var_89_11

					if var_89_11 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_8
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041021", "story_v_out_305041.awb") ~= 0 then
					local var_89_12 = manager.audio:GetVoiceLength("story_v_out_305041", "305041021", "story_v_out_305041.awb") / 1000

					if var_89_12 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_4
					end

					if var_89_7.prefab_name ~= "" and arg_86_1.actors_[var_89_7.prefab_name] ~= nil then
						local var_89_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_7.prefab_name].transform, "story_v_out_305041", "305041021", "story_v_out_305041.awb")

						arg_86_1:RecordAudio("305041021", var_89_13)
						arg_86_1:RecordAudio("305041021", var_89_13)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_305041", "305041021", "story_v_out_305041.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_305041", "305041021", "story_v_out_305041.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_14 and arg_86_1.time_ < var_89_4 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play305041022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 305041022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play305041023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["2079ui_story"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos2079ui_story = var_93_0.localPosition
			end

			local var_93_2 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2
				local var_93_4 = Vector3.New(0, 100, 0)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos2079ui_story, var_93_4, var_93_3)

				local var_93_5 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_5.x, var_93_5.y, var_93_5.z)

				local var_93_6 = var_93_0.localEulerAngles

				var_93_6.z = 0
				var_93_6.x = 0
				var_93_0.localEulerAngles = var_93_6
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(0, 100, 0)

				local var_93_7 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_7.x, var_93_7.y, var_93_7.z)

				local var_93_8 = var_93_0.localEulerAngles

				var_93_8.z = 0
				var_93_8.x = 0
				var_93_0.localEulerAngles = var_93_8
			end

			local var_93_9 = arg_90_1.actors_["2079ui_story"]
			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 and not isNil(var_93_9) and arg_90_1.var_.characterEffect2079ui_story == nil then
				arg_90_1.var_.characterEffect2079ui_story = var_93_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_11 = 0.200000002980232

			if var_93_10 <= arg_90_1.time_ and arg_90_1.time_ < var_93_10 + var_93_11 and not isNil(var_93_9) then
				local var_93_12 = (arg_90_1.time_ - var_93_10) / var_93_11

				if arg_90_1.var_.characterEffect2079ui_story and not isNil(var_93_9) then
					local var_93_13 = Mathf.Lerp(0, 0.5, var_93_12)

					arg_90_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_90_1.var_.characterEffect2079ui_story.fillRatio = var_93_13
				end
			end

			if arg_90_1.time_ >= var_93_10 + var_93_11 and arg_90_1.time_ < var_93_10 + var_93_11 + arg_93_0 and not isNil(var_93_9) and arg_90_1.var_.characterEffect2079ui_story then
				local var_93_14 = 0.5

				arg_90_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_90_1.var_.characterEffect2079ui_story.fillRatio = var_93_14
			end

			local var_93_15 = 0
			local var_93_16 = 1.25

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_17 = arg_90_1:GetWordFromCfg(305041022)
				local var_93_18 = arg_90_1:FormatText(var_93_17.content)

				arg_90_1.text_.text = var_93_18

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_19 = 50
				local var_93_20 = utf8.len(var_93_18)
				local var_93_21 = var_93_19 <= 0 and var_93_16 or var_93_16 * (var_93_20 / var_93_19)

				if var_93_21 > 0 and var_93_16 < var_93_21 then
					arg_90_1.talkMaxDuration = var_93_21

					if var_93_21 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_21 + var_93_15
					end
				end

				arg_90_1.text_.text = var_93_18
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_22 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_22 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_22

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_22 and arg_90_1.time_ < var_93_15 + var_93_22 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play305041023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 305041023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play305041024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.425

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[7].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(305041023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 17
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
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_8 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_8 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_8

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_8 and arg_94_1.time_ < var_97_0 + var_97_8 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play305041024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 305041024
		arg_98_1.duration_ = 4.4

		local var_98_0 = {
			zh = 4.4,
			ja = 1.999999999999
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
				arg_98_0:Play305041025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = "1037ui_story"

			if arg_98_1.actors_[var_101_0] == nil then
				local var_101_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_101_1) then
					local var_101_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_98_1.stage_.transform)

					var_101_2.name = var_101_0
					var_101_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_98_1.actors_[var_101_0] = var_101_2

					local var_101_3 = var_101_2:GetComponentInChildren(typeof(CharacterEffect))

					var_101_3.enabled = true

					local var_101_4 = GameObjectTools.GetOrAddComponent(var_101_2, typeof(DynamicBoneHelper))

					if var_101_4 then
						var_101_4:EnableDynamicBone(false)
					end

					arg_98_1:ShowWeapon(var_101_3.transform, false)

					arg_98_1.var_[var_101_0 .. "Animator"] = var_101_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_98_1.var_[var_101_0 .. "Animator"].applyRootMotion = true
					arg_98_1.var_[var_101_0 .. "LipSync"] = var_101_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_101_5 = arg_98_1.actors_["1037ui_story"].transform
			local var_101_6 = 0

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.var_.moveOldPos1037ui_story = var_101_5.localPosition
			end

			local var_101_7 = 0.001

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_7 then
				local var_101_8 = (arg_98_1.time_ - var_101_6) / var_101_7
				local var_101_9 = Vector3.New(0, -1.09, -5.81)

				var_101_5.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1037ui_story, var_101_9, var_101_8)

				local var_101_10 = manager.ui.mainCamera.transform.position - var_101_5.position

				var_101_5.forward = Vector3.New(var_101_10.x, var_101_10.y, var_101_10.z)

				local var_101_11 = var_101_5.localEulerAngles

				var_101_11.z = 0
				var_101_11.x = 0
				var_101_5.localEulerAngles = var_101_11
			end

			if arg_98_1.time_ >= var_101_6 + var_101_7 and arg_98_1.time_ < var_101_6 + var_101_7 + arg_101_0 then
				var_101_5.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_101_12 = manager.ui.mainCamera.transform.position - var_101_5.position

				var_101_5.forward = Vector3.New(var_101_12.x, var_101_12.y, var_101_12.z)

				local var_101_13 = var_101_5.localEulerAngles

				var_101_13.z = 0
				var_101_13.x = 0
				var_101_5.localEulerAngles = var_101_13
			end

			local var_101_14 = arg_98_1.actors_["1037ui_story"]
			local var_101_15 = 0

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 and not isNil(var_101_14) and arg_98_1.var_.characterEffect1037ui_story == nil then
				arg_98_1.var_.characterEffect1037ui_story = var_101_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_16 = 0.200000002980232

			if var_101_15 <= arg_98_1.time_ and arg_98_1.time_ < var_101_15 + var_101_16 and not isNil(var_101_14) then
				local var_101_17 = (arg_98_1.time_ - var_101_15) / var_101_16

				if arg_98_1.var_.characterEffect1037ui_story and not isNil(var_101_14) then
					arg_98_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_15 + var_101_16 and arg_98_1.time_ < var_101_15 + var_101_16 + arg_101_0 and not isNil(var_101_14) and arg_98_1.var_.characterEffect1037ui_story then
				arg_98_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_101_18 = 0

			if var_101_18 < arg_98_1.time_ and arg_98_1.time_ <= var_101_18 + arg_101_0 then
				arg_98_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_101_19 = 0

			if var_101_19 < arg_98_1.time_ and arg_98_1.time_ <= var_101_19 + arg_101_0 then
				arg_98_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_101_20 = arg_98_1.actors_["1037ui_story"]
			local var_101_21 = 0.034000001847744
			local var_101_22 = 1.76599999815226

			if var_101_21 < arg_98_1.time_ and arg_98_1.time_ <= var_101_21 + arg_101_0 then
				if arg_98_1.var_.characterEffect1037ui_story == nil then
					arg_98_1.var_.characterEffect1037ui_story = var_101_20:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_98_1.var_.characterEffect1037ui_story.imageEffect:turnOn(false)
			end

			local var_101_23 = arg_98_1.actors_["1037ui_story"]
			local var_101_24 = 0

			if var_101_24 < arg_98_1.time_ and arg_98_1.time_ <= var_101_24 + arg_101_0 then
				if arg_98_1.var_.characterEffect1037ui_story == nil then
					arg_98_1.var_.characterEffect1037ui_story = var_101_23:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_101_25 = arg_98_1.var_.characterEffect1037ui_story

				var_101_25.imageEffect:turnOff()

				var_101_25.interferenceEffect.enabled = true
				var_101_25.interferenceEffect.noise = 0.001
				var_101_25.interferenceEffect.simTimeScale = 1
				var_101_25.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_101_26 = 0
			local var_101_27 = 0.625

			if var_101_26 < arg_98_1.time_ and arg_98_1.time_ <= var_101_26 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_28 = arg_98_1:FormatText(StoryNameCfg[15].name)

				arg_98_1.leftNameTxt_.text = var_101_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_29 = arg_98_1:GetWordFromCfg(305041024)
				local var_101_30 = arg_98_1:FormatText(var_101_29.content)

				arg_98_1.text_.text = var_101_30

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_31 = 25
				local var_101_32 = utf8.len(var_101_30)
				local var_101_33 = var_101_31 <= 0 and var_101_27 or var_101_27 * (var_101_32 / var_101_31)

				if var_101_33 > 0 and var_101_27 < var_101_33 then
					arg_98_1.talkMaxDuration = var_101_33

					if var_101_33 + var_101_26 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_33 + var_101_26
					end
				end

				arg_98_1.text_.text = var_101_30
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041024", "story_v_out_305041.awb") ~= 0 then
					local var_101_34 = manager.audio:GetVoiceLength("story_v_out_305041", "305041024", "story_v_out_305041.awb") / 1000

					if var_101_34 + var_101_26 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_34 + var_101_26
					end

					if var_101_29.prefab_name ~= "" and arg_98_1.actors_[var_101_29.prefab_name] ~= nil then
						local var_101_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_29.prefab_name].transform, "story_v_out_305041", "305041024", "story_v_out_305041.awb")

						arg_98_1:RecordAudio("305041024", var_101_35)
						arg_98_1:RecordAudio("305041024", var_101_35)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_305041", "305041024", "story_v_out_305041.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_305041", "305041024", "story_v_out_305041.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_36 = math.max(var_101_27, arg_98_1.talkMaxDuration)

			if var_101_26 <= arg_98_1.time_ and arg_98_1.time_ < var_101_26 + var_101_36 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_26) / var_101_36

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_26 + var_101_36 and arg_98_1.time_ < var_101_26 + var_101_36 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play305041025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 305041025
		arg_102_1.duration_ = 6.87

		local var_102_0 = {
			zh = 6.866,
			ja = 1.333
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play305041026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.975

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[15].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_3 = arg_102_1:GetWordFromCfg(305041025)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 39
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041025", "story_v_out_305041.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_305041", "305041025", "story_v_out_305041.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_305041", "305041025", "story_v_out_305041.awb")

						arg_102_1:RecordAudio("305041025", var_105_9)
						arg_102_1:RecordAudio("305041025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_305041", "305041025", "story_v_out_305041.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_305041", "305041025", "story_v_out_305041.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play305041026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 305041026
		arg_106_1.duration_ = 8.4

		local var_106_0 = {
			zh = 5.766,
			ja = 8.4
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
				arg_106_0:Play305041027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1037ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1037ui_story == nil then
				arg_106_1.var_.characterEffect1037ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1037ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1037ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1037ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1037ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0
			local var_109_7 = 0.625

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_8 = arg_106_1:FormatText(StoryNameCfg[10].name)

				arg_106_1.leftNameTxt_.text = var_109_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_9 = arg_106_1:GetWordFromCfg(305041026)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 25
				local var_109_12 = utf8.len(var_109_10)
				local var_109_13 = var_109_11 <= 0 and var_109_7 or var_109_7 * (var_109_12 / var_109_11)

				if var_109_13 > 0 and var_109_7 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041026", "story_v_out_305041.awb") ~= 0 then
					local var_109_14 = manager.audio:GetVoiceLength("story_v_out_305041", "305041026", "story_v_out_305041.awb") / 1000

					if var_109_14 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_6
					end

					if var_109_9.prefab_name ~= "" and arg_106_1.actors_[var_109_9.prefab_name] ~= nil then
						local var_109_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_9.prefab_name].transform, "story_v_out_305041", "305041026", "story_v_out_305041.awb")

						arg_106_1:RecordAudio("305041026", var_109_15)
						arg_106_1:RecordAudio("305041026", var_109_15)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_305041", "305041026", "story_v_out_305041.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_305041", "305041026", "story_v_out_305041.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_16 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_16 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_16

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_16 and arg_106_1.time_ < var_109_6 + var_109_16 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play305041027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 305041027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play305041028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1037ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos1037ui_story = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(0, 100, 0)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1037ui_story, var_113_4, var_113_3)

				local var_113_5 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_5.x, var_113_5.y, var_113_5.z)

				local var_113_6 = var_113_0.localEulerAngles

				var_113_6.z = 0
				var_113_6.x = 0
				var_113_0.localEulerAngles = var_113_6
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, 100, 0)

				local var_113_7 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_7.x, var_113_7.y, var_113_7.z)

				local var_113_8 = var_113_0.localEulerAngles

				var_113_8.z = 0
				var_113_8.x = 0
				var_113_0.localEulerAngles = var_113_8
			end

			local var_113_9 = 0
			local var_113_10 = 0.85

			if var_113_9 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_11 = arg_110_1:GetWordFromCfg(305041027)
				local var_113_12 = arg_110_1:FormatText(var_113_11.content)

				arg_110_1.text_.text = var_113_12

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_13 = 34
				local var_113_14 = utf8.len(var_113_12)
				local var_113_15 = var_113_13 <= 0 and var_113_10 or var_113_10 * (var_113_14 / var_113_13)

				if var_113_15 > 0 and var_113_10 < var_113_15 then
					arg_110_1.talkMaxDuration = var_113_15

					if var_113_15 + var_113_9 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_15 + var_113_9
					end
				end

				arg_110_1.text_.text = var_113_12
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_16 = math.max(var_113_10, arg_110_1.talkMaxDuration)

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_9) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_9 + var_113_16 and arg_110_1.time_ < var_113_9 + var_113_16 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play305041028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 305041028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play305041029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.275

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[7].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(305041028)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 11
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_8 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_8 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_8

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_8 and arg_114_1.time_ < var_117_0 + var_117_8 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play305041029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 305041029
		arg_118_1.duration_ = 4.67

		local var_118_0 = {
			zh = 2.533,
			ja = 4.666
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
				arg_118_0:Play305041030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["2079ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos2079ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(0, -1.28, -5.6)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos2079ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = arg_118_1.actors_["2079ui_story"]
			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect2079ui_story == nil then
				arg_118_1.var_.characterEffect2079ui_story = var_121_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_11 = 0.200000002980232

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_11 and not isNil(var_121_9) then
				local var_121_12 = (arg_118_1.time_ - var_121_10) / var_121_11

				if arg_118_1.var_.characterEffect2079ui_story and not isNil(var_121_9) then
					arg_118_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_10 + var_121_11 and arg_118_1.time_ < var_121_10 + var_121_11 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect2079ui_story then
				arg_118_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_121_13 = 0

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 then
				arg_118_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_121_14 = 0

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				arg_118_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_121_15 = 0
			local var_121_16 = 0.25

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_17 = arg_118_1:FormatText(StoryNameCfg[646].name)

				arg_118_1.leftNameTxt_.text = var_121_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:GetWordFromCfg(305041029)
				local var_121_19 = arg_118_1:FormatText(var_121_18.content)

				arg_118_1.text_.text = var_121_19

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_305041", "305041029", "story_v_out_305041.awb") ~= 0 then
					local var_121_23 = manager.audio:GetVoiceLength("story_v_out_305041", "305041029", "story_v_out_305041.awb") / 1000

					if var_121_23 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_15
					end

					if var_121_18.prefab_name ~= "" and arg_118_1.actors_[var_121_18.prefab_name] ~= nil then
						local var_121_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_18.prefab_name].transform, "story_v_out_305041", "305041029", "story_v_out_305041.awb")

						arg_118_1:RecordAudio("305041029", var_121_24)
						arg_118_1:RecordAudio("305041029", var_121_24)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_305041", "305041029", "story_v_out_305041.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_305041", "305041029", "story_v_out_305041.awb")
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
				actorName = "2079ui_story",
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
	Play305041030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 305041030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play305041031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.allBtn_.enabled = false
			end

			local var_125_1 = 0.3

			if arg_122_1.time_ >= var_125_0 + var_125_1 and arg_122_1.time_ < var_125_0 + var_125_1 + arg_125_0 then
				arg_122_1.allBtn_.enabled = true
			end

			local var_125_2 = arg_122_1.actors_["2079ui_story"].transform
			local var_125_3 = 0

			if var_125_3 < arg_122_1.time_ and arg_122_1.time_ <= var_125_3 + arg_125_0 then
				arg_122_1.var_.moveOldPos2079ui_story = var_125_2.localPosition
			end

			local var_125_4 = 0.001

			if var_125_3 <= arg_122_1.time_ and arg_122_1.time_ < var_125_3 + var_125_4 then
				local var_125_5 = (arg_122_1.time_ - var_125_3) / var_125_4
				local var_125_6 = Vector3.New(0, 100, 0)

				var_125_2.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos2079ui_story, var_125_6, var_125_5)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_2.position

				var_125_2.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_2.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_2.localEulerAngles = var_125_8
			end

			if arg_122_1.time_ >= var_125_3 + var_125_4 and arg_122_1.time_ < var_125_3 + var_125_4 + arg_125_0 then
				var_125_2.localPosition = Vector3.New(0, 100, 0)

				local var_125_9 = manager.ui.mainCamera.transform.position - var_125_2.position

				var_125_2.forward = Vector3.New(var_125_9.x, var_125_9.y, var_125_9.z)

				local var_125_10 = var_125_2.localEulerAngles

				var_125_10.z = 0
				var_125_10.x = 0
				var_125_2.localEulerAngles = var_125_10
			end

			local var_125_11 = arg_122_1.actors_["2079ui_story"]
			local var_125_12 = 0

			if var_125_12 < arg_122_1.time_ and arg_122_1.time_ <= var_125_12 + arg_125_0 and not isNil(var_125_11) and arg_122_1.var_.characterEffect2079ui_story == nil then
				arg_122_1.var_.characterEffect2079ui_story = var_125_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_13 = 0.200000002980232

			if var_125_12 <= arg_122_1.time_ and arg_122_1.time_ < var_125_12 + var_125_13 and not isNil(var_125_11) then
				local var_125_14 = (arg_122_1.time_ - var_125_12) / var_125_13

				if arg_122_1.var_.characterEffect2079ui_story and not isNil(var_125_11) then
					local var_125_15 = Mathf.Lerp(0, 0.5, var_125_14)

					arg_122_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_122_1.var_.characterEffect2079ui_story.fillRatio = var_125_15
				end
			end

			if arg_122_1.time_ >= var_125_12 + var_125_13 and arg_122_1.time_ < var_125_12 + var_125_13 + arg_125_0 and not isNil(var_125_11) and arg_122_1.var_.characterEffect2079ui_story then
				local var_125_16 = 0.5

				arg_122_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_122_1.var_.characterEffect2079ui_story.fillRatio = var_125_16
			end

			local var_125_17 = 0
			local var_125_18 = 0.8

			if var_125_17 < arg_122_1.time_ and arg_122_1.time_ <= var_125_17 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_19 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_19:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_122_1.dialogCg_.alpha = arg_126_0
				end))
				var_125_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_20 = arg_122_1:GetWordFromCfg(305041030)
				local var_125_21 = arg_122_1:FormatText(var_125_20.content)

				arg_122_1.text_.text = var_125_21

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_22 = 32
				local var_125_23 = utf8.len(var_125_21)
				local var_125_24 = var_125_22 <= 0 and var_125_18 or var_125_18 * (var_125_23 / var_125_22)

				if var_125_24 > 0 and var_125_18 < var_125_24 then
					arg_122_1.talkMaxDuration = var_125_24
					var_125_17 = var_125_17 + 0.3

					if var_125_24 + var_125_17 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_24 + var_125_17
					end
				end

				arg_122_1.text_.text = var_125_21
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_25 = var_125_17 + 0.3
			local var_125_26 = math.max(var_125_18, arg_122_1.talkMaxDuration)

			if var_125_25 <= arg_122_1.time_ and arg_122_1.time_ < var_125_25 + var_125_26 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_25) / var_125_26

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_25 + var_125_26 and arg_122_1.time_ < var_125_25 + var_125_26 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
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

		arg_122_1:InitPlayNodeList()
	end,
	Play305041031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 305041031
		arg_128_1.duration_ = 8.7

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play305041032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = "S0404"

			if arg_128_1.bgs_[var_131_0] == nil then
				local var_131_1 = Object.Instantiate(arg_128_1.paintGo_)

				var_131_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_131_0)
				var_131_1.name = var_131_0
				var_131_1.transform.parent = arg_128_1.stage_.transform
				var_131_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.bgs_[var_131_0] = var_131_1
			end

			local var_131_2 = 1.66666666666667

			if var_131_2 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				local var_131_3 = manager.ui.mainCamera.transform.localPosition
				local var_131_4 = Vector3.New(0, 0, 10) + Vector3.New(var_131_3.x, var_131_3.y, 0)
				local var_131_5 = arg_128_1.bgs_.S0404

				var_131_5.transform.localPosition = var_131_4
				var_131_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_6 = var_131_5:GetComponent("SpriteRenderer")

				if var_131_6 and var_131_6.sprite then
					local var_131_7 = (var_131_5.transform.localPosition - var_131_3).z
					local var_131_8 = manager.ui.mainCameraCom_
					local var_131_9 = 2 * var_131_7 * Mathf.Tan(var_131_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_131_10 = var_131_9 * var_131_8.aspect
					local var_131_11 = var_131_6.sprite.bounds.size.x
					local var_131_12 = var_131_6.sprite.bounds.size.y
					local var_131_13 = var_131_10 / var_131_11
					local var_131_14 = var_131_9 / var_131_12
					local var_131_15 = var_131_14 < var_131_13 and var_131_13 or var_131_14

					var_131_5.transform.localScale = Vector3.New(var_131_15, var_131_15, 0)
				end

				for iter_131_0, iter_131_1 in pairs(arg_128_1.bgs_) do
					if iter_131_0 ~= "S0404" then
						iter_131_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_131_16 = 0

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_17 = 1.7

			if var_131_16 <= arg_128_1.time_ and arg_128_1.time_ < var_131_16 + var_131_17 then
				local var_131_18 = (arg_128_1.time_ - var_131_16) / var_131_17
				local var_131_19 = Color.New(0, 0, 0)

				var_131_19.a = Mathf.Lerp(0, 1, var_131_18)
				arg_128_1.mask_.color = var_131_19
			end

			if arg_128_1.time_ >= var_131_16 + var_131_17 and arg_128_1.time_ < var_131_16 + var_131_17 + arg_131_0 then
				local var_131_20 = Color.New(0, 0, 0)

				var_131_20.a = 1
				arg_128_1.mask_.color = var_131_20
			end

			local var_131_21 = 1.7

			if var_131_21 < arg_128_1.time_ and arg_128_1.time_ <= var_131_21 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_22 = 2

			if var_131_21 <= arg_128_1.time_ and arg_128_1.time_ < var_131_21 + var_131_22 then
				local var_131_23 = (arg_128_1.time_ - var_131_21) / var_131_22
				local var_131_24 = Color.New(0, 0, 0)

				var_131_24.a = Mathf.Lerp(1, 0, var_131_23)
				arg_128_1.mask_.color = var_131_24
			end

			if arg_128_1.time_ >= var_131_21 + var_131_22 and arg_128_1.time_ < var_131_21 + var_131_22 + arg_131_0 then
				local var_131_25 = Color.New(0, 0, 0)
				local var_131_26 = 0

				arg_128_1.mask_.enabled = false
				var_131_25.a = var_131_26
				arg_128_1.mask_.color = var_131_25
			end

			local var_131_27 = arg_128_1.bgs_.S0404.transform
			local var_131_28 = 1.7

			if var_131_28 < arg_128_1.time_ and arg_128_1.time_ <= var_131_28 + arg_131_0 then
				arg_128_1.var_.moveOldPosS0404 = var_131_27.localPosition
			end

			local var_131_29 = 2

			if var_131_28 <= arg_128_1.time_ and arg_128_1.time_ < var_131_28 + var_131_29 then
				local var_131_30 = (arg_128_1.time_ - var_131_28) / var_131_29
				local var_131_31 = Vector3.New(0, 0.56, 8)

				var_131_27.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPosS0404, var_131_31, var_131_30)
			end

			if arg_128_1.time_ >= var_131_28 + var_131_29 and arg_128_1.time_ < var_131_28 + var_131_29 + arg_131_0 then
				var_131_27.localPosition = Vector3.New(0, 0.56, 8)
			end

			local var_131_32 = 0.2
			local var_131_33 = 1

			if var_131_32 < arg_128_1.time_ and arg_128_1.time_ <= var_131_32 + arg_131_0 then
				local var_131_34 = "play"
				local var_131_35 = "effect"

				arg_128_1:AudioAction(var_131_34, var_131_35, "se_story_151", "se_story_151_Paotai_Huopao_bullet1", "")
			end

			local var_131_36 = 2
			local var_131_37 = 1

			if var_131_36 < arg_128_1.time_ and arg_128_1.time_ <= var_131_36 + arg_131_0 then
				local var_131_38 = "play"
				local var_131_39 = "effect"

				arg_128_1:AudioAction(var_131_38, var_131_39, "se_story_140", "se_story_140_explosion04", "")
			end

			if arg_128_1.frameCnt_ <= 1 then
				arg_128_1.dialog_:SetActive(false)
			end

			local var_131_40 = 3.7
			local var_131_41 = 1.4

			if var_131_40 < arg_128_1.time_ and arg_128_1.time_ <= var_131_40 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0

				arg_128_1.dialog_:SetActive(true)

				arg_128_1.dialogCg_.alpha = 0

				local var_131_42 = LeanTween.value(arg_128_1.dialog_, 0, 1, 0.3)

				var_131_42:setOnUpdate(LuaHelper.FloatAction(function(arg_132_0)
					arg_128_1.dialogCg_.alpha = arg_132_0
				end))
				var_131_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_128_1.dialog_)
					var_131_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_128_1.duration_ = arg_128_1.duration_ + 0.3

				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_43 = arg_128_1:GetWordFromCfg(305041031)
				local var_131_44 = arg_128_1:FormatText(var_131_43.content)

				arg_128_1.text_.text = var_131_44

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_45 = 56
				local var_131_46 = utf8.len(var_131_44)
				local var_131_47 = var_131_45 <= 0 and var_131_41 or var_131_41 * (var_131_46 / var_131_45)

				if var_131_47 > 0 and var_131_41 < var_131_47 then
					arg_128_1.talkMaxDuration = var_131_47
					var_131_40 = var_131_40 + 0.3

					if var_131_47 + var_131_40 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_47 + var_131_40
					end
				end

				arg_128_1.text_.text = var_131_44
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_48 = var_131_40 + 0.3
			local var_131_49 = math.max(var_131_41, arg_128_1.talkMaxDuration)

			if var_131_48 <= arg_128_1.time_ and arg_128_1.time_ < var_131_48 + var_131_49 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_48) / var_131_49

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_48 + var_131_49 and arg_128_1.time_ < var_131_48 + var_131_49 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D Wobble",
				duration = 1.46666666666667,
				amplitudeGain = 0.1,
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 6),
					endPos = Vector3.New(0, 0.56, 8),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play305041032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 305041032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play305041033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 1.225

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_2 = arg_134_1:GetWordFromCfg(305041032)
				local var_137_3 = arg_134_1:FormatText(var_137_2.content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 49
				local var_137_5 = utf8.len(var_137_3)
				local var_137_6 = var_137_4 <= 0 and var_137_1 or var_137_1 * (var_137_5 / var_137_4)

				if var_137_6 > 0 and var_137_1 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_7 and arg_134_1.time_ < var_137_0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play305041033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 305041033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
			arg_138_1.auto_ = false
		end

		function arg_138_1.playNext_(arg_140_0)
			arg_138_1.onStoryFinished_()
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 0.275

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[7].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(305041033)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 11
				local var_141_6 = utf8.len(var_141_4)
				local var_141_7 = var_141_5 <= 0 and var_141_1 or var_141_1 * (var_141_6 / var_141_5)

				if var_141_7 > 0 and var_141_1 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_8 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_8 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_8

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_8 and arg_138_1.time_ < var_141_0 + var_141_8 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B14",
		"TextureConfig/Background/S0404"
	},
	voices = {
		"story_v_out_305041.awb"
	}
}
