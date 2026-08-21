return {
	Play322041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322041001
		arg_1_1.duration_ = 12.57

		local var_1_0 = {
			zh = 8.765999999999,
			ja = 12.565999999999
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
				arg_1_0:Play322041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L01h"

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
				local var_4_5 = arg_1_1.bgs_.L01h

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
					if iter_4_0 ~= "L01h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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
			local var_4_25 = 0.3

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

			local var_4_30 = 0.4
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

			local var_4_36 = 0.166666666666667
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 1.999999999999
			local var_4_41 = 0.55

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_43 = arg_1_1:FormatText(StoryNameCfg[1167].name)

				arg_1_1.leftNameTxt_.text = var_4_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_1_1.callingController_:SetSelectedState("calling")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_44 = arg_1_1:GetWordFromCfg(322041001)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.text_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_46 = 22
				local var_4_47 = utf8.len(var_4_45)
				local var_4_48 = var_4_46 <= 0 and var_4_41 or var_4_41 * (var_4_47 / var_4_46)

				if var_4_48 > 0 and var_4_41 < var_4_48 then
					arg_1_1.talkMaxDuration = var_4_48
					var_4_40 = var_4_40 + 0.3

					if var_4_48 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_48 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_45
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041001", "story_v_out_322041.awb") ~= 0 then
					local var_4_49 = manager.audio:GetVoiceLength("story_v_out_322041", "322041001", "story_v_out_322041.awb") / 1000

					if var_4_49 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_49 + var_4_40
					end

					if var_4_44.prefab_name ~= "" and arg_1_1.actors_[var_4_44.prefab_name] ~= nil then
						local var_4_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_44.prefab_name].transform, "story_v_out_322041", "322041001", "story_v_out_322041.awb")

						arg_1_1:RecordAudio("322041001", var_4_50)
						arg_1_1:RecordAudio("322041001", var_4_50)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322041", "322041001", "story_v_out_322041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322041", "322041001", "story_v_out_322041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_51 = var_4_40 + 0.3
			local var_4_52 = math.max(var_4_41, arg_1_1.talkMaxDuration)

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
	Play322041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322041002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.225

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(322041002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 49
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play322041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322041003
		arg_13_1.duration_ = 2.87

		local var_13_0 = {
			zh = 1.999999999999,
			ja = 2.866
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
				arg_13_0:Play322041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1284ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1284ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1284ui_story = var_16_5.localPosition

				local var_16_7 = "1284ui_story"

				arg_13_1:ShowWeapon(arg_13_1.var_[var_16_7 .. "Animator"].transform, false)
			end

			local var_16_8 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_6) / var_16_8
				local var_16_10 = Vector3.New(0, -0.985, -6.22)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1284ui_story, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_5.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_5.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_6 + var_16_8 and arg_13_1.time_ < var_16_6 + var_16_8 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_16_13 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_13.x, var_16_13.y, var_16_13.z)

				local var_16_14 = var_16_5.localEulerAngles

				var_16_14.z = 0
				var_16_14.x = 0
				var_16_5.localEulerAngles = var_16_14
			end

			local var_16_15 = arg_13_1.actors_["1284ui_story"]
			local var_16_16 = 0

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect1284ui_story == nil then
				arg_13_1.var_.characterEffect1284ui_story = var_16_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_17 = 0.200000002980232

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_17 and not isNil(var_16_15) then
				local var_16_18 = (arg_13_1.time_ - var_16_16) / var_16_17

				if arg_13_1.var_.characterEffect1284ui_story and not isNil(var_16_15) then
					arg_13_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect1284ui_story then
				arg_13_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_21 = 0
			local var_16_22 = 0.2

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_23 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_24 = arg_13_1:GetWordFromCfg(322041003)
				local var_16_25 = arg_13_1:FormatText(var_16_24.content)

				arg_13_1.text_.text = var_16_25

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_26 = 8
				local var_16_27 = utf8.len(var_16_25)
				local var_16_28 = var_16_26 <= 0 and var_16_22 or var_16_22 * (var_16_27 / var_16_26)

				if var_16_28 > 0 and var_16_22 < var_16_28 then
					arg_13_1.talkMaxDuration = var_16_28

					if var_16_28 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_21
					end
				end

				arg_13_1.text_.text = var_16_25
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041003", "story_v_out_322041.awb") ~= 0 then
					local var_16_29 = manager.audio:GetVoiceLength("story_v_out_322041", "322041003", "story_v_out_322041.awb") / 1000

					if var_16_29 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_29 + var_16_21
					end

					if var_16_24.prefab_name ~= "" and arg_13_1.actors_[var_16_24.prefab_name] ~= nil then
						local var_16_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_24.prefab_name].transform, "story_v_out_322041", "322041003", "story_v_out_322041.awb")

						arg_13_1:RecordAudio("322041003", var_16_30)
						arg_13_1:RecordAudio("322041003", var_16_30)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322041", "322041003", "story_v_out_322041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322041", "322041003", "story_v_out_322041.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_31 = math.max(var_16_22, arg_13_1.talkMaxDuration)

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_31 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_21) / var_16_31

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_21 + var_16_31 and arg_13_1.time_ < var_16_21 + var_16_31 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322041004
		arg_17_1.duration_ = 11.67

		local var_17_0 = {
			zh = 6.933,
			ja = 11.666
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
				arg_17_0:Play322041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1284ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1284ui_story == nil then
				arg_17_1.var_.characterEffect1284ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1284ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1284ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1284ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1284ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.975

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[1167].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_17_1.callingController_:SetSelectedState("calling")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(322041004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041004", "story_v_out_322041.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_322041", "322041004", "story_v_out_322041.awb") / 1000

					if var_20_14 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_6
					end

					if var_20_9.prefab_name ~= "" and arg_17_1.actors_[var_20_9.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_9.prefab_name].transform, "story_v_out_322041", "322041004", "story_v_out_322041.awb")

						arg_17_1:RecordAudio("322041004", var_20_15)
						arg_17_1:RecordAudio("322041004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_322041", "322041004", "story_v_out_322041.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_322041", "322041004", "story_v_out_322041.awb")
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
	Play322041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322041005
		arg_21_1.duration_ = 15.3

		local var_21_0 = {
			zh = 8.133,
			ja = 15.3
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
				arg_21_0:Play322041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.075

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[1167].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_21_1.callingController_:SetSelectedState("calling")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(322041005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041005", "story_v_out_322041.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_322041", "322041005", "story_v_out_322041.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_322041", "322041005", "story_v_out_322041.awb")

						arg_21_1:RecordAudio("322041005", var_24_9)
						arg_21_1:RecordAudio("322041005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_322041", "322041005", "story_v_out_322041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_322041", "322041005", "story_v_out_322041.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play322041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322041006
		arg_25_1.duration_ = 4.47

		local var_25_0 = {
			zh = 2.933,
			ja = 4.466
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
				arg_25_0:Play322041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1284ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1284ui_story == nil then
				arg_25_1.var_.characterEffect1284ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1284ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1284ui_story then
				arg_25_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_6 = 0
			local var_28_7 = 0.4

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[6].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(322041006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041006", "story_v_out_322041.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_322041", "322041006", "story_v_out_322041.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_322041", "322041006", "story_v_out_322041.awb")

						arg_25_1:RecordAudio("322041006", var_28_15)
						arg_25_1:RecordAudio("322041006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322041", "322041006", "story_v_out_322041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322041", "322041006", "story_v_out_322041.awb")
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
	Play322041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322041007
		arg_29_1.duration_ = 9.13

		local var_29_0 = {
			zh = 5.466,
			ja = 9.133
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
				arg_29_0:Play322041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1284ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1284ui_story == nil then
				arg_29_1.var_.characterEffect1284ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1284ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1284ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1284ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1284ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.675

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[1167].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_29_1.callingController_:SetSelectedState("calling")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_9 = arg_29_1:GetWordFromCfg(322041007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041007", "story_v_out_322041.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_322041", "322041007", "story_v_out_322041.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_322041", "322041007", "story_v_out_322041.awb")

						arg_29_1:RecordAudio("322041007", var_32_15)
						arg_29_1:RecordAudio("322041007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322041", "322041007", "story_v_out_322041.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322041", "322041007", "story_v_out_322041.awb")
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
	Play322041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322041008
		arg_33_1.duration_ = 4.73

		local var_33_0 = {
			zh = 4.566,
			ja = 4.733
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
				arg_33_0:Play322041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1284ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1284ui_story == nil then
				arg_33_1.var_.characterEffect1284ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1284ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1284ui_story then
				arg_33_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action6_1")
			end

			local var_36_5 = 0
			local var_36_6 = 0.65

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_7 = arg_33_1:FormatText(StoryNameCfg[6].name)

				arg_33_1.leftNameTxt_.text = var_36_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(322041008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 26
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_6 or var_36_6 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_6 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041008", "story_v_out_322041.awb") ~= 0 then
					local var_36_13 = manager.audio:GetVoiceLength("story_v_out_322041", "322041008", "story_v_out_322041.awb") / 1000

					if var_36_13 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_5
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_322041", "322041008", "story_v_out_322041.awb")

						arg_33_1:RecordAudio("322041008", var_36_14)
						arg_33_1:RecordAudio("322041008", var_36_14)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322041", "322041008", "story_v_out_322041.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322041", "322041008", "story_v_out_322041.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_15 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_15 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_15

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_15 and arg_33_1.time_ < var_36_5 + var_36_15 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322041009
		arg_37_1.duration_ = 5.77

		local var_37_0 = {
			zh = 4.566,
			ja = 5.766
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
				arg_37_0:Play322041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1284ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1284ui_story == nil then
				arg_37_1.var_.characterEffect1284ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1284ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1284ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1284ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1284ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.55

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[1167].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_37_1.callingController_:SetSelectedState("calling")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_9 = arg_37_1:GetWordFromCfg(322041009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041009", "story_v_out_322041.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_322041", "322041009", "story_v_out_322041.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_out_322041", "322041009", "story_v_out_322041.awb")

						arg_37_1:RecordAudio("322041009", var_40_15)
						arg_37_1:RecordAudio("322041009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322041", "322041009", "story_v_out_322041.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322041", "322041009", "story_v_out_322041.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_16 and arg_37_1.time_ < var_40_6 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play322041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322041010
		arg_41_1.duration_ = 9.87

		local var_41_0 = {
			zh = 6.5,
			ja = 9.866
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
				arg_41_0:Play322041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.8

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1167].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_41_1.callingController_:SetSelectedState("calling")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(322041010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041010", "story_v_out_322041.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_322041", "322041010", "story_v_out_322041.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_322041", "322041010", "story_v_out_322041.awb")

						arg_41_1:RecordAudio("322041010", var_44_9)
						arg_41_1:RecordAudio("322041010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322041", "322041010", "story_v_out_322041.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322041", "322041010", "story_v_out_322041.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322041011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1284ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1284ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1284ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, 100, 0)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = 0.1
			local var_48_10 = 1

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				local var_48_11 = "play"
				local var_48_12 = "effect"

				arg_45_1:AudioAction(var_48_11, var_48_12, "se_story_145", "se_story_145_ui01", "")
			end

			local var_48_13 = 0
			local var_48_14 = 1.325

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_15 = arg_45_1:GetWordFromCfg(322041011)
				local var_48_16 = arg_45_1:FormatText(var_48_15.content)

				arg_45_1.text_.text = var_48_16

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_17 = 53
				local var_48_18 = utf8.len(var_48_16)
				local var_48_19 = var_48_17 <= 0 and var_48_14 or var_48_14 * (var_48_18 / var_48_17)

				if var_48_19 > 0 and var_48_14 < var_48_19 then
					arg_45_1.talkMaxDuration = var_48_19

					if var_48_19 + var_48_13 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_13
					end
				end

				arg_45_1.text_.text = var_48_16
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_20 = math.max(var_48_14, arg_45_1.talkMaxDuration)

			if var_48_13 <= arg_45_1.time_ and arg_45_1.time_ < var_48_13 + var_48_20 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_13) / var_48_20

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_13 + var_48_20 and arg_45_1.time_ < var_48_13 + var_48_20 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322041012
		arg_49_1.duration_ = 2

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1284ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1284ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1284ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["1284ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1284ui_story == nil then
				arg_49_1.var_.characterEffect1284ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect1284ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1284ui_story then
				arg_49_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_52_15 = 0
			local var_52_16 = 0.125

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[6].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(322041012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 5
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041012", "story_v_out_322041.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_322041", "322041012", "story_v_out_322041.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_322041", "322041012", "story_v_out_322041.awb")

						arg_49_1:RecordAudio("322041012", var_52_24)
						arg_49_1:RecordAudio("322041012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322041", "322041012", "story_v_out_322041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322041", "322041012", "story_v_out_322041.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_25 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_25

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_25 and arg_49_1.time_ < var_52_15 + var_52_25 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play322041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322041013
		arg_53_1.duration_ = 6.2

		local var_53_0 = {
			zh = 4.8,
			ja = 6.2
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
				arg_53_0:Play322041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "1156ui_story"

			if arg_53_1.actors_[var_56_0] == nil then
				local var_56_1 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_56_1) then
					local var_56_2 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_53_1.stage_.transform)

					var_56_2.name = var_56_0
					var_56_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_53_1.actors_[var_56_0] = var_56_2

					local var_56_3 = var_56_2:GetComponentInChildren(typeof(CharacterEffect))

					var_56_3.enabled = true

					local var_56_4 = GameObjectTools.GetOrAddComponent(var_56_2, typeof(DynamicBoneHelper))

					if var_56_4 then
						var_56_4:EnableDynamicBone(false)
					end

					arg_53_1:ShowWeapon(var_56_3.transform, false)

					arg_53_1.var_[var_56_0 .. "Animator"] = var_56_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_53_1.var_[var_56_0 .. "Animator"].applyRootMotion = true
					arg_53_1.var_[var_56_0 .. "LipSync"] = var_56_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_56_5 = arg_53_1.actors_["1156ui_story"].transform
			local var_56_6 = 0

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.var_.moveOldPos1156ui_story = var_56_5.localPosition
			end

			local var_56_7 = 0.001

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_7 then
				local var_56_8 = (arg_53_1.time_ - var_56_6) / var_56_7
				local var_56_9 = Vector3.New(0.9, -1.1, -6.18)

				var_56_5.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1156ui_story, var_56_9, var_56_8)

				local var_56_10 = manager.ui.mainCamera.transform.position - var_56_5.position

				var_56_5.forward = Vector3.New(var_56_10.x, var_56_10.y, var_56_10.z)

				local var_56_11 = var_56_5.localEulerAngles

				var_56_11.z = 0
				var_56_11.x = 0
				var_56_5.localEulerAngles = var_56_11
			end

			if arg_53_1.time_ >= var_56_6 + var_56_7 and arg_53_1.time_ < var_56_6 + var_56_7 + arg_56_0 then
				var_56_5.localPosition = Vector3.New(0.9, -1.1, -6.18)

				local var_56_12 = manager.ui.mainCamera.transform.position - var_56_5.position

				var_56_5.forward = Vector3.New(var_56_12.x, var_56_12.y, var_56_12.z)

				local var_56_13 = var_56_5.localEulerAngles

				var_56_13.z = 0
				var_56_13.x = 0
				var_56_5.localEulerAngles = var_56_13
			end

			local var_56_14 = arg_53_1.actors_["1156ui_story"]
			local var_56_15 = 0

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.characterEffect1156ui_story == nil then
				arg_53_1.var_.characterEffect1156ui_story = var_56_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_16 = 0.200000002980232

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_16 and not isNil(var_56_14) then
				local var_56_17 = (arg_53_1.time_ - var_56_15) / var_56_16

				if arg_53_1.var_.characterEffect1156ui_story and not isNil(var_56_14) then
					arg_53_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_15 + var_56_16 and arg_53_1.time_ < var_56_15 + var_56_16 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.characterEffect1156ui_story then
				arg_53_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_56_18 = arg_53_1.actors_["1284ui_story"]
			local var_56_19 = 0

			if var_56_19 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 and not isNil(var_56_18) and arg_53_1.var_.characterEffect1284ui_story == nil then
				arg_53_1.var_.characterEffect1284ui_story = var_56_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_20 = 0.200000002980232

			if var_56_19 <= arg_53_1.time_ and arg_53_1.time_ < var_56_19 + var_56_20 and not isNil(var_56_18) then
				local var_56_21 = (arg_53_1.time_ - var_56_19) / var_56_20

				if arg_53_1.var_.characterEffect1284ui_story and not isNil(var_56_18) then
					local var_56_22 = Mathf.Lerp(0, 0.5, var_56_21)

					arg_53_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1284ui_story.fillRatio = var_56_22
				end
			end

			if arg_53_1.time_ >= var_56_19 + var_56_20 and arg_53_1.time_ < var_56_19 + var_56_20 + arg_56_0 and not isNil(var_56_18) and arg_53_1.var_.characterEffect1284ui_story then
				local var_56_23 = 0.5

				arg_53_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1284ui_story.fillRatio = var_56_23
			end

			local var_56_24 = 0

			if var_56_24 < arg_53_1.time_ and arg_53_1.time_ <= var_56_24 + arg_56_0 then
				arg_53_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_56_25 = 0

			if var_56_25 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 then
				arg_53_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_26 = 0
			local var_56_27 = 0.625

			if var_56_26 < arg_53_1.time_ and arg_53_1.time_ <= var_56_26 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_28 = arg_53_1:FormatText(StoryNameCfg[605].name)

				arg_53_1.leftNameTxt_.text = var_56_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_29 = arg_53_1:GetWordFromCfg(322041013)
				local var_56_30 = arg_53_1:FormatText(var_56_29.content)

				arg_53_1.text_.text = var_56_30

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_31 = 25
				local var_56_32 = utf8.len(var_56_30)
				local var_56_33 = var_56_31 <= 0 and var_56_27 or var_56_27 * (var_56_32 / var_56_31)

				if var_56_33 > 0 and var_56_27 < var_56_33 then
					arg_53_1.talkMaxDuration = var_56_33

					if var_56_33 + var_56_26 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_33 + var_56_26
					end
				end

				arg_53_1.text_.text = var_56_30
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041013", "story_v_out_322041.awb") ~= 0 then
					local var_56_34 = manager.audio:GetVoiceLength("story_v_out_322041", "322041013", "story_v_out_322041.awb") / 1000

					if var_56_34 + var_56_26 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_34 + var_56_26
					end

					if var_56_29.prefab_name ~= "" and arg_53_1.actors_[var_56_29.prefab_name] ~= nil then
						local var_56_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_29.prefab_name].transform, "story_v_out_322041", "322041013", "story_v_out_322041.awb")

						arg_53_1:RecordAudio("322041013", var_56_35)
						arg_53_1:RecordAudio("322041013", var_56_35)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322041", "322041013", "story_v_out_322041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322041", "322041013", "story_v_out_322041.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_36 = math.max(var_56_27, arg_53_1.talkMaxDuration)

			if var_56_26 <= arg_53_1.time_ and arg_53_1.time_ < var_56_26 + var_56_36 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_26) / var_56_36

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_26 + var_56_36 and arg_53_1.time_ < var_56_26 + var_56_36 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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
	Play322041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322041014
		arg_57_1.duration_ = 2.9

		local var_57_0 = {
			zh = 2.7,
			ja = 2.9
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
				arg_57_0:Play322041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.35

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[605].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(322041014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041014", "story_v_out_322041.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_322041", "322041014", "story_v_out_322041.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_322041", "322041014", "story_v_out_322041.awb")

						arg_57_1:RecordAudio("322041014", var_60_9)
						arg_57_1:RecordAudio("322041014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322041", "322041014", "story_v_out_322041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322041", "322041014", "story_v_out_322041.awb")
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
	Play322041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322041015
		arg_61_1.duration_ = 11.13

		local var_61_0 = {
			zh = 7.866,
			ja = 11.133
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
				arg_61_0:Play322041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1284ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1284ui_story == nil then
				arg_61_1.var_.characterEffect1284ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1284ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1284ui_story then
				arg_61_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_64_4 = arg_61_1.actors_["1156ui_story"]
			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1156ui_story == nil then
				arg_61_1.var_.characterEffect1156ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_6 and not isNil(var_64_4) then
				local var_64_7 = (arg_61_1.time_ - var_64_5) / var_64_6

				if arg_61_1.var_.characterEffect1156ui_story and not isNil(var_64_4) then
					local var_64_8 = Mathf.Lerp(0, 0.5, var_64_7)

					arg_61_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1156ui_story.fillRatio = var_64_8
				end
			end

			if arg_61_1.time_ >= var_64_5 + var_64_6 and arg_61_1.time_ < var_64_5 + var_64_6 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1156ui_story then
				local var_64_9 = 0.5

				arg_61_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1156ui_story.fillRatio = var_64_9
			end

			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_64_11 = 0

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_12 = 0
			local var_64_13 = 0.875

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_14 = arg_61_1:FormatText(StoryNameCfg[6].name)

				arg_61_1.leftNameTxt_.text = var_64_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_15 = arg_61_1:GetWordFromCfg(322041015)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 35
				local var_64_18 = utf8.len(var_64_16)
				local var_64_19 = var_64_17 <= 0 and var_64_13 or var_64_13 * (var_64_18 / var_64_17)

				if var_64_19 > 0 and var_64_13 < var_64_19 then
					arg_61_1.talkMaxDuration = var_64_19

					if var_64_19 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_16
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041015", "story_v_out_322041.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_out_322041", "322041015", "story_v_out_322041.awb") / 1000

					if var_64_20 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_12
					end

					if var_64_15.prefab_name ~= "" and arg_61_1.actors_[var_64_15.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_15.prefab_name].transform, "story_v_out_322041", "322041015", "story_v_out_322041.awb")

						arg_61_1:RecordAudio("322041015", var_64_21)
						arg_61_1:RecordAudio("322041015", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322041", "322041015", "story_v_out_322041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322041", "322041015", "story_v_out_322041.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_22 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_22

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_22 and arg_61_1.time_ < var_64_12 + var_64_22 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play322041016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322041016
		arg_65_1.duration_ = 2.8

		local var_65_0 = {
			zh = 2.6,
			ja = 2.8
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
				arg_65_0:Play322041017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1156ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1156ui_story == nil then
				arg_65_1.var_.characterEffect1156ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1156ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1156ui_story then
				arg_65_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1284ui_story"]
			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1284ui_story == nil then
				arg_65_1.var_.characterEffect1284ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.200000002980232

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 and not isNil(var_68_4) then
				local var_68_7 = (arg_65_1.time_ - var_68_5) / var_68_6

				if arg_65_1.var_.characterEffect1284ui_story and not isNil(var_68_4) then
					local var_68_8 = Mathf.Lerp(0, 0.5, var_68_7)

					arg_65_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1284ui_story.fillRatio = var_68_8
				end
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1284ui_story then
				local var_68_9 = 0.5

				arg_65_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1284ui_story.fillRatio = var_68_9
			end

			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_1")
			end

			local var_68_11 = 0

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_68_12 = 0
			local var_68_13 = 0.35

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[605].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(322041016)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 14
				local var_68_18 = utf8.len(var_68_16)
				local var_68_19 = var_68_17 <= 0 and var_68_13 or var_68_13 * (var_68_18 / var_68_17)

				if var_68_19 > 0 and var_68_13 < var_68_19 then
					arg_65_1.talkMaxDuration = var_68_19

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041016", "story_v_out_322041.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_322041", "322041016", "story_v_out_322041.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_322041", "322041016", "story_v_out_322041.awb")

						arg_65_1:RecordAudio("322041016", var_68_21)
						arg_65_1:RecordAudio("322041016", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322041", "322041016", "story_v_out_322041.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322041", "322041016", "story_v_out_322041.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_22 and arg_65_1.time_ < var_68_12 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play322041017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322041017
		arg_69_1.duration_ = 17.9

		local var_69_0 = {
			zh = 9.8,
			ja = 17.9
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
				arg_69_0:Play322041018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.3

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[605].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(322041017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 52
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041017", "story_v_out_322041.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_322041", "322041017", "story_v_out_322041.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_322041", "322041017", "story_v_out_322041.awb")

						arg_69_1:RecordAudio("322041017", var_72_9)
						arg_69_1:RecordAudio("322041017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322041", "322041017", "story_v_out_322041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322041", "322041017", "story_v_out_322041.awb")
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
	Play322041018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322041018
		arg_73_1.duration_ = 13.4

		local var_73_0 = {
			zh = 10.3,
			ja = 13.4
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
				arg_73_0:Play322041019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.2

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[605].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(322041018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041018", "story_v_out_322041.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_322041", "322041018", "story_v_out_322041.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_322041", "322041018", "story_v_out_322041.awb")

						arg_73_1:RecordAudio("322041018", var_76_9)
						arg_73_1:RecordAudio("322041018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_322041", "322041018", "story_v_out_322041.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_322041", "322041018", "story_v_out_322041.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play322041019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322041019
		arg_77_1.duration_ = 9.83

		local var_77_0 = {
			zh = 7.033,
			ja = 9.833
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
				arg_77_0:Play322041020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_2")
			end

			local var_80_1 = 0
			local var_80_2 = 0.875

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_3 = arg_77_1:FormatText(StoryNameCfg[605].name)

				arg_77_1.leftNameTxt_.text = var_80_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(322041019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 35
				local var_80_7 = utf8.len(var_80_5)
				local var_80_8 = var_80_6 <= 0 and var_80_2 or var_80_2 * (var_80_7 / var_80_6)

				if var_80_8 > 0 and var_80_2 < var_80_8 then
					arg_77_1.talkMaxDuration = var_80_8

					if var_80_8 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041019", "story_v_out_322041.awb") ~= 0 then
					local var_80_9 = manager.audio:GetVoiceLength("story_v_out_322041", "322041019", "story_v_out_322041.awb") / 1000

					if var_80_9 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_1
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_322041", "322041019", "story_v_out_322041.awb")

						arg_77_1:RecordAudio("322041019", var_80_10)
						arg_77_1:RecordAudio("322041019", var_80_10)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_322041", "322041019", "story_v_out_322041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_322041", "322041019", "story_v_out_322041.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_11 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_11 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_11

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_11 and arg_77_1.time_ < var_80_1 + var_80_11 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play322041020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 322041020
		arg_81_1.duration_ = 9.57

		local var_81_0 = {
			zh = 8.599999999999,
			ja = 9.565999999999
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
				arg_81_0:Play322041021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = "L10g"

			if arg_81_1.bgs_[var_84_0] == nil then
				local var_84_1 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_84_0)
				var_84_1.name = var_84_0
				var_84_1.transform.parent = arg_81_1.stage_.transform
				var_84_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_[var_84_0] = var_84_1
			end

			local var_84_2 = 2

			if var_84_2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				local var_84_3 = manager.ui.mainCamera.transform.localPosition
				local var_84_4 = Vector3.New(0, 0, 10) + Vector3.New(var_84_3.x, var_84_3.y, 0)
				local var_84_5 = arg_81_1.bgs_.L10g

				var_84_5.transform.localPosition = var_84_4
				var_84_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_6 = var_84_5:GetComponent("SpriteRenderer")

				if var_84_6 and var_84_6.sprite then
					local var_84_7 = (var_84_5.transform.localPosition - var_84_3).z
					local var_84_8 = manager.ui.mainCameraCom_
					local var_84_9 = 2 * var_84_7 * Mathf.Tan(var_84_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_84_10 = var_84_9 * var_84_8.aspect
					local var_84_11 = var_84_6.sprite.bounds.size.x
					local var_84_12 = var_84_6.sprite.bounds.size.y
					local var_84_13 = var_84_10 / var_84_11
					local var_84_14 = var_84_9 / var_84_12
					local var_84_15 = var_84_14 < var_84_13 and var_84_13 or var_84_14

					var_84_5.transform.localScale = Vector3.New(var_84_15, var_84_15, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "L10g" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_16 = 3.999999999999

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			local var_84_17 = 0.3

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end

			local var_84_18 = 0

			if var_84_18 < arg_81_1.time_ and arg_81_1.time_ <= var_84_18 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_19 = 2

			if var_84_18 <= arg_81_1.time_ and arg_81_1.time_ < var_84_18 + var_84_19 then
				local var_84_20 = (arg_81_1.time_ - var_84_18) / var_84_19
				local var_84_21 = Color.New(0, 0, 0)

				var_84_21.a = Mathf.Lerp(0, 1, var_84_20)
				arg_81_1.mask_.color = var_84_21
			end

			if arg_81_1.time_ >= var_84_18 + var_84_19 and arg_81_1.time_ < var_84_18 + var_84_19 + arg_84_0 then
				local var_84_22 = Color.New(0, 0, 0)

				var_84_22.a = 1
				arg_81_1.mask_.color = var_84_22
			end

			local var_84_23 = 2

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_24 = 2

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_24 then
				local var_84_25 = (arg_81_1.time_ - var_84_23) / var_84_24
				local var_84_26 = Color.New(0, 0, 0)

				var_84_26.a = Mathf.Lerp(1, 0, var_84_25)
				arg_81_1.mask_.color = var_84_26
			end

			if arg_81_1.time_ >= var_84_23 + var_84_24 and arg_81_1.time_ < var_84_23 + var_84_24 + arg_84_0 then
				local var_84_27 = Color.New(0, 0, 0)
				local var_84_28 = 0

				arg_81_1.mask_.enabled = false
				var_84_27.a = var_84_28
				arg_81_1.mask_.color = var_84_27
			end

			local var_84_29 = arg_81_1.actors_["1156ui_story"].transform
			local var_84_30 = 1.96599999815226

			if var_84_30 < arg_81_1.time_ and arg_81_1.time_ <= var_84_30 + arg_84_0 then
				arg_81_1.var_.moveOldPos1156ui_story = var_84_29.localPosition
			end

			local var_84_31 = 0.001

			if var_84_30 <= arg_81_1.time_ and arg_81_1.time_ < var_84_30 + var_84_31 then
				local var_84_32 = (arg_81_1.time_ - var_84_30) / var_84_31
				local var_84_33 = Vector3.New(0, 100, 0)

				var_84_29.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1156ui_story, var_84_33, var_84_32)

				local var_84_34 = manager.ui.mainCamera.transform.position - var_84_29.position

				var_84_29.forward = Vector3.New(var_84_34.x, var_84_34.y, var_84_34.z)

				local var_84_35 = var_84_29.localEulerAngles

				var_84_35.z = 0
				var_84_35.x = 0
				var_84_29.localEulerAngles = var_84_35
			end

			if arg_81_1.time_ >= var_84_30 + var_84_31 and arg_81_1.time_ < var_84_30 + var_84_31 + arg_84_0 then
				var_84_29.localPosition = Vector3.New(0, 100, 0)

				local var_84_36 = manager.ui.mainCamera.transform.position - var_84_29.position

				var_84_29.forward = Vector3.New(var_84_36.x, var_84_36.y, var_84_36.z)

				local var_84_37 = var_84_29.localEulerAngles

				var_84_37.z = 0
				var_84_37.x = 0
				var_84_29.localEulerAngles = var_84_37
			end

			local var_84_38 = arg_81_1.actors_["1156ui_story"].transform
			local var_84_39 = 2.9666666696479

			if var_84_39 < arg_81_1.time_ and arg_81_1.time_ <= var_84_39 + arg_84_0 then
				arg_81_1.var_.moveOldPos1156ui_story = var_84_38.localPosition
			end

			local var_84_40 = 0.001

			if var_84_39 <= arg_81_1.time_ and arg_81_1.time_ < var_84_39 + var_84_40 then
				local var_84_41 = (arg_81_1.time_ - var_84_39) / var_84_40
				local var_84_42 = Vector3.New(0, -1.1, -6.18)

				var_84_38.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1156ui_story, var_84_42, var_84_41)

				local var_84_43 = manager.ui.mainCamera.transform.position - var_84_38.position

				var_84_38.forward = Vector3.New(var_84_43.x, var_84_43.y, var_84_43.z)

				local var_84_44 = var_84_38.localEulerAngles

				var_84_44.z = 0
				var_84_44.x = 0
				var_84_38.localEulerAngles = var_84_44
			end

			if arg_81_1.time_ >= var_84_39 + var_84_40 and arg_81_1.time_ < var_84_39 + var_84_40 + arg_84_0 then
				var_84_38.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_84_45 = manager.ui.mainCamera.transform.position - var_84_38.position

				var_84_38.forward = Vector3.New(var_84_45.x, var_84_45.y, var_84_45.z)

				local var_84_46 = var_84_38.localEulerAngles

				var_84_46.z = 0
				var_84_46.x = 0
				var_84_38.localEulerAngles = var_84_46
			end

			local var_84_47 = arg_81_1.actors_["1284ui_story"].transform
			local var_84_48 = 1.96599999815226

			if var_84_48 < arg_81_1.time_ and arg_81_1.time_ <= var_84_48 + arg_84_0 then
				arg_81_1.var_.moveOldPos1284ui_story = var_84_47.localPosition
			end

			local var_84_49 = 0.001

			if var_84_48 <= arg_81_1.time_ and arg_81_1.time_ < var_84_48 + var_84_49 then
				local var_84_50 = (arg_81_1.time_ - var_84_48) / var_84_49
				local var_84_51 = Vector3.New(0, 100, 0)

				var_84_47.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1284ui_story, var_84_51, var_84_50)

				local var_84_52 = manager.ui.mainCamera.transform.position - var_84_47.position

				var_84_47.forward = Vector3.New(var_84_52.x, var_84_52.y, var_84_52.z)

				local var_84_53 = var_84_47.localEulerAngles

				var_84_53.z = 0
				var_84_53.x = 0
				var_84_47.localEulerAngles = var_84_53
			end

			if arg_81_1.time_ >= var_84_48 + var_84_49 and arg_81_1.time_ < var_84_48 + var_84_49 + arg_84_0 then
				var_84_47.localPosition = Vector3.New(0, 100, 0)

				local var_84_54 = manager.ui.mainCamera.transform.position - var_84_47.position

				var_84_47.forward = Vector3.New(var_84_54.x, var_84_54.y, var_84_54.z)

				local var_84_55 = var_84_47.localEulerAngles

				var_84_55.z = 0
				var_84_55.x = 0
				var_84_47.localEulerAngles = var_84_55
			end

			local var_84_56 = 2.9666666696479

			if var_84_56 < arg_81_1.time_ and arg_81_1.time_ <= var_84_56 + arg_84_0 then
				arg_81_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			local var_84_57 = 2.9666666696479

			if var_84_57 < arg_81_1.time_ and arg_81_1.time_ <= var_84_57 + arg_84_0 then
				arg_81_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_84_58 = arg_81_1.actors_["1156ui_story"]
			local var_84_59 = 2.96666666666667

			if var_84_59 < arg_81_1.time_ and arg_81_1.time_ <= var_84_59 + arg_84_0 and not isNil(var_84_58) and arg_81_1.var_.characterEffect1156ui_story == nil then
				arg_81_1.var_.characterEffect1156ui_story = var_84_58:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_60 = 0.200000002980232

			if var_84_59 <= arg_81_1.time_ and arg_81_1.time_ < var_84_59 + var_84_60 and not isNil(var_84_58) then
				local var_84_61 = (arg_81_1.time_ - var_84_59) / var_84_60

				if arg_81_1.var_.characterEffect1156ui_story and not isNil(var_84_58) then
					arg_81_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_59 + var_84_60 and arg_81_1.time_ < var_84_59 + var_84_60 + arg_84_0 and not isNil(var_84_58) and arg_81_1.var_.characterEffect1156ui_story then
				arg_81_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_62 = 3.999999999999
			local var_84_63 = 0.55

			if var_84_62 < arg_81_1.time_ and arg_81_1.time_ <= var_84_62 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_64 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_64:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_65 = arg_81_1:FormatText(StoryNameCfg[605].name)

				arg_81_1.leftNameTxt_.text = var_84_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_66 = arg_81_1:GetWordFromCfg(322041020)
				local var_84_67 = arg_81_1:FormatText(var_84_66.content)

				arg_81_1.text_.text = var_84_67

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_68 = 22
				local var_84_69 = utf8.len(var_84_67)
				local var_84_70 = var_84_68 <= 0 and var_84_63 or var_84_63 * (var_84_69 / var_84_68)

				if var_84_70 > 0 and var_84_63 < var_84_70 then
					arg_81_1.talkMaxDuration = var_84_70
					var_84_62 = var_84_62 + 0.3

					if var_84_70 + var_84_62 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_70 + var_84_62
					end
				end

				arg_81_1.text_.text = var_84_67
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041020", "story_v_out_322041.awb") ~= 0 then
					local var_84_71 = manager.audio:GetVoiceLength("story_v_out_322041", "322041020", "story_v_out_322041.awb") / 1000

					if var_84_71 + var_84_62 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_71 + var_84_62
					end

					if var_84_66.prefab_name ~= "" and arg_81_1.actors_[var_84_66.prefab_name] ~= nil then
						local var_84_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_66.prefab_name].transform, "story_v_out_322041", "322041020", "story_v_out_322041.awb")

						arg_81_1:RecordAudio("322041020", var_84_72)
						arg_81_1:RecordAudio("322041020", var_84_72)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_322041", "322041020", "story_v_out_322041.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_322041", "322041020", "story_v_out_322041.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_73 = var_84_62 + 0.3
			local var_84_74 = math.max(var_84_63, arg_81_1.talkMaxDuration)

			if var_84_73 <= arg_81_1.time_ and arg_81_1.time_ < var_84_73 + var_84_74 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_73) / var_84_74

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_73 + var_84_74 and arg_81_1.time_ < var_84_73 + var_84_74 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.9666666696479,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play322041021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322041021
		arg_87_1.duration_ = 6

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play322041022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1156ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1156ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, 100, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1156ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, 100, 0)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = 0.1
			local var_90_10 = 1

			if var_90_9 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				local var_90_11 = "play"
				local var_90_12 = "effect"

				arg_87_1:AudioAction(var_90_11, var_90_12, "se_story_1311", "se_story_1311_car01", "")
			end

			local var_90_13 = manager.ui.mainCamera.transform
			local var_90_14 = 0.5

			if var_90_14 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 then
				local var_90_15 = arg_87_1.var_.effect1021
				local var_90_16
				local var_90_17 = var_90_13

				if not var_90_15 then
					var_90_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_90_17)
					var_90_15.name = "1021"
					arg_87_1.var_.effect1021 = var_90_15
				else
					var_90_15.transform:SetParent(var_90_17)
				end

				var_90_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_90_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_90_18 = manager.ui.mainCamera.transform
			local var_90_19 = 0.5

			if var_90_19 < arg_87_1.time_ and arg_87_1.time_ <= var_90_19 + arg_90_0 then
				arg_87_1.var_.shakeOldPos = var_90_18.localPosition
			end

			local var_90_20 = 0.466666666666667

			if var_90_19 <= arg_87_1.time_ and arg_87_1.time_ < var_90_19 + var_90_20 then
				local var_90_21 = (arg_87_1.time_ - var_90_19) / 0.066
				local var_90_22, var_90_23 = math.modf(var_90_21)

				var_90_18.localPosition = Vector3.New(var_90_23 * 0.13, var_90_23 * 0.13, var_90_23 * 0.13) + arg_87_1.var_.shakeOldPos
			end

			if arg_87_1.time_ >= var_90_19 + var_90_20 and arg_87_1.time_ < var_90_19 + var_90_20 + arg_90_0 then
				var_90_18.localPosition = arg_87_1.var_.shakeOldPos
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_24 = 1
			local var_90_25 = 1.575

			if var_90_24 < arg_87_1.time_ and arg_87_1.time_ <= var_90_24 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_26 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_26:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_27 = arg_87_1:GetWordFromCfg(322041021)
				local var_90_28 = arg_87_1:FormatText(var_90_27.content)

				arg_87_1.text_.text = var_90_28

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_29 = 63
				local var_90_30 = utf8.len(var_90_28)
				local var_90_31 = var_90_29 <= 0 and var_90_25 or var_90_25 * (var_90_30 / var_90_29)

				if var_90_31 > 0 and var_90_25 < var_90_31 then
					arg_87_1.talkMaxDuration = var_90_31
					var_90_24 = var_90_24 + 0.3

					if var_90_31 + var_90_24 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_31 + var_90_24
					end
				end

				arg_87_1.text_.text = var_90_28
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_32 = var_90_24 + 0.3
			local var_90_33 = math.max(var_90_25, arg_87_1.talkMaxDuration)

			if var_90_32 <= arg_87_1.time_ and arg_87_1.time_ < var_90_32 + var_90_33 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_32) / var_90_33

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_32 + var_90_33 and arg_87_1.time_ < var_90_32 + var_90_33 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play322041022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322041022
		arg_93_1.duration_ = 8.8

		local var_93_0 = {
			zh = 8.166,
			ja = 8.8
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
				arg_93_0:Play322041023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1284ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1284ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, -0.985, -6.22)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1284ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1284ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1284ui_story == nil then
				arg_93_1.var_.characterEffect1284ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1284ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1284ui_story then
				arg_93_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_96_13 = 0

			if var_96_13 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_15 = manager.ui.mainCamera.transform
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				local var_96_17 = arg_93_1.var_.effect1021

				if var_96_17 then
					Object.Destroy(var_96_17)

					arg_93_1.var_.effect1021 = nil
				end
			end

			local var_96_18 = 0
			local var_96_19 = 1.025

			if var_96_18 < arg_93_1.time_ and arg_93_1.time_ <= var_96_18 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_20 = arg_93_1:FormatText(StoryNameCfg[6].name)

				arg_93_1.leftNameTxt_.text = var_96_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_21 = arg_93_1:GetWordFromCfg(322041022)
				local var_96_22 = arg_93_1:FormatText(var_96_21.content)

				arg_93_1.text_.text = var_96_22

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_23 = 41
				local var_96_24 = utf8.len(var_96_22)
				local var_96_25 = var_96_23 <= 0 and var_96_19 or var_96_19 * (var_96_24 / var_96_23)

				if var_96_25 > 0 and var_96_19 < var_96_25 then
					arg_93_1.talkMaxDuration = var_96_25

					if var_96_25 + var_96_18 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_25 + var_96_18
					end
				end

				arg_93_1.text_.text = var_96_22
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041022", "story_v_out_322041.awb") ~= 0 then
					local var_96_26 = manager.audio:GetVoiceLength("story_v_out_322041", "322041022", "story_v_out_322041.awb") / 1000

					if var_96_26 + var_96_18 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_26 + var_96_18
					end

					if var_96_21.prefab_name ~= "" and arg_93_1.actors_[var_96_21.prefab_name] ~= nil then
						local var_96_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_21.prefab_name].transform, "story_v_out_322041", "322041022", "story_v_out_322041.awb")

						arg_93_1:RecordAudio("322041022", var_96_27)
						arg_93_1:RecordAudio("322041022", var_96_27)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322041", "322041022", "story_v_out_322041.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322041", "322041022", "story_v_out_322041.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_28 = math.max(var_96_19, arg_93_1.talkMaxDuration)

			if var_96_18 <= arg_93_1.time_ and arg_93_1.time_ < var_96_18 + var_96_28 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_18) / var_96_28

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_18 + var_96_28 and arg_93_1.time_ < var_96_18 + var_96_28 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play322041023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322041023
		arg_97_1.duration_ = 10.43

		local var_97_0 = {
			zh = 7.166,
			ja = 10.433
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
				arg_97_0:Play322041024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_1")
			end

			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_100_2 = 0
			local var_100_3 = 1.1

			if var_100_2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_4 = arg_97_1:FormatText(StoryNameCfg[6].name)

				arg_97_1.leftNameTxt_.text = var_100_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_5 = arg_97_1:GetWordFromCfg(322041023)
				local var_100_6 = arg_97_1:FormatText(var_100_5.content)

				arg_97_1.text_.text = var_100_6

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 44
				local var_100_8 = utf8.len(var_100_6)
				local var_100_9 = var_100_7 <= 0 and var_100_3 or var_100_3 * (var_100_8 / var_100_7)

				if var_100_9 > 0 and var_100_3 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_6
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041023", "story_v_out_322041.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041023", "story_v_out_322041.awb") / 1000

					if var_100_10 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_2
					end

					if var_100_5.prefab_name ~= "" and arg_97_1.actors_[var_100_5.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_5.prefab_name].transform, "story_v_out_322041", "322041023", "story_v_out_322041.awb")

						arg_97_1:RecordAudio("322041023", var_100_11)
						arg_97_1:RecordAudio("322041023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_322041", "322041023", "story_v_out_322041.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_322041", "322041023", "story_v_out_322041.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_12 and arg_97_1.time_ < var_100_2 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play322041024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322041024
		arg_101_1.duration_ = 4.5

		local var_101_0 = {
			zh = 3.8,
			ja = 4.5
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
				arg_101_0:Play322041025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1156ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1156ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1156ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1284ui_story"].transform
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1.var_.moveOldPos1284ui_story = var_104_9.localPosition
			end

			local var_104_11 = 0.001

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11
				local var_104_13 = Vector3.New(0.7, -0.985, -6.22)

				var_104_9.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1284ui_story, var_104_13, var_104_12)

				local var_104_14 = manager.ui.mainCamera.transform.position - var_104_9.position

				var_104_9.forward = Vector3.New(var_104_14.x, var_104_14.y, var_104_14.z)

				local var_104_15 = var_104_9.localEulerAngles

				var_104_15.z = 0
				var_104_15.x = 0
				var_104_9.localEulerAngles = var_104_15
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 then
				var_104_9.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_104_16 = manager.ui.mainCamera.transform.position - var_104_9.position

				var_104_9.forward = Vector3.New(var_104_16.x, var_104_16.y, var_104_16.z)

				local var_104_17 = var_104_9.localEulerAngles

				var_104_17.z = 0
				var_104_17.x = 0
				var_104_9.localEulerAngles = var_104_17
			end

			local var_104_18 = arg_101_1.actors_["1156ui_story"]
			local var_104_19 = 0

			if var_104_19 < arg_101_1.time_ and arg_101_1.time_ <= var_104_19 + arg_104_0 and not isNil(var_104_18) and arg_101_1.var_.characterEffect1156ui_story == nil then
				arg_101_1.var_.characterEffect1156ui_story = var_104_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_20 = 0.200000002980232

			if var_104_19 <= arg_101_1.time_ and arg_101_1.time_ < var_104_19 + var_104_20 and not isNil(var_104_18) then
				local var_104_21 = (arg_101_1.time_ - var_104_19) / var_104_20

				if arg_101_1.var_.characterEffect1156ui_story and not isNil(var_104_18) then
					arg_101_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_19 + var_104_20 and arg_101_1.time_ < var_104_19 + var_104_20 + arg_104_0 and not isNil(var_104_18) and arg_101_1.var_.characterEffect1156ui_story then
				arg_101_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_104_22 = arg_101_1.actors_["1284ui_story"]
			local var_104_23 = 0

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 and not isNil(var_104_22) and arg_101_1.var_.characterEffect1284ui_story == nil then
				arg_101_1.var_.characterEffect1284ui_story = var_104_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_24 = 0.200000002980232

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_24 and not isNil(var_104_22) then
				local var_104_25 = (arg_101_1.time_ - var_104_23) / var_104_24

				if arg_101_1.var_.characterEffect1284ui_story and not isNil(var_104_22) then
					local var_104_26 = Mathf.Lerp(0, 0.5, var_104_25)

					arg_101_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1284ui_story.fillRatio = var_104_26
				end
			end

			if arg_101_1.time_ >= var_104_23 + var_104_24 and arg_101_1.time_ < var_104_23 + var_104_24 + arg_104_0 and not isNil(var_104_22) and arg_101_1.var_.characterEffect1284ui_story then
				local var_104_27 = 0.5

				arg_101_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1284ui_story.fillRatio = var_104_27
			end

			local var_104_28 = 0

			if var_104_28 < arg_101_1.time_ and arg_101_1.time_ <= var_104_28 + arg_104_0 then
				arg_101_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action7_1")
			end

			local var_104_29 = 0

			if var_104_29 < arg_101_1.time_ and arg_101_1.time_ <= var_104_29 + arg_104_0 then
				arg_101_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_104_30 = 0
			local var_104_31 = 0.4

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_32 = arg_101_1:FormatText(StoryNameCfg[605].name)

				arg_101_1.leftNameTxt_.text = var_104_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_33 = arg_101_1:GetWordFromCfg(322041024)
				local var_104_34 = arg_101_1:FormatText(var_104_33.content)

				arg_101_1.text_.text = var_104_34

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_35 = 16
				local var_104_36 = utf8.len(var_104_34)
				local var_104_37 = var_104_35 <= 0 and var_104_31 or var_104_31 * (var_104_36 / var_104_35)

				if var_104_37 > 0 and var_104_31 < var_104_37 then
					arg_101_1.talkMaxDuration = var_104_37

					if var_104_37 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_37 + var_104_30
					end
				end

				arg_101_1.text_.text = var_104_34
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041024", "story_v_out_322041.awb") ~= 0 then
					local var_104_38 = manager.audio:GetVoiceLength("story_v_out_322041", "322041024", "story_v_out_322041.awb") / 1000

					if var_104_38 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_38 + var_104_30
					end

					if var_104_33.prefab_name ~= "" and arg_101_1.actors_[var_104_33.prefab_name] ~= nil then
						local var_104_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_33.prefab_name].transform, "story_v_out_322041", "322041024", "story_v_out_322041.awb")

						arg_101_1:RecordAudio("322041024", var_104_39)
						arg_101_1:RecordAudio("322041024", var_104_39)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322041", "322041024", "story_v_out_322041.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322041", "322041024", "story_v_out_322041.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_40 = math.max(var_104_31, arg_101_1.talkMaxDuration)

			if var_104_30 <= arg_101_1.time_ and arg_101_1.time_ < var_104_30 + var_104_40 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_30) / var_104_40

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_30 + var_104_40 and arg_101_1.time_ < var_104_30 + var_104_40 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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
				actorName = "1284ui_story",
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
	Play322041025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322041025
		arg_105_1.duration_ = 7.17

		local var_105_0 = {
			zh = 5.366,
			ja = 7.166
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
				arg_105_0:Play322041026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1284ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1284ui_story == nil then
				arg_105_1.var_.characterEffect1284ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1284ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1284ui_story then
				arg_105_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_108_4 = arg_105_1.actors_["1156ui_story"]
			local var_108_5 = 0

			if var_108_5 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1156ui_story == nil then
				arg_105_1.var_.characterEffect1156ui_story = var_108_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.200000002980232

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_6 and not isNil(var_108_4) then
				local var_108_7 = (arg_105_1.time_ - var_108_5) / var_108_6

				if arg_105_1.var_.characterEffect1156ui_story and not isNil(var_108_4) then
					local var_108_8 = Mathf.Lerp(0, 0.5, var_108_7)

					arg_105_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1156ui_story.fillRatio = var_108_8
				end
			end

			if arg_105_1.time_ >= var_108_5 + var_108_6 and arg_105_1.time_ < var_108_5 + var_108_6 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1156ui_story then
				local var_108_9 = 0.5

				arg_105_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1156ui_story.fillRatio = var_108_9
			end

			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_2")
			end

			local var_108_11 = 0

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_12 = 0
			local var_108_13 = 0.8

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_14 = arg_105_1:FormatText(StoryNameCfg[6].name)

				arg_105_1.leftNameTxt_.text = var_108_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_15 = arg_105_1:GetWordFromCfg(322041025)
				local var_108_16 = arg_105_1:FormatText(var_108_15.content)

				arg_105_1.text_.text = var_108_16

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041025", "story_v_out_322041.awb") ~= 0 then
					local var_108_20 = manager.audio:GetVoiceLength("story_v_out_322041", "322041025", "story_v_out_322041.awb") / 1000

					if var_108_20 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_20 + var_108_12
					end

					if var_108_15.prefab_name ~= "" and arg_105_1.actors_[var_108_15.prefab_name] ~= nil then
						local var_108_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_15.prefab_name].transform, "story_v_out_322041", "322041025", "story_v_out_322041.awb")

						arg_105_1:RecordAudio("322041025", var_108_21)
						arg_105_1:RecordAudio("322041025", var_108_21)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_322041", "322041025", "story_v_out_322041.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_322041", "322041025", "story_v_out_322041.awb")
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
	Play322041026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322041026
		arg_109_1.duration_ = 9.07

		local var_109_0 = {
			zh = 6.166,
			ja = 9.066
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
				arg_109_0:Play322041027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.75

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[6].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(322041026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041026", "story_v_out_322041.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_322041", "322041026", "story_v_out_322041.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_322041", "322041026", "story_v_out_322041.awb")

						arg_109_1:RecordAudio("322041026", var_112_9)
						arg_109_1:RecordAudio("322041026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322041", "322041026", "story_v_out_322041.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322041", "322041026", "story_v_out_322041.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play322041027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322041027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322041028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = "10104ui_story"

			if arg_113_1.actors_[var_116_0] == nil then
				local var_116_1 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_116_1) then
					local var_116_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_113_1.stage_.transform)

					var_116_2.name = var_116_0
					var_116_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_113_1.actors_[var_116_0] = var_116_2

					local var_116_3 = var_116_2:GetComponentInChildren(typeof(CharacterEffect))

					var_116_3.enabled = true

					local var_116_4 = GameObjectTools.GetOrAddComponent(var_116_2, typeof(DynamicBoneHelper))

					if var_116_4 then
						var_116_4:EnableDynamicBone(false)
					end

					arg_113_1:ShowWeapon(var_116_3.transform, false)

					arg_113_1.var_[var_116_0 .. "Animator"] = var_116_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_113_1.var_[var_116_0 .. "Animator"].applyRootMotion = true
					arg_113_1.var_[var_116_0 .. "LipSync"] = var_116_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_116_5 = arg_113_1.actors_["10104ui_story"].transform
			local var_116_6 = 0

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.var_.moveOldPos10104ui_story = var_116_5.localPosition
			end

			local var_116_7 = 0.001

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_7 then
				local var_116_8 = (arg_113_1.time_ - var_116_6) / var_116_7
				local var_116_9 = Vector3.New(-0.88, -1.12, -5.99)

				var_116_5.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10104ui_story, var_116_9, var_116_8)

				local var_116_10 = manager.ui.mainCamera.transform.position - var_116_5.position

				var_116_5.forward = Vector3.New(var_116_10.x, var_116_10.y, var_116_10.z)

				local var_116_11 = var_116_5.localEulerAngles

				var_116_11.z = 0
				var_116_11.x = 0
				var_116_5.localEulerAngles = var_116_11
			end

			if arg_113_1.time_ >= var_116_6 + var_116_7 and arg_113_1.time_ < var_116_6 + var_116_7 + arg_116_0 then
				var_116_5.localPosition = Vector3.New(-0.88, -1.12, -5.99)

				local var_116_12 = manager.ui.mainCamera.transform.position - var_116_5.position

				var_116_5.forward = Vector3.New(var_116_12.x, var_116_12.y, var_116_12.z)

				local var_116_13 = var_116_5.localEulerAngles

				var_116_13.z = 0
				var_116_13.x = 0
				var_116_5.localEulerAngles = var_116_13
			end

			local var_116_14 = arg_113_1.actors_["1156ui_story"].transform
			local var_116_15 = 0

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.var_.moveOldPos1156ui_story = var_116_14.localPosition
			end

			local var_116_16 = 0.001

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_16 then
				local var_116_17 = (arg_113_1.time_ - var_116_15) / var_116_16
				local var_116_18 = Vector3.New(0, 100, 0)

				var_116_14.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1156ui_story, var_116_18, var_116_17)

				local var_116_19 = manager.ui.mainCamera.transform.position - var_116_14.position

				var_116_14.forward = Vector3.New(var_116_19.x, var_116_19.y, var_116_19.z)

				local var_116_20 = var_116_14.localEulerAngles

				var_116_20.z = 0
				var_116_20.x = 0
				var_116_14.localEulerAngles = var_116_20
			end

			if arg_113_1.time_ >= var_116_15 + var_116_16 and arg_113_1.time_ < var_116_15 + var_116_16 + arg_116_0 then
				var_116_14.localPosition = Vector3.New(0, 100, 0)

				local var_116_21 = manager.ui.mainCamera.transform.position - var_116_14.position

				var_116_14.forward = Vector3.New(var_116_21.x, var_116_21.y, var_116_21.z)

				local var_116_22 = var_116_14.localEulerAngles

				var_116_22.z = 0
				var_116_22.x = 0
				var_116_14.localEulerAngles = var_116_22
			end

			local var_116_23 = arg_113_1.actors_["10104ui_story"]
			local var_116_24 = 0

			if var_116_24 < arg_113_1.time_ and arg_113_1.time_ <= var_116_24 + arg_116_0 and not isNil(var_116_23) and arg_113_1.var_.characterEffect10104ui_story == nil then
				arg_113_1.var_.characterEffect10104ui_story = var_116_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_25 = 0.200000002980232

			if var_116_24 <= arg_113_1.time_ and arg_113_1.time_ < var_116_24 + var_116_25 and not isNil(var_116_23) then
				local var_116_26 = (arg_113_1.time_ - var_116_24) / var_116_25

				if arg_113_1.var_.characterEffect10104ui_story and not isNil(var_116_23) then
					arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_24 + var_116_25 and arg_113_1.time_ < var_116_24 + var_116_25 + arg_116_0 and not isNil(var_116_23) and arg_113_1.var_.characterEffect10104ui_story then
				arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_116_27 = arg_113_1.actors_["1284ui_story"]
			local var_116_28 = 0

			if var_116_28 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 and not isNil(var_116_27) and arg_113_1.var_.characterEffect1284ui_story == nil then
				arg_113_1.var_.characterEffect1284ui_story = var_116_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_29 = 0.200000002980232

			if var_116_28 <= arg_113_1.time_ and arg_113_1.time_ < var_116_28 + var_116_29 and not isNil(var_116_27) then
				local var_116_30 = (arg_113_1.time_ - var_116_28) / var_116_29

				if arg_113_1.var_.characterEffect1284ui_story and not isNil(var_116_27) then
					local var_116_31 = Mathf.Lerp(0, 0.5, var_116_30)

					arg_113_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1284ui_story.fillRatio = var_116_31
				end
			end

			if arg_113_1.time_ >= var_116_28 + var_116_29 and arg_113_1.time_ < var_116_28 + var_116_29 + arg_116_0 and not isNil(var_116_27) and arg_113_1.var_.characterEffect1284ui_story then
				local var_116_32 = 0.5

				arg_113_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1284ui_story.fillRatio = var_116_32
			end

			local var_116_33 = 0

			if var_116_33 < arg_113_1.time_ and arg_113_1.time_ <= var_116_33 + arg_116_0 then
				arg_113_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_116_34 = 0

			if var_116_34 < arg_113_1.time_ and arg_113_1.time_ <= var_116_34 + arg_116_0 then
				arg_113_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_116_35 = arg_113_1.actors_["10104ui_story"]
			local var_116_36 = 0

			if var_116_36 < arg_113_1.time_ and arg_113_1.time_ <= var_116_36 + arg_116_0 then
				if arg_113_1.var_.characterEffect10104ui_story == nil then
					arg_113_1.var_.characterEffect10104ui_story = var_116_35:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_116_37 = arg_113_1.var_.characterEffect10104ui_story

				var_116_37.imageEffect:turnOff()

				var_116_37.interferenceEffect.enabled = true
				var_116_37.interferenceEffect.noise = 0.001
				var_116_37.interferenceEffect.simTimeScale = 1
				var_116_37.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_116_38 = arg_113_1.actors_["10104ui_story"]
			local var_116_39 = 0
			local var_116_40 = 5

			if var_116_39 < arg_113_1.time_ and arg_113_1.time_ <= var_116_39 + arg_116_0 then
				if arg_113_1.var_.characterEffect10104ui_story == nil then
					arg_113_1.var_.characterEffect10104ui_story = var_116_38:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_113_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_116_41 = 0
			local var_116_42 = 0.15

			if var_116_41 < arg_113_1.time_ and arg_113_1.time_ <= var_116_41 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_43 = arg_113_1:FormatText(StoryNameCfg[1030].name)

				arg_113_1.leftNameTxt_.text = var_116_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_44 = arg_113_1:GetWordFromCfg(322041027)
				local var_116_45 = arg_113_1:FormatText(var_116_44.content)

				arg_113_1.text_.text = var_116_45

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_46 = 6
				local var_116_47 = utf8.len(var_116_45)
				local var_116_48 = var_116_46 <= 0 and var_116_42 or var_116_42 * (var_116_47 / var_116_46)

				if var_116_48 > 0 and var_116_42 < var_116_48 then
					arg_113_1.talkMaxDuration = var_116_48

					if var_116_48 + var_116_41 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_48 + var_116_41
					end
				end

				arg_113_1.text_.text = var_116_45
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041027", "story_v_out_322041.awb") ~= 0 then
					local var_116_49 = manager.audio:GetVoiceLength("story_v_out_322041", "322041027", "story_v_out_322041.awb") / 1000

					if var_116_49 + var_116_41 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_49 + var_116_41
					end

					if var_116_44.prefab_name ~= "" and arg_113_1.actors_[var_116_44.prefab_name] ~= nil then
						local var_116_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_44.prefab_name].transform, "story_v_out_322041", "322041027", "story_v_out_322041.awb")

						arg_113_1:RecordAudio("322041027", var_116_50)
						arg_113_1:RecordAudio("322041027", var_116_50)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_322041", "322041027", "story_v_out_322041.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_322041", "322041027", "story_v_out_322041.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_51 = math.max(var_116_42, arg_113_1.talkMaxDuration)

			if var_116_41 <= arg_113_1.time_ and arg_113_1.time_ < var_116_41 + var_116_51 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_41) / var_116_51

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_41 + var_116_51 and arg_113_1.time_ < var_116_41 + var_116_51 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_113_1:InitPlayNodeList()
	end,
	Play322041028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322041028
		arg_117_1.duration_ = 2.63

		local var_117_0 = {
			zh = 2.433,
			ja = 2.633
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
				arg_117_0:Play322041029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1284ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1284ui_story = var_120_0.localPosition

				local var_120_2 = "1284ui_story"

				arg_117_1:ShowWeapon(arg_117_1.var_[var_120_2 .. "Animator"].transform, false)
			end

			local var_120_3 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_3 then
				local var_120_4 = (arg_117_1.time_ - var_120_1) / var_120_3
				local var_120_5 = Vector3.New(0.7, -0.985, -6.22)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1284ui_story, var_120_5, var_120_4)

				local var_120_6 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_6.x, var_120_6.y, var_120_6.z)

				local var_120_7 = var_120_0.localEulerAngles

				var_120_7.z = 0
				var_120_7.x = 0
				var_120_0.localEulerAngles = var_120_7
			end

			if arg_117_1.time_ >= var_120_1 + var_120_3 and arg_117_1.time_ < var_120_1 + var_120_3 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_120_8 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_8.x, var_120_8.y, var_120_8.z)

				local var_120_9 = var_120_0.localEulerAngles

				var_120_9.z = 0
				var_120_9.x = 0
				var_120_0.localEulerAngles = var_120_9
			end

			local var_120_10 = arg_117_1.actors_["1284ui_story"]
			local var_120_11 = 0

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 and not isNil(var_120_10) and arg_117_1.var_.characterEffect1284ui_story == nil then
				arg_117_1.var_.characterEffect1284ui_story = var_120_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_12 = 0.200000002980232

			if var_120_11 <= arg_117_1.time_ and arg_117_1.time_ < var_120_11 + var_120_12 and not isNil(var_120_10) then
				local var_120_13 = (arg_117_1.time_ - var_120_11) / var_120_12

				if arg_117_1.var_.characterEffect1284ui_story and not isNil(var_120_10) then
					arg_117_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_11 + var_120_12 and arg_117_1.time_ < var_120_11 + var_120_12 + arg_120_0 and not isNil(var_120_10) and arg_117_1.var_.characterEffect1284ui_story then
				arg_117_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_120_14 = arg_117_1.actors_["10104ui_story"]
			local var_120_15 = 0

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.characterEffect10104ui_story == nil then
				arg_117_1.var_.characterEffect10104ui_story = var_120_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_16 = 0.200000002980232

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_16 and not isNil(var_120_14) then
				local var_120_17 = (arg_117_1.time_ - var_120_15) / var_120_16

				if arg_117_1.var_.characterEffect10104ui_story and not isNil(var_120_14) then
					local var_120_18 = Mathf.Lerp(0, 0.5, var_120_17)

					arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10104ui_story.fillRatio = var_120_18
				end
			end

			if arg_117_1.time_ >= var_120_15 + var_120_16 and arg_117_1.time_ < var_120_15 + var_120_16 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.characterEffect10104ui_story then
				local var_120_19 = 0.5

				arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10104ui_story.fillRatio = var_120_19
			end

			local var_120_20 = 0

			if var_120_20 < arg_117_1.time_ and arg_117_1.time_ <= var_120_20 + arg_120_0 then
				arg_117_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			local var_120_21 = 0

			if var_120_21 < arg_117_1.time_ and arg_117_1.time_ <= var_120_21 + arg_120_0 then
				arg_117_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_120_22 = 0
			local var_120_23 = 0.3

			if var_120_22 < arg_117_1.time_ and arg_117_1.time_ <= var_120_22 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_24 = arg_117_1:FormatText(StoryNameCfg[6].name)

				arg_117_1.leftNameTxt_.text = var_120_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_25 = arg_117_1:GetWordFromCfg(322041028)
				local var_120_26 = arg_117_1:FormatText(var_120_25.content)

				arg_117_1.text_.text = var_120_26

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_27 = 12
				local var_120_28 = utf8.len(var_120_26)
				local var_120_29 = var_120_27 <= 0 and var_120_23 or var_120_23 * (var_120_28 / var_120_27)

				if var_120_29 > 0 and var_120_23 < var_120_29 then
					arg_117_1.talkMaxDuration = var_120_29

					if var_120_29 + var_120_22 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_29 + var_120_22
					end
				end

				arg_117_1.text_.text = var_120_26
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041028", "story_v_out_322041.awb") ~= 0 then
					local var_120_30 = manager.audio:GetVoiceLength("story_v_out_322041", "322041028", "story_v_out_322041.awb") / 1000

					if var_120_30 + var_120_22 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_30 + var_120_22
					end

					if var_120_25.prefab_name ~= "" and arg_117_1.actors_[var_120_25.prefab_name] ~= nil then
						local var_120_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_25.prefab_name].transform, "story_v_out_322041", "322041028", "story_v_out_322041.awb")

						arg_117_1:RecordAudio("322041028", var_120_31)
						arg_117_1:RecordAudio("322041028", var_120_31)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_322041", "322041028", "story_v_out_322041.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_322041", "322041028", "story_v_out_322041.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_32 = math.max(var_120_23, arg_117_1.talkMaxDuration)

			if var_120_22 <= arg_117_1.time_ and arg_117_1.time_ < var_120_22 + var_120_32 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_22) / var_120_32

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_22 + var_120_32 and arg_117_1.time_ < var_120_22 + var_120_32 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play322041029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322041029
		arg_121_1.duration_ = 2.57

		local var_121_0 = {
			zh = 2.566,
			ja = 2.3
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
				arg_121_0:Play322041030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_2")
			end

			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_124_2 = 0
			local var_124_3 = 0.225

			if var_124_2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_4 = arg_121_1:FormatText(StoryNameCfg[6].name)

				arg_121_1.leftNameTxt_.text = var_124_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_5 = arg_121_1:GetWordFromCfg(322041029)
				local var_124_6 = arg_121_1:FormatText(var_124_5.content)

				arg_121_1.text_.text = var_124_6

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 9
				local var_124_8 = utf8.len(var_124_6)
				local var_124_9 = var_124_7 <= 0 and var_124_3 or var_124_3 * (var_124_8 / var_124_7)

				if var_124_9 > 0 and var_124_3 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_6
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041029", "story_v_out_322041.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041029", "story_v_out_322041.awb") / 1000

					if var_124_10 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_2
					end

					if var_124_5.prefab_name ~= "" and arg_121_1.actors_[var_124_5.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_5.prefab_name].transform, "story_v_out_322041", "322041029", "story_v_out_322041.awb")

						arg_121_1:RecordAudio("322041029", var_124_11)
						arg_121_1:RecordAudio("322041029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_322041", "322041029", "story_v_out_322041.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_322041", "322041029", "story_v_out_322041.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_12 and arg_121_1.time_ < var_124_2 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play322041030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 322041030
		arg_125_1.duration_ = 9.43

		local var_125_0 = {
			zh = 5.933,
			ja = 9.433
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
				arg_125_0:Play322041031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10104ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10104ui_story == nil then
				arg_125_1.var_.characterEffect10104ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect10104ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10104ui_story then
				arg_125_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["1284ui_story"]
			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1284ui_story == nil then
				arg_125_1.var_.characterEffect1284ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.200000002980232

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 and not isNil(var_128_4) then
				local var_128_7 = (arg_125_1.time_ - var_128_5) / var_128_6

				if arg_125_1.var_.characterEffect1284ui_story and not isNil(var_128_4) then
					local var_128_8 = Mathf.Lerp(0, 0.5, var_128_7)

					arg_125_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1284ui_story.fillRatio = var_128_8
				end
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1284ui_story then
				local var_128_9 = 0.5

				arg_125_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1284ui_story.fillRatio = var_128_9
			end

			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_128_11 = 0

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_128_12 = arg_125_1.actors_["10104ui_story"]
			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				if arg_125_1.var_.characterEffect10104ui_story == nil then
					arg_125_1.var_.characterEffect10104ui_story = var_128_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_128_14 = arg_125_1.var_.characterEffect10104ui_story

				var_128_14.imageEffect:turnOff()

				var_128_14.interferenceEffect.enabled = true
				var_128_14.interferenceEffect.noise = 0.001
				var_128_14.interferenceEffect.simTimeScale = 1
				var_128_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_128_15 = arg_125_1.actors_["10104ui_story"]
			local var_128_16 = 0
			local var_128_17 = 5

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				if arg_125_1.var_.characterEffect10104ui_story == nil then
					arg_125_1.var_.characterEffect10104ui_story = var_128_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_125_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_128_18 = 0
			local var_128_19 = 0.825

			if var_128_18 < arg_125_1.time_ and arg_125_1.time_ <= var_128_18 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_20 = arg_125_1:FormatText(StoryNameCfg[1030].name)

				arg_125_1.leftNameTxt_.text = var_128_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_21 = arg_125_1:GetWordFromCfg(322041030)
				local var_128_22 = arg_125_1:FormatText(var_128_21.content)

				arg_125_1.text_.text = var_128_22

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_23 = 33
				local var_128_24 = utf8.len(var_128_22)
				local var_128_25 = var_128_23 <= 0 and var_128_19 or var_128_19 * (var_128_24 / var_128_23)

				if var_128_25 > 0 and var_128_19 < var_128_25 then
					arg_125_1.talkMaxDuration = var_128_25

					if var_128_25 + var_128_18 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_25 + var_128_18
					end
				end

				arg_125_1.text_.text = var_128_22
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041030", "story_v_out_322041.awb") ~= 0 then
					local var_128_26 = manager.audio:GetVoiceLength("story_v_out_322041", "322041030", "story_v_out_322041.awb") / 1000

					if var_128_26 + var_128_18 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_26 + var_128_18
					end

					if var_128_21.prefab_name ~= "" and arg_125_1.actors_[var_128_21.prefab_name] ~= nil then
						local var_128_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_21.prefab_name].transform, "story_v_out_322041", "322041030", "story_v_out_322041.awb")

						arg_125_1:RecordAudio("322041030", var_128_27)
						arg_125_1:RecordAudio("322041030", var_128_27)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_322041", "322041030", "story_v_out_322041.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_322041", "322041030", "story_v_out_322041.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_28 = math.max(var_128_19, arg_125_1.talkMaxDuration)

			if var_128_18 <= arg_125_1.time_ and arg_125_1.time_ < var_128_18 + var_128_28 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_18) / var_128_28

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_18 + var_128_28 and arg_125_1.time_ < var_128_18 + var_128_28 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play322041031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 322041031
		arg_129_1.duration_ = 7.27

		local var_129_0 = {
			zh = 4.999999999999,
			ja = 7.266
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
				arg_129_0:Play322041032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_132_1 = arg_129_1.actors_["10104ui_story"]
			local var_132_2 = 0

			if var_132_2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				if arg_129_1.var_.characterEffect10104ui_story == nil then
					arg_129_1.var_.characterEffect10104ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_132_3 = arg_129_1.var_.characterEffect10104ui_story

				var_132_3.imageEffect:turnOff()

				var_132_3.interferenceEffect.enabled = true
				var_132_3.interferenceEffect.noise = 0.001
				var_132_3.interferenceEffect.simTimeScale = 1
				var_132_3.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_132_4 = arg_129_1.actors_["10104ui_story"]
			local var_132_5 = 0
			local var_132_6 = 5

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				if arg_129_1.var_.characterEffect10104ui_story == nil then
					arg_129_1.var_.characterEffect10104ui_story = var_132_4:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_129_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_132_7 = 0
			local var_132_8 = 0.6

			if var_132_7 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_9 = arg_129_1:FormatText(StoryNameCfg[1030].name)

				arg_129_1.leftNameTxt_.text = var_132_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:GetWordFromCfg(322041031)
				local var_132_11 = arg_129_1:FormatText(var_132_10.content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_12 = 24
				local var_132_13 = utf8.len(var_132_11)
				local var_132_14 = var_132_12 <= 0 and var_132_8 or var_132_8 * (var_132_13 / var_132_12)

				if var_132_14 > 0 and var_132_8 < var_132_14 then
					arg_129_1.talkMaxDuration = var_132_14

					if var_132_14 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_7
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041031", "story_v_out_322041.awb") ~= 0 then
					local var_132_15 = manager.audio:GetVoiceLength("story_v_out_322041", "322041031", "story_v_out_322041.awb") / 1000

					if var_132_15 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_15 + var_132_7
					end

					if var_132_10.prefab_name ~= "" and arg_129_1.actors_[var_132_10.prefab_name] ~= nil then
						local var_132_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_10.prefab_name].transform, "story_v_out_322041", "322041031", "story_v_out_322041.awb")

						arg_129_1:RecordAudio("322041031", var_132_16)
						arg_129_1:RecordAudio("322041031", var_132_16)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_322041", "322041031", "story_v_out_322041.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_322041", "322041031", "story_v_out_322041.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_17 = math.max(var_132_8, arg_129_1.talkMaxDuration)

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_17 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_7) / var_132_17

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_7 + var_132_17 and arg_129_1.time_ < var_132_7 + var_132_17 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play322041032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 322041032
		arg_133_1.duration_ = 3.23

		local var_133_0 = {
			zh = 2.233,
			ja = 3.233
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
				arg_133_0:Play322041033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1284ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1284ui_story == nil then
				arg_133_1.var_.characterEffect1284ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1284ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1284ui_story then
				arg_133_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_136_4 = arg_133_1.actors_["10104ui_story"]
			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect10104ui_story == nil then
				arg_133_1.var_.characterEffect10104ui_story = var_136_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_6 = 0.200000002980232

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 and not isNil(var_136_4) then
				local var_136_7 = (arg_133_1.time_ - var_136_5) / var_136_6

				if arg_133_1.var_.characterEffect10104ui_story and not isNil(var_136_4) then
					local var_136_8 = Mathf.Lerp(0, 0.5, var_136_7)

					arg_133_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10104ui_story.fillRatio = var_136_8
				end
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect10104ui_story then
				local var_136_9 = 0.5

				arg_133_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10104ui_story.fillRatio = var_136_9
			end

			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_136_11 = 0

			if var_136_11 < arg_133_1.time_ and arg_133_1.time_ <= var_136_11 + arg_136_0 then
				arg_133_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_136_12 = 0
			local var_136_13 = 0.275

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_14 = arg_133_1:FormatText(StoryNameCfg[6].name)

				arg_133_1.leftNameTxt_.text = var_136_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_15 = arg_133_1:GetWordFromCfg(322041032)
				local var_136_16 = arg_133_1:FormatText(var_136_15.content)

				arg_133_1.text_.text = var_136_16

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_17 = 11
				local var_136_18 = utf8.len(var_136_16)
				local var_136_19 = var_136_17 <= 0 and var_136_13 or var_136_13 * (var_136_18 / var_136_17)

				if var_136_19 > 0 and var_136_13 < var_136_19 then
					arg_133_1.talkMaxDuration = var_136_19

					if var_136_19 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_19 + var_136_12
					end
				end

				arg_133_1.text_.text = var_136_16
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041032", "story_v_out_322041.awb") ~= 0 then
					local var_136_20 = manager.audio:GetVoiceLength("story_v_out_322041", "322041032", "story_v_out_322041.awb") / 1000

					if var_136_20 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_20 + var_136_12
					end

					if var_136_15.prefab_name ~= "" and arg_133_1.actors_[var_136_15.prefab_name] ~= nil then
						local var_136_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_15.prefab_name].transform, "story_v_out_322041", "322041032", "story_v_out_322041.awb")

						arg_133_1:RecordAudio("322041032", var_136_21)
						arg_133_1:RecordAudio("322041032", var_136_21)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_322041", "322041032", "story_v_out_322041.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_322041", "322041032", "story_v_out_322041.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_22 = math.max(var_136_13, arg_133_1.talkMaxDuration)

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_22 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_12) / var_136_22

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_12 + var_136_22 and arg_133_1.time_ < var_136_12 + var_136_22 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play322041033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 322041033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play322041034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1284ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1284ui_story == nil then
				arg_137_1.var_.characterEffect1284ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1284ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1284ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1284ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1284ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0.9
			local var_140_7 = 1

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				local var_140_8 = "play"
				local var_140_9 = "effect"

				arg_137_1:AudioAction(var_140_8, var_140_9, "se_story_145", "se_story_145_ui02", "")
			end

			local var_140_10 = 0
			local var_140_11 = 1.25

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_12 = arg_137_1:GetWordFromCfg(322041033)
				local var_140_13 = arg_137_1:FormatText(var_140_12.content)

				arg_137_1.text_.text = var_140_13

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_14 = 50
				local var_140_15 = utf8.len(var_140_13)
				local var_140_16 = var_140_14 <= 0 and var_140_11 or var_140_11 * (var_140_15 / var_140_14)

				if var_140_16 > 0 and var_140_11 < var_140_16 then
					arg_137_1.talkMaxDuration = var_140_16

					if var_140_16 + var_140_10 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_10
					end
				end

				arg_137_1.text_.text = var_140_13
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_17 = math.max(var_140_11, arg_137_1.talkMaxDuration)

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_17 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_10) / var_140_17

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_10 + var_140_17 and arg_137_1.time_ < var_140_10 + var_140_17 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play322041034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 322041034
		arg_141_1.duration_ = 4.7

		local var_141_0 = {
			zh = 4.7,
			ja = 4.133
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
				arg_141_0:Play322041035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1284ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1284ui_story == nil then
				arg_141_1.var_.characterEffect1284ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1284ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1284ui_story then
				arg_141_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_144_6 = 0
			local var_144_7 = 0.5

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_8 = arg_141_1:FormatText(StoryNameCfg[6].name)

				arg_141_1.leftNameTxt_.text = var_144_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:GetWordFromCfg(322041034)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 20
				local var_144_12 = utf8.len(var_144_10)
				local var_144_13 = var_144_11 <= 0 and var_144_7 or var_144_7 * (var_144_12 / var_144_11)

				if var_144_13 > 0 and var_144_7 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041034", "story_v_out_322041.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_322041", "322041034", "story_v_out_322041.awb") / 1000

					if var_144_14 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_6
					end

					if var_144_9.prefab_name ~= "" and arg_141_1.actors_[var_144_9.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_9.prefab_name].transform, "story_v_out_322041", "322041034", "story_v_out_322041.awb")

						arg_141_1:RecordAudio("322041034", var_144_15)
						arg_141_1:RecordAudio("322041034", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_322041", "322041034", "story_v_out_322041.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_322041", "322041034", "story_v_out_322041.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_16 and arg_141_1.time_ < var_144_6 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play322041035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 322041035
		arg_145_1.duration_ = 8.07

		local var_145_0 = {
			zh = 4.999999999999,
			ja = 8.066
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
				arg_145_0:Play322041036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10104ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10104ui_story == nil then
				arg_145_1.var_.characterEffect10104ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect10104ui_story and not isNil(var_148_0) then
					arg_145_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10104ui_story then
				arg_145_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_148_4 = arg_145_1.actors_["1284ui_story"]
			local var_148_5 = 0

			if var_148_5 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1284ui_story == nil then
				arg_145_1.var_.characterEffect1284ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_6 = 0.200000002980232

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_6 and not isNil(var_148_4) then
				local var_148_7 = (arg_145_1.time_ - var_148_5) / var_148_6

				if arg_145_1.var_.characterEffect1284ui_story and not isNil(var_148_4) then
					local var_148_8 = Mathf.Lerp(0, 0.5, var_148_7)

					arg_145_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1284ui_story.fillRatio = var_148_8
				end
			end

			if arg_145_1.time_ >= var_148_5 + var_148_6 and arg_145_1.time_ < var_148_5 + var_148_6 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1284ui_story then
				local var_148_9 = 0.5

				arg_145_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1284ui_story.fillRatio = var_148_9
			end

			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			local var_148_11 = 0

			if var_148_11 < arg_145_1.time_ and arg_145_1.time_ <= var_148_11 + arg_148_0 then
				arg_145_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_148_12 = arg_145_1.actors_["10104ui_story"]
			local var_148_13 = 0

			if var_148_13 < arg_145_1.time_ and arg_145_1.time_ <= var_148_13 + arg_148_0 then
				if arg_145_1.var_.characterEffect10104ui_story == nil then
					arg_145_1.var_.characterEffect10104ui_story = var_148_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_148_14 = arg_145_1.var_.characterEffect10104ui_story

				var_148_14.imageEffect:turnOff()

				var_148_14.interferenceEffect.enabled = true
				var_148_14.interferenceEffect.noise = 0.001
				var_148_14.interferenceEffect.simTimeScale = 1
				var_148_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_148_15 = arg_145_1.actors_["10104ui_story"]
			local var_148_16 = 0
			local var_148_17 = 5

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				if arg_145_1.var_.characterEffect10104ui_story == nil then
					arg_145_1.var_.characterEffect10104ui_story = var_148_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_145_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_148_18 = 0
			local var_148_19 = 0.5

			if var_148_18 < arg_145_1.time_ and arg_145_1.time_ <= var_148_18 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_20 = arg_145_1:FormatText(StoryNameCfg[1030].name)

				arg_145_1.leftNameTxt_.text = var_148_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_21 = arg_145_1:GetWordFromCfg(322041035)
				local var_148_22 = arg_145_1:FormatText(var_148_21.content)

				arg_145_1.text_.text = var_148_22

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_23 = 20
				local var_148_24 = utf8.len(var_148_22)
				local var_148_25 = var_148_23 <= 0 and var_148_19 or var_148_19 * (var_148_24 / var_148_23)

				if var_148_25 > 0 and var_148_19 < var_148_25 then
					arg_145_1.talkMaxDuration = var_148_25

					if var_148_25 + var_148_18 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_25 + var_148_18
					end
				end

				arg_145_1.text_.text = var_148_22
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041035", "story_v_out_322041.awb") ~= 0 then
					local var_148_26 = manager.audio:GetVoiceLength("story_v_out_322041", "322041035", "story_v_out_322041.awb") / 1000

					if var_148_26 + var_148_18 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_26 + var_148_18
					end

					if var_148_21.prefab_name ~= "" and arg_145_1.actors_[var_148_21.prefab_name] ~= nil then
						local var_148_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_21.prefab_name].transform, "story_v_out_322041", "322041035", "story_v_out_322041.awb")

						arg_145_1:RecordAudio("322041035", var_148_27)
						arg_145_1:RecordAudio("322041035", var_148_27)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_322041", "322041035", "story_v_out_322041.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_322041", "322041035", "story_v_out_322041.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_28 = math.max(var_148_19, arg_145_1.talkMaxDuration)

			if var_148_18 <= arg_145_1.time_ and arg_145_1.time_ < var_148_18 + var_148_28 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_18) / var_148_28

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_18 + var_148_28 and arg_145_1.time_ < var_148_18 + var_148_28 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play322041036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322041036
		arg_149_1.duration_ = 10.77

		local var_149_0 = {
			zh = 8.632999999999,
			ja = 10.765999999999
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
				arg_149_0:Play322041037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = "L15f"

			if arg_149_1.bgs_[var_152_0] == nil then
				local var_152_1 = Object.Instantiate(arg_149_1.paintGo_)

				var_152_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_152_0)
				var_152_1.name = var_152_0
				var_152_1.transform.parent = arg_149_1.stage_.transform
				var_152_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.bgs_[var_152_0] = var_152_1
			end

			local var_152_2 = 1.999999999999

			if var_152_2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				local var_152_3 = manager.ui.mainCamera.transform.localPosition
				local var_152_4 = Vector3.New(0, 0, 10) + Vector3.New(var_152_3.x, var_152_3.y, 0)
				local var_152_5 = arg_149_1.bgs_.L15f

				var_152_5.transform.localPosition = var_152_4
				var_152_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_6 = var_152_5:GetComponent("SpriteRenderer")

				if var_152_6 and var_152_6.sprite then
					local var_152_7 = (var_152_5.transform.localPosition - var_152_3).z
					local var_152_8 = manager.ui.mainCameraCom_
					local var_152_9 = 2 * var_152_7 * Mathf.Tan(var_152_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_152_10 = var_152_9 * var_152_8.aspect
					local var_152_11 = var_152_6.sprite.bounds.size.x
					local var_152_12 = var_152_6.sprite.bounds.size.y
					local var_152_13 = var_152_10 / var_152_11
					local var_152_14 = var_152_9 / var_152_12
					local var_152_15 = var_152_14 < var_152_13 and var_152_13 or var_152_14

					var_152_5.transform.localScale = Vector3.New(var_152_15, var_152_15, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "L15f" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_16 = 3.999999999999

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			local var_152_17 = 0.3

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end

			local var_152_18 = 0

			if var_152_18 < arg_149_1.time_ and arg_149_1.time_ <= var_152_18 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_19 = 2

			if var_152_18 <= arg_149_1.time_ and arg_149_1.time_ < var_152_18 + var_152_19 then
				local var_152_20 = (arg_149_1.time_ - var_152_18) / var_152_19
				local var_152_21 = Color.New(0, 0, 0)

				var_152_21.a = Mathf.Lerp(0, 1, var_152_20)
				arg_149_1.mask_.color = var_152_21
			end

			if arg_149_1.time_ >= var_152_18 + var_152_19 and arg_149_1.time_ < var_152_18 + var_152_19 + arg_152_0 then
				local var_152_22 = Color.New(0, 0, 0)

				var_152_22.a = 1
				arg_149_1.mask_.color = var_152_22
			end

			local var_152_23 = 2

			if var_152_23 < arg_149_1.time_ and arg_149_1.time_ <= var_152_23 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_24 = 2

			if var_152_23 <= arg_149_1.time_ and arg_149_1.time_ < var_152_23 + var_152_24 then
				local var_152_25 = (arg_149_1.time_ - var_152_23) / var_152_24
				local var_152_26 = Color.New(0, 0, 0)

				var_152_26.a = Mathf.Lerp(1, 0, var_152_25)
				arg_149_1.mask_.color = var_152_26
			end

			if arg_149_1.time_ >= var_152_23 + var_152_24 and arg_149_1.time_ < var_152_23 + var_152_24 + arg_152_0 then
				local var_152_27 = Color.New(0, 0, 0)
				local var_152_28 = 0

				arg_149_1.mask_.enabled = false
				var_152_27.a = var_152_28
				arg_149_1.mask_.color = var_152_27
			end

			local var_152_29 = arg_149_1.actors_["10104ui_story"].transform
			local var_152_30 = 1.96599999815226

			if var_152_30 < arg_149_1.time_ and arg_149_1.time_ <= var_152_30 + arg_152_0 then
				arg_149_1.var_.moveOldPos10104ui_story = var_152_29.localPosition
			end

			local var_152_31 = 0.001

			if var_152_30 <= arg_149_1.time_ and arg_149_1.time_ < var_152_30 + var_152_31 then
				local var_152_32 = (arg_149_1.time_ - var_152_30) / var_152_31
				local var_152_33 = Vector3.New(0, 100, 0)

				var_152_29.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10104ui_story, var_152_33, var_152_32)

				local var_152_34 = manager.ui.mainCamera.transform.position - var_152_29.position

				var_152_29.forward = Vector3.New(var_152_34.x, var_152_34.y, var_152_34.z)

				local var_152_35 = var_152_29.localEulerAngles

				var_152_35.z = 0
				var_152_35.x = 0
				var_152_29.localEulerAngles = var_152_35
			end

			if arg_149_1.time_ >= var_152_30 + var_152_31 and arg_149_1.time_ < var_152_30 + var_152_31 + arg_152_0 then
				var_152_29.localPosition = Vector3.New(0, 100, 0)

				local var_152_36 = manager.ui.mainCamera.transform.position - var_152_29.position

				var_152_29.forward = Vector3.New(var_152_36.x, var_152_36.y, var_152_36.z)

				local var_152_37 = var_152_29.localEulerAngles

				var_152_37.z = 0
				var_152_37.x = 0
				var_152_29.localEulerAngles = var_152_37
			end

			local var_152_38 = arg_149_1.actors_["1284ui_story"].transform
			local var_152_39 = 1.96599999815226

			if var_152_39 < arg_149_1.time_ and arg_149_1.time_ <= var_152_39 + arg_152_0 then
				arg_149_1.var_.moveOldPos1284ui_story = var_152_38.localPosition
			end

			local var_152_40 = 0.001

			if var_152_39 <= arg_149_1.time_ and arg_149_1.time_ < var_152_39 + var_152_40 then
				local var_152_41 = (arg_149_1.time_ - var_152_39) / var_152_40
				local var_152_42 = Vector3.New(0, 100, 0)

				var_152_38.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1284ui_story, var_152_42, var_152_41)

				local var_152_43 = manager.ui.mainCamera.transform.position - var_152_38.position

				var_152_38.forward = Vector3.New(var_152_43.x, var_152_43.y, var_152_43.z)

				local var_152_44 = var_152_38.localEulerAngles

				var_152_44.z = 0
				var_152_44.x = 0
				var_152_38.localEulerAngles = var_152_44
			end

			if arg_149_1.time_ >= var_152_39 + var_152_40 and arg_149_1.time_ < var_152_39 + var_152_40 + arg_152_0 then
				var_152_38.localPosition = Vector3.New(0, 100, 0)

				local var_152_45 = manager.ui.mainCamera.transform.position - var_152_38.position

				var_152_38.forward = Vector3.New(var_152_45.x, var_152_45.y, var_152_45.z)

				local var_152_46 = var_152_38.localEulerAngles

				var_152_46.z = 0
				var_152_46.x = 0
				var_152_38.localEulerAngles = var_152_46
			end

			local var_152_47 = "10103ui_story"

			if arg_149_1.actors_[var_152_47] == nil then
				local var_152_48 = Asset.Load("Char/" .. "10103ui_story")

				if not isNil(var_152_48) then
					local var_152_49 = Object.Instantiate(Asset.Load("Char/" .. "10103ui_story"), arg_149_1.stage_.transform)

					var_152_49.name = var_152_47
					var_152_49.transform.localPosition = Vector3.New(0, 100, 0)
					arg_149_1.actors_[var_152_47] = var_152_49

					local var_152_50 = var_152_49:GetComponentInChildren(typeof(CharacterEffect))

					var_152_50.enabled = true

					local var_152_51 = GameObjectTools.GetOrAddComponent(var_152_49, typeof(DynamicBoneHelper))

					if var_152_51 then
						var_152_51:EnableDynamicBone(false)
					end

					arg_149_1:ShowWeapon(var_152_50.transform, false)

					arg_149_1.var_[var_152_47 .. "Animator"] = var_152_50.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_149_1.var_[var_152_47 .. "Animator"].applyRootMotion = true
					arg_149_1.var_[var_152_47 .. "LipSync"] = var_152_50.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_152_52 = arg_149_1.actors_["10103ui_story"].transform
			local var_152_53 = 3.8

			if var_152_53 < arg_149_1.time_ and arg_149_1.time_ <= var_152_53 + arg_152_0 then
				arg_149_1.var_.moveOldPos10103ui_story = var_152_52.localPosition

				local var_152_54 = GameObjectTools.GetOrAddComponent(var_152_52.gameObject, typeof(DynamicBoneHelper))

				if var_152_54 then
					var_152_54:EnableDynamicBone(false)
				end
			end

			local var_152_55 = 0.001

			if var_152_53 <= arg_149_1.time_ and arg_149_1.time_ < var_152_53 + var_152_55 then
				local var_152_56 = (arg_149_1.time_ - var_152_53) / var_152_55
				local var_152_57 = Vector3.New(0, -0.95, -6.2)

				var_152_52.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10103ui_story, var_152_57, var_152_56)

				local var_152_58 = manager.ui.mainCamera.transform.position - var_152_52.position

				var_152_52.forward = Vector3.New(var_152_58.x, var_152_58.y, var_152_58.z)

				local var_152_59 = var_152_52.localEulerAngles

				var_152_59.z = 0
				var_152_59.x = 0
				var_152_52.localEulerAngles = var_152_59
			end

			if arg_149_1.time_ >= var_152_53 + var_152_55 and arg_149_1.time_ < var_152_53 + var_152_55 + arg_152_0 then
				var_152_52.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_152_60 = manager.ui.mainCamera.transform.position - var_152_52.position

				var_152_52.forward = Vector3.New(var_152_60.x, var_152_60.y, var_152_60.z)

				local var_152_61 = var_152_52.localEulerAngles

				var_152_61.z = 0
				var_152_61.x = 0
				var_152_52.localEulerAngles = var_152_61

				local var_152_62 = GameObjectTools.GetOrAddComponent(var_152_52.gameObject, typeof(DynamicBoneHelper))

				if var_152_62 then
					var_152_62:EnableDynamicBone(true)
				end
			end

			local var_152_63 = arg_149_1.actors_["10103ui_story"]
			local var_152_64 = 3.8

			if var_152_64 < arg_149_1.time_ and arg_149_1.time_ <= var_152_64 + arg_152_0 and not isNil(var_152_63) and arg_149_1.var_.characterEffect10103ui_story == nil then
				arg_149_1.var_.characterEffect10103ui_story = var_152_63:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_65 = 0.200000002980232

			if var_152_64 <= arg_149_1.time_ and arg_149_1.time_ < var_152_64 + var_152_65 and not isNil(var_152_63) then
				local var_152_66 = (arg_149_1.time_ - var_152_64) / var_152_65

				if arg_149_1.var_.characterEffect10103ui_story and not isNil(var_152_63) then
					arg_149_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_64 + var_152_65 and arg_149_1.time_ < var_152_64 + var_152_65 + arg_152_0 and not isNil(var_152_63) and arg_149_1.var_.characterEffect10103ui_story then
				arg_149_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_152_67 = 3.8

			if var_152_67 < arg_149_1.time_ and arg_149_1.time_ <= var_152_67 + arg_152_0 then
				arg_149_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_152_68 = 3.8

			if var_152_68 < arg_149_1.time_ and arg_149_1.time_ <= var_152_68 + arg_152_0 then
				arg_149_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_152_69 = arg_149_1.actors_["10104ui_story"]
			local var_152_70 = 2

			if var_152_70 < arg_149_1.time_ and arg_149_1.time_ <= var_152_70 + arg_152_0 then
				if arg_149_1.var_.characterEffect10104ui_story == nil then
					arg_149_1.var_.characterEffect10104ui_story = var_152_69:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_152_71 = arg_149_1.var_.characterEffect10104ui_story

				var_152_71.imageEffect:turnOff()

				var_152_71.interferenceEffect.enabled = false
				var_152_71.interferenceEffect.noise = 0.001
				var_152_71.interferenceEffect.simTimeScale = 1
				var_152_71.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_152_72 = arg_149_1.actors_["10104ui_story"]
			local var_152_73 = 2
			local var_152_74 = 0.0166666666666667

			if var_152_73 < arg_149_1.time_ and arg_149_1.time_ <= var_152_73 + arg_152_0 then
				if arg_149_1.var_.characterEffect10104ui_story == nil then
					arg_149_1.var_.characterEffect10104ui_story = var_152_72:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_149_1.var_.characterEffect10104ui_story.imageEffect:turnOff()
			end

			local var_152_75 = 3.8

			if var_152_75 < arg_149_1.time_ and arg_149_1.time_ <= var_152_75 + arg_152_0 then
				local var_152_76 = arg_149_1.actors_["10103ui_story"]

				if not isNil(var_152_76) then
					local var_152_77 = GameObjectTools.GetOrAddComponent(var_152_76, typeof(DynamicBoneHelper))

					if var_152_77 then
						var_152_77:EnableDynamicBone(true)
					end
				end
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_78 = 3.999999999999
			local var_152_79 = 0.475

			if var_152_78 < arg_149_1.time_ and arg_149_1.time_ <= var_152_78 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_80 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_80:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_149_1.dialogCg_.alpha = arg_153_0
				end))
				var_152_80:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_80:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_81 = arg_149_1:FormatText(StoryNameCfg[1214].name)

				arg_149_1.leftNameTxt_.text = var_152_81

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_82 = arg_149_1:GetWordFromCfg(322041036)
				local var_152_83 = arg_149_1:FormatText(var_152_82.content)

				arg_149_1.text_.text = var_152_83

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_84 = 19
				local var_152_85 = utf8.len(var_152_83)
				local var_152_86 = var_152_84 <= 0 and var_152_79 or var_152_79 * (var_152_85 / var_152_84)

				if var_152_86 > 0 and var_152_79 < var_152_86 then
					arg_149_1.talkMaxDuration = var_152_86
					var_152_78 = var_152_78 + 0.3

					if var_152_86 + var_152_78 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_86 + var_152_78
					end
				end

				arg_149_1.text_.text = var_152_83
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041036", "story_v_out_322041.awb") ~= 0 then
					local var_152_87 = manager.audio:GetVoiceLength("story_v_out_322041", "322041036", "story_v_out_322041.awb") / 1000

					if var_152_87 + var_152_78 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_87 + var_152_78
					end

					if var_152_82.prefab_name ~= "" and arg_149_1.actors_[var_152_82.prefab_name] ~= nil then
						local var_152_88 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_82.prefab_name].transform, "story_v_out_322041", "322041036", "story_v_out_322041.awb")

						arg_149_1:RecordAudio("322041036", var_152_88)
						arg_149_1:RecordAudio("322041036", var_152_88)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322041", "322041036", "story_v_out_322041.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322041", "322041036", "story_v_out_322041.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_89 = var_152_78 + 0.3
			local var_152_90 = math.max(var_152_79, arg_149_1.talkMaxDuration)

			if var_152_89 <= arg_149_1.time_ and arg_149_1.time_ < var_152_89 + var_152_90 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_89) / var_152_90

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_89 + var_152_90 and arg_149_1.time_ < var_152_89 + var_152_90 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play322041037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 322041037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play322041038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10103ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10103ui_story = var_158_0.localPosition

				local var_158_2 = GameObjectTools.GetOrAddComponent(var_158_0.gameObject, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(false)
				end
			end

			local var_158_3 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_3 then
				local var_158_4 = (arg_155_1.time_ - var_158_1) / var_158_3
				local var_158_5 = Vector3.New(0, 100, 0)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10103ui_story, var_158_5, var_158_4)

				local var_158_6 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_6.x, var_158_6.y, var_158_6.z)

				local var_158_7 = var_158_0.localEulerAngles

				var_158_7.z = 0
				var_158_7.x = 0
				var_158_0.localEulerAngles = var_158_7
			end

			if arg_155_1.time_ >= var_158_1 + var_158_3 and arg_155_1.time_ < var_158_1 + var_158_3 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, 100, 0)

				local var_158_8 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_8.x, var_158_8.y, var_158_8.z)

				local var_158_9 = var_158_0.localEulerAngles

				var_158_9.z = 0
				var_158_9.x = 0
				var_158_0.localEulerAngles = var_158_9

				local var_158_10 = GameObjectTools.GetOrAddComponent(var_158_0.gameObject, typeof(DynamicBoneHelper))

				if var_158_10 then
					var_158_10:EnableDynamicBone(true)
				end
			end

			local var_158_11 = 0
			local var_158_12 = 1

			if var_158_11 < arg_155_1.time_ and arg_155_1.time_ <= var_158_11 + arg_158_0 then
				local var_158_13 = "play"
				local var_158_14 = "effect"

				arg_155_1:AudioAction(var_158_13, var_158_14, "se_story_145", "se_story_145_police_car", "")
			end

			local var_158_15 = 0
			local var_158_16 = 0.975

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_17 = arg_155_1:GetWordFromCfg(322041037)
				local var_158_18 = arg_155_1:FormatText(var_158_17.content)

				arg_155_1.text_.text = var_158_18

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_19 = 39
				local var_158_20 = utf8.len(var_158_18)
				local var_158_21 = var_158_19 <= 0 and var_158_16 or var_158_16 * (var_158_20 / var_158_19)

				if var_158_21 > 0 and var_158_16 < var_158_21 then
					arg_155_1.talkMaxDuration = var_158_21

					if var_158_21 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_21 + var_158_15
					end
				end

				arg_155_1.text_.text = var_158_18
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_22 = math.max(var_158_16, arg_155_1.talkMaxDuration)

			if var_158_15 <= arg_155_1.time_ and arg_155_1.time_ < var_158_15 + var_158_22 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_15) / var_158_22

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_15 + var_158_22 and arg_155_1.time_ < var_158_15 + var_158_22 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
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
	Play322041038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322041038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play322041039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.575

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(322041038)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 23
				local var_162_5 = utf8.len(var_162_3)
				local var_162_6 = var_162_4 <= 0 and var_162_1 or var_162_1 * (var_162_5 / var_162_4)

				if var_162_6 > 0 and var_162_1 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_7 and arg_159_1.time_ < var_162_0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play322041039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 322041039
		arg_163_1.duration_ = 8.73

		local var_163_0 = {
			zh = 5.1,
			ja = 8.733
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
				arg_163_0:Play322041040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10103ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10103ui_story = var_166_0.localPosition

				local var_166_2 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(false)
				end
			end

			local var_166_3 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_3 then
				local var_166_4 = (arg_163_1.time_ - var_166_1) / var_166_3
				local var_166_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10103ui_story, var_166_5, var_166_4)

				local var_166_6 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_6.x, var_166_6.y, var_166_6.z)

				local var_166_7 = var_166_0.localEulerAngles

				var_166_7.z = 0
				var_166_7.x = 0
				var_166_0.localEulerAngles = var_166_7
			end

			if arg_163_1.time_ >= var_166_1 + var_166_3 and arg_163_1.time_ < var_166_1 + var_166_3 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_166_8 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_8.x, var_166_8.y, var_166_8.z)

				local var_166_9 = var_166_0.localEulerAngles

				var_166_9.z = 0
				var_166_9.x = 0
				var_166_0.localEulerAngles = var_166_9

				local var_166_10 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_10 then
					var_166_10:EnableDynamicBone(true)
				end
			end

			local var_166_11 = arg_163_1.actors_["10103ui_story"]
			local var_166_12 = 0

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect10103ui_story == nil then
				arg_163_1.var_.characterEffect10103ui_story = var_166_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_13 = 0.200000002980232

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_13 and not isNil(var_166_11) then
				local var_166_14 = (arg_163_1.time_ - var_166_12) / var_166_13

				if arg_163_1.var_.characterEffect10103ui_story and not isNil(var_166_11) then
					arg_163_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_12 + var_166_13 and arg_163_1.time_ < var_166_12 + var_166_13 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect10103ui_story then
				arg_163_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_166_15 = 0

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_166_17 = 0

			if var_166_17 < arg_163_1.time_ and arg_163_1.time_ <= var_166_17 + arg_166_0 then
				local var_166_18 = arg_163_1.actors_["10103ui_story"]

				if not isNil(var_166_18) then
					local var_166_19 = GameObjectTools.GetOrAddComponent(var_166_18, typeof(DynamicBoneHelper))

					if var_166_19 then
						var_166_19:EnableDynamicBone(true)
					end
				end
			end

			local var_166_20 = 0
			local var_166_21 = 0.6

			if var_166_20 < arg_163_1.time_ and arg_163_1.time_ <= var_166_20 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_22 = arg_163_1:FormatText(StoryNameCfg[1214].name)

				arg_163_1.leftNameTxt_.text = var_166_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_23 = arg_163_1:GetWordFromCfg(322041039)
				local var_166_24 = arg_163_1:FormatText(var_166_23.content)

				arg_163_1.text_.text = var_166_24

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_25 = 24
				local var_166_26 = utf8.len(var_166_24)
				local var_166_27 = var_166_25 <= 0 and var_166_21 or var_166_21 * (var_166_26 / var_166_25)

				if var_166_27 > 0 and var_166_21 < var_166_27 then
					arg_163_1.talkMaxDuration = var_166_27

					if var_166_27 + var_166_20 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_27 + var_166_20
					end
				end

				arg_163_1.text_.text = var_166_24
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041039", "story_v_out_322041.awb") ~= 0 then
					local var_166_28 = manager.audio:GetVoiceLength("story_v_out_322041", "322041039", "story_v_out_322041.awb") / 1000

					if var_166_28 + var_166_20 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_28 + var_166_20
					end

					if var_166_23.prefab_name ~= "" and arg_163_1.actors_[var_166_23.prefab_name] ~= nil then
						local var_166_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_23.prefab_name].transform, "story_v_out_322041", "322041039", "story_v_out_322041.awb")

						arg_163_1:RecordAudio("322041039", var_166_29)
						arg_163_1:RecordAudio("322041039", var_166_29)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_322041", "322041039", "story_v_out_322041.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_322041", "322041039", "story_v_out_322041.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_30 = math.max(var_166_21, arg_163_1.talkMaxDuration)

			if var_166_20 <= arg_163_1.time_ and arg_163_1.time_ < var_166_20 + var_166_30 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_20) / var_166_30

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_20 + var_166_30 and arg_163_1.time_ < var_166_20 + var_166_30 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
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
	Play322041040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322041040
		arg_167_1.duration_ = 2.8

		local var_167_0 = {
			zh = 2.566,
			ja = 2.8
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play322041041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = "10150ui_story"

			if arg_167_1.actors_[var_170_0] == nil then
				local var_170_1 = Asset.Load("Char/" .. "10150ui_story")

				if not isNil(var_170_1) then
					local var_170_2 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_167_1.stage_.transform)

					var_170_2.name = var_170_0
					var_170_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_167_1.actors_[var_170_0] = var_170_2

					local var_170_3 = var_170_2:GetComponentInChildren(typeof(CharacterEffect))

					var_170_3.enabled = true

					local var_170_4 = GameObjectTools.GetOrAddComponent(var_170_2, typeof(DynamicBoneHelper))

					if var_170_4 then
						var_170_4:EnableDynamicBone(false)
					end

					arg_167_1:ShowWeapon(var_170_3.transform, false)

					arg_167_1.var_[var_170_0 .. "Animator"] = var_170_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_167_1.var_[var_170_0 .. "Animator"].applyRootMotion = true
					arg_167_1.var_[var_170_0 .. "LipSync"] = var_170_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_170_5 = arg_167_1.actors_["10150ui_story"].transform
			local var_170_6 = 0

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.var_.moveOldPos10150ui_story = var_170_5.localPosition

				local var_170_7 = GameObjectTools.GetOrAddComponent(var_170_5.gameObject, typeof(DynamicBoneHelper))

				if var_170_7 then
					var_170_7:EnableDynamicBone(false)
				end
			end

			local var_170_8 = 0.001

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_8 then
				local var_170_9 = (arg_167_1.time_ - var_170_6) / var_170_8
				local var_170_10 = Vector3.New(0.9, -1.73, -5.5)

				var_170_5.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10150ui_story, var_170_10, var_170_9)

				local var_170_11 = manager.ui.mainCamera.transform.position - var_170_5.position

				var_170_5.forward = Vector3.New(var_170_11.x, var_170_11.y, var_170_11.z)

				local var_170_12 = var_170_5.localEulerAngles

				var_170_12.z = 0
				var_170_12.x = 0
				var_170_5.localEulerAngles = var_170_12
			end

			if arg_167_1.time_ >= var_170_6 + var_170_8 and arg_167_1.time_ < var_170_6 + var_170_8 + arg_170_0 then
				var_170_5.localPosition = Vector3.New(0.9, -1.73, -5.5)

				local var_170_13 = manager.ui.mainCamera.transform.position - var_170_5.position

				var_170_5.forward = Vector3.New(var_170_13.x, var_170_13.y, var_170_13.z)

				local var_170_14 = var_170_5.localEulerAngles

				var_170_14.z = 0
				var_170_14.x = 0
				var_170_5.localEulerAngles = var_170_14

				local var_170_15 = GameObjectTools.GetOrAddComponent(var_170_5.gameObject, typeof(DynamicBoneHelper))

				if var_170_15 then
					var_170_15:EnableDynamicBone(true)
				end
			end

			local var_170_16 = arg_167_1.actors_["10150ui_story"]
			local var_170_17 = 0

			if var_170_17 < arg_167_1.time_ and arg_167_1.time_ <= var_170_17 + arg_170_0 and not isNil(var_170_16) and arg_167_1.var_.characterEffect10150ui_story == nil then
				arg_167_1.var_.characterEffect10150ui_story = var_170_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_18 = 0.200000002980232

			if var_170_17 <= arg_167_1.time_ and arg_167_1.time_ < var_170_17 + var_170_18 and not isNil(var_170_16) then
				local var_170_19 = (arg_167_1.time_ - var_170_17) / var_170_18

				if arg_167_1.var_.characterEffect10150ui_story and not isNil(var_170_16) then
					arg_167_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_17 + var_170_18 and arg_167_1.time_ < var_170_17 + var_170_18 + arg_170_0 and not isNil(var_170_16) and arg_167_1.var_.characterEffect10150ui_story then
				arg_167_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_170_20 = arg_167_1.actors_["10103ui_story"]
			local var_170_21 = 0

			if var_170_21 < arg_167_1.time_ and arg_167_1.time_ <= var_170_21 + arg_170_0 and not isNil(var_170_20) and arg_167_1.var_.characterEffect10103ui_story == nil then
				arg_167_1.var_.characterEffect10103ui_story = var_170_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_22 = 0.200000002980232

			if var_170_21 <= arg_167_1.time_ and arg_167_1.time_ < var_170_21 + var_170_22 and not isNil(var_170_20) then
				local var_170_23 = (arg_167_1.time_ - var_170_21) / var_170_22

				if arg_167_1.var_.characterEffect10103ui_story and not isNil(var_170_20) then
					local var_170_24 = Mathf.Lerp(0, 0.5, var_170_23)

					arg_167_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10103ui_story.fillRatio = var_170_24
				end
			end

			if arg_167_1.time_ >= var_170_21 + var_170_22 and arg_167_1.time_ < var_170_21 + var_170_22 + arg_170_0 and not isNil(var_170_20) and arg_167_1.var_.characterEffect10103ui_story then
				local var_170_25 = 0.5

				arg_167_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10103ui_story.fillRatio = var_170_25
			end

			local var_170_26 = 0

			if var_170_26 < arg_167_1.time_ and arg_167_1.time_ <= var_170_26 + arg_170_0 then
				arg_167_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			local var_170_27 = 0

			if var_170_27 < arg_167_1.time_ and arg_167_1.time_ <= var_170_27 + arg_170_0 then
				arg_167_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_170_28 = 0
			local var_170_29 = 0.275

			if var_170_28 < arg_167_1.time_ and arg_167_1.time_ <= var_170_28 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_30 = arg_167_1:FormatText(StoryNameCfg[1361].name)

				arg_167_1.leftNameTxt_.text = var_170_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_31 = arg_167_1:GetWordFromCfg(322041040)
				local var_170_32 = arg_167_1:FormatText(var_170_31.content)

				arg_167_1.text_.text = var_170_32

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_33 = 11
				local var_170_34 = utf8.len(var_170_32)
				local var_170_35 = var_170_33 <= 0 and var_170_29 or var_170_29 * (var_170_34 / var_170_33)

				if var_170_35 > 0 and var_170_29 < var_170_35 then
					arg_167_1.talkMaxDuration = var_170_35

					if var_170_35 + var_170_28 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_35 + var_170_28
					end
				end

				arg_167_1.text_.text = var_170_32
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041040", "story_v_out_322041.awb") ~= 0 then
					local var_170_36 = manager.audio:GetVoiceLength("story_v_out_322041", "322041040", "story_v_out_322041.awb") / 1000

					if var_170_36 + var_170_28 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_36 + var_170_28
					end

					if var_170_31.prefab_name ~= "" and arg_167_1.actors_[var_170_31.prefab_name] ~= nil then
						local var_170_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_31.prefab_name].transform, "story_v_out_322041", "322041040", "story_v_out_322041.awb")

						arg_167_1:RecordAudio("322041040", var_170_37)
						arg_167_1:RecordAudio("322041040", var_170_37)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_322041", "322041040", "story_v_out_322041.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_322041", "322041040", "story_v_out_322041.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_38 = math.max(var_170_29, arg_167_1.talkMaxDuration)

			if var_170_28 <= arg_167_1.time_ and arg_167_1.time_ < var_170_28 + var_170_38 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_28) / var_170_38

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_28 + var_170_38 and arg_167_1.time_ < var_170_28 + var_170_38 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322041041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322041041
		arg_171_1.duration_ = 7.93

		local var_171_0 = {
			zh = 5.233,
			ja = 7.933
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
				arg_171_0:Play322041042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10103ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10103ui_story = var_174_0.localPosition

				local var_174_2 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(false)
				end
			end

			local var_174_3 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_3 then
				local var_174_4 = (arg_171_1.time_ - var_174_1) / var_174_3
				local var_174_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10103ui_story, var_174_5, var_174_4)

				local var_174_6 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_6.x, var_174_6.y, var_174_6.z)

				local var_174_7 = var_174_0.localEulerAngles

				var_174_7.z = 0
				var_174_7.x = 0
				var_174_0.localEulerAngles = var_174_7
			end

			if arg_171_1.time_ >= var_174_1 + var_174_3 and arg_171_1.time_ < var_174_1 + var_174_3 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_174_8 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_8.x, var_174_8.y, var_174_8.z)

				local var_174_9 = var_174_0.localEulerAngles

				var_174_9.z = 0
				var_174_9.x = 0
				var_174_0.localEulerAngles = var_174_9

				local var_174_10 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_10 then
					var_174_10:EnableDynamicBone(true)
				end
			end

			local var_174_11 = arg_171_1.actors_["10103ui_story"]
			local var_174_12 = 0

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 and not isNil(var_174_11) and arg_171_1.var_.characterEffect10103ui_story == nil then
				arg_171_1.var_.characterEffect10103ui_story = var_174_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_13 = 0.200000002980232

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_13 and not isNil(var_174_11) then
				local var_174_14 = (arg_171_1.time_ - var_174_12) / var_174_13

				if arg_171_1.var_.characterEffect10103ui_story and not isNil(var_174_11) then
					arg_171_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_12 + var_174_13 and arg_171_1.time_ < var_174_12 + var_174_13 + arg_174_0 and not isNil(var_174_11) and arg_171_1.var_.characterEffect10103ui_story then
				arg_171_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_174_15 = arg_171_1.actors_["10150ui_story"]
			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 and not isNil(var_174_15) and arg_171_1.var_.characterEffect10150ui_story == nil then
				arg_171_1.var_.characterEffect10150ui_story = var_174_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_17 = 0.200000002980232

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 and not isNil(var_174_15) then
				local var_174_18 = (arg_171_1.time_ - var_174_16) / var_174_17

				if arg_171_1.var_.characterEffect10150ui_story and not isNil(var_174_15) then
					local var_174_19 = Mathf.Lerp(0, 0.5, var_174_18)

					arg_171_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10150ui_story.fillRatio = var_174_19
				end
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 and not isNil(var_174_15) and arg_171_1.var_.characterEffect10150ui_story then
				local var_174_20 = 0.5

				arg_171_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10150ui_story.fillRatio = var_174_20
			end

			local var_174_21 = 0

			if var_174_21 < arg_171_1.time_ and arg_171_1.time_ <= var_174_21 + arg_174_0 then
				arg_171_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			local var_174_22 = 0

			if var_174_22 < arg_171_1.time_ and arg_171_1.time_ <= var_174_22 + arg_174_0 then
				arg_171_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_174_23 = 0

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				local var_174_24 = arg_171_1.actors_["10103ui_story"]

				if not isNil(var_174_24) then
					local var_174_25 = GameObjectTools.GetOrAddComponent(var_174_24, typeof(DynamicBoneHelper))

					if var_174_25 then
						var_174_25:EnableDynamicBone(true)
					end
				end
			end

			local var_174_26 = 0
			local var_174_27 = 0.45

			if var_174_26 < arg_171_1.time_ and arg_171_1.time_ <= var_174_26 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_28 = arg_171_1:FormatText(StoryNameCfg[1214].name)

				arg_171_1.leftNameTxt_.text = var_174_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_29 = arg_171_1:GetWordFromCfg(322041041)
				local var_174_30 = arg_171_1:FormatText(var_174_29.content)

				arg_171_1.text_.text = var_174_30

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_31 = 18
				local var_174_32 = utf8.len(var_174_30)
				local var_174_33 = var_174_31 <= 0 and var_174_27 or var_174_27 * (var_174_32 / var_174_31)

				if var_174_33 > 0 and var_174_27 < var_174_33 then
					arg_171_1.talkMaxDuration = var_174_33

					if var_174_33 + var_174_26 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_33 + var_174_26
					end
				end

				arg_171_1.text_.text = var_174_30
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041041", "story_v_out_322041.awb") ~= 0 then
					local var_174_34 = manager.audio:GetVoiceLength("story_v_out_322041", "322041041", "story_v_out_322041.awb") / 1000

					if var_174_34 + var_174_26 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_34 + var_174_26
					end

					if var_174_29.prefab_name ~= "" and arg_171_1.actors_[var_174_29.prefab_name] ~= nil then
						local var_174_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_29.prefab_name].transform, "story_v_out_322041", "322041041", "story_v_out_322041.awb")

						arg_171_1:RecordAudio("322041041", var_174_35)
						arg_171_1:RecordAudio("322041041", var_174_35)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_322041", "322041041", "story_v_out_322041.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_322041", "322041041", "story_v_out_322041.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_36 = math.max(var_174_27, arg_171_1.talkMaxDuration)

			if var_174_26 <= arg_171_1.time_ and arg_171_1.time_ < var_174_26 + var_174_36 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_26) / var_174_36

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_26 + var_174_36 and arg_171_1.time_ < var_174_26 + var_174_36 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
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
	Play322041042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322041042
		arg_175_1.duration_ = 8.5

		local var_175_0 = {
			zh = 8.166,
			ja = 8.5
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play322041043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.8

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[1214].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(322041042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 32
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041042", "story_v_out_322041.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_322041", "322041042", "story_v_out_322041.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_322041", "322041042", "story_v_out_322041.awb")

						arg_175_1:RecordAudio("322041042", var_178_9)
						arg_175_1:RecordAudio("322041042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_322041", "322041042", "story_v_out_322041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_322041", "322041042", "story_v_out_322041.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_10 and arg_175_1.time_ < var_178_0 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play322041043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 322041043
		arg_179_1.duration_ = 5.67

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play322041044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10103ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos10103ui_story = var_182_0.localPosition

				local var_182_2 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(false)
				end
			end

			local var_182_3 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_3 then
				local var_182_4 = (arg_179_1.time_ - var_182_1) / var_182_3
				local var_182_5 = Vector3.New(0, 100, 0)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10103ui_story, var_182_5, var_182_4)

				local var_182_6 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_6.x, var_182_6.y, var_182_6.z)

				local var_182_7 = var_182_0.localEulerAngles

				var_182_7.z = 0
				var_182_7.x = 0
				var_182_0.localEulerAngles = var_182_7
			end

			if arg_179_1.time_ >= var_182_1 + var_182_3 and arg_179_1.time_ < var_182_1 + var_182_3 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0, 100, 0)

				local var_182_8 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_8.x, var_182_8.y, var_182_8.z)

				local var_182_9 = var_182_0.localEulerAngles

				var_182_9.z = 0
				var_182_9.x = 0
				var_182_0.localEulerAngles = var_182_9

				local var_182_10 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_10 then
					var_182_10:EnableDynamicBone(true)
				end
			end

			local var_182_11 = arg_179_1.actors_["10150ui_story"].transform
			local var_182_12 = 0

			if var_182_12 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 then
				arg_179_1.var_.moveOldPos10150ui_story = var_182_11.localPosition

				local var_182_13 = GameObjectTools.GetOrAddComponent(var_182_11.gameObject, typeof(DynamicBoneHelper))

				if var_182_13 then
					var_182_13:EnableDynamicBone(false)
				end
			end

			local var_182_14 = 0.001

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_14 then
				local var_182_15 = (arg_179_1.time_ - var_182_12) / var_182_14
				local var_182_16 = Vector3.New(0, 100, 0)

				var_182_11.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10150ui_story, var_182_16, var_182_15)

				local var_182_17 = manager.ui.mainCamera.transform.position - var_182_11.position

				var_182_11.forward = Vector3.New(var_182_17.x, var_182_17.y, var_182_17.z)

				local var_182_18 = var_182_11.localEulerAngles

				var_182_18.z = 0
				var_182_18.x = 0
				var_182_11.localEulerAngles = var_182_18
			end

			if arg_179_1.time_ >= var_182_12 + var_182_14 and arg_179_1.time_ < var_182_12 + var_182_14 + arg_182_0 then
				var_182_11.localPosition = Vector3.New(0, 100, 0)

				local var_182_19 = manager.ui.mainCamera.transform.position - var_182_11.position

				var_182_11.forward = Vector3.New(var_182_19.x, var_182_19.y, var_182_19.z)

				local var_182_20 = var_182_11.localEulerAngles

				var_182_20.z = 0
				var_182_20.x = 0
				var_182_11.localEulerAngles = var_182_20

				local var_182_21 = GameObjectTools.GetOrAddComponent(var_182_11.gameObject, typeof(DynamicBoneHelper))

				if var_182_21 then
					var_182_21:EnableDynamicBone(true)
				end
			end

			local var_182_22 = arg_179_1.actors_["10103ui_story"]
			local var_182_23 = 0

			if var_182_23 < arg_179_1.time_ and arg_179_1.time_ <= var_182_23 + arg_182_0 and not isNil(var_182_22) and arg_179_1.var_.characterEffect10103ui_story == nil then
				arg_179_1.var_.characterEffect10103ui_story = var_182_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_24 = 0.400000005960464

			if var_182_23 <= arg_179_1.time_ and arg_179_1.time_ < var_182_23 + var_182_24 and not isNil(var_182_22) then
				local var_182_25 = (arg_179_1.time_ - var_182_23) / var_182_24

				if arg_179_1.var_.characterEffect10103ui_story and not isNil(var_182_22) then
					local var_182_26 = Mathf.Lerp(0, 0.5, var_182_25)

					arg_179_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10103ui_story.fillRatio = var_182_26
				end
			end

			if arg_179_1.time_ >= var_182_23 + var_182_24 and arg_179_1.time_ < var_182_23 + var_182_24 + arg_182_0 and not isNil(var_182_22) and arg_179_1.var_.characterEffect10103ui_story then
				local var_182_27 = 0.5

				arg_179_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10103ui_story.fillRatio = var_182_27
			end

			local var_182_28 = 0.400000005960464
			local var_182_29 = 1

			if var_182_28 < arg_179_1.time_ and arg_179_1.time_ <= var_182_28 + arg_182_0 then
				local var_182_30 = "play"
				local var_182_31 = "effect"

				arg_179_1:AudioAction(var_182_30, var_182_31, "se_story_140", "se_story_140_car02", "")
			end

			local var_182_32 = manager.ui.mainCamera.transform
			local var_182_33 = 0.766666666666667

			if var_182_33 < arg_179_1.time_ and arg_179_1.time_ <= var_182_33 + arg_182_0 then
				local var_182_34 = arg_179_1.var_.effect1043
				local var_182_35
				local var_182_36 = var_182_32

				if not var_182_34 then
					var_182_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_182_36)
					var_182_34.name = "1043"
					arg_179_1.var_.effect1043 = var_182_34
				else
					var_182_34.transform:SetParent(var_182_36)
				end

				var_182_34.transform.localPosition = Vector3.New(0, 0, -3.74)
				var_182_34.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_182_37 = manager.ui.mainCamera.transform
			local var_182_38 = 1.89999999701977

			if var_182_38 < arg_179_1.time_ and arg_179_1.time_ <= var_182_38 + arg_182_0 then
				local var_182_39 = arg_179_1.var_.effect1043

				if var_182_39 then
					Object.Destroy(var_182_39)

					arg_179_1.var_.effect1043 = nil
				end
			end

			local var_182_40 = manager.ui.mainCamera.transform
			local var_182_41 = 0.766666666666667

			if var_182_41 < arg_179_1.time_ and arg_179_1.time_ <= var_182_41 + arg_182_0 then
				arg_179_1.var_.shakeOldPos = var_182_40.localPosition
			end

			local var_182_42 = 1

			if var_182_41 <= arg_179_1.time_ and arg_179_1.time_ < var_182_41 + var_182_42 then
				local var_182_43 = (arg_179_1.time_ - var_182_41) / 0.132
				local var_182_44, var_182_45 = math.modf(var_182_43)

				var_182_40.localPosition = Vector3.New(var_182_45 * 0.04, var_182_45 * 0.04, var_182_45 * 0.04) + arg_179_1.var_.shakeOldPos
			end

			if arg_179_1.time_ >= var_182_41 + var_182_42 and arg_179_1.time_ < var_182_41 + var_182_42 + arg_182_0 then
				var_182_40.localPosition = arg_179_1.var_.shakeOldPos
			end

			local var_182_46 = 0.666666666666667
			local var_182_47 = 1.125

			if var_182_46 < arg_179_1.time_ and arg_179_1.time_ <= var_182_46 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_48 = arg_179_1:GetWordFromCfg(322041043)
				local var_182_49 = arg_179_1:FormatText(var_182_48.content)

				arg_179_1.text_.text = var_182_49

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_50 = 45
				local var_182_51 = utf8.len(var_182_49)
				local var_182_52 = var_182_50 <= 0 and var_182_47 or var_182_47 * (var_182_51 / var_182_50)

				if var_182_52 > 0 and var_182_47 < var_182_52 then
					arg_179_1.talkMaxDuration = var_182_52

					if var_182_52 + var_182_46 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_52 + var_182_46
					end
				end

				arg_179_1.text_.text = var_182_49
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_53 = math.max(var_182_47, arg_179_1.talkMaxDuration)

			if var_182_46 <= arg_179_1.time_ and arg_179_1.time_ < var_182_46 + var_182_53 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_46) / var_182_53

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_46 + var_182_53 and arg_179_1.time_ < var_182_46 + var_182_53 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play322041044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 322041044
		arg_183_1.duration_ = 2

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play322041045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1284ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1284ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, -0.985, -6.22)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1284ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["1284ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1284ui_story == nil then
				arg_183_1.var_.characterEffect1284ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect1284ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1284ui_story then
				arg_183_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_186_15 = 0
			local var_186_16 = 0.175

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[6].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(322041044)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 7
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041044", "story_v_out_322041.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_out_322041", "322041044", "story_v_out_322041.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_out_322041", "322041044", "story_v_out_322041.awb")

						arg_183_1:RecordAudio("322041044", var_186_24)
						arg_183_1:RecordAudio("322041044", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_322041", "322041044", "story_v_out_322041.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_322041", "322041044", "story_v_out_322041.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322041045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 322041045
		arg_187_1.duration_ = 7.17

		local var_187_0 = {
			zh = 3.2,
			ja = 7.166
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
				arg_187_0:Play322041046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1284ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1284ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(0, 100, 0)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1284ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, 100, 0)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["10103ui_story"].transform
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1.var_.moveOldPos10103ui_story = var_190_9.localPosition

				local var_190_11 = GameObjectTools.GetOrAddComponent(var_190_9.gameObject, typeof(DynamicBoneHelper))

				if var_190_11 then
					var_190_11:EnableDynamicBone(false)
				end
			end

			local var_190_12 = 0.001

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_12 then
				local var_190_13 = (arg_187_1.time_ - var_190_10) / var_190_12
				local var_190_14 = Vector3.New(-0.7, -0.95, -6.2)

				var_190_9.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10103ui_story, var_190_14, var_190_13)

				local var_190_15 = manager.ui.mainCamera.transform.position - var_190_9.position

				var_190_9.forward = Vector3.New(var_190_15.x, var_190_15.y, var_190_15.z)

				local var_190_16 = var_190_9.localEulerAngles

				var_190_16.z = 0
				var_190_16.x = 0
				var_190_9.localEulerAngles = var_190_16
			end

			if arg_187_1.time_ >= var_190_10 + var_190_12 and arg_187_1.time_ < var_190_10 + var_190_12 + arg_190_0 then
				var_190_9.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_190_17 = manager.ui.mainCamera.transform.position - var_190_9.position

				var_190_9.forward = Vector3.New(var_190_17.x, var_190_17.y, var_190_17.z)

				local var_190_18 = var_190_9.localEulerAngles

				var_190_18.z = 0
				var_190_18.x = 0
				var_190_9.localEulerAngles = var_190_18

				local var_190_19 = GameObjectTools.GetOrAddComponent(var_190_9.gameObject, typeof(DynamicBoneHelper))

				if var_190_19 then
					var_190_19:EnableDynamicBone(true)
				end
			end

			local var_190_20 = arg_187_1.actors_["10103ui_story"]
			local var_190_21 = 0

			if var_190_21 < arg_187_1.time_ and arg_187_1.time_ <= var_190_21 + arg_190_0 and not isNil(var_190_20) and arg_187_1.var_.characterEffect10103ui_story == nil then
				arg_187_1.var_.characterEffect10103ui_story = var_190_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_22 = 0.200000002980232

			if var_190_21 <= arg_187_1.time_ and arg_187_1.time_ < var_190_21 + var_190_22 and not isNil(var_190_20) then
				local var_190_23 = (arg_187_1.time_ - var_190_21) / var_190_22

				if arg_187_1.var_.characterEffect10103ui_story and not isNil(var_190_20) then
					arg_187_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_21 + var_190_22 and arg_187_1.time_ < var_190_21 + var_190_22 + arg_190_0 and not isNil(var_190_20) and arg_187_1.var_.characterEffect10103ui_story then
				arg_187_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_190_24 = arg_187_1.actors_["1284ui_story"]
			local var_190_25 = 0

			if var_190_25 < arg_187_1.time_ and arg_187_1.time_ <= var_190_25 + arg_190_0 and not isNil(var_190_24) and arg_187_1.var_.characterEffect1284ui_story == nil then
				arg_187_1.var_.characterEffect1284ui_story = var_190_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_26 = 0.200000002980232

			if var_190_25 <= arg_187_1.time_ and arg_187_1.time_ < var_190_25 + var_190_26 and not isNil(var_190_24) then
				local var_190_27 = (arg_187_1.time_ - var_190_25) / var_190_26

				if arg_187_1.var_.characterEffect1284ui_story and not isNil(var_190_24) then
					local var_190_28 = Mathf.Lerp(0, 0.5, var_190_27)

					arg_187_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1284ui_story.fillRatio = var_190_28
				end
			end

			if arg_187_1.time_ >= var_190_25 + var_190_26 and arg_187_1.time_ < var_190_25 + var_190_26 + arg_190_0 and not isNil(var_190_24) and arg_187_1.var_.characterEffect1284ui_story then
				local var_190_29 = 0.5

				arg_187_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1284ui_story.fillRatio = var_190_29
			end

			local var_190_30 = 0

			if var_190_30 < arg_187_1.time_ and arg_187_1.time_ <= var_190_30 + arg_190_0 then
				arg_187_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_190_31 = 0

			if var_190_31 < arg_187_1.time_ and arg_187_1.time_ <= var_190_31 + arg_190_0 then
				arg_187_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_190_32 = 0

			if var_190_32 < arg_187_1.time_ and arg_187_1.time_ <= var_190_32 + arg_190_0 then
				local var_190_33 = arg_187_1.actors_["10103ui_story"]

				if not isNil(var_190_33) then
					local var_190_34 = GameObjectTools.GetOrAddComponent(var_190_33, typeof(DynamicBoneHelper))

					if var_190_34 then
						var_190_34:EnableDynamicBone(true)
					end
				end
			end

			local var_190_35 = 0
			local var_190_36 = 0.275

			if var_190_35 < arg_187_1.time_ and arg_187_1.time_ <= var_190_35 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_37 = arg_187_1:FormatText(StoryNameCfg[1214].name)

				arg_187_1.leftNameTxt_.text = var_190_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_38 = arg_187_1:GetWordFromCfg(322041045)
				local var_190_39 = arg_187_1:FormatText(var_190_38.content)

				arg_187_1.text_.text = var_190_39

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_40 = 11
				local var_190_41 = utf8.len(var_190_39)
				local var_190_42 = var_190_40 <= 0 and var_190_36 or var_190_36 * (var_190_41 / var_190_40)

				if var_190_42 > 0 and var_190_36 < var_190_42 then
					arg_187_1.talkMaxDuration = var_190_42

					if var_190_42 + var_190_35 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_42 + var_190_35
					end
				end

				arg_187_1.text_.text = var_190_39
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041045", "story_v_out_322041.awb") ~= 0 then
					local var_190_43 = manager.audio:GetVoiceLength("story_v_out_322041", "322041045", "story_v_out_322041.awb") / 1000

					if var_190_43 + var_190_35 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_43 + var_190_35
					end

					if var_190_38.prefab_name ~= "" and arg_187_1.actors_[var_190_38.prefab_name] ~= nil then
						local var_190_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_38.prefab_name].transform, "story_v_out_322041", "322041045", "story_v_out_322041.awb")

						arg_187_1:RecordAudio("322041045", var_190_44)
						arg_187_1:RecordAudio("322041045", var_190_44)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_322041", "322041045", "story_v_out_322041.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_322041", "322041045", "story_v_out_322041.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_45 = math.max(var_190_36, arg_187_1.talkMaxDuration)

			if var_190_35 <= arg_187_1.time_ and arg_187_1.time_ < var_190_35 + var_190_45 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_35) / var_190_45

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_35 + var_190_45 and arg_187_1.time_ < var_190_35 + var_190_45 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play322041046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 322041046
		arg_191_1.duration_ = 2

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play322041047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10150ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos10150ui_story = var_194_0.localPosition

				local var_194_2 = GameObjectTools.GetOrAddComponent(var_194_0.gameObject, typeof(DynamicBoneHelper))

				if var_194_2 then
					var_194_2:EnableDynamicBone(false)
				end
			end

			local var_194_3 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_3 then
				local var_194_4 = (arg_191_1.time_ - var_194_1) / var_194_3
				local var_194_5 = Vector3.New(0.9, -1.73, -5.5)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10150ui_story, var_194_5, var_194_4)

				local var_194_6 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_6.x, var_194_6.y, var_194_6.z)

				local var_194_7 = var_194_0.localEulerAngles

				var_194_7.z = 0
				var_194_7.x = 0
				var_194_0.localEulerAngles = var_194_7
			end

			if arg_191_1.time_ >= var_194_1 + var_194_3 and arg_191_1.time_ < var_194_1 + var_194_3 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0.9, -1.73, -5.5)

				local var_194_8 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_8.x, var_194_8.y, var_194_8.z)

				local var_194_9 = var_194_0.localEulerAngles

				var_194_9.z = 0
				var_194_9.x = 0
				var_194_0.localEulerAngles = var_194_9

				local var_194_10 = GameObjectTools.GetOrAddComponent(var_194_0.gameObject, typeof(DynamicBoneHelper))

				if var_194_10 then
					var_194_10:EnableDynamicBone(true)
				end
			end

			local var_194_11 = arg_191_1.actors_["10150ui_story"]
			local var_194_12 = 0

			if var_194_12 < arg_191_1.time_ and arg_191_1.time_ <= var_194_12 + arg_194_0 and not isNil(var_194_11) and arg_191_1.var_.characterEffect10150ui_story == nil then
				arg_191_1.var_.characterEffect10150ui_story = var_194_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_13 = 0.200000002980232

			if var_194_12 <= arg_191_1.time_ and arg_191_1.time_ < var_194_12 + var_194_13 and not isNil(var_194_11) then
				local var_194_14 = (arg_191_1.time_ - var_194_12) / var_194_13

				if arg_191_1.var_.characterEffect10150ui_story and not isNil(var_194_11) then
					arg_191_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_12 + var_194_13 and arg_191_1.time_ < var_194_12 + var_194_13 + arg_194_0 and not isNil(var_194_11) and arg_191_1.var_.characterEffect10150ui_story then
				arg_191_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_194_15 = arg_191_1.actors_["10103ui_story"]
			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 and not isNil(var_194_15) and arg_191_1.var_.characterEffect10103ui_story == nil then
				arg_191_1.var_.characterEffect10103ui_story = var_194_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_17 = 0.200000002980232

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_17 and not isNil(var_194_15) then
				local var_194_18 = (arg_191_1.time_ - var_194_16) / var_194_17

				if arg_191_1.var_.characterEffect10103ui_story and not isNil(var_194_15) then
					local var_194_19 = Mathf.Lerp(0, 0.5, var_194_18)

					arg_191_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10103ui_story.fillRatio = var_194_19
				end
			end

			if arg_191_1.time_ >= var_194_16 + var_194_17 and arg_191_1.time_ < var_194_16 + var_194_17 + arg_194_0 and not isNil(var_194_15) and arg_191_1.var_.characterEffect10103ui_story then
				local var_194_20 = 0.5

				arg_191_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10103ui_story.fillRatio = var_194_20
			end

			local var_194_21 = 0

			if var_194_21 < arg_191_1.time_ and arg_191_1.time_ <= var_194_21 + arg_194_0 then
				arg_191_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action4_1")
			end

			local var_194_22 = 0

			if var_194_22 < arg_191_1.time_ and arg_191_1.time_ <= var_194_22 + arg_194_0 then
				arg_191_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_194_23 = 0
			local var_194_24 = 0.175

			if var_194_23 < arg_191_1.time_ and arg_191_1.time_ <= var_194_23 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_25 = arg_191_1:FormatText(StoryNameCfg[1361].name)

				arg_191_1.leftNameTxt_.text = var_194_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_26 = arg_191_1:GetWordFromCfg(322041046)
				local var_194_27 = arg_191_1:FormatText(var_194_26.content)

				arg_191_1.text_.text = var_194_27

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_28 = 7
				local var_194_29 = utf8.len(var_194_27)
				local var_194_30 = var_194_28 <= 0 and var_194_24 or var_194_24 * (var_194_29 / var_194_28)

				if var_194_30 > 0 and var_194_24 < var_194_30 then
					arg_191_1.talkMaxDuration = var_194_30

					if var_194_30 + var_194_23 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_30 + var_194_23
					end
				end

				arg_191_1.text_.text = var_194_27
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041046", "story_v_out_322041.awb") ~= 0 then
					local var_194_31 = manager.audio:GetVoiceLength("story_v_out_322041", "322041046", "story_v_out_322041.awb") / 1000

					if var_194_31 + var_194_23 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_31 + var_194_23
					end

					if var_194_26.prefab_name ~= "" and arg_191_1.actors_[var_194_26.prefab_name] ~= nil then
						local var_194_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_26.prefab_name].transform, "story_v_out_322041", "322041046", "story_v_out_322041.awb")

						arg_191_1:RecordAudio("322041046", var_194_32)
						arg_191_1:RecordAudio("322041046", var_194_32)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_322041", "322041046", "story_v_out_322041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_322041", "322041046", "story_v_out_322041.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_33 = math.max(var_194_24, arg_191_1.talkMaxDuration)

			if var_194_23 <= arg_191_1.time_ and arg_191_1.time_ < var_194_23 + var_194_33 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_23) / var_194_33

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_23 + var_194_33 and arg_191_1.time_ < var_194_23 + var_194_33 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322041047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 322041047
		arg_195_1.duration_ = 8.47

		local var_195_0 = {
			zh = 4.333,
			ja = 8.466
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
				arg_195_0:Play322041048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10103ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos10103ui_story = var_198_0.localPosition

				local var_198_2 = GameObjectTools.GetOrAddComponent(var_198_0.gameObject, typeof(DynamicBoneHelper))

				if var_198_2 then
					var_198_2:EnableDynamicBone(false)
				end
			end

			local var_198_3 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_3 then
				local var_198_4 = (arg_195_1.time_ - var_198_1) / var_198_3
				local var_198_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10103ui_story, var_198_5, var_198_4)

				local var_198_6 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_6.x, var_198_6.y, var_198_6.z)

				local var_198_7 = var_198_0.localEulerAngles

				var_198_7.z = 0
				var_198_7.x = 0
				var_198_0.localEulerAngles = var_198_7
			end

			if arg_195_1.time_ >= var_198_1 + var_198_3 and arg_195_1.time_ < var_198_1 + var_198_3 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_198_8 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_8.x, var_198_8.y, var_198_8.z)

				local var_198_9 = var_198_0.localEulerAngles

				var_198_9.z = 0
				var_198_9.x = 0
				var_198_0.localEulerAngles = var_198_9

				local var_198_10 = GameObjectTools.GetOrAddComponent(var_198_0.gameObject, typeof(DynamicBoneHelper))

				if var_198_10 then
					var_198_10:EnableDynamicBone(true)
				end
			end

			local var_198_11 = arg_195_1.actors_["10103ui_story"]
			local var_198_12 = 0

			if var_198_12 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 and not isNil(var_198_11) and arg_195_1.var_.characterEffect10103ui_story == nil then
				arg_195_1.var_.characterEffect10103ui_story = var_198_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_13 = 0.200000002980232

			if var_198_12 <= arg_195_1.time_ and arg_195_1.time_ < var_198_12 + var_198_13 and not isNil(var_198_11) then
				local var_198_14 = (arg_195_1.time_ - var_198_12) / var_198_13

				if arg_195_1.var_.characterEffect10103ui_story and not isNil(var_198_11) then
					arg_195_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_12 + var_198_13 and arg_195_1.time_ < var_198_12 + var_198_13 + arg_198_0 and not isNil(var_198_11) and arg_195_1.var_.characterEffect10103ui_story then
				arg_195_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_198_15 = arg_195_1.actors_["10150ui_story"]
			local var_198_16 = 0

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.characterEffect10150ui_story == nil then
				arg_195_1.var_.characterEffect10150ui_story = var_198_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_17 = 0.200000002980232

			if var_198_16 <= arg_195_1.time_ and arg_195_1.time_ < var_198_16 + var_198_17 and not isNil(var_198_15) then
				local var_198_18 = (arg_195_1.time_ - var_198_16) / var_198_17

				if arg_195_1.var_.characterEffect10150ui_story and not isNil(var_198_15) then
					local var_198_19 = Mathf.Lerp(0, 0.5, var_198_18)

					arg_195_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10150ui_story.fillRatio = var_198_19
				end
			end

			if arg_195_1.time_ >= var_198_16 + var_198_17 and arg_195_1.time_ < var_198_16 + var_198_17 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.characterEffect10150ui_story then
				local var_198_20 = 0.5

				arg_195_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10150ui_story.fillRatio = var_198_20
			end

			local var_198_21 = 0

			if var_198_21 < arg_195_1.time_ and arg_195_1.time_ <= var_198_21 + arg_198_0 then
				arg_195_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action3_1")
			end

			local var_198_22 = 0

			if var_198_22 < arg_195_1.time_ and arg_195_1.time_ <= var_198_22 + arg_198_0 then
				arg_195_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_198_23 = 0

			if var_198_23 < arg_195_1.time_ and arg_195_1.time_ <= var_198_23 + arg_198_0 then
				local var_198_24 = arg_195_1.actors_["10103ui_story"]

				if not isNil(var_198_24) then
					local var_198_25 = GameObjectTools.GetOrAddComponent(var_198_24, typeof(DynamicBoneHelper))

					if var_198_25 then
						var_198_25:EnableDynamicBone(true)
					end
				end
			end

			local var_198_26 = 0
			local var_198_27 = 0.425

			if var_198_26 < arg_195_1.time_ and arg_195_1.time_ <= var_198_26 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_28 = arg_195_1:FormatText(StoryNameCfg[1214].name)

				arg_195_1.leftNameTxt_.text = var_198_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_29 = arg_195_1:GetWordFromCfg(322041047)
				local var_198_30 = arg_195_1:FormatText(var_198_29.content)

				arg_195_1.text_.text = var_198_30

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_31 = 17
				local var_198_32 = utf8.len(var_198_30)
				local var_198_33 = var_198_31 <= 0 and var_198_27 or var_198_27 * (var_198_32 / var_198_31)

				if var_198_33 > 0 and var_198_27 < var_198_33 then
					arg_195_1.talkMaxDuration = var_198_33

					if var_198_33 + var_198_26 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_33 + var_198_26
					end
				end

				arg_195_1.text_.text = var_198_30
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041047", "story_v_out_322041.awb") ~= 0 then
					local var_198_34 = manager.audio:GetVoiceLength("story_v_out_322041", "322041047", "story_v_out_322041.awb") / 1000

					if var_198_34 + var_198_26 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_34 + var_198_26
					end

					if var_198_29.prefab_name ~= "" and arg_195_1.actors_[var_198_29.prefab_name] ~= nil then
						local var_198_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_29.prefab_name].transform, "story_v_out_322041", "322041047", "story_v_out_322041.awb")

						arg_195_1:RecordAudio("322041047", var_198_35)
						arg_195_1:RecordAudio("322041047", var_198_35)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_322041", "322041047", "story_v_out_322041.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_322041", "322041047", "story_v_out_322041.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_36 = math.max(var_198_27, arg_195_1.talkMaxDuration)

			if var_198_26 <= arg_195_1.time_ and arg_195_1.time_ < var_198_26 + var_198_36 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_26) / var_198_36

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_26 + var_198_36 and arg_195_1.time_ < var_198_26 + var_198_36 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play322041048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 322041048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play322041049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10103ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos10103ui_story = var_202_0.localPosition

				local var_202_2 = GameObjectTools.GetOrAddComponent(var_202_0.gameObject, typeof(DynamicBoneHelper))

				if var_202_2 then
					var_202_2:EnableDynamicBone(false)
				end
			end

			local var_202_3 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_3 then
				local var_202_4 = (arg_199_1.time_ - var_202_1) / var_202_3
				local var_202_5 = Vector3.New(0, 100, 0)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10103ui_story, var_202_5, var_202_4)

				local var_202_6 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_6.x, var_202_6.y, var_202_6.z)

				local var_202_7 = var_202_0.localEulerAngles

				var_202_7.z = 0
				var_202_7.x = 0
				var_202_0.localEulerAngles = var_202_7
			end

			if arg_199_1.time_ >= var_202_1 + var_202_3 and arg_199_1.time_ < var_202_1 + var_202_3 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, 100, 0)

				local var_202_8 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_8.x, var_202_8.y, var_202_8.z)

				local var_202_9 = var_202_0.localEulerAngles

				var_202_9.z = 0
				var_202_9.x = 0
				var_202_0.localEulerAngles = var_202_9

				local var_202_10 = GameObjectTools.GetOrAddComponent(var_202_0.gameObject, typeof(DynamicBoneHelper))

				if var_202_10 then
					var_202_10:EnableDynamicBone(true)
				end
			end

			local var_202_11 = arg_199_1.actors_["10150ui_story"].transform
			local var_202_12 = 0

			if var_202_12 < arg_199_1.time_ and arg_199_1.time_ <= var_202_12 + arg_202_0 then
				arg_199_1.var_.moveOldPos10150ui_story = var_202_11.localPosition

				local var_202_13 = GameObjectTools.GetOrAddComponent(var_202_11.gameObject, typeof(DynamicBoneHelper))

				if var_202_13 then
					var_202_13:EnableDynamicBone(false)
				end
			end

			local var_202_14 = 0.001

			if var_202_12 <= arg_199_1.time_ and arg_199_1.time_ < var_202_12 + var_202_14 then
				local var_202_15 = (arg_199_1.time_ - var_202_12) / var_202_14
				local var_202_16 = Vector3.New(0, 100, 0)

				var_202_11.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10150ui_story, var_202_16, var_202_15)

				local var_202_17 = manager.ui.mainCamera.transform.position - var_202_11.position

				var_202_11.forward = Vector3.New(var_202_17.x, var_202_17.y, var_202_17.z)

				local var_202_18 = var_202_11.localEulerAngles

				var_202_18.z = 0
				var_202_18.x = 0
				var_202_11.localEulerAngles = var_202_18
			end

			if arg_199_1.time_ >= var_202_12 + var_202_14 and arg_199_1.time_ < var_202_12 + var_202_14 + arg_202_0 then
				var_202_11.localPosition = Vector3.New(0, 100, 0)

				local var_202_19 = manager.ui.mainCamera.transform.position - var_202_11.position

				var_202_11.forward = Vector3.New(var_202_19.x, var_202_19.y, var_202_19.z)

				local var_202_20 = var_202_11.localEulerAngles

				var_202_20.z = 0
				var_202_20.x = 0
				var_202_11.localEulerAngles = var_202_20

				local var_202_21 = GameObjectTools.GetOrAddComponent(var_202_11.gameObject, typeof(DynamicBoneHelper))

				if var_202_21 then
					var_202_21:EnableDynamicBone(true)
				end
			end

			local var_202_22 = 0
			local var_202_23 = 1.2

			if var_202_22 < arg_199_1.time_ and arg_199_1.time_ <= var_202_22 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_24 = arg_199_1:GetWordFromCfg(322041048)
				local var_202_25 = arg_199_1:FormatText(var_202_24.content)

				arg_199_1.text_.text = var_202_25

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_26 = 48
				local var_202_27 = utf8.len(var_202_25)
				local var_202_28 = var_202_26 <= 0 and var_202_23 or var_202_23 * (var_202_27 / var_202_26)

				if var_202_28 > 0 and var_202_23 < var_202_28 then
					arg_199_1.talkMaxDuration = var_202_28

					if var_202_28 + var_202_22 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_28 + var_202_22
					end
				end

				arg_199_1.text_.text = var_202_25
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_29 = math.max(var_202_23, arg_199_1.talkMaxDuration)

			if var_202_22 <= arg_199_1.time_ and arg_199_1.time_ < var_202_22 + var_202_29 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_22) / var_202_29

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_22 + var_202_29 and arg_199_1.time_ < var_202_22 + var_202_29 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322041049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 322041049
		arg_203_1.duration_ = 2

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play322041050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1284ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1284ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, -0.985, -6.22)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1284ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["1284ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1284ui_story == nil then
				arg_203_1.var_.characterEffect1284ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect1284ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1284ui_story then
				arg_203_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_1")
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_206_15 = 0
			local var_206_16 = 0.15

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[6].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_18 = arg_203_1:GetWordFromCfg(322041049)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041049", "story_v_out_322041.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_out_322041", "322041049", "story_v_out_322041.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_322041", "322041049", "story_v_out_322041.awb")

						arg_203_1:RecordAudio("322041049", var_206_24)
						arg_203_1:RecordAudio("322041049", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_322041", "322041049", "story_v_out_322041.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_322041", "322041049", "story_v_out_322041.awb")
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
				actorName = "1284ui_story",
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
	Play322041050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 322041050
		arg_207_1.duration_ = 4.03

		local var_207_0 = {
			zh = 3.666,
			ja = 4.033
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play322041051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1156ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1156ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0.9, -1.1, -6.18)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1156ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0.9, -1.1, -6.18)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1284ui_story"].transform
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1.var_.moveOldPos1284ui_story = var_210_9.localPosition
			end

			local var_210_11 = 0.001

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11
				local var_210_13 = Vector3.New(-0.7, -0.985, -6.22)

				var_210_9.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1284ui_story, var_210_13, var_210_12)

				local var_210_14 = manager.ui.mainCamera.transform.position - var_210_9.position

				var_210_9.forward = Vector3.New(var_210_14.x, var_210_14.y, var_210_14.z)

				local var_210_15 = var_210_9.localEulerAngles

				var_210_15.z = 0
				var_210_15.x = 0
				var_210_9.localEulerAngles = var_210_15
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 then
				var_210_9.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_210_16 = manager.ui.mainCamera.transform.position - var_210_9.position

				var_210_9.forward = Vector3.New(var_210_16.x, var_210_16.y, var_210_16.z)

				local var_210_17 = var_210_9.localEulerAngles

				var_210_17.z = 0
				var_210_17.x = 0
				var_210_9.localEulerAngles = var_210_17
			end

			local var_210_18 = arg_207_1.actors_["1156ui_story"]
			local var_210_19 = 0

			if var_210_19 < arg_207_1.time_ and arg_207_1.time_ <= var_210_19 + arg_210_0 and not isNil(var_210_18) and arg_207_1.var_.characterEffect1156ui_story == nil then
				arg_207_1.var_.characterEffect1156ui_story = var_210_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_20 = 0.200000002980232

			if var_210_19 <= arg_207_1.time_ and arg_207_1.time_ < var_210_19 + var_210_20 and not isNil(var_210_18) then
				local var_210_21 = (arg_207_1.time_ - var_210_19) / var_210_20

				if arg_207_1.var_.characterEffect1156ui_story and not isNil(var_210_18) then
					arg_207_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_19 + var_210_20 and arg_207_1.time_ < var_210_19 + var_210_20 + arg_210_0 and not isNil(var_210_18) and arg_207_1.var_.characterEffect1156ui_story then
				arg_207_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_210_22 = arg_207_1.actors_["1284ui_story"]
			local var_210_23 = 0

			if var_210_23 < arg_207_1.time_ and arg_207_1.time_ <= var_210_23 + arg_210_0 and not isNil(var_210_22) and arg_207_1.var_.characterEffect1284ui_story == nil then
				arg_207_1.var_.characterEffect1284ui_story = var_210_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_24 = 0.200000002980232

			if var_210_23 <= arg_207_1.time_ and arg_207_1.time_ < var_210_23 + var_210_24 and not isNil(var_210_22) then
				local var_210_25 = (arg_207_1.time_ - var_210_23) / var_210_24

				if arg_207_1.var_.characterEffect1284ui_story and not isNil(var_210_22) then
					local var_210_26 = Mathf.Lerp(0, 0.5, var_210_25)

					arg_207_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1284ui_story.fillRatio = var_210_26
				end
			end

			if arg_207_1.time_ >= var_210_23 + var_210_24 and arg_207_1.time_ < var_210_23 + var_210_24 + arg_210_0 and not isNil(var_210_22) and arg_207_1.var_.characterEffect1284ui_story then
				local var_210_27 = 0.5

				arg_207_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1284ui_story.fillRatio = var_210_27
			end

			local var_210_28 = 0

			if var_210_28 < arg_207_1.time_ and arg_207_1.time_ <= var_210_28 + arg_210_0 then
				arg_207_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_210_29 = 0

			if var_210_29 < arg_207_1.time_ and arg_207_1.time_ <= var_210_29 + arg_210_0 then
				arg_207_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_210_30 = 0
			local var_210_31 = 0.325

			if var_210_30 < arg_207_1.time_ and arg_207_1.time_ <= var_210_30 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_32 = arg_207_1:FormatText(StoryNameCfg[605].name)

				arg_207_1.leftNameTxt_.text = var_210_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_33 = arg_207_1:GetWordFromCfg(322041050)
				local var_210_34 = arg_207_1:FormatText(var_210_33.content)

				arg_207_1.text_.text = var_210_34

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_35 = 13
				local var_210_36 = utf8.len(var_210_34)
				local var_210_37 = var_210_35 <= 0 and var_210_31 or var_210_31 * (var_210_36 / var_210_35)

				if var_210_37 > 0 and var_210_31 < var_210_37 then
					arg_207_1.talkMaxDuration = var_210_37

					if var_210_37 + var_210_30 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_37 + var_210_30
					end
				end

				arg_207_1.text_.text = var_210_34
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041050", "story_v_out_322041.awb") ~= 0 then
					local var_210_38 = manager.audio:GetVoiceLength("story_v_out_322041", "322041050", "story_v_out_322041.awb") / 1000

					if var_210_38 + var_210_30 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_38 + var_210_30
					end

					if var_210_33.prefab_name ~= "" and arg_207_1.actors_[var_210_33.prefab_name] ~= nil then
						local var_210_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_33.prefab_name].transform, "story_v_out_322041", "322041050", "story_v_out_322041.awb")

						arg_207_1:RecordAudio("322041050", var_210_39)
						arg_207_1:RecordAudio("322041050", var_210_39)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_322041", "322041050", "story_v_out_322041.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_322041", "322041050", "story_v_out_322041.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_40 = math.max(var_210_31, arg_207_1.talkMaxDuration)

			if var_210_30 <= arg_207_1.time_ and arg_207_1.time_ < var_210_30 + var_210_40 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_30) / var_210_40

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_30 + var_210_40 and arg_207_1.time_ < var_210_30 + var_210_40 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play322041051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 322041051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play322041052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1156ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1156ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1156ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["1284ui_story"].transform
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 then
				arg_211_1.var_.moveOldPos1284ui_story = var_214_9.localPosition
			end

			local var_214_11 = 0.001

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11
				local var_214_13 = Vector3.New(0, 100, 0)

				var_214_9.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1284ui_story, var_214_13, var_214_12)

				local var_214_14 = manager.ui.mainCamera.transform.position - var_214_9.position

				var_214_9.forward = Vector3.New(var_214_14.x, var_214_14.y, var_214_14.z)

				local var_214_15 = var_214_9.localEulerAngles

				var_214_15.z = 0
				var_214_15.x = 0
				var_214_9.localEulerAngles = var_214_15
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 then
				var_214_9.localPosition = Vector3.New(0, 100, 0)

				local var_214_16 = manager.ui.mainCamera.transform.position - var_214_9.position

				var_214_9.forward = Vector3.New(var_214_16.x, var_214_16.y, var_214_16.z)

				local var_214_17 = var_214_9.localEulerAngles

				var_214_17.z = 0
				var_214_17.x = 0
				var_214_9.localEulerAngles = var_214_17
			end

			local var_214_18 = arg_211_1.actors_["1156ui_story"]
			local var_214_19 = 0

			if var_214_19 < arg_211_1.time_ and arg_211_1.time_ <= var_214_19 + arg_214_0 and not isNil(var_214_18) and arg_211_1.var_.characterEffect1156ui_story == nil then
				arg_211_1.var_.characterEffect1156ui_story = var_214_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_20 = 0.200000002980232

			if var_214_19 <= arg_211_1.time_ and arg_211_1.time_ < var_214_19 + var_214_20 and not isNil(var_214_18) then
				local var_214_21 = (arg_211_1.time_ - var_214_19) / var_214_20

				if arg_211_1.var_.characterEffect1156ui_story and not isNil(var_214_18) then
					local var_214_22 = Mathf.Lerp(0, 0.5, var_214_21)

					arg_211_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1156ui_story.fillRatio = var_214_22
				end
			end

			if arg_211_1.time_ >= var_214_19 + var_214_20 and arg_211_1.time_ < var_214_19 + var_214_20 + arg_214_0 and not isNil(var_214_18) and arg_211_1.var_.characterEffect1156ui_story then
				local var_214_23 = 0.5

				arg_211_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1156ui_story.fillRatio = var_214_23
			end

			local var_214_24 = 0.3
			local var_214_25 = 1

			if var_214_24 < arg_211_1.time_ and arg_211_1.time_ <= var_214_24 + arg_214_0 then
				local var_214_26 = "play"
				local var_214_27 = "effect"

				arg_211_1:AudioAction(var_214_26, var_214_27, "se_story_birthday3", "se_story_birthday3_flame", "")
			end

			local var_214_28 = 0
			local var_214_29 = 1.5

			if var_214_28 < arg_211_1.time_ and arg_211_1.time_ <= var_214_28 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_30 = arg_211_1:GetWordFromCfg(322041051)
				local var_214_31 = arg_211_1:FormatText(var_214_30.content)

				arg_211_1.text_.text = var_214_31

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_32 = 60
				local var_214_33 = utf8.len(var_214_31)
				local var_214_34 = var_214_32 <= 0 and var_214_29 or var_214_29 * (var_214_33 / var_214_32)

				if var_214_34 > 0 and var_214_29 < var_214_34 then
					arg_211_1.talkMaxDuration = var_214_34

					if var_214_34 + var_214_28 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_34 + var_214_28
					end
				end

				arg_211_1.text_.text = var_214_31
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_35 = math.max(var_214_29, arg_211_1.talkMaxDuration)

			if var_214_28 <= arg_211_1.time_ and arg_211_1.time_ < var_214_28 + var_214_35 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_28) / var_214_35

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_28 + var_214_35 and arg_211_1.time_ < var_214_28 + var_214_35 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play322041052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 322041052
		arg_215_1.duration_ = 2.03

		local var_215_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_215_0:Play322041053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1156ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1156ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, -1.1, -6.18)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1156ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["1156ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1156ui_story == nil then
				arg_215_1.var_.characterEffect1156ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect1156ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1156ui_story then
				arg_215_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_218_15 = 0
			local var_218_16 = 0.125

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[605].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(322041052)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 5
				local var_218_21 = utf8.len(var_218_19)
				local var_218_22 = var_218_20 <= 0 and var_218_16 or var_218_16 * (var_218_21 / var_218_20)

				if var_218_22 > 0 and var_218_16 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22

					if var_218_22 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041052", "story_v_out_322041.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_322041", "322041052", "story_v_out_322041.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_322041", "322041052", "story_v_out_322041.awb")

						arg_215_1:RecordAudio("322041052", var_218_24)
						arg_215_1:RecordAudio("322041052", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_322041", "322041052", "story_v_out_322041.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_322041", "322041052", "story_v_out_322041.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_25 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_25 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_25

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_25 and arg_215_1.time_ < var_218_15 + var_218_25 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play322041053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 322041053
		arg_219_1.duration_ = 4.57

		local var_219_0 = {
			zh = 3.233,
			ja = 4.566
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
				arg_219_0:Play322041054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action2_1")
			end

			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_222_2 = 0
			local var_222_3 = 0.55

			if var_222_2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_4 = arg_219_1:FormatText(StoryNameCfg[605].name)

				arg_219_1.leftNameTxt_.text = var_222_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_5 = arg_219_1:GetWordFromCfg(322041053)
				local var_222_6 = arg_219_1:FormatText(var_222_5.content)

				arg_219_1.text_.text = var_222_6

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 22
				local var_222_8 = utf8.len(var_222_6)
				local var_222_9 = var_222_7 <= 0 and var_222_3 or var_222_3 * (var_222_8 / var_222_7)

				if var_222_9 > 0 and var_222_3 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_6
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041053", "story_v_out_322041.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041053", "story_v_out_322041.awb") / 1000

					if var_222_10 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_2
					end

					if var_222_5.prefab_name ~= "" and arg_219_1.actors_[var_222_5.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_5.prefab_name].transform, "story_v_out_322041", "322041053", "story_v_out_322041.awb")

						arg_219_1:RecordAudio("322041053", var_222_11)
						arg_219_1:RecordAudio("322041053", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_322041", "322041053", "story_v_out_322041.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_322041", "322041053", "story_v_out_322041.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_12 and arg_219_1.time_ < var_222_2 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play322041054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 322041054
		arg_223_1.duration_ = 3.73

		local var_223_0 = {
			zh = 3.733,
			ja = 3.4
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
				arg_223_0:Play322041055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10150ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos10150ui_story = var_226_0.localPosition

				local var_226_2 = GameObjectTools.GetOrAddComponent(var_226_0.gameObject, typeof(DynamicBoneHelper))

				if var_226_2 then
					var_226_2:EnableDynamicBone(false)
				end
			end

			local var_226_3 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_3 then
				local var_226_4 = (arg_223_1.time_ - var_226_1) / var_226_3
				local var_226_5 = Vector3.New(0, -1.73, -5.5)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10150ui_story, var_226_5, var_226_4)

				local var_226_6 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_6.x, var_226_6.y, var_226_6.z)

				local var_226_7 = var_226_0.localEulerAngles

				var_226_7.z = 0
				var_226_7.x = 0
				var_226_0.localEulerAngles = var_226_7
			end

			if arg_223_1.time_ >= var_226_1 + var_226_3 and arg_223_1.time_ < var_226_1 + var_226_3 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -1.73, -5.5)

				local var_226_8 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_8.x, var_226_8.y, var_226_8.z)

				local var_226_9 = var_226_0.localEulerAngles

				var_226_9.z = 0
				var_226_9.x = 0
				var_226_0.localEulerAngles = var_226_9

				local var_226_10 = GameObjectTools.GetOrAddComponent(var_226_0.gameObject, typeof(DynamicBoneHelper))

				if var_226_10 then
					var_226_10:EnableDynamicBone(true)
				end
			end

			local var_226_11 = arg_223_1.actors_["1156ui_story"].transform
			local var_226_12 = 0

			if var_226_12 < arg_223_1.time_ and arg_223_1.time_ <= var_226_12 + arg_226_0 then
				arg_223_1.var_.moveOldPos1156ui_story = var_226_11.localPosition
			end

			local var_226_13 = 0.001

			if var_226_12 <= arg_223_1.time_ and arg_223_1.time_ < var_226_12 + var_226_13 then
				local var_226_14 = (arg_223_1.time_ - var_226_12) / var_226_13
				local var_226_15 = Vector3.New(0, 100, 0)

				var_226_11.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1156ui_story, var_226_15, var_226_14)

				local var_226_16 = manager.ui.mainCamera.transform.position - var_226_11.position

				var_226_11.forward = Vector3.New(var_226_16.x, var_226_16.y, var_226_16.z)

				local var_226_17 = var_226_11.localEulerAngles

				var_226_17.z = 0
				var_226_17.x = 0
				var_226_11.localEulerAngles = var_226_17
			end

			if arg_223_1.time_ >= var_226_12 + var_226_13 and arg_223_1.time_ < var_226_12 + var_226_13 + arg_226_0 then
				var_226_11.localPosition = Vector3.New(0, 100, 0)

				local var_226_18 = manager.ui.mainCamera.transform.position - var_226_11.position

				var_226_11.forward = Vector3.New(var_226_18.x, var_226_18.y, var_226_18.z)

				local var_226_19 = var_226_11.localEulerAngles

				var_226_19.z = 0
				var_226_19.x = 0
				var_226_11.localEulerAngles = var_226_19
			end

			local var_226_20 = arg_223_1.actors_["10150ui_story"]
			local var_226_21 = 0

			if var_226_21 < arg_223_1.time_ and arg_223_1.time_ <= var_226_21 + arg_226_0 and not isNil(var_226_20) and arg_223_1.var_.characterEffect10150ui_story == nil then
				arg_223_1.var_.characterEffect10150ui_story = var_226_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_22 = 0.200000002980232

			if var_226_21 <= arg_223_1.time_ and arg_223_1.time_ < var_226_21 + var_226_22 and not isNil(var_226_20) then
				local var_226_23 = (arg_223_1.time_ - var_226_21) / var_226_22

				if arg_223_1.var_.characterEffect10150ui_story and not isNil(var_226_20) then
					arg_223_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_21 + var_226_22 and arg_223_1.time_ < var_226_21 + var_226_22 + arg_226_0 and not isNil(var_226_20) and arg_223_1.var_.characterEffect10150ui_story then
				arg_223_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_226_24 = arg_223_1.actors_["1156ui_story"]
			local var_226_25 = 0

			if var_226_25 < arg_223_1.time_ and arg_223_1.time_ <= var_226_25 + arg_226_0 and not isNil(var_226_24) and arg_223_1.var_.characterEffect1156ui_story == nil then
				arg_223_1.var_.characterEffect1156ui_story = var_226_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_26 = 0.200000002980232

			if var_226_25 <= arg_223_1.time_ and arg_223_1.time_ < var_226_25 + var_226_26 and not isNil(var_226_24) then
				local var_226_27 = (arg_223_1.time_ - var_226_25) / var_226_26

				if arg_223_1.var_.characterEffect1156ui_story and not isNil(var_226_24) then
					local var_226_28 = Mathf.Lerp(0, 0.5, var_226_27)

					arg_223_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1156ui_story.fillRatio = var_226_28
				end
			end

			if arg_223_1.time_ >= var_226_25 + var_226_26 and arg_223_1.time_ < var_226_25 + var_226_26 + arg_226_0 and not isNil(var_226_24) and arg_223_1.var_.characterEffect1156ui_story then
				local var_226_29 = 0.5

				arg_223_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1156ui_story.fillRatio = var_226_29
			end

			local var_226_30 = 0

			if var_226_30 < arg_223_1.time_ and arg_223_1.time_ <= var_226_30 + arg_226_0 then
				arg_223_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			local var_226_31 = 0

			if var_226_31 < arg_223_1.time_ and arg_223_1.time_ <= var_226_31 + arg_226_0 then
				arg_223_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_226_32 = 0
			local var_226_33 = 0.2

			if var_226_32 < arg_223_1.time_ and arg_223_1.time_ <= var_226_32 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_34 = arg_223_1:FormatText(StoryNameCfg[1361].name)

				arg_223_1.leftNameTxt_.text = var_226_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_35 = arg_223_1:GetWordFromCfg(322041054)
				local var_226_36 = arg_223_1:FormatText(var_226_35.content)

				arg_223_1.text_.text = var_226_36

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_37 = 8
				local var_226_38 = utf8.len(var_226_36)
				local var_226_39 = var_226_37 <= 0 and var_226_33 or var_226_33 * (var_226_38 / var_226_37)

				if var_226_39 > 0 and var_226_33 < var_226_39 then
					arg_223_1.talkMaxDuration = var_226_39

					if var_226_39 + var_226_32 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_39 + var_226_32
					end
				end

				arg_223_1.text_.text = var_226_36
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041054", "story_v_out_322041.awb") ~= 0 then
					local var_226_40 = manager.audio:GetVoiceLength("story_v_out_322041", "322041054", "story_v_out_322041.awb") / 1000

					if var_226_40 + var_226_32 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_40 + var_226_32
					end

					if var_226_35.prefab_name ~= "" and arg_223_1.actors_[var_226_35.prefab_name] ~= nil then
						local var_226_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_35.prefab_name].transform, "story_v_out_322041", "322041054", "story_v_out_322041.awb")

						arg_223_1:RecordAudio("322041054", var_226_41)
						arg_223_1:RecordAudio("322041054", var_226_41)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_322041", "322041054", "story_v_out_322041.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_322041", "322041054", "story_v_out_322041.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_42 = math.max(var_226_33, arg_223_1.talkMaxDuration)

			if var_226_32 <= arg_223_1.time_ and arg_223_1.time_ < var_226_32 + var_226_42 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_32) / var_226_42

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_32 + var_226_42 and arg_223_1.time_ < var_226_32 + var_226_42 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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

		arg_223_1:InitPlayNodeList()
	end,
	Play322041055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 322041055
		arg_227_1.duration_ = 8.47

		local var_227_0 = {
			zh = 4.733,
			ja = 8.466
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play322041056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_230_2 = 0
			local var_230_3 = 0.375

			if var_230_2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_4 = arg_227_1:FormatText(StoryNameCfg[1361].name)

				arg_227_1.leftNameTxt_.text = var_230_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_5 = arg_227_1:GetWordFromCfg(322041055)
				local var_230_6 = arg_227_1:FormatText(var_230_5.content)

				arg_227_1.text_.text = var_230_6

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 15
				local var_230_8 = utf8.len(var_230_6)
				local var_230_9 = var_230_7 <= 0 and var_230_3 or var_230_3 * (var_230_8 / var_230_7)

				if var_230_9 > 0 and var_230_3 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_6
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041055", "story_v_out_322041.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041055", "story_v_out_322041.awb") / 1000

					if var_230_10 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_2
					end

					if var_230_5.prefab_name ~= "" and arg_227_1.actors_[var_230_5.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_5.prefab_name].transform, "story_v_out_322041", "322041055", "story_v_out_322041.awb")

						arg_227_1:RecordAudio("322041055", var_230_11)
						arg_227_1:RecordAudio("322041055", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_322041", "322041055", "story_v_out_322041.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_322041", "322041055", "story_v_out_322041.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_12 and arg_227_1.time_ < var_230_2 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play322041056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 322041056
		arg_231_1.duration_ = 5.13

		local var_231_0 = {
			zh = 5.133,
			ja = 3.166
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
				arg_231_0:Play322041057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1156ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1156ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0, -1.1, -6.18)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1156ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["10150ui_story"].transform
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.var_.moveOldPos10150ui_story = var_234_9.localPosition

				local var_234_11 = GameObjectTools.GetOrAddComponent(var_234_9.gameObject, typeof(DynamicBoneHelper))

				if var_234_11 then
					var_234_11:EnableDynamicBone(false)
				end
			end

			local var_234_12 = 0.001

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_12 then
				local var_234_13 = (arg_231_1.time_ - var_234_10) / var_234_12
				local var_234_14 = Vector3.New(0, 100, 0)

				var_234_9.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10150ui_story, var_234_14, var_234_13)

				local var_234_15 = manager.ui.mainCamera.transform.position - var_234_9.position

				var_234_9.forward = Vector3.New(var_234_15.x, var_234_15.y, var_234_15.z)

				local var_234_16 = var_234_9.localEulerAngles

				var_234_16.z = 0
				var_234_16.x = 0
				var_234_9.localEulerAngles = var_234_16
			end

			if arg_231_1.time_ >= var_234_10 + var_234_12 and arg_231_1.time_ < var_234_10 + var_234_12 + arg_234_0 then
				var_234_9.localPosition = Vector3.New(0, 100, 0)

				local var_234_17 = manager.ui.mainCamera.transform.position - var_234_9.position

				var_234_9.forward = Vector3.New(var_234_17.x, var_234_17.y, var_234_17.z)

				local var_234_18 = var_234_9.localEulerAngles

				var_234_18.z = 0
				var_234_18.x = 0
				var_234_9.localEulerAngles = var_234_18

				local var_234_19 = GameObjectTools.GetOrAddComponent(var_234_9.gameObject, typeof(DynamicBoneHelper))

				if var_234_19 then
					var_234_19:EnableDynamicBone(true)
				end
			end

			local var_234_20 = arg_231_1.actors_["1156ui_story"]
			local var_234_21 = 0

			if var_234_21 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 and not isNil(var_234_20) and arg_231_1.var_.characterEffect1156ui_story == nil then
				arg_231_1.var_.characterEffect1156ui_story = var_234_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_22 = 0.200000002980232

			if var_234_21 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_22 and not isNil(var_234_20) then
				local var_234_23 = (arg_231_1.time_ - var_234_21) / var_234_22

				if arg_231_1.var_.characterEffect1156ui_story and not isNil(var_234_20) then
					arg_231_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_21 + var_234_22 and arg_231_1.time_ < var_234_21 + var_234_22 + arg_234_0 and not isNil(var_234_20) and arg_231_1.var_.characterEffect1156ui_story then
				arg_231_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_234_24 = arg_231_1.actors_["10150ui_story"]
			local var_234_25 = 0

			if var_234_25 < arg_231_1.time_ and arg_231_1.time_ <= var_234_25 + arg_234_0 and not isNil(var_234_24) and arg_231_1.var_.characterEffect10150ui_story == nil then
				arg_231_1.var_.characterEffect10150ui_story = var_234_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_26 = 0.200000002980232

			if var_234_25 <= arg_231_1.time_ and arg_231_1.time_ < var_234_25 + var_234_26 and not isNil(var_234_24) then
				local var_234_27 = (arg_231_1.time_ - var_234_25) / var_234_26

				if arg_231_1.var_.characterEffect10150ui_story and not isNil(var_234_24) then
					local var_234_28 = Mathf.Lerp(0, 0.5, var_234_27)

					arg_231_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10150ui_story.fillRatio = var_234_28
				end
			end

			if arg_231_1.time_ >= var_234_25 + var_234_26 and arg_231_1.time_ < var_234_25 + var_234_26 + arg_234_0 and not isNil(var_234_24) and arg_231_1.var_.characterEffect10150ui_story then
				local var_234_29 = 0.5

				arg_231_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10150ui_story.fillRatio = var_234_29
			end

			local var_234_30 = 0

			if var_234_30 < arg_231_1.time_ and arg_231_1.time_ <= var_234_30 + arg_234_0 then
				arg_231_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156actionlink/1156action423")
			end

			local var_234_31 = 0

			if var_234_31 < arg_231_1.time_ and arg_231_1.time_ <= var_234_31 + arg_234_0 then
				arg_231_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_234_32 = 0
			local var_234_33 = 0.225

			if var_234_32 < arg_231_1.time_ and arg_231_1.time_ <= var_234_32 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_34 = arg_231_1:FormatText(StoryNameCfg[605].name)

				arg_231_1.leftNameTxt_.text = var_234_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_35 = arg_231_1:GetWordFromCfg(322041056)
				local var_234_36 = arg_231_1:FormatText(var_234_35.content)

				arg_231_1.text_.text = var_234_36

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_37 = 9
				local var_234_38 = utf8.len(var_234_36)
				local var_234_39 = var_234_37 <= 0 and var_234_33 or var_234_33 * (var_234_38 / var_234_37)

				if var_234_39 > 0 and var_234_33 < var_234_39 then
					arg_231_1.talkMaxDuration = var_234_39

					if var_234_39 + var_234_32 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_39 + var_234_32
					end
				end

				arg_231_1.text_.text = var_234_36
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041056", "story_v_out_322041.awb") ~= 0 then
					local var_234_40 = manager.audio:GetVoiceLength("story_v_out_322041", "322041056", "story_v_out_322041.awb") / 1000

					if var_234_40 + var_234_32 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_40 + var_234_32
					end

					if var_234_35.prefab_name ~= "" and arg_231_1.actors_[var_234_35.prefab_name] ~= nil then
						local var_234_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_35.prefab_name].transform, "story_v_out_322041", "322041056", "story_v_out_322041.awb")

						arg_231_1:RecordAudio("322041056", var_234_41)
						arg_231_1:RecordAudio("322041056", var_234_41)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_322041", "322041056", "story_v_out_322041.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_322041", "322041056", "story_v_out_322041.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_42 = math.max(var_234_33, arg_231_1.talkMaxDuration)

			if var_234_32 <= arg_231_1.time_ and arg_231_1.time_ < var_234_32 + var_234_42 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_32) / var_234_42

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_32 + var_234_42 and arg_231_1.time_ < var_234_32 + var_234_42 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play322041057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 322041057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play322041058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1156ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos1156ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(0, 100, 0)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1156ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0, 100, 0)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = 0.25
			local var_238_10 = 1

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 then
				local var_238_11 = "play"
				local var_238_12 = "effect"

				arg_235_1:AudioAction(var_238_11, var_238_12, "se_story_145", "se_story_145_thunder", "")
			end

			local var_238_13 = manager.ui.mainCamera.transform
			local var_238_14 = 0.25

			if var_238_14 < arg_235_1.time_ and arg_235_1.time_ <= var_238_14 + arg_238_0 then
				local var_238_15 = arg_235_1.var_.effect1057
				local var_238_16
				local var_238_17 = var_238_13

				if not var_238_15 then
					var_238_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_238_17)
					var_238_15.name = "1057"
					arg_235_1.var_.effect1057 = var_238_15
				else
					var_238_15.transform:SetParent(var_238_17)
				end

				var_238_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_238_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_238_18 = manager.ui.mainCamera.transform
			local var_238_19 = 1.26666666666667

			if var_238_19 < arg_235_1.time_ and arg_235_1.time_ <= var_238_19 + arg_238_0 then
				local var_238_20 = arg_235_1.var_.effect1057

				if var_238_20 then
					Object.Destroy(var_238_20)

					arg_235_1.var_.effect1057 = nil
				end
			end

			local var_238_21 = manager.ui.mainCamera.transform
			local var_238_22 = 1.26666666666667

			if var_238_22 < arg_235_1.time_ and arg_235_1.time_ <= var_238_22 + arg_238_0 then
				arg_235_1.var_.shakeOldPos = var_238_21.localPosition
			end

			local var_238_23 = 0.566666666666667

			if var_238_22 <= arg_235_1.time_ and arg_235_1.time_ < var_238_22 + var_238_23 then
				local var_238_24 = (arg_235_1.time_ - var_238_22) / 0.066
				local var_238_25, var_238_26 = math.modf(var_238_24)

				var_238_21.localPosition = Vector3.New(var_238_26 * 0.13, var_238_26 * 0.13, var_238_26 * 0.13) + arg_235_1.var_.shakeOldPos
			end

			if arg_235_1.time_ >= var_238_22 + var_238_23 and arg_235_1.time_ < var_238_22 + var_238_23 + arg_238_0 then
				var_238_21.localPosition = arg_235_1.var_.shakeOldPos
			end

			local var_238_27 = 0
			local var_238_28 = 1.25

			if var_238_27 < arg_235_1.time_ and arg_235_1.time_ <= var_238_27 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_29 = arg_235_1:GetWordFromCfg(322041057)
				local var_238_30 = arg_235_1:FormatText(var_238_29.content)

				arg_235_1.text_.text = var_238_30

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_31 = 50
				local var_238_32 = utf8.len(var_238_30)
				local var_238_33 = var_238_31 <= 0 and var_238_28 or var_238_28 * (var_238_32 / var_238_31)

				if var_238_33 > 0 and var_238_28 < var_238_33 then
					arg_235_1.talkMaxDuration = var_238_33

					if var_238_33 + var_238_27 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_33 + var_238_27
					end
				end

				arg_235_1.text_.text = var_238_30
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_34 = math.max(var_238_28, arg_235_1.talkMaxDuration)

			if var_238_27 <= arg_235_1.time_ and arg_235_1.time_ < var_238_27 + var_238_34 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_27) / var_238_34

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_27 + var_238_34 and arg_235_1.time_ < var_238_27 + var_238_34 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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

		arg_235_1:InitPlayNodeList()
	end,
	Play322041058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 322041058
		arg_239_1.duration_ = 6.1

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
			arg_239_1.auto_ = false
		end

		function arg_239_1.playNext_(arg_241_0)
			arg_239_1.onStoryFinished_()
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.1
			local var_242_1 = 1

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				local var_242_2 = "play"
				local var_242_3 = "effect"

				arg_239_1:AudioAction(var_242_2, var_242_3, "se_story_145", "se_story_145_explosion02", "")
			end

			local var_242_4 = manager.ui.mainCamera.transform
			local var_242_5 = 0

			if var_242_5 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 then
				local var_242_6 = arg_239_1.var_.effect1058
				local var_242_7
				local var_242_8 = var_242_4

				if not var_242_6 then
					var_242_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_242_8)
					var_242_6.name = "1058"
					arg_239_1.var_.effect1058 = var_242_6
				else
					var_242_6.transform:SetParent(var_242_8)
				end

				var_242_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_242_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_9 = 1.1
			local var_242_10 = 1.4

			if var_242_9 < arg_239_1.time_ and arg_239_1.time_ <= var_242_9 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_11 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_11:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_12 = arg_239_1:GetWordFromCfg(322041058)
				local var_242_13 = arg_239_1:FormatText(var_242_12.content)

				arg_239_1.text_.text = var_242_13

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_14 = 56
				local var_242_15 = utf8.len(var_242_13)
				local var_242_16 = var_242_14 <= 0 and var_242_10 or var_242_10 * (var_242_15 / var_242_14)

				if var_242_16 > 0 and var_242_10 < var_242_16 then
					arg_239_1.talkMaxDuration = var_242_16
					var_242_9 = var_242_9 + 0.3

					if var_242_16 + var_242_9 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_16 + var_242_9
					end
				end

				arg_239_1.text_.text = var_242_13
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_17 = var_242_9 + 0.3
			local var_242_18 = math.max(var_242_10, arg_239_1.talkMaxDuration)

			if var_242_17 <= arg_239_1.time_ and arg_239_1.time_ < var_242_17 + var_242_18 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_17) / var_242_18

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_17 + var_242_18 and arg_239_1.time_ < var_242_17 + var_242_18 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01h",
		"TextureConfig/Background/L10g",
		"TextureConfig/Background/L15f"
	},
	voices = {
		"story_v_out_322041.awb"
	}
}
