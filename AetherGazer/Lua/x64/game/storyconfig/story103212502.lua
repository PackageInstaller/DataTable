return {
	Play321252001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321252001
		arg_1_1.duration_ = 2.97

		local var_1_0 = {
			zh = 2.8,
			ja = 2.966
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321252002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L12f"

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
				local var_4_5 = arg_1_1.bgs_.L12f

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
					if iter_4_0 ~= "L12f" then
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

			local var_4_30 = 0.3
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily")

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
			local var_4_37 = 0.1

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

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[605].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(321252001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252001", "story_v_out_321252.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_321252", "321252001", "story_v_out_321252.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_321252", "321252001", "story_v_out_321252.awb")

						arg_1_1:RecordAudio("321252001", var_4_46)
						arg_1_1:RecordAudio("321252001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321252", "321252001", "story_v_out_321252.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321252", "321252001", "story_v_out_321252.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play321252002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321252002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321252003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1156ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1156ui_story"]
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1156ui_story == nil then
				arg_9_1.var_.characterEffect1156ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_7 = 0.200000002980232

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 and not isNil(var_12_5) then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7

				if arg_9_1.var_.characterEffect1156ui_story and not isNil(var_12_5) then
					local var_12_9 = Mathf.Lerp(0, 0.5, var_12_8)

					arg_9_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1156ui_story.fillRatio = var_12_9
				end
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1156ui_story then
				local var_12_10 = 0.5

				arg_9_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1156ui_story.fillRatio = var_12_10
			end

			local var_12_11 = 0
			local var_12_12 = 1.475

			if var_12_11 < arg_9_1.time_ and arg_9_1.time_ <= var_12_11 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_13 = arg_9_1:GetWordFromCfg(321252002)
				local var_12_14 = arg_9_1:FormatText(var_12_13.content)

				arg_9_1.text_.text = var_12_14

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 59
				local var_12_16 = utf8.len(var_12_14)
				local var_12_17 = var_12_15 <= 0 and var_12_12 or var_12_12 * (var_12_16 / var_12_15)

				if var_12_17 > 0 and var_12_12 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_11 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_11
					end
				end

				arg_9_1.text_.text = var_12_14
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_12, arg_9_1.talkMaxDuration)

			if var_12_11 <= arg_9_1.time_ and arg_9_1.time_ < var_12_11 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_11) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_11 + var_12_18 and arg_9_1.time_ < var_12_11 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play321252003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321252003
		arg_13_1.duration_ = 2.2

		local var_13_0 = {
			zh = 2.2,
			ja = 1.999999999999
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
				arg_13_0:Play321252004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1156ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1156ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, -1.1, -6.18)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1156ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["1156ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1156ui_story == nil then
				arg_13_1.var_.characterEffect1156ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect1156ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1156ui_story then
				arg_13_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action7_1")
			end

			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_16_15 = 0
			local var_16_16 = 0.15

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[605].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(321252003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 6
				local var_16_21 = utf8.len(var_16_19)
				local var_16_22 = var_16_20 <= 0 and var_16_16 or var_16_16 * (var_16_21 / var_16_20)

				if var_16_22 > 0 and var_16_16 < var_16_22 then
					arg_13_1.talkMaxDuration = var_16_22

					if var_16_22 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_19
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252003", "story_v_out_321252.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_321252", "321252003", "story_v_out_321252.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_321252", "321252003", "story_v_out_321252.awb")

						arg_13_1:RecordAudio("321252003", var_16_24)
						arg_13_1:RecordAudio("321252003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321252", "321252003", "story_v_out_321252.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321252", "321252003", "story_v_out_321252.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_25 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_25 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_25

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_25 and arg_13_1.time_ < var_16_15 + var_16_25 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play321252004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321252004
		arg_17_1.duration_ = 5.53

		local var_17_0 = {
			zh = 4.666,
			ja = 5.533
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
				arg_17_0:Play321252005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1156ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1156ui_story == nil then
				arg_17_1.var_.characterEffect1156ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1156ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1156ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1156ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1156ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.35

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[1180].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(321252004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252004", "story_v_out_321252.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_321252", "321252004", "story_v_out_321252.awb") / 1000

					if var_20_14 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_6
					end

					if var_20_9.prefab_name ~= "" and arg_17_1.actors_[var_20_9.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_9.prefab_name].transform, "story_v_out_321252", "321252004", "story_v_out_321252.awb")

						arg_17_1:RecordAudio("321252004", var_20_15)
						arg_17_1:RecordAudio("321252004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321252", "321252004", "story_v_out_321252.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321252", "321252004", "story_v_out_321252.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_16 and arg_17_1.time_ < var_20_6 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play321252005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321252005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play321252006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1156ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1156ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1156ui_story, var_24_4, var_24_3)

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

			local var_24_9 = 0.433333333333333
			local var_24_10 = 1

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				local var_24_11 = "play"
				local var_24_12 = "effect"

				arg_21_1:AudioAction(var_24_11, var_24_12, "se_story_1310", "se_story_1310_horn", "")
			end

			local var_24_13 = 0
			local var_24_14 = 0.925

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_15 = arg_21_1:GetWordFromCfg(321252005)
				local var_24_16 = arg_21_1:FormatText(var_24_15.content)

				arg_21_1.text_.text = var_24_16

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 37
				local var_24_18 = utf8.len(var_24_16)
				local var_24_19 = var_24_17 <= 0 and var_24_14 or var_24_14 * (var_24_18 / var_24_17)

				if var_24_19 > 0 and var_24_14 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19

					if var_24_19 + var_24_13 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_13
					end
				end

				arg_21_1.text_.text = var_24_16
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_20 = math.max(var_24_14, arg_21_1.talkMaxDuration)

			if var_24_13 <= arg_21_1.time_ and arg_21_1.time_ < var_24_13 + var_24_20 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_13) / var_24_20

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_13 + var_24_20 and arg_21_1.time_ < var_24_13 + var_24_20 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play321252006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321252006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play321252007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 1.675

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(321252006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 67
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321252007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321252007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play321252008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.275

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(321252007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 51
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321252008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321252008
		arg_33_1.duration_ = 8.33

		local var_33_0 = {
			zh = 3.933,
			ja = 8.333
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
				arg_33_0:Play321252009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "404001ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_33_1.stage_.transform)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

					var_36_3.enabled = true

					local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

					if var_36_4 then
						var_36_4:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_3.transform, false)

					arg_33_1.var_[var_36_0 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_0 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_0 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_5 = arg_33_1.actors_["404001ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos404001ui_story = var_36_5.localPosition
			end

			local var_36_7 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7
				local var_36_9 = Vector3.New(0, -1.55, -5.5)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos404001ui_story, var_36_9, var_36_8)

				local var_36_10 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_10.x, var_36_10.y, var_36_10.z)

				local var_36_11 = var_36_5.localEulerAngles

				var_36_11.z = 0
				var_36_11.x = 0
				var_36_5.localEulerAngles = var_36_11
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_36_12 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_12.x, var_36_12.y, var_36_12.z)

				local var_36_13 = var_36_5.localEulerAngles

				var_36_13.z = 0
				var_36_13.x = 0
				var_36_5.localEulerAngles = var_36_13
			end

			local var_36_14 = arg_33_1.actors_["404001ui_story"]
			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect404001ui_story == nil then
				arg_33_1.var_.characterEffect404001ui_story = var_36_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_16 = 0.200000002980232

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_16 and not isNil(var_36_14) then
				local var_36_17 = (arg_33_1.time_ - var_36_15) / var_36_16

				if arg_33_1.var_.characterEffect404001ui_story and not isNil(var_36_14) then
					arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_15 + var_36_16 and arg_33_1.time_ < var_36_15 + var_36_16 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect404001ui_story then
				arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_36_18 = 0

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_36_20 = 0
			local var_36_21 = 0.6

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_22 = arg_33_1:FormatText(StoryNameCfg[668].name)

				arg_33_1.leftNameTxt_.text = var_36_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_23 = arg_33_1:GetWordFromCfg(321252008)
				local var_36_24 = arg_33_1:FormatText(var_36_23.content)

				arg_33_1.text_.text = var_36_24

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_25 = 24
				local var_36_26 = utf8.len(var_36_24)
				local var_36_27 = var_36_25 <= 0 and var_36_21 or var_36_21 * (var_36_26 / var_36_25)

				if var_36_27 > 0 and var_36_21 < var_36_27 then
					arg_33_1.talkMaxDuration = var_36_27

					if var_36_27 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_27 + var_36_20
					end
				end

				arg_33_1.text_.text = var_36_24
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252008", "story_v_out_321252.awb") ~= 0 then
					local var_36_28 = manager.audio:GetVoiceLength("story_v_out_321252", "321252008", "story_v_out_321252.awb") / 1000

					if var_36_28 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_20
					end

					if var_36_23.prefab_name ~= "" and arg_33_1.actors_[var_36_23.prefab_name] ~= nil then
						local var_36_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_23.prefab_name].transform, "story_v_out_321252", "321252008", "story_v_out_321252.awb")

						arg_33_1:RecordAudio("321252008", var_36_29)
						arg_33_1:RecordAudio("321252008", var_36_29)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321252", "321252008", "story_v_out_321252.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321252", "321252008", "story_v_out_321252.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_30 = math.max(var_36_21, arg_33_1.talkMaxDuration)

			if var_36_20 <= arg_33_1.time_ and arg_33_1.time_ < var_36_20 + var_36_30 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_20) / var_36_30

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_20 + var_36_30 and arg_33_1.time_ < var_36_20 + var_36_30 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play321252009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321252009
		arg_37_1.duration_ = 14.6

		local var_37_0 = {
			zh = 8.966,
			ja = 14.6
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
				arg_37_0:Play321252010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["404001ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos404001ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, 100, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos404001ui_story, var_40_4, var_40_3)

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

			local var_40_9 = "1211ui_story"

			if arg_37_1.actors_[var_40_9] == nil then
				local var_40_10 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_40_10) then
					local var_40_11 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_37_1.stage_.transform)

					var_40_11.name = var_40_9
					var_40_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_37_1.actors_[var_40_9] = var_40_11

					local var_40_12 = var_40_11:GetComponentInChildren(typeof(CharacterEffect))

					var_40_12.enabled = true

					local var_40_13 = GameObjectTools.GetOrAddComponent(var_40_11, typeof(DynamicBoneHelper))

					if var_40_13 then
						var_40_13:EnableDynamicBone(false)
					end

					arg_37_1:ShowWeapon(var_40_12.transform, false)

					arg_37_1.var_[var_40_9 .. "Animator"] = var_40_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_37_1.var_[var_40_9 .. "Animator"].applyRootMotion = true
					arg_37_1.var_[var_40_9 .. "LipSync"] = var_40_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_40_14 = arg_37_1.actors_["1211ui_story"].transform
			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.var_.moveOldPos1211ui_story = var_40_14.localPosition

				local var_40_16 = "1211ui_story"

				arg_37_1:ShowWeapon(arg_37_1.var_[var_40_16 .. "Animator"].transform, false)
			end

			local var_40_17 = 0.001

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_17 then
				local var_40_18 = (arg_37_1.time_ - var_40_15) / var_40_17
				local var_40_19 = Vector3.New(0, -0.67, -6.07)

				var_40_14.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1211ui_story, var_40_19, var_40_18)

				local var_40_20 = manager.ui.mainCamera.transform.position - var_40_14.position

				var_40_14.forward = Vector3.New(var_40_20.x, var_40_20.y, var_40_20.z)

				local var_40_21 = var_40_14.localEulerAngles

				var_40_21.z = 0
				var_40_21.x = 0
				var_40_14.localEulerAngles = var_40_21
			end

			if arg_37_1.time_ >= var_40_15 + var_40_17 and arg_37_1.time_ < var_40_15 + var_40_17 + arg_40_0 then
				var_40_14.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_40_22 = manager.ui.mainCamera.transform.position - var_40_14.position

				var_40_14.forward = Vector3.New(var_40_22.x, var_40_22.y, var_40_22.z)

				local var_40_23 = var_40_14.localEulerAngles

				var_40_23.z = 0
				var_40_23.x = 0
				var_40_14.localEulerAngles = var_40_23
			end

			local var_40_24 = arg_37_1.actors_["1211ui_story"]
			local var_40_25 = 0

			if var_40_25 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 and not isNil(var_40_24) and arg_37_1.var_.characterEffect1211ui_story == nil then
				arg_37_1.var_.characterEffect1211ui_story = var_40_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_26 = 0.200000002980232

			if var_40_25 <= arg_37_1.time_ and arg_37_1.time_ < var_40_25 + var_40_26 and not isNil(var_40_24) then
				local var_40_27 = (arg_37_1.time_ - var_40_25) / var_40_26

				if arg_37_1.var_.characterEffect1211ui_story and not isNil(var_40_24) then
					arg_37_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_25 + var_40_26 and arg_37_1.time_ < var_40_25 + var_40_26 + arg_40_0 and not isNil(var_40_24) and arg_37_1.var_.characterEffect1211ui_story then
				arg_37_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_40_28 = arg_37_1.actors_["404001ui_story"]
			local var_40_29 = 0

			if var_40_29 < arg_37_1.time_ and arg_37_1.time_ <= var_40_29 + arg_40_0 and not isNil(var_40_28) and arg_37_1.var_.characterEffect404001ui_story == nil then
				arg_37_1.var_.characterEffect404001ui_story = var_40_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_30 = 0.200000002980232

			if var_40_29 <= arg_37_1.time_ and arg_37_1.time_ < var_40_29 + var_40_30 and not isNil(var_40_28) then
				local var_40_31 = (arg_37_1.time_ - var_40_29) / var_40_30

				if arg_37_1.var_.characterEffect404001ui_story and not isNil(var_40_28) then
					local var_40_32 = Mathf.Lerp(0, 0.5, var_40_31)

					arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_37_1.var_.characterEffect404001ui_story.fillRatio = var_40_32
				end
			end

			if arg_37_1.time_ >= var_40_29 + var_40_30 and arg_37_1.time_ < var_40_29 + var_40_30 + arg_40_0 and not isNil(var_40_28) and arg_37_1.var_.characterEffect404001ui_story then
				local var_40_33 = 0.5

				arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_37_1.var_.characterEffect404001ui_story.fillRatio = var_40_33
			end

			local var_40_34 = 0

			if var_40_34 < arg_37_1.time_ and arg_37_1.time_ <= var_40_34 + arg_40_0 then
				arg_37_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_40_35 = 0

			if var_40_35 < arg_37_1.time_ and arg_37_1.time_ <= var_40_35 + arg_40_0 then
				arg_37_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_40_36 = 0
			local var_40_37 = 1.025

			if var_40_36 < arg_37_1.time_ and arg_37_1.time_ <= var_40_36 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_38 = arg_37_1:FormatText(StoryNameCfg[37].name)

				arg_37_1.leftNameTxt_.text = var_40_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_39 = arg_37_1:GetWordFromCfg(321252009)
				local var_40_40 = arg_37_1:FormatText(var_40_39.content)

				arg_37_1.text_.text = var_40_40

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_41 = 41
				local var_40_42 = utf8.len(var_40_40)
				local var_40_43 = var_40_41 <= 0 and var_40_37 or var_40_37 * (var_40_42 / var_40_41)

				if var_40_43 > 0 and var_40_37 < var_40_43 then
					arg_37_1.talkMaxDuration = var_40_43

					if var_40_43 + var_40_36 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_43 + var_40_36
					end
				end

				arg_37_1.text_.text = var_40_40
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252009", "story_v_out_321252.awb") ~= 0 then
					local var_40_44 = manager.audio:GetVoiceLength("story_v_out_321252", "321252009", "story_v_out_321252.awb") / 1000

					if var_40_44 + var_40_36 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_44 + var_40_36
					end

					if var_40_39.prefab_name ~= "" and arg_37_1.actors_[var_40_39.prefab_name] ~= nil then
						local var_40_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_39.prefab_name].transform, "story_v_out_321252", "321252009", "story_v_out_321252.awb")

						arg_37_1:RecordAudio("321252009", var_40_45)
						arg_37_1:RecordAudio("321252009", var_40_45)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321252", "321252009", "story_v_out_321252.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321252", "321252009", "story_v_out_321252.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_46 = math.max(var_40_37, arg_37_1.talkMaxDuration)

			if var_40_36 <= arg_37_1.time_ and arg_37_1.time_ < var_40_36 + var_40_46 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_36) / var_40_46

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_36 + var_40_46 and arg_37_1.time_ < var_40_36 + var_40_46 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play321252010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321252010
		arg_41_1.duration_ = 5.17

		local var_41_0 = {
			zh = 4.133,
			ja = 5.166
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
				arg_41_0:Play321252011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1156ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1156ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1156ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1211ui_story"].transform
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.var_.moveOldPos1211ui_story = var_44_9.localPosition
			end

			local var_44_11 = 0.001

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11
				local var_44_13 = Vector3.New(0.7, -0.67, -6.07)

				var_44_9.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1211ui_story, var_44_13, var_44_12)

				local var_44_14 = manager.ui.mainCamera.transform.position - var_44_9.position

				var_44_9.forward = Vector3.New(var_44_14.x, var_44_14.y, var_44_14.z)

				local var_44_15 = var_44_9.localEulerAngles

				var_44_15.z = 0
				var_44_15.x = 0
				var_44_9.localEulerAngles = var_44_15
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 then
				var_44_9.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_44_16 = manager.ui.mainCamera.transform.position - var_44_9.position

				var_44_9.forward = Vector3.New(var_44_16.x, var_44_16.y, var_44_16.z)

				local var_44_17 = var_44_9.localEulerAngles

				var_44_17.z = 0
				var_44_17.x = 0
				var_44_9.localEulerAngles = var_44_17
			end

			local var_44_18 = arg_41_1.actors_["1156ui_story"]
			local var_44_19 = 0

			if var_44_19 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 and not isNil(var_44_18) and arg_41_1.var_.characterEffect1156ui_story == nil then
				arg_41_1.var_.characterEffect1156ui_story = var_44_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_20 = 0.200000002980232

			if var_44_19 <= arg_41_1.time_ and arg_41_1.time_ < var_44_19 + var_44_20 and not isNil(var_44_18) then
				local var_44_21 = (arg_41_1.time_ - var_44_19) / var_44_20

				if arg_41_1.var_.characterEffect1156ui_story and not isNil(var_44_18) then
					arg_41_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_19 + var_44_20 and arg_41_1.time_ < var_44_19 + var_44_20 + arg_44_0 and not isNil(var_44_18) and arg_41_1.var_.characterEffect1156ui_story then
				arg_41_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_44_22 = 0

			if var_44_22 < arg_41_1.time_ and arg_41_1.time_ <= var_44_22 + arg_44_0 then
				arg_41_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action7_2")
			end

			local var_44_23 = 0

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_44_24 = arg_41_1.actors_["1211ui_story"]
			local var_44_25 = 0

			if var_44_25 < arg_41_1.time_ and arg_41_1.time_ <= var_44_25 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect1211ui_story == nil then
				arg_41_1.var_.characterEffect1211ui_story = var_44_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_26 = 0.200000002980232

			if var_44_25 <= arg_41_1.time_ and arg_41_1.time_ < var_44_25 + var_44_26 and not isNil(var_44_24) then
				local var_44_27 = (arg_41_1.time_ - var_44_25) / var_44_26

				if arg_41_1.var_.characterEffect1211ui_story and not isNil(var_44_24) then
					local var_44_28 = Mathf.Lerp(0, 0.5, var_44_27)

					arg_41_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1211ui_story.fillRatio = var_44_28
				end
			end

			if arg_41_1.time_ >= var_44_25 + var_44_26 and arg_41_1.time_ < var_44_25 + var_44_26 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect1211ui_story then
				local var_44_29 = 0.5

				arg_41_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1211ui_story.fillRatio = var_44_29
			end

			local var_44_30 = 0
			local var_44_31 = 0.375

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[605].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(321252010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 15
				local var_44_36 = utf8.len(var_44_34)
				local var_44_37 = var_44_35 <= 0 and var_44_31 or var_44_31 * (var_44_36 / var_44_35)

				if var_44_37 > 0 and var_44_31 < var_44_37 then
					arg_41_1.talkMaxDuration = var_44_37

					if var_44_37 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_37 + var_44_30
					end
				end

				arg_41_1.text_.text = var_44_34
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252010", "story_v_out_321252.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_321252", "321252010", "story_v_out_321252.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_321252", "321252010", "story_v_out_321252.awb")

						arg_41_1:RecordAudio("321252010", var_44_39)
						arg_41_1:RecordAudio("321252010", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321252", "321252010", "story_v_out_321252.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321252", "321252010", "story_v_out_321252.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_40 = math.max(var_44_31, arg_41_1.talkMaxDuration)

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_40 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_30) / var_44_40

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_30 + var_44_40 and arg_41_1.time_ < var_44_30 + var_44_40 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play321252011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321252011
		arg_45_1.duration_ = 3.87

		local var_45_0 = {
			zh = 2.1,
			ja = 3.866
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
				arg_45_0:Play321252012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1211ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1211ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0.7, -0.67, -6.07)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1211ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1156ui_story"].transform
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.var_.moveOldPos1156ui_story = var_48_9.localPosition
			end

			local var_48_11 = 0.001

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11
				local var_48_13 = Vector3.New(-0.9, -1.1, -6.18)

				var_48_9.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1156ui_story, var_48_13, var_48_12)

				local var_48_14 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_14.x, var_48_14.y, var_48_14.z)

				local var_48_15 = var_48_9.localEulerAngles

				var_48_15.z = 0
				var_48_15.x = 0
				var_48_9.localEulerAngles = var_48_15
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 then
				var_48_9.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_48_16 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_16.x, var_48_16.y, var_48_16.z)

				local var_48_17 = var_48_9.localEulerAngles

				var_48_17.z = 0
				var_48_17.x = 0
				var_48_9.localEulerAngles = var_48_17
			end

			local var_48_18 = arg_45_1.actors_["1156ui_story"]
			local var_48_19 = 0

			if var_48_19 < arg_45_1.time_ and arg_45_1.time_ <= var_48_19 + arg_48_0 and not isNil(var_48_18) and arg_45_1.var_.characterEffect1156ui_story == nil then
				arg_45_1.var_.characterEffect1156ui_story = var_48_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_20 = 0.200000002980232

			if var_48_19 <= arg_45_1.time_ and arg_45_1.time_ < var_48_19 + var_48_20 and not isNil(var_48_18) then
				local var_48_21 = (arg_45_1.time_ - var_48_19) / var_48_20

				if arg_45_1.var_.characterEffect1156ui_story and not isNil(var_48_18) then
					local var_48_22 = Mathf.Lerp(0, 0.5, var_48_21)

					arg_45_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1156ui_story.fillRatio = var_48_22
				end
			end

			if arg_45_1.time_ >= var_48_19 + var_48_20 and arg_45_1.time_ < var_48_19 + var_48_20 + arg_48_0 and not isNil(var_48_18) and arg_45_1.var_.characterEffect1156ui_story then
				local var_48_23 = 0.5

				arg_45_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1156ui_story.fillRatio = var_48_23
			end

			local var_48_24 = 0

			if var_48_24 < arg_45_1.time_ and arg_45_1.time_ <= var_48_24 + arg_48_0 then
				arg_45_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211actionlink/1211action436")
			end

			local var_48_25 = 0

			if var_48_25 < arg_45_1.time_ and arg_45_1.time_ <= var_48_25 + arg_48_0 then
				arg_45_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_48_26 = arg_45_1.actors_["1211ui_story"]
			local var_48_27 = 0

			if var_48_27 < arg_45_1.time_ and arg_45_1.time_ <= var_48_27 + arg_48_0 and not isNil(var_48_26) and arg_45_1.var_.characterEffect1211ui_story == nil then
				arg_45_1.var_.characterEffect1211ui_story = var_48_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_28 = 0.200000002980232

			if var_48_27 <= arg_45_1.time_ and arg_45_1.time_ < var_48_27 + var_48_28 and not isNil(var_48_26) then
				local var_48_29 = (arg_45_1.time_ - var_48_27) / var_48_28

				if arg_45_1.var_.characterEffect1211ui_story and not isNil(var_48_26) then
					arg_45_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_27 + var_48_28 and arg_45_1.time_ < var_48_27 + var_48_28 + arg_48_0 and not isNil(var_48_26) and arg_45_1.var_.characterEffect1211ui_story then
				arg_45_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_48_30 = 0
			local var_48_31 = 0.225

			if var_48_30 < arg_45_1.time_ and arg_45_1.time_ <= var_48_30 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_32 = arg_45_1:FormatText(StoryNameCfg[37].name)

				arg_45_1.leftNameTxt_.text = var_48_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_33 = arg_45_1:GetWordFromCfg(321252011)
				local var_48_34 = arg_45_1:FormatText(var_48_33.content)

				arg_45_1.text_.text = var_48_34

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_35 = 9
				local var_48_36 = utf8.len(var_48_34)
				local var_48_37 = var_48_35 <= 0 and var_48_31 or var_48_31 * (var_48_36 / var_48_35)

				if var_48_37 > 0 and var_48_31 < var_48_37 then
					arg_45_1.talkMaxDuration = var_48_37

					if var_48_37 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_37 + var_48_30
					end
				end

				arg_45_1.text_.text = var_48_34
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252011", "story_v_out_321252.awb") ~= 0 then
					local var_48_38 = manager.audio:GetVoiceLength("story_v_out_321252", "321252011", "story_v_out_321252.awb") / 1000

					if var_48_38 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_38 + var_48_30
					end

					if var_48_33.prefab_name ~= "" and arg_45_1.actors_[var_48_33.prefab_name] ~= nil then
						local var_48_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_33.prefab_name].transform, "story_v_out_321252", "321252011", "story_v_out_321252.awb")

						arg_45_1:RecordAudio("321252011", var_48_39)
						arg_45_1:RecordAudio("321252011", var_48_39)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321252", "321252011", "story_v_out_321252.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321252", "321252011", "story_v_out_321252.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_40 = math.max(var_48_31, arg_45_1.talkMaxDuration)

			if var_48_30 <= arg_45_1.time_ and arg_45_1.time_ < var_48_30 + var_48_40 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_30) / var_48_40

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_30 + var_48_40 and arg_45_1.time_ < var_48_30 + var_48_40 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play321252012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321252012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play321252013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1211ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1211ui_story == nil then
				arg_49_1.var_.characterEffect1211ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1211ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1211ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1211ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1211ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.9

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(321252012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 36
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play321252013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321252013
		arg_53_1.duration_ = 7.3

		local var_53_0 = {
			zh = 6.4,
			ja = 7.3
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
				arg_53_0:Play321252014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["404001ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos404001ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, -1.55, -5.5)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos404001ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["1211ui_story"].transform
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.var_.moveOldPos1211ui_story = var_56_9.localPosition
			end

			local var_56_11 = 0.001

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11
				local var_56_13 = Vector3.New(0, 100, 0)

				var_56_9.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1211ui_story, var_56_13, var_56_12)

				local var_56_14 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_14.x, var_56_14.y, var_56_14.z)

				local var_56_15 = var_56_9.localEulerAngles

				var_56_15.z = 0
				var_56_15.x = 0
				var_56_9.localEulerAngles = var_56_15
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 then
				var_56_9.localPosition = Vector3.New(0, 100, 0)

				local var_56_16 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_16.x, var_56_16.y, var_56_16.z)

				local var_56_17 = var_56_9.localEulerAngles

				var_56_17.z = 0
				var_56_17.x = 0
				var_56_9.localEulerAngles = var_56_17
			end

			local var_56_18 = arg_53_1.actors_["404001ui_story"]
			local var_56_19 = 0

			if var_56_19 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 and not isNil(var_56_18) and arg_53_1.var_.characterEffect404001ui_story == nil then
				arg_53_1.var_.characterEffect404001ui_story = var_56_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_20 = 0.200000002980232

			if var_56_19 <= arg_53_1.time_ and arg_53_1.time_ < var_56_19 + var_56_20 and not isNil(var_56_18) then
				local var_56_21 = (arg_53_1.time_ - var_56_19) / var_56_20

				if arg_53_1.var_.characterEffect404001ui_story and not isNil(var_56_18) then
					arg_53_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_19 + var_56_20 and arg_53_1.time_ < var_56_19 + var_56_20 + arg_56_0 and not isNil(var_56_18) and arg_53_1.var_.characterEffect404001ui_story then
				arg_53_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_56_22 = 0

			if var_56_22 < arg_53_1.time_ and arg_53_1.time_ <= var_56_22 + arg_56_0 then
				arg_53_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040actionlink/4040action423")
			end

			local var_56_23 = 0

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_24 = arg_53_1.actors_["1156ui_story"].transform
			local var_56_25 = 0

			if var_56_25 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 then
				arg_53_1.var_.moveOldPos1156ui_story = var_56_24.localPosition
			end

			local var_56_26 = 0.001

			if var_56_25 <= arg_53_1.time_ and arg_53_1.time_ < var_56_25 + var_56_26 then
				local var_56_27 = (arg_53_1.time_ - var_56_25) / var_56_26
				local var_56_28 = Vector3.New(0, 100, 0)

				var_56_24.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1156ui_story, var_56_28, var_56_27)

				local var_56_29 = manager.ui.mainCamera.transform.position - var_56_24.position

				var_56_24.forward = Vector3.New(var_56_29.x, var_56_29.y, var_56_29.z)

				local var_56_30 = var_56_24.localEulerAngles

				var_56_30.z = 0
				var_56_30.x = 0
				var_56_24.localEulerAngles = var_56_30
			end

			if arg_53_1.time_ >= var_56_25 + var_56_26 and arg_53_1.time_ < var_56_25 + var_56_26 + arg_56_0 then
				var_56_24.localPosition = Vector3.New(0, 100, 0)

				local var_56_31 = manager.ui.mainCamera.transform.position - var_56_24.position

				var_56_24.forward = Vector3.New(var_56_31.x, var_56_31.y, var_56_31.z)

				local var_56_32 = var_56_24.localEulerAngles

				var_56_32.z = 0
				var_56_32.x = 0
				var_56_24.localEulerAngles = var_56_32
			end

			local var_56_33 = 0
			local var_56_34 = 0.85

			if var_56_33 < arg_53_1.time_ and arg_53_1.time_ <= var_56_33 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_35 = arg_53_1:FormatText(StoryNameCfg[668].name)

				arg_53_1.leftNameTxt_.text = var_56_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_36 = arg_53_1:GetWordFromCfg(321252013)
				local var_56_37 = arg_53_1:FormatText(var_56_36.content)

				arg_53_1.text_.text = var_56_37

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_38 = 34
				local var_56_39 = utf8.len(var_56_37)
				local var_56_40 = var_56_38 <= 0 and var_56_34 or var_56_34 * (var_56_39 / var_56_38)

				if var_56_40 > 0 and var_56_34 < var_56_40 then
					arg_53_1.talkMaxDuration = var_56_40

					if var_56_40 + var_56_33 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_40 + var_56_33
					end
				end

				arg_53_1.text_.text = var_56_37
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252013", "story_v_out_321252.awb") ~= 0 then
					local var_56_41 = manager.audio:GetVoiceLength("story_v_out_321252", "321252013", "story_v_out_321252.awb") / 1000

					if var_56_41 + var_56_33 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_41 + var_56_33
					end

					if var_56_36.prefab_name ~= "" and arg_53_1.actors_[var_56_36.prefab_name] ~= nil then
						local var_56_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_36.prefab_name].transform, "story_v_out_321252", "321252013", "story_v_out_321252.awb")

						arg_53_1:RecordAudio("321252013", var_56_42)
						arg_53_1:RecordAudio("321252013", var_56_42)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_321252", "321252013", "story_v_out_321252.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_321252", "321252013", "story_v_out_321252.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_43 = math.max(var_56_34, arg_53_1.talkMaxDuration)

			if var_56_33 <= arg_53_1.time_ and arg_53_1.time_ < var_56_33 + var_56_43 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_33) / var_56_43

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_33 + var_56_43 and arg_53_1.time_ < var_56_33 + var_56_43 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play321252014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321252014
		arg_57_1.duration_ = 3.9

		local var_57_0 = {
			zh = 2.566,
			ja = 3.9
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
				arg_57_0:Play321252015(arg_57_1)
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

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[668].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(321252014)
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

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252014", "story_v_out_321252.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_321252", "321252014", "story_v_out_321252.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_321252", "321252014", "story_v_out_321252.awb")

						arg_57_1:RecordAudio("321252014", var_60_9)
						arg_57_1:RecordAudio("321252014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_321252", "321252014", "story_v_out_321252.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_321252", "321252014", "story_v_out_321252.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play321252015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321252015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play321252016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["404001ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect404001ui_story == nil then
				arg_61_1.var_.characterEffect404001ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect404001ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_61_1.var_.characterEffect404001ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect404001ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_61_1.var_.characterEffect404001ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0
			local var_64_7 = 1.225

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(321252015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 49
				local var_64_11 = utf8.len(var_64_9)
				local var_64_12 = var_64_10 <= 0 and var_64_7 or var_64_7 * (var_64_11 / var_64_10)

				if var_64_12 > 0 and var_64_7 < var_64_12 then
					arg_61_1.talkMaxDuration = var_64_12

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_13 and arg_61_1.time_ < var_64_6 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play321252016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321252016
		arg_65_1.duration_ = 2.43

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 2.433
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
				arg_65_0:Play321252017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["404001ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos404001ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, -1.55, -5.5)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos404001ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["404001ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect404001ui_story == nil then
				arg_65_1.var_.characterEffect404001ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect404001ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect404001ui_story then
				arg_65_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_68_15 = 0
			local var_68_16 = 0.175

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[668].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(321252016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 7
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252016", "story_v_out_321252.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_321252", "321252016", "story_v_out_321252.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_321252", "321252016", "story_v_out_321252.awb")

						arg_65_1:RecordAudio("321252016", var_68_24)
						arg_65_1:RecordAudio("321252016", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_321252", "321252016", "story_v_out_321252.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_321252", "321252016", "story_v_out_321252.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play321252017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321252017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play321252018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["404001ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect404001ui_story == nil then
				arg_69_1.var_.characterEffect404001ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect404001ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_69_1.var_.characterEffect404001ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect404001ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_69_1.var_.characterEffect404001ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.6

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

				local var_72_9 = arg_69_1:GetWordFromCfg(321252017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 24
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
	Play321252018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321252018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play321252019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.85

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(321252018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 34
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_8 and arg_73_1.time_ < var_76_0 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play321252019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321252019
		arg_77_1.duration_ = 9.1

		local var_77_0 = {
			zh = 6.666,
			ja = 9.1
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
				arg_77_0:Play321252020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["404001ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect404001ui_story == nil then
				arg_77_1.var_.characterEffect404001ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect404001ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect404001ui_story then
				arg_77_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_80_4 = 0
			local var_80_5 = 1

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_6 = arg_77_1:FormatText(StoryNameCfg[668].name)

				arg_77_1.leftNameTxt_.text = var_80_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(321252019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 40
				local var_80_10 = utf8.len(var_80_8)
				local var_80_11 = var_80_9 <= 0 and var_80_5 or var_80_5 * (var_80_10 / var_80_9)

				if var_80_11 > 0 and var_80_5 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252019", "story_v_out_321252.awb") ~= 0 then
					local var_80_12 = manager.audio:GetVoiceLength("story_v_out_321252", "321252019", "story_v_out_321252.awb") / 1000

					if var_80_12 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_4
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_321252", "321252019", "story_v_out_321252.awb")

						arg_77_1:RecordAudio("321252019", var_80_13)
						arg_77_1:RecordAudio("321252019", var_80_13)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_321252", "321252019", "story_v_out_321252.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_321252", "321252019", "story_v_out_321252.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_14 and arg_77_1.time_ < var_80_4 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play321252020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321252020
		arg_81_1.duration_ = 2.53

		local var_81_0 = {
			zh = 2.533,
			ja = 2.433
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
				arg_81_0:Play321252021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.275

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[668].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(321252020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252020", "story_v_out_321252.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_321252", "321252020", "story_v_out_321252.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_321252", "321252020", "story_v_out_321252.awb")

						arg_81_1:RecordAudio("321252020", var_84_9)
						arg_81_1:RecordAudio("321252020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_321252", "321252020", "story_v_out_321252.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_321252", "321252020", "story_v_out_321252.awb")
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
	Play321252021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321252021
		arg_85_1.duration_ = 6.8

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play321252022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["404001ui_story"].transform
			local var_88_1 = 0.965999998152256

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos404001ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, 100, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos404001ui_story, var_88_4, var_88_3)

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

			local var_88_9 = arg_85_1.actors_["404001ui_story"]
			local var_88_10 = 0.983333333333333

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect404001ui_story == nil then
				arg_85_1.var_.characterEffect404001ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.0166666666666667

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect404001ui_story and not isNil(var_88_9) then
					local var_88_13 = Mathf.Lerp(0, 0.5, var_88_12)

					arg_85_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_85_1.var_.characterEffect404001ui_story.fillRatio = var_88_13
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect404001ui_story then
				local var_88_14 = 0.5

				arg_85_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_85_1.var_.characterEffect404001ui_story.fillRatio = var_88_14
			end

			local var_88_15 = 0

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_16 = 1

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_16 then
				local var_88_17 = (arg_85_1.time_ - var_88_15) / var_88_16
				local var_88_18 = Color.New(0, 0, 0)

				var_88_18.a = Mathf.Lerp(0, 1, var_88_17)
				arg_85_1.mask_.color = var_88_18
			end

			if arg_85_1.time_ >= var_88_15 + var_88_16 and arg_85_1.time_ < var_88_15 + var_88_16 + arg_88_0 then
				local var_88_19 = Color.New(0, 0, 0)

				var_88_19.a = 1
				arg_85_1.mask_.color = var_88_19
			end

			local var_88_20 = 1

			if var_88_20 < arg_85_1.time_ and arg_85_1.time_ <= var_88_20 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_21 = 1

			if var_88_20 <= arg_85_1.time_ and arg_85_1.time_ < var_88_20 + var_88_21 then
				local var_88_22 = (arg_85_1.time_ - var_88_20) / var_88_21
				local var_88_23 = Color.New(0, 0, 0)

				var_88_23.a = Mathf.Lerp(1, 0, var_88_22)
				arg_85_1.mask_.color = var_88_23
			end

			if arg_85_1.time_ >= var_88_20 + var_88_21 and arg_85_1.time_ < var_88_20 + var_88_21 + arg_88_0 then
				local var_88_24 = Color.New(0, 0, 0)
				local var_88_25 = 0

				arg_85_1.mask_.enabled = false
				var_88_24.a = var_88_25
				arg_85_1.mask_.color = var_88_24
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_26 = 1.8
			local var_88_27 = 1.025

			if var_88_26 < arg_85_1.time_ and arg_85_1.time_ <= var_88_26 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_28 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_28:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_29 = arg_85_1:GetWordFromCfg(321252021)
				local var_88_30 = arg_85_1:FormatText(var_88_29.content)

				arg_85_1.text_.text = var_88_30

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_31 = 41
				local var_88_32 = utf8.len(var_88_30)
				local var_88_33 = var_88_31 <= 0 and var_88_27 or var_88_27 * (var_88_32 / var_88_31)

				if var_88_33 > 0 and var_88_27 < var_88_33 then
					arg_85_1.talkMaxDuration = var_88_33
					var_88_26 = var_88_26 + 0.3

					if var_88_33 + var_88_26 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_33 + var_88_26
					end
				end

				arg_85_1.text_.text = var_88_30
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_34 = var_88_26 + 0.3
			local var_88_35 = math.max(var_88_27, arg_85_1.talkMaxDuration)

			if var_88_34 <= arg_85_1.time_ and arg_85_1.time_ < var_88_34 + var_88_35 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_34) / var_88_35

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_34 + var_88_35 and arg_85_1.time_ < var_88_34 + var_88_35 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play321252022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 321252022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play321252023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.275

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_2

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

				local var_94_3 = arg_91_1:GetWordFromCfg(321252022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 11
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_8 and arg_91_1.time_ < var_94_0 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play321252023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321252023
		arg_95_1.duration_ = 14.27

		local var_95_0 = {
			zh = 9.833,
			ja = 14.266
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
				arg_95_0:Play321252024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = "2079ui_story"

			if arg_95_1.actors_[var_98_0] == nil then
				local var_98_1 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_98_1) then
					local var_98_2 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_95_1.stage_.transform)

					var_98_2.name = var_98_0
					var_98_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_95_1.actors_[var_98_0] = var_98_2

					local var_98_3 = var_98_2:GetComponentInChildren(typeof(CharacterEffect))

					var_98_3.enabled = true

					local var_98_4 = GameObjectTools.GetOrAddComponent(var_98_2, typeof(DynamicBoneHelper))

					if var_98_4 then
						var_98_4:EnableDynamicBone(false)
					end

					arg_95_1:ShowWeapon(var_98_3.transform, false)

					arg_95_1.var_[var_98_0 .. "Animator"] = var_98_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_95_1.var_[var_98_0 .. "Animator"].applyRootMotion = true
					arg_95_1.var_[var_98_0 .. "LipSync"] = var_98_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_98_5 = arg_95_1.actors_["2079ui_story"].transform
			local var_98_6 = 0

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.var_.moveOldPos2079ui_story = var_98_5.localPosition
			end

			local var_98_7 = 0.001

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_7 then
				local var_98_8 = (arg_95_1.time_ - var_98_6) / var_98_7
				local var_98_9 = Vector3.New(0, -1.28, -5.6)

				var_98_5.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos2079ui_story, var_98_9, var_98_8)

				local var_98_10 = manager.ui.mainCamera.transform.position - var_98_5.position

				var_98_5.forward = Vector3.New(var_98_10.x, var_98_10.y, var_98_10.z)

				local var_98_11 = var_98_5.localEulerAngles

				var_98_11.z = 0
				var_98_11.x = 0
				var_98_5.localEulerAngles = var_98_11
			end

			if arg_95_1.time_ >= var_98_6 + var_98_7 and arg_95_1.time_ < var_98_6 + var_98_7 + arg_98_0 then
				var_98_5.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_98_12 = manager.ui.mainCamera.transform.position - var_98_5.position

				var_98_5.forward = Vector3.New(var_98_12.x, var_98_12.y, var_98_12.z)

				local var_98_13 = var_98_5.localEulerAngles

				var_98_13.z = 0
				var_98_13.x = 0
				var_98_5.localEulerAngles = var_98_13
			end

			local var_98_14 = arg_95_1.actors_["2079ui_story"]
			local var_98_15 = 0

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 and not isNil(var_98_14) and arg_95_1.var_.characterEffect2079ui_story == nil then
				arg_95_1.var_.characterEffect2079ui_story = var_98_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_16 = 0.200000002980232

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_16 and not isNil(var_98_14) then
				local var_98_17 = (arg_95_1.time_ - var_98_15) / var_98_16

				if arg_95_1.var_.characterEffect2079ui_story and not isNil(var_98_14) then
					arg_95_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_15 + var_98_16 and arg_95_1.time_ < var_98_15 + var_98_16 + arg_98_0 and not isNil(var_98_14) and arg_95_1.var_.characterEffect2079ui_story then
				arg_95_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_98_18 = 0

			if var_98_18 < arg_95_1.time_ and arg_95_1.time_ <= var_98_18 + arg_98_0 then
				arg_95_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_98_19 = 0

			if var_98_19 < arg_95_1.time_ and arg_95_1.time_ <= var_98_19 + arg_98_0 then
				arg_95_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_98_20 = 0
			local var_98_21 = 1.35

			if var_98_20 < arg_95_1.time_ and arg_95_1.time_ <= var_98_20 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_22 = arg_95_1:FormatText(StoryNameCfg[1184].name)

				arg_95_1.leftNameTxt_.text = var_98_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_23 = arg_95_1:GetWordFromCfg(321252023)
				local var_98_24 = arg_95_1:FormatText(var_98_23.content)

				arg_95_1.text_.text = var_98_24

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_25 = 55
				local var_98_26 = utf8.len(var_98_24)
				local var_98_27 = var_98_25 <= 0 and var_98_21 or var_98_21 * (var_98_26 / var_98_25)

				if var_98_27 > 0 and var_98_21 < var_98_27 then
					arg_95_1.talkMaxDuration = var_98_27

					if var_98_27 + var_98_20 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_27 + var_98_20
					end
				end

				arg_95_1.text_.text = var_98_24
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252023", "story_v_out_321252.awb") ~= 0 then
					local var_98_28 = manager.audio:GetVoiceLength("story_v_out_321252", "321252023", "story_v_out_321252.awb") / 1000

					if var_98_28 + var_98_20 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_28 + var_98_20
					end

					if var_98_23.prefab_name ~= "" and arg_95_1.actors_[var_98_23.prefab_name] ~= nil then
						local var_98_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_23.prefab_name].transform, "story_v_out_321252", "321252023", "story_v_out_321252.awb")

						arg_95_1:RecordAudio("321252023", var_98_29)
						arg_95_1:RecordAudio("321252023", var_98_29)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321252", "321252023", "story_v_out_321252.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321252", "321252023", "story_v_out_321252.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_30 = math.max(var_98_21, arg_95_1.talkMaxDuration)

			if var_98_20 <= arg_95_1.time_ and arg_95_1.time_ < var_98_20 + var_98_30 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_20) / var_98_30

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_20 + var_98_30 and arg_95_1.time_ < var_98_20 + var_98_30 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play321252024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321252024
		arg_99_1.duration_ = 13.87

		local var_99_0 = {
			zh = 8.566,
			ja = 13.866
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
				arg_99_0:Play321252025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.175

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[1184].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(321252024)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 47
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252024", "story_v_out_321252.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_321252", "321252024", "story_v_out_321252.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_321252", "321252024", "story_v_out_321252.awb")

						arg_99_1:RecordAudio("321252024", var_102_9)
						arg_99_1:RecordAudio("321252024", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_321252", "321252024", "story_v_out_321252.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_321252", "321252024", "story_v_out_321252.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play321252025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321252025
		arg_103_1.duration_ = 17.5

		local var_103_0 = {
			zh = 9.066,
			ja = 17.5
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play321252026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.175

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[1184].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:GetWordFromCfg(321252025)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 47
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252025", "story_v_out_321252.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_321252", "321252025", "story_v_out_321252.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_321252", "321252025", "story_v_out_321252.awb")

						arg_103_1:RecordAudio("321252025", var_106_9)
						arg_103_1:RecordAudio("321252025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_321252", "321252025", "story_v_out_321252.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_321252", "321252025", "story_v_out_321252.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play321252026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 321252026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play321252027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["2079ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect2079ui_story == nil then
				arg_107_1.var_.characterEffect2079ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect2079ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_107_1.var_.characterEffect2079ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect2079ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_107_1.var_.characterEffect2079ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 0.25

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_8 = arg_107_1:FormatText(StoryNameCfg[7].name)

				arg_107_1.leftNameTxt_.text = var_110_8

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

				local var_110_9 = arg_107_1:GetWordFromCfg(321252026)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 10
				local var_110_12 = utf8.len(var_110_10)
				local var_110_13 = var_110_11 <= 0 and var_110_7 or var_110_7 * (var_110_12 / var_110_11)

				if var_110_13 > 0 and var_110_7 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_10
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play321252027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321252027
		arg_111_1.duration_ = 12

		local var_111_0 = {
			zh = 8.2,
			ja = 12
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
				arg_111_0:Play321252028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["2079ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect2079ui_story == nil then
				arg_111_1.var_.characterEffect2079ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect2079ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect2079ui_story then
				arg_111_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_114_4 = 0
			local var_114_5 = 1.05

			if var_114_4 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_6 = arg_111_1:FormatText(StoryNameCfg[1184].name)

				arg_111_1.leftNameTxt_.text = var_114_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(321252027)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252027", "story_v_out_321252.awb") ~= 0 then
					local var_114_12 = manager.audio:GetVoiceLength("story_v_out_321252", "321252027", "story_v_out_321252.awb") / 1000

					if var_114_12 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_4
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_321252", "321252027", "story_v_out_321252.awb")

						arg_111_1:RecordAudio("321252027", var_114_13)
						arg_111_1:RecordAudio("321252027", var_114_13)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_321252", "321252027", "story_v_out_321252.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_321252", "321252027", "story_v_out_321252.awb")
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
	Play321252028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321252028
		arg_115_1.duration_ = 11.8

		local var_115_0 = {
			zh = 8.6,
			ja = 11.8
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
				arg_115_0:Play321252029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.975

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[1184].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(321252028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 39
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252028", "story_v_out_321252.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_321252", "321252028", "story_v_out_321252.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_321252", "321252028", "story_v_out_321252.awb")

						arg_115_1:RecordAudio("321252028", var_118_9)
						arg_115_1:RecordAudio("321252028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_321252", "321252028", "story_v_out_321252.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_321252", "321252028", "story_v_out_321252.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play321252029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321252029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play321252030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["2079ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect2079ui_story == nil then
				arg_119_1.var_.characterEffect2079ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect2079ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_119_1.var_.characterEffect2079ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect2079ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_119_1.var_.characterEffect2079ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0
			local var_122_7 = 0.875

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_8 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_9 = arg_119_1:GetWordFromCfg(321252029)
				local var_122_10 = arg_119_1:FormatText(var_122_9.content)

				arg_119_1.text_.text = var_122_10

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 35
				local var_122_12 = utf8.len(var_122_10)
				local var_122_13 = var_122_11 <= 0 and var_122_7 or var_122_7 * (var_122_12 / var_122_11)

				if var_122_13 > 0 and var_122_7 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_10
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_14 and arg_119_1.time_ < var_122_6 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play321252030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321252030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play321252031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.225

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[7].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(321252030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 49
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_8 and arg_123_1.time_ < var_126_0 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play321252031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321252031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play321252032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.625

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(321252031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 25
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_8 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_8 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_8

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_8 and arg_127_1.time_ < var_130_0 + var_130_8 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play321252032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321252032
		arg_131_1.duration_ = 9.77

		local var_131_0 = {
			zh = 4.8,
			ja = 9.766
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
				arg_131_0:Play321252033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["2079ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect2079ui_story == nil then
				arg_131_1.var_.characterEffect2079ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect2079ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect2079ui_story then
				arg_131_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_134_4 = 0
			local var_134_5 = 0.65

			if var_134_4 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_6 = arg_131_1:FormatText(StoryNameCfg[1184].name)

				arg_131_1.leftNameTxt_.text = var_134_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_7 = arg_131_1:GetWordFromCfg(321252032)
				local var_134_8 = arg_131_1:FormatText(var_134_7.content)

				arg_131_1.text_.text = var_134_8

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 26
				local var_134_10 = utf8.len(var_134_8)
				local var_134_11 = var_134_9 <= 0 and var_134_5 or var_134_5 * (var_134_10 / var_134_9)

				if var_134_11 > 0 and var_134_5 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_8
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252032", "story_v_out_321252.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_321252", "321252032", "story_v_out_321252.awb") / 1000

					if var_134_12 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_4
					end

					if var_134_7.prefab_name ~= "" and arg_131_1.actors_[var_134_7.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_7.prefab_name].transform, "story_v_out_321252", "321252032", "story_v_out_321252.awb")

						arg_131_1:RecordAudio("321252032", var_134_13)
						arg_131_1:RecordAudio("321252032", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_321252", "321252032", "story_v_out_321252.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_321252", "321252032", "story_v_out_321252.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_14 and arg_131_1.time_ < var_134_4 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play321252033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321252033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play321252034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["2079ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect2079ui_story == nil then
				arg_135_1.var_.characterEffect2079ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect2079ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_135_1.var_.characterEffect2079ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect2079ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_135_1.var_.characterEffect2079ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0
			local var_138_7 = 0.55

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_8 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_9 = arg_135_1:GetWordFromCfg(321252033)
				local var_138_10 = arg_135_1:FormatText(var_138_9.content)

				arg_135_1.text_.text = var_138_10

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 22
				local var_138_12 = utf8.len(var_138_10)
				local var_138_13 = var_138_11 <= 0 and var_138_7 or var_138_7 * (var_138_12 / var_138_11)

				if var_138_13 > 0 and var_138_7 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_10
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_14 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_14 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_14

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_14 and arg_135_1.time_ < var_138_6 + var_138_14 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play321252034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321252034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play321252035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.75

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[7].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(321252034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 30
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play321252035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321252035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321252036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.775

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(321252035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 31
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_8 and arg_143_1.time_ < var_146_0 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play321252036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321252036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play321252037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.45

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(321252036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 18
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321252037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321252037
		arg_151_1.duration_ = 17.13

		local var_151_0 = {
			zh = 16,
			ja = 17.133
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
				arg_151_0:Play321252038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = "STblack"

			if arg_151_1.bgs_[var_154_0] == nil then
				local var_154_1 = Object.Instantiate(arg_151_1.paintGo_)

				var_154_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_154_0)
				var_154_1.name = var_154_0
				var_154_1.transform.parent = arg_151_1.stage_.transform
				var_154_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.bgs_[var_154_0] = var_154_1
			end

			local var_154_2 = 1.93333333333333

			if var_154_2 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				local var_154_3 = manager.ui.mainCamera.transform.localPosition
				local var_154_4 = Vector3.New(0, 0, 10) + Vector3.New(var_154_3.x, var_154_3.y, 0)
				local var_154_5 = arg_151_1.bgs_.STblack

				var_154_5.transform.localPosition = var_154_4
				var_154_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_154_6 = var_154_5:GetComponent("SpriteRenderer")

				if var_154_6 and var_154_6.sprite then
					local var_154_7 = (var_154_5.transform.localPosition - var_154_3).z
					local var_154_8 = manager.ui.mainCameraCom_
					local var_154_9 = 2 * var_154_7 * Mathf.Tan(var_154_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_154_10 = var_154_9 * var_154_8.aspect
					local var_154_11 = var_154_6.sprite.bounds.size.x
					local var_154_12 = var_154_6.sprite.bounds.size.y
					local var_154_13 = var_154_10 / var_154_11
					local var_154_14 = var_154_9 / var_154_12
					local var_154_15 = var_154_14 < var_154_13 and var_154_13 or var_154_14

					var_154_5.transform.localScale = Vector3.New(var_154_15, var_154_15, 0)
				end

				for iter_154_0, iter_154_1 in pairs(arg_151_1.bgs_) do
					if iter_154_0 ~= "STblack" then
						iter_154_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_154_16 = 3.56666666666667

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			local var_154_17 = 0.3

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_18 = 0

			if var_154_18 < arg_151_1.time_ and arg_151_1.time_ <= var_154_18 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_19 = 1.96733333518108

			if var_154_18 <= arg_151_1.time_ and arg_151_1.time_ < var_154_18 + var_154_19 then
				local var_154_20 = (arg_151_1.time_ - var_154_18) / var_154_19
				local var_154_21 = Color.New(0, 0, 0)

				var_154_21.a = Mathf.Lerp(0, 1, var_154_20)
				arg_151_1.mask_.color = var_154_21
			end

			if arg_151_1.time_ >= var_154_18 + var_154_19 and arg_151_1.time_ < var_154_18 + var_154_19 + arg_154_0 then
				local var_154_22 = Color.New(0, 0, 0)

				var_154_22.a = 1
				arg_151_1.mask_.color = var_154_22
			end

			local var_154_23 = 1.96733333518108

			if var_154_23 < arg_151_1.time_ and arg_151_1.time_ <= var_154_23 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_24 = 1.89933333148559

			if var_154_23 <= arg_151_1.time_ and arg_151_1.time_ < var_154_23 + var_154_24 then
				local var_154_25 = (arg_151_1.time_ - var_154_23) / var_154_24
				local var_154_26 = Color.New(0, 0, 0)

				var_154_26.a = Mathf.Lerp(1, 0, var_154_25)
				arg_151_1.mask_.color = var_154_26
			end

			if arg_151_1.time_ >= var_154_23 + var_154_24 and arg_151_1.time_ < var_154_23 + var_154_24 + arg_154_0 then
				local var_154_27 = Color.New(0, 0, 0)
				local var_154_28 = 0

				arg_151_1.mask_.enabled = false
				var_154_27.a = var_154_28
				arg_151_1.mask_.color = var_154_27
			end

			local var_154_29 = arg_151_1.actors_["2079ui_story"].transform
			local var_154_30 = 1.93333333333333

			if var_154_30 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 then
				arg_151_1.var_.moveOldPos2079ui_story = var_154_29.localPosition
			end

			local var_154_31 = 0.001

			if var_154_30 <= arg_151_1.time_ and arg_151_1.time_ < var_154_30 + var_154_31 then
				local var_154_32 = (arg_151_1.time_ - var_154_30) / var_154_31
				local var_154_33 = Vector3.New(0, 100, 0)

				var_154_29.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos2079ui_story, var_154_33, var_154_32)

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
			local var_154_39 = 0.2

			if var_154_38 < arg_151_1.time_ and arg_151_1.time_ <= var_154_38 + arg_154_0 then
				local var_154_40 = "play"
				local var_154_41 = "music"

				arg_151_1:AudioAction(var_154_40, var_154_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_154_42 = ""
				local var_154_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_154_43 ~= "" then
					if arg_151_1.bgmTxt_.text ~= var_154_43 and arg_151_1.bgmTxt_.text ~= "" then
						if arg_151_1.bgmTxt2_.text ~= "" then
							arg_151_1.bgmTxt_.text = arg_151_1.bgmTxt2_.text
						end

						arg_151_1.bgmTxt2_.text = var_154_43

						arg_151_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_151_1.bgmTxt_.text = var_154_43
						arg_151_1.bgmTxt2_.text = var_154_43
					end

					if arg_151_1.bgmTimer then
						arg_151_1.bgmTimer:Stop()

						arg_151_1.bgmTimer = nil
					end

					if arg_151_1.settingData.show_music_name == 1 then
						arg_151_1.musicController:SetSelectedState("show")
						arg_151_1.musicAnimator_:Play("open", 0, 0)

						if arg_151_1.settingData.music_time ~= 0 then
							arg_151_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_151_1.settingData.music_time), function()
								if arg_151_1 == nil or isNil(arg_151_1.bgmTxt_) then
									return
								end

								arg_151_1.musicController:SetSelectedState("hide")
								arg_151_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_44 = 3.7
			local var_154_45 = 1.1

			if var_154_44 < arg_151_1.time_ and arg_151_1.time_ <= var_154_44 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_46 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_46:setOnUpdate(LuaHelper.FloatAction(function(arg_156_0)
					arg_151_1.dialogCg_.alpha = arg_156_0
				end))
				var_154_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_47 = arg_151_1:GetWordFromCfg(321252037)
				local var_154_48 = arg_151_1:FormatText(var_154_47.content)

				arg_151_1.text_.text = var_154_48

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_49 = 44
				local var_154_50 = utf8.len(var_154_48)
				local var_154_51 = var_154_49 <= 0 and var_154_45 or var_154_45 * (var_154_50 / var_154_49)

				if var_154_51 > 0 and var_154_45 < var_154_51 then
					arg_151_1.talkMaxDuration = var_154_51
					var_154_44 = var_154_44 + 0.3

					if var_154_51 + var_154_44 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_51 + var_154_44
					end
				end

				arg_151_1.text_.text = var_154_48
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252037", "story_v_out_321252.awb") ~= 0 then
					local var_154_52 = manager.audio:GetVoiceLength("story_v_out_321252", "321252037", "story_v_out_321252.awb") / 1000

					if var_154_52 + var_154_44 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_52 + var_154_44
					end

					if var_154_47.prefab_name ~= "" and arg_151_1.actors_[var_154_47.prefab_name] ~= nil then
						local var_154_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_47.prefab_name].transform, "story_v_out_321252", "321252037", "story_v_out_321252.awb")

						arg_151_1:RecordAudio("321252037", var_154_53)
						arg_151_1:RecordAudio("321252037", var_154_53)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_321252", "321252037", "story_v_out_321252.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_321252", "321252037", "story_v_out_321252.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_54 = var_154_44 + 0.3
			local var_154_55 = math.max(var_154_45, arg_151_1.talkMaxDuration)

			if var_154_54 <= arg_151_1.time_ and arg_151_1.time_ < var_154_54 + var_154_55 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_54) / var_154_55

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_54 + var_154_55 and arg_151_1.time_ < var_154_54 + var_154_55 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.93333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play321252038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 321252038
		arg_158_1.duration_ = 13.1

		local var_158_0 = {
			zh = 9.533,
			ja = 13.1
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
				arg_158_0:Play321252039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.975

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_2 = arg_158_1:GetWordFromCfg(321252038)
				local var_161_3 = arg_158_1:FormatText(var_161_2.content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 39
				local var_161_5 = utf8.len(var_161_3)
				local var_161_6 = var_161_4 <= 0 and var_161_1 or var_161_1 * (var_161_5 / var_161_4)

				if var_161_6 > 0 and var_161_1 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252038", "story_v_out_321252.awb") ~= 0 then
					local var_161_7 = manager.audio:GetVoiceLength("story_v_out_321252", "321252038", "story_v_out_321252.awb") / 1000

					if var_161_7 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_0
					end

					if var_161_2.prefab_name ~= "" and arg_158_1.actors_[var_161_2.prefab_name] ~= nil then
						local var_161_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_2.prefab_name].transform, "story_v_out_321252", "321252038", "story_v_out_321252.awb")

						arg_158_1:RecordAudio("321252038", var_161_8)
						arg_158_1:RecordAudio("321252038", var_161_8)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_321252", "321252038", "story_v_out_321252.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_321252", "321252038", "story_v_out_321252.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_9 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_9 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_9

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_9 and arg_158_1.time_ < var_161_0 + var_161_9 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play321252039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 321252039
		arg_162_1.duration_ = 17.23

		local var_162_0 = {
			zh = 15.866,
			ja = 17.233
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play321252040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1.325

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

				local var_165_2 = arg_162_1:GetWordFromCfg(321252039)
				local var_165_3 = arg_162_1:FormatText(var_165_2.content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252039", "story_v_out_321252.awb") ~= 0 then
					local var_165_7 = manager.audio:GetVoiceLength("story_v_out_321252", "321252039", "story_v_out_321252.awb") / 1000

					if var_165_7 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_0
					end

					if var_165_2.prefab_name ~= "" and arg_162_1.actors_[var_165_2.prefab_name] ~= nil then
						local var_165_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_2.prefab_name].transform, "story_v_out_321252", "321252039", "story_v_out_321252.awb")

						arg_162_1:RecordAudio("321252039", var_165_8)
						arg_162_1:RecordAudio("321252039", var_165_8)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_321252", "321252039", "story_v_out_321252.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_321252", "321252039", "story_v_out_321252.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_9 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_9 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_9

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_9 and arg_162_1.time_ < var_165_0 + var_165_9 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play321252040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 321252040
		arg_166_1.duration_ = 9.53

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play321252041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.9

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_2 = arg_166_1:GetWordFromCfg(321252040)
				local var_169_3 = arg_166_1:FormatText(var_169_2.content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 36
				local var_169_5 = utf8.len(var_169_3)
				local var_169_6 = var_169_4 <= 0 and var_169_1 or var_169_1 * (var_169_5 / var_169_4)

				if var_169_6 > 0 and var_169_1 < var_169_6 then
					arg_166_1.talkMaxDuration = var_169_6

					if var_169_6 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_6 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252040", "story_v_out_321252.awb") ~= 0 then
					local var_169_7 = manager.audio:GetVoiceLength("story_v_out_321252", "321252040", "story_v_out_321252.awb") / 1000

					if var_169_7 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_0
					end

					if var_169_2.prefab_name ~= "" and arg_166_1.actors_[var_169_2.prefab_name] ~= nil then
						local var_169_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_2.prefab_name].transform, "story_v_out_321252", "321252040", "story_v_out_321252.awb")

						arg_166_1:RecordAudio("321252040", var_169_8)
						arg_166_1:RecordAudio("321252040", var_169_8)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_321252", "321252040", "story_v_out_321252.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_321252", "321252040", "story_v_out_321252.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_9 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_9 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_9

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_9 and arg_166_1.time_ < var_169_0 + var_169_9 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play321252041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 321252041
		arg_170_1.duration_ = 8.57

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play321252042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = "L09h"

			if arg_170_1.bgs_[var_173_0] == nil then
				local var_173_1 = Object.Instantiate(arg_170_1.paintGo_)

				var_173_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_173_0)
				var_173_1.name = var_173_0
				var_173_1.transform.parent = arg_170_1.stage_.transform
				var_173_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.bgs_[var_173_0] = var_173_1
			end

			local var_173_2 = 2

			if var_173_2 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				local var_173_3 = manager.ui.mainCamera.transform.localPosition
				local var_173_4 = Vector3.New(0, 0, 10) + Vector3.New(var_173_3.x, var_173_3.y, 0)
				local var_173_5 = arg_170_1.bgs_.L09h

				var_173_5.transform.localPosition = var_173_4
				var_173_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_173_6 = var_173_5:GetComponent("SpriteRenderer")

				if var_173_6 and var_173_6.sprite then
					local var_173_7 = (var_173_5.transform.localPosition - var_173_3).z
					local var_173_8 = manager.ui.mainCameraCom_
					local var_173_9 = 2 * var_173_7 * Mathf.Tan(var_173_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_173_10 = var_173_9 * var_173_8.aspect
					local var_173_11 = var_173_6.sprite.bounds.size.x
					local var_173_12 = var_173_6.sprite.bounds.size.y
					local var_173_13 = var_173_10 / var_173_11
					local var_173_14 = var_173_9 / var_173_12
					local var_173_15 = var_173_14 < var_173_13 and var_173_13 or var_173_14

					var_173_5.transform.localScale = Vector3.New(var_173_15, var_173_15, 0)
				end

				for iter_173_0, iter_173_1 in pairs(arg_170_1.bgs_) do
					if iter_173_0 ~= "L09h" then
						iter_173_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_173_16 = 4

			if var_173_16 < arg_170_1.time_ and arg_170_1.time_ <= var_173_16 + arg_173_0 then
				arg_170_1.allBtn_.enabled = false
			end

			local var_173_17 = 0.3

			if arg_170_1.time_ >= var_173_16 + var_173_17 and arg_170_1.time_ < var_173_16 + var_173_17 + arg_173_0 then
				arg_170_1.allBtn_.enabled = true
			end

			local var_173_18 = 0

			if var_173_18 < arg_170_1.time_ and arg_170_1.time_ <= var_173_18 + arg_173_0 then
				arg_170_1.mask_.enabled = true
				arg_170_1.mask_.raycastTarget = true

				arg_170_1:SetGaussion(false)
			end

			local var_173_19 = 2

			if var_173_18 <= arg_170_1.time_ and arg_170_1.time_ < var_173_18 + var_173_19 then
				local var_173_20 = (arg_170_1.time_ - var_173_18) / var_173_19
				local var_173_21 = Color.New(0, 0, 0)

				var_173_21.a = Mathf.Lerp(0, 1, var_173_20)
				arg_170_1.mask_.color = var_173_21
			end

			if arg_170_1.time_ >= var_173_18 + var_173_19 and arg_170_1.time_ < var_173_18 + var_173_19 + arg_173_0 then
				local var_173_22 = Color.New(0, 0, 0)

				var_173_22.a = 1
				arg_170_1.mask_.color = var_173_22
			end

			local var_173_23 = 2

			if var_173_23 < arg_170_1.time_ and arg_170_1.time_ <= var_173_23 + arg_173_0 then
				arg_170_1.mask_.enabled = true
				arg_170_1.mask_.raycastTarget = true

				arg_170_1:SetGaussion(false)
			end

			local var_173_24 = 2

			if var_173_23 <= arg_170_1.time_ and arg_170_1.time_ < var_173_23 + var_173_24 then
				local var_173_25 = (arg_170_1.time_ - var_173_23) / var_173_24
				local var_173_26 = Color.New(0, 0, 0)

				var_173_26.a = Mathf.Lerp(1, 0, var_173_25)
				arg_170_1.mask_.color = var_173_26
			end

			if arg_170_1.time_ >= var_173_23 + var_173_24 and arg_170_1.time_ < var_173_23 + var_173_24 + arg_173_0 then
				local var_173_27 = Color.New(0, 0, 0)
				local var_173_28 = 0

				arg_170_1.mask_.enabled = false
				var_173_27.a = var_173_28
				arg_170_1.mask_.color = var_173_27
			end

			local var_173_29 = 0
			local var_173_30 = 0.2

			if var_173_29 < arg_170_1.time_ and arg_170_1.time_ <= var_173_29 + arg_173_0 then
				local var_173_31 = "play"
				local var_173_32 = "music"

				arg_170_1:AudioAction(var_173_31, var_173_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_173_33 = ""
				local var_173_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_173_34 ~= "" then
					if arg_170_1.bgmTxt_.text ~= var_173_34 and arg_170_1.bgmTxt_.text ~= "" then
						if arg_170_1.bgmTxt2_.text ~= "" then
							arg_170_1.bgmTxt_.text = arg_170_1.bgmTxt2_.text
						end

						arg_170_1.bgmTxt2_.text = var_173_34

						arg_170_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_170_1.bgmTxt_.text = var_173_34
						arg_170_1.bgmTxt2_.text = var_173_34
					end

					if arg_170_1.bgmTimer then
						arg_170_1.bgmTimer:Stop()

						arg_170_1.bgmTimer = nil
					end

					if arg_170_1.settingData.show_music_name == 1 then
						arg_170_1.musicController:SetSelectedState("show")
						arg_170_1.musicAnimator_:Play("open", 0, 0)

						if arg_170_1.settingData.music_time ~= 0 then
							arg_170_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_170_1.settingData.music_time), function()
								if arg_170_1 == nil or isNil(arg_170_1.bgmTxt_) then
									return
								end

								arg_170_1.musicController:SetSelectedState("hide")
								arg_170_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_173_35 = 1.86666666666667
			local var_173_36 = 1

			if var_173_35 < arg_170_1.time_ and arg_170_1.time_ <= var_173_35 + arg_173_0 then
				local var_173_37 = "play"
				local var_173_38 = "music"

				arg_170_1:AudioAction(var_173_37, var_173_38, "bgm_activity_4_0_story_shashvat_source", "bgm_activity_4_0_story_shashvat_source", "bgm_activity_4_0_story_shashvat_source.awb")

				local var_173_39 = ""
				local var_173_40 = manager.audio:GetAudioName("bgm_activity_4_0_story_shashvat_source", "bgm_activity_4_0_story_shashvat_source")

				if var_173_40 ~= "" then
					if arg_170_1.bgmTxt_.text ~= var_173_40 and arg_170_1.bgmTxt_.text ~= "" then
						if arg_170_1.bgmTxt2_.text ~= "" then
							arg_170_1.bgmTxt_.text = arg_170_1.bgmTxt2_.text
						end

						arg_170_1.bgmTxt2_.text = var_173_40

						arg_170_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_170_1.bgmTxt_.text = var_173_40
						arg_170_1.bgmTxt2_.text = var_173_40
					end

					if arg_170_1.bgmTimer then
						arg_170_1.bgmTimer:Stop()

						arg_170_1.bgmTimer = nil
					end

					if arg_170_1.settingData.show_music_name == 1 then
						arg_170_1.musicController:SetSelectedState("show")
						arg_170_1.musicAnimator_:Play("open", 0, 0)

						if arg_170_1.settingData.music_time ~= 0 then
							arg_170_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_170_1.settingData.music_time), function()
								if arg_170_1 == nil or isNil(arg_170_1.bgmTxt_) then
									return
								end

								arg_170_1.musicController:SetSelectedState("hide")
								arg_170_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_170_1.frameCnt_ <= 1 then
				arg_170_1.dialog_:SetActive(false)
			end

			local var_173_41 = 3.56666666666667
			local var_173_42 = 1.15

			if var_173_41 < arg_170_1.time_ and arg_170_1.time_ <= var_173_41 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0

				arg_170_1.dialog_:SetActive(true)

				arg_170_1.dialogCg_.alpha = 0

				local var_173_43 = LeanTween.value(arg_170_1.dialog_, 0, 1, 0.3)

				var_173_43:setOnUpdate(LuaHelper.FloatAction(function(arg_176_0)
					arg_170_1.dialogCg_.alpha = arg_176_0
				end))
				var_173_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_170_1.dialog_)
					var_173_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_170_1.duration_ = arg_170_1.duration_ + 0.3

				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_44 = arg_170_1:GetWordFromCfg(321252041)
				local var_173_45 = arg_170_1:FormatText(var_173_44.content)

				arg_170_1.text_.text = var_173_45

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_46 = 46
				local var_173_47 = utf8.len(var_173_45)
				local var_173_48 = var_173_46 <= 0 and var_173_42 or var_173_42 * (var_173_47 / var_173_46)

				if var_173_48 > 0 and var_173_42 < var_173_48 then
					arg_170_1.talkMaxDuration = var_173_48
					var_173_41 = var_173_41 + 0.3

					if var_173_48 + var_173_41 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_48 + var_173_41
					end
				end

				arg_170_1.text_.text = var_173_45
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_49 = var_173_41 + 0.3
			local var_173_50 = math.max(var_173_42, arg_170_1.talkMaxDuration)

			if var_173_49 <= arg_170_1.time_ and arg_170_1.time_ < var_173_49 + var_173_50 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_49) / var_173_50

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_49 + var_173_50 and arg_170_1.time_ < var_173_49 + var_173_50 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play321252042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 321252042
		arg_178_1.duration_ = 7.27

		local var_178_0 = {
			zh = 7.266,
			ja = 6.366
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play321252043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = "1111ui_story"

			if arg_178_1.actors_[var_181_0] == nil then
				local var_181_1 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_181_1) then
					local var_181_2 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_178_1.stage_.transform)

					var_181_2.name = var_181_0
					var_181_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_178_1.actors_[var_181_0] = var_181_2

					local var_181_3 = var_181_2:GetComponentInChildren(typeof(CharacterEffect))

					var_181_3.enabled = true

					local var_181_4 = GameObjectTools.GetOrAddComponent(var_181_2, typeof(DynamicBoneHelper))

					if var_181_4 then
						var_181_4:EnableDynamicBone(false)
					end

					arg_178_1:ShowWeapon(var_181_3.transform, false)

					arg_178_1.var_[var_181_0 .. "Animator"] = var_181_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_178_1.var_[var_181_0 .. "Animator"].applyRootMotion = true
					arg_178_1.var_[var_181_0 .. "LipSync"] = var_181_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_181_5 = arg_178_1.actors_["1111ui_story"].transform
			local var_181_6 = 0

			if var_181_6 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.var_.moveOldPos1111ui_story = var_181_5.localPosition
			end

			local var_181_7 = 0.001

			if var_181_6 <= arg_178_1.time_ and arg_178_1.time_ < var_181_6 + var_181_7 then
				local var_181_8 = (arg_178_1.time_ - var_181_6) / var_181_7
				local var_181_9 = Vector3.New(0, -0.87, -5.7)

				var_181_5.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1111ui_story, var_181_9, var_181_8)

				local var_181_10 = manager.ui.mainCamera.transform.position - var_181_5.position

				var_181_5.forward = Vector3.New(var_181_10.x, var_181_10.y, var_181_10.z)

				local var_181_11 = var_181_5.localEulerAngles

				var_181_11.z = 0
				var_181_11.x = 0
				var_181_5.localEulerAngles = var_181_11
			end

			if arg_178_1.time_ >= var_181_6 + var_181_7 and arg_178_1.time_ < var_181_6 + var_181_7 + arg_181_0 then
				var_181_5.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_181_12 = manager.ui.mainCamera.transform.position - var_181_5.position

				var_181_5.forward = Vector3.New(var_181_12.x, var_181_12.y, var_181_12.z)

				local var_181_13 = var_181_5.localEulerAngles

				var_181_13.z = 0
				var_181_13.x = 0
				var_181_5.localEulerAngles = var_181_13
			end

			local var_181_14 = arg_178_1.actors_["1111ui_story"]
			local var_181_15 = 0

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 and not isNil(var_181_14) and arg_178_1.var_.characterEffect1111ui_story == nil then
				arg_178_1.var_.characterEffect1111ui_story = var_181_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_16 = 0.200000002980232

			if var_181_15 <= arg_178_1.time_ and arg_178_1.time_ < var_181_15 + var_181_16 and not isNil(var_181_14) then
				local var_181_17 = (arg_178_1.time_ - var_181_15) / var_181_16

				if arg_178_1.var_.characterEffect1111ui_story and not isNil(var_181_14) then
					arg_178_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_15 + var_181_16 and arg_178_1.time_ < var_181_15 + var_181_16 + arg_181_0 and not isNil(var_181_14) and arg_178_1.var_.characterEffect1111ui_story then
				arg_178_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_181_18 = 0

			if var_181_18 < arg_178_1.time_ and arg_178_1.time_ <= var_181_18 + arg_181_0 then
				arg_178_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_181_19 = 0

			if var_181_19 < arg_178_1.time_ and arg_178_1.time_ <= var_181_19 + arg_181_0 then
				arg_178_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_181_20 = 0
			local var_181_21 = 0.8

			if var_181_20 < arg_178_1.time_ and arg_178_1.time_ <= var_181_20 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_22 = arg_178_1:FormatText(StoryNameCfg[67].name)

				arg_178_1.leftNameTxt_.text = var_181_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_23 = arg_178_1:GetWordFromCfg(321252042)
				local var_181_24 = arg_178_1:FormatText(var_181_23.content)

				arg_178_1.text_.text = var_181_24

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_25 = 32
				local var_181_26 = utf8.len(var_181_24)
				local var_181_27 = var_181_25 <= 0 and var_181_21 or var_181_21 * (var_181_26 / var_181_25)

				if var_181_27 > 0 and var_181_21 < var_181_27 then
					arg_178_1.talkMaxDuration = var_181_27

					if var_181_27 + var_181_20 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_27 + var_181_20
					end
				end

				arg_178_1.text_.text = var_181_24
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252042", "story_v_out_321252.awb") ~= 0 then
					local var_181_28 = manager.audio:GetVoiceLength("story_v_out_321252", "321252042", "story_v_out_321252.awb") / 1000

					if var_181_28 + var_181_20 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_28 + var_181_20
					end

					if var_181_23.prefab_name ~= "" and arg_178_1.actors_[var_181_23.prefab_name] ~= nil then
						local var_181_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_23.prefab_name].transform, "story_v_out_321252", "321252042", "story_v_out_321252.awb")

						arg_178_1:RecordAudio("321252042", var_181_29)
						arg_178_1:RecordAudio("321252042", var_181_29)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_321252", "321252042", "story_v_out_321252.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_321252", "321252042", "story_v_out_321252.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_30 = math.max(var_181_21, arg_178_1.talkMaxDuration)

			if var_181_20 <= arg_178_1.time_ and arg_178_1.time_ < var_181_20 + var_181_30 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_20) / var_181_30

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_20 + var_181_30 and arg_178_1.time_ < var_181_20 + var_181_30 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play321252043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 321252043
		arg_182_1.duration_ = 9.23

		local var_182_0 = {
			zh = 7.7,
			ja = 9.233
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play321252044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = "10131ui_story"

			if arg_182_1.actors_[var_185_0] == nil then
				local var_185_1 = Asset.Load("Char/" .. "10131ui_story")

				if not isNil(var_185_1) then
					local var_185_2 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_182_1.stage_.transform)

					var_185_2.name = var_185_0
					var_185_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_182_1.actors_[var_185_0] = var_185_2

					local var_185_3 = var_185_2:GetComponentInChildren(typeof(CharacterEffect))

					var_185_3.enabled = true

					local var_185_4 = GameObjectTools.GetOrAddComponent(var_185_2, typeof(DynamicBoneHelper))

					if var_185_4 then
						var_185_4:EnableDynamicBone(false)
					end

					arg_182_1:ShowWeapon(var_185_3.transform, false)

					arg_182_1.var_[var_185_0 .. "Animator"] = var_185_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_182_1.var_[var_185_0 .. "Animator"].applyRootMotion = true
					arg_182_1.var_[var_185_0 .. "LipSync"] = var_185_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_185_5 = arg_182_1.actors_["10131ui_story"].transform
			local var_185_6 = 0

			if var_185_6 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1.var_.moveOldPos10131ui_story = var_185_5.localPosition
			end

			local var_185_7 = 0.001

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_7 then
				local var_185_8 = (arg_182_1.time_ - var_185_6) / var_185_7
				local var_185_9 = Vector3.New(0.83, -0.96, -5.8)

				var_185_5.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10131ui_story, var_185_9, var_185_8)

				local var_185_10 = manager.ui.mainCamera.transform.position - var_185_5.position

				var_185_5.forward = Vector3.New(var_185_10.x, var_185_10.y, var_185_10.z)

				local var_185_11 = var_185_5.localEulerAngles

				var_185_11.z = 0
				var_185_11.x = 0
				var_185_5.localEulerAngles = var_185_11
			end

			if arg_182_1.time_ >= var_185_6 + var_185_7 and arg_182_1.time_ < var_185_6 + var_185_7 + arg_185_0 then
				var_185_5.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_185_12 = manager.ui.mainCamera.transform.position - var_185_5.position

				var_185_5.forward = Vector3.New(var_185_12.x, var_185_12.y, var_185_12.z)

				local var_185_13 = var_185_5.localEulerAngles

				var_185_13.z = 0
				var_185_13.x = 0
				var_185_5.localEulerAngles = var_185_13
			end

			local var_185_14 = arg_182_1.actors_["1111ui_story"].transform
			local var_185_15 = 0

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				arg_182_1.var_.moveOldPos1111ui_story = var_185_14.localPosition
			end

			local var_185_16 = 0.001

			if var_185_15 <= arg_182_1.time_ and arg_182_1.time_ < var_185_15 + var_185_16 then
				local var_185_17 = (arg_182_1.time_ - var_185_15) / var_185_16
				local var_185_18 = Vector3.New(-0.79, -0.87, -5.7)

				var_185_14.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1111ui_story, var_185_18, var_185_17)

				local var_185_19 = manager.ui.mainCamera.transform.position - var_185_14.position

				var_185_14.forward = Vector3.New(var_185_19.x, var_185_19.y, var_185_19.z)

				local var_185_20 = var_185_14.localEulerAngles

				var_185_20.z = 0
				var_185_20.x = 0
				var_185_14.localEulerAngles = var_185_20
			end

			if arg_182_1.time_ >= var_185_15 + var_185_16 and arg_182_1.time_ < var_185_15 + var_185_16 + arg_185_0 then
				var_185_14.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_185_21 = manager.ui.mainCamera.transform.position - var_185_14.position

				var_185_14.forward = Vector3.New(var_185_21.x, var_185_21.y, var_185_21.z)

				local var_185_22 = var_185_14.localEulerAngles

				var_185_22.z = 0
				var_185_22.x = 0
				var_185_14.localEulerAngles = var_185_22
			end

			local var_185_23 = arg_182_1.actors_["10131ui_story"]
			local var_185_24 = 0

			if var_185_24 < arg_182_1.time_ and arg_182_1.time_ <= var_185_24 + arg_185_0 and not isNil(var_185_23) and arg_182_1.var_.characterEffect10131ui_story == nil then
				arg_182_1.var_.characterEffect10131ui_story = var_185_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_25 = 0.200000002980232

			if var_185_24 <= arg_182_1.time_ and arg_182_1.time_ < var_185_24 + var_185_25 and not isNil(var_185_23) then
				local var_185_26 = (arg_182_1.time_ - var_185_24) / var_185_25

				if arg_182_1.var_.characterEffect10131ui_story and not isNil(var_185_23) then
					arg_182_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_24 + var_185_25 and arg_182_1.time_ < var_185_24 + var_185_25 + arg_185_0 and not isNil(var_185_23) and arg_182_1.var_.characterEffect10131ui_story then
				arg_182_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_185_27 = arg_182_1.actors_["1111ui_story"]
			local var_185_28 = 0

			if var_185_28 < arg_182_1.time_ and arg_182_1.time_ <= var_185_28 + arg_185_0 and not isNil(var_185_27) and arg_182_1.var_.characterEffect1111ui_story == nil then
				arg_182_1.var_.characterEffect1111ui_story = var_185_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_29 = 0.200000002980232

			if var_185_28 <= arg_182_1.time_ and arg_182_1.time_ < var_185_28 + var_185_29 and not isNil(var_185_27) then
				local var_185_30 = (arg_182_1.time_ - var_185_28) / var_185_29

				if arg_182_1.var_.characterEffect1111ui_story and not isNil(var_185_27) then
					local var_185_31 = Mathf.Lerp(0, 0.5, var_185_30)

					arg_182_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1111ui_story.fillRatio = var_185_31
				end
			end

			if arg_182_1.time_ >= var_185_28 + var_185_29 and arg_182_1.time_ < var_185_28 + var_185_29 + arg_185_0 and not isNil(var_185_27) and arg_182_1.var_.characterEffect1111ui_story then
				local var_185_32 = 0.5

				arg_182_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1111ui_story.fillRatio = var_185_32
			end

			local var_185_33 = 0

			if var_185_33 < arg_182_1.time_ and arg_182_1.time_ <= var_185_33 + arg_185_0 then
				arg_182_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_185_34 = 0

			if var_185_34 < arg_182_1.time_ and arg_182_1.time_ <= var_185_34 + arg_185_0 then
				arg_182_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_185_35 = 0
			local var_185_36 = 0.8

			if var_185_35 < arg_182_1.time_ and arg_182_1.time_ <= var_185_35 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_37 = arg_182_1:FormatText(StoryNameCfg[1178].name)

				arg_182_1.leftNameTxt_.text = var_185_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_38 = arg_182_1:GetWordFromCfg(321252043)
				local var_185_39 = arg_182_1:FormatText(var_185_38.content)

				arg_182_1.text_.text = var_185_39

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_40 = 32
				local var_185_41 = utf8.len(var_185_39)
				local var_185_42 = var_185_40 <= 0 and var_185_36 or var_185_36 * (var_185_41 / var_185_40)

				if var_185_42 > 0 and var_185_36 < var_185_42 then
					arg_182_1.talkMaxDuration = var_185_42

					if var_185_42 + var_185_35 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_42 + var_185_35
					end
				end

				arg_182_1.text_.text = var_185_39
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252043", "story_v_out_321252.awb") ~= 0 then
					local var_185_43 = manager.audio:GetVoiceLength("story_v_out_321252", "321252043", "story_v_out_321252.awb") / 1000

					if var_185_43 + var_185_35 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_43 + var_185_35
					end

					if var_185_38.prefab_name ~= "" and arg_182_1.actors_[var_185_38.prefab_name] ~= nil then
						local var_185_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_38.prefab_name].transform, "story_v_out_321252", "321252043", "story_v_out_321252.awb")

						arg_182_1:RecordAudio("321252043", var_185_44)
						arg_182_1:RecordAudio("321252043", var_185_44)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_321252", "321252043", "story_v_out_321252.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_321252", "321252043", "story_v_out_321252.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_45 = math.max(var_185_36, arg_182_1.talkMaxDuration)

			if var_185_35 <= arg_182_1.time_ and arg_182_1.time_ < var_185_35 + var_185_45 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_35) / var_185_45

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_35 + var_185_45 and arg_182_1.time_ < var_185_35 + var_185_45 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play321252044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 321252044
		arg_186_1.duration_ = 5.17

		local var_186_0 = {
			zh = 4.933,
			ja = 5.166
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play321252045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1111ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1111ui_story == nil then
				arg_186_1.var_.characterEffect1111ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1111ui_story and not isNil(var_189_0) then
					arg_186_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1111ui_story then
				arg_186_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_189_4 = arg_186_1.actors_["10131ui_story"]
			local var_189_5 = 0

			if var_189_5 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 and not isNil(var_189_4) and arg_186_1.var_.characterEffect10131ui_story == nil then
				arg_186_1.var_.characterEffect10131ui_story = var_189_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_6 = 0.200000002980232

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_6 and not isNil(var_189_4) then
				local var_189_7 = (arg_186_1.time_ - var_189_5) / var_189_6

				if arg_186_1.var_.characterEffect10131ui_story and not isNil(var_189_4) then
					local var_189_8 = Mathf.Lerp(0, 0.5, var_189_7)

					arg_186_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_186_1.var_.characterEffect10131ui_story.fillRatio = var_189_8
				end
			end

			if arg_186_1.time_ >= var_189_5 + var_189_6 and arg_186_1.time_ < var_189_5 + var_189_6 + arg_189_0 and not isNil(var_189_4) and arg_186_1.var_.characterEffect10131ui_story then
				local var_189_9 = 0.5

				arg_186_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_186_1.var_.characterEffect10131ui_story.fillRatio = var_189_9
			end

			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 then
				arg_186_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_189_11 = 0
			local var_189_12 = 0.525

			if var_189_11 < arg_186_1.time_ and arg_186_1.time_ <= var_189_11 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_13 = arg_186_1:FormatText(StoryNameCfg[67].name)

				arg_186_1.leftNameTxt_.text = var_189_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_14 = arg_186_1:GetWordFromCfg(321252044)
				local var_189_15 = arg_186_1:FormatText(var_189_14.content)

				arg_186_1.text_.text = var_189_15

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_16 = 21
				local var_189_17 = utf8.len(var_189_15)
				local var_189_18 = var_189_16 <= 0 and var_189_12 or var_189_12 * (var_189_17 / var_189_16)

				if var_189_18 > 0 and var_189_12 < var_189_18 then
					arg_186_1.talkMaxDuration = var_189_18

					if var_189_18 + var_189_11 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_18 + var_189_11
					end
				end

				arg_186_1.text_.text = var_189_15
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252044", "story_v_out_321252.awb") ~= 0 then
					local var_189_19 = manager.audio:GetVoiceLength("story_v_out_321252", "321252044", "story_v_out_321252.awb") / 1000

					if var_189_19 + var_189_11 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_19 + var_189_11
					end

					if var_189_14.prefab_name ~= "" and arg_186_1.actors_[var_189_14.prefab_name] ~= nil then
						local var_189_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_14.prefab_name].transform, "story_v_out_321252", "321252044", "story_v_out_321252.awb")

						arg_186_1:RecordAudio("321252044", var_189_20)
						arg_186_1:RecordAudio("321252044", var_189_20)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_321252", "321252044", "story_v_out_321252.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_321252", "321252044", "story_v_out_321252.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_21 = math.max(var_189_12, arg_186_1.talkMaxDuration)

			if var_189_11 <= arg_186_1.time_ and arg_186_1.time_ < var_189_11 + var_189_21 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_11) / var_189_21

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_11 + var_189_21 and arg_186_1.time_ < var_189_11 + var_189_21 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play321252045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 321252045
		arg_190_1.duration_ = 9.03

		local var_190_0 = {
			zh = 8.766,
			ja = 9.033
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play321252046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["10131ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect10131ui_story == nil then
				arg_190_1.var_.characterEffect10131ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect10131ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect10131ui_story then
				arg_190_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_193_4 = arg_190_1.actors_["1111ui_story"]
			local var_193_5 = 0

			if var_193_5 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect1111ui_story == nil then
				arg_190_1.var_.characterEffect1111ui_story = var_193_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_6 = 0.200000002980232

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_6 and not isNil(var_193_4) then
				local var_193_7 = (arg_190_1.time_ - var_193_5) / var_193_6

				if arg_190_1.var_.characterEffect1111ui_story and not isNil(var_193_4) then
					local var_193_8 = Mathf.Lerp(0, 0.5, var_193_7)

					arg_190_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1111ui_story.fillRatio = var_193_8
				end
			end

			if arg_190_1.time_ >= var_193_5 + var_193_6 and arg_190_1.time_ < var_193_5 + var_193_6 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect1111ui_story then
				local var_193_9 = 0.5

				arg_190_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1111ui_story.fillRatio = var_193_9
			end

			local var_193_10 = 0
			local var_193_11 = 1.125

			if var_193_10 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_12 = arg_190_1:FormatText(StoryNameCfg[1178].name)

				arg_190_1.leftNameTxt_.text = var_193_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_13 = arg_190_1:GetWordFromCfg(321252045)
				local var_193_14 = arg_190_1:FormatText(var_193_13.content)

				arg_190_1.text_.text = var_193_14

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_15 = 45
				local var_193_16 = utf8.len(var_193_14)
				local var_193_17 = var_193_15 <= 0 and var_193_11 or var_193_11 * (var_193_16 / var_193_15)

				if var_193_17 > 0 and var_193_11 < var_193_17 then
					arg_190_1.talkMaxDuration = var_193_17

					if var_193_17 + var_193_10 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_17 + var_193_10
					end
				end

				arg_190_1.text_.text = var_193_14
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252045", "story_v_out_321252.awb") ~= 0 then
					local var_193_18 = manager.audio:GetVoiceLength("story_v_out_321252", "321252045", "story_v_out_321252.awb") / 1000

					if var_193_18 + var_193_10 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_18 + var_193_10
					end

					if var_193_13.prefab_name ~= "" and arg_190_1.actors_[var_193_13.prefab_name] ~= nil then
						local var_193_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_13.prefab_name].transform, "story_v_out_321252", "321252045", "story_v_out_321252.awb")

						arg_190_1:RecordAudio("321252045", var_193_19)
						arg_190_1:RecordAudio("321252045", var_193_19)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_321252", "321252045", "story_v_out_321252.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_321252", "321252045", "story_v_out_321252.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_20 = math.max(var_193_11, arg_190_1.talkMaxDuration)

			if var_193_10 <= arg_190_1.time_ and arg_190_1.time_ < var_193_10 + var_193_20 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_10) / var_193_20

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_10 + var_193_20 and arg_190_1.time_ < var_193_10 + var_193_20 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play321252046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 321252046
		arg_194_1.duration_ = 4.07

		local var_194_0 = {
			zh = 3.9,
			ja = 4.066
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play321252047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 0.425

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_2 = arg_194_1:FormatText(StoryNameCfg[1178].name)

				arg_194_1.leftNameTxt_.text = var_197_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_3 = arg_194_1:GetWordFromCfg(321252046)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 17
				local var_197_6 = utf8.len(var_197_4)
				local var_197_7 = var_197_5 <= 0 and var_197_1 or var_197_1 * (var_197_6 / var_197_5)

				if var_197_7 > 0 and var_197_1 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252046", "story_v_out_321252.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_321252", "321252046", "story_v_out_321252.awb") / 1000

					if var_197_8 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_0
					end

					if var_197_3.prefab_name ~= "" and arg_194_1.actors_[var_197_3.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_3.prefab_name].transform, "story_v_out_321252", "321252046", "story_v_out_321252.awb")

						arg_194_1:RecordAudio("321252046", var_197_9)
						arg_194_1:RecordAudio("321252046", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_321252", "321252046", "story_v_out_321252.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_321252", "321252046", "story_v_out_321252.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_10 and arg_194_1.time_ < var_197_0 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play321252047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 321252047
		arg_198_1.duration_ = 9.13

		local var_198_0 = {
			zh = 7.2,
			ja = 9.133
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play321252048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1111ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos1111ui_story = var_201_0.localPosition
			end

			local var_201_2 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2
				local var_201_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1111ui_story, var_201_4, var_201_3)

				local var_201_5 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_5.x, var_201_5.y, var_201_5.z)

				local var_201_6 = var_201_0.localEulerAngles

				var_201_6.z = 0
				var_201_6.x = 0
				var_201_0.localEulerAngles = var_201_6
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_201_7 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_7.x, var_201_7.y, var_201_7.z)

				local var_201_8 = var_201_0.localEulerAngles

				var_201_8.z = 0
				var_201_8.x = 0
				var_201_0.localEulerAngles = var_201_8
			end

			local var_201_9 = arg_198_1.actors_["1111ui_story"]
			local var_201_10 = 0

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 and not isNil(var_201_9) and arg_198_1.var_.characterEffect1111ui_story == nil then
				arg_198_1.var_.characterEffect1111ui_story = var_201_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_11 = 0.200000002980232

			if var_201_10 <= arg_198_1.time_ and arg_198_1.time_ < var_201_10 + var_201_11 and not isNil(var_201_9) then
				local var_201_12 = (arg_198_1.time_ - var_201_10) / var_201_11

				if arg_198_1.var_.characterEffect1111ui_story and not isNil(var_201_9) then
					arg_198_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_10 + var_201_11 and arg_198_1.time_ < var_201_10 + var_201_11 + arg_201_0 and not isNil(var_201_9) and arg_198_1.var_.characterEffect1111ui_story then
				arg_198_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_201_13 = arg_198_1.actors_["10131ui_story"]
			local var_201_14 = 0

			if var_201_14 < arg_198_1.time_ and arg_198_1.time_ <= var_201_14 + arg_201_0 and not isNil(var_201_13) and arg_198_1.var_.characterEffect10131ui_story == nil then
				arg_198_1.var_.characterEffect10131ui_story = var_201_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_15 = 0.200000002980232

			if var_201_14 <= arg_198_1.time_ and arg_198_1.time_ < var_201_14 + var_201_15 and not isNil(var_201_13) then
				local var_201_16 = (arg_198_1.time_ - var_201_14) / var_201_15

				if arg_198_1.var_.characterEffect10131ui_story and not isNil(var_201_13) then
					local var_201_17 = Mathf.Lerp(0, 0.5, var_201_16)

					arg_198_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_198_1.var_.characterEffect10131ui_story.fillRatio = var_201_17
				end
			end

			if arg_198_1.time_ >= var_201_14 + var_201_15 and arg_198_1.time_ < var_201_14 + var_201_15 + arg_201_0 and not isNil(var_201_13) and arg_198_1.var_.characterEffect10131ui_story then
				local var_201_18 = 0.5

				arg_198_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_198_1.var_.characterEffect10131ui_story.fillRatio = var_201_18
			end

			local var_201_19 = 0

			if var_201_19 < arg_198_1.time_ and arg_198_1.time_ <= var_201_19 + arg_201_0 then
				arg_198_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			local var_201_20 = 0

			if var_201_20 < arg_198_1.time_ and arg_198_1.time_ <= var_201_20 + arg_201_0 then
				arg_198_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_201_21 = 0
			local var_201_22 = 0.75

			if var_201_21 < arg_198_1.time_ and arg_198_1.time_ <= var_201_21 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_23 = arg_198_1:FormatText(StoryNameCfg[67].name)

				arg_198_1.leftNameTxt_.text = var_201_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_24 = arg_198_1:GetWordFromCfg(321252047)
				local var_201_25 = arg_198_1:FormatText(var_201_24.content)

				arg_198_1.text_.text = var_201_25

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_26 = 30
				local var_201_27 = utf8.len(var_201_25)
				local var_201_28 = var_201_26 <= 0 and var_201_22 or var_201_22 * (var_201_27 / var_201_26)

				if var_201_28 > 0 and var_201_22 < var_201_28 then
					arg_198_1.talkMaxDuration = var_201_28

					if var_201_28 + var_201_21 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_28 + var_201_21
					end
				end

				arg_198_1.text_.text = var_201_25
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252047", "story_v_out_321252.awb") ~= 0 then
					local var_201_29 = manager.audio:GetVoiceLength("story_v_out_321252", "321252047", "story_v_out_321252.awb") / 1000

					if var_201_29 + var_201_21 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_29 + var_201_21
					end

					if var_201_24.prefab_name ~= "" and arg_198_1.actors_[var_201_24.prefab_name] ~= nil then
						local var_201_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_24.prefab_name].transform, "story_v_out_321252", "321252047", "story_v_out_321252.awb")

						arg_198_1:RecordAudio("321252047", var_201_30)
						arg_198_1:RecordAudio("321252047", var_201_30)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_321252", "321252047", "story_v_out_321252.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_321252", "321252047", "story_v_out_321252.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_31 = math.max(var_201_22, arg_198_1.talkMaxDuration)

			if var_201_21 <= arg_198_1.time_ and arg_198_1.time_ < var_201_21 + var_201_31 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_21) / var_201_31

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_21 + var_201_31 and arg_198_1.time_ < var_201_21 + var_201_31 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play321252048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 321252048
		arg_202_1.duration_ = 7.6

		local var_202_0 = {
			zh = 7.6,
			ja = 6.766
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play321252049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["10131ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect10131ui_story == nil then
				arg_202_1.var_.characterEffect10131ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect10131ui_story and not isNil(var_205_0) then
					arg_202_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect10131ui_story then
				arg_202_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_205_4 = arg_202_1.actors_["1111ui_story"]
			local var_205_5 = 0

			if var_205_5 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.characterEffect1111ui_story == nil then
				arg_202_1.var_.characterEffect1111ui_story = var_205_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_6 = 0.200000002980232

			if var_205_5 <= arg_202_1.time_ and arg_202_1.time_ < var_205_5 + var_205_6 and not isNil(var_205_4) then
				local var_205_7 = (arg_202_1.time_ - var_205_5) / var_205_6

				if arg_202_1.var_.characterEffect1111ui_story and not isNil(var_205_4) then
					local var_205_8 = Mathf.Lerp(0, 0.5, var_205_7)

					arg_202_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1111ui_story.fillRatio = var_205_8
				end
			end

			if arg_202_1.time_ >= var_205_5 + var_205_6 and arg_202_1.time_ < var_205_5 + var_205_6 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.characterEffect1111ui_story then
				local var_205_9 = 0.5

				arg_202_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1111ui_story.fillRatio = var_205_9
			end

			local var_205_10 = 0

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 then
				arg_202_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_205_11 = 0

			if var_205_11 < arg_202_1.time_ and arg_202_1.time_ <= var_205_11 + arg_205_0 then
				arg_202_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_205_12 = 0
			local var_205_13 = 0.7

			if var_205_12 < arg_202_1.time_ and arg_202_1.time_ <= var_205_12 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_14 = arg_202_1:FormatText(StoryNameCfg[1178].name)

				arg_202_1.leftNameTxt_.text = var_205_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_15 = arg_202_1:GetWordFromCfg(321252048)
				local var_205_16 = arg_202_1:FormatText(var_205_15.content)

				arg_202_1.text_.text = var_205_16

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_17 = 28
				local var_205_18 = utf8.len(var_205_16)
				local var_205_19 = var_205_17 <= 0 and var_205_13 or var_205_13 * (var_205_18 / var_205_17)

				if var_205_19 > 0 and var_205_13 < var_205_19 then
					arg_202_1.talkMaxDuration = var_205_19

					if var_205_19 + var_205_12 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_19 + var_205_12
					end
				end

				arg_202_1.text_.text = var_205_16
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252048", "story_v_out_321252.awb") ~= 0 then
					local var_205_20 = manager.audio:GetVoiceLength("story_v_out_321252", "321252048", "story_v_out_321252.awb") / 1000

					if var_205_20 + var_205_12 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_20 + var_205_12
					end

					if var_205_15.prefab_name ~= "" and arg_202_1.actors_[var_205_15.prefab_name] ~= nil then
						local var_205_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_15.prefab_name].transform, "story_v_out_321252", "321252048", "story_v_out_321252.awb")

						arg_202_1:RecordAudio("321252048", var_205_21)
						arg_202_1:RecordAudio("321252048", var_205_21)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_321252", "321252048", "story_v_out_321252.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_321252", "321252048", "story_v_out_321252.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_22 = math.max(var_205_13, arg_202_1.talkMaxDuration)

			if var_205_12 <= arg_202_1.time_ and arg_202_1.time_ < var_205_12 + var_205_22 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_12) / var_205_22

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_12 + var_205_22 and arg_202_1.time_ < var_205_12 + var_205_22 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play321252049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 321252049
		arg_206_1.duration_ = 4.4

		local var_206_0 = {
			zh = 1.999999999999,
			ja = 4.4
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play321252050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1111ui_story"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1111ui_story == nil then
				arg_206_1.var_.characterEffect1111ui_story = var_209_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.characterEffect1111ui_story and not isNil(var_209_0) then
					arg_206_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1111ui_story then
				arg_206_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_209_4 = arg_206_1.actors_["10131ui_story"]
			local var_209_5 = 0

			if var_209_5 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 and not isNil(var_209_4) and arg_206_1.var_.characterEffect10131ui_story == nil then
				arg_206_1.var_.characterEffect10131ui_story = var_209_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_6 = 0.200000002980232

			if var_209_5 <= arg_206_1.time_ and arg_206_1.time_ < var_209_5 + var_209_6 and not isNil(var_209_4) then
				local var_209_7 = (arg_206_1.time_ - var_209_5) / var_209_6

				if arg_206_1.var_.characterEffect10131ui_story and not isNil(var_209_4) then
					local var_209_8 = Mathf.Lerp(0, 0.5, var_209_7)

					arg_206_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_206_1.var_.characterEffect10131ui_story.fillRatio = var_209_8
				end
			end

			if arg_206_1.time_ >= var_209_5 + var_209_6 and arg_206_1.time_ < var_209_5 + var_209_6 + arg_209_0 and not isNil(var_209_4) and arg_206_1.var_.characterEffect10131ui_story then
				local var_209_9 = 0.5

				arg_206_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_206_1.var_.characterEffect10131ui_story.fillRatio = var_209_9
			end

			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 then
				arg_206_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_2")
			end

			local var_209_11 = 0

			if var_209_11 < arg_206_1.time_ and arg_206_1.time_ <= var_209_11 + arg_209_0 then
				arg_206_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_209_12 = 0
			local var_209_13 = 0.175

			if var_209_12 < arg_206_1.time_ and arg_206_1.time_ <= var_209_12 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_14 = arg_206_1:FormatText(StoryNameCfg[67].name)

				arg_206_1.leftNameTxt_.text = var_209_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_15 = arg_206_1:GetWordFromCfg(321252049)
				local var_209_16 = arg_206_1:FormatText(var_209_15.content)

				arg_206_1.text_.text = var_209_16

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_17 = 7
				local var_209_18 = utf8.len(var_209_16)
				local var_209_19 = var_209_17 <= 0 and var_209_13 or var_209_13 * (var_209_18 / var_209_17)

				if var_209_19 > 0 and var_209_13 < var_209_19 then
					arg_206_1.talkMaxDuration = var_209_19

					if var_209_19 + var_209_12 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_19 + var_209_12
					end
				end

				arg_206_1.text_.text = var_209_16
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252049", "story_v_out_321252.awb") ~= 0 then
					local var_209_20 = manager.audio:GetVoiceLength("story_v_out_321252", "321252049", "story_v_out_321252.awb") / 1000

					if var_209_20 + var_209_12 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_20 + var_209_12
					end

					if var_209_15.prefab_name ~= "" and arg_206_1.actors_[var_209_15.prefab_name] ~= nil then
						local var_209_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_15.prefab_name].transform, "story_v_out_321252", "321252049", "story_v_out_321252.awb")

						arg_206_1:RecordAudio("321252049", var_209_21)
						arg_206_1:RecordAudio("321252049", var_209_21)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_321252", "321252049", "story_v_out_321252.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_321252", "321252049", "story_v_out_321252.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_22 = math.max(var_209_13, arg_206_1.talkMaxDuration)

			if var_209_12 <= arg_206_1.time_ and arg_206_1.time_ < var_209_12 + var_209_22 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_12) / var_209_22

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_12 + var_209_22 and arg_206_1.time_ < var_209_12 + var_209_22 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play321252050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 321252050
		arg_210_1.duration_ = 13.93

		local var_210_0 = {
			zh = 9.233,
			ja = 13.933
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play321252051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10131ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect10131ui_story == nil then
				arg_210_1.var_.characterEffect10131ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect10131ui_story and not isNil(var_213_0) then
					arg_210_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect10131ui_story then
				arg_210_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_213_4 = arg_210_1.actors_["1111ui_story"]
			local var_213_5 = 0

			if var_213_5 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 and not isNil(var_213_4) and arg_210_1.var_.characterEffect1111ui_story == nil then
				arg_210_1.var_.characterEffect1111ui_story = var_213_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_6 = 0.200000002980232

			if var_213_5 <= arg_210_1.time_ and arg_210_1.time_ < var_213_5 + var_213_6 and not isNil(var_213_4) then
				local var_213_7 = (arg_210_1.time_ - var_213_5) / var_213_6

				if arg_210_1.var_.characterEffect1111ui_story and not isNil(var_213_4) then
					local var_213_8 = Mathf.Lerp(0, 0.5, var_213_7)

					arg_210_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1111ui_story.fillRatio = var_213_8
				end
			end

			if arg_210_1.time_ >= var_213_5 + var_213_6 and arg_210_1.time_ < var_213_5 + var_213_6 + arg_213_0 and not isNil(var_213_4) and arg_210_1.var_.characterEffect1111ui_story then
				local var_213_9 = 0.5

				arg_210_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1111ui_story.fillRatio = var_213_9
			end

			local var_213_10 = 0
			local var_213_11 = 0.925

			if var_213_10 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_12 = arg_210_1:FormatText(StoryNameCfg[1178].name)

				arg_210_1.leftNameTxt_.text = var_213_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_13 = arg_210_1:GetWordFromCfg(321252050)
				local var_213_14 = arg_210_1:FormatText(var_213_13.content)

				arg_210_1.text_.text = var_213_14

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_15 = 37
				local var_213_16 = utf8.len(var_213_14)
				local var_213_17 = var_213_15 <= 0 and var_213_11 or var_213_11 * (var_213_16 / var_213_15)

				if var_213_17 > 0 and var_213_11 < var_213_17 then
					arg_210_1.talkMaxDuration = var_213_17

					if var_213_17 + var_213_10 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_17 + var_213_10
					end
				end

				arg_210_1.text_.text = var_213_14
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252050", "story_v_out_321252.awb") ~= 0 then
					local var_213_18 = manager.audio:GetVoiceLength("story_v_out_321252", "321252050", "story_v_out_321252.awb") / 1000

					if var_213_18 + var_213_10 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_18 + var_213_10
					end

					if var_213_13.prefab_name ~= "" and arg_210_1.actors_[var_213_13.prefab_name] ~= nil then
						local var_213_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_13.prefab_name].transform, "story_v_out_321252", "321252050", "story_v_out_321252.awb")

						arg_210_1:RecordAudio("321252050", var_213_19)
						arg_210_1:RecordAudio("321252050", var_213_19)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_321252", "321252050", "story_v_out_321252.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_321252", "321252050", "story_v_out_321252.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_20 = math.max(var_213_11, arg_210_1.talkMaxDuration)

			if var_213_10 <= arg_210_1.time_ and arg_210_1.time_ < var_213_10 + var_213_20 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_10) / var_213_20

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_10 + var_213_20 and arg_210_1.time_ < var_213_10 + var_213_20 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play321252051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 321252051
		arg_214_1.duration_ = 7.5

		local var_214_0 = {
			zh = 6.8,
			ja = 7.5
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
				arg_214_0:Play321252052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10131ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos10131ui_story = var_217_0.localPosition
			end

			local var_217_2 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2
				local var_217_4 = Vector3.New(0.83, -0.96, -5.8)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10131ui_story, var_217_4, var_217_3)

				local var_217_5 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_5.x, var_217_5.y, var_217_5.z)

				local var_217_6 = var_217_0.localEulerAngles

				var_217_6.z = 0
				var_217_6.x = 0
				var_217_0.localEulerAngles = var_217_6
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_217_7 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_7.x, var_217_7.y, var_217_7.z)

				local var_217_8 = var_217_0.localEulerAngles

				var_217_8.z = 0
				var_217_8.x = 0
				var_217_0.localEulerAngles = var_217_8
			end

			local var_217_9 = 0

			if var_217_9 < arg_214_1.time_ and arg_214_1.time_ <= var_217_9 + arg_217_0 then
				arg_214_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_1")
			end

			local var_217_10 = 0

			if var_217_10 < arg_214_1.time_ and arg_214_1.time_ <= var_217_10 + arg_217_0 then
				arg_214_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_217_11 = 0
			local var_217_12 = 0.8

			if var_217_11 < arg_214_1.time_ and arg_214_1.time_ <= var_217_11 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_13 = arg_214_1:FormatText(StoryNameCfg[1178].name)

				arg_214_1.leftNameTxt_.text = var_217_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_14 = arg_214_1:GetWordFromCfg(321252051)
				local var_217_15 = arg_214_1:FormatText(var_217_14.content)

				arg_214_1.text_.text = var_217_15

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_16 = 32
				local var_217_17 = utf8.len(var_217_15)
				local var_217_18 = var_217_16 <= 0 and var_217_12 or var_217_12 * (var_217_17 / var_217_16)

				if var_217_18 > 0 and var_217_12 < var_217_18 then
					arg_214_1.talkMaxDuration = var_217_18

					if var_217_18 + var_217_11 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_18 + var_217_11
					end
				end

				arg_214_1.text_.text = var_217_15
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252051", "story_v_out_321252.awb") ~= 0 then
					local var_217_19 = manager.audio:GetVoiceLength("story_v_out_321252", "321252051", "story_v_out_321252.awb") / 1000

					if var_217_19 + var_217_11 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_19 + var_217_11
					end

					if var_217_14.prefab_name ~= "" and arg_214_1.actors_[var_217_14.prefab_name] ~= nil then
						local var_217_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_14.prefab_name].transform, "story_v_out_321252", "321252051", "story_v_out_321252.awb")

						arg_214_1:RecordAudio("321252051", var_217_20)
						arg_214_1:RecordAudio("321252051", var_217_20)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_321252", "321252051", "story_v_out_321252.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_321252", "321252051", "story_v_out_321252.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_21 = math.max(var_217_12, arg_214_1.talkMaxDuration)

			if var_217_11 <= arg_214_1.time_ and arg_214_1.time_ < var_217_11 + var_217_21 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_11) / var_217_21

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_11 + var_217_21 and arg_214_1.time_ < var_217_11 + var_217_21 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321252052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 321252052
		arg_218_1.duration_ = 3.9

		local var_218_0 = {
			zh = 2.7,
			ja = 3.9
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
				arg_218_0:Play321252053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1111ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos1111ui_story = var_221_0.localPosition
			end

			local var_221_2 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2
				local var_221_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1111ui_story, var_221_4, var_221_3)

				local var_221_5 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_5.x, var_221_5.y, var_221_5.z)

				local var_221_6 = var_221_0.localEulerAngles

				var_221_6.z = 0
				var_221_6.x = 0
				var_221_0.localEulerAngles = var_221_6
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_221_7 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_7.x, var_221_7.y, var_221_7.z)

				local var_221_8 = var_221_0.localEulerAngles

				var_221_8.z = 0
				var_221_8.x = 0
				var_221_0.localEulerAngles = var_221_8
			end

			local var_221_9 = "1043ui_story"

			if arg_218_1.actors_[var_221_9] == nil then
				local var_221_10 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_221_10) then
					local var_221_11 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_218_1.stage_.transform)

					var_221_11.name = var_221_9
					var_221_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_218_1.actors_[var_221_9] = var_221_11

					local var_221_12 = var_221_11:GetComponentInChildren(typeof(CharacterEffect))

					var_221_12.enabled = true

					local var_221_13 = GameObjectTools.GetOrAddComponent(var_221_11, typeof(DynamicBoneHelper))

					if var_221_13 then
						var_221_13:EnableDynamicBone(false)
					end

					arg_218_1:ShowWeapon(var_221_12.transform, false)

					arg_218_1.var_[var_221_9 .. "Animator"] = var_221_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_218_1.var_[var_221_9 .. "Animator"].applyRootMotion = true
					arg_218_1.var_[var_221_9 .. "LipSync"] = var_221_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_221_14 = arg_218_1.actors_["1043ui_story"]
			local var_221_15 = 0

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 and not isNil(var_221_14) and arg_218_1.var_.characterEffect1043ui_story == nil then
				arg_218_1.var_.characterEffect1043ui_story = var_221_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_16 = 0.200000002980232

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_16 and not isNil(var_221_14) then
				local var_221_17 = (arg_218_1.time_ - var_221_15) / var_221_16

				if arg_218_1.var_.characterEffect1043ui_story and not isNil(var_221_14) then
					arg_218_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_15 + var_221_16 and arg_218_1.time_ < var_221_15 + var_221_16 + arg_221_0 and not isNil(var_221_14) and arg_218_1.var_.characterEffect1043ui_story then
				arg_218_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_221_18 = arg_218_1.actors_["10131ui_story"]
			local var_221_19 = 0

			if var_221_19 < arg_218_1.time_ and arg_218_1.time_ <= var_221_19 + arg_221_0 and not isNil(var_221_18) and arg_218_1.var_.characterEffect10131ui_story == nil then
				arg_218_1.var_.characterEffect10131ui_story = var_221_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_20 = 0.200000002980232

			if var_221_19 <= arg_218_1.time_ and arg_218_1.time_ < var_221_19 + var_221_20 and not isNil(var_221_18) then
				local var_221_21 = (arg_218_1.time_ - var_221_19) / var_221_20

				if arg_218_1.var_.characterEffect10131ui_story and not isNil(var_221_18) then
					local var_221_22 = Mathf.Lerp(0, 0.5, var_221_21)

					arg_218_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10131ui_story.fillRatio = var_221_22
				end
			end

			if arg_218_1.time_ >= var_221_19 + var_221_20 and arg_218_1.time_ < var_221_19 + var_221_20 + arg_221_0 and not isNil(var_221_18) and arg_218_1.var_.characterEffect10131ui_story then
				local var_221_23 = 0.5

				arg_218_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10131ui_story.fillRatio = var_221_23
			end

			local var_221_24 = 0
			local var_221_25 = 0.325

			if var_221_24 < arg_218_1.time_ and arg_218_1.time_ <= var_221_24 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_26 = arg_218_1:FormatText(StoryNameCfg[1156].name)

				arg_218_1.leftNameTxt_.text = var_221_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_27 = arg_218_1:GetWordFromCfg(321252052)
				local var_221_28 = arg_218_1:FormatText(var_221_27.content)

				arg_218_1.text_.text = var_221_28

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_29 = 13
				local var_221_30 = utf8.len(var_221_28)
				local var_221_31 = var_221_29 <= 0 and var_221_25 or var_221_25 * (var_221_30 / var_221_29)

				if var_221_31 > 0 and var_221_25 < var_221_31 then
					arg_218_1.talkMaxDuration = var_221_31

					if var_221_31 + var_221_24 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_31 + var_221_24
					end
				end

				arg_218_1.text_.text = var_221_28
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252052", "story_v_out_321252.awb") ~= 0 then
					local var_221_32 = manager.audio:GetVoiceLength("story_v_out_321252", "321252052", "story_v_out_321252.awb") / 1000

					if var_221_32 + var_221_24 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_32 + var_221_24
					end

					if var_221_27.prefab_name ~= "" and arg_218_1.actors_[var_221_27.prefab_name] ~= nil then
						local var_221_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_27.prefab_name].transform, "story_v_out_321252", "321252052", "story_v_out_321252.awb")

						arg_218_1:RecordAudio("321252052", var_221_33)
						arg_218_1:RecordAudio("321252052", var_221_33)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_321252", "321252052", "story_v_out_321252.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_321252", "321252052", "story_v_out_321252.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_34 = math.max(var_221_25, arg_218_1.talkMaxDuration)

			if var_221_24 <= arg_218_1.time_ and arg_218_1.time_ < var_221_24 + var_221_34 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_24) / var_221_34

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_24 + var_221_34 and arg_218_1.time_ < var_221_24 + var_221_34 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play321252053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 321252053
		arg_222_1.duration_ = 8.67

		local var_222_0 = {
			zh = 6.4,
			ja = 8.666
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
				arg_222_0:Play321252054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10131ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect10131ui_story == nil then
				arg_222_1.var_.characterEffect10131ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect10131ui_story and not isNil(var_225_0) then
					arg_222_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect10131ui_story then
				arg_222_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_225_4 = "1037ui_story"

			if arg_222_1.actors_[var_225_4] == nil then
				local var_225_5 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_225_5) then
					local var_225_6 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_222_1.stage_.transform)

					var_225_6.name = var_225_4
					var_225_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_222_1.actors_[var_225_4] = var_225_6

					local var_225_7 = var_225_6:GetComponentInChildren(typeof(CharacterEffect))

					var_225_7.enabled = true

					local var_225_8 = GameObjectTools.GetOrAddComponent(var_225_6, typeof(DynamicBoneHelper))

					if var_225_8 then
						var_225_8:EnableDynamicBone(false)
					end

					arg_222_1:ShowWeapon(var_225_7.transform, false)

					arg_222_1.var_[var_225_4 .. "Animator"] = var_225_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_222_1.var_[var_225_4 .. "Animator"].applyRootMotion = true
					arg_222_1.var_[var_225_4 .. "LipSync"] = var_225_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_225_9 = arg_222_1.actors_["1037ui_story"]
			local var_225_10 = 0

			if var_225_10 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect1037ui_story == nil then
				arg_222_1.var_.characterEffect1037ui_story = var_225_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_11 = 0.200000002980232

			if var_225_10 <= arg_222_1.time_ and arg_222_1.time_ < var_225_10 + var_225_11 and not isNil(var_225_9) then
				local var_225_12 = (arg_222_1.time_ - var_225_10) / var_225_11

				if arg_222_1.var_.characterEffect1037ui_story and not isNil(var_225_9) then
					local var_225_13 = Mathf.Lerp(0, 0.5, var_225_12)

					arg_222_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1037ui_story.fillRatio = var_225_13
				end
			end

			if arg_222_1.time_ >= var_225_10 + var_225_11 and arg_222_1.time_ < var_225_10 + var_225_11 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect1037ui_story then
				local var_225_14 = 0.5

				arg_222_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1037ui_story.fillRatio = var_225_14
			end

			local var_225_15 = 0
			local var_225_16 = 0.575

			if var_225_15 < arg_222_1.time_ and arg_222_1.time_ <= var_225_15 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_17 = arg_222_1:FormatText(StoryNameCfg[1178].name)

				arg_222_1.leftNameTxt_.text = var_225_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_18 = arg_222_1:GetWordFromCfg(321252053)
				local var_225_19 = arg_222_1:FormatText(var_225_18.content)

				arg_222_1.text_.text = var_225_19

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_20 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252053", "story_v_out_321252.awb") ~= 0 then
					local var_225_23 = manager.audio:GetVoiceLength("story_v_out_321252", "321252053", "story_v_out_321252.awb") / 1000

					if var_225_23 + var_225_15 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_23 + var_225_15
					end

					if var_225_18.prefab_name ~= "" and arg_222_1.actors_[var_225_18.prefab_name] ~= nil then
						local var_225_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_18.prefab_name].transform, "story_v_out_321252", "321252053", "story_v_out_321252.awb")

						arg_222_1:RecordAudio("321252053", var_225_24)
						arg_222_1:RecordAudio("321252053", var_225_24)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_321252", "321252053", "story_v_out_321252.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_321252", "321252053", "story_v_out_321252.awb")
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

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play321252054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 321252054
		arg_226_1.duration_ = 10.2

		local var_226_0 = {
			zh = 7.3,
			ja = 10.2
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
				arg_226_0:Play321252055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.75

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_2 = arg_226_1:FormatText(StoryNameCfg[1178].name)

				arg_226_1.leftNameTxt_.text = var_229_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_3 = arg_226_1:GetWordFromCfg(321252054)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252054", "story_v_out_321252.awb") ~= 0 then
					local var_229_8 = manager.audio:GetVoiceLength("story_v_out_321252", "321252054", "story_v_out_321252.awb") / 1000

					if var_229_8 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_0
					end

					if var_229_3.prefab_name ~= "" and arg_226_1.actors_[var_229_3.prefab_name] ~= nil then
						local var_229_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_3.prefab_name].transform, "story_v_out_321252", "321252054", "story_v_out_321252.awb")

						arg_226_1:RecordAudio("321252054", var_229_9)
						arg_226_1:RecordAudio("321252054", var_229_9)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_321252", "321252054", "story_v_out_321252.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_321252", "321252054", "story_v_out_321252.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_10 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_10

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_10 and arg_226_1.time_ < var_229_0 + var_229_10 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play321252055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 321252055
		arg_230_1.duration_ = 6.87

		local var_230_0 = {
			zh = 4.1,
			ja = 6.866
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
				arg_230_0:Play321252056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131actionlink/10131action484")
			end

			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_233_2 = 0
			local var_233_3 = 0.45

			if var_233_2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_4 = arg_230_1:FormatText(StoryNameCfg[1178].name)

				arg_230_1.leftNameTxt_.text = var_233_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_5 = arg_230_1:GetWordFromCfg(321252055)
				local var_233_6 = arg_230_1:FormatText(var_233_5.content)

				arg_230_1.text_.text = var_233_6

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_7 = 18
				local var_233_8 = utf8.len(var_233_6)
				local var_233_9 = var_233_7 <= 0 and var_233_3 or var_233_3 * (var_233_8 / var_233_7)

				if var_233_9 > 0 and var_233_3 < var_233_9 then
					arg_230_1.talkMaxDuration = var_233_9

					if var_233_9 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_6
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252055", "story_v_out_321252.awb") ~= 0 then
					local var_233_10 = manager.audio:GetVoiceLength("story_v_out_321252", "321252055", "story_v_out_321252.awb") / 1000

					if var_233_10 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_2
					end

					if var_233_5.prefab_name ~= "" and arg_230_1.actors_[var_233_5.prefab_name] ~= nil then
						local var_233_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_5.prefab_name].transform, "story_v_out_321252", "321252055", "story_v_out_321252.awb")

						arg_230_1:RecordAudio("321252055", var_233_11)
						arg_230_1:RecordAudio("321252055", var_233_11)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_321252", "321252055", "story_v_out_321252.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_321252", "321252055", "story_v_out_321252.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_12 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_12 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_12

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_12 and arg_230_1.time_ < var_233_2 + var_233_12 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play321252056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 321252056
		arg_234_1.duration_ = 7.87

		local var_234_0 = {
			zh = 5.833,
			ja = 7.866
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
				arg_234_0:Play321252057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10131ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos10131ui_story = var_237_0.localPosition
			end

			local var_237_2 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2
				local var_237_4 = Vector3.New(0.83, -0.96, -5.8)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10131ui_story, var_237_4, var_237_3)

				local var_237_5 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_5.x, var_237_5.y, var_237_5.z)

				local var_237_6 = var_237_0.localEulerAngles

				var_237_6.z = 0
				var_237_6.x = 0
				var_237_0.localEulerAngles = var_237_6
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_237_7 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_7.x, var_237_7.y, var_237_7.z)

				local var_237_8 = var_237_0.localEulerAngles

				var_237_8.z = 0
				var_237_8.x = 0
				var_237_0.localEulerAngles = var_237_8
			end

			local var_237_9 = arg_234_1.actors_["1111ui_story"].transform
			local var_237_10 = 0

			if var_237_10 < arg_234_1.time_ and arg_234_1.time_ <= var_237_10 + arg_237_0 then
				arg_234_1.var_.moveOldPos1111ui_story = var_237_9.localPosition
			end

			local var_237_11 = 0.001

			if var_237_10 <= arg_234_1.time_ and arg_234_1.time_ < var_237_10 + var_237_11 then
				local var_237_12 = (arg_234_1.time_ - var_237_10) / var_237_11
				local var_237_13 = Vector3.New(-0.79, -0.87, -5.7)

				var_237_9.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1111ui_story, var_237_13, var_237_12)

				local var_237_14 = manager.ui.mainCamera.transform.position - var_237_9.position

				var_237_9.forward = Vector3.New(var_237_14.x, var_237_14.y, var_237_14.z)

				local var_237_15 = var_237_9.localEulerAngles

				var_237_15.z = 0
				var_237_15.x = 0
				var_237_9.localEulerAngles = var_237_15
			end

			if arg_234_1.time_ >= var_237_10 + var_237_11 and arg_234_1.time_ < var_237_10 + var_237_11 + arg_237_0 then
				var_237_9.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_237_16 = manager.ui.mainCamera.transform.position - var_237_9.position

				var_237_9.forward = Vector3.New(var_237_16.x, var_237_16.y, var_237_16.z)

				local var_237_17 = var_237_9.localEulerAngles

				var_237_17.z = 0
				var_237_17.x = 0
				var_237_9.localEulerAngles = var_237_17
			end

			local var_237_18 = arg_234_1.actors_["1111ui_story"]
			local var_237_19 = 0

			if var_237_19 < arg_234_1.time_ and arg_234_1.time_ <= var_237_19 + arg_237_0 and not isNil(var_237_18) and arg_234_1.var_.characterEffect1111ui_story == nil then
				arg_234_1.var_.characterEffect1111ui_story = var_237_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_20 = 0.200000002980232

			if var_237_19 <= arg_234_1.time_ and arg_234_1.time_ < var_237_19 + var_237_20 and not isNil(var_237_18) then
				local var_237_21 = (arg_234_1.time_ - var_237_19) / var_237_20

				if arg_234_1.var_.characterEffect1111ui_story and not isNil(var_237_18) then
					arg_234_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_19 + var_237_20 and arg_234_1.time_ < var_237_19 + var_237_20 + arg_237_0 and not isNil(var_237_18) and arg_234_1.var_.characterEffect1111ui_story then
				arg_234_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_237_22 = arg_234_1.actors_["10131ui_story"]
			local var_237_23 = 0

			if var_237_23 < arg_234_1.time_ and arg_234_1.time_ <= var_237_23 + arg_237_0 and not isNil(var_237_22) and arg_234_1.var_.characterEffect10131ui_story == nil then
				arg_234_1.var_.characterEffect10131ui_story = var_237_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_24 = 0.200000002980232

			if var_237_23 <= arg_234_1.time_ and arg_234_1.time_ < var_237_23 + var_237_24 and not isNil(var_237_22) then
				local var_237_25 = (arg_234_1.time_ - var_237_23) / var_237_24

				if arg_234_1.var_.characterEffect10131ui_story and not isNil(var_237_22) then
					local var_237_26 = Mathf.Lerp(0, 0.5, var_237_25)

					arg_234_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_234_1.var_.characterEffect10131ui_story.fillRatio = var_237_26
				end
			end

			if arg_234_1.time_ >= var_237_23 + var_237_24 and arg_234_1.time_ < var_237_23 + var_237_24 + arg_237_0 and not isNil(var_237_22) and arg_234_1.var_.characterEffect10131ui_story then
				local var_237_27 = 0.5

				arg_234_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_234_1.var_.characterEffect10131ui_story.fillRatio = var_237_27
			end

			local var_237_28 = 0

			if var_237_28 < arg_234_1.time_ and arg_234_1.time_ <= var_237_28 + arg_237_0 then
				arg_234_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_237_29 = 0

			if var_237_29 < arg_234_1.time_ and arg_234_1.time_ <= var_237_29 + arg_237_0 then
				arg_234_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_237_30 = arg_234_1.actors_["1037ui_story"].transform
			local var_237_31 = 0

			if var_237_31 < arg_234_1.time_ and arg_234_1.time_ <= var_237_31 + arg_237_0 then
				arg_234_1.var_.moveOldPos1037ui_story = var_237_30.localPosition
			end

			local var_237_32 = 0.001

			if var_237_31 <= arg_234_1.time_ and arg_234_1.time_ < var_237_31 + var_237_32 then
				local var_237_33 = (arg_234_1.time_ - var_237_31) / var_237_32
				local var_237_34 = Vector3.New(0, 100, 0)

				var_237_30.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1037ui_story, var_237_34, var_237_33)

				local var_237_35 = manager.ui.mainCamera.transform.position - var_237_30.position

				var_237_30.forward = Vector3.New(var_237_35.x, var_237_35.y, var_237_35.z)

				local var_237_36 = var_237_30.localEulerAngles

				var_237_36.z = 0
				var_237_36.x = 0
				var_237_30.localEulerAngles = var_237_36
			end

			if arg_234_1.time_ >= var_237_31 + var_237_32 and arg_234_1.time_ < var_237_31 + var_237_32 + arg_237_0 then
				var_237_30.localPosition = Vector3.New(0, 100, 0)

				local var_237_37 = manager.ui.mainCamera.transform.position - var_237_30.position

				var_237_30.forward = Vector3.New(var_237_37.x, var_237_37.y, var_237_37.z)

				local var_237_38 = var_237_30.localEulerAngles

				var_237_38.z = 0
				var_237_38.x = 0
				var_237_30.localEulerAngles = var_237_38
			end

			local var_237_39 = 0
			local var_237_40 = 0.775

			if var_237_39 < arg_234_1.time_ and arg_234_1.time_ <= var_237_39 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_41 = arg_234_1:FormatText(StoryNameCfg[67].name)

				arg_234_1.leftNameTxt_.text = var_237_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_42 = arg_234_1:GetWordFromCfg(321252056)
				local var_237_43 = arg_234_1:FormatText(var_237_42.content)

				arg_234_1.text_.text = var_237_43

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_44 = 31
				local var_237_45 = utf8.len(var_237_43)
				local var_237_46 = var_237_44 <= 0 and var_237_40 or var_237_40 * (var_237_45 / var_237_44)

				if var_237_46 > 0 and var_237_40 < var_237_46 then
					arg_234_1.talkMaxDuration = var_237_46

					if var_237_46 + var_237_39 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_46 + var_237_39
					end
				end

				arg_234_1.text_.text = var_237_43
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252056", "story_v_out_321252.awb") ~= 0 then
					local var_237_47 = manager.audio:GetVoiceLength("story_v_out_321252", "321252056", "story_v_out_321252.awb") / 1000

					if var_237_47 + var_237_39 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_47 + var_237_39
					end

					if var_237_42.prefab_name ~= "" and arg_234_1.actors_[var_237_42.prefab_name] ~= nil then
						local var_237_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_42.prefab_name].transform, "story_v_out_321252", "321252056", "story_v_out_321252.awb")

						arg_234_1:RecordAudio("321252056", var_237_48)
						arg_234_1:RecordAudio("321252056", var_237_48)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_321252", "321252056", "story_v_out_321252.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_321252", "321252056", "story_v_out_321252.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_49 = math.max(var_237_40, arg_234_1.talkMaxDuration)

			if var_237_39 <= arg_234_1.time_ and arg_234_1.time_ < var_237_39 + var_237_49 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_39) / var_237_49

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_39 + var_237_49 and arg_234_1.time_ < var_237_39 + var_237_49 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_234_1:InitPlayNodeList()
	end,
	Play321252057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 321252057
		arg_238_1.duration_ = 9.4

		local var_238_0 = {
			zh = 9.4,
			ja = 8.3
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play321252058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.875

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[67].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:GetWordFromCfg(321252057)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 35
				local var_241_6 = utf8.len(var_241_4)
				local var_241_7 = var_241_5 <= 0 and var_241_1 or var_241_1 * (var_241_6 / var_241_5)

				if var_241_7 > 0 and var_241_1 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252057", "story_v_out_321252.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_out_321252", "321252057", "story_v_out_321252.awb") / 1000

					if var_241_8 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_0
					end

					if var_241_3.prefab_name ~= "" and arg_238_1.actors_[var_241_3.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_3.prefab_name].transform, "story_v_out_321252", "321252057", "story_v_out_321252.awb")

						arg_238_1:RecordAudio("321252057", var_241_9)
						arg_238_1:RecordAudio("321252057", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_321252", "321252057", "story_v_out_321252.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_321252", "321252057", "story_v_out_321252.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_10 and arg_238_1.time_ < var_241_0 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play321252058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 321252058
		arg_242_1.duration_ = 8.27

		local var_242_0 = {
			zh = 5.766,
			ja = 8.266
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
				arg_242_0:Play321252059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action4_2")
			end

			local var_245_2 = 0
			local var_245_3 = 0.625

			if var_245_2 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_4 = arg_242_1:FormatText(StoryNameCfg[67].name)

				arg_242_1.leftNameTxt_.text = var_245_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_5 = arg_242_1:GetWordFromCfg(321252058)
				local var_245_6 = arg_242_1:FormatText(var_245_5.content)

				arg_242_1.text_.text = var_245_6

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_7 = 25
				local var_245_8 = utf8.len(var_245_6)
				local var_245_9 = var_245_7 <= 0 and var_245_3 or var_245_3 * (var_245_8 / var_245_7)

				if var_245_9 > 0 and var_245_3 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_2
					end
				end

				arg_242_1.text_.text = var_245_6
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252058", "story_v_out_321252.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_out_321252", "321252058", "story_v_out_321252.awb") / 1000

					if var_245_10 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_2
					end

					if var_245_5.prefab_name ~= "" and arg_242_1.actors_[var_245_5.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_5.prefab_name].transform, "story_v_out_321252", "321252058", "story_v_out_321252.awb")

						arg_242_1:RecordAudio("321252058", var_245_11)
						arg_242_1:RecordAudio("321252058", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_321252", "321252058", "story_v_out_321252.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_321252", "321252058", "story_v_out_321252.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_12 = math.max(var_245_3, arg_242_1.talkMaxDuration)

			if var_245_2 <= arg_242_1.time_ and arg_242_1.time_ < var_245_2 + var_245_12 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_2) / var_245_12

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_2 + var_245_12 and arg_242_1.time_ < var_245_2 + var_245_12 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play321252059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 321252059
		arg_246_1.duration_ = 2

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play321252060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["10131ui_story"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos10131ui_story = var_249_0.localPosition
			end

			local var_249_2 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2
				local var_249_4 = Vector3.New(0.05, -0.96, -5.8)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10131ui_story, var_249_4, var_249_3)

				local var_249_5 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_5.x, var_249_5.y, var_249_5.z)

				local var_249_6 = var_249_0.localEulerAngles

				var_249_6.z = 0
				var_249_6.x = 0
				var_249_0.localEulerAngles = var_249_6
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0.05, -0.96, -5.8)

				local var_249_7 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_7.x, var_249_7.y, var_249_7.z)

				local var_249_8 = var_249_0.localEulerAngles

				var_249_8.z = 0
				var_249_8.x = 0
				var_249_0.localEulerAngles = var_249_8
			end

			local var_249_9 = arg_246_1.actors_["1111ui_story"].transform
			local var_249_10 = 0

			if var_249_10 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 then
				arg_246_1.var_.moveOldPos1111ui_story = var_249_9.localPosition
			end

			local var_249_11 = 0.001

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_11 then
				local var_249_12 = (arg_246_1.time_ - var_249_10) / var_249_11
				local var_249_13 = Vector3.New(0, 100, 0)

				var_249_9.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1111ui_story, var_249_13, var_249_12)

				local var_249_14 = manager.ui.mainCamera.transform.position - var_249_9.position

				var_249_9.forward = Vector3.New(var_249_14.x, var_249_14.y, var_249_14.z)

				local var_249_15 = var_249_9.localEulerAngles

				var_249_15.z = 0
				var_249_15.x = 0
				var_249_9.localEulerAngles = var_249_15
			end

			if arg_246_1.time_ >= var_249_10 + var_249_11 and arg_246_1.time_ < var_249_10 + var_249_11 + arg_249_0 then
				var_249_9.localPosition = Vector3.New(0, 100, 0)

				local var_249_16 = manager.ui.mainCamera.transform.position - var_249_9.position

				var_249_9.forward = Vector3.New(var_249_16.x, var_249_16.y, var_249_16.z)

				local var_249_17 = var_249_9.localEulerAngles

				var_249_17.z = 0
				var_249_17.x = 0
				var_249_9.localEulerAngles = var_249_17
			end

			local var_249_18 = arg_246_1.actors_["10131ui_story"]
			local var_249_19 = 0

			if var_249_19 < arg_246_1.time_ and arg_246_1.time_ <= var_249_19 + arg_249_0 and not isNil(var_249_18) and arg_246_1.var_.characterEffect10131ui_story == nil then
				arg_246_1.var_.characterEffect10131ui_story = var_249_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_20 = 0.200000002980232

			if var_249_19 <= arg_246_1.time_ and arg_246_1.time_ < var_249_19 + var_249_20 and not isNil(var_249_18) then
				local var_249_21 = (arg_246_1.time_ - var_249_19) / var_249_20

				if arg_246_1.var_.characterEffect10131ui_story and not isNil(var_249_18) then
					arg_246_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_19 + var_249_20 and arg_246_1.time_ < var_249_19 + var_249_20 + arg_249_0 and not isNil(var_249_18) and arg_246_1.var_.characterEffect10131ui_story then
				arg_246_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_249_22 = arg_246_1.actors_["1111ui_story"]
			local var_249_23 = 0

			if var_249_23 < arg_246_1.time_ and arg_246_1.time_ <= var_249_23 + arg_249_0 and not isNil(var_249_22) and arg_246_1.var_.characterEffect1111ui_story == nil then
				arg_246_1.var_.characterEffect1111ui_story = var_249_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_24 = 0.200000002980232

			if var_249_23 <= arg_246_1.time_ and arg_246_1.time_ < var_249_23 + var_249_24 and not isNil(var_249_22) then
				local var_249_25 = (arg_246_1.time_ - var_249_23) / var_249_24

				if arg_246_1.var_.characterEffect1111ui_story and not isNil(var_249_22) then
					local var_249_26 = Mathf.Lerp(0, 0.5, var_249_25)

					arg_246_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1111ui_story.fillRatio = var_249_26
				end
			end

			if arg_246_1.time_ >= var_249_23 + var_249_24 and arg_246_1.time_ < var_249_23 + var_249_24 + arg_249_0 and not isNil(var_249_22) and arg_246_1.var_.characterEffect1111ui_story then
				local var_249_27 = 0.5

				arg_246_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1111ui_story.fillRatio = var_249_27
			end

			local var_249_28 = 0

			if var_249_28 < arg_246_1.time_ and arg_246_1.time_ <= var_249_28 + arg_249_0 then
				arg_246_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_249_29 = 0
			local var_249_30 = 0.1

			if var_249_29 < arg_246_1.time_ and arg_246_1.time_ <= var_249_29 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_31 = arg_246_1:FormatText(StoryNameCfg[1178].name)

				arg_246_1.leftNameTxt_.text = var_249_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_32 = arg_246_1:GetWordFromCfg(321252059)
				local var_249_33 = arg_246_1:FormatText(var_249_32.content)

				arg_246_1.text_.text = var_249_33

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_34 = 4
				local var_249_35 = utf8.len(var_249_33)
				local var_249_36 = var_249_34 <= 0 and var_249_30 or var_249_30 * (var_249_35 / var_249_34)

				if var_249_36 > 0 and var_249_30 < var_249_36 then
					arg_246_1.talkMaxDuration = var_249_36

					if var_249_36 + var_249_29 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_36 + var_249_29
					end
				end

				arg_246_1.text_.text = var_249_33
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252059", "story_v_out_321252.awb") ~= 0 then
					local var_249_37 = manager.audio:GetVoiceLength("story_v_out_321252", "321252059", "story_v_out_321252.awb") / 1000

					if var_249_37 + var_249_29 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_37 + var_249_29
					end

					if var_249_32.prefab_name ~= "" and arg_246_1.actors_[var_249_32.prefab_name] ~= nil then
						local var_249_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_32.prefab_name].transform, "story_v_out_321252", "321252059", "story_v_out_321252.awb")

						arg_246_1:RecordAudio("321252059", var_249_38)
						arg_246_1:RecordAudio("321252059", var_249_38)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_321252", "321252059", "story_v_out_321252.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_321252", "321252059", "story_v_out_321252.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_39 = math.max(var_249_30, arg_246_1.talkMaxDuration)

			if var_249_29 <= arg_246_1.time_ and arg_246_1.time_ < var_249_29 + var_249_39 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_29) / var_249_39

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_29 + var_249_39 and arg_246_1.time_ < var_249_29 + var_249_39 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play321252060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 321252060
		arg_250_1.duration_ = 5.6

		local var_250_0 = {
			zh = 3.533,
			ja = 5.6
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
				arg_250_0:Play321252061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10131ui_story"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos10131ui_story = var_253_0.localPosition
			end

			local var_253_2 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2
				local var_253_4 = Vector3.New(0.05, -0.96, -5.8)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10131ui_story, var_253_4, var_253_3)

				local var_253_5 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_5.x, var_253_5.y, var_253_5.z)

				local var_253_6 = var_253_0.localEulerAngles

				var_253_6.z = 0
				var_253_6.x = 0
				var_253_0.localEulerAngles = var_253_6
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(0.05, -0.96, -5.8)

				local var_253_7 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_7.x, var_253_7.y, var_253_7.z)

				local var_253_8 = var_253_0.localEulerAngles

				var_253_8.z = 0
				var_253_8.x = 0
				var_253_0.localEulerAngles = var_253_8
			end

			local var_253_9 = arg_250_1.actors_["10131ui_story"]
			local var_253_10 = 0

			if var_253_10 < arg_250_1.time_ and arg_250_1.time_ <= var_253_10 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect10131ui_story == nil then
				arg_250_1.var_.characterEffect10131ui_story = var_253_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_11 = 0.200000002980232

			if var_253_10 <= arg_250_1.time_ and arg_250_1.time_ < var_253_10 + var_253_11 and not isNil(var_253_9) then
				local var_253_12 = (arg_250_1.time_ - var_253_10) / var_253_11

				if arg_250_1.var_.characterEffect10131ui_story and not isNil(var_253_9) then
					local var_253_13 = Mathf.Lerp(0, 0.5, var_253_12)

					arg_250_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_250_1.var_.characterEffect10131ui_story.fillRatio = var_253_13
				end
			end

			if arg_250_1.time_ >= var_253_10 + var_253_11 and arg_250_1.time_ < var_253_10 + var_253_11 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect10131ui_story then
				local var_253_14 = 0.5

				arg_250_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_250_1.var_.characterEffect10131ui_story.fillRatio = var_253_14
			end

			local var_253_15 = 0
			local var_253_16 = 0.425

			if var_253_15 < arg_250_1.time_ and arg_250_1.time_ <= var_253_15 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_17 = arg_250_1:FormatText(StoryNameCfg[67].name)

				arg_250_1.leftNameTxt_.text = var_253_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_18 = arg_250_1:GetWordFromCfg(321252060)
				local var_253_19 = arg_250_1:FormatText(var_253_18.content)

				arg_250_1.text_.text = var_253_19

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_20 = 17
				local var_253_21 = utf8.len(var_253_19)
				local var_253_22 = var_253_20 <= 0 and var_253_16 or var_253_16 * (var_253_21 / var_253_20)

				if var_253_22 > 0 and var_253_16 < var_253_22 then
					arg_250_1.talkMaxDuration = var_253_22

					if var_253_22 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_22 + var_253_15
					end
				end

				arg_250_1.text_.text = var_253_19
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252060", "story_v_out_321252.awb") ~= 0 then
					local var_253_23 = manager.audio:GetVoiceLength("story_v_out_321252", "321252060", "story_v_out_321252.awb") / 1000

					if var_253_23 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_23 + var_253_15
					end

					if var_253_18.prefab_name ~= "" and arg_250_1.actors_[var_253_18.prefab_name] ~= nil then
						local var_253_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_18.prefab_name].transform, "story_v_out_321252", "321252060", "story_v_out_321252.awb")

						arg_250_1:RecordAudio("321252060", var_253_24)
						arg_250_1:RecordAudio("321252060", var_253_24)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_321252", "321252060", "story_v_out_321252.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_321252", "321252060", "story_v_out_321252.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_25 = math.max(var_253_16, arg_250_1.talkMaxDuration)

			if var_253_15 <= arg_250_1.time_ and arg_250_1.time_ < var_253_15 + var_253_25 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_15) / var_253_25

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_15 + var_253_25 and arg_250_1.time_ < var_253_15 + var_253_25 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play321252061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 321252061
		arg_254_1.duration_ = 2

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play321252062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["10131ui_story"].transform
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.var_.moveOldPos10131ui_story = var_257_0.localPosition
			end

			local var_257_2 = 0.001

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2
				local var_257_4 = Vector3.New(0.05, -0.96, -5.8)

				var_257_0.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10131ui_story, var_257_4, var_257_3)

				local var_257_5 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_5.x, var_257_5.y, var_257_5.z)

				local var_257_6 = var_257_0.localEulerAngles

				var_257_6.z = 0
				var_257_6.x = 0
				var_257_0.localEulerAngles = var_257_6
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 then
				var_257_0.localPosition = Vector3.New(0.05, -0.96, -5.8)

				local var_257_7 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_7.x, var_257_7.y, var_257_7.z)

				local var_257_8 = var_257_0.localEulerAngles

				var_257_8.z = 0
				var_257_8.x = 0
				var_257_0.localEulerAngles = var_257_8
			end

			local var_257_9 = arg_254_1.actors_["10131ui_story"]
			local var_257_10 = 0

			if var_257_10 < arg_254_1.time_ and arg_254_1.time_ <= var_257_10 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect10131ui_story == nil then
				arg_254_1.var_.characterEffect10131ui_story = var_257_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_11 = 0.200000002980232

			if var_257_10 <= arg_254_1.time_ and arg_254_1.time_ < var_257_10 + var_257_11 and not isNil(var_257_9) then
				local var_257_12 = (arg_254_1.time_ - var_257_10) / var_257_11

				if arg_254_1.var_.characterEffect10131ui_story and not isNil(var_257_9) then
					arg_254_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_10 + var_257_11 and arg_254_1.time_ < var_257_10 + var_257_11 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect10131ui_story then
				arg_254_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_257_13 = arg_254_1.actors_["1111ui_story"]
			local var_257_14 = 0

			if var_257_14 < arg_254_1.time_ and arg_254_1.time_ <= var_257_14 + arg_257_0 and not isNil(var_257_13) and arg_254_1.var_.characterEffect1111ui_story == nil then
				arg_254_1.var_.characterEffect1111ui_story = var_257_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_15 = 0.200000002980232

			if var_257_14 <= arg_254_1.time_ and arg_254_1.time_ < var_257_14 + var_257_15 and not isNil(var_257_13) then
				local var_257_16 = (arg_254_1.time_ - var_257_14) / var_257_15

				if arg_254_1.var_.characterEffect1111ui_story and not isNil(var_257_13) then
					local var_257_17 = Mathf.Lerp(0, 0.5, var_257_16)

					arg_254_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1111ui_story.fillRatio = var_257_17
				end
			end

			if arg_254_1.time_ >= var_257_14 + var_257_15 and arg_254_1.time_ < var_257_14 + var_257_15 + arg_257_0 and not isNil(var_257_13) and arg_254_1.var_.characterEffect1111ui_story then
				local var_257_18 = 0.5

				arg_254_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1111ui_story.fillRatio = var_257_18
			end

			local var_257_19 = 0

			if var_257_19 < arg_254_1.time_ and arg_254_1.time_ <= var_257_19 + arg_257_0 then
				arg_254_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_257_20 = 0

			if var_257_20 < arg_254_1.time_ and arg_254_1.time_ <= var_257_20 + arg_257_0 then
				arg_254_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_257_21 = arg_254_1.actors_["1111ui_story"].transform
			local var_257_22 = 0

			if var_257_22 < arg_254_1.time_ and arg_254_1.time_ <= var_257_22 + arg_257_0 then
				arg_254_1.var_.moveOldPos1111ui_story = var_257_21.localPosition
			end

			local var_257_23 = 0.001

			if var_257_22 <= arg_254_1.time_ and arg_254_1.time_ < var_257_22 + var_257_23 then
				local var_257_24 = (arg_254_1.time_ - var_257_22) / var_257_23
				local var_257_25 = Vector3.New(0, 100, 0)

				var_257_21.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1111ui_story, var_257_25, var_257_24)

				local var_257_26 = manager.ui.mainCamera.transform.position - var_257_21.position

				var_257_21.forward = Vector3.New(var_257_26.x, var_257_26.y, var_257_26.z)

				local var_257_27 = var_257_21.localEulerAngles

				var_257_27.z = 0
				var_257_27.x = 0
				var_257_21.localEulerAngles = var_257_27
			end

			if arg_254_1.time_ >= var_257_22 + var_257_23 and arg_254_1.time_ < var_257_22 + var_257_23 + arg_257_0 then
				var_257_21.localPosition = Vector3.New(0, 100, 0)

				local var_257_28 = manager.ui.mainCamera.transform.position - var_257_21.position

				var_257_21.forward = Vector3.New(var_257_28.x, var_257_28.y, var_257_28.z)

				local var_257_29 = var_257_21.localEulerAngles

				var_257_29.z = 0
				var_257_29.x = 0
				var_257_21.localEulerAngles = var_257_29
			end

			local var_257_30 = 0
			local var_257_31 = 0.1

			if var_257_30 < arg_254_1.time_ and arg_254_1.time_ <= var_257_30 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_32 = arg_254_1:FormatText(StoryNameCfg[1178].name)

				arg_254_1.leftNameTxt_.text = var_257_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_33 = arg_254_1:GetWordFromCfg(321252061)
				local var_257_34 = arg_254_1:FormatText(var_257_33.content)

				arg_254_1.text_.text = var_257_34

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_35 = 4
				local var_257_36 = utf8.len(var_257_34)
				local var_257_37 = var_257_35 <= 0 and var_257_31 or var_257_31 * (var_257_36 / var_257_35)

				if var_257_37 > 0 and var_257_31 < var_257_37 then
					arg_254_1.talkMaxDuration = var_257_37

					if var_257_37 + var_257_30 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_37 + var_257_30
					end
				end

				arg_254_1.text_.text = var_257_34
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252061", "story_v_out_321252.awb") ~= 0 then
					local var_257_38 = manager.audio:GetVoiceLength("story_v_out_321252", "321252061", "story_v_out_321252.awb") / 1000

					if var_257_38 + var_257_30 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_38 + var_257_30
					end

					if var_257_33.prefab_name ~= "" and arg_254_1.actors_[var_257_33.prefab_name] ~= nil then
						local var_257_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_33.prefab_name].transform, "story_v_out_321252", "321252061", "story_v_out_321252.awb")

						arg_254_1:RecordAudio("321252061", var_257_39)
						arg_254_1:RecordAudio("321252061", var_257_39)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_321252", "321252061", "story_v_out_321252.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_321252", "321252061", "story_v_out_321252.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_40 = math.max(var_257_31, arg_254_1.talkMaxDuration)

			if var_257_30 <= arg_254_1.time_ and arg_254_1.time_ < var_257_30 + var_257_40 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_30) / var_257_40

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_30 + var_257_40 and arg_254_1.time_ < var_257_30 + var_257_40 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play321252062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 321252062
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play321252063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["10131ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect10131ui_story == nil then
				arg_258_1.var_.characterEffect10131ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect10131ui_story and not isNil(var_261_0) then
					local var_261_4 = Mathf.Lerp(0, 0.5, var_261_3)

					arg_258_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_258_1.var_.characterEffect10131ui_story.fillRatio = var_261_4
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect10131ui_story then
				local var_261_5 = 0.5

				arg_258_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_258_1.var_.characterEffect10131ui_story.fillRatio = var_261_5
			end

			local var_261_6 = 0
			local var_261_7 = 0.95

			if var_261_6 < arg_258_1.time_ and arg_258_1.time_ <= var_261_6 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_8 = arg_258_1:GetWordFromCfg(321252062)
				local var_261_9 = arg_258_1:FormatText(var_261_8.content)

				arg_258_1.text_.text = var_261_9

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_10 = 38
				local var_261_11 = utf8.len(var_261_9)
				local var_261_12 = var_261_10 <= 0 and var_261_7 or var_261_7 * (var_261_11 / var_261_10)

				if var_261_12 > 0 and var_261_7 < var_261_12 then
					arg_258_1.talkMaxDuration = var_261_12

					if var_261_12 + var_261_6 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_6
					end
				end

				arg_258_1.text_.text = var_261_9
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_13 = math.max(var_261_7, arg_258_1.talkMaxDuration)

			if var_261_6 <= arg_258_1.time_ and arg_258_1.time_ < var_261_6 + var_261_13 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_6) / var_261_13

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_6 + var_261_13 and arg_258_1.time_ < var_261_6 + var_261_13 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play321252063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 321252063
		arg_262_1.duration_ = 3.1

		local var_262_0 = {
			zh = 2.333,
			ja = 3.1
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
				arg_262_0:Play321252064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["10131ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect10131ui_story == nil then
				arg_262_1.var_.characterEffect10131ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect10131ui_story and not isNil(var_265_0) then
					arg_262_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect10131ui_story then
				arg_262_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_265_4 = 0
			local var_265_5 = 0.275

			if var_265_4 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_6 = arg_262_1:FormatText(StoryNameCfg[1178].name)

				arg_262_1.leftNameTxt_.text = var_265_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_7 = arg_262_1:GetWordFromCfg(321252063)
				local var_265_8 = arg_262_1:FormatText(var_265_7.content)

				arg_262_1.text_.text = var_265_8

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_9 = 11
				local var_265_10 = utf8.len(var_265_8)
				local var_265_11 = var_265_9 <= 0 and var_265_5 or var_265_5 * (var_265_10 / var_265_9)

				if var_265_11 > 0 and var_265_5 < var_265_11 then
					arg_262_1.talkMaxDuration = var_265_11

					if var_265_11 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_11 + var_265_4
					end
				end

				arg_262_1.text_.text = var_265_8
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252063", "story_v_out_321252.awb") ~= 0 then
					local var_265_12 = manager.audio:GetVoiceLength("story_v_out_321252", "321252063", "story_v_out_321252.awb") / 1000

					if var_265_12 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_12 + var_265_4
					end

					if var_265_7.prefab_name ~= "" and arg_262_1.actors_[var_265_7.prefab_name] ~= nil then
						local var_265_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_7.prefab_name].transform, "story_v_out_321252", "321252063", "story_v_out_321252.awb")

						arg_262_1:RecordAudio("321252063", var_265_13)
						arg_262_1:RecordAudio("321252063", var_265_13)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_321252", "321252063", "story_v_out_321252.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_321252", "321252063", "story_v_out_321252.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_14 = math.max(var_265_5, arg_262_1.talkMaxDuration)

			if var_265_4 <= arg_262_1.time_ and arg_262_1.time_ < var_265_4 + var_265_14 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_4) / var_265_14

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_4 + var_265_14 and arg_262_1.time_ < var_265_4 + var_265_14 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play321252064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 321252064
		arg_266_1.duration_ = 5.63

		local var_266_0 = {
			zh = 5.633,
			ja = 5.2
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
			arg_266_1.auto_ = false
		end

		function arg_266_1.playNext_(arg_268_0)
			arg_266_1.onStoryFinished_()
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_269_2 = 0
			local var_269_3 = 0.525

			if var_269_2 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_4 = arg_266_1:FormatText(StoryNameCfg[1178].name)

				arg_266_1.leftNameTxt_.text = var_269_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_5 = arg_266_1:GetWordFromCfg(321252064)
				local var_269_6 = arg_266_1:FormatText(var_269_5.content)

				arg_266_1.text_.text = var_269_6

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_7 = 21
				local var_269_8 = utf8.len(var_269_6)
				local var_269_9 = var_269_7 <= 0 and var_269_3 or var_269_3 * (var_269_8 / var_269_7)

				if var_269_9 > 0 and var_269_3 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_2
					end
				end

				arg_266_1.text_.text = var_269_6
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321252", "321252064", "story_v_out_321252.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_out_321252", "321252064", "story_v_out_321252.awb") / 1000

					if var_269_10 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_2
					end

					if var_269_5.prefab_name ~= "" and arg_266_1.actors_[var_269_5.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_5.prefab_name].transform, "story_v_out_321252", "321252064", "story_v_out_321252.awb")

						arg_266_1:RecordAudio("321252064", var_269_11)
						arg_266_1:RecordAudio("321252064", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_321252", "321252064", "story_v_out_321252.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_321252", "321252064", "story_v_out_321252.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_3, arg_266_1.talkMaxDuration)

			if var_269_2 <= arg_266_1.time_ and arg_266_1.time_ < var_269_2 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_2) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_2 + var_269_12 and arg_266_1.time_ < var_269_2 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L12f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L09h"
	},
	voices = {
		"story_v_out_321252.awb"
	}
}
