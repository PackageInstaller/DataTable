return {
	Play116311001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116311001
		arg_1_1.duration_ = 4.77

		local var_1_0 = {
			zh = 4.466,
			ja = 4.766
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
				arg_1_0:Play116311002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B13c"

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
				local var_4_5 = arg_1_1.bgs_.B13c

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
					if iter_4_0 ~= "B13c" then
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
			local var_4_23 = 0.15

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

			local var_4_28 = 0.266666666666667
			local var_4_29 = 0.733333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

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
			local var_4_35 = 0.325

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

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(116311001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311001", "story_v_out_116311.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_116311", "116311001", "story_v_out_116311.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_116311", "116311001", "story_v_out_116311.awb")

						arg_1_1:RecordAudio("116311001", var_4_44)
						arg_1_1:RecordAudio("116311001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116311", "116311001", "story_v_out_116311.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116311", "116311001", "story_v_out_116311.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_34 + 0.3
			local var_4_46 = math.max(var_4_35, arg_1_1.talkMaxDuration)

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
	Play116311002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116311002
		arg_9_1.duration_ = 2.97

		local var_9_0 = {
			zh = 2.966,
			ja = 1.999999999999
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
				arg_9_0:Play116311003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1184ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1184ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1184ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, 100, 0)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1184ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, 100, 0)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = "1148ui_story"

			if arg_9_1.actors_[var_12_14] == nil then
				local var_12_15 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_12_15) then
					local var_12_16 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_9_1.stage_.transform)

					var_12_16.name = var_12_14
					var_12_16.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_14] = var_12_16

					local var_12_17 = var_12_16:GetComponentInChildren(typeof(CharacterEffect))

					var_12_17.enabled = true

					local var_12_18 = GameObjectTools.GetOrAddComponent(var_12_16, typeof(DynamicBoneHelper))

					if var_12_18 then
						var_12_18:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_17.transform, false)

					arg_9_1.var_[var_12_14 .. "Animator"] = var_12_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_14 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_14 .. "LipSync"] = var_12_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_19 = arg_9_1.actors_["1148ui_story"].transform
			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.var_.moveOldPos1148ui_story = var_12_19.localPosition
			end

			local var_12_21 = 0.001

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_21 then
				local var_12_22 = (arg_9_1.time_ - var_12_20) / var_12_21
				local var_12_23 = Vector3.New(-0.7, -0.8, -6.2)

				var_12_19.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1148ui_story, var_12_23, var_12_22)

				local var_12_24 = manager.ui.mainCamera.transform.position - var_12_19.position

				var_12_19.forward = Vector3.New(var_12_24.x, var_12_24.y, var_12_24.z)

				local var_12_25 = var_12_19.localEulerAngles

				var_12_25.z = 0
				var_12_25.x = 0
				var_12_19.localEulerAngles = var_12_25
			end

			if arg_9_1.time_ >= var_12_20 + var_12_21 and arg_9_1.time_ < var_12_20 + var_12_21 + arg_12_0 then
				var_12_19.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_12_26 = manager.ui.mainCamera.transform.position - var_12_19.position

				var_12_19.forward = Vector3.New(var_12_26.x, var_12_26.y, var_12_26.z)

				local var_12_27 = var_12_19.localEulerAngles

				var_12_27.z = 0
				var_12_27.x = 0
				var_12_19.localEulerAngles = var_12_27
			end

			local var_12_28 = "1059ui_story"

			if arg_9_1.actors_[var_12_28] == nil then
				local var_12_29 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_12_29) then
					local var_12_30 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_9_1.stage_.transform)

					var_12_30.name = var_12_28
					var_12_30.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_28] = var_12_30

					local var_12_31 = var_12_30:GetComponentInChildren(typeof(CharacterEffect))

					var_12_31.enabled = true

					local var_12_32 = GameObjectTools.GetOrAddComponent(var_12_30, typeof(DynamicBoneHelper))

					if var_12_32 then
						var_12_32:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_31.transform, false)

					arg_9_1.var_[var_12_28 .. "Animator"] = var_12_31.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_28 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_28 .. "LipSync"] = var_12_31.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_33 = arg_9_1.actors_["1059ui_story"].transform
			local var_12_34 = 0

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1.var_.moveOldPos1059ui_story = var_12_33.localPosition
			end

			local var_12_35 = 0.001

			if var_12_34 <= arg_9_1.time_ and arg_9_1.time_ < var_12_34 + var_12_35 then
				local var_12_36 = (arg_9_1.time_ - var_12_34) / var_12_35
				local var_12_37 = Vector3.New(0.7, -1.05, -6)

				var_12_33.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1059ui_story, var_12_37, var_12_36)

				local var_12_38 = manager.ui.mainCamera.transform.position - var_12_33.position

				var_12_33.forward = Vector3.New(var_12_38.x, var_12_38.y, var_12_38.z)

				local var_12_39 = var_12_33.localEulerAngles

				var_12_39.z = 0
				var_12_39.x = 0
				var_12_33.localEulerAngles = var_12_39
			end

			if arg_9_1.time_ >= var_12_34 + var_12_35 and arg_9_1.time_ < var_12_34 + var_12_35 + arg_12_0 then
				var_12_33.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_12_40 = manager.ui.mainCamera.transform.position - var_12_33.position

				var_12_33.forward = Vector3.New(var_12_40.x, var_12_40.y, var_12_40.z)

				local var_12_41 = var_12_33.localEulerAngles

				var_12_41.z = 0
				var_12_41.x = 0
				var_12_33.localEulerAngles = var_12_41
			end

			local var_12_42 = arg_9_1.actors_["1148ui_story"]
			local var_12_43 = 0

			if var_12_43 < arg_9_1.time_ and arg_9_1.time_ <= var_12_43 + arg_12_0 and not isNil(var_12_42) and arg_9_1.var_.characterEffect1148ui_story == nil then
				arg_9_1.var_.characterEffect1148ui_story = var_12_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_44 = 0.2

			if var_12_43 <= arg_9_1.time_ and arg_9_1.time_ < var_12_43 + var_12_44 and not isNil(var_12_42) then
				local var_12_45 = (arg_9_1.time_ - var_12_43) / var_12_44

				if arg_9_1.var_.characterEffect1148ui_story and not isNil(var_12_42) then
					local var_12_46 = Mathf.Lerp(0, 0.5, var_12_45)

					arg_9_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1148ui_story.fillRatio = var_12_46
				end
			end

			if arg_9_1.time_ >= var_12_43 + var_12_44 and arg_9_1.time_ < var_12_43 + var_12_44 + arg_12_0 and not isNil(var_12_42) and arg_9_1.var_.characterEffect1148ui_story then
				local var_12_47 = 0.5

				arg_9_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1148ui_story.fillRatio = var_12_47
			end

			local var_12_48 = arg_9_1.actors_["1059ui_story"]
			local var_12_49 = 0

			if var_12_49 < arg_9_1.time_ and arg_9_1.time_ <= var_12_49 + arg_12_0 and not isNil(var_12_48) and arg_9_1.var_.characterEffect1059ui_story == nil then
				arg_9_1.var_.characterEffect1059ui_story = var_12_48:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_50 = 0.2

			if var_12_49 <= arg_9_1.time_ and arg_9_1.time_ < var_12_49 + var_12_50 and not isNil(var_12_48) then
				local var_12_51 = (arg_9_1.time_ - var_12_49) / var_12_50

				if arg_9_1.var_.characterEffect1059ui_story and not isNil(var_12_48) then
					arg_9_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_49 + var_12_50 and arg_9_1.time_ < var_12_49 + var_12_50 + arg_12_0 and not isNil(var_12_48) and arg_9_1.var_.characterEffect1059ui_story then
				arg_9_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_12_52 = 0

			if var_12_52 < arg_9_1.time_ and arg_9_1.time_ <= var_12_52 + arg_12_0 then
				arg_9_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_12_53 = 0

			if var_12_53 < arg_9_1.time_ and arg_9_1.time_ <= var_12_53 + arg_12_0 then
				arg_9_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_12_54 = 0

			if var_12_54 < arg_9_1.time_ and arg_9_1.time_ <= var_12_54 + arg_12_0 then
				arg_9_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_55 = 0
			local var_12_56 = 0.35

			if var_12_55 < arg_9_1.time_ and arg_9_1.time_ <= var_12_55 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_57 = arg_9_1:FormatText(StoryNameCfg[28].name)

				arg_9_1.leftNameTxt_.text = var_12_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_58 = arg_9_1:GetWordFromCfg(116311002)
				local var_12_59 = arg_9_1:FormatText(var_12_58.content)

				arg_9_1.text_.text = var_12_59

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_60 = 14
				local var_12_61 = utf8.len(var_12_59)
				local var_12_62 = var_12_60 <= 0 and var_12_56 or var_12_56 * (var_12_61 / var_12_60)

				if var_12_62 > 0 and var_12_56 < var_12_62 then
					arg_9_1.talkMaxDuration = var_12_62

					if var_12_62 + var_12_55 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_62 + var_12_55
					end
				end

				arg_9_1.text_.text = var_12_59
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311002", "story_v_out_116311.awb") ~= 0 then
					local var_12_63 = manager.audio:GetVoiceLength("story_v_out_116311", "116311002", "story_v_out_116311.awb") / 1000

					if var_12_63 + var_12_55 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_63 + var_12_55
					end

					if var_12_58.prefab_name ~= "" and arg_9_1.actors_[var_12_58.prefab_name] ~= nil then
						local var_12_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_58.prefab_name].transform, "story_v_out_116311", "116311002", "story_v_out_116311.awb")

						arg_9_1:RecordAudio("116311002", var_12_64)
						arg_9_1:RecordAudio("116311002", var_12_64)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_116311", "116311002", "story_v_out_116311.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_116311", "116311002", "story_v_out_116311.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_65 = math.max(var_12_56, arg_9_1.talkMaxDuration)

			if var_12_55 <= arg_9_1.time_ and arg_9_1.time_ < var_12_55 + var_12_65 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_55) / var_12_65

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_55 + var_12_65 and arg_9_1.time_ < var_12_55 + var_12_65 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play116311003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116311003
		arg_13_1.duration_ = 3.8

		local var_13_0 = {
			zh = 3.433,
			ja = 3.8
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
				arg_13_0:Play116311004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1148ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1148ui_story == nil then
				arg_13_1.var_.characterEffect1148ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1148ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1148ui_story then
				arg_13_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_16_4 = arg_13_1.actors_["1059ui_story"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1059ui_story == nil then
				arg_13_1.var_.characterEffect1059ui_story = var_16_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.2

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.characterEffect1059ui_story and not isNil(var_16_4) then
					local var_16_8 = Mathf.Lerp(0, 0.5, var_16_7)

					arg_13_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1059ui_story.fillRatio = var_16_8
				end
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1059ui_story then
				local var_16_9 = 0.5

				arg_13_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1059ui_story.fillRatio = var_16_9
			end

			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action493")
			end

			local var_16_11 = 0

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_16_12 = 0
			local var_16_13 = 0.325

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_14 = arg_13_1:FormatText(StoryNameCfg[8].name)

				arg_13_1.leftNameTxt_.text = var_16_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:GetWordFromCfg(116311003)
				local var_16_16 = arg_13_1:FormatText(var_16_15.content)

				arg_13_1.text_.text = var_16_16

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 13
				local var_16_18 = utf8.len(var_16_16)
				local var_16_19 = var_16_17 <= 0 and var_16_13 or var_16_13 * (var_16_18 / var_16_17)

				if var_16_19 > 0 and var_16_13 < var_16_19 then
					arg_13_1.talkMaxDuration = var_16_19

					if var_16_19 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_16
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311003", "story_v_out_116311.awb") ~= 0 then
					local var_16_20 = manager.audio:GetVoiceLength("story_v_out_116311", "116311003", "story_v_out_116311.awb") / 1000

					if var_16_20 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_12
					end

					if var_16_15.prefab_name ~= "" and arg_13_1.actors_[var_16_15.prefab_name] ~= nil then
						local var_16_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_15.prefab_name].transform, "story_v_out_116311", "116311003", "story_v_out_116311.awb")

						arg_13_1:RecordAudio("116311003", var_16_21)
						arg_13_1:RecordAudio("116311003", var_16_21)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_116311", "116311003", "story_v_out_116311.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_116311", "116311003", "story_v_out_116311.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_22 and arg_13_1.time_ < var_16_12 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play116311004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116311004
		arg_17_1.duration_ = 5.4

		local var_17_0 = {
			zh = 5.4,
			ja = 5.233
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
				arg_17_0:Play116311005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1184ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1184ui_story = var_20_0.localPosition

				local var_20_2 = "1184ui_story"

				arg_17_1:ShowWeapon(arg_17_1.var_[var_20_2 .. "Animator"].transform, true)
			end

			local var_20_3 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_3 then
				local var_20_4 = (arg_17_1.time_ - var_20_1) / var_20_3
				local var_20_5 = Vector3.New(0, -0.97, -6)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1184ui_story, var_20_5, var_20_4)

				local var_20_6 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_6.x, var_20_6.y, var_20_6.z)

				local var_20_7 = var_20_0.localEulerAngles

				var_20_7.z = 0
				var_20_7.x = 0
				var_20_0.localEulerAngles = var_20_7
			end

			if arg_17_1.time_ >= var_20_1 + var_20_3 and arg_17_1.time_ < var_20_1 + var_20_3 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_20_8 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_8.x, var_20_8.y, var_20_8.z)

				local var_20_9 = var_20_0.localEulerAngles

				var_20_9.z = 0
				var_20_9.x = 0
				var_20_0.localEulerAngles = var_20_9
			end

			local var_20_10 = arg_17_1.actors_["1148ui_story"].transform
			local var_20_11 = 0

			if var_20_11 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1.var_.moveOldPos1148ui_story = var_20_10.localPosition

				local var_20_12 = "1148ui_story"

				arg_17_1:ShowWeapon(arg_17_1.var_[var_20_12 .. "Animator"].transform, true)
			end

			local var_20_13 = 0.001

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_13 then
				local var_20_14 = (arg_17_1.time_ - var_20_11) / var_20_13
				local var_20_15 = Vector3.New(0, 100, 0)

				var_20_10.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1148ui_story, var_20_15, var_20_14)

				local var_20_16 = manager.ui.mainCamera.transform.position - var_20_10.position

				var_20_10.forward = Vector3.New(var_20_16.x, var_20_16.y, var_20_16.z)

				local var_20_17 = var_20_10.localEulerAngles

				var_20_17.z = 0
				var_20_17.x = 0
				var_20_10.localEulerAngles = var_20_17
			end

			if arg_17_1.time_ >= var_20_11 + var_20_13 and arg_17_1.time_ < var_20_11 + var_20_13 + arg_20_0 then
				var_20_10.localPosition = Vector3.New(0, 100, 0)

				local var_20_18 = manager.ui.mainCamera.transform.position - var_20_10.position

				var_20_10.forward = Vector3.New(var_20_18.x, var_20_18.y, var_20_18.z)

				local var_20_19 = var_20_10.localEulerAngles

				var_20_19.z = 0
				var_20_19.x = 0
				var_20_10.localEulerAngles = var_20_19
			end

			local var_20_20 = arg_17_1.actors_["1059ui_story"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos1059ui_story = var_20_20.localPosition
			end

			local var_20_22 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22
				local var_20_24 = Vector3.New(0, 100, 0)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1059ui_story, var_20_24, var_20_23)

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

			local var_20_29 = arg_17_1.actors_["1184ui_story"]
			local var_20_30 = 0

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect1184ui_story == nil then
				arg_17_1.var_.characterEffect1184ui_story = var_20_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_31 = 0.2

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_31 and not isNil(var_20_29) then
				local var_20_32 = (arg_17_1.time_ - var_20_30) / var_20_31

				if arg_17_1.var_.characterEffect1184ui_story and not isNil(var_20_29) then
					arg_17_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_30 + var_20_31 and arg_17_1.time_ < var_20_30 + var_20_31 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect1184ui_story then
				arg_17_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_20_33 = 0

			if var_20_33 < arg_17_1.time_ and arg_17_1.time_ <= var_20_33 + arg_20_0 then
				arg_17_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_20_34 = 0

			if var_20_34 < arg_17_1.time_ and arg_17_1.time_ <= var_20_34 + arg_20_0 then
				arg_17_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_20_35 = 0
			local var_20_36 = 0.625

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_37 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_38 = arg_17_1:GetWordFromCfg(116311004)
				local var_20_39 = arg_17_1:FormatText(var_20_38.content)

				arg_17_1.text_.text = var_20_39

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_40 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311004", "story_v_out_116311.awb") ~= 0 then
					local var_20_43 = manager.audio:GetVoiceLength("story_v_out_116311", "116311004", "story_v_out_116311.awb") / 1000

					if var_20_43 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_43 + var_20_35
					end

					if var_20_38.prefab_name ~= "" and arg_17_1.actors_[var_20_38.prefab_name] ~= nil then
						local var_20_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_38.prefab_name].transform, "story_v_out_116311", "116311004", "story_v_out_116311.awb")

						arg_17_1:RecordAudio("116311004", var_20_44)
						arg_17_1:RecordAudio("116311004", var_20_44)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_116311", "116311004", "story_v_out_116311.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_116311", "116311004", "story_v_out_116311.awb")
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
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play116311005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116311005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play116311006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1184ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1184ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1184ui_story, var_24_4, var_24_3)

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
			local var_24_10 = 0.85

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

				local var_24_11 = arg_21_1:GetWordFromCfg(116311005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 34
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
				actorName = "1184ui_story",
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
	Play116311006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116311006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116311007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 1.15

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

				local var_28_2 = arg_25_1:GetWordFromCfg(116311006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 46
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
	Play116311007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116311007
		arg_29_1.duration_ = 5.6

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play116311008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				local var_32_2 = "play"
				local var_32_3 = "effect"

				arg_29_1:AudioAction(var_32_2, var_32_3, "se_story_6", "se_story_6_blast", "")
			end

			local var_32_4 = manager.ui.mainCamera.transform
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.var_.shakeOldPos = var_32_4.localPosition
			end

			local var_32_6 = 1

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / 0.066
				local var_32_8, var_32_9 = math.modf(var_32_7)

				var_32_4.localPosition = Vector3.New(var_32_9 * 0.13, var_32_9 * 0.13, var_32_9 * 0.13) + arg_29_1.var_.shakeOldPos
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 then
				var_32_4.localPosition = arg_29_1.var_.shakeOldPos
			end

			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			local var_32_11 = 1

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_12 = 0.6
			local var_32_13 = 0.85

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_14 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_14:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(116311007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 34
				local var_32_18 = utf8.len(var_32_16)
				local var_32_19 = var_32_17 <= 0 and var_32_13 or var_32_13 * (var_32_18 / var_32_17)

				if var_32_19 > 0 and var_32_13 < var_32_19 then
					arg_29_1.talkMaxDuration = var_32_19
					var_32_12 = var_32_12 + 0.3

					if var_32_19 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_20 = var_32_12 + 0.3
			local var_32_21 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_20) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_20 + var_32_21 and arg_29_1.time_ < var_32_20 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play116311008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 116311008
		arg_35_1.duration_ = 9.03

		local var_35_0 = {
			zh = 8.5,
			ja = 9.033
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
				arg_35_0:Play116311009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.725

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[332].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4031")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(116311008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311008", "story_v_out_116311.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_116311", "116311008", "story_v_out_116311.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_116311", "116311008", "story_v_out_116311.awb")

						arg_35_1:RecordAudio("116311008", var_38_9)
						arg_35_1:RecordAudio("116311008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_116311", "116311008", "story_v_out_116311.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_116311", "116311008", "story_v_out_116311.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play116311009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 116311009
		arg_39_1.duration_ = 2.97

		local var_39_0 = {
			zh = 2.6,
			ja = 2.966
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
				arg_39_0:Play116311010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1184ui_story"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1184ui_story = var_42_0.localPosition

				local var_42_2 = "1184ui_story"

				arg_39_1:ShowWeapon(arg_39_1.var_[var_42_2 .. "Animator"].transform, false)
			end

			local var_42_3 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_3 then
				local var_42_4 = (arg_39_1.time_ - var_42_1) / var_42_3
				local var_42_5 = Vector3.New(0, -0.97, -6)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1184ui_story, var_42_5, var_42_4)

				local var_42_6 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_6.x, var_42_6.y, var_42_6.z)

				local var_42_7 = var_42_0.localEulerAngles

				var_42_7.z = 0
				var_42_7.x = 0
				var_42_0.localEulerAngles = var_42_7
			end

			if arg_39_1.time_ >= var_42_1 + var_42_3 and arg_39_1.time_ < var_42_1 + var_42_3 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_42_8 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_8.x, var_42_8.y, var_42_8.z)

				local var_42_9 = var_42_0.localEulerAngles

				var_42_9.z = 0
				var_42_9.x = 0
				var_42_0.localEulerAngles = var_42_9
			end

			local var_42_10 = arg_39_1.actors_["1184ui_story"]
			local var_42_11 = 0

			if var_42_11 < arg_39_1.time_ and arg_39_1.time_ <= var_42_11 + arg_42_0 and not isNil(var_42_10) and arg_39_1.var_.characterEffect1184ui_story == nil then
				arg_39_1.var_.characterEffect1184ui_story = var_42_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_12 = 0.2

			if var_42_11 <= arg_39_1.time_ and arg_39_1.time_ < var_42_11 + var_42_12 and not isNil(var_42_10) then
				local var_42_13 = (arg_39_1.time_ - var_42_11) / var_42_12

				if arg_39_1.var_.characterEffect1184ui_story and not isNil(var_42_10) then
					arg_39_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_11 + var_42_12 and arg_39_1.time_ < var_42_11 + var_42_12 + arg_42_0 and not isNil(var_42_10) and arg_39_1.var_.characterEffect1184ui_story then
				arg_39_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_42_14 = 0

			if var_42_14 < arg_39_1.time_ and arg_39_1.time_ <= var_42_14 + arg_42_0 then
				arg_39_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action10_2")
			end

			local var_42_15 = 0

			if var_42_15 < arg_39_1.time_ and arg_39_1.time_ <= var_42_15 + arg_42_0 then
				arg_39_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_42_16 = 0
			local var_42_17 = 0.25

			if var_42_16 < arg_39_1.time_ and arg_39_1.time_ <= var_42_16 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_18 = arg_39_1:FormatText(StoryNameCfg[6].name)

				arg_39_1.leftNameTxt_.text = var_42_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_19 = arg_39_1:GetWordFromCfg(116311009)
				local var_42_20 = arg_39_1:FormatText(var_42_19.content)

				arg_39_1.text_.text = var_42_20

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_21 = 10
				local var_42_22 = utf8.len(var_42_20)
				local var_42_23 = var_42_21 <= 0 and var_42_17 or var_42_17 * (var_42_22 / var_42_21)

				if var_42_23 > 0 and var_42_17 < var_42_23 then
					arg_39_1.talkMaxDuration = var_42_23

					if var_42_23 + var_42_16 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_23 + var_42_16
					end
				end

				arg_39_1.text_.text = var_42_20
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311009", "story_v_out_116311.awb") ~= 0 then
					local var_42_24 = manager.audio:GetVoiceLength("story_v_out_116311", "116311009", "story_v_out_116311.awb") / 1000

					if var_42_24 + var_42_16 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_24 + var_42_16
					end

					if var_42_19.prefab_name ~= "" and arg_39_1.actors_[var_42_19.prefab_name] ~= nil then
						local var_42_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_19.prefab_name].transform, "story_v_out_116311", "116311009", "story_v_out_116311.awb")

						arg_39_1:RecordAudio("116311009", var_42_25)
						arg_39_1:RecordAudio("116311009", var_42_25)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_116311", "116311009", "story_v_out_116311.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_116311", "116311009", "story_v_out_116311.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_26 = math.max(var_42_17, arg_39_1.talkMaxDuration)

			if var_42_16 <= arg_39_1.time_ and arg_39_1.time_ < var_42_16 + var_42_26 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_16) / var_42_26

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_16 + var_42_26 and arg_39_1.time_ < var_42_16 + var_42_26 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play116311010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 116311010
		arg_43_1.duration_ = 6.17

		local var_43_0 = {
			zh = 4.4,
			ja = 6.166
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
				arg_43_0:Play116311011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1184ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1184ui_story = var_46_0.localPosition

				local var_46_2 = "1184ui_story"

				arg_43_1:ShowWeapon(arg_43_1.var_[var_46_2 .. "Animator"].transform, true)
			end

			local var_46_3 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_3 then
				local var_46_4 = (arg_43_1.time_ - var_46_1) / var_46_3
				local var_46_5 = Vector3.New(0, 100, 0)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1184ui_story, var_46_5, var_46_4)

				local var_46_6 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_6.x, var_46_6.y, var_46_6.z)

				local var_46_7 = var_46_0.localEulerAngles

				var_46_7.z = 0
				var_46_7.x = 0
				var_46_0.localEulerAngles = var_46_7
			end

			if arg_43_1.time_ >= var_46_1 + var_46_3 and arg_43_1.time_ < var_46_1 + var_46_3 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, 100, 0)

				local var_46_8 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_8.x, var_46_8.y, var_46_8.z)

				local var_46_9 = var_46_0.localEulerAngles

				var_46_9.z = 0
				var_46_9.x = 0
				var_46_0.localEulerAngles = var_46_9
			end

			local var_46_10 = arg_43_1.actors_["1184ui_story"]
			local var_46_11 = 0

			if var_46_11 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 and not isNil(var_46_10) and arg_43_1.var_.characterEffect1184ui_story == nil then
				arg_43_1.var_.characterEffect1184ui_story = var_46_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_12 = 0.2

			if var_46_11 <= arg_43_1.time_ and arg_43_1.time_ < var_46_11 + var_46_12 and not isNil(var_46_10) then
				local var_46_13 = (arg_43_1.time_ - var_46_11) / var_46_12

				if arg_43_1.var_.characterEffect1184ui_story and not isNil(var_46_10) then
					local var_46_14 = Mathf.Lerp(0, 0.5, var_46_13)

					arg_43_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1184ui_story.fillRatio = var_46_14
				end
			end

			if arg_43_1.time_ >= var_46_11 + var_46_12 and arg_43_1.time_ < var_46_11 + var_46_12 + arg_46_0 and not isNil(var_46_10) and arg_43_1.var_.characterEffect1184ui_story then
				local var_46_15 = 0.5

				arg_43_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1184ui_story.fillRatio = var_46_15
			end

			local var_46_16 = "10025ui_story"

			if arg_43_1.actors_[var_46_16] == nil then
				local var_46_17 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_46_17) then
					local var_46_18 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_43_1.stage_.transform)

					var_46_18.name = var_46_16
					var_46_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_43_1.actors_[var_46_16] = var_46_18

					local var_46_19 = var_46_18:GetComponentInChildren(typeof(CharacterEffect))

					var_46_19.enabled = true

					local var_46_20 = GameObjectTools.GetOrAddComponent(var_46_18, typeof(DynamicBoneHelper))

					if var_46_20 then
						var_46_20:EnableDynamicBone(false)
					end

					arg_43_1:ShowWeapon(var_46_19.transform, false)

					arg_43_1.var_[var_46_16 .. "Animator"] = var_46_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_43_1.var_[var_46_16 .. "Animator"].applyRootMotion = true
					arg_43_1.var_[var_46_16 .. "LipSync"] = var_46_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_46_21 = arg_43_1.actors_["10025ui_story"].transform
			local var_46_22 = 0

			if var_46_22 < arg_43_1.time_ and arg_43_1.time_ <= var_46_22 + arg_46_0 then
				arg_43_1.var_.moveOldPos10025ui_story = var_46_21.localPosition
			end

			local var_46_23 = 0.001

			if var_46_22 <= arg_43_1.time_ and arg_43_1.time_ < var_46_22 + var_46_23 then
				local var_46_24 = (arg_43_1.time_ - var_46_22) / var_46_23
				local var_46_25 = Vector3.New(0, -1.1, -5.9)

				var_46_21.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10025ui_story, var_46_25, var_46_24)

				local var_46_26 = manager.ui.mainCamera.transform.position - var_46_21.position

				var_46_21.forward = Vector3.New(var_46_26.x, var_46_26.y, var_46_26.z)

				local var_46_27 = var_46_21.localEulerAngles

				var_46_27.z = 0
				var_46_27.x = 0
				var_46_21.localEulerAngles = var_46_27
			end

			if arg_43_1.time_ >= var_46_22 + var_46_23 and arg_43_1.time_ < var_46_22 + var_46_23 + arg_46_0 then
				var_46_21.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_46_28 = manager.ui.mainCamera.transform.position - var_46_21.position

				var_46_21.forward = Vector3.New(var_46_28.x, var_46_28.y, var_46_28.z)

				local var_46_29 = var_46_21.localEulerAngles

				var_46_29.z = 0
				var_46_29.x = 0
				var_46_21.localEulerAngles = var_46_29
			end

			local var_46_30 = arg_43_1.actors_["10025ui_story"]
			local var_46_31 = 0

			if var_46_31 < arg_43_1.time_ and arg_43_1.time_ <= var_46_31 + arg_46_0 and not isNil(var_46_30) and arg_43_1.var_.characterEffect10025ui_story == nil then
				arg_43_1.var_.characterEffect10025ui_story = var_46_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_32 = 0.2

			if var_46_31 <= arg_43_1.time_ and arg_43_1.time_ < var_46_31 + var_46_32 and not isNil(var_46_30) then
				local var_46_33 = (arg_43_1.time_ - var_46_31) / var_46_32

				if arg_43_1.var_.characterEffect10025ui_story and not isNil(var_46_30) then
					arg_43_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_31 + var_46_32 and arg_43_1.time_ < var_46_31 + var_46_32 + arg_46_0 and not isNil(var_46_30) and arg_43_1.var_.characterEffect10025ui_story then
				arg_43_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_46_34 = 0

			if var_46_34 < arg_43_1.time_ and arg_43_1.time_ <= var_46_34 + arg_46_0 then
				arg_43_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_46_35 = 0

			if var_46_35 < arg_43_1.time_ and arg_43_1.time_ <= var_46_35 + arg_46_0 then
				arg_43_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_46_36 = 0
			local var_46_37 = 0.275

			if var_46_36 < arg_43_1.time_ and arg_43_1.time_ <= var_46_36 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_38 = arg_43_1:FormatText(StoryNameCfg[328].name)

				arg_43_1.leftNameTxt_.text = var_46_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_39 = arg_43_1:GetWordFromCfg(116311010)
				local var_46_40 = arg_43_1:FormatText(var_46_39.content)

				arg_43_1.text_.text = var_46_40

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_41 = 11
				local var_46_42 = utf8.len(var_46_40)
				local var_46_43 = var_46_41 <= 0 and var_46_37 or var_46_37 * (var_46_42 / var_46_41)

				if var_46_43 > 0 and var_46_37 < var_46_43 then
					arg_43_1.talkMaxDuration = var_46_43

					if var_46_43 + var_46_36 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_43 + var_46_36
					end
				end

				arg_43_1.text_.text = var_46_40
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311010", "story_v_out_116311.awb") ~= 0 then
					local var_46_44 = manager.audio:GetVoiceLength("story_v_out_116311", "116311010", "story_v_out_116311.awb") / 1000

					if var_46_44 + var_46_36 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_44 + var_46_36
					end

					if var_46_39.prefab_name ~= "" and arg_43_1.actors_[var_46_39.prefab_name] ~= nil then
						local var_46_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_39.prefab_name].transform, "story_v_out_116311", "116311010", "story_v_out_116311.awb")

						arg_43_1:RecordAudio("116311010", var_46_45)
						arg_43_1:RecordAudio("116311010", var_46_45)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_116311", "116311010", "story_v_out_116311.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_116311", "116311010", "story_v_out_116311.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_46 = math.max(var_46_37, arg_43_1.talkMaxDuration)

			if var_46_36 <= arg_43_1.time_ and arg_43_1.time_ < var_46_36 + var_46_46 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_36) / var_46_46

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_36 + var_46_46 and arg_43_1.time_ < var_46_36 + var_46_46 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play116311011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 116311011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play116311012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10025ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10025ui_story == nil then
				arg_47_1.var_.characterEffect10025ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.2

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect10025ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10025ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10025ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10025ui_story.fillRatio = var_50_5
			end

			local var_50_6 = 0
			local var_50_7 = 0.1

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_8 = arg_47_1:FormatText(StoryNameCfg[7].name)

				arg_47_1.leftNameTxt_.text = var_50_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_9 = arg_47_1:GetWordFromCfg(116311011)
				local var_50_10 = arg_47_1:FormatText(var_50_9.content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 4
				local var_50_12 = utf8.len(var_50_10)
				local var_50_13 = var_50_11 <= 0 and var_50_7 or var_50_7 * (var_50_12 / var_50_11)

				if var_50_13 > 0 and var_50_7 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_14 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_14 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_14

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_14 and arg_47_1.time_ < var_50_6 + var_50_14 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play116311012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 116311012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play116311013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1184ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1184ui_story = var_54_0.localPosition

				local var_54_2 = "1184ui_story"

				arg_51_1:ShowWeapon(arg_51_1.var_[var_54_2 .. "Animator"].transform, true)
			end

			local var_54_3 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_3 then
				local var_54_4 = (arg_51_1.time_ - var_54_1) / var_54_3
				local var_54_5 = Vector3.New(0, 100, 0)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1184ui_story, var_54_5, var_54_4)

				local var_54_6 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_6.x, var_54_6.y, var_54_6.z)

				local var_54_7 = var_54_0.localEulerAngles

				var_54_7.z = 0
				var_54_7.x = 0
				var_54_0.localEulerAngles = var_54_7
			end

			if arg_51_1.time_ >= var_54_1 + var_54_3 and arg_51_1.time_ < var_54_1 + var_54_3 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, 100, 0)

				local var_54_8 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_8.x, var_54_8.y, var_54_8.z)

				local var_54_9 = var_54_0.localEulerAngles

				var_54_9.z = 0
				var_54_9.x = 0
				var_54_0.localEulerAngles = var_54_9
			end

			local var_54_10 = arg_51_1.actors_["10025ui_story"].transform
			local var_54_11 = 0

			if var_54_11 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1.var_.moveOldPos10025ui_story = var_54_10.localPosition
			end

			local var_54_12 = 0.001

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_12 then
				local var_54_13 = (arg_51_1.time_ - var_54_11) / var_54_12
				local var_54_14 = Vector3.New(0, 100, 0)

				var_54_10.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10025ui_story, var_54_14, var_54_13)

				local var_54_15 = manager.ui.mainCamera.transform.position - var_54_10.position

				var_54_10.forward = Vector3.New(var_54_15.x, var_54_15.y, var_54_15.z)

				local var_54_16 = var_54_10.localEulerAngles

				var_54_16.z = 0
				var_54_16.x = 0
				var_54_10.localEulerAngles = var_54_16
			end

			if arg_51_1.time_ >= var_54_11 + var_54_12 and arg_51_1.time_ < var_54_11 + var_54_12 + arg_54_0 then
				var_54_10.localPosition = Vector3.New(0, 100, 0)

				local var_54_17 = manager.ui.mainCamera.transform.position - var_54_10.position

				var_54_10.forward = Vector3.New(var_54_17.x, var_54_17.y, var_54_17.z)

				local var_54_18 = var_54_10.localEulerAngles

				var_54_18.z = 0
				var_54_18.x = 0
				var_54_10.localEulerAngles = var_54_18
			end

			local var_54_19 = 0
			local var_54_20 = 1.475

			if var_54_19 < arg_51_1.time_ and arg_51_1.time_ <= var_54_19 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_21 = arg_51_1:GetWordFromCfg(116311012)
				local var_54_22 = arg_51_1:FormatText(var_54_21.content)

				arg_51_1.text_.text = var_54_22

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_23 = 59
				local var_54_24 = utf8.len(var_54_22)
				local var_54_25 = var_54_23 <= 0 and var_54_20 or var_54_20 * (var_54_24 / var_54_23)

				if var_54_25 > 0 and var_54_20 < var_54_25 then
					arg_51_1.talkMaxDuration = var_54_25

					if var_54_25 + var_54_19 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_25 + var_54_19
					end
				end

				arg_51_1.text_.text = var_54_22
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_26 = math.max(var_54_20, arg_51_1.talkMaxDuration)

			if var_54_19 <= arg_51_1.time_ and arg_51_1.time_ < var_54_19 + var_54_26 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_19) / var_54_26

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_19 + var_54_26 and arg_51_1.time_ < var_54_19 + var_54_26 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play116311013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 116311013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play116311014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = manager.ui.mainCamera.transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.shakeOldPos = var_58_0.localPosition
			end

			local var_58_2 = 0.6

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / 0.066
				local var_58_4, var_58_5 = math.modf(var_58_3)

				var_58_0.localPosition = Vector3.New(var_58_5 * 0.13, var_58_5 * 0.13, var_58_5 * 0.13) + arg_55_1.var_.shakeOldPos
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = arg_55_1.var_.shakeOldPos
			end

			local var_58_6 = 0

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			local var_58_7 = 0.6

			if arg_55_1.time_ >= var_58_6 + var_58_7 and arg_55_1.time_ < var_58_6 + var_58_7 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end

			local var_58_8 = 0
			local var_58_9 = 0.175

			if var_58_8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_10 = arg_55_1:FormatText(StoryNameCfg[7].name)

				arg_55_1.leftNameTxt_.text = var_58_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_11 = arg_55_1:GetWordFromCfg(116311013)
				local var_58_12 = arg_55_1:FormatText(var_58_11.content)

				arg_55_1.text_.text = var_58_12

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 7
				local var_58_14 = utf8.len(var_58_12)
				local var_58_15 = var_58_13 <= 0 and var_58_9 or var_58_9 * (var_58_14 / var_58_13)

				if var_58_15 > 0 and var_58_9 < var_58_15 then
					arg_55_1.talkMaxDuration = var_58_15

					if var_58_15 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_15 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_12
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_9, arg_55_1.talkMaxDuration)

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_8) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_8 + var_58_16 and arg_55_1.time_ < var_58_8 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play116311014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116311014
		arg_59_1.duration_ = 12

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play116311015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = "SK0205"

			if arg_59_1.bgs_[var_62_0] == nil then
				local var_62_1 = Object.Instantiate(arg_59_1.paintGo_)

				var_62_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_62_0)
				var_62_1.name = var_62_0
				var_62_1.transform.parent = arg_59_1.stage_.transform
				var_62_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.bgs_[var_62_0] = var_62_1
			end

			local var_62_2 = 1

			if var_62_2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				local var_62_3 = manager.ui.mainCamera.transform.localPosition
				local var_62_4 = Vector3.New(0, 0, 10) + Vector3.New(var_62_3.x, var_62_3.y, 0)
				local var_62_5 = arg_59_1.bgs_.SK0205

				var_62_5.transform.localPosition = var_62_4
				var_62_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_6 = var_62_5:GetComponent("SpriteRenderer")

				if var_62_6 and var_62_6.sprite then
					local var_62_7 = (var_62_5.transform.localPosition - var_62_3).z
					local var_62_8 = manager.ui.mainCameraCom_
					local var_62_9 = 2 * var_62_7 * Mathf.Tan(var_62_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_62_10 = var_62_9 * var_62_8.aspect
					local var_62_11 = var_62_6.sprite.bounds.size.x
					local var_62_12 = var_62_6.sprite.bounds.size.y
					local var_62_13 = var_62_10 / var_62_11
					local var_62_14 = var_62_9 / var_62_12
					local var_62_15 = var_62_14 < var_62_13 and var_62_13 or var_62_14

					var_62_5.transform.localScale = Vector3.New(var_62_15, var_62_15, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "SK0205" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_16 = 0

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = false

				arg_59_1:SetGaussion(false)
			end

			local var_62_17 = 1

			if var_62_16 <= arg_59_1.time_ and arg_59_1.time_ < var_62_16 + var_62_17 then
				local var_62_18 = (arg_59_1.time_ - var_62_16) / var_62_17
				local var_62_19 = Color.New(1, 1, 1)

				var_62_19.a = Mathf.Lerp(0, 1, var_62_18)
				arg_59_1.mask_.color = var_62_19
			end

			if arg_59_1.time_ >= var_62_16 + var_62_17 and arg_59_1.time_ < var_62_16 + var_62_17 + arg_62_0 then
				local var_62_20 = Color.New(1, 1, 1)

				var_62_20.a = 1
				arg_59_1.mask_.color = var_62_20
			end

			local var_62_21 = 0.999999999999999

			if var_62_21 < arg_59_1.time_ and arg_59_1.time_ <= var_62_21 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = false

				arg_59_1:SetGaussion(false)
			end

			local var_62_22 = 2

			if var_62_21 <= arg_59_1.time_ and arg_59_1.time_ < var_62_21 + var_62_22 then
				local var_62_23 = (arg_59_1.time_ - var_62_21) / var_62_22
				local var_62_24 = Color.New(1, 1, 1)

				var_62_24.a = Mathf.Lerp(1, 0, var_62_23)
				arg_59_1.mask_.color = var_62_24
			end

			if arg_59_1.time_ >= var_62_21 + var_62_22 and arg_59_1.time_ < var_62_21 + var_62_22 + arg_62_0 then
				local var_62_25 = Color.New(1, 1, 1)
				local var_62_26 = 0

				arg_59_1.mask_.enabled = false
				var_62_25.a = var_62_26
				arg_59_1.mask_.color = var_62_25
			end

			local var_62_27 = arg_59_1.bgs_.SK0205.transform
			local var_62_28 = 0

			if var_62_28 < arg_59_1.time_ and arg_59_1.time_ <= var_62_28 + arg_62_0 then
				arg_59_1.var_.moveOldPosSK0205 = var_62_27.localPosition
			end

			local var_62_29 = 0.001

			if var_62_28 <= arg_59_1.time_ and arg_59_1.time_ < var_62_28 + var_62_29 then
				local var_62_30 = (arg_59_1.time_ - var_62_28) / var_62_29
				local var_62_31 = Vector3.New(-0.1, 3, 0)

				var_62_27.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPosSK0205, var_62_31, var_62_30)
			end

			if arg_59_1.time_ >= var_62_28 + var_62_29 and arg_59_1.time_ < var_62_28 + var_62_29 + arg_62_0 then
				var_62_27.localPosition = Vector3.New(-0.1, 3, 0)
			end

			local var_62_32 = arg_59_1.bgs_.SK0205.transform
			local var_62_33 = 0.034

			if var_62_33 < arg_59_1.time_ and arg_59_1.time_ <= var_62_33 + arg_62_0 then
				arg_59_1.var_.moveOldPosSK0205 = var_62_32.localPosition
			end

			local var_62_34 = 3

			if var_62_33 <= arg_59_1.time_ and arg_59_1.time_ < var_62_33 + var_62_34 then
				local var_62_35 = (arg_59_1.time_ - var_62_33) / var_62_34
				local var_62_36 = Vector3.New(-0.1, 3, 0.8)

				var_62_32.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPosSK0205, var_62_36, var_62_35)
			end

			if arg_59_1.time_ >= var_62_33 + var_62_34 and arg_59_1.time_ < var_62_33 + var_62_34 + arg_62_0 then
				var_62_32.localPosition = Vector3.New(-0.1, 3, 0.8)
			end

			local var_62_37 = arg_59_1.bgs_.SK0205.transform
			local var_62_38 = 3.034

			if var_62_38 < arg_59_1.time_ and arg_59_1.time_ <= var_62_38 + arg_62_0 then
				arg_59_1.var_.moveOldPosSK0205 = var_62_37.localPosition
			end

			local var_62_39 = 0.1

			if var_62_38 <= arg_59_1.time_ and arg_59_1.time_ < var_62_38 + var_62_39 then
				local var_62_40 = (arg_59_1.time_ - var_62_38) / var_62_39
				local var_62_41 = Vector3.New(0, 1, 9)

				var_62_37.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPosSK0205, var_62_41, var_62_40)
			end

			if arg_59_1.time_ >= var_62_38 + var_62_39 and arg_59_1.time_ < var_62_38 + var_62_39 + arg_62_0 then
				var_62_37.localPosition = Vector3.New(0, 1, 9)
			end

			local var_62_42 = arg_59_1.bgs_.SK0205.transform
			local var_62_43 = 3.134

			if var_62_43 < arg_59_1.time_ and arg_59_1.time_ <= var_62_43 + arg_62_0 then
				arg_59_1.var_.moveOldPosSK0205 = var_62_42.localPosition
			end

			local var_62_44 = 8

			if var_62_43 <= arg_59_1.time_ and arg_59_1.time_ < var_62_43 + var_62_44 then
				local var_62_45 = (arg_59_1.time_ - var_62_43) / var_62_44
				local var_62_46 = Vector3.New(0, 1, 10)

				var_62_42.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPosSK0205, var_62_46, var_62_45)
			end

			if arg_59_1.time_ >= var_62_43 + var_62_44 and arg_59_1.time_ < var_62_43 + var_62_44 + arg_62_0 then
				var_62_42.localPosition = Vector3.New(0, 1, 10)
			end

			local var_62_47 = 3

			if var_62_47 < arg_59_1.time_ and arg_59_1.time_ <= var_62_47 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			local var_62_48 = 8.134

			if arg_59_1.time_ >= var_62_47 + var_62_48 and arg_59_1.time_ < var_62_47 + var_62_48 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_49 = 3
			local var_62_50 = 0.425

			if var_62_49 < arg_59_1.time_ and arg_59_1.time_ <= var_62_49 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_51 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_51:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_52 = arg_59_1:FormatText(StoryNameCfg[328].name)

				arg_59_1.leftNameTxt_.text = var_62_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_53 = arg_59_1:GetWordFromCfg(116311014)
				local var_62_54 = arg_59_1:FormatText(var_62_53.content)

				arg_59_1.text_.text = var_62_54

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_55 = 17
				local var_62_56 = utf8.len(var_62_54)
				local var_62_57 = var_62_55 <= 0 and var_62_50 or var_62_50 * (var_62_56 / var_62_55)

				if var_62_57 > 0 and var_62_50 < var_62_57 then
					arg_59_1.talkMaxDuration = var_62_57
					var_62_49 = var_62_49 + 0.3

					if var_62_57 + var_62_49 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_57 + var_62_49
					end
				end

				arg_59_1.text_.text = var_62_54
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311014", "story_v_out_116311.awb") ~= 0 then
					local var_62_58 = manager.audio:GetVoiceLength("story_v_out_116311", "116311014", "story_v_out_116311.awb") / 1000

					if var_62_58 + var_62_49 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_58 + var_62_49
					end

					if var_62_53.prefab_name ~= "" and arg_59_1.actors_[var_62_53.prefab_name] ~= nil then
						local var_62_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_53.prefab_name].transform, "story_v_out_116311", "116311014", "story_v_out_116311.awb")

						arg_59_1:RecordAudio("116311014", var_62_59)
						arg_59_1:RecordAudio("116311014", var_62_59)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_116311", "116311014", "story_v_out_116311.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_116311", "116311014", "story_v_out_116311.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_60 = var_62_49 + 0.3
			local var_62_61 = math.max(var_62_50, arg_59_1.talkMaxDuration)

			if var_62_60 <= arg_59_1.time_ and arg_59_1.time_ < var_62_60 + var_62_61 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_60) / var_62_61

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_60 + var_62_61 and arg_59_1.time_ < var_62_60 + var_62_61 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0205",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0205",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0205",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 3.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0205",
				changeDisplayLayer = false,
				needEase = false,
				duration = 8,
				className = "StoryMoveNode",
				startTime = 3.134,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play116311015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116311015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play116311016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 1

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				local var_68_2 = "play"
				local var_68_3 = "effect"

				arg_65_1:AudioAction(var_68_2, var_68_3, "se_story_16", "se_story_16_wind02", "")
			end

			local var_68_4 = 0
			local var_68_5 = 0.65

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(116311015)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_8 = 26
				local var_68_9 = utf8.len(var_68_7)
				local var_68_10 = var_68_8 <= 0 and var_68_5 or var_68_5 * (var_68_9 / var_68_8)

				if var_68_10 > 0 and var_68_5 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_11 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_11 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_11

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_11 and arg_65_1.time_ < var_68_4 + var_68_11 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play116311016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116311016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play116311017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.8

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(116311016)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 32
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play116311017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 116311017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play116311018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.725

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(116311017)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 29
				local var_76_5 = utf8.len(var_76_3)
				local var_76_6 = var_76_4 <= 0 and var_76_1 or var_76_1 * (var_76_5 / var_76_4)

				if var_76_6 > 0 and var_76_1 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_7 and arg_73_1.time_ < var_76_0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play116311018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 116311018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play116311019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.925

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(116311018)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 37
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play116311019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 116311019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play116311020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.85

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:GetWordFromCfg(116311019)
				local var_84_3 = arg_81_1:FormatText(var_84_2.content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 34
				local var_84_5 = utf8.len(var_84_3)
				local var_84_6 = var_84_4 <= 0 and var_84_1 or var_84_1 * (var_84_5 / var_84_4)

				if var_84_6 > 0 and var_84_1 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_7 and arg_81_1.time_ < var_84_0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play116311020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 116311020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play116311021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.45

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

				local var_88_2 = arg_85_1:GetWordFromCfg(116311020)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 18
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
	Play116311021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116311021
		arg_89_1.duration_ = 4.5

		local var_89_0 = {
			zh = 3.6,
			ja = 4.5
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
				arg_89_0:Play116311022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.375

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[28].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(116311021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311021", "story_v_out_116311.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_116311", "116311021", "story_v_out_116311.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_116311", "116311021", "story_v_out_116311.awb")

						arg_89_1:RecordAudio("116311021", var_92_9)
						arg_89_1:RecordAudio("116311021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_116311", "116311021", "story_v_out_116311.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_116311", "116311021", "story_v_out_116311.awb")
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
	Play116311022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 116311022
		arg_93_1.duration_ = 6.43

		local var_93_0 = {
			zh = 6.433,
			ja = 5.1
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
				arg_93_0:Play116311023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.6

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[8].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(116311022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311022", "story_v_out_116311.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_116311", "116311022", "story_v_out_116311.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_116311", "116311022", "story_v_out_116311.awb")

						arg_93_1:RecordAudio("116311022", var_96_9)
						arg_93_1:RecordAudio("116311022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_116311", "116311022", "story_v_out_116311.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_116311", "116311022", "story_v_out_116311.awb")
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
	Play116311023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 116311023
		arg_97_1.duration_ = 7.23

		local var_97_0 = {
			zh = 7.233,
			ja = 7.066
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
				arg_97_0:Play116311024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.8

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[332].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4031")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(116311023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 32
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311023", "story_v_out_116311.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_116311", "116311023", "story_v_out_116311.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_116311", "116311023", "story_v_out_116311.awb")

						arg_97_1:RecordAudio("116311023", var_100_9)
						arg_97_1:RecordAudio("116311023", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_116311", "116311023", "story_v_out_116311.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_116311", "116311023", "story_v_out_116311.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play116311024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 116311024
		arg_101_1.duration_ = 10.13

		local var_101_0 = {
			zh = 10.133,
			ja = 9.333
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
				arg_101_0:Play116311025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[332].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4031")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(116311024)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311024", "story_v_out_116311.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_116311", "116311024", "story_v_out_116311.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_116311", "116311024", "story_v_out_116311.awb")

						arg_101_1:RecordAudio("116311024", var_104_9)
						arg_101_1:RecordAudio("116311024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_116311", "116311024", "story_v_out_116311.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_116311", "116311024", "story_v_out_116311.awb")
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
	Play116311025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 116311025
		arg_105_1.duration_ = 4.27

		local var_105_0 = {
			zh = 2.333,
			ja = 4.266
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
				arg_105_0:Play116311026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.25

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[6].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(116311025)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 10
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311025", "story_v_out_116311.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_116311", "116311025", "story_v_out_116311.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_116311", "116311025", "story_v_out_116311.awb")

						arg_105_1:RecordAudio("116311025", var_108_9)
						arg_105_1:RecordAudio("116311025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_116311", "116311025", "story_v_out_116311.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_116311", "116311025", "story_v_out_116311.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play116311026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116311026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play116311027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1.325

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(116311026)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 53
				local var_112_5 = utf8.len(var_112_3)
				local var_112_6 = var_112_4 <= 0 and var_112_1 or var_112_1 * (var_112_5 / var_112_4)

				if var_112_6 > 0 and var_112_1 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_7 and arg_109_1.time_ < var_112_0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play116311027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 116311027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play116311028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.6

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_2 = arg_113_1:GetWordFromCfg(116311027)
				local var_116_3 = arg_113_1:FormatText(var_116_2.content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 24
				local var_116_5 = utf8.len(var_116_3)
				local var_116_6 = var_116_4 <= 0 and var_116_1 or var_116_1 * (var_116_5 / var_116_4)

				if var_116_6 > 0 and var_116_1 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_7 and arg_113_1.time_ < var_116_0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play116311028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116311028
		arg_117_1.duration_ = 6.73

		local var_117_0 = {
			zh = 5.633,
			ja = 6.733
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
			arg_117_1.auto_ = false
		end

		function arg_117_1.playNext_(arg_119_0)
			arg_117_1.onStoryFinished_()
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.5

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[332].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4031")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:GetWordFromCfg(116311028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_116311", "116311028", "story_v_out_116311.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_116311", "116311028", "story_v_out_116311.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_116311", "116311028", "story_v_out_116311.awb")

						arg_117_1:RecordAudio("116311028", var_120_9)
						arg_117_1:RecordAudio("116311028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_116311", "116311028", "story_v_out_116311.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_116311", "116311028", "story_v_out_116311.awb")
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
	assets = {
		"TextureConfig/Background/B13c",
		"TextureConfig/Background/SK0205"
	},
	voices = {
		"story_v_out_116311.awb"
	}
}
