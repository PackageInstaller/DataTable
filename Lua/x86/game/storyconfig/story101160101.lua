return {
	Play116011001 = function(arg_1_0, arg_1_1)
		arg_1_1.marker = "Mark1"
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116011001
		arg_1_1.duration_ = 122.97

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			arg_1_1.marker = ""

			if arg_3_0 == 1 then
				arg_1_0:Play116011002(arg_1_1)
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

			local var_4_2 = 110.9667

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

			local var_4_16 = 110.9667

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
			local var_4_23 = 1

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

			local var_4_28 = 110.966666666667
			local var_4_29 = 1.366666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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

			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, false)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)

				arg_1_1.marker = "PlayCantSkipVideo"

				manager.video:Play("SofdecAsset/story/101160101.usm", function(arg_7_0)
					arg_1_1.time_ = var_4_34 + 110.95666666689

					if arg_1_1.state_ == "pause" then
						arg_1_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_8_0)
					if arg_8_0 then
						arg_1_1.state_ = "pause"
					else
						arg_1_1.state_ = "playing"
					end
				end, 101160101)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_35 = 110.966666666667

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.marker = ""
			end

			local var_4_36 = 110.9667

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				SetActive(arg_1_1.dialog_, true)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_1_1.isInLoopVideo = false
			end

			local var_4_37 = 0.133334000000005

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				-- block empty
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 112.966699999999
			local var_4_39 = 0.65

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
					arg_1_1.dialogCg_.alpha = arg_9_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[323].name)

				arg_1_1.leftNameTxt_.text = var_4_41

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

				local var_4_42 = arg_1_1:GetWordFromCfg(116011001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 26
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_39 or var_4_39 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_39 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_38 = var_4_38 + 0.3

					if var_4_46 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011001", "story_v_out_116011.awb") ~= 0 then
					local var_4_47 = manager.audio:GetVoiceLength("story_v_out_116011", "116011001", "story_v_out_116011.awb") / 1000

					if var_4_47 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_38
					end

					if var_4_42.prefab_name ~= "" and arg_1_1.actors_[var_4_42.prefab_name] ~= nil then
						local var_4_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_42.prefab_name].transform, "story_v_out_116011", "116011001", "story_v_out_116011.awb")

						arg_1_1:RecordAudio("116011001", var_4_48)
						arg_1_1:RecordAudio("116011001", var_4_48)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116011", "116011001", "story_v_out_116011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116011", "116011001", "story_v_out_116011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_49 = var_4_38 + 0.3
			local var_4_50 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_49) / var_4_50

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116011002 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 116011002
		arg_11_1.duration_ = 2

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play116011003(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = "2078ui_story"

			if arg_11_1.actors_[var_14_0] == nil then
				local var_14_1 = Asset.Load("Char/" .. "2078ui_story")

				if not isNil(var_14_1) then
					local var_14_2 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_11_1.stage_.transform)

					var_14_2.name = var_14_0
					var_14_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_11_1.actors_[var_14_0] = var_14_2

					local var_14_3 = var_14_2:GetComponentInChildren(typeof(CharacterEffect))

					var_14_3.enabled = true

					local var_14_4 = GameObjectTools.GetOrAddComponent(var_14_2, typeof(DynamicBoneHelper))

					if var_14_4 then
						var_14_4:EnableDynamicBone(false)
					end

					arg_11_1:ShowWeapon(var_14_3.transform, false)

					arg_11_1.var_[var_14_0 .. "Animator"] = var_14_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_11_1.var_[var_14_0 .. "Animator"].applyRootMotion = true
					arg_11_1.var_[var_14_0 .. "LipSync"] = var_14_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_14_5 = arg_11_1.actors_["2078ui_story"].transform
			local var_14_6 = 0

			if var_14_6 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 then
				arg_11_1.var_.moveOldPos2078ui_story = var_14_5.localPosition
			end

			local var_14_7 = 0.001

			if var_14_6 <= arg_11_1.time_ and arg_11_1.time_ < var_14_6 + var_14_7 then
				local var_14_8 = (arg_11_1.time_ - var_14_6) / var_14_7
				local var_14_9 = Vector3.New(-0.7, -1.28, -5.6)

				var_14_5.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos2078ui_story, var_14_9, var_14_8)

				local var_14_10 = manager.ui.mainCamera.transform.position - var_14_5.position

				var_14_5.forward = Vector3.New(var_14_10.x, var_14_10.y, var_14_10.z)

				local var_14_11 = var_14_5.localEulerAngles

				var_14_11.z = 0
				var_14_11.x = 0
				var_14_5.localEulerAngles = var_14_11
			end

			if arg_11_1.time_ >= var_14_6 + var_14_7 and arg_11_1.time_ < var_14_6 + var_14_7 + arg_14_0 then
				var_14_5.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_14_12 = manager.ui.mainCamera.transform.position - var_14_5.position

				var_14_5.forward = Vector3.New(var_14_12.x, var_14_12.y, var_14_12.z)

				local var_14_13 = var_14_5.localEulerAngles

				var_14_13.z = 0
				var_14_13.x = 0
				var_14_5.localEulerAngles = var_14_13
			end

			local var_14_14 = 0

			if var_14_14 < arg_11_1.time_ and arg_11_1.time_ <= var_14_14 + arg_14_0 then
				arg_11_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_14_15 = "2079ui_story"

			if arg_11_1.actors_[var_14_15] == nil then
				local var_14_16 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_14_16) then
					local var_14_17 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_11_1.stage_.transform)

					var_14_17.name = var_14_15
					var_14_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_11_1.actors_[var_14_15] = var_14_17

					local var_14_18 = var_14_17:GetComponentInChildren(typeof(CharacterEffect))

					var_14_18.enabled = true

					local var_14_19 = GameObjectTools.GetOrAddComponent(var_14_17, typeof(DynamicBoneHelper))

					if var_14_19 then
						var_14_19:EnableDynamicBone(false)
					end

					arg_11_1:ShowWeapon(var_14_18.transform, false)

					arg_11_1.var_[var_14_15 .. "Animator"] = var_14_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_11_1.var_[var_14_15 .. "Animator"].applyRootMotion = true
					arg_11_1.var_[var_14_15 .. "LipSync"] = var_14_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_14_20 = arg_11_1.actors_["2079ui_story"].transform
			local var_14_21 = 0

			if var_14_21 < arg_11_1.time_ and arg_11_1.time_ <= var_14_21 + arg_14_0 then
				arg_11_1.var_.moveOldPos2079ui_story = var_14_20.localPosition
			end

			local var_14_22 = 0.001

			if var_14_21 <= arg_11_1.time_ and arg_11_1.time_ < var_14_21 + var_14_22 then
				local var_14_23 = (arg_11_1.time_ - var_14_21) / var_14_22
				local var_14_24 = Vector3.New(0.7, -1.28, -5.6)

				var_14_20.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos2079ui_story, var_14_24, var_14_23)

				local var_14_25 = manager.ui.mainCamera.transform.position - var_14_20.position

				var_14_20.forward = Vector3.New(var_14_25.x, var_14_25.y, var_14_25.z)

				local var_14_26 = var_14_20.localEulerAngles

				var_14_26.z = 0
				var_14_26.x = 0
				var_14_20.localEulerAngles = var_14_26
			end

			if arg_11_1.time_ >= var_14_21 + var_14_22 and arg_11_1.time_ < var_14_21 + var_14_22 + arg_14_0 then
				var_14_20.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_14_27 = manager.ui.mainCamera.transform.position - var_14_20.position

				var_14_20.forward = Vector3.New(var_14_27.x, var_14_27.y, var_14_27.z)

				local var_14_28 = var_14_20.localEulerAngles

				var_14_28.z = 0
				var_14_28.x = 0
				var_14_20.localEulerAngles = var_14_28
			end

			local var_14_29 = 0

			if var_14_29 < arg_11_1.time_ and arg_11_1.time_ <= var_14_29 + arg_14_0 then
				arg_11_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_14_30 = arg_11_1.actors_["2078ui_story"]
			local var_14_31 = 0

			if var_14_31 < arg_11_1.time_ and arg_11_1.time_ <= var_14_31 + arg_14_0 and not isNil(var_14_30) and arg_11_1.var_.characterEffect2078ui_story == nil then
				arg_11_1.var_.characterEffect2078ui_story = var_14_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_32 = 0.2

			if var_14_31 <= arg_11_1.time_ and arg_11_1.time_ < var_14_31 + var_14_32 and not isNil(var_14_30) then
				local var_14_33 = (arg_11_1.time_ - var_14_31) / var_14_32

				if arg_11_1.var_.characterEffect2078ui_story and not isNil(var_14_30) then
					arg_11_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_31 + var_14_32 and arg_11_1.time_ < var_14_31 + var_14_32 + arg_14_0 and not isNil(var_14_30) and arg_11_1.var_.characterEffect2078ui_story then
				arg_11_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_14_34 = arg_11_1.actors_["2079ui_story"]
			local var_14_35 = 0

			if var_14_35 < arg_11_1.time_ and arg_11_1.time_ <= var_14_35 + arg_14_0 and not isNil(var_14_34) and arg_11_1.var_.characterEffect2079ui_story == nil then
				arg_11_1.var_.characterEffect2079ui_story = var_14_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_36 = 0.2

			if var_14_35 <= arg_11_1.time_ and arg_11_1.time_ < var_14_35 + var_14_36 and not isNil(var_14_34) then
				local var_14_37 = (arg_11_1.time_ - var_14_35) / var_14_36

				if arg_11_1.var_.characterEffect2079ui_story and not isNil(var_14_34) then
					arg_11_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_35 + var_14_36 and arg_11_1.time_ < var_14_35 + var_14_36 + arg_14_0 and not isNil(var_14_34) and arg_11_1.var_.characterEffect2079ui_story then
				arg_11_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_14_38 = 0
			local var_14_39 = 0.075

			if var_14_38 < arg_11_1.time_ and arg_11_1.time_ <= var_14_38 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_40 = arg_11_1:FormatText(StoryNameCfg[325].name)

				arg_11_1.leftNameTxt_.text = var_14_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_41 = arg_11_1:GetWordFromCfg(116011002)
				local var_14_42 = arg_11_1:FormatText(var_14_41.content)

				arg_11_1.text_.text = var_14_42

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_43 = 3
				local var_14_44 = utf8.len(var_14_42)
				local var_14_45 = var_14_43 <= 0 and var_14_39 or var_14_39 * (var_14_44 / var_14_43)

				if var_14_45 > 0 and var_14_39 < var_14_45 then
					arg_11_1.talkMaxDuration = var_14_45

					if var_14_45 + var_14_38 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_45 + var_14_38
					end
				end

				arg_11_1.text_.text = var_14_42
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011002", "story_v_out_116011.awb") ~= 0 then
					local var_14_46 = manager.audio:GetVoiceLength("story_v_out_116011", "116011002", "story_v_out_116011.awb") / 1000

					if var_14_46 + var_14_38 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_46 + var_14_38
					end

					if var_14_41.prefab_name ~= "" and arg_11_1.actors_[var_14_41.prefab_name] ~= nil then
						local var_14_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_41.prefab_name].transform, "story_v_out_116011", "116011002", "story_v_out_116011.awb")

						arg_11_1:RecordAudio("116011002", var_14_47)
						arg_11_1:RecordAudio("116011002", var_14_47)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_116011", "116011002", "story_v_out_116011.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_116011", "116011002", "story_v_out_116011.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_48 = math.max(var_14_39, arg_11_1.talkMaxDuration)

			if var_14_38 <= arg_11_1.time_ and arg_11_1.time_ < var_14_38 + var_14_48 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_38) / var_14_48

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_38 + var_14_48 and arg_11_1.time_ < var_14_38 + var_14_48 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play116011003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 116011003
		arg_15_1.duration_ = 12.83

		local var_15_0 = {
			zh = 6.866,
			ja = 12.833
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play116011004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["2078ui_story"]
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 and not isNil(var_18_0) and arg_15_1.var_.characterEffect2078ui_story == nil then
				arg_15_1.var_.characterEffect2078ui_story = var_18_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.2

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 and not isNil(var_18_0) then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2

				if arg_15_1.var_.characterEffect2078ui_story and not isNil(var_18_0) then
					local var_18_4 = Mathf.Lerp(0, 0.5, var_18_3)

					arg_15_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_15_1.var_.characterEffect2078ui_story.fillRatio = var_18_4
				end
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 and not isNil(var_18_0) and arg_15_1.var_.characterEffect2078ui_story then
				local var_18_5 = 0.5

				arg_15_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_15_1.var_.characterEffect2078ui_story.fillRatio = var_18_5
			end

			local var_18_6 = arg_15_1.actors_["2079ui_story"]
			local var_18_7 = 0

			if var_18_7 < arg_15_1.time_ and arg_15_1.time_ <= var_18_7 + arg_18_0 and not isNil(var_18_6) and arg_15_1.var_.characterEffect2079ui_story == nil then
				arg_15_1.var_.characterEffect2079ui_story = var_18_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_8 = 0.2

			if var_18_7 <= arg_15_1.time_ and arg_15_1.time_ < var_18_7 + var_18_8 and not isNil(var_18_6) then
				local var_18_9 = (arg_15_1.time_ - var_18_7) / var_18_8

				if arg_15_1.var_.characterEffect2079ui_story and not isNil(var_18_6) then
					local var_18_10 = Mathf.Lerp(0, 0.5, var_18_9)

					arg_15_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_15_1.var_.characterEffect2079ui_story.fillRatio = var_18_10
				end
			end

			if arg_15_1.time_ >= var_18_7 + var_18_8 and arg_15_1.time_ < var_18_7 + var_18_8 + arg_18_0 and not isNil(var_18_6) and arg_15_1.var_.characterEffect2079ui_story then
				local var_18_11 = 0.5

				arg_15_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_15_1.var_.characterEffect2079ui_story.fillRatio = var_18_11
			end

			local var_18_12 = 0
			local var_18_13 = 0.925

			if var_18_12 < arg_15_1.time_ and arg_15_1.time_ <= var_18_12 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_14 = arg_15_1:FormatText(StoryNameCfg[323].name)

				arg_15_1.leftNameTxt_.text = var_18_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_15 = arg_15_1:GetWordFromCfg(116011003)
				local var_18_16 = arg_15_1:FormatText(var_18_15.content)

				arg_15_1.text_.text = var_18_16

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_17 = 37
				local var_18_18 = utf8.len(var_18_16)
				local var_18_19 = var_18_17 <= 0 and var_18_13 or var_18_13 * (var_18_18 / var_18_17)

				if var_18_19 > 0 and var_18_13 < var_18_19 then
					arg_15_1.talkMaxDuration = var_18_19

					if var_18_19 + var_18_12 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_19 + var_18_12
					end
				end

				arg_15_1.text_.text = var_18_16
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011003", "story_v_out_116011.awb") ~= 0 then
					local var_18_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011003", "story_v_out_116011.awb") / 1000

					if var_18_20 + var_18_12 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_20 + var_18_12
					end

					if var_18_15.prefab_name ~= "" and arg_15_1.actors_[var_18_15.prefab_name] ~= nil then
						local var_18_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_15.prefab_name].transform, "story_v_out_116011", "116011003", "story_v_out_116011.awb")

						arg_15_1:RecordAudio("116011003", var_18_21)
						arg_15_1:RecordAudio("116011003", var_18_21)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_116011", "116011003", "story_v_out_116011.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_116011", "116011003", "story_v_out_116011.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_22 = math.max(var_18_13, arg_15_1.talkMaxDuration)

			if var_18_12 <= arg_15_1.time_ and arg_15_1.time_ < var_18_12 + var_18_22 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_12) / var_18_22

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_12 + var_18_22 and arg_15_1.time_ < var_18_12 + var_18_22 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play116011004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 116011004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play116011005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 0.4

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_2 = arg_19_1:GetWordFromCfg(116011004)
				local var_22_3 = arg_19_1:FormatText(var_22_2.content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_4 = 16
				local var_22_5 = utf8.len(var_22_3)
				local var_22_6 = var_22_4 <= 0 and var_22_1 or var_22_1 * (var_22_5 / var_22_4)

				if var_22_6 > 0 and var_22_1 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_7 and arg_19_1.time_ < var_22_0 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play116011005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 116011005
		arg_23_1.duration_ = 4.13

		local var_23_0 = {
			zh = 2.833,
			ja = 4.133
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play116011006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["2078ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect2078ui_story == nil then
				arg_23_1.var_.characterEffect2078ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect2078ui_story and not isNil(var_26_0) then
					arg_23_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect2078ui_story then
				arg_23_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_26_4 = 0
			local var_26_5 = 0.45

			if var_26_4 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_6 = arg_23_1:FormatText(StoryNameCfg[320].name)

				arg_23_1.leftNameTxt_.text = var_26_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_7 = arg_23_1:GetWordFromCfg(116011005)
				local var_26_8 = arg_23_1:FormatText(var_26_7.content)

				arg_23_1.text_.text = var_26_8

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_9 = 18
				local var_26_10 = utf8.len(var_26_8)
				local var_26_11 = var_26_9 <= 0 and var_26_5 or var_26_5 * (var_26_10 / var_26_9)

				if var_26_11 > 0 and var_26_5 < var_26_11 then
					arg_23_1.talkMaxDuration = var_26_11

					if var_26_11 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_11 + var_26_4
					end
				end

				arg_23_1.text_.text = var_26_8
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011005", "story_v_out_116011.awb") ~= 0 then
					local var_26_12 = manager.audio:GetVoiceLength("story_v_out_116011", "116011005", "story_v_out_116011.awb") / 1000

					if var_26_12 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_12 + var_26_4
					end

					if var_26_7.prefab_name ~= "" and arg_23_1.actors_[var_26_7.prefab_name] ~= nil then
						local var_26_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_7.prefab_name].transform, "story_v_out_116011", "116011005", "story_v_out_116011.awb")

						arg_23_1:RecordAudio("116011005", var_26_13)
						arg_23_1:RecordAudio("116011005", var_26_13)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_116011", "116011005", "story_v_out_116011.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_116011", "116011005", "story_v_out_116011.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_14 = math.max(var_26_5, arg_23_1.talkMaxDuration)

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_14 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_4) / var_26_14

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_4 + var_26_14 and arg_23_1.time_ < var_26_4 + var_26_14 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play116011006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 116011006
		arg_27_1.duration_ = 2.5

		local var_27_0 = {
			zh = 1.6,
			ja = 2.5
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
				arg_27_0:Play116011007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["2078ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect2078ui_story == nil then
				arg_27_1.var_.characterEffect2078ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect2078ui_story and not isNil(var_30_0) then
					local var_30_4 = Mathf.Lerp(0, 0.5, var_30_3)

					arg_27_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_27_1.var_.characterEffect2078ui_story.fillRatio = var_30_4
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect2078ui_story then
				local var_30_5 = 0.5

				arg_27_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_27_1.var_.characterEffect2078ui_story.fillRatio = var_30_5
			end

			local var_30_6 = arg_27_1.actors_["2079ui_story"]
			local var_30_7 = 0

			if var_30_7 < arg_27_1.time_ and arg_27_1.time_ <= var_30_7 + arg_30_0 and not isNil(var_30_6) and arg_27_1.var_.characterEffect2079ui_story == nil then
				arg_27_1.var_.characterEffect2079ui_story = var_30_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_8 = 0.2

			if var_30_7 <= arg_27_1.time_ and arg_27_1.time_ < var_30_7 + var_30_8 and not isNil(var_30_6) then
				local var_30_9 = (arg_27_1.time_ - var_30_7) / var_30_8

				if arg_27_1.var_.characterEffect2079ui_story and not isNil(var_30_6) then
					arg_27_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_7 + var_30_8 and arg_27_1.time_ < var_30_7 + var_30_8 + arg_30_0 and not isNil(var_30_6) and arg_27_1.var_.characterEffect2079ui_story then
				arg_27_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_30_10 = 0
			local var_30_11 = 0.175

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_12 = arg_27_1:FormatText(StoryNameCfg[321].name)

				arg_27_1.leftNameTxt_.text = var_30_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_13 = arg_27_1:GetWordFromCfg(116011006)
				local var_30_14 = arg_27_1:FormatText(var_30_13.content)

				arg_27_1.text_.text = var_30_14

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_15 = 7
				local var_30_16 = utf8.len(var_30_14)
				local var_30_17 = var_30_15 <= 0 and var_30_11 or var_30_11 * (var_30_16 / var_30_15)

				if var_30_17 > 0 and var_30_11 < var_30_17 then
					arg_27_1.talkMaxDuration = var_30_17

					if var_30_17 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_17 + var_30_10
					end
				end

				arg_27_1.text_.text = var_30_14
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011006", "story_v_out_116011.awb") ~= 0 then
					local var_30_18 = manager.audio:GetVoiceLength("story_v_out_116011", "116011006", "story_v_out_116011.awb") / 1000

					if var_30_18 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_18 + var_30_10
					end

					if var_30_13.prefab_name ~= "" and arg_27_1.actors_[var_30_13.prefab_name] ~= nil then
						local var_30_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_13.prefab_name].transform, "story_v_out_116011", "116011006", "story_v_out_116011.awb")

						arg_27_1:RecordAudio("116011006", var_30_19)
						arg_27_1:RecordAudio("116011006", var_30_19)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_116011", "116011006", "story_v_out_116011.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_116011", "116011006", "story_v_out_116011.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_20 = math.max(var_30_11, arg_27_1.talkMaxDuration)

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_20 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_10) / var_30_20

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_10 + var_30_20 and arg_27_1.time_ < var_30_10 + var_30_20 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play116011007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 116011007
		arg_31_1.duration_ = 5.83

		local var_31_0 = {
			zh = 5.833,
			ja = 5.133
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play116011008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["2078ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect2078ui_story == nil then
				arg_31_1.var_.characterEffect2078ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.2

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect2078ui_story and not isNil(var_34_0) then
					arg_31_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect2078ui_story then
				arg_31_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_34_4 = arg_31_1.actors_["2079ui_story"]
			local var_34_5 = 0

			if var_34_5 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect2079ui_story == nil then
				arg_31_1.var_.characterEffect2079ui_story = var_34_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_6 = 0.2

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_6 and not isNil(var_34_4) then
				local var_34_7 = (arg_31_1.time_ - var_34_5) / var_34_6

				if arg_31_1.var_.characterEffect2079ui_story and not isNil(var_34_4) then
					local var_34_8 = Mathf.Lerp(0, 0.5, var_34_7)

					arg_31_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_31_1.var_.characterEffect2079ui_story.fillRatio = var_34_8
				end
			end

			if arg_31_1.time_ >= var_34_5 + var_34_6 and arg_31_1.time_ < var_34_5 + var_34_6 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect2079ui_story then
				local var_34_9 = 0.5

				arg_31_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_31_1.var_.characterEffect2079ui_story.fillRatio = var_34_9
			end

			local var_34_10 = 0
			local var_34_11 = 0.975

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_12 = arg_31_1:FormatText(StoryNameCfg[320].name)

				arg_31_1.leftNameTxt_.text = var_34_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_13 = arg_31_1:GetWordFromCfg(116011007)
				local var_34_14 = arg_31_1:FormatText(var_34_13.content)

				arg_31_1.text_.text = var_34_14

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_15 = 39
				local var_34_16 = utf8.len(var_34_14)
				local var_34_17 = var_34_15 <= 0 and var_34_11 or var_34_11 * (var_34_16 / var_34_15)

				if var_34_17 > 0 and var_34_11 < var_34_17 then
					arg_31_1.talkMaxDuration = var_34_17

					if var_34_17 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_17 + var_34_10
					end
				end

				arg_31_1.text_.text = var_34_14
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011007", "story_v_out_116011.awb") ~= 0 then
					local var_34_18 = manager.audio:GetVoiceLength("story_v_out_116011", "116011007", "story_v_out_116011.awb") / 1000

					if var_34_18 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_18 + var_34_10
					end

					if var_34_13.prefab_name ~= "" and arg_31_1.actors_[var_34_13.prefab_name] ~= nil then
						local var_34_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_13.prefab_name].transform, "story_v_out_116011", "116011007", "story_v_out_116011.awb")

						arg_31_1:RecordAudio("116011007", var_34_19)
						arg_31_1:RecordAudio("116011007", var_34_19)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_116011", "116011007", "story_v_out_116011.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_116011", "116011007", "story_v_out_116011.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_20 = math.max(var_34_11, arg_31_1.talkMaxDuration)

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_20 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_10) / var_34_20

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_10 + var_34_20 and arg_31_1.time_ < var_34_10 + var_34_20 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play116011008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 116011008
		arg_35_1.duration_ = 5.8

		local var_35_0 = {
			zh = 3.533,
			ja = 5.8
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play116011009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["2078ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect2078ui_story == nil then
				arg_35_1.var_.characterEffect2078ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect2078ui_story and not isNil(var_38_0) then
					local var_38_4 = Mathf.Lerp(0, 0.5, var_38_3)

					arg_35_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_35_1.var_.characterEffect2078ui_story.fillRatio = var_38_4
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect2078ui_story then
				local var_38_5 = 0.5

				arg_35_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_35_1.var_.characterEffect2078ui_story.fillRatio = var_38_5
			end

			local var_38_6 = arg_35_1.actors_["2079ui_story"]
			local var_38_7 = 0

			if var_38_7 < arg_35_1.time_ and arg_35_1.time_ <= var_38_7 + arg_38_0 and not isNil(var_38_6) and arg_35_1.var_.characterEffect2079ui_story == nil then
				arg_35_1.var_.characterEffect2079ui_story = var_38_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_8 = 0.2

			if var_38_7 <= arg_35_1.time_ and arg_35_1.time_ < var_38_7 + var_38_8 and not isNil(var_38_6) then
				local var_38_9 = (arg_35_1.time_ - var_38_7) / var_38_8

				if arg_35_1.var_.characterEffect2079ui_story and not isNil(var_38_6) then
					arg_35_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_7 + var_38_8 and arg_35_1.time_ < var_38_7 + var_38_8 + arg_38_0 and not isNil(var_38_6) and arg_35_1.var_.characterEffect2079ui_story then
				arg_35_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_38_10 = 0
			local var_38_11 = 0.325

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_12 = arg_35_1:FormatText(StoryNameCfg[321].name)

				arg_35_1.leftNameTxt_.text = var_38_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_13 = arg_35_1:GetWordFromCfg(116011008)
				local var_38_14 = arg_35_1:FormatText(var_38_13.content)

				arg_35_1.text_.text = var_38_14

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_15 = 13
				local var_38_16 = utf8.len(var_38_14)
				local var_38_17 = var_38_15 <= 0 and var_38_11 or var_38_11 * (var_38_16 / var_38_15)

				if var_38_17 > 0 and var_38_11 < var_38_17 then
					arg_35_1.talkMaxDuration = var_38_17

					if var_38_17 + var_38_10 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_17 + var_38_10
					end
				end

				arg_35_1.text_.text = var_38_14
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011008", "story_v_out_116011.awb") ~= 0 then
					local var_38_18 = manager.audio:GetVoiceLength("story_v_out_116011", "116011008", "story_v_out_116011.awb") / 1000

					if var_38_18 + var_38_10 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_18 + var_38_10
					end

					if var_38_13.prefab_name ~= "" and arg_35_1.actors_[var_38_13.prefab_name] ~= nil then
						local var_38_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_13.prefab_name].transform, "story_v_out_116011", "116011008", "story_v_out_116011.awb")

						arg_35_1:RecordAudio("116011008", var_38_19)
						arg_35_1:RecordAudio("116011008", var_38_19)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_116011", "116011008", "story_v_out_116011.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_116011", "116011008", "story_v_out_116011.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_20 = math.max(var_38_11, arg_35_1.talkMaxDuration)

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_20 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_10) / var_38_20

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_10 + var_38_20 and arg_35_1.time_ < var_38_10 + var_38_20 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play116011009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 116011009
		arg_39_1.duration_ = 8.77

		local var_39_0 = {
			zh = 5.6,
			ja = 8.766
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
				arg_39_0:Play116011010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.65

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[321].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:GetWordFromCfg(116011009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 26
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011009", "story_v_out_116011.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_116011", "116011009", "story_v_out_116011.awb") / 1000

					if var_42_8 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_0
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_116011", "116011009", "story_v_out_116011.awb")

						arg_39_1:RecordAudio("116011009", var_42_9)
						arg_39_1:RecordAudio("116011009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_116011", "116011009", "story_v_out_116011.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_116011", "116011009", "story_v_out_116011.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_10 and arg_39_1.time_ < var_42_0 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play116011010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 116011010
		arg_43_1.duration_ = 11.23

		local var_43_0 = {
			zh = 7.166,
			ja = 11.233
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play116011011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["2079ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect2079ui_story == nil then
				arg_43_1.var_.characterEffect2079ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect2079ui_story and not isNil(var_46_0) then
					local var_46_4 = Mathf.Lerp(0, 0.5, var_46_3)

					arg_43_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_43_1.var_.characterEffect2079ui_story.fillRatio = var_46_4
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect2079ui_story then
				local var_46_5 = 0.5

				arg_43_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_43_1.var_.characterEffect2079ui_story.fillRatio = var_46_5
			end

			local var_46_6 = 0
			local var_46_7 = 0.95

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_8 = arg_43_1:FormatText(StoryNameCfg[323].name)

				arg_43_1.leftNameTxt_.text = var_46_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_9 = arg_43_1:GetWordFromCfg(116011010)
				local var_46_10 = arg_43_1:FormatText(var_46_9.content)

				arg_43_1.text_.text = var_46_10

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_11 = 38
				local var_46_12 = utf8.len(var_46_10)
				local var_46_13 = var_46_11 <= 0 and var_46_7 or var_46_7 * (var_46_12 / var_46_11)

				if var_46_13 > 0 and var_46_7 < var_46_13 then
					arg_43_1.talkMaxDuration = var_46_13

					if var_46_13 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_6
					end
				end

				arg_43_1.text_.text = var_46_10
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011010", "story_v_out_116011.awb") ~= 0 then
					local var_46_14 = manager.audio:GetVoiceLength("story_v_out_116011", "116011010", "story_v_out_116011.awb") / 1000

					if var_46_14 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_14 + var_46_6
					end

					if var_46_9.prefab_name ~= "" and arg_43_1.actors_[var_46_9.prefab_name] ~= nil then
						local var_46_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_9.prefab_name].transform, "story_v_out_116011", "116011010", "story_v_out_116011.awb")

						arg_43_1:RecordAudio("116011010", var_46_15)
						arg_43_1:RecordAudio("116011010", var_46_15)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_116011", "116011010", "story_v_out_116011.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_116011", "116011010", "story_v_out_116011.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_16 = math.max(var_46_7, arg_43_1.talkMaxDuration)

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_16 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_6) / var_46_16

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_6 + var_46_16 and arg_43_1.time_ < var_46_6 + var_46_16 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play116011011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 116011011
		arg_47_1.duration_ = 7.13

		local var_47_0 = {
			zh = 7.133,
			ja = 6.6
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play116011012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["2078ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect2078ui_story == nil then
				arg_47_1.var_.characterEffect2078ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.2

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect2078ui_story and not isNil(var_50_0) then
					arg_47_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect2078ui_story then
				arg_47_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_50_4 = 0
			local var_50_5 = 1

			if var_50_4 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_6 = arg_47_1:FormatText(StoryNameCfg[320].name)

				arg_47_1.leftNameTxt_.text = var_50_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_7 = arg_47_1:GetWordFromCfg(116011011)
				local var_50_8 = arg_47_1:FormatText(var_50_7.content)

				arg_47_1.text_.text = var_50_8

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 40
				local var_50_10 = utf8.len(var_50_8)
				local var_50_11 = var_50_9 <= 0 and var_50_5 or var_50_5 * (var_50_10 / var_50_9)

				if var_50_11 > 0 and var_50_5 < var_50_11 then
					arg_47_1.talkMaxDuration = var_50_11

					if var_50_11 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_11 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_8
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011011", "story_v_out_116011.awb") ~= 0 then
					local var_50_12 = manager.audio:GetVoiceLength("story_v_out_116011", "116011011", "story_v_out_116011.awb") / 1000

					if var_50_12 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_4
					end

					if var_50_7.prefab_name ~= "" and arg_47_1.actors_[var_50_7.prefab_name] ~= nil then
						local var_50_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_7.prefab_name].transform, "story_v_out_116011", "116011011", "story_v_out_116011.awb")

						arg_47_1:RecordAudio("116011011", var_50_13)
						arg_47_1:RecordAudio("116011011", var_50_13)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_116011", "116011011", "story_v_out_116011.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_116011", "116011011", "story_v_out_116011.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_14 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_14 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_14

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_14 and arg_47_1.time_ < var_50_4 + var_50_14 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play116011012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 116011012
		arg_51_1.duration_ = 5.83

		local var_51_0 = {
			zh = 4.566,
			ja = 5.833
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play116011013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["2078ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect2078ui_story == nil then
				arg_51_1.var_.characterEffect2078ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.2

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect2078ui_story and not isNil(var_54_0) then
					local var_54_4 = Mathf.Lerp(0, 0.5, var_54_3)

					arg_51_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_51_1.var_.characterEffect2078ui_story.fillRatio = var_54_4
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect2078ui_story then
				local var_54_5 = 0.5

				arg_51_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_51_1.var_.characterEffect2078ui_story.fillRatio = var_54_5
			end

			local var_54_6 = 0
			local var_54_7 = 0.625

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_8 = arg_51_1:FormatText(StoryNameCfg[322].name)

				arg_51_1.leftNameTxt_.text = var_54_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_9 = arg_51_1:GetWordFromCfg(116011012)
				local var_54_10 = arg_51_1:FormatText(var_54_9.content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_11 = 25
				local var_54_12 = utf8.len(var_54_10)
				local var_54_13 = var_54_11 <= 0 and var_54_7 or var_54_7 * (var_54_12 / var_54_11)

				if var_54_13 > 0 and var_54_7 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_6
					end
				end

				arg_51_1.text_.text = var_54_10
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011012", "story_v_out_116011.awb") ~= 0 then
					local var_54_14 = manager.audio:GetVoiceLength("story_v_out_116011", "116011012", "story_v_out_116011.awb") / 1000

					if var_54_14 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_14 + var_54_6
					end

					if var_54_9.prefab_name ~= "" and arg_51_1.actors_[var_54_9.prefab_name] ~= nil then
						local var_54_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_9.prefab_name].transform, "story_v_out_116011", "116011012", "story_v_out_116011.awb")

						arg_51_1:RecordAudio("116011012", var_54_15)
						arg_51_1:RecordAudio("116011012", var_54_15)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_116011", "116011012", "story_v_out_116011.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_116011", "116011012", "story_v_out_116011.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_16 = math.max(var_54_7, arg_51_1.talkMaxDuration)

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_16 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_6) / var_54_16

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_6 + var_54_16 and arg_51_1.time_ < var_54_6 + var_54_16 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play116011013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 116011013
		arg_55_1.duration_ = 7.27

		local var_55_0 = {
			zh = 4.366,
			ja = 7.266
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
				arg_55_0:Play116011014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.625

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[323].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(116011013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 25
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011013", "story_v_out_116011.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_116011", "116011013", "story_v_out_116011.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_116011", "116011013", "story_v_out_116011.awb")

						arg_55_1:RecordAudio("116011013", var_58_9)
						arg_55_1:RecordAudio("116011013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_116011", "116011013", "story_v_out_116011.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_116011", "116011013", "story_v_out_116011.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play116011014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116011014
		arg_59_1.duration_ = 7

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play116011015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.bgs_.I05f
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				local var_62_2 = var_62_0:GetComponent("SpriteRenderer")

				if var_62_2 then
					arg_59_1.var_.alphaOldValueI05f = var_62_2.color.a
					arg_59_1.var_.alphaMatValueI05f = var_62_2
				end

				arg_59_1.var_.alphaOldValueI05f = 1
			end

			local var_62_3 = 2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_3 then
				local var_62_4 = (arg_59_1.time_ - var_62_1) / var_62_3
				local var_62_5 = Mathf.Lerp(arg_59_1.var_.alphaOldValueI05f, 0, var_62_4)

				if arg_59_1.var_.alphaMatValueI05f then
					local var_62_6 = arg_59_1.var_.alphaMatValueI05f.color

					var_62_6.a = var_62_5
					arg_59_1.var_.alphaMatValueI05f.color = var_62_6
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_3 and arg_59_1.time_ < var_62_1 + var_62_3 + arg_62_0 and arg_59_1.var_.alphaMatValueI05f then
				local var_62_7 = arg_59_1.var_.alphaMatValueI05f
				local var_62_8 = var_62_7.color

				var_62_8.a = 0
				var_62_7.color = var_62_8
			end

			local var_62_9 = 0

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			local var_62_10 = 2

			if arg_59_1.time_ >= var_62_9 + var_62_10 and arg_59_1.time_ < var_62_9 + var_62_10 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			local var_62_11 = 2
			local var_62_12 = 0.6

			if var_62_11 < arg_59_1.time_ and arg_59_1.time_ <= var_62_11 + arg_62_0 then
				local var_62_13 = "play"
				local var_62_14 = "effect"

				arg_59_1:AudioAction(var_62_13, var_62_14, "se_story_16", "se_story_16_gun_highpass", "")
			end

			local var_62_15 = arg_59_1.actors_["2078ui_story"].transform
			local var_62_16 = 0

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				arg_59_1.var_.moveOldPos2078ui_story = var_62_15.localPosition
			end

			local var_62_17 = 0.001

			if var_62_16 <= arg_59_1.time_ and arg_59_1.time_ < var_62_16 + var_62_17 then
				local var_62_18 = (arg_59_1.time_ - var_62_16) / var_62_17
				local var_62_19 = Vector3.New(0, 100, 0)

				var_62_15.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos2078ui_story, var_62_19, var_62_18)

				local var_62_20 = manager.ui.mainCamera.transform.position - var_62_15.position

				var_62_15.forward = Vector3.New(var_62_20.x, var_62_20.y, var_62_20.z)

				local var_62_21 = var_62_15.localEulerAngles

				var_62_21.z = 0
				var_62_21.x = 0
				var_62_15.localEulerAngles = var_62_21
			end

			if arg_59_1.time_ >= var_62_16 + var_62_17 and arg_59_1.time_ < var_62_16 + var_62_17 + arg_62_0 then
				var_62_15.localPosition = Vector3.New(0, 100, 0)

				local var_62_22 = manager.ui.mainCamera.transform.position - var_62_15.position

				var_62_15.forward = Vector3.New(var_62_22.x, var_62_22.y, var_62_22.z)

				local var_62_23 = var_62_15.localEulerAngles

				var_62_23.z = 0
				var_62_23.x = 0
				var_62_15.localEulerAngles = var_62_23
			end

			local var_62_24 = arg_59_1.actors_["2079ui_story"].transform
			local var_62_25 = 0

			if var_62_25 < arg_59_1.time_ and arg_59_1.time_ <= var_62_25 + arg_62_0 then
				arg_59_1.var_.moveOldPos2079ui_story = var_62_24.localPosition
			end

			local var_62_26 = 0.001

			if var_62_25 <= arg_59_1.time_ and arg_59_1.time_ < var_62_25 + var_62_26 then
				local var_62_27 = (arg_59_1.time_ - var_62_25) / var_62_26
				local var_62_28 = Vector3.New(0, 100, 0)

				var_62_24.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos2079ui_story, var_62_28, var_62_27)

				local var_62_29 = manager.ui.mainCamera.transform.position - var_62_24.position

				var_62_24.forward = Vector3.New(var_62_29.x, var_62_29.y, var_62_29.z)

				local var_62_30 = var_62_24.localEulerAngles

				var_62_30.z = 0
				var_62_30.x = 0
				var_62_24.localEulerAngles = var_62_30
			end

			if arg_59_1.time_ >= var_62_25 + var_62_26 and arg_59_1.time_ < var_62_25 + var_62_26 + arg_62_0 then
				var_62_24.localPosition = Vector3.New(0, 100, 0)

				local var_62_31 = manager.ui.mainCamera.transform.position - var_62_24.position

				var_62_24.forward = Vector3.New(var_62_31.x, var_62_31.y, var_62_31.z)

				local var_62_32 = var_62_24.localEulerAngles

				var_62_32.z = 0
				var_62_32.x = 0
				var_62_24.localEulerAngles = var_62_32
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_33 = 2
			local var_62_34 = 0.05

			if var_62_33 < arg_59_1.time_ and arg_59_1.time_ <= var_62_33 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_35 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_35:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_36 = arg_59_1:GetWordFromCfg(116011014)
				local var_62_37 = arg_59_1:FormatText(var_62_36.content)

				arg_59_1.text_.text = var_62_37

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_38 = 2
				local var_62_39 = utf8.len(var_62_37)
				local var_62_40 = var_62_38 <= 0 and var_62_34 or var_62_34 * (var_62_39 / var_62_38)

				if var_62_40 > 0 and var_62_34 < var_62_40 then
					arg_59_1.talkMaxDuration = var_62_40
					var_62_33 = var_62_33 + 0.3

					if var_62_40 + var_62_33 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_40 + var_62_33
					end
				end

				arg_59_1.text_.text = var_62_37
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_41 = var_62_33 + 0.3
			local var_62_42 = math.max(var_62_34, arg_59_1.talkMaxDuration)

			if var_62_41 <= arg_59_1.time_ and arg_59_1.time_ < var_62_41 + var_62_42 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_41) / var_62_42

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_41 + var_62_42 and arg_59_1.time_ < var_62_41 + var_62_42 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play116011015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116011015
		arg_65_1.duration_ = 4.63

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play116011016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.bgs_.I05f
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				local var_68_2 = var_68_0:GetComponent("SpriteRenderer")

				if var_68_2 then
					arg_65_1.var_.alphaOldValueI05f = var_68_2.color.a
					arg_65_1.var_.alphaMatValueI05f = var_68_2
				end

				arg_65_1.var_.alphaOldValueI05f = 0
			end

			local var_68_3 = 2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_3 then
				local var_68_4 = (arg_65_1.time_ - var_68_1) / var_68_3
				local var_68_5 = Mathf.Lerp(arg_65_1.var_.alphaOldValueI05f, 1, var_68_4)

				if arg_65_1.var_.alphaMatValueI05f then
					local var_68_6 = arg_65_1.var_.alphaMatValueI05f.color

					var_68_6.a = var_68_5
					arg_65_1.var_.alphaMatValueI05f.color = var_68_6
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_3 and arg_65_1.time_ < var_68_1 + var_68_3 + arg_68_0 and arg_65_1.var_.alphaMatValueI05f then
				local var_68_7 = arg_65_1.var_.alphaMatValueI05f
				local var_68_8 = var_68_7.color

				var_68_8.a = 1
				var_68_7.color = var_68_8
			end

			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			local var_68_10 = 2

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_11 = arg_65_1.actors_["2078ui_story"].transform
			local var_68_12 = 1.8

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.var_.moveOldPos2078ui_story = var_68_11.localPosition
			end

			local var_68_13 = 0.001

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 then
				local var_68_14 = (arg_65_1.time_ - var_68_12) / var_68_13
				local var_68_15 = Vector3.New(-0.7, -1.28, -5.6)

				var_68_11.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos2078ui_story, var_68_15, var_68_14)

				local var_68_16 = manager.ui.mainCamera.transform.position - var_68_11.position

				var_68_11.forward = Vector3.New(var_68_16.x, var_68_16.y, var_68_16.z)

				local var_68_17 = var_68_11.localEulerAngles

				var_68_17.z = 0
				var_68_17.x = 0
				var_68_11.localEulerAngles = var_68_17
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 then
				var_68_11.localPosition = Vector3.New(-0.7, -1.28, -5.6)

				local var_68_18 = manager.ui.mainCamera.transform.position - var_68_11.position

				var_68_11.forward = Vector3.New(var_68_18.x, var_68_18.y, var_68_18.z)

				local var_68_19 = var_68_11.localEulerAngles

				var_68_19.z = 0
				var_68_19.x = 0
				var_68_11.localEulerAngles = var_68_19
			end

			local var_68_20 = 1.8

			if var_68_20 < arg_65_1.time_ and arg_65_1.time_ <= var_68_20 + arg_68_0 then
				arg_65_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_68_21 = arg_65_1.actors_["2079ui_story"].transform
			local var_68_22 = 1.8

			if var_68_22 < arg_65_1.time_ and arg_65_1.time_ <= var_68_22 + arg_68_0 then
				arg_65_1.var_.moveOldPos2079ui_story = var_68_21.localPosition
			end

			local var_68_23 = 0.001

			if var_68_22 <= arg_65_1.time_ and arg_65_1.time_ < var_68_22 + var_68_23 then
				local var_68_24 = (arg_65_1.time_ - var_68_22) / var_68_23
				local var_68_25 = Vector3.New(0.7, -1.28, -5.6)

				var_68_21.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos2079ui_story, var_68_25, var_68_24)

				local var_68_26 = manager.ui.mainCamera.transform.position - var_68_21.position

				var_68_21.forward = Vector3.New(var_68_26.x, var_68_26.y, var_68_26.z)

				local var_68_27 = var_68_21.localEulerAngles

				var_68_27.z = 0
				var_68_27.x = 0
				var_68_21.localEulerAngles = var_68_27
			end

			if arg_65_1.time_ >= var_68_22 + var_68_23 and arg_65_1.time_ < var_68_22 + var_68_23 + arg_68_0 then
				var_68_21.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_68_28 = manager.ui.mainCamera.transform.position - var_68_21.position

				var_68_21.forward = Vector3.New(var_68_28.x, var_68_28.y, var_68_28.z)

				local var_68_29 = var_68_21.localEulerAngles

				var_68_29.z = 0
				var_68_29.x = 0
				var_68_21.localEulerAngles = var_68_29
			end

			local var_68_30 = 1.8

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 then
				arg_65_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_68_31 = arg_65_1.actors_["2078ui_story"]
			local var_68_32 = 1.8

			if var_68_32 < arg_65_1.time_ and arg_65_1.time_ <= var_68_32 + arg_68_0 and not isNil(var_68_31) and arg_65_1.var_.characterEffect2078ui_story == nil then
				arg_65_1.var_.characterEffect2078ui_story = var_68_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_33 = 0.2

			if var_68_32 <= arg_65_1.time_ and arg_65_1.time_ < var_68_32 + var_68_33 and not isNil(var_68_31) then
				local var_68_34 = (arg_65_1.time_ - var_68_32) / var_68_33

				if arg_65_1.var_.characterEffect2078ui_story and not isNil(var_68_31) then
					local var_68_35 = Mathf.Lerp(0, 0.5, var_68_34)

					arg_65_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_65_1.var_.characterEffect2078ui_story.fillRatio = var_68_35
				end
			end

			if arg_65_1.time_ >= var_68_32 + var_68_33 and arg_65_1.time_ < var_68_32 + var_68_33 + arg_68_0 and not isNil(var_68_31) and arg_65_1.var_.characterEffect2078ui_story then
				local var_68_36 = 0.5

				arg_65_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_65_1.var_.characterEffect2078ui_story.fillRatio = var_68_36
			end

			local var_68_37 = arg_65_1.actors_["2079ui_story"]
			local var_68_38 = 1.8

			if var_68_38 < arg_65_1.time_ and arg_65_1.time_ <= var_68_38 + arg_68_0 and not isNil(var_68_37) and arg_65_1.var_.characterEffect2079ui_story == nil then
				arg_65_1.var_.characterEffect2079ui_story = var_68_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_39 = 0.2

			if var_68_38 <= arg_65_1.time_ and arg_65_1.time_ < var_68_38 + var_68_39 and not isNil(var_68_37) then
				local var_68_40 = (arg_65_1.time_ - var_68_38) / var_68_39

				if arg_65_1.var_.characterEffect2079ui_story and not isNil(var_68_37) then
					arg_65_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_38 + var_68_39 and arg_65_1.time_ < var_68_38 + var_68_39 + arg_68_0 and not isNil(var_68_37) and arg_65_1.var_.characterEffect2079ui_story then
				arg_65_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_41 = 2
			local var_68_42 = 0.15

			if var_68_41 < arg_65_1.time_ and arg_65_1.time_ <= var_68_41 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_43 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_43:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_44 = arg_65_1:FormatText(StoryNameCfg[321].name)

				arg_65_1.leftNameTxt_.text = var_68_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_45 = arg_65_1:GetWordFromCfg(116011015)
				local var_68_46 = arg_65_1:FormatText(var_68_45.content)

				arg_65_1.text_.text = var_68_46

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_47 = 6
				local var_68_48 = utf8.len(var_68_46)
				local var_68_49 = var_68_47 <= 0 and var_68_42 or var_68_42 * (var_68_48 / var_68_47)

				if var_68_49 > 0 and var_68_42 < var_68_49 then
					arg_65_1.talkMaxDuration = var_68_49
					var_68_41 = var_68_41 + 0.3

					if var_68_49 + var_68_41 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_49 + var_68_41
					end
				end

				arg_65_1.text_.text = var_68_46
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011015", "story_v_out_116011.awb") ~= 0 then
					local var_68_50 = manager.audio:GetVoiceLength("story_v_out_116011", "116011015", "story_v_out_116011.awb") / 1000

					if var_68_50 + var_68_41 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_50 + var_68_41
					end

					if var_68_45.prefab_name ~= "" and arg_65_1.actors_[var_68_45.prefab_name] ~= nil then
						local var_68_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_45.prefab_name].transform, "story_v_out_116011", "116011015", "story_v_out_116011.awb")

						arg_65_1:RecordAudio("116011015", var_68_51)
						arg_65_1:RecordAudio("116011015", var_68_51)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_116011", "116011015", "story_v_out_116011.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_116011", "116011015", "story_v_out_116011.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_52 = var_68_41 + 0.3
			local var_68_53 = math.max(var_68_42, arg_65_1.talkMaxDuration)

			if var_68_52 <= arg_65_1.time_ and arg_65_1.time_ < var_68_52 + var_68_53 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_52) / var_68_53

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_52 + var_68_53 and arg_65_1.time_ < var_68_52 + var_68_53 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play116011016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116011016
		arg_71_1.duration_ = 5.47

		local var_71_0 = {
			zh = 3.766,
			ja = 5.466
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
				arg_71_0:Play116011017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["2079ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect2079ui_story == nil then
				arg_71_1.var_.characterEffect2079ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect2079ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_71_1.var_.characterEffect2079ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect2079ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_71_1.var_.characterEffect2079ui_story.fillRatio = var_74_5
			end

			local var_74_6 = arg_71_1.actors_["2078ui_story"]
			local var_74_7 = 0

			if var_74_7 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect2078ui_story == nil then
				arg_71_1.var_.characterEffect2078ui_story = var_74_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_8 = 0.2

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_8 and not isNil(var_74_6) then
				local var_74_9 = (arg_71_1.time_ - var_74_7) / var_74_8

				if arg_71_1.var_.characterEffect2078ui_story and not isNil(var_74_6) then
					arg_71_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_7 + var_74_8 and arg_71_1.time_ < var_74_7 + var_74_8 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect2078ui_story then
				arg_71_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_74_10 = 0
			local var_74_11 = 0.475

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_12 = arg_71_1:FormatText(StoryNameCfg[322].name)

				arg_71_1.leftNameTxt_.text = var_74_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_13 = arg_71_1:GetWordFromCfg(116011016)
				local var_74_14 = arg_71_1:FormatText(var_74_13.content)

				arg_71_1.text_.text = var_74_14

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_15 = 19
				local var_74_16 = utf8.len(var_74_14)
				local var_74_17 = var_74_15 <= 0 and var_74_11 or var_74_11 * (var_74_16 / var_74_15)

				if var_74_17 > 0 and var_74_11 < var_74_17 then
					arg_71_1.talkMaxDuration = var_74_17

					if var_74_17 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_17 + var_74_10
					end
				end

				arg_71_1.text_.text = var_74_14
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011016", "story_v_out_116011.awb") ~= 0 then
					local var_74_18 = manager.audio:GetVoiceLength("story_v_out_116011", "116011016", "story_v_out_116011.awb") / 1000

					if var_74_18 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_18 + var_74_10
					end

					if var_74_13.prefab_name ~= "" and arg_71_1.actors_[var_74_13.prefab_name] ~= nil then
						local var_74_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_13.prefab_name].transform, "story_v_out_116011", "116011016", "story_v_out_116011.awb")

						arg_71_1:RecordAudio("116011016", var_74_19)
						arg_71_1:RecordAudio("116011016", var_74_19)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_116011", "116011016", "story_v_out_116011.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_116011", "116011016", "story_v_out_116011.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_20 = math.max(var_74_11, arg_71_1.talkMaxDuration)

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_20 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_10) / var_74_20

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_10 + var_74_20 and arg_71_1.time_ < var_74_10 + var_74_20 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play116011017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116011017
		arg_75_1.duration_ = 9.03

		local var_75_0 = {
			zh = 7.633,
			ja = 9.033
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
				arg_75_0:Play116011018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = manager.ui.mainCamera.transform
			local var_78_1 = 2.9

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.shakeOldPos = var_78_0.localPosition
			end

			local var_78_2 = 0.6

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / 0.066
				local var_78_4, var_78_5 = math.modf(var_78_3)

				var_78_0.localPosition = Vector3.New(var_78_5 * 0.13, var_78_5 * 0.13, var_78_5 * 0.13) + arg_75_1.var_.shakeOldPos
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = arg_75_1.var_.shakeOldPos
			end

			local var_78_6 = 0

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			local var_78_7 = 3.6

			if arg_75_1.time_ >= var_78_6 + var_78_7 and arg_75_1.time_ < var_78_6 + var_78_7 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			local var_78_8 = arg_75_1.actors_["2078ui_story"].transform
			local var_78_9 = 0

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1.var_.moveOldPos2078ui_story = var_78_8.localPosition
			end

			local var_78_10 = 0.001

			if var_78_9 <= arg_75_1.time_ and arg_75_1.time_ < var_78_9 + var_78_10 then
				local var_78_11 = (arg_75_1.time_ - var_78_9) / var_78_10
				local var_78_12 = Vector3.New(0, 100, 0)

				var_78_8.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos2078ui_story, var_78_12, var_78_11)

				local var_78_13 = manager.ui.mainCamera.transform.position - var_78_8.position

				var_78_8.forward = Vector3.New(var_78_13.x, var_78_13.y, var_78_13.z)

				local var_78_14 = var_78_8.localEulerAngles

				var_78_14.z = 0
				var_78_14.x = 0
				var_78_8.localEulerAngles = var_78_14
			end

			if arg_75_1.time_ >= var_78_9 + var_78_10 and arg_75_1.time_ < var_78_9 + var_78_10 + arg_78_0 then
				var_78_8.localPosition = Vector3.New(0, 100, 0)

				local var_78_15 = manager.ui.mainCamera.transform.position - var_78_8.position

				var_78_8.forward = Vector3.New(var_78_15.x, var_78_15.y, var_78_15.z)

				local var_78_16 = var_78_8.localEulerAngles

				var_78_16.z = 0
				var_78_16.x = 0
				var_78_8.localEulerAngles = var_78_16
			end

			local var_78_17 = arg_75_1.actors_["2079ui_story"].transform
			local var_78_18 = 0

			if var_78_18 < arg_75_1.time_ and arg_75_1.time_ <= var_78_18 + arg_78_0 then
				arg_75_1.var_.moveOldPos2079ui_story = var_78_17.localPosition
			end

			local var_78_19 = 0.001

			if var_78_18 <= arg_75_1.time_ and arg_75_1.time_ < var_78_18 + var_78_19 then
				local var_78_20 = (arg_75_1.time_ - var_78_18) / var_78_19
				local var_78_21 = Vector3.New(0, 100, 0)

				var_78_17.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos2079ui_story, var_78_21, var_78_20)

				local var_78_22 = manager.ui.mainCamera.transform.position - var_78_17.position

				var_78_17.forward = Vector3.New(var_78_22.x, var_78_22.y, var_78_22.z)

				local var_78_23 = var_78_17.localEulerAngles

				var_78_23.z = 0
				var_78_23.x = 0
				var_78_17.localEulerAngles = var_78_23
			end

			if arg_75_1.time_ >= var_78_18 + var_78_19 and arg_75_1.time_ < var_78_18 + var_78_19 + arg_78_0 then
				var_78_17.localPosition = Vector3.New(0, 100, 0)

				local var_78_24 = manager.ui.mainCamera.transform.position - var_78_17.position

				var_78_17.forward = Vector3.New(var_78_24.x, var_78_24.y, var_78_24.z)

				local var_78_25 = var_78_17.localEulerAngles

				var_78_25.z = 0
				var_78_25.x = 0
				var_78_17.localEulerAngles = var_78_25
			end

			local var_78_26 = 0
			local var_78_27 = 0.475

			if var_78_26 < arg_75_1.time_ and arg_75_1.time_ <= var_78_26 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_28 = arg_75_1:FormatText(StoryNameCfg[323].name)

				arg_75_1.leftNameTxt_.text = var_78_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_29 = arg_75_1:GetWordFromCfg(116011017)
				local var_78_30 = arg_75_1:FormatText(var_78_29.content)

				arg_75_1.text_.text = var_78_30

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_31 = 19
				local var_78_32 = utf8.len(var_78_30)
				local var_78_33 = var_78_31 <= 0 and var_78_27 or var_78_27 * (var_78_32 / var_78_31)

				if var_78_33 > 0 and var_78_27 < var_78_33 then
					arg_75_1.talkMaxDuration = var_78_33

					if var_78_33 + var_78_26 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_33 + var_78_26
					end
				end

				arg_75_1.text_.text = var_78_30
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011017", "story_v_out_116011.awb") ~= 0 then
					local var_78_34 = manager.audio:GetVoiceLength("story_v_out_116011", "116011017", "story_v_out_116011.awb") / 1000

					if var_78_34 + var_78_26 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_34 + var_78_26
					end

					if var_78_29.prefab_name ~= "" and arg_75_1.actors_[var_78_29.prefab_name] ~= nil then
						local var_78_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_29.prefab_name].transform, "story_v_out_116011", "116011017", "story_v_out_116011.awb")

						arg_75_1:RecordAudio("116011017", var_78_35)
						arg_75_1:RecordAudio("116011017", var_78_35)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_116011", "116011017", "story_v_out_116011.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_116011", "116011017", "story_v_out_116011.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_36 = math.max(var_78_27, arg_75_1.talkMaxDuration)

			if var_78_26 <= arg_75_1.time_ and arg_75_1.time_ < var_78_26 + var_78_36 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_26) / var_78_36

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_26 + var_78_36 and arg_75_1.time_ < var_78_26 + var_78_36 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play116011018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116011018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play116011019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.1

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_2 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_2:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:GetWordFromCfg(116011018)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 16
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7
					var_82_0 = var_82_0 + 0.3

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = var_82_0 + 0.3
			local var_82_9 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_9 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_9

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_9 and arg_79_1.time_ < var_82_8 + var_82_9 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play116011019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 116011019
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play116011020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.4

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(116011019)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 23
				local var_88_5 = utf8.len(var_88_3)
				local var_88_6 = var_88_4 <= 0 and var_88_1 or var_88_1 * (var_88_5 / var_88_4)

				if var_88_6 > 0 and var_88_1 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_7 and arg_85_1.time_ < var_88_0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play116011020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116011020
		arg_89_1.duration_ = 9.2

		local var_89_0 = {
			zh = 5.166,
			ja = 9.2
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
				arg_89_0:Play116011021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["2079ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos2079ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -1.28, -5.6)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos2079ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_92_10 = arg_89_1.actors_["2079ui_story"]
			local var_92_11 = 0

			if var_92_11 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 and not isNil(var_92_10) and arg_89_1.var_.characterEffect2079ui_story == nil then
				arg_89_1.var_.characterEffect2079ui_story = var_92_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_12 = 0.2

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_12 and not isNil(var_92_10) then
				local var_92_13 = (arg_89_1.time_ - var_92_11) / var_92_12

				if arg_89_1.var_.characterEffect2079ui_story and not isNil(var_92_10) then
					arg_89_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_11 + var_92_12 and arg_89_1.time_ < var_92_11 + var_92_12 + arg_92_0 and not isNil(var_92_10) and arg_89_1.var_.characterEffect2079ui_story then
				arg_89_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_92_14 = 0
			local var_92_15 = 0.6

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_16 = arg_89_1:FormatText(StoryNameCfg[321].name)

				arg_89_1.leftNameTxt_.text = var_92_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_17 = arg_89_1:GetWordFromCfg(116011020)
				local var_92_18 = arg_89_1:FormatText(var_92_17.content)

				arg_89_1.text_.text = var_92_18

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_19 = 24
				local var_92_20 = utf8.len(var_92_18)
				local var_92_21 = var_92_19 <= 0 and var_92_15 or var_92_15 * (var_92_20 / var_92_19)

				if var_92_21 > 0 and var_92_15 < var_92_21 then
					arg_89_1.talkMaxDuration = var_92_21

					if var_92_21 + var_92_14 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_21 + var_92_14
					end
				end

				arg_89_1.text_.text = var_92_18
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011020", "story_v_out_116011.awb") ~= 0 then
					local var_92_22 = manager.audio:GetVoiceLength("story_v_out_116011", "116011020", "story_v_out_116011.awb") / 1000

					if var_92_22 + var_92_14 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_14
					end

					if var_92_17.prefab_name ~= "" and arg_89_1.actors_[var_92_17.prefab_name] ~= nil then
						local var_92_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_17.prefab_name].transform, "story_v_out_116011", "116011020", "story_v_out_116011.awb")

						arg_89_1:RecordAudio("116011020", var_92_23)
						arg_89_1:RecordAudio("116011020", var_92_23)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_116011", "116011020", "story_v_out_116011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_116011", "116011020", "story_v_out_116011.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_24 = math.max(var_92_15, arg_89_1.talkMaxDuration)

			if var_92_14 <= arg_89_1.time_ and arg_89_1.time_ < var_92_14 + var_92_24 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_14) / var_92_24

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_14 + var_92_24 and arg_89_1.time_ < var_92_14 + var_92_24 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play116011021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 116011021
		arg_93_1.duration_ = 2.53

		local var_93_0 = {
			zh = 2.133,
			ja = 2.533
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
				arg_93_0:Play116011022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["2079ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect2079ui_story == nil then
				arg_93_1.var_.characterEffect2079ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect2079ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_93_1.var_.characterEffect2079ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect2079ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_93_1.var_.characterEffect2079ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 0.3

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[320].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_9 = arg_93_1:GetWordFromCfg(116011021)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 12
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011021", "story_v_out_116011.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_116011", "116011021", "story_v_out_116011.awb") / 1000

					if var_96_14 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_6
					end

					if var_96_9.prefab_name ~= "" and arg_93_1.actors_[var_96_9.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_9.prefab_name].transform, "story_v_out_116011", "116011021", "story_v_out_116011.awb")

						arg_93_1:RecordAudio("116011021", var_96_15)
						arg_93_1:RecordAudio("116011021", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_116011", "116011021", "story_v_out_116011.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_116011", "116011021", "story_v_out_116011.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_16 and arg_93_1.time_ < var_96_6 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play116011022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 116011022
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play116011023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["2079ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos2079ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, 100, 0)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos2079ui_story, var_100_4, var_100_3)

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

			local var_100_9 = 0
			local var_100_10 = 1.025

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_11 = arg_97_1:GetWordFromCfg(116011022)
				local var_100_12 = arg_97_1:FormatText(var_100_11.content)

				arg_97_1.text_.text = var_100_12

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 41
				local var_100_14 = utf8.len(var_100_12)
				local var_100_15 = var_100_13 <= 0 and var_100_10 or var_100_10 * (var_100_14 / var_100_13)

				if var_100_15 > 0 and var_100_10 < var_100_15 then
					arg_97_1.talkMaxDuration = var_100_15

					if var_100_15 + var_100_9 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_15 + var_100_9
					end
				end

				arg_97_1.text_.text = var_100_12
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_10, arg_97_1.talkMaxDuration)

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_9) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_9 + var_100_16 and arg_97_1.time_ < var_100_9 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play116011023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 116011023
		arg_101_1.duration_ = 6.4

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play116011024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = manager.ui.mainCamera.transform
			local var_104_1 = 1.4

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.shakeOldPos = var_104_0.localPosition
			end

			local var_104_2 = 0.6

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / 0.066
				local var_104_4, var_104_5 = math.modf(var_104_3)

				var_104_0.localPosition = Vector3.New(var_104_5 * 0.13, var_104_5 * 0.13, var_104_5 * 0.13) + arg_101_1.var_.shakeOldPos
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = arg_101_1.var_.shakeOldPos
			end

			local var_104_6 = 1.4

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			local var_104_7 = 0.6

			if arg_101_1.time_ >= var_104_6 + var_104_7 and arg_101_1.time_ < var_104_6 + var_104_7 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_8 = arg_101_1.bgs_.I05f
			local var_104_9 = 0

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				local var_104_10 = var_104_8:GetComponent("SpriteRenderer")

				if var_104_10 then
					arg_101_1.var_.alphaOldValueI05f = var_104_10.color.a
					arg_101_1.var_.alphaMatValueI05f = var_104_10
				end

				arg_101_1.var_.alphaOldValueI05f = 1
			end

			local var_104_11 = 2

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_11 then
				local var_104_12 = (arg_101_1.time_ - var_104_9) / var_104_11
				local var_104_13 = Mathf.Lerp(arg_101_1.var_.alphaOldValueI05f, 0, var_104_12)

				if arg_101_1.var_.alphaMatValueI05f then
					local var_104_14 = arg_101_1.var_.alphaMatValueI05f.color

					var_104_14.a = var_104_13
					arg_101_1.var_.alphaMatValueI05f.color = var_104_14
				end
			end

			if arg_101_1.time_ >= var_104_9 + var_104_11 and arg_101_1.time_ < var_104_9 + var_104_11 + arg_104_0 and arg_101_1.var_.alphaMatValueI05f then
				local var_104_15 = arg_101_1.var_.alphaMatValueI05f
				local var_104_16 = var_104_15.color

				var_104_16.a = 0
				var_104_15.color = var_104_16
			end

			local var_104_17 = 1.4
			local var_104_18 = 1

			if var_104_17 < arg_101_1.time_ and arg_101_1.time_ <= var_104_17 + arg_104_0 then
				local var_104_19 = "play"
				local var_104_20 = "effect"

				arg_101_1:AudioAction(var_104_19, var_104_20, "se_story_16", "se_story_16_gun_highpass", "")
			end

			local var_104_21 = 1.4
			local var_104_22 = 0.1

			if var_104_21 < arg_101_1.time_ and arg_101_1.time_ <= var_104_21 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_23 = arg_101_1:FormatText(StoryNameCfg[324].name)

				arg_101_1.leftNameTxt_.text = var_104_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_24 = arg_101_1:GetWordFromCfg(116011023)
				local var_104_25 = arg_101_1:FormatText(var_104_24.content)

				arg_101_1.text_.text = var_104_25

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_26 = 4
				local var_104_27 = utf8.len(var_104_25)
				local var_104_28 = var_104_26 <= 0 and var_104_22 or var_104_22 * (var_104_27 / var_104_26)

				if var_104_28 > 0 and var_104_22 < var_104_28 then
					arg_101_1.talkMaxDuration = var_104_28

					if var_104_28 + var_104_21 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_28 + var_104_21
					end
				end

				arg_101_1.text_.text = var_104_25
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_29 = math.max(var_104_22, arg_101_1.talkMaxDuration)

			if var_104_21 <= arg_101_1.time_ and arg_101_1.time_ < var_104_21 + var_104_29 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_21) / var_104_29

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_21 + var_104_29 and arg_101_1.time_ < var_104_21 + var_104_29 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play116011024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 116011024
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play116011025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.275

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				local var_108_2 = "play"
				local var_108_3 = "effect"

				arg_105_1:AudioAction(var_108_2, var_108_3, "se_story_16", "se_story_16_gun_highpass", "")
			end

			local var_108_4 = 0.275
			local var_108_5 = 0.366666666666667

			if var_108_4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				local var_108_6 = "play"
				local var_108_7 = "effect"

				arg_105_1:AudioAction(var_108_6, var_108_7, "se_story_16", "se_story_16_gun_highpass", "")
			end

			local var_108_8 = 0.433333333333333
			local var_108_9 = 0.466666666666667

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				local var_108_10 = "play"
				local var_108_11 = "effect"

				arg_105_1:AudioAction(var_108_10, var_108_11, "se_story_16", "se_story_16_gun_highpass", "")
			end

			local var_108_12 = 0
			local var_108_13 = 0.275

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_14 = arg_105_1:FormatText(StoryNameCfg[324].name)

				arg_105_1.leftNameTxt_.text = var_108_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_15 = arg_105_1:GetWordFromCfg(116011024)
				local var_108_16 = arg_105_1:FormatText(var_108_15.content)

				arg_105_1.text_.text = var_108_16

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 11
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
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_20 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_20 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_12) / var_108_20

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_20 and arg_105_1.time_ < var_108_12 + var_108_20 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play116011025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116011025
		arg_109_1.duration_ = 7

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play116011026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = "ST02"

			if arg_109_1.bgs_[var_112_0] == nil then
				local var_112_1 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_112_0)
				var_112_1.name = var_112_0
				var_112_1.transform.parent = arg_109_1.stage_.transform
				var_112_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_[var_112_0] = var_112_1
			end

			local var_112_2 = 0

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				local var_112_3 = manager.ui.mainCamera.transform.localPosition
				local var_112_4 = Vector3.New(0, 0, 10) + Vector3.New(var_112_3.x, var_112_3.y, 0)
				local var_112_5 = arg_109_1.bgs_.ST02

				var_112_5.transform.localPosition = var_112_4
				var_112_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_6 = var_112_5:GetComponent("SpriteRenderer")

				if var_112_6 and var_112_6.sprite then
					local var_112_7 = (var_112_5.transform.localPosition - var_112_3).z
					local var_112_8 = manager.ui.mainCameraCom_
					local var_112_9 = 2 * var_112_7 * Mathf.Tan(var_112_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_112_10 = var_112_9 * var_112_8.aspect
					local var_112_11 = var_112_6.sprite.bounds.size.x
					local var_112_12 = var_112_6.sprite.bounds.size.y
					local var_112_13 = var_112_10 / var_112_11
					local var_112_14 = var_112_9 / var_112_12
					local var_112_15 = var_112_14 < var_112_13 and var_112_13 or var_112_14

					var_112_5.transform.localScale = Vector3.New(var_112_15, var_112_15, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "ST02" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_17 = 2

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17
				local var_112_19 = Color.New(0, 0, 0)

				var_112_19.a = Mathf.Lerp(1, 0, var_112_18)
				arg_109_1.mask_.color = var_112_19
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 then
				local var_112_20 = Color.New(0, 0, 0)
				local var_112_21 = 0

				arg_109_1.mask_.enabled = false
				var_112_20.a = var_112_21
				arg_109_1.mask_.color = var_112_20
			end

			local var_112_22 = 0
			local var_112_23 = 1

			if var_112_22 < arg_109_1.time_ and arg_109_1.time_ <= var_112_22 + arg_112_0 then
				local var_112_24 = "play"
				local var_112_25 = "music"

				arg_109_1:AudioAction(var_112_24, var_112_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_112_26 = ""
				local var_112_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_112_27 ~= "" then
					if arg_109_1.bgmTxt_.text ~= var_112_27 and arg_109_1.bgmTxt_.text ~= "" then
						if arg_109_1.bgmTxt2_.text ~= "" then
							arg_109_1.bgmTxt_.text = arg_109_1.bgmTxt2_.text
						end

						arg_109_1.bgmTxt2_.text = var_112_27

						arg_109_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_109_1.bgmTxt_.text = var_112_27
						arg_109_1.bgmTxt2_.text = var_112_27
					end

					if arg_109_1.bgmTimer then
						arg_109_1.bgmTimer:Stop()

						arg_109_1.bgmTimer = nil
					end

					if arg_109_1.settingData.show_music_name == 1 then
						arg_109_1.musicController:SetSelectedState("show")
						arg_109_1.musicAnimator_:Play("open", 0, 0)

						if arg_109_1.settingData.music_time ~= 0 then
							arg_109_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_109_1.settingData.music_time), function()
								if arg_109_1 == nil or isNil(arg_109_1.bgmTxt_) then
									return
								end

								arg_109_1.musicController:SetSelectedState("hide")
								arg_109_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_112_28 = 1.9
			local var_112_29 = 1

			if var_112_28 < arg_109_1.time_ and arg_109_1.time_ <= var_112_28 + arg_112_0 then
				local var_112_30 = "play"
				local var_112_31 = "music"

				arg_109_1:AudioAction(var_112_30, var_112_31, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_112_32 = ""
				local var_112_33 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_112_33 ~= "" then
					if arg_109_1.bgmTxt_.text ~= var_112_33 and arg_109_1.bgmTxt_.text ~= "" then
						if arg_109_1.bgmTxt2_.text ~= "" then
							arg_109_1.bgmTxt_.text = arg_109_1.bgmTxt2_.text
						end

						arg_109_1.bgmTxt2_.text = var_112_33

						arg_109_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_109_1.bgmTxt_.text = var_112_33
						arg_109_1.bgmTxt2_.text = var_112_33
					end

					if arg_109_1.bgmTimer then
						arg_109_1.bgmTimer:Stop()

						arg_109_1.bgmTimer = nil
					end

					if arg_109_1.settingData.show_music_name == 1 then
						arg_109_1.musicController:SetSelectedState("show")
						arg_109_1.musicAnimator_:Play("open", 0, 0)

						if arg_109_1.settingData.music_time ~= 0 then
							arg_109_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_109_1.settingData.music_time), function()
								if arg_109_1 == nil or isNil(arg_109_1.bgmTxt_) then
									return
								end

								arg_109_1.musicController:SetSelectedState("hide")
								arg_109_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_34 = 2
			local var_112_35 = 0.775

			if var_112_34 < arg_109_1.time_ and arg_109_1.time_ <= var_112_34 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_36 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_36:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_109_1.dialogCg_.alpha = arg_115_0
				end))
				var_112_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_37 = arg_109_1:GetWordFromCfg(116011025)
				local var_112_38 = arg_109_1:FormatText(var_112_37.content)

				arg_109_1.text_.text = var_112_38

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_39 = 31
				local var_112_40 = utf8.len(var_112_38)
				local var_112_41 = var_112_39 <= 0 and var_112_35 or var_112_35 * (var_112_40 / var_112_39)

				if var_112_41 > 0 and var_112_35 < var_112_41 then
					arg_109_1.talkMaxDuration = var_112_41
					var_112_34 = var_112_34 + 0.3

					if var_112_41 + var_112_34 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_41 + var_112_34
					end
				end

				arg_109_1.text_.text = var_112_38
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_42 = var_112_34 + 0.3
			local var_112_43 = math.max(var_112_35, arg_109_1.talkMaxDuration)

			if var_112_42 <= arg_109_1.time_ and arg_109_1.time_ < var_112_42 + var_112_43 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_42) / var_112_43

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_42 + var_112_43 and arg_109_1.time_ < var_112_42 + var_112_43 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play116011026 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116011026
		arg_117_1.duration_ = 9.17

		local var_117_0 = {
			zh = 7.266,
			ja = 9.166
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
				arg_117_0:Play116011027(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = "1048ui_story"

			if arg_117_1.actors_[var_120_0] == nil then
				local var_120_1 = Asset.Load("Char/" .. "1048ui_story")

				if not isNil(var_120_1) then
					local var_120_2 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_117_1.stage_.transform)

					var_120_2.name = var_120_0
					var_120_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_117_1.actors_[var_120_0] = var_120_2

					local var_120_3 = var_120_2:GetComponentInChildren(typeof(CharacterEffect))

					var_120_3.enabled = true

					local var_120_4 = GameObjectTools.GetOrAddComponent(var_120_2, typeof(DynamicBoneHelper))

					if var_120_4 then
						var_120_4:EnableDynamicBone(false)
					end

					arg_117_1:ShowWeapon(var_120_3.transform, false)

					arg_117_1.var_[var_120_0 .. "Animator"] = var_120_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_117_1.var_[var_120_0 .. "Animator"].applyRootMotion = true
					arg_117_1.var_[var_120_0 .. "LipSync"] = var_120_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_120_5 = arg_117_1.actors_["1048ui_story"]
			local var_120_6 = 0

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1048ui_story == nil then
				arg_117_1.var_.characterEffect1048ui_story = var_120_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_7 = 0.034

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_7 and not isNil(var_120_5) then
				local var_120_8 = (arg_117_1.time_ - var_120_6) / var_120_7

				if arg_117_1.var_.characterEffect1048ui_story and not isNil(var_120_5) then
					arg_117_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_6 + var_120_7 and arg_117_1.time_ < var_120_6 + var_120_7 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1048ui_story then
				arg_117_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_120_9 = arg_117_1.actors_["1048ui_story"].transform
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1.var_.moveOldPos1048ui_story = var_120_9.localPosition
			end

			local var_120_11 = 0.001

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11
				local var_120_13 = Vector3.New(0.7, -0.8, -6.2)

				var_120_9.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1048ui_story, var_120_13, var_120_12)

				local var_120_14 = manager.ui.mainCamera.transform.position - var_120_9.position

				var_120_9.forward = Vector3.New(var_120_14.x, var_120_14.y, var_120_14.z)

				local var_120_15 = var_120_9.localEulerAngles

				var_120_15.z = 0
				var_120_15.x = 0
				var_120_9.localEulerAngles = var_120_15
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 then
				var_120_9.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_120_16 = manager.ui.mainCamera.transform.position - var_120_9.position

				var_120_9.forward = Vector3.New(var_120_16.x, var_120_16.y, var_120_16.z)

				local var_120_17 = var_120_9.localEulerAngles

				var_120_17.z = 0
				var_120_17.x = 0
				var_120_9.localEulerAngles = var_120_17
			end

			local var_120_18 = 0

			if var_120_18 < arg_117_1.time_ and arg_117_1.time_ <= var_120_18 + arg_120_0 then
				arg_117_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action7_1")
			end

			local var_120_19 = 0

			if var_120_19 < arg_117_1.time_ and arg_117_1.time_ <= var_120_19 + arg_120_0 then
				arg_117_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_120_20 = 0
			local var_120_21 = 0.55

			if var_120_20 < arg_117_1.time_ and arg_117_1.time_ <= var_120_20 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_22 = arg_117_1:FormatText(StoryNameCfg[8].name)

				arg_117_1.leftNameTxt_.text = var_120_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_23 = arg_117_1:GetWordFromCfg(116011026)
				local var_120_24 = arg_117_1:FormatText(var_120_23.content)

				arg_117_1.text_.text = var_120_24

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_25 = 22
				local var_120_26 = utf8.len(var_120_24)
				local var_120_27 = var_120_25 <= 0 and var_120_21 or var_120_21 * (var_120_26 / var_120_25)

				if var_120_27 > 0 and var_120_21 < var_120_27 then
					arg_117_1.talkMaxDuration = var_120_27

					if var_120_27 + var_120_20 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_27 + var_120_20
					end
				end

				arg_117_1.text_.text = var_120_24
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011026", "story_v_out_116011.awb") ~= 0 then
					local var_120_28 = manager.audio:GetVoiceLength("story_v_out_116011", "116011026", "story_v_out_116011.awb") / 1000

					if var_120_28 + var_120_20 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_28 + var_120_20
					end

					if var_120_23.prefab_name ~= "" and arg_117_1.actors_[var_120_23.prefab_name] ~= nil then
						local var_120_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_23.prefab_name].transform, "story_v_out_116011", "116011026", "story_v_out_116011.awb")

						arg_117_1:RecordAudio("116011026", var_120_29)
						arg_117_1:RecordAudio("116011026", var_120_29)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_116011", "116011026", "story_v_out_116011.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_116011", "116011026", "story_v_out_116011.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_30 = math.max(var_120_21, arg_117_1.talkMaxDuration)

			if var_120_20 <= arg_117_1.time_ and arg_117_1.time_ < var_120_20 + var_120_30 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_20) / var_120_30

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_20 + var_120_30 and arg_117_1.time_ < var_120_20 + var_120_30 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play116011027 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 116011027
		arg_121_1.duration_ = 9.2

		local var_121_0 = {
			zh = 6.266,
			ja = 9.2
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
				arg_121_0:Play116011028(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_124_1 = 0
			local var_124_2 = 0.75

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_3 = arg_121_1:FormatText(StoryNameCfg[8].name)

				arg_121_1.leftNameTxt_.text = var_124_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_4 = arg_121_1:GetWordFromCfg(116011027)
				local var_124_5 = arg_121_1:FormatText(var_124_4.content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 30
				local var_124_7 = utf8.len(var_124_5)
				local var_124_8 = var_124_6 <= 0 and var_124_2 or var_124_2 * (var_124_7 / var_124_6)

				if var_124_8 > 0 and var_124_2 < var_124_8 then
					arg_121_1.talkMaxDuration = var_124_8

					if var_124_8 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011027", "story_v_out_116011.awb") ~= 0 then
					local var_124_9 = manager.audio:GetVoiceLength("story_v_out_116011", "116011027", "story_v_out_116011.awb") / 1000

					if var_124_9 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_1
					end

					if var_124_4.prefab_name ~= "" and arg_121_1.actors_[var_124_4.prefab_name] ~= nil then
						local var_124_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_4.prefab_name].transform, "story_v_out_116011", "116011027", "story_v_out_116011.awb")

						arg_121_1:RecordAudio("116011027", var_124_10)
						arg_121_1:RecordAudio("116011027", var_124_10)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_116011", "116011027", "story_v_out_116011.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_116011", "116011027", "story_v_out_116011.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_11 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_11 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_11

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_11 and arg_121_1.time_ < var_124_1 + var_124_11 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play116011028 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 116011028
		arg_125_1.duration_ = 6.27

		local var_125_0 = {
			zh = 6.266,
			ja = 5.133
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
				arg_125_0:Play116011029(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = "1039ui_story"

			if arg_125_1.actors_[var_128_0] == nil then
				local var_128_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_128_1) then
					local var_128_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_125_1.stage_.transform)

					var_128_2.name = var_128_0
					var_128_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_125_1.actors_[var_128_0] = var_128_2

					local var_128_3 = var_128_2:GetComponentInChildren(typeof(CharacterEffect))

					var_128_3.enabled = true

					local var_128_4 = GameObjectTools.GetOrAddComponent(var_128_2, typeof(DynamicBoneHelper))

					if var_128_4 then
						var_128_4:EnableDynamicBone(false)
					end

					arg_125_1:ShowWeapon(var_128_3.transform, false)

					arg_125_1.var_[var_128_0 .. "Animator"] = var_128_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_125_1.var_[var_128_0 .. "Animator"].applyRootMotion = true
					arg_125_1.var_[var_128_0 .. "LipSync"] = var_128_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_128_5 = arg_125_1.actors_["1039ui_story"].transform
			local var_128_6 = 0

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.var_.moveOldPos1039ui_story = var_128_5.localPosition
			end

			local var_128_7 = 0.001

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_7 then
				local var_128_8 = (arg_125_1.time_ - var_128_6) / var_128_7
				local var_128_9 = Vector3.New(-0.7, -1.01, -5.9)

				var_128_5.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1039ui_story, var_128_9, var_128_8)

				local var_128_10 = manager.ui.mainCamera.transform.position - var_128_5.position

				var_128_5.forward = Vector3.New(var_128_10.x, var_128_10.y, var_128_10.z)

				local var_128_11 = var_128_5.localEulerAngles

				var_128_11.z = 0
				var_128_11.x = 0
				var_128_5.localEulerAngles = var_128_11
			end

			if arg_125_1.time_ >= var_128_6 + var_128_7 and arg_125_1.time_ < var_128_6 + var_128_7 + arg_128_0 then
				var_128_5.localPosition = Vector3.New(-0.7, -1.01, -5.9)

				local var_128_12 = manager.ui.mainCamera.transform.position - var_128_5.position

				var_128_5.forward = Vector3.New(var_128_12.x, var_128_12.y, var_128_12.z)

				local var_128_13 = var_128_5.localEulerAngles

				var_128_13.z = 0
				var_128_13.x = 0
				var_128_5.localEulerAngles = var_128_13
			end

			local var_128_14 = arg_125_1.actors_["1039ui_story"]
			local var_128_15 = 0

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 and not isNil(var_128_14) and arg_125_1.var_.characterEffect1039ui_story == nil then
				arg_125_1.var_.characterEffect1039ui_story = var_128_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_16 = 0.034

			if var_128_15 <= arg_125_1.time_ and arg_125_1.time_ < var_128_15 + var_128_16 and not isNil(var_128_14) then
				local var_128_17 = (arg_125_1.time_ - var_128_15) / var_128_16

				if arg_125_1.var_.characterEffect1039ui_story and not isNil(var_128_14) then
					arg_125_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_15 + var_128_16 and arg_125_1.time_ < var_128_15 + var_128_16 + arg_128_0 and not isNil(var_128_14) and arg_125_1.var_.characterEffect1039ui_story then
				arg_125_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_128_18 = 0

			if var_128_18 < arg_125_1.time_ and arg_125_1.time_ <= var_128_18 + arg_128_0 then
				arg_125_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_128_19 = arg_125_1.actors_["1048ui_story"]
			local var_128_20 = 0

			if var_128_20 < arg_125_1.time_ and arg_125_1.time_ <= var_128_20 + arg_128_0 and not isNil(var_128_19) and arg_125_1.var_.characterEffect1048ui_story == nil then
				arg_125_1.var_.characterEffect1048ui_story = var_128_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_21 = 0.2

			if var_128_20 <= arg_125_1.time_ and arg_125_1.time_ < var_128_20 + var_128_21 and not isNil(var_128_19) then
				local var_128_22 = (arg_125_1.time_ - var_128_20) / var_128_21

				if arg_125_1.var_.characterEffect1048ui_story and not isNil(var_128_19) then
					local var_128_23 = Mathf.Lerp(0, 0.5, var_128_22)

					arg_125_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1048ui_story.fillRatio = var_128_23
				end
			end

			if arg_125_1.time_ >= var_128_20 + var_128_21 and arg_125_1.time_ < var_128_20 + var_128_21 + arg_128_0 and not isNil(var_128_19) and arg_125_1.var_.characterEffect1048ui_story then
				local var_128_24 = 0.5

				arg_125_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1048ui_story.fillRatio = var_128_24
			end

			local var_128_25 = 0

			if var_128_25 < arg_125_1.time_ and arg_125_1.time_ <= var_128_25 + arg_128_0 then
				arg_125_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action7_2")
			end

			local var_128_26 = 0

			if var_128_26 < arg_125_1.time_ and arg_125_1.time_ <= var_128_26 + arg_128_0 then
				arg_125_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_128_27 = arg_125_1.actors_["1039ui_story"]
			local var_128_28 = 0

			if var_128_28 < arg_125_1.time_ and arg_125_1.time_ <= var_128_28 + arg_128_0 and not isNil(var_128_27) and arg_125_1.var_.characterEffect1039ui_story == nil then
				arg_125_1.var_.characterEffect1039ui_story = var_128_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_29 = 0.2

			if var_128_28 <= arg_125_1.time_ and arg_125_1.time_ < var_128_28 + var_128_29 and not isNil(var_128_27) then
				local var_128_30 = (arg_125_1.time_ - var_128_28) / var_128_29

				if arg_125_1.var_.characterEffect1039ui_story and not isNil(var_128_27) then
					arg_125_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_28 + var_128_29 and arg_125_1.time_ < var_128_28 + var_128_29 + arg_128_0 and not isNil(var_128_27) and arg_125_1.var_.characterEffect1039ui_story then
				arg_125_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_128_31 = 0
			local var_128_32 = 0.625

			if var_128_31 < arg_125_1.time_ and arg_125_1.time_ <= var_128_31 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_33 = arg_125_1:FormatText(StoryNameCfg[9].name)

				arg_125_1.leftNameTxt_.text = var_128_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_34 = arg_125_1:GetWordFromCfg(116011028)
				local var_128_35 = arg_125_1:FormatText(var_128_34.content)

				arg_125_1.text_.text = var_128_35

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_36 = 25
				local var_128_37 = utf8.len(var_128_35)
				local var_128_38 = var_128_36 <= 0 and var_128_32 or var_128_32 * (var_128_37 / var_128_36)

				if var_128_38 > 0 and var_128_32 < var_128_38 then
					arg_125_1.talkMaxDuration = var_128_38

					if var_128_38 + var_128_31 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_38 + var_128_31
					end
				end

				arg_125_1.text_.text = var_128_35
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011028", "story_v_out_116011.awb") ~= 0 then
					local var_128_39 = manager.audio:GetVoiceLength("story_v_out_116011", "116011028", "story_v_out_116011.awb") / 1000

					if var_128_39 + var_128_31 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_39 + var_128_31
					end

					if var_128_34.prefab_name ~= "" and arg_125_1.actors_[var_128_34.prefab_name] ~= nil then
						local var_128_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_34.prefab_name].transform, "story_v_out_116011", "116011028", "story_v_out_116011.awb")

						arg_125_1:RecordAudio("116011028", var_128_40)
						arg_125_1:RecordAudio("116011028", var_128_40)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_116011", "116011028", "story_v_out_116011.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_116011", "116011028", "story_v_out_116011.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_41 = math.max(var_128_32, arg_125_1.talkMaxDuration)

			if var_128_31 <= arg_125_1.time_ and arg_125_1.time_ < var_128_31 + var_128_41 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_31) / var_128_41

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_31 + var_128_41 and arg_125_1.time_ < var_128_31 + var_128_41 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play116011029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 116011029
		arg_129_1.duration_ = 9.1

		local var_129_0 = {
			zh = 9.1,
			ja = 8.7
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
				arg_129_0:Play116011030(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1048ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1048ui_story == nil then
				arg_129_1.var_.characterEffect1048ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.0166666666666667

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1048ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1048ui_story then
				arg_129_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_132_4 = 0

			if var_132_4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action4_1")
			end

			local var_132_5 = arg_129_1.actors_["1048ui_story"]
			local var_132_6 = 0

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1048ui_story == nil then
				arg_129_1.var_.characterEffect1048ui_story = var_132_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_7 = 0.2

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_7 and not isNil(var_132_5) then
				local var_132_8 = (arg_129_1.time_ - var_132_6) / var_132_7

				if arg_129_1.var_.characterEffect1048ui_story and not isNil(var_132_5) then
					arg_129_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_6 + var_132_7 and arg_129_1.time_ < var_132_6 + var_132_7 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1048ui_story then
				arg_129_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_132_10 = arg_129_1.actors_["1039ui_story"]
			local var_132_11 = 0

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 and not isNil(var_132_10) and arg_129_1.var_.characterEffect1039ui_story == nil then
				arg_129_1.var_.characterEffect1039ui_story = var_132_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_12 = 0.2

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_12 and not isNil(var_132_10) then
				local var_132_13 = (arg_129_1.time_ - var_132_11) / var_132_12

				if arg_129_1.var_.characterEffect1039ui_story and not isNil(var_132_10) then
					local var_132_14 = Mathf.Lerp(0, 0.5, var_132_13)

					arg_129_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1039ui_story.fillRatio = var_132_14
				end
			end

			if arg_129_1.time_ >= var_132_11 + var_132_12 and arg_129_1.time_ < var_132_11 + var_132_12 + arg_132_0 and not isNil(var_132_10) and arg_129_1.var_.characterEffect1039ui_story then
				local var_132_15 = 0.5

				arg_129_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1039ui_story.fillRatio = var_132_15
			end

			local var_132_16 = 0
			local var_132_17 = 1.2

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_18 = arg_129_1:FormatText(StoryNameCfg[8].name)

				arg_129_1.leftNameTxt_.text = var_132_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_19 = arg_129_1:GetWordFromCfg(116011029)
				local var_132_20 = arg_129_1:FormatText(var_132_19.content)

				arg_129_1.text_.text = var_132_20

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_21 = 48
				local var_132_22 = utf8.len(var_132_20)
				local var_132_23 = var_132_21 <= 0 and var_132_17 or var_132_17 * (var_132_22 / var_132_21)

				if var_132_23 > 0 and var_132_17 < var_132_23 then
					arg_129_1.talkMaxDuration = var_132_23

					if var_132_23 + var_132_16 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_16
					end
				end

				arg_129_1.text_.text = var_132_20
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011029", "story_v_out_116011.awb") ~= 0 then
					local var_132_24 = manager.audio:GetVoiceLength("story_v_out_116011", "116011029", "story_v_out_116011.awb") / 1000

					if var_132_24 + var_132_16 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_24 + var_132_16
					end

					if var_132_19.prefab_name ~= "" and arg_129_1.actors_[var_132_19.prefab_name] ~= nil then
						local var_132_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_19.prefab_name].transform, "story_v_out_116011", "116011029", "story_v_out_116011.awb")

						arg_129_1:RecordAudio("116011029", var_132_25)
						arg_129_1:RecordAudio("116011029", var_132_25)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_116011", "116011029", "story_v_out_116011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_116011", "116011029", "story_v_out_116011.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_26 = math.max(var_132_17, arg_129_1.talkMaxDuration)

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_26 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_16) / var_132_26

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_16 + var_132_26 and arg_129_1.time_ < var_132_16 + var_132_26 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play116011030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 116011030
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play116011031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_136_1 = arg_133_1.actors_["1048ui_story"]
			local var_136_2 = 0

			if var_136_2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1048ui_story == nil then
				arg_133_1.var_.characterEffect1048ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.2

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_3 and not isNil(var_136_1) then
				local var_136_4 = (arg_133_1.time_ - var_136_2) / var_136_3

				if arg_133_1.var_.characterEffect1048ui_story and not isNil(var_136_1) then
					local var_136_5 = Mathf.Lerp(0, 0.5, var_136_4)

					arg_133_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1048ui_story.fillRatio = var_136_5
				end
			end

			if arg_133_1.time_ >= var_136_2 + var_136_3 and arg_133_1.time_ < var_136_2 + var_136_3 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1048ui_story then
				local var_136_6 = 0.5

				arg_133_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1048ui_story.fillRatio = var_136_6
			end

			local var_136_7 = 0
			local var_136_8 = 0.475

			if var_136_7 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_9 = arg_133_1:GetWordFromCfg(116011030)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 19
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_8 or var_136_8 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_8 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_7 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_7
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_8, arg_133_1.talkMaxDuration)

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_7) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_7 + var_136_14 and arg_133_1.time_ < var_136_7 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play116011031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 116011031
		arg_137_1.duration_ = 13.1

		local var_137_0 = {
			zh = 7.833,
			ja = 13.1
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play116011032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1039ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1039ui_story == nil then
				arg_137_1.var_.characterEffect1039ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1039ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1039ui_story then
				arg_137_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_140_4 = 0

			if var_140_4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_140_6 = 0
			local var_140_7 = 1

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[9].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_9 = arg_137_1:GetWordFromCfg(116011031)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011031", "story_v_out_116011.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_116011", "116011031", "story_v_out_116011.awb") / 1000

					if var_140_14 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_6
					end

					if var_140_9.prefab_name ~= "" and arg_137_1.actors_[var_140_9.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_9.prefab_name].transform, "story_v_out_116011", "116011031", "story_v_out_116011.awb")

						arg_137_1:RecordAudio("116011031", var_140_15)
						arg_137_1:RecordAudio("116011031", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_116011", "116011031", "story_v_out_116011.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_116011", "116011031", "story_v_out_116011.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_16 and arg_137_1.time_ < var_140_6 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play116011032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 116011032
		arg_141_1.duration_ = 3.97

		local var_141_0 = {
			zh = 3.966,
			ja = 2.866
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
				arg_141_0:Play116011033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1039ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1039ui_story == nil then
				arg_141_1.var_.characterEffect1039ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1039ui_story and not isNil(var_144_0) then
					local var_144_4 = Mathf.Lerp(0, 0.5, var_144_3)

					arg_141_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1039ui_story.fillRatio = var_144_4
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1039ui_story then
				local var_144_5 = 0.5

				arg_141_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1039ui_story.fillRatio = var_144_5
			end

			local var_144_6 = arg_141_1.actors_["1048ui_story"]
			local var_144_7 = 0

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1048ui_story == nil then
				arg_141_1.var_.characterEffect1048ui_story = var_144_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_8 = 0.2

			if var_144_7 <= arg_141_1.time_ and arg_141_1.time_ < var_144_7 + var_144_8 and not isNil(var_144_6) then
				local var_144_9 = (arg_141_1.time_ - var_144_7) / var_144_8

				if arg_141_1.var_.characterEffect1048ui_story and not isNil(var_144_6) then
					arg_141_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_7 + var_144_8 and arg_141_1.time_ < var_144_7 + var_144_8 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1048ui_story then
				arg_141_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action442")
			end

			local var_144_11 = 0

			if var_144_11 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				arg_141_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_144_12 = 0
			local var_144_13 = 0.325

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_14 = arg_141_1:FormatText(StoryNameCfg[8].name)

				arg_141_1.leftNameTxt_.text = var_144_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_15 = arg_141_1:GetWordFromCfg(116011032)
				local var_144_16 = arg_141_1:FormatText(var_144_15.content)

				arg_141_1.text_.text = var_144_16

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_17 = 13
				local var_144_18 = utf8.len(var_144_16)
				local var_144_19 = var_144_17 <= 0 and var_144_13 or var_144_13 * (var_144_18 / var_144_17)

				if var_144_19 > 0 and var_144_13 < var_144_19 then
					arg_141_1.talkMaxDuration = var_144_19

					if var_144_19 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_19 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_16
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011032", "story_v_out_116011.awb") ~= 0 then
					local var_144_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011032", "story_v_out_116011.awb") / 1000

					if var_144_20 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_20 + var_144_12
					end

					if var_144_15.prefab_name ~= "" and arg_141_1.actors_[var_144_15.prefab_name] ~= nil then
						local var_144_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_15.prefab_name].transform, "story_v_out_116011", "116011032", "story_v_out_116011.awb")

						arg_141_1:RecordAudio("116011032", var_144_21)
						arg_141_1:RecordAudio("116011032", var_144_21)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_116011", "116011032", "story_v_out_116011.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_116011", "116011032", "story_v_out_116011.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_22 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_22 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_22

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_22 and arg_141_1.time_ < var_144_12 + var_144_22 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play116011033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 116011033
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play116011034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_2")
			end

			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_148_2 = arg_145_1.actors_["1048ui_story"]
			local var_148_3 = 0

			if var_148_3 < arg_145_1.time_ and arg_145_1.time_ <= var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1048ui_story == nil then
				arg_145_1.var_.characterEffect1048ui_story = var_148_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_4 = 0.2

			if var_148_3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_3 + var_148_4 and not isNil(var_148_2) then
				local var_148_5 = (arg_145_1.time_ - var_148_3) / var_148_4

				if arg_145_1.var_.characterEffect1048ui_story and not isNil(var_148_2) then
					local var_148_6 = Mathf.Lerp(0, 0.5, var_148_5)

					arg_145_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1048ui_story.fillRatio = var_148_6
				end
			end

			if arg_145_1.time_ >= var_148_3 + var_148_4 and arg_145_1.time_ < var_148_3 + var_148_4 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1048ui_story then
				local var_148_7 = 0.5

				arg_145_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1048ui_story.fillRatio = var_148_7
			end

			local var_148_8 = 0
			local var_148_9 = 0.75

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(116011033)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_12 = 30
				local var_148_13 = utf8.len(var_148_11)
				local var_148_14 = var_148_12 <= 0 and var_148_9 or var_148_9 * (var_148_13 / var_148_12)

				if var_148_14 > 0 and var_148_9 < var_148_14 then
					arg_145_1.talkMaxDuration = var_148_14

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_15 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_15 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_15

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_15 and arg_145_1.time_ < var_148_8 + var_148_15 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play116011034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 116011034
		arg_149_1.duration_ = 12.7

		local var_149_0 = {
			zh = 6.8,
			ja = 12.7
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
				arg_149_0:Play116011035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1039ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1039ui_story == nil then
				arg_149_1.var_.characterEffect1039ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1039ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1039ui_story then
				arg_149_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["1048ui_story"]
			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1048ui_story == nil then
				arg_149_1.var_.characterEffect1048ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.2

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 and not isNil(var_152_4) then
				local var_152_7 = (arg_149_1.time_ - var_152_5) / var_152_6

				if arg_149_1.var_.characterEffect1048ui_story and not isNil(var_152_4) then
					local var_152_8 = Mathf.Lerp(0, 0.5, var_152_7)

					arg_149_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1048ui_story.fillRatio = var_152_8
				end
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1048ui_story then
				local var_152_9 = 0.5

				arg_149_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1048ui_story.fillRatio = var_152_9
			end

			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_2")
			end

			local var_152_11 = 0

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_152_12 = 0
			local var_152_13 = 0.825

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_14 = arg_149_1:FormatText(StoryNameCfg[9].name)

				arg_149_1.leftNameTxt_.text = var_152_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_15 = arg_149_1:GetWordFromCfg(116011034)
				local var_152_16 = arg_149_1:FormatText(var_152_15.content)

				arg_149_1.text_.text = var_152_16

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_17 = 33
				local var_152_18 = utf8.len(var_152_16)
				local var_152_19 = var_152_17 <= 0 and var_152_13 or var_152_13 * (var_152_18 / var_152_17)

				if var_152_19 > 0 and var_152_13 < var_152_19 then
					arg_149_1.talkMaxDuration = var_152_19

					if var_152_19 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_12
					end
				end

				arg_149_1.text_.text = var_152_16
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011034", "story_v_out_116011.awb") ~= 0 then
					local var_152_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011034", "story_v_out_116011.awb") / 1000

					if var_152_20 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_20 + var_152_12
					end

					if var_152_15.prefab_name ~= "" and arg_149_1.actors_[var_152_15.prefab_name] ~= nil then
						local var_152_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_15.prefab_name].transform, "story_v_out_116011", "116011034", "story_v_out_116011.awb")

						arg_149_1:RecordAudio("116011034", var_152_21)
						arg_149_1:RecordAudio("116011034", var_152_21)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_116011", "116011034", "story_v_out_116011.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_116011", "116011034", "story_v_out_116011.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_22 = math.max(var_152_13, arg_149_1.talkMaxDuration)

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_22 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_12) / var_152_22

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_12 + var_152_22 and arg_149_1.time_ < var_152_12 + var_152_22 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play116011035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 116011035
		arg_153_1.duration_ = 8.7

		local var_153_0 = {
			zh = 1.999999999999,
			ja = 8.7
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
				arg_153_0:Play116011036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1039ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1039ui_story == nil then
				arg_153_1.var_.characterEffect1039ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1039ui_story and not isNil(var_156_0) then
					local var_156_4 = Mathf.Lerp(0, 0.5, var_156_3)

					arg_153_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1039ui_story.fillRatio = var_156_4
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1039ui_story then
				local var_156_5 = 0.5

				arg_153_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1039ui_story.fillRatio = var_156_5
			end

			local var_156_6 = arg_153_1.actors_["1048ui_story"]
			local var_156_7 = 0

			if var_156_7 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect1048ui_story == nil then
				arg_153_1.var_.characterEffect1048ui_story = var_156_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_8 = 0.2

			if var_156_7 <= arg_153_1.time_ and arg_153_1.time_ < var_156_7 + var_156_8 and not isNil(var_156_6) then
				local var_156_9 = (arg_153_1.time_ - var_156_7) / var_156_8

				if arg_153_1.var_.characterEffect1048ui_story and not isNil(var_156_6) then
					arg_153_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_7 + var_156_8 and arg_153_1.time_ < var_156_7 + var_156_8 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect1048ui_story then
				arg_153_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_156_11 = 0
			local var_156_12 = 0.175

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_13 = arg_153_1:FormatText(StoryNameCfg[8].name)

				arg_153_1.leftNameTxt_.text = var_156_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_14 = arg_153_1:GetWordFromCfg(116011035)
				local var_156_15 = arg_153_1:FormatText(var_156_14.content)

				arg_153_1.text_.text = var_156_15

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 7
				local var_156_17 = utf8.len(var_156_15)
				local var_156_18 = var_156_16 <= 0 and var_156_12 or var_156_12 * (var_156_17 / var_156_16)

				if var_156_18 > 0 and var_156_12 < var_156_18 then
					arg_153_1.talkMaxDuration = var_156_18

					if var_156_18 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_11
					end
				end

				arg_153_1.text_.text = var_156_15
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011035", "story_v_out_116011.awb") ~= 0 then
					local var_156_19 = manager.audio:GetVoiceLength("story_v_out_116011", "116011035", "story_v_out_116011.awb") / 1000

					if var_156_19 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_11
					end

					if var_156_14.prefab_name ~= "" and arg_153_1.actors_[var_156_14.prefab_name] ~= nil then
						local var_156_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_14.prefab_name].transform, "story_v_out_116011", "116011035", "story_v_out_116011.awb")

						arg_153_1:RecordAudio("116011035", var_156_20)
						arg_153_1:RecordAudio("116011035", var_156_20)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_116011", "116011035", "story_v_out_116011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_116011", "116011035", "story_v_out_116011.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_21 = math.max(var_156_12, arg_153_1.talkMaxDuration)

			if var_156_11 <= arg_153_1.time_ and arg_153_1.time_ < var_156_11 + var_156_21 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_11) / var_156_21

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_11 + var_156_21 and arg_153_1.time_ < var_156_11 + var_156_21 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play116011036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 116011036
		arg_157_1.duration_ = 7.1

		local var_157_0 = {
			zh = 7.033,
			ja = 7.1
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
				arg_157_0:Play116011037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1039ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1039ui_story == nil then
				arg_157_1.var_.characterEffect1039ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1039ui_story and not isNil(var_160_0) then
					arg_157_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1039ui_story then
				arg_157_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_160_4 = arg_157_1.actors_["1048ui_story"]
			local var_160_5 = 0

			if var_160_5 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1048ui_story == nil then
				arg_157_1.var_.characterEffect1048ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_6 = 0.2

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_6 and not isNil(var_160_4) then
				local var_160_7 = (arg_157_1.time_ - var_160_5) / var_160_6

				if arg_157_1.var_.characterEffect1048ui_story and not isNil(var_160_4) then
					local var_160_8 = Mathf.Lerp(0, 0.5, var_160_7)

					arg_157_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1048ui_story.fillRatio = var_160_8
				end
			end

			if arg_157_1.time_ >= var_160_5 + var_160_6 and arg_157_1.time_ < var_160_5 + var_160_6 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1048ui_story then
				local var_160_9 = 0.5

				arg_157_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1048ui_story.fillRatio = var_160_9
			end

			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_160_11 = 0
			local var_160_12 = 0.85

			if var_160_11 < arg_157_1.time_ and arg_157_1.time_ <= var_160_11 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_13 = arg_157_1:FormatText(StoryNameCfg[9].name)

				arg_157_1.leftNameTxt_.text = var_160_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_14 = arg_157_1:GetWordFromCfg(116011036)
				local var_160_15 = arg_157_1:FormatText(var_160_14.content)

				arg_157_1.text_.text = var_160_15

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_16 = 34
				local var_160_17 = utf8.len(var_160_15)
				local var_160_18 = var_160_16 <= 0 and var_160_12 or var_160_12 * (var_160_17 / var_160_16)

				if var_160_18 > 0 and var_160_12 < var_160_18 then
					arg_157_1.talkMaxDuration = var_160_18

					if var_160_18 + var_160_11 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_18 + var_160_11
					end
				end

				arg_157_1.text_.text = var_160_15
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011036", "story_v_out_116011.awb") ~= 0 then
					local var_160_19 = manager.audio:GetVoiceLength("story_v_out_116011", "116011036", "story_v_out_116011.awb") / 1000

					if var_160_19 + var_160_11 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_19 + var_160_11
					end

					if var_160_14.prefab_name ~= "" and arg_157_1.actors_[var_160_14.prefab_name] ~= nil then
						local var_160_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_14.prefab_name].transform, "story_v_out_116011", "116011036", "story_v_out_116011.awb")

						arg_157_1:RecordAudio("116011036", var_160_20)
						arg_157_1:RecordAudio("116011036", var_160_20)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_116011", "116011036", "story_v_out_116011.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_116011", "116011036", "story_v_out_116011.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_21 = math.max(var_160_12, arg_157_1.talkMaxDuration)

			if var_160_11 <= arg_157_1.time_ and arg_157_1.time_ < var_160_11 + var_160_21 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_11) / var_160_21

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_11 + var_160_21 and arg_157_1.time_ < var_160_11 + var_160_21 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play116011037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 116011037
		arg_161_1.duration_ = 14.43

		local var_161_0 = {
			zh = 7.366,
			ja = 14.433
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
				arg_161_0:Play116011038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1039ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1039ui_story == nil then
				arg_161_1.var_.characterEffect1039ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1039ui_story and not isNil(var_164_0) then
					local var_164_4 = Mathf.Lerp(0, 0.5, var_164_3)

					arg_161_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1039ui_story.fillRatio = var_164_4
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1039ui_story then
				local var_164_5 = 0.5

				arg_161_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1039ui_story.fillRatio = var_164_5
			end

			local var_164_6 = arg_161_1.actors_["1048ui_story"]
			local var_164_7 = 0

			if var_164_7 < arg_161_1.time_ and arg_161_1.time_ <= var_164_7 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect1048ui_story == nil then
				arg_161_1.var_.characterEffect1048ui_story = var_164_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_8 = 0.2

			if var_164_7 <= arg_161_1.time_ and arg_161_1.time_ < var_164_7 + var_164_8 and not isNil(var_164_6) then
				local var_164_9 = (arg_161_1.time_ - var_164_7) / var_164_8

				if arg_161_1.var_.characterEffect1048ui_story and not isNil(var_164_6) then
					arg_161_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_7 + var_164_8 and arg_161_1.time_ < var_164_7 + var_164_8 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect1048ui_story then
				arg_161_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_1")
			end

			local var_164_11 = 0

			if var_164_11 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_164_12 = 0
			local var_164_13 = 0.975

			if var_164_12 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_14 = arg_161_1:FormatText(StoryNameCfg[8].name)

				arg_161_1.leftNameTxt_.text = var_164_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_15 = arg_161_1:GetWordFromCfg(116011037)
				local var_164_16 = arg_161_1:FormatText(var_164_15.content)

				arg_161_1.text_.text = var_164_16

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_17 = 39
				local var_164_18 = utf8.len(var_164_16)
				local var_164_19 = var_164_17 <= 0 and var_164_13 or var_164_13 * (var_164_18 / var_164_17)

				if var_164_19 > 0 and var_164_13 < var_164_19 then
					arg_161_1.talkMaxDuration = var_164_19

					if var_164_19 + var_164_12 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_19 + var_164_12
					end
				end

				arg_161_1.text_.text = var_164_16
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011037", "story_v_out_116011.awb") ~= 0 then
					local var_164_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011037", "story_v_out_116011.awb") / 1000

					if var_164_20 + var_164_12 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_20 + var_164_12
					end

					if var_164_15.prefab_name ~= "" and arg_161_1.actors_[var_164_15.prefab_name] ~= nil then
						local var_164_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_15.prefab_name].transform, "story_v_out_116011", "116011037", "story_v_out_116011.awb")

						arg_161_1:RecordAudio("116011037", var_164_21)
						arg_161_1:RecordAudio("116011037", var_164_21)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_116011", "116011037", "story_v_out_116011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_116011", "116011037", "story_v_out_116011.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_22 = math.max(var_164_13, arg_161_1.talkMaxDuration)

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_22 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_12) / var_164_22

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_12 + var_164_22 and arg_161_1.time_ < var_164_12 + var_164_22 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play116011038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116011038
		arg_165_1.duration_ = 4.73

		local var_165_0 = {
			zh = 2.333,
			ja = 4.733
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
				arg_165_0:Play116011039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1048ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1048ui_story == nil then
				arg_165_1.var_.characterEffect1048ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1048ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1048ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1048ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1048ui_story.fillRatio = var_168_5
			end

			local var_168_6 = arg_165_1.actors_["1039ui_story"]
			local var_168_7 = 0

			if var_168_7 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect1039ui_story == nil then
				arg_165_1.var_.characterEffect1039ui_story = var_168_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_8 = 0.2

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_8 and not isNil(var_168_6) then
				local var_168_9 = (arg_165_1.time_ - var_168_7) / var_168_8

				if arg_165_1.var_.characterEffect1039ui_story and not isNil(var_168_6) then
					arg_165_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_7 + var_168_8 and arg_165_1.time_ < var_168_7 + var_168_8 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect1039ui_story then
				arg_165_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_168_11 = 0

			if var_168_11 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_168_12 = 0
			local var_168_13 = 0.25

			if var_168_12 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_14 = arg_165_1:FormatText(StoryNameCfg[9].name)

				arg_165_1.leftNameTxt_.text = var_168_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_15 = arg_165_1:GetWordFromCfg(116011038)
				local var_168_16 = arg_165_1:FormatText(var_168_15.content)

				arg_165_1.text_.text = var_168_16

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_17 = 10
				local var_168_18 = utf8.len(var_168_16)
				local var_168_19 = var_168_17 <= 0 and var_168_13 or var_168_13 * (var_168_18 / var_168_17)

				if var_168_19 > 0 and var_168_13 < var_168_19 then
					arg_165_1.talkMaxDuration = var_168_19

					if var_168_19 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_19 + var_168_12
					end
				end

				arg_165_1.text_.text = var_168_16
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011038", "story_v_out_116011.awb") ~= 0 then
					local var_168_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011038", "story_v_out_116011.awb") / 1000

					if var_168_20 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_20 + var_168_12
					end

					if var_168_15.prefab_name ~= "" and arg_165_1.actors_[var_168_15.prefab_name] ~= nil then
						local var_168_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_15.prefab_name].transform, "story_v_out_116011", "116011038", "story_v_out_116011.awb")

						arg_165_1:RecordAudio("116011038", var_168_21)
						arg_165_1:RecordAudio("116011038", var_168_21)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_116011", "116011038", "story_v_out_116011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_116011", "116011038", "story_v_out_116011.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_22 = math.max(var_168_13, arg_165_1.talkMaxDuration)

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_22 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_12) / var_168_22

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_12 + var_168_22 and arg_165_1.time_ < var_168_12 + var_168_22 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play116011039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116011039
		arg_169_1.duration_ = 9.93

		local var_169_0 = {
			zh = 8.2,
			ja = 9.933
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play116011040(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_2")
			end

			local var_172_2 = 0

			if var_172_2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_172_3 = 0
			local var_172_4 = 0.95

			if var_172_3 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_5 = arg_169_1:FormatText(StoryNameCfg[9].name)

				arg_169_1.leftNameTxt_.text = var_172_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(116011039)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_8 = 38
				local var_172_9 = utf8.len(var_172_7)
				local var_172_10 = var_172_8 <= 0 and var_172_4 or var_172_4 * (var_172_9 / var_172_8)

				if var_172_10 > 0 and var_172_4 < var_172_10 then
					arg_169_1.talkMaxDuration = var_172_10

					if var_172_10 + var_172_3 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_3
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011039", "story_v_out_116011.awb") ~= 0 then
					local var_172_11 = manager.audio:GetVoiceLength("story_v_out_116011", "116011039", "story_v_out_116011.awb") / 1000

					if var_172_11 + var_172_3 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_3
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_116011", "116011039", "story_v_out_116011.awb")

						arg_169_1:RecordAudio("116011039", var_172_12)
						arg_169_1:RecordAudio("116011039", var_172_12)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_116011", "116011039", "story_v_out_116011.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_116011", "116011039", "story_v_out_116011.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_13 = math.max(var_172_4, arg_169_1.talkMaxDuration)

			if var_172_3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_3 + var_172_13 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_3) / var_172_13

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_3 + var_172_13 and arg_169_1.time_ < var_172_3 + var_172_13 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play116011040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116011040
		arg_173_1.duration_ = 7.27

		local var_173_0 = {
			zh = 7.266,
			ja = 6.2
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
				arg_173_0:Play116011041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1039ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1039ui_story == nil then
				arg_173_1.var_.characterEffect1039ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.0638109967112541

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1039ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1039ui_story then
				arg_173_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_176_4 = arg_173_1.actors_["1048ui_story"]
			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1048ui_story == nil then
				arg_173_1.var_.characterEffect1048ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_6 = 0.0638109967112541

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_6 and not isNil(var_176_4) then
				local var_176_7 = (arg_173_1.time_ - var_176_5) / var_176_6

				if arg_173_1.var_.characterEffect1048ui_story and not isNil(var_176_4) then
					local var_176_8 = Mathf.Lerp(0, 0.5, var_176_7)

					arg_173_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1048ui_story.fillRatio = var_176_8
				end
			end

			if arg_173_1.time_ >= var_176_5 + var_176_6 and arg_173_1.time_ < var_176_5 + var_176_6 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1048ui_story then
				local var_176_9 = 0.5

				arg_173_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1048ui_story.fillRatio = var_176_9
			end

			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			local var_176_11 = 0

			if var_176_11 < arg_173_1.time_ and arg_173_1.time_ <= var_176_11 + arg_176_0 then
				arg_173_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_12 = 0
			local var_176_13 = 0.75

			if var_176_12 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_14 = arg_173_1:FormatText(StoryNameCfg[9].name)

				arg_173_1.leftNameTxt_.text = var_176_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_15 = arg_173_1:GetWordFromCfg(116011040)
				local var_176_16 = arg_173_1:FormatText(var_176_15.content)

				arg_173_1.text_.text = var_176_16

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_17 = 30
				local var_176_18 = utf8.len(var_176_16)
				local var_176_19 = var_176_17 <= 0 and var_176_13 or var_176_13 * (var_176_18 / var_176_17)

				if var_176_19 > 0 and var_176_13 < var_176_19 then
					arg_173_1.talkMaxDuration = var_176_19

					if var_176_19 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_19 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_16
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011040", "story_v_out_116011.awb") ~= 0 then
					local var_176_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011040", "story_v_out_116011.awb") / 1000

					if var_176_20 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_20 + var_176_12
					end

					if var_176_15.prefab_name ~= "" and arg_173_1.actors_[var_176_15.prefab_name] ~= nil then
						local var_176_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_15.prefab_name].transform, "story_v_out_116011", "116011040", "story_v_out_116011.awb")

						arg_173_1:RecordAudio("116011040", var_176_21)
						arg_173_1:RecordAudio("116011040", var_176_21)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_116011", "116011040", "story_v_out_116011.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_116011", "116011040", "story_v_out_116011.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_22 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_12) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_12 + var_176_22 and arg_173_1.time_ < var_176_12 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play116011041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 116011041
		arg_177_1.duration_ = 14.3

		local var_177_0 = {
			zh = 10.2,
			ja = 14.3
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play116011042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1039ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1039ui_story == nil then
				arg_177_1.var_.characterEffect1039ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1039ui_story and not isNil(var_180_0) then
					local var_180_4 = Mathf.Lerp(0, 0.5, var_180_3)

					arg_177_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1039ui_story.fillRatio = var_180_4
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1039ui_story then
				local var_180_5 = 0.5

				arg_177_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1039ui_story.fillRatio = var_180_5
			end

			local var_180_6 = arg_177_1.actors_["1048ui_story"]
			local var_180_7 = 0

			if var_180_7 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1048ui_story == nil then
				arg_177_1.var_.characterEffect1048ui_story = var_180_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_8 = 0.2

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_8 and not isNil(var_180_6) then
				local var_180_9 = (arg_177_1.time_ - var_180_7) / var_180_8

				if arg_177_1.var_.characterEffect1048ui_story and not isNil(var_180_6) then
					arg_177_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_7 + var_180_8 and arg_177_1.time_ < var_180_7 + var_180_8 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1048ui_story then
				arg_177_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action5_1")
			end

			local var_180_11 = 0

			if var_180_11 < arg_177_1.time_ and arg_177_1.time_ <= var_180_11 + arg_180_0 then
				arg_177_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_180_12 = 0
			local var_180_13 = 1.475

			if var_180_12 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_14 = arg_177_1:FormatText(StoryNameCfg[8].name)

				arg_177_1.leftNameTxt_.text = var_180_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_15 = arg_177_1:GetWordFromCfg(116011041)
				local var_180_16 = arg_177_1:FormatText(var_180_15.content)

				arg_177_1.text_.text = var_180_16

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_17 = 59
				local var_180_18 = utf8.len(var_180_16)
				local var_180_19 = var_180_17 <= 0 and var_180_13 or var_180_13 * (var_180_18 / var_180_17)

				if var_180_19 > 0 and var_180_13 < var_180_19 then
					arg_177_1.talkMaxDuration = var_180_19

					if var_180_19 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_19 + var_180_12
					end
				end

				arg_177_1.text_.text = var_180_16
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011041", "story_v_out_116011.awb") ~= 0 then
					local var_180_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011041", "story_v_out_116011.awb") / 1000

					if var_180_20 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_20 + var_180_12
					end

					if var_180_15.prefab_name ~= "" and arg_177_1.actors_[var_180_15.prefab_name] ~= nil then
						local var_180_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_15.prefab_name].transform, "story_v_out_116011", "116011041", "story_v_out_116011.awb")

						arg_177_1:RecordAudio("116011041", var_180_21)
						arg_177_1:RecordAudio("116011041", var_180_21)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_116011", "116011041", "story_v_out_116011.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_116011", "116011041", "story_v_out_116011.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_22 = math.max(var_180_13, arg_177_1.talkMaxDuration)

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_22 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_12) / var_180_22

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_12 + var_180_22 and arg_177_1.time_ < var_180_12 + var_180_22 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play116011042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 116011042
		arg_181_1.duration_ = 4.3

		local var_181_0 = {
			zh = 4.3,
			ja = 3.933
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
				arg_181_0:Play116011043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1039ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1039ui_story == nil then
				arg_181_1.var_.characterEffect1039ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1039ui_story and not isNil(var_184_0) then
					arg_181_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1039ui_story then
				arg_181_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["1048ui_story"]
			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1048ui_story == nil then
				arg_181_1.var_.characterEffect1048ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.2

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_6 and not isNil(var_184_4) then
				local var_184_7 = (arg_181_1.time_ - var_184_5) / var_184_6

				if arg_181_1.var_.characterEffect1048ui_story and not isNil(var_184_4) then
					local var_184_8 = Mathf.Lerp(0, 0.5, var_184_7)

					arg_181_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1048ui_story.fillRatio = var_184_8
				end
			end

			if arg_181_1.time_ >= var_184_5 + var_184_6 and arg_181_1.time_ < var_184_5 + var_184_6 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1048ui_story then
				local var_184_9 = 0.5

				arg_181_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1048ui_story.fillRatio = var_184_9
			end

			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_2")
			end

			local var_184_11 = 0

			if var_184_11 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				arg_181_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_184_12 = 0
			local var_184_13 = 0.325

			if var_184_12 < arg_181_1.time_ and arg_181_1.time_ <= var_184_12 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_14 = arg_181_1:FormatText(StoryNameCfg[9].name)

				arg_181_1.leftNameTxt_.text = var_184_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_15 = arg_181_1:GetWordFromCfg(116011042)
				local var_184_16 = arg_181_1:FormatText(var_184_15.content)

				arg_181_1.text_.text = var_184_16

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_17 = 13
				local var_184_18 = utf8.len(var_184_16)
				local var_184_19 = var_184_17 <= 0 and var_184_13 or var_184_13 * (var_184_18 / var_184_17)

				if var_184_19 > 0 and var_184_13 < var_184_19 then
					arg_181_1.talkMaxDuration = var_184_19

					if var_184_19 + var_184_12 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_19 + var_184_12
					end
				end

				arg_181_1.text_.text = var_184_16
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011042", "story_v_out_116011.awb") ~= 0 then
					local var_184_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011042", "story_v_out_116011.awb") / 1000

					if var_184_20 + var_184_12 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_20 + var_184_12
					end

					if var_184_15.prefab_name ~= "" and arg_181_1.actors_[var_184_15.prefab_name] ~= nil then
						local var_184_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_15.prefab_name].transform, "story_v_out_116011", "116011042", "story_v_out_116011.awb")

						arg_181_1:RecordAudio("116011042", var_184_21)
						arg_181_1:RecordAudio("116011042", var_184_21)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_116011", "116011042", "story_v_out_116011.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_116011", "116011042", "story_v_out_116011.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_22 = math.max(var_184_13, arg_181_1.talkMaxDuration)

			if var_184_12 <= arg_181_1.time_ and arg_181_1.time_ < var_184_12 + var_184_22 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_12) / var_184_22

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_12 + var_184_22 and arg_181_1.time_ < var_184_12 + var_184_22 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play116011043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 116011043
		arg_185_1.duration_ = 17.6

		local var_185_0 = {
			zh = 11.1,
			ja = 17.6
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
				arg_185_0:Play116011044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_188_1 = 0
			local var_188_2 = 1.5

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_3 = arg_185_1:FormatText(StoryNameCfg[9].name)

				arg_185_1.leftNameTxt_.text = var_188_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:GetWordFromCfg(116011043)
				local var_188_5 = arg_185_1:FormatText(var_188_4.content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_6 = 60
				local var_188_7 = utf8.len(var_188_5)
				local var_188_8 = var_188_6 <= 0 and var_188_2 or var_188_2 * (var_188_7 / var_188_6)

				if var_188_8 > 0 and var_188_2 < var_188_8 then
					arg_185_1.talkMaxDuration = var_188_8

					if var_188_8 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011043", "story_v_out_116011.awb") ~= 0 then
					local var_188_9 = manager.audio:GetVoiceLength("story_v_out_116011", "116011043", "story_v_out_116011.awb") / 1000

					if var_188_9 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_1
					end

					if var_188_4.prefab_name ~= "" and arg_185_1.actors_[var_188_4.prefab_name] ~= nil then
						local var_188_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_4.prefab_name].transform, "story_v_out_116011", "116011043", "story_v_out_116011.awb")

						arg_185_1:RecordAudio("116011043", var_188_10)
						arg_185_1:RecordAudio("116011043", var_188_10)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_116011", "116011043", "story_v_out_116011.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_116011", "116011043", "story_v_out_116011.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_11 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_11 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_11

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_11 and arg_185_1.time_ < var_188_1 + var_188_11 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play116011044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 116011044
		arg_189_1.duration_ = 7.97

		local var_189_0 = {
			zh = 5.766,
			ja = 7.966
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
				arg_189_0:Play116011045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1048ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1048ui_story == nil then
				arg_189_1.var_.characterEffect1048ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1048ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1048ui_story then
				arg_189_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_192_4 = arg_189_1.actors_["1039ui_story"]
			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1039ui_story == nil then
				arg_189_1.var_.characterEffect1039ui_story = var_192_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.2

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_6 and not isNil(var_192_4) then
				local var_192_7 = (arg_189_1.time_ - var_192_5) / var_192_6

				if arg_189_1.var_.characterEffect1039ui_story and not isNil(var_192_4) then
					local var_192_8 = Mathf.Lerp(0, 0.5, var_192_7)

					arg_189_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1039ui_story.fillRatio = var_192_8
				end
			end

			if arg_189_1.time_ >= var_192_5 + var_192_6 and arg_189_1.time_ < var_192_5 + var_192_6 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1039ui_story then
				local var_192_9 = 0.5

				arg_189_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1039ui_story.fillRatio = var_192_9
			end

			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_192_11 = 0

			if var_192_11 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 then
				arg_189_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action454")
			end

			local var_192_12 = 0
			local var_192_13 = 0.675

			if var_192_12 < arg_189_1.time_ and arg_189_1.time_ <= var_192_12 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_14 = arg_189_1:FormatText(StoryNameCfg[8].name)

				arg_189_1.leftNameTxt_.text = var_192_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_15 = arg_189_1:GetWordFromCfg(116011044)
				local var_192_16 = arg_189_1:FormatText(var_192_15.content)

				arg_189_1.text_.text = var_192_16

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_17 = 27
				local var_192_18 = utf8.len(var_192_16)
				local var_192_19 = var_192_17 <= 0 and var_192_13 or var_192_13 * (var_192_18 / var_192_17)

				if var_192_19 > 0 and var_192_13 < var_192_19 then
					arg_189_1.talkMaxDuration = var_192_19

					if var_192_19 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_19 + var_192_12
					end
				end

				arg_189_1.text_.text = var_192_16
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011044", "story_v_out_116011.awb") ~= 0 then
					local var_192_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011044", "story_v_out_116011.awb") / 1000

					if var_192_20 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_20 + var_192_12
					end

					if var_192_15.prefab_name ~= "" and arg_189_1.actors_[var_192_15.prefab_name] ~= nil then
						local var_192_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_15.prefab_name].transform, "story_v_out_116011", "116011044", "story_v_out_116011.awb")

						arg_189_1:RecordAudio("116011044", var_192_21)
						arg_189_1:RecordAudio("116011044", var_192_21)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_116011", "116011044", "story_v_out_116011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_116011", "116011044", "story_v_out_116011.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_22 = math.max(var_192_13, arg_189_1.talkMaxDuration)

			if var_192_12 <= arg_189_1.time_ and arg_189_1.time_ < var_192_12 + var_192_22 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_12) / var_192_22

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_12 + var_192_22 and arg_189_1.time_ < var_192_12 + var_192_22 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play116011045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116011045
		arg_193_1.duration_ = 18.67

		local var_193_0 = {
			zh = 11.033,
			ja = 18.666
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
				arg_193_0:Play116011046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1048ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1048ui_story == nil then
				arg_193_1.var_.characterEffect1048ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1048ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1048ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1048ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1048ui_story.fillRatio = var_196_5
			end

			local var_196_6 = arg_193_1.actors_["1039ui_story"]
			local var_196_7 = 0

			if var_196_7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1039ui_story == nil then
				arg_193_1.var_.characterEffect1039ui_story = var_196_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_8 = 0.2

			if var_196_7 <= arg_193_1.time_ and arg_193_1.time_ < var_196_7 + var_196_8 and not isNil(var_196_6) then
				local var_196_9 = (arg_193_1.time_ - var_196_7) / var_196_8

				if arg_193_1.var_.characterEffect1039ui_story and not isNil(var_196_6) then
					arg_193_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_7 + var_196_8 and arg_193_1.time_ < var_196_7 + var_196_8 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1039ui_story then
				arg_193_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_196_11 = 0

			if var_196_11 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_196_12 = 0
			local var_196_13 = 1.375

			if var_196_12 < arg_193_1.time_ and arg_193_1.time_ <= var_196_12 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_14 = arg_193_1:FormatText(StoryNameCfg[9].name)

				arg_193_1.leftNameTxt_.text = var_196_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_15 = arg_193_1:GetWordFromCfg(116011045)
				local var_196_16 = arg_193_1:FormatText(var_196_15.content)

				arg_193_1.text_.text = var_196_16

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_17 = 55
				local var_196_18 = utf8.len(var_196_16)
				local var_196_19 = var_196_17 <= 0 and var_196_13 or var_196_13 * (var_196_18 / var_196_17)

				if var_196_19 > 0 and var_196_13 < var_196_19 then
					arg_193_1.talkMaxDuration = var_196_19

					if var_196_19 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_19 + var_196_12
					end
				end

				arg_193_1.text_.text = var_196_16
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011045", "story_v_out_116011.awb") ~= 0 then
					local var_196_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011045", "story_v_out_116011.awb") / 1000

					if var_196_20 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_20 + var_196_12
					end

					if var_196_15.prefab_name ~= "" and arg_193_1.actors_[var_196_15.prefab_name] ~= nil then
						local var_196_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_15.prefab_name].transform, "story_v_out_116011", "116011045", "story_v_out_116011.awb")

						arg_193_1:RecordAudio("116011045", var_196_21)
						arg_193_1:RecordAudio("116011045", var_196_21)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_116011", "116011045", "story_v_out_116011.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_116011", "116011045", "story_v_out_116011.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_22 = math.max(var_196_13, arg_193_1.talkMaxDuration)

			if var_196_12 <= arg_193_1.time_ and arg_193_1.time_ < var_196_12 + var_196_22 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_12) / var_196_22

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_12 + var_196_22 and arg_193_1.time_ < var_196_12 + var_196_22 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play116011046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116011046
		arg_197_1.duration_ = 10.07

		local var_197_0 = {
			zh = 9.6,
			ja = 10.066
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play116011047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1048ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1048ui_story == nil then
				arg_197_1.var_.characterEffect1048ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.2

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1048ui_story and not isNil(var_200_0) then
					arg_197_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1048ui_story then
				arg_197_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_200_4 = arg_197_1.actors_["1039ui_story"]
			local var_200_5 = 0

			if var_200_5 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1039ui_story == nil then
				arg_197_1.var_.characterEffect1039ui_story = var_200_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_6 = 0.2

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_6 and not isNil(var_200_4) then
				local var_200_7 = (arg_197_1.time_ - var_200_5) / var_200_6

				if arg_197_1.var_.characterEffect1039ui_story and not isNil(var_200_4) then
					local var_200_8 = Mathf.Lerp(0, 0.5, var_200_7)

					arg_197_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1039ui_story.fillRatio = var_200_8
				end
			end

			if arg_197_1.time_ >= var_200_5 + var_200_6 and arg_197_1.time_ < var_200_5 + var_200_6 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1039ui_story then
				local var_200_9 = 0.5

				arg_197_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1039ui_story.fillRatio = var_200_9
			end

			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 then
				arg_197_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action443")
			end

			local var_200_11 = 0

			if var_200_11 < arg_197_1.time_ and arg_197_1.time_ <= var_200_11 + arg_200_0 then
				arg_197_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_200_12 = 0
			local var_200_13 = 1.1

			if var_200_12 < arg_197_1.time_ and arg_197_1.time_ <= var_200_12 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_14 = arg_197_1:FormatText(StoryNameCfg[8].name)

				arg_197_1.leftNameTxt_.text = var_200_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_15 = arg_197_1:GetWordFromCfg(116011046)
				local var_200_16 = arg_197_1:FormatText(var_200_15.content)

				arg_197_1.text_.text = var_200_16

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_17 = 44
				local var_200_18 = utf8.len(var_200_16)
				local var_200_19 = var_200_17 <= 0 and var_200_13 or var_200_13 * (var_200_18 / var_200_17)

				if var_200_19 > 0 and var_200_13 < var_200_19 then
					arg_197_1.talkMaxDuration = var_200_19

					if var_200_19 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_19 + var_200_12
					end
				end

				arg_197_1.text_.text = var_200_16
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011046", "story_v_out_116011.awb") ~= 0 then
					local var_200_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011046", "story_v_out_116011.awb") / 1000

					if var_200_20 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_20 + var_200_12
					end

					if var_200_15.prefab_name ~= "" and arg_197_1.actors_[var_200_15.prefab_name] ~= nil then
						local var_200_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_15.prefab_name].transform, "story_v_out_116011", "116011046", "story_v_out_116011.awb")

						arg_197_1:RecordAudio("116011046", var_200_21)
						arg_197_1:RecordAudio("116011046", var_200_21)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_116011", "116011046", "story_v_out_116011.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_116011", "116011046", "story_v_out_116011.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_22 = math.max(var_200_13, arg_197_1.talkMaxDuration)

			if var_200_12 <= arg_197_1.time_ and arg_197_1.time_ < var_200_12 + var_200_22 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_12) / var_200_22

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_12 + var_200_22 and arg_197_1.time_ < var_200_12 + var_200_22 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play116011047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 116011047
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play116011048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1039ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1039ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(0, 100, 0)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1039ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, 100, 0)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = arg_201_1.actors_["1048ui_story"].transform
			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1.var_.moveOldPos1048ui_story = var_204_9.localPosition
			end

			local var_204_11 = 0.001

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 then
				local var_204_12 = (arg_201_1.time_ - var_204_10) / var_204_11
				local var_204_13 = Vector3.New(0, 100, 0)

				var_204_9.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1048ui_story, var_204_13, var_204_12)

				local var_204_14 = manager.ui.mainCamera.transform.position - var_204_9.position

				var_204_9.forward = Vector3.New(var_204_14.x, var_204_14.y, var_204_14.z)

				local var_204_15 = var_204_9.localEulerAngles

				var_204_15.z = 0
				var_204_15.x = 0
				var_204_9.localEulerAngles = var_204_15
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 then
				var_204_9.localPosition = Vector3.New(0, 100, 0)

				local var_204_16 = manager.ui.mainCamera.transform.position - var_204_9.position

				var_204_9.forward = Vector3.New(var_204_16.x, var_204_16.y, var_204_16.z)

				local var_204_17 = var_204_9.localEulerAngles

				var_204_17.z = 0
				var_204_17.x = 0
				var_204_9.localEulerAngles = var_204_17
			end

			local var_204_18 = 0
			local var_204_19 = 0.625

			if var_204_18 < arg_201_1.time_ and arg_201_1.time_ <= var_204_18 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_20 = arg_201_1:GetWordFromCfg(116011047)
				local var_204_21 = arg_201_1:FormatText(var_204_20.content)

				arg_201_1.text_.text = var_204_21

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_22 = 25
				local var_204_23 = utf8.len(var_204_21)
				local var_204_24 = var_204_22 <= 0 and var_204_19 or var_204_19 * (var_204_23 / var_204_22)

				if var_204_24 > 0 and var_204_19 < var_204_24 then
					arg_201_1.talkMaxDuration = var_204_24

					if var_204_24 + var_204_18 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_24 + var_204_18
					end
				end

				arg_201_1.text_.text = var_204_21
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_25 = math.max(var_204_19, arg_201_1.talkMaxDuration)

			if var_204_18 <= arg_201_1.time_ and arg_201_1.time_ < var_204_18 + var_204_25 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_18) / var_204_25

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_18 + var_204_25 and arg_201_1.time_ < var_204_18 + var_204_25 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
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
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play116011048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 116011048
		arg_205_1.duration_ = 15.9

		local var_205_0 = {
			zh = 11.065999999999,
			ja = 15.899999999999
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play116011049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = "I05a"

			if arg_205_1.bgs_[var_208_0] == nil then
				local var_208_1 = Object.Instantiate(arg_205_1.paintGo_)

				var_208_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_208_0)
				var_208_1.name = var_208_0
				var_208_1.transform.parent = arg_205_1.stage_.transform
				var_208_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.bgs_[var_208_0] = var_208_1
			end

			local var_208_2 = 2

			if var_208_2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				local var_208_3 = manager.ui.mainCamera.transform.localPosition
				local var_208_4 = Vector3.New(0, 0, 10) + Vector3.New(var_208_3.x, var_208_3.y, 0)
				local var_208_5 = arg_205_1.bgs_.I05a

				var_208_5.transform.localPosition = var_208_4
				var_208_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_6 = var_208_5:GetComponent("SpriteRenderer")

				if var_208_6 and var_208_6.sprite then
					local var_208_7 = (var_208_5.transform.localPosition - var_208_3).z
					local var_208_8 = manager.ui.mainCameraCom_
					local var_208_9 = 2 * var_208_7 * Mathf.Tan(var_208_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_208_10 = var_208_9 * var_208_8.aspect
					local var_208_11 = var_208_6.sprite.bounds.size.x
					local var_208_12 = var_208_6.sprite.bounds.size.y
					local var_208_13 = var_208_10 / var_208_11
					local var_208_14 = var_208_9 / var_208_12
					local var_208_15 = var_208_14 < var_208_13 and var_208_13 or var_208_14

					var_208_5.transform.localScale = Vector3.New(var_208_15, var_208_15, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "I05a" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_16 = arg_205_1.actors_["1039ui_story"]
			local var_208_17 = 3.8

			if var_208_17 < arg_205_1.time_ and arg_205_1.time_ <= var_208_17 + arg_208_0 and not isNil(var_208_16) and arg_205_1.var_.characterEffect1039ui_story == nil then
				arg_205_1.var_.characterEffect1039ui_story = var_208_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_18 = 0.2

			if var_208_17 <= arg_205_1.time_ and arg_205_1.time_ < var_208_17 + var_208_18 and not isNil(var_208_16) then
				local var_208_19 = (arg_205_1.time_ - var_208_17) / var_208_18

				if arg_205_1.var_.characterEffect1039ui_story and not isNil(var_208_16) then
					local var_208_20 = Mathf.Lerp(0, 0.5, var_208_19)

					arg_205_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1039ui_story.fillRatio = var_208_20
				end
			end

			if arg_205_1.time_ >= var_208_17 + var_208_18 and arg_205_1.time_ < var_208_17 + var_208_18 + arg_208_0 and not isNil(var_208_16) and arg_205_1.var_.characterEffect1039ui_story then
				local var_208_21 = 0.5

				arg_205_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1039ui_story.fillRatio = var_208_21
			end

			local var_208_22 = arg_205_1.actors_["1048ui_story"]
			local var_208_23 = 3.8

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 and not isNil(var_208_22) and arg_205_1.var_.characterEffect1048ui_story == nil then
				arg_205_1.var_.characterEffect1048ui_story = var_208_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_24 = 0.2

			if var_208_23 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_24 and not isNil(var_208_22) then
				local var_208_25 = (arg_205_1.time_ - var_208_23) / var_208_24

				if arg_205_1.var_.characterEffect1048ui_story and not isNil(var_208_22) then
					arg_205_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_23 + var_208_24 and arg_205_1.time_ < var_208_23 + var_208_24 + arg_208_0 and not isNil(var_208_22) and arg_205_1.var_.characterEffect1048ui_story then
				arg_205_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_208_26 = arg_205_1.actors_["1039ui_story"].transform
			local var_208_27 = 3.8

			if var_208_27 < arg_205_1.time_ and arg_205_1.time_ <= var_208_27 + arg_208_0 then
				arg_205_1.var_.moveOldPos1039ui_story = var_208_26.localPosition
			end

			local var_208_28 = 0.001

			if var_208_27 <= arg_205_1.time_ and arg_205_1.time_ < var_208_27 + var_208_28 then
				local var_208_29 = (arg_205_1.time_ - var_208_27) / var_208_28
				local var_208_30 = Vector3.New(-0.7, -1.01, -5.9)

				var_208_26.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1039ui_story, var_208_30, var_208_29)

				local var_208_31 = manager.ui.mainCamera.transform.position - var_208_26.position

				var_208_26.forward = Vector3.New(var_208_31.x, var_208_31.y, var_208_31.z)

				local var_208_32 = var_208_26.localEulerAngles

				var_208_32.z = 0
				var_208_32.x = 0
				var_208_26.localEulerAngles = var_208_32
			end

			if arg_205_1.time_ >= var_208_27 + var_208_28 and arg_205_1.time_ < var_208_27 + var_208_28 + arg_208_0 then
				var_208_26.localPosition = Vector3.New(-0.7, -1.01, -5.9)

				local var_208_33 = manager.ui.mainCamera.transform.position - var_208_26.position

				var_208_26.forward = Vector3.New(var_208_33.x, var_208_33.y, var_208_33.z)

				local var_208_34 = var_208_26.localEulerAngles

				var_208_34.z = 0
				var_208_34.x = 0
				var_208_26.localEulerAngles = var_208_34
			end

			local var_208_35 = arg_205_1.actors_["1048ui_story"].transform
			local var_208_36 = 3.8

			if var_208_36 < arg_205_1.time_ and arg_205_1.time_ <= var_208_36 + arg_208_0 then
				arg_205_1.var_.moveOldPos1048ui_story = var_208_35.localPosition
			end

			local var_208_37 = 0.001

			if var_208_36 <= arg_205_1.time_ and arg_205_1.time_ < var_208_36 + var_208_37 then
				local var_208_38 = (arg_205_1.time_ - var_208_36) / var_208_37
				local var_208_39 = Vector3.New(0.7, -0.8, -6.2)

				var_208_35.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1048ui_story, var_208_39, var_208_38)

				local var_208_40 = manager.ui.mainCamera.transform.position - var_208_35.position

				var_208_35.forward = Vector3.New(var_208_40.x, var_208_40.y, var_208_40.z)

				local var_208_41 = var_208_35.localEulerAngles

				var_208_41.z = 0
				var_208_41.x = 0
				var_208_35.localEulerAngles = var_208_41
			end

			if arg_205_1.time_ >= var_208_36 + var_208_37 and arg_205_1.time_ < var_208_36 + var_208_37 + arg_208_0 then
				var_208_35.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_208_42 = manager.ui.mainCamera.transform.position - var_208_35.position

				var_208_35.forward = Vector3.New(var_208_42.x, var_208_42.y, var_208_42.z)

				local var_208_43 = var_208_35.localEulerAngles

				var_208_43.z = 0
				var_208_43.x = 0
				var_208_35.localEulerAngles = var_208_43
			end

			local var_208_44 = 0

			if var_208_44 < arg_205_1.time_ and arg_205_1.time_ <= var_208_44 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_45 = 2

			if var_208_44 <= arg_205_1.time_ and arg_205_1.time_ < var_208_44 + var_208_45 then
				local var_208_46 = (arg_205_1.time_ - var_208_44) / var_208_45
				local var_208_47 = Color.New(0, 0, 0)

				var_208_47.a = Mathf.Lerp(0, 1, var_208_46)
				arg_205_1.mask_.color = var_208_47
			end

			if arg_205_1.time_ >= var_208_44 + var_208_45 and arg_205_1.time_ < var_208_44 + var_208_45 + arg_208_0 then
				local var_208_48 = Color.New(0, 0, 0)

				var_208_48.a = 1
				arg_205_1.mask_.color = var_208_48
			end

			local var_208_49 = 2

			if var_208_49 < arg_205_1.time_ and arg_205_1.time_ <= var_208_49 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_50 = 2

			if var_208_49 <= arg_205_1.time_ and arg_205_1.time_ < var_208_49 + var_208_50 then
				local var_208_51 = (arg_205_1.time_ - var_208_49) / var_208_50
				local var_208_52 = Color.New(0, 0, 0)

				var_208_52.a = Mathf.Lerp(1, 0, var_208_51)
				arg_205_1.mask_.color = var_208_52
			end

			if arg_205_1.time_ >= var_208_49 + var_208_50 and arg_205_1.time_ < var_208_49 + var_208_50 + arg_208_0 then
				local var_208_53 = Color.New(0, 0, 0)
				local var_208_54 = 0

				arg_205_1.mask_.enabled = false
				var_208_53.a = var_208_54
				arg_205_1.mask_.color = var_208_53
			end

			local var_208_55 = 3.8

			if var_208_55 < arg_205_1.time_ and arg_205_1.time_ <= var_208_55 + arg_208_0 then
				arg_205_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action1_1")
			end

			local var_208_56 = 3.8

			if var_208_56 < arg_205_1.time_ and arg_205_1.time_ <= var_208_56 + arg_208_0 then
				arg_205_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action4_1")
			end

			local var_208_57 = 3.8

			if var_208_57 < arg_205_1.time_ and arg_205_1.time_ <= var_208_57 + arg_208_0 then
				arg_205_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_58 = 3.999999999999
			local var_208_59 = 0.85

			if var_208_58 < arg_205_1.time_ and arg_205_1.time_ <= var_208_58 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_60 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_60:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_61 = arg_205_1:FormatText(StoryNameCfg[8].name)

				arg_205_1.leftNameTxt_.text = var_208_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_62 = arg_205_1:GetWordFromCfg(116011048)
				local var_208_63 = arg_205_1:FormatText(var_208_62.content)

				arg_205_1.text_.text = var_208_63

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_64 = 34
				local var_208_65 = utf8.len(var_208_63)
				local var_208_66 = var_208_64 <= 0 and var_208_59 or var_208_59 * (var_208_65 / var_208_64)

				if var_208_66 > 0 and var_208_59 < var_208_66 then
					arg_205_1.talkMaxDuration = var_208_66
					var_208_58 = var_208_58 + 0.3

					if var_208_66 + var_208_58 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_66 + var_208_58
					end
				end

				arg_205_1.text_.text = var_208_63
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011048", "story_v_out_116011.awb") ~= 0 then
					local var_208_67 = manager.audio:GetVoiceLength("story_v_out_116011", "116011048", "story_v_out_116011.awb") / 1000

					if var_208_67 + var_208_58 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_67 + var_208_58
					end

					if var_208_62.prefab_name ~= "" and arg_205_1.actors_[var_208_62.prefab_name] ~= nil then
						local var_208_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_62.prefab_name].transform, "story_v_out_116011", "116011048", "story_v_out_116011.awb")

						arg_205_1:RecordAudio("116011048", var_208_68)
						arg_205_1:RecordAudio("116011048", var_208_68)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_116011", "116011048", "story_v_out_116011.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_116011", "116011048", "story_v_out_116011.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_69 = var_208_58 + 0.3
			local var_208_70 = math.max(var_208_59, arg_205_1.talkMaxDuration)

			if var_208_69 <= arg_205_1.time_ and arg_205_1.time_ < var_208_69 + var_208_70 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_69) / var_208_70

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_69 + var_208_70 and arg_205_1.time_ < var_208_69 + var_208_70 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play116011049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 116011049
		arg_211_1.duration_ = 17.03

		local var_211_0 = {
			zh = 9.633,
			ja = 17.033
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
				arg_211_0:Play116011050(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action447")
			end

			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_214_2 = 0
			local var_214_3 = 0.975

			if var_214_2 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_4 = arg_211_1:FormatText(StoryNameCfg[8].name)

				arg_211_1.leftNameTxt_.text = var_214_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_5 = arg_211_1:GetWordFromCfg(116011049)
				local var_214_6 = arg_211_1:FormatText(var_214_5.content)

				arg_211_1.text_.text = var_214_6

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 39
				local var_214_8 = utf8.len(var_214_6)
				local var_214_9 = var_214_7 <= 0 and var_214_3 or var_214_3 * (var_214_8 / var_214_7)

				if var_214_9 > 0 and var_214_3 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_6
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011049", "story_v_out_116011.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011049", "story_v_out_116011.awb") / 1000

					if var_214_10 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_2
					end

					if var_214_5.prefab_name ~= "" and arg_211_1.actors_[var_214_5.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_5.prefab_name].transform, "story_v_out_116011", "116011049", "story_v_out_116011.awb")

						arg_211_1:RecordAudio("116011049", var_214_11)
						arg_211_1:RecordAudio("116011049", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_116011", "116011049", "story_v_out_116011.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_116011", "116011049", "story_v_out_116011.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_12 and arg_211_1.time_ < var_214_2 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play116011050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 116011050
		arg_215_1.duration_ = 22.83

		local var_215_0 = {
			zh = 13.866,
			ja = 22.833
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
				arg_215_0:Play116011051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1039ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1039ui_story == nil then
				arg_215_1.var_.characterEffect1039ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.2

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1039ui_story and not isNil(var_218_0) then
					arg_215_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1039ui_story then
				arg_215_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_218_4 = arg_215_1.actors_["1048ui_story"]
			local var_218_5 = 0

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect1048ui_story == nil then
				arg_215_1.var_.characterEffect1048ui_story = var_218_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_6 = 0.2

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_6 and not isNil(var_218_4) then
				local var_218_7 = (arg_215_1.time_ - var_218_5) / var_218_6

				if arg_215_1.var_.characterEffect1048ui_story and not isNil(var_218_4) then
					local var_218_8 = Mathf.Lerp(0, 0.5, var_218_7)

					arg_215_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1048ui_story.fillRatio = var_218_8
				end
			end

			if arg_215_1.time_ >= var_218_5 + var_218_6 and arg_215_1.time_ < var_218_5 + var_218_6 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect1048ui_story then
				local var_218_9 = 0.5

				arg_215_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1048ui_story.fillRatio = var_218_9
			end

			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				arg_215_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_218_11 = 0

			if var_218_11 < arg_215_1.time_ and arg_215_1.time_ <= var_218_11 + arg_218_0 then
				arg_215_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_218_12 = 0
			local var_218_13 = 1.55

			if var_218_12 < arg_215_1.time_ and arg_215_1.time_ <= var_218_12 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_14 = arg_215_1:FormatText(StoryNameCfg[9].name)

				arg_215_1.leftNameTxt_.text = var_218_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_15 = arg_215_1:GetWordFromCfg(116011050)
				local var_218_16 = arg_215_1:FormatText(var_218_15.content)

				arg_215_1.text_.text = var_218_16

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_17 = 62
				local var_218_18 = utf8.len(var_218_16)
				local var_218_19 = var_218_17 <= 0 and var_218_13 or var_218_13 * (var_218_18 / var_218_17)

				if var_218_19 > 0 and var_218_13 < var_218_19 then
					arg_215_1.talkMaxDuration = var_218_19

					if var_218_19 + var_218_12 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_19 + var_218_12
					end
				end

				arg_215_1.text_.text = var_218_16
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011050", "story_v_out_116011.awb") ~= 0 then
					local var_218_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011050", "story_v_out_116011.awb") / 1000

					if var_218_20 + var_218_12 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_20 + var_218_12
					end

					if var_218_15.prefab_name ~= "" and arg_215_1.actors_[var_218_15.prefab_name] ~= nil then
						local var_218_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_15.prefab_name].transform, "story_v_out_116011", "116011050", "story_v_out_116011.awb")

						arg_215_1:RecordAudio("116011050", var_218_21)
						arg_215_1:RecordAudio("116011050", var_218_21)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_116011", "116011050", "story_v_out_116011.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_116011", "116011050", "story_v_out_116011.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_22 = math.max(var_218_13, arg_215_1.talkMaxDuration)

			if var_218_12 <= arg_215_1.time_ and arg_215_1.time_ < var_218_12 + var_218_22 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_12) / var_218_22

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_12 + var_218_22 and arg_215_1.time_ < var_218_12 + var_218_22 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play116011051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 116011051
		arg_219_1.duration_ = 4.8

		local var_219_0 = {
			zh = 2.466,
			ja = 4.8
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
				arg_219_0:Play116011052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1048ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1048ui_story == nil then
				arg_219_1.var_.characterEffect1048ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.2

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect1048ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1048ui_story then
				arg_219_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_222_4 = arg_219_1.actors_["1039ui_story"]
			local var_222_5 = 0

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect1039ui_story == nil then
				arg_219_1.var_.characterEffect1039ui_story = var_222_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_6 = 0.2

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_6 and not isNil(var_222_4) then
				local var_222_7 = (arg_219_1.time_ - var_222_5) / var_222_6

				if arg_219_1.var_.characterEffect1039ui_story and not isNil(var_222_4) then
					local var_222_8 = Mathf.Lerp(0, 0.5, var_222_7)

					arg_219_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1039ui_story.fillRatio = var_222_8
				end
			end

			if arg_219_1.time_ >= var_222_5 + var_222_6 and arg_219_1.time_ < var_222_5 + var_222_6 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect1039ui_story then
				local var_222_9 = 0.5

				arg_219_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1039ui_story.fillRatio = var_222_9
			end

			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 then
				arg_219_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action7_2")
			end

			local var_222_11 = 0

			if var_222_11 < arg_219_1.time_ and arg_219_1.time_ <= var_222_11 + arg_222_0 then
				arg_219_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_222_12 = 0
			local var_222_13 = 0.275

			if var_222_12 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_14 = arg_219_1:FormatText(StoryNameCfg[8].name)

				arg_219_1.leftNameTxt_.text = var_222_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_15 = arg_219_1:GetWordFromCfg(116011051)
				local var_222_16 = arg_219_1:FormatText(var_222_15.content)

				arg_219_1.text_.text = var_222_16

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_17 = 11
				local var_222_18 = utf8.len(var_222_16)
				local var_222_19 = var_222_17 <= 0 and var_222_13 or var_222_13 * (var_222_18 / var_222_17)

				if var_222_19 > 0 and var_222_13 < var_222_19 then
					arg_219_1.talkMaxDuration = var_222_19

					if var_222_19 + var_222_12 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_19 + var_222_12
					end
				end

				arg_219_1.text_.text = var_222_16
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011051", "story_v_out_116011.awb") ~= 0 then
					local var_222_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011051", "story_v_out_116011.awb") / 1000

					if var_222_20 + var_222_12 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_20 + var_222_12
					end

					if var_222_15.prefab_name ~= "" and arg_219_1.actors_[var_222_15.prefab_name] ~= nil then
						local var_222_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_15.prefab_name].transform, "story_v_out_116011", "116011051", "story_v_out_116011.awb")

						arg_219_1:RecordAudio("116011051", var_222_21)
						arg_219_1:RecordAudio("116011051", var_222_21)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_116011", "116011051", "story_v_out_116011.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_116011", "116011051", "story_v_out_116011.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_22 = math.max(var_222_13, arg_219_1.talkMaxDuration)

			if var_222_12 <= arg_219_1.time_ and arg_219_1.time_ < var_222_12 + var_222_22 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_12) / var_222_22

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_12 + var_222_22 and arg_219_1.time_ < var_222_12 + var_222_22 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play116011052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 116011052
		arg_223_1.duration_ = 3.9

		local var_223_0 = {
			zh = 2.933,
			ja = 3.9
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
				arg_223_0:Play116011053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1048ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1048ui_story == nil then
				arg_223_1.var_.characterEffect1048ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1048ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1048ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1048ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1048ui_story.fillRatio = var_226_5
			end

			local var_226_6 = arg_223_1.actors_["1039ui_story"]
			local var_226_7 = 0

			if var_226_7 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect1039ui_story == nil then
				arg_223_1.var_.characterEffect1039ui_story = var_226_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_8 = 0.2

			if var_226_7 <= arg_223_1.time_ and arg_223_1.time_ < var_226_7 + var_226_8 and not isNil(var_226_6) then
				local var_226_9 = (arg_223_1.time_ - var_226_7) / var_226_8

				if arg_223_1.var_.characterEffect1039ui_story and not isNil(var_226_6) then
					arg_223_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_7 + var_226_8 and arg_223_1.time_ < var_226_7 + var_226_8 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect1039ui_story then
				arg_223_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 then
				arg_223_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_226_11 = 0
			local var_226_12 = 0.2

			if var_226_11 < arg_223_1.time_ and arg_223_1.time_ <= var_226_11 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_13 = arg_223_1:FormatText(StoryNameCfg[9].name)

				arg_223_1.leftNameTxt_.text = var_226_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_14 = arg_223_1:GetWordFromCfg(116011052)
				local var_226_15 = arg_223_1:FormatText(var_226_14.content)

				arg_223_1.text_.text = var_226_15

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_16 = 8
				local var_226_17 = utf8.len(var_226_15)
				local var_226_18 = var_226_16 <= 0 and var_226_12 or var_226_12 * (var_226_17 / var_226_16)

				if var_226_18 > 0 and var_226_12 < var_226_18 then
					arg_223_1.talkMaxDuration = var_226_18

					if var_226_18 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_18 + var_226_11
					end
				end

				arg_223_1.text_.text = var_226_15
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011052", "story_v_out_116011.awb") ~= 0 then
					local var_226_19 = manager.audio:GetVoiceLength("story_v_out_116011", "116011052", "story_v_out_116011.awb") / 1000

					if var_226_19 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_19 + var_226_11
					end

					if var_226_14.prefab_name ~= "" and arg_223_1.actors_[var_226_14.prefab_name] ~= nil then
						local var_226_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_14.prefab_name].transform, "story_v_out_116011", "116011052", "story_v_out_116011.awb")

						arg_223_1:RecordAudio("116011052", var_226_20)
						arg_223_1:RecordAudio("116011052", var_226_20)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_116011", "116011052", "story_v_out_116011.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_116011", "116011052", "story_v_out_116011.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_21 = math.max(var_226_12, arg_223_1.talkMaxDuration)

			if var_226_11 <= arg_223_1.time_ and arg_223_1.time_ < var_226_11 + var_226_21 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_11) / var_226_21

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_11 + var_226_21 and arg_223_1.time_ < var_226_11 + var_226_21 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play116011053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 116011053
		arg_227_1.duration_ = 14.13

		local var_227_0 = {
			zh = 11.8,
			ja = 14.133
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
				arg_227_0:Play116011054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1048ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1048ui_story == nil then
				arg_227_1.var_.characterEffect1048ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.2

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1048ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1048ui_story then
				arg_227_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_230_4 = arg_227_1.actors_["1039ui_story"]
			local var_230_5 = 0

			if var_230_5 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect1039ui_story == nil then
				arg_227_1.var_.characterEffect1039ui_story = var_230_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_6 = 0.2

			if var_230_5 <= arg_227_1.time_ and arg_227_1.time_ < var_230_5 + var_230_6 and not isNil(var_230_4) then
				local var_230_7 = (arg_227_1.time_ - var_230_5) / var_230_6

				if arg_227_1.var_.characterEffect1039ui_story and not isNil(var_230_4) then
					local var_230_8 = Mathf.Lerp(0, 0.5, var_230_7)

					arg_227_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1039ui_story.fillRatio = var_230_8
				end
			end

			if arg_227_1.time_ >= var_230_5 + var_230_6 and arg_227_1.time_ < var_230_5 + var_230_6 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect1039ui_story then
				local var_230_9 = 0.5

				arg_227_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1039ui_story.fillRatio = var_230_9
			end

			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 then
				arg_227_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_1")
			end

			local var_230_11 = 0

			if var_230_11 < arg_227_1.time_ and arg_227_1.time_ <= var_230_11 + arg_230_0 then
				arg_227_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_230_12 = 0
			local var_230_13 = 1.125

			if var_230_12 < arg_227_1.time_ and arg_227_1.time_ <= var_230_12 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_14 = arg_227_1:FormatText(StoryNameCfg[8].name)

				arg_227_1.leftNameTxt_.text = var_230_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_15 = arg_227_1:GetWordFromCfg(116011053)
				local var_230_16 = arg_227_1:FormatText(var_230_15.content)

				arg_227_1.text_.text = var_230_16

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_17 = 45
				local var_230_18 = utf8.len(var_230_16)
				local var_230_19 = var_230_17 <= 0 and var_230_13 or var_230_13 * (var_230_18 / var_230_17)

				if var_230_19 > 0 and var_230_13 < var_230_19 then
					arg_227_1.talkMaxDuration = var_230_19

					if var_230_19 + var_230_12 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_19 + var_230_12
					end
				end

				arg_227_1.text_.text = var_230_16
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011053", "story_v_out_116011.awb") ~= 0 then
					local var_230_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011053", "story_v_out_116011.awb") / 1000

					if var_230_20 + var_230_12 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_20 + var_230_12
					end

					if var_230_15.prefab_name ~= "" and arg_227_1.actors_[var_230_15.prefab_name] ~= nil then
						local var_230_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_15.prefab_name].transform, "story_v_out_116011", "116011053", "story_v_out_116011.awb")

						arg_227_1:RecordAudio("116011053", var_230_21)
						arg_227_1:RecordAudio("116011053", var_230_21)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_116011", "116011053", "story_v_out_116011.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_116011", "116011053", "story_v_out_116011.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_22 = math.max(var_230_13, arg_227_1.talkMaxDuration)

			if var_230_12 <= arg_227_1.time_ and arg_227_1.time_ < var_230_12 + var_230_22 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_12) / var_230_22

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_12 + var_230_22 and arg_227_1.time_ < var_230_12 + var_230_22 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play116011054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 116011054
		arg_231_1.duration_ = 5.87

		local var_231_0 = {
			zh = 2.466,
			ja = 5.866
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
				arg_231_0:Play116011055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1039ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1039ui_story == nil then
				arg_231_1.var_.characterEffect1039ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1039ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1039ui_story then
				arg_231_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_234_4 = arg_231_1.actors_["1048ui_story"]
			local var_234_5 = 0

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect1048ui_story == nil then
				arg_231_1.var_.characterEffect1048ui_story = var_234_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.2

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 and not isNil(var_234_4) then
				local var_234_7 = (arg_231_1.time_ - var_234_5) / var_234_6

				if arg_231_1.var_.characterEffect1048ui_story and not isNil(var_234_4) then
					local var_234_8 = Mathf.Lerp(0, 0.5, var_234_7)

					arg_231_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1048ui_story.fillRatio = var_234_8
				end
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect1048ui_story then
				local var_234_9 = 0.5

				arg_231_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1048ui_story.fillRatio = var_234_9
			end

			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			local var_234_11 = 0

			if var_234_11 < arg_231_1.time_ and arg_231_1.time_ <= var_234_11 + arg_234_0 then
				arg_231_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_234_12 = 0
			local var_234_13 = 0.225

			if var_234_12 < arg_231_1.time_ and arg_231_1.time_ <= var_234_12 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_14 = arg_231_1:FormatText(StoryNameCfg[9].name)

				arg_231_1.leftNameTxt_.text = var_234_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_15 = arg_231_1:GetWordFromCfg(116011054)
				local var_234_16 = arg_231_1:FormatText(var_234_15.content)

				arg_231_1.text_.text = var_234_16

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_17 = 9
				local var_234_18 = utf8.len(var_234_16)
				local var_234_19 = var_234_17 <= 0 and var_234_13 or var_234_13 * (var_234_18 / var_234_17)

				if var_234_19 > 0 and var_234_13 < var_234_19 then
					arg_231_1.talkMaxDuration = var_234_19

					if var_234_19 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_12
					end
				end

				arg_231_1.text_.text = var_234_16
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011054", "story_v_out_116011.awb") ~= 0 then
					local var_234_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011054", "story_v_out_116011.awb") / 1000

					if var_234_20 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_20 + var_234_12
					end

					if var_234_15.prefab_name ~= "" and arg_231_1.actors_[var_234_15.prefab_name] ~= nil then
						local var_234_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_15.prefab_name].transform, "story_v_out_116011", "116011054", "story_v_out_116011.awb")

						arg_231_1:RecordAudio("116011054", var_234_21)
						arg_231_1:RecordAudio("116011054", var_234_21)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_116011", "116011054", "story_v_out_116011.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_116011", "116011054", "story_v_out_116011.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_22 = math.max(var_234_13, arg_231_1.talkMaxDuration)

			if var_234_12 <= arg_231_1.time_ and arg_231_1.time_ < var_234_12 + var_234_22 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_12) / var_234_22

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_12 + var_234_22 and arg_231_1.time_ < var_234_12 + var_234_22 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play116011055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 116011055
		arg_235_1.duration_ = 12.77

		local var_235_0 = {
			zh = 5.4,
			ja = 12.766
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
				arg_235_0:Play116011056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1048ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1048ui_story == nil then
				arg_235_1.var_.characterEffect1048ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1048ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1048ui_story then
				arg_235_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_238_4 = arg_235_1.actors_["1039ui_story"]
			local var_238_5 = 0

			if var_238_5 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1039ui_story == nil then
				arg_235_1.var_.characterEffect1039ui_story = var_238_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_6 = 0.2

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_6 and not isNil(var_238_4) then
				local var_238_7 = (arg_235_1.time_ - var_238_5) / var_238_6

				if arg_235_1.var_.characterEffect1039ui_story and not isNil(var_238_4) then
					local var_238_8 = Mathf.Lerp(0, 0.5, var_238_7)

					arg_235_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1039ui_story.fillRatio = var_238_8
				end
			end

			if arg_235_1.time_ >= var_238_5 + var_238_6 and arg_235_1.time_ < var_238_5 + var_238_6 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1039ui_story then
				local var_238_9 = 0.5

				arg_235_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1039ui_story.fillRatio = var_238_9
			end

			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 then
				arg_235_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action429")
			end

			local var_238_11 = 0

			if var_238_11 < arg_235_1.time_ and arg_235_1.time_ <= var_238_11 + arg_238_0 then
				arg_235_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_238_12 = 0
			local var_238_13 = 0.575

			if var_238_12 < arg_235_1.time_ and arg_235_1.time_ <= var_238_12 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_14 = arg_235_1:FormatText(StoryNameCfg[8].name)

				arg_235_1.leftNameTxt_.text = var_238_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_15 = arg_235_1:GetWordFromCfg(116011055)
				local var_238_16 = arg_235_1:FormatText(var_238_15.content)

				arg_235_1.text_.text = var_238_16

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_17 = 23
				local var_238_18 = utf8.len(var_238_16)
				local var_238_19 = var_238_17 <= 0 and var_238_13 or var_238_13 * (var_238_18 / var_238_17)

				if var_238_19 > 0 and var_238_13 < var_238_19 then
					arg_235_1.talkMaxDuration = var_238_19

					if var_238_19 + var_238_12 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_19 + var_238_12
					end
				end

				arg_235_1.text_.text = var_238_16
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011055", "story_v_out_116011.awb") ~= 0 then
					local var_238_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011055", "story_v_out_116011.awb") / 1000

					if var_238_20 + var_238_12 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_20 + var_238_12
					end

					if var_238_15.prefab_name ~= "" and arg_235_1.actors_[var_238_15.prefab_name] ~= nil then
						local var_238_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_15.prefab_name].transform, "story_v_out_116011", "116011055", "story_v_out_116011.awb")

						arg_235_1:RecordAudio("116011055", var_238_21)
						arg_235_1:RecordAudio("116011055", var_238_21)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_116011", "116011055", "story_v_out_116011.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_116011", "116011055", "story_v_out_116011.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_22 = math.max(var_238_13, arg_235_1.talkMaxDuration)

			if var_238_12 <= arg_235_1.time_ and arg_235_1.time_ < var_238_12 + var_238_22 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_12) / var_238_22

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_12 + var_238_22 and arg_235_1.time_ < var_238_12 + var_238_22 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play116011056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 116011056
		arg_239_1.duration_ = 5.2

		local var_239_0 = {
			zh = 3.933,
			ja = 5.2
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
				arg_239_0:Play116011057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1048ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1048ui_story == nil then
				arg_239_1.var_.characterEffect1048ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.2

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect1048ui_story and not isNil(var_242_0) then
					local var_242_4 = Mathf.Lerp(0, 0.5, var_242_3)

					arg_239_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1048ui_story.fillRatio = var_242_4
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1048ui_story then
				local var_242_5 = 0.5

				arg_239_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1048ui_story.fillRatio = var_242_5
			end

			local var_242_6 = arg_239_1.actors_["1039ui_story"]
			local var_242_7 = 0

			if var_242_7 < arg_239_1.time_ and arg_239_1.time_ <= var_242_7 + arg_242_0 and not isNil(var_242_6) and arg_239_1.var_.characterEffect1039ui_story == nil then
				arg_239_1.var_.characterEffect1039ui_story = var_242_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_8 = 0.2

			if var_242_7 <= arg_239_1.time_ and arg_239_1.time_ < var_242_7 + var_242_8 and not isNil(var_242_6) then
				local var_242_9 = (arg_239_1.time_ - var_242_7) / var_242_8

				if arg_239_1.var_.characterEffect1039ui_story and not isNil(var_242_6) then
					arg_239_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_7 + var_242_8 and arg_239_1.time_ < var_242_7 + var_242_8 + arg_242_0 and not isNil(var_242_6) and arg_239_1.var_.characterEffect1039ui_story then
				arg_239_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 then
				arg_239_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_242_11 = 0

			if var_242_11 < arg_239_1.time_ and arg_239_1.time_ <= var_242_11 + arg_242_0 then
				arg_239_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action446")
			end

			local var_242_12 = 0
			local var_242_13 = 0.45

			if var_242_12 < arg_239_1.time_ and arg_239_1.time_ <= var_242_12 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_14 = arg_239_1:FormatText(StoryNameCfg[9].name)

				arg_239_1.leftNameTxt_.text = var_242_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_15 = arg_239_1:GetWordFromCfg(116011056)
				local var_242_16 = arg_239_1:FormatText(var_242_15.content)

				arg_239_1.text_.text = var_242_16

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_17 = 18
				local var_242_18 = utf8.len(var_242_16)
				local var_242_19 = var_242_17 <= 0 and var_242_13 or var_242_13 * (var_242_18 / var_242_17)

				if var_242_19 > 0 and var_242_13 < var_242_19 then
					arg_239_1.talkMaxDuration = var_242_19

					if var_242_19 + var_242_12 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_19 + var_242_12
					end
				end

				arg_239_1.text_.text = var_242_16
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011056", "story_v_out_116011.awb") ~= 0 then
					local var_242_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011056", "story_v_out_116011.awb") / 1000

					if var_242_20 + var_242_12 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_20 + var_242_12
					end

					if var_242_15.prefab_name ~= "" and arg_239_1.actors_[var_242_15.prefab_name] ~= nil then
						local var_242_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_15.prefab_name].transform, "story_v_out_116011", "116011056", "story_v_out_116011.awb")

						arg_239_1:RecordAudio("116011056", var_242_21)
						arg_239_1:RecordAudio("116011056", var_242_21)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_116011", "116011056", "story_v_out_116011.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_116011", "116011056", "story_v_out_116011.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_22 = math.max(var_242_13, arg_239_1.talkMaxDuration)

			if var_242_12 <= arg_239_1.time_ and arg_239_1.time_ < var_242_12 + var_242_22 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_12) / var_242_22

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_12 + var_242_22 and arg_239_1.time_ < var_242_12 + var_242_22 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play116011057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 116011057
		arg_243_1.duration_ = 9

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play116011058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 2

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				local var_246_1 = manager.ui.mainCamera.transform.localPosition
				local var_246_2 = Vector3.New(0, 0, 10) + Vector3.New(var_246_1.x, var_246_1.y, 0)
				local var_246_3 = arg_243_1.bgs_.I05f

				var_246_3.transform.localPosition = var_246_2
				var_246_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_4 = var_246_3:GetComponent("SpriteRenderer")

				if var_246_4 and var_246_4.sprite then
					local var_246_5 = (var_246_3.transform.localPosition - var_246_1).z
					local var_246_6 = manager.ui.mainCameraCom_
					local var_246_7 = 2 * var_246_5 * Mathf.Tan(var_246_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_246_8 = var_246_7 * var_246_6.aspect
					local var_246_9 = var_246_4.sprite.bounds.size.x
					local var_246_10 = var_246_4.sprite.bounds.size.y
					local var_246_11 = var_246_8 / var_246_9
					local var_246_12 = var_246_7 / var_246_10
					local var_246_13 = var_246_12 < var_246_11 and var_246_11 or var_246_12

					var_246_3.transform.localScale = Vector3.New(var_246_13, var_246_13, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "I05f" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_14 = 0

			if var_246_14 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_15 = 2

			if var_246_14 <= arg_243_1.time_ and arg_243_1.time_ < var_246_14 + var_246_15 then
				local var_246_16 = (arg_243_1.time_ - var_246_14) / var_246_15
				local var_246_17 = Color.New(0, 0, 0)

				var_246_17.a = Mathf.Lerp(0, 1, var_246_16)
				arg_243_1.mask_.color = var_246_17
			end

			if arg_243_1.time_ >= var_246_14 + var_246_15 and arg_243_1.time_ < var_246_14 + var_246_15 + arg_246_0 then
				local var_246_18 = Color.New(0, 0, 0)

				var_246_18.a = 1
				arg_243_1.mask_.color = var_246_18
			end

			local var_246_19 = 2

			if var_246_19 < arg_243_1.time_ and arg_243_1.time_ <= var_246_19 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_20 = 2

			if var_246_19 <= arg_243_1.time_ and arg_243_1.time_ < var_246_19 + var_246_20 then
				local var_246_21 = (arg_243_1.time_ - var_246_19) / var_246_20
				local var_246_22 = Color.New(0, 0, 0)

				var_246_22.a = Mathf.Lerp(1, 0, var_246_21)
				arg_243_1.mask_.color = var_246_22
			end

			if arg_243_1.time_ >= var_246_19 + var_246_20 and arg_243_1.time_ < var_246_19 + var_246_20 + arg_246_0 then
				local var_246_23 = Color.New(0, 0, 0)
				local var_246_24 = 0

				arg_243_1.mask_.enabled = false
				var_246_23.a = var_246_24
				arg_243_1.mask_.color = var_246_23
			end

			local var_246_25 = arg_243_1.actors_["1048ui_story"].transform
			local var_246_26 = 1.966

			if var_246_26 < arg_243_1.time_ and arg_243_1.time_ <= var_246_26 + arg_246_0 then
				arg_243_1.var_.moveOldPos1048ui_story = var_246_25.localPosition
			end

			local var_246_27 = 0.001

			if var_246_26 <= arg_243_1.time_ and arg_243_1.time_ < var_246_26 + var_246_27 then
				local var_246_28 = (arg_243_1.time_ - var_246_26) / var_246_27
				local var_246_29 = Vector3.New(0, 100, 0)

				var_246_25.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1048ui_story, var_246_29, var_246_28)

				local var_246_30 = manager.ui.mainCamera.transform.position - var_246_25.position

				var_246_25.forward = Vector3.New(var_246_30.x, var_246_30.y, var_246_30.z)

				local var_246_31 = var_246_25.localEulerAngles

				var_246_31.z = 0
				var_246_31.x = 0
				var_246_25.localEulerAngles = var_246_31
			end

			if arg_243_1.time_ >= var_246_26 + var_246_27 and arg_243_1.time_ < var_246_26 + var_246_27 + arg_246_0 then
				var_246_25.localPosition = Vector3.New(0, 100, 0)

				local var_246_32 = manager.ui.mainCamera.transform.position - var_246_25.position

				var_246_25.forward = Vector3.New(var_246_32.x, var_246_32.y, var_246_32.z)

				local var_246_33 = var_246_25.localEulerAngles

				var_246_33.z = 0
				var_246_33.x = 0
				var_246_25.localEulerAngles = var_246_33
			end

			local var_246_34 = arg_243_1.actors_["1039ui_story"].transform
			local var_246_35 = 1.966

			if var_246_35 < arg_243_1.time_ and arg_243_1.time_ <= var_246_35 + arg_246_0 then
				arg_243_1.var_.moveOldPos1039ui_story = var_246_34.localPosition
			end

			local var_246_36 = 0.001

			if var_246_35 <= arg_243_1.time_ and arg_243_1.time_ < var_246_35 + var_246_36 then
				local var_246_37 = (arg_243_1.time_ - var_246_35) / var_246_36
				local var_246_38 = Vector3.New(0, 100, 0)

				var_246_34.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1039ui_story, var_246_38, var_246_37)

				local var_246_39 = manager.ui.mainCamera.transform.position - var_246_34.position

				var_246_34.forward = Vector3.New(var_246_39.x, var_246_39.y, var_246_39.z)

				local var_246_40 = var_246_34.localEulerAngles

				var_246_40.z = 0
				var_246_40.x = 0
				var_246_34.localEulerAngles = var_246_40
			end

			if arg_243_1.time_ >= var_246_35 + var_246_36 and arg_243_1.time_ < var_246_35 + var_246_36 + arg_246_0 then
				var_246_34.localPosition = Vector3.New(0, 100, 0)

				local var_246_41 = manager.ui.mainCamera.transform.position - var_246_34.position

				var_246_34.forward = Vector3.New(var_246_41.x, var_246_41.y, var_246_41.z)

				local var_246_42 = var_246_34.localEulerAngles

				var_246_42.z = 0
				var_246_42.x = 0
				var_246_34.localEulerAngles = var_246_42
			end

			local var_246_43 = arg_243_1.bgs_.I05f
			local var_246_44 = 2

			if var_246_44 < arg_243_1.time_ and arg_243_1.time_ <= var_246_44 + arg_246_0 then
				local var_246_45 = var_246_43:GetComponent("SpriteRenderer")

				if var_246_45 then
					arg_243_1.var_.alphaOldValueI05f = var_246_45.color.a
					arg_243_1.var_.alphaMatValueI05f = var_246_45
				end

				arg_243_1.var_.alphaOldValueI05f = 0
			end

			local var_246_46 = 0.0166666666666667

			if var_246_44 <= arg_243_1.time_ and arg_243_1.time_ < var_246_44 + var_246_46 then
				local var_246_47 = (arg_243_1.time_ - var_246_44) / var_246_46
				local var_246_48 = Mathf.Lerp(arg_243_1.var_.alphaOldValueI05f, 1, var_246_47)

				if arg_243_1.var_.alphaMatValueI05f then
					local var_246_49 = arg_243_1.var_.alphaMatValueI05f.color

					var_246_49.a = var_246_48
					arg_243_1.var_.alphaMatValueI05f.color = var_246_49
				end
			end

			if arg_243_1.time_ >= var_246_44 + var_246_46 and arg_243_1.time_ < var_246_44 + var_246_46 + arg_246_0 and arg_243_1.var_.alphaMatValueI05f then
				local var_246_50 = arg_243_1.var_.alphaMatValueI05f
				local var_246_51 = var_246_50.color

				var_246_51.a = 1
				var_246_50.color = var_246_51
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_52 = 3.999999999999
			local var_246_53 = 0.55

			if var_246_52 < arg_243_1.time_ and arg_243_1.time_ <= var_246_52 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_54 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_54:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_55 = arg_243_1:GetWordFromCfg(116011057)
				local var_246_56 = arg_243_1:FormatText(var_246_55.content)

				arg_243_1.text_.text = var_246_56

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_57 = 22
				local var_246_58 = utf8.len(var_246_56)
				local var_246_59 = var_246_57 <= 0 and var_246_53 or var_246_53 * (var_246_58 / var_246_57)

				if var_246_59 > 0 and var_246_53 < var_246_59 then
					arg_243_1.talkMaxDuration = var_246_59
					var_246_52 = var_246_52 + 0.3

					if var_246_59 + var_246_52 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_59 + var_246_52
					end
				end

				arg_243_1.text_.text = var_246_56
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_60 = var_246_52 + 0.3
			local var_246_61 = math.max(var_246_53, arg_243_1.talkMaxDuration)

			if var_246_60 <= arg_243_1.time_ and arg_243_1.time_ < var_246_60 + var_246_61 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_60) / var_246_61

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_60 + var_246_61 and arg_243_1.time_ < var_246_60 + var_246_61 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play116011058 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 116011058
		arg_249_1.duration_ = 4.63

		local var_249_0 = {
			zh = 4.466,
			ja = 4.633
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play116011059(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1048ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1048ui_story == nil then
				arg_249_1.var_.characterEffect1048ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.0166666666666667

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1048ui_story and not isNil(var_252_0) then
					local var_252_4 = Mathf.Lerp(0, 0.5, var_252_3)

					arg_249_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1048ui_story.fillRatio = var_252_4
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1048ui_story then
				local var_252_5 = 0.5

				arg_249_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1048ui_story.fillRatio = var_252_5
			end

			local var_252_6 = arg_249_1.actors_["1039ui_story"]
			local var_252_7 = 0

			if var_252_7 < arg_249_1.time_ and arg_249_1.time_ <= var_252_7 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect1039ui_story == nil then
				arg_249_1.var_.characterEffect1039ui_story = var_252_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_8 = 0.0166666666666667

			if var_252_7 <= arg_249_1.time_ and arg_249_1.time_ < var_252_7 + var_252_8 and not isNil(var_252_6) then
				local var_252_9 = (arg_249_1.time_ - var_252_7) / var_252_8

				if arg_249_1.var_.characterEffect1039ui_story and not isNil(var_252_6) then
					arg_249_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_7 + var_252_8 and arg_249_1.time_ < var_252_7 + var_252_8 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect1039ui_story then
				arg_249_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_252_10 = arg_249_1.actors_["1039ui_story"].transform
			local var_252_11 = 0

			if var_252_11 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1.var_.moveOldPos1039ui_story = var_252_10.localPosition
			end

			local var_252_12 = 0.001

			if var_252_11 <= arg_249_1.time_ and arg_249_1.time_ < var_252_11 + var_252_12 then
				local var_252_13 = (arg_249_1.time_ - var_252_11) / var_252_12
				local var_252_14 = Vector3.New(-0.7, -1.01, -5.9)

				var_252_10.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1039ui_story, var_252_14, var_252_13)

				local var_252_15 = manager.ui.mainCamera.transform.position - var_252_10.position

				var_252_10.forward = Vector3.New(var_252_15.x, var_252_15.y, var_252_15.z)

				local var_252_16 = var_252_10.localEulerAngles

				var_252_16.z = 0
				var_252_16.x = 0
				var_252_10.localEulerAngles = var_252_16
			end

			if arg_249_1.time_ >= var_252_11 + var_252_12 and arg_249_1.time_ < var_252_11 + var_252_12 + arg_252_0 then
				var_252_10.localPosition = Vector3.New(-0.7, -1.01, -5.9)

				local var_252_17 = manager.ui.mainCamera.transform.position - var_252_10.position

				var_252_10.forward = Vector3.New(var_252_17.x, var_252_17.y, var_252_17.z)

				local var_252_18 = var_252_10.localEulerAngles

				var_252_18.z = 0
				var_252_18.x = 0
				var_252_10.localEulerAngles = var_252_18
			end

			local var_252_19 = arg_249_1.actors_["1048ui_story"].transform
			local var_252_20 = 0

			if var_252_20 < arg_249_1.time_ and arg_249_1.time_ <= var_252_20 + arg_252_0 then
				arg_249_1.var_.moveOldPos1048ui_story = var_252_19.localPosition
			end

			local var_252_21 = 0.001

			if var_252_20 <= arg_249_1.time_ and arg_249_1.time_ < var_252_20 + var_252_21 then
				local var_252_22 = (arg_249_1.time_ - var_252_20) / var_252_21
				local var_252_23 = Vector3.New(0.7, -0.8, -6.2)

				var_252_19.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1048ui_story, var_252_23, var_252_22)

				local var_252_24 = manager.ui.mainCamera.transform.position - var_252_19.position

				var_252_19.forward = Vector3.New(var_252_24.x, var_252_24.y, var_252_24.z)

				local var_252_25 = var_252_19.localEulerAngles

				var_252_25.z = 0
				var_252_25.x = 0
				var_252_19.localEulerAngles = var_252_25
			end

			if arg_249_1.time_ >= var_252_20 + var_252_21 and arg_249_1.time_ < var_252_20 + var_252_21 + arg_252_0 then
				var_252_19.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_252_26 = manager.ui.mainCamera.transform.position - var_252_19.position

				var_252_19.forward = Vector3.New(var_252_26.x, var_252_26.y, var_252_26.z)

				local var_252_27 = var_252_19.localEulerAngles

				var_252_27.z = 0
				var_252_27.x = 0
				var_252_19.localEulerAngles = var_252_27
			end

			local var_252_28 = 0

			if var_252_28 < arg_249_1.time_ and arg_249_1.time_ <= var_252_28 + arg_252_0 then
				arg_249_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			local var_252_29 = 0

			if var_252_29 < arg_249_1.time_ and arg_249_1.time_ <= var_252_29 + arg_252_0 then
				arg_249_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_252_30 = 0

			if var_252_30 < arg_249_1.time_ and arg_249_1.time_ <= var_252_30 + arg_252_0 then
				arg_249_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action1_1")
			end

			local var_252_31 = 0

			if var_252_31 < arg_249_1.time_ and arg_249_1.time_ <= var_252_31 + arg_252_0 then
				arg_249_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_252_32 = 0
			local var_252_33 = 0.6

			if var_252_32 < arg_249_1.time_ and arg_249_1.time_ <= var_252_32 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_34 = arg_249_1:FormatText(StoryNameCfg[9].name)

				arg_249_1.leftNameTxt_.text = var_252_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_35 = arg_249_1:GetWordFromCfg(116011058)
				local var_252_36 = arg_249_1:FormatText(var_252_35.content)

				arg_249_1.text_.text = var_252_36

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_37 = 24
				local var_252_38 = utf8.len(var_252_36)
				local var_252_39 = var_252_37 <= 0 and var_252_33 or var_252_33 * (var_252_38 / var_252_37)

				if var_252_39 > 0 and var_252_33 < var_252_39 then
					arg_249_1.talkMaxDuration = var_252_39

					if var_252_39 + var_252_32 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_39 + var_252_32
					end
				end

				arg_249_1.text_.text = var_252_36
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011058", "story_v_out_116011.awb") ~= 0 then
					local var_252_40 = manager.audio:GetVoiceLength("story_v_out_116011", "116011058", "story_v_out_116011.awb") / 1000

					if var_252_40 + var_252_32 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_40 + var_252_32
					end

					if var_252_35.prefab_name ~= "" and arg_249_1.actors_[var_252_35.prefab_name] ~= nil then
						local var_252_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_35.prefab_name].transform, "story_v_out_116011", "116011058", "story_v_out_116011.awb")

						arg_249_1:RecordAudio("116011058", var_252_41)
						arg_249_1:RecordAudio("116011058", var_252_41)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_116011", "116011058", "story_v_out_116011.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_116011", "116011058", "story_v_out_116011.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_42 = math.max(var_252_33, arg_249_1.talkMaxDuration)

			if var_252_32 <= arg_249_1.time_ and arg_249_1.time_ < var_252_32 + var_252_42 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_32) / var_252_42

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_32 + var_252_42 and arg_249_1.time_ < var_252_32 + var_252_42 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play116011059 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 116011059
		arg_253_1.duration_ = 7.47

		local var_253_0 = {
			zh = 7.166,
			ja = 7.466
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play116011060(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1039ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1039ui_story == nil then
				arg_253_1.var_.characterEffect1039ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.2

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1039ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1039ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1039ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1039ui_story.fillRatio = var_256_5
			end

			local var_256_6 = arg_253_1.actors_["1048ui_story"]
			local var_256_7 = 0

			if var_256_7 < arg_253_1.time_ and arg_253_1.time_ <= var_256_7 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect1048ui_story == nil then
				arg_253_1.var_.characterEffect1048ui_story = var_256_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_8 = 0.2

			if var_256_7 <= arg_253_1.time_ and arg_253_1.time_ < var_256_7 + var_256_8 and not isNil(var_256_6) then
				local var_256_9 = (arg_253_1.time_ - var_256_7) / var_256_8

				if arg_253_1.var_.characterEffect1048ui_story and not isNil(var_256_6) then
					arg_253_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_7 + var_256_8 and arg_253_1.time_ < var_256_7 + var_256_8 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect1048ui_story then
				arg_253_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 then
				arg_253_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action9_1")
			end

			local var_256_11 = 0

			if var_256_11 < arg_253_1.time_ and arg_253_1.time_ <= var_256_11 + arg_256_0 then
				arg_253_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_256_12 = 0
			local var_256_13 = 0.775

			if var_256_12 < arg_253_1.time_ and arg_253_1.time_ <= var_256_12 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_14 = arg_253_1:FormatText(StoryNameCfg[8].name)

				arg_253_1.leftNameTxt_.text = var_256_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_15 = arg_253_1:GetWordFromCfg(116011059)
				local var_256_16 = arg_253_1:FormatText(var_256_15.content)

				arg_253_1.text_.text = var_256_16

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_17 = 31
				local var_256_18 = utf8.len(var_256_16)
				local var_256_19 = var_256_17 <= 0 and var_256_13 or var_256_13 * (var_256_18 / var_256_17)

				if var_256_19 > 0 and var_256_13 < var_256_19 then
					arg_253_1.talkMaxDuration = var_256_19

					if var_256_19 + var_256_12 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_19 + var_256_12
					end
				end

				arg_253_1.text_.text = var_256_16
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011059", "story_v_out_116011.awb") ~= 0 then
					local var_256_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011059", "story_v_out_116011.awb") / 1000

					if var_256_20 + var_256_12 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_20 + var_256_12
					end

					if var_256_15.prefab_name ~= "" and arg_253_1.actors_[var_256_15.prefab_name] ~= nil then
						local var_256_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_15.prefab_name].transform, "story_v_out_116011", "116011059", "story_v_out_116011.awb")

						arg_253_1:RecordAudio("116011059", var_256_21)
						arg_253_1:RecordAudio("116011059", var_256_21)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_116011", "116011059", "story_v_out_116011.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_116011", "116011059", "story_v_out_116011.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_22 = math.max(var_256_13, arg_253_1.talkMaxDuration)

			if var_256_12 <= arg_253_1.time_ and arg_253_1.time_ < var_256_12 + var_256_22 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_12) / var_256_22

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_12 + var_256_22 and arg_253_1.time_ < var_256_12 + var_256_22 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play116011060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 116011060
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play116011061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1039ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1039ui_story = var_260_0.localPosition
			end

			local var_260_2 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2
				local var_260_4 = Vector3.New(0, 100, 0)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1039ui_story, var_260_4, var_260_3)

				local var_260_5 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_5.x, var_260_5.y, var_260_5.z)

				local var_260_6 = var_260_0.localEulerAngles

				var_260_6.z = 0
				var_260_6.x = 0
				var_260_0.localEulerAngles = var_260_6
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, 100, 0)

				local var_260_7 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_7.x, var_260_7.y, var_260_7.z)

				local var_260_8 = var_260_0.localEulerAngles

				var_260_8.z = 0
				var_260_8.x = 0
				var_260_0.localEulerAngles = var_260_8
			end

			local var_260_9 = arg_257_1.actors_["1048ui_story"].transform
			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1.var_.moveOldPos1048ui_story = var_260_9.localPosition
			end

			local var_260_11 = 0.001

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_11 then
				local var_260_12 = (arg_257_1.time_ - var_260_10) / var_260_11
				local var_260_13 = Vector3.New(0, 100, 0)

				var_260_9.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1048ui_story, var_260_13, var_260_12)

				local var_260_14 = manager.ui.mainCamera.transform.position - var_260_9.position

				var_260_9.forward = Vector3.New(var_260_14.x, var_260_14.y, var_260_14.z)

				local var_260_15 = var_260_9.localEulerAngles

				var_260_15.z = 0
				var_260_15.x = 0
				var_260_9.localEulerAngles = var_260_15
			end

			if arg_257_1.time_ >= var_260_10 + var_260_11 and arg_257_1.time_ < var_260_10 + var_260_11 + arg_260_0 then
				var_260_9.localPosition = Vector3.New(0, 100, 0)

				local var_260_16 = manager.ui.mainCamera.transform.position - var_260_9.position

				var_260_9.forward = Vector3.New(var_260_16.x, var_260_16.y, var_260_16.z)

				local var_260_17 = var_260_9.localEulerAngles

				var_260_17.z = 0
				var_260_17.x = 0
				var_260_9.localEulerAngles = var_260_17
			end

			local var_260_18 = 0
			local var_260_19 = 0.325

			if var_260_18 < arg_257_1.time_ and arg_257_1.time_ <= var_260_18 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_20 = arg_257_1:GetWordFromCfg(116011060)
				local var_260_21 = arg_257_1:FormatText(var_260_20.content)

				arg_257_1.text_.text = var_260_21

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_22 = 13
				local var_260_23 = utf8.len(var_260_21)
				local var_260_24 = var_260_22 <= 0 and var_260_19 or var_260_19 * (var_260_23 / var_260_22)

				if var_260_24 > 0 and var_260_19 < var_260_24 then
					arg_257_1.talkMaxDuration = var_260_24

					if var_260_24 + var_260_18 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_24 + var_260_18
					end
				end

				arg_257_1.text_.text = var_260_21
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_25 = math.max(var_260_19, arg_257_1.talkMaxDuration)

			if var_260_18 <= arg_257_1.time_ and arg_257_1.time_ < var_260_18 + var_260_25 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_18) / var_260_25

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_18 + var_260_25 and arg_257_1.time_ < var_260_18 + var_260_25 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play116011061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 116011061
		arg_261_1.duration_ = 6.4

		local var_261_0 = {
			zh = 4.866,
			ja = 6.4
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play116011062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1039ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1039ui_story == nil then
				arg_261_1.var_.characterEffect1039ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.2

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1039ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1039ui_story then
				arg_261_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_264_4 = 0

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_264_5 = arg_261_1.actors_["1039ui_story"].transform
			local var_264_6 = 0

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.var_.moveOldPos1039ui_story = var_264_5.localPosition
			end

			local var_264_7 = 0.001

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_7 then
				local var_264_8 = (arg_261_1.time_ - var_264_6) / var_264_7
				local var_264_9 = Vector3.New(0, -1.01, -5.9)

				var_264_5.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1039ui_story, var_264_9, var_264_8)

				local var_264_10 = manager.ui.mainCamera.transform.position - var_264_5.position

				var_264_5.forward = Vector3.New(var_264_10.x, var_264_10.y, var_264_10.z)

				local var_264_11 = var_264_5.localEulerAngles

				var_264_11.z = 0
				var_264_11.x = 0
				var_264_5.localEulerAngles = var_264_11
			end

			if arg_261_1.time_ >= var_264_6 + var_264_7 and arg_261_1.time_ < var_264_6 + var_264_7 + arg_264_0 then
				var_264_5.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_264_12 = manager.ui.mainCamera.transform.position - var_264_5.position

				var_264_5.forward = Vector3.New(var_264_12.x, var_264_12.y, var_264_12.z)

				local var_264_13 = var_264_5.localEulerAngles

				var_264_13.z = 0
				var_264_13.x = 0
				var_264_5.localEulerAngles = var_264_13
			end

			local var_264_14 = 0

			if var_264_14 < arg_261_1.time_ and arg_261_1.time_ <= var_264_14 + arg_264_0 then
				arg_261_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_264_15 = 0
			local var_264_16 = 0.55

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_17 = arg_261_1:FormatText(StoryNameCfg[9].name)

				arg_261_1.leftNameTxt_.text = var_264_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_18 = arg_261_1:GetWordFromCfg(116011061)
				local var_264_19 = arg_261_1:FormatText(var_264_18.content)

				arg_261_1.text_.text = var_264_19

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_20 = 22
				local var_264_21 = utf8.len(var_264_19)
				local var_264_22 = var_264_20 <= 0 and var_264_16 or var_264_16 * (var_264_21 / var_264_20)

				if var_264_22 > 0 and var_264_16 < var_264_22 then
					arg_261_1.talkMaxDuration = var_264_22

					if var_264_22 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_22 + var_264_15
					end
				end

				arg_261_1.text_.text = var_264_19
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011061", "story_v_out_116011.awb") ~= 0 then
					local var_264_23 = manager.audio:GetVoiceLength("story_v_out_116011", "116011061", "story_v_out_116011.awb") / 1000

					if var_264_23 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_15
					end

					if var_264_18.prefab_name ~= "" and arg_261_1.actors_[var_264_18.prefab_name] ~= nil then
						local var_264_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_18.prefab_name].transform, "story_v_out_116011", "116011061", "story_v_out_116011.awb")

						arg_261_1:RecordAudio("116011061", var_264_24)
						arg_261_1:RecordAudio("116011061", var_264_24)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_116011", "116011061", "story_v_out_116011.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_116011", "116011061", "story_v_out_116011.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_25 = math.max(var_264_16, arg_261_1.talkMaxDuration)

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_25 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_15) / var_264_25

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_15 + var_264_25 and arg_261_1.time_ < var_264_15 + var_264_25 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play116011062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 116011062
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play116011063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1039ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1039ui_story = var_268_0.localPosition
			end

			local var_268_2 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2
				local var_268_4 = Vector3.New(0, 100, 0)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1039ui_story, var_268_4, var_268_3)

				local var_268_5 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_5.x, var_268_5.y, var_268_5.z)

				local var_268_6 = var_268_0.localEulerAngles

				var_268_6.z = 0
				var_268_6.x = 0
				var_268_0.localEulerAngles = var_268_6
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, 100, 0)

				local var_268_7 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_7.x, var_268_7.y, var_268_7.z)

				local var_268_8 = var_268_0.localEulerAngles

				var_268_8.z = 0
				var_268_8.x = 0
				var_268_0.localEulerAngles = var_268_8
			end

			local var_268_9 = 0
			local var_268_10 = 1

			if var_268_9 < arg_265_1.time_ and arg_265_1.time_ <= var_268_9 + arg_268_0 then
				local var_268_11 = "play"
				local var_268_12 = "effect"

				arg_265_1:AudioAction(var_268_11, var_268_12, "se_story_16", "se_story_16_leaves", "")
			end

			local var_268_13 = 0
			local var_268_14 = 0.133333333333333

			if var_268_13 < arg_265_1.time_ and arg_265_1.time_ <= var_268_13 + arg_268_0 then
				local var_268_15 = "play"
				local var_268_16 = "music"

				arg_265_1:AudioAction(var_268_15, var_268_16, "ui_battle", "ui_battle_stopbgm", "")

				local var_268_17 = ""
				local var_268_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_268_18 ~= "" then
					if arg_265_1.bgmTxt_.text ~= var_268_18 and arg_265_1.bgmTxt_.text ~= "" then
						if arg_265_1.bgmTxt2_.text ~= "" then
							arg_265_1.bgmTxt_.text = arg_265_1.bgmTxt2_.text
						end

						arg_265_1.bgmTxt2_.text = var_268_18

						arg_265_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_265_1.bgmTxt_.text = var_268_18
						arg_265_1.bgmTxt2_.text = var_268_18
					end

					if arg_265_1.bgmTimer then
						arg_265_1.bgmTimer:Stop()

						arg_265_1.bgmTimer = nil
					end

					if arg_265_1.settingData.show_music_name == 1 then
						arg_265_1.musicController:SetSelectedState("show")
						arg_265_1.musicAnimator_:Play("open", 0, 0)

						if arg_265_1.settingData.music_time ~= 0 then
							arg_265_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_265_1.settingData.music_time), function()
								if arg_265_1 == nil or isNil(arg_265_1.bgmTxt_) then
									return
								end

								arg_265_1.musicController:SetSelectedState("hide")
								arg_265_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_268_19 = 0.2
			local var_268_20 = 0.8

			if var_268_19 < arg_265_1.time_ and arg_265_1.time_ <= var_268_19 + arg_268_0 then
				local var_268_21 = "play"
				local var_268_22 = "music"

				arg_265_1:AudioAction(var_268_21, var_268_22, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_268_23 = ""
				local var_268_24 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if var_268_24 ~= "" then
					if arg_265_1.bgmTxt_.text ~= var_268_24 and arg_265_1.bgmTxt_.text ~= "" then
						if arg_265_1.bgmTxt2_.text ~= "" then
							arg_265_1.bgmTxt_.text = arg_265_1.bgmTxt2_.text
						end

						arg_265_1.bgmTxt2_.text = var_268_24

						arg_265_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_265_1.bgmTxt_.text = var_268_24
						arg_265_1.bgmTxt2_.text = var_268_24
					end

					if arg_265_1.bgmTimer then
						arg_265_1.bgmTimer:Stop()

						arg_265_1.bgmTimer = nil
					end

					if arg_265_1.settingData.show_music_name == 1 then
						arg_265_1.musicController:SetSelectedState("show")
						arg_265_1.musicAnimator_:Play("open", 0, 0)

						if arg_265_1.settingData.music_time ~= 0 then
							arg_265_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_265_1.settingData.music_time), function()
								if arg_265_1 == nil or isNil(arg_265_1.bgmTxt_) then
									return
								end

								arg_265_1.musicController:SetSelectedState("hide")
								arg_265_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_268_25 = 0
			local var_268_26 = 0.75

			if var_268_25 < arg_265_1.time_ and arg_265_1.time_ <= var_268_25 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_27 = arg_265_1:GetWordFromCfg(116011062)
				local var_268_28 = arg_265_1:FormatText(var_268_27.content)

				arg_265_1.text_.text = var_268_28

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_29 = 30
				local var_268_30 = utf8.len(var_268_28)
				local var_268_31 = var_268_29 <= 0 and var_268_26 or var_268_26 * (var_268_30 / var_268_29)

				if var_268_31 > 0 and var_268_26 < var_268_31 then
					arg_265_1.talkMaxDuration = var_268_31

					if var_268_31 + var_268_25 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_31 + var_268_25
					end
				end

				arg_265_1.text_.text = var_268_28
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_32 = math.max(var_268_26, arg_265_1.talkMaxDuration)

			if var_268_25 <= arg_265_1.time_ and arg_265_1.time_ < var_268_25 + var_268_32 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_25) / var_268_32

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_25 + var_268_32 and arg_265_1.time_ < var_268_25 + var_268_32 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play116011063 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 116011063
		arg_271_1.duration_ = 2

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play116011064(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_274_1 = arg_271_1.actors_["1039ui_story"].transform
			local var_274_2 = 0

			if var_274_2 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				arg_271_1.var_.moveOldPos1039ui_story = var_274_1.localPosition
			end

			local var_274_3 = 0.001

			if var_274_2 <= arg_271_1.time_ and arg_271_1.time_ < var_274_2 + var_274_3 then
				local var_274_4 = (arg_271_1.time_ - var_274_2) / var_274_3
				local var_274_5 = Vector3.New(-0.7, -1.01, -5.9)

				var_274_1.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1039ui_story, var_274_5, var_274_4)

				local var_274_6 = manager.ui.mainCamera.transform.position - var_274_1.position

				var_274_1.forward = Vector3.New(var_274_6.x, var_274_6.y, var_274_6.z)

				local var_274_7 = var_274_1.localEulerAngles

				var_274_7.z = 0
				var_274_7.x = 0
				var_274_1.localEulerAngles = var_274_7
			end

			if arg_271_1.time_ >= var_274_2 + var_274_3 and arg_271_1.time_ < var_274_2 + var_274_3 + arg_274_0 then
				var_274_1.localPosition = Vector3.New(-0.7, -1.01, -5.9)

				local var_274_8 = manager.ui.mainCamera.transform.position - var_274_1.position

				var_274_1.forward = Vector3.New(var_274_8.x, var_274_8.y, var_274_8.z)

				local var_274_9 = var_274_1.localEulerAngles

				var_274_9.z = 0
				var_274_9.x = 0
				var_274_1.localEulerAngles = var_274_9
			end

			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 then
				arg_271_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			local var_274_11 = arg_271_1.actors_["1039ui_story"]
			local var_274_12 = 0

			if var_274_12 < arg_271_1.time_ and arg_271_1.time_ <= var_274_12 + arg_274_0 and not isNil(var_274_11) and arg_271_1.var_.characterEffect1039ui_story == nil then
				arg_271_1.var_.characterEffect1039ui_story = var_274_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_13 = 0.2

			if var_274_12 <= arg_271_1.time_ and arg_271_1.time_ < var_274_12 + var_274_13 and not isNil(var_274_11) then
				local var_274_14 = (arg_271_1.time_ - var_274_12) / var_274_13

				if arg_271_1.var_.characterEffect1039ui_story and not isNil(var_274_11) then
					arg_271_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_12 + var_274_13 and arg_271_1.time_ < var_274_12 + var_274_13 + arg_274_0 and not isNil(var_274_11) and arg_271_1.var_.characterEffect1039ui_story then
				arg_271_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_274_15 = 0
			local var_274_16 = 0.1

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_17 = arg_271_1:FormatText(StoryNameCfg[9].name)

				arg_271_1.leftNameTxt_.text = var_274_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_18 = arg_271_1:GetWordFromCfg(116011063)
				local var_274_19 = arg_271_1:FormatText(var_274_18.content)

				arg_271_1.text_.text = var_274_19

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_20 = 4
				local var_274_21 = utf8.len(var_274_19)
				local var_274_22 = var_274_20 <= 0 and var_274_16 or var_274_16 * (var_274_21 / var_274_20)

				if var_274_22 > 0 and var_274_16 < var_274_22 then
					arg_271_1.talkMaxDuration = var_274_22

					if var_274_22 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_22 + var_274_15
					end
				end

				arg_271_1.text_.text = var_274_19
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011063", "story_v_out_116011.awb") ~= 0 then
					local var_274_23 = manager.audio:GetVoiceLength("story_v_out_116011", "116011063", "story_v_out_116011.awb") / 1000

					if var_274_23 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_15
					end

					if var_274_18.prefab_name ~= "" and arg_271_1.actors_[var_274_18.prefab_name] ~= nil then
						local var_274_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_18.prefab_name].transform, "story_v_out_116011", "116011063", "story_v_out_116011.awb")

						arg_271_1:RecordAudio("116011063", var_274_24)
						arg_271_1:RecordAudio("116011063", var_274_24)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_116011", "116011063", "story_v_out_116011.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_116011", "116011063", "story_v_out_116011.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_25 = math.max(var_274_16, arg_271_1.talkMaxDuration)

			if var_274_15 <= arg_271_1.time_ and arg_271_1.time_ < var_274_15 + var_274_25 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_15) / var_274_25

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_15 + var_274_25 and arg_271_1.time_ < var_274_15 + var_274_25 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play116011064 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 116011064
		arg_275_1.duration_ = 2

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play116011065(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1048ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1048ui_story == nil then
				arg_275_1.var_.characterEffect1048ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect1048ui_story and not isNil(var_278_0) then
					arg_275_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1048ui_story then
				arg_275_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_278_4 = arg_275_1.actors_["1039ui_story"]
			local var_278_5 = 0

			if var_278_5 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect1039ui_story == nil then
				arg_275_1.var_.characterEffect1039ui_story = var_278_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_6 = 0.2

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_6 and not isNil(var_278_4) then
				local var_278_7 = (arg_275_1.time_ - var_278_5) / var_278_6

				if arg_275_1.var_.characterEffect1039ui_story and not isNil(var_278_4) then
					local var_278_8 = Mathf.Lerp(0, 0.5, var_278_7)

					arg_275_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1039ui_story.fillRatio = var_278_8
				end
			end

			if arg_275_1.time_ >= var_278_5 + var_278_6 and arg_275_1.time_ < var_278_5 + var_278_6 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect1039ui_story then
				local var_278_9 = 0.5

				arg_275_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1039ui_story.fillRatio = var_278_9
			end

			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 then
				arg_275_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_278_11 = arg_275_1.actors_["1048ui_story"].transform
			local var_278_12 = 0

			if var_278_12 < arg_275_1.time_ and arg_275_1.time_ <= var_278_12 + arg_278_0 then
				arg_275_1.var_.moveOldPos1048ui_story = var_278_11.localPosition
			end

			local var_278_13 = 0.001

			if var_278_12 <= arg_275_1.time_ and arg_275_1.time_ < var_278_12 + var_278_13 then
				local var_278_14 = (arg_275_1.time_ - var_278_12) / var_278_13
				local var_278_15 = Vector3.New(0.7, -0.8, -6.2)

				var_278_11.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1048ui_story, var_278_15, var_278_14)

				local var_278_16 = manager.ui.mainCamera.transform.position - var_278_11.position

				var_278_11.forward = Vector3.New(var_278_16.x, var_278_16.y, var_278_16.z)

				local var_278_17 = var_278_11.localEulerAngles

				var_278_17.z = 0
				var_278_17.x = 0
				var_278_11.localEulerAngles = var_278_17
			end

			if arg_275_1.time_ >= var_278_12 + var_278_13 and arg_275_1.time_ < var_278_12 + var_278_13 + arg_278_0 then
				var_278_11.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_278_18 = manager.ui.mainCamera.transform.position - var_278_11.position

				var_278_11.forward = Vector3.New(var_278_18.x, var_278_18.y, var_278_18.z)

				local var_278_19 = var_278_11.localEulerAngles

				var_278_19.z = 0
				var_278_19.x = 0
				var_278_11.localEulerAngles = var_278_19
			end

			local var_278_20 = 0

			if var_278_20 < arg_275_1.time_ and arg_275_1.time_ <= var_278_20 + arg_278_0 then
				arg_275_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action1_1")
			end

			local var_278_21 = 0
			local var_278_22 = 0.1

			if var_278_21 < arg_275_1.time_ and arg_275_1.time_ <= var_278_21 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_23 = arg_275_1:FormatText(StoryNameCfg[8].name)

				arg_275_1.leftNameTxt_.text = var_278_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_24 = arg_275_1:GetWordFromCfg(116011064)
				local var_278_25 = arg_275_1:FormatText(var_278_24.content)

				arg_275_1.text_.text = var_278_25

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_26 = 4
				local var_278_27 = utf8.len(var_278_25)
				local var_278_28 = var_278_26 <= 0 and var_278_22 or var_278_22 * (var_278_27 / var_278_26)

				if var_278_28 > 0 and var_278_22 < var_278_28 then
					arg_275_1.talkMaxDuration = var_278_28

					if var_278_28 + var_278_21 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_28 + var_278_21
					end
				end

				arg_275_1.text_.text = var_278_25
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011064", "story_v_out_116011.awb") ~= 0 then
					local var_278_29 = manager.audio:GetVoiceLength("story_v_out_116011", "116011064", "story_v_out_116011.awb") / 1000

					if var_278_29 + var_278_21 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_29 + var_278_21
					end

					if var_278_24.prefab_name ~= "" and arg_275_1.actors_[var_278_24.prefab_name] ~= nil then
						local var_278_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_24.prefab_name].transform, "story_v_out_116011", "116011064", "story_v_out_116011.awb")

						arg_275_1:RecordAudio("116011064", var_278_30)
						arg_275_1:RecordAudio("116011064", var_278_30)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_116011", "116011064", "story_v_out_116011.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_116011", "116011064", "story_v_out_116011.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_31 = math.max(var_278_22, arg_275_1.talkMaxDuration)

			if var_278_21 <= arg_275_1.time_ and arg_275_1.time_ < var_278_21 + var_278_31 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_21) / var_278_31

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_21 + var_278_31 and arg_275_1.time_ < var_278_21 + var_278_31 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play116011065 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 116011065
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play116011066(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1039ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1039ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, 100, 0)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1039ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, 100, 0)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["1048ui_story"].transform
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 then
				arg_279_1.var_.moveOldPos1048ui_story = var_282_9.localPosition
			end

			local var_282_11 = 0.001

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11
				local var_282_13 = Vector3.New(0, 100, 0)

				var_282_9.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1048ui_story, var_282_13, var_282_12)

				local var_282_14 = manager.ui.mainCamera.transform.position - var_282_9.position

				var_282_9.forward = Vector3.New(var_282_14.x, var_282_14.y, var_282_14.z)

				local var_282_15 = var_282_9.localEulerAngles

				var_282_15.z = 0
				var_282_15.x = 0
				var_282_9.localEulerAngles = var_282_15
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 then
				var_282_9.localPosition = Vector3.New(0, 100, 0)

				local var_282_16 = manager.ui.mainCamera.transform.position - var_282_9.position

				var_282_9.forward = Vector3.New(var_282_16.x, var_282_16.y, var_282_16.z)

				local var_282_17 = var_282_9.localEulerAngles

				var_282_17.z = 0
				var_282_17.x = 0
				var_282_9.localEulerAngles = var_282_17
			end

			local var_282_18 = 0
			local var_282_19 = 1.625

			if var_282_18 < arg_279_1.time_ and arg_279_1.time_ <= var_282_18 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_20 = arg_279_1:GetWordFromCfg(116011065)
				local var_282_21 = arg_279_1:FormatText(var_282_20.content)

				arg_279_1.text_.text = var_282_21

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_22 = 65
				local var_282_23 = utf8.len(var_282_21)
				local var_282_24 = var_282_22 <= 0 and var_282_19 or var_282_19 * (var_282_23 / var_282_22)

				if var_282_24 > 0 and var_282_19 < var_282_24 then
					arg_279_1.talkMaxDuration = var_282_24

					if var_282_24 + var_282_18 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_24 + var_282_18
					end
				end

				arg_279_1.text_.text = var_282_21
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_25 = math.max(var_282_19, arg_279_1.talkMaxDuration)

			if var_282_18 <= arg_279_1.time_ and arg_279_1.time_ < var_282_18 + var_282_25 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_18) / var_282_25

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_18 + var_282_25 and arg_279_1.time_ < var_282_18 + var_282_25 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play116011066 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 116011066
		arg_283_1.duration_ = 5.5

		local var_283_0 = {
			zh = 4.733,
			ja = 5.5
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play116011067(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1039ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1039ui_story == nil then
				arg_283_1.var_.characterEffect1039ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect1039ui_story and not isNil(var_286_0) then
					arg_283_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1039ui_story then
				arg_283_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_286_4 = arg_283_1.actors_["1048ui_story"]
			local var_286_5 = 0

			if var_286_5 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect1048ui_story == nil then
				arg_283_1.var_.characterEffect1048ui_story = var_286_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_6 = 0.2

			if var_286_5 <= arg_283_1.time_ and arg_283_1.time_ < var_286_5 + var_286_6 and not isNil(var_286_4) then
				local var_286_7 = (arg_283_1.time_ - var_286_5) / var_286_6

				if arg_283_1.var_.characterEffect1048ui_story and not isNil(var_286_4) then
					local var_286_8 = Mathf.Lerp(0, 0.5, var_286_7)

					arg_283_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1048ui_story.fillRatio = var_286_8
				end
			end

			if arg_283_1.time_ >= var_286_5 + var_286_6 and arg_283_1.time_ < var_286_5 + var_286_6 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect1048ui_story then
				local var_286_9 = 0.5

				arg_283_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1048ui_story.fillRatio = var_286_9
			end

			local var_286_10 = 0

			if var_286_10 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 then
				arg_283_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_286_11 = arg_283_1.actors_["1048ui_story"].transform
			local var_286_12 = 0

			if var_286_12 < arg_283_1.time_ and arg_283_1.time_ <= var_286_12 + arg_286_0 then
				arg_283_1.var_.moveOldPos1048ui_story = var_286_11.localPosition
			end

			local var_286_13 = 0.001

			if var_286_12 <= arg_283_1.time_ and arg_283_1.time_ < var_286_12 + var_286_13 then
				local var_286_14 = (arg_283_1.time_ - var_286_12) / var_286_13
				local var_286_15 = Vector3.New(0.7, -0.8, -6.2)

				var_286_11.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1048ui_story, var_286_15, var_286_14)

				local var_286_16 = manager.ui.mainCamera.transform.position - var_286_11.position

				var_286_11.forward = Vector3.New(var_286_16.x, var_286_16.y, var_286_16.z)

				local var_286_17 = var_286_11.localEulerAngles

				var_286_17.z = 0
				var_286_17.x = 0
				var_286_11.localEulerAngles = var_286_17
			end

			if arg_283_1.time_ >= var_286_12 + var_286_13 and arg_283_1.time_ < var_286_12 + var_286_13 + arg_286_0 then
				var_286_11.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_286_18 = manager.ui.mainCamera.transform.position - var_286_11.position

				var_286_11.forward = Vector3.New(var_286_18.x, var_286_18.y, var_286_18.z)

				local var_286_19 = var_286_11.localEulerAngles

				var_286_19.z = 0
				var_286_19.x = 0
				var_286_11.localEulerAngles = var_286_19
			end

			local var_286_20 = arg_283_1.actors_["1039ui_story"].transform
			local var_286_21 = 0

			if var_286_21 < arg_283_1.time_ and arg_283_1.time_ <= var_286_21 + arg_286_0 then
				arg_283_1.var_.moveOldPos1039ui_story = var_286_20.localPosition
			end

			local var_286_22 = 0.001

			if var_286_21 <= arg_283_1.time_ and arg_283_1.time_ < var_286_21 + var_286_22 then
				local var_286_23 = (arg_283_1.time_ - var_286_21) / var_286_22
				local var_286_24 = Vector3.New(-0.7, -1.01, -5.9)

				var_286_20.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1039ui_story, var_286_24, var_286_23)

				local var_286_25 = manager.ui.mainCamera.transform.position - var_286_20.position

				var_286_20.forward = Vector3.New(var_286_25.x, var_286_25.y, var_286_25.z)

				local var_286_26 = var_286_20.localEulerAngles

				var_286_26.z = 0
				var_286_26.x = 0
				var_286_20.localEulerAngles = var_286_26
			end

			if arg_283_1.time_ >= var_286_21 + var_286_22 and arg_283_1.time_ < var_286_21 + var_286_22 + arg_286_0 then
				var_286_20.localPosition = Vector3.New(-0.7, -1.01, -5.9)

				local var_286_27 = manager.ui.mainCamera.transform.position - var_286_20.position

				var_286_20.forward = Vector3.New(var_286_27.x, var_286_27.y, var_286_27.z)

				local var_286_28 = var_286_20.localEulerAngles

				var_286_28.z = 0
				var_286_28.x = 0
				var_286_20.localEulerAngles = var_286_28
			end

			local var_286_29 = 0

			if var_286_29 < arg_283_1.time_ and arg_283_1.time_ <= var_286_29 + arg_286_0 then
				arg_283_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_286_30 = 0
			local var_286_31 = 0.5

			if var_286_30 < arg_283_1.time_ and arg_283_1.time_ <= var_286_30 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_32 = arg_283_1:FormatText(StoryNameCfg[9].name)

				arg_283_1.leftNameTxt_.text = var_286_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_33 = arg_283_1:GetWordFromCfg(116011066)
				local var_286_34 = arg_283_1:FormatText(var_286_33.content)

				arg_283_1.text_.text = var_286_34

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_35 = 20
				local var_286_36 = utf8.len(var_286_34)
				local var_286_37 = var_286_35 <= 0 and var_286_31 or var_286_31 * (var_286_36 / var_286_35)

				if var_286_37 > 0 and var_286_31 < var_286_37 then
					arg_283_1.talkMaxDuration = var_286_37

					if var_286_37 + var_286_30 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_37 + var_286_30
					end
				end

				arg_283_1.text_.text = var_286_34
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011066", "story_v_out_116011.awb") ~= 0 then
					local var_286_38 = manager.audio:GetVoiceLength("story_v_out_116011", "116011066", "story_v_out_116011.awb") / 1000

					if var_286_38 + var_286_30 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_38 + var_286_30
					end

					if var_286_33.prefab_name ~= "" and arg_283_1.actors_[var_286_33.prefab_name] ~= nil then
						local var_286_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_33.prefab_name].transform, "story_v_out_116011", "116011066", "story_v_out_116011.awb")

						arg_283_1:RecordAudio("116011066", var_286_39)
						arg_283_1:RecordAudio("116011066", var_286_39)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_116011", "116011066", "story_v_out_116011.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_116011", "116011066", "story_v_out_116011.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_40 = math.max(var_286_31, arg_283_1.talkMaxDuration)

			if var_286_30 <= arg_283_1.time_ and arg_283_1.time_ < var_286_30 + var_286_40 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_30) / var_286_40

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_30 + var_286_40 and arg_283_1.time_ < var_286_30 + var_286_40 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
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

		arg_283_1:InitPlayNodeList()
	end,
	Play116011067 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 116011067
		arg_287_1.duration_ = 6

		local var_287_0 = {
			zh = 2.5,
			ja = 6
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play116011068(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1048ui_story"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1048ui_story == nil then
				arg_287_1.var_.characterEffect1048ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.characterEffect1048ui_story and not isNil(var_290_0) then
					arg_287_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1048ui_story then
				arg_287_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_290_4 = arg_287_1.actors_["1039ui_story"]
			local var_290_5 = 0

			if var_290_5 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 and not isNil(var_290_4) and arg_287_1.var_.characterEffect1039ui_story == nil then
				arg_287_1.var_.characterEffect1039ui_story = var_290_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_6 = 0.2

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_6 and not isNil(var_290_4) then
				local var_290_7 = (arg_287_1.time_ - var_290_5) / var_290_6

				if arg_287_1.var_.characterEffect1039ui_story and not isNil(var_290_4) then
					local var_290_8 = Mathf.Lerp(0, 0.5, var_290_7)

					arg_287_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1039ui_story.fillRatio = var_290_8
				end
			end

			if arg_287_1.time_ >= var_290_5 + var_290_6 and arg_287_1.time_ < var_290_5 + var_290_6 + arg_290_0 and not isNil(var_290_4) and arg_287_1.var_.characterEffect1039ui_story then
				local var_290_9 = 0.5

				arg_287_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1039ui_story.fillRatio = var_290_9
			end

			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 then
				arg_287_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action4_1")
			end

			local var_290_11 = 0

			if var_290_11 < arg_287_1.time_ and arg_287_1.time_ <= var_290_11 + arg_290_0 then
				arg_287_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_290_12 = 0
			local var_290_13 = 0.3

			if var_290_12 < arg_287_1.time_ and arg_287_1.time_ <= var_290_12 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_14 = arg_287_1:FormatText(StoryNameCfg[8].name)

				arg_287_1.leftNameTxt_.text = var_290_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_15 = arg_287_1:GetWordFromCfg(116011067)
				local var_290_16 = arg_287_1:FormatText(var_290_15.content)

				arg_287_1.text_.text = var_290_16

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_17 = 12
				local var_290_18 = utf8.len(var_290_16)
				local var_290_19 = var_290_17 <= 0 and var_290_13 or var_290_13 * (var_290_18 / var_290_17)

				if var_290_19 > 0 and var_290_13 < var_290_19 then
					arg_287_1.talkMaxDuration = var_290_19

					if var_290_19 + var_290_12 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_19 + var_290_12
					end
				end

				arg_287_1.text_.text = var_290_16
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011067", "story_v_out_116011.awb") ~= 0 then
					local var_290_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011067", "story_v_out_116011.awb") / 1000

					if var_290_20 + var_290_12 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_20 + var_290_12
					end

					if var_290_15.prefab_name ~= "" and arg_287_1.actors_[var_290_15.prefab_name] ~= nil then
						local var_290_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_15.prefab_name].transform, "story_v_out_116011", "116011067", "story_v_out_116011.awb")

						arg_287_1:RecordAudio("116011067", var_290_21)
						arg_287_1:RecordAudio("116011067", var_290_21)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_116011", "116011067", "story_v_out_116011.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_116011", "116011067", "story_v_out_116011.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_22 = math.max(var_290_13, arg_287_1.talkMaxDuration)

			if var_290_12 <= arg_287_1.time_ and arg_287_1.time_ < var_290_12 + var_290_22 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_12) / var_290_22

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_12 + var_290_22 and arg_287_1.time_ < var_290_12 + var_290_22 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play116011068 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 116011068
		arg_291_1.duration_ = 7

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play116011069(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1039ui_story"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos1039ui_story = var_294_0.localPosition
			end

			local var_294_2 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2
				local var_294_4 = Vector3.New(0, 100, 0)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1039ui_story, var_294_4, var_294_3)

				local var_294_5 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_5.x, var_294_5.y, var_294_5.z)

				local var_294_6 = var_294_0.localEulerAngles

				var_294_6.z = 0
				var_294_6.x = 0
				var_294_0.localEulerAngles = var_294_6
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0, 100, 0)

				local var_294_7 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_7.x, var_294_7.y, var_294_7.z)

				local var_294_8 = var_294_0.localEulerAngles

				var_294_8.z = 0
				var_294_8.x = 0
				var_294_0.localEulerAngles = var_294_8
			end

			local var_294_9 = arg_291_1.actors_["1048ui_story"].transform
			local var_294_10 = 0

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 then
				arg_291_1.var_.moveOldPos1048ui_story = var_294_9.localPosition
			end

			local var_294_11 = 0.001

			if var_294_10 <= arg_291_1.time_ and arg_291_1.time_ < var_294_10 + var_294_11 then
				local var_294_12 = (arg_291_1.time_ - var_294_10) / var_294_11
				local var_294_13 = Vector3.New(0, 100, 0)

				var_294_9.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1048ui_story, var_294_13, var_294_12)

				local var_294_14 = manager.ui.mainCamera.transform.position - var_294_9.position

				var_294_9.forward = Vector3.New(var_294_14.x, var_294_14.y, var_294_14.z)

				local var_294_15 = var_294_9.localEulerAngles

				var_294_15.z = 0
				var_294_15.x = 0
				var_294_9.localEulerAngles = var_294_15
			end

			if arg_291_1.time_ >= var_294_10 + var_294_11 and arg_291_1.time_ < var_294_10 + var_294_11 + arg_294_0 then
				var_294_9.localPosition = Vector3.New(0, 100, 0)

				local var_294_16 = manager.ui.mainCamera.transform.position - var_294_9.position

				var_294_9.forward = Vector3.New(var_294_16.x, var_294_16.y, var_294_16.z)

				local var_294_17 = var_294_9.localEulerAngles

				var_294_17.z = 0
				var_294_17.x = 0
				var_294_9.localEulerAngles = var_294_17
			end

			local var_294_18 = manager.ui.mainCamera.transform
			local var_294_19 = 1

			if var_294_19 < arg_291_1.time_ and arg_291_1.time_ <= var_294_19 + arg_294_0 then
				arg_291_1.var_.shakeOldPos = var_294_18.localPosition
			end

			local var_294_20 = 1

			if var_294_19 <= arg_291_1.time_ and arg_291_1.time_ < var_294_19 + var_294_20 then
				local var_294_21 = (arg_291_1.time_ - var_294_19) / 0.066
				local var_294_22, var_294_23 = math.modf(var_294_21)

				var_294_18.localPosition = Vector3.New(var_294_23 * 0.13, var_294_23 * 0.13, var_294_23 * 0.13) + arg_291_1.var_.shakeOldPos
			end

			if arg_291_1.time_ >= var_294_19 + var_294_20 and arg_291_1.time_ < var_294_19 + var_294_20 + arg_294_0 then
				var_294_18.localPosition = arg_291_1.var_.shakeOldPos
			end

			local var_294_24 = 1

			if var_294_24 < arg_291_1.time_ and arg_291_1.time_ <= var_294_24 + arg_294_0 then
				arg_291_1.allBtn_.enabled = false
			end

			local var_294_25 = 1

			if arg_291_1.time_ >= var_294_24 + var_294_25 and arg_291_1.time_ < var_294_24 + var_294_25 + arg_294_0 then
				arg_291_1.allBtn_.enabled = true
			end

			local var_294_26 = 1
			local var_294_27 = 1

			if var_294_26 < arg_291_1.time_ and arg_291_1.time_ <= var_294_26 + arg_294_0 then
				local var_294_28 = "play"
				local var_294_29 = "effect"

				arg_291_1:AudioAction(var_294_28, var_294_29, "se_story_16", "se_story_16_loud", "")
			end

			local var_294_30 = 0.5

			if var_294_30 < arg_291_1.time_ and arg_291_1.time_ <= var_294_30 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_31 = 1

			if var_294_30 <= arg_291_1.time_ and arg_291_1.time_ < var_294_30 + var_294_31 then
				local var_294_32 = (arg_291_1.time_ - var_294_30) / var_294_31
				local var_294_33 = Color.New(1, 1, 1)

				var_294_33.a = Mathf.Lerp(1, 0, var_294_32)
				arg_291_1.mask_.color = var_294_33
			end

			if arg_291_1.time_ >= var_294_30 + var_294_31 and arg_291_1.time_ < var_294_30 + var_294_31 + arg_294_0 then
				local var_294_34 = Color.New(1, 1, 1)
				local var_294_35 = 0

				arg_291_1.mask_.enabled = false
				var_294_34.a = var_294_35
				arg_291_1.mask_.color = var_294_34
			end

			if arg_291_1.frameCnt_ <= 1 then
				arg_291_1.dialog_:SetActive(false)
			end

			local var_294_36 = 2
			local var_294_37 = 0.575

			if var_294_36 < arg_291_1.time_ and arg_291_1.time_ <= var_294_36 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				arg_291_1.dialog_:SetActive(true)

				arg_291_1.dialogCg_.alpha = 0

				local var_294_38 = LeanTween.value(arg_291_1.dialog_, 0, 1, 0.3)

				var_294_38:setOnUpdate(LuaHelper.FloatAction(function(arg_295_0)
					arg_291_1.dialogCg_.alpha = arg_295_0
				end))
				var_294_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_291_1.dialog_)
					var_294_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_291_1.duration_ = arg_291_1.duration_ + 0.3

				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_39 = arg_291_1:GetWordFromCfg(116011068)
				local var_294_40 = arg_291_1:FormatText(var_294_39.content)

				arg_291_1.text_.text = var_294_40

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_41 = 23
				local var_294_42 = utf8.len(var_294_40)
				local var_294_43 = var_294_41 <= 0 and var_294_37 or var_294_37 * (var_294_42 / var_294_41)

				if var_294_43 > 0 and var_294_37 < var_294_43 then
					arg_291_1.talkMaxDuration = var_294_43
					var_294_36 = var_294_36 + 0.3

					if var_294_43 + var_294_36 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_43 + var_294_36
					end
				end

				arg_291_1.text_.text = var_294_40
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_44 = var_294_36 + 0.3
			local var_294_45 = math.max(var_294_37, arg_291_1.talkMaxDuration)

			if var_294_44 <= arg_291_1.time_ and arg_291_1.time_ < var_294_44 + var_294_45 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_44) / var_294_45

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_44 + var_294_45 and arg_291_1.time_ < var_294_44 + var_294_45 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play116011069 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 116011069
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play116011070(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.95

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

				local var_300_2 = arg_297_1:GetWordFromCfg(116011069)
				local var_300_3 = arg_297_1:FormatText(var_300_2.content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 38
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
	Play116011070 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 116011070
		arg_301_1.duration_ = 1.53

		local var_301_0 = {
			zh = 1.533,
			ja = 1.5
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play116011071(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.175

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				local var_304_2 = "play"
				local var_304_3 = "music"

				arg_301_1:AudioAction(var_304_2, var_304_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_304_4 = ""
				local var_304_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_304_5 ~= "" then
					if arg_301_1.bgmTxt_.text ~= var_304_5 and arg_301_1.bgmTxt_.text ~= "" then
						if arg_301_1.bgmTxt2_.text ~= "" then
							arg_301_1.bgmTxt_.text = arg_301_1.bgmTxt2_.text
						end

						arg_301_1.bgmTxt2_.text = var_304_5

						arg_301_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_301_1.bgmTxt_.text = var_304_5
						arg_301_1.bgmTxt2_.text = var_304_5
					end

					if arg_301_1.bgmTimer then
						arg_301_1.bgmTimer:Stop()

						arg_301_1.bgmTimer = nil
					end

					if arg_301_1.settingData.show_music_name == 1 then
						arg_301_1.musicController:SetSelectedState("show")
						arg_301_1.musicAnimator_:Play("open", 0, 0)

						if arg_301_1.settingData.music_time ~= 0 then
							arg_301_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_301_1.settingData.music_time), function()
								if arg_301_1 == nil or isNil(arg_301_1.bgmTxt_) then
									return
								end

								arg_301_1.musicController:SetSelectedState("hide")
								arg_301_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_304_6 = 0.266666666666667
			local var_304_7 = 0.733333333333333

			if var_304_6 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				local var_304_8 = "play"
				local var_304_9 = "music"

				arg_301_1:AudioAction(var_304_8, var_304_9, "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_304_10 = ""
				local var_304_11 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

				if var_304_11 ~= "" then
					if arg_301_1.bgmTxt_.text ~= var_304_11 and arg_301_1.bgmTxt_.text ~= "" then
						if arg_301_1.bgmTxt2_.text ~= "" then
							arg_301_1.bgmTxt_.text = arg_301_1.bgmTxt2_.text
						end

						arg_301_1.bgmTxt2_.text = var_304_11

						arg_301_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_301_1.bgmTxt_.text = var_304_11
						arg_301_1.bgmTxt2_.text = var_304_11
					end

					if arg_301_1.bgmTimer then
						arg_301_1.bgmTimer:Stop()

						arg_301_1.bgmTimer = nil
					end

					if arg_301_1.settingData.show_music_name == 1 then
						arg_301_1.musicController:SetSelectedState("show")
						arg_301_1.musicAnimator_:Play("open", 0, 0)

						if arg_301_1.settingData.music_time ~= 0 then
							arg_301_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_301_1.settingData.music_time), function()
								if arg_301_1 == nil or isNil(arg_301_1.bgmTxt_) then
									return
								end

								arg_301_1.musicController:SetSelectedState("hide")
								arg_301_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_304_12 = 0
			local var_304_13 = 0.175

			if var_304_12 < arg_301_1.time_ and arg_301_1.time_ <= var_304_12 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_14 = arg_301_1:FormatText(StoryNameCfg[9].name)

				arg_301_1.leftNameTxt_.text = var_304_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_15 = arg_301_1:GetWordFromCfg(116011070)
				local var_304_16 = arg_301_1:FormatText(var_304_15.content)

				arg_301_1.text_.text = var_304_16

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_17 = 7
				local var_304_18 = utf8.len(var_304_16)
				local var_304_19 = var_304_17 <= 0 and var_304_13 or var_304_13 * (var_304_18 / var_304_17)

				if var_304_19 > 0 and var_304_13 < var_304_19 then
					arg_301_1.talkMaxDuration = var_304_19

					if var_304_19 + var_304_12 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_19 + var_304_12
					end
				end

				arg_301_1.text_.text = var_304_16
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011070", "story_v_out_116011.awb") ~= 0 then
					local var_304_20 = manager.audio:GetVoiceLength("story_v_out_116011", "116011070", "story_v_out_116011.awb") / 1000

					if var_304_20 + var_304_12 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_20 + var_304_12
					end

					if var_304_15.prefab_name ~= "" and arg_301_1.actors_[var_304_15.prefab_name] ~= nil then
						local var_304_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_15.prefab_name].transform, "story_v_out_116011", "116011070", "story_v_out_116011.awb")

						arg_301_1:RecordAudio("116011070", var_304_21)
						arg_301_1:RecordAudio("116011070", var_304_21)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_116011", "116011070", "story_v_out_116011.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_116011", "116011070", "story_v_out_116011.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_22 = math.max(var_304_13, arg_301_1.talkMaxDuration)

			if var_304_12 <= arg_301_1.time_ and arg_301_1.time_ < var_304_12 + var_304_22 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_12) / var_304_22

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_12 + var_304_22 and arg_301_1.time_ < var_304_12 + var_304_22 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play116011071 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 116011071
		arg_307_1.duration_ = 1.2

		local var_307_0 = {
			zh = 1.033,
			ja = 1.2
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play116011072(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 0.05

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_2 = arg_307_1:FormatText(StoryNameCfg[8].name)

				arg_307_1.leftNameTxt_.text = var_310_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:GetWordFromCfg(116011071)
				local var_310_4 = arg_307_1:FormatText(var_310_3.content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 2
				local var_310_6 = utf8.len(var_310_4)
				local var_310_7 = var_310_5 <= 0 and var_310_1 or var_310_1 * (var_310_6 / var_310_5)

				if var_310_7 > 0 and var_310_1 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011071", "story_v_out_116011.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_out_116011", "116011071", "story_v_out_116011.awb") / 1000

					if var_310_8 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_0
					end

					if var_310_3.prefab_name ~= "" and arg_307_1.actors_[var_310_3.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_3.prefab_name].transform, "story_v_out_116011", "116011071", "story_v_out_116011.awb")

						arg_307_1:RecordAudio("116011071", var_310_9)
						arg_307_1:RecordAudio("116011071", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_116011", "116011071", "story_v_out_116011.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_116011", "116011071", "story_v_out_116011.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_10 and arg_307_1.time_ < var_310_0 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play116011072 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 116011072
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play116011073(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 1.4

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_2 = arg_311_1:GetWordFromCfg(116011072)
				local var_314_3 = arg_311_1:FormatText(var_314_2.content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 56
				local var_314_5 = utf8.len(var_314_3)
				local var_314_6 = var_314_4 <= 0 and var_314_1 or var_314_1 * (var_314_5 / var_314_4)

				if var_314_6 > 0 and var_314_1 < var_314_6 then
					arg_311_1.talkMaxDuration = var_314_6

					if var_314_6 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_7 and arg_311_1.time_ < var_314_0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play116011073 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 116011073
		arg_315_1.duration_ = 6

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play116011074(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = manager.ui.mainCamera.transform
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.var_.shakeOldPos = var_318_0.localPosition
			end

			local var_318_2 = 1

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / 0.066
				local var_318_4, var_318_5 = math.modf(var_318_3)

				var_318_0.localPosition = Vector3.New(var_318_5 * 0.13, var_318_5 * 0.13, var_318_5 * 0.13) + arg_315_1.var_.shakeOldPos
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 then
				var_318_0.localPosition = arg_315_1.var_.shakeOldPos
			end

			local var_318_6 = 0

			if var_318_6 < arg_315_1.time_ and arg_315_1.time_ <= var_318_6 + arg_318_0 then
				arg_315_1.allBtn_.enabled = false
			end

			local var_318_7 = 1

			if arg_315_1.time_ >= var_318_6 + var_318_7 and arg_315_1.time_ < var_318_6 + var_318_7 + arg_318_0 then
				arg_315_1.allBtn_.enabled = true
			end

			local var_318_8 = 0
			local var_318_9 = 1

			if var_318_8 < arg_315_1.time_ and arg_315_1.time_ <= var_318_8 + arg_318_0 then
				local var_318_10 = "play"
				local var_318_11 = "effect"

				arg_315_1:AudioAction(var_318_10, var_318_11, "se_story_16", "se_story_16_fall", "")
			end

			if arg_315_1.frameCnt_ <= 1 then
				arg_315_1.dialog_:SetActive(false)
			end

			local var_318_12 = 0.999999999999
			local var_318_13 = 0.85

			if var_318_12 < arg_315_1.time_ and arg_315_1.time_ <= var_318_12 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0

				arg_315_1.dialog_:SetActive(true)

				arg_315_1.dialogCg_.alpha = 0

				local var_318_14 = LeanTween.value(arg_315_1.dialog_, 0, 1, 0.3)

				var_318_14:setOnUpdate(LuaHelper.FloatAction(function(arg_319_0)
					arg_315_1.dialogCg_.alpha = arg_319_0
				end))
				var_318_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_315_1.dialog_)
					var_318_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_315_1.duration_ = arg_315_1.duration_ + 0.3

				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_15 = arg_315_1:GetWordFromCfg(116011073)
				local var_318_16 = arg_315_1:FormatText(var_318_15.content)

				arg_315_1.text_.text = var_318_16

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_17 = 34
				local var_318_18 = utf8.len(var_318_16)
				local var_318_19 = var_318_17 <= 0 and var_318_13 or var_318_13 * (var_318_18 / var_318_17)

				if var_318_19 > 0 and var_318_13 < var_318_19 then
					arg_315_1.talkMaxDuration = var_318_19
					var_318_12 = var_318_12 + 0.3

					if var_318_19 + var_318_12 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_19 + var_318_12
					end
				end

				arg_315_1.text_.text = var_318_16
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_20 = var_318_12 + 0.3
			local var_318_21 = math.max(var_318_13, arg_315_1.talkMaxDuration)

			if var_318_20 <= arg_315_1.time_ and arg_315_1.time_ < var_318_20 + var_318_21 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_20) / var_318_21

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_20 + var_318_21 and arg_315_1.time_ < var_318_20 + var_318_21 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play116011074 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 116011074
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play116011075(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.3

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_2 = arg_321_1:GetWordFromCfg(116011074)
				local var_324_3 = arg_321_1:FormatText(var_324_2.content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 12
				local var_324_5 = utf8.len(var_324_3)
				local var_324_6 = var_324_4 <= 0 and var_324_1 or var_324_1 * (var_324_5 / var_324_4)

				if var_324_6 > 0 and var_324_1 < var_324_6 then
					arg_321_1.talkMaxDuration = var_324_6

					if var_324_6 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_6 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_7 and arg_321_1.time_ < var_324_0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play116011075 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 116011075
		arg_325_1.duration_ = 1.9

		local var_325_0 = {
			zh = 1.3,
			ja = 1.9
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play116011076(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.175

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[9].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039_split_4")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(116011075)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 7
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011075", "story_v_out_116011.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_116011", "116011075", "story_v_out_116011.awb") / 1000

					if var_328_8 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_0
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_out_116011", "116011075", "story_v_out_116011.awb")

						arg_325_1:RecordAudio("116011075", var_328_9)
						arg_325_1:RecordAudio("116011075", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_116011", "116011075", "story_v_out_116011.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_116011", "116011075", "story_v_out_116011.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_10 and arg_325_1.time_ < var_328_0 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play116011076 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 116011076
		arg_329_1.duration_ = 1

		local var_329_0 = {
			zh = 1,
			ja = 0.999999999999
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play116011077(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1039ui_story"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos1039ui_story = var_332_0.localPosition
			end

			local var_332_2 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2
				local var_332_4 = Vector3.New(0, 100, 0)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1039ui_story, var_332_4, var_332_3)

				local var_332_5 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_5.x, var_332_5.y, var_332_5.z)

				local var_332_6 = var_332_0.localEulerAngles

				var_332_6.z = 0
				var_332_6.x = 0
				var_332_0.localEulerAngles = var_332_6
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(0, 100, 0)

				local var_332_7 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_7.x, var_332_7.y, var_332_7.z)

				local var_332_8 = var_332_0.localEulerAngles

				var_332_8.z = 0
				var_332_8.x = 0
				var_332_0.localEulerAngles = var_332_8
			end

			local var_332_9 = manager.ui.mainCamera.transform
			local var_332_10 = 0

			if var_332_10 < arg_329_1.time_ and arg_329_1.time_ <= var_332_10 + arg_332_0 then
				arg_329_1.var_.shakeOldPos = var_332_9.localPosition
			end

			local var_332_11 = 0.6

			if var_332_10 <= arg_329_1.time_ and arg_329_1.time_ < var_332_10 + var_332_11 then
				local var_332_12 = (arg_329_1.time_ - var_332_10) / 0.066
				local var_332_13, var_332_14 = math.modf(var_332_12)

				var_332_9.localPosition = Vector3.New(var_332_14 * 0.13, var_332_14 * 0.13, var_332_14 * 0.13) + arg_329_1.var_.shakeOldPos
			end

			if arg_329_1.time_ >= var_332_10 + var_332_11 and arg_329_1.time_ < var_332_10 + var_332_11 + arg_332_0 then
				var_332_9.localPosition = arg_329_1.var_.shakeOldPos
			end

			local var_332_15 = 0

			if var_332_15 < arg_329_1.time_ and arg_329_1.time_ <= var_332_15 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			local var_332_16 = 0.6

			if arg_329_1.time_ >= var_332_15 + var_332_16 and arg_329_1.time_ < var_332_15 + var_332_16 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			local var_332_17 = 0
			local var_332_18 = 1

			if var_332_17 < arg_329_1.time_ and arg_329_1.time_ <= var_332_17 + arg_332_0 then
				local var_332_19 = "play"
				local var_332_20 = "effect"

				arg_329_1:AudioAction(var_332_19, var_332_20, "se_story_activity_1_5_3", "se_story_activity_1_5_3_magic", "")
			end

			local var_332_21 = 0
			local var_332_22 = 0.125

			if var_332_21 < arg_329_1.time_ and arg_329_1.time_ <= var_332_21 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_23 = arg_329_1:FormatText(StoryNameCfg[9].name)

				arg_329_1.leftNameTxt_.text = var_332_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039_split_4_1")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_24 = arg_329_1:GetWordFromCfg(116011076)
				local var_332_25 = arg_329_1:FormatText(var_332_24.content)

				arg_329_1.text_.text = var_332_25

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_26 = 5
				local var_332_27 = utf8.len(var_332_25)
				local var_332_28 = var_332_26 <= 0 and var_332_22 or var_332_22 * (var_332_27 / var_332_26)

				if var_332_28 > 0 and var_332_22 < var_332_28 then
					arg_329_1.talkMaxDuration = var_332_28

					if var_332_28 + var_332_21 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_28 + var_332_21
					end
				end

				arg_329_1.text_.text = var_332_25
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011076", "story_v_out_116011.awb") ~= 0 then
					local var_332_29 = manager.audio:GetVoiceLength("story_v_out_116011", "116011076", "story_v_out_116011.awb") / 1000

					if var_332_29 + var_332_21 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_29 + var_332_21
					end

					if var_332_24.prefab_name ~= "" and arg_329_1.actors_[var_332_24.prefab_name] ~= nil then
						local var_332_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_24.prefab_name].transform, "story_v_out_116011", "116011076", "story_v_out_116011.awb")

						arg_329_1:RecordAudio("116011076", var_332_30)
						arg_329_1:RecordAudio("116011076", var_332_30)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_116011", "116011076", "story_v_out_116011.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_116011", "116011076", "story_v_out_116011.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_31 = math.max(var_332_22, arg_329_1.talkMaxDuration)

			if var_332_21 <= arg_329_1.time_ and arg_329_1.time_ < var_332_21 + var_332_31 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_21) / var_332_31

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_21 + var_332_31 and arg_329_1.time_ < var_332_21 + var_332_31 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play116011077 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 116011077
		arg_333_1.duration_ = 6.5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play116011078(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_1 = 1.5

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_1 then
				local var_336_2 = (arg_333_1.time_ - var_336_0) / var_336_1
				local var_336_3 = Color.New(1, 1, 1)

				var_336_3.a = Mathf.Lerp(1, 0, var_336_2)
				arg_333_1.mask_.color = var_336_3
			end

			if arg_333_1.time_ >= var_336_0 + var_336_1 and arg_333_1.time_ < var_336_0 + var_336_1 + arg_336_0 then
				local var_336_4 = Color.New(1, 1, 1)
				local var_336_5 = 0

				arg_333_1.mask_.enabled = false
				var_336_4.a = var_336_5
				arg_333_1.mask_.color = var_336_4
			end

			if arg_333_1.frameCnt_ <= 1 then
				arg_333_1.dialog_:SetActive(false)
			end

			local var_336_6 = 1.5
			local var_336_7 = 1.05

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				arg_333_1.dialog_:SetActive(true)

				arg_333_1.dialogCg_.alpha = 0

				local var_336_8 = LeanTween.value(arg_333_1.dialog_, 0, 1, 0.3)

				var_336_8:setOnUpdate(LuaHelper.FloatAction(function(arg_337_0)
					arg_333_1.dialogCg_.alpha = arg_337_0
				end))
				var_336_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_333_1.dialog_)
					var_336_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_333_1.duration_ = arg_333_1.duration_ + 0.3

				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_9 = arg_333_1:GetWordFromCfg(116011077)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 42
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13
					var_336_6 = var_336_6 + 0.3

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_14 = var_336_6 + 0.3
			local var_336_15 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_14 <= arg_333_1.time_ and arg_333_1.time_ < var_336_14 + var_336_15 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_14) / var_336_15

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_14 + var_336_15 and arg_333_1.time_ < var_336_14 + var_336_15 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play116011078 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 116011078
		arg_339_1.duration_ = 2

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play116011079(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1048ui_story"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos1048ui_story = var_342_0.localPosition
			end

			local var_342_2 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2
				local var_342_4 = Vector3.New(0, -0.8, -6.2)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1048ui_story, var_342_4, var_342_3)

				local var_342_5 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_5.x, var_342_5.y, var_342_5.z)

				local var_342_6 = var_342_0.localEulerAngles

				var_342_6.z = 0
				var_342_6.x = 0
				var_342_0.localEulerAngles = var_342_6
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_342_7 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_7.x, var_342_7.y, var_342_7.z)

				local var_342_8 = var_342_0.localEulerAngles

				var_342_8.z = 0
				var_342_8.x = 0
				var_342_0.localEulerAngles = var_342_8
			end

			local var_342_9 = 0

			if var_342_9 < arg_339_1.time_ and arg_339_1.time_ <= var_342_9 + arg_342_0 then
				arg_339_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action8_2")
			end

			local var_342_10 = 0

			if var_342_10 < arg_339_1.time_ and arg_339_1.time_ <= var_342_10 + arg_342_0 then
				arg_339_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_342_11 = arg_339_1.actors_["1048ui_story"]
			local var_342_12 = 0

			if var_342_12 < arg_339_1.time_ and arg_339_1.time_ <= var_342_12 + arg_342_0 and not isNil(var_342_11) and arg_339_1.var_.characterEffect1048ui_story == nil then
				arg_339_1.var_.characterEffect1048ui_story = var_342_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_13 = 0.2

			if var_342_12 <= arg_339_1.time_ and arg_339_1.time_ < var_342_12 + var_342_13 and not isNil(var_342_11) then
				local var_342_14 = (arg_339_1.time_ - var_342_12) / var_342_13

				if arg_339_1.var_.characterEffect1048ui_story and not isNil(var_342_11) then
					arg_339_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_12 + var_342_13 and arg_339_1.time_ < var_342_12 + var_342_13 + arg_342_0 and not isNil(var_342_11) and arg_339_1.var_.characterEffect1048ui_story then
				arg_339_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_342_15 = 0
			local var_342_16 = 0.2

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_17 = arg_339_1:FormatText(StoryNameCfg[8].name)

				arg_339_1.leftNameTxt_.text = var_342_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_18 = arg_339_1:GetWordFromCfg(116011078)
				local var_342_19 = arg_339_1:FormatText(var_342_18.content)

				arg_339_1.text_.text = var_342_19

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_20 = 8
				local var_342_21 = utf8.len(var_342_19)
				local var_342_22 = var_342_20 <= 0 and var_342_16 or var_342_16 * (var_342_21 / var_342_20)

				if var_342_22 > 0 and var_342_16 < var_342_22 then
					arg_339_1.talkMaxDuration = var_342_22

					if var_342_22 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_22 + var_342_15
					end
				end

				arg_339_1.text_.text = var_342_19
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011078", "story_v_out_116011.awb") ~= 0 then
					local var_342_23 = manager.audio:GetVoiceLength("story_v_out_116011", "116011078", "story_v_out_116011.awb") / 1000

					if var_342_23 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_23 + var_342_15
					end

					if var_342_18.prefab_name ~= "" and arg_339_1.actors_[var_342_18.prefab_name] ~= nil then
						local var_342_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_18.prefab_name].transform, "story_v_out_116011", "116011078", "story_v_out_116011.awb")

						arg_339_1:RecordAudio("116011078", var_342_24)
						arg_339_1:RecordAudio("116011078", var_342_24)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_116011", "116011078", "story_v_out_116011.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_116011", "116011078", "story_v_out_116011.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_25 = math.max(var_342_16, arg_339_1.talkMaxDuration)

			if var_342_15 <= arg_339_1.time_ and arg_339_1.time_ < var_342_15 + var_342_25 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_15) / var_342_25

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_15 + var_342_25 and arg_339_1.time_ < var_342_15 + var_342_25 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play116011079 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 116011079
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play116011080(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1048ui_story"].transform
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.var_.moveOldPos1048ui_story = var_346_0.localPosition
			end

			local var_346_2 = 0.001

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2
				local var_346_4 = Vector3.New(0, 100, 0)

				var_346_0.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1048ui_story, var_346_4, var_346_3)

				local var_346_5 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_5.x, var_346_5.y, var_346_5.z)

				local var_346_6 = var_346_0.localEulerAngles

				var_346_6.z = 0
				var_346_6.x = 0
				var_346_0.localEulerAngles = var_346_6
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 then
				var_346_0.localPosition = Vector3.New(0, 100, 0)

				local var_346_7 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_7.x, var_346_7.y, var_346_7.z)

				local var_346_8 = var_346_0.localEulerAngles

				var_346_8.z = 0
				var_346_8.x = 0
				var_346_0.localEulerAngles = var_346_8
			end

			local var_346_9 = 0
			local var_346_10 = 0.775

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_11 = arg_343_1:GetWordFromCfg(116011079)
				local var_346_12 = arg_343_1:FormatText(var_346_11.content)

				arg_343_1.text_.text = var_346_12

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_13 = 31
				local var_346_14 = utf8.len(var_346_12)
				local var_346_15 = var_346_13 <= 0 and var_346_10 or var_346_10 * (var_346_14 / var_346_13)

				if var_346_15 > 0 and var_346_10 < var_346_15 then
					arg_343_1.talkMaxDuration = var_346_15

					if var_346_15 + var_346_9 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_15 + var_346_9
					end
				end

				arg_343_1.text_.text = var_346_12
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_16 = math.max(var_346_10, arg_343_1.talkMaxDuration)

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_16 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_9) / var_346_16

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_9 + var_346_16 and arg_343_1.time_ < var_346_9 + var_346_16 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play116011080 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 116011080
		arg_347_1.duration_ = 2.13

		local var_347_0 = {
			zh = 1.999999999999,
			ja = 2.133
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
				arg_347_0:Play116011081(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1039ui_story"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1039ui_story == nil then
				arg_347_1.var_.characterEffect1039ui_story = var_350_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.characterEffect1039ui_story and not isNil(var_350_0) then
					arg_347_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1039ui_story then
				arg_347_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_350_4 = arg_347_1.actors_["1039ui_story"].transform
			local var_350_5 = 0

			if var_350_5 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.var_.moveOldPos1039ui_story = var_350_4.localPosition
			end

			local var_350_6 = 0.001

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_6 then
				local var_350_7 = (arg_347_1.time_ - var_350_5) / var_350_6
				local var_350_8 = Vector3.New(0, -1.01, -5.9)

				var_350_4.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1039ui_story, var_350_8, var_350_7)

				local var_350_9 = manager.ui.mainCamera.transform.position - var_350_4.position

				var_350_4.forward = Vector3.New(var_350_9.x, var_350_9.y, var_350_9.z)

				local var_350_10 = var_350_4.localEulerAngles

				var_350_10.z = 0
				var_350_10.x = 0
				var_350_4.localEulerAngles = var_350_10
			end

			if arg_347_1.time_ >= var_350_5 + var_350_6 and arg_347_1.time_ < var_350_5 + var_350_6 + arg_350_0 then
				var_350_4.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_350_11 = manager.ui.mainCamera.transform.position - var_350_4.position

				var_350_4.forward = Vector3.New(var_350_11.x, var_350_11.y, var_350_11.z)

				local var_350_12 = var_350_4.localEulerAngles

				var_350_12.z = 0
				var_350_12.x = 0
				var_350_4.localEulerAngles = var_350_12
			end

			local var_350_13 = 0

			if var_350_13 < arg_347_1.time_ and arg_347_1.time_ <= var_350_13 + arg_350_0 then
				arg_347_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_350_14 = 0

			if var_350_14 < arg_347_1.time_ and arg_347_1.time_ <= var_350_14 + arg_350_0 then
				arg_347_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_350_15 = 0
			local var_350_16 = 0.1

			if var_350_15 < arg_347_1.time_ and arg_347_1.time_ <= var_350_15 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_17 = arg_347_1:FormatText(StoryNameCfg[9].name)

				arg_347_1.leftNameTxt_.text = var_350_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_18 = arg_347_1:GetWordFromCfg(116011080)
				local var_350_19 = arg_347_1:FormatText(var_350_18.content)

				arg_347_1.text_.text = var_350_19

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_20 = 4
				local var_350_21 = utf8.len(var_350_19)
				local var_350_22 = var_350_20 <= 0 and var_350_16 or var_350_16 * (var_350_21 / var_350_20)

				if var_350_22 > 0 and var_350_16 < var_350_22 then
					arg_347_1.talkMaxDuration = var_350_22

					if var_350_22 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_22 + var_350_15
					end
				end

				arg_347_1.text_.text = var_350_19
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011080", "story_v_out_116011.awb") ~= 0 then
					local var_350_23 = manager.audio:GetVoiceLength("story_v_out_116011", "116011080", "story_v_out_116011.awb") / 1000

					if var_350_23 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_23 + var_350_15
					end

					if var_350_18.prefab_name ~= "" and arg_347_1.actors_[var_350_18.prefab_name] ~= nil then
						local var_350_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_18.prefab_name].transform, "story_v_out_116011", "116011080", "story_v_out_116011.awb")

						arg_347_1:RecordAudio("116011080", var_350_24)
						arg_347_1:RecordAudio("116011080", var_350_24)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_116011", "116011080", "story_v_out_116011.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_116011", "116011080", "story_v_out_116011.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_25 = math.max(var_350_16, arg_347_1.talkMaxDuration)

			if var_350_15 <= arg_347_1.time_ and arg_347_1.time_ < var_350_15 + var_350_25 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_15) / var_350_25

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_15 + var_350_25 and arg_347_1.time_ < var_350_15 + var_350_25 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
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

		arg_347_1:InitPlayNodeList()
	end,
	Play116011081 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 116011081
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play116011082(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1039ui_story"].transform
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.var_.moveOldPos1039ui_story = var_354_0.localPosition
			end

			local var_354_2 = 0.001

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2
				local var_354_4 = Vector3.New(0, 100, 0)

				var_354_0.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1039ui_story, var_354_4, var_354_3)

				local var_354_5 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_5.x, var_354_5.y, var_354_5.z)

				local var_354_6 = var_354_0.localEulerAngles

				var_354_6.z = 0
				var_354_6.x = 0
				var_354_0.localEulerAngles = var_354_6
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 then
				var_354_0.localPosition = Vector3.New(0, 100, 0)

				local var_354_7 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_7.x, var_354_7.y, var_354_7.z)

				local var_354_8 = var_354_0.localEulerAngles

				var_354_8.z = 0
				var_354_8.x = 0
				var_354_0.localEulerAngles = var_354_8
			end

			local var_354_9 = 0
			local var_354_10 = 0.575

			if var_354_9 < arg_351_1.time_ and arg_351_1.time_ <= var_354_9 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_11 = arg_351_1:GetWordFromCfg(116011081)
				local var_354_12 = arg_351_1:FormatText(var_354_11.content)

				arg_351_1.text_.text = var_354_12

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_13 = 23
				local var_354_14 = utf8.len(var_354_12)
				local var_354_15 = var_354_13 <= 0 and var_354_10 or var_354_10 * (var_354_14 / var_354_13)

				if var_354_15 > 0 and var_354_10 < var_354_15 then
					arg_351_1.talkMaxDuration = var_354_15

					if var_354_15 + var_354_9 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_15 + var_354_9
					end
				end

				arg_351_1.text_.text = var_354_12
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_16 = math.max(var_354_10, arg_351_1.talkMaxDuration)

			if var_354_9 <= arg_351_1.time_ and arg_351_1.time_ < var_354_9 + var_354_16 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_9) / var_354_16

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_9 + var_354_16 and arg_351_1.time_ < var_354_9 + var_354_16 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
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

		arg_351_1:InitPlayNodeList()
	end,
	Play116011082 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 116011082
		arg_355_1.duration_ = 3.2

		local var_355_0 = {
			zh = 1.999999999999,
			ja = 3.2
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
				arg_355_0:Play116011083(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1039ui_story"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos1039ui_story = var_358_0.localPosition
			end

			local var_358_2 = 0.001

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2
				local var_358_4 = Vector3.New(0, -1.01, -5.9)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1039ui_story, var_358_4, var_358_3)

				local var_358_5 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_5.x, var_358_5.y, var_358_5.z)

				local var_358_6 = var_358_0.localEulerAngles

				var_358_6.z = 0
				var_358_6.x = 0
				var_358_0.localEulerAngles = var_358_6
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_358_7 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_7.x, var_358_7.y, var_358_7.z)

				local var_358_8 = var_358_0.localEulerAngles

				var_358_8.z = 0
				var_358_8.x = 0
				var_358_0.localEulerAngles = var_358_8
			end

			local var_358_9 = 0

			if var_358_9 < arg_355_1.time_ and arg_355_1.time_ <= var_358_9 + arg_358_0 then
				arg_355_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_358_10 = arg_355_1.actors_["1039ui_story"]
			local var_358_11 = 0

			if var_358_11 < arg_355_1.time_ and arg_355_1.time_ <= var_358_11 + arg_358_0 and not isNil(var_358_10) and arg_355_1.var_.characterEffect1039ui_story == nil then
				arg_355_1.var_.characterEffect1039ui_story = var_358_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_12 = 0.2

			if var_358_11 <= arg_355_1.time_ and arg_355_1.time_ < var_358_11 + var_358_12 and not isNil(var_358_10) then
				local var_358_13 = (arg_355_1.time_ - var_358_11) / var_358_12

				if arg_355_1.var_.characterEffect1039ui_story and not isNil(var_358_10) then
					arg_355_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_11 + var_358_12 and arg_355_1.time_ < var_358_11 + var_358_12 + arg_358_0 and not isNil(var_358_10) and arg_355_1.var_.characterEffect1039ui_story then
				arg_355_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_358_14 = 0
			local var_358_15 = 0.275

			if var_358_14 < arg_355_1.time_ and arg_355_1.time_ <= var_358_14 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_16 = arg_355_1:FormatText(StoryNameCfg[9].name)

				arg_355_1.leftNameTxt_.text = var_358_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_17 = arg_355_1:GetWordFromCfg(116011082)
				local var_358_18 = arg_355_1:FormatText(var_358_17.content)

				arg_355_1.text_.text = var_358_18

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_19 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011082", "story_v_out_116011.awb") ~= 0 then
					local var_358_22 = manager.audio:GetVoiceLength("story_v_out_116011", "116011082", "story_v_out_116011.awb") / 1000

					if var_358_22 + var_358_14 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_22 + var_358_14
					end

					if var_358_17.prefab_name ~= "" and arg_355_1.actors_[var_358_17.prefab_name] ~= nil then
						local var_358_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_17.prefab_name].transform, "story_v_out_116011", "116011082", "story_v_out_116011.awb")

						arg_355_1:RecordAudio("116011082", var_358_23)
						arg_355_1:RecordAudio("116011082", var_358_23)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_116011", "116011082", "story_v_out_116011.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_116011", "116011082", "story_v_out_116011.awb")
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
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play116011083 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 116011083
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play116011084(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1039ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos1039ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(0, 100, 0)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1039ui_story, var_362_4, var_362_3)

				local var_362_5 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_5.x, var_362_5.y, var_362_5.z)

				local var_362_6 = var_362_0.localEulerAngles

				var_362_6.z = 0
				var_362_6.x = 0
				var_362_0.localEulerAngles = var_362_6
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(0, 100, 0)

				local var_362_7 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_7.x, var_362_7.y, var_362_7.z)

				local var_362_8 = var_362_0.localEulerAngles

				var_362_8.z = 0
				var_362_8.x = 0
				var_362_0.localEulerAngles = var_362_8
			end

			local var_362_9 = 0
			local var_362_10 = 0.775

			if var_362_9 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 then
				local var_362_11 = "play"
				local var_362_12 = "effect"

				arg_359_1:AudioAction(var_362_11, var_362_12, "se_story_16", "se_story_16_skill01", "")
			end

			local var_362_13 = 0.3
			local var_362_14 = 0.7

			if var_362_13 < arg_359_1.time_ and arg_359_1.time_ <= var_362_13 + arg_362_0 then
				local var_362_15 = "play"
				local var_362_16 = "effect"

				arg_359_1:AudioAction(var_362_15, var_362_16, "se_story_16", "se_story_16_skill_loop", "")
			end

			local var_362_17 = 0
			local var_362_18 = 0.775

			if var_362_17 < arg_359_1.time_ and arg_359_1.time_ <= var_362_17 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_19 = arg_359_1:GetWordFromCfg(116011083)
				local var_362_20 = arg_359_1:FormatText(var_362_19.content)

				arg_359_1.text_.text = var_362_20

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_21 = 31
				local var_362_22 = utf8.len(var_362_20)
				local var_362_23 = var_362_21 <= 0 and var_362_18 or var_362_18 * (var_362_22 / var_362_21)

				if var_362_23 > 0 and var_362_18 < var_362_23 then
					arg_359_1.talkMaxDuration = var_362_23

					if var_362_23 + var_362_17 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_23 + var_362_17
					end
				end

				arg_359_1.text_.text = var_362_20
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_24 = math.max(var_362_18, arg_359_1.talkMaxDuration)

			if var_362_17 <= arg_359_1.time_ and arg_359_1.time_ < var_362_17 + var_362_24 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_17) / var_362_24

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_17 + var_362_24 and arg_359_1.time_ < var_362_17 + var_362_24 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
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

		arg_359_1:InitPlayNodeList()
	end,
	Play116011084 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 116011084
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play116011085(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = manager.ui.mainCamera.transform
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.var_.shakeOldPos = var_366_0.localPosition
			end

			local var_366_2 = 0.6

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / 0.066
				local var_366_4, var_366_5 = math.modf(var_366_3)

				var_366_0.localPosition = Vector3.New(var_366_5 * 0.13, var_366_5 * 0.13, var_366_5 * 0.13) + arg_363_1.var_.shakeOldPos
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 then
				var_366_0.localPosition = arg_363_1.var_.shakeOldPos
			end

			local var_366_6 = 0
			local var_366_7 = 0.733333333333333

			if var_366_6 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				local var_366_8 = "stop"
				local var_366_9 = "music"

				arg_363_1:AudioAction(var_366_8, var_366_9, "se_story_16", "se_story_16_skill_loop", "")

				local var_366_10 = ""
				local var_366_11 = manager.audio:GetAudioName("se_story_16", "se_story_16_skill_loop")

				if var_366_11 ~= "" then
					if arg_363_1.bgmTxt_.text ~= var_366_11 and arg_363_1.bgmTxt_.text ~= "" then
						if arg_363_1.bgmTxt2_.text ~= "" then
							arg_363_1.bgmTxt_.text = arg_363_1.bgmTxt2_.text
						end

						arg_363_1.bgmTxt2_.text = var_366_11

						arg_363_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_363_1.bgmTxt_.text = var_366_11
						arg_363_1.bgmTxt2_.text = var_366_11
					end

					if arg_363_1.bgmTimer then
						arg_363_1.bgmTimer:Stop()

						arg_363_1.bgmTimer = nil
					end

					if arg_363_1.settingData.show_music_name == 1 then
						arg_363_1.musicController:SetSelectedState("show")
						arg_363_1.musicAnimator_:Play("open", 0, 0)

						if arg_363_1.settingData.music_time ~= 0 then
							arg_363_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_363_1.settingData.music_time), function()
								if arg_363_1 == nil or isNil(arg_363_1.bgmTxt_) then
									return
								end

								arg_363_1.musicController:SetSelectedState("hide")
								arg_363_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_366_12 = 0
			local var_366_13 = 1.05

			if var_366_12 < arg_363_1.time_ and arg_363_1.time_ <= var_366_12 + arg_366_0 then
				local var_366_14 = "play"
				local var_366_15 = "effect"

				arg_363_1:AudioAction(var_366_14, var_366_15, "se_story_16", "se_story_16_skill02", "")
			end

			local var_366_16 = 0

			if var_366_16 < arg_363_1.time_ and arg_363_1.time_ <= var_366_16 + arg_366_0 then
				arg_363_1.allBtn_.enabled = false
			end

			local var_366_17 = 0.6

			if arg_363_1.time_ >= var_366_16 + var_366_17 and arg_363_1.time_ < var_366_16 + var_366_17 + arg_366_0 then
				arg_363_1.allBtn_.enabled = true
			end

			local var_366_18 = 0
			local var_366_19 = 1.05

			if var_366_18 < arg_363_1.time_ and arg_363_1.time_ <= var_366_18 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_20 = arg_363_1:GetWordFromCfg(116011084)
				local var_366_21 = arg_363_1:FormatText(var_366_20.content)

				arg_363_1.text_.text = var_366_21

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_22 = 42
				local var_366_23 = utf8.len(var_366_21)
				local var_366_24 = var_366_22 <= 0 and var_366_19 or var_366_19 * (var_366_23 / var_366_22)

				if var_366_24 > 0 and var_366_19 < var_366_24 then
					arg_363_1.talkMaxDuration = var_366_24

					if var_366_24 + var_366_18 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_24 + var_366_18
					end
				end

				arg_363_1.text_.text = var_366_21
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_25 = math.max(var_366_19, arg_363_1.talkMaxDuration)

			if var_366_18 <= arg_363_1.time_ and arg_363_1.time_ < var_366_18 + var_366_25 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_18) / var_366_25

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_18 + var_366_25 and arg_363_1.time_ < var_366_18 + var_366_25 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play116011085 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 116011085
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play116011086(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 1.775

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_2 = arg_368_1:GetWordFromCfg(116011085)
				local var_371_3 = arg_368_1:FormatText(var_371_2.content)

				arg_368_1.text_.text = var_371_3

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 71
				local var_371_5 = utf8.len(var_371_3)
				local var_371_6 = var_371_4 <= 0 and var_371_1 or var_371_1 * (var_371_5 / var_371_4)

				if var_371_6 > 0 and var_371_1 < var_371_6 then
					arg_368_1.talkMaxDuration = var_371_6

					if var_371_6 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_6 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_3
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_7 and arg_368_1.time_ < var_371_0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play116011086 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 116011086
		arg_372_1.duration_ = 2

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play116011087(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1039ui_story"].transform
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.var_.moveOldPos1039ui_story = var_375_0.localPosition
			end

			local var_375_2 = 0.001

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2
				local var_375_4 = Vector3.New(0, -1.01, -5.9)

				var_375_0.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1039ui_story, var_375_4, var_375_3)

				local var_375_5 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_5.x, var_375_5.y, var_375_5.z)

				local var_375_6 = var_375_0.localEulerAngles

				var_375_6.z = 0
				var_375_6.x = 0
				var_375_0.localEulerAngles = var_375_6
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 then
				var_375_0.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_375_7 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_7.x, var_375_7.y, var_375_7.z)

				local var_375_8 = var_375_0.localEulerAngles

				var_375_8.z = 0
				var_375_8.x = 0
				var_375_0.localEulerAngles = var_375_8
			end

			local var_375_9 = 0

			if var_375_9 < arg_372_1.time_ and arg_372_1.time_ <= var_375_9 + arg_375_0 then
				arg_372_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_375_10 = 0

			if var_375_10 < arg_372_1.time_ and arg_372_1.time_ <= var_375_10 + arg_375_0 then
				arg_372_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_375_11 = 0
			local var_375_12 = 0.125

			if var_375_11 < arg_372_1.time_ and arg_372_1.time_ <= var_375_11 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_13 = arg_372_1:FormatText(StoryNameCfg[9].name)

				arg_372_1.leftNameTxt_.text = var_375_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_14 = arg_372_1:GetWordFromCfg(116011086)
				local var_375_15 = arg_372_1:FormatText(var_375_14.content)

				arg_372_1.text_.text = var_375_15

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_16 = 7
				local var_375_17 = utf8.len(var_375_15)
				local var_375_18 = var_375_16 <= 0 and var_375_12 or var_375_12 * (var_375_17 / var_375_16)

				if var_375_18 > 0 and var_375_12 < var_375_18 then
					arg_372_1.talkMaxDuration = var_375_18

					if var_375_18 + var_375_11 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_18 + var_375_11
					end
				end

				arg_372_1.text_.text = var_375_15
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011086", "story_v_out_116011.awb") ~= 0 then
					local var_375_19 = manager.audio:GetVoiceLength("story_v_out_116011", "116011086", "story_v_out_116011.awb") / 1000

					if var_375_19 + var_375_11 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_19 + var_375_11
					end

					if var_375_14.prefab_name ~= "" and arg_372_1.actors_[var_375_14.prefab_name] ~= nil then
						local var_375_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_14.prefab_name].transform, "story_v_out_116011", "116011086", "story_v_out_116011.awb")

						arg_372_1:RecordAudio("116011086", var_375_20)
						arg_372_1:RecordAudio("116011086", var_375_20)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_116011", "116011086", "story_v_out_116011.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_116011", "116011086", "story_v_out_116011.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_21 = math.max(var_375_12, arg_372_1.talkMaxDuration)

			if var_375_11 <= arg_372_1.time_ and arg_372_1.time_ < var_375_11 + var_375_21 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_11) / var_375_21

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_11 + var_375_21 and arg_372_1.time_ < var_375_11 + var_375_21 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
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

		arg_372_1:InitPlayNodeList()
	end,
	Play116011087 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 116011087
		arg_376_1.duration_ = 4.33

		local var_376_0 = {
			zh = 4.333,
			ja = 3.833
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play116011088(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_379_1 = 0
			local var_379_2 = 0.475

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_3 = arg_376_1:FormatText(StoryNameCfg[9].name)

				arg_376_1.leftNameTxt_.text = var_379_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_4 = arg_376_1:GetWordFromCfg(116011087)
				local var_379_5 = arg_376_1:FormatText(var_379_4.content)

				arg_376_1.text_.text = var_379_5

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_6 = 21
				local var_379_7 = utf8.len(var_379_5)
				local var_379_8 = var_379_6 <= 0 and var_379_2 or var_379_2 * (var_379_7 / var_379_6)

				if var_379_8 > 0 and var_379_2 < var_379_8 then
					arg_376_1.talkMaxDuration = var_379_8

					if var_379_8 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_1
					end
				end

				arg_376_1.text_.text = var_379_5
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011087", "story_v_out_116011.awb") ~= 0 then
					local var_379_9 = manager.audio:GetVoiceLength("story_v_out_116011", "116011087", "story_v_out_116011.awb") / 1000

					if var_379_9 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_9 + var_379_1
					end

					if var_379_4.prefab_name ~= "" and arg_376_1.actors_[var_379_4.prefab_name] ~= nil then
						local var_379_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_4.prefab_name].transform, "story_v_out_116011", "116011087", "story_v_out_116011.awb")

						arg_376_1:RecordAudio("116011087", var_379_10)
						arg_376_1:RecordAudio("116011087", var_379_10)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_116011", "116011087", "story_v_out_116011.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_116011", "116011087", "story_v_out_116011.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_11 = math.max(var_379_2, arg_376_1.talkMaxDuration)

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_11 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_1) / var_379_11

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_1 + var_379_11 and arg_376_1.time_ < var_379_1 + var_379_11 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play116011088 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 116011088
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play116011089(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1039ui_story"].transform
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.var_.moveOldPos1039ui_story = var_383_0.localPosition
			end

			local var_383_2 = 0.001

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2
				local var_383_4 = Vector3.New(0, 100, 0)

				var_383_0.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1039ui_story, var_383_4, var_383_3)

				local var_383_5 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_5.x, var_383_5.y, var_383_5.z)

				local var_383_6 = var_383_0.localEulerAngles

				var_383_6.z = 0
				var_383_6.x = 0
				var_383_0.localEulerAngles = var_383_6
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 then
				var_383_0.localPosition = Vector3.New(0, 100, 0)

				local var_383_7 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_7.x, var_383_7.y, var_383_7.z)

				local var_383_8 = var_383_0.localEulerAngles

				var_383_8.z = 0
				var_383_8.x = 0
				var_383_0.localEulerAngles = var_383_8
			end

			local var_383_9 = 0
			local var_383_10 = 1.375

			if var_383_9 < arg_380_1.time_ and arg_380_1.time_ <= var_383_9 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_11 = arg_380_1:GetWordFromCfg(116011088)
				local var_383_12 = arg_380_1:FormatText(var_383_11.content)

				arg_380_1.text_.text = var_383_12

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_13 = 55
				local var_383_14 = utf8.len(var_383_12)
				local var_383_15 = var_383_13 <= 0 and var_383_10 or var_383_10 * (var_383_14 / var_383_13)

				if var_383_15 > 0 and var_383_10 < var_383_15 then
					arg_380_1.talkMaxDuration = var_383_15

					if var_383_15 + var_383_9 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_15 + var_383_9
					end
				end

				arg_380_1.text_.text = var_383_12
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_16 = math.max(var_383_10, arg_380_1.talkMaxDuration)

			if var_383_9 <= arg_380_1.time_ and arg_380_1.time_ < var_383_9 + var_383_16 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_9) / var_383_16

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_9 + var_383_16 and arg_380_1.time_ < var_383_9 + var_383_16 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
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

		arg_380_1:InitPlayNodeList()
	end,
	Play116011089 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 116011089
		arg_384_1.duration_ = 4.4

		local var_384_0 = {
			zh = 3.633,
			ja = 4.4
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play116011090(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.35

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_2 = arg_384_1:FormatText(StoryNameCfg[9].name)

				arg_384_1.leftNameTxt_.text = var_387_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039_split_4_1")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:GetWordFromCfg(116011089)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 14
				local var_387_6 = utf8.len(var_387_4)
				local var_387_7 = var_387_5 <= 0 and var_387_1 or var_387_1 * (var_387_6 / var_387_5)

				if var_387_7 > 0 and var_387_1 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011089", "story_v_out_116011.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_out_116011", "116011089", "story_v_out_116011.awb") / 1000

					if var_387_8 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_0
					end

					if var_387_3.prefab_name ~= "" and arg_384_1.actors_[var_387_3.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_3.prefab_name].transform, "story_v_out_116011", "116011089", "story_v_out_116011.awb")

						arg_384_1:RecordAudio("116011089", var_387_9)
						arg_384_1:RecordAudio("116011089", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_116011", "116011089", "story_v_out_116011.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_116011", "116011089", "story_v_out_116011.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_10 and arg_384_1.time_ < var_387_0 + var_387_10 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play116011090 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 116011090
		arg_388_1.duration_ = 3.83

		local var_388_0 = {
			zh = 2.466,
			ja = 3.833
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
				arg_388_0:Play116011091(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0
			local var_391_1 = 0.15

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_2 = arg_388_1:FormatText(StoryNameCfg[8].name)

				arg_388_1.leftNameTxt_.text = var_391_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_3 = arg_388_1:GetWordFromCfg(116011090)
				local var_391_4 = arg_388_1:FormatText(var_391_3.content)

				arg_388_1.text_.text = var_391_4

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_5 = 6
				local var_391_6 = utf8.len(var_391_4)
				local var_391_7 = var_391_5 <= 0 and var_391_1 or var_391_1 * (var_391_6 / var_391_5)

				if var_391_7 > 0 and var_391_1 < var_391_7 then
					arg_388_1.talkMaxDuration = var_391_7

					if var_391_7 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_7 + var_391_0
					end
				end

				arg_388_1.text_.text = var_391_4
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011090", "story_v_out_116011.awb") ~= 0 then
					local var_391_8 = manager.audio:GetVoiceLength("story_v_out_116011", "116011090", "story_v_out_116011.awb") / 1000

					if var_391_8 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_8 + var_391_0
					end

					if var_391_3.prefab_name ~= "" and arg_388_1.actors_[var_391_3.prefab_name] ~= nil then
						local var_391_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_3.prefab_name].transform, "story_v_out_116011", "116011090", "story_v_out_116011.awb")

						arg_388_1:RecordAudio("116011090", var_391_9)
						arg_388_1:RecordAudio("116011090", var_391_9)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_116011", "116011090", "story_v_out_116011.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_116011", "116011090", "story_v_out_116011.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_10 = math.max(var_391_1, arg_388_1.talkMaxDuration)

			if var_391_0 <= arg_388_1.time_ and arg_388_1.time_ < var_391_0 + var_391_10 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_0) / var_391_10

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_0 + var_391_10 and arg_388_1.time_ < var_391_0 + var_391_10 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play116011091 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 116011091
		arg_392_1.duration_ = 5.3

		local var_392_0 = {
			zh = 3.4,
			ja = 5.3
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
			arg_392_1.auto_ = false
		end

		function arg_392_1.playNext_(arg_394_0)
			arg_392_1.onStoryFinished_()
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 0.833333333333333

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_2 = arg_392_1:FormatText(StoryNameCfg[9].name)

				arg_392_1.leftNameTxt_.text = var_395_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039_split_4_1")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_3 = arg_392_1:GetWordFromCfg(116011091)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 10
				local var_395_6 = utf8.len(var_395_4)
				local var_395_7 = var_395_5 <= 0 and var_395_1 or var_395_1 * (var_395_6 / var_395_5)

				if var_395_7 > 0 and var_395_1 < var_395_7 then
					arg_392_1.talkMaxDuration = var_395_7

					if var_395_7 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_0
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011091", "story_v_out_116011.awb") ~= 0 then
					local var_395_8 = manager.audio:GetVoiceLength("story_v_out_116011", "116011091", "story_v_out_116011.awb") / 1000

					if var_395_8 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_8 + var_395_0
					end

					if var_395_3.prefab_name ~= "" and arg_392_1.actors_[var_395_3.prefab_name] ~= nil then
						local var_395_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_3.prefab_name].transform, "story_v_out_116011", "116011091", "story_v_out_116011.awb")

						arg_392_1:RecordAudio("116011091", var_395_9)
						arg_392_1:RecordAudio("116011091", var_395_9)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_116011", "116011091", "story_v_out_116011.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_116011", "116011091", "story_v_out_116011.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_10 = math.max(var_395_1, arg_392_1.talkMaxDuration)

			if var_395_0 <= arg_392_1.time_ and arg_392_1.time_ < var_395_0 + var_395_10 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_0) / var_395_10

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_0 + var_395_10 and arg_392_1.time_ < var_395_0 + var_395_10 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I05f",
		"SofdecAsset/story/101160101.usm",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/I05a"
	},
	voices = {
		"story_v_out_116011.awb"
	},
	skipMarkers = {
		116011001
	}
}
