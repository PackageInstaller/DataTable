return {
	Play319741001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319741001
		arg_1_1.duration_ = 7.9

		local var_1_0 = {
			zh = 5.932999999999,
			ja = 7.899999999999
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
				arg_1_0:Play319741002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11m"

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
				local var_4_5 = arg_1_1.bgs_.I11m

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
					if iter_4_0 ~= "I11m" then
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

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure")

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

			local var_4_36 = 1.999999999999
			local var_4_37 = 0.675

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

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[648].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(319741001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741001", "story_v_out_319741.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_319741", "319741001", "story_v_out_319741.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_319741", "319741001", "story_v_out_319741.awb")

						arg_1_1:RecordAudio("319741001", var_4_46)
						arg_1_1:RecordAudio("319741001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319741", "319741001", "story_v_out_319741.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319741", "319741001", "story_v_out_319741.awb")
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
	Play319741002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319741002
		arg_9_1.duration_ = 3.27

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 3.266
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
				arg_9_0:Play319741003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10079ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["10079ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos10079ui_story = var_12_5.localPosition

				local var_12_7 = "10079ui_story"

				arg_9_1:ShowWeapon(arg_9_1.var_[var_12_7 .. "Animator"].transform, false)
			end

			local var_12_8 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_6) / var_12_8
				local var_12_10 = Vector3.New(0, -0.95, -6.05)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10079ui_story, var_12_10, var_12_9)

				local var_12_11 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_11.x, var_12_11.y, var_12_11.z)

				local var_12_12 = var_12_5.localEulerAngles

				var_12_12.z = 0
				var_12_12.x = 0
				var_12_5.localEulerAngles = var_12_12
			end

			if arg_9_1.time_ >= var_12_6 + var_12_8 and arg_9_1.time_ < var_12_6 + var_12_8 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_12_13 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_13.x, var_12_13.y, var_12_13.z)

				local var_12_14 = var_12_5.localEulerAngles

				var_12_14.z = 0
				var_12_14.x = 0
				var_12_5.localEulerAngles = var_12_14
			end

			local var_12_15 = arg_9_1.actors_["10079ui_story"]
			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect10079ui_story == nil then
				arg_9_1.var_.characterEffect10079ui_story = var_12_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_17 = 0.200000002980232

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 and not isNil(var_12_15) then
				local var_12_18 = (arg_9_1.time_ - var_12_16) / var_12_17

				if arg_9_1.var_.characterEffect10079ui_story and not isNil(var_12_15) then
					arg_9_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect10079ui_story then
				arg_9_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_21 = 0
			local var_12_22 = 0.15

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_23 = arg_9_1:FormatText(StoryNameCfg[6].name)

				arg_9_1.leftNameTxt_.text = var_12_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_24 = arg_9_1:GetWordFromCfg(319741002)
				local var_12_25 = arg_9_1:FormatText(var_12_24.content)

				arg_9_1.text_.text = var_12_25

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_26 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741002", "story_v_out_319741.awb") ~= 0 then
					local var_12_29 = manager.audio:GetVoiceLength("story_v_out_319741", "319741002", "story_v_out_319741.awb") / 1000

					if var_12_29 + var_12_21 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_29 + var_12_21
					end

					if var_12_24.prefab_name ~= "" and arg_9_1.actors_[var_12_24.prefab_name] ~= nil then
						local var_12_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_24.prefab_name].transform, "story_v_out_319741", "319741002", "story_v_out_319741.awb")

						arg_9_1:RecordAudio("319741002", var_12_30)
						arg_9_1:RecordAudio("319741002", var_12_30)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319741", "319741002", "story_v_out_319741.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319741", "319741002", "story_v_out_319741.awb")
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
				actorName = "10079ui_story",
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
	Play319741003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319741003
		arg_13_1.duration_ = 3.67

		local var_13_0 = {
			zh = 3.666,
			ja = 2.566
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
				arg_13_0:Play319741004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10079ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect10079ui_story == nil then
				arg_13_1.var_.characterEffect10079ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect10079ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10079ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect10079ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10079ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.475

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_8 = arg_13_1:FormatText(StoryNameCfg[648].name)

				arg_13_1.leftNameTxt_.text = var_16_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_9 = arg_13_1:GetWordFromCfg(319741003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741003", "story_v_out_319741.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_319741", "319741003", "story_v_out_319741.awb") / 1000

					if var_16_14 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_6
					end

					if var_16_9.prefab_name ~= "" and arg_13_1.actors_[var_16_9.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_9.prefab_name].transform, "story_v_out_319741", "319741003", "story_v_out_319741.awb")

						arg_13_1:RecordAudio("319741003", var_16_15)
						arg_13_1:RecordAudio("319741003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319741", "319741003", "story_v_out_319741.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319741", "319741003", "story_v_out_319741.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_16 and arg_13_1.time_ < var_16_6 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319741004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319741004
		arg_17_1.duration_ = 6.3

		local var_17_0 = {
			zh = 6.033,
			ja = 6.3
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
				arg_17_0:Play319741005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.825

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[648].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(319741004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 33
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741004", "story_v_out_319741.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_319741", "319741004", "story_v_out_319741.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_319741", "319741004", "story_v_out_319741.awb")

						arg_17_1:RecordAudio("319741004", var_20_9)
						arg_17_1:RecordAudio("319741004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319741", "319741004", "story_v_out_319741.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319741", "319741004", "story_v_out_319741.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319741005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319741005
		arg_21_1.duration_ = 4.7

		local var_21_0 = {
			zh = 2.766,
			ja = 4.7
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
				arg_21_0:Play319741006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10079ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10079ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -0.95, -6.05)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10079ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["10079ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect10079ui_story == nil then
				arg_21_1.var_.characterEffect10079ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect10079ui_story and not isNil(var_24_9) then
					arg_21_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect10079ui_story then
				arg_21_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_15 = 0
			local var_24_16 = 0.25

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(319741005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 10
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741005", "story_v_out_319741.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_319741", "319741005", "story_v_out_319741.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_319741", "319741005", "story_v_out_319741.awb")

						arg_21_1:RecordAudio("319741005", var_24_24)
						arg_21_1:RecordAudio("319741005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319741", "319741005", "story_v_out_319741.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319741", "319741005", "story_v_out_319741.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_25 and arg_21_1.time_ < var_24_15 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319741006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319741006
		arg_25_1.duration_ = 5

		local var_25_0 = {
			zh = 4.866,
			ja = 5
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
				arg_25_0:Play319741007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10079ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect10079ui_story == nil then
				arg_25_1.var_.characterEffect10079ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect10079ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10079ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect10079ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10079ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.7

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[648].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(319741006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741006", "story_v_out_319741.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_319741", "319741006", "story_v_out_319741.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_319741", "319741006", "story_v_out_319741.awb")

						arg_25_1:RecordAudio("319741006", var_28_15)
						arg_25_1:RecordAudio("319741006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319741", "319741006", "story_v_out_319741.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319741", "319741006", "story_v_out_319741.awb")
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
	Play319741007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319741007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319741008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.925

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

				local var_32_2 = arg_29_1:GetWordFromCfg(319741007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 37
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
	Play319741008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319741008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319741009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10079ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10079ui_story = var_36_0.localPosition

				local var_36_2 = "10079ui_story"

				arg_33_1:ShowWeapon(arg_33_1.var_[var_36_2 .. "Animator"].transform, false)
			end

			local var_36_3 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_3 then
				local var_36_4 = (arg_33_1.time_ - var_36_1) / var_36_3
				local var_36_5 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10079ui_story, var_36_5, var_36_4)

				local var_36_6 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_6.x, var_36_6.y, var_36_6.z)

				local var_36_7 = var_36_0.localEulerAngles

				var_36_7.z = 0
				var_36_7.x = 0
				var_36_0.localEulerAngles = var_36_7
			end

			if arg_33_1.time_ >= var_36_1 + var_36_3 and arg_33_1.time_ < var_36_1 + var_36_3 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, 100, 0)

				local var_36_8 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_8.x, var_36_8.y, var_36_8.z)

				local var_36_9 = var_36_0.localEulerAngles

				var_36_9.z = 0
				var_36_9.x = 0
				var_36_0.localEulerAngles = var_36_9
			end

			local var_36_10 = 0
			local var_36_11 = 1.075

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_12 = arg_33_1:GetWordFromCfg(319741008)
				local var_36_13 = arg_33_1:FormatText(var_36_12.content)

				arg_33_1.text_.text = var_36_13

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_14 = 43
				local var_36_15 = utf8.len(var_36_13)
				local var_36_16 = var_36_14 <= 0 and var_36_11 or var_36_11 * (var_36_15 / var_36_14)

				if var_36_16 > 0 and var_36_11 < var_36_16 then
					arg_33_1.talkMaxDuration = var_36_16

					if var_36_16 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_13
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_17 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_17 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_17

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_17 and arg_33_1.time_ < var_36_10 + var_36_17 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319741009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319741009
		arg_37_1.duration_ = 2.37

		local var_37_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_37_0:Play319741010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "10066ui_story"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_37_1.stage_.transform)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentInChildren(typeof(CharacterEffect))

					var_40_3.enabled = true

					local var_40_4 = GameObjectTools.GetOrAddComponent(var_40_2, typeof(DynamicBoneHelper))

					if var_40_4 then
						var_40_4:EnableDynamicBone(false)
					end

					arg_37_1:ShowWeapon(var_40_3.transform, false)

					arg_37_1.var_[var_40_0 .. "Animator"] = var_40_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_37_1.var_[var_40_0 .. "Animator"].applyRootMotion = true
					arg_37_1.var_[var_40_0 .. "LipSync"] = var_40_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_40_5 = arg_37_1.actors_["10066ui_story"].transform
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.var_.moveOldPos10066ui_story = var_40_5.localPosition
			end

			local var_40_7 = 0.001

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7
				local var_40_9 = Vector3.New(0, -0.99, -5.83)

				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10066ui_story, var_40_9, var_40_8)

				local var_40_10 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_10.x, var_40_10.y, var_40_10.z)

				local var_40_11 = var_40_5.localEulerAngles

				var_40_11.z = 0
				var_40_11.x = 0
				var_40_5.localEulerAngles = var_40_11
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_40_12 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_12.x, var_40_12.y, var_40_12.z)

				local var_40_13 = var_40_5.localEulerAngles

				var_40_13.z = 0
				var_40_13.x = 0
				var_40_5.localEulerAngles = var_40_13
			end

			local var_40_14 = arg_37_1.actors_["10066ui_story"]
			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.characterEffect10066ui_story == nil then
				arg_37_1.var_.characterEffect10066ui_story = var_40_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_16 = 0.200000002980232

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_16 and not isNil(var_40_14) then
				local var_40_17 = (arg_37_1.time_ - var_40_15) / var_40_16

				if arg_37_1.var_.characterEffect10066ui_story and not isNil(var_40_14) then
					arg_37_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_15 + var_40_16 and arg_37_1.time_ < var_40_15 + var_40_16 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.characterEffect10066ui_story then
				arg_37_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_40_18 = 0

			if var_40_18 < arg_37_1.time_ and arg_37_1.time_ <= var_40_18 + arg_40_0 then
				arg_37_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_40_19 = 0

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_20 = 0
			local var_40_21 = 0.125

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_22 = arg_37_1:FormatText(StoryNameCfg[640].name)

				arg_37_1.leftNameTxt_.text = var_40_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_23 = arg_37_1:GetWordFromCfg(319741009)
				local var_40_24 = arg_37_1:FormatText(var_40_23.content)

				arg_37_1.text_.text = var_40_24

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_25 = 5
				local var_40_26 = utf8.len(var_40_24)
				local var_40_27 = var_40_25 <= 0 and var_40_21 or var_40_21 * (var_40_26 / var_40_25)

				if var_40_27 > 0 and var_40_21 < var_40_27 then
					arg_37_1.talkMaxDuration = var_40_27

					if var_40_27 + var_40_20 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_27 + var_40_20
					end
				end

				arg_37_1.text_.text = var_40_24
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741009", "story_v_out_319741.awb") ~= 0 then
					local var_40_28 = manager.audio:GetVoiceLength("story_v_out_319741", "319741009", "story_v_out_319741.awb") / 1000

					if var_40_28 + var_40_20 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_28 + var_40_20
					end

					if var_40_23.prefab_name ~= "" and arg_37_1.actors_[var_40_23.prefab_name] ~= nil then
						local var_40_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_23.prefab_name].transform, "story_v_out_319741", "319741009", "story_v_out_319741.awb")

						arg_37_1:RecordAudio("319741009", var_40_29)
						arg_37_1:RecordAudio("319741009", var_40_29)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319741", "319741009", "story_v_out_319741.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319741", "319741009", "story_v_out_319741.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_30 = math.max(var_40_21, arg_37_1.talkMaxDuration)

			if var_40_20 <= arg_37_1.time_ and arg_37_1.time_ < var_40_20 + var_40_30 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_20) / var_40_30

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_20 + var_40_30 and arg_37_1.time_ < var_40_20 + var_40_30 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play319741010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319741010
		arg_41_1.duration_ = 6.33

		local var_41_0 = {
			zh = 3.3,
			ja = 6.333
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
				arg_41_0:Play319741011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10079ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10079ui_story == nil then
				arg_41_1.var_.characterEffect10079ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10079ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10079ui_story then
				arg_41_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_6 = arg_41_1.actors_["10066ui_story"]
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect10066ui_story == nil then
				arg_41_1.var_.characterEffect10066ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.200000002980232

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 and not isNil(var_44_6) then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8

				if arg_41_1.var_.characterEffect10066ui_story and not isNil(var_44_6) then
					local var_44_10 = Mathf.Lerp(0, 0.5, var_44_9)

					arg_41_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10066ui_story.fillRatio = var_44_10
				end
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect10066ui_story then
				local var_44_11 = 0.5

				arg_41_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10066ui_story.fillRatio = var_44_11
			end

			local var_44_12 = arg_41_1.actors_["10079ui_story"].transform
			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1.var_.moveOldPos10079ui_story = var_44_12.localPosition
			end

			local var_44_14 = 0.001

			if var_44_13 <= arg_41_1.time_ and arg_41_1.time_ < var_44_13 + var_44_14 then
				local var_44_15 = (arg_41_1.time_ - var_44_13) / var_44_14
				local var_44_16 = Vector3.New(-0.7, -0.95, -6.05)

				var_44_12.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10079ui_story, var_44_16, var_44_15)

				local var_44_17 = manager.ui.mainCamera.transform.position - var_44_12.position

				var_44_12.forward = Vector3.New(var_44_17.x, var_44_17.y, var_44_17.z)

				local var_44_18 = var_44_12.localEulerAngles

				var_44_18.z = 0
				var_44_18.x = 0
				var_44_12.localEulerAngles = var_44_18
			end

			if arg_41_1.time_ >= var_44_13 + var_44_14 and arg_41_1.time_ < var_44_13 + var_44_14 + arg_44_0 then
				var_44_12.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_44_19 = manager.ui.mainCamera.transform.position - var_44_12.position

				var_44_12.forward = Vector3.New(var_44_19.x, var_44_19.y, var_44_19.z)

				local var_44_20 = var_44_12.localEulerAngles

				var_44_20.z = 0
				var_44_20.x = 0
				var_44_12.localEulerAngles = var_44_20
			end

			local var_44_21 = arg_41_1.actors_["10066ui_story"].transform
			local var_44_22 = 0

			if var_44_22 < arg_41_1.time_ and arg_41_1.time_ <= var_44_22 + arg_44_0 then
				arg_41_1.var_.moveOldPos10066ui_story = var_44_21.localPosition
			end

			local var_44_23 = 0.001

			if var_44_22 <= arg_41_1.time_ and arg_41_1.time_ < var_44_22 + var_44_23 then
				local var_44_24 = (arg_41_1.time_ - var_44_22) / var_44_23
				local var_44_25 = Vector3.New(0.7, -0.99, -5.83)

				var_44_21.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10066ui_story, var_44_25, var_44_24)

				local var_44_26 = manager.ui.mainCamera.transform.position - var_44_21.position

				var_44_21.forward = Vector3.New(var_44_26.x, var_44_26.y, var_44_26.z)

				local var_44_27 = var_44_21.localEulerAngles

				var_44_27.z = 0
				var_44_27.x = 0
				var_44_21.localEulerAngles = var_44_27
			end

			if arg_41_1.time_ >= var_44_22 + var_44_23 and arg_41_1.time_ < var_44_22 + var_44_23 + arg_44_0 then
				var_44_21.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_44_28 = manager.ui.mainCamera.transform.position - var_44_21.position

				var_44_21.forward = Vector3.New(var_44_28.x, var_44_28.y, var_44_28.z)

				local var_44_29 = var_44_21.localEulerAngles

				var_44_29.z = 0
				var_44_29.x = 0
				var_44_21.localEulerAngles = var_44_29
			end

			local var_44_30 = 0
			local var_44_31 = 0.425

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[6].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(319741010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741010", "story_v_out_319741.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_319741", "319741010", "story_v_out_319741.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_319741", "319741010", "story_v_out_319741.awb")

						arg_41_1:RecordAudio("319741010", var_44_39)
						arg_41_1:RecordAudio("319741010", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319741", "319741010", "story_v_out_319741.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319741", "319741010", "story_v_out_319741.awb")
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
				actorName = "10079ui_story",
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

		arg_41_1:InitPlayNodeList()
	end,
	Play319741011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319741011
		arg_45_1.duration_ = 7.6

		local var_45_0 = {
			zh = 7.6,
			ja = 7.233
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
				arg_45_0:Play319741012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "4040ui_story"

			if arg_45_1.actors_[var_48_0] == nil then
				local var_48_1 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_48_1) then
					local var_48_2 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_45_1.stage_.transform)

					var_48_2.name = var_48_0
					var_48_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_45_1.actors_[var_48_0] = var_48_2

					local var_48_3 = var_48_2:GetComponentInChildren(typeof(CharacterEffect))

					var_48_3.enabled = true

					local var_48_4 = GameObjectTools.GetOrAddComponent(var_48_2, typeof(DynamicBoneHelper))

					if var_48_4 then
						var_48_4:EnableDynamicBone(false)
					end

					arg_45_1:ShowWeapon(var_48_3.transform, false)

					arg_45_1.var_[var_48_0 .. "Animator"] = var_48_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_45_1.var_[var_48_0 .. "Animator"].applyRootMotion = true
					arg_45_1.var_[var_48_0 .. "LipSync"] = var_48_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_48_5 = arg_45_1.actors_["4040ui_story"].transform
			local var_48_6 = 0

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.var_.moveOldPos4040ui_story = var_48_5.localPosition
			end

			local var_48_7 = 0.001

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_7 then
				local var_48_8 = (arg_45_1.time_ - var_48_6) / var_48_7
				local var_48_9 = Vector3.New(0, -1.55, -5.5)

				var_48_5.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos4040ui_story, var_48_9, var_48_8)

				local var_48_10 = manager.ui.mainCamera.transform.position - var_48_5.position

				var_48_5.forward = Vector3.New(var_48_10.x, var_48_10.y, var_48_10.z)

				local var_48_11 = var_48_5.localEulerAngles

				var_48_11.z = 0
				var_48_11.x = 0
				var_48_5.localEulerAngles = var_48_11
			end

			if arg_45_1.time_ >= var_48_6 + var_48_7 and arg_45_1.time_ < var_48_6 + var_48_7 + arg_48_0 then
				var_48_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_48_12 = manager.ui.mainCamera.transform.position - var_48_5.position

				var_48_5.forward = Vector3.New(var_48_12.x, var_48_12.y, var_48_12.z)

				local var_48_13 = var_48_5.localEulerAngles

				var_48_13.z = 0
				var_48_13.x = 0
				var_48_5.localEulerAngles = var_48_13
			end

			local var_48_14 = arg_45_1.actors_["4040ui_story"]
			local var_48_15 = 0

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.characterEffect4040ui_story == nil then
				arg_45_1.var_.characterEffect4040ui_story = var_48_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_16 = 0.200000002980232

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_16 and not isNil(var_48_14) then
				local var_48_17 = (arg_45_1.time_ - var_48_15) / var_48_16

				if arg_45_1.var_.characterEffect4040ui_story and not isNil(var_48_14) then
					arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_15 + var_48_16 and arg_45_1.time_ < var_48_15 + var_48_16 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.characterEffect4040ui_story then
				arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_48_18 = 0

			if var_48_18 < arg_45_1.time_ and arg_45_1.time_ <= var_48_18 + arg_48_0 then
				arg_45_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_48_19 = 0

			if var_48_19 < arg_45_1.time_ and arg_45_1.time_ <= var_48_19 + arg_48_0 then
				arg_45_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_20 = arg_45_1.actors_["10066ui_story"].transform
			local var_48_21 = 0

			if var_48_21 < arg_45_1.time_ and arg_45_1.time_ <= var_48_21 + arg_48_0 then
				arg_45_1.var_.moveOldPos10066ui_story = var_48_20.localPosition
			end

			local var_48_22 = 0.001

			if var_48_21 <= arg_45_1.time_ and arg_45_1.time_ < var_48_21 + var_48_22 then
				local var_48_23 = (arg_45_1.time_ - var_48_21) / var_48_22
				local var_48_24 = Vector3.New(0, 100, 0)

				var_48_20.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10066ui_story, var_48_24, var_48_23)

				local var_48_25 = manager.ui.mainCamera.transform.position - var_48_20.position

				var_48_20.forward = Vector3.New(var_48_25.x, var_48_25.y, var_48_25.z)

				local var_48_26 = var_48_20.localEulerAngles

				var_48_26.z = 0
				var_48_26.x = 0
				var_48_20.localEulerAngles = var_48_26
			end

			if arg_45_1.time_ >= var_48_21 + var_48_22 and arg_45_1.time_ < var_48_21 + var_48_22 + arg_48_0 then
				var_48_20.localPosition = Vector3.New(0, 100, 0)

				local var_48_27 = manager.ui.mainCamera.transform.position - var_48_20.position

				var_48_20.forward = Vector3.New(var_48_27.x, var_48_27.y, var_48_27.z)

				local var_48_28 = var_48_20.localEulerAngles

				var_48_28.z = 0
				var_48_28.x = 0
				var_48_20.localEulerAngles = var_48_28
			end

			local var_48_29 = arg_45_1.actors_["10066ui_story"]
			local var_48_30 = 0

			if var_48_30 < arg_45_1.time_ and arg_45_1.time_ <= var_48_30 + arg_48_0 and not isNil(var_48_29) and arg_45_1.var_.characterEffect10066ui_story == nil then
				arg_45_1.var_.characterEffect10066ui_story = var_48_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_31 = 0.200000002980232

			if var_48_30 <= arg_45_1.time_ and arg_45_1.time_ < var_48_30 + var_48_31 and not isNil(var_48_29) then
				local var_48_32 = (arg_45_1.time_ - var_48_30) / var_48_31

				if arg_45_1.var_.characterEffect10066ui_story and not isNil(var_48_29) then
					local var_48_33 = Mathf.Lerp(0, 0.5, var_48_32)

					arg_45_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10066ui_story.fillRatio = var_48_33
				end
			end

			if arg_45_1.time_ >= var_48_30 + var_48_31 and arg_45_1.time_ < var_48_30 + var_48_31 + arg_48_0 and not isNil(var_48_29) and arg_45_1.var_.characterEffect10066ui_story then
				local var_48_34 = 0.5

				arg_45_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10066ui_story.fillRatio = var_48_34
			end

			local var_48_35 = arg_45_1.actors_["10079ui_story"].transform
			local var_48_36 = 0

			if var_48_36 < arg_45_1.time_ and arg_45_1.time_ <= var_48_36 + arg_48_0 then
				arg_45_1.var_.moveOldPos10079ui_story = var_48_35.localPosition
			end

			local var_48_37 = 0.001

			if var_48_36 <= arg_45_1.time_ and arg_45_1.time_ < var_48_36 + var_48_37 then
				local var_48_38 = (arg_45_1.time_ - var_48_36) / var_48_37
				local var_48_39 = Vector3.New(0, 100, 0)

				var_48_35.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10079ui_story, var_48_39, var_48_38)

				local var_48_40 = manager.ui.mainCamera.transform.position - var_48_35.position

				var_48_35.forward = Vector3.New(var_48_40.x, var_48_40.y, var_48_40.z)

				local var_48_41 = var_48_35.localEulerAngles

				var_48_41.z = 0
				var_48_41.x = 0
				var_48_35.localEulerAngles = var_48_41
			end

			if arg_45_1.time_ >= var_48_36 + var_48_37 and arg_45_1.time_ < var_48_36 + var_48_37 + arg_48_0 then
				var_48_35.localPosition = Vector3.New(0, 100, 0)

				local var_48_42 = manager.ui.mainCamera.transform.position - var_48_35.position

				var_48_35.forward = Vector3.New(var_48_42.x, var_48_42.y, var_48_42.z)

				local var_48_43 = var_48_35.localEulerAngles

				var_48_43.z = 0
				var_48_43.x = 0
				var_48_35.localEulerAngles = var_48_43
			end

			local var_48_44 = arg_45_1.actors_["10079ui_story"]
			local var_48_45 = 0

			if var_48_45 < arg_45_1.time_ and arg_45_1.time_ <= var_48_45 + arg_48_0 and not isNil(var_48_44) and arg_45_1.var_.characterEffect10079ui_story == nil then
				arg_45_1.var_.characterEffect10079ui_story = var_48_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_46 = 0.200000002980232

			if var_48_45 <= arg_45_1.time_ and arg_45_1.time_ < var_48_45 + var_48_46 and not isNil(var_48_44) then
				local var_48_47 = (arg_45_1.time_ - var_48_45) / var_48_46

				if arg_45_1.var_.characterEffect10079ui_story and not isNil(var_48_44) then
					local var_48_48 = Mathf.Lerp(0, 0.5, var_48_47)

					arg_45_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10079ui_story.fillRatio = var_48_48
				end
			end

			if arg_45_1.time_ >= var_48_45 + var_48_46 and arg_45_1.time_ < var_48_45 + var_48_46 + arg_48_0 and not isNil(var_48_44) and arg_45_1.var_.characterEffect10079ui_story then
				local var_48_49 = 0.5

				arg_45_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10079ui_story.fillRatio = var_48_49
			end

			local var_48_50 = 0
			local var_48_51 = 0.85

			if var_48_50 < arg_45_1.time_ and arg_45_1.time_ <= var_48_50 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_52 = arg_45_1:FormatText(StoryNameCfg[668].name)

				arg_45_1.leftNameTxt_.text = var_48_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_53 = arg_45_1:GetWordFromCfg(319741011)
				local var_48_54 = arg_45_1:FormatText(var_48_53.content)

				arg_45_1.text_.text = var_48_54

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_55 = 34
				local var_48_56 = utf8.len(var_48_54)
				local var_48_57 = var_48_55 <= 0 and var_48_51 or var_48_51 * (var_48_56 / var_48_55)

				if var_48_57 > 0 and var_48_51 < var_48_57 then
					arg_45_1.talkMaxDuration = var_48_57

					if var_48_57 + var_48_50 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_57 + var_48_50
					end
				end

				arg_45_1.text_.text = var_48_54
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741011", "story_v_out_319741.awb") ~= 0 then
					local var_48_58 = manager.audio:GetVoiceLength("story_v_out_319741", "319741011", "story_v_out_319741.awb") / 1000

					if var_48_58 + var_48_50 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_58 + var_48_50
					end

					if var_48_53.prefab_name ~= "" and arg_45_1.actors_[var_48_53.prefab_name] ~= nil then
						local var_48_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_53.prefab_name].transform, "story_v_out_319741", "319741011", "story_v_out_319741.awb")

						arg_45_1:RecordAudio("319741011", var_48_59)
						arg_45_1:RecordAudio("319741011", var_48_59)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319741", "319741011", "story_v_out_319741.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319741", "319741011", "story_v_out_319741.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_60 = math.max(var_48_51, arg_45_1.talkMaxDuration)

			if var_48_50 <= arg_45_1.time_ and arg_45_1.time_ < var_48_50 + var_48_60 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_50) / var_48_60

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_50 + var_48_60 and arg_45_1.time_ < var_48_50 + var_48_60 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
				actorName = "10079ui_story",
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
	Play319741012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319741012
		arg_49_1.duration_ = 7.4

		local var_49_0 = {
			zh = 7.4,
			ja = 5.5
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
				arg_49_0:Play319741013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.825

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[668].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(319741012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741012", "story_v_out_319741.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_319741", "319741012", "story_v_out_319741.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_319741", "319741012", "story_v_out_319741.awb")

						arg_49_1:RecordAudio("319741012", var_52_9)
						arg_49_1:RecordAudio("319741012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319741", "319741012", "story_v_out_319741.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319741", "319741012", "story_v_out_319741.awb")
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
	Play319741013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319741013
		arg_53_1.duration_ = 14.67

		local var_53_0 = {
			zh = 7.166,
			ja = 14.666
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
				arg_53_0:Play319741014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10079ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10079ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, -0.95, -6.05)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10079ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["10079ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect10079ui_story == nil then
				arg_53_1.var_.characterEffect10079ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 and not isNil(var_56_9) then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect10079ui_story and not isNil(var_56_9) then
					arg_53_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect10079ui_story then
				arg_53_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_56_13 = 0

			if var_56_13 < arg_53_1.time_ and arg_53_1.time_ <= var_56_13 + arg_56_0 then
				arg_53_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_56_14 = 0

			if var_56_14 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_15 = arg_53_1.actors_["4040ui_story"].transform
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.var_.moveOldPos4040ui_story = var_56_15.localPosition
			end

			local var_56_17 = 0.001

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17
				local var_56_19 = Vector3.New(0, 100, 0)

				var_56_15.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos4040ui_story, var_56_19, var_56_18)

				local var_56_20 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_20.x, var_56_20.y, var_56_20.z)

				local var_56_21 = var_56_15.localEulerAngles

				var_56_21.z = 0
				var_56_21.x = 0
				var_56_15.localEulerAngles = var_56_21
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				var_56_15.localPosition = Vector3.New(0, 100, 0)

				local var_56_22 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_22.x, var_56_22.y, var_56_22.z)

				local var_56_23 = var_56_15.localEulerAngles

				var_56_23.z = 0
				var_56_23.x = 0
				var_56_15.localEulerAngles = var_56_23
			end

			local var_56_24 = arg_53_1.actors_["4040ui_story"]
			local var_56_25 = 0

			if var_56_25 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect4040ui_story == nil then
				arg_53_1.var_.characterEffect4040ui_story = var_56_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_26 = 0.200000002980232

			if var_56_25 <= arg_53_1.time_ and arg_53_1.time_ < var_56_25 + var_56_26 and not isNil(var_56_24) then
				local var_56_27 = (arg_53_1.time_ - var_56_25) / var_56_26

				if arg_53_1.var_.characterEffect4040ui_story and not isNil(var_56_24) then
					local var_56_28 = Mathf.Lerp(0, 0.5, var_56_27)

					arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_53_1.var_.characterEffect4040ui_story.fillRatio = var_56_28
				end
			end

			if arg_53_1.time_ >= var_56_25 + var_56_26 and arg_53_1.time_ < var_56_25 + var_56_26 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect4040ui_story then
				local var_56_29 = 0.5

				arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_53_1.var_.characterEffect4040ui_story.fillRatio = var_56_29
			end

			local var_56_30 = 0
			local var_56_31 = 0.975

			if var_56_30 < arg_53_1.time_ and arg_53_1.time_ <= var_56_30 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_32 = arg_53_1:FormatText(StoryNameCfg[6].name)

				arg_53_1.leftNameTxt_.text = var_56_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_33 = arg_53_1:GetWordFromCfg(319741013)
				local var_56_34 = arg_53_1:FormatText(var_56_33.content)

				arg_53_1.text_.text = var_56_34

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_35 = 39
				local var_56_36 = utf8.len(var_56_34)
				local var_56_37 = var_56_35 <= 0 and var_56_31 or var_56_31 * (var_56_36 / var_56_35)

				if var_56_37 > 0 and var_56_31 < var_56_37 then
					arg_53_1.talkMaxDuration = var_56_37

					if var_56_37 + var_56_30 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_37 + var_56_30
					end
				end

				arg_53_1.text_.text = var_56_34
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741013", "story_v_out_319741.awb") ~= 0 then
					local var_56_38 = manager.audio:GetVoiceLength("story_v_out_319741", "319741013", "story_v_out_319741.awb") / 1000

					if var_56_38 + var_56_30 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_38 + var_56_30
					end

					if var_56_33.prefab_name ~= "" and arg_53_1.actors_[var_56_33.prefab_name] ~= nil then
						local var_56_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_33.prefab_name].transform, "story_v_out_319741", "319741013", "story_v_out_319741.awb")

						arg_53_1:RecordAudio("319741013", var_56_39)
						arg_53_1:RecordAudio("319741013", var_56_39)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319741", "319741013", "story_v_out_319741.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319741", "319741013", "story_v_out_319741.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_40 = math.max(var_56_31, arg_53_1.talkMaxDuration)

			if var_56_30 <= arg_53_1.time_ and arg_53_1.time_ < var_56_30 + var_56_40 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_30) / var_56_40

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_30 + var_56_40 and arg_53_1.time_ < var_56_30 + var_56_40 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319741014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319741014
		arg_57_1.duration_ = 5.23

		local var_57_0 = {
			zh = 5.233,
			ja = 4.333
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
				arg_57_0:Play319741015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10066ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10066ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0.7, -0.99, -5.83)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10066ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["10066ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect10066ui_story == nil then
				arg_57_1.var_.characterEffect10066ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect10066ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect10066ui_story then
				arg_57_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_15 = arg_57_1.actors_["10079ui_story"].transform
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.var_.moveOldPos10079ui_story = var_60_15.localPosition
			end

			local var_60_17 = 0.001

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_17 then
				local var_60_18 = (arg_57_1.time_ - var_60_16) / var_60_17
				local var_60_19 = Vector3.New(-0.7, -0.95, -6.05)

				var_60_15.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10079ui_story, var_60_19, var_60_18)

				local var_60_20 = manager.ui.mainCamera.transform.position - var_60_15.position

				var_60_15.forward = Vector3.New(var_60_20.x, var_60_20.y, var_60_20.z)

				local var_60_21 = var_60_15.localEulerAngles

				var_60_21.z = 0
				var_60_21.x = 0
				var_60_15.localEulerAngles = var_60_21
			end

			if arg_57_1.time_ >= var_60_16 + var_60_17 and arg_57_1.time_ < var_60_16 + var_60_17 + arg_60_0 then
				var_60_15.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_60_22 = manager.ui.mainCamera.transform.position - var_60_15.position

				var_60_15.forward = Vector3.New(var_60_22.x, var_60_22.y, var_60_22.z)

				local var_60_23 = var_60_15.localEulerAngles

				var_60_23.z = 0
				var_60_23.x = 0
				var_60_15.localEulerAngles = var_60_23
			end

			local var_60_24 = arg_57_1.actors_["10079ui_story"]
			local var_60_25 = 0

			if var_60_25 < arg_57_1.time_ and arg_57_1.time_ <= var_60_25 + arg_60_0 and not isNil(var_60_24) and arg_57_1.var_.characterEffect10079ui_story == nil then
				arg_57_1.var_.characterEffect10079ui_story = var_60_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_26 = 0.200000002980232

			if var_60_25 <= arg_57_1.time_ and arg_57_1.time_ < var_60_25 + var_60_26 and not isNil(var_60_24) then
				local var_60_27 = (arg_57_1.time_ - var_60_25) / var_60_26

				if arg_57_1.var_.characterEffect10079ui_story and not isNil(var_60_24) then
					local var_60_28 = Mathf.Lerp(0, 0.5, var_60_27)

					arg_57_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10079ui_story.fillRatio = var_60_28
				end
			end

			if arg_57_1.time_ >= var_60_25 + var_60_26 and arg_57_1.time_ < var_60_25 + var_60_26 + arg_60_0 and not isNil(var_60_24) and arg_57_1.var_.characterEffect10079ui_story then
				local var_60_29 = 0.5

				arg_57_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10079ui_story.fillRatio = var_60_29
			end

			local var_60_30 = 0
			local var_60_31 = 0.5

			if var_60_30 < arg_57_1.time_ and arg_57_1.time_ <= var_60_30 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_32 = arg_57_1:FormatText(StoryNameCfg[640].name)

				arg_57_1.leftNameTxt_.text = var_60_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_33 = arg_57_1:GetWordFromCfg(319741014)
				local var_60_34 = arg_57_1:FormatText(var_60_33.content)

				arg_57_1.text_.text = var_60_34

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_35 = 20
				local var_60_36 = utf8.len(var_60_34)
				local var_60_37 = var_60_35 <= 0 and var_60_31 or var_60_31 * (var_60_36 / var_60_35)

				if var_60_37 > 0 and var_60_31 < var_60_37 then
					arg_57_1.talkMaxDuration = var_60_37

					if var_60_37 + var_60_30 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_37 + var_60_30
					end
				end

				arg_57_1.text_.text = var_60_34
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741014", "story_v_out_319741.awb") ~= 0 then
					local var_60_38 = manager.audio:GetVoiceLength("story_v_out_319741", "319741014", "story_v_out_319741.awb") / 1000

					if var_60_38 + var_60_30 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_38 + var_60_30
					end

					if var_60_33.prefab_name ~= "" and arg_57_1.actors_[var_60_33.prefab_name] ~= nil then
						local var_60_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_33.prefab_name].transform, "story_v_out_319741", "319741014", "story_v_out_319741.awb")

						arg_57_1:RecordAudio("319741014", var_60_39)
						arg_57_1:RecordAudio("319741014", var_60_39)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319741", "319741014", "story_v_out_319741.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319741", "319741014", "story_v_out_319741.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_40 = math.max(var_60_31, arg_57_1.talkMaxDuration)

			if var_60_30 <= arg_57_1.time_ and arg_57_1.time_ < var_60_30 + var_60_40 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_30) / var_60_40

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_30 + var_60_40 and arg_57_1.time_ < var_60_30 + var_60_40 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play319741015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319741015
		arg_61_1.duration_ = 4.03

		local var_61_0 = {
			zh = 3.366,
			ja = 4.033
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
				arg_61_0:Play319741016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10066ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10066ui_story == nil then
				arg_61_1.var_.characterEffect10066ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect10066ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10066ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10066ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10066ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_64_7 = 0

			if var_64_7 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 then
				arg_61_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_8 = arg_61_1.actors_["10079ui_story"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.characterEffect10079ui_story == nil then
				arg_61_1.var_.characterEffect10079ui_story = var_64_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_10 = 0.200000002980232

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.characterEffect10079ui_story and not isNil(var_64_8) then
					arg_61_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.characterEffect10079ui_story then
				arg_61_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_64_12 = 0
			local var_64_13 = 0.45

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

				local var_64_15 = arg_61_1:GetWordFromCfg(319741015)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741015", "story_v_out_319741.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_out_319741", "319741015", "story_v_out_319741.awb") / 1000

					if var_64_20 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_12
					end

					if var_64_15.prefab_name ~= "" and arg_61_1.actors_[var_64_15.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_15.prefab_name].transform, "story_v_out_319741", "319741015", "story_v_out_319741.awb")

						arg_61_1:RecordAudio("319741015", var_64_21)
						arg_61_1:RecordAudio("319741015", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319741", "319741015", "story_v_out_319741.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319741", "319741015", "story_v_out_319741.awb")
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
	Play319741016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319741016
		arg_65_1.duration_ = 6.1

		local var_65_0 = {
			zh = 2.3,
			ja = 6.1
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
				arg_65_0:Play319741017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_68_1 = arg_65_1.actors_["10066ui_story"]
			local var_68_2 = 0

			if var_68_2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10066ui_story == nil then
				arg_65_1.var_.characterEffect10066ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_3 and not isNil(var_68_1) then
				local var_68_4 = (arg_65_1.time_ - var_68_2) / var_68_3

				if arg_65_1.var_.characterEffect10066ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_2 + var_68_3 and arg_65_1.time_ < var_68_2 + var_68_3 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10066ui_story then
				arg_65_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_68_5 = arg_65_1.actors_["10079ui_story"]
			local var_68_6 = 0

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect10079ui_story == nil then
				arg_65_1.var_.characterEffect10079ui_story = var_68_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_7 = 0.200000002980232

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_7 and not isNil(var_68_5) then
				local var_68_8 = (arg_65_1.time_ - var_68_6) / var_68_7

				if arg_65_1.var_.characterEffect10079ui_story and not isNil(var_68_5) then
					local var_68_9 = Mathf.Lerp(0, 0.5, var_68_8)

					arg_65_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10079ui_story.fillRatio = var_68_9
				end
			end

			if arg_65_1.time_ >= var_68_6 + var_68_7 and arg_65_1.time_ < var_68_6 + var_68_7 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect10079ui_story then
				local var_68_10 = 0.5

				arg_65_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10079ui_story.fillRatio = var_68_10
			end

			local var_68_11 = 0
			local var_68_12 = 0.275

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_13 = arg_65_1:FormatText(StoryNameCfg[640].name)

				arg_65_1.leftNameTxt_.text = var_68_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_14 = arg_65_1:GetWordFromCfg(319741016)
				local var_68_15 = arg_65_1:FormatText(var_68_14.content)

				arg_65_1.text_.text = var_68_15

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_16 = 11
				local var_68_17 = utf8.len(var_68_15)
				local var_68_18 = var_68_16 <= 0 and var_68_12 or var_68_12 * (var_68_17 / var_68_16)

				if var_68_18 > 0 and var_68_12 < var_68_18 then
					arg_65_1.talkMaxDuration = var_68_18

					if var_68_18 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_11
					end
				end

				arg_65_1.text_.text = var_68_15
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741016", "story_v_out_319741.awb") ~= 0 then
					local var_68_19 = manager.audio:GetVoiceLength("story_v_out_319741", "319741016", "story_v_out_319741.awb") / 1000

					if var_68_19 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_11
					end

					if var_68_14.prefab_name ~= "" and arg_65_1.actors_[var_68_14.prefab_name] ~= nil then
						local var_68_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_14.prefab_name].transform, "story_v_out_319741", "319741016", "story_v_out_319741.awb")

						arg_65_1:RecordAudio("319741016", var_68_20)
						arg_65_1:RecordAudio("319741016", var_68_20)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319741", "319741016", "story_v_out_319741.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319741", "319741016", "story_v_out_319741.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_21 = math.max(var_68_12, arg_65_1.talkMaxDuration)

			if var_68_11 <= arg_65_1.time_ and arg_65_1.time_ < var_68_11 + var_68_21 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_11) / var_68_21

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_11 + var_68_21 and arg_65_1.time_ < var_68_11 + var_68_21 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319741017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319741017
		arg_69_1.duration_ = 3.3

		local var_69_0 = {
			zh = 2.9,
			ja = 3.3
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
				arg_69_0:Play319741018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["4040ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos4040ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, -1.55, -5.5)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos4040ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["4040ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect4040ui_story == nil then
				arg_69_1.var_.characterEffect4040ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect4040ui_story and not isNil(var_72_9) then
					arg_69_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect4040ui_story then
				arg_69_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_72_13 = arg_69_1.actors_["10066ui_story"].transform
			local var_72_14 = 0

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1.var_.moveOldPos10066ui_story = var_72_13.localPosition
			end

			local var_72_15 = 0.001

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_15 then
				local var_72_16 = (arg_69_1.time_ - var_72_14) / var_72_15
				local var_72_17 = Vector3.New(0, 100, 0)

				var_72_13.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10066ui_story, var_72_17, var_72_16)

				local var_72_18 = manager.ui.mainCamera.transform.position - var_72_13.position

				var_72_13.forward = Vector3.New(var_72_18.x, var_72_18.y, var_72_18.z)

				local var_72_19 = var_72_13.localEulerAngles

				var_72_19.z = 0
				var_72_19.x = 0
				var_72_13.localEulerAngles = var_72_19
			end

			if arg_69_1.time_ >= var_72_14 + var_72_15 and arg_69_1.time_ < var_72_14 + var_72_15 + arg_72_0 then
				var_72_13.localPosition = Vector3.New(0, 100, 0)

				local var_72_20 = manager.ui.mainCamera.transform.position - var_72_13.position

				var_72_13.forward = Vector3.New(var_72_20.x, var_72_20.y, var_72_20.z)

				local var_72_21 = var_72_13.localEulerAngles

				var_72_21.z = 0
				var_72_21.x = 0
				var_72_13.localEulerAngles = var_72_21
			end

			local var_72_22 = arg_69_1.actors_["10066ui_story"]
			local var_72_23 = 0

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 and not isNil(var_72_22) and arg_69_1.var_.characterEffect10066ui_story == nil then
				arg_69_1.var_.characterEffect10066ui_story = var_72_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_24 = 0.200000002980232

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_24 and not isNil(var_72_22) then
				local var_72_25 = (arg_69_1.time_ - var_72_23) / var_72_24

				if arg_69_1.var_.characterEffect10066ui_story and not isNil(var_72_22) then
					local var_72_26 = Mathf.Lerp(0, 0.5, var_72_25)

					arg_69_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10066ui_story.fillRatio = var_72_26
				end
			end

			if arg_69_1.time_ >= var_72_23 + var_72_24 and arg_69_1.time_ < var_72_23 + var_72_24 + arg_72_0 and not isNil(var_72_22) and arg_69_1.var_.characterEffect10066ui_story then
				local var_72_27 = 0.5

				arg_69_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10066ui_story.fillRatio = var_72_27
			end

			local var_72_28 = arg_69_1.actors_["10079ui_story"].transform
			local var_72_29 = 0

			if var_72_29 < arg_69_1.time_ and arg_69_1.time_ <= var_72_29 + arg_72_0 then
				arg_69_1.var_.moveOldPos10079ui_story = var_72_28.localPosition
			end

			local var_72_30 = 0.001

			if var_72_29 <= arg_69_1.time_ and arg_69_1.time_ < var_72_29 + var_72_30 then
				local var_72_31 = (arg_69_1.time_ - var_72_29) / var_72_30
				local var_72_32 = Vector3.New(0, 100, 0)

				var_72_28.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10079ui_story, var_72_32, var_72_31)

				local var_72_33 = manager.ui.mainCamera.transform.position - var_72_28.position

				var_72_28.forward = Vector3.New(var_72_33.x, var_72_33.y, var_72_33.z)

				local var_72_34 = var_72_28.localEulerAngles

				var_72_34.z = 0
				var_72_34.x = 0
				var_72_28.localEulerAngles = var_72_34
			end

			if arg_69_1.time_ >= var_72_29 + var_72_30 and arg_69_1.time_ < var_72_29 + var_72_30 + arg_72_0 then
				var_72_28.localPosition = Vector3.New(0, 100, 0)

				local var_72_35 = manager.ui.mainCamera.transform.position - var_72_28.position

				var_72_28.forward = Vector3.New(var_72_35.x, var_72_35.y, var_72_35.z)

				local var_72_36 = var_72_28.localEulerAngles

				var_72_36.z = 0
				var_72_36.x = 0
				var_72_28.localEulerAngles = var_72_36
			end

			local var_72_37 = arg_69_1.actors_["10079ui_story"]
			local var_72_38 = 0

			if var_72_38 < arg_69_1.time_ and arg_69_1.time_ <= var_72_38 + arg_72_0 and not isNil(var_72_37) and arg_69_1.var_.characterEffect10079ui_story == nil then
				arg_69_1.var_.characterEffect10079ui_story = var_72_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_39 = 0.200000002980232

			if var_72_38 <= arg_69_1.time_ and arg_69_1.time_ < var_72_38 + var_72_39 and not isNil(var_72_37) then
				local var_72_40 = (arg_69_1.time_ - var_72_38) / var_72_39

				if arg_69_1.var_.characterEffect10079ui_story and not isNil(var_72_37) then
					local var_72_41 = Mathf.Lerp(0, 0.5, var_72_40)

					arg_69_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10079ui_story.fillRatio = var_72_41
				end
			end

			if arg_69_1.time_ >= var_72_38 + var_72_39 and arg_69_1.time_ < var_72_38 + var_72_39 + arg_72_0 and not isNil(var_72_37) and arg_69_1.var_.characterEffect10079ui_story then
				local var_72_42 = 0.5

				arg_69_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10079ui_story.fillRatio = var_72_42
			end

			local var_72_43 = 0

			if var_72_43 < arg_69_1.time_ and arg_69_1.time_ <= var_72_43 + arg_72_0 then
				arg_69_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_72_44 = 0

			if var_72_44 < arg_69_1.time_ and arg_69_1.time_ <= var_72_44 + arg_72_0 then
				arg_69_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_45 = 0
			local var_72_46 = 0.325

			if var_72_45 < arg_69_1.time_ and arg_69_1.time_ <= var_72_45 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_47 = arg_69_1:FormatText(StoryNameCfg[668].name)

				arg_69_1.leftNameTxt_.text = var_72_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_48 = arg_69_1:GetWordFromCfg(319741017)
				local var_72_49 = arg_69_1:FormatText(var_72_48.content)

				arg_69_1.text_.text = var_72_49

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_50 = 13
				local var_72_51 = utf8.len(var_72_49)
				local var_72_52 = var_72_50 <= 0 and var_72_46 or var_72_46 * (var_72_51 / var_72_50)

				if var_72_52 > 0 and var_72_46 < var_72_52 then
					arg_69_1.talkMaxDuration = var_72_52

					if var_72_52 + var_72_45 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_52 + var_72_45
					end
				end

				arg_69_1.text_.text = var_72_49
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741017", "story_v_out_319741.awb") ~= 0 then
					local var_72_53 = manager.audio:GetVoiceLength("story_v_out_319741", "319741017", "story_v_out_319741.awb") / 1000

					if var_72_53 + var_72_45 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_53 + var_72_45
					end

					if var_72_48.prefab_name ~= "" and arg_69_1.actors_[var_72_48.prefab_name] ~= nil then
						local var_72_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_48.prefab_name].transform, "story_v_out_319741", "319741017", "story_v_out_319741.awb")

						arg_69_1:RecordAudio("319741017", var_72_54)
						arg_69_1:RecordAudio("319741017", var_72_54)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319741", "319741017", "story_v_out_319741.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319741", "319741017", "story_v_out_319741.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_55 = math.max(var_72_46, arg_69_1.talkMaxDuration)

			if var_72_45 <= arg_69_1.time_ and arg_69_1.time_ < var_72_45 + var_72_55 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_45) / var_72_55

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_45 + var_72_55 and arg_69_1.time_ < var_72_45 + var_72_55 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play319741018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319741018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play319741019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["4040ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos4040ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, 100, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos4040ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, 100, 0)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["4040ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect4040ui_story == nil then
				arg_73_1.var_.characterEffect4040ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect4040ui_story and not isNil(var_76_9) then
					local var_76_13 = Mathf.Lerp(0, 0.5, var_76_12)

					arg_73_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_73_1.var_.characterEffect4040ui_story.fillRatio = var_76_13
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect4040ui_story then
				local var_76_14 = 0.5

				arg_73_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_73_1.var_.characterEffect4040ui_story.fillRatio = var_76_14
			end

			local var_76_15 = 0
			local var_76_16 = 0.975

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_17 = arg_73_1:GetWordFromCfg(319741018)
				local var_76_18 = arg_73_1:FormatText(var_76_17.content)

				arg_73_1.text_.text = var_76_18

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_19 = 39
				local var_76_20 = utf8.len(var_76_18)
				local var_76_21 = var_76_19 <= 0 and var_76_16 or var_76_16 * (var_76_20 / var_76_19)

				if var_76_21 > 0 and var_76_16 < var_76_21 then
					arg_73_1.talkMaxDuration = var_76_21

					if var_76_21 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_21 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_18
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_22 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_22

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_22 and arg_73_1.time_ < var_76_15 + var_76_22 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play319741019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319741019
		arg_77_1.duration_ = 4.1

		local var_77_0 = {
			zh = 3.533,
			ja = 4.1
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
				arg_77_0:Play319741020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10066ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10066ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, -0.99, -5.83)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10066ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["10066ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10066ui_story == nil then
				arg_77_1.var_.characterEffect10066ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect10066ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10066ui_story then
				arg_77_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_80_14 = 0

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_80_15 = 0
			local var_80_16 = 0.375

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[640].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(319741019)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741019", "story_v_out_319741.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_319741", "319741019", "story_v_out_319741.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_319741", "319741019", "story_v_out_319741.awb")

						arg_77_1:RecordAudio("319741019", var_80_24)
						arg_77_1:RecordAudio("319741019", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319741", "319741019", "story_v_out_319741.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319741", "319741019", "story_v_out_319741.awb")
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
				actorName = "10066ui_story",
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
	Play319741020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319741020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play319741021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10066ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10066ui_story == nil then
				arg_81_1.var_.characterEffect10066ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect10066ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10066ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10066ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10066ui_story.fillRatio = var_84_5
			end

			local var_84_6 = arg_81_1.actors_["10066ui_story"].transform
			local var_84_7 = 0

			if var_84_7 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 then
				arg_81_1.var_.moveOldPos10066ui_story = var_84_6.localPosition
			end

			local var_84_8 = 0.001

			if var_84_7 <= arg_81_1.time_ and arg_81_1.time_ < var_84_7 + var_84_8 then
				local var_84_9 = (arg_81_1.time_ - var_84_7) / var_84_8
				local var_84_10 = Vector3.New(0, 100, 0)

				var_84_6.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10066ui_story, var_84_10, var_84_9)

				local var_84_11 = manager.ui.mainCamera.transform.position - var_84_6.position

				var_84_6.forward = Vector3.New(var_84_11.x, var_84_11.y, var_84_11.z)

				local var_84_12 = var_84_6.localEulerAngles

				var_84_12.z = 0
				var_84_12.x = 0
				var_84_6.localEulerAngles = var_84_12
			end

			if arg_81_1.time_ >= var_84_7 + var_84_8 and arg_81_1.time_ < var_84_7 + var_84_8 + arg_84_0 then
				var_84_6.localPosition = Vector3.New(0, 100, 0)

				local var_84_13 = manager.ui.mainCamera.transform.position - var_84_6.position

				var_84_6.forward = Vector3.New(var_84_13.x, var_84_13.y, var_84_13.z)

				local var_84_14 = var_84_6.localEulerAngles

				var_84_14.z = 0
				var_84_14.x = 0
				var_84_6.localEulerAngles = var_84_14
			end

			local var_84_15 = 0
			local var_84_16 = 1.05

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_17 = arg_81_1:GetWordFromCfg(319741020)
				local var_84_18 = arg_81_1:FormatText(var_84_17.content)

				arg_81_1.text_.text = var_84_18

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_19 = 42
				local var_84_20 = utf8.len(var_84_18)
				local var_84_21 = var_84_19 <= 0 and var_84_16 or var_84_16 * (var_84_20 / var_84_19)

				if var_84_21 > 0 and var_84_16 < var_84_21 then
					arg_81_1.talkMaxDuration = var_84_21

					if var_84_21 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_21 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_18
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_22 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_22 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_22

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_22 and arg_81_1.time_ < var_84_15 + var_84_22 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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

		arg_81_1:InitPlayNodeList()
	end,
	Play319741021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319741021
		arg_85_1.duration_ = 11.9

		local var_85_0 = {
			zh = 7.066,
			ja = 11.9
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
				arg_85_0:Play319741022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10066ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10066ui_story == nil then
				arg_85_1.var_.characterEffect10066ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect10066ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10066ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10066ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10066ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.6

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[640].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(319741021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 24
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741021", "story_v_out_319741.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_319741", "319741021", "story_v_out_319741.awb") / 1000

					if var_88_14 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_6
					end

					if var_88_9.prefab_name ~= "" and arg_85_1.actors_[var_88_9.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_9.prefab_name].transform, "story_v_out_319741", "319741021", "story_v_out_319741.awb")

						arg_85_1:RecordAudio("319741021", var_88_15)
						arg_85_1:RecordAudio("319741021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319741", "319741021", "story_v_out_319741.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319741", "319741021", "story_v_out_319741.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_16 and arg_85_1.time_ < var_88_6 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play319741022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319741022
		arg_89_1.duration_ = 12.37

		local var_89_0 = {
			zh = 11.5,
			ja = 12.366
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319741023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.1

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[640].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(319741022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 44
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741022", "story_v_out_319741.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_319741", "319741022", "story_v_out_319741.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_319741", "319741022", "story_v_out_319741.awb")

						arg_89_1:RecordAudio("319741022", var_92_9)
						arg_89_1:RecordAudio("319741022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319741", "319741022", "story_v_out_319741.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319741", "319741022", "story_v_out_319741.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319741023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319741023
		arg_93_1.duration_ = 6.17

		local var_93_0 = {
			zh = 4.966,
			ja = 6.166
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
				arg_93_0:Play319741024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.425

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[640].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(319741023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 17
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741023", "story_v_out_319741.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_319741", "319741023", "story_v_out_319741.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_319741", "319741023", "story_v_out_319741.awb")

						arg_93_1:RecordAudio("319741023", var_96_9)
						arg_93_1:RecordAudio("319741023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319741", "319741023", "story_v_out_319741.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319741", "319741023", "story_v_out_319741.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319741024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319741024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play319741025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10066ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10066ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, 100, 0)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10066ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, 100, 0)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["10066ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10066ui_story == nil then
				arg_97_1.var_.characterEffect10066ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect10066ui_story and not isNil(var_100_9) then
					local var_100_13 = Mathf.Lerp(0, 0.5, var_100_12)

					arg_97_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10066ui_story.fillRatio = var_100_13
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10066ui_story then
				local var_100_14 = 0.5

				arg_97_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10066ui_story.fillRatio = var_100_14
			end

			local var_100_15 = 0
			local var_100_16 = 0.85

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_17 = arg_97_1:GetWordFromCfg(319741024)
				local var_100_18 = arg_97_1:FormatText(var_100_17.content)

				arg_97_1.text_.text = var_100_18

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_19 = 34
				local var_100_20 = utf8.len(var_100_18)
				local var_100_21 = var_100_19 <= 0 and var_100_16 or var_100_16 * (var_100_20 / var_100_19)

				if var_100_21 > 0 and var_100_16 < var_100_21 then
					arg_97_1.talkMaxDuration = var_100_21

					if var_100_21 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_21 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_18
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_22 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_22 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_22

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_22 and arg_97_1.time_ < var_100_15 + var_100_22 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play319741025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319741025
		arg_101_1.duration_ = 4.02

		local var_101_0 = {
			zh = 3.799999999999,
			ja = 4.01600000298023
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
				arg_101_0:Play319741026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["4040ui_story"].transform
			local var_104_1 = 1.8

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos4040ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -1.55, -5.5)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos4040ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["4040ui_story"]
			local var_104_10 = 1.8

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect4040ui_story == nil then
				arg_101_1.var_.characterEffect4040ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect4040ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect4040ui_story then
				arg_101_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_104_13 = 1.8

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_104_14 = 1.8

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_104_15 = 1

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				local var_104_16 = manager.ui.mainCamera.transform.localPosition
				local var_104_17 = Vector3.New(0, 0, 10) + Vector3.New(var_104_16.x, var_104_16.y, 0)
				local var_104_18 = arg_101_1.bgs_.I11m

				var_104_18.transform.localPosition = var_104_17
				var_104_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_19 = var_104_18:GetComponent("SpriteRenderer")

				if var_104_19 and var_104_19.sprite then
					local var_104_20 = (var_104_18.transform.localPosition - var_104_16).z
					local var_104_21 = manager.ui.mainCameraCom_
					local var_104_22 = 2 * var_104_20 * Mathf.Tan(var_104_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_104_23 = var_104_22 * var_104_21.aspect
					local var_104_24 = var_104_19.sprite.bounds.size.x
					local var_104_25 = var_104_19.sprite.bounds.size.y
					local var_104_26 = var_104_23 / var_104_24
					local var_104_27 = var_104_22 / var_104_25
					local var_104_28 = var_104_27 < var_104_26 and var_104_26 or var_104_27

					var_104_18.transform.localScale = Vector3.New(var_104_28, var_104_28, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "I11m" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_29 = 0

			if var_104_29 < arg_101_1.time_ and arg_101_1.time_ <= var_104_29 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_30 = 1

			if var_104_29 <= arg_101_1.time_ and arg_101_1.time_ < var_104_29 + var_104_30 then
				local var_104_31 = (arg_101_1.time_ - var_104_29) / var_104_30
				local var_104_32 = Color.New(0, 0, 0)

				var_104_32.a = Mathf.Lerp(0, 1, var_104_31)
				arg_101_1.mask_.color = var_104_32
			end

			if arg_101_1.time_ >= var_104_29 + var_104_30 and arg_101_1.time_ < var_104_29 + var_104_30 + arg_104_0 then
				local var_104_33 = Color.New(0, 0, 0)

				var_104_33.a = 1
				arg_101_1.mask_.color = var_104_33
			end

			local var_104_34 = 1

			if var_104_34 < arg_101_1.time_ and arg_101_1.time_ <= var_104_34 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_35 = 1

			if var_104_34 <= arg_101_1.time_ and arg_101_1.time_ < var_104_34 + var_104_35 then
				local var_104_36 = (arg_101_1.time_ - var_104_34) / var_104_35
				local var_104_37 = Color.New(0, 0, 0)

				var_104_37.a = Mathf.Lerp(1, 0, var_104_36)
				arg_101_1.mask_.color = var_104_37
			end

			if arg_101_1.time_ >= var_104_34 + var_104_35 and arg_101_1.time_ < var_104_34 + var_104_35 + arg_104_0 then
				local var_104_38 = Color.New(0, 0, 0)
				local var_104_39 = 0

				arg_101_1.mask_.enabled = false
				var_104_38.a = var_104_39
				arg_101_1.mask_.color = var_104_38
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_40 = 1.85000000298023
			local var_104_41 = 0.15

			if var_104_40 < arg_101_1.time_ and arg_101_1.time_ <= var_104_40 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_42 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_42:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_43 = arg_101_1:FormatText(StoryNameCfg[668].name)

				arg_101_1.leftNameTxt_.text = var_104_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_44 = arg_101_1:GetWordFromCfg(319741025)
				local var_104_45 = arg_101_1:FormatText(var_104_44.content)

				arg_101_1.text_.text = var_104_45

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_46 = 6
				local var_104_47 = utf8.len(var_104_45)
				local var_104_48 = var_104_46 <= 0 and var_104_41 or var_104_41 * (var_104_47 / var_104_46)

				if var_104_48 > 0 and var_104_41 < var_104_48 then
					arg_101_1.talkMaxDuration = var_104_48
					var_104_40 = var_104_40 + 0.3

					if var_104_48 + var_104_40 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_48 + var_104_40
					end
				end

				arg_101_1.text_.text = var_104_45
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741025", "story_v_out_319741.awb") ~= 0 then
					local var_104_49 = manager.audio:GetVoiceLength("story_v_out_319741", "319741025", "story_v_out_319741.awb") / 1000

					if var_104_49 + var_104_40 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_49 + var_104_40
					end

					if var_104_44.prefab_name ~= "" and arg_101_1.actors_[var_104_44.prefab_name] ~= nil then
						local var_104_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_44.prefab_name].transform, "story_v_out_319741", "319741025", "story_v_out_319741.awb")

						arg_101_1:RecordAudio("319741025", var_104_50)
						arg_101_1:RecordAudio("319741025", var_104_50)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319741", "319741025", "story_v_out_319741.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319741", "319741025", "story_v_out_319741.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_51 = var_104_40 + 0.3
			local var_104_52 = math.max(var_104_41, arg_101_1.talkMaxDuration)

			if var_104_51 <= arg_101_1.time_ and arg_101_1.time_ < var_104_51 + var_104_52 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_51) / var_104_52

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_51 + var_104_52 and arg_101_1.time_ < var_104_51 + var_104_52 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play319741026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319741026
		arg_107_1.duration_ = 2

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319741027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10079ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10079ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10079ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["10079ui_story"]
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect10079ui_story == nil then
				arg_107_1.var_.characterEffect10079ui_story = var_110_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_11 = 0.200000002980232

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 and not isNil(var_110_9) then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11

				if arg_107_1.var_.characterEffect10079ui_story and not isNil(var_110_9) then
					arg_107_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect10079ui_story then
				arg_107_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_110_13 = 0

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_110_14 = 0

			if var_110_14 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_110_15 = arg_107_1.actors_["4040ui_story"].transform
			local var_110_16 = 0

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				arg_107_1.var_.moveOldPos4040ui_story = var_110_15.localPosition
			end

			local var_110_17 = 0.001

			if var_110_16 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_17 then
				local var_110_18 = (arg_107_1.time_ - var_110_16) / var_110_17
				local var_110_19 = Vector3.New(0.7, -1.55, -5.5)

				var_110_15.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos4040ui_story, var_110_19, var_110_18)

				local var_110_20 = manager.ui.mainCamera.transform.position - var_110_15.position

				var_110_15.forward = Vector3.New(var_110_20.x, var_110_20.y, var_110_20.z)

				local var_110_21 = var_110_15.localEulerAngles

				var_110_21.z = 0
				var_110_21.x = 0
				var_110_15.localEulerAngles = var_110_21
			end

			if arg_107_1.time_ >= var_110_16 + var_110_17 and arg_107_1.time_ < var_110_16 + var_110_17 + arg_110_0 then
				var_110_15.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_110_22 = manager.ui.mainCamera.transform.position - var_110_15.position

				var_110_15.forward = Vector3.New(var_110_22.x, var_110_22.y, var_110_22.z)

				local var_110_23 = var_110_15.localEulerAngles

				var_110_23.z = 0
				var_110_23.x = 0
				var_110_15.localEulerAngles = var_110_23
			end

			local var_110_24 = arg_107_1.actors_["4040ui_story"]
			local var_110_25 = 0

			if var_110_25 < arg_107_1.time_ and arg_107_1.time_ <= var_110_25 + arg_110_0 and not isNil(var_110_24) and arg_107_1.var_.characterEffect4040ui_story == nil then
				arg_107_1.var_.characterEffect4040ui_story = var_110_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_26 = 0.200000002980232

			if var_110_25 <= arg_107_1.time_ and arg_107_1.time_ < var_110_25 + var_110_26 and not isNil(var_110_24) then
				local var_110_27 = (arg_107_1.time_ - var_110_25) / var_110_26

				if arg_107_1.var_.characterEffect4040ui_story and not isNil(var_110_24) then
					local var_110_28 = Mathf.Lerp(0, 0.5, var_110_27)

					arg_107_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_107_1.var_.characterEffect4040ui_story.fillRatio = var_110_28
				end
			end

			if arg_107_1.time_ >= var_110_25 + var_110_26 and arg_107_1.time_ < var_110_25 + var_110_26 + arg_110_0 and not isNil(var_110_24) and arg_107_1.var_.characterEffect4040ui_story then
				local var_110_29 = 0.5

				arg_107_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_107_1.var_.characterEffect4040ui_story.fillRatio = var_110_29
			end

			local var_110_30 = 0
			local var_110_31 = 0.05

			if var_110_30 < arg_107_1.time_ and arg_107_1.time_ <= var_110_30 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_32 = arg_107_1:FormatText(StoryNameCfg[6].name)

				arg_107_1.leftNameTxt_.text = var_110_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_33 = arg_107_1:GetWordFromCfg(319741026)
				local var_110_34 = arg_107_1:FormatText(var_110_33.content)

				arg_107_1.text_.text = var_110_34

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_35 = 2
				local var_110_36 = utf8.len(var_110_34)
				local var_110_37 = var_110_35 <= 0 and var_110_31 or var_110_31 * (var_110_36 / var_110_35)

				if var_110_37 > 0 and var_110_31 < var_110_37 then
					arg_107_1.talkMaxDuration = var_110_37

					if var_110_37 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_37 + var_110_30
					end
				end

				arg_107_1.text_.text = var_110_34
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741026", "story_v_out_319741.awb") ~= 0 then
					local var_110_38 = manager.audio:GetVoiceLength("story_v_out_319741", "319741026", "story_v_out_319741.awb") / 1000

					if var_110_38 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_38 + var_110_30
					end

					if var_110_33.prefab_name ~= "" and arg_107_1.actors_[var_110_33.prefab_name] ~= nil then
						local var_110_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_33.prefab_name].transform, "story_v_out_319741", "319741026", "story_v_out_319741.awb")

						arg_107_1:RecordAudio("319741026", var_110_39)
						arg_107_1:RecordAudio("319741026", var_110_39)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_319741", "319741026", "story_v_out_319741.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_319741", "319741026", "story_v_out_319741.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_40 = math.max(var_110_31, arg_107_1.talkMaxDuration)

			if var_110_30 <= arg_107_1.time_ and arg_107_1.time_ < var_110_30 + var_110_40 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_30) / var_110_40

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_30 + var_110_40 and arg_107_1.time_ < var_110_30 + var_110_40 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319741027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319741027
		arg_111_1.duration_ = 3.33

		local var_111_0 = {
			zh = 3.333,
			ja = 2.9
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
				arg_111_0:Play319741028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.3

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[6].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(319741027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 12
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741027", "story_v_out_319741.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_319741", "319741027", "story_v_out_319741.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_319741", "319741027", "story_v_out_319741.awb")

						arg_111_1:RecordAudio("319741027", var_114_9)
						arg_111_1:RecordAudio("319741027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_319741", "319741027", "story_v_out_319741.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_319741", "319741027", "story_v_out_319741.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319741028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319741028
		arg_115_1.duration_ = 5.67

		local var_115_0 = {
			zh = 5.2,
			ja = 5.666
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
				arg_115_0:Play319741029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10079ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect10079ui_story == nil then
				arg_115_1.var_.characterEffect10079ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect10079ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10079ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect10079ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10079ui_story.fillRatio = var_118_5
			end

			local var_118_6 = arg_115_1.actors_["4040ui_story"]
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect4040ui_story == nil then
				arg_115_1.var_.characterEffect4040ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.200000002980232

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 and not isNil(var_118_6) then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / var_118_8

				if arg_115_1.var_.characterEffect4040ui_story and not isNil(var_118_6) then
					arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect4040ui_story then
				arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 then
				arg_115_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_118_11 = 0

			if var_118_11 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 then
				arg_115_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_118_12 = 0
			local var_118_13 = 0.425

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_14 = arg_115_1:FormatText(StoryNameCfg[668].name)

				arg_115_1.leftNameTxt_.text = var_118_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_15 = arg_115_1:GetWordFromCfg(319741028)
				local var_118_16 = arg_115_1:FormatText(var_118_15.content)

				arg_115_1.text_.text = var_118_16

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 17
				local var_118_18 = utf8.len(var_118_16)
				local var_118_19 = var_118_17 <= 0 and var_118_13 or var_118_13 * (var_118_18 / var_118_17)

				if var_118_19 > 0 and var_118_13 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19

					if var_118_19 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_16
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741028", "story_v_out_319741.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_out_319741", "319741028", "story_v_out_319741.awb") / 1000

					if var_118_20 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_12
					end

					if var_118_15.prefab_name ~= "" and arg_115_1.actors_[var_118_15.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_15.prefab_name].transform, "story_v_out_319741", "319741028", "story_v_out_319741.awb")

						arg_115_1:RecordAudio("319741028", var_118_21)
						arg_115_1:RecordAudio("319741028", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319741", "319741028", "story_v_out_319741.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319741", "319741028", "story_v_out_319741.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_22 and arg_115_1.time_ < var_118_12 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play319741029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319741029
		arg_119_1.duration_ = 5.5

		local var_119_0 = {
			zh = 4.433,
			ja = 5.5
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
				arg_119_0:Play319741030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10079ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10079ui_story == nil then
				arg_119_1.var_.characterEffect10079ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect10079ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10079ui_story then
				arg_119_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_122_4 = 0

			if var_122_4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_122_6 = arg_119_1.actors_["4040ui_story"]
			local var_122_7 = 0

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect4040ui_story == nil then
				arg_119_1.var_.characterEffect4040ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_8 = 0.200000002980232

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 and not isNil(var_122_6) then
				local var_122_9 = (arg_119_1.time_ - var_122_7) / var_122_8

				if arg_119_1.var_.characterEffect4040ui_story and not isNil(var_122_6) then
					local var_122_10 = Mathf.Lerp(0, 0.5, var_122_9)

					arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_119_1.var_.characterEffect4040ui_story.fillRatio = var_122_10
				end
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect4040ui_story then
				local var_122_11 = 0.5

				arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_119_1.var_.characterEffect4040ui_story.fillRatio = var_122_11
			end

			local var_122_12 = 0
			local var_122_13 = 0.625

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

				local var_122_15 = arg_119_1:GetWordFromCfg(319741029)
				local var_122_16 = arg_119_1:FormatText(var_122_15.content)

				arg_119_1.text_.text = var_122_16

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_17 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741029", "story_v_out_319741.awb") ~= 0 then
					local var_122_20 = manager.audio:GetVoiceLength("story_v_out_319741", "319741029", "story_v_out_319741.awb") / 1000

					if var_122_20 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_20 + var_122_12
					end

					if var_122_15.prefab_name ~= "" and arg_119_1.actors_[var_122_15.prefab_name] ~= nil then
						local var_122_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_15.prefab_name].transform, "story_v_out_319741", "319741029", "story_v_out_319741.awb")

						arg_119_1:RecordAudio("319741029", var_122_21)
						arg_119_1:RecordAudio("319741029", var_122_21)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319741", "319741029", "story_v_out_319741.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319741", "319741029", "story_v_out_319741.awb")
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
	Play319741030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319741030
		arg_123_1.duration_ = 8.77

		local var_123_0 = {
			zh = 6.033,
			ja = 8.766
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
				arg_123_0:Play319741031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10079ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10079ui_story == nil then
				arg_123_1.var_.characterEffect10079ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect10079ui_story and not isNil(var_126_0) then
					local var_126_4 = Mathf.Lerp(0, 0.5, var_126_3)

					arg_123_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10079ui_story.fillRatio = var_126_4
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10079ui_story then
				local var_126_5 = 0.5

				arg_123_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10079ui_story.fillRatio = var_126_5
			end

			local var_126_6 = arg_123_1.actors_["4040ui_story"]
			local var_126_7 = 0

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect4040ui_story == nil then
				arg_123_1.var_.characterEffect4040ui_story = var_126_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_8 = 0.200000002980232

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_8 and not isNil(var_126_6) then
				local var_126_9 = (arg_123_1.time_ - var_126_7) / var_126_8

				if arg_123_1.var_.characterEffect4040ui_story and not isNil(var_126_6) then
					arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_7 + var_126_8 and arg_123_1.time_ < var_126_7 + var_126_8 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect4040ui_story then
				arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_126_10 = 0
			local var_126_11 = 0.75

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_12 = arg_123_1:FormatText(StoryNameCfg[668].name)

				arg_123_1.leftNameTxt_.text = var_126_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_13 = arg_123_1:GetWordFromCfg(319741030)
				local var_126_14 = arg_123_1:FormatText(var_126_13.content)

				arg_123_1.text_.text = var_126_14

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_15 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741030", "story_v_out_319741.awb") ~= 0 then
					local var_126_18 = manager.audio:GetVoiceLength("story_v_out_319741", "319741030", "story_v_out_319741.awb") / 1000

					if var_126_18 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_18 + var_126_10
					end

					if var_126_13.prefab_name ~= "" and arg_123_1.actors_[var_126_13.prefab_name] ~= nil then
						local var_126_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_13.prefab_name].transform, "story_v_out_319741", "319741030", "story_v_out_319741.awb")

						arg_123_1:RecordAudio("319741030", var_126_19)
						arg_123_1:RecordAudio("319741030", var_126_19)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319741", "319741030", "story_v_out_319741.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319741", "319741030", "story_v_out_319741.awb")
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
	Play319741031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319741031
		arg_127_1.duration_ = 3.5

		local var_127_0 = {
			zh = 2.866,
			ja = 3.5
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
				arg_127_0:Play319741032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10079ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos10079ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10079ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["10079ui_story"]
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect10079ui_story == nil then
				arg_127_1.var_.characterEffect10079ui_story = var_130_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_11 = 0.200000002980232

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 and not isNil(var_130_9) then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11

				if arg_127_1.var_.characterEffect10079ui_story and not isNil(var_130_9) then
					arg_127_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect10079ui_story then
				arg_127_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_130_13 = arg_127_1.actors_["4040ui_story"]
			local var_130_14 = 0

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 and not isNil(var_130_13) and arg_127_1.var_.characterEffect4040ui_story == nil then
				arg_127_1.var_.characterEffect4040ui_story = var_130_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_15 = 0.200000002980232

			if var_130_14 <= arg_127_1.time_ and arg_127_1.time_ < var_130_14 + var_130_15 and not isNil(var_130_13) then
				local var_130_16 = (arg_127_1.time_ - var_130_14) / var_130_15

				if arg_127_1.var_.characterEffect4040ui_story and not isNil(var_130_13) then
					local var_130_17 = Mathf.Lerp(0, 0.5, var_130_16)

					arg_127_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_127_1.var_.characterEffect4040ui_story.fillRatio = var_130_17
				end
			end

			if arg_127_1.time_ >= var_130_14 + var_130_15 and arg_127_1.time_ < var_130_14 + var_130_15 + arg_130_0 and not isNil(var_130_13) and arg_127_1.var_.characterEffect4040ui_story then
				local var_130_18 = 0.5

				arg_127_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_127_1.var_.characterEffect4040ui_story.fillRatio = var_130_18
			end

			local var_130_19 = 0
			local var_130_20 = 0.35

			if var_130_19 < arg_127_1.time_ and arg_127_1.time_ <= var_130_19 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_21 = arg_127_1:FormatText(StoryNameCfg[6].name)

				arg_127_1.leftNameTxt_.text = var_130_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_22 = arg_127_1:GetWordFromCfg(319741031)
				local var_130_23 = arg_127_1:FormatText(var_130_22.content)

				arg_127_1.text_.text = var_130_23

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_24 = 14
				local var_130_25 = utf8.len(var_130_23)
				local var_130_26 = var_130_24 <= 0 and var_130_20 or var_130_20 * (var_130_25 / var_130_24)

				if var_130_26 > 0 and var_130_20 < var_130_26 then
					arg_127_1.talkMaxDuration = var_130_26

					if var_130_26 + var_130_19 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_26 + var_130_19
					end
				end

				arg_127_1.text_.text = var_130_23
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741031", "story_v_out_319741.awb") ~= 0 then
					local var_130_27 = manager.audio:GetVoiceLength("story_v_out_319741", "319741031", "story_v_out_319741.awb") / 1000

					if var_130_27 + var_130_19 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_27 + var_130_19
					end

					if var_130_22.prefab_name ~= "" and arg_127_1.actors_[var_130_22.prefab_name] ~= nil then
						local var_130_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_22.prefab_name].transform, "story_v_out_319741", "319741031", "story_v_out_319741.awb")

						arg_127_1:RecordAudio("319741031", var_130_28)
						arg_127_1:RecordAudio("319741031", var_130_28)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319741", "319741031", "story_v_out_319741.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319741", "319741031", "story_v_out_319741.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_29 = math.max(var_130_20, arg_127_1.talkMaxDuration)

			if var_130_19 <= arg_127_1.time_ and arg_127_1.time_ < var_130_19 + var_130_29 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_19) / var_130_29

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_19 + var_130_29 and arg_127_1.time_ < var_130_19 + var_130_29 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play319741032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319741032
		arg_131_1.duration_ = 2.67

		local var_131_0 = {
			zh = 2.666,
			ja = 2
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
				arg_131_0:Play319741033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["4040ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos4040ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0.7, -1.55, -5.5)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos4040ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["4040ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect4040ui_story == nil then
				arg_131_1.var_.characterEffect4040ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect4040ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect4040ui_story then
				arg_131_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_134_13 = arg_131_1.actors_["10079ui_story"]
			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 and not isNil(var_134_13) and arg_131_1.var_.characterEffect10079ui_story == nil then
				arg_131_1.var_.characterEffect10079ui_story = var_134_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_15 = 0.200000002980232

			if var_134_14 <= arg_131_1.time_ and arg_131_1.time_ < var_134_14 + var_134_15 and not isNil(var_134_13) then
				local var_134_16 = (arg_131_1.time_ - var_134_14) / var_134_15

				if arg_131_1.var_.characterEffect10079ui_story and not isNil(var_134_13) then
					local var_134_17 = Mathf.Lerp(0, 0.5, var_134_16)

					arg_131_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10079ui_story.fillRatio = var_134_17
				end
			end

			if arg_131_1.time_ >= var_134_14 + var_134_15 and arg_131_1.time_ < var_134_14 + var_134_15 + arg_134_0 and not isNil(var_134_13) and arg_131_1.var_.characterEffect10079ui_story then
				local var_134_18 = 0.5

				arg_131_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10079ui_story.fillRatio = var_134_18
			end

			local var_134_19 = 0

			if var_134_19 < arg_131_1.time_ and arg_131_1.time_ <= var_134_19 + arg_134_0 then
				arg_131_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_134_20 = 0

			if var_134_20 < arg_131_1.time_ and arg_131_1.time_ <= var_134_20 + arg_134_0 then
				arg_131_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_134_21 = 0
			local var_134_22 = 0.225

			if var_134_21 < arg_131_1.time_ and arg_131_1.time_ <= var_134_21 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_23 = arg_131_1:FormatText(StoryNameCfg[668].name)

				arg_131_1.leftNameTxt_.text = var_134_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_24 = arg_131_1:GetWordFromCfg(319741032)
				local var_134_25 = arg_131_1:FormatText(var_134_24.content)

				arg_131_1.text_.text = var_134_25

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_26 = 9
				local var_134_27 = utf8.len(var_134_25)
				local var_134_28 = var_134_26 <= 0 and var_134_22 or var_134_22 * (var_134_27 / var_134_26)

				if var_134_28 > 0 and var_134_22 < var_134_28 then
					arg_131_1.talkMaxDuration = var_134_28

					if var_134_28 + var_134_21 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_28 + var_134_21
					end
				end

				arg_131_1.text_.text = var_134_25
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741032", "story_v_out_319741.awb") ~= 0 then
					local var_134_29 = manager.audio:GetVoiceLength("story_v_out_319741", "319741032", "story_v_out_319741.awb") / 1000

					if var_134_29 + var_134_21 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_29 + var_134_21
					end

					if var_134_24.prefab_name ~= "" and arg_131_1.actors_[var_134_24.prefab_name] ~= nil then
						local var_134_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_24.prefab_name].transform, "story_v_out_319741", "319741032", "story_v_out_319741.awb")

						arg_131_1:RecordAudio("319741032", var_134_30)
						arg_131_1:RecordAudio("319741032", var_134_30)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319741", "319741032", "story_v_out_319741.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319741", "319741032", "story_v_out_319741.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_31 = math.max(var_134_22, arg_131_1.talkMaxDuration)

			if var_134_21 <= arg_131_1.time_ and arg_131_1.time_ < var_134_21 + var_134_31 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_21) / var_134_31

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_21 + var_134_31 and arg_131_1.time_ < var_134_21 + var_134_31 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play319741033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319741033
		arg_135_1.duration_ = 3.47

		local var_135_0 = {
			zh = 3.3,
			ja = 3.466
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
				arg_135_0:Play319741034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["4040ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect4040ui_story == nil then
				arg_135_1.var_.characterEffect4040ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect4040ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_135_1.var_.characterEffect4040ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect4040ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_135_1.var_.characterEffect4040ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 then
				arg_135_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_138_8 = arg_135_1.actors_["10079ui_story"]
			local var_138_9 = 0

			if var_138_9 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.characterEffect10079ui_story == nil then
				arg_135_1.var_.characterEffect10079ui_story = var_138_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_10 = 0.200000002980232

			if var_138_9 <= arg_135_1.time_ and arg_135_1.time_ < var_138_9 + var_138_10 and not isNil(var_138_8) then
				local var_138_11 = (arg_135_1.time_ - var_138_9) / var_138_10

				if arg_135_1.var_.characterEffect10079ui_story and not isNil(var_138_8) then
					arg_135_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_9 + var_138_10 and arg_135_1.time_ < var_138_9 + var_138_10 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.characterEffect10079ui_story then
				arg_135_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_138_12 = 0
			local var_138_13 = 0.4

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_14 = arg_135_1:FormatText(StoryNameCfg[6].name)

				arg_135_1.leftNameTxt_.text = var_138_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_15 = arg_135_1:GetWordFromCfg(319741033)
				local var_138_16 = arg_135_1:FormatText(var_138_15.content)

				arg_135_1.text_.text = var_138_16

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 16
				local var_138_18 = utf8.len(var_138_16)
				local var_138_19 = var_138_17 <= 0 and var_138_13 or var_138_13 * (var_138_18 / var_138_17)

				if var_138_19 > 0 and var_138_13 < var_138_19 then
					arg_135_1.talkMaxDuration = var_138_19

					if var_138_19 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_16
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741033", "story_v_out_319741.awb") ~= 0 then
					local var_138_20 = manager.audio:GetVoiceLength("story_v_out_319741", "319741033", "story_v_out_319741.awb") / 1000

					if var_138_20 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_12
					end

					if var_138_15.prefab_name ~= "" and arg_135_1.actors_[var_138_15.prefab_name] ~= nil then
						local var_138_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_15.prefab_name].transform, "story_v_out_319741", "319741033", "story_v_out_319741.awb")

						arg_135_1:RecordAudio("319741033", var_138_21)
						arg_135_1:RecordAudio("319741033", var_138_21)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319741", "319741033", "story_v_out_319741.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319741", "319741033", "story_v_out_319741.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_22 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_22 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_22

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_22 and arg_135_1.time_ < var_138_12 + var_138_22 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play319741034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319741034
		arg_139_1.duration_ = 15.57

		local var_139_0 = {
			zh = 10.433,
			ja = 15.566
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
				arg_139_0:Play319741035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 1.425

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[6].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(319741034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 57
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741034", "story_v_out_319741.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_319741", "319741034", "story_v_out_319741.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_319741", "319741034", "story_v_out_319741.awb")

						arg_139_1:RecordAudio("319741034", var_142_9)
						arg_139_1:RecordAudio("319741034", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319741", "319741034", "story_v_out_319741.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319741", "319741034", "story_v_out_319741.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play319741035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319741035
		arg_143_1.duration_ = 4.2

		local var_143_0 = {
			zh = 3.533,
			ja = 4.2
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
				arg_143_0:Play319741036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10079ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10079ui_story == nil then
				arg_143_1.var_.characterEffect10079ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect10079ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10079ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10079ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10079ui_story.fillRatio = var_146_5
			end

			local var_146_6 = arg_143_1.actors_["4040ui_story"]
			local var_146_7 = 0

			if var_146_7 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect4040ui_story == nil then
				arg_143_1.var_.characterEffect4040ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_8 = 0.200000002980232

			if var_146_7 <= arg_143_1.time_ and arg_143_1.time_ < var_146_7 + var_146_8 and not isNil(var_146_6) then
				local var_146_9 = (arg_143_1.time_ - var_146_7) / var_146_8

				if arg_143_1.var_.characterEffect4040ui_story and not isNil(var_146_6) then
					arg_143_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_7 + var_146_8 and arg_143_1.time_ < var_146_7 + var_146_8 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect4040ui_story then
				arg_143_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action7_1")
			end

			local var_146_11 = 0

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_146_12 = 0
			local var_146_13 = 0.325

			if var_146_12 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_14 = arg_143_1:FormatText(StoryNameCfg[668].name)

				arg_143_1.leftNameTxt_.text = var_146_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_15 = arg_143_1:GetWordFromCfg(319741035)
				local var_146_16 = arg_143_1:FormatText(var_146_15.content)

				arg_143_1.text_.text = var_146_16

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_17 = 13
				local var_146_18 = utf8.len(var_146_16)
				local var_146_19 = var_146_17 <= 0 and var_146_13 or var_146_13 * (var_146_18 / var_146_17)

				if var_146_19 > 0 and var_146_13 < var_146_19 then
					arg_143_1.talkMaxDuration = var_146_19

					if var_146_19 + var_146_12 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_19 + var_146_12
					end
				end

				arg_143_1.text_.text = var_146_16
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741035", "story_v_out_319741.awb") ~= 0 then
					local var_146_20 = manager.audio:GetVoiceLength("story_v_out_319741", "319741035", "story_v_out_319741.awb") / 1000

					if var_146_20 + var_146_12 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_20 + var_146_12
					end

					if var_146_15.prefab_name ~= "" and arg_143_1.actors_[var_146_15.prefab_name] ~= nil then
						local var_146_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_15.prefab_name].transform, "story_v_out_319741", "319741035", "story_v_out_319741.awb")

						arg_143_1:RecordAudio("319741035", var_146_21)
						arg_143_1:RecordAudio("319741035", var_146_21)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319741", "319741035", "story_v_out_319741.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319741", "319741035", "story_v_out_319741.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_22 = math.max(var_146_13, arg_143_1.talkMaxDuration)

			if var_146_12 <= arg_143_1.time_ and arg_143_1.time_ < var_146_12 + var_146_22 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_12) / var_146_22

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_12 + var_146_22 and arg_143_1.time_ < var_146_12 + var_146_22 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play319741036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319741036
		arg_147_1.duration_ = 4.07

		local var_147_0 = {
			zh = 3,
			ja = 4.066
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play319741037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["4040ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect4040ui_story == nil then
				arg_147_1.var_.characterEffect4040ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect4040ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_147_1.var_.characterEffect4040ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect4040ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_147_1.var_.characterEffect4040ui_story.fillRatio = var_150_5
			end

			local var_150_6 = arg_147_1.actors_["10079ui_story"]
			local var_150_7 = 0

			if var_150_7 < arg_147_1.time_ and arg_147_1.time_ <= var_150_7 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect10079ui_story == nil then
				arg_147_1.var_.characterEffect10079ui_story = var_150_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_8 = 0.200000002980232

			if var_150_7 <= arg_147_1.time_ and arg_147_1.time_ < var_150_7 + var_150_8 and not isNil(var_150_6) then
				local var_150_9 = (arg_147_1.time_ - var_150_7) / var_150_8

				if arg_147_1.var_.characterEffect10079ui_story and not isNil(var_150_6) then
					arg_147_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_7 + var_150_8 and arg_147_1.time_ < var_150_7 + var_150_8 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect10079ui_story then
				arg_147_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_150_10 = 0
			local var_150_11 = 0.325

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_12 = arg_147_1:FormatText(StoryNameCfg[6].name)

				arg_147_1.leftNameTxt_.text = var_150_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_13 = arg_147_1:GetWordFromCfg(319741036)
				local var_150_14 = arg_147_1:FormatText(var_150_13.content)

				arg_147_1.text_.text = var_150_14

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_15 = 13
				local var_150_16 = utf8.len(var_150_14)
				local var_150_17 = var_150_15 <= 0 and var_150_11 or var_150_11 * (var_150_16 / var_150_15)

				if var_150_17 > 0 and var_150_11 < var_150_17 then
					arg_147_1.talkMaxDuration = var_150_17

					if var_150_17 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_17 + var_150_10
					end
				end

				arg_147_1.text_.text = var_150_14
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741036", "story_v_out_319741.awb") ~= 0 then
					local var_150_18 = manager.audio:GetVoiceLength("story_v_out_319741", "319741036", "story_v_out_319741.awb") / 1000

					if var_150_18 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_18 + var_150_10
					end

					if var_150_13.prefab_name ~= "" and arg_147_1.actors_[var_150_13.prefab_name] ~= nil then
						local var_150_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_13.prefab_name].transform, "story_v_out_319741", "319741036", "story_v_out_319741.awb")

						arg_147_1:RecordAudio("319741036", var_150_19)
						arg_147_1:RecordAudio("319741036", var_150_19)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319741", "319741036", "story_v_out_319741.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319741", "319741036", "story_v_out_319741.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_20 = math.max(var_150_11, arg_147_1.talkMaxDuration)

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_20 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_10) / var_150_20

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_10 + var_150_20 and arg_147_1.time_ < var_150_10 + var_150_20 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319741037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319741037
		arg_151_1.duration_ = 1.8

		local var_151_0 = {
			zh = 1.8,
			ja = 1.666
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
				arg_151_0:Play319741038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10079ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10079ui_story == nil then
				arg_151_1.var_.characterEffect10079ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10079ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10079ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10079ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10079ui_story.fillRatio = var_154_5
			end

			local var_154_6 = arg_151_1.actors_["4040ui_story"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect4040ui_story == nil then
				arg_151_1.var_.characterEffect4040ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.200000002980232

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 and not isNil(var_154_6) then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8

				if arg_151_1.var_.characterEffect4040ui_story and not isNil(var_154_6) then
					arg_151_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect4040ui_story then
				arg_151_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_154_10 = 0
			local var_154_11 = 0.15

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_12 = arg_151_1:FormatText(StoryNameCfg[668].name)

				arg_151_1.leftNameTxt_.text = var_154_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_13 = arg_151_1:GetWordFromCfg(319741037)
				local var_154_14 = arg_151_1:FormatText(var_154_13.content)

				arg_151_1.text_.text = var_154_14

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_15 = 6
				local var_154_16 = utf8.len(var_154_14)
				local var_154_17 = var_154_15 <= 0 and var_154_11 or var_154_11 * (var_154_16 / var_154_15)

				if var_154_17 > 0 and var_154_11 < var_154_17 then
					arg_151_1.talkMaxDuration = var_154_17

					if var_154_17 + var_154_10 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_17 + var_154_10
					end
				end

				arg_151_1.text_.text = var_154_14
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741037", "story_v_out_319741.awb") ~= 0 then
					local var_154_18 = manager.audio:GetVoiceLength("story_v_out_319741", "319741037", "story_v_out_319741.awb") / 1000

					if var_154_18 + var_154_10 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_18 + var_154_10
					end

					if var_154_13.prefab_name ~= "" and arg_151_1.actors_[var_154_13.prefab_name] ~= nil then
						local var_154_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_13.prefab_name].transform, "story_v_out_319741", "319741037", "story_v_out_319741.awb")

						arg_151_1:RecordAudio("319741037", var_154_19)
						arg_151_1:RecordAudio("319741037", var_154_19)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319741", "319741037", "story_v_out_319741.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319741", "319741037", "story_v_out_319741.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_20 = math.max(var_154_11, arg_151_1.talkMaxDuration)

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_20 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_10) / var_154_20

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_10 + var_154_20 and arg_151_1.time_ < var_154_10 + var_154_20 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319741038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319741038
		arg_155_1.duration_ = 8.33

		local var_155_0 = {
			zh = 5.733,
			ja = 8.333
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
				arg_155_0:Play319741039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10079ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10079ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10079ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = 0

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				arg_155_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_158_11 = arg_155_1.actors_["4040ui_story"]
			local var_158_12 = 0

			if var_158_12 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 and not isNil(var_158_11) and arg_155_1.var_.characterEffect4040ui_story == nil then
				arg_155_1.var_.characterEffect4040ui_story = var_158_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_13 = 0.200000002980232

			if var_158_12 <= arg_155_1.time_ and arg_155_1.time_ < var_158_12 + var_158_13 and not isNil(var_158_11) then
				local var_158_14 = (arg_155_1.time_ - var_158_12) / var_158_13

				if arg_155_1.var_.characterEffect4040ui_story and not isNil(var_158_11) then
					local var_158_15 = Mathf.Lerp(0, 0.5, var_158_14)

					arg_155_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_155_1.var_.characterEffect4040ui_story.fillRatio = var_158_15
				end
			end

			if arg_155_1.time_ >= var_158_12 + var_158_13 and arg_155_1.time_ < var_158_12 + var_158_13 + arg_158_0 and not isNil(var_158_11) and arg_155_1.var_.characterEffect4040ui_story then
				local var_158_16 = 0.5

				arg_155_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_155_1.var_.characterEffect4040ui_story.fillRatio = var_158_16
			end

			local var_158_17 = arg_155_1.actors_["10079ui_story"]
			local var_158_18 = 0

			if var_158_18 < arg_155_1.time_ and arg_155_1.time_ <= var_158_18 + arg_158_0 and not isNil(var_158_17) and arg_155_1.var_.characterEffect10079ui_story == nil then
				arg_155_1.var_.characterEffect10079ui_story = var_158_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_19 = 0.200000002980232

			if var_158_18 <= arg_155_1.time_ and arg_155_1.time_ < var_158_18 + var_158_19 and not isNil(var_158_17) then
				local var_158_20 = (arg_155_1.time_ - var_158_18) / var_158_19

				if arg_155_1.var_.characterEffect10079ui_story and not isNil(var_158_17) then
					arg_155_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_18 + var_158_19 and arg_155_1.time_ < var_158_18 + var_158_19 + arg_158_0 and not isNil(var_158_17) and arg_155_1.var_.characterEffect10079ui_story then
				arg_155_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_158_21 = 0
			local var_158_22 = 0.7

			if var_158_21 < arg_155_1.time_ and arg_155_1.time_ <= var_158_21 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_23 = arg_155_1:FormatText(StoryNameCfg[6].name)

				arg_155_1.leftNameTxt_.text = var_158_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_24 = arg_155_1:GetWordFromCfg(319741038)
				local var_158_25 = arg_155_1:FormatText(var_158_24.content)

				arg_155_1.text_.text = var_158_25

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_26 = 28
				local var_158_27 = utf8.len(var_158_25)
				local var_158_28 = var_158_26 <= 0 and var_158_22 or var_158_22 * (var_158_27 / var_158_26)

				if var_158_28 > 0 and var_158_22 < var_158_28 then
					arg_155_1.talkMaxDuration = var_158_28

					if var_158_28 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_28 + var_158_21
					end
				end

				arg_155_1.text_.text = var_158_25
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741038", "story_v_out_319741.awb") ~= 0 then
					local var_158_29 = manager.audio:GetVoiceLength("story_v_out_319741", "319741038", "story_v_out_319741.awb") / 1000

					if var_158_29 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_29 + var_158_21
					end

					if var_158_24.prefab_name ~= "" and arg_155_1.actors_[var_158_24.prefab_name] ~= nil then
						local var_158_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_24.prefab_name].transform, "story_v_out_319741", "319741038", "story_v_out_319741.awb")

						arg_155_1:RecordAudio("319741038", var_158_30)
						arg_155_1:RecordAudio("319741038", var_158_30)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319741", "319741038", "story_v_out_319741.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319741", "319741038", "story_v_out_319741.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_31 = math.max(var_158_22, arg_155_1.talkMaxDuration)

			if var_158_21 <= arg_155_1.time_ and arg_155_1.time_ < var_158_21 + var_158_31 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_21) / var_158_31

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_21 + var_158_31 and arg_155_1.time_ < var_158_21 + var_158_31 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319741039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319741039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play319741040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10079ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10079ui_story == nil then
				arg_159_1.var_.characterEffect10079ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect10079ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10079ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10079ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10079ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_162_7 = 0

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action7_2")
			end

			local var_162_8 = 0
			local var_162_9 = 1.725

			if var_162_8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(319741039)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_12 = 69
				local var_162_13 = utf8.len(var_162_11)
				local var_162_14 = var_162_12 <= 0 and var_162_9 or var_162_9 * (var_162_13 / var_162_12)

				if var_162_14 > 0 and var_162_9 < var_162_14 then
					arg_159_1.talkMaxDuration = var_162_14

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_15 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_15 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_15

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_15 and arg_159_1.time_ < var_162_8 + var_162_15 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play319741040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319741040
		arg_163_1.duration_ = 5.13

		local var_163_0 = {
			zh = 5.133,
			ja = 4.266
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
				arg_163_0:Play319741041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["4040ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos4040ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0.7, -1.55, -5.5)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos4040ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = arg_163_1.actors_["4040ui_story"]
			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect4040ui_story == nil then
				arg_163_1.var_.characterEffect4040ui_story = var_166_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_11 = 0.200000002980232

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 and not isNil(var_166_9) then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11

				if arg_163_1.var_.characterEffect4040ui_story and not isNil(var_166_9) then
					arg_163_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect4040ui_story then
				arg_163_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_166_13 = 0

			if var_166_13 < arg_163_1.time_ and arg_163_1.time_ <= var_166_13 + arg_166_0 then
				arg_163_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_166_14 = 0
			local var_166_15 = 0.6

			if var_166_14 < arg_163_1.time_ and arg_163_1.time_ <= var_166_14 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_16 = arg_163_1:FormatText(StoryNameCfg[668].name)

				arg_163_1.leftNameTxt_.text = var_166_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_17 = arg_163_1:GetWordFromCfg(319741040)
				local var_166_18 = arg_163_1:FormatText(var_166_17.content)

				arg_163_1.text_.text = var_166_18

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_19 = 24
				local var_166_20 = utf8.len(var_166_18)
				local var_166_21 = var_166_19 <= 0 and var_166_15 or var_166_15 * (var_166_20 / var_166_19)

				if var_166_21 > 0 and var_166_15 < var_166_21 then
					arg_163_1.talkMaxDuration = var_166_21

					if var_166_21 + var_166_14 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_21 + var_166_14
					end
				end

				arg_163_1.text_.text = var_166_18
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741040", "story_v_out_319741.awb") ~= 0 then
					local var_166_22 = manager.audio:GetVoiceLength("story_v_out_319741", "319741040", "story_v_out_319741.awb") / 1000

					if var_166_22 + var_166_14 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_14
					end

					if var_166_17.prefab_name ~= "" and arg_163_1.actors_[var_166_17.prefab_name] ~= nil then
						local var_166_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_17.prefab_name].transform, "story_v_out_319741", "319741040", "story_v_out_319741.awb")

						arg_163_1:RecordAudio("319741040", var_166_23)
						arg_163_1:RecordAudio("319741040", var_166_23)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319741", "319741040", "story_v_out_319741.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319741", "319741040", "story_v_out_319741.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_24 = math.max(var_166_15, arg_163_1.talkMaxDuration)

			if var_166_14 <= arg_163_1.time_ and arg_163_1.time_ < var_166_14 + var_166_24 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_14) / var_166_24

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_14 + var_166_24 and arg_163_1.time_ < var_166_14 + var_166_24 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319741041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319741041
		arg_167_1.duration_ = 12.03

		local var_167_0 = {
			zh = 8.733,
			ja = 12.033
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
				arg_167_0:Play319741042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1.05

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[668].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(319741041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 42
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741041", "story_v_out_319741.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_319741", "319741041", "story_v_out_319741.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_319741", "319741041", "story_v_out_319741.awb")

						arg_167_1:RecordAudio("319741041", var_170_9)
						arg_167_1:RecordAudio("319741041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_319741", "319741041", "story_v_out_319741.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_319741", "319741041", "story_v_out_319741.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play319741042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319741042
		arg_171_1.duration_ = 10.63

		local var_171_0 = {
			zh = 2.9,
			ja = 10.633
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
				arg_171_0:Play319741043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["4040ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect4040ui_story == nil then
				arg_171_1.var_.characterEffect4040ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect4040ui_story and not isNil(var_174_0) then
					local var_174_4 = Mathf.Lerp(0, 0.5, var_174_3)

					arg_171_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_171_1.var_.characterEffect4040ui_story.fillRatio = var_174_4
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect4040ui_story then
				local var_174_5 = 0.5

				arg_171_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_171_1.var_.characterEffect4040ui_story.fillRatio = var_174_5
			end

			local var_174_6 = arg_171_1.actors_["10079ui_story"]
			local var_174_7 = 0

			if var_174_7 < arg_171_1.time_ and arg_171_1.time_ <= var_174_7 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect10079ui_story == nil then
				arg_171_1.var_.characterEffect10079ui_story = var_174_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_8 = 0.200000002980232

			if var_174_7 <= arg_171_1.time_ and arg_171_1.time_ < var_174_7 + var_174_8 and not isNil(var_174_6) then
				local var_174_9 = (arg_171_1.time_ - var_174_7) / var_174_8

				if arg_171_1.var_.characterEffect10079ui_story and not isNil(var_174_6) then
					arg_171_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_7 + var_174_8 and arg_171_1.time_ < var_174_7 + var_174_8 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect10079ui_story then
				arg_171_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_174_10 = 0
			local var_174_11 = 0.35

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_12 = arg_171_1:FormatText(StoryNameCfg[6].name)

				arg_171_1.leftNameTxt_.text = var_174_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_13 = arg_171_1:GetWordFromCfg(319741042)
				local var_174_14 = arg_171_1:FormatText(var_174_13.content)

				arg_171_1.text_.text = var_174_14

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_15 = 14
				local var_174_16 = utf8.len(var_174_14)
				local var_174_17 = var_174_15 <= 0 and var_174_11 or var_174_11 * (var_174_16 / var_174_15)

				if var_174_17 > 0 and var_174_11 < var_174_17 then
					arg_171_1.talkMaxDuration = var_174_17

					if var_174_17 + var_174_10 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_17 + var_174_10
					end
				end

				arg_171_1.text_.text = var_174_14
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741042", "story_v_out_319741.awb") ~= 0 then
					local var_174_18 = manager.audio:GetVoiceLength("story_v_out_319741", "319741042", "story_v_out_319741.awb") / 1000

					if var_174_18 + var_174_10 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_18 + var_174_10
					end

					if var_174_13.prefab_name ~= "" and arg_171_1.actors_[var_174_13.prefab_name] ~= nil then
						local var_174_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_13.prefab_name].transform, "story_v_out_319741", "319741042", "story_v_out_319741.awb")

						arg_171_1:RecordAudio("319741042", var_174_19)
						arg_171_1:RecordAudio("319741042", var_174_19)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_319741", "319741042", "story_v_out_319741.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_319741", "319741042", "story_v_out_319741.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_20 = math.max(var_174_11, arg_171_1.talkMaxDuration)

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_20 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_10) / var_174_20

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_10 + var_174_20 and arg_171_1.time_ < var_174_10 + var_174_20 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play319741043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319741043
		arg_175_1.duration_ = 6.17

		local var_175_0 = {
			zh = 5.366,
			ja = 6.166
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
				arg_175_0:Play319741044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10079ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10079ui_story == nil then
				arg_175_1.var_.characterEffect10079ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect10079ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10079ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10079ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10079ui_story.fillRatio = var_178_5
			end

			local var_178_6 = arg_175_1.actors_["4040ui_story"]
			local var_178_7 = 0

			if var_178_7 < arg_175_1.time_ and arg_175_1.time_ <= var_178_7 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect4040ui_story == nil then
				arg_175_1.var_.characterEffect4040ui_story = var_178_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_8 = 0.200000002980232

			if var_178_7 <= arg_175_1.time_ and arg_175_1.time_ < var_178_7 + var_178_8 and not isNil(var_178_6) then
				local var_178_9 = (arg_175_1.time_ - var_178_7) / var_178_8

				if arg_175_1.var_.characterEffect4040ui_story and not isNil(var_178_6) then
					arg_175_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_7 + var_178_8 and arg_175_1.time_ < var_178_7 + var_178_8 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect4040ui_story then
				arg_175_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_178_11 = 0

			if var_178_11 < arg_175_1.time_ and arg_175_1.time_ <= var_178_11 + arg_178_0 then
				arg_175_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_178_12 = 0
			local var_178_13 = 0.325

			if var_178_12 < arg_175_1.time_ and arg_175_1.time_ <= var_178_12 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_14 = arg_175_1:FormatText(StoryNameCfg[668].name)

				arg_175_1.leftNameTxt_.text = var_178_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_15 = arg_175_1:GetWordFromCfg(319741043)
				local var_178_16 = arg_175_1:FormatText(var_178_15.content)

				arg_175_1.text_.text = var_178_16

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_17 = 13
				local var_178_18 = utf8.len(var_178_16)
				local var_178_19 = var_178_17 <= 0 and var_178_13 or var_178_13 * (var_178_18 / var_178_17)

				if var_178_19 > 0 and var_178_13 < var_178_19 then
					arg_175_1.talkMaxDuration = var_178_19

					if var_178_19 + var_178_12 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_19 + var_178_12
					end
				end

				arg_175_1.text_.text = var_178_16
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741043", "story_v_out_319741.awb") ~= 0 then
					local var_178_20 = manager.audio:GetVoiceLength("story_v_out_319741", "319741043", "story_v_out_319741.awb") / 1000

					if var_178_20 + var_178_12 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_20 + var_178_12
					end

					if var_178_15.prefab_name ~= "" and arg_175_1.actors_[var_178_15.prefab_name] ~= nil then
						local var_178_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_15.prefab_name].transform, "story_v_out_319741", "319741043", "story_v_out_319741.awb")

						arg_175_1:RecordAudio("319741043", var_178_21)
						arg_175_1:RecordAudio("319741043", var_178_21)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_319741", "319741043", "story_v_out_319741.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_319741", "319741043", "story_v_out_319741.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_22 = math.max(var_178_13, arg_175_1.talkMaxDuration)

			if var_178_12 <= arg_175_1.time_ and arg_175_1.time_ < var_178_12 + var_178_22 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_12) / var_178_22

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_12 + var_178_22 and arg_175_1.time_ < var_178_12 + var_178_22 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play319741044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319741044
		arg_179_1.duration_ = 10.53

		local var_179_0 = {
			zh = 3.7,
			ja = 10.533
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play319741045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_182_1 = arg_179_1.actors_["4040ui_story"]
			local var_182_2 = 0

			if var_182_2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect4040ui_story == nil then
				arg_179_1.var_.characterEffect4040ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_3 = 0.200000002980232

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_3 and not isNil(var_182_1) then
				local var_182_4 = (arg_179_1.time_ - var_182_2) / var_182_3

				if arg_179_1.var_.characterEffect4040ui_story and not isNil(var_182_1) then
					local var_182_5 = Mathf.Lerp(0, 0.5, var_182_4)

					arg_179_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_179_1.var_.characterEffect4040ui_story.fillRatio = var_182_5
				end
			end

			if arg_179_1.time_ >= var_182_2 + var_182_3 and arg_179_1.time_ < var_182_2 + var_182_3 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect4040ui_story then
				local var_182_6 = 0.5

				arg_179_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_179_1.var_.characterEffect4040ui_story.fillRatio = var_182_6
			end

			local var_182_7 = arg_179_1.actors_["10079ui_story"]
			local var_182_8 = 0

			if var_182_8 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 and not isNil(var_182_7) and arg_179_1.var_.characterEffect10079ui_story == nil then
				arg_179_1.var_.characterEffect10079ui_story = var_182_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_9 = 0.200000002980232

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_9 and not isNil(var_182_7) then
				local var_182_10 = (arg_179_1.time_ - var_182_8) / var_182_9

				if arg_179_1.var_.characterEffect10079ui_story and not isNil(var_182_7) then
					arg_179_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_8 + var_182_9 and arg_179_1.time_ < var_182_8 + var_182_9 + arg_182_0 and not isNil(var_182_7) and arg_179_1.var_.characterEffect10079ui_story then
				arg_179_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_182_11 = 0
			local var_182_12 = 0.475

			if var_182_11 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_13 = arg_179_1:FormatText(StoryNameCfg[6].name)

				arg_179_1.leftNameTxt_.text = var_182_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_14 = arg_179_1:GetWordFromCfg(319741044)
				local var_182_15 = arg_179_1:FormatText(var_182_14.content)

				arg_179_1.text_.text = var_182_15

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_16 = 19
				local var_182_17 = utf8.len(var_182_15)
				local var_182_18 = var_182_16 <= 0 and var_182_12 or var_182_12 * (var_182_17 / var_182_16)

				if var_182_18 > 0 and var_182_12 < var_182_18 then
					arg_179_1.talkMaxDuration = var_182_18

					if var_182_18 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_18 + var_182_11
					end
				end

				arg_179_1.text_.text = var_182_15
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741044", "story_v_out_319741.awb") ~= 0 then
					local var_182_19 = manager.audio:GetVoiceLength("story_v_out_319741", "319741044", "story_v_out_319741.awb") / 1000

					if var_182_19 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_19 + var_182_11
					end

					if var_182_14.prefab_name ~= "" and arg_179_1.actors_[var_182_14.prefab_name] ~= nil then
						local var_182_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_14.prefab_name].transform, "story_v_out_319741", "319741044", "story_v_out_319741.awb")

						arg_179_1:RecordAudio("319741044", var_182_20)
						arg_179_1:RecordAudio("319741044", var_182_20)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_319741", "319741044", "story_v_out_319741.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_319741", "319741044", "story_v_out_319741.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_21 = math.max(var_182_12, arg_179_1.talkMaxDuration)

			if var_182_11 <= arg_179_1.time_ and arg_179_1.time_ < var_182_11 + var_182_21 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_11) / var_182_21

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_11 + var_182_21 and arg_179_1.time_ < var_182_11 + var_182_21 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play319741045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319741045
		arg_183_1.duration_ = 3.47

		local var_183_0 = {
			zh = 3.466,
			ja = 3.266
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
				arg_183_0:Play319741046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["4040ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect4040ui_story == nil then
				arg_183_1.var_.characterEffect4040ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect4040ui_story and not isNil(var_186_0) then
					arg_183_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect4040ui_story then
				arg_183_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_186_4 = arg_183_1.actors_["10079ui_story"]
			local var_186_5 = 0

			if var_186_5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect10079ui_story == nil then
				arg_183_1.var_.characterEffect10079ui_story = var_186_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_6 = 0.200000002980232

			if var_186_5 <= arg_183_1.time_ and arg_183_1.time_ < var_186_5 + var_186_6 and not isNil(var_186_4) then
				local var_186_7 = (arg_183_1.time_ - var_186_5) / var_186_6

				if arg_183_1.var_.characterEffect10079ui_story and not isNil(var_186_4) then
					local var_186_8 = Mathf.Lerp(0, 0.5, var_186_7)

					arg_183_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_183_1.var_.characterEffect10079ui_story.fillRatio = var_186_8
				end
			end

			if arg_183_1.time_ >= var_186_5 + var_186_6 and arg_183_1.time_ < var_186_5 + var_186_6 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect10079ui_story then
				local var_186_9 = 0.5

				arg_183_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_183_1.var_.characterEffect10079ui_story.fillRatio = var_186_9
			end

			local var_186_10 = 0
			local var_186_11 = 0.4

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_12 = arg_183_1:FormatText(StoryNameCfg[668].name)

				arg_183_1.leftNameTxt_.text = var_186_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_13 = arg_183_1:GetWordFromCfg(319741045)
				local var_186_14 = arg_183_1:FormatText(var_186_13.content)

				arg_183_1.text_.text = var_186_14

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_15 = 16
				local var_186_16 = utf8.len(var_186_14)
				local var_186_17 = var_186_15 <= 0 and var_186_11 or var_186_11 * (var_186_16 / var_186_15)

				if var_186_17 > 0 and var_186_11 < var_186_17 then
					arg_183_1.talkMaxDuration = var_186_17

					if var_186_17 + var_186_10 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_17 + var_186_10
					end
				end

				arg_183_1.text_.text = var_186_14
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741045", "story_v_out_319741.awb") ~= 0 then
					local var_186_18 = manager.audio:GetVoiceLength("story_v_out_319741", "319741045", "story_v_out_319741.awb") / 1000

					if var_186_18 + var_186_10 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_18 + var_186_10
					end

					if var_186_13.prefab_name ~= "" and arg_183_1.actors_[var_186_13.prefab_name] ~= nil then
						local var_186_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_13.prefab_name].transform, "story_v_out_319741", "319741045", "story_v_out_319741.awb")

						arg_183_1:RecordAudio("319741045", var_186_19)
						arg_183_1:RecordAudio("319741045", var_186_19)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_319741", "319741045", "story_v_out_319741.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_319741", "319741045", "story_v_out_319741.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_20 = math.max(var_186_11, arg_183_1.talkMaxDuration)

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_20 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_10) / var_186_20

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_10 + var_186_20 and arg_183_1.time_ < var_186_10 + var_186_20 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play319741046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319741046
		arg_187_1.duration_ = 13.97

		local var_187_0 = {
			zh = 8,
			ja = 13.966
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
				arg_187_0:Play319741047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_190_2 = arg_187_1.actors_["4040ui_story"]
			local var_190_3 = 0

			if var_190_3 < arg_187_1.time_ and arg_187_1.time_ <= var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect4040ui_story == nil then
				arg_187_1.var_.characterEffect4040ui_story = var_190_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_4 = 0.200000002980232

			if var_190_3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_3 + var_190_4 and not isNil(var_190_2) then
				local var_190_5 = (arg_187_1.time_ - var_190_3) / var_190_4

				if arg_187_1.var_.characterEffect4040ui_story and not isNil(var_190_2) then
					local var_190_6 = Mathf.Lerp(0, 0.5, var_190_5)

					arg_187_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_187_1.var_.characterEffect4040ui_story.fillRatio = var_190_6
				end
			end

			if arg_187_1.time_ >= var_190_3 + var_190_4 and arg_187_1.time_ < var_190_3 + var_190_4 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect4040ui_story then
				local var_190_7 = 0.5

				arg_187_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_187_1.var_.characterEffect4040ui_story.fillRatio = var_190_7
			end

			local var_190_8 = arg_187_1.actors_["10079ui_story"]
			local var_190_9 = 0

			if var_190_9 < arg_187_1.time_ and arg_187_1.time_ <= var_190_9 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.characterEffect10079ui_story == nil then
				arg_187_1.var_.characterEffect10079ui_story = var_190_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_10 = 0.200000002980232

			if var_190_9 <= arg_187_1.time_ and arg_187_1.time_ < var_190_9 + var_190_10 and not isNil(var_190_8) then
				local var_190_11 = (arg_187_1.time_ - var_190_9) / var_190_10

				if arg_187_1.var_.characterEffect10079ui_story and not isNil(var_190_8) then
					arg_187_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_9 + var_190_10 and arg_187_1.time_ < var_190_9 + var_190_10 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.characterEffect10079ui_story then
				arg_187_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_190_12 = 0
			local var_190_13 = 1

			if var_190_12 < arg_187_1.time_ and arg_187_1.time_ <= var_190_12 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_14 = arg_187_1:FormatText(StoryNameCfg[6].name)

				arg_187_1.leftNameTxt_.text = var_190_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_15 = arg_187_1:GetWordFromCfg(319741046)
				local var_190_16 = arg_187_1:FormatText(var_190_15.content)

				arg_187_1.text_.text = var_190_16

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_17 = 40
				local var_190_18 = utf8.len(var_190_16)
				local var_190_19 = var_190_17 <= 0 and var_190_13 or var_190_13 * (var_190_18 / var_190_17)

				if var_190_19 > 0 and var_190_13 < var_190_19 then
					arg_187_1.talkMaxDuration = var_190_19

					if var_190_19 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_19 + var_190_12
					end
				end

				arg_187_1.text_.text = var_190_16
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741046", "story_v_out_319741.awb") ~= 0 then
					local var_190_20 = manager.audio:GetVoiceLength("story_v_out_319741", "319741046", "story_v_out_319741.awb") / 1000

					if var_190_20 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_20 + var_190_12
					end

					if var_190_15.prefab_name ~= "" and arg_187_1.actors_[var_190_15.prefab_name] ~= nil then
						local var_190_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_15.prefab_name].transform, "story_v_out_319741", "319741046", "story_v_out_319741.awb")

						arg_187_1:RecordAudio("319741046", var_190_21)
						arg_187_1:RecordAudio("319741046", var_190_21)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_319741", "319741046", "story_v_out_319741.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_319741", "319741046", "story_v_out_319741.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_22 = math.max(var_190_13, arg_187_1.talkMaxDuration)

			if var_190_12 <= arg_187_1.time_ and arg_187_1.time_ < var_190_12 + var_190_22 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_12) / var_190_22

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_12 + var_190_22 and arg_187_1.time_ < var_190_12 + var_190_22 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319741047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319741047
		arg_191_1.duration_ = 3.97

		local var_191_0 = {
			zh = 3.966,
			ja = 3.1
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play319741048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["4040ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect4040ui_story == nil then
				arg_191_1.var_.characterEffect4040ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect4040ui_story and not isNil(var_194_0) then
					arg_191_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect4040ui_story then
				arg_191_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_194_4 = arg_191_1.actors_["10079ui_story"]
			local var_194_5 = 0

			if var_194_5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 and not isNil(var_194_4) and arg_191_1.var_.characterEffect10079ui_story == nil then
				arg_191_1.var_.characterEffect10079ui_story = var_194_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_6 = 0.200000002980232

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_6 and not isNil(var_194_4) then
				local var_194_7 = (arg_191_1.time_ - var_194_5) / var_194_6

				if arg_191_1.var_.characterEffect10079ui_story and not isNil(var_194_4) then
					local var_194_8 = Mathf.Lerp(0, 0.5, var_194_7)

					arg_191_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10079ui_story.fillRatio = var_194_8
				end
			end

			if arg_191_1.time_ >= var_194_5 + var_194_6 and arg_191_1.time_ < var_194_5 + var_194_6 + arg_194_0 and not isNil(var_194_4) and arg_191_1.var_.characterEffect10079ui_story then
				local var_194_9 = 0.5

				arg_191_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10079ui_story.fillRatio = var_194_9
			end

			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				arg_191_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			local var_194_11 = 0
			local var_194_12 = 0.45

			if var_194_11 < arg_191_1.time_ and arg_191_1.time_ <= var_194_11 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_13 = arg_191_1:FormatText(StoryNameCfg[668].name)

				arg_191_1.leftNameTxt_.text = var_194_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_14 = arg_191_1:GetWordFromCfg(319741047)
				local var_194_15 = arg_191_1:FormatText(var_194_14.content)

				arg_191_1.text_.text = var_194_15

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_16 = 18
				local var_194_17 = utf8.len(var_194_15)
				local var_194_18 = var_194_16 <= 0 and var_194_12 or var_194_12 * (var_194_17 / var_194_16)

				if var_194_18 > 0 and var_194_12 < var_194_18 then
					arg_191_1.talkMaxDuration = var_194_18

					if var_194_18 + var_194_11 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_18 + var_194_11
					end
				end

				arg_191_1.text_.text = var_194_15
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741047", "story_v_out_319741.awb") ~= 0 then
					local var_194_19 = manager.audio:GetVoiceLength("story_v_out_319741", "319741047", "story_v_out_319741.awb") / 1000

					if var_194_19 + var_194_11 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_19 + var_194_11
					end

					if var_194_14.prefab_name ~= "" and arg_191_1.actors_[var_194_14.prefab_name] ~= nil then
						local var_194_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_14.prefab_name].transform, "story_v_out_319741", "319741047", "story_v_out_319741.awb")

						arg_191_1:RecordAudio("319741047", var_194_20)
						arg_191_1:RecordAudio("319741047", var_194_20)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_319741", "319741047", "story_v_out_319741.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_319741", "319741047", "story_v_out_319741.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_21 = math.max(var_194_12, arg_191_1.talkMaxDuration)

			if var_194_11 <= arg_191_1.time_ and arg_191_1.time_ < var_194_11 + var_194_21 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_11) / var_194_21

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_11 + var_194_21 and arg_191_1.time_ < var_194_11 + var_194_21 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play319741048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319741048
		arg_195_1.duration_ = 17.17

		local var_195_0 = {
			zh = 9.033,
			ja = 17.166
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
				arg_195_0:Play319741049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.975

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[668].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:GetWordFromCfg(319741048)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741048", "story_v_out_319741.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_319741", "319741048", "story_v_out_319741.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_319741", "319741048", "story_v_out_319741.awb")

						arg_195_1:RecordAudio("319741048", var_198_9)
						arg_195_1:RecordAudio("319741048", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_319741", "319741048", "story_v_out_319741.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_319741", "319741048", "story_v_out_319741.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play319741049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319741049
		arg_199_1.duration_ = 8.77

		local var_199_0 = {
			zh = 8.766,
			ja = 8.633
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
				arg_199_0:Play319741050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.875

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[668].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:GetWordFromCfg(319741049)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741049", "story_v_out_319741.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_319741", "319741049", "story_v_out_319741.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_319741", "319741049", "story_v_out_319741.awb")

						arg_199_1:RecordAudio("319741049", var_202_9)
						arg_199_1:RecordAudio("319741049", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_319741", "319741049", "story_v_out_319741.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_319741", "319741049", "story_v_out_319741.awb")
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
	Play319741050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319741050
		arg_203_1.duration_ = 10.73

		local var_203_0 = {
			zh = 10.733,
			ja = 10.033
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
				arg_203_0:Play319741051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 1.175

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[668].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(319741050)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 47
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741050", "story_v_out_319741.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_319741", "319741050", "story_v_out_319741.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_319741", "319741050", "story_v_out_319741.awb")

						arg_203_1:RecordAudio("319741050", var_206_9)
						arg_203_1:RecordAudio("319741050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_319741", "319741050", "story_v_out_319741.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_319741", "319741050", "story_v_out_319741.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play319741051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319741051
		arg_207_1.duration_ = 12.37

		local var_207_0 = {
			zh = 12.133,
			ja = 12.366
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
				arg_207_0:Play319741052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_210_2 = 0
			local var_210_3 = 1.425

			if var_210_2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_4 = arg_207_1:FormatText(StoryNameCfg[668].name)

				arg_207_1.leftNameTxt_.text = var_210_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_5 = arg_207_1:GetWordFromCfg(319741051)
				local var_210_6 = arg_207_1:FormatText(var_210_5.content)

				arg_207_1.text_.text = var_210_6

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 57
				local var_210_8 = utf8.len(var_210_6)
				local var_210_9 = var_210_7 <= 0 and var_210_3 or var_210_3 * (var_210_8 / var_210_7)

				if var_210_9 > 0 and var_210_3 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_2
					end
				end

				arg_207_1.text_.text = var_210_6
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741051", "story_v_out_319741.awb") ~= 0 then
					local var_210_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741051", "story_v_out_319741.awb") / 1000

					if var_210_10 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_2
					end

					if var_210_5.prefab_name ~= "" and arg_207_1.actors_[var_210_5.prefab_name] ~= nil then
						local var_210_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_5.prefab_name].transform, "story_v_out_319741", "319741051", "story_v_out_319741.awb")

						arg_207_1:RecordAudio("319741051", var_210_11)
						arg_207_1:RecordAudio("319741051", var_210_11)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_319741", "319741051", "story_v_out_319741.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_319741", "319741051", "story_v_out_319741.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_12 = math.max(var_210_3, arg_207_1.talkMaxDuration)

			if var_210_2 <= arg_207_1.time_ and arg_207_1.time_ < var_210_2 + var_210_12 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_2) / var_210_12

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_2 + var_210_12 and arg_207_1.time_ < var_210_2 + var_210_12 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play319741052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319741052
		arg_211_1.duration_ = 10.4

		local var_211_0 = {
			zh = 8.8,
			ja = 10.4
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
				arg_211_0:Play319741053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.85

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[668].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:GetWordFromCfg(319741052)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741052", "story_v_out_319741.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_319741", "319741052", "story_v_out_319741.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_319741", "319741052", "story_v_out_319741.awb")

						arg_211_1:RecordAudio("319741052", var_214_9)
						arg_211_1:RecordAudio("319741052", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_319741", "319741052", "story_v_out_319741.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_319741", "319741052", "story_v_out_319741.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_10 and arg_211_1.time_ < var_214_0 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play319741053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 319741053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play319741054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10079ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect10079ui_story == nil then
				arg_215_1.var_.characterEffect10079ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect10079ui_story and not isNil(var_218_0) then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10079ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect10079ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10079ui_story.fillRatio = var_218_5
			end

			local var_218_6 = arg_215_1.actors_["4040ui_story"]
			local var_218_7 = 0

			if var_218_7 < arg_215_1.time_ and arg_215_1.time_ <= var_218_7 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect4040ui_story == nil then
				arg_215_1.var_.characterEffect4040ui_story = var_218_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_8 = 0.200000002980232

			if var_218_7 <= arg_215_1.time_ and arg_215_1.time_ < var_218_7 + var_218_8 and not isNil(var_218_6) then
				local var_218_9 = (arg_215_1.time_ - var_218_7) / var_218_8

				if arg_215_1.var_.characterEffect4040ui_story and not isNil(var_218_6) then
					local var_218_10 = Mathf.Lerp(0, 0.5, var_218_9)

					arg_215_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_215_1.var_.characterEffect4040ui_story.fillRatio = var_218_10
				end
			end

			if arg_215_1.time_ >= var_218_7 + var_218_8 and arg_215_1.time_ < var_218_7 + var_218_8 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect4040ui_story then
				local var_218_11 = 0.5

				arg_215_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_215_1.var_.characterEffect4040ui_story.fillRatio = var_218_11
			end

			local var_218_12 = arg_215_1.actors_["4040ui_story"].transform
			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1.var_.moveOldPos4040ui_story = var_218_12.localPosition
			end

			local var_218_14 = 0.001

			if var_218_13 <= arg_215_1.time_ and arg_215_1.time_ < var_218_13 + var_218_14 then
				local var_218_15 = (arg_215_1.time_ - var_218_13) / var_218_14
				local var_218_16 = Vector3.New(0, 100, 0)

				var_218_12.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos4040ui_story, var_218_16, var_218_15)

				local var_218_17 = manager.ui.mainCamera.transform.position - var_218_12.position

				var_218_12.forward = Vector3.New(var_218_17.x, var_218_17.y, var_218_17.z)

				local var_218_18 = var_218_12.localEulerAngles

				var_218_18.z = 0
				var_218_18.x = 0
				var_218_12.localEulerAngles = var_218_18
			end

			if arg_215_1.time_ >= var_218_13 + var_218_14 and arg_215_1.time_ < var_218_13 + var_218_14 + arg_218_0 then
				var_218_12.localPosition = Vector3.New(0, 100, 0)

				local var_218_19 = manager.ui.mainCamera.transform.position - var_218_12.position

				var_218_12.forward = Vector3.New(var_218_19.x, var_218_19.y, var_218_19.z)

				local var_218_20 = var_218_12.localEulerAngles

				var_218_20.z = 0
				var_218_20.x = 0
				var_218_12.localEulerAngles = var_218_20
			end

			local var_218_21 = arg_215_1.actors_["10079ui_story"].transform
			local var_218_22 = 0

			if var_218_22 < arg_215_1.time_ and arg_215_1.time_ <= var_218_22 + arg_218_0 then
				arg_215_1.var_.moveOldPos10079ui_story = var_218_21.localPosition
			end

			local var_218_23 = 0.001

			if var_218_22 <= arg_215_1.time_ and arg_215_1.time_ < var_218_22 + var_218_23 then
				local var_218_24 = (arg_215_1.time_ - var_218_22) / var_218_23
				local var_218_25 = Vector3.New(0, 100, 0)

				var_218_21.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10079ui_story, var_218_25, var_218_24)

				local var_218_26 = manager.ui.mainCamera.transform.position - var_218_21.position

				var_218_21.forward = Vector3.New(var_218_26.x, var_218_26.y, var_218_26.z)

				local var_218_27 = var_218_21.localEulerAngles

				var_218_27.z = 0
				var_218_27.x = 0
				var_218_21.localEulerAngles = var_218_27
			end

			if arg_215_1.time_ >= var_218_22 + var_218_23 and arg_215_1.time_ < var_218_22 + var_218_23 + arg_218_0 then
				var_218_21.localPosition = Vector3.New(0, 100, 0)

				local var_218_28 = manager.ui.mainCamera.transform.position - var_218_21.position

				var_218_21.forward = Vector3.New(var_218_28.x, var_218_28.y, var_218_28.z)

				local var_218_29 = var_218_21.localEulerAngles

				var_218_29.z = 0
				var_218_29.x = 0
				var_218_21.localEulerAngles = var_218_29
			end

			local var_218_30 = 0
			local var_218_31 = 1.05

			if var_218_30 < arg_215_1.time_ and arg_215_1.time_ <= var_218_30 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_32 = arg_215_1:GetWordFromCfg(319741053)
				local var_218_33 = arg_215_1:FormatText(var_218_32.content)

				arg_215_1.text_.text = var_218_33

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_34 = 42
				local var_218_35 = utf8.len(var_218_33)
				local var_218_36 = var_218_34 <= 0 and var_218_31 or var_218_31 * (var_218_35 / var_218_34)

				if var_218_36 > 0 and var_218_31 < var_218_36 then
					arg_215_1.talkMaxDuration = var_218_36

					if var_218_36 + var_218_30 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_36 + var_218_30
					end
				end

				arg_215_1.text_.text = var_218_33
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_37 = math.max(var_218_31, arg_215_1.talkMaxDuration)

			if var_218_30 <= arg_215_1.time_ and arg_215_1.time_ < var_218_30 + var_218_37 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_30) / var_218_37

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_30 + var_218_37 and arg_215_1.time_ < var_218_30 + var_218_37 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319741054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 319741054
		arg_219_1.duration_ = 6.18

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play319741055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.15
			local var_222_1 = 6.033
			local var_222_2 = manager.audio:GetVoiceLength("story_v_out_319741", "319741054", "story_v_out_319741.awb") / 1000

			if var_222_2 > 0 and var_222_1 < var_222_2 and var_222_2 + var_222_0 > arg_219_1.duration_ then
				local var_222_3 = var_222_2

				arg_219_1.duration_ = var_222_2 + var_222_0
			end

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				local var_222_4 = "play"
				local var_222_5 = "voice"

				arg_219_1:AudioAction(var_222_4, var_222_5, "story_v_out_319741", "319741054", "story_v_out_319741.awb")
			end

			local var_222_6 = 0

			if var_222_6 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(true)
				arg_219_1.dialog_:SetActive(false)

				arg_219_1.fswtw_.percent = 0

				local var_222_7 = arg_219_1:GetWordFromCfg(319741054)
				local var_222_8 = arg_219_1:FormatText(var_222_7.content)

				arg_219_1.fswt_.text = var_222_8

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.fswt_)

				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_219_1.fswtw_:SetDirty()

				arg_219_1.typewritterCharCountI18N = 0

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_9 = 0.149999999998999

			if var_222_9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1.var_.oldValueTypewriter = arg_219_1.fswtw_.percent

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_10 = 0
			local var_222_11 = 0
			local var_222_12 = arg_219_1:GetWordFromCfg(319741054)
			local var_222_13 = arg_219_1:FormatText(var_222_12.content)
			local var_222_14, var_222_15 = arg_219_1:GetPercentByPara(var_222_13, 1)

			if var_222_9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				local var_222_16 = var_222_10 <= 0 and var_222_11 or var_222_11 * ((var_222_15 - arg_219_1.typewritterCharCountI18N) / var_222_10)

				if var_222_16 > 0 and var_222_11 < var_222_16 then
					arg_219_1.talkMaxDuration = var_222_16

					if var_222_16 + var_222_9 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_16 + var_222_9
					end
				end
			end

			local var_222_17 = 0
			local var_222_18 = math.max(var_222_17, arg_219_1.talkMaxDuration)

			if var_222_9 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_18 then
				local var_222_19 = (arg_219_1.time_ - var_222_9) / var_222_18

				arg_219_1.fswtw_.percent = Mathf.Lerp(arg_219_1.var_.oldValueTypewriter, var_222_14, var_222_19)
				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.fswtw_:SetDirty()
			end

			if arg_219_1.time_ >= var_222_9 + var_222_18 and arg_219_1.time_ < var_222_9 + var_222_18 + arg_222_0 then
				arg_219_1.fswtw_.percent = var_222_14

				arg_219_1.fswtw_:SetDirty()
				arg_219_1:ShowNextGo(true)

				arg_219_1.typewritterCharCountI18N = var_222_15
			end

			local var_222_20 = 0.15

			if var_222_20 < arg_219_1.time_ and arg_219_1.time_ <= var_222_20 + arg_222_0 then
				arg_219_1.var_.oldValueTypewriter = arg_219_1.fswtw_.percent

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_21 = 24
			local var_222_22 = 1.6
			local var_222_23 = arg_219_1:GetWordFromCfg(319741054)
			local var_222_24 = arg_219_1:FormatText(var_222_23.content)
			local var_222_25, var_222_26 = arg_219_1:GetPercentByPara(var_222_24, 1)

			if var_222_20 < arg_219_1.time_ and arg_219_1.time_ <= var_222_20 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				local var_222_27 = var_222_21 <= 0 and var_222_22 or var_222_22 * ((var_222_26 - arg_219_1.typewritterCharCountI18N) / var_222_21)

				if var_222_27 > 0 and var_222_22 < var_222_27 then
					arg_219_1.talkMaxDuration = var_222_27

					if var_222_27 + var_222_20 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_27 + var_222_20
					end
				end
			end

			local var_222_28 = 1.6
			local var_222_29 = math.max(var_222_28, arg_219_1.talkMaxDuration)

			if var_222_20 <= arg_219_1.time_ and arg_219_1.time_ < var_222_20 + var_222_29 then
				local var_222_30 = (arg_219_1.time_ - var_222_20) / var_222_29

				arg_219_1.fswtw_.percent = Mathf.Lerp(arg_219_1.var_.oldValueTypewriter, var_222_25, var_222_30)
				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.fswtw_:SetDirty()
			end

			if arg_219_1.time_ >= var_222_20 + var_222_29 and arg_219_1.time_ < var_222_20 + var_222_29 + arg_222_0 then
				arg_219_1.fswtw_.percent = var_222_25

				arg_219_1.fswtw_:SetDirty()
				arg_219_1:ShowNextGo(true)

				arg_219_1.typewritterCharCountI18N = var_222_26
			end

			local var_222_31 = 0

			if var_222_31 < arg_219_1.time_ and arg_219_1.time_ <= var_222_31 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(true)

				local var_222_32 = arg_219_1.cswt_:GetComponent("RectTransform")

				arg_219_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_222_32.offsetMin = Vector2.New(400, 220)
				var_222_32.offsetMax = Vector2.New(-400, -200)

				local var_222_33 = arg_219_1:GetWordFromCfg(419050)
				local var_222_34 = arg_219_1:FormatText(var_222_33.content)

				arg_219_1.cswt_.text = var_222_34

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.cswt_)

				arg_219_1.cswt_.fontSize = 180
				arg_219_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_219_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_222_35 = 0

			if var_222_35 < arg_219_1.time_ and arg_219_1.time_ <= var_222_35 + arg_222_0 then
				local var_222_36 = arg_219_1.fswbg_.transform:Find("textbox/adapt/content") or arg_219_1.fswbg_.transform:Find("textbox/content")
				local var_222_37 = arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_222_38 = var_222_36:GetComponent("Text")
				local var_222_39 = var_222_36:GetComponent("RectTransform")

				var_222_38.alignment = UnityEngine.TextAnchor.LowerCenter
				var_222_39.offsetMin = Vector2.New(0, 0)
				var_222_39.offsetMax = Vector2.New(0, 0)
			end

			local var_222_40 = "STblack"

			if arg_219_1.bgs_[var_222_40] == nil then
				local var_222_41 = Object.Instantiate(arg_219_1.paintGo_)

				var_222_41:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_222_40)
				var_222_41.name = var_222_40
				var_222_41.transform.parent = arg_219_1.stage_.transform
				var_222_41.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.bgs_[var_222_40] = var_222_41
			end

			local var_222_42 = 0

			if var_222_42 < arg_219_1.time_ and arg_219_1.time_ <= var_222_42 + arg_222_0 then
				local var_222_43 = manager.ui.mainCamera.transform.localPosition
				local var_222_44 = Vector3.New(0, 0, 10) + Vector3.New(var_222_43.x, var_222_43.y, 0)
				local var_222_45 = arg_219_1.bgs_.STblack

				var_222_45.transform.localPosition = var_222_44
				var_222_45.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_46 = var_222_45:GetComponent("SpriteRenderer")

				if var_222_46 and var_222_46.sprite then
					local var_222_47 = (var_222_45.transform.localPosition - var_222_43).z
					local var_222_48 = manager.ui.mainCameraCom_
					local var_222_49 = 2 * var_222_47 * Mathf.Tan(var_222_48.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_222_50 = var_222_49 * var_222_48.aspect
					local var_222_51 = var_222_46.sprite.bounds.size.x
					local var_222_52 = var_222_46.sprite.bounds.size.y
					local var_222_53 = var_222_50 / var_222_51
					local var_222_54 = var_222_49 / var_222_52
					local var_222_55 = var_222_54 < var_222_53 and var_222_53 or var_222_54

					var_222_45.transform.localScale = Vector3.New(var_222_55, var_222_55, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "STblack" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_56 = 0

			if var_222_56 < arg_219_1.time_ and arg_219_1.time_ <= var_222_56 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(true)

				local var_222_57 = arg_219_1.cswt_:GetComponent("RectTransform")

				arg_219_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_222_57.offsetMin = Vector2.New(410, 330)
				var_222_57.offsetMax = Vector2.New(-400, -180)

				local var_222_58 = arg_219_1:GetWordFromCfg(419050)
				local var_222_59 = arg_219_1:FormatText(var_222_58.content)

				arg_219_1.cswt_.text = var_222_59

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.cswt_)

				arg_219_1.cswt_.fontSize = 175
				arg_219_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_219_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play319741055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 319741055
		arg_223_1.duration_ = 4.78

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
			arg_223_1.auto_ = false
		end

		function arg_223_1.playNext_(arg_225_0)
			arg_223_1.onStoryFinished_()
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.15
			local var_226_1 = 4.633
			local var_226_2 = manager.audio:GetVoiceLength("story_v_out_319741", "319741055", "story_v_out_319741.awb") / 1000

			if var_226_2 > 0 and var_226_1 < var_226_2 and var_226_2 + var_226_0 > arg_223_1.duration_ then
				local var_226_3 = var_226_2

				arg_223_1.duration_ = var_226_2 + var_226_0
			end

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				local var_226_4 = "play"
				local var_226_5 = "voice"

				arg_223_1:AudioAction(var_226_4, var_226_5, "story_v_out_319741", "319741055", "story_v_out_319741.awb")
			end

			local var_226_6 = 0

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.fswbg_:SetActive(true)
				arg_223_1.dialog_:SetActive(false)

				arg_223_1.fswtw_.percent = 0

				local var_226_7 = arg_223_1:GetWordFromCfg(319741055)
				local var_226_8 = arg_223_1:FormatText(var_226_7.content)

				arg_223_1.fswt_.text = var_226_8

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.fswt_)

				arg_223_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_223_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_223_1.fswtw_:SetDirty()

				arg_223_1.typewritterCharCountI18N = 0

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_9 = 0.149999999998999

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1.var_.oldValueTypewriter = arg_223_1.fswtw_.percent

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_10 = 0
			local var_226_11 = 0
			local var_226_12 = arg_223_1:GetWordFromCfg(319741055)
			local var_226_13 = arg_223_1:FormatText(var_226_12.content)
			local var_226_14, var_226_15 = arg_223_1:GetPercentByPara(var_226_13, 1)

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				local var_226_16 = var_226_10 <= 0 and var_226_11 or var_226_11 * ((var_226_15 - arg_223_1.typewritterCharCountI18N) / var_226_10)

				if var_226_16 > 0 and var_226_11 < var_226_16 then
					arg_223_1.talkMaxDuration = var_226_16

					if var_226_16 + var_226_9 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_16 + var_226_9
					end
				end
			end

			local var_226_17 = 0
			local var_226_18 = math.max(var_226_17, arg_223_1.talkMaxDuration)

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_18 then
				local var_226_19 = (arg_223_1.time_ - var_226_9) / var_226_18

				arg_223_1.fswtw_.percent = Mathf.Lerp(arg_223_1.var_.oldValueTypewriter, var_226_14, var_226_19)
				arg_223_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.fswtw_:SetDirty()
			end

			if arg_223_1.time_ >= var_226_9 + var_226_18 and arg_223_1.time_ < var_226_9 + var_226_18 + arg_226_0 then
				arg_223_1.fswtw_.percent = var_226_14

				arg_223_1.fswtw_:SetDirty()
				arg_223_1:ShowNextGo(true)

				arg_223_1.typewritterCharCountI18N = var_226_15
			end

			local var_226_20 = 0.15

			if var_226_20 < arg_223_1.time_ and arg_223_1.time_ <= var_226_20 + arg_226_0 then
				arg_223_1.var_.oldValueTypewriter = arg_223_1.fswtw_.percent

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_21 = 24
			local var_226_22 = 1.6
			local var_226_23 = arg_223_1:GetWordFromCfg(319741055)
			local var_226_24 = arg_223_1:FormatText(var_226_23.content)
			local var_226_25, var_226_26 = arg_223_1:GetPercentByPara(var_226_24, 1)

			if var_226_20 < arg_223_1.time_ and arg_223_1.time_ <= var_226_20 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				local var_226_27 = var_226_21 <= 0 and var_226_22 or var_226_22 * ((var_226_26 - arg_223_1.typewritterCharCountI18N) / var_226_21)

				if var_226_27 > 0 and var_226_22 < var_226_27 then
					arg_223_1.talkMaxDuration = var_226_27

					if var_226_27 + var_226_20 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_27 + var_226_20
					end
				end
			end

			local var_226_28 = 1.6
			local var_226_29 = math.max(var_226_28, arg_223_1.talkMaxDuration)

			if var_226_20 <= arg_223_1.time_ and arg_223_1.time_ < var_226_20 + var_226_29 then
				local var_226_30 = (arg_223_1.time_ - var_226_20) / var_226_29

				arg_223_1.fswtw_.percent = Mathf.Lerp(arg_223_1.var_.oldValueTypewriter, var_226_25, var_226_30)
				arg_223_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.fswtw_:SetDirty()
			end

			if arg_223_1.time_ >= var_226_20 + var_226_29 and arg_223_1.time_ < var_226_20 + var_226_29 + arg_226_0 then
				arg_223_1.fswtw_.percent = var_226_25

				arg_223_1.fswtw_:SetDirty()
				arg_223_1:ShowNextGo(true)

				arg_223_1.typewritterCharCountI18N = var_226_26
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11m",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319741.awb"
	}
}
