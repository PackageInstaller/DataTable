return {
	Play116402001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116402001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116402002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I05f"

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
				local var_4_5 = arg_1_1.bgs_.I05f

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
					if iter_4_0 ~= "I05f" then
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

			local var_4_17 = 1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(1, 1, 1)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(1, 1, 1)
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

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_16", "se_story_16_hit02", "")
			end

			local var_4_26 = manager.ui.mainCamera.transform
			local var_4_27 = 0

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_26.localPosition
			end

			local var_4_28 = 2

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				local var_4_29 = (arg_1_1.time_ - var_4_27) / 0.066
				local var_4_30, var_4_31 = math.modf(var_4_29)

				var_4_26.localPosition = Vector3.New(var_4_31 * 0.13, var_4_31 * 0.13, var_4_31 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				var_4_26.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_32 = 0
			local var_4_33 = 0.666666666666667

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_38 = 0.866666666666667
			local var_4_39 = 1.13333333333333

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_40 = "play"
				local var_4_41 = "music"

				arg_1_1:AudioAction(var_4_40, var_4_41, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_42 = ""
				local var_4_43 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_4_43 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_43 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_43

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_43
						arg_1_1.bgmTxt2_.text = var_4_43
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

			local var_4_44 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_45 = 1

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_46 = 2
			local var_4_47 = 1.2

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_48 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_48:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_49 = arg_1_1:GetWordFromCfg(116402001)
				local var_4_50 = arg_1_1:FormatText(var_4_49.content)

				arg_1_1.text_.text = var_4_50

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_51 = 48
				local var_4_52 = utf8.len(var_4_50)
				local var_4_53 = var_4_51 <= 0 and var_4_47 or var_4_47 * (var_4_52 / var_4_51)

				if var_4_53 > 0 and var_4_47 < var_4_53 then
					arg_1_1.talkMaxDuration = var_4_53
					var_4_46 = var_4_46 + 0.3

					if var_4_53 + var_4_46 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_53 + var_4_46
					end
				end

				arg_1_1.text_.text = var_4_50
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_54 = var_4_46 + 0.3
			local var_4_55 = math.max(var_4_47, arg_1_1.talkMaxDuration)

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_55 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_54) / var_4_55

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116402002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116402002
		arg_9_1.duration_ = 9.23

		local var_9_0 = {
			zh = 9.233,
			ja = 4.9
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
				arg_9_0:Play116402003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1028ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1028ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1028ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1028ui_story = var_12_5.localPosition

				local var_12_7 = "1028ui_story"

				arg_9_1:ShowWeapon(arg_9_1.var_[var_12_7 .. "Animator"].transform, true)
			end

			local var_12_8 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_6) / var_12_8
				local var_12_10 = Vector3.New(0, -0.9, -5.9)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1028ui_story, var_12_10, var_12_9)

				local var_12_11 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_11.x, var_12_11.y, var_12_11.z)

				local var_12_12 = var_12_5.localEulerAngles

				var_12_12.z = 0
				var_12_12.x = 0
				var_12_5.localEulerAngles = var_12_12
			end

			if arg_9_1.time_ >= var_12_6 + var_12_8 and arg_9_1.time_ < var_12_6 + var_12_8 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_12_13 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_13.x, var_12_13.y, var_12_13.z)

				local var_12_14 = var_12_5.localEulerAngles

				var_12_14.z = 0
				var_12_14.x = 0
				var_12_5.localEulerAngles = var_12_14
			end

			local var_12_15 = arg_9_1.actors_["1028ui_story"]
			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect1028ui_story == nil then
				arg_9_1.var_.characterEffect1028ui_story = var_12_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_17 = 0.2

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 and not isNil(var_12_15) then
				local var_12_18 = (arg_9_1.time_ - var_12_16) / var_12_17

				if arg_9_1.var_.characterEffect1028ui_story and not isNil(var_12_15) then
					arg_9_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect1028ui_story then
				arg_9_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action2_1")
			end

			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_12_21 = 0
			local var_12_22 = 0.725

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_23 = arg_9_1:FormatText(StoryNameCfg[327].name)

				arg_9_1.leftNameTxt_.text = var_12_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_24 = arg_9_1:GetWordFromCfg(116402002)
				local var_12_25 = arg_9_1:FormatText(var_12_24.content)

				arg_9_1.text_.text = var_12_25

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_26 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_116402", "116402002", "story_v_out_116402.awb") ~= 0 then
					local var_12_29 = manager.audio:GetVoiceLength("story_v_out_116402", "116402002", "story_v_out_116402.awb") / 1000

					if var_12_29 + var_12_21 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_29 + var_12_21
					end

					if var_12_24.prefab_name ~= "" and arg_9_1.actors_[var_12_24.prefab_name] ~= nil then
						local var_12_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_24.prefab_name].transform, "story_v_out_116402", "116402002", "story_v_out_116402.awb")

						arg_9_1:RecordAudio("116402002", var_12_30)
						arg_9_1:RecordAudio("116402002", var_12_30)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_116402", "116402002", "story_v_out_116402.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_116402", "116402002", "story_v_out_116402.awb")
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
				actorName = "1028ui_story",
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
	Play116402003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116402003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play116402004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1028ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1028ui_story = var_16_0.localPosition

				local var_16_2 = "1028ui_story"

				arg_13_1:ShowWeapon(arg_13_1.var_[var_16_2 .. "Animator"].transform, true)
			end

			local var_16_3 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_3 then
				local var_16_4 = (arg_13_1.time_ - var_16_1) / var_16_3
				local var_16_5 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1028ui_story, var_16_5, var_16_4)

				local var_16_6 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_6.x, var_16_6.y, var_16_6.z)

				local var_16_7 = var_16_0.localEulerAngles

				var_16_7.z = 0
				var_16_7.x = 0
				var_16_0.localEulerAngles = var_16_7
			end

			if arg_13_1.time_ >= var_16_1 + var_16_3 and arg_13_1.time_ < var_16_1 + var_16_3 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, 100, 0)

				local var_16_8 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_8.x, var_16_8.y, var_16_8.z)

				local var_16_9 = var_16_0.localEulerAngles

				var_16_9.z = 0
				var_16_9.x = 0
				var_16_0.localEulerAngles = var_16_9
			end

			local var_16_10 = 0.533333333333333
			local var_16_11 = 0.3

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				local var_16_12 = "play"
				local var_16_13 = "effect"

				arg_13_1:AudioAction(var_16_12, var_16_13, "se_story_16", "se_story_16_metal02", "")
			end

			local var_16_14 = 0.566666666666667
			local var_16_15 = 0.266666666666667

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				local var_16_16 = "play"
				local var_16_17 = "effect"

				arg_13_1:AudioAction(var_16_16, var_16_17, "se_story_16", "se_story_16_energy02", "")
			end

			local var_16_18 = manager.ui.mainCamera.transform
			local var_16_19 = 0.533333333333333

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = var_16_18.localPosition
			end

			local var_16_20 = 0.866666666666667

			if var_16_19 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_20 then
				local var_16_21 = (arg_13_1.time_ - var_16_19) / 0.099
				local var_16_22, var_16_23 = math.modf(var_16_21)

				var_16_18.localPosition = Vector3.New(var_16_23 * 0.13, var_16_23 * 0.13, var_16_23 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= var_16_19 + var_16_20 and arg_13_1.time_ < var_16_19 + var_16_20 + arg_16_0 then
				var_16_18.localPosition = arg_13_1.var_.shakeOldPos
			end

			local var_16_24 = 0
			local var_16_25 = 1.4

			if var_16_24 < arg_13_1.time_ and arg_13_1.time_ <= var_16_24 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_26 = arg_13_1:GetWordFromCfg(116402003)
				local var_16_27 = arg_13_1:FormatText(var_16_26.content)

				arg_13_1.text_.text = var_16_27

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_28 = 56
				local var_16_29 = utf8.len(var_16_27)
				local var_16_30 = var_16_28 <= 0 and var_16_25 or var_16_25 * (var_16_29 / var_16_28)

				if var_16_30 > 0 and var_16_25 < var_16_30 then
					arg_13_1.talkMaxDuration = var_16_30

					if var_16_30 + var_16_24 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_30 + var_16_24
					end
				end

				arg_13_1.text_.text = var_16_27
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_31 = math.max(var_16_25, arg_13_1.talkMaxDuration)

			if var_16_24 <= arg_13_1.time_ and arg_13_1.time_ < var_16_24 + var_16_31 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_24) / var_16_31

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_24 + var_16_31 and arg_13_1.time_ < var_16_24 + var_16_31 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play116402004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116402004
		arg_17_1.duration_ = 5.3

		local var_17_0 = {
			zh = 4.333,
			ja = 5.3
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
				arg_17_0:Play116402005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1028ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1028ui_story == nil then
				arg_17_1.var_.characterEffect1028ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1028ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1028ui_story then
				arg_17_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_20_4 = 0

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_20_6 = arg_17_1.actors_["1028ui_story"].transform
			local var_20_7 = 0

			if var_20_7 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 then
				arg_17_1.var_.moveOldPos1028ui_story = var_20_6.localPosition
			end

			local var_20_8 = 0.001

			if var_20_7 <= arg_17_1.time_ and arg_17_1.time_ < var_20_7 + var_20_8 then
				local var_20_9 = (arg_17_1.time_ - var_20_7) / var_20_8
				local var_20_10 = Vector3.New(-0.7, -0.9, -5.9)

				var_20_6.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1028ui_story, var_20_10, var_20_9)

				local var_20_11 = manager.ui.mainCamera.transform.position - var_20_6.position

				var_20_6.forward = Vector3.New(var_20_11.x, var_20_11.y, var_20_11.z)

				local var_20_12 = var_20_6.localEulerAngles

				var_20_12.z = 0
				var_20_12.x = 0
				var_20_6.localEulerAngles = var_20_12
			end

			if arg_17_1.time_ >= var_20_7 + var_20_8 and arg_17_1.time_ < var_20_7 + var_20_8 + arg_20_0 then
				var_20_6.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_20_13 = manager.ui.mainCamera.transform.position - var_20_6.position

				var_20_6.forward = Vector3.New(var_20_13.x, var_20_13.y, var_20_13.z)

				local var_20_14 = var_20_6.localEulerAngles

				var_20_14.z = 0
				var_20_14.x = 0
				var_20_6.localEulerAngles = var_20_14
			end

			local var_20_15 = "1029ui_story"

			if arg_17_1.actors_[var_20_15] == nil then
				local var_20_16 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_20_16) then
					local var_20_17 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_17_1.stage_.transform)

					var_20_17.name = var_20_15
					var_20_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_15] = var_20_17

					local var_20_18 = var_20_17:GetComponentInChildren(typeof(CharacterEffect))

					var_20_18.enabled = true

					local var_20_19 = GameObjectTools.GetOrAddComponent(var_20_17, typeof(DynamicBoneHelper))

					if var_20_19 then
						var_20_19:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_18.transform, false)

					arg_17_1.var_[var_20_15 .. "Animator"] = var_20_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_15 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_15 .. "LipSync"] = var_20_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_20 = arg_17_1.actors_["1029ui_story"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos1029ui_story = var_20_20.localPosition
			end

			local var_20_22 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22
				local var_20_24 = Vector3.New(0.7, -1.09, -6.2)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1029ui_story, var_20_24, var_20_23)

				local var_20_25 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_25.x, var_20_25.y, var_20_25.z)

				local var_20_26 = var_20_20.localEulerAngles

				var_20_26.z = 0
				var_20_26.x = 0
				var_20_20.localEulerAngles = var_20_26
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_20_27 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_27.x, var_20_27.y, var_20_27.z)

				local var_20_28 = var_20_20.localEulerAngles

				var_20_28.z = 0
				var_20_28.x = 0
				var_20_20.localEulerAngles = var_20_28
			end

			local var_20_29 = arg_17_1.actors_["1029ui_story"]
			local var_20_30 = 0

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect1029ui_story == nil then
				arg_17_1.var_.characterEffect1029ui_story = var_20_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_31 = 0.2

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_31 and not isNil(var_20_29) then
				local var_20_32 = (arg_17_1.time_ - var_20_30) / var_20_31

				if arg_17_1.var_.characterEffect1029ui_story and not isNil(var_20_29) then
					local var_20_33 = Mathf.Lerp(0, 0.5, var_20_32)

					arg_17_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1029ui_story.fillRatio = var_20_33
				end
			end

			if arg_17_1.time_ >= var_20_30 + var_20_31 and arg_17_1.time_ < var_20_30 + var_20_31 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect1029ui_story then
				local var_20_34 = 0.5

				arg_17_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1029ui_story.fillRatio = var_20_34
			end

			local var_20_35 = 0

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 then
				arg_17_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_20_36 = 0

			if var_20_36 < arg_17_1.time_ and arg_17_1.time_ <= var_20_36 + arg_20_0 then
				arg_17_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_20_37 = 0
			local var_20_38 = 0.35

			if var_20_37 < arg_17_1.time_ and arg_17_1.time_ <= var_20_37 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_39 = arg_17_1:FormatText(StoryNameCfg[327].name)

				arg_17_1.leftNameTxt_.text = var_20_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_40 = arg_17_1:GetWordFromCfg(116402004)
				local var_20_41 = arg_17_1:FormatText(var_20_40.content)

				arg_17_1.text_.text = var_20_41

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_42 = 14
				local var_20_43 = utf8.len(var_20_41)
				local var_20_44 = var_20_42 <= 0 and var_20_38 or var_20_38 * (var_20_43 / var_20_42)

				if var_20_44 > 0 and var_20_38 < var_20_44 then
					arg_17_1.talkMaxDuration = var_20_44

					if var_20_44 + var_20_37 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_44 + var_20_37
					end
				end

				arg_17_1.text_.text = var_20_41
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116402", "116402004", "story_v_out_116402.awb") ~= 0 then
					local var_20_45 = manager.audio:GetVoiceLength("story_v_out_116402", "116402004", "story_v_out_116402.awb") / 1000

					if var_20_45 + var_20_37 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_45 + var_20_37
					end

					if var_20_40.prefab_name ~= "" and arg_17_1.actors_[var_20_40.prefab_name] ~= nil then
						local var_20_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_40.prefab_name].transform, "story_v_out_116402", "116402004", "story_v_out_116402.awb")

						arg_17_1:RecordAudio("116402004", var_20_46)
						arg_17_1:RecordAudio("116402004", var_20_46)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_116402", "116402004", "story_v_out_116402.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_116402", "116402004", "story_v_out_116402.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_47 = math.max(var_20_38, arg_17_1.talkMaxDuration)

			if var_20_37 <= arg_17_1.time_ and arg_17_1.time_ < var_20_37 + var_20_47 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_37) / var_20_47

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_37 + var_20_47 and arg_17_1.time_ < var_20_37 + var_20_47 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play116402005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116402005
		arg_21_1.duration_ = 4.6

		local var_21_0 = {
			zh = 4.6,
			ja = 3.9
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
				arg_21_0:Play116402006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1028ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1028ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(-0.7, -0.9, -5.9)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1028ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["1029ui_story"].transform
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.var_.moveOldPos1029ui_story = var_24_9.localPosition
			end

			local var_24_11 = 0.001

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11
				local var_24_13 = Vector3.New(0.7, -1.09, -6.2)

				var_24_9.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1029ui_story, var_24_13, var_24_12)

				local var_24_14 = manager.ui.mainCamera.transform.position - var_24_9.position

				var_24_9.forward = Vector3.New(var_24_14.x, var_24_14.y, var_24_14.z)

				local var_24_15 = var_24_9.localEulerAngles

				var_24_15.z = 0
				var_24_15.x = 0
				var_24_9.localEulerAngles = var_24_15
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 then
				var_24_9.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_24_16 = manager.ui.mainCamera.transform.position - var_24_9.position

				var_24_9.forward = Vector3.New(var_24_16.x, var_24_16.y, var_24_16.z)

				local var_24_17 = var_24_9.localEulerAngles

				var_24_17.z = 0
				var_24_17.x = 0
				var_24_9.localEulerAngles = var_24_17
			end

			local var_24_18 = arg_21_1.actors_["1028ui_story"]
			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 and not isNil(var_24_18) and arg_21_1.var_.characterEffect1028ui_story == nil then
				arg_21_1.var_.characterEffect1028ui_story = var_24_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_20 = 0.2

			if var_24_19 <= arg_21_1.time_ and arg_21_1.time_ < var_24_19 + var_24_20 and not isNil(var_24_18) then
				local var_24_21 = (arg_21_1.time_ - var_24_19) / var_24_20

				if arg_21_1.var_.characterEffect1028ui_story and not isNil(var_24_18) then
					local var_24_22 = Mathf.Lerp(0, 0.5, var_24_21)

					arg_21_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1028ui_story.fillRatio = var_24_22
				end
			end

			if arg_21_1.time_ >= var_24_19 + var_24_20 and arg_21_1.time_ < var_24_19 + var_24_20 + arg_24_0 and not isNil(var_24_18) and arg_21_1.var_.characterEffect1028ui_story then
				local var_24_23 = 0.5

				arg_21_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1028ui_story.fillRatio = var_24_23
			end

			local var_24_24 = arg_21_1.actors_["1029ui_story"]
			local var_24_25 = 0

			if var_24_25 < arg_21_1.time_ and arg_21_1.time_ <= var_24_25 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect1029ui_story == nil then
				arg_21_1.var_.characterEffect1029ui_story = var_24_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_26 = 0.2

			if var_24_25 <= arg_21_1.time_ and arg_21_1.time_ < var_24_25 + var_24_26 and not isNil(var_24_24) then
				local var_24_27 = (arg_21_1.time_ - var_24_25) / var_24_26

				if arg_21_1.var_.characterEffect1029ui_story and not isNil(var_24_24) then
					arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_25 + var_24_26 and arg_21_1.time_ < var_24_25 + var_24_26 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect1029ui_story then
				arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_1")
			end

			local var_24_29 = 0

			if var_24_29 < arg_21_1.time_ and arg_21_1.time_ <= var_24_29 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_24_30 = 0
			local var_24_31 = 0.35

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_32 = arg_21_1:FormatText(StoryNameCfg[319].name)

				arg_21_1.leftNameTxt_.text = var_24_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_33 = arg_21_1:GetWordFromCfg(116402005)
				local var_24_34 = arg_21_1:FormatText(var_24_33.content)

				arg_21_1.text_.text = var_24_34

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_35 = 14
				local var_24_36 = utf8.len(var_24_34)
				local var_24_37 = var_24_35 <= 0 and var_24_31 or var_24_31 * (var_24_36 / var_24_35)

				if var_24_37 > 0 and var_24_31 < var_24_37 then
					arg_21_1.talkMaxDuration = var_24_37

					if var_24_37 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_37 + var_24_30
					end
				end

				arg_21_1.text_.text = var_24_34
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116402", "116402005", "story_v_out_116402.awb") ~= 0 then
					local var_24_38 = manager.audio:GetVoiceLength("story_v_out_116402", "116402005", "story_v_out_116402.awb") / 1000

					if var_24_38 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_38 + var_24_30
					end

					if var_24_33.prefab_name ~= "" and arg_21_1.actors_[var_24_33.prefab_name] ~= nil then
						local var_24_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_33.prefab_name].transform, "story_v_out_116402", "116402005", "story_v_out_116402.awb")

						arg_21_1:RecordAudio("116402005", var_24_39)
						arg_21_1:RecordAudio("116402005", var_24_39)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_116402", "116402005", "story_v_out_116402.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_116402", "116402005", "story_v_out_116402.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_40 = math.max(var_24_31, arg_21_1.talkMaxDuration)

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_40 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_30) / var_24_40

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_30 + var_24_40 and arg_21_1.time_ < var_24_30 + var_24_40 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play116402006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116402006
		arg_25_1.duration_ = 18.5

		local var_25_0 = {
			zh = 9.5,
			ja = 18.5
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
				arg_25_0:Play116402007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1028ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1028ui_story = var_28_0.localPosition

				local var_28_2 = "1028ui_story"

				arg_25_1:ShowWeapon(arg_25_1.var_[var_28_2 .. "Animator"].transform, false)
			end

			local var_28_3 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_3 then
				local var_28_4 = (arg_25_1.time_ - var_28_1) / var_28_3
				local var_28_5 = Vector3.New(-0.7, -0.9, -5.9)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1028ui_story, var_28_5, var_28_4)

				local var_28_6 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_6.x, var_28_6.y, var_28_6.z)

				local var_28_7 = var_28_0.localEulerAngles

				var_28_7.z = 0
				var_28_7.x = 0
				var_28_0.localEulerAngles = var_28_7
			end

			if arg_25_1.time_ >= var_28_1 + var_28_3 and arg_25_1.time_ < var_28_1 + var_28_3 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_28_8 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_8.x, var_28_8.y, var_28_8.z)

				local var_28_9 = var_28_0.localEulerAngles

				var_28_9.z = 0
				var_28_9.x = 0
				var_28_0.localEulerAngles = var_28_9
			end

			local var_28_10 = arg_25_1.actors_["1028ui_story"]
			local var_28_11 = 0

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect1028ui_story == nil then
				arg_25_1.var_.characterEffect1028ui_story = var_28_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_12 = 0.2

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_12 and not isNil(var_28_10) then
				local var_28_13 = (arg_25_1.time_ - var_28_11) / var_28_12

				if arg_25_1.var_.characterEffect1028ui_story and not isNil(var_28_10) then
					arg_25_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_11 + var_28_12 and arg_25_1.time_ < var_28_11 + var_28_12 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect1028ui_story then
				arg_25_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_28_14 = arg_25_1.actors_["1029ui_story"]
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1029ui_story == nil then
				arg_25_1.var_.characterEffect1029ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_16 = 0.2

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 and not isNil(var_28_14) then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16

				if arg_25_1.var_.characterEffect1029ui_story and not isNil(var_28_14) then
					local var_28_18 = Mathf.Lerp(0, 0.5, var_28_17)

					arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_18
				end
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1029ui_story then
				local var_28_19 = 0.5

				arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_19
			end

			local var_28_20 = 0

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_1")
			end

			local var_28_21 = 0

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_28_22 = 0
			local var_28_23 = 1.175

			if var_28_22 < arg_25_1.time_ and arg_25_1.time_ <= var_28_22 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_24 = arg_25_1:FormatText(StoryNameCfg[327].name)

				arg_25_1.leftNameTxt_.text = var_28_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_25 = arg_25_1:GetWordFromCfg(116402006)
				local var_28_26 = arg_25_1:FormatText(var_28_25.content)

				arg_25_1.text_.text = var_28_26

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_27 = 47
				local var_28_28 = utf8.len(var_28_26)
				local var_28_29 = var_28_27 <= 0 and var_28_23 or var_28_23 * (var_28_28 / var_28_27)

				if var_28_29 > 0 and var_28_23 < var_28_29 then
					arg_25_1.talkMaxDuration = var_28_29

					if var_28_29 + var_28_22 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_29 + var_28_22
					end
				end

				arg_25_1.text_.text = var_28_26
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116402", "116402006", "story_v_out_116402.awb") ~= 0 then
					local var_28_30 = manager.audio:GetVoiceLength("story_v_out_116402", "116402006", "story_v_out_116402.awb") / 1000

					if var_28_30 + var_28_22 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_30 + var_28_22
					end

					if var_28_25.prefab_name ~= "" and arg_25_1.actors_[var_28_25.prefab_name] ~= nil then
						local var_28_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_25.prefab_name].transform, "story_v_out_116402", "116402006", "story_v_out_116402.awb")

						arg_25_1:RecordAudio("116402006", var_28_31)
						arg_25_1:RecordAudio("116402006", var_28_31)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_116402", "116402006", "story_v_out_116402.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_116402", "116402006", "story_v_out_116402.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_32 = math.max(var_28_23, arg_25_1.talkMaxDuration)

			if var_28_22 <= arg_25_1.time_ and arg_25_1.time_ < var_28_22 + var_28_32 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_22) / var_28_32

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_22 + var_28_32 and arg_25_1.time_ < var_28_22 + var_28_32 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play116402007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116402007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play116402008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1028ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1028ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, 100, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1028ui_story, var_32_4, var_32_3)

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

			local var_32_9 = arg_29_1.actors_["1029ui_story"].transform
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.var_.moveOldPos1029ui_story = var_32_9.localPosition
			end

			local var_32_11 = 0.001

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11
				local var_32_13 = Vector3.New(0, 100, 0)

				var_32_9.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1029ui_story, var_32_13, var_32_12)

				local var_32_14 = manager.ui.mainCamera.transform.position - var_32_9.position

				var_32_9.forward = Vector3.New(var_32_14.x, var_32_14.y, var_32_14.z)

				local var_32_15 = var_32_9.localEulerAngles

				var_32_15.z = 0
				var_32_15.x = 0
				var_32_9.localEulerAngles = var_32_15
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 then
				var_32_9.localPosition = Vector3.New(0, 100, 0)

				local var_32_16 = manager.ui.mainCamera.transform.position - var_32_9.position

				var_32_9.forward = Vector3.New(var_32_16.x, var_32_16.y, var_32_16.z)

				local var_32_17 = var_32_9.localEulerAngles

				var_32_17.z = 0
				var_32_17.x = 0
				var_32_9.localEulerAngles = var_32_17
			end

			local var_32_18 = 0
			local var_32_19 = 0.925

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_20 = arg_29_1:GetWordFromCfg(116402007)
				local var_32_21 = arg_29_1:FormatText(var_32_20.content)

				arg_29_1.text_.text = var_32_21

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_22 = 37
				local var_32_23 = utf8.len(var_32_21)
				local var_32_24 = var_32_22 <= 0 and var_32_19 or var_32_19 * (var_32_23 / var_32_22)

				if var_32_24 > 0 and var_32_19 < var_32_24 then
					arg_29_1.talkMaxDuration = var_32_24

					if var_32_24 + var_32_18 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_18
					end
				end

				arg_29_1.text_.text = var_32_21
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_25 = math.max(var_32_19, arg_29_1.talkMaxDuration)

			if var_32_18 <= arg_29_1.time_ and arg_29_1.time_ < var_32_18 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_18) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_18 + var_32_25 and arg_29_1.time_ < var_32_18 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play116402008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116402008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play116402009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.45

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(116402008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 18
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play116402009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116402009
		arg_37_1.duration_ = 3.17

		local var_37_0 = {
			zh = 2.466,
			ja = 3.166
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
				arg_37_0:Play116402010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1028ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1028ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -0.9, -5.9)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1028ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1028ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1028ui_story == nil then
				arg_37_1.var_.characterEffect1028ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.2

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1028ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1028ui_story then
				arg_37_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_40_15 = 0
			local var_40_16 = 0.225

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[327].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(116402009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_116402", "116402009", "story_v_out_116402.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_116402", "116402009", "story_v_out_116402.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_116402", "116402009", "story_v_out_116402.awb")

						arg_37_1:RecordAudio("116402009", var_40_24)
						arg_37_1:RecordAudio("116402009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_116402", "116402009", "story_v_out_116402.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_116402", "116402009", "story_v_out_116402.awb")
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
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play116402010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116402010
		arg_41_1.duration_ = 2

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play116402011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1028ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1028ui_story == nil then
				arg_41_1.var_.characterEffect1028ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1028ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1028ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1028ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1028ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.2

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[319].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(116402010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_116402", "116402010", "story_v_out_116402.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_116402", "116402010", "story_v_out_116402.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_116402", "116402010", "story_v_out_116402.awb")

						arg_41_1:RecordAudio("116402010", var_44_15)
						arg_41_1:RecordAudio("116402010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_116402", "116402010", "story_v_out_116402.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_116402", "116402010", "story_v_out_116402.awb")
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
	Play116402011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116402011
		arg_45_1.duration_ = 6.5

		local var_45_0 = {
			zh = 6.066,
			ja = 6.5
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
				arg_45_0:Play116402012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.85

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[319].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(116402011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_116402", "116402011", "story_v_out_116402.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_116402", "116402011", "story_v_out_116402.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_116402", "116402011", "story_v_out_116402.awb")

						arg_45_1:RecordAudio("116402011", var_48_9)
						arg_45_1:RecordAudio("116402011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_116402", "116402011", "story_v_out_116402.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_116402", "116402011", "story_v_out_116402.awb")
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
	Play116402012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116402012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play116402013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.925

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

				local var_52_2 = arg_49_1:GetWordFromCfg(116402012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 37
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
	Play116402013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116402013
		arg_53_1.duration_ = 4.43

		local var_53_0 = {
			zh = 4.233,
			ja = 4.433
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play116402014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1028ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1028ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, -0.9, -5.9)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1028ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["1028ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1028ui_story == nil then
				arg_53_1.var_.characterEffect1028ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.2

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 and not isNil(var_56_9) then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect1028ui_story and not isNil(var_56_9) then
					arg_53_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1028ui_story then
				arg_53_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_56_13 = 0

			if var_56_13 < arg_53_1.time_ and arg_53_1.time_ <= var_56_13 + arg_56_0 then
				arg_53_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_1")
			end

			local var_56_14 = 0

			if var_56_14 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_56_15 = 0
			local var_56_16 = 0.4

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[327].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(116402013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 16
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_16 or var_56_16 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_16 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22

					if var_56_22 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116402", "116402013", "story_v_out_116402.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_out_116402", "116402013", "story_v_out_116402.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_out_116402", "116402013", "story_v_out_116402.awb")

						arg_53_1:RecordAudio("116402013", var_56_24)
						arg_53_1:RecordAudio("116402013", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_116402", "116402013", "story_v_out_116402.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_116402", "116402013", "story_v_out_116402.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_25 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_25 and arg_53_1.time_ < var_56_15 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play116402014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116402014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
			arg_57_1.auto_ = false
		end

		function arg_57_1.playNext_(arg_59_0)
			arg_57_1.onStoryFinished_()
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1028ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1028ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, 100, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1028ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, 100, 0)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = 0
			local var_60_10 = 1.225

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_11 = arg_57_1:GetWordFromCfg(116402014)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 49
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_10 or var_60_10 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_10 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_9 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_9
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_10, arg_57_1.talkMaxDuration)

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_9) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_9 + var_60_16 and arg_57_1.time_ < var_60_9 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I05f"
	},
	voices = {
		"story_v_out_116402.awb"
	}
}
